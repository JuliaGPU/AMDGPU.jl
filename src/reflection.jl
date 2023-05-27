# code reflection entry-points

# forward the rest to GPUCompiler with an appropriate CompilerJob

#
# code_* replacements
#

for method in (:code_typed, :code_warntype, :code_llvm, :code_native)
    # only code_typed doesn't take an io argument
    args = method == :code_typed ? (:job,) : (:io, :job)
    @eval begin
        function $method(
            io::IO, @nospecialize(func), @nospecialize(types);
            kernel::Bool=false, device=HIP.device(), kwargs...,
        )
            source = methodinstance(typeof(func), Base.to_tuple_type(types))
            config = Compiler.compiler_config(device; kernel)
            job = CompilerJob(source, config)
            GPUCompiler.$method($(args...); kwargs...)
        end
        $method(@nospecialize(func), @nospecialize(types); kwargs...) =
            $method(stdout, func, types; kwargs...)
    end
end

const code_gcn = code_native

#
# @device_code_* macros
#

export @device_code_lowered, @device_code_typed, @device_code_warntype,
       @device_code_llvm, @device_code_gcn, @device_code

# forward the rest to GPUCompiler
@eval $(Symbol("@device_code_lowered")) = $(getfield(GPUCompiler, Symbol("@device_code_lowered")))
@eval $(Symbol("@device_code_typed")) = $(getfield(GPUCompiler, Symbol("@device_code_typed")))
@eval $(Symbol("@device_code_warntype")) = $(getfield(GPUCompiler, Symbol("@device_code_warntype")))
@eval $(Symbol("@device_code_llvm")) = $(getfield(GPUCompiler, Symbol("@device_code_llvm")))
@eval $(Symbol("@device_code_gcn")) = $(getfield(GPUCompiler, Symbol("@device_code_native")))
@eval $(Symbol("@device_code")) = $(getfield(GPUCompiler, Symbol("@device_code")))
