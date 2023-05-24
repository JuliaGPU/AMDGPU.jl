@generated function promote_c_argument(arg)
    if arg == Cchar || arg == Cshort || arg == Cuchar || arg == Cushort
        return :(Cint(arg))
    elseif arg == Cfloat
        return :(Cdouble(arg))
    else
        return :(arg)
    end
end

@generated function _hipprintf(::Val{fmt}, argspec...)::Int64 where {fmt}
    @dispose ctx=Context() begin
        arg_exprs = [:( argspec[$i] ) for i in 1:length(argspec)]
        arg_types = [argspec...]

        T_int32 = LLVM.Int32Type(ctx)
        T_int64 = LLVM.Int64Type(ctx)
        T_pint8 = LLVM.PointerType(LLVM.Int8Type(ctx))

        # Create function.
        param_types = LLVMType[convert.(LLVMType, arg_types; ctx)...]
        llvm_f, _ = create_function(T_int64, param_types)
        mod = LLVM.parent(llvm_f)

        # Generate IR.
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # Begin printf.
            printf_begin_typ = LLVM.FunctionType(T_int64)
            printf_begin = LLVM.Function(
                mod, "__ockl_fprintf_stdout_begin", printf_begin_typ)
            descriptor = call!(builder, printf_begin_typ, printf_begin)

            # println(mod)

            # # Append `fmt` string.
            # fmt_str = globalstring_ptr!(builder, String(fmt))

            # printf_append_str_typ = LLVM.FunctionType(
            #     T_int64, [T_int64, T_pint8, T_int64, T_int32])
            # printf_append_str = LLVM.Function(
            #     mod, "__ockl_fprintf_append_string_n", printf_append_str_typ)
            # descriptor = call!(
            #     builder, printf_append_str_typ, printf_append_str,
            #     [descriptor, fmt_str,
            #         LLVM.ConstantInt(T_int64, 6),
            #         LLVM.ConstantInt(T_int32, 1)])

            # """
            # 1. printf begin
            # 2. append string (fmt)
            # 3. foreach arg append arg
            # """

            descriptor = LLVM.ConstantInt(T_int64, 3)
            ret!(builder, descriptor)
        end

        call_function(llvm_f, Int64, Tuple{arg_types...}, arg_exprs...)
    end
end

macro hipprintf(fmt::String, args...)
    fmt_val = Val(Symbol(fmt))

    return :(_hipprintf(
        $fmt_val,
        $(map(arg -> :(promote_c_argument($arg)), esc.(args))...),
    ))
end

@inline @generated function _hipprint(parts...)
    fmt = ""
    args = Expr[]

    for i in 1:length(parts)
        part = :(parts[$i])
        T = parts[i]

        # Put literal directly in the format string.
        if T <: Val
            fmt *= string(T.parameters[1])
            continue
        end

        # TODO
    end

    quote
        @hipprintf($fmt, $(args...))
    end
end

macro hipprint(parts...)
    args = Union{Val, Expr, Symbol}[]
    parts = [parts...]

    while true
        isempty(parts) && break

        part = popfirst!(parts)
        # Handle string interpolation.
        if isa(part, Expr) && part.head == :string
            parts = vcat(part.args, parts)
            continue
        end

        if isbits(part) # literal numbers, etc.
            push!(args, Val(part))
        elseif isa(part, QuoteNode) # literal symbols.
            push!(args, Val(part.value))
        elseif isa(part, String) # literal string.
            push!(args, Val(Symbol(part)))
        else
            push!(args, part)
        end
    end
    quote
        _hipprint($(map(esc, args)...))
    end
end

macro hipprintln(parts...)
    esc(quote
        AMDGPU.Device.@hipprint($(parts...), "\n")
    end)
end
