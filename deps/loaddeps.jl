# HSA runtime and ROCm External Libraries
## copied from CUDAdrv/src/CUDAdrv.jl
const ext = joinpath(@__DIR__, "ext.jl")
if !isfile(ext)
    @warn "Didn't find $ext, please build AMDGPU.jl"
    const hsa_configured = false
    const ext_libs_configured = false
else
    include(ext)
end

# Default (non-functional) values for critical variables,
# making it possible to load the package at all times.
if !hsa_configured
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end
if !ext_libs_configured
    const librocblas = nothing
    const librocsparse = nothing
    const librocalution = nothing
    const librocfft = nothing
    const librocrand = nothing
    const libmiopen = nothing
    const libhip = nothing
end

# ROCm-Device-Libs
device_libs_deps = joinpath(@__DIR__, "deps.jl")
isfile(device_libs_deps) && include(device_libs_deps)
const device_libs_path = joinpath(@__DIR__, "usr", "lib")

const configured = hsa_configured
