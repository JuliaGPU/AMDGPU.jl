struct HIPCompilerParams <: AbstractCompilerParams
    # Whether to compile kernel for the wavefront of size 64.
    wavefrontsize64::Bool
    # Whether floating-point atomic RMW operations may ignore the denormal mode,
    # which lets some targets use hardware instructions instead of CAS loops.
    unsafe_fp_atomics::Bool
    # Whether atomic RMW operations with a scope narrower than system scope may assume
    # that they access neither fine-grained nor remote memory, which lets the back-end
    # use native instructions instead of CAS loops.
    atomic_memory_assumptions::Bool
end

const HIPCompilerConfig = CompilerConfig{GCNCompilerTarget, HIPCompilerParams}
const HIPCompilerJob = CompilerJob{GCNCompilerTarget, HIPCompilerParams}

"""
    HIPResults

Cached compilation results for a HIP kernel job, managed by `GPUCompiler.cached_results`.

Session-portable artifacts (the lld-linked shared object `obj`, the entry-point name `entry`,
the detected `global_hostcalls`, and the `relocations` manifest describing the host addresses
the loader must patch into the loaded image) are populated after codegen and
persist across sessions (e.g. through package precompilation).

The session-local `functions` are `HIPFunction` handles linked onto a specific device,
they are device-specific and never populated during precompilation.

`obj === nothing` identifies a job that has not been compiled yet.

`functions` is a small linear cache of `(HIPDevice, HIPFunction)` pairs, matching the
old per-device cache semantics; the scan is almost always over a single entry.
"""
mutable struct HIPResults
    # session-portable artifacts
    obj::Union{Nothing,Vector{UInt8}}       # lld-linked shared object
    entry::Union{Nothing,String}
    global_hostcalls::Vector{Symbol}
    relocations::GPUCompiler.Relocations
    # session-local handles (never populated during precompilation)
    functions::Vector{Tuple{HIP.HIPDevice,HIP.HIPFunction}}
    HIPResults() = new(
        nothing, nothing, Symbol[], GPUCompiler.Relocations(),
        Tuple{HIP.HIPDevice,HIP.HIPFunction}[])
end

# (objectid(source), hash(fun), f) => HIPKernel
const _kernel_instances = Dict{Any, Any}()

GPUCompiler.runtime_module(@nospecialize(::HIPCompilerJob)) = AMDGPU

GPUCompiler.method_table(@nospecialize(::HIPCompilerJob)) = AMDGPU.method_table

GPUCompiler.kernel_state_type(@nospecialize(::HIPCompilerJob)) = AMDGPU.KernelState

# Same situation as the `llvm.frexp`/`llvm.ldexp` note in GPUCompiler's gcn.jl: the ROCm
# device libraries are built against a newer LLVM than the one in this process, so they
# use intrinsics it does not know and will not accept as such. Final code generation goes
# through AMDGPU_LLVM_Backend_jll, which does know them.
#
# `llvm.readsteadycounter` (LLVM 19) is reached from `__ockl_dm_alloc`, i.e. by every
# module that uses the device allocator.
const _backend_only_intrinsics = ("llvm.readsteadycounter",)

GPUCompiler.isintrinsic(@nospecialize(job::HIPCompilerJob), fn::String) =
    fn in _backend_only_intrinsics ||
    invoke(GPUCompiler.isintrinsic,
        Tuple{CompilerJob{GCNCompilerTarget}, typeof(fn)}, job, fn)

# Julia codegen embeds host addresses
# (type tags, boxed values, words read from libjulia globals)
# into the IR it hands us.
#
# GPUCompiler keeps them symbolic and reports them as relocation records instead.
# HIP can look a global up in a loaded module by name (`hipModuleGetGlobal`) and
# write to it (via `hipMemcpyHtoD`), so we use `:patch` strategy:
# the emitted object leaves each word as a named, zero-initialized global that
# `patch_relocations!` fills in after loading.
#
# Nothing session-local ends up in `obj`, which is what lets `HIPResults` persist across sessions.
GPUCompiler.relocation_lowering(@nospecialize(::HIPCompilerJob)) = :patch

function GPUCompiler.link_libraries!(@nospecialize(job::HIPCompilerJob), mod::LLVM.Module)
    invoke(GPUCompiler.link_libraries!, Tuple{CompilerJob{GCNCompilerTarget},typeof(mod)}, job, mod)

    # Detect global hostcalls here, before optimizations & cleanup occur.
    # Accumulate into task-local storage so hipcompile can retrieve them
    # on the same task, without any global dict or hash-collision race.
    tls_hostcalls = get!(task_local_storage(), :amdgpu_early_hostcalls, Symbol[])
    append!(tls_hostcalls, find_global_hostcalls(mod))

    # Only the final kernel module needs the device libraries.
    job.config.toplevel || return
    # Before linking, so that the `__ockl_dm_alloc`/`__ockl_dm_dealloc` this introduces
    # are among the undefined symbols that pull in `ockl`.
    lower_device_malloc!(mod)
    link_device_libs!(
        job.config.target, mod;
        wavefrontsize64=job.config.params.wavefrontsize64)
end

function GPUCompiler.finish_module!(
    @nospecialize(job::HIPCompilerJob), mod::LLVM.Module, entry::LLVM.Function,
)
    entry = invoke(GPUCompiler.finish_module!,
        Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(entry)},
        job, mod, entry)

    # Re-link device libs to resolve references introduced by the GPUCompiler runtime,
    # e.g. boxing → malloc → hostcall → __ockl_hsa_signal*
    # which are added after link_libraries! has already run.
    if job.config.toplevel
        lower_device_malloc!(mod)
        link_device_libs!(
            job.config.target, mod;
            wavefrontsize64=job.config.params.wavefrontsize64)
    end

    fold_wavefrontsize!(mod, job.config.params.wavefrontsize64)

    # Set kernel target cpu and features.
    if entry.callconv == LLVM.CallConv.AMDGPUKERNEL
        target_cpu_attr = StringAttribute("target-cpu", job.config.target.dev_isa)
        target_features_attr = StringAttribute("target-features", job.config.target.features)

        # TODO add convergent, mustprogress, willreturn attributes?

        # request the full hidden-argument block (code object v5+): workgroup and
        # grid dimensions are read from it (see device/gcn/indexing.jl),
        implicitarg_attr = StringAttribute("amdgpu-implicitarg-num-bytes", "256")

        attrs = entry.function_attributes
        push!(attrs, target_cpu_attr)
        push!(attrs, target_features_attr)
        if job.config.params.unsafe_fp_atomics
            push!(attrs, StringAttribute("amdgpu-unsafe-fp-atomics", "true"))
        end
        push!(attrs, implicitarg_attr)
    end

    # Workaround for the lack of zeroinitializer support for LDS.
    zeroinit_lds!(mod, entry)

    # Force-inline exception-related functions.
    # LLVM gets confused when not all functions are inlined,
    # causing huge scratch memory usage.
    # And GPUCompiler fails to inline all functions without forcing
    # always-inline attributes on them. Add them here.
    target_fns = ("signal_exception", "report_exception", "malloc", "__throw_")

    for fn in mod.functions
        do_inline = any(occursin.(target_fns, fn.name))
        if job.config.params.unsafe_fp_atomics || do_inline
            attrs = fn.function_attributes

            if do_inline && !haskey(attrs, :alwaysinline)
                # the two are mutually exclusive, and some matched functions are
                # `@noinline` in Base (e.g. `_throw_boundserror_indices` on Julia 1.14)
                delete!(attrs, :noinline)
                push!(attrs, EnumAttribute(:alwaysinline))
            end
        end
    end

    return entry
end

# AMDGPU sync scopes narrower than the system scope. The system scope ("" and "one-as")
# and scopes we don't know never get memory assumptions.
const NARROW_SYNCSCOPES = (
    "agent", "cluster", "workgroup", "wavefront", "singlethread",
    "agent-one-as", "cluster-one-as", "workgroup-one-as", "wavefront-one-as",
    "singlethread-one-as")

# Attach the metadata that lets the AMDGPU back-end use native atomic instructions, like
# Clang's `setTargetAtomicMetadata`. Unlike Clang, system-scope RMWs never get the memory
# assumptions, which keeps the system scope usable for fine-grained or remote memory.
# Since LLVM 22, integer RMWs other than add/xchg are CAS loops without them on several
# targets, and FP RMWs have needed them since LLVM 20.
function annotate_atomics!(mod::LLVM.Module, job::HIPCompilerJob)
    params = job.config.params
    denormal_md = denormal_metadata_name(job.config.target)
    empty_md = MDNode(Metadata[])
    for fn in mod.functions, bb in fn.blocks, inst in bb.instructions
        inst isa LLVM.AtomicRMWInst || continue
        md = inst.metadata
        if params.atomic_memory_assumptions && inst.syncscope.name in NARROW_SYNCSCOPES
            md["amdgpu.no.fine.grained.memory"] = empty_md
            md["amdgpu.no.remote.memory"] = empty_md
        end
        if params.unsafe_fp_atomics && inst.binop == LLVM.AtomicRMWBinOp.FAdd &&
           inst.value_type isa LLVM.FloatType
            md[denormal_md] = empty_md
        end
    end
end

# LLVM 24 renamed the metadata (llvm/llvm-project#217585) and only upgrades the old name
# when reading IR, which the in-process back-end doesn't do.
function denormal_metadata_name(target::GCNCompilerTarget)
    llvm = target.backend === :external ? pkgversion(AMDGPU_LLVM_Backend_jll) :
                                          Base.libllvm_version
    llvm >= v"24" ? "atomic.ignore.denormal.mode" : "amdgpu.ignore.denormal.mode"
end

# LLVM only folds `llvm.amdgcn.wavefrontsize` during instruction selection, which then
# fails on branches for the other wavefront size (e.g. in `ballot`), so fold it here.
function fold_wavefrontsize!(mod::LLVM.Module, wavefrontsize64::Bool)
    f = get(mod.functions, "llvm.amdgcn.wavefrontsize", nothing)
    f === nothing && return
    ws = ConstantInt(f.function_type.return_type, wavefrontsize64 ? 64 : 32)
    for call in collect(f.users)
        LLVM.replace_uses!(call::LLVM.CallInst, ws)
        LLVM.erase!(call)
    end
    return
end

function parse_llvm_features(arch::String)
    splits = split(arch, ":")
    length(splits) == 1 && return (; dev_isa=splits[1], features="")

    dev_isa, features = splits[1], splits[2:end]
    features = join(map(x -> x[1:end - 1], filter(x -> x[end] == '+', features)), ",+")
    isempty(features) || (features = "+" * features)
    (; dev_isa, features)
end


const _compiler_configs = Dict{UInt, HIPCompilerConfig}()
const compiler_config_lock = ReentrantLock()

function compiler_config(dev::HIP.HIPDevice; kwargs...)
    h = hash(dev, hash(kwargs))
    return Base.@lock compiler_config_lock begin
        get!(_compiler_configs, h) do
            _compiler_config(dev; kwargs...)
        end
    end
end

function _compiler_config(dev::HIP.HIPDevice;
    name::Union{String, Nothing} = nothing, kernel::Bool = true,
    unsafe_fp_atomics::Bool = true, atomic_memory_assumptions::Bool = true,
    wavefrontsize64::Bool = HIP.wavefrontsize(dev) == 64,
    minthreads::Union{Nothing, Int, Dims} = nothing,
    maxthreads::Union{Nothing, Int, Dims} = nothing,
)
    dev_isa, features = parse_llvm_features(HIP.gcn_arch(dev))
    if !isempty(features)
        features = "$features,"
    end

    features = if wavefrontsize64
        features * "-wavefrontsize32,+wavefrontsize64"
    else
        features * "+wavefrontsize32,-wavefrontsize64"
    end

    target = GCNCompilerTarget(; dev_isa, features, minthreads, maxthreads)
    params = HIPCompilerParams(wavefrontsize64, unsafe_fp_atomics, atomic_memory_assumptions)
    CompilerConfig(target, params; kernel, name, always_inline=true)
end

const hipfunction_lock = ReentrantLock()

"""
    hipfunction(f::F, tt::TT = Tuple{}; kwargs...)

Compile Julia function `f` to a HIP kernel given a tuple of
argument's types `tt` that it accepts.

The following kwargs are supported:

- `name::Union{String, Nothing} = nothing`:
    A unique name to give a compiled kernel.
- `unsafe_fp_atomics::Bool = true`:
    Whether floating-point atomic read-modify-write operations may ignore the
    floating-point denormal mode, so that targets whose hardware atomics flush
    denormals can use them instead of a compare-and-swap (CAS) loop.
- `atomic_memory_assumptions::Bool = true`:
    Whether atomic read-modify-write operations with a scope narrower than the
    system scope may assume that they access memory that is neither fine-grained
    nor remote (on another device). This lets them use hardware instructions
    instead of CAS loops. Disable it for kernels that use such atomics on
    fine-grained memory, e.g. host or unified memory; see the
    "Atomics" section of the kernel programming documentation.
- `maxthreads::Union{Nothing, Int, Dims} = nothing`:
    An upper bound on the workgroup size the kernel will be launched with
    (`__launch_bounds__` equivalent); lets the backend size its register
    budget for the actual occupancy target instead of 1024-item workgroups.
- `minthreads::Union{Nothing, Int, Dims} = nothing`:
    The workgroup size the kernel is guaranteed to be launched with.
"""
function hipfunction(f::F, tt::TT = Tuple{}; kwargs...) where {F <: Core.Function, TT}
    Base.@lock hipfunction_lock begin
        dev = AMDGPU.device()
        config = compiler_config(dev; kwargs...)
        source = methodinstance(F, tt)
        fun = hipfunction_lookup(source, config, dev)

        key = (objectid(source), hash(fun), f)
        kernel = get(_kernel_instances, key, nothing)
        if kernel === nothing
            kernel = Runtime.HIPKernel{F, tt}(f, fun)
            _kernel_instances[key] = kernel
        end
        return kernel::Runtime.HIPKernel{F, tt}
    end
end

# Resolve the `HIPFunction` for `source`/`config` on the active device. This is a
# session-local handle, so it lives in the results struct's linear cache rather than
# being persisted; the scan is almost always over a single entry, matching the old
# per-device cache (`==` compare, as `HIPDevice` was the Dict key before).
function hipfunction_lookup(
    source::Core.MethodInstance, config::HIPCompilerConfig, dev::HIP.HIPDevice,
)::HIP.HIPFunction
    job = CompilerJob(source, config)
    res = compile_or_lookup(job)

    for (cached_dev, cached_fun) in res.functions
        cached_dev == dev && return cached_fun
    end

    fun = hiplink(job, res.obj::Vector{UInt8}, res.entry::String, res.global_hostcalls, res.relocations)
    # Don't cache session-local handles while generating output: the results
    # struct is serialized into the package image along with its CodeInstance,
    # and the handles would come back dangling.
    if ccall(:jl_generating_output, Cint, ()) != 1
        push!(res.functions, (dev, fun))
    end
    return fun
end

# Look up the cached compilation artifacts for `job`, running the compiler on a miss.
#
# Storage is managed by `GPUCompiler.cached_results`: Julia's integrated code cache on
# 1.11+ (which also persists artifacts through precompilation), or a session-local store
# on 1.10. `obj === nothing` identifies a freshly-created `HIPResults` that hasn't been
# compiled yet. Every lookup is reported to the `@device_code_*` hook, so reflection
# observes cached kernels without recompiling them.
# Specialize on the target/parameter types so callers can avoid boxing CompilerJob.
# Keep the body out of callers that specialize per kernel.
@noinline function compile_or_lookup(job::CompilerJob)::HIPResults
    GPUCompiler.run_compile_hook(job)
    res = GPUCompiler.cached_results(HIPResults, job)
    if res === nothing || res.obj === nothing
        compiled = hipcompile(job)
        res = @something res GPUCompiler.cached_results(HIPResults, job)
        res.obj = compiled.obj
        res.entry = compiled.entry
        res.global_hostcalls = compiled.global_hostcalls
        res.relocations = compiled.relocations
    end
    return res
end

# Path of an `ld.lld` to link with, or "" to fall back to the in-process linker. Discovery
# has not run while generating package output, so look one up directly there: `AMDGPULink`
# deadlocks in a precompilation worker on Windows (#1083).
function external_lld()::String
    isempty(AMDGPU.lld_path) || return AMDGPU.lld_path
    ccall(:jl_generating_output, Cint, ()) == 1 || return ""
    return AMDGPU.ROCmDiscovery.find_ld_lld(AMDGPU.ROCmDiscovery.find_roc_path())
end

function create_executable(obj)
    lld = external_lld()
    if isempty(lld)
        @assert AMDGPU.lld_artifact || AMDGPU_LLVM_Backend_jll.is_available() "ld.lld was not found; cannot link kernel"
        return link_in_process(obj)
    end

    path_o = tempname(;cleanup=false) * ".obj"
    path_exe = tempname(;cleanup=false) * ".exe"

    write(path_o, obj)
    run(`$lld -shared -o $path_exe $path_o`)
    bin = read(path_exe)

    rm(path_o)
    rm(path_exe)
    return bin
end

# link a relocatable object into an HSA code object through `libamdgpu`, i.e.
# `ld.lld -flavor gnu -shared` without spawning a process or touching the file system
function link_in_process(obj::AbstractVector{UInt8})
    obj = convert(Vector{UInt8}, obj)
    buffer = Ref{Ptr{Cvoid}}(C_NULL)
    message = Ref{Cstring}(C_NULL)
    # linking can take a while, so don't block the GC
    status = @gcsafe_ccall libamdgpu.AMDGPULink(
        obj::Ptr{UInt8}, length(obj)::Csize_t,
        buffer::Ptr{Ptr{Cvoid}}, message::Ptr{Cstring})::Cint
    if status != 0
        msg = "Failed to link kernel"
        if message[] != C_NULL
            msg *= ":\n" * unsafe_string(message[])
            @ccall libamdgpu.AMDGPUDisposeMessage(message[]::Cstring)::Cvoid
        end
        error(msg)
    end
    start = @ccall libamdgpu.AMDGPUGetBufferStart(buffer[]::Ptr{Cvoid})::Ptr{UInt8}
    size = @ccall libamdgpu.AMDGPUGetBufferSize(buffer[]::Ptr{Cvoid})::Csize_t
    bin = copy(unsafe_wrap(Array, start, size))
    @ccall libamdgpu.AMDGPUDisposeMemoryBuffer(buffer[]::Ptr{Cvoid})::Cvoid
    return bin
end

function find_global_hostcalls(mod::LLVM.Module)
    global_hostcall_names = (
        :malloc_hostcall, :free_hostcall, :print_hostcall, :printf_hostcall)

    global_hostcalls = Symbol[]
    for gbl in mod.globals, gbl_name in global_hostcall_names
        occursin("__$gbl_name", gbl.name) || continue
        push!(global_hostcalls, gbl_name)
    end
    return global_hostcalls
end

function hipcompile(@nospecialize(job::CompilerJob))
    # the IR in `meta` is ours: inspect it in here, and dispose of it so that it does not leak
    obj, entry, late_hostcalls, extinit_globals, relocations = JuliaContext() do ctx
        obj, meta = GPUCompiler.compile(:obj, job)
        @dispose ir=meta.ir begin
            # Filter out extinit global from `relocations` that :patch strategy emits.
            relocated = Set(rec.name for rec in meta.relocations.records)
            extinit_globals = [gv.name for gv in ir.globals
                               if gv.externally_initialized && gv.name ∉ relocated]

            obj, meta.entry.name, find_global_hostcalls(ir), extinit_globals,
                meta.relocations
        end
    end

    # Collect early-detected hostcalls written by link_libraries! on this task.
    # Falls back gracefully to empty if link_libraries! was not called.
    global_hostcalls = pop!(task_local_storage(), :amdgpu_early_hostcalls, Symbol[])
    # Late global hostcalls detection.
    append!(global_hostcalls, late_hostcalls)

    if !isempty(global_hostcalls)
        @info """Global hostcalls detected!
        - Source: $(job.source)
        - Hostcalls: $(global_hostcalls)

        Use `AMDGPU.synchronize(; stop_hostcalls=true)` to synchronize and stop them.
        Otherwise, performance might degrade if they keep running in the background.
        """
    end

    if !isempty(extinit_globals)
        @warn """
        HIP backend does not support setting extinit globals.
        But kernel `$entry` has following:
        $extinit_globals

        Compilation will likely fail.
        """
    end
    (; obj=create_executable(codeunits(obj)), entry, global_hostcalls, relocations)
end

# Fill in the host addresses the loaded object was left waiting for:
# each record names a global in the image, and its word at `offset` is where the address goes.
# Resolving roots the referenced Julia values in this process, so those addresses cannot dangle.
function patch_relocations!(mod::HIP.HIPModule, relocations::GPUCompiler.Relocations)
    isempty(relocations) && return
    word = UInt[0]
    for (rec, value) in GPUCompiler.resolved_relocations(relocations)
        # a site the linker dropped would otherwise surface as a bare `hipErrorNotFound`
        ptr, size = try
            HIP.module_global(mod, rec.name)
        catch err
            error("Loaded kernel has no relocation site `$(rec.name)`: $(sprint(showerror, err))")
        end
        rec.offset + sizeof(UInt) ≤ size ||
            error("Relocation `$(rec.name)+$(rec.offset)` does not fit in its $size-byte global")

        word[1] = value
        GC.@preserve word begin
            HIP.hipMemcpyHtoD(ptr + rec.offset, Ptr{Cvoid}(pointer(word)), sizeof(UInt))
        end
    end
    return
end

# link a compiled shared object into a session-local `HIPFunction` on the active device,
# filling in the host addresses the object was compiled to expect.
function hiplink(@nospecialize(job::CompilerJob), obj, entry, global_hostcalls, relocations)
    mod = HIP.HIPModule(obj)
    patch_relocations!(mod, relocations)
    HIP.HIPFunction(mod, entry, global_hostcalls)
end

function run_and_collect(cmd)
    stdout = Pipe()
    proc = run(pipeline(ignorestatus(cmd); stdout, stderr=stdout), wait=false)
    close(stdout.in)

    reader = Threads.@spawn String(read(stdout))
    Base.wait(proc)
    log = strip(fetch(reader))
    return proc, log
end

# Run amdgpu-attributor so that the amdgpu specific attributes are added
# This reduces some register usage
function GPUCompiler.finish_ir!(
    @nospecialize(job::HIPCompilerJob), mod::LLVM.Module, entry::LLVM.Function,
)
    entry = invoke(GPUCompiler.finish_ir!,
        Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(entry)},
        job, mod, entry)

    # after optimization, so that sync scopes have their AMDGPU names
    annotate_atomics!(mod, job)

    job.config.kernel || return entry

    name = entry.name
    # The textual pass name is only registered since LLVM 18; it's a pure
    # optimization, so skip it on older LLVM (e.g. Julia 1.10's LLVM 15).
    if LLVM.version() >= v"18"
        @dispose tm=GPUCompiler.llvm_machine(job.config.target) pb=PassBuilder() begin
            add!(pb, "amdgpu-attributor")
            run!(pb, mod, tm)
        end
    end
    return mod.functions[name]
end
