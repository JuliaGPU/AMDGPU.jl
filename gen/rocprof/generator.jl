using Clang.Generators
using JuliaFormatter

include_dir = normpath("/opt/rocm/include")
rocprof_dir  = joinpath(include_dir, "rocprofiler-sdk")
options = load_options("rocprof/rocprof-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")

headers = [
    joinpath(rocprof_dir, header)
    # for header in readdir(rocprof_dir)
    # if endswith(header, ".h")
    for header in ("rocprofiler.h",)
]

ctx = create_context(headers, args, options)
build!(ctx)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
