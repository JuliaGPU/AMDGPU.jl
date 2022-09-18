using Adapt
using AMDGPU.rocSparse
using LinearAlgebra, SparseArrays

@testset "LinearAlgebra" begin
    @testset "$f(A)±$h(B) $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
                                     f in (identity, transpose), #adjoint),
                                     h in (identity, transpose)#, adjoint)
        # adjoint need the support of broadcast for `conj()` to work with `ROCSparseMatrix`.
        n = 10
        alpha = rand()
        beta = rand()
        A = sprand(elty, n, n, rand())
        B = sprand(elty, n, n, rand())

        dA = ROCSparseMatrixCSR(A)
        dB = ROCSparseMatrixCSR(B)

        C = f(A) + h(B)
        dC = f(dA) + h(dB)
        @test C ≈ collect(dC)

        C = f(A) - h(B)
        dC = f(dA) - h(dB)
        @test C ≈ collect(dC)
    end

    @testset "A±$f(B) $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
                                 f in (ROCSparseMatrixCSR, ROCSparseMatrixCSC, x->ROCSparseMatrixBSR(x,1))
        n = 10
        A = sprand(elty, n, n, rand())
        B = sprand(elty, n, n, rand())

        dA = ROCSparseMatrixCSR(A)
        dB = ROCSparseMatrixCSR(B)

        C = A + B
        dC = dA + f(dB)
        @test C ≈ collect(dC)

        C = B + A
        dC = f(dB) + dA
        @test C ≈ collect(dC)

        C = A - B
        dC = dA - f(dB)
        @test C ≈ collect(dC)

        C = B - A
        dC = f(dB) - dA
        @test C ≈ collect(dC)
    end

    @testset "$f(A)*b $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
                                 f in (identity, transpose, adjoint)
        n = 10
        alpha = rand()
        beta = rand()
        A = sprand(elty, n, n, rand())
        b = rand(elty, n)
        c = rand(elty, n)
        alpha = beta = 1.0
        c = zeros(elty, n)

        dA = ROCSparseMatrixCSR(A)
        db = ROCArray(b)
        dc = ROCArray(c)

        # test with empty inputs
        @test Array(dA * AMDGPU.zeros(elty, n, 0)) == zeros(elty, n, 0)

        LinearAlgebra.mul!(c, f(A), b, alpha, beta)
        LinearAlgebra.mul!(dc, f(dA), db, alpha, beta)
        @test c ≈ collect(dc)

        A = A + transpose(A)
        dA = ROCSparseMatrixCSR(A)

        @assert issymmetric(A)
        LinearAlgebra.mul!(c, f(Symmetric(A)), b, alpha, beta)
        LinearAlgebra.mul!(dc, f(Symmetric(dA)), db, alpha, beta)
        @test c ≈ collect(dc)
    end

    @testset "$f(A)*b Complex{$elty}*$elty" for elty in [Float32, Float64],
                                 f in (identity, transpose, adjoint)
        n = 10
        alpha = rand()
        beta = rand()
        A = sprand(Complex{elty}, n, n, rand())
        b = rand(Complex{elty}, n)
        c = rand(Complex{elty}, n)
        alpha = beta = 1.0
        c = zeros(Complex{elty}, n)

        dA = ROCSparseMatrixCSR(A)
        db = ROCArray(b)
        dc = ROCArray(c)

        # test with empty inputs
        @test Array(dA * AMDGPU.zeros(Complex{elty}, n, 0)) == zeros(Complex{elty}, n, 0)

        LinearAlgebra.mul!(c, f(A), b, alpha, beta)
        LinearAlgebra.mul!(dc, f(dA), db, alpha, beta)
        @test c ≈ collect(dc)

        A = A + transpose(A)
        dA = ROCSparseMatrixCSR(A)

        @assert issymmetric(A)
        LinearAlgebra.mul!(c, f(Symmetric(A)), b, alpha, beta)
        LinearAlgebra.mul!(dc, f(Symmetric(dA)), db, alpha, beta)
        @test c ≈ collect(dc)
    end

    @testset "$f(A)*$h(B) $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64],
                                     f in (identity, transpose, adjoint),
                                     h in (identity, transpose, adjoint)
        # if CUSPARSE.version() <= v"10.3.1" &&
        #     (h ∈ (transpose, adjoint) && f != identity) ||
        #     (h == adjoint && elty <: Complex)
        #     # These combinations are not implemented in CUDA10
        #     continue
        # end

        n = 10
        alpha = rand()
        beta = rand()
        A = sprand(elty, n, n, rand())
        B = rand(elty, n, n)
        C = rand(elty, n, n)

        dA = ROCSparseMatrixCSR(A)
        dB = ROCArray(B)
        dC = ROCArray(C)

        LinearAlgebra.mul!(C, f(A), h(B), alpha, beta)
        LinearAlgebra.mul!(dC, f(dA), h(dB), alpha, beta)
        @test C ≈ collect(dC)

        A = A + transpose(A)
        dA = ROCSparseMatrixCSR(A)

        @assert issymmetric(A)
        LinearAlgebra.mul!(C, f(Symmetric(A)), h(B), alpha, beta)
        LinearAlgebra.mul!(dC, f(Symmetric(dA)), h(dB), alpha, beta)
        @test C ≈ collect(dC)
    end

    @testset "issue #1095 ($elty)" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        # Test non-square matrices
        n, m, p = 10, 20, 4
        alpha = rand()
        beta = rand()
        A = sprand(elty, n, m, rand())
        B = rand(elty, m, p)
        C = rand(elty, n, p)

        dA = ROCSparseMatrixCSR(A)
        dB = ROCArray(B)
        dC = ROCArray(C)

        LinearAlgebra.mul!(C, A, B, alpha, beta)
        LinearAlgebra.mul!(dC, dA, dB, alpha, beta)
        @test C ≈ collect(dC)

        LinearAlgebra.mul!(B, transpose(A), C, alpha, beta)
        LinearAlgebra.mul!(dB, transpose(dA), dC, alpha, beta)
        @test B ≈ collect(dB)

        LinearAlgebra.mul!(B, adjoint(A), C, alpha, beta)
        LinearAlgebra.mul!(dB, adjoint(dA), dC, alpha, beta)
        @test B ≈ collect(dB)
    end

    @testset "ROCSparseMatrixCSR($f) $elty" for f in [transpose, adjoint], elty in [Float32, ComplexF32]
        S = f(sprand(elty, 10, 10, 0.1))
        @test SparseMatrixCSC(ROCSparseMatrixCSR(S)) ≈ S

        S = sprand(elty, 10, 10, 0.1)
        T = f(ROCSparseMatrixCSR(S))
        @test SparseMatrixCSC(ROCSparseMatrixCSC(T)) ≈ f(S)

        S = sprand(elty, 10, 10, 0.1)
        T = f(ROCSparseMatrixCSC(S))
        @test SparseMatrixCSC(ROCSparseMatrixCSR(T)) ≈ f(S)
    end

    @testset "UniformScaling with $typ($dims)" for
            typ in [ROCSparseMatrixCSR, ROCSparseMatrixCSC],
            dims in [(10, 10), (5, 10), (10, 5)]
        S = sprand(Float32, dims..., 0.1)
        dA = typ(S)

        @test Array(dA + I) == S + I
        @test Array(I + dA) == I + S

        @test Array(dA - I) == S - I
        @test Array(I - dA) == I - S
    end

    @testset "Diagonal with $typ(10, 10)" for
        typ in [ROCSparseMatrixCSR, ROCSparseMatrixCSC]
        
        S = sprand(Float32, 10, 10, 0.8)
        D = Diagonal(rand(Float32, 10))
        dA = typ(S)
        dD = adapt(ROCArray, D)

        @test Array(dA + dD) == S + D
        @test Array(dD + dA) == D + S

        @test Array(dA - dD) == S - D
        @test Array(dD - dA) == D - S

        @test dA + dD isa typ
        @test dD + dA isa typ
        @test dA - dD isa typ
        @test dD - dA isa typ
    end
end
