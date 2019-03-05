
# JIT compilation of Julia code to AMDGPU, based upon CUDAnative.jl

#
# main code generation functions
#

# make function names safe for PTX
nameof(f::Core.Function) = String(typeof(f).name.mt.name)
nameof(f::LLVM.Function) = LLVM.name(f)


function module_setup(mod::LLVM.Module)
    # The triple could also be amdgcn-amd-amdhsa-opencl, 
    # but that will lead to a different memory model.
    triple!(mod, "amdgcn-amd-amdhsa-hcc")
end

function raise_exception(insblock::BasicBlock, ex::Value)
    fun = LLVM.parent(insblock)
    mod = LLVM.parent(fun)
    ctx = context(mod)

    builder = Builder(ctx)
    position!(builder, insblock)

    trap = if haskey(functions(mod), "llvm.trap")
        functions(mod)["llvm.trap"]
    else
        LLVM.Function(mod, "llvm.trap", LLVM.FunctionType(LLVM.VoidType(ctx)))
    end
    call!(builder, trap)
end

function irgen(func, tt)
    @nospecialize func tt
    # collect all modules of IR
    # TODO: make codegen pure
    function hook_module_setup(ref::Ptr{Nothing})
        ref = convert(LLVM.API.LLVMModuleRef, ref)
        module_setup(LLVM.Module(ref))
    end
    function hook_raise_exception(insblock::Ptr{Nothing}, ex::Ptr{Nothing})
        insblock = convert(LLVM.API.LLVMValueRef, insblock)
        ex = convert(LLVM.API.LLVMValueRef, ex)
        raise_exception(BasicBlock(insblock), Value(ex))
    end
    irmods = Vector{LLVM.Module}()
    function hook_module_activation(ref::Ptr{Nothing})
        ref = convert(LLVM.API.LLVMModuleRef, ref)
        push!(irmods, LLVM.Module(ref))
    end
    params = Base.CodegenParams(cached=false,
                                track_allocations=false,
                                code_coverage=false,
                                static_alloc=false,
                                prefer_specsig=true,
                                module_setup=hook_module_setup,
                                module_activation=hook_module_activation,
                                raise_exception=hook_raise_exception)
    let irmod = parse(LLVM.Module,
                      InteractiveUtils._dump_function(func, tt,
                                          #=native=#false, #=wrapper=#false, #=strip=#false,
                                          #=dump_module=#true, #=syntax=#:att, #=optimize=#false,
                                          #=debuginfo=#:default, params),
                      jlctx[])
        pushfirst!(irmods, irmod)
    end

    # FIXME: Julia doesn't honor the module_setup hook, and module_activation isn't called
    #        for every module (causing us to re-parse the top-level module)

    # link all the modules
    mod = LLVM.Module(nameof(func), jlctx[])
    module_setup(mod)
    for irmod in irmods
        module_setup(irmod) # FIXME
        link!(mod, irmod)
    end

    # add debug info metadata
    # TODO: do this once module_setup is properly honored
    # push!(metadata(mod), "llvm.module.flags",
    #      MDNode([ConstantInt(Int32(1)),    # llvm::Module::Error
    #              MDString("Debug Info Version"), ConstantInt(DEBUG_METADATA_VERSION())]))

    # clean up incompatibilities
    for llvmf in functions(mod)
        llvmfn = LLVM.name(llvmf)
        if startswith(llvmfn, "jlcall_")
            # we don't need the generic wrapper
            unsafe_delete!(mod, llvmf)
        else
            # only occurs in debug builds
            delete!(function_attributes(llvmf), EnumAttribute("sspreq"))
        end
    end

    return mod
end

function add_entry!(mod::LLVM.Module, func, tt; kernel::Bool=false)
    @nospecialize func tt
    # find all Julia functions
    # TODO: let Julia report this
    julia_fs = Dict{String,Dict{String,LLVM.Function}}()
    r = r"^(?P<cc>(jl|japi|jsys|julia)[^\W_]*)_(?P<name>.+)_\d+$"
    for llvmf in functions(mod)
        m = match(r, LLVM.name(llvmf))
        if m != nothing
            fns = get!(julia_fs, m[:name], Dict{String,LLVM.Function}())
            fns[m[:cc]] = llvmf
        end
    end

    # find the native entry-point function
    fn = nameof(func)
    haskey(julia_fs, fn) || error("could not find compiled function for $fn")
    entry_fs = julia_fs[fn]
    if !haskey(entry_fs, "julia")
        error("could not find native function for $fn, available CCs are: ",
              join(keys(entry_fs), ", "))
    end
    entry_f = entry_fs["julia"]

    # generate a kernel wrapper to fix & improve argument passing
    if kernel
        entry_ft = eltype(llvmtype(entry_f))
        @assert return_type(entry_ft) == LLVM.VoidType(jlctx[])

        # filter out ghost types, which don't occur in the LLVM function signatures
        julia_types = filter(dt->!isghosttype(dt), [tt.parameters...,])

        # generate the wrapper function type & def
        function wrapper_type(julia_t, codegen_t)
            if isa(codegen_t, LLVM.PointerType) && !(julia_t <: Ptr)
                # we didn't specify a pointer, but codegen passes one anyway.
                # make the wrapper accept the underlying value instead.
                return eltype(codegen_t)
            else
                return codegen_t
            end
        end
        wrapper_types = LLVM.LLVMType[wrapper_type(julia_t, codegen_t)
                                      for (julia_t, codegen_t)
                                      in zip(julia_types, parameters(entry_ft))]
        # TODO: rename?
        wrapper_fn = "ptxcall" * LLVM.name(entry_f)[6:end]
        wrapper_ft = LLVM.FunctionType(LLVM.VoidType(jlctx[]), wrapper_types)
        wrapper_f = LLVM.Function(mod, wrapper_fn, wrapper_ft)

        # emit IR performing the "conversions"
        Builder(jlctx[]) do builder
            entry = BasicBlock(wrapper_f, "entry", jlctx[])
            position!(builder, entry)

            wrapper_args = Vector{LLVM.Value}()

            # perform argument conversions
            codegen_types = parameters(entry_ft)
            wrapper_params = parameters(wrapper_f)
            for (julia_t, codegen_t, wrapper_t, wrapper_param) in
                zip(julia_types, codegen_types, wrapper_types, wrapper_params)
                if codegen_t != wrapper_t
                    # the wrapper argument doesn't match the kernel parameter type.
                    # this only happens when codegen wants to pass a pointer.
                    @assert isa(codegen_t, LLVM.PointerType)
                    @assert eltype(codegen_t) == wrapper_t

                    # copy the argument value to a stack slot, and reference it.
                    ptr = alloca!(builder, wrapper_t)
                    if LLVM.addrspace(codegen_t) != 0
                        ptr = addrspacecast!(builder, ptr, codegen_t)
                    end
                    store!(builder, wrapper_param, ptr)
                    push!(wrapper_args, ptr)

                    # Julia marks parameters as TBAA immutable;
                    # this is incompatible with us storing to a stack slot, so clear TBAA
                    # TODO: tag with alternative information (eg. TBAA, or invariant groups)
                    entry_params = collect(parameters(entry_f))
                    candidate_uses = []
                    for param in entry_params
                        append!(candidate_uses, collect(uses(param)))
                    end
                    while !isempty(candidate_uses)
                        usepair = popfirst!(candidate_uses)
                        inst = user(usepair)

                        md = metadata(inst)
                        if haskey(md, LLVM.MD_tbaa)
                            delete!(md, LLVM.MD_tbaa)
                        end

                        # follow along certain pointer operations
                        if isa(inst, LLVM.GetElementPtrInst) ||
                           isa(inst, LLVM.BitCastInst) ||
                           isa(inst, LLVM.AddrSpaceCastInst)
                            append!(candidate_uses, collect(uses(inst)))
                        end
                    end
                else
                    push!(wrapper_args, wrapper_param)
                end
            end

            call!(builder, entry_f, wrapper_args)

            ret!(builder)
        end

        # early-inline the original entry function into the wrapper
        push!(function_attributes(entry_f), EnumAttribute("alwaysinline"))
        linkage!(entry_f, LLVM.API.LLVMInternalLinkage)
        ModulePassManager() do pm
            always_inliner!(pm)
            run!(pm, mod)
        end

        entry_f = wrapper_f
    end

    verify(mod)

    return entry_f
end

# const libdevices = Dict{String, LLVM.Module}()
# function link_libdevice!(mod::LLVM.Module, cap::VersionNumber)
#     CUDAnative.configured || return

#     # find libdevice
#     path = if isa(libdevice, Dict)
#         # select the most recent & compatible library
#         const vers = keys(CUDAnative.libdevice)
#         compat_vers = Set(ver for ver in vers if ver <= cap)
#         isempty(compat_vers) && error("No compatible CUDA device library available")
#         ver = maximum(compat_vers)
#         path = libdevice[ver]
#     else
#         libdevice
#     end

#     # load the library, once
#     if !haskey(libdevices, path)
#         open(path) do io
#             libdevice_mod = parse(LLVM.Module, read(io), jlctx[])
#             name!(libdevice_mod, "libdevice")
#             libdevices[path] = libdevice_mod
#         end
#     end
#     libdevice_mod = LLVM.Module(libdevices[path])

#     # override libdevice's triple and datalayout to avoid warnings
#     triple!(libdevice_mod, triple(mod))
#     datalayout!(libdevice_mod, datalayout(mod))

#     # 1. save list of external functions
#     exports = map(LLVM.name, functions(mod))
#     filter!(fn->!haskey(functions(libdevice_mod), fn), exports)

#     # 2. link with libdevice
#     link!(mod, libdevice_mod)

#     ModulePassManager() do pm
#         # 3. internalize all functions not in list from (1)
#         internalize!(pm, exports)

#         # 4. eliminate all unused internal functions
#         #
#         # this isn't necessary, as we do the same in optimize! to inline kernel wrappers,
#         # but it results _much_ smaller modules which are easier to handle on optimize=false
#         global_optimizer!(pm)
#         global_dce!(pm)
#         strip_dead_prototypes!(pm)

#         # 5. run NVVMReflect pass
#         push!(metadata(mod), "nvvm-reflect-ftz",
#               MDNode([ConstantInt(Int32(1))]))

#         # 6. run standard optimization pipeline
#         #
#         #    see `optimize!`

#         run!(pm, mod)
#     end
# end

function machine(triple::String, cpu::String)
    InitializeAMDGPUTarget()
    InitializeAMDGPUTargetInfo()
    t = Target(triple)

    InitializeAMDGPUTargetMC()

    feat = ""

    tm = TargetMachine(t, triple, cpu, feat)

    return tm
end

# Optimize a bitcode module according to a certain device capability.
function optimize!(mod::LLVM.Module, entry::LLVM.Function, cpu::String)
    tm = machine(triple(mod), cpu)

    ModulePassManager() do pm
        internalize!(pm, [LLVM.name(entry)])

        add_library_info!(pm, triple(mod))
        add_transform_info!(pm, tm)
        ccall(:jl_add_optimization_passes, Nothing,
                (LLVM.API.LLVMPassManagerRef, Cint),
                LLVM.ref(pm), Base.JLOptions().opt_level)

        # CUDAnative's JIT internalizes non-inlined child functions, making it possible
        # to rewrite them (whereas the Julia JIT caches those functions exactly);
        # this opens up some more optimization opportunities
        dead_arg_elimination!(pm)   # parent doesn't use return value --> ret void

        global_optimizer!(pm)
        global_dce!(pm)
        strip_dead_prototypes!(pm)

        run!(pm, mod)
    end
end

function mcgen(mod::LLVM.Module, func::LLVM.Function, cpu::String;
               kernel::Bool=true)
    tm = machine(triple(mod), cpu)

    # kernel metadata
    # if kernel
    #     push!(metadata(mod), "nvvm.annotations",
    #          MDNode([func, MDString("kernel"), ConstantInt(Int32(1))]))
    # end

    InitializeAMDGPUAsmPrinter()
    # TODO AMDGPU support ELF object file output
    return String(emit(tm, mod, LLVM.API.LLVMAssemblyFile))
end

# Compile a function to PTX, returning the assembly and an entry point.
# Not to be used directly, see `cufunction` instead.
#
# The `kernel` argument indicates whether we are compiling a kernel entry-point function,
# in which case extra metadata needs to be attached.
function compile_function(func, tt, cpu::String; kernel::Bool=true)
    @nospecialize func tt
    check_invocation(func, tt; kernel=kernel)

    sig = "$(typeof(func).name.mt.name)($(join(tt.parameters, ", ")))"
    @debug("(Re)compiling $sig for mcpu $cpu")

    # generate LLVM IR
    mod = irgen(func, tt)
    entry = add_entry!(mod, func, tt; kernel=kernel)
    @info("Module entry point: ", LLVM.name(entry))

    # link libdevice, if it might be necessary
    # TODO: should be more find-grained -- only matching functions actually in this libdevice
    # if any(f->isdeclaration(f) && intrinsic_id(f)==0, functions(mod))
    #     link_libdevice!(mod, cap)
    # end

    # optimize the IR (otherwise the IR isn't necessarily compatible)
    optimize!(mod, entry, cpu)

    # validate generated IR
    # errors = validate_ir(mod)
    # if !isempty(errors)
    #     for e in errors
    #         warn("Encountered incompatible LLVM IR for $sig at mcpu $cpu, with : ", e)
    #     end
    #     error("LLVM IR generated for $sig at capability $cap is not compatible")
    # end

    # generate (PTX) assembly
    module_asm = mcgen(mod, entry, cpu; kernel=kernel)

    return module_asm, LLVM.name(entry)
end

# check validity of a function invocation, specified by the generic function and a tupletype
function check_invocation(func, tt; kernel::Bool=false)
    @nospecialize func tt
    sig = "$(typeof(func).name.mt.name)($(join(tt.parameters, ", ")))"

    # get the method
    ms = Base.methods(func, tt)
    isempty(ms)   && throw(ArgumentError("no method found for $sig"))
    length(ms)!=1 && throw(ArgumentError("no unique matching method for $sig"))
    m = first(ms)

    # emulate some of the specsig logic from codegen.cppto detect non-native CC functions
    # TODO: also do this for device functions (#87)
    isconcretetype(tt) || throw(ArgumentError("invalid call to device function $sig: passing abstract arguments"))
    m.isva && throw(ArgumentError("invalid device function $sig: is a varargs function"))

    # kernels can't return values
    if kernel
        rt = Base.return_types(func, tt)[1]
        if rt != Nothing
            throw(ArgumentError("$sig is not a valid kernel as it returns $rt"))
        end
    end
end

# Main entry point for compiling a Julia function + argtypes to a callable CUDA function
# function cufunction(dev::CuDevice, func::ANY, tt::ANY)
#     CUDAnative.configured || error("CUDAnative.jl has not been configured; cannot JIT code.")
#     @assert isa(func, Core.Function)

#     # select a capability level
#     dev_cap = capability(dev)
#     compat_caps = filter(cap -> cap <= dev_cap, capabilities)
#     isempty(compat_caps) &&
#         error("Device capability v$dev_cap not supported by available toolchain")
#     cap = maximum(compat_caps)

#     (module_asm, module_entry) = compile_function(func, tt, cap)

#     # enable debug options based on Julia's debug setting
#     jit_options = Dict{CUDAdrv.CUjit_option,Any}()
#     if CUDAapi.DEBUG || Base.JLOptions().debug_level >= 1
#         jit_options[CUDAdrv.GENERATE_LINE_INFO] = true
#     end
#     if CUDAapi.DEBUG || Base.JLOptions().debug_level >= 2
#         # TODO: detect cuda-gdb
#         # FIXME: this conflicts with GENERATE_LINE_INFO (see the verbose PTX JIT log)
#         jit_options[CUDAdrv.GENERATE_DEBUG_INFO] = true
#     end
#     cuda_mod = CuModule(module_asm, jit_options)
#     cuda_fun = CuFunction(cuda_mod, module_entry)

#     return cuda_fun, cuda_mod
# end

function init_jit()
    llvm_args = [
        # Program name; can be left blank.
        "",
        # Enable generation of FMA instructions to mimic behavior of nvcc.
        # "--nvptx-fma-level=1",
    ]
    LLVM.API.LLVMParseCommandLineOptions(Int32(length(llvm_args)),
        [Base.unsafe_convert(Cstring, llvm_arg) for llvm_arg in llvm_args], C_NULL)
end
