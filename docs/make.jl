using AMDGPU
using Documenter
using DocumenterVitepress

# const dst = "https://amdgpu.juliagpu.org/stable/"

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
        # format=Documenter.HTML(
        #     # Use clean URLs on CI
        #     prettyurls = ci,
        #     canonical = dst,
        #     assets = ["assets/favicon.ico"],
        #     analytics = "UA-154489943-2",
        # ),
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
                "Quick Start" => "tutorials/index.md",
            ],
            "API" => [
                "Devices" => "api/index.md",
                "Streams" => "api/streams.md",
                "Kernel Programming" => "api/kernel_programming.md",
                "Exceptions" => "api/exceptions.md",
                "Profiling" => "api/profiling.md",
                "Memory" => "api/memory.md",
                "Host-Call" => "api/hostcall.md",
                "Printing" => "api/printing.md",
                "Logging" => "api/logging.md",
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
