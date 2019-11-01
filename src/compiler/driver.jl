# compiler driver and main interface

# (::CompilerJob)
const compile_hook = Ref{Union{Nothing,Function}}(nothing)

"""
    compile(target::Symbol, agent::HSAAgent, f, tt, kernel=true;
            libraries=true, optimize=true, strip=false, strict=true, ...)
Compile a function `f` invoked with types `tt` for agent `agent` to one of the
following formats as specified by the `target` argument: `:julia` for Julia
IR, `:llvm` for LLVM IR, `:gcn` for GCN assembly, and `:roc` for linked
objects. If the `kernel` flag is set, specialized code generation and
optimization for kernel functions is enabled.
The following keyword arguments are supported:
- `libraries`: link the ROCm device libraries (if required)
- `optimize`: optimize the code (default: true)
- `strip`: strip non-functional metadata and debug information (default: false)
- `strict`: perform code validation either as early or as late as possible
Other keyword arguments can be found in the documentation of [`rocfunction`](@ref).
"""
compile(target::Symbol, agent::HSAAgent, @nospecialize(f::Core.Function),
                 @nospecialize(tt), kernel::Bool=true; libraries::Bool=true,
                 optimize::Bool=true, strip::Bool=false, strict::Bool=true, kwargs...) =

                 compile(target, CompilerJob(f, tt, agent, kernel; kwargs...);
                         libraries=libraries, optimize=optimize, strip=strip,
                         strict=strict)

function compile(target::Symbol, job::CompilerJob; libraries::Bool=true,
                 optimize::Bool=true, strip::Bool=false, strict::Bool=true)
    @debug "(Re)compiling function" job

    if compile_hook[] != nothing
        global globalUnique
        previous_globalUnique = globalUnique

        compile_hook[](job)

        globalUnique = previous_globalUnique
    end

    return codegen(target, job;
                   libraries=libraries,
                   optimize=optimize, strip=strip, strict=strict)
end

function codegen(target::Symbol, job::CompilerJob; libraries::Bool=true, 
                 optimize::Bool=true, strip::Bool=false, strict::Bool=true)
    ## Julia IR

    @timeit to[] "validation" check_method(job)

    @timeit to[] "Julia front-end" begin

        # get the method instance
        world = typemax(UInt)
        meth = which(job.f, job.tt)
        sig = Base.signature_type(job.f, job.tt)::Type
        (ti, env) = ccall(:jl_type_intersection_with_env, Any,
                          (Any, Any), sig, meth.sig)::Core.SimpleVector
        if VERSION >= v"1.2.0-DEV.320"
            meth = Base.func_for_method_checked(meth, ti, env)
        else
            meth = Base.func_for_method_checked(meth, ti)
        end
        method_instance = ccall(:jl_specializations_get_linfo, Ref{Core.MethodInstance},
                      (Any, Any, Any, UInt), meth, ti, env, world)

        for var in env
            if var isa TypeVar
                throw(KernelError(job, "method captures a typevar (you probably use an unbound type variable)"))
            end
        end
    end

    target == :julia && return method_instance

    # LLVM IR

    defs(mod)  = filter(f -> !isdeclaration(f), collect(functions(mod)))
    decls(mod) = filter(f ->  isdeclaration(f) && intrinsic_id(f) == 0,
                        collect(functions(mod)))
    need_library(mod, lib) = any(f -> isdeclaration(f) &&
                                      intrinsic_id(f) == 0 &&
                                      haskey(functions(lib), LLVM.name(f)),
                                      functions(mod))

    # always preload the runtime, and do so early; it cannot be part of any timing block
    # because it recurses into the compiler
    if libraries
        runtime = load_runtime(job.agent)
        runtime_fns = LLVM.name.(defs(runtime))
    end

    @timeit to[] "LLVM middle-end" begin
        ir, kernel = @timeit to[] "IR generation" irgen(job, method_instance, world)

        if libraries
            undefined_fns = LLVM.name.(decls(ir))
            #= FIXME: Remove this "__nv_" check
            #
            if any(fn->startswith(fn, "__nv_"), undefined_fns)
                libdevice = load_libdevice(job.cap)
                @timeit to[] "device library" link_libdevice!(job, ir, libdevice)
            end
            =#
            # FIXME: Load this only when needed
            device_libs = load_device_libs(job.agent)
            for lib in device_libs
                if need_library(ir, lib)
                    @timeit to[] "device library" link_device_lib!(job, ir, lib)
                end
            end
            @timeit to[] "oclc defaults" link_oclc_defaults!(job, ir)
        end

        if optimize
            kernel = @timeit to[] "optimization" optimize!(job, ir, kernel)
        end

        if libraries
            undefined_fns = LLVM.name.(decls(ir))
            if any(fn -> fn in runtime_fns, undefined_fns)
                @timeit to[] "runtime library" link_library!(job, ir, runtime)
            end
        end

        if ccall(:jl_is_debugbuild, Cint, ()) == 1
            @timeit to[] "verification" verify(ir)
        end

        kernel_fn = LLVM.name(kernel)
    end

    if strict
        # NOTE: keep in sync with non-strict check below
        @timeit to[] "validation" begin
            check_invocation(job, kernel)
            check_ir(job, ir)
        end
    end

    if strip
        @timeit to[] "strip debug info" strip_debuginfo!(ir)
    end

    target == :llvm && return ir, kernel

    # GCN machine code

    @timeit to[] "LLVM back-end" begin
        @timeit to[] "preparation" prepare_execution!(job, ir)

        if target == :gcn_asm
            asm = @timeit to[] "machine-code generation (assembly)" mcgen(job, ir, kernel; output_format = LLVM.API.LLVMAssemblyFile)
        else
            asm = @timeit to[] "machine-code generation (object)" mcgen(job, ir, kernel)
        end
    end

    (target == :gcn || target == :gcn_asm) && return asm, kernel_fn

    # Executables

    if !strict
        # NOTE: keep in sync with strict check above
        @timeit to[] "validation" begin
            check_invocation(job, kernel)
            check_ir(job, ir)
        end
    end

    # FIXME: Pull the ld linking functionality into this code block?
    @timeit to[] "Executable generation" begin
        # enable debug options based on Julia's debug setting
        jit_options = Dict{Any,Any}()
        #= FIXME: Debug options
        if Base.JLOptions().debug_level == 1
            jit_options[CUDAdrv.GENERATE_LINE_INFO] = true
        elseif Base.JLOptions().debug_level >= 2
            jit_options[CUDAdrv.GENERATE_DEBUG_INFO] = true
        end
        =#

        @timeit to[] "compilation" begin
            roc_mod = ROCModule(collect(codeunits(asm)), jit_options)
            roc_fun = ROCFunction(roc_mod, kernel_fn)
        end
    end

    target == :roc && return roc_fun, roc_mod


    error("Unknown compilation target $target")
end

