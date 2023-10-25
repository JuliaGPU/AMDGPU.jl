@testitem "core: device" begin

using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
using LinearAlgebra

# include("device/launch.jl")
include("device/array.jl")
# include("device/vadd.jl")
# include("device/memory.jl")
# include("device/indexing.jl")
# include("device/math.jl")
# include("device/wavefront.jl")
# include("device/synchronization.jl")
# include("device/execution_control.jl")
# include("device/exceptions.jl")

end
