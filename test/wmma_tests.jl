@testitem "core: WMMA" begin

using AMDGPU.Device: wmma_load_a, wmma_load_b, wmma_load_c, wmma_store_d, wmma_mma, wmma_fill_c
using AMDGPU.Device: WMMA_M, WMMA_N, WMMA_K

function wmma_kernel_ptr!(C, A, B, M::Int32, N::Int32, K::Int32)
    tile_row = (workgroupIdx().x - Int32(1)) * Int32(WMMA_M)
    tile_col = (workgroupIdx().y - Int32(1)) * Int32(WMMA_N)

    C_ptr = pointer(C)
    A_ptr = pointer(A)
    B_ptr = pointer(B)

    c_frag = wmma_fill_c(Float32, 0.0f0)

    k = Int32(0)
    while k < K
        a_ptr = A_ptr + (k * M + tile_row) * Int32(sizeof(Float16))
        b_ptr = B_ptr + (tile_col * K + k) * Int32(sizeof(Float16))

        a_frag = wmma_load_a(a_ptr, M)
        b_frag = wmma_load_b(b_ptr, K)
        c_frag = wmma_mma(a_frag, b_frag, c_frag)

        k += Int32(WMMA_K)
    end

    c_ptr = C_ptr + (tile_col * M + tile_row) * Int32(sizeof(Float32))
    wmma_store_d(c_ptr, c_frag, M)
    return
end

@testset "Tiled $M x $N" for (M, N, K) in ((64, 64, 64), (128, 128, 128))
    A_host = Float16.(rand(M, K))
    B_host = Float16.(rand(K, N))
    A_gpu = ROCArray(A_host)
    B_gpu = ROCArray(B_host)
    C_gpu = ROCArray(zeros(Float32, M, N))

    tiles_m = M ÷ WMMA_M
    tiles_n = N ÷ WMMA_N
    @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel_ptr!(
        C_gpu, A_gpu, B_gpu, Int32(M), Int32(N), Int32(K))

    C_result = Array(C_gpu)
    C_expected = Float32.(A_host) * Float32.(B_host)
    @test maximum(abs.(C_result .- C_expected)) < 0.1
end

end
