using Clang.Generators
using hsa_rocr_jll

cd(@__DIR__)

include_dir = normpath(hsa_rocr_jll.artifact_dir, "include")
hsa_dir = joinpath(include_dir, "hsa")

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, "-I$include_dir")

headers = [joinpath(hsa_dir, header) for header in ["hsa.h", "hsa_ext_amd.h"]]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
