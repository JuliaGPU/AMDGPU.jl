using AMDGPU
using Documenter

function main()
    ci = get(ENV, "CI", "") == "true"

    @info "Generating Documenter site"
    makedocs(
        sitename="AMDGPU.jl",
        pages = [
            "Home" => "index.md",
            "Quick Start" => "quickstart.md",
            "Devices" => "devices.md",
            "Streams" => "streams.md",
            "Kernel Launch" => "kernel_launch.md",
            "Exceptions" => "exceptions.md",
            "Profiling" => "profiling.md",
            "Printing" => "printing.md",
            "Memory" => "memory.md",
            "Intrinsics" => [
                "Execution Control" => "execution_control.md",
                "Wavefront Operations" => "wavefront_ops.md",
            ],
            "Logging" => "logging.md",
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
