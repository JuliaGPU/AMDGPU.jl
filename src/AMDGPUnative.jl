module AMDGPUnative

using LLVM, LLVM.Interop
using GPUCompiler
using HSARuntime, HSARuntime.HSA
using Adapt
using Libdl
using Requires

@enum DeviceRuntime HSA_rt OCL_rt
const RUNTIME = Ref{DeviceRuntime}(HSA_rt)
#=
if get(ENV, "AMDGPUNATIVE_OPENCL", "") != ""
    RUNTIME[] = OCL_rt
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
include(joinpath("device", "llvm.jl"))

include("compiler.jl")
include("execution_utils.jl")
include("execution.jl")
include("reflection.jl")

function __init__()
    try
        # Try to load deps if possible
        check_deps()
    catch err
        @warn """
        AMDGPUnative dependencies have not been built, some functionality may be missing.
        Please run Pkg.build("AMDGPUnative") and reload AMDGPUnative.
        """
    end
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")
end

end # module
