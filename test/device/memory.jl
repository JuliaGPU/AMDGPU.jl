@testset "Memory: Static" begin
@testset "Fixed-size Allocation" begin
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

# https://reviews.llvm.org/D82496
if Base.libllvm_version.major >= 14
@testset "Dynamic-size Local Allocation" begin
    function dynamic_localmem_kernel(RA)
        ptr = AMDGPU.Device.alloc_local(:local, Float32, 0)
        RB = ROCDeviceArray(length(RA), ptr)
        for i in 1:length(RA)
            RB[i] = RA[i] + 1f0
        end
        for i in 1:length(RA)
            RA[i] = RB[i]
        end
    end

    N = 2^10
    A = rand(Float32, N)
    RA = ROCArray(A)

    wait(@roc localmem=N*sizeof(Float32) dynamic_localmem_kernel(RA))

    @test Array(RA) ≈ A .+ 1f0
end
end

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
