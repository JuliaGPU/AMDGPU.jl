# HSA runtime
## copied from CUDAdrv/src/CUDAdrv.jl
const hsa_ext = joinpath(@__DIR__, "hsa", "ext.jl")
if isfile(hsa_ext)
    include(hsa_ext)
end
if !hsa_configured
    const hsa_configured = false
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end

# ROCm-Device-Libs
const device_libs_path = joinpath(@__DIR__, "device-libs", "usr", "lib")

# ROCm External Libraries
const libs_ext = joinpath(@__DIR__, "rocm-external", "ext.jl")
if isfile(libs_ext)
    include(libs_ext)
end
if !ext_libs_configured
    # default (non-functional) values for critical variables,
    # making it possible to _load_ the package at all times.
    const librocblas = nothing
    const librocsparse = nothing
    const librocalution = nothing
    const librocfft = nothing
    const librocrand = nothing
    const libmiopen = nothing
end

const configured = hsa_configured && ext_libs_configured
