cmd = Cmd([Base.julia_cmd()...,
           "--project=$(@__DIR__)/..",
           "-e", "using Pkg; " * ARGS[1]])
cd(joinpath(@__DIR__, "..")) do
    for version in (8, 7, 6)
        file = if version == 8
            "Manifest.toml"
        else
            "Manifest.toml.gpuarrays-$version"
        end
        println("Updating $file for GPUArrays v$version")
        if file != "Manifest.toml"
            mv("Manifest.toml", "Manifest.toml.bak")
            cp(file, "Manifest.toml")
        end
        run(cmd)
        if file != "Manifest.toml"
            mv("Manifest.toml", file; force=true)
            mv("Manifest.toml.bak", "Manifest.toml")
        end
    end
end
