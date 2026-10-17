using Test
using AMDGPU
import GPUCompiler
import LLVM
using AMDGPU: Device, ROCArray, @roc, UnsafeAtomics
using AMDGPU.Device: sync_workgroup, workitemIdx, workgroupIdx, workgroupDim
using KernelAbstractions: @atomic

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

@testset "waves_per_eu" begin
    wpe_kern() = nothing
    function wpe_ir(; kwargs...)
        config = AMDGPU.Compiler.compiler_config(AMDGPU.device(); kernel=true, kwargs...)
        job = GPUCompiler.CompilerJob(GPUCompiler.methodinstance(typeof(wpe_kern), Tuple{}), config)
        sprint(io -> GPUCompiler.code_llvm(io, job; dump_module=true))
    end
    @test occursin("\"amdgpu-waves-per-eu\"=\"4\"", wpe_ir(; waves_per_eu=4))
    @test !occursin("amdgpu-waves-per-eu", wpe_ir())

    k = @roc launch=false maxthreads=256 waves_per_eu=2 wpe_kern()
    k(; groupsize=256)
    AMDGPU.synchronize()
end
