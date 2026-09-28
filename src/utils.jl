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
    out = _version_subprocess("""
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

# `"err"` = present but the version query threw. Guards against a
# broken/mismatched install crashing `versioninfo()` itself (same class of
# bug as rocSPARSE's #920; these queries run in-process rather than isolated
# since they've only been observed to throw, not segfault).
function _ver(is_functional::Bool, ver_fn; on_error = Returns(nothing))
    is_functional || return "-"
    try
        return string(ver_fn())
    catch e
        on_error(e)
        return "err"
    end
end
_ver(lib::Symbol, ver_fn, errors::Vector{Pair{Symbol, String}}) = _ver(
    functional(lib), ver_fn; on_error = e -> push!(errors, lib => sprint(showerror, e)))

"""
    versioninfo(io::IO=stdout)

Print a report of the AMDGPU.jl setup: detected ROCm libraries and their
versions, tool paths, and the available GPU devices. Useful as a first
diagnostic when something is missing or not working.
"""
function versioninfo(io::IO=stdout)
    println(io, "AMDGPU versioninfo")
    _status(st::Bool) = st ? "+" : "-"
    _libpath(p::String) = isempty(p) ? "-" : p

    rocsparse_ver = functional(:rocsparse) ? _rocsparse_version_isolated() : "-"
    errs = Pair{Symbol, String}[]

    data = String[
        _status(functional(:lld))         "LLD"              "-"                                       _libpath(lld_artifact ? AMDGPU_LLVM_Backend_jll.libamdgpu : lld_path);
        _status(functional(:device_libs)) "Device Libraries" "-"                                       _libpath(libdevice_libs);
        _status(functional(:hip))         "HIP"              _ver(:hip, HIP.runtime_version, errs)     _libpath(libhip);
        _status(functional(:rocblas))     "rocBLAS"          _ver(:rocblas, rocBLAS.version, errs)     _libpath(librocblas);
        _status(functional(:rocsolver))   "rocSOLVER"        _ver(:rocsolver, rocSOLVER.version, errs) _libpath(librocsolver);
        _status(functional(:rocsparse))   "rocSPARSE"        rocsparse_ver                             _libpath(librocsparse);
        _status(functional(:rocrand))     "rocRAND"          _ver(:rocrand, rocRAND.version, errs)     _libpath(librocrand);
        _status(functional(:rocfft))      "rocFFT"           _ver(:rocfft, rocFFT.version, errs)       _libpath(librocfft);
        _status(functional(:hiptensor))   "hipTENSOR"        _ver(:hiptensor, hipTENSOR.version, errs) _libpath(libhiptensor);
        _status(functional(:MIOpen))      "MIOpen"           _ver(:MIOpen, MIOpen.version, errs)       _libpath(libMIOpen_path);
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

    # rocSPARSE never lands in `errs`: it has its own warning above.
    if !isempty(errs)
        @warn """Some installed libraries failed their version query. This usually \
            indicates a broken or mismatched ROCm install:
            $(join(("  $lib: $msg" for (lib, msg) in errs), "\n"))"""
    end

    get_module(name::Symbol) = (name, getfield(AMDGPU, name))
    function get_module(pkg::Tuple{String, String})
        id = Base.PkgId(Base.UUID(pkg[1]), pkg[2])
        (pkg[2], get(Base.loaded_modules, id, nothing))
    end

    println(io, "Julia packages: ")
    println(io, "- AMDGPU.jl: $(Base.pkgversion(AMDGPU))")
    for pkg in [:GPUArrays, :GPUCompiler, ("63c18a36-062a-441e-b654-da1e3ab1ce7c", "KernelAbstractions"),
                 :LLVM, :AMDGPU_LLVM_Backend_jll, :LLVMDowngrader_jll]
        name, mod = get_module(pkg)
        isnothing(mod) || println(io, "- $(name): $(Base.pkgversion(mod))")
    end
    println(io)

    println(io, "Toolchain:")
    println(io, "- Julia: $VERSION")
    println(io, "- LLVM: $(LLVM.version())")
    println(io)

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
- `:hiptensor`   - Queries hipTENSOR library availability, whether every
                   present device has an architecture supported by it, and
                   whether it exports the C API (ROCm 7.2+) at a version at
                   least that of the headers the bindings were generated from
- `:MIOpen`      - Queries MIOpen library availability
- `:all`         - Queries all above components

This query should never throw for valid `component` values.
"""
function functional(component::Symbol)
    if component == :hip
        return !isempty(libhip)
    elseif component == :lld
        return !isempty(lld_path) || lld_artifact
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
        supported = try
            devs = devices()
            !isempty(devs) && all(hiptensor_supported, devs)
        catch
            false
        end
        supported || return false
        # Only load the library once the arch check has passed: on an
        # unsupported device hipTENSOR's init calls `exit()`, killing Julia.
        return _hiptensor_api_compatible()
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

# hipTENSOR only ships kernels for the architectures listed in
# `hiptensorSupportedArchitectures.cmake` of the ROCm install (Composable Kernel
# only generates CDNA instances); elsewhere its calls fail at runtime with
# `HIPTENSOR_STATUS_ARCH_MISMATCH`. gfx940/gfx941 are pre-release MI300 variants
# that ROCm 6.x builds still supported.
const HIPTENSOR_ARCHS = (
    "gfx908", "gfx90a", "gfx940", "gfx941", "gfx942", "gfx950")

# hipTENSOR only exports a C API since ROCm 7.2; older versions only have
# C++-mangled names, so none of our bindings resolve. Also require at least the
# header version the bindings were generated from. Cached: hit on every handle creation.
const _HIPTENSOR_API_COMPATIBLE = Ref{Union{Nothing, Bool}}(nothing)
function _hiptensor_api_compatible()
    cached = _HIPTENSOR_API_COMPATIBLE[]
    cached === nothing || return cached
    bindings_version = VersionNumber(
        hipTENSOR.HIPTENSOR_MAJOR_VERSION, hipTENSOR.HIPTENSOR_MINOR_VERSION,
        hipTENSOR.HIPTENSOR_PATCH_VERSION)
    ok = try
        Libdl.dlsym_e(Libdl.dlopen(libhiptensor), :hiptensorGetVersion) != C_NULL &&
            hipTENSOR.version() >= bindings_version
    catch
        false
    end
    _HIPTENSOR_API_COMPATIBLE[] = ok
    return ok
end

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
