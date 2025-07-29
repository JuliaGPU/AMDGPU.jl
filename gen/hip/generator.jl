using Clang.Generators
using JuliaFormatter

include_dir = normpath(joinpath(ENV["ROCM_PATH"], "include"))
hip_dir = joinpath(include_dir, "hip")
options = load_options("hip/hip-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")
push!(args, "-I$hip_dir")
push!(args, "-D__HIP_PLATFORM_AMD__")

headers = [
    joinpath(hip_dir, header)
    for header in readdir(hip_dir)
    if header == "hip_runtime_api.h"
]

ctx = create_context(headers, args, options)

# build without printing so we can do custom rewriting
build!(ctx, BUILDSTAGE_NO_PRINTING)

const no_prepare_state = Set([
    :hipDriverGetVersion,
    :hipRuntimeGetVersion,
    :hipInit,
    :hipDeviceGet,
    :hipCtxCreate,
    :hipCtxDestroy,
    :hipCtxSetCurrent,
    :hipCtxGetCurrent,
    :hipGetDevice,
    :hipSetDevice,
    :hipGetDeviceCount,
    :hipGetDeviceProperties,
    :hipDeviceGetName,
    :hipDeviceGetAttribute,
    :hipGetDevicePropertiesR0600,
    :hipChooseDeviceR0600,
 ])

# custom rewriter
function rewrite!(e::Expr)
    if e.head === :const
        @assert Meta.isexpr(e.args[1], :(=))
        rhs = e.args[1].args[2]
        if Meta.isexpr(rhs, :call) && rhs.args[1] == :(-) && rhs.args[2] == :Cint
            e.args[1].args[2] = :(Cint(-$(rhs.args[3])))
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
        ex.args[1] = Symbol("@gcsafe_ccall")
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
