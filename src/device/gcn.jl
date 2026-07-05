include(joinpath("gcn", "helpers.jl"))
include(joinpath("gcn", "array.jl"))
include(joinpath("gcn", "math.jl"))
include(joinpath("gcn", "wavefront.jl"))
include(joinpath("gcn", "wavefront_sync.jl"))
include(joinpath("gcn", "indexing.jl"))
include(joinpath("gcn", "synchronization.jl"))
include(joinpath("gcn", "memory_static.jl"))
include(joinpath("gcn", "execution_control.jl"))
include(joinpath("gcn", "hostcall.jl"))
include(joinpath("gcn", "output.jl"))
include(joinpath("gcn", "memory_dynamic.jl"))
include(joinpath("gcn", "wmma_rdna3.jl"))
# TODO Remove this alias for the next major release
const WMMA = WMMA_RDNA3
export WMMA
include(joinpath("gcn", "wmma_rdna4.jl"))
