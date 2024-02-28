# NOTE: for this to work, in /opt/rocm/include/hip/hip_runtime_api.h
# add the following:
# #define __HIP_PLATFORM_AMD__
# right before:
# #if defined(__HIP_PLATFORM_AMD__) && !defined(__HIP_PLATFORM_NVIDIA__)

using Clang.Generators

include_dir = normpath("/opt/rocm/include")
hip_dir = joinpath(include_dir, "hip")
options = load_options("hip/hip-generator.toml")

args = get_default_args()
push!(args, "-I$include_dir")
push!(args, "-I$hip_dir")

headers = [
    joinpath(hip_dir, header)
    for header in readdir(hip_dir)
    if header == "hip_runtime_api.h"
]

ctx = create_context(headers, args, options)
build!(ctx)
