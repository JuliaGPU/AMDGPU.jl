using Clang.Generators

include_dir = normpath("/opt/rocm/include")
rocfft_dir  = joinpath(include_dir, "rocsparse")
options = load_options("rocsparse/rocsparse-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocfft_dir, header)
    for header in readdir(rocfft_dir)
    if endswith(header, ".h")
]

ctx = create_context(headers, args, options)
build!(ctx)
