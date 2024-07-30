@testitem "core: device" begin

using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import LinearAlgebra

include("device/launch.jl")
include("device/array.jl")
include("device/vadd.jl")
include("device/memory.jl")
include("device/indexing.jl")
include("device/wavefront.jl")
include("device/synchronization.jl")
include("device/execution_control.jl")
include("device/exceptions.jl")
include("device/random.jl")

# TODO https://github.com/JuliaGPU/AMDGPU.jl/issues/546
include("device/math.jl")

end
