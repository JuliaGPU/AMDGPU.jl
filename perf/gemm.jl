group = addgroup!(SUITE, "gemm")

using StaticArrays

# Register-tiled GEMM: 16x16 workgroup, 8x8 accumulator microtile per thread,
# A/B staged through LDS. Register-bound: tracks the launch-bounds support
# (maxthreads=256 lifts the default 1,1024 flat-workgroup-size register budget).
function gemm_tiled!(C, A, B, M, N, K)
    tx = workitemIdx().x % Int32
    ty = workitemIdx().y % Int32
    bx = workgroupIdx().x % Int32
    by = workgroupIdx().y % Int32

    sA = @ROCStaticLocalArray(Float32, (128, 16), false)
    sB = @ROCStaticLocalArray(Float32, (16, 128), false)

    acc = MVector{64, Float32}(undef)
    @inbounds for i in 1:64
        acc[i] = 0f0
    end

    row0 = (bx - Int32(1)) * Int32(128)
    col0 = (by - Int32(1)) * Int32(128)
    tid = (ty - Int32(1)) * Int32(16) + tx

    nk = div(K, Int32(16))
    @inbounds for kb in Int32(1):nk
        k0 = (kb - Int32(1)) * Int32(16)
        for r in Int32(0):Int32(7)
            idx = (tid - Int32(1)) + r * Int32(256)
            ar = idx % Int32(128); ac = div(idx, Int32(128))
            sA[ar + Int32(1), ac + Int32(1)] = A[row0 + ar + Int32(1) + (k0 + ac) * M]
            br = idx % Int32(16); bc = div(idx, Int32(16))
            sB[br + Int32(1), bc + Int32(1)] = B[k0 + br + Int32(1) + (col0 + bc) * K]
        end
        sync_workgroup()
        for k in Int32(1):Int32(16)
            for j in Int32(1):Int32(8), i in Int32(1):Int32(8)
                a = sA[(tx - Int32(1)) * Int32(8) + i, k]
                b = sB[k, (ty - Int32(1)) * Int32(8) + j]
                acc[(j - Int32(1)) * Int32(8) + i] = muladd(a, b, acc[(j - Int32(1)) * Int32(8) + i])
            end
        end
        sync_workgroup()
    end
    @inbounds for j in Int32(1):Int32(8), i in Int32(1):Int32(8)
        r = row0 + (tx - Int32(1)) * Int32(8) + i
        c = col0 + (ty - Int32(1)) * Int32(8) + j
        C[r + (c - Int32(1)) * M] = acc[(j - Int32(1)) * Int32(8) + i]
    end
    return
end

gemm_N = Int32(2048)
gemm_A = AMDGPU.rand(Float32, gemm_N, gemm_N)
gemm_B = AMDGPU.rand(Float32, gemm_N, gemm_N)
gemm_C = similar(gemm_A)
gemm_grid = (div(Int(gemm_N), 128), div(Int(gemm_N), 128))
group["tiled"] = @async_benchmarkable(
    @roc groupsize=(16, 16) gridsize=$gemm_grid maxthreads=256 $gemm_tiled!(
        $gemm_C, $gemm_A, $gemm_B, $gemm_N, $gemm_N, $gemm_N))
group["tiled_unbounded"] = @async_benchmarkable(
    @roc groupsize=(16, 16) gridsize=$gemm_grid $gemm_tiled!(
        $gemm_C, $gemm_A, $gemm_B, $gemm_N, $gemm_N, $gemm_N))
