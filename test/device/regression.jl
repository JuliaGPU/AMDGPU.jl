using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim

# https://github.com/JuliaGPU/AMDGPU.jl/issues/1015

function triangular_for!(out, A, R, n)
    lm = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    if lm ≤ size(out, 1)
        @inbounds for k in 1:n
            v = zero(eltype(out))
            for r in k:n
                v += R[k, r] * A[lm, r]
            end
            out[lm, k] = v
        end
    end
    return
end

function triangular_while!(out, A, R, n)
    lm = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    if lm ≤ size(out, 1)
        @inbounds for k in 1:n
            v = zero(eltype(out))
            r = k
            while r ≤ n
                v += R[k, r] * A[lm, r]
                r += 1
            end
            out[lm, k] = v
        end
    end
    return
end

@testset "Triangular dynamic-bounds loop (#1015)" begin
    n, rows = 8, 594
    hA = rand(ComplexF32, rows, n)
    hR = rand(Float32, n, n)
    A, R = ROCArray(hA), ROCArray(hR)

    expected = [sum(hR[k, r] * hA[l, r] for r in k:n) for l in 1:rows, k in 1:n]

    groupsize = 256
    gridsize = cld(rows, groupsize)

    @testset "$(nameof(kernel))" for kernel in (triangular_for!, triangular_while!)
        out = AMDGPU.zeros(ComplexF32, rows, n)
        @roc groupsize=groupsize gridsize=gridsize kernel(out, A, R, n)
        AMDGPU.synchronize()
        @test Array(out) ≈ expected
    end
end
