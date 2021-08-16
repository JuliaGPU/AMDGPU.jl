# HSA runtime and ROCm External Libraries
## copied from CUDAdrv/src/CUDAdrv.jl
if !parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "false"))
    using hsa_rocr_jll
    using HIP_jll
    using ROCmDeviceLibs_jll
end

try
    include("ext.jl")
catch err
    if !isfile(joinpath(@__DIR__, "ext.jl"))
        @warn "Didn't find deps/ext.jl, please build AMDGPU.jl"
        @eval const hsa_configured = false
        @eval const hip_configured = false
        @eval const device_libs_configured = false
    else
        rethrow(err)
    end
end

# Default (non-functional) values for critical variables,
# making it possible to load the package at all times.
if !hsa_configured
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end
if !hip_configured
    const libhip_path = nothing
    const librocblas = nothing
    const librocsparse = nothing
    const librocalution = nothing
    const librocfft = nothing
    const librocrand = nothing
    const libmiopen = nothing
end
if device_libs_configured && device_libs_downloaded
    # Fallback to download
    device_libs_deps = joinpath(@__DIR__, "deps.jl")
    isfile(device_libs_deps) && include(device_libs_deps)
    const device_libs_path = joinpath(@__DIR__, "usr", "lib")
elseif !device_libs_configured
    const device_libs_path = ""
end

const configured = hsa_configured
