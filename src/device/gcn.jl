if Base.libllvm_version >= v"7.0"
    include(joinpath("gcn", "math.jl"))
end
include(joinpath("gcn", "indexing.jl"))
include(joinpath("gcn", "assertion.jl"))
include(joinpath("gcn", "synchronization.jl"))
include(joinpath("gcn", "memory_static.jl"))
include(joinpath("gcn", "memory_dynamic.jl"))
include(joinpath("gcn", "hostcall.jl"))
