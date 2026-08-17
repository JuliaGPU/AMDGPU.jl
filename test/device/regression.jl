using Test
using AMDGPU
using KernelAbstractions: @kernel, @index

# https://github.com/JuliaGPU/AMDGPU.jl/issues/931

# strong-zero scalar ops, as in VectorInterface.scale/add
_scale(x, α) = iszero(α) ? zero(x * α) : x * α
_add(x, y) = x + y

@inline function _strided_offset(strides::NTuple{N, Int}, cidx::CartesianIndex{N}) where N
    s = 0
    for d in Base.OneTo(N)
        @inbounds s += strides[d] * (cidx[d] - 1)
    end
    return s
end

@kernel function conj_scale_add!(out, A, αv, βv, conjfn, out_stride, A_stride, dims_red)
    I = @index(Global, Cartesian)
    out_i = _strided_offset(out_stride, I) + 1
    A_i = _strided_offset(A_stride, I) + 1
    @inbounds acc = _scale(out[out_i], βv)
    for I_red in CartesianIndices(dims_red)
        A_red = _strided_offset(A_stride, I_red)
        val = conjfn(getindex(A, A_i + A_red))
        acc = _add(acc, _scale(val, αv))
    end
    @inbounds out[out_i] = acc
end

@testset "Predicated conj load (#931)" begin
    # `out_stride` and `A_stride` are permuted (non-column-major) layouts over
    # `dims`, each a bijection onto 1:prod(dims); the exact sizes are bisection
    # artifacts, kept to preserve the miscompiled IR shape.
    dims = (4, 3, 5, 6)
    out_stride = (1, 4, 72, 12)
    A_stride = (15, 1, 3, 60)
    dims_red = (1, 1, 1, 1)
    α = ComplexF32(0.75734866, 0.7862585)
    β = ComplexF32(0.9682096, 0.11172444)

    n = prod(dims)
    C0 = ComplexF32.(randn(Float32, n), randn(Float32, n))
    hA = ComplexF32.(randn(Float32, n), randn(Float32, n))

    # α and β are nonzero, so the kernel's strong-zero `_scale`/`_add` reduce
    # to plain scalar arithmetic in this reference.
    expected = copy(C0)
    for I in CartesianIndices(dims)
        oi = _strided_offset(out_stride, I) + 1
        ai = _strided_offset(A_stride, I) + 1
        expected[oi] = β * C0[oi] + α * conj(hA[ai])
    end

    dC = ROCArray(C0)
    dA = ROCArray(hA)
    conj_scale_add!(AMDGPU.ROCBackend())(
        dC, dA, α, β, conj, out_stride, A_stride, dims_red; ndrange=dims)
    AMDGPU.synchronize()
    @test Array(dC) ≈ expected
end
