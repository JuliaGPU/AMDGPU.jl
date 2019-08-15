if Base.libllvm_version >= v"7.0"
    include(joinpath("gcn_intrinsics", "math.jl"))
end
include(joinpath("gcn_intrinsics", "indexing.jl"))
include(joinpath("gcn_intrinsics", "assertion.jl"))
include(joinpath("gcn_intrinsics", "synchronization.jl"))
include(joinpath("gcn_intrinsics", "extras.jl"))
