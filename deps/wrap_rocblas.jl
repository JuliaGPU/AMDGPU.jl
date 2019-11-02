using Clang

#error("$(@__FILE__) is broken until Clang.jl supports wrapping C++")

# ROCBLAS_HEADERS are those headers to be wrapped.
const ROCBLAS_INCLUDE = joinpath(@__DIR__, "include") |> normpath

rocblas_headers_base = joinpath(@__DIR__, "include", "rocblas")
const ROCBLAS_HEADERS = String[]
push!(ROCBLAS_HEADERS, joinpath(rocblas_headers_base, "julia_rocblas.h"))

wc = init(; headers = ROCBLAS_HEADERS,
            output_file = joinpath(@__DIR__, "rocblas_interface.jl"),
            common_file = joinpath(@__DIR__, "rocblas_types.jl"),
            clang_includes = vcat(ROCBLAS_INCLUDE, CLANG_INCLUDE),
            #clang_args = ["-I", joinpath(ROCBLAS_INCLUDE, "..")],
            header_wrapped = (root, current)->root == current,
            header_library = x->"librocblas",
            clang_diagnostics = true,
            )

run(wc)

# Remove useless ROCBLAS_API macros
#run(Cmd(["sed", "-i", "/^.*ROCBLAS_API.*\$/d", "rocblas_types.jl"]))
