using Clang.Generators
using MIOpen_jll

include_dir = normpath(MIOpen_jll.artifact_dir, "include")
miopen_dir = joinpath(include_dir, "miopen")
options = load_options("generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(miopen_dir, header)
    for header in readdir(miopen_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)
