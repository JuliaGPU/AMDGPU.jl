using Clang.Generators
using rocBLAS_jll

include_dir = normpath(rocBLAS_jll.artifact_dir, "include")
rocblas_dir = joinpath(include_dir, "rocblas")
options = load_options("rocblas/rocblas-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocblas_dir, header)
    for header in readdir(rocblas_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)
