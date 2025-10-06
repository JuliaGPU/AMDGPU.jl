@testset "BLAS" begin

using AMDGPU.rocBLAS
using AMDGPU.HIP
import .rocBLAS: rocblas_int, bandex, band

m = 20
n = 35
k = 13

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

    @testset "Strided matmul" begin
        for T in (Float16, Float32, Float64, ComplexF32, ComplexF64)
            x = AMDGPU.rand(T, 10, 10)
            v1 = @view(x[:, 1:5])
            v2 = @view(x[1:5, :])
            @test Array(v1) * Array(v2) ≈ Array(v1 * v2)
        end
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
        @test testf(axpy!, Ref(rand()), rand(T, m), 1:m-1, rand(T, m), 1:m-1)
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
            A = rand(T, m, n)
            x = rand(T, n)
            dA, dx = ROCArray.((A, x))
            dy = rocBLAS.gemv('N', α, dA, dx)
            @test α * A * x ≈ Array(dy)
            dy = rocBLAS.gemv('N', dA, dx)
            @test A * x ≈ Array(dy)
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
            
            A_ = rand(T, m, m)
            A = A_ + A_'
            x = rand(T, m)
            y = zeros(T, m)
            dA, dx, dy = ROCArray.((A, x, y))
            α = rand(T)
            if T <: Real
                rocBLAS.symv!('U', α, dA, dx, T(0), dy)
                @test α * A * x ≈ Array(dy)
                dy = rocBLAS.symv('U', α, dA, dx)
                @test α * A * x ≈ Array(dy)
                dy = rocBLAS.symv('U', dA, dx)
                @test A * x ≈ Array(dy)
            else
                rocBLAS.hemv!('U', α, dA, dx, T(0), dy)
                @test α * A * x ≈ Array(dy)
                dy = rocBLAS.hemv('U', α, dA, dx)
                @test α * A * x ≈ Array(dy)
                dy = rocBLAS.hemv('U', dA, dx)
                @test A * x ≈ Array(dy)
            end
        end

        A = rand(T, m, m)
        x = rand(T, m)
        @testset "Triangular mul/lmul!" for TR in (
            UpperTriangular, LowerTriangular,
        ), f in (
            identity, adjoint, transpose,
        )
            @test testf((a, b) -> f(TR(a)) * b, A, x)
            @test testf((a, b) -> lmul!(f(TR(a)), b), A, copy(x))
        end
        @testset "trmv" begin
            A  = rand(T, m, m)
            dA = ROCArray(A)
            x  = rand(T, m)
            dx = ROCArray(x)
            dy = rocBLAS.trmv('U', 'N', 'N', dA, dx)
            @test collect(dy) ≈ triu(A) * x
        end

        A, x = rand(T, m, m), rand(T, m)
        @testset "Triangular ldiv" for TR in (
            UpperTriangular, LowerTriangular,
        ), f in (
            identity, adjoint, transpose,
        )
            @test testf((a, b) -> f(TR(a)) \ b, A, x)
            @test testf((a, b) -> ldiv!(f(TR(a)), b), A, copy(x))
        end
        @testset "trsv" begin
            A  = rand(T, m, m)
            dA = ROCArray(A)
            x  = rand(T, m)
            dx = ROCArray(x)
            dy = rocBLAS.trsv('U', 'N', 'N', dA, dx)
            @test collect(dy) ≈ triu(A) \ x
        end

        x = rand(T, m, m)
        @testset "inv($TR)" for TR in (
            UpperTriangular, LowerTriangular,
            UnitUpperTriangular, UnitLowerTriangular,
            Diagonal,
        )
            @test testf(a -> inv(TR(a)), x)
        end

        @testset "ger!" begin
            A  = rand(T, m, m)
            x  = rand(T, m)
            y  = rand(T, m)
            dA = ROCArray(A)
            dx = ROCArray(x)
            dy = ROCArray(y)
            # perform rank one update
            dB = copy(dA)
            rocBLAS.ger!(alpha,dx,dy,dB)
            B  = (alpha*x)*y' + A
            # move to host and compare
            hB = Array(dB)
            @test B ≈ hB
        end

        @testset "syr!" begin
            sA = rand(T, m, m)
            sA = sA + transpose(sA)
            x  = rand(T,m)
            dx = ROCArray(x)
            dB = ROCArray(sA)
            rocBLAS.syr!('U',alpha,dx,dB)
            B  = (alpha*x)*transpose(x) + sA
            # move to host and compare upper triangles
            hB = Array(dB)
            B  = triu(B)
            hB = triu(hB)
            @test B ≈ hB
        end

        if T <: Complex
            @testset "her" begin
                hA = rand(T,m,m)
                hA = hA + adjoint(hA)
                dB = ROCArray(hA)
                x  = rand(T,m)
                dx = ROCArray(x)
                # perform rank one update
                rocBLAS.her!('U',real(alpha),dx,dB)
                B = (real(alpha)*x)*x' + hA
                # move to host and compare upper triangles
                hB = Array(dB)
                B  = triu(B)
                hB = triu(hB)
                @test B ≈ hB
            end
            @testset "her2!" begin
                hA = rand(T,m,m)
                hA = hA + adjoint(hA)
                x  = rand(T, m)
                y  = rand(T,m)
                dB = ROCArray(hA)
                dx = ROCArray(x)
                dy = ROCArray(y)
                rocBLAS.her2!('U',alpha,dx,dy,dB)
                B = (alpha*x)*y' + y*(alpha*x)' + hA
                # move to host and compare upper triangles
                hB = Array(dB)
                B  = triu(B)
                hB = triu(hB)
                @test B ≈ hB
            end
        end
        @testset "Banded methods" begin
            ku = 3
            kl = 4
            A  = rand(T, m, n) # generate banded matrix
            A  = bandex(A, kl, ku)
            Ab = band(A, kl, ku) # get packed format
            d_Ab = ROCArray(Ab)
            x    = rand(T, n)
            d_x  = ROCArray(x)
            alpha = rand(T)
            beta  = rand(T)
            y     = rand(T, m)
            d_y   = ROCArray(y)
            @testset "gbmv!" begin
                @testset for (op, da1, da2, ha1, ha2)  in (('N',d_x,d_y,x,y), ('T',d_y,d_x,y,x), ('C',d_y,d_x,y,x))
                    # test y = alpha*A*x + beta*y
                    rocBLAS.gbmv!(op,m,kl,ku,alpha,d_Ab,da1,beta,da2)
                    BLAS.gbmv!(op,m,kl,ku,alpha,Ab,ha1,beta,ha2)
                    @test ha2 ≈ Array(da2)
                    d_y = ROCArray(y)
                end
            end
            @testset "gbmv" begin
                d_x = ROCArray(x)
                d_y = rocBLAS.gbmv('N',m,kl,ku,alpha,d_Ab,d_x)
                y   = BLAS.gbmv('N',m,kl,ku,alpha,Ab,x)
                @test y ≈ Array(d_y)
                # test alpha=1 version without y
                d_y = rocBLAS.gbmv('N',m,kl,ku,d_Ab,d_x)
                y   = BLAS.gbmv('N',m,kl,ku,Ab,x)
                @test y ≈ Array(d_y)
            end
            A = rand(T, m, m)
            A = A + A'
            nbands = 3
            @test m >= 1 + nbands
            A = bandex(A,nbands,nbands)
            # convert to 'upper' banded storage format
            AB = band(A, 0, nbands)
            # construct x
            x    = rand(T, m)
            d_AB = ROCArray(AB)
            d_x  = ROCArray(x)
            y    = rand(T, m)
            if T <: Real
                @testset "sbmv!" begin
                    d_y = ROCArray(y)
                    rocBLAS.sbmv!('U',nbands,alpha,d_AB,d_x,beta,d_y)
                    @test alpha*(A*x) + beta*y ≈ Array(d_y)
                end
                @testset "sbmv" begin
                    d_y = rocBLAS.sbmv('U',nbands,d_AB,d_x)
                    @test A*x ≈ Array(d_y)
                end
            else
                @testset "hbmv!" begin
                    d_y = ROCArray(y)
                    rocBLAS.hbmv!('U',nbands,alpha,d_AB,d_x,beta,d_y)
                    @test alpha*(A*x) + beta*y ≈ Array(d_y)
                end
                @testset "hbmv" begin
                    d_y = rocBLAS.hbmv('U',nbands,d_AB,d_x)
                    @test A*x ≈ Array(d_y)
                end
            end
            # generate banded triangular matrix
            A    = rand(T, m, m)
            nbands = 3 # restrict to 3 bands
            @test m >= 1 + nbands
            A    = bandex(A,0,nbands)
            AB   = band(A,0,nbands)
            d_AB = ROCArray(AB)
            @testset "tbmv!" begin
                d_y = ROCArray(y)
                rocBLAS.tbmv!('U','N','N',nbands,d_AB,d_y)
                @test A*y ≈ Array(d_y)
            end
            @testset "tbmv" begin
                d_y = rocBLAS.tbmv('U','N','N',nbands,d_AB,d_x)
                @test A*x ≈ Array(d_y)
            end
            @testset "tbsv!" begin
                d_y = copy(d_x)
                rocBLAS.tbsv!('U','N','N',nbands,d_AB,d_y)
                @test A\x ≈ Array(d_y)
            end
            @testset "tbsv" begin
                d_y = rocBLAS.tbsv('U','N','N',nbands,d_AB,d_x)
                @test A\x ≈ Array(d_y)
            end
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
            A_ = rand(T, m, m)
            A = A_ + A_'
            B = rand(T, m, n)
            dA, dB = ROCArray.((A, B))
            α = rand(T)
            if T <: Real
                dC = rocBLAS.symm('L', 'U', α, dA, dB)
                @test α * A * B ≈ Array(dC)
                dC = rocBLAS.symm('L', 'U', dA, dB)
                @test A * B ≈ Array(dC)
            else
                dC = rocBLAS.hemm('L', 'U', α, dA, dB)
                @test α * A * B ≈ Array(dC)
                dC = rocBLAS.hemm('L', 'U', dA, dB)
                @test A * B ≈ Array(dC)
            end
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
        @testset "trsm" begin
            A  = rand(T, m, m)
            dA = ROCArray(A)
            B  = rand(T, m, m)
            dB = ROCArray(B)
            dC = rocBLAS.trsm('L', 'U', 'N', 'N', one(T), dA, dB)
            @test collect(dC) ≈ triu(A) \ B
        end
        @testset "trsm_batched" begin
            batch_count = 3
            A  = [rand(T, m, m) for ix in 1:batch_count]
            dA = [ROCArray(A_) for A_ in A]
            B  = [rand(T, m, m) for ix in 1:batch_count]
            dB = [ROCArray(B_) for B_ in B]
            dC = rocBLAS.trsm_batched('L', 'U', 'N', 'N', one(T), dA, dB)
            for ix in 1:batch_count
                @test collect(dC[ix]) ≈ triu(A[ix]) \ B[ix]
            end
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
        @testset "trmm" begin
            A  = rand(T, m, m)
            dA = ROCArray(A)
            B  = rand(T, m, m)
            dB = ROCArray(B)
            dC = rocBLAS.trmm('L', 'U', 'N', 'N', one(T), dA, dB)
            @test collect(dC) ≈ triu(A) * B
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
                A = [rand(T, 4, 4) for ix in 1:batch_count]
                B = [rand(T, 4, 4) for ix in 1:batch_count]
                RA = [ROCArray(A_) for A_ in A]
                RB = [ROCArray(B_) for B_ in B]

                RC = rocBLAS.gemm_batched(at, bt, RA, RB)
                @test length(RC) == batch_count
                C  = [Array(RC_) for RC_ in RC]
                for i in 1:batch_count
                    c =
                    (at == 'T' ? transpose(A[i]) : A[i]) *
                    (bt == 'T' ? transpose(B[i]) : B[i])
                    @test C[i] ≈ c
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
    @testset "syrk T=$T" for T in (Float32, Float64, ComplexF32, ComplexF64)
        # generate parameters
        α = rand(T)
        β = rand(T)
        A = rand(T, m, m)
        Abad = rand(T, m + 1, m + 1)
        C = rand(T, m, m)
        # move to device
        d_A, d_Abad = ROCArray(A), ROCArray(Abad)
        C   = C + transpose(C)
        d_C = ROCArray(C)
        C   = α*(A*transpose(A)) + β*C
        rocBLAS.syrk!('U','N',α,d_A,β,d_C)
        # move back to host and compare
        C   = triu(C)
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
        @test_throws DimensionMismatch rocBLAS.syrk!('U','N',α,d_Abad,β,d_C)

        d_C = rocBLAS.syrk('U','N',d_A)
        C   = triu(A*transpose(A))
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
    end
    @testset "syr2k T=$T" for T in (Float32, Float64, ComplexF32, ComplexF64)
        # generate parameters
        α = rand(T)
        β = rand(T)
        A = rand(T, m, k)
        B = rand(T, m, k)
        Bbad = rand(T, m + 1, k + 1)
        C = rand(T, m, m)
        # move to device
        d_A, d_B, d_Bbad = ROCArray(A), ROCArray(B), ROCArray(Bbad)
        C = C + transpose(C)
        d_C = ROCArray(C)
        C = α*(A*transpose(B) + B*transpose(A)) + β*C
        rocBLAS.syr2k!('U','N',α,d_A,d_B,β,d_C)
        # move back to host and compare
        C   = triu(C)
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
        @test_throws DimensionMismatch rocBLAS.syr2k!('U','N',α,d_A,d_Bbad,β,d_C)
        Bbad   = rand(T, m, k + 1)
        d_Bbad = ROCArray(Bbad)
        @test_throws DimensionMismatch rocBLAS.syr2k!('U','N',α,d_A,d_Bbad,β,d_C)

        d_C = rocBLAS.syr2k('U','N',d_A,d_B)
        C   = triu((A*transpose(B)) + (B*transpose(A)))
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
    end
    @testset "herk T=$T" for T in (ComplexF32, ComplexF64)
        T1 = T 
        T2 = real(T)
        # generate parameters
        α = rand(T2)
        β = rand(T2)
        A = rand(T, m, m)
        Abad = rand(T, m + 1, m + 1)
        C = rand(T, m, m)
        # move to device
        d_A, d_Abad = ROCArray(A), ROCArray(Abad)
        C   = C + C'
        d_C = ROCArray(C)
        C   = α*(A*A') + β*C
        rocBLAS.herk!('U','N',α,d_A,β,d_C)
        # move back to host and compare
        C   = triu(C)
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
        @test_throws DimensionMismatch rocBLAS.herk!('U','N',α,d_Abad,β,d_C)

        d_C = rocBLAS.herk('U','N',d_A)
        C   = triu(A*A')
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
    end
    @testset "her2k T=$T" for T in (ComplexF32, ComplexF64)
        T1 = T 
        T2 = real(T)
        # generate parameters
        α = rand(T1)
        β = rand(T2)
        A = rand(T, m, k)
        B = rand(T, m, k)
        Bbad = rand(T, m + 1, k + 1)
        C = rand(T, m, m)
        # move to device
        d_A, d_B, d_Bbad = ROCArray(A), ROCArray(B), ROCArray(Bbad)
        C = C + C'
        d_C = ROCArray(C)
        C = α*(A*B') + conj(α)*(B*A') + β*C
        rocBLAS.her2k!('U','N',α,d_A,d_B,β,d_C)
        # move back to host and compare
        C   = triu(C)
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
        @test_throws DimensionMismatch rocBLAS.her2k!('U','N',α,d_A,d_Bbad,β,d_C)
        Bbad   = rand(T, m, k + 1)
        d_Bbad = ROCArray(Bbad)
        @test_throws DimensionMismatch rocBLAS.her2k!('U','N',α,d_A,d_Bbad,β,d_C)

        d_C = rocBLAS.her2k('U','N',d_A,d_B)
        C   = triu((A*B') + (B*A'))
        h_C = Array(d_C)
        h_C = triu(h_C)
        @test C ≈ h_C
    end
end

@testset "Extension" begin
    for TA in (Float32, Float64, ComplexF32, ComplexF64), TB in (Float32, Float64)
        x    = rand(TB, m)
        d_x  = ROCArray(x)
        XA   = rand(TA, m, n)
        d_XA = ROCArray(XA)
        d_X  = Diagonal(d_x)
        lmul!(d_X, d_XA)
        @test Array(d_XA) ≈ Diagonal(x) * XA

        x    = rand(TB, m)
        d_x  = ROCArray(x)
        XA   = rand(TA, n, m)
        d_AX = transpose(ROCArray(XA))
        d_X  = Diagonal(d_x)
        lmul!(d_X, d_AX)
        @test Array(d_AX) ≈ Diagonal(x) * transpose(XA)

        x    = rand(TB, m)
        d_x  = ROCArray(x)
        XA   = rand(TA, n, m)
        d_AX = adjoint(ROCArray(XA))
        d_X  = Diagonal(d_x)
        lmul!(d_X, d_AX)
        @test Array(d_AX) ≈ Diagonal(x) * adjoint(XA)

        y    = rand(TB, n)
        d_y  = ROCArray(y)
        AY   = rand(TA, m, n)
        d_AY = ROCArray(AY)
        d_Y  = Diagonal(d_y)
        rmul!(d_AY, d_Y)
        @test Array(d_AY) ≈ AY * Diagonal(y)

        y    = rand(TB, n)
        d_y  = ROCArray(y)
        AY   = rand(TA, n, m)
        d_YA = transpose(ROCArray(AY))
        d_Y  = Diagonal(d_y)
        d_YA = rmul!(d_YA, d_Y)
        @test Array(d_YA) ≈ transpose(AY) * Diagonal(y)

        y    = rand(TB, n)
        d_y  = ROCArray(y)
        AY   = rand(TA, n, m)
        d_YA = adjoint(ROCArray(AY))
        d_Y  = Diagonal(d_y)
        d_YA = rmul!(d_YA, d_Y)
        @test Array(d_YA) ≈ adjoint(AY) * Diagonal(y)
    end
    @testset "geam" begin
        m = 4
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            for at in ('N', 'T'), bt in ('N', 'T')
                A = rand(T, m, m)
                B = rand(T, m, m)
                RA = ROCArray(A)
                RB = ROCArray(B)
                α = rand(T)
                β = rand(T)
                RC = rocBLAS.geam(at, bt, α, RA, β, RB)
                C =
                    α * (at == 'T' ? transpose(A) : A) +
                    β * (bt == 'T' ? transpose(B) : B)
                @test Array(RC) ≈ C
            end
        end
    end

end

end
