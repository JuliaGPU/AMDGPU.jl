
using Clang

# HSA_HEADERS are those headers to be wrapped.
const HSA_INCLUDE = joinpath(@__DIR__, "include") |> normpath

hsa_headers_base = joinpath(@__DIR__, "include", "hsa")
const HSA_HEADERS = String[]
push!(HSA_HEADERS, joinpath(hsa_headers_base, "hsa.h"))
push!(HSA_HEADERS, joinpath(hsa_headers_base, "hsa_ext_amd.h"))
push!(HSA_HEADERS, joinpath(hsa_headers_base, "hsa_ext_finalize.h"))
push!(HSA_HEADERS, joinpath(hsa_headers_base, "hsa_ext_image.h"))

wc = init(; headers = HSA_HEADERS,
            output_file = joinpath(@__DIR__, "hsa_interface.jl"),
            common_file = joinpath(@__DIR__, "hsa_types.jl"),
            clang_includes = vcat(HSA_INCLUDE, CLANG_INCLUDE),
            #clang_args = ["-I", joinpath(HSA_INCLUDE, "..")],
            header_wrapped = (root, current)->root == current,
            header_library = x->"libhsa-runtime64",
            clang_diagnostics = true,
            )

run(wc)

# Replace stuff
for (src,dst) in [("libhsa-runtime64","\"libhsa-runtime64\"")]
  for file in ("hsa_interface.jl", "hsa_types.jl")
    run(Cmd(["sed", "-i", "s/$src/$dst/g", file]))
  end
end
# Remove useless HSA_API macros
#run(Cmd(["sed", "-i", "/^.*HSA_API.*\$/d", "hsa_types.jl"]))
