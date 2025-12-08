using Clang.Generators
using JuliaFormatter

include_dir = normpath(joinpath(ENV["ROCM_PATH"], "include"))
rocrand_dir  = joinpath(include_dir, "rocrand")
options = load_options("rocrand/rocrand-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

rocrand_h = read(joinpath(rocrand_dir, "rocrand.h"), String)
open("./rocrand.h", "w") do io
    println(io, """
    #include <stddef.h>

    typedef void* hipStream_t;
    typedef struct { unsigned int x, y, z, w; } uint4;
    """)
    print(io, rocrand_h)
end
headers = [
    "./rocrand.h"
]

ctx = create_context(headers, args, options)

# build without printing so we can do custom rewriting
build!(ctx, BUILDSTAGE_NO_PRINTING)

# custom rewriter
function rewrite!(e::Expr)
    if e.head === :const
        @assert Meta.isexpr(e.args[1], :(=))
        rhs = e.args[1].args[2]
        if Meta.isexpr(rhs, :call)
            if rhs.args[1] == :(*) && rhs.args[3] == :f
                e.args[1].args[2] = :(Float32($(rhs.args[2])))
            elseif rhs.args[1] == :(Cuint)
                e.args[1].args[2] = :($(rhs.args[2]) % Cuint)
            end
        end
        return e
    end
    (e.head === :function && Meta.isexpr(e.args[1], :call)) || return e
    f = e.args[1].args[1]
    if !(f isa Symbol)
        @assert f in (:(Base.getproperty), :(Base.setproperty!), :(Base.propertynames))
        return e
    end
    stmts = e.args[2].args
    map!(stmts, stmts) do ex
        Meta.isexpr(ex, :macrocall) || return ex
        ex.args[1] === Symbol("@ccall") || return ex
        # TODO: should this be `@gcsafe_ccall`?
        # ex.args[1] = Symbol("@gcsafe_ccall")
        Expr(:macrocall, Symbol("@check"), nothing, ex)
    end
    pushfirst!(stmts, :(AMDGPU.prepare_state()))
    return e
end

function rewrite!(dag::ExprDAG)
    for node in get_nodes(dag)
        for expr in get_exprs(node)
            rewrite!(expr)
        end
    end
end

rewrite!(ctx.dag)

# print
build!(ctx, BUILDSTAGE_PRINTING_ONLY)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
