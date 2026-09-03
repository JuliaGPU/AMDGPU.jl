using Test
using AMDGPU
using AMDGPU: Device, ROCArray, @roc
using AMDGPU.Device: sync_workgroup
using KernelAbstractions: @atomic

@testset "Synchronization" begin
    function synckern()
        sync_workgroup()
        nothing
    end

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, synckern, Tuple{}; kernel=true)
    @test occursin("s_barrier", String(take!(iob)))
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
