module ROCmDiscovery

export lld_artifact, lld_path, libhsaruntime, libdevice_libs, libhip
export librocblas, librocsparse, librocsolver
export librocrand, librocfft, libMIOpen_path
export libhiptensor

using AMDGPU_LLVM_Backend_jll
using LLVMDowngrader_jll
using LLVMDowngrader_jll: libllvm_downgrade
using Preferences
using Scratch
using Libdl

include("utils.jl")

function get_ld_lld(rocm_path::String)::Tuple{String, Bool}
    lld_path = find_ld_lld(rocm_path)
    isempty(lld_path) || return (lld_path, false)
    # the artifact links in-process through `libamdgpu`, so there is no tool path
    return ("", AMDGPU_LLVM_Backend_jll.is_available())
end

# downgrade bitcode to the format of an older LLVM through `libllvm_downgrade`
function downgrade_bitcode(input::Vector{UInt8}, version::VersionNumber)
    buffer = Ref{Ptr{Cvoid}}(C_NULL)
    message = Ref{Cstring}(C_NULL)
    status = @ccall libllvm_downgrade.LLVMDGDowngrade(
        input::Ptr{UInt8}, length(input)::Csize_t, version.major::Cuint, version.minor::Cuint,
        buffer::Ptr{Ptr{Cvoid}}, message::Ptr{Cstring})::Cint
    if status != 0
        msg = "unknown error"
        if message[] != C_NULL
            msg = unsafe_string(message[])
            @ccall libllvm_downgrade.LLVMDGDisposeMessage(message[]::Cstring)::Cvoid
        end
        error(msg)
    end
    start = @ccall libllvm_downgrade.LLVMDGGetBufferStart(buffer[]::Ptr{Cvoid})::Ptr{UInt8}
    size = @ccall libllvm_downgrade.LLVMDGGetBufferSize(buffer[]::Ptr{Cvoid})::Csize_t
    output = copy(unsafe_wrap(Array, start, size))
    @ccall libllvm_downgrade.LLVMDGDisposeMemoryBuffer(buffer[]::Ptr{Cvoid})::Cvoid
    return output
end

# bitcode versions `llvm-downgrade` can target.
# The 15 target emits opaque pointers, but GPUCompiler uses typed pointers on LLVM 15 and 16
# (Julia 1.10 and 1.11), so both use the 14 target instead.
const DOWNGRADE_TARGETS = (v"14", #=v"15",=# v"18")

# downgrade the device libs to the latest LLVM version Julia supports
function downgrade_device_libs(src_dir::String)::String
    target = maximum(Iterators.filter(<=(Base.libllvm_version), DOWNGRADE_TARGETS))
    # ensure this is rebuilt if any of the relevant jlls or the target changes
    scratch_name = replace(string(
        "device_libs-", pkgversion(AMDGPU_LLVM_Backend_jll),
        "-", first(basename(AMDGPU_LLVM_Backend_jll.artifact_dir), 8),
        "-downgrader-", pkgversion(LLVMDowngrader_jll),
        "-", first(basename(LLVMDowngrader_jll.artifact_dir), 8),
        "-llvm-", target.major), "+" => "_") # artifact versions include +, which Scratch does not like
    dir = @get_scratch!(scratch_name)
    marker = joinpath(dir, "downgrade_complete")
    isfile(marker) && return dir

    # Use a temp dir, so concurrent processes don't interfere
    mktempdir(dirname(dir)) do tmp
        for file in readdir(src_dir)
            endswith(file, ".bc") || continue
            # Just skip libraries the downgrader can't handle. `link_device_libs!` will throw an error if it is actually needed
            try
                bitcode = downgrade_bitcode(read(joinpath(src_dir, file)), target)
                write(joinpath(tmp, file), bitcode)
            catch err
                @warn """Failed to downgrade device library `$file` to LLVM $(target.major), skipping it.
                $(sprint(showerror, err))
                """
                rm(joinpath(tmp, file); force=true)
            end
        end
        for file in readdir(tmp)
            mv(joinpath(tmp, file), joinpath(dir, file); force=true)
        end
    end
    touch(marker)
    return dir
end

function get_device_libs(from_artifact::Bool; rocm_path::String)
    artifact_err = nothing
    if from_artifact &&
        AMDGPU_LLVM_Backend_jll.is_available() &&
        isdefined(AMDGPU_LLVM_Backend_jll, :bitcode_path) &&
        LLVMDowngrader_jll.is_available()

        try
            return downgrade_device_libs(AMDGPU_LLVM_Backend_jll.bitcode_path)
        catch err
            artifact_err = (err, catch_backtrace())
        end
    end

    device_libs = find_device_libs(rocm_path)
    if !isnothing(artifact_err)
        if isempty(device_libs)
            @warn """Failed to downgrade artifact device libraries and no system-wide \
            device libraries found in `$rocm_path`.
            Ensure `JULIA_DEPOT_PATH` is writeable, or point `ROCM_PATH` to a local ROCm
            installation.
            """ exception=artifact_err
        else
            @warn """Failed to downgrade artifact device libraries, \
            falling back to system-wide device libraries in `$device_libs`.
            """ exception=artifact_err
        end
    end
    return device_libs
end

function _hip_runtime_version()
    v_ref = Ref{Cint}()
    res = ccall((:hipRuntimeGetVersion, libhip), UInt32, (Ptr{Cint},), v_ref)
    res > 0 && error("Failed to get HIP runtime version.")

    v = v_ref[]
    major = v ÷ 10_000_000
    minor = (v ÷ 100_000) % 100
    patch = v % 100000
    VersionNumber(major, minor, patch)
end

global rel_libdir::String = Sys.islinux() ? "" : "bin"
global libhsaruntime::String = ""
global lld_path::String = ""
global lld_artifact::Bool = false
global libhip::String = ""
global libdevice_libs::String = ""
global librocblas::String = ""
global librocsparse::String = ""
global librocsolver::String = ""
global librocrand::String = ""
global librocfft::String = ""
global libhiptensor::String = ""
global libMIOpen_path::String = ""

# Properties of the GPU nodes in the KFD topology that ROCr can use, in the order ROCr
# enumerates them.
function kfd_gpu_nodes(root="/sys/class/kfd/kfd/topology/nodes"; dri="/dev/dri")
    nodes = Dict{String,UInt64}[]
    Sys.islinux() && isdir(root) || return nodes
    for id in sort!(filter!(!isnothing, tryparse.(Int, readdir(root))))
        props = Dict{String,UInt64}()
        try
            for line in eachline(joinpath(root, string(id), "properties"))
                fields = split(line)
                length(fields) == 2 || continue
                value = tryparse(UInt64, fields[2])
                value === nothing || (props[fields[1]] = value)
            end
        catch err
            err isa Base.IOError || err isa SystemError || rethrow()
        end
        # CPU nodes don't have SIMDs
        get(props, "simd_count", 0) > 0 || continue

        # like libhsakmt, skip GPUs whose render device we can't open, e.g., because the
        # cgroup device controller (as used by Slurm) hides them
        render = joinpath(dri, "renderD$(get(props, "drm_render_minor", 0))")
        accessible = try
            close(open(render, "r+"))
            true
        catch err
            err isa Base.IOError || err isa SystemError || rethrow()
            false
        end
        accessible && push!(nodes, props)
    end
    return nodes
end

# like C's `strtol(token, &end, 0)` with `*end == '\0'`
function parse_c_int(token)
    m = match(r"^([+-]?)(?:0[xX]([0-9a-fA-F]+)|0([0-7]*)|([1-9][0-9]*))$", token)
    m === nothing && return nothing
    value = if m[2] !== nothing
        tryparse(Int, m[2]; base=16)
    elseif m[3] !== nothing
        isempty(m[3]) ? 0 : tryparse(Int, m[3]; base=8)
    else
        tryparse(Int, m[4])
    end
    return value === nothing || m[1] != "-" ? value : -value
end

# The KFD nodes of the GPUs that HIP will use, after applying `ROCR_VISIBLE_DEVICES` like
# ROCr does, and `HIP_VISIBLE_DEVICES` (or `CUDA_VISIBLE_DEVICES`) like HIP does.
function visible_gpus(gpus, env=ENV)
    # like ROCr's `RvdFilter`: indices or UUID prefixes, until the first invalid entry
    if haskey(env, "ROCR_VISIBLE_DEVICES")
        uuids = map(gpus) do gpu
            id = get(gpu, "unique_id", 0)
            id == 0 ? "" : "GPU-" * uppercase(string(id; base=16, pad=16))
        end
        tokens = split(env["ROCR_VISIBLE_DEVICES"], ',')
        isempty(last(tokens)) && pop!(tokens)
        selected = Int[]
        for token in Iterators.take(tokens, length(gpus))
            token = uppercase(strip(token))
            index = if startswith(token, 'G')
                # a UUID, or a unique prefix of one
                matches = findall(uuid -> startswith(uuid, token), uuids)
                5 <= length(token) <= 20 && length(matches) == 1 ? only(matches) : 0
            else
                something(isempty(token) ? 0 : parse_c_int(token), -1) + 1
            end
            1 <= index <= length(gpus) && !(index in selected) || break
            push!(selected, index)
        end
        gpus = gpus[selected]
    end

    # like HIP's `roc::Device::init`: indices or parts of UUIDs, of the remaining GPUs
    hip = get(env, "HIP_VISIBLE_DEVICES", "")
    isempty(hip) && (hip = get(env, "CUDA_VISIBLE_DEVICES", ""))
    if !isempty(hip)
        uuids = map(gpus) do gpu
            id = get(gpu, "unique_id", 0)
            id == 0 ? "GPU-XX" : "GPU-" * string(id; base=16, pad=16)
        end
        selected = Int[]
        for token in split(hip, ',')
            index = if occursin("GPU-", token)
                something(findfirst(uuid -> occursin(token, uuid), uuids), 0)
            else
                index = tryparse(Int, token)
                index !== nothing && string(index) == token ? index + 1 : 0
            end
            1 <= index <= length(gpus) || break
            index in selected || push!(selected, index)
        end
        gpus = gpus[selected]
    end

    return gpus
end

# On the gfx1036 iGPU of Ryzen 7000/9000 CPUs, idle clock gating discards dirty L2
# lines, so device-memory writes of a kernel are lost when the GPU goes idle before
# a system-scope release, e.g., when the host synchronizes more than ~200us after
# the launch. `AMD_OPT_FLUSH=0` makes HIP use system-scope releases on every dispatch.
const SYSTEM_SCOPE_FENCE_TARGETS = (100306,)

# PCI locations `(domain, bus, device)` of the GPUs that need system-scope fences.
global system_scope_fence_devices::Vector{NTuple{3,Int}} = NTuple{3,Int}[]
# Whether HIP was configured to use system-scope fences, and what decided that
# (`:environment`, `:preference` or `:auto`).
global system_scope_fences::Bool = false
global system_scope_fences_source::Symbol = :auto
global amd_opt_flush::String = ""

# Decide whether HIP should use system-scope fences on the given GPUs. Returns the PCI
# locations of the GPUs that need them, whether to use them, and what decided that.
function system_scope_fences_config(gpus; env=ENV,
        preference=load_preference(@__MODULE__, "system_scope_fences", "auto"))
    affected = filter(gpus) do node
        get(node, "gfx_target_version", 0) in SYSTEM_SCOPE_FENCE_TARGETS
    end
    devices = map(affected) do node
        location = Int(get(node, "location_id", 0))  # bus << 8 | device << 3 | function
        (Int(get(node, "domain", 0)), location >> 8, (location >> 3) & 0x1f)
    end

    if haskey(env, "AMD_OPT_FLUSH")
        # HIP parses the value with `atoi`, so e.g. "" and "false" mean 0
        m = match(r"^\s*[+-]?(\d+)", env["AMD_OPT_FLUSH"])
        return devices, m === nothing || all(==('0'), m[1]), :environment
    elseif preference isa Bool
        return devices, preference, :preference
    else
        preference == "auto" || @error """Invalid value for the `system_scope_fences` preference: $(repr(preference)).
                                          Use `AMDGPU.system_scope_fences!` to set it to `true`, `false` or `"auto"`."""
        # don't slow down other GPUs
        return devices, !isempty(affected) && length(affected) == length(gpus), :auto
    end
end

function configure_system_scope_fences!(gpus)
    devices, enable, source = system_scope_fences_config(gpus)
    global system_scope_fence_devices = devices
    global system_scope_fences = enable
    global system_scope_fences_source = source
    if source == :environment
        global amd_opt_flush = ENV["AMD_OPT_FLUSH"]
    elseif enable
        ENV["AMD_OPT_FLUSH"] = "0"
    end
    return
end

"""
    system_scope_fences!(value::Union{Bool,String})

Configure whether HIP uses system-scope fences after every kernel, which is needed for
correct results on the integrated GPU of Ryzen 7000 and 9000 CPUs (`gfx1036`), at a
small cost per kernel launch. `value` is `true`, `false` or `"auto"` (the default),
which enables them only when all AMD GPUs in the system need them. Setting the
`AMD_OPT_FLUSH` environment variable overrides this preference.

HIP reads this setting at initialization, for all GPUs, so the change takes effect
after restarting Julia.
"""
function system_scope_fences!(value::Union{Bool,String})
    value isa String && value != "auto" &&
        throw(ArgumentError("Invalid value $(repr(value)); use `true`, `false` or `\"auto\"`."))
    @set_preferences!("system_scope_fences" => value)
    @info "System-scope fences preference set to $(repr(value)); restart Julia for this change to take effect."
end

function __init__()

    if Sys.islinux() && isdir("/sys/class/kfd/kfd/topology/nodes/")
        for node_id in readdir("/sys/class/kfd/kfd/topology/nodes/")
            node_name = readchomp(joinpath("/sys/class/kfd/kfd/topology/nodes/", node_id, "name"))
            # CPU nodes don't have names.
            isempty(node_name) && continue

            if node_name == "navy_flounder"
                ENV["HSA_OVERRIDE_GFX_VERSION"] = "10.3.0"
                break
            end
        end
    end

    configure_system_scope_fences!(visible_gpus(kfd_gpu_nodes()))

    rocm_path = find_roc_path()
    lib_prefix = Sys.islinux() ? "lib" : ""

    try
        global libhsaruntime = Sys.islinux() ?
            find_rocm_library("libhsa-runtime64"; rocm_path, ext="so.1") :
            ""

        # Linker.
        lld_path, lld_artifact = get_ld_lld(rocm_path)
        global lld_path = lld_path
        global lld_artifact = lld_artifact
        global libhip = find_rocm_library(Sys.islinux() ? "libamdhip64" : "amdhip64"; rocm_path)

        # Always load artifact device libraries.
        from_artifact = true
        global libdevice_libs = get_device_libs(from_artifact; rocm_path)

        # HIP-based libraries.
        global librocblas = find_rocm_library(lib_prefix * "rocblas"; rocm_path)
        global librocsparse = find_rocm_library(lib_prefix * "rocsparse"; rocm_path)
        global librocsolver = find_rocm_library(lib_prefix * "rocsolver"; rocm_path)
        global librocrand = find_rocm_library(lib_prefix * "rocrand"; rocm_path)
        global librocfft = find_rocm_library(lib_prefix * "rocfft"; rocm_path)
        global libhiptensor = find_rocm_library(lib_prefix * "hiptensor"; rocm_path)
        global libMIOpen_path = find_rocm_library(lib_prefix * "MIOpen"; rocm_path)
    catch err
        @error """ROCm discovery failed!
        Discovered ROCm path: $rocm_path.
        Use `ROCM_PATH` env variable to specify ROCm directory.

        """ exception=(err, catch_backtrace())
    end
end

end
