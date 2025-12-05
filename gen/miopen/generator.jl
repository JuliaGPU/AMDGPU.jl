using Clang.Generators
using JuliaFormatter

include_dir = normpath(joinpath(ENV["ROCM_PATH"], "include"))
miopen_dir = joinpath(include_dir, "miopen")
options = load_options("miopen/miopen-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(miopen_dir, header)
    for header in readdir(miopen_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)

# build without printing so we can do custom rewriting
build!(ctx, BUILDSTAGE_NO_PRINTING)

const no_prepare_state = Set([
    :miopenGetErrorString,
    :miopenGetVersion,
 ])

# custom rewriter
function rewrite!(e::Expr)
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
    if !(f in no_prepare_state)
        pushfirst!(stmts, :(AMDGPU.prepare_state()))
    end
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
