@testset "rocSOLVER" begin

using AMDGPU.rocSOLVER

m, n = 15, 10
p = 5

@testset "elty=$elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
    @testset "qr" begin
        tol = min(m, n) * eps(real(elty)) * (1 + (elty <: Complex))

        A = rand(elty, m, n)
        F = qr(A)

        dA = ROCArray(A)
        dF = qr(dA)

        dRR = dF.Q' * dA
        @test collect(dRR[1:n, :]) ≈ collect(dF.R) atol=tol * norm(A)
        @test norm(dRR[n + 1:end, :]) < tol * norm(A)

        dRRt = dA' * dF.Q
        @test collect(dRRt[:, 1:n]) ≈ collect(dF.R') atol=tol * norm(A)
        @test norm(dRRt[:, n + 1:end]) < tol * norm(A)

        @test size(dF) == size(A)
        @test size(dF.Q) == (m, m)
        @test size(dF.R) == (n, n)
        @test size(dRR) == size(dA)
        @test size(dRRt) == size(dA')

        dI = ROCMatrix{elty}(I, size(dF.Q))
        @test det(dF.Q) ≈ det(collect(dF.Q * ROCMatrix{elty}(I, size(dF.Q)))) atol=tol * norm(A)
        @test collect((dF.Q' * dI) * dF.Q) ≈ collect(dI)
        @test collect(dF.Q * (dI * dF.Q')) ≈ collect(dI)

        dI = ROCMatrix{elty}(I, size(dF.R))
        @test collect(dF.R * dI) ≈ collect(dF.R)
        @test collect(dI * dF.R) ≈ collect(dF.R)

        Q, R = F
        dQ, dR = dF
        @test collect(dQ * dR) ≈ A
        @test collect(dR * dQ') ≈ (R * Q')

        A = rand(elty, n, m)
        dA = ROCArray(A)
        dF = qr(dA)
        @test det(dF.Q) ≈ det(collect(dF.Q * ROCMatrix{elty}(I, size(dF.Q)))) atol=tol * norm(A)

        A = rand(elty, m, n)
        dA = ROCArray(A)
        dq, dr = qr(dA)
        q, r = qr(A)
        @test Array(dq) ≈ Array(q)
        @test collect(ROCArray(dq)) ≈ Array(q)
        @test Array(dr) ≈ Array(r)
        @test ROCArray(dq) ≈ convert(typeof(dA), dq)

        A = rand(elty, n, m)
        dA = ROCArray(A)
        dq, dr = qr(dA)
        q, r = qr(A)
        @test Array(dq) ≈ Array(q)
        @test Array(dr) ≈ Array(r)
    end
end

@testset "Matrix division $elty1 \\ $elty2" for elty1 in (
    Float16, Float32, Float64, ComplexF16, ComplexF32, ComplexF64,
), elty2 in (
    Float16, Float32, Float64, ComplexF16, ComplexF32, ComplexF64,
)
    @testset "Underdetermined linear system" begin
        A = rand(elty1, n, m)
        B = rand(elty2, n, 5)
        b = rand(elty2, n)

        rocblasfloat = promote_type(Float32, promote_type(elty1, elty2))
        Af, Bf, bf = map(x -> rocblasfloat.(x), (A, B, b))

        dA, dB, db = ROCArray.((A, B, b))
        @test Array(dA \ dB) ≈ (Af \ Bf)
        @test Array(dA \ db) ≈ (Af \ bf)
        @inferred dA \ dB
        @inferred dA \ db
    end

    @testset "Square linear system" begin
        A = rand(elty1, n, n)
        B = rand(elty2, n, 5)
        b = rand(elty2, n)

        rocblasfloat = promote_type(Float32, promote_type(elty1, elty2))
        Af, Bf, bf = map(x -> rocblasfloat.(x), (A, B, b))

        dA, dB, db = ROCArray.((A, B, b))
        @test Array(dA \ dB) ≈ (Af \ Bf)
        @test Array(dA \ db) ≈ (Af \ bf)
        @inferred dA \ dB
        @inferred dA \ db
    end

    @testset "Overdetermined linear system" begin
        A = rand(elty1, m, n)
        B = rand(elty2, m, 5)
        b = rand(elty2, m)

        rocblasfloat = promote_type(Float32, promote_type(elty1, elty2))
        Af, Bf, bf = map(x -> rocblasfloat.(x), (A, B, b))

        dA, dB, db = ROCArray.((A, B, b))
        @test Array(dA \ dB) ≈ (Af \ Bf)
        @test Array(dA \ db) ≈ (Af \ bf)
        @inferred dA \ dB
        @inferred dA \ db
    end
end

@testset "ldiv!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A, x, y = rand(elty, m, m), rand(elty, m), rand(elty, m)
        dA, dx, dy = ROCArray.((A, x, y))

        b = ldiv!(qr(A), x)
        db = ldiv!(qr(dA), dx)
        @test Array(db) ≈ b

        b = ldiv!(y, qr(A), x)
        db = ldiv!(dy, qr(dA), dx)
        @test Array(db) ≈ b
    end
end

@testset "geqrf! -- omgqr!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A = rand(elty, m, n)
        dA = ROCArray(A)
        dA, τ = rocSOLVER.geqrf!(dA)
        rocSOLVER.orgqr!(dA, τ)
        @test dA' * dA ≈ I
    end
end

@testset "ormqr!" begin
    @testset "elty = $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
        @testset "side = $side" for side in ('L', 'R')
            @testset "trans = $trans" for (trans, op) in (
                ('N', identity), ('T', transpose), ('C', adjoint),
            )
                elty <: Real && trans == 'C' && continue
                elty <: Complex && trans == 'T' && continue

                dA = ROCArray(rand(elty, m, n))
                dA, dτ = rocSOLVER.geqrf!(dA)

                dI = ROCArray(Matrix{elty}(I, m, m))
                dH = rocSOLVER.ormqr!(side, 'N', dA, dτ, dI)
                @test dH' * dH ≈ I

                C = side == 'L' ? rand(elty, m, n) : rand(elty, n, m)
                dC = ROCArray(C)
                dD = side == 'L' ? op(dH) * dC : dC * op(dH)

                rocSOLVER.ormqr!(side, trans, dA, dτ, dC)
                @test dC ≈ dD
            end
        end
    end
end

@testset "potrf! -- potrs!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A    = rand(elty,n,n)
        A    = A*A' + I
        B    = rand(elty,n,p)
        d_A  = ROCArray(A)
        d_B  = ROCArray(B)

        LAPACK.potrf!('L',d_A)
        LAPACK.potrs!('U',d_A,d_B)
        LAPACK.potrf!('L',A)
        LAPACK.potrs!('U',A,B)
        @test B ≈ collect(d_B)
    end
end

@testset "sytrf!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A = rand(elty,n,n)
        A = A + A'
        d_A = ROCArray(A)
        d_A,d_ipiv,info = rocSOLVER.sytrf!('U',d_A)
        LinearAlgebra.checknonsingular(info)
        h_A = collect(d_A)
        h_ipiv = collect(d_ipiv)
        A, ipiv = LAPACK.sytrf!('U',A)
        @test ipiv == h_ipiv
        @test A ≈ h_A
    end
end

@testset "gebrd!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A                             = rand(elty,m,n)
        d_A                           = ROCArray(A)
        d_A, d_D, d_E, d_tauq, d_taup = rocSOLVER.gebrd!(d_A)
        h_A                           = collect(d_A)
        h_D                           = collect(d_D)
        h_E                           = collect(d_E)
        h_tauq                        = collect(d_tauq)
        h_taup                        = collect(d_taup)
        A,d,e,q,p                     = LAPACK.gebrd!(A)
        @test A ≈ h_A
        @test d ≈ h_D
        @test e[min(m,n)-1] ≈ h_E[min(m,n)-1]
        @test q ≈ h_tauq
        @test p ≈ h_taup
    end
end

@testset "gesvd!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        A = rand(elty,m,n)
        d_A = ROCMatrix(A)
        U, Σ, Vt = rocSOLVER.gesvd!('A', 'A', d_A)
        @test A ≈ collect(U[:,1:n] * Diagonal(Σ) * Vt)
    end
end

@testset "getrf_batched! -- getri_batched!" begin
    @testset "elty = $elty" for elty in [Float32, Float64, ComplexF32, ComplexF64]
        bA = [rand(elty, m, m) for i in 1:n]
        d_bA = ROCMatrix{elty}[]
        for i in 1:n
            push!(d_bA, ROCMatrix(bA[i]))
        end

        d_ipiv, flags, d_bA = rocSOLVER.getrf_batched!(d_bA)
        h_bA = [collect(d_bA[i]) for i in 1:n]

        ipiv = Vector{Int64}[]
        for i = 1:n
            _, ipiv_i, info = LinearAlgebra.LAPACK.getrf!(bA[i])
            push!(ipiv, ipiv_i)
            @test bA[i] ≈ h_bA[i]
        end

        d_ipiv, flags, d_bA = rocSOLVER.getri_batched!(d_bA, d_ipiv)
        h_bA = [collect(d_bA[i]) for i in 1:n]
        for i = 1:n
            LinearAlgebra.LAPACK.getri!(bA[i], ipiv[i])
            @test bA[i] ≈ h_bA[i]
        end
    end
end

@testset "gesvdj!" begin
    @testset "elts = ($elty, $tol_type)" for (elty, tol_type) in [
        (ComplexF64, Float64),
        (ComplexF32, Float32),
        (Float64, Float64),
        (Float32, Float32),
    ]
        A = rand(elty, m, n)
        dA = ROCMatrix(A)
        abstol = tol_type(-1.0)
        max_sweeps::Int32 = 100

        U, S, V, residual, n_sweeps, info = AMDGPU.rocSOLVER.gesvdj!(dA, abstol, max_sweeps)
        @test U * Diagonal(S) * V' ≈ dA
    end
end

@testset "eigen" begin
    @testset "matrix type = $matrix_type" for (matrix_type, eltypes) in [
        (Symmetric, [Float32, Float64]),
        (Hermitian, [Float32, Float64, ComplexF32, ComplexF64]),
    ]
        @testset "elty = $elty" for elty in eltypes
            A = matrix_type(rand(elty, m, m))
            dA = ROCMatrix(A)

            E = eigen(dA)

            for k in 1:length(E.values)
                @allowscalar lambda = E.values[k]
                @test dA * E.vectors[:, k] ≈ lambda .* E.vectors[:, k]
            end
        end
    end
end

end
