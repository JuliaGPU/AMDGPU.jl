# NOTE: tests should cover both pow2 and non-pow2 dims

# in-place
for (f,T) in ((rand!,Float32),
              (rand!,Cuint),
              (randn!,Float32),
              (rand_logn!,Float32),
              (rand_poisson!,Cuint)),
    d in (2, (2,2), (2,2,2), 3, (3,3), (3,3,3))
    A = ROCArray{T}(undef, d)
    f(A)
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

#=
# unsupported types that fall back to GPUArrays
for (f,T) in ((AMDGPU.rand,Int64),),
    args in ((T, 2), (T, 2, 2), (T, (2, 2)), (T, 3), (T, 3, 3), (T, (3, 3)))
    A = f(args...)
    @test eltype(A) == T
end
for (f,T) in ((rand!,Int64),),
    d in (2, (2,2), (2,2,2), 3, (3,3), (3,3,3))
    A = ROCArray{T}(undef, d)
    f(A)
end

@test_throws ErrorException randn!(ROCArray{Cuint}(undef, 10))
@test_throws ErrorException rand_logn!(ROCArray{Cuint}(undef, 10))
@test_throws ErrorException rand_poisson!(ROCArray{Float64}(undef, 10))

# seeding of both generators
AMDGPU.seed!()
AMDGPU.seed!(1)
## AMDGPU CURAND
AMDGPU.seed!(1)
A = AMDGPU.rand(Float32, 1)
AMDGPU.seed!(1)
B = AMDGPU.rand(Float32, 1)
@test all(A .== B)
## GPUArrays fallback
AMDGPU.seed!(1)
A = AMDGPU.rand(Int64, 1)
AMDGPU.seed!(1)
B = AMDGPU.rand(Int64, 1)
@test all(A .== B)
=#
