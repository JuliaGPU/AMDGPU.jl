@testset "Memory: Static" begin

function memory_static_kernel(a,b)
    # Local
    ptr_local = alloc_special(Val(:local), Float32, Val(AS.Local), Val(1))
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

HA = HSAArray(A)
HB = HSAArray(B)

wait(@roc memory_static_kernel(HA, HB))

@test Array(HA) ≈ Array(HB)

end

@testset "Memory: Dynamic" begin

function malloc_kernel(X)
    ptr = AMDGPU.malloc(Csize_t(4))
    X[1] = ptr
    AMDGPU.free(ptr)
    nothing
end

HA = HSAArray(zeros(UInt64, 1))

wait(@roc malloc_kernel(HA))

@test Array(HA)[1] != 0

end

@testset "Memcpy/Memset" begin

function memcpy_kernel(X,Y)
    AMDGPU.memcpy!(Y.ptr, X.ptr, sizeof(Float32)*length(X))
    nothing
end

A = rand(Float32, 4)
B = zeros(Float32, 4)
HA, HB = HSAArray.((A,B))

wait(@roc memcpy_kernel(HA,HB))

@test A == collect(HA) == collect(HB)

function memset_kernel(X,y)
    AMDGPU.memset!(X.ptr, y, div(length(X),2))
    nothing
end

A = zeros(UInt8, 4)
HA = HSAArray(A)

wait(@roc memset_kernel(HA,0x3))

@test all(collect(HA)[1:2] .== 0x3)
@test all(collect(HA)[3:4] .== 0x0)

end
