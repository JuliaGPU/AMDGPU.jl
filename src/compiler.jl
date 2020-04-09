## target

struct ROCCompilerTarget <: CompositeCompilerTarget
    parent::GCNCompilerTarget

    ROCCompilerTarget(dev_isa::String) = new(GCNCompilerTarget(dev_isa))
end

Base.parent(target::ROCCompilerTarget) = target.parent

# filter out functions from device libs
GPUCompiler.isintrinsic(target::ROCCompilerTarget, fn::String) =
    GPUCompiler.isintrinsic(target.parent, fn) || startswith(fn, "rocm")

GPUCompiler.runtime_module(::ROCCompilerTarget) = AMDGPUnative


## job

struct ROCCompilerJob <: CompositeCompilerJob
    parent::GCNCompilerJob
end

ROCCompilerJob(target::AbstractCompilerTarget, source::FunctionSpec; kwargs...) =
    ROCCompilerJob(GCNCompilerJob(target, source; kwargs...))

Base.similar(job::ROCCompilerJob, source::FunctionSpec; kwargs...) =
    ROCCompilerJob(similar(job.parent, source; kwargs...))

Base.parent(job::ROCCompilerJob) = job.parent

function GPUCompiler.process_module!(job::ROCCompilerJob, mod::LLVM.Module)
    GPUCompiler.process_module!(job.parent, mod)

    #emit_exception_flag!(mod)
end

function GPUCompiler.link_libraries!(job::ROCCompilerJob, mod::LLVM.Module,
                                     undefined_fns::Vector{String})
    GPUCompiler.link_libraries!(job.parent, mod, undefined_fns)

    link_device_libs!(mod, job.parent.target.parent.dev_isa, undefined_fns)
end
