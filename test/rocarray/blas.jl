@testset "BLAS" begin

using AMDGPU.rocBLAS
using AMDGPU.HIP
import .rocBLAS: rocblas_int

handle = rocBLAS.handle()

@testset "Build Information" begin
    ver = rocBLAS.version()
    @test ver isa VersionNumber
end

@testset "Highlevel" begin
    for T in (Float32, Float64)
        # Regular array
        A = rand(T, 8, 8)
        x = rand(T, 8)
        RA = ROCArray(A)
        Rx = ROCArray(x)
        Rb = RA * Rx
        @test A*x ≈ Array(Rb)

        # View into array
        A = rand(T, 8, 8, 2)
        x = rand(T, 8, 2)
        A_d = ROCArray(A)
        x_d = ROCArray(x)
        # Perform multiplication with contiguous view with non-zero offsets
        # This ensures that the offsets are properly being passed to rocBLAS
        Ax = view(A, :, :, 2) * view(x, :, 2)
        Ax_d = view(A_d, :, :, 2) * view(x_d, :, 2)
        @test Ax ≈ Array(Ax_d)
    end
    @testset "norm" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x = rand(T, 8)
            Rx = ROCArray(x)
            nx = norm(Rx)
            @test nx ≈ norm(x)
        end
    end
end

@testset "Level 1 BLAS" begin
    @testset "scal()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            RA = ROCArray(A)
            rocBLAS.scal!(8, T(5), RA, 1)
            @test A .* 5 ≈ Array(RA)
        end
    end
    @testset "copy()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            B = rand(T, 8)
            RA = ROCArray(A)
            RB = ROCArray(B)
            rocBLAS.blascopy!(8, RA, 1, RB, 1)
            @test A ≈ Array(RA)
            @test A ≈ Array(RB)
        end
    end
    @testset "dot()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            B = rand(T, 8)
            RA = ROCArray(A)
            RB = ROCArray(B)
            result = rocBLAS.dot(8, RA, 1, RB, 1)
            @test LinearAlgebra.dot(A, B) ≈ result
        end
    end
    @testset "axpy!" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x, y = rand(T, 8), rand(T, 8)
            Rx, Ry = ROCArray(x), ROCArray(y)
            alpha = rand(T)
            axpy!(alpha, Rx, Ry)
            @test alpha * x + y ≈ Array(Ry)
        end
    end
    @testset "axpby!" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x, y = rand(T, 8), rand(T, 8)
            Rx, Ry = ROCArray(x), ROCArray(y)
            alpha, beta = rand(T), rand(T)
            axpby!(alpha, Rx, beta, Ry)
            @test alpha * x + beta * y ≈ Array(Ry)
        end
    end
    @testset "rotate!" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x, y = rand(T, 8), rand(T, 8)
            Rx, Ry = ROCArray(x), ROCArray(y)
            c, s = rand(real(T)), rand(T)
            rotate!(Rx, Ry, c, s)
            @test c * x + s * y ≈ Array(Rx)
            @test -conj(s) * x + c * y ≈ Array(Ry)
        end
    end
    @testset "reflect!" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x, y = rand(T, 8), rand(T, 8)
            Rx, Ry = ROCArray(x), ROCArray(y)
            c, s = rand(real(T)), rand(T)
            reflect!(Rx, Ry, c, s)
            @test c * x + s * y ≈ Array(Rx)
            @test conj(s) * x - c * y ≈ Array(Ry)
        end
    end
end

@testset "Level 2 BLAS" begin
    @testset "gemv()" begin
        for T in (Float32, Float64)
            A = rand(T, 8, 4)
            x = rand(T, 4)
            y = zeros(T, 8)
            RA, Rx, Ry = ROCArray.((A, x, y))
            rocBLAS.gemv!('N', T(5), RA, Rx, T(0), Ry)
            @test 5A * x ≈ Array(Ry)
        end
    end
end

@testset "Level 3 BLAS" begin
    @testset "gemm()" begin
        for T in (Float16, Float32, Float64, ComplexF32, ComplexF64)
            for at in ('N', 'T'), bt in ('N', 'T')
                A = rand(T, 4, 4)
                B = rand(T, 4, 4)
                RA = ROCArray(A)
                RB = ROCArray(B)

                RC = rocBLAS.gemm(at, bt, RA, RB)
                C =
                    (at == 'T' ? transpose(A) : A) *
                    (bt == 'T' ? transpose(B) : B)
                @test Array(RC) ≈ C
            end
        end
    end

    @testset "gemm_batched()" begin
        batch_count = 3
        for T in (Float16, Float32, Float64, ComplexF32, ComplexF64)
            for at in ('N', 'T'), bt in ('N', 'T')
                A = rand(T, 4, 4, batch_count)
                B = rand(T, 4, 4, batch_count)
                RA = ROCArray(A)
                RB = ROCArray(B)

                RC = rocBLAS.gemm_batched(at, bt, RA, RB)
                C = Array(RC)
                for i in 1:batch_count
                    c =
                        (at == 'T' ? transpose(A[:, :, i]) : A[:, :, i]) *
                        (bt == 'T' ? transpose(B[:, :, i]) : B[:, :, i])
                    @test C[:, :, i] ≈ c
                end
            end
        end
    end

    @testset "2D * 3D batched gemm" begin
        batch_count = 5

        for at in ('N', 'T'), bt in ('N', 'T')
            hA = rand(Float32, 4, 4, 1)
            hB = rand(Float32, 4, 4, batch_count)
            A, B = ROCArray(hA), ROCArray(hB)
            C = rocBLAS.gemm_batched(at, bt, A, B)
            @test size(C) == (4, 4, 5)
            hC = Array(C)
            for i in 1:batch_count
                c =
                    (at == 'T' ? transpose(hA[:, :, 1]) : hA[:, :, 1]) *
                    (bt == 'T' ? transpose(hB[:, :, i]) : hB[:, :, i])
                @test hC[:, :, i] ≈ c
            end

            hA = rand(Float32, 4, 4, batch_count)
            hB = rand(Float32, 4, 4, 1)
            A, B = ROCArray(hA), ROCArray(hB)
            C = rocBLAS.gemm_batched(at, bt, A, B)
            @test size(C) == (4, 4, 5)
            hC = Array(C)
            for i in 1:batch_count
                c =
                    (at == 'T' ? transpose(hA[:, :, i]) : hA[:, :, i]) *
                    (bt == 'T' ? transpose(hB[:, :, 1]) : hB[:, :, 1])
                @test hC[:, :, i] ≈ c
            end
        end
    end

    @testset "triangular lmul!, rmul!, ldiv!, rdiv!" begin
        for T in (Float32, Float64)
            A = triu(rand(T, 20, 20))
            B = rand(T, 20, 20)
            b = rand(T, 20)
            dA, dB, db = ROCArray(A), ROCArray(B), ROCArray(b)

            for t in (identity, transpose, adjoint),
                TR in (UpperTriangular, LowerTriangular, UnitUpperTriangular, UnitLowerTriangular)

                # Left division.
                dC = copy(dB)
                ldiv!(t(TR(dA)), dC)
                C = t(TR(A)) \ B
                @test C ≈ Array(dC)

                # Right division.
                dC = copy(dB)
                rdiv!(dC, t(TR(dA)))
                C = B / t(TR(A))
                @test C ≈ Array(dC)

                # Left division vector.
                dc = copy(db)
                ldiv!(t(TR(dA)), dc)
                c = t(TR(A)) \ b
                @test c ≈ Array(dc)

                # Left multiplication.
                dC = copy(dB)
                lmul!(t(TR(dA)), dC)
                C = t(TR(A)) * B
                @test C ≈ Array(dC)

                # Right multiplication.
                dC = copy(dB)
                rmul!(dC, t(TR(dA)))
                C = B * t(TR(A))
                @test C ≈ Array(dC)

                # Left multiplication by vector.
                dc = copy(db)
                lmul!(t(TR(dA)), dc)
                c = t(TR(A)) * b
                @test c ≈ Array(dc)
            end
        end
    end
end

end
