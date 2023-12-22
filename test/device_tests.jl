@testitem "core: device" begin

using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import LinearAlgebra

CI = parse(Bool, get(ENV, "CI", "false"))

include("device/launch.jl")
include("device/array.jl")
include("device/vadd.jl")
include("device/memory.jl")
include("device/indexing.jl")
include("device/wavefront.jl")
include("device/synchronization.jl")
include("device/execution_control.jl")
include("device/exceptions.jl")


# TODO Julia 1.9 fails with out-of-bounds error for some reason...
if VERSION ≥ v"1.10-"
    include("device/random.jl")
end

# TODO https://github.com/JuliaGPU/AMDGPU.jl/issues/546
include("device/math.jl")

end
