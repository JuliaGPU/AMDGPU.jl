@testset "pointer" begin

# inner constructors

voidptr_a = Ptr{Cvoid}(Int(0xDEADBEEF))
generic_voidptr_a = AMDGPUnative.DevicePtr{Cvoid,AS.Generic}(voidptr_a)
global_voidptr_a = AMDGPUnative.DevicePtr{Cvoid,AS.Global}(voidptr_a)
local_voidptr_a = AMDGPUnative.DevicePtr{Cvoid,AS.Local}(voidptr_a)

voidptr_b = Ptr{Cvoid}(Int(0xCAFEBABE))
generic_voidptr_b = AMDGPUnative.DevicePtr{Cvoid,AS.Generic}(voidptr_b)
global_voidptr_b = AMDGPUnative.DevicePtr{Cvoid,AS.Global}(voidptr_b)
local_voidptr_b = AMDGPUnative.DevicePtr{Cvoid,AS.Local}(voidptr_b)

intptr_b = convert(Ptr{Int}, voidptr_b)
generic_intptr_b = AMDGPUnative.DevicePtr{Int,AS.Generic}(intptr_b)
global_intptr_b = AMDGPUnative.DevicePtr{Int,AS.Global}(intptr_b)
local_intptr_b = AMDGPUnative.DevicePtr{Int,AS.Local}(intptr_b)

# outer constructors
@test AMDGPUnative.DevicePtr{Cvoid}(voidptr_a) == generic_voidptr_a
@test AMDGPUnative.DevicePtr(voidptr_a) == generic_voidptr_a

# getters
@test eltype(generic_voidptr_a) == Cvoid
@test eltype(global_intptr_b) == Int
@test AMDGPUnative.addrspace(generic_voidptr_a) == AS.Generic
@test AMDGPUnative.addrspace(global_voidptr_a) == AS.Global
@test AMDGPUnative.addrspace(local_voidptr_a) == AS.Local

# comparisons
@test generic_voidptr_a != global_voidptr_a
@test generic_voidptr_a != generic_intptr_b


@testset "conversions" begin

# between regular and device pointers

@test_throws InexactError convert(Ptr{Cvoid}, generic_voidptr_a)
@test_throws InexactError convert(AMDGPUnative.DevicePtr{Cvoid}, voidptr_a)

@test Base.unsafe_convert(Ptr{Cvoid}, generic_voidptr_a) == voidptr_a


# between device pointers

@test_throws InexactError convert(typeof(local_voidptr_a), global_voidptr_a)
@test convert(typeof(generic_voidptr_a), generic_voidptr_a) == generic_voidptr_a
@test convert(typeof(global_voidptr_a), global_voidptr_a) == global_voidptr_a
@test Base.unsafe_convert(typeof(local_voidptr_a), global_voidptr_a) == local_voidptr_a

@test convert(typeof(global_voidptr_a), global_intptr_b) == global_voidptr_b
@test convert(typeof(generic_voidptr_a), global_intptr_b) == generic_voidptr_b
@test convert(typeof(global_voidptr_a), generic_intptr_b) == global_voidptr_b

@test convert(AMDGPUnative.DevicePtr{Cvoid}, global_intptr_b) == global_voidptr_b

end

end
