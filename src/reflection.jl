# code reflection entry-points

using InteractiveUtils

# NOTE: These functions (of form: code_*) replicate parts of the main compiler driver in
#   order to generate more compact code (i.e. without the run-time library)
#   and/or to support generating otherwise invalid code (e.g. with missing symbols).

"""
    code_llvm([io], f, types; optimize=true, device::RuntimeDevice=default_device(), kernel=false,
              optimize=true, raw=false, dump_module=false, strict=false)

Prints the device LLVM IR generated for the method matching the given generic function and
type signature to `io` which defaults to `stdout`.

The following keyword arguments are supported:

- `device`: which device to generate code for
- `kernel`: treat the function as an entry-point kernel
- `optimize`: determines if the code is optimized, which includes kernel-specific
  optimizations if `kernel` is true
- `raw`: return the raw IR including all metadata
- `dump_module`: display the entire module instead of just the function
- `strict`: verify generate code as early as possible

See also: [`@device_code_llvm`](@ref), [`InteractiveUtils.code_llvm`](@ref)
"""
function code_llvm(io::IO, @nospecialize(func), @nospecialize(types);
                   optimize::Bool=true, device::RuntimeDevice=default_device(),
                   dump_module::Bool=false, raw::Bool=false,
                   kernel::Bool=false, strict::Bool=false, kwargs...)
    tt = Base.to_tuple_type(types)
    job = CompilerJob(func, tt, device, kernel; kwargs...)
    code_llvm(io, job; optimize=optimize,
              raw=raw, dump_module=dump_module, strict=strict)
end

function code_llvm(io::IO, job::CompilerJob; optimize::Bool=true, raw::Bool=false,
                   dump_module::Bool=false, strict::Bool=false)
    ir, entry = codegen(:llvm, job; optimize=optimize, strip=!raw, strict=strict)
    if dump_module
        show(io, ir)
    else
        show(io, entry)
    end
end

code_llvm(@nospecialize(func), @nospecialize(types); kwargs...) =
    code_llvm(stdout, func, types; kwargs...)

"""
    code_gcn([io], f, types; device::RuntimeDevice=default_device(), kernel=false, raw=false, strict=false)

Prints the GCN assembly generated for the method matching the given generic function and
type signature to `io` which defaults to `stdout`.

The following keyword arguments are supported:

- `device`: which device to generate code for
- `kernel`: treat the function as an entry-point kernel
- `raw`: return the raw code including all metadata
- `strict`: verify generate code as early as possible

See also: [`@device_code_gcn`](@ref)
"""
function code_gcn(io::IO, @nospecialize(func), @nospecialize(types);
                  device::RuntimeDevice=default_device(), kernel::Bool=false,
                  raw::Bool=false, strict::Bool=false, kwargs...)
    tt = Base.to_tuple_type(types)
    job = CompilerJob(func, tt, device, kernel; kwargs...)
    code_gcn(io, job; raw=raw, strict=strict)
end

function code_gcn(io::IO, job::CompilerJob; raw::Bool=false, strict::Bool=false)
    asm, _ = codegen(:gcn_asm, job; strip=!raw, strict=strict)
    print(io, asm)
end

code_gcn(@nospecialize(func), @nospecialize(types); kwargs...) =
    code_gcn(stdout, func, types; kwargs...)

export @device_code_lowered, @device_code_typed, @device_code_warntype,
       @device_code_llvm, @device_code_gcn, @device_code_sass,
       @device_code

function emit_hooked_compilation(inner_hook, ex...)
    user_code = ex[end]
    user_kwargs = ex[1:end-1]
    quote
        # wipe the compile cache to force recompilation
        empty!(AMDGPUnative.compilecache)

        local kernels = 0
        function outer_hook(job)
            kernels += 1
            $inner_hook(job; $(map(esc, user_kwargs)...))
        end

        if AMDGPUnative.compile_hook[] != nothing
            error("Chaining multiple @device_code calls is unsupported")
        end
        try
            AMDGPUnative.compile_hook[] = outer_hook
            $(esc(user_code))
        finally
            AMDGPUnative.compile_hook[] = nothing
        end

        if kernels == 0
            error("no kernels executed while evaluating the given expression")
        end

        nothing
    end
end

# NOTE: These hooks take both a `f` and an inner `f`, because of how `@roc`
#   works: kernels are automatically wrapped in a function that returns
#   nothing (for usability).
#
#       Julia-level reflection (lowered/typed/warntype) skips these wrappers,
#       because we can't do call-site inlining and the kernel wrapper would
#       hide any meaningful code.
#
#       At the LLVM level, we inline everything so there's no need to hide the
#       wrapper.

"""
    @device_code_lowered ex

Evaluates the expression `ex` and returns the result of
[`InteractiveUtils.code_lowered`](@ref) for every compiled GCN kernel.

See also: [`InteractiveUtils.@code_lowered`](@ref)
"""
macro device_code_lowered(ex...)
    quote
        buf = Any[]
        function hook(job::CompilerJob)
            append!(buf, code_lowered(job.f, job.tt))
        end
        $(emit_hooked_compilation(:hook, ex...))
        buf
    end
end

"""
    @device_code_typed ex

Evaluates the expression `ex` and returns the result of
[`InteractiveUtils.code_typed`](@ref) for every compiled GCN kernel.

See also: [`InteractiveUtils.@code_typed`](@ref)
"""
macro device_code_typed(ex...)
    quote
        buf = Any[]
        function hook(job::CompilerJob)
            if VERSION >= v"1.1.0"
                append!(buf, code_typed(job.f, job.tt, debuginfo=:source))
            else
                append!(buf, code_typed(job.f, job.tt))
            end
        end
        $(emit_hooked_compilation(:hook, ex...))
        buf
    end
end

"""
    @device_code_warntype [io::IO=stdout] ex

Evaluates the expression `ex` and prints the result of
[`InteractiveUtils.code_warntype`](@ref) to `io` for every compiled GCN kernel.

See also: [`InteractiveUtils.@code_warntype`](@ref)
"""
macro device_code_warntype(ex...)
    function hook(job::CompilerJob; io::IO=stdout, kwargs...)
        code_warntype(io, job.f, job.tt; kwargs...)
    end
    emit_hooked_compilation(hook, ex...)
end

"""
    @device_code_llvm [io::IO=stdout, ...] ex

Evaluates the expression `ex` and prints the result of [`InteractiveUtils.code_llvm`](@ref)
to `io` for every compiled GCN kernel. For other supported keywords, see
[`AMDGPUnative.code_llvm`](@ref).

See also: [`InteractiveUtils.@code_llvm`](@ref)
"""
macro device_code_llvm(ex...)
    hook(job::CompilerJob; io::IO=stdout, kwargs...) = code_llvm(io, job; kwargs...)
    emit_hooked_compilation(hook, ex...)
end

"""
    @device_code_gcn [io::IO=stdout, ...] ex

Evaluates the expression `ex` and prints the result of [`AMDGPUnative.code_gcn`](@ref) to `io`
for every compiled GCN kernel. For other supported keywords, see
[`AMDGPUnative.code_gcn`](@ref).
"""
macro device_code_gcn(ex...)
    hook(job::CompilerJob; io::IO=stdout, kwargs...) = code_gcn(io, job; kwargs...)
    emit_hooked_compilation(hook, ex...)
end

"""
    @device_code dir::AbstractString=... [...] ex

Evaluates the expression `ex` and dumps all intermediate forms of code to the directory
`dir`.
"""
macro device_code(ex...)
    only(xs) = (@assert length(xs) == 1; first(xs))
    function hook(job::CompilerJob; dir::AbstractString)
        name = something(job.name, nameof(job.f))
        fn = "$(name)_$(globalUnique+1)"
        mkpath(dir)

        open(joinpath(dir, "$fn.lowered.jl"), "w") do io
            code = only(code_lowered(job.f, job.tt))
            println(io, code)
        end

        open(joinpath(dir, "$fn.typed.jl"), "w") do io
            if VERSION >= v"1.1.0"
                code = only(code_typed(job.f, job.tt, debuginfo=:source))
            else
                code = only(code_typed(job.f, job.tt))
            end
            println(io, code)
        end

        open(joinpath(dir, "$fn.unopt.ll"), "w") do io
            code_llvm(io, job; dump_module=true, strip_ir_metadata=false, optimize=false)
        end

        open(joinpath(dir, "$fn.opt.ll"), "w") do io
            code_llvm(io, job; dump_module=true, strip_ir_metadata=false)
        end

        open(joinpath(dir, "$fn.gcn"), "w") do io
            code_gcn(io, job)
        end
    end
    emit_hooked_compilation(hook, ex...)
end
