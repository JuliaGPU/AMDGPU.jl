using AMDGPU
using Clang.Generators

function main()
    options = load_options(joinpath(@__DIR__, "wrap.toml"))
    includedir = joinpath(dirname(AMDGPU.librocsparse),"..", "rocsparse", "include")

    args = get_default_args("x86_64-linux-gnu")
    push!(args, "-I$includedir")
    header_files = detect_headers(normpath(includedir), args)

    ctx = create_context(header_files, args, options)

    build!(ctx, BUILDSTAGE_NO_PRINTING)
    return ctx
end

# isinteractive() ||
 ctx = main()
 build!(ctx, BUILDSTAGE_PRINTING_ONLY)