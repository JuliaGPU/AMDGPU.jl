@testset "FFT" begin

using AMDGPU.rocFFT
using AMDGPU.HIP
using FFTW

N1 = 8
N2 = 32
N3 = 64
N4 = 8

MYRTOL = 1e-5
MYATOL = 1e-8

function mycollect(x::ROCArray{T,N}) where {T,N}
    # need to synchronize otherwise division during inverse transformation not applied
    #= HIP.hipStreamSynchronize(Ptr{Cvoid}(UInt64(0))) =#
    HIP.hipDeviceSynchronize()
    collect(x)
end

## complex

function out_of_place(X::AbstractArray{T,N}) where {T <: Complex,N}
    fftw_X = fft(X)
    d_X = ROCArray{T}(undef, size(X))
    copyto!(d_X, X)
    p = plan_fft(d_X)
    Y = zeros(T, p.osz)
    d_Y = p * d_X;
    Y = mycollect(d_Y)
    @test isapprox(Y, fftw_X, rtol = MYRTOL, atol = MYATOL)

    pinv = plan_ifft(d_Y)
    d_Z = pinv * d_Y
    Z = mycollect(d_Z)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)

    pinv2 = inv(p)
    d_Z = pinv2 * d_Y
    Z = mycollect(d_Z)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)
end

function in_place(X::AbstractArray{T,N}) where {T <: Complex,N}
    fftw_X = fft(X)
    d_X = ROCArray{T}(undef, size(X))
    copyto!(d_X, X)
    p = plan_fft!(d_X)
    p * d_X
    Y = mycollect(d_X)
    @test isapprox(Y, fftw_X, rtol = MYRTOL, atol = MYATOL)

    pinv = plan_ifft!(d_X)
    pinv * d_X
    Z = mycollect(d_X)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)
end

function batched(X::AbstractArray{T,N},region) where {T <: Complex,N}
    fftw_X = fft(X,region)
    d_X = ROCArray{T}(undef, size(X))
    copyto!(d_X, X)
    p = plan_fft!(d_X,region)
    p * d_X
    Y = mycollect(d_X)
    @test isapprox(Y, fftw_X, rtol = MYRTOL, atol = MYATOL)

    pinv = plan_ifft!(d_X,region)
    pinv * d_X
    Z = mycollect(d_X)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)
end


@testset for T in [ComplexF64, ComplexF32]

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
    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,1)

    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,2)

    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,(1,2))
end

# Broken upstream rocFFT#270
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
    dims = (N1,N2,N3)
    for region in [(1,2),(2,3),(1,3)]
        X = rand(T, dims)
        batched(X,region)
    end

    X = rand(T, dims)
    @test_throws ArgumentError batched(X,(3,1))
end

@testset "Batch 2D (in 4D)" begin
    dims = (N1,N2,N3,N4)
    # for (1,4) workarea allocates to much memory?
    for region in [(1,2),(3,4),(1,4)]
        X = rand(T, dims)
        batched(X,region)
    end
    for region in [(1,3),(2,3),(2,4)]
        X = rand(T, dims)
        @test_throws ArgumentError batched(X,region)
    end

end

end # testset Complex


## real

function out_of_place(X::AbstractArray{T,N}) where {T <: Real,N}
    fftw_X = rfft(X)
    d_X = ROCArray{T}(undef, size(X))
    copyto!(d_X, X)
    p = plan_rfft(d_X)
    d_Y = p * d_X
    Y = mycollect(d_Y)
    @test isapprox(Y, fftw_X, rtol = MYRTOL, atol = MYATOL)

    pinv = plan_irfft(d_Y,size(X,1))
    d_Z = pinv * d_Y
    Z = mycollect(d_Z)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)

    pinv2 = inv(p)
    d_Z = pinv2 * d_Y
    Z = mycollect(d_Z)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)

    pinv3 = inv(pinv)
    d_W = pinv3 * d_X
    W = mycollect(d_W)
    @test isapprox(W, Y, rtol = MYRTOL, atol = MYATOL)
end

function batched(X::AbstractArray{T,N},region) where {T <: Real,N}
    fftw_X = rfft(X,region)
    d_X = ROCArray{T}(undef, size(X))
    copyto!(d_X, X)
    p = plan_rfft(d_X,region)
    d_Y = p * d_X
    Y = mycollect(d_Y)
    @test isapprox(Y, fftw_X, rtol = MYRTOL, atol = MYATOL)

    pinv = plan_irfft(d_Y,size(X,region[1]),region)
    d_Z = pinv * d_Y
    Z = mycollect(d_Z)
    @test isapprox(Z, X, rtol = MYRTOL, atol = MYATOL)
end


@testset for T in [Float32, Float64]

@testset "1D" begin
    X = rand(T, N1)
    out_of_place(X)
end

# still broken? rocFFT#128
@testset "2D" begin
    X = rand(T, N1,N2)
    out_of_place(X)
end

@testset "Batch 1D" begin
    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,1)

    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,2)

    dims = (N1,N2)
    X = rand(T, dims)
    batched(X,(1,2))
end

@testset "3D" begin
    X = rand(T, N1, N2, N3)
    out_of_place(X)
end

@testset "Batch 2D (in 3D)" begin
    dims = (N1,N2,N3)
    for region in [(1,2),(2,3),(1,3)]
        X = rand(T, dims)
        @test_skip batched(X,region)
    end

    X = rand(T, dims)
    @test_throws ArgumentError batched(X,(3,1))
end

@testset "Batch 2D (in 4D)" begin
    dims = (N1,N2,N3,N4)
    for region in [(1,2),(1,4),(3,4)]
        X = rand(T, dims)
        @test_skip batched(X,region)
    end
    for region in [(1,3),(2,3),(2,4)]
        X = rand(T, dims)
        @test_throws ArgumentError batched(X,region)
    end
end

end
end # testset FFT
