import AMDGPU: libdevice_libs

function locate_lib(file)
    file_path = joinpath(libdevice_libs, file * ".bc")
    if !ispath(file_path)
        file_path = joinpath(libdevice_libs, file * ".amdgcn.bc")
        if !ispath(file_path)
            # failed to find matching bitcode file
            return nothing
        end
    end
    return file_path
end

mutable struct DevLib
    name::String
    path::String
    data::Vector{UInt8}

    DevLib(name::String, path::String) = new(name, path, read(path))
    DevLib(name::String, ::Nothing) = new(name, "", UInt8[])
end

const DEVICE_LIBS::Dict{String, DevLib} = Dict{String, DevLib}()

function get_device_libs_paths(
    target::GCNCompilerTarget;
    wavefrontsize64::Bool,
)
    paths = String[]
    isnothing(libdevice_libs) && return paths

    # 1. Load other libraries.
    lib_names = ("hc", "hip", "irif", "ockl", "opencl", "ocml")
    for lib_name in lib_names
        path = locate_lib(lib_name)
        !isnothing(path) && push!(paths, path)
    end

    # 2. Load OCLC library.
    isa_short = replace(target.dev_isa, "gfx"=>"")
    path = locate_lib("oclc_isa_version_$isa_short")
    !isnothing(path) && push!(paths, path)

    # 3. Load OCLC ABI library.
    path = locate_lib("oclc_abi_version_500")
    !isnothing(path) && push!(paths, path)

    # 4. Load options libraries.
    options = (
        (:finite_only, false),
        (:unsafe_math, false),
        (:correctly_rounded_sqrt, true),
        (:daz_opt, false),
        (:wavefrontsize64, wavefrontsize64))

    for (option, value) in options
        toggle = value ? "on" : "off"
        name = "oclc_$(option)_$(toggle)"
        path = locate_lib(name)
        !isnothing(path) && push!(paths, path)
    end
    return paths
end

function link_device_libs!(
    target::GCNCompilerTarget, mod::LLVM.Module;
    wavefrontsize64::Bool,
)
    isnothing(libdevice_libs) && return
    if !isempty(AMDGPU.ROCmDiscovery.clang_path)
        return
    end

    for path in get_device_libs_paths(target; wavefrontsize64)
        name = basename(path)
        devlib = get!(DEVICE_LIBS, name) do
            DevLib(name, path)
        end
        load_and_link!(devlib, mod)
    end
end

function load_and_link!(devlib::DevLib, mod::LLVM.Module)
    isempty(devlib.path) && return

    lib = parse(LLVM.Module, devlib.data)
    inline_attr = EnumAttribute("alwaysinline")
    noinline_attr = EnumAttribute("noinline")

    for f in LLVM.functions(lib)
        fn_name = LLVM.name(f)

        # FIXME: We should be able to inline this, that we can't means
        #        we are inserting calls to it late.
        startswith(fn_name, "__ockl_hsa_signal") && continue

        attrs = function_attributes(f)
        inline = true
        for attr in collect(attrs)
            if kind(attr) == kind(noinline_attr)
                inline = false
                break
            end
        end
        inline && push!(attrs, inline_attr)
    end

    # override triple and datalayout to avoid warnings
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))
    LLVM.link!(mod, lib)
    return
end
