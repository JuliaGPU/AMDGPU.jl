using Clang.Generators
using JuliaFormatter

include_dir = normpath("/opt/rocm/include")
rocfft_dir  = joinpath(include_dir, "rocfft")
options = load_options("rocfft/rocfft-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocfft_dir, header)
    for header in readdir(rocfft_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
