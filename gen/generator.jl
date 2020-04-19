using Clang, Clang.LibClang
using CEnum
using DataStructures, OrderedCollections 

include("clanghelpers.jl")

const HSA_INCLUDE = joinpath("..", "deps", "include", "hsa") |> normpath
const HSA_HEADERS = [joinpath(HSA_INCLUDE, header) for header in readdir(HSA_INCLUDE) if endswith(header, ".h")]

ctx = DefaultContext()

parse_headers!(ctx, HSA_HEADERS,
               args=["-I", joinpath(HSA_INCLUDE, ".."), "-fparse-all-comments"],
               includes=vcat(HSA_INCLUDE, CLANG_INCLUDE),
               flags = CXTranslationUnit_DetailedPreprocessingRecord
               )

ctx.libname = "libhsa"
ctx.options["is_function_strictly_typed"] = true
ctx.options["is_struct_mutable"] = false
    
blacklist = ["unix", "linux"]
blackprefix = ["Brig", "_"]

functions = Vector{CLCursor}()
remaining = Vector{CLCursor}()
typealiases = OrderedDict()

for trans_unit in ctx.trans_units

    root_cursor = getcursor(trans_unit)
    push!(ctx.cursor_stack, root_cursor)
    header = spelling(root_cursor)
    ctx.children = children(root_cursor)

    for (i, child) in enumerate(ctx.children)
        # Cursor properties
        child_name = name(child)
        child_kind = kind(child)
        if i > 1
            prev_name = name(ctx.children[i-1])
            prev_kind = kind(ctx.children[i-1])
        end
        if i < length(ctx.children)
            next_name = name(ctx.children[i+1])
            next_kind = kind(ctx.children[i+1])
        end
        ctx.children_index = i
        
        # Skip compiler constants/garbage and redundants
        child_kind == CXCursor_MacroInstantiation   && continue
        child_kind == CXCursor_LastPreprocessing    && continue
        child_name ∈ blacklist                      && continue
        any(startswith.(child_name, blackprefix))   && continue
        child_name ∈ keys(ctx.common_buffer)        && continue
        child_name ∈ name.(functions)               && continue 
        child_kind == CXCursor_FunctionDecl     && (wrap_hsa_fun!(ctx, child); push!(functions, child); continue)
        child_kind == CXCursor_StructDecl       && (wrap_hsa_struct!(ctx, child); continue) 
        child_kind == CXCursor_EnumDecl         && (wrap!(ctx, child); continue)
        child_kind == CXCursor_MacroDefinition  && (wrap!(ctx, child); continue)
        child_kind == CXCursor_VarDecl          && (wrap!(ctx, child); continue)

#=        # skip redundant and most unneeded types
        if child_kind == CXCursor_TypedefDecl
            if prev_kind ∈ (CXCursor_StructDecl, CXCursor_EnumDecl)
                if child_name[1:end-2] == prev_name[1:end-2]
                    push!(typealiases, child_name => prev_name) 
                    continue
                elseif i < length(ctx.children) && next_name != "" && startswith(child_name, next_name[1:end-2])
                    push!(typealiases, child_name => next_name)
                    continue
                elseif i > 0 && prev_name != "" && startswith(child_name, prev_name[1:end-2])
                    push!(typealiases, child_name => prev_name)
                    continue
                end
            elseif !(startswith(child_name, "hsa_") || startswith(child_name, "amd"))
                push!(remaining, child)
                continue
            end
        end
=#
        child_kind == CXCursor_TypedefDecl      && (wrap!(ctx, child); continue)
        
        push!(remaining, child)
    end
end


api_file = joinpath(@__DIR__, "libhsa_api_full.jl")
api_stream = open(api_file, "w")
print_buffer(api_stream, ctx.api_buffer)
empty!(ctx.api_buffer)
close(api_stream)

common_file = joinpath(@__DIR__, "libhsa_common_full.jl")
open(common_file, "w") do f
    print_buffer(f, dump_to_buffer(ctx.common_buffer))
end
