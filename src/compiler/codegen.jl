struct HIPCompilerParams <: AbstractCompilerParams end

const HIPCompilerConfig = CompilerConfig{GCNCompilerTarget, HIPCompilerParams}
const HIPCompilerJob = CompilerJob{GCNCompilerTarget, HIPCompilerParams}

const _hip_compiler_cache = Dict{HIP.HIPDevice, Dict{UInt, Any}}()
const _kernel_instances = Dict{UInt, Any}() # HIPKernel

function compiler_cache(dev::HIP.HIPDevice)
    get!(() -> Dict{UInt, Any}(), _hip_compiler_cache, dev)
end

GPUCompiler.runtime_module(@nospecialize(::HIPCompilerJob)) = AMDGPU

GPUCompiler.ci_cache(@nospecialize(::HIPCompilerJob)) = AMDGPU.ci_cache

GPUCompiler.method_table(@nospecialize(::HIPCompilerJob)) = AMDGPU.method_table

GPUCompiler.kernel_state_type(@nospecialize(::HIPCompilerJob)) = AMDGPU.KernelState

function GPUCompiler.link_libraries!(
    @nospecialize(job::HIPCompilerJob), mod::LLVM.Module,
    undefined_fns::Vector{String},
)
    # @show undefined_fns
    invoke(GPUCompiler.link_libraries!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(undefined_fns)},
           job, mod, undefined_fns)
    link_device_libs!(job.config.target, mod)
end

function compiler_config(
    dev::HIP.HIPDevice; kernel::Bool = true,
    name::Union{String, Nothing} = nothing,
    always_inline::Bool = true,
)
    # FIXME use HIP device and isa
    isa = AMDGPU.default_isa(AMDGPU.device())
    dev_isa, features = Runtime.llvm_arch_features(isa)

    target = GCNCompilerTarget(; dev_isa, features)
    params = HIPCompilerParams()
    CompilerConfig(target, params; kernel, name, always_inline)
end

const hipfunction_lock = ReentrantLock()

function hipfunction(f::F, tt::TT = Tuple{}; kwargs...) where {F <: Core.Function, TT}
    Base.@lock hipfunction_lock begin
        dev = HIP.device()
        cache = compiler_cache(dev)
        config = compiler_config(dev; kwargs...)

        fun = GPUCompiler.cached_compilation(
            cache, config, F, tt, hipcompile, hiplink)

        h = hash(fun, hash(f, hash(tt)))
        kernel = get!(_kernel_instances, h) do
            exception_ptr = create_exception!(fun.mod)
            output_context_ptr = create_output_context!()
            printf_output_context_ptr = create_printf_output_context!()
            malloc_hc = create_malloc_hostcall!()
            free_hc = create_free_hostcall!()
            state = AMDGPU.KernelState(
                exception_ptr, output_context_ptr,
                printf_output_context_ptr, malloc_hc, free_hc)
            Runtime.HIPKernel{F, tt}(f, fun, state)
        end
        return kernel::Runtime.HIPKernel{F, tt}
    end
end

import LLD_jll

function create_executable(obj)
    lld = if AMDGPU.lld_artifact
        # Use
        `$(LLD_jll.lld()) -flavor gnu`
    else
        @assert !isempty(AMDGPU.lld_path) "ld.lld was not found; cannot link kernel"
        `$(AMDGPU.lld_path)`
    end

    path_exe = mktemp() do path_o, io_o
        write(io_o, obj)
        flush(io_o)
        path_exe = path_o * ".exe"
        run(`$lld -shared -o $path_exe $path_o`)
        path_exe
    end
    return read(path_exe)
end

function hipcompile(@nospecialize(job::CompilerJob))
    JuliaContext() do ctx
        obj, meta = GPUCompiler.compile(:obj, job; ctx)
        globals = filter(isextinit, collect(LLVM.globals(meta.ir))) .|> LLVM.name
        # @show globals
        (; obj=create_executable(codeunits(obj)), entry=LLVM.name(meta.entry), globals)
    end
end

function hiplink(@nospecialize(job::CompilerJob), compiled)
    (; obj, entry, globals) = compiled
    mod = HIP.HIPModule(obj)
    HIP.HIPFunction(mod, entry)
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
