# Load configurations
try
    include("ext.jl")
catch err
    if !isfile(joinpath(@__DIR__, "ext.jl"))
        @warn "Didn't find deps/ext.jl, please build AMDGPU.jl"
        @eval const configured = false
        @eval const build_reason = "Build did not occur"
        @eval const lld_configured = false
        @eval const lld_build_reason = "Build did not occur"
        @eval const hsa_configured = false
        @eval const hsa_build_reason = "Build did not occur"
        @eval const hip_configured = false
        @eval const hip_build_reason = "Build did not occur"
        @eval const device_libs_configured = false
        @eval const device_libs_build_reason = "Build did not occur"
        @eval const rocrand_configured = false
        @eval const rocrand_build_reason = "Build did not occur"
    else
        rethrow(err)
    end
end

# HSA runtime and ROCm External Libraries
## copied from CUDAdrv/src/CUDAdrv.jl
const use_artifacts = !parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "false"))
if use_artifacts
    if hsa_configured
        using hsa_rocr_jll
    end
    if hip_configured
        using HIP_jll
    end
    if device_libs_configured
        using ROCmDeviceLibs_jll
    end
    if rocrand_configured
        using rocRAND_jll
    end
end

# Default (non-functional) values for critical variables,
# making it possible to load the package at all times.
if !hsa_configured
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_path = nothing
end
if !hip_configured
    const libhip_path = nothing
end
if device_libs_configured && device_libs_downloaded
    # Fallback to download
    #device_libs_deps = joinpath(@__DIR__, "deps.jl")
    #isfile(device_libs_deps) && include(device_libs_deps)
    #const device_libs_path = joinpath(@__DIR__, "usr", "lib")
elseif !device_libs_configured
    const device_libs_path = ""
end
if !rocrand_configured
    const librocrand = nothing
end
