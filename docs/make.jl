using Documenter, AMDGPU


function main()
    ci = get(ENV, "CI", "") == "true"

    @info "Generating Documenter site"
    makedocs(
        sitename="AMDGPU.jl",
        pages = [
            "Home" => "index.md",
            "Quick Start" => "quickstart.md",
            "Kernel Dependencies" => "kernel_deps.md",
            "Global Variables" => "globals.md",
            "Exceptions" => "exceptions.md",
            "Memory" => "memory.md",
            "Intrinsics" => [
                "Execution Control" => "execution_control.md",
                "Wavefront Operations" => "wavefront_ops.md",
            ],
            "API Reference" => "api.md"
        ]
    )
    if ci
        @info "Deploying to GitHub"
        deploydocs(
            repo = "github.com/JuliaGPU/AMDGPU.jl.git",
            push_preview = true
        )
    end
end

isinteractive() || main()
