import AMDGPU: libdevice_libs

function locate_lib(file)
    isempty(libdevice_libs) && return nothing
    for extension in (".bc", ".amdgcn.bc")
        path = joinpath(libdevice_libs, file * extension)
        isfile(path) && return path
    end
    return nothing
end

# Language libraries implementing the functions device code calls. Their definitions are
# force-inlined, as the AMDGPU back-end handles calls poorly (e.g. huge scratch usage).
const rocm_language_libraries = ("hc", "hip", "opencl", "ocml", "ockl", "irif")

# Selected libraries per (library directory, ISA, wavefront size). This avoids filesystem
# checks on every compilation, and keeps each library's export manifest, which
# GPUCompiler computes on first use.
const rocm_libraries_lock = ReentrantLock()
const rocm_libraries = Dict{Tuple{String,String,Bool},Tuple}()

"""
    rocm_device_libraries(target, wavefrontsize64)

Select the ROCm bitcode libraries for `target`: the language libraries, then the
target-specific `oclc` control constants they depend on. Missing optional libraries are
omitted; GPUCompiler diagnoses any unresolved calls that actually require them.
"""
function rocm_device_libraries(target::GCNCompilerTarget, wavefrontsize64::Bool)
    key = (libdevice_libs, target.dev_isa, wavefrontsize64)
    Base.@lock rocm_libraries_lock begin
        get!(rocm_libraries, key) do
            _rocm_device_libraries(target, wavefrontsize64)
        end
    end
end

function _rocm_device_libraries(target::GCNCompilerTarget, wavefrontsize64::Bool)
    isa_short = replace(target.dev_isa, "gfx" => "")
    controls = ["oclc_isa_version_$isa_short", "oclc_abi_version_500"]
    for (option, value) in (
        (:finite_only, false),
        (:unsafe_math, false),
        (:correctly_rounded_sqrt, true),
        (:daz_opt, false),
        (:wavefrontsize64, wavefrontsize64),
    )
        push!(controls, "oclc_$(option)_$(value ? "on" : "off")")
    end
    libraries = GPUCompiler.DeviceLibrary[]
    for (names, always_inline) in ((rocm_language_libraries, true), (controls, false))
        for name in names
            path = locate_lib(name)
            path === nothing && continue
            push!(libraries,
                  GPUCompiler.DeviceLibrary(Symbol(name); bitcode=path, always_inline))
        end
    end
    return Tuple(libraries)
end

# HSA signal operations are only used by hostcalls, and are kept out of line.
function uninline_signal_functions!(mod::LLVM.Module)
    for fn in mod.functions
        isdeclaration(fn) && continue
        startswith(fn.name, "__ockl_hsa_signal") || continue
        delete!(fn.function_attributes, :alwaysinline)
    end
    return
end
