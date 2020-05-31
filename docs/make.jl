using Documenter, AMDGPU

makedocs(
    sitename="AMDGPU.jl",
    pages = [
        "Home" => "index.md",
        "Quick Start" => "quickstart.md",
        "Global Variables" => "globals.md",
        "Exceptions" => "exceptions.md",
        "Memory" => "memory.md",
        "Intrinsics" => [
            "Execution Control" => "execution_control.md",
        ],
        "API Reference" => "api.md"
    ]
)

