using PrecompileTools: @compile_workload

# Compiling a GCN kernel requires being able to initialize the AMDGPU LLVM
# backend, so we only run the precompile workload when that's supported, to be
# able to load this package also on systems where the backend isn't available.
#
# This mirrors CUDA.jl's precompile workload: it warms up the GPUCompiler ->
# AMDGPU codegen pipeline during precompilation so that the first kernel launch
# at runtime doesn't have to JIT-compile the entire compiler. It does NOT need a
# GPU (or even the ROCm runtime to be discovered) -- it only uses LLVM.
if :AMDGPU in LLVM.backends()
    @compile_workload begin
        let
            function _precompile_kernel(a)
                i = workitemIdx().x
                @inbounds a[i] += 1.0f0
                return
            end

            # Build a device-free compiler config for a baseline GCN target.
            # `gfx1030` (RDNA2, wavefront 32) is a portable baseline that exercises
            # the full pipeline; the cached *code* is reused regardless of the
            # actual device's ISA at runtime (only the kernel binary differs).
            #
            # NOTE: the ISA must be RDNA/CDNA, not pre-RDNA. The `wavefrontsize*`
            # LLVM features only exist on gfx10+, so pairing them with e.g. gfx900
            # (GCN3) yields an inconsistent target that miscompiles the
            # wavefront-sensitive exception/bounds-error path (manifests under
            # `--check-bounds=yes`/`--code-coverage`, where `@inbounds` is ignored).
            target = GPUCompiler.GCNCompilerTarget(;
                dev_isa="gfx1030", features="+wavefrontsize32,-wavefrontsize64")
            params = Compiler.HIPCompilerParams(false, true)
            config = GPUCompiler.CompilerConfig(target, params;
                kernel=true, name=nothing, always_inline=true)

            tt = Tuple{ROCDeviceArray{Float32, 1, AS.Global}}
            source = GPUCompiler.methodinstance(typeof(_precompile_kernel), tt)
            job = GPUCompiler.CompilerJob(source, config)

            # Under `--check-bounds=yes` (used by `Pkg.test`) or `--code-coverage`,
            # `@inbounds` is ignored, so `a[i]` emits a bounds-error path
            # (`throw_boundserror` -> `signal_exception` -> `kernel_state()`). That
            # path compiles fine at *runtime*, but NOT during precompilation: the
            # `@generated kernel_state()` fails to inline there, leaving a dynamic
            # call -> invalid GPU IR. Those flags only occur during testing, never
            # in normal user precompilation (where `@inbounds` elides the path), so
            # skip the warming compile then -- users still get the full benefit.
            instrumented = Base.JLOptions().code_coverage != 0 ||
                           Base.JLOptions().check_bounds == 1

            # On Julia < 1.12, GPU compilation during precompilation leaks foreign
            # MIs into native compilation, causing LLVM errors. Guard like CUDA.jl.
            @static if VERSION >= v"1.12-"
                if !instrumented
                    GPUCompiler.JuliaContext() do ctx
                        GPUCompiler.compile(:obj, job)
                    end

                    # The compile above runs during precompilation, when ROCm
                    # discovery (`__init__`) has NOT run, so `libdevice_libs` is
                    # empty. That poisons the `DEVICE_LIBS` cache with empty entries
                    # (e.g. an `ocml` `DevLib` with no path), which would be baked
                    # into the precompile image and prevent device-library linking
                    # at runtime (`unsupported call to __ocml_*`). Reset it so it is
                    # repopulated correctly once discovery has run.
                    empty!(Compiler.DEVICE_LIBS)
                end
            end
        end
    end
end

# Kernel launch infrastructure that the workload above cannot reach, because it
# requires a live device (mirrors CUDA.jl's explicit precompile directives:
# `cufunction`, `link`, and `actual_compilation`).
precompile(Tuple{typeof(Compiler.hipfunction), typeof(identity), Type{Tuple{Nothing}}})
precompile(Tuple{typeof(GPUCompiler.actual_compilation),
    Dict{Any, HIP.HIPFunction}, Core.MethodInstance, UInt64,
    Compiler.HIPCompilerConfig, typeof(Compiler.hipcompile), typeof(Compiler.hiplink)})
precompile(Tuple{typeof(Compiler.hiplink), Compiler.HIPCompilerJob,
    NamedTuple{(:obj, :entry, :global_hostcalls),
        Tuple{Vector{UInt8}, String, Vector{Symbol}}}})

# Hot entry points of the bundled ROCm libraries, mirroring CUDA.jl's per-library
# precompile directives. These compile the (GPU-free) Julia wrappers so the first
# `A * B`, factorization, FFT plan, etc. doesn't pay full first-use compilation.
let RM = (T) -> ROCArray{T, 2, Mem.HIPBuffer}
    # rocBLAS: handle creation, GEMM and high-level matmul.
    precompile(Tuple{typeof(rocBLAS.create_handle)})
    precompile(Tuple{typeof(rocBLAS.lib_state)})
    for T in (Float32, Float64, ComplexF32, ComplexF64)
        precompile(Tuple{typeof(rocBLAS.gemm!), Char, Char, T, RM(T), RM(T), T, RM(T)})
    end
    for T in (Float32, Float64)
        precompile(Tuple{typeof(*), RM(T), RM(T)})
        precompile(Tuple{typeof(LinearAlgebra.mul!), RM(T), RM(T), RM(T)})
    end

    # rocSOLVER: common factorizations.
    for T in (Float32, Float64)
        precompile(Tuple{typeof(rocSOLVER.getrf!), RM(T)})
        precompile(Tuple{typeof(rocSOLVER.geqrf!), RM(T)})
        precompile(Tuple{typeof(rocSOLVER.potrf!), Char, RM(T)})
    end

    # rocFFT: plan creation for common types.
    for T in (ComplexF32, ComplexF64)
        precompile(Tuple{typeof(rocFFT.plan_fft!), RM(T), Int})
    end
    for T in (Float32, Float64)
        precompile(Tuple{typeof(rocFFT.plan_rfft), RM(T), Int})
    end

    # rocRAND / random.
    precompile(Tuple{typeof(rand), Type{Float32}, Dims{2}})
    precompile(Tuple{typeof(Random.rand!), RM(Float32)})
end
