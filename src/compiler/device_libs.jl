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
    fn_names::Set{String}

    DevLib(name::String, path::String) = new(name, path, read(path), Set{String}())
    DevLib(name::String, ::Nothing) = new(name, "", UInt8[], Set{String}())
end

const DEVICE_LIBS::Dict{String, DevLib} = Dict{String, DevLib}()

function link_device_libs!(
    target::GCNCompilerTarget, mod::LLVM.Module, undefined_fns::Vector{String},
)
    isnothing(libdevice_libs) && return
    isempty(undefined_fns) && return

    # 1. Load other libraries.
    lib_names = ("hc", "hip", "irif", "ockl", "opencl", "ocml")
    for lib_name in lib_names
        devlib = get!(DEVICE_LIBS, lib_name) do
            DevLib(lib_name, locate_lib(lib_name))
        end
        load_and_link!(devlib, mod, undefined_fns)
    end

    # 2. Load OCLC library.
    devlib = get!(DEVICE_LIBS, "oclc") do
        isa_short = replace(target.dev_isa, "gfx"=>"")
        DevLib("oclc", locate_lib("oclc_isa_version_$isa_short"))
    end
    load_and_link!(devlib, mod)

    # 3. Load OCLC ABI library.
    devlib = get!(DEVICE_LIBS, "oclc_abi") do
        DevLib("oclc_abi", locate_lib("oclc_abi_version_500"))
    end
    load_and_link!(devlib, mod)

    # 4. Load options libraries.
    options = (
        (:finite_only, false),
        (:unsafe_math, false),
        (:correctly_rounded_sqrt, true),
        (:daz_opt, false),
        (:wavefrontsize64, true))

    for (option, value) in options
        toggle = value ? "on" : "off"
        name = "oclc_$(option)_$(toggle)"
        devlib = get!(DEVICE_LIBS, name) do
            DevLib(name, locate_lib(name))
        end
        load_and_link!(devlib, mod)
    end
end

function load_and_link!(
    devlib::DevLib, mod::LLVM.Module, undefined_fns::Vector{String} = String[],
)
    isempty(devlib.path) && return

    fill_fn_names = isempty(devlib.fn_names)
    do_linking = false

    if !fill_fn_names && !isempty(undefined_fns)
        for undef_fn in undefined_fns
            undef_fn ∈ devlib.fn_names && (do_linking = true; break)
        end
        do_linking || return
    end

    lib = parse(LLVM.Module, devlib.data)
    inline_attr = EnumAttribute("alwaysinline")
    noinline_attr = EnumAttribute("noinline")

    for f in LLVM.functions(lib)
        fn_name = LLVM.name(f)
        fill_fn_names && push!(devlib.fn_names, fn_name)

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

    if !do_linking && !isempty(undefined_fns)
        for undef_fn in undefined_fns
            undef_fn ∈ devlib.fn_names && (do_linking = true; break)
        end
        do_linking || return
    end

    # override triple and datalayout to avoid warnings
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))
    LLVM.link!(mod, lib)
    return
end
