using AMDGPU
using Documenter
using DocumenterVitepress

const deploy_url = "https://amdgpu.juliagpu.org/"
const repo = "https://github.com/JuliaGPU/AMDGPU.jl"

function main()
    ci = get(ENV, "CI", "") == "true"
    DocMeta.setdocmeta!(AMDGPU, :DocTestSetup, :(using AMDGPU); recursive=true)

    deploy_config = Documenter.auto_detect_deploy_system()
    deploy_decision = Documenter.deploy_folder(
        deploy_config;
        repo,
        devbranch="master",
        devurl="dev",
        push_preview=true,
    )

    makedocs(;
        modules=[AMDGPU],
        sitename="AMDGPU.jl",
        format=DocumenterVitepress.MarkdownVitepress(;
            repo,
            deploy_url,
            devbranch="master",
            devurl="dev",
            deploy_decision,
        ),
        pages=[
            "Home" => "index.md",
            "Tutorials" => [
                "Quick Start" => "tutorials/quickstart.md",
                "Profiling" => "tutorials/profiling.md",
            ],
            "API" => [
                "Devices" => "api/devices.md",
                "Streams" => "api/streams.md",
                "Kernel Programming" => "api/kernel_programming.md",
                "Exceptions" => "api/exceptions.md",
                "Memory" => "api/memory.md",
                "Host-Call" => "api/hostcall.md",
                "Printing" => "api/printing.md",
                "Intrinsics" => "api/intrinsics.md",
            ],
        ],
        doctest=true,
        warnonly=[:missing_docs],
    )
    if ci
        @info "Deploying to GitHub"
        deploydocs(;
            repo="github.com/JuliaGPU/AMDGPU.jl.git",
            push_preview=true,
        )
    end
end
isinteractive() || main()
