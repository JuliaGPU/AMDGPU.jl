# compiler support for working with run-time libraries

function link_library!(ctx::CompilerContext, mod::LLVM.Module, lib::LLVM.Module)
    # linking is destructive, so copy the library
    lib = LLVM.Module(lib)

    # save list of external functions
    exports = String[]
    for f in functions(mod)
        fn = LLVM.name(f)
        if !haskey(functions(lib), fn)
            push!(exports, fn)
        end
    end

    link!(mod, lib)

    ModulePassManager() do pm
        # internalize all functions that aren't exports
        internalize!(pm, exports)

        # eliminate all unused internal functions
        global_optimizer!(pm)
        global_dce!(pm)
        strip_dead_prototypes!(pm)

        run!(pm, mod)
    end
end

const libcache = Dict{String, LLVM.Module}()


#
# ROCm device library
#

function load_device_libs(agent)
    device_libs_path === nothing && return

    device_libs = LLVM.Module[]
    bitcode_files = (
        "hc.amdgcn.bc",
        "hip.amdgcn.bc",
        "irif.amdgcn.bc",
        "ockl.amdgcn.bc",
        "oclc_isa_version_803.amdgcn.bc", # FIXME: Load based on agent name!
        "opencl.amdgcn.bc",
        "ocml.amdgcn.bc",
    )
    for file in bitcode_files
        ispath(joinpath(device_libs_path, file)) || continue
        name, ext = splitext(file)
        lib = get!(libcache, name) do
            file_path = joinpath(device_libs_path, file)
            open(file_path) do io
                parse(LLVM.Module, read(file_path), JuliaContext())
            end
        end
        push!(device_libs, lib)
    end
    @assert !isempty(device_libs) "No device libs detected!"
    return device_libs
end

function link_device_lib!(ctx::CompilerContext, mod::LLVM.Module, lib::LLVM.Module)
    # override device lib's triple and datalayout to avoid warnings
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))

    link_library!(ctx, mod, lib)
end

function link_oclc_defaults!(ctx::CompilerContext, mod::LLVM.Module)
    # link in some defaults for OCLC knobs, to prevent undefined variable errors
    # TODO: only link if used
    # TODO: make these configurable
    lib = LLVM.Module("OCLC")
    for (name,value) in (
            "__oclc_ISA_version"=>Int32(803),
            "__oclc_finite_only_opt"=>Int32(0),
            "__oclc_unsafe_math_opt"=>Int32(0),
            "__oclc_correctly_rounded_sqrt32"=>Int32(1),
            "__oclc_daz_opt"=>Int32(0))
        gvtype = convert(LLVMType, typeof(value))
        gv = GlobalVariable(lib, gvtype, name, 4)
        init = ConstantInt(Int32(0), JuliaContext())
        initializer!(gv, init)
        unnamed_addr!(gv, true)
        constant!(gv, true)
    end
    link!(mod, lib)
end


#
# AMDGPUnative run-time library
#

# remove existing runtime libraries globally,
# so any change to AMDGPUnative triggers recompilation
rm(joinpath(@__DIR__, "..", "..", "deps", "runtime"); recursive=true, force=true)


## higher-level functionality to work with runtime functions

function LLVM.call!(builder, rt::Runtime.RuntimeMethodInstance, args=LLVM.Value[])
    bb = position(builder)
    f = LLVM.parent(bb)
    mod = LLVM.parent(f)

    # get or create a function prototype
    if haskey(functions(mod), rt.llvm_name)
        f = functions(mod)[rt.llvm_name]
        ft = eltype(llvmtype(f))
    else
        ft = LLVM.FunctionType(rt.llvm_return_type, rt.llvm_types)
        f = LLVM.Function(mod, rt.llvm_name, ft)
    end

    # runtime functions are written in Julia, while we're calling from LLVM,
    # this often results in argument type mismatches. try to fix some here.
    for (i,arg) in enumerate(args)
        if llvmtype(arg) != parameters(ft)[i]
            if (llvmtype(arg) isa LLVM.PointerType) &&
               (parameters(ft)[i] isa LLVM.IntegerType)
                # Julia pointers are passed as integers
                args[i] = ptrtoint!(builder, args[i], parameters(ft)[i])
            else
                error("Don't know how to convert ", arg, " argument to ", parameters(ft)[i])
            end
        end
    end

    call!(builder, f, args)
end


## functionality to build the runtime library

function emit_function!(mod, agent, f, types, name)
    tt = Base.to_tuple_type(types)
    ctx = CompilerContext(f, tt, agent, #= kernel =# false)
    new_mod, entry = irgen(ctx)
    entry = optimize!(ctx, new_mod, entry)
    LLVM.name!(entry, name)

    link!(mod, new_mod)
end

function build_runtime(agent)
    mod = LLVM.Module("AMDGPUnative run-time library", JuliaContext())

    for method in values(Runtime.methods)
        try
            emit_function!(mod, agent, method.def, method.types, method.llvm_name)
        catch err
            @warn method
        end
    end

    mod
end

function load_runtime(agent::HSAAgent)
    isa = get_first_isa(agent)
    name = "amdgpunative.$isa.bc"
    path = joinpath(@__DIR__, "..", "..", "deps", "runtime", name)
    mkpath(dirname(path))

    get!(libcache, path) do
        if ispath(path)
            open(path) do io
                parse(LLVM.Module, read(io), JuliaContext())
            end
        else
            @info "Building the AMDGPUnative run-time library for your $isa device, this might take a while..."
            lib = build_runtime(agent)
            open(path, "w") do io
                write(io, lib)
            end
            lib
        end
    end
end
