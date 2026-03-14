using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
using BFloat16s
using AMDGPU.Device: WMMA, workitemIdx, workgroupIdx

AMDGPU.allowscalar(false)

# Only run WMMA tests on RDNA3+ (gfx1100+)
_arch_str = first(split(AMDGPU.HIP.gcn_arch(AMDGPU.device()), ':'))
is_rdna3 = parse(Int, _arch_str[4:end]) >= 1100
if !is_rdna3
    @info "Skipping WMMA tests (requires RDNA3+)"
else

function wmma_kernel_ptr!(C, A::AbstractArray{T}, B, M::Int32, N::Int32, K::Int32) where T
    tile_row = (workgroupIdx().x - Int32(1)) * Int32(WMMA.M)
    tile_col = (workgroupIdx().y - Int32(1)) * Int32(WMMA.N)

    C_ptr = pointer(C)
    A_ptr = pointer(A)
    B_ptr = pointer(B)

    c_frag = WMMA.fill_c(Float32, 0f0)
    k = Int32(0)
    while k < K
        a_ptr = A_ptr + (k * M + tile_row) * Int32(sizeof(T))
        b_ptr = B_ptr + (tile_col * K + k) * Int32(sizeof(T))

        a_frag = WMMA.load_a(a_ptr, M)
        b_frag = WMMA.load_b(b_ptr, K)
        c_frag = WMMA.mma(a_frag, b_frag, c_frag)

        k += Int32(WMMA.K)
    end

    c_ptr = C_ptr + (tile_col * M + tile_row) * Int32(sizeof(Float32))
    WMMA.store_d(c_ptr, c_frag, M)
    return
end

@testset "WMMA" begin

    @testset "Tiled $M x $N: $arg_T" for (M, N, K) in (
        (64, 64, 64), (128, 128, 128),
    ), arg_T in (Float16, BFloat16)
        A_host = arg_T.(rand(M, K))
        B_host = arg_T.(rand(K, N))
        A, B = ROCArray(A_host), ROCArray(B_host)
        C = ROCArray(zeros(Float32, M, N))

        tiles_m, tiles_n = M ÷ WMMA.M, N ÷ WMMA.N
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel_ptr!(
            C, A, B, Int32(M), Int32(N), Int32(K))
        @test maximum(abs.(Float32.(C) .- (Float32.(A) * Float32.(B)))) < 0.1
    end
end
end
