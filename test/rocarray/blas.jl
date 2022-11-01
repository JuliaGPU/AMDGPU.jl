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
        A = rand(T, 8, 8)
        x = rand(T, 8)
        RA = ROCArray(A)
        Rx = ROCArray(x)
        Rb = RA*Rx
        _b = Array(Rb)
        @test isapprox(A*x, _b)
    end
    @testset "norm" begin
        for T in (Float32, Float64, ComplexF32, ComplexF64)
            x = rand(T, 8)
            Rx = ROCArray(x)
            nx = norm(Rx)
            @test isapprox(nx, norm(x))
        end
    end
end

@testset "Level 1 BLAS" begin
    @testset "scal()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            RA = ROCArray(A)
            if T === Float32
                rocBLAS.rocblas_sscal(handle, 8, 5f0, RA, 1)
            else
                rocBLAS.rocblas_dscal(handle, 8, 5.0, RA, 1)
            end
            _A = Array(RA)
            @test isapprox(A .* 5, _A)
        end
    end
    @testset "copy()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            B = rand(T, 8)
            RA = ROCArray(A)
            RB = ROCArray(B)
            if T === Float32
                rocBLAS.rocblas_scopy(handle, 8, RA, 1, RB, 1)
            else
                rocBLAS.rocblas_dcopy(handle, 8, RA, 1, RB, 1)
            end
            _A = Array(RA)
            _B = Array(RB)
            @test isapprox(A, _A)
            @test isapprox(A, _B)
        end
    end
    @testset "dot()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            B = rand(T, 8)
            result = zeros(T, 8)
            RA = ROCArray(A)
            RB = ROCArray(B)
            result = Ref{T}(zero(T))
            if T === Float32
                rocBLAS.rocblas_sdot(handle, 8, RA, 1, RB, 1, result)
            else
                rocBLAS.rocblas_ddot(handle, 8, RA, 1, RB, 1, result)
            end
            @test isapprox(LinearAlgebra.dot(A,B), result[])
        end
    end
    @testset "swap()" begin
        for T in (Float32, Float64)
            A = rand(T, 8)
            B = rand(T, 8)
            result = zeros(T, 8)
            RA = ROCArray(A)
            RB = ROCArray(B)
            if T === Float32
                rocBLAS.rocblas_sswap(handle, 8, RA, 1, RB, 1)
            else
                rocBLAS.rocblas_dswap(handle, 8, RA, 1, RB, 1)
            end
            _A = Array(RA)
            _B = Array(RB)
            @test isapprox(A, _B)
            @test isapprox(B, _A)
        end
    end
end

@testset "Level 2 BLAS" begin
    @testset "gemv()" begin
        for T in (Float32, Float64)
            A = rand(T, 8, 4)
            RA = ROCArray(A)
            x = rand(T, 4)
            Rx = ROCArray(x)
            y = zeros(T, 8)
            Ry = ROCArray(y)
            op = rocBLAS.ROCBLAS_OPERATION_NONE
            m, n = rocblas_int.(size(A))
            lda = m
            incx = incy = Int32(1)
            if T === Float32
                rocBLAS.rocblas_sgemv(handle, op, m, n, 5f0, RA, lda, Rx, incx, 0f0, Ry, incy)
            else
                rocBLAS.rocblas_dgemv(handle, op, m, n, 5.0, RA, lda, Rx, incx, 0.0, Ry, incy)
            end
            _A = Array(RA)
            _x = Array(Rx)
            _y = Array(Ry)
            @test isapprox(5A * x, _y)
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
        for T in (Float16, Float32, Float64, ComplexF32, ComplexF64)
            for at in ('N', 'T'), bt in ('N', 'T')
                batch_count = 3
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
end

end # testse BLAS
