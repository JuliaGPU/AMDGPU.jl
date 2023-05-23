## ROCm device library

import AMDGPU: device_libs_path

function load_and_link!(mod, path)
    ctx = LLVM.context(mod)
    lib = parse(LLVM.Module, read(path); ctx)

    for f in LLVM.functions(lib)
        # FIXME: We should be able to inline this, that we can't means
        #        we are inserting calls to it late.
        name = LLVM.name(f)
        name == "__ockl_hsa_signal_store" && continue
        name == "__ockl_hsa_signal_load" && continue
        startswith(name, "__ockl_hsa_signal") && continue

        attrs = function_attributes(f)
        inline = true
        noinline_attr = EnumAttribute("noinline"; ctx)
        for attr in collect(attrs)
            if kind(attr) == kind(noinline_attr)
                inline = false
                break
            end
        end
        if inline
            push!(attrs, EnumAttribute("alwaysinline"; ctx))
        end
    end

    # override triple and datalayout to avoid warnings
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))

    LLVM.link!(mod, lib)
end

function locate_lib(file)
    file_path = joinpath(device_libs_path, file*".bc")
    if !ispath(file_path)
        file_path = joinpath(device_libs_path, file*".amdgcn.bc")
        if !ispath(file_path)
            # failed to find matching bitcode file
            return nothing
        end
    end
    return file_path
end

function link_device_libs!(target, mod::LLVM.Module)
    # TODO: only link if used
    # TODO: make these globally/locally configurable

    device_libs_path === nothing && return

    # https://github.com/RadeonOpenCompute/ROCm-Device-Libs/blob/9420f6380990b09851edc2a5f9cbfaa88742b449/doc/OCML.md#controls
    # Note: It seems we need to load in reverse order, to avoid LLVM deleting the globals from the module, before we use them.

    # 1. Load other libraries
    libs = (
        "hc",
        "hip",
        "irif",
        "ockl",
        "opencl",
        "ocml",
    )

    for lib in libs
        lib_path = locate_lib(lib)
        lib_path === nothing && continue
        try
            load_and_link!(mod, lib_path)
        catch err
            @warn "Failed to load/link $lib" err=err
        end
    end

    # 2. Load OCLC library
    isa_short = replace(target.dev_isa, "gfx"=>"")
    lib = locate_lib("oclc_isa_version_$isa_short")
    @assert lib !== nothing
    try
        load_and_link!(mod, lib)
    catch err
        @warn "Failed to load/link OCLC core library `$lib` for ISA $(target.dev_isa)." err=err
    end

    # 3. Load OCLC ABI library (required for printing).
    lib = locate_lib("oclc_abi_version_500")
    @assert lib !== nothing
    load_and_link!(mod, lib)

    # 4. Load options libraries
    options = Dict(
        :finite_only => false,
        :unsafe_math => false,
        :correctly_rounded_sqrt => true,
        :daz_opt => false,
        :wavefrontsize64 => true
    )
    for (option, value) in options
        toggle = value ? "on" : "off"
        lib = locate_lib("oclc_$(option)_$(toggle)")
        if lib === nothing
            @warn "Could not find OCLC library for option $option=$value"
            continue
        end
        try
            load_and_link!(mod, lib)
        catch err
            @warn "Failed to load/link OCLC library for option $option=$value" err=err
        end
    end
end
