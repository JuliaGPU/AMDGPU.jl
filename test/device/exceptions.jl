@testset "Exceptions" begin
    function oob_kernel(X)
        X[0] = 1
        return
    end

    RA = ROCArray(zeros(Int, 1))
    @roc oob_kernel(RA)
    try
        AMDGPU.synchronize()
    catch err
        @test err isa ErrorException
    end
    # TODO check exception message
    # TODO check specific exception type
end

# FIXME: https://github.com/JuliaGPU/AMDGPU.jl/issues/808
# For now InexactError with just throw(nothing) and not log anything.
@testset "Issue #808: InexactError failure" begin
    @inline function add!(a::MMatrix{NC,NC,Complex{T},NC2}) where {NC,NC2,T}
        ar = reinterpret(reshape, T, a)
        ar[1] += 1.0
        return a
    end

    function kernel!(a)
        i = workitemIdx().x
        a[i] = SMatrix(add!(MMatrix(a[i])))
        return
    end

    a = AMDGPU.zeros(SMatrix{3,3,ComplexF64,9}, 1)
    @roc groupsize=1 kernel!(a)
end
