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
            "Kernel Programming" => "kernel_programming.md",
            "Exceptions" => "exceptions.md",
            "Profiling" => "profiling.md",
            "Memory" => "memory.md",
            "Host-Call" => "hostcall.md",
            "Intrinsics" => [
                "Execution Control" => "execution_control.md",
            ],
            "Printing" => "printing.md",
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
