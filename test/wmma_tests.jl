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

# Tile base pointer + stride for A (M×K) by layout.
_a_tile(ptr, ::WMMA.ColMajor, tile_row, k, M, K, ::Type{T}) where T =
    ptr + (k * M + tile_row) * Int32(sizeof(T)), M
_a_tile(ptr, ::WMMA.RowMajor, tile_row, k, M, K, ::Type{T}) where T =
    ptr + (tile_row * K + k) * Int32(sizeof(T)), K

# Tile base pointer + stride for B (K×N) by layout.
_b_tile(ptr, ::WMMA.ColMajor, tile_col, k, N, K, ::Type{T}) where T =
    ptr + (tile_col * K + k) * Int32(sizeof(T)), K
_b_tile(ptr, ::WMMA.RowMajor, tile_col, k, N, K, ::Type{T}) where T =
    ptr + (k * N + tile_col) * Int32(sizeof(T)), N

function wmma_kernel!(
    C::AbstractArray{R},
    A::AbstractArray{T}, B,
    M::Int32, N::Int32, K::Int32,
    layout, scale::Float32,
) where {R, T}
    tile_row = (workgroupIdx().x - Int32(1)) * Int32(WMMA.M)
    tile_col = (workgroupIdx().y - Int32(1)) * Int32(WMMA.N)

    C_ptr = pointer(C)
    A_ptr = pointer(A)
    B_ptr = pointer(B)

    c_frag = WMMA.fill_c(Float32, 0f0)
    k = Int32(0)
    while k < K
        a_ptr, a_stride = _a_tile(A_ptr, layout, tile_row, k, M, K, T)
        b_ptr, b_stride = _b_tile(B_ptr, layout, tile_col, k, N, K, T)

        a_frag = WMMA.load_a(a_ptr, a_stride, layout)
        b_frag = WMMA.load_b(b_ptr, b_stride, layout)
        c_frag = WMMA.mma(a_frag, b_frag, c_frag)

        k += Int32(WMMA.K)
    end

    c_frag = c_frag .* scale
    c_ptr = C_ptr + (tile_col * M + tile_row) * Int32(sizeof(R))
    WMMA.store_d(c_ptr, c_frag, M, WMMA.ColMajor())
    return
end

@testset "WMMA" begin
    @testset "ColMajor $M×$N: $arg_T -> $res_T" for (M, N, K) in (
        (64, 64, 64), (128, 128, 128),
    ), arg_T in (Float16, BFloat16), res_T in (Float16, BFloat16, Float32)
        A_host = arg_T.(rand(M, K))
        B_host = arg_T.(rand(K, N))
        A, B = ROCArray(A_host), ROCArray(B_host)
        C = ROCArray(zeros(res_T, M, N))
        tol = sizeof(res_T) == 4 ? 0.1 : 0.3

        tiles_m, tiles_n = M ÷ WMMA.M, N ÷ WMMA.N
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel!(
            C, A, B, Int32(M), Int32(N), Int32(K), WMMA.ColMajor(), 1f0)
        @test maximum(abs.(Float32.(C) .- (Float32.(A) * Float32.(B)))) < tol
    end

    @testset "Fragment broadcast: $M×$N $arg_T" for (M, N, K) in (
        (64, 64, 64), (128, 128, 128),
    ), arg_T in (Float16, BFloat16)
        scale = rand(Float32)
        A_host = arg_T.(rand(M, K))
        B_host = arg_T.(rand(K, N))
        A, B = ROCArray(A_host), ROCArray(B_host)
        C = ROCArray(zeros(Float32, M, N))

        tiles_m, tiles_n = M ÷ WMMA.M, N ÷ WMMA.N
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel!(
            C, A, B, Int32(M), Int32(N), Int32(K), WMMA.ColMajor(), scale)
        expected = scale .* (Float32.(A) * Float32.(B))
        @test maximum(abs.(Float32.(C) .- expected)) < 0.1
    end

    @testset "RowMajor $M×$N: $arg_T" for (M, N, K) in (
        (64, 64, 64), (128, 128, 128),
    ), arg_T in (Float16, BFloat16), res_T in (Float16, BFloat16, Float32)
        A_host = arg_T.(rand(M, K))
        B_host = arg_T.(rand(K, N))
        # Transpose to get row-major storage.
        A = ROCArray(A_host')
        B = ROCArray(B_host')
        C = ROCArray(zeros(res_T, M, N))
        tol = sizeof(res_T) == 4 ? 0.1 : 0.3

        tiles_m, tiles_n = M ÷ WMMA.M, N ÷ WMMA.N
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel!(
            C, A, B, Int32(M), Int32(N), Int32(K), WMMA.RowMajor(), 1f0)
        @test maximum(abs.(
            Float32.(C) .- ROCArray(Float32.(A_host)) * ROCArray(Float32.(B_host))
        )) < tol
    end
end

end
