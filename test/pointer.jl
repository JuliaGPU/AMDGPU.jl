@testset "pointer" begin

# inner constructors

voidptr_a = Ptr{Cvoid}(Int(0xDEADBEEF))
generic_voidptr_a = AMDGPU.DevicePtr{Cvoid,AS.Generic}(voidptr_a)
global_voidptr_a = AMDGPU.DevicePtr{Cvoid,AS.Global}(voidptr_a)
local_voidptr_a = AMDGPU.DevicePtr{Cvoid,AS.Local}(voidptr_a)

voidptr_b = Ptr{Cvoid}(Int(0xCAFEBABE))
generic_voidptr_b = AMDGPU.DevicePtr{Cvoid,AS.Generic}(voidptr_b)
global_voidptr_b = AMDGPU.DevicePtr{Cvoid,AS.Global}(voidptr_b)
local_voidptr_b = AMDGPU.DevicePtr{Cvoid,AS.Local}(voidptr_b)

intptr_b = convert(Ptr{Int}, voidptr_b)
generic_intptr_b = AMDGPU.DevicePtr{Int,AS.Generic}(intptr_b)
global_intptr_b = AMDGPU.DevicePtr{Int,AS.Global}(intptr_b)
local_intptr_b = AMDGPU.DevicePtr{Int,AS.Local}(intptr_b)

# outer constructors
@test AMDGPU.DevicePtr{Cvoid}(voidptr_a) == generic_voidptr_a
@test AMDGPU.DevicePtr(voidptr_a) == generic_voidptr_a

# getters
@test eltype(generic_voidptr_a) == Cvoid
@test eltype(global_intptr_b) == Int
@test AMDGPU.addrspace(generic_voidptr_a) == AS.Generic
@test AMDGPU.addrspace(global_voidptr_a) == AS.Global
@test AMDGPU.addrspace(local_voidptr_a) == AS.Local

# comparisons
@test generic_voidptr_a != global_voidptr_a
@test generic_voidptr_a != generic_intptr_b


@testset "conversions" begin

# between regular and device pointers

@test convert(Ptr{Cvoid}, generic_voidptr_a) == voidptr_a
@test convert(AMDGPU.DevicePtr{Cvoid}, voidptr_a) == generic_voidptr_a
@test convert(AMDGPU.DevicePtr{Cvoid,AS.Global}, voidptr_a) == global_voidptr_a


# between device pointers

@test_throws ArgumentError convert(typeof(local_voidptr_a), global_voidptr_a)
@test convert(typeof(generic_voidptr_a), generic_voidptr_a) == generic_voidptr_a
@test convert(typeof(global_voidptr_a), global_voidptr_a) == global_voidptr_a
@test Base.unsafe_convert(typeof(local_voidptr_a), global_voidptr_a) == local_voidptr_a

@test convert(typeof(global_voidptr_a), global_intptr_b) == global_voidptr_b
@test convert(typeof(generic_voidptr_a), global_intptr_b) == generic_voidptr_b
@test convert(typeof(global_voidptr_a), generic_intptr_b) == global_voidptr_b

@test convert(AMDGPU.DevicePtr{Cvoid}, global_intptr_b) == global_voidptr_b

end

end
