using Clang.Generators

include_dir = normpath("/opt/rocm/include")

rocsolver_dir  = joinpath(include_dir, "rocsolver")
options = load_options("rocsolver/rocsolver-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocsolver_dir, header)
    for header in readdir(rocsolver_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)
