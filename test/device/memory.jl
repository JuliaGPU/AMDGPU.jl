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

wait(@roc groupsize=1 gridsize=1 memory_static_kernel(HA, HB))

@test Array(HA) ≈ Array(HB)

end
