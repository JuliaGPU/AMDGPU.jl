function hsa_version()
    major_ref = Ref{Cushort}(typemax(Cushort))
    minor_ref = Ref{Cushort}(typemax(Cushort))
    major_status = ccall((:hsa_system_get_info, libhsaruntime_path), Cint, (Cint, Ptr{Cushort}), HSA.SYSTEM_INFO_VERSION_MAJOR, major_ref)
    minor_status = ccall((:hsa_system_get_info, libhsaruntime_path), Cint, (Cint, Ptr{Cushort}), HSA.SYSTEM_INFO_VERSION_MINOR, minor_ref)
    if major_status != HSA.STATUS_SUCCESS ||
       minor_status != HSA.STATUS_SUCCESS
        @warn "Failed to detect HSA version: $major_status"
        return v"0"
    end
    return VersionNumber(major_ref[], minor_ref[])
end

function versioninfo(io::IO=stdout)
    println("Using ROCm provided by: ", use_artifacts() ? "JLLs" : "System")
    println("HSA Runtime ($(functional(:hsa) ? "ready" : "MISSING"))")
    if functional(:hsa)
        println("- Path: $libhsaruntime_path")
        println("- Version: $(hsa_version())")
        #println("- Initialized: $(repr(HSA_REFCOUNT[] > 0))")
    end
    println("ld.lld ($(functional(:lld) ? "ready" : "MISSING"))")
    if functional(:lld)
        println("- Path: $lld_path")
    end
    println("ROCm-Device-Libs ($(functional(:device_libs) ? "ready" : "MISSING"))")
    if functional(:device_libs)
        println("- Path: $libdevice_libs")
        # TODO: println("- Version: $(device_libs_version)")
    end
    println("HIP Runtime ($(functional(:hip) ? "ready" : "MISSING"))")
    if functional(:hip)
        println("- Path: $libhip")
        # TODO: println("- Version: $(libhip_version)")
    end
    println("rocBLAS ($(functional(:rocblas) ? "ready" : "MISSING"))")
    if functional(:rocblas)
        println("- Path: $(Libdl.dlpath(librocblas))")
    end
    println("rocSOLVER ($(functional(:rocsolver) ? "ready" : "MISSING"))")
    if functional(:rocsolver)
        println("- Path: $(Libdl.dlpath(librocsolver))")
    end
    println("rocALUTION ($(functional(:rocalution) ? "ready" : "MISSING"))")
    if functional(:rocalution)
        println("- Path: $(Libdl.dlpath(librocalution))")
    end
    println("rocSPARSE ($(functional(:rocsparse) ? "ready" : "MISSING"))")
    if functional(:rocsparse)
        println("- Path: $(Libdl.dlpath(librocsparse))")
    end
    println("rocRAND ($(functional(:rocrand) ? "ready" : "MISSING"))")
    if functional(:rocrand)
        println("- Path: $(Libdl.dlpath(librocrand))")
    end
    println("rocFFT ($(functional(:rocfft) ? "ready" : "MISSING"))")
    if functional(:rocfft)
        println("- Path: $(Libdl.dlpath(librocfft))")
    end
    println("MIOpen ($(functional(:MIOpen) ? "ready" : "MISSING"))")
    if functional(:MIOpen)
        println("- Path: $(Libdl.dlpath(libMIOpen))")
    end

    if functional(:hsa)
        println("HSA Agents ($(length(Runtime.devices()))):")
        for device in Runtime.devices()
            println("- ", repr(device))
        end
    end
end

"""
    functional() -> Bool

Returns `true` if AMDGPU is nominally functional; "functional" currently means
that HSA, HIP, lld, and device libraries are available (although it does not
imply that usages of these components will be successful).

Packages may use the result of this query to determine whether it is safe to:
- Use AMDGPU to compile code
- Query devices, queues, and other runtime state
- Launch compiled kernels on a device
- Wait on launched kernels to complete
- Utilize external ROCm libraries (rocBLAS et. al)

If the full compilation and launch pipeline is desired, then this query should
be sufficient for most packages and applications. This query combines
sub-queries of multiple components; a failing sub-query will propagate to a
`false` return value. For more fine-grained queries, use `functional(::Symbol)`.

This query should never throw.
"""
function functional()
    return functional(:hsa) &&
           functional(:hip) &&
           functional(:lld) &&
           functional(:device_libs)
end
"""
    functional(component::Symbol) -> Bool

Returns `true` if the ROCm component `component` is configured and expected to
function correctly. Available `component` values are:

- `:hsa`         - Queries ROCR library availability, initialization status, and GPU device availability
- `:hip`         - Queries HIP library availability
- `:lld`         - Queries `ld.lld` tool availability
- `:device_libs` - Queries ROCm device libraries availability
- `:rocblas`     - Queries rocBLAS library availability
- `:rocsolver`   - Queries rocSOLVER library availability
- `:rocalution`  - Queries rocALUTION library availability
- `:rocsparse`   - Queries rocSPARSE library availability
- `:rocrand`     - Queries rocRAND library availability
- `:rocfft`      - Queries rocFFT library availability
- `:miopen`      - Queries MIOpen library availability
- `:all`         - Queries all above components

This query should never throw for valid `component` values.
"""
function functional(component::Symbol)
    if component == :hsa
        return hsa_configured &&
               HSA_REFCOUNT[] > 0 &&
               length(devices()) > 0
    elseif component == :hip
        return hip_configured
    elseif component == :lld
        return lld_configured
    elseif component == :device_libs
        return device_libs_configured
    elseif component == :rocblas
        return librocblas !== nothing
    elseif component == :rocsolver
        return librocsolver !== nothing
    elseif component == :rocalution
        return librocalution !== nothing
    elseif component == :rocsparse
        return librocsparse !== nothing
    elseif component == :rocrand
        return librocrand !== nothing
    elseif component == :rocfft
        return librocfft !== nothing
    elseif component == :MIOpen
        return libMIOpen !== nothing
    elseif component == :all
        for component in (:hsa, :hip, :lld, :device_libs, :rocblas, :rocsolver,
                          :rocalution, :rocsparse, :rocrand, :rocfft, :MIOpen)
            functional(component) || return false
        end
        return true
    else
        throw(ArgumentError("Unknown component $(repr(component))"))
    end
end

function has_rocm_gpu()
    if !functional(:hsa)
        return false
    else
        return length(devices(:gpu)) > 0
    end
end

function print_build_diagnostics()
    println("Diagnostics:")
    println("-- permissions")
    run(`ls -lah /dev/kfd`)
    run(`ls -lah /dev/dri`)
    for file in readdir("/dev/dri")
        run(`ls -lah $(joinpath("/dev/dri", file))`)
    end
    run(`id`)
end

function getinfo(::Type{String}, object, query)::String
    value = Base.zeros(UInt8, 64)
    getinfo(object, query, value) |> Runtime.check
    return rstrip(String(value), '\0')
end

function getinfo(::Type{T}, object, query)::T where T
    value = Ref{T}()
    getinfo(object, query, value) |> Runtime.check
    return value[]
end

function check end

macro check(f)
    quote
        local err
        err = $(esc(f::Expr))
        $check(err)
        err
    end
end
