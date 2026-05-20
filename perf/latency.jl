module Latency

using AMDGPU
using BenchmarkTools

function main()
    results = BenchmarkGroup()

    base_cmd = Base.julia_cmd()
    if Base.JLOptions().project != C_NULL
        base_cmd = `$base_cmd --project=$(unsafe_string(Base.JLOptions().project))`
    end
    # NOTE: we don't use Base.active_project() here because of how CI launches this script,
    #       starting with --project in the main AMDGPU.jl project.

    # time to precompile the package and its dependencies
    precompile_cmd =
        `$base_cmd -e "pkg = Base.identify_package(\"AMDGPU\")
                       Base.compilecache(pkg)"`
    results["precompile"] = @benchmark run($precompile_cmd) evals=1 seconds=60

    # time to actually import the package
    import_cmd =
        `$base_cmd -e "using AMDGPU"`
    results["import"] = @benchmark run($import_cmd) evals=1 seconds=30

    # time to actually compile a kernel (time to first kernel)
    ttfp_cmd =
        `$base_cmd -e "using AMDGPU
                       kernel() = return
                       AMDGPU.code_gcn(devnull, kernel, Tuple{}; kernel=true)"`
    results["ttfp"] = @benchmark run($ttfp_cmd) evals=1 seconds=60

    results
end

end

Latency.main()
