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
        devbranch="main",
        devurl="dev",
        push_preview=true,
    )

    makedocs(;
        modules=[AMDGPU],
        sitename="AMDGPU.jl",
        format=DocumenterVitepress.MarkdownVitepress(;
            repo,
            deploy_url,
            devbranch="main",
            devurl="dev",
            deploy_decision,
        ),
        pages=[
            "Home" => "index.md",
            "Tutorials" => [
                "Quick Start" => "tutorials/quickstart.md",
                "Custom Structs in Kernels" => "tutorials/custom_structs.md",
                "Performance Tips" => "tutorials/perf.md",
                "Profiling" => "tutorials/profiling.md",
                "Installation Tips" => "install_tips.md",
                "Testing" => "testing.md",
            ],
            "Usage" => [
                "Array Programming" => "usage/arrays.md",
                "Tasks and Streams" => "usage/multitasking.md",
                "KernelAbstractions" => "usage/kernelabstractions.md",
            ],
            "API" => [
                "Devices" => "api/devices.md",
                "System and Configuration" => "api/system.md",
                "Streams" => "api/streams.md",
                "Kernel Programming" => "api/kernel_programming.md",
                "Reflection" => "api/reflection.md",
                "Graphs" => "api/graphs.md",
                "Exceptions" => "api/exceptions.md",
                "Memory" => "api/memory.md",
                "Host-Call" => "api/hostcall.md",
                "Printing" => "api/printing.md",
                "Intrinsics" => "api/intrinsics.md",
            ],
            "Libraries" => [
                "Linear Algebra" => "libraries/linalg.md",
                "Sparse Arrays" => "libraries/sparse.md",
                "Fourier Transforms" => "libraries/fft.md",
                "Random Numbers" => "libraries/rand.md",
                "Deep Learning (MIOpen)" => "libraries/dnn.md",
            ],
            "FAQ" => "faq.md",
        ],
        doctest=true,
        warnonly=[:missing_docs],
    )
    if ci
        @info "Deploying to GitHub"
        DocumenterVitepress.deploydocs(;
            repo="github.com/JuliaGPU/AMDGPU.jl.git",
            push_preview=true,
            target="build",
            devbranch="main",
        )
    end
end
isinteractive() || main()
