using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim

# https://github.com/JuliaGPU/AMDGPU.jl/issues/1015
#
# A device-side loop over a triangular range whose both endpoints are dynamic
# was miscompiled on CDNA (gfx90a, gfx942) when bounds checks are off, faulting
# with "Memory access fault ... Reason: Unknown". The same faulty pattern is
# emitted on RDNA, but is benign there because of wave32 branch lowering, so
# this only ever reproduced on MI250/MI300.
#
# Fixed upstream in llvm/llvm-project#215829 and backported into
# AMDGPU_LLVM_Backend_jll by JuliaPackaging/Yggdrasil#14465.
#
# NOTE: kernels are defined at top level on purpose. Defining them inside the
# testset makes them close over the enclosing locals, which is not what we want
# to compile here.

# Both endpoints of the inner loop are dynamic, which is what triggered the
# miscompile.
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

# `while` form of the same loop. It was never affected by the miscompile, so it
# acts as a control: if only `triangular_for!` fails, the regression is back in
# the backend rather than in this test's reference values.
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

    # Direct transcription of the kernels' arithmetic.
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
