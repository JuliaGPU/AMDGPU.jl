# Julia/LLVM IR generation and transformation passes

function module_setup(mod::LLVM.Module)
    triple!(mod, "amdgcn-amd-amdhsa")

    # add debug info metadata
        push!(metadata(mod), "llvm.module.flags",
             MDNode([ConstantInt(Int32(1), JuliaContext()), # llvm::Module::Error
                     MDString("Debug Info Version"),
                     ConstantInt(DEBUG_METADATA_VERSION(), JuliaContext())]))
end

# generate a pseudo-backtrace from a stack of methods being emitted
function backtrace(job::CompilerJob, call_stack::Vector{Core.MethodInstance})
    bt = StackTraces.StackFrame[]
    for method_instance in call_stack
        method = method_instance.def
        if method.name === :overdub && isdefined(method, :generator)
            # The inline frames are maintained by the dwarf based backtrace,
            # but here we only have the calls to overdub directly, the backtrace
            # therefore is collapsed and we have to lookup the overdubbed
            # function, but only if we likely are using the generated variant.
            actual_sig = Tuple{method_instance.specTypes.parameters[3:end]...}
            m = ccall(:jl_gf_invoke_lookup, Any, (Any, UInt), actual_sig,
                      typemax(UInt))
            method = m.func::Method
        end
        frame = StackTraces.StackFrame(method.name, method.file, method.line)
        pushfirst!(bt, frame)
    end
    bt
end

# NOTE: We use an exception to be able to display a stack trace using
# the logging framework.
struct MethodSubstitutionWarning <: Exception
    original::Method
    substitute::Method
end

Base.showerror(io::IO, err::MethodSubstitutionWarning) =
    print(io, "You called $(err.original), maybe you intended to call $(err.substitute) instead?")

function compile_method_instance(job::CompilerJob, method_instance::Core.MethodInstance, world)
        function postprocess(ir)
        # get rid of jfptr wrappers
        for llvmf in functions(ir)
            startswith(LLVM.name(llvmf), "jfptr_") && unsafe_delete!(ir, llvmf)
        end

        return
    end

    # set-up the compiler interface
    last_method_instance = nothing
    call_stack = Vector{Core.MethodInstance}()
    dependencies = MultiDict{Core.MethodInstance,LLVM.Function}()
    function hook_module_setup(ref::Ptr{Cvoid})
        ref = convert(LLVM.API.LLVMModuleRef, ref)
        ir = LLVM.Module(ref)
        module_setup(ir)
    end

    function hook_module_activation(ref::Ptr{Cvoid})
        ref = convert(LLVM.API.LLVMModuleRef, ref)
        ir = LLVM.Module(ref)
        postprocess(ir)

        # find the function that this module defines
        llvmfs = filter(llvmf -> !isdeclaration(llvmf) &&
                                 linkage(llvmf) == LLVM.API.LLVMExternalLinkage,
                        collect(functions(ir)))

        llvmf = nothing
        if length(llvmfs) == 1
            llvmf = first(llvmfs)
        elseif length(llvmfs) > 1
            llvmfs = filter!(llvmf -> startswith(LLVM.name(llvmf), "julia_"), llvmfs)
            if length(llvmfs) == 1
                llvmf = first(llvmfs)
            end
        end

        @compiler_assert llvmf !== nothing job

        insert!(dependencies, last_method_instance, llvmf)
    end
    function hook_emit_function(method_instance, code, world)
        push!(call_stack, method_instance)

        # check for recursion
        if method_instance in call_stack[1:end-1]
            throw(KernelError(job, "recursion is currently not supported";
                              bt=backtrace(job, call_stack)))
        end

        # check for Base methods that exist in AMDGPUnative too
        # FIXME: this might be too coarse
        method = method_instance.def
        if Base.moduleroot(method.module) == Base &&
           isdefined(AMDGPUnative, method_instance.def.name)
            substitute_function = getfield(AMDGPUnative, method.name)
            tt = Tuple{method_instance.specTypes.parameters[2:end]...}
            if hasmethod(substitute_function, tt)
                method′ = which(substitute_function, tt)
                if Base.moduleroot(method′.module) == AMDGPUnative
                    @warn "calls to Base intrinsics might be GPU incompatible" exception=(MethodSubstitutionWarning(method, method′), backtrace(job, call_stack))
                end
            end
        end
    end
    function hook_emitted_function(method, code, world)
        @compiler_assert last(call_stack) == method job
        last_method_instance = pop!(call_stack)
    end

    param_kwargs = [:cached             => false,
                    :track_allocations  => false,
                    :code_coverage      => false,
                    :static_alloc       => false,
                    :prefer_specsig     => true,
                    :module_setup       => hook_module_setup,
                    :module_activation  => hook_module_activation,
                    :emit_function      => hook_emit_function,
                    :emitted_function   => hook_emitted_function]
    if LLVM.version() >= v"8.0" && VERSION >= v"1.3.0-DEV.547"
        push!(param_kwargs, :gnu_pubnames => false)

        debug_info_kind = if Base.JLOptions().debug_level == 0
            LLVM.API.LLVMDebugEmissionKindNoDebug
        elseif Base.JLOptions().debug_level == 1
            LLVM.API.LLVMDebugEmissionKindDebugDirectivesOnly
        elseif Base.JLOptions().debug_level >= 2
            LLVM.API.LLVMDebugEmissionKindFullDebug
        end
        push!(param_kwargs, :debug_info_kind => Cint(debug_info_kind))
    end
    params = Base.CodegenParams(;param_kwargs...)

    # get the code
    ref = ccall(:jl_get_llvmf_defn, LLVM.API.LLVMValueRef,
                (Any, UInt, Bool, Bool, Base.CodegenParams),
                method_instance, world, #=wrapper=#false, #=optimize=#false, params)
    if ref == C_NULL
        throw(InternalCompilerError(job, "the Julia compiler could not generate LLVM IR"))
    end
    llvmf = LLVM.Function(ref)
    ir = LLVM.parent(llvmf)
    postprocess(ir)

    return llvmf, dependencies
end

function irgen(job::CompilerJob, method_instance::Core.MethodInstance, world)
    entry, dependencies = @timeit to[] "emission" compile_method_instance(job, method_instance, world)
    mod = LLVM.parent(entry)

    # link in dependent modules
    @timeit to[] "linking" begin
        # We disable Julia's compilation cache not to poison it with GPU-specific code.
        # as a result, we might get multiple modules for a single method instance.
        cache = Dict{String,String}()

        for called_method_instance in keys(dependencies)
            llvmfs = dependencies[called_method_instance]

            # link the first module
            llvmf = popfirst!(llvmfs)
            llvmfn = LLVM.name(llvmf)
            link!(mod, LLVM.parent(llvmf))

            # process subsequent duplicate modules
            for dup_llvmf in llvmfs
                if Base.JLOptions().debug_level >= 2
                    # link them too, to ensure accurate backtrace reconstruction
                    link!(mod, LLVM.parent(dup_llvmf))
                else
                    # don't link them, but note the called function name in a cache
                    dup_llvmfn = LLVM.name(dup_llvmf)
                    cache[dup_llvmfn] = llvmfn
                end
            end
        end

        # resolve function declarations with cached entries
        for llvmf in filter(isdeclaration, collect(functions(mod)))
            llvmfn = LLVM.name(llvmf)
            if haskey(cache, llvmfn)
                def_llvmfn = cache[llvmfn]
                replace_uses!(llvmf, functions(mod)[def_llvmfn])
                @compiler_assert isempty(uses(llvmf)) job
                unsafe_delete!(LLVM.parent(llvmf), llvmf)
            end
        end
    end

    # clean up incompatibilities
    @timeit to[] "clean-up" for llvmf in functions(mod)
        llvmfn = LLVM.name(llvmf)

        # only occurs in debug builds
        delete!(function_attributes(llvmf), EnumAttribute("sspstrong", 0, JuliaContext()))

        # rename functions
        if !isdeclaration(llvmf)
            # Julia disambiguates local functions by prefixing with `#\d#`.
            # since we don't use a global function namespace, get rid of those tags.
            if occursin(r"^julia_#\d+#", llvmfn)
                llvmfn′ = replace(llvmfn, r"#\d+#"=>"")
                if !haskey(functions(mod), llvmfn′)
                    LLVM.name!(llvmf, llvmfn′)
                    llvmfn = llvmfn′
                end
            end

            # anonymous functions are just named `#\d`, make that somewhat more readable
            m = match(r"_#(\d+)_", llvmfn)
            if m !== nothing
                llvmfn′ = replace(llvmfn, m.match=>"_anonymous$(m.captures[1])_")
                LLVM.name!(llvmf, llvmfn′)
                llvmfn = llvmfn′
            end
        end
    end

    # add the global exception indicator flag
    emit_exception_flag!(mod)

    # rename the entry point
    if job.name !== nothing
        llvmfn = string("julia_", job.name)
    else
        llvmfn = replace(LLVM.name(entry), r"_\d+$"=>"")
    end

    ## append a global unique counter
    global globalUnique
    globalUnique += 1
    llvmfn *= "_$globalUnique"
    LLVM.name!(entry, llvmfn)

    # minimal required optimization
    @timeit to[] "rewrite" ModulePassManager() do pm
        global current_job
        current_job = job

        linkage!(entry, LLVM.API.LLVMExternalLinkage)
        internalize!(pm, [LLVM.name(entry)])
        add!(pm, ModulePass("LowerThrow", lower_throw!))
        always_inliner!(pm)
        run!(pm, mod)
    end

    return mod, entry
end

# This pass lowers `jl_throw` and friends to GPU-compatible exceptions.
# This isn't strictly necessary, but has a couple of advantages:
# - We can kill off unused exception arguments that otherwise would allocate or invoke
# - We can fake debug information (lacking a stack unwinder)
#
# Once we have thorough inference (ie. discarding `@nospecialize` and thus
# supporting exception arguments) and proper debug info to unwind the stack,
# this pass can go.
function lower_throw!(mod::LLVM.Module)
    job = current_job::CompilerJob
    changed = false
    @timeit to[] "lower throw" begin

    throw_functions = Dict{String,String}(
        "jl_throw"                      => "exception",
        "jl_error"                      => "error",
        "jl_too_few_args"               => "too few arguments exception",
        "jl_too_many_args"              => "too many arguments exception",
        "jl_type_error_rt"              => "type error",
        "jl_undefined_var_error"        => "undefined variable error",
        "jl_bounds_error"               => "bounds error",
        "jl_bounds_error_v"             => "bounds error",
        "jl_bounds_error_int"           => "bounds error",
        "jl_bounds_error_tuple_int"     => "bounds error",
        "jl_bounds_error_unboxed_int"   => "bounds error",
        "jl_bounds_error_ints"          => "bounds error",
        "jl_eof_error"                  => "EOF error"
    )

    for (fn, name) in throw_functions
        if haskey(functions(mod), fn)
            f = functions(mod)[fn]

            for use in uses(f)
                call = user(use)::LLVM.CallInst

                # replace the throw with a GCN-compatible exception
                let builder = Builder(JuliaContext())
                    position!(builder, call)
                    emit_exception!(builder, name, call)
                    dispose(builder)
                end

                # remove the call
                call_args = collect(operands(call))[1:end-1] # last arg is function itself
                unsafe_delete!(LLVM.parent(call), call)

                # HACK: kill the exceptions' unused arguments
                for arg in call_args
                    # peek through casts
                    if isa(arg, LLVM.AddrSpaceCastInst)
                        cast = arg
                        arg = first(operands(cast))
                        isempty(uses(cast)) && unsafe_delete!(LLVM.parent(cast), cast)
                    end

                    if isa(arg, LLVM.Instruction) && isempty(uses(arg))
                        unsafe_delete!(LLVM.parent(arg), arg)
                    end
                end

                changed = true
            end

            @compiler_assert isempty(uses(f)) job
         end
    end

    end
    return changed
end

# `emit_exception!()` reports an exception in a GPU-compatible manner.
#
# The exact behavior depends on the debug level. In all cases, a `trap` will 
# be emitted. On debug level 1, the exception name will be printed, and on debug 
# level 2 the individual stack frames (as recovered from the LLVM debug
# information) will be printed as well.
function emit_exception!(builder, name, inst)
    bb = position(builder)
    fun = LLVM.parent(bb)
    mod = LLVM.parent(fun)

    # report the exception
    if Base.JLOptions().debug_level >= 1
        name = globalstring_ptr!(builder, name, "exception")
        if Base.JLOptions().debug_level == 1
            call!(builder, Runtime.get(:report_exception), [name])
        else
            call!(builder, Runtime.get(:report_exception_name), [name])
        end
    end

    # report each frame
    if Base.JLOptions().debug_level >= 2
        rt = Runtime.get(:report_exception_frame)
        bt = backtrace(inst)
        for (i,frame) in enumerate(bt)
            idx = ConstantInt(rt.llvm_types[1], i)
            func = globalstring_ptr!(builder, String(frame.func), "di_func")
            file = globalstring_ptr!(builder, String(frame.file), "di_file")
            line = ConstantInt(rt.llvm_types[4], frame.line)
            call!(builder, rt, [idx, func, file, line])
        end
    end

    # signal the exception
    call!(builder, Runtime.get(:signal_exception))

    trap = if haskey(functions(mod), "llvm.trap")
        functions(mod)["llvm.trap"]
    else
        LLVM.Function(mod, "llvm.trap", LLVM.FunctionType(LLVM.VoidType(JuliaContext())))
    end
    call!(builder, trap)
end

# `emit_exception_flag!` emits a global variable for storing the current
# exception status. Since we don't actually support globals, access to this
# variable is done by calling the amdgpunativeExceptionFlag function, which
# is lowered here to actual accesses of the variable.
function emit_exception_flag!(mod::LLVM.Module)
    # add the global variable
    T_ptr = convert(LLVMType, Ptr{Cvoid})
    gv = GlobalVariable(mod, T_ptr, "exception_flag")
    initializer!(gv, LLVM.ConstantInt(T_ptr, 0))
    linkage!(gv, LLVM.API.LLVMWeakAnyLinkage)
    extinit!(gv, true)

    # lower uses of the getter
    if haskey(functions(mod), "amdgpunativeExceptionFlag")
        buf_getter = functions(mod)["amdgpunativeExceptionFlag"]
        @assert return_type(eltype(llvmtype(buf_getter))) == eltype(llvmtype(gv))

        # find uses
        worklist = Vector{LLVM.CallInst}()
        for use in uses(buf_getter)
            call = user(use)::LLVM.CallInst
            push!(worklist, call)
        end

        # replace uses by a load from the global variable
        for call in worklist
            Builder(JuliaContext()) do builder
                position!(builder, call)
                ptr = load!(builder, gv)
                replace_uses!(call, ptr)
            end
            unsafe_delete!(LLVM.parent(call), call)
        end
    end
end

