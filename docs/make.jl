using Documenter, AMDGPUnative

makedocs(
    sitename="AMDGPU.jl",
    pages = [
        "Home" => "index.md",
        "Quick Start" => "quickstart.md",
        "Global Variables" => "globals.md",
        "API Reference" => "api.md"
    ]
)

