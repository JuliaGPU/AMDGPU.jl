using Test
using AMDGPU
import GPUCompiler
import LLVM

@testset "Device library selection" begin
    for (dev_isa, wave64) in (("gfx1030", false), ("gfx90a", true), ("gfx1030", true))
        target = GPUCompiler.GCNCompilerTarget(; dev_isa)
        params = AMDGPU.Compiler.HIPCompilerParams(wave64, true, true)
        config = GPUCompiler.CompilerConfig(target, params; kernel=false)
        source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
        job = GPUCompiler.CompilerJob(source, config)
        libraries = GPUCompiler.device_libraries(job)
        @test first(libraries).name == :AMDGPU
        names = [library.name for library in libraries]
        @test allunique(names)
        @test findfirst(==(:opencl), names) < findfirst(==(:ocml), names) <
              findfirst(==(:ockl), names)
        isa_name = Symbol("oclc_isa_version_", replace(dev_isa, "gfx" => ""))
        isa_library = only(filter(library -> library.name == isa_name, libraries))
        @test isa_library.bitcode == AMDGPU.Compiler.locate_lib(String(isa_name))
        @test !isa_library.always_inline
        @test only(filter(library -> library.name == :ocml, libraries)).always_inline
        @test GPUCompiler.device_libraries(job)[2:end] === libraries[2:end]
        wave_name = Symbol("oclc_wavefrontsize64_", wave64 ? "on" : "off")
        @test wave_name in names
        @test !(Symbol("oclc_wavefrontsize64_", wave64 ? "off" : "on") in names)
        GPUCompiler.JuliaContext() do _
            exports = [GPUCompiler.library_exports(library) for library in libraries]
            @test length(union(exports...)) == sum(length, exports)
        end
    end
end

opencl_sin(value::Float32) =
    ccall("extern _Z3sinf", llvmcall, Float32, (Float32,), value)
opencl_global_id() =
    ccall("extern _Z13get_global_idj", llvmcall, UInt64, (UInt32,), UInt32(0))

@testset "Transitive ROCm imports" begin
    input = Float32[0, 0.5, 1, 2]
    @test Array(opencl_sin.(ROCArray(input))) ≈ sin.(input)
    function index_kernel(output)
        index = AMDGPU.Device.workitemIdx().x
        @inbounds output[index] = opencl_global_id()
        return
    end
    output = AMDGPU.zeros(UInt64, 4)
    @roc groupsize=4 gridsize=1 index_kernel(output)
    @test Array(output) == UInt64[0, 1, 2, 3]
    types = Tuple{AMDGPU.Device.ROCDeviceVector{UInt64, AMDGPU.Device.AS.Global}}
    ir = sprint(io -> AMDGPU.code_llvm(io, index_kernel, types;
                                      kernel=true, dump_module=true))
    @test !occursin("@__oclc_", ir)
    @test !occursin("call i32 @llvm.amdgcn.wavefrontsize", ir)
end

@testset "Convergent calls in divergent control flow" begin
    function divergent_lane(output)
        index = AMDGPU.Device.workitemIdx().x
        if iseven(index)
            result = AMDGPU.Device.activelane() + UInt32(100)
        else
            result = AMDGPU.Device.activelane() + UInt32(200)
        end
        @inbounds output[index] = result
        return
    end
    width = Int(AMDGPU.HIP.wavefrontsize(AMDGPU.device()))
    output = AMDGPU.zeros(UInt32, width)
    @roc groupsize=width gridsize=1 divergent_lane(output)
    expected = [(index - 1) ÷ 2 + (iseven(index) ? 100 : 200) for index in 1:width]
    if LLVM.version() < v"16"
        @test_broken Array(output) == expected
    else
        @test Array(output) == expected
    end
end

@testset "Runtime building does not leak hostcalls" begin
    target = GPUCompiler.GCNCompilerTarget(; dev_isa="gfx1030")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true, 1)
    config = GPUCompiler.CompilerConfig(target, params; kernel=false)
    source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
    job = GPUCompiler.CompilerJob(source, config)
    storage = task_local_storage()
    previous = pop!(storage, :amdgpu_early_hostcalls, nothing)
    try
        GPUCompiler.JuliaContext() do _
            mod, _ = GPUCompiler.load_runtime(job)
            LLVM.dispose(mod)
        end
        @test isempty(get(storage, :amdgpu_early_hostcalls, Symbol[]))
    finally
        pop!(storage, :amdgpu_early_hostcalls, nothing)
        previous === nothing || (storage[:amdgpu_early_hostcalls] = previous)
    end
end

@testset "Import policy" begin
    target = GPUCompiler.GCNCompilerTarget(; dev_isa="gfx1030")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true)
    config = GPUCompiler.CompilerConfig(target, params; kernel=false)
    source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
    job = GPUCompiler.CompilerJob(source, config)
    storage = task_local_storage()
    previous = pop!(storage, :amdgpu_early_hostcalls, nothing)
    # imported before (`finish_linked_module!`) and after optimization (`finish_imports!`)
    for late in (false, true)
        GPUCompiler.JuliaContext() do _
            mod = parse(LLVM.Module, """
                @__malloc_hostcall = internal global i64 0
                declare i32 @llvm.amdgcn.wavefrontsize()
                define i32 @__ocml_fabs_f32() alwaysinline {
                    %size = call i32 @llvm.amdgcn.wavefrontsize()
                    ret i32 %size
                }
                define void @__ockl_hsa_signal_test() alwaysinline { ret void }
                define void @report_exception_test() noinline { ret void }
                """)
            try
                if late
                    GPUCompiler.finish_imports!(job, mod,
                        ["__ocml_fabs_f32", "__ockl_hsa_signal_test", "report_exception_test"])
                else
                    GPUCompiler.finish_linked_module!(job, mod)
                end
                @test occursin("ret i32 32", string(mod.functions["__ocml_fabs_f32"]))
                @test haskey(mod.functions["__ocml_fabs_f32"].function_attributes, :alwaysinline)
                @test !haskey(mod.functions["__ockl_hsa_signal_test"].function_attributes,
                              :alwaysinline)
                @test haskey(mod.functions["report_exception_test"].function_attributes,
                             late ? :alwaysinline : :noinline)
                @test LLVM.verify(mod) === nothing
                @test pop!(storage, :amdgpu_early_hostcalls, Symbol[]) == [:malloc_hostcall]
            finally
                LLVM.dispose(mod)
            end
        end
    end
    pop!(storage, :amdgpu_early_hostcalls, nothing)
    previous === nothing || (storage[:amdgpu_early_hostcalls] = previous)
end

@testset "Libraries are optimized with the kernel" begin
    # loop-invariant library calls are hoisted, which requires their definitions
    function licm_kernel(output, x)
        index = AMDGPU.Device.workitemIdx().x
        acc = 0f0
        for i in 1:index
            acc += sin(x)
        end
        @inbounds output[index] = acc
        return
    end
    types = Tuple{AMDGPU.Device.ROCDeviceVector{Float32, AMDGPU.Device.AS.Global}, Float32}
    ir = sprint(io -> AMDGPU.code_llvm(io, licm_kernel, types; kernel=true, dump_module=true))
    @test !occursin("__ocml_sin_f32", ir)

    output = AMDGPU.zeros(Float32, 4)
    @roc groupsize=4 gridsize=1 licm_kernel(output, 0.5f0)
    @test Array(output) ≈ Float32[1, 2, 3, 4] .* sin(0.5f0)
end
