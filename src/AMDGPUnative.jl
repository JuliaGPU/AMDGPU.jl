module AMDGPUnative

using LLVM, LLVM.Interop
using InteractiveUtils
using HSARuntime
using Adapt
using Libdl

const configured = HSARuntime.configured

# where the ROCm-Device-Libs bitcode goes
include(joinpath(@__DIR__, "..", "deps", "deps.jl"))
const device_libs_path = joinpath(@__DIR__, "..", "deps", "usr", "lib")

# needs to be loaded _before_ the compiler infrastructure, because of generated functions
include(joinpath("device", "tools.jl"))
include(joinpath("device", "pointer.jl"))
include(joinpath("device", "array.jl"))
include(joinpath("device", "gcn_intrinsics.jl"))
include(joinpath("device", "runtime_intrinsics.jl"))

include("execution_utils.jl")
include("compiler.jl")
include("execution.jl")

include("reflection.jl")

function __init__()
    check_deps()
end

end # module
