# HSA dispatch packet offsets
_packet_names = fieldnames(HSA.KernelDispatchPacket)
_packet_offsets = fieldoffset.(HSA.KernelDispatchPacket, 1:length(_packet_names))

include(joinpath("gcn", "math.jl"))
include(joinpath("gcn", "indexing.jl"))
include(joinpath("gcn", "assertion.jl"))
include(joinpath("gcn", "synchronization.jl"))
include(joinpath("gcn", "memory_static.jl"))
include(joinpath("gcn", "hostcall.jl"))
include(joinpath("gcn", "output.jl"))
include(joinpath("gcn", "memory_dynamic.jl"))
include(joinpath("gcn", "execution_control.jl"))
include(joinpath("gcn", "atomics.jl"))
