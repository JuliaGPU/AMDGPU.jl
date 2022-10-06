@testset "Memory: Static" begin

function memory_static_kernel(a,b)
    # Local
    ptr_local = AMDGPU.Device.alloc_local(:local, Float32, 1)
    unsafe_store!(ptr_local, a[1])
    b[1] = unsafe_load(ptr_local)

    # Region
    #= TODO: AMDGPU target cannot select
    ptr_region = alloc_special(Val(:region), Float32, Val(AS.Region), Val(1))
    unsafe_store!(ptr_region, a[2])
    b[2] = unsafe_load(ptr_region)
    =#

    # Private
    #= TODO
    ptr_private = alloc_special(Val(:private), Float32, Val(AS.Private), Val(1))
    unsafe_store!(ptr_private, a[3])
    b[3] = unsafe_load(ptr_private)
    =#

    nothing
end

A = ones(Float32, 1)
B = zeros(Float32, 1)

RA = ROCArray(A)
RB = ROCArray(B)

wait(@roc memory_static_kernel(RA, RB))

@test Array(RA) ≈ Array(RB)

end

@testset "Memory: Dynamic" begin

function malloc_kernel(X)
    ptr = AMDGPU.Device.malloc(Csize_t(4))
    X[1] = reinterpret(UInt64, ptr)
    AMDGPU.Device.free(ptr)
    nothing
end

RA = ROCArray(zeros(UInt64, 1))

wait(@roc malloc_kernel(RA))

@test Array(RA)[1] != 0

end

@testset "Memcpy/Memset" begin

function memcpy_kernel(X,Y)
    AMDGPU.Device.memcpy!(Y.ptr, X.ptr, sizeof(Float32)*length(X))
    nothing
end

A = rand(Float32, 4)
B = zeros(Float32, 4)
RA, RB = ROCArray.((A,B))

wait(@roc memcpy_kernel(RA,RB))

@test A == collect(RA) == collect(RB)

function memset_kernel(X,y)
    AMDGPU.Device.memset!(X.ptr, y, div(length(X),2))
    nothing
end

A = zeros(UInt8, 4)
RA = ROCArray(A)

wait(@roc memset_kernel(RA,0x3))

@test all(collect(RA)[1:2] .== 0x3)
@test all(collect(RA)[3:4] .== 0x0)
end
