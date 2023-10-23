function versioninfo(io::IO=stdout)
    _status(st::Bool) = st ? "+" : "-"
    function _lib_title(name::String, sym::Symbol; version_fn::Function)
        st = _status(functional(sym))
        ver = (functional(sym) && version_fn ≢ identity) ? "v$(version_fn())" : ""
        "[$st] $name $ver"
    end

    println("ROCm provided by: ", use_artifacts() ? "JLLs" : "system")
    println(_lib_title("HSA Runtime", :hsa; version_fn=HSA.version))
    if functional(:hsa)
        println("    @ $libhsaruntime")
    end
    println("[$(_status(functional(:lld)))] ld.lld")
    if functional(:lld)
        println("    @ $lld_path")
    end
    println("[$(_status(functional(:device_libs)))] ROCm-Device-Libs")
    if functional(:device_libs)
        println("    @ $libdevice_libs")
    end
    println(_lib_title("HIP Runtime", :hip; version_fn=HIP.runtime_version))
    if functional(:hip)
        println("    @ $libhip")
    end
    println(_lib_title("rocBLAS", :rocblas; version_fn=rocBLAS.version))
    if functional(:rocblas)
        println("    @ $(Libdl.dlpath(librocblas))")
    end
    println(_lib_title("rocSOLVER", :rocsolver; version_fn=rocSOLVER.version))
    if functional(:rocsolver)
        println("    @ $(Libdl.dlpath(librocsolver))")
    end
    println("[$(_status(functional(:rocalution)))] rocALUTION")
    if functional(:rocalution)
        println("    @ $(Libdl.dlpath(librocalution))")
    end
    println("[$(_status(functional(:rocsparse)))] rocSPARSE")
    if functional(:rocsparse)
        println("    @ $(Libdl.dlpath(librocsparse))")
    end
    println(_lib_title("rocRAND", :rocrand; version_fn=rocRAND.version))
    if functional(:rocrand)
        println("    @ $(Libdl.dlpath(librocrand))")
    end
    println(_lib_title("rocFFT", :rocfft; version_fn=rocFFT.version))
    if functional(:rocfft)
        println("    @ $(Libdl.dlpath(librocfft))")
    end
    println(_lib_title("MIOpen", :MIOpen; version_fn=MIOpen.version))
    if functional(:MIOpen)
        println("    @ $(Libdl.dlpath(libMIOpen_path))")
    end

    if functional(:hsa) && functional(:hip)
        println()
        println("HIP Devices [$(length(HIP.devices()))]")
        for (i, device) in enumerate(HIP.devices())
            println("    $i. ", repr(device))
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
- `:MIOpen`      - Queries MIOpen library availability
- `:all`         - Queries all above components

This query should never throw for valid `component` values.
"""
function functional(component::Symbol)
    if component == :hsa
        return !isempty(libhsaruntime)
    elseif component == :hip
        return !isempty(libhip)
    elseif component == :lld
        return !isempty(lld_path)
    elseif component == :device_libs
        return !isempty(libdevice_libs)
    elseif component == :rocblas
        return !isempty(librocblas)
    elseif component == :rocsolver
        return !isempty(librocsolver)
    elseif component == :rocalution
        return !isempty(librocalution)
    elseif component == :rocsparse
        return !isempty(librocsparse)
    elseif component == :rocrand
        return !isempty(librocrand)
    elseif component == :rocfft
        return !isempty(librocfft)
    elseif component == :MIOpen
        return !isempty(libMIOpen_path)
    elseif component == :all
        for component in (
            :hsa, :hip, :lld, :device_libs, :rocblas, :rocsolver,
            :rocalution, :rocsparse, :rocrand, :rocfft, :MIOpen,
        )
            functional(component) || return false
        end
        return true
    else
        throw(ArgumentError("Unknown component $(repr(component))"))
    end
end

function has_rocm_gpu()
    (functional(:hsa) && functional(:hip)) || return false
    return length(devices()) > 0
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
