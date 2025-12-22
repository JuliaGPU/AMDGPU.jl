using AMDGPU
using AMDGPU.Device: wmma_load_a, wmma_load_b, wmma_store_d
using AMDGPU.Device: wmma_mma, wmma_fill_c
using AMDGPU.Device: WMMA_M, WMMA_N, WMMA_K
using Printf
using LinearAlgebra

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

function naive_matmul_kernel!(C, A, B, M::Int32, N::Int32, K::Int32)
    i = (workgroupIdx().x - Int32(1)) * workgroupDim().x + workitemIdx().x
    j = (workgroupIdx().y - Int32(1)) * workgroupDim().y + workitemIdx().y

    if i <= M && j <= N
        acc = 0.0f0
        for k in Int32(1):K
            acc += Float32(A[i, k]) * Float32(B[k, j])
        end
        C[i, j] = acc
    end
    return
end

function benchmark_wmma_ptr(M, N, K; warmup=5, iterations=20)
    A_gpu = ROCArray(Float16.(rand(M, K)))
    B_gpu = ROCArray(Float16.(rand(K, N)))
    C_gpu = ROCArray(zeros(Float32, M, N))

    tiles_m = M ÷ WMMA_M
    tiles_n = N ÷ WMMA_N

    for _ in 1:warmup
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel_ptr!(
            C_gpu, A_gpu, B_gpu, Int32(M), Int32(N), Int32(K))
        AMDGPU.synchronize()
    end

    t_start = time_ns()
    for _ in 1:iterations
        @roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel_ptr!(
            C_gpu, A_gpu, B_gpu, Int32(M), Int32(N), Int32(K))
        AMDGPU.synchronize()
    end
    t_end = time_ns()

    return (t_end - t_start) / iterations / 1e6
end

function benchmark_rocblas(M, N, K; warmup=5, iterations=20)
    A_gpu = ROCArray(Float16.(rand(M, K)))
    B_gpu = ROCArray(Float16.(rand(K, N)))
    C_gpu = ROCArray(zeros(Float32, M, N))

    A_f32 = ROCArray(zeros(Float32, M, K))
    B_f32 = ROCArray(zeros(Float32, K, N))
    copyto!(A_f32, Float32.(Array(A_gpu)))
    copyto!(B_f32, Float32.(Array(B_gpu)))

    for _ in 1:warmup
        mul!(C_gpu, A_f32, B_f32)
        AMDGPU.synchronize()
    end

    t_start = time_ns()
    for _ in 1:iterations
        mul!(C_gpu, A_f32, B_f32)
        AMDGPU.synchronize()
    end
    t_end = time_ns()

    return (t_end - t_start) / iterations / 1e6
end

function benchmark_naive(M, N, K; warmup=5, iterations=20)
    A_gpu = ROCArray(Float16.(rand(M, K)))
    B_gpu = ROCArray(Float16.(rand(K, N)))
    C_gpu = ROCArray(zeros(Float32, M, N))

    block_size = 16
    grid_x = cld(M, block_size)
    grid_y = cld(N, block_size)

    for _ in 1:warmup
        @roc gridsize=(grid_x, grid_y) groupsize=(block_size, block_size) naive_matmul_kernel!(
            C_gpu, A_gpu, B_gpu, Int32(M), Int32(N), Int32(K))
        AMDGPU.synchronize()
    end

    t_start = time_ns()
    for _ in 1:iterations
        @roc gridsize=(grid_x, block_size) groupsize=(block_size, block_size) naive_matmul_kernel!(
            C_gpu, A_gpu, B_gpu, Int32(M), Int32(N), Int32(K))
        AMDGPU.synchronize()
    end
    t_end = time_ns()

    return (t_end - t_start) / iterations / 1e6
end

function compute_tflops(M, N, K, time_ms)
    flops = 2.0 * M * N * K
    return flops / (time_ms * 1e-3) / 1e12
end

function main()
    println("WMMA Matrix Multiplication Benchmark")
    println("=" ^ 76)
    println()

    sizes = [
        (256, 256, 256),
        (512, 512, 512),
        (1024, 1024, 1024),
        (2048, 2048, 2048),
        (4096, 4096, 4096),
    ]

    println(@sprintf("%-16s %10s %10s %10s %10s %10s",
        "Size", "WMMA-Ptr", "rocBLAS", "Naive", "WMMA", "rocBLAS"))
    println(@sprintf("%-16s %10s %10s %10s %10s %10s",
        "", "(ms)", "(ms)", "(ms)", "TFLOPS", "TFLOPS"))
    println("-" ^ 76)

    for (M, N, K) in sizes
        t_wmma_ptr = benchmark_wmma_ptr(M, N, K)
        t_rocblas = benchmark_rocblas(M, N, K)
        t_naive = benchmark_naive(M, N, K)

        tflops_wmma = compute_tflops(M, N, K, t_wmma_ptr)
        tflops_rocblas = compute_tflops(M, N, K, t_rocblas)

        println(@sprintf("%-16s %10.3f %10.3f %10.3f %10.2f %10.2f",
            "$(M)x$(N)x$(K)", t_wmma_ptr, t_rocblas, t_naive, tflops_wmma, tflops_rocblas))
    end
end
main()
