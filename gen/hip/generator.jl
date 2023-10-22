using Clang.Generators

include_dir = "/opt/rocm/include"
hip_dir = joinpath(include_dir, "hip")
options = load_options("hip/hip-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

# headers = [
#     joinpath(hip_dir, header)
#     for header in readdir(hip_dir)
#     if endswith(header, ".h")
# ]
headers = [joinpath(hip_dir, "hip_runtime_api.h")]
@show headers

ctx = create_context(headers, args, options)
build!(ctx)
