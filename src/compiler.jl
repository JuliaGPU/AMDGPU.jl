struct ROCCompilerParams <: AbstractCompilerParams end

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
    #emit_exception_flag!(mod)
end

function GPUCompiler.link_libraries!(job::ROCCompilerJob, mod::LLVM.Module,
                                     undefined_fns::Vector{String})
    invoke(GPUCompiler.link_libraries!,
           Tuple{CompilerJob{GCNCompilerTarget}, typeof(mod), typeof(undefined_fns)},
           job, mod, undefined_fns)

    link_device_libs!(mod, job.target.dev_isa, undefined_fns)
end
