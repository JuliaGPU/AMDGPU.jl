using AMDGPU
using AMDGPU.ROCSPARSE
using LinearAlgebra, SparseArrays
using Test

@testset "LinearAlgebra" begin
	mA = 3
	nA = 5
	nnzA = 8
	rowPtrA = ROCVector{Int32}([0, 3, 5, 8])
	colValA = ROCVector{Int32}([0, 1, 3, 1, 2, 0, 3, 4])
	nzValA = ROCVector{Float32}([1, 2, 3, 4, 5, 6, 7, 8])
        
	rowPtrAT = ROCVector{Int32}(undef, mA+1)
	colValAT = ROCVector{Int32}(undef, nnzA)
	nzValAT = ROCVector{Float32}(undef, nnzA)

	buffer = ROCVector{Float32}(undef, 1000)
	status = AMDGPU.ROCSPARSE.rocsparse_scsr2csc(AMDGPU.ROCSPARSE.handle(), mA, nA, nnzA, 
		nzValA, rowPtrA, colValA,
		nzValAT, colValAT, rowPtrAT,
		AMDGPU.ROCSPARSE.rocsparse_action_symbolic,
		AMDGPU.ROCSPARSE.rocsparse_index_base_zero,
		buffer
    )
    @test_broken status == AMDGPU.ROCSPARSE.rocsparse_status_success
#     @testset "$f(A)*b $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
#                                  f in (identity, transpose, adjoint)
    (elty, f) = (Float32, identity)
    n = 10
    alpha = rand()
    beta = rand()
    A = sprand(elty, n, n, rand())
    b = rand(elty, n)
    c = rand(elty, n)
    alpha = beta = 1.0
    c = zeros(elty, n)
    dA = ROCSparseMatrixCSC(A)
    db = ROCArray(b)
    dc = ROCArray(c)

    mul!(c, f(A), b, alpha, beta)
    mul!(dc, f(dA), db, alpha, beta)
    @test c ≈ collect(dc)

    A = A + transpose(A)



        # dA = CuSparseMatrixCSR(A)

        # @assert issymmetric(A)
        # mul!(c, f(Symmetric(A)), b, alpha, beta)
        # mul!(dc, f(Symmetric(dA)), db, alpha, beta)
        # @test c ≈ collect(dc)
#     end

    # @testset "$f(A)*$h(B) $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
    #                                  f in (identity, transpose, adjoint),
    #                                  h in (identity, transpose, adjoint)
    #     if CUSPARSE.version() <= v"10.3.1" &&
    #         (h ∈ (transpose, adjoint) && f != identity) ||
    #         (h == adjoint && elty <: Complex)
    #         # These combinations are not implemented in CUDA10
    #         continue
    #     end

    #     n = 10
    #     alpha = rand()
    #     beta = rand()
    #     A = sprand(elty, n, n, rand())
    #     B = rand(elty, n, n)
    #     C = rand(elty, n, n)

    #     dA = CuSparseMatrixCSR(A)
    #     dB = CuArray(B)
    #     dC = CuArray(C)

    #     mul!(C, f(A), h(B), alpha, beta)
    #     mul!(dC, f(dA), h(dB), alpha, beta)
    #     @test C ≈ collect(dC)

    #     A = A + transpose(A)
    #     dA = CuSparseMatrixCSR(A)

    #     @assert issymmetric(A)
    #     mul!(C, f(Symmetric(A)), h(B), alpha, beta)
    #     mul!(dC, f(Symmetric(dA)), h(dB), alpha, beta)
    #     @test C ≈ collect(dC)
    # end
end