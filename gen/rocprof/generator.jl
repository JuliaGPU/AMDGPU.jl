using Clang.Generators
using JuliaFormatter

include_dir = normpath("/home/simeon/Documents/rocm/TheRock/output-linux-portable/build/profiler/rocprofiler-sdk/dist/include")
rocprof_dir  = joinpath(include_dir, "rocprofiler-sdk")
options = load_options("rocprof/rocprof-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")
push!(args, "-D__HIP_PLATFORM_AMD__")

headers = [
    joinpath(rocprof_dir, header)
    # for header in readdir(rocprof_dir)
    # if endswith(header, ".h")
    for header in ("rocprofiler.h",)
]
#push!(headers, joinpath(include_dir, "hip/driver_types.h"))

ctx = create_context(headers, args, options)
build!(ctx)

path = options["general"]["output_file_path"]
format_file(path, YASStyle())
