# Run `code` in a short-lived subprocess and return its stdout, or `nothing` if
# it crashed, timed out, or exited nonzero. Isolates version probes that can
# segfault on broken ROCm installs, where SIGSEGV isn't catchable in-process.
function _version_subprocess(code::String; timeout::Real = 60)
    project = Base.active_project()
    projarg = project === nothing ? "@." : dirname(project)
    cmd = `$(Base.julia_cmd()) --startup-file=no --project=$projarg -e $code`
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

# rocSPARSE's version query needs a handle, which inits a HIP context and can
# segfault on broken ROCm installs (issue #920). Probe it out-of-process so a
# crash degrades to `"err"` instead of killing the session.
_rocsparse_version_isolated(; timeout::Real = 60) = _version_subprocess("""
    using AMDGPU
    AMDGPU.functional(:rocsparse) || exit(2)
    print(AMDGPU.rocSPARSE.version())
    """; timeout)

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
    rocsparse_failed = false
    rocsparse_ver = if functional(:rocsparse)
        v = _rocsparse_version_isolated()
        v === nothing ? (rocsparse_failed = true; "err") : v
    else
        "-"
    end

    data = String[
        _status(functional(:lld))         "LLD"              "-"                                 _libpath(lld_path);
        _status(functional(:device_libs)) "Device Libraries" "-"                                 _libpath(libdevice_libs);
        _status(functional(:hip))         "HIP"              _ver(:hip, HIP.runtime_version)     _libpath(libamdhip64);
        _status(functional(:rocblas))     "rocBLAS"          _ver(:rocblas, rocBLAS.version)     _libpath(librocblas);
        _status(functional(:rocsolver))   "rocSOLVER"        _ver(:rocsolver, rocSOLVER.version) _libpath(librocsolver);
        _status(functional(:rocsparse))   "rocSPARSE"        rocsparse_ver                       _libpath(librocsparse);
        _status(functional(:rocrand))     "rocRAND"          _ver(:rocrand, rocRAND.version)     _libpath(librocrand);
        _status(functional(:rocfft))      "rocFFT"           _ver(:rocfft, rocFFT.version)       _libpath(librocfft);
        _status(functional(:MIOpen))      "MIOpen"           _ver(:MIOpen, MIOpen.version)       _libpath(libMIOpen);
    ]

    PrettyTables.pretty_table(io, data; column_labels=[
        "Available", "Name", "Version", "Path"],
        alignment=[:c, :l, :l, :l])

    if rocsparse_failed
        @warn """rocSPARSE is installed but its version query failed (it ran in an \
            isolated subprocess and crashed or timed out). This usually indicates a \
            broken or mismatched ROCm install. See \
            https://github.com/JuliaGPU/AMDGPU.jl/issues/920."""
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
