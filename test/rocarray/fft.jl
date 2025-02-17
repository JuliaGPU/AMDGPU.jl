@testset "FFT" begin

using AMDGPU.rocFFT
using FFTW

N1 = 8
N2 = 32
N3 = 64
N4 = 8

MYRTOL = 1e-5
MYATOL = 1e-8

## complex

function out_of_place(X::AbstractArray{T,N}) where {T <: Complex,N}
    fftw_X = fft(X)

    dX = ROCArray(X)
    p = plan_fft(dX)
    dY = p * dX
    @test isapprox(collect(dY), fftw_X; rtol=MYRTOL, atol=MYATOL)
    @test X ≈ collect(dX)

    Y = collect(dY)
    pinv = plan_ifft(dY)
    dZ = pinv * dY
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)
    @test Y ≈ collect(dY)

    pinv2 = inv(p)
    dZ = pinv2 * dY
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)
end

function in_place(X::AbstractArray{T,N}) where {T <: Complex,N}
    fftw_X = fft(X)

    dX = ROCArray(X)
    p = plan_fft!(dX)
    p * dX
    @test isapprox(collect(dX), fftw_X; rtol=MYRTOL, atol=MYATOL)

    pinv = plan_ifft!(dX)
    pinv * dX
    @test isapprox(collect(dX), X; rtol=MYRTOL, atol=MYATOL)
end

function batched(X::AbstractArray{T,N}, region) where {T <: Complex,N}
    fftw_X = fft(X, region)

    dX = ROCArray(X)
    p = plan_fft!(dX, region)
    p * dX
    @test isapprox(collect(dX), fftw_X; rtol=MYRTOL, atol=MYATOL)

    pinv = plan_ifft!(dX, region)
    pinv * dX
    @test isapprox(collect(dX), X; rtol=MYRTOL, atol=MYATOL)
end

function fftwrapper(X::AbstractArray{T}) where {T <: Complex}
    fftw_X = fft(X)

    dX = ROCArray(X)
    dY = fft(dX)
    @test typeof(dY) <: ROCArray
    @test isapprox(collect(dY), fftw_X; rtol=MYRTOL, atol=MYATOL)

    dZ = ifft(dY)
    @test typeof(dZ) <: ROCArray
    @test isapprox(collect(dZ), X, rtol=MYRTOL, atol=MYATOL)

    fft!(dX)
    @test isapprox(collect(dX), fftw_X; rtol=MYRTOL, atol=MYATOL)

    ifft!(dX)
    @test isapprox(collect(dX), X; rtol=MYRTOL, atol=MYATOL)
end

@testset for T in [ComplexF32, ComplexF64]
    @testset "1D" begin
        dims = (N1,)
        X = rand(T, dims)
        out_of_place(X)
    end

    @testset "1D inplace" begin
        dims = (N1,)
        X = rand(T, dims)
        in_place(X)
    end

    @testset "2D" begin
        dims = (N1,N2)
        X = rand(T, dims)
        out_of_place(X)
    end

    @testset "2D inplace" begin
        dims = (N1,N2)
        X = rand(T, dims)
        in_place(X)
    end

    @testset "Batch 1D" begin
        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, 1)

        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, 2)

        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, (1, 2))
    end

    @testset "3D" begin
        dims = (N1,N2,N3)
        X = rand(T, dims)
        out_of_place(X)
    end

    @testset "3D inplace" begin
        dims = (N1,N2,N3)
        X = rand(T, dims)
        in_place(X)
    end

    @testset "Batch 2D (in 3D)" begin
        dims = (N1, N2, N3)
        # for region in [(1, 2), (2, 3), (1, 3)]
        for region in [(1, 2), (2, 3)]
            X = rand(T, dims)
            batched(X, region)
        end

        X = rand(T, dims)
        @test_throws ArgumentError batched(X, (3, 1))
    end

    @testset "Batch 2D (in 4D)" begin
        dims = (N1, N2, N3, N4)
        # TODO for (1, 4) workarea allocates too much memory?
        # for region in [(1, 2), (3, 4), (1, 4)]
        for region in [(1, 2), (3, 4),]
            X = rand(T, dims)
            batched(X, region)
        end
        for region in [(1, 3), (2, 3), (2, 4)]
            X = rand(T, dims)
            @test_throws ArgumentError batched(X, region)
        end
    end

    @testset "FFT Wrappers" begin
        X = rand(T, N1)
        fftwrapper(X)

        X = rand(T, N1, N2)
        fftwrapper(X)

        X = rand(T, N1, N2, N3)
        fftwrapper(X)
    end
end

## real

function out_of_place(X::AbstractArray{T,N}) where {T <: Real,N}
    fftw_X = rfft(X)
    dX = ROCArray(X)

    p = plan_rfft(dX)
    dY = p * dX
    Y = collect(dY)
    @test isapprox(Y, fftw_X; rtol=MYRTOL, atol=MYATOL)
    @test X ≈ collect(dX)

    pinv = plan_irfft(dY, size(X, 1))
    dZ = pinv * dY
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)
    @test Y ≈ collect(dY)

    pinv2 = inv(p)
    dZ = pinv2 * dY
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)

    pinv3 = inv(pinv)
    dW = pinv3 * dX
    @test isapprox(collect(dW), Y; rtol=MYRTOL, atol=MYATOL)
end

function batched(X::AbstractArray{T,N},region) where {T <: Real,N}
    fftw_X = rfft(X,region)
    dX = ROCArray(X)

    p = plan_rfft(dX, region)
    dY = p * dX
    @test isapprox(collect(dY), fftw_X; rtol=MYRTOL, atol=MYATOL)
    @test X ≈ collect(dX)

    Y = collect(dY)
    pinv = plan_irfft(dY, size(X, region[1]), region)
    dZ = pinv * dY
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)
    @test Y ≈ collect(dY)
end

function fftwrapper(X::AbstractArray{T}) where {T <: Real}
    fftw_X = rfft(X)
    dX = ROCArray(X)

    dY = rfft(dX)
    @test typeof(dY) <: ROCArray
    @test isapprox(collect(dY), fftw_X; rtol=MYRTOL, atol=MYATOL)

    @test_throws MethodError irfft(dY)
    dZ = irfft(dY, size(X, 1))
    @test typeof(dZ) <: ROCArray
    @test isapprox(collect(dZ), X; rtol=MYRTOL, atol=MYATOL)
end

@testset for T in [Float32, Float64]
    @testset "1D" begin
        X = rand(T, N1)
        out_of_place(X)
    end

    @testset "2D" begin
        X = rand(T, N1, N2)
        out_of_place(X)
    end

    @testset "Batch 1D" begin
        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, 1)

        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, 2)

        dims = (N1, N2)
        X = rand(T, dims)
        batched(X, (1, 2))
    end

    @testset "3D" begin
        X = rand(T, N1, N2, N3)
        out_of_place(X)
    end

    @testset "Batch 2D (in 3D)" begin
        dims = (N1, N2, N3)
        # TODO non-contiguous inverse not working
        # for region in [(1, 2), (2, 3), (1, 3)]
        for region in [(1, 2), (2, 3)]
            X = rand(T, dims)
            batched(X, region)
        end

        X = rand(T, dims)
        @test_throws ArgumentError batched(X, (3, 1))
    end

    @testset "Batch 2D (in 4D)" begin
        dims = (N1, N2, N3, N4)
        # for region in [(1, 2), (1, 4), (3, 4)]
        for region in [(1, 2), (3, 4)]
            X = rand(T, dims)
            batched(X, region)
        end
        for region in [(1, 3), (2, 4)]
            X = rand(T, dims)
            @test_throws ArgumentError batched(X, region)
        end
    end

    @testset "FFT Wrappers" begin
        X = rand(T, N1)
        fftwrapper(X)

        X = rand(T, N1, N2)
        fftwrapper(X)

        X = rand(T, N1, N2, N3)
        fftwrapper(X)
    end
end

@testset "FFT with view" begin
    for T in (ComplexF32, ComplexF64)
        X = rand(T, 128, 128, 2)
        X_d = ROCArray(X)

        # Perform fft with contiguous view with non-zero offsets
        # This ensures that the offsets are properly being passed to rocFFT
        fft!(view(X, :, :, 2))
        fft!(view(X_d, :, :, 2))

        @test isapprox(X, Array(X_d))
    end
end

@testset "Promoted types" begin
    @testset for T in (Float32, Float64)
        X = rand(T, 10, 10)
        d_X = ROCArray(X)

        Y = fft(X)
        d_Y = fft(d_X)
        @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)

        Y = ifft(X)
        d_Y = ifft(d_X)
        @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)
    end

    @testset "Complex{Int}" begin
        X = rand(Complex{Int}, 10, 10)
        d_X = ROCArray(X)

        Y = fft(X)
        d_Y = fft(d_X)
        @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)

        Y = ifft(X)
        d_Y = ifft(d_X)
        @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)
    end

    @testset "Int" begin
        X = rand(Int, 10, 10)
        d_X = ROCArray(X)

        Y = rfft(X)
        d_Y = rfft(d_X)
        @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)
    end
end

@testset "Asynchronous" begin
    X = rand(Float32, 10, 10)
    d_X = ROCArray(X)

    p = plan_rfft(X)
    d_p = plan_rfft(d_X)

    Y = p * X

    task = Threads.@spawn d_p * d_X  # executes FFT on separate AMDGPU stream
    d_Y = fetch(task)

    @test isapprox(collect(d_Y), Y; rtol=MYRTOL, atol=MYATOL)
end

end # testset FFT
