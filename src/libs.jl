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
# `ld.lld` and the device libraries always come from their JLLs: `ld.lld` has
# to match the LLVM version device code is generated with, and local device
# libraries target a newer LLVM than Julia's and would need to be downgraded.

import ROCm_Runtime

const local_rocm = ROCm_Runtime.local_preference === true
if local_rocm
    using ROCm_Runtime_Discovery
else
    using ROCm_Runtime
end

import AMDGPU_LLVM_Backend_jll: lld_path
import ROCmDeviceLibs_jll: bitcode_path as libdevice_libs

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
