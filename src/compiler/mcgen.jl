# machine code generation

function machine(agent::HSAAgent, triple::String)
    InitializeAMDGPUTarget()
    InitializeAMDGPUTargetInfo()
    t = Target(triple)

    InitializeAMDGPUTargetMC()
    cpu = get_first_isa(agent) # TODO: Make this configurable
    feat = ""
    tm = TargetMachine(t, triple, cpu, feat)
    asm_verbosity!(tm, true)

    return tm
end

# final preparations for the module to be compiled to GCN
# these passes should not be run when e.g. compiling to write to disk.
function prepare_execution!(ctx::CompilerContext, mod::LLVM.Module)
    let pm = ModulePassManager()
        global global_ctx
        global_ctx = ctx

        global_optimizer!(pm)

        add!(pm, ModulePass("ResolveCPUReferences", resolve_cpu_references!))

        global_dce!(pm)
        strip_dead_prototypes!(pm)

        run!(pm, mod)
        dispose(pm)
    end

    return
end

# some Julia code contains references to objects in the CPU run-time,
# without actually using the contents or functionality of those objects.
#
# prime example are type tags, which reference the address of the allocated type.
# since those references are ephemeral, we can't eagerly resolve and emit them in the IR,
# but at the same time the GPU can't resolve them at run-time.
#
# this pass performs that resolution at link time.
function resolve_cpu_references!(mod::LLVM.Module)
    ctx = global_ctx::CompilerContext
    changed = false

    for f in functions(mod)
        fn = LLVM.name(f)
        if isdeclaration(f) && intrinsic_id(f) == 0 && startswith(fn, "jl_")
            # eagerly resolve the address of the binding
            address = ccall(:jl_cglobal, Any, (Any, Any), fn, UInt)
            dereferenced = unsafe_load(address)
            dereferenced = LLVM.ConstantInt(dereferenced, JuliaContext())

            function replace_bindings!(value)
                changed = false
                for use in uses(value)
                    val = user(use)
                    if isa(val, LLVM.ConstantExpr)
                        # recurse
                        changed |= replace_bindings!(val)
                    elseif isa(val, LLVM.LoadInst)
                        # resolve
                        replace_uses!(val, dereferenced)
                        unsafe_delete!(LLVM.parent(val), val)
                        # FIXME: iterator invalidation?
                        changed = true
                    end
                end
                changed
            end

            changed |= replace_bindings!(f)
        end
    end

    return changed
end

function mcgen(ctx::CompilerContext, mod::LLVM.Module, f::LLVM.Function;
               file_type=LLVM.API.LLVMObjectFile)
    tm = machine(ctx.agent, triple(mod))

    InitializeAMDGPUAsmPrinter()
    obj = emit(tm, mod, file_type)
    return obj
end
