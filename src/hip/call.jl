## version of ccall that calls jl_gc_safe_enter|leave around the inner ccall

# TODO: replace with JuliaLang/julia#49933 once merged

# note that this is generally only safe with functions that do not call back into Julia.
# when callbacks occur, the code should ensure the GC is not running by wrapping the code
# in the `@gcunsafe` macro

function ccall_macro_lower(func, rettype, types, args, nreq)
    # instead of re-using ccall or Expr(:foreigncall) to perform argument conversion,
    # we need to do so ourselves in order to insert a jl_gc_safe_enter|leave
    # just around the inner ccall

    cconvert_exprs = []
    cconvert_args = []
    for (typ, arg) in zip(types, args)
        var = gensym("$(func)_cconvert")
        push!(cconvert_args, var)
        push!(cconvert_exprs, quote
            $var = Base.cconvert($(esc(typ)), $(esc(arg)))
        end)
    end

    unsafe_convert_exprs = []
    unsafe_convert_args = []
    for (typ, arg) in zip(types, cconvert_args)
        var = gensym("$(func)_unsafe_convert")
        push!(unsafe_convert_args, var)
        push!(unsafe_convert_exprs, quote
            $var = Base.unsafe_convert($(esc(typ)), $arg)
        end)
    end

    call = quote
        $(unsafe_convert_exprs...)

        gc_state = @ccall(jl_gc_safe_enter()::Int8)
        ret = ccall($(esc(func)), $(esc(rettype)), $(Expr(:tuple, map(esc, types)...)),
                    $(unsafe_convert_args...))
        @ccall(jl_gc_safe_leave(gc_state::Int8)::Cvoid)
        ret
    end

    quote
        $(cconvert_exprs...)

        GC.@preserve $(cconvert_args...)  $(call)
    end
end

"""
    @gcsafe_ccall ...

Call a foreign function just like `@ccall`, but marking it safe for the GC to run. This is
useful for functions that may block, so that the GC isn't blocked from running, but may also
be required to prevent deadlocks (see JuliaGPU/CUDA.jl#2261).

Note that this is generally only safe with non-Julia C functions that do not call back into
Julia. When using callbacks, the code should make sure to transition back into GC-unsafe
mode using the `@gcunsafe` macro.
"""
macro gcsafe_ccall(expr)
    ccall_macro_lower(Base.ccall_macro_parse(expr)...)
end
