# Load configurations
const ext_file_found = try
    include("ext.jl")
    true
catch err
    if !isfile(joinpath(@__DIR__, "ext.jl"))
        @warn "Didn't find deps/ext.jl, please build AMDGPU.jl"
        @eval const use_artifacts = false
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

        for name in (:rocblas,
                     :rocsparse,
                     :rocsolver,
                     :rocrand,
                     :rocfft,
                     :rocalution,
                     :MIOpen)
            lib = Symbol(:lib, lowercase(string(name)))
            @eval const $lib = nothing
            @eval const $(Symbol(name, :_configured)) = false
            @eval const $(Symbol(name, :_build_reason)) = "Build did not occur"
        end
    else
        rethrow(err)
    end
    false
end

# HSA runtime and ROCm External Libraries
## copied from CUDAdrv/src/CUDAdrv.jl
if use_artifacts
    if hsa_configured
        using hsa_rocr_jll
    end
    if lld_configured
        using LLD_jll
    end
    if hip_configured
        using HIP_jll
    end
    if device_libs_configured
        using ROCmDeviceLibs_jll
    end
    if rocblas_configured
        using rocBLAS_jll
    end
    if rocsparse_configured
        using rocSPARSE_jll
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
if !lld_configured
    const ld_lld_path = ""
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
if ext_file_found
    if !rocblas_configured
        const librocblas = nothing
    end
    if !rocsparse_configured
        const librocsparse = nothing
    end
    if !rocrand_configured
        const librocrand = nothing
    end
end
