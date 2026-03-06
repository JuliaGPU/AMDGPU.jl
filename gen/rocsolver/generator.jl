# NOTE: for this to work, in opt/rocm/include/rocsolver/rocsolver-functions.h
# replace all occurrences of "ROCSOLVER_EXPORT " by "".

using Clang, Clang.Generators
using JuliaFormatter

include_dir = normpath(joinpath(ENV["ROCM_PATH"], "include"))
rocblas_dir = joinpath(include_dir, "rocblas")#, "internal")
rocsolver_dir = joinpath(include_dir, "rocsolver")
options = load_options("rocsolver/rocsolver-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir", "-DROCSOLVER_EXPORT=")

headers_rocsolver = [
    joinpath(rocsolver_dir, header)
    for header in readdir(rocsolver_dir)
    if endswith(header, ".h")
]

headers_rocblas = [
    joinpath(rocblas_dir, header)
    for header in readdir(rocblas_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers_rocsolver ∪
 headers_rocblas, args, options)
build!(ctx, BUILDSTAGE_NO_PRINTING)

# Only keep the wrapped headers because the dependencies are already wrapped with other headers.
replace!(get_nodes(ctx.dag)) do node
    path = Clang.get_filename(node.cursor)
    should_wrap = any(headers_rocsolver) do header
        occursin(header, path)
    end
    if !should_wrap
        return ExprNode(node.id, Generators.Skip(), node.cursor, Expr[], node.adj)
    end
    return node
end

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

build!(ctx, BUILDSTAGE_PRINTING_ONLY)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
