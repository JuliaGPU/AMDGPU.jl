module AMDGPUnative

using LLVM, LLVM.Interop
using InteractiveUtils
using HSARuntime
using Adapt
using TimerOutputs
using DataStructures
using Libdl

const configured = HSARuntime.configured

# ROCm-Device-Libs bitcode path
include(joinpath(@__DIR__, "..", "deps", "deps.jl"))
const device_libs_path = joinpath(@__DIR__, "..", "deps", "usr", "lib")

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
    __init_compiler__()
end

end # module
