
function jltypefmt(str::String)
    # we assume all hsa types end in "_t"
    str[1:4] == "hsa_" ? i = 2 : i = 1
    words = split(str, "_", keepempty=false)[i:end-1]
    words = uppercasefirst.(words)
    return prod(words)
end

function eccall(func_name::Symbol, libname::Symbol, rtype, args, types)
    :(ccall(($(QuoteNode(func_name)), $(QuoteNode(libname))),
        $rtype,
        $(Expr(:tuple, types...)),
        $(args...))
     )
end

function is_ptr_type_expr(@nospecialize t)
    (t === :Cstring || t === :Cwstring) && return true
    isa(t, Expr) || return false
    t = t::Expr
    t.head === :curly && t.args[1] === :Ptr
end

function efunsig(name::Symbol, args::Vector{Symbol}, types)
    x = [is_ptr_type_expr(t) ? a : Expr(:(::), a, t) for (a,t) in zip(args,types)]
    Expr(:call, name, x...)
end

function sort_cursors(cursors::Vector{CLMacroDefinition})
    cursor_names = spelling.(cursors)
    cursor_dict = Dict(zip(cursor_names, cursors))
    sort!(unique!(cursor_names))
    sorted_cursors = [cursor_dict[cursor_names[j]] for j in 1:length(cursor_names)]
    return sorted_cursors
end

function wrap_hsa_fun!(ctx::AbstractContext, cursor::CLFunctionDecl)

    func_type = type(cursor)
    
    if kind(func_type) == CXType_FunctionNoProto
        @warn "No Prototype for $cursor - assuming no arguments"
    elseif isvariadic(func_type)
        @warn "Skipping VarArg Function $cursor"
        return ctx
    end

    func_name = isempty(ctx.force_name) ? Symbol(spelling(cursor)) : ctx.force_name
    ret_type = clang2julia(return_type(cursor)) # reformat name
    args = function_args(cursor)
    arg_types = [argtype(func_type, i) for i in 0:length(args)-1]
    
    # do a check to dealias/reformat args

    arg_reps = clang2julia.(arg_types)

    for (i, arg) in enumerate(arg_reps)
        if Meta.isexpr(arg, :curly) && first(arg.args) == :NTuple
            arg_reps[i] = Expr(:curly, :Ref, last(arg.args))
        end
        if Meta.isexpr(arg, :curly) && first(arg.args) == :Ptr
            arg_reps[i] = Expr(:curly, :Ref, last(arg.args))
        end
    end

    arg_count = 0
    arg_names = map(args) do x
        n = name_safe(name(x))
        s = !isempty(n) ? n : "arg"*string(arg_count+=1)
        Symbol(s)
    end

    signature = efunsig(Symbol(spelling(cursor)[5:end]), arg_names, arg_reps)
    body = eccall(func_name, Symbol("libhsa-runtime64"), ret_type, arg_names, arg_reps)
    push!(ctx.api_buffer, Expr(:function, signature, Expr(:block, body)))

    return ctx
end

function wrap_hsa_struct!(ctx::AbstractContext, cursor::CLStructDecl)
    # make sure a empty struct is indeed an opaque struct typedef/typealias
    # cursor = canonical(cursor)  # this won't work
    cursor = type(cursor) |> canonical |> typedecl
    cursor_name = name(cursor)
    # handle typedef anonymous struct
    idx = ctx.children_index
    if 0 < idx < length(ctx.children)
        next_cursor = ctx.children[idx+1]
        if is_typedef_anon(cursor, next_cursor)
            cursor_name = name(next_cursor)
        end
    end
    !isempty(ctx.force_name) && (cursor_name = ctx.force_name;)
    cursor_name == "" && (@warn("Skipping unnamed StructDecl: $cursor"); return ctx)

    struct_sym = symbol_safe(cursor_name)
    ismutable = get(ctx.options, "is_struct_mutable", false)
    buffer = ctx.common_buffer

    # generate struct declaration
    block = Expr(:block)
    expr = Expr(:struct, ismutable, struct_sym, block)
    deps = OrderedSet{Symbol}()
    struct_fields = children(cursor)
    for (field_idx, field_cursor) in enumerate(struct_fields)
        field_name = name(field_cursor)
        field_kind = kind(field_cursor)
        if field_kind == CXCursor_StructDecl || field_kind == CXCursor_UnionDecl
            continue
        elseif field_kind == CXCursor_FirstAttr && field_idx == 1
            continue
        elseif field_kind != CXCursor_FieldDecl || field_kind == CXCursor_TypeRef || kind(type(field_cursor)) == CXType_FunctionNoProto
            buffer[struct_sym] = ExprUnit(Clang.Poisoned())
            @warn "Skipping struct: \"$cursor\" due to unsupported field: $field_cursor"
            return ctx
        elseif isempty(field_name)
            error("Unnamed struct member in: $cursor ... cursor: $field_cursor")
        end
        
        

        if occursin("anonymous", string(clang2julia(field_cursor)))
            idx = field_idx-1
            anonymous_record = struct_fields[idx]
            while idx != 0 && kind(anonymous_record) == CXCursor_FieldDecl
                idx -= 1
                anonymous_record = struct_fields[idx]
            end
            if idx == field_idx-1
                ctx.anonymous_counter += 1
                anon_name = "ANONYMOUS$(ctx.anonymous_counter)_"*spelling(field_cursor)
                ctx.force_name = anon_name
                wrap!(ctx, anonymous_record)
                ctx.force_name = ""
                repr = symbol_safe(anon_name)
            else
                anon_name = "ANONYMOUS$(ctx.anonymous_counter)_"*spelling(struct_fields[idx+1])
                repr = symbol_safe(anon_name)
            end
        else
            repr = clang2julia(field_cursor)
        end
        push!(block.args, Expr(:(::), symbol_safe(field_name), repr))
        push!(deps, target_type(repr))
    end

    # check for a previous forward ordering
    if !(struct_sym in keys(buffer)) || buffer[struct_sym].state == :empty
        if !isempty(struct_fields)
            buffer[struct_sym] = ExprUnit(expr, deps)
        else
            # opaque struct typedef/typealias
            buffer[struct_sym] = ExprUnit(:(const $struct_sym = Cvoid), deps, state=:empty)
        end
    end

    return ctx
end


