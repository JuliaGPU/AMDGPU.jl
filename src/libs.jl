# Selection of the ROCm library provider.
#
# By default the ROCm runtime (HIP, HSA) and the vendor libraries (rocBLAS et
# al.) come from the ROCm_Runtime subpackage, which ships AMD's TheRock
# distribution as lazy artifacts. Setting its "local" preference (see
# `AMDGPU.set_rocm_version!`) switches them to a local ROCm installation,
# discovered through ROCm_Runtime_Discovery; that package is not loaded at all
# otherwise. Both packages provide the same set of exported library paths
# (empty strings when a component is missing).
#
# `ld.lld` and the device libraries always come from AMDGPU_LLVM_Backend_jll:
# `ld.lld` has to match the LLVM version device code is generated with, and the
# device bitcode libraries target that same LLVM, which is newer than Julia's,
# so they are downgraded to Julia's bitcode version with `llvm-downgrade` at
# first use (see `find_device_libs`).

import ROCm_Runtime

const local_rocm = ROCm_Runtime.local_preference === true
if local_rocm
    using ROCm_Runtime_Discovery
else
    using ROCm_Runtime
end

import AMDGPU_LLVM_Backend_jll
import AMDGPU_LLVM_Backend_jll: lld_path
using LLVMDowngrader_jll
using Scratch

# Set by `__init__` (through `find_device_libs`); empty until then, in
# particular during precompilation.
global libdevice_libs::String = ""

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
            cmd = `$(LLVMDowngrader_jll.llvm_downgrade()) --bitcode-version=$(target.major).$(target.minor) -o $(joinpath(tmp, file)) $(joinpath(src_dir, file))`
            err_io = IOBuffer()
            try
                run(pipeline(cmd; stderr=err_io))
            catch
                @warn """Failed to downgrade device library `$file` to LLVM $(target.major), skipping it.
                $(rstrip(String(take!(err_io))))
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

# Directory with the device bitcode libraries to link against, or "" if none
# are available: the downgraded AMDGPU_LLVM_Backend_jll ones, falling back to
# the (non-downgraded) libraries of the local ROCm when one is used.
function find_device_libs()::String
    artifact_err = nothing
    if AMDGPU_LLVM_Backend_jll.is_available() &&
        isdefined(AMDGPU_LLVM_Backend_jll, :bitcode_path) &&
        LLVMDowngrader_jll.is_available()

        try
            return downgrade_device_libs(AMDGPU_LLVM_Backend_jll.bitcode_path)
        catch err
            artifact_err = (err, catch_backtrace())
        end
    end

    device_libs = local_rocm ? ROCm_Runtime_Discovery.libdevice_libs : ""
    if !isnothing(artifact_err)
        if isempty(device_libs)
            @warn """Failed to downgrade the artifact device libraries, and no local \
            device libraries are available to fall back to.
            Ensure `JULIA_DEPOT_PATH` is writeable, or opt into a local ROCm installation
            with `AMDGPU.set_rocm_version!(local_rocm=true)`.
            """ exception=artifact_err
        else
            @warn """Failed to downgrade the artifact device libraries, \
            falling back to the local device libraries in `$device_libs`.
            """ exception=artifact_err
        end
    end
    return device_libs
end

# When the artifact provider cannot resolve a bundle for this host it simply
# ends up with no libraries at all, which otherwise surfaces only as the generic
# "... is unavailable" warnings during initialization. Those do not say that
# nothing was downloaded, nor that a system-wide ROCm is not picked up unless it
# is opted into, so spell both out along with the architecture we detected.
function warn_unresolved_rocm_artifact()
    detected = try
        ROCm_Runtime.rocm_arch()
    catch err
        @debug "Could not query the GPU architecture" exception=(err, catch_backtrace())
        String[]
    end

    what = isempty(detected) ?
        "no GPU architecture could be detected on this host" :
        "no bundle could be resolved for the detected architecture " *
            join(detected, ", ") * " (it may be unsupported, or the download may have failed)"

    @warn """
    No ROCm artifact could be resolved: $what.

    AMDGPU.jl downloads ROCm by default and does not fall back to a ROCm
    installed on this system; using that one requires opting in:

        AMDGPU.set_rocm_version!(local_rocm=true)

    Alternatively, if the architecture above is wrong or could not be detected,
    select the bundle explicitly:

        AMDGPU.set_rocm_version!(arch="gfx1100")

    Either way, restart Julia afterwards. Set `JULIA_DEBUG=ROCm_Runtime` to see
    the underlying artifact resolution error.
    """
end

"""
    AMDGPU.set_rocm_version!([version::VersionNumber]; [local_rocm::Bool], [arch])

Configure the active project to use a specific ROCm version from a specific
source.

If `local_rocm` is set, the ROCm runtime and libraries will be used from the
local system, otherwise they will be downloaded from an artifact source. In the
case of a local ROCm, `version` informs AMDGPU.jl which version that is (this
may be useful if auto-detection fails). In the case of artifact sources,
`version` controls which version will be downloaded and used.

`arch` overrides the GPU architectures the artifact is selected for, given
either as a single `gfx` target (`"gfx942"`) or as a collection of them. It is
only needed when the GPUs of the host cannot be detected, for example when
preparing a depot on a machine without an AMD GPU, and has no effect when a
local ROCm is used.

When not specifying any of the `version`, `local_rocm` or `arch` arguments, the
default behavior will be used, which is to use the most recent compatible
artifacts. Note that this will override any preferences that may be configured
in a higher-up depot; to clear preferences nondestructively, use
[`AMDGPU.reset_rocm_version!`](@ref) instead.
"""
function set_rocm_version!(version::Union{Nothing,VersionNumber}=nothing;
                           local_rocm::Union{Nothing,Bool}=nothing,
                           arch::Union{Nothing,AbstractString,AbstractVector{<:AbstractString}}=nothing)
    # Validate before writing anything, so a bad `arch` cannot leave the
    # preferences half-applied. The artifact selection splits this value on ','
    # without dropping empty entries, and expects each one to be a gfx target,
    # so anything else would only fail later during artifact resolution.
    arch_pref = if isnothing(arch)
        nothing
    else
        archs = arch isa AbstractString ? [String(arch)] : String.(arch)
        (!isempty(archs) && all(a -> startswith(a, "gfx"), archs)) || throw(ArgumentError(
            "`arch` must be a gfx target (e.g. \"gfx942\") or a collection of them, got $(repr(arch))"))
        join(archs, ',')
    end

    Preferences.set_preferences!(ROCm_Runtime,
        "version" => isnothing(version) ? nothing : "$(version.major).$(version.minor)";
        force=true)
    Preferences.set_preferences!(ROCm_Runtime,
        "local" => isnothing(local_rocm) ? nothing : string(local_rocm);
        force=true)
    Preferences.set_preferences!(ROCm_Runtime, "arch" => arch_pref; force=true)

    io = IOBuffer()
    print(io, "Configured the active project to use ")
    if version !== nothing
        print(io, "ROCm $(version.major).$(version.minor)")
    else
        print(io, "the default ROCm")
    end
    if local_rocm !== nothing
        print(io, local_rocm ? " from the local system" : " from artifact sources")
    end
    if arch_pref !== nothing
        print(io, " for ", arch_pref)
    end
    print(io, "; please re-start Julia for this to take effect.")
    @info String(take!(io))
end

"""
    AMDGPU.reset_rocm_version!()

Reset the ROCm preferences in the active project to the default, which
is to use the most recent compatible artifacts, unless a higher-up depot has
configured a different preference. To force use of the default behavior for the
local project, use [`AMDGPU.set_rocm_version!`](@ref) with no arguments.
"""
function reset_rocm_version!()
    Preferences.delete_preferences!(ROCm_Runtime, "version"; force=true)
    Preferences.delete_preferences!(ROCm_Runtime, "local"; force=true)
    Preferences.delete_preferences!(ROCm_Runtime, "arch"; force=true)
    @info "Reset ROCm preferences, please re-start Julia for this to take effect."
end
