@testset "BLAS" begin

using AMDGPU.rocBLAS
using AMDGPU.HIP
import .rocBLAS: rocblas_int

m = 20
n = 35
k = 13

handle = rocBLAS.handle()

@testset "Build Information" begin
    ver = rocBLAS.version()
    @test ver isa VersionNumber
end

@testset "Highlevel" begin
    for T in (Float32, Float64)
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
end

@testset "Level 1" begin
    @testset for T in (Float32, Float64, ComplexF32, ComplexF64)
        A = AMDGPU.rand(T, m)
        B = ROCArray{T}(undef, m)
        rocBLAS.blascopy!(m, A, 1, B, 1)
        @test Array(A) == Array(B)

        @test testf(rmul!, rand(T, 2, 3), Ref(rand()))
        @test testf(dot, rand(T, m), rand(T, m))
        @test testf(*, transpose(rand(T, m)), rand(T, m))
        @test testf(*, rand(T, m)', rand(T, m))
        @test testf(norm, rand(T, m))
        @test testf(BLAS.asum, rand(T, m))
        @test testf(axpy!, Ref(rand()), rand(T, m), rand(T, m))
        @test testf(axpby!, Ref(rand()), rand(T, m), Ref(rand()), rand(T, m))

        @test testf(rotate!, rand(T, m), rand(T, m), rand(real(T)), rand(real(T)))
        @test testf(rotate!, rand(T, m), rand(T, m), rand(real(T)), rand(T))

        @test testf(reflect!, rand(T, m), rand(T, m), rand(real(T)), rand(real(T)))
        @test testf(reflect!, rand(T, m), rand(T, m), rand(real(T)), rand(T))
    end
end

@testset "Level 2" begin
    @testset for T in (Float32, Float64, ComplexF32, ComplexF64)
        alpha, beta = rand(T), rand(T)

        @testset "gemv" begin
            @test testf(*, rand(T, m, n), rand(T, n))
            @test testf(*, transpose(rand(T, m, n)), rand(T, m))
            @test testf(*, rand(T, m, n)', rand(T, m))

            x = rand(T, m)
            A = rand(T, m, m + 1)
            y = rand(T, m)
            dx = ROCArray(x)
            dA = ROCArray(A)
            dy = ROCArray(y)
            @test_throws DimensionMismatch mul!(dy, dA, dx)

            A = rand(T, m + 1, m)
            dA = ROCArray(A)
            @test_throws DimensionMismatch mul!(dy, dA, dx)

            A = rand(T, m, n)
            x = rand(T, n)
            y = zeros(T, m)
            dA, dx, dy = ROCArray.((A, x, y))
            α = rand(T)
            rocBLAS.gemv!('N', α, dA, dx, T(0), dy)
            @test α * A * x ≈ Array(dy)
        end

        @testset "mul! y = $f(A) * x * $Ts(a) + y * $Ts(b)" for f in (
            identity, transpose, adjoint,
        ), Ts in (Int, T)
            @test testf(
                (y, a, b) -> mul!(y, f(a), b, Ts(1), Ts(2)),
                rand(T, 5), rand(T, 5, 5), rand(T, 5))
        end

        @testset "hermitian" begin
            @test testf(
                (a, b) -> Hermitian(a) * b,
                rand(T, 5, 5), rand(T, 5))
            @test testf(
                (y, a, b) -> mul!(y, Hermitian(a), b), rand(T, 5),
                rand(T, 5, 5), rand(T, 5))
        end

        A = rand(T, m, m)
        x = rand(T, m)
        @testset "Triangular mul/lmul!"  for TR in (
            UpperTriangular, LowerTriangular,
        ), f in (
            identity, adjoint, transpose,
        )
            @test testf((a, b) -> f(TR(A)) * x, A, x)
            @test testf((a, b) -> lmul!(f(TR(A)), b), A, copy(x))
        end

        A, x = rand(T, m, m), rand(T, m)
        @testset "Triangular ldiv" for TR in (
            UpperTriangular, LowerTriangular,
        ), f in (
            identity, adjoint, transpose,
        )
            @test testf((a, b) -> f(TR(A)) \ x, A, x)
            @test testf((a, b) -> ldiv!(f(TR(A)), b), A, copy(x))
        end

        @testset "inv($TR)" for TR in (
            UpperTriangular, LowerTriangular,
            UnitUpperTriangular, UnitLowerTriangular,
        )
            @test testf(x -> inv(TR(x)), rand(T, m, m))
        end
    end
end

@testset "Level 3" begin
    @testset for T in (Float16, Float32, Float64, ComplexF32, ComplexF64)
        @testset "mul! C = $f(A) *  $g(B) * $Ts(a) + C * $Ts(b)" for f in (
            identity, transpose, adjoint,
        ), g in (identity, transpose, adjoint), Ts in (Int, T)
            @test testf(
                (c, a, b) -> mul!(c, f(a), g(b), Ts(1), Ts(1)),
                rand(T, 5, 5), rand(T, 5, 5), rand(T, 5, 5))
        end
    end

    @testset for T in (Float32, Float64, ComplexF32, ComplexF64)
        @testset "hermitian" begin
            @test testf(
                (c, a, b) -> mul!(c, Hermitian(a), b),
                rand(T, 5, 5), Hermitian(rand(T, 5, 5)), rand(T, 5, 5))
        end

        @testset "trsm ($T, $adjtype, $uplotype)" for adjtype in (
            identity, adjoint, transpose,
        ), uplotype in (
            UpperTriangular, LowerTriangular,
            UnitUpperTriangular, UnitLowerTriangular,
        )
            @test testf(
                (a, b) -> adjtype(uplotype(a)) \ b,
                triu(rand(T, m, m)), rand(T, m, n))
            @test testf(
                (a, b) -> b / adjtype(uplotype(a)),
                triu(rand(T, m, m)), rand(T, n, m))
        end

        @testset "triangular-dense mul ($T, $adjtype, $uplotype)" for adjtype in (
            identity, adjoint, transpose,
        ), uplotype in (
            UpperTriangular, LowerTriangular,
            UnitUpperTriangular, UnitLowerTriangular,
        )
            A = rand(T, m, m)
            A = A + transpose(A)

            @test testf(
                (c, a, b) -> mul!(c, adjtype(uplotype(a)), b),
                zeros(T, m, n), A, rand(T, m, n))
            @test testf(
                (c, a, b) -> mul!(c, b, adjtype(uplotype(a))),
                zeros(T, n, m), A, rand(T, n, m))
        end

        @testset "triangular-triangular mul"  for (TRa, ta, TRb, tb) in (
            (UpperTriangular, identity,  LowerTriangular, identity),
            (LowerTriangular, identity,  UpperTriangular, identity),
            (UpperTriangular, identity,  UpperTriangular, transpose),
            (UpperTriangular, transpose, UpperTriangular, identity),
            (LowerTriangular, identity,  LowerTriangular, transpose),
            (LowerTriangular, transpose, LowerTriangular, identity),
        )
            A = rand(T, m, m)
            A = A + transpose(A)
            B = rand(T, m, m)
            B = B + transpose(B)

            @test testf(
                (c, a, b) -> mul!(c, ta(TRa(a)), tb(TRb(b))),
                rand(T, m, m), A, B)
        end

        @testset "Diagonal mul" begin
            @test testf(
                (c, a, b) -> mul!(c, Diagonal(a), b),
                zeros(T, m, m), rand(T, m, m), rand(T, m, m))
            @test testf(
                (c, a, b) -> mul!(c, a, Diagonal(b)),
                zeros(T, m, m), rand(T, m, m), rand(T, m, m))
        end
    end

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
end

end
