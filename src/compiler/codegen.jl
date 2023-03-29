import .Device: ExceptionEntry, HostCall

## GPUCompiler interface

struct ROCCompilerParams <: AbstractCompilerParams
    device::ROCDevice
    global_hooks::NamedTuple
end

const ROCCompilerConfig = CompilerConfig{GCNCompilerTarget, ROCCompilerParams}
const ROCCompilerJob = CompilerJob{GCNCompilerTarget, ROCCompilerParams}

# Caches for GPUCompiler.
const _compiler_cache = Dict{ROCDevice, Dict{UInt, Any}}()
const _compiler_configs = Dict{UInt, ROCCompilerConfig}()
const _kernel_instances = Dict{UInt, Any}() # HostKernel

function compiler_cache(dev::ROCDevice)
    get!(() -> Dict{UInt, Any}(), _compiler_cache, dev)
end

function compiler_config(dev::ROCDevice; kwargs...)
    h = hash(dev, hash(kwargs))
    get!(() -> _compiler_config(dev; kwargs...), _compiler_configs, h)
end
function _compiler_config(
    dev::ROCDevice; global_hooks, kernel::Bool = true, name=nothing,
    always_inline=true, kwargs...,
)
    isa = AMDGPU.default_isa(dev)
    dev_isa, features = Runtime.llvm_arch_features(isa)

    target = GCNCompilerTarget(; dev_isa, features)
    params = ROCCompilerParams(dev, global_hooks)
    CompilerConfig(target, params; kernel, name, always_inline)
end

GPUCompiler.runtime_module(@nospecialize(::ROCCompilerJob)) = AMDGPU

GPUCompiler.ci_cache(@nospecialize(::ROCCompilerJob)) = AMDGPU.ci_cache

GPUCompiler.method_table(@nospecialize(::ROCCompilerJob)) = AMDGPU.method_table

# filter out functions from device libs
GPUCompiler.isintrinsic(@nospecialize(job::ROCCompilerJob), fn::String) =
    invoke(GPUCompiler.isintrinsic,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(fn)},
           job, fn) ||
    startswith(fn, "rocm")

function GPUCompiler.process_module!(@nospecialize(job::ROCCompilerJob), mod::LLVM.Module)
    invoke(GPUCompiler.process_module!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod)},
           job, mod)
    # Run this early (before optimization) to ensure we link OCKL
    emit_exception_user!(mod)
end
function GPUCompiler.process_entry!(@nospecialize(job::ROCCompilerJob), mod::LLVM.Module, entry::LLVM.Function)
    invoke(GPUCompiler.process_entry!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(entry)},
           job, mod, entry)
    # Workaround for the lack of zeroinitializer support for LDS
    zeroinit_lds!(mod, entry)
end
function GPUCompiler.finish_module!(@nospecialize(job::ROCCompilerJob), mod::LLVM.Module)
    invoke(GPUCompiler.finish_module!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod)},
           job, mod)
    delete_exception_user!(mod)
end

function GPUCompiler.link_libraries!(
    @nospecialize(job::ROCCompilerJob), mod::LLVM.Module,
    undefined_fns::Vector{String},
)
    invoke(GPUCompiler.link_libraries!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(undefined_fns)},
           job, mod, undefined_fns)
    link_device_libs!(job.config.target, mod)
end

const rocfunction_lock = ReentrantLock()

"""
    rocfunction(f, tt=Tuple{}; kwargs...)

Low-level interface to compile a function invocation for the currently-active
GPU, returning a callable kernel object. For a higher-level interface, use
[`@roc`](@ref).

The following keyword arguments are supported:
- `name`: overrides the name that the kernel will have in the generated code
- `device`: chooses which device to compile the kernel for
- `global_hooks`: specifies maps from global variable name to initializer hook

The output of this function is automatically cached, i.e. you can simply call
`rocfunction` in a hot path without degrading performance. New code will be
generated automatically, when function definitions change, or when different
types or keyword arguments are provided.
"""
function rocfunction(
    f::F, tt::Type = Tuple{}; device::ROCDevice = AMDGPU.default_device(),
    global_hooks = NamedTuple(), kwargs...,
) where {F <: Core.Function}
    Base.@lock rocfunction_lock begin
        @debug "Compiling $f($(join(tt.parameters, ", ")))"
        Runtime.@log_start(:cached_compile, (;f=F, tt), nothing)

        cache = compiler_cache(device)
        config = compiler_config(device; global_hooks, kwargs...)
        fun = GPUCompiler.cached_compilation(
            cache, config, F, tt, compile, link)::ROCFunction

        h = hash(fun, hash(f, hash(tt)))
        kernel = get(_kernel_instances, h, Runtime.HostKernel{F,tt}(f, fun.mod, fun))
        Runtime.@log_finish(:cached_compile, (;f=F, tt), nothing)
        return kernel::Runtime.HostKernel{F,tt}
    end
end

# compile to GCN
function compile(@nospecialize(job::CompilerJob))
    # compile
    Runtime.@log_start(:compile, (;f=job.source.ft, tt=job.source.tt), nothing)

    method_instance, mi_meta = GPUCompiler.emit_julia(job)
    JuliaContext() do ctx
        ir, ir_meta = GPUCompiler.emit_llvm(job, method_instance; ctx)
        kernel = ir_meta.entry

        obj, obj_meta = GPUCompiler.emit_asm(job, ir; format=LLVM.API.LLVMObjectFile)

        # find undefined globals and calculate sizes
        globals = map(gbl->Symbol(LLVM.name(gbl))=>llvmsize(eltype(llvmtype(gbl))),
                      filter!(x->isextinit(x), collect(LLVM.globals(ir))))
        entry = LLVM.name(kernel)

        dispose(ir)

        Runtime.@log_finish(:compile, (;f=job.source.ft, tt=job.source.tt), nothing)

        return (;obj, entry, globals)
    end
end
function link(@nospecialize(job::CompilerJob), compiled)
    Runtime.@log_start(:link, (;f=job.source.ft, tt=job.source.tt), nothing)
    device = job.config.params.device
    global_hooks = job.config.params.global_hooks
    (;obj, entry, globals) = compiled

    # create executable and kernel
    obj = codeunits(obj)
    exe = AMDGPU.create_executable(device, entry, obj; globals=globals)
    mod = ROCModule(exe)
    fun = ROCFunction(mod, entry, hash(job.source, UInt64(0)))

    # initialize globals from hooks
    for gname in first.(globals)
        hook = nothing
        if haskey(default_global_hooks, gname)
            hook = default_global_hooks[gname]
        elseif haskey(global_hooks, gname)
            hook = global_hooks[gname]
        end
        if hook !== nothing
            @debug "Initializing global $gname"
            Runtime.@log_start(:global_init, (;f=job.source.ft, tt=job.source.tt, gname), nothing)
            gbl = Runtime.get_global(exe, gname)
            hook(gbl, mod, device)
            Runtime.@log_finish(:global_init, (;f=job.source.ft, tt=job.source.tt, gname), nothing)
        else
            @debug "Uninitialized global $gname"
            continue
        end
    end

    Runtime.@log_finish(:link, (;f=job.source.ft, tt=job.source.tt), nothing)
    return fun
end

function zeroinit_lds!(mod::LLVM.Module, entry::LLVM.Function)
    if LLVM.callconv(entry) != LLVM.API.LLVMAMDGPUKERNELCallConv
        return entry
    end
    to_init = []
    for gbl in LLVM.globals(mod)
        if startswith(LLVM.name(gbl), "__zeroinit")
            as = LLVM.addrspace(llvmtype(gbl))
            if as == AMDGPU.Device.AS.Local
                push!(to_init, gbl)
            end
        end
    end
    if length(to_init) > 0
        ctx = LLVM.context(mod)
        T_void = LLVM.VoidType(ctx)
        LLVM.@dispose builder=LLVM.Builder(ctx) begin
            # Make these the first operations we do
            position!(builder, first(LLVM.instructions(first(LLVM.blocks(entry)))))

            # Use memset to clear all values to 0
            for gbl in to_init
                sz = llvmsize(eltype(llvmtype(gbl)))
                if sz > 0
                    LLVM.memset!(builder, gbl, ConstantInt(UInt8(0); ctx), ConstantInt(sz; ctx), LLVM.alignment(gbl))
                end
            end

            # Synchronize the workgroup to prevent races
            sync_f = LLVM.Function(mod, LLVM.Intrinsic("llvm.amdgcn.s.barrier"))
            call!(builder, sync_f)
        end
    end

    return entry
end

## exception codegen
# emit a global variable for storing the current exception status
function emit_exception_user!(mod::LLVM.Module)
    # add a fake user for __ockl_hsa_signal_store and __ockl_hsa_signal_load
    if !haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
        ctx = LLVM.context(mod)
        ft = LLVM.FunctionType(LLVM.VoidType(ctx))
        fn = LLVM.Function(mod, "__fake_global_exception_flag_user", ft)
        Builder(ctx) do builder
            entry = BasicBlock(fn, "entry"; ctx)
            position!(builder, entry)
            T_nothing = LLVM.VoidType(ctx)
            T_i32 = LLVM.Int32Type(ctx)
            T_i64 = LLVM.Int64Type(ctx)
            T_signal_store = LLVM.FunctionType(T_nothing, [T_i64, T_i64, T_i32])
            signal_store = LLVM.Function(mod, "__ockl_hsa_signal_store", T_signal_store)
            call!(builder, signal_store, [ConstantInt(0; ctx),
                                          ConstantInt(0; ctx),
                                          # __ATOMIC_RELEASE == 3
                                          ConstantInt(Int32(3); ctx)])
            T_signal_load = LLVM.FunctionType(T_i64, [T_i64, T_i32])
            signal_load = LLVM.Function(mod, "__ockl_hsa_signal_load", T_signal_load)
            loaded_value = call!(builder, signal_load, [ConstantInt(0; ctx),
                                                        # __ATOMIC_ACQUIRE == 2
                                                        ConstantInt(Int32(2); ctx)])
            T_signal_cas = LLVM.FunctionType(T_i64, [T_i64, T_i64, T_i64, T_i32])
            signal_cas = LLVM.Function(mod, "__ockl_hsa_signal_cas", T_signal_cas)
            loaded_value = call!(builder, signal_cas, [ConstantInt(0; ctx),
                                                       ConstantInt(0; ctx),
                                                       ConstantInt(0; ctx),
                                                       # __ATOMIC_ACQ_REL == 4
                                                       ConstantInt(Int32(4); ctx)])
            ret!(builder)
        end
    end
    @assert haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
end
function delete_exception_user!(mod::LLVM.Module)
    fns = LLVM.functions(mod)
    if haskey(fns, "__fake_global_exception_flag_user")
        unsafe_delete!(mod, fns["__fake_global_exception_flag_user"])
    end
    @assert !haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
end
