@testset "random" begin
# NOTE: tests should cover both pow2 and non-pow2 dims

# in-place
for (f,T) in ((rand!,Float32),
              (rand!,Cuint),
              (randn!,Float32),
              (rand_logn!,Float32),
              (rand_poisson!,Cuint)),
    d in (2, (2,2), (2,2,2), 3, (3,3), (3,3,3))
    A = ROCArray{T}(undef, d)
    fill!(A, T(0))
    f(A)
    if f !== rand_poisson!
        @test !iszero(mycollect(A))
    end
end

# out-of-place, with implicit type
for (f,T) in ((AMDGPU.rand,Float32), (AMDGPU.randn,Float32),
              (AMDGPU.rand_logn,Float32), (AMDGPU.rand_poisson,Cuint),
              (rand,Float64), (randn,Float64)),
    args in ((2,), (2, 2), (3,), (3, 3))
    A = f(args...)
    @test eltype(A) == T
end

# out-of-place, with type specified
for (f,T) in ((AMDGPU.rand,Float32), (AMDGPU.randn,Float32), (AMDGPU.rand_logn,Float32),
              (AMDGPU.rand,Float64), (AMDGPU.randn,Float64), (AMDGPU.rand_logn,Float64),
              (AMDGPU.rand_poisson,Cuint),
              (rand,Float32), (randn,Float32),
              (rand,Float64), (randn,Float64)),
    args in ((T, 2), (T, 2, 2), (T, (2, 2)), (T, 3), (T, 3, 3), (T, (3, 3)))
    A = f(args...)
    @test eltype(A) == T
end

# FIXME: Int64 support
# unsupported types that fall back to GPUArrays
for (f,T) in ((rand!,Int32),),
    d in (2, (2,2), (2,2,2), 3, (3,3), (3,3,3))
    A = ROCArray{T}(undef, d)
    fill!(A, T(0))
    f(A)
    @test !iszero(mycollect(A))
end
for (f,T) in ((AMDGPU.rand,Int32),),
    args in ((T, 2), (T, 2, 2), (T, (2, 2)), (T, 3), (T, 3, 3), (T, (3, 3)))
    A = f(args...)
    @test eltype(A) == T
end

@test_throws ErrorException randn!(ROCArray{Cuint}(undef, 10))
@test_throws ErrorException rand_logn!(ROCArray{Cuint}(undef, 10))
@test_throws ErrorException rand_poisson!(ROCArray{Float64}(undef, 10))

# seeding of both generators
AMDGPU.seed!()
AMDGPU.seed!(1)
## AMDGPU rocrand
AMDGPU.seed!(1)
a = AMDGPU.rand(Float32, 1)
AMDGPU.seed!(1)
b = AMDGPU.rand(Float32, 1)
# fixme: uncomment once mapreduce works
@test iszero(mycollect(a) - mycollect(b))
#@test all(a .== b)
## gpuarrays fallback
AMDGPU.seed!(1)
a = AMDGPU.rand(Int32, 1)
AMDGPU.seed!(1)
b = AMDGPU.rand(Int32, 1)
@test iszero(mycollect(a) - mycollect(b))
#@test all(a .== b)
end # testset
