using Clang

error("$(@__FILE__) is broken until Clang.jl supports wrapping C++")

# HIP_HEADERS are those headers to be wrapped.
const HIP_INCLUDE = joinpath(@__DIR__, "include") |> normpath

hip_headers_base = joinpath(@__DIR__, "include", "hip")
const HIP_HEADERS = String[]
push!(HIP_HEADERS, joinpath(hip_headers_base, "julia_hip_runtime.h"))

wc = init(; headers = HIP_HEADERS,
            output_file = joinpath(@__DIR__, "hip_interface.jl"),
            common_file = joinpath(@__DIR__, "hip_types.jl"),
            clang_includes = vcat(HIP_INCLUDE, CLANG_INCLUDE),
            #clang_args = ["-I", joinpath(HIP_INCLUDE, "..")],
            header_wrapped = (root, current)->root == current,
            header_library = x->"libhip-hcc",
            clang_diagnostics = true,
            )

run(wc)

# Replace stuff
#=
for (src,dst) in [("libhip-hcc","\"libhip-hcc\"")]
  for file in ("hip_interface.jl", "hip_types.jl")
    run(Cmd(["sed", "-i", "s/$src/$dst/g", file]))
  end
end
=#
# Remove useless HIP_API macros
#run(Cmd(["sed", "-i", "/^.*HIP_API.*\$/d", "hip_types.jl"]))
