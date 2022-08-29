## exception codegen

import AMDGPU: ExceptionEntry, HostCall

# emit a global variable for storing the current exception status
function emit_exception_user!(mod::LLVM.Module)
    # add a fake user for __ockl_hsa_signal_store and __ockl_hsa_signal_load
    if !haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
        ctx = LLVM.context(mod)
        #Context() do ctx
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
                ret!(builder)
            end
        #end
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

## GPUCompiler interface

struct ROCCompilerParams <: AbstractCompilerParams
    device::HSAAgent
    global_hooks::NamedTuple
end

ROCCompilerJob = CompilerJob{GCNCompilerTarget,ROCCompilerParams}


GPUCompiler.runtime_module(::ROCCompilerJob) = AMDGPU

# filter out functions from device libs
GPUCompiler.isintrinsic(job::ROCCompilerJob, fn::String) =
    invoke(GPUCompiler.isintrinsic,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(fn)},
           job, fn) ||
    startswith(fn, "rocm")

function GPUCompiler.process_module!(job::ROCCompilerJob, mod::LLVM.Module)
    invoke(GPUCompiler.process_module!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod)},
           job, mod)
    # Run this early (before optimization) to ensure we link OCKL
    emit_exception_user!(mod)
end
function GPUCompiler.finish_module!(job::ROCCompilerJob, mod::LLVM.Module)
    invoke(GPUCompiler.finish_module!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod)},
           job, mod)
    delete_exception_user!(mod)
end

function GPUCompiler.link_libraries!(job::ROCCompilerJob, mod::LLVM.Module,
                                     undefined_fns::Vector{String})
    invoke(GPUCompiler.link_libraries!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(undefined_fns)},
           job, mod, undefined_fns)

    link_device_libs!(job.target, mod)
end

GPUCompiler.ci_cache(::ROCCompilerJob) = AMDGPU.ci_cache

GPUCompiler.method_table(::ROCCompilerJob) = AMDGPU.method_table

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
function rocfunction(f::Core.Function, tt::Type=Tuple{}; name=nothing, device=AMDGPU.default_device(), global_hooks=NamedTuple(), kwargs...)
    source = FunctionSpec(f, tt, true, name)
    cache = get!(()->Dict{UInt,Any}(), rocfunction_cache, device)
    isa = AMDGPU.default_isa(device)
    arch = Runtime.architecture(isa)
    feat = Runtime.features(isa)
    target = GCNCompilerTarget(; dev_isa=arch, features=feat)
    params = ROCCompilerParams(device, global_hooks)
    job = CompilerJob(target, source, params)
    GPUCompiler.cached_compilation(cache, job, rocfunction_compile, rocfunction_link)::Runtime.HostKernel{typeof(f),tt}
end

const rocfunction_cache = Dict{HSAAgent,Dict{UInt,Any}}()

# compile to GCN
function rocfunction_compile(@nospecialize(job::CompilerJob))
    # compile
    method_instance, mi_meta = GPUCompiler.emit_julia(job)
    JuliaContext() do ctx
        ir, ir_meta = GPUCompiler.emit_llvm(job, method_instance; ctx)
        kernel = ir_meta.entry

        obj, obj_meta = GPUCompiler.emit_asm(job, ir; format=LLVM.API.LLVMObjectFile)

        # find undefined globals and calculate sizes
        globals = map(gbl->Symbol(LLVM.name(gbl))=>llvmsize(eltype(llvmtype(gbl))),
                      filter(x->isextinit(x), collect(LLVM.globals(ir))))
        entry = LLVM.name(kernel)
        dispose(ir)

        return (;obj, entry, globals)
    end
end
function rocfunction_link(@nospecialize(job::CompilerJob), compiled)
    device = job.params.device
    global_hooks = job.params.global_hooks
    obj, entry, globals = compiled.obj, compiled.entry, compiled.globals

    # create executable and kernel
    obj = codeunits(obj)
    exe = AMDGPU.create_executable(device, entry, obj; globals=globals)
    mod = ROCModule(exe)
    fun = ROCFunction(mod, entry)
    kernel = Runtime.HostKernel{job.source.f,job.source.tt}(mod, fun)

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
            gbl = Runtime.get_global(exe, gname)
            hook(gbl, mod, device)
        else
            @debug "Uninitialized global $gname"
            continue
        end
    end

    return kernel
end

const default_global_hooks = Dict{Symbol,Function}()

default_global_hooks[:__global_output_context] = (gbl, mod, device) -> begin
    # initialize global output context
    gbl_ptr = Base.unsafe_convert(Ptr{AMDGPU.GLOBAL_OUTPUT_CONTEXT_TYPE}, gbl)
    oc = AMDGPU.OutputContext(stdout)
    Base.unsafe_store!(gbl_ptr, oc)
end
default_global_hooks[:__global_printf_context] = (gbl, mod, device) -> begin
    # initialize global printf context
    # Return type of Int to force synchronizing behavior
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Int,Tuple{LLVMPtr{UInt8,AS.Global}}}}, gbl)
    hc = HostCall(Int, Tuple{LLVMPtr{UInt8,AS.Global}}; agent=device, continuous=true, buf_len=2^16) do _
        fmt, args = unsafe_load(reinterpret(LLVMPtr{ROCPrintfBuffer,AS.Global}, hc.buf_ptr))
        args = map(x->x isa Cstring ? unsafe_string(x) : x, args)
        @debug "@rocprintf with $fmt and $(args)"
        @eval @printf($fmt, $(args...))
        return 0
    end
    Base.unsafe_store!(gbl_ptr, hc)
end
default_global_hooks[:__global_exception_flag] = (gbl, mod, device) -> begin
    # initialize global exception flag
    gbl_ptr = Base.unsafe_convert(Ptr{Int64}, gbl)
    Base.unsafe_store!(gbl_ptr, 0)
end
default_global_hooks[:__global_exception_ring] = (gbl, mod, device) -> begin
    # initialize exception ring buffer
    gbl_ptr = Base.unsafe_convert(Ptr{Ptr{ExceptionEntry}}, gbl)
    ex_ptr = Base.unsafe_convert(Ptr{ExceptionEntry}, mod.exceptions)
    unsafe_store!(gbl_ptr, ex_ptr)
    # setup initial slots
    for i in 1:Runtime.MAX_EXCEPTIONS-1
        unsafe_store!(ex_ptr, ExceptionEntry(0, LLVMPtr{UInt8,1}(0)))
        ex_ptr += sizeof(ExceptionEntry)
    end
    # setup tail slot
    unsafe_store!(ex_ptr, ExceptionEntry(1, LLVMPtr{UInt8,1}(0)))
end
default_global_hooks[:__global_malloc_hostcall] = (gbl, mod, device) -> begin
    # initialize malloc hostcall
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Ptr{Cvoid},Tuple{UInt64,Csize_t}}}, gbl)
    hc = HostCall(Ptr{Cvoid}, Tuple{UInt64,Csize_t}; agent=device, continuous=true) do kern, sz
        buf = Mem.alloc(device, sz; coherent=true)
        ptr = buf.ptr
        push!(mod.metadata, Runtime.KernelMetadata(kern, buf))
        @debug "Allocated $ptr ($sz bytes) for kernel $kern on device $device"
        return ptr
    end
    Base.unsafe_store!(gbl_ptr, hc)
end
default_global_hooks[:__global_free_hostcall] = (gbl, mod, device) -> begin
    # initialize free hostcall
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Nothing,Tuple{UInt64,Ptr{Cvoid}}}}, gbl)
    hc = HostCall(Nothing, Tuple{UInt64,Ptr{Cvoid}}; agent=device, continuous=true) do kern, ptr
        for idx in length(mod.metadata):-1:1
            if mod.metadata[idx].kern == kern && mod.metadata[idx].buf.ptr == ptr
                sz = mod.metadata[idx].buf.bytesize
                Mem.free(mod.metadata[idx].buf)
                deleteat!(mod.metadata, idx)
                @debug "Freed $ptr ($sz bytes) for kernel $kern on device $device"
                break
            end
        end
        return nothing
    end
    Base.unsafe_store!(gbl_ptr, hc)
end
