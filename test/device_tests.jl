@testitem "core: device" begin

using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
using StaticArrays
import LinearAlgebra

include("device/array.jl")
include("device/execution_control.jl")
include("device/exceptions.jl")
include("device/indexing.jl")
include("device/launch.jl")
include("device/math.jl")
include("device/memory.jl")
include("device/wavefront.jl")
include("device/random.jl")
include("device/synchronization.jl")
include("device/vadd.jl")

end
