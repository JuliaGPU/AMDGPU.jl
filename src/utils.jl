function versioninfo()
    @info "AMDGPU versioninfo"
    _status(st::Bool) = st ? "+" : "-"
    _libpath(p::String) = isempty(p) ? "-" : p
    _ver(lib::Symbol, ver_fn) = functional(lib) ? "$(ver_fn())" : "-"
    data = String[
        _status(functional(:lld))         "LLD"              "-"                                 _libpath(lld_path);
        _status(functional(:device_libs)) "Device Libraries" "-"                                 _libpath(libdevice_libs);
        _status(functional(:hip))         "HIP"              _ver(:hip, HIP.runtime_version)     _libpath(libhip);
        _status(functional(:rocblas))     "rocBLAS"          _ver(:rocblas, rocBLAS.version)     _libpath(librocblas);
        _status(functional(:rocsolver))   "rocSOLVER"        _ver(:rocsolver, rocSOLVER.version) _libpath(librocsolver);
        _status(functional(:rocsparse))   "rocSPARSE"        _ver(:rocsparse, rocSPARSE.version) _libpath(librocsparse);
        _status(functional(:rocrand))     "rocRAND"          _ver(:rocrand, rocRAND.version)     _libpath(librocrand);
        _status(functional(:rocfft))      "rocFFT"           _ver(:rocfft, rocFFT.version)       _libpath(librocfft);
        _status(functional(:MIOpen))      "MIOpen"           _ver(:MIOpen, MIOpen.version)       _libpath(libMIOpen_path);
    ]

    PrettyTables.pretty_table(data; header=[
        "Available", "Name", "Version", "Path"],
        alignment=[:c, :l, :l, :l])

    if functional(:hip)
        println()
        @info "AMDGPU devices"
        display(AMDGPU.devices())
    end
    return
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
functional() = functional(:hip) && functional(:lld) && functional(:device_libs)

"""
    functional(component::Symbol) -> Bool

Returns `true` if the ROCm component `component` is configured and expected to
function correctly. Available `component` values are:

- `:hip`         - Queries HIP library availability
- `:lld`         - Queries `ld.lld` tool availability
- `:device_libs` - Queries ROCm device libraries availability
- `:rocblas`     - Queries rocBLAS library availability
- `:rocsolver`   - Queries rocSOLVER library availability
- `:rocsparse`   - Queries rocSPARSE library availability
- `:rocrand`     - Queries rocRAND library availability
- `:rocfft`      - Queries rocFFT library availability
- `:MIOpen`      - Queries MIOpen library availability
- `:all`         - Queries all above components

This query should never throw for valid `component` values.
"""
function functional(component::Symbol)
    if component == :hip
        return !isempty(libhip)
    elseif component == :lld
        return !isempty(lld_path)
    elseif component == :device_libs
        return !isempty(libdevice_libs)
    elseif component == :rocblas
        return !isempty(librocblas)
    elseif component == :rocsolver
        return !isempty(librocsolver)
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
            :hip, :lld, :device_libs, :rocblas, :rocsolver,
            :rocsparse, :rocrand, :rocfft, :MIOpen,
        )
            functional(component) || return false
        end
        return true
    else
        throw(ArgumentError("Unknown component $(repr(component))"))
    end
end

has_rocm_gpu() = functional(:hip) && length(devices()) > 0

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

function check end

macro check(f)
    quote
        local err
        err = $(esc(f::Expr))
        $check(err)
        err
    end
end
