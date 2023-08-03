m, n = 15, 10

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
        # TODO 1.10
        @test collect(dF.Q * dI) ≈ collect(dF.Q)
        @test collect(dI * dF.Q) ≈ collect(dF.Q)

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

        # TODO the rest
        # https://github.com/JuliaGPU/CUDA.jl/blob/d79adbfd090b0e51ccaf4c74710eaa610e0bf998/test/libraries/cusolver/dense.jl#L409
    end
end
