import AMDGPU: libdevice_libs

function locate_lib(file)
    isempty(libdevice_libs) && return nothing
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
    # Symbols this library defines.
    # `nothing` until the library has been parsed once.
    # Afterwards, we can skip parsing entirely if the module does not need them.
    defines::Union{Nothing, Set{String}}

    DevLib(name::String, path::String) = new(name, path, read(path), nothing)
    DevLib(name::String, ::Nothing) = new(name, "", UInt8[], nothing)
end

const DEVICE_LIBS::Dict{String, DevLib} = Dict{String, DevLib}()

devlib!(name::String, locate=() -> locate_lib(name)) =
    get!(() -> DevLib(name, locate()), DEVICE_LIBS, name)

# Libraries that provide functions/globals on demand.
ondemand_libs() = (
    devlib!("hc"), devlib!("hip"), devlib!("irif"),
    devlib!("ockl"), devlib!("opencl"), devlib!("ocml"))

# Core libraries are always linked, both the device libraries and
# the AMDGPU backend expect them to be present.
function control_libs(target::GCNCompilerTarget, wavefrontsize64::Bool)
    isa_short = replace(target.dev_isa, "gfx" => "")
    libs = DevLib[
        devlib!("oclc", () -> locate_lib("oclc_isa_version_$isa_short")),
        devlib!("oclc_abi", () -> locate_lib("oclc_abi_version_500")),
    ]
    for (option, value) in (
        (:finite_only, false),
        (:unsafe_math, false),
        (:correctly_rounded_sqrt, true),
        (:daz_opt, false),
        (:wavefrontsize64, wavefrontsize64),
    )
        push!(libs, devlib!("oclc_$(option)_$(value ? "on" : "off")"))
    end
    return libs
end

"""
Names of all symbols `mod` references but does not define.
"""
function undefined_symbols(mod::LLVM.Module)
    undefined = Set{String}()
    for f in LLVM.functions(mod)
        LLVM.isdeclaration(f) && push!(undefined, LLVM.name(f))
    end
    for g in LLVM.globals(mod)
        LLVM.isdeclaration(g) && push!(undefined, LLVM.name(g))
    end
    return undefined
end

function defined_symbols(mod::LLVM.Module)
    defined = Set{String}()
    for f in LLVM.functions(mod)
        LLVM.isdeclaration(f) || push!(defined, LLVM.name(f))
    end
    for g in LLVM.globals(mod)
        LLVM.isdeclaration(g) || push!(defined, LLVM.name(g))
    end
    return defined
end

function link_device_libs!(
    target::GCNCompilerTarget, mod::LLVM.Module;
    wavefrontsize64::Bool,
)
    isnothing(libdevice_libs) && return

    ondemand = ondemand_libs()
    undefined = undefined_symbols(mod)

    # Linking one library can introduce references satisfied by another
    # (e.g. `ocml` -> `__ockl_*`), so iterate until nothing more links.
    while true
        linked = false
        for devlib in ondemand
            isempty(undefined) && break
            if load_and_link!(devlib, mod; undefined)
                linked = true
                undefined = undefined_symbols(mod)
            end
        end
        linked || break
    end

    for devlib in control_libs(target, wavefrontsize64)
        load_and_link!(devlib, mod)
    end
    return
end

"""
Link `devlib` into `mod`, returning whether anything was linked.

When `undefined` is given, the library is skipped unless it defines at least one
of those symbols. The first time a library is seen we must parse it anyway to
learn what it defines; from then on the check is a set intersection.
"""
function load_and_link!(
    devlib::DevLib, mod::LLVM.Module; undefined::Union{Nothing, Set{String}} = nothing,
)
    isempty(devlib.path) && return false

    if undefined !== nothing && devlib.defines !== nothing &&
       isdisjoint(devlib.defines, undefined)
        return false
    end

    # Lazy parsing only reads the module header,
    # function bodies are materialized by the linker as it needs them.
    # `devlib.data` is stored in `DEVICE_LIBS` and outlives `lib`, so it is safe to lazy-load.
    lib = parse(LLVM.Module, devlib.data; lazy=true)

    if devlib.defines === nothing
        devlib.defines = defined_symbols(lib)
        if undefined !== nothing && isdisjoint(devlib.defines, undefined)
            dispose(lib)
            return false
        end
    end

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
    return true
end
