struct HIPCompilerParams <: AbstractCompilerParams
    # Whether to compile kernel for the wavefront of size 64.
    wavefrontsize64::Bool
    # AMD GPU devices support fast atomic read-modify-write (RMW)
    # operations on floating-point values.
    # On single- or double-precision floating-point values this may generate
    # a hardware RMW instruction that is faster than emulating
    # the atomic operation using an atomic compare-and-swap (CAS) loop.
    unsafe_fp_atomics::Bool
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

    # Only the final kernel module needs the device libraries.
    job.config.toplevel || return
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
    job.config.toplevel && link_device_libs!(
        job.config.target, mod;
        wavefrontsize64=job.config.params.wavefrontsize64)

    # Set kernel target cpu and features.
    if LLVM.callconv(entry) == LLVM.API.LLVMAMDGPUKERNELCallConv
        target_cpu_attr = StringAttribute("target-cpu", job.config.target.dev_isa)
        target_features_attr = StringAttribute("target-features", job.config.target.features)
        atomic_attr = StringAttribute("amdgpu-unsafe-fp-atomics", "true")

        # TODO add convergent, mustprogress, willreturn attributes?

        attrs = LLVM.function_attributes(entry)
        push!(attrs, target_cpu_attr)
        push!(attrs, target_features_attr)
        push!(attrs, atomic_attr)
    end

    # Workaround for the lack of zeroinitializer support for LDS.
    zeroinit_lds!(mod, entry)

    # Force-inline exception-related functions.
    # LLVM gets confused when not all functions are inlined,
    # causing huge scratch memory usage.
    # And GPUCompiler fails to inline all functions without forcing
    # always-inline attributes on them. Add them here.
    target_fns = ("signal_exception", "report_exception", "malloc", "__throw_")
    inline_attr = EnumAttribute("alwaysinline")

    for fn in LLVM.functions(mod)
        do_inline = any(occursin.(target_fns, LLVM.name(fn)))
        if job.config.params.unsafe_fp_atomics || do_inline
            attrs = LLVM.function_attributes(fn)

            do_inline && inline_attr ∉ collect(attrs) && push!(attrs, inline_attr)
        end
    end

    # LLVM 20+ requires !amdgpu.no.fine.grained.memory on FP atomicrmw to emit
    # native hardware atomics (e.g. global_atomic_add_f32) instead of a CAS loop.
    # Mirrors Clang's setTargetAtomicMetadata; unsafe_fp_atomics is the opt-in.
    if job.config.params.unsafe_fp_atomics
        fp_binops = (LLVM.API.LLVMAtomicRMWBinOpFAdd, LLVM.API.LLVMAtomicRMWBinOpFSub,
                     LLVM.API.LLVMAtomicRMWBinOpFMax, LLVM.API.LLVMAtomicRMWBinOpFMin)
        empty_md = MDNode(Metadata[])
        for fn in LLVM.functions(mod), bb in LLVM.blocks(fn), inst in LLVM.instructions(bb)
            inst isa LLVM.AtomicRMWInst || continue
            op = LLVM.binop(inst)
            op ∈ fp_binops || continue
            md = LLVM.metadata(inst)
            md["amdgpu.no.fine.grained.memory"] = empty_md
            if op == LLVM.API.LLVMAtomicRMWBinOpFAdd && LLVM.value_type(inst) == LLVM.FloatType()
                md["amdgpu.ignore.denormal.mode"] = empty_md
            end
        end
    end

    return entry
end

function GPUCompiler.finish_ir!(
    @nospecialize(job::HIPCompilerJob), mod::LLVM.Module, entry::LLVM.Function,
)
    entry = invoke(GPUCompiler.finish_ir!,
        Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(entry)},
        job, mod, entry)

    # Detect global hostcalls after optimization & cleanup, but before codegen
    # (which lowers LDS globals and loses their names): a hostcall that only
    # lives on a code path optimization proved dead (e.g. an elided bounds
    # check) must not force the host to spin one up.
    # Accumulate into task-local storage so hipcompile can retrieve them
    # on the same task, without any global dict or hash-collision race.
    if job.config.toplevel
        tls_hostcalls = get!(task_local_storage(), :amdgpu_hostcalls, Symbol[])
        union!(tls_hostcalls, find_global_hostcalls(mod))
    end
    return entry
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
    unsafe_fp_atomics::Bool = true, wavefrontsize64::Bool = HIP.wavefrontsize(dev) == 64,
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

    target = GCNCompilerTarget(; dev_isa, features)
    params = HIPCompilerParams(wavefrontsize64, unsafe_fp_atomics)
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
    Whether to use 'unsafe' floating-point atomics.
    AMD GPU devices support fast atomic read-modify-write (RMW)
    operations on floating-point values.
    On single- or double-precision floating-point values this may generate
    a hardware RMW instruction that is faster than emulating
    the atomic operation using an atomic compare-and-swap (CAS) loop.
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
# compiled yet; the `compile_hook` check additionally forces the compile path so that
# reflection consumers (`@device_code_*`) observe the compilation even on a cache hit.
function compile_or_lookup(@nospecialize(job::CompilerJob))::HIPResults
    res = GPUCompiler.cached_results(HIPResults, job)
    if res === nothing || res.obj === nothing || GPUCompiler.compile_hook[] !== nothing
        compiled = hipcompile(job)
        res = @something res GPUCompiler.cached_results(HIPResults, job)
        res.obj = compiled.obj
        res.entry = compiled.entry
        res.global_hostcalls = compiled.global_hostcalls
        res.relocations = compiled.relocations
    end
    return res
end

function create_executable(obj)
    @assert AMDGPU_LLVM_Backend_jll.is_available() "ld.lld was not found; cannot link kernel"
    # `--threads=1`: the Windows build of lld intermittently dies with
    # STATUS_HEAP_CORRUPTION (0xC0000374) when linking with its default thread
    # pool; these objects are tiny, so single-threaded linking costs nothing.
    lld = `$(AMDGPU_LLVM_Backend_jll.lld()) -flavor gnu --threads=1`

    path_o = tempname(;cleanup=false) * ".obj"
    path_exe = tempname(;cleanup=false) * ".exe"

    write(path_o, obj)
    run(`$lld -shared -o $path_exe $path_o`)
    bin = read(path_exe)

    rm(path_o)
    rm(path_exe)
    return bin
end

function find_global_hostcalls(mod::LLVM.Module)
    global_hostcall_names = (
        :malloc_hostcall, :free_hostcall, :print_hostcall, :printf_hostcall)

    global_hostcalls = Symbol[]
    for gbl in LLVM.globals(mod), gbl_name in global_hostcall_names
        occursin("__$gbl_name", LLVM.name(gbl)) || continue
        # The marker global (see `malloc_hc` & co.) has external linkage, so it
        # survives optimization even when every store to it was removed along
        # with the code path that needed the hostcall. Only a remaining use
        # means the kernel can actually reach the hostcall.
        isempty(LLVM.uses(gbl)) && continue
        gbl_name in global_hostcalls || push!(global_hostcalls, gbl_name)
    end
    return global_hostcalls
end

function hipcompile(@nospecialize(job::CompilerJob))
    # Drop hostcalls left behind by compilations that never reached hipcompile
    # (e.g. `code_llvm`), so they can't be attributed to this kernel.
    delete!(task_local_storage(), :amdgpu_hostcalls)
    obj, meta = JuliaContext() do ctx
        GPUCompiler.compile(:obj, job)
    end

    # Collect hostcalls detected by finish_ir! on this task.
    # Falls back gracefully to empty if finish_ir! was not called.
    global_hostcalls = pop!(task_local_storage(), :amdgpu_hostcalls, Symbol[])

    if !isempty(global_hostcalls)
        @info """Global hostcalls detected!
        - Source: $(job.source)
        - Hostcalls: $(global_hostcalls)

        Use `AMDGPU.synchronize(; stop_hostcalls=true)` to synchronize and stop them.
        Otherwise, performance might degrade if they keep running in the background.
        """
    end

    entry = LLVM.name(meta.entry)

    # Filter out extinit global from `relocations` that :patch strategy emits.
    relocations = meta.relocations
    relocated = Set(rec.name for rec in relocations.records)
    extinit_globals = filter(collect(LLVM.globals(meta.ir))) do gv
        isextinit(gv) && LLVM.name(gv) ∉ relocated
    end .|> LLVM.name
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
