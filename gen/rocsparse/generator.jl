using Clang.Generators
using JuliaFormatter

include_dir = normpath("/opt/rocm/include")
rocsparse_dir  = joinpath(include_dir, "rocsparse")
options = load_options("rocsparse/rocsparse-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocsparse_dir, header)
    for header in readdir(rocsparse_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
