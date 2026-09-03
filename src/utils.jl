# Run `code` in a subprocess and return its stdout, or `nothing` on crash,
# timeout, or nonzero exit. The empty `JULIA_LOAD_PATH` keeps the child out of
# the active project, so `code` must only use `Base`.
function _version_subprocess(code::String; timeout::Real = 20)::Union{String, Nothing}
    cmd = `$(Base.julia_cmd()) --startup-file=no -O0 --compile=min -e $code`
    cmd = addenv(cmd, "JULIA_LOAD_PATH" => "")
    out = IOBuffer()
    try
        proc = run(pipeline(ignorestatus(cmd); stdout = out, stderr = devnull); wait = false)
        timedout = Ref(false)
        timer = Timer(timeout) do _
            if process_running(proc)
                timedout[] = true
                kill(proc)
            end
        end
        wait(proc)
        close(timer)
        (timedout[] || !success(proc)) && return nothing
        v = strip(String(take!(out)))
        return isempty(v) ? nothing : v
    catch
        return nothing
    end
end

# Empty until probed, then the version string or `"err"`.
global _ROCSPARSE_VERSION::String = ""

# rocSPARSE's version query needs a handle, and creating one can segfault on
# broken ROCm installs (issue #920), so run it out-of-process.
function _rocsparse_version_isolated(; timeout::Real = 20)
    global _ROCSPARSE_VERSION
    isempty(_ROCSPARSE_VERSION) || return _ROCSPARSE_VERSION

    lib = repr(librocsparse)  # `repr` so Windows separators survive the parser
    # HIP loads comgr by soname, so a system ROCm in the environment can displace
    # the provider's copy. The parent claims the soname first (see
    # `ROCm_Runtime.preload_bundle`); the child has to do the same. Only comgr:
    # replaying the parent's whole closure here costs more than the probe's budget.
    preload = isempty(libamd_comgr) ? "" :
        "Base.Libc.Libdl.dlopen($(repr(libamd_comgr)); throw_error = false)"
    out = _version_subprocess("""
        $preload
        handle = Ref{Ptr{Cvoid}}(C_NULL)
        ccall((:rocsparse_create_handle, $lib), Cint,
            (Ptr{Ptr{Cvoid}},), handle) == 0 || exit(2)
        version = Ref{Cint}(0)
        ccall((:rocsparse_get_version, $lib), Cint,
            (Ptr{Cvoid}, Ptr{Cint}), handle[], version) == 0 || exit(2)
        print(version[])
        """; timeout)
    packed = out === nothing ? nothing : tryparse(Int, out)
    return _ROCSPARSE_VERSION =
        packed === nothing ? "err" : string(rocSPARSE.decode_version(packed))
end

"""
    versioninfo(io::IO=stdout)

Print a report of the AMDGPU.jl setup: detected ROCm libraries and their
versions, tool paths, and the available GPU devices. Useful as a first
diagnostic when something is missing or not working.
"""
function versioninfo(io::IO=stdout)
    println(io, "AMDGPU versioninfo")
    println(io, "ROCm provider: ", local_rocm ?
        "local ROCm installation" : "downloaded artifacts")
    _status(st::Bool) = st ? "+" : "-"
    _libpath(p::String) = isempty(p) ? "-" : p
    _ver(lib::Symbol, ver_fn) = functional(lib) ? "$(ver_fn())" : "-"

    # `"err"` = present but the out-of-process version probe crashed/timed out.
    rocsparse_ver = functional(:rocsparse) ? _rocsparse_version_isolated() : "-"

    data = String[
        _status(functional(:lld))         "LLD"              "-"                                 _libpath(lld_path);
        _status(functional(:device_libs)) "Device Libraries" "-"                                 _libpath(libdevice_libs);
        _status(functional(:hip))         "HIP"              _ver(:hip, HIP.runtime_version)     _libpath(libamdhip64);
        _status(functional(:rocblas))     "rocBLAS"          _ver(:rocblas, rocBLAS.version)     _libpath(librocblas);
        _status(functional(:rocsolver))   "rocSOLVER"        _ver(:rocsolver, rocSOLVER.version) _libpath(librocsolver);
        _status(functional(:rocsparse))   "rocSPARSE"        rocsparse_ver                       _libpath(librocsparse);
        _status(functional(:rocrand))     "rocRAND"          _ver(:rocrand, rocRAND.version)     _libpath(librocrand);
        _status(functional(:rocfft))      "rocFFT"           _ver(:rocfft, rocFFT.version)       _libpath(librocfft);
        _status(functional(:hiptensor))   "hipTENSOR"        _ver(:hiptensor, hipTENSOR.version) _libpath(libhiptensor);
        _status(functional(:MIOpen))      "MIOpen"           _ver(:MIOpen, MIOpen.version)       _libpath(libMIOpen);
    ]

    PrettyTables.pretty_table(io, data; column_labels=[
        "Available", "Name", "Version", "Path"],
        alignment=[:c, :l, :l, :l])

    if rocsparse_ver == "err"
        @warn """rocSPARSE is installed but its version query failed (it ran in an \
            isolated subprocess and crashed or timed out). This usually indicates a \
            broken or mismatched ROCm install. See \
            https://github.com/JuliaGPU/AMDGPU.jl/issues/920."""
    end

    # Artifact-mode hygiene: what we claimed from the bundle, and what a ROCm
    # elsewhere in the environment is still doing to this process.
    if !local_rocm
        loaded = count(p -> last(p) === :loaded, ROCm_Runtime.preload_log)
        other = [p for p in ROCm_Runtime.preload_log if last(p) !== :loaded]
        println(io)
        print(io, "Preloaded $loaded artifact libraries")
        println(io, isempty(other) ? "" : ", $(length(other)) not loaded:")
        for (name, status) in other
            println(io, "  $status: $name")
        end

        redirects = ROCm_Runtime.redirect_env()
        if isempty(redirects)
            println(io, "Device-library redirects: none")
        else
            println(io, "Device-library redirects (override the artifact's own):")
            for (name, value) in redirects
                println(io, "  $name = $value")
            end
        end

        foreign = ROCm_Runtime.foreign_libraries()
        if isempty(foreign)
            println(io, "Foreign ROCm libraries loaded: none")
        else
            println(io, "Foreign ROCm libraries loaded (two ROCm versions at once):")
            for path in foreign
                println(io, "  $path")
            end
        end
    end

    if functional(:hip)
        println(io)
        println(io, "AMDGPU devices")
        show(io, MIME"text/plain"(), AMDGPU.devices())
        println(io)
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
- `:hiptensor`   - Queries hipTENSOR library availability and whether every
                   present device has an architecture supported by it
- `:MIOpen`      - Queries MIOpen library availability
- `:all`         - Queries all above components

This query should never throw for valid `component` values.
"""
function functional(component::Symbol)
    if component == :hip
        return !isempty(libamdhip64)
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
    elseif component == :hiptensor
        isempty(libhiptensor) && return false
        functional(:hip) || return false
        # Having the library is not enough: it only carries kernels for a few
        # architectures. Require every device to be supported, so that this
        # stays valid no matter which one is current. Enumerating devices may
        # throw on a broken install.
        return try
            devs = devices()
            !isempty(devs) && all(hiptensor_supported, devs)
        catch
            false
        end
    elseif component == :MIOpen
        return !isempty(libMIOpen)
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

# hipTENSOR only ships kernels for the architectures listed in
# `hiptensorSupportedArchitectures.cmake` of the ROCm install (Composable Kernel
# only generates CDNA instances); elsewhere its calls fail at runtime with
# `HIPTENSOR_STATUS_ARCH_MISMATCH`. gfx940/gfx941 are pre-release MI300 variants
# that ROCm 6.x builds still supported.
const HIPTENSOR_ARCHS = (
    "gfx908", "gfx90a", "gfx940", "gfx941", "gfx942", "gfx950")

"""
    hiptensor_supported(arch::AbstractString) -> Bool
    hiptensor_supported(device::HIP.HIPDevice) -> Bool

Return `true` if hipTENSOR provides kernels for the GCN architecture `arch`
(e.g. `"gfx90a"`; trailing target features as in `"gfx90a:sramecc+:xnack-"` are
ignored) or for the architecture of `device`.

This only inspects the architecture; use `AMDGPU.functional(:hiptensor)` to also
check that the hipTENSOR library itself was found.
"""
hiptensor_supported(arch::AbstractString) =
    first(split(arch, ':')) in HIPTENSOR_ARCHS

hiptensor_supported(device) = hiptensor_supported(HIP.gcn_arch(device))


"""
    has_rocm_gpu() -> Bool

Return `true` if HIP is functional and at least one GPU device is present.
Use this to guard code that specifically requires GPU hardware; for a general
"can AMDGPU.jl run here" check prefer [`AMDGPU.functional`](@ref).
"""
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

# Used by `GPUToolbox.@checked`.
@inline function check(f::Base.Callable)
    err = f()
    check(err)
    return err
end

macro check(f)
    quote
        local err
        err = $(esc(f::Expr))
        $check(err)
        err
    end
end
