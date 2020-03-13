module AMDGPUnative

using LLVM, LLVM.Interop
using InteractiveUtils
using HSARuntime
using Adapt
using TimerOutputs
using DataStructures
using Libdl
using Requires

@enum DeviceRuntime HSA OCL
const RUNTIME = Ref{DeviceRuntime}(HSA)
#=
if get(ENV, "AMDGPUNATIVE_OPENCL", "") != ""
    RUNTIME[] = OCL
end
=#
include("runtime.jl")

const configured = HSARuntime.configured

# ROCm-Device-Libs bitcode path
include(joinpath(@__DIR__, "..", "deps", "deps.jl"))
const device_libs_path = joinpath(@__DIR__, "..", "deps", "usr", "lib")

struct Adaptor end

# Device sources must load _before_ the compiler infrastructure
# because of generated functions.
include(joinpath("device", "tools.jl"))
include(joinpath("device", "pointer.jl"))
include(joinpath("device", "array.jl"))
include(joinpath("device", "gcn.jl"))
include(joinpath("device", "runtime.jl"))

include("execution_utils.jl")
include("compiler.jl")
include("execution.jl")
include("reflection.jl")

function __init__()
    check_deps()
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")
    __init_compiler__()
end

end # module
