using Test
using AMDGPU
import GPUCompiler
import LLVM
using AMDGPU: Device, ROCArray, @roc, UnsafeAtomics
using AMDGPU.Device: sync_workgroup, workitemIdx, workgroupIdx, workgroupDim
using KernelAbstractions: @atomic

# compile for a GPU other than the local one
function compile_offline(f, tt, format; dev_isa="gfx90a", backend=:external,
                         unsafe_fp_atomics=true, atomic_memory_assumptions=true,
                         validate=true)
    wf64 = !startswith(dev_isa, "gfx1")
    features = wf64 ? "-wavefrontsize32,+wavefrontsize64" : "+wavefrontsize32,-wavefrontsize64"
    target = GPUCompiler.GCNCompilerTarget(; dev_isa, features, backend)
    params = AMDGPU.Compiler.HIPCompilerParams(wf64, unsafe_fp_atomics,
                                               atomic_memory_assumptions)
    config = GPUCompiler.CompilerConfig(target, params; kernel=true, always_inline=true,
                                        validate)
    job = GPUCompiler.CompilerJob(GPUCompiler.methodinstance(typeof(f), tt), config)
    GPUCompiler.JuliaContext() do _
        if format === :llvm
            mod, _ = GPUCompiler.compile(:llvm, job)
            ir = string(mod)
            LLVM.dispose(mod)
            ir
        else
            asm, meta = GPUCompiler.compile(:asm, job)
            LLVM.dispose(meta.ir)
            asm
        end
    end
end

@testset "Synchronization" begin
    function synckern()
        sync_workgroup()
        nothing
    end

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, synckern, Tuple{}; kernel=true)
    @test occursin("s_barrier", String(take!(iob)))

    AMDGPU.code_llvm(iob, synckern, Tuple{}; kernel=true)
    @test count("fence syncscope(\"workgroup\") seq_cst", String(take!(iob))) == 2
end

@testset "Synchronization scopes" begin
    # UnsafeAtomics' `device` scope has to reach LLVM as AMDGPU's `agent`
    function atomic_add_ker!(x)
        @inbounds @atomic x[1] += 1f0
        return
    end
    function agent_fence_ker()
        AMDGPU.UnsafeAtomics.fence(AMDGPU.UnsafeAtomics.seq_cst, AMDGPU.syncscope_agent)
        return
    end

    iob = IOBuffer()
    tt = Tuple{AMDGPU.Device.ROCDeviceVector{Float32, AMDGPU.Device.AS.Global}}
    AMDGPU.code_llvm(iob, atomic_add_ker!, tt; kernel=true)
    @test occursin(r"atomicrmw fadd .* syncscope\(\"agent\"\) seq_cst", String(take!(iob)))

    AMDGPU.code_llvm(iob, agent_fence_ker, Tuple{}; kernel=true)
    @test occursin("fence syncscope(\"agent\") seq_cst", String(take!(iob)))
end

@testset "Trapping" begin
    function trapkern()
        Device.trap()
        nothing
    end
    function debugtrapkern()
        Device.debugtrap()
        nothing
    end

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, trapkern, Tuple{}; kernel=true)
    @test occursin("s_trap 2", String(take!(iob)))

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, debugtrapkern, Tuple{}; kernel=true)
    @test occursin("s_trap 3", String(take!(iob)))
end

@testset "Hardware FP atomics" begin
    function atomic_fp_ker!(x)
        @inbounds @atomic x[1] += 1f0
        return
    end

    # `global_atomic_add_f32` only exists on CDNA (gfx908, gfx90a, gfx94x, gfx95x)
    # and RDNA3+ (gfx11+), see `FeatureAtomicFaddNoRtnInsts` in LLVM's AMDGPU.td.
    # Vega (gfx900-gfx906) and RDNA1/2 (gfx10xx) lack it, so LLVM must expand
    # the atomic to a CAS loop there.
    arch = first(split(AMDGPU.HIP.gcn_arch(AMDGPU.device()), ':'))
    gen = parse(Int, match(r"^gfx([0-9a-f]+)", arch).captures[1]; base=16)
    has_hw_fadd = 0x908 <= gen < 0x1000 || gen >= 0x1100

    for (T, fp) in ((Float32, "f32"),)
        iob = IOBuffer()
        tt = Tuple{AMDGPU.Device.ROCDeviceVector{T, AMDGPU.Device.AS.Global}}
        AMDGPU.code_gcn(iob, atomic_fp_ker!, tt; kernel=true)
        gcn = String(take!(iob))
        if has_hw_fadd
            @test occursin("global_atomic_add_$fp", gcn)
        else
            @test occursin("global_atomic_cmpswap", gcn)
            @test !occursin("global_atomic_add_$fp", gcn)
        end
    end
end

@testset "Unsafe FP atomics attribute" begin
    kern() = nothing
    function kernel_ir(; kwargs...)
        config = AMDGPU.Compiler.compiler_config(AMDGPU.device(); kernel=true, kwargs...)
        job = GPUCompiler.CompilerJob(GPUCompiler.methodinstance(typeof(kern), Tuple{}), config)
        sprint(io -> GPUCompiler.code_llvm(io, job; dump_module=true))
    end
    # like the denormal metadata, but for all FP atomics in the kernel
    @test occursin("\"amdgpu-unsafe-fp-atomics\"=\"true\"", kernel_ir())
    @test !occursin("amdgpu-unsafe-fp-atomics", kernel_ir(; unsafe_fp_atomics=false))
end

@testset "Launch bounds" begin
    bound_kern() = nothing
    k = @roc launch=false maxthreads=256 bound_kern()

    maxthreads = Ref{Cint}(0)
    AMDGPU.HIP.hipFuncGetAttribute(
        maxthreads, AMDGPU.HIP.HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, k.fun.handle)
    @test maxthreads[] == 256

    k(; groupsize=256)
    AMDGPU.synchronize()
    # exceeding the bound is undefined behavior; HIP rejects it at launch
    @test_throws AMDGPU.HIP.HIPError k(; groupsize=512)
end

@testset "Dimension reads stay scalar" begin
    # workgroupDim/workgroupIdx must lower to SMEM loads of the (hidden)
    # kernarg segment. Reading two or more dim components used to merge the
    # u16 dispatch-packet loads into an under-aligned vector load that could
    # only select per-wave VMEM.
    function dim_kern!(A)
        i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
        j = (workgroupIdx().y - 1) * workgroupDim().y + workitemIdx().y
        k = (workgroupIdx().z - 1) * workgroupDim().z + workitemIdx().z
        n = i + j + k
        # not `A[n] = n`: under --check-bounds=yes its exception path emits
        # private-memory buffer_loads on gfx90a
        n <= length(A) && unsafe_store!(pointer(A), Float32(n), n)
        return
    end

    iob = IOBuffer()
    tt = Tuple{AMDGPU.Device.ROCDeviceVector{Float32, AMDGPU.Device.AS.Global}}
    AMDGPU.code_gcn(iob, dim_kern!, tt; kernel=true)
    gcn = String(take!(iob))
    @test occursin("s_load", gcn)
    @test !occursin("global_load", gcn)
    @test !occursin("flat_load", gcn)
    @test !occursin("buffer_load", gcn)
end

@testset "Bounds checks for the precompiled target" begin
    # same configuration as the precompile workload, whose results the package image caches
    function oob_kern!(a)
        a[workitemIdx().x] += 1f0
        return
    end

    target = GPUCompiler.GCNCompilerTarget(;
        dev_isa="gfx1030", features="+wavefrontsize32,-wavefrontsize64")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true)
    config = GPUCompiler.CompilerConfig(target, params;
        kernel=true, name=nothing, always_inline=true)
    tt = Tuple{AMDGPU.Device.ROCDeviceVector{Float32, AMDGPU.Device.AS.Global}}
    job = GPUCompiler.CompilerJob(GPUCompiler.methodinstance(typeof(oob_kern!), tt), config)
    asm = GPUCompiler.JuliaContext() do _
        asm, meta = GPUCompiler.compile(:asm, job)
        # the IR belongs to us: dispose of it, or it leaks along with the context
        LLVM.dispose(meta.ir)
        asm
    end
    # the exception path signals through an atomic compare-and-swap
    @test occursin("cmpswap", asm)
end

@testset "Atomic metadata" begin
    function rmw_kernel(p, x, op, scope)
        UnsafeAtomics.modify!(p, op, x, UnsafeAtomics.monotonic, scope)
        return
    end
    # the pointer is loaded from memory, so the optimizer can't infer its address space
    function flat_rmw_kernel(pp, x, op, scope)
        UnsafeAtomics.modify!(unsafe_load(pp), op, x, UnsafeAtomics.monotonic, scope)
        return
    end
    function cas_kernel(p, x, scope)
        UnsafeAtomics.cas!(p, x, x, UnsafeAtomics.monotonic, UnsafeAtomics.monotonic, scope)
        return
    end

    rmw_tt(T, op, scope; as=AMDGPU.Device.AS.Global) =
        Tuple{Core.LLVMPtr{T,as}, T, typeof(op), typeof(scope)}

    atomic_lines(ir, inst) = filter(l -> occursin("= $inst ", l), split(ir, '\n'))
    has_md(line, name) = occursin("!amdgpu.$name ", line)
    memory_md(line) = has_md(line, "no.fine.grained.memory") && has_md(line, "no.remote.memory")
    no_memory_md(line) = !has_md(line, "no.fine.grained.memory") && !has_md(line, "no.remote.memory")

    @testset "memory assumptions" begin
        for (T, op) in ((Int32, max), (Int32, |), (Int64, +), (Float32, +), (Float64, -),
                        (Float32, UnsafeAtomics.fmax))
            for scope in (UnsafeAtomics.device, UnsafeAtomics.workgroup)
                ir = compile_offline(rmw_kernel, rmw_tt(T, op, scope), :llvm)
                rmw = only(atomic_lines(ir, "atomicrmw"))
                @test memory_md(rmw)

                ir = compile_offline(rmw_kernel, rmw_tt(T, op, scope), :llvm;
                                     atomic_memory_assumptions=false)
                @test no_memory_md(only(atomic_lines(ir, "atomicrmw")))
            end

            # the system scope is the escape hatch for fine-grained and remote memory
            ir = compile_offline(rmw_kernel, rmw_tt(T, op, UnsafeAtomics.system), :llvm)
            @test no_memory_md(only(atomic_lines(ir, "atomicrmw")))
        end

        # AMDGPU-specific scope names are passed on verbatim
        for (name, assumed) in (("agent-one-as", true), ("cluster", true),
                                ("cluster-one-as", true), ("one-as", false),
                                ("unknown-scope", false))
            scope = UnsafeAtomics.SyncScope(Symbol(name))
            # (GPUCompiler rejects unknown scopes when validating the IR)
            ir = compile_offline(rmw_kernel, rmw_tt(Int32, max, scope), :llvm;
                                 validate=name != "unknown-scope")
            rmw = only(atomic_lines(ir, "atomicrmw"))
            @test occursin("syncscope(\"$name\")", rmw)
            @test assumed ? memory_md(rmw) : no_memory_md(rmw)
        end

        ir = compile_offline(cas_kernel, Tuple{Core.LLVMPtr{Int32,1}, Int32, typeof(UnsafeAtomics.device)},
                             :llvm)
        @test no_memory_md(only(atomic_lines(ir, "cmpxchg")))
    end

    external = AMDGPU.Compiler.AMDGPU_LLVM_Backend_jll.is_available()
    # LLVM 22+ only (the external back-end) uses CAS loops without the metadata
    external && @testset "native integer atomics" begin
        for (op, inst) in ((max, "global_atomic_smax"), (|, "global_atomic_or"),
                           (-, "global_atomic_sub"))
            asm = compile_offline(rmw_kernel, rmw_tt(Int32, op, UnsafeAtomics.device), :asm)
            @test occursin(inst, asm)
            @test !occursin("cmpswap", asm)

            asm = compile_offline(rmw_kernel, rmw_tt(Int32, op, UnsafeAtomics.device), :asm;
                                  atomic_memory_assumptions=false)
            @test occursin("global_atomic_cmpswap", asm)
        end
    end

    @testset "native FP atomics with the in-process back-end" begin
        if :AMDGPU in LLVM.backends()
            asm = compile_offline(rmw_kernel, rmw_tt(Float32, +, UnsafeAtomics.device), :asm;
                                  backend=:inprocess)
            @test occursin("global_atomic_add_f32", asm)
            @test !occursin("cmpswap", asm)
        end
    end

    @testset "denormal mode" begin
        # (renamed to !atomic.ignore.denormal.mode in LLVM 24)
        ignores_denormals(T, op; kwargs...) = occursin(
            r"!(amdgpu|atomic)\.ignore\.denormal\.mode ", only(atomic_lines(
            compile_offline(rmw_kernel, rmw_tt(T, op, UnsafeAtomics.device), :llvm; kwargs...),
            "atomicrmw")))
        @test ignores_denormals(Float32, +)
        @test ignores_denormals(Float32, +; atomic_memory_assumptions=false)
        @test !ignores_denormals(Float32, +; unsafe_fp_atomics=false)
        @test !ignores_denormals(Float64, +)
        @test !ignores_denormals(Float32, -)
        @test !ignores_denormals(Int32, +)
    end

    # UnsafeAtomics only emits `atomicrmw usub_sat` with LLVM 20+
    Base.libllvm_version >= v"20" && @testset "flat usub_sat" begin
        # LLVM 22 couldn't select a native flat usub_sat on gfx10.3/gfx11 with the memory
        # assumptions (llvm/llvm-project#229442), which GPUCompiler works around, so they
        # are attached like for other operations
        flat_tt = Tuple{Core.LLVMPtr{Core.LLVMPtr{UInt32,0},1}, UInt32,
                        typeof(UnsafeAtomics.sub_sat), typeof(UnsafeAtomics.device)}
        ir = compile_offline(flat_rmw_kernel, flat_tt, :llvm; dev_isa="gfx1030")
        @test memory_md(only(atomic_lines(ir, "atomicrmw")))
        if external
            asm = compile_offline(flat_rmw_kernel, flat_tt, :asm; dev_isa="gfx1030")
            @test occursin("flat_atomic_cmpswap", asm)
        end

        global_tt = rmw_tt(UInt32, UnsafeAtomics.sub_sat, UnsafeAtomics.device)
        ir = compile_offline(rmw_kernel, global_tt, :llvm; dev_isa="gfx1030")
        @test memory_md(only(atomic_lines(ir, "atomicrmw")))
        if external
            asm = compile_offline(rmw_kernel, global_tt, :asm; dev_isa="gfx1030")
            @test occursin("global_atomic_csub", asm)
        end
    end
end
