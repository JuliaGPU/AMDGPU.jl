using Test
import AMDGPU

# Pkg runs the artifact selection hook in a subprocess. Under `Pkg.test` its load path has
# no `@stdlib`, so the hook can only load what ROCm_Runtime's `Project.toml` declares.
@testset "ROCm_Runtime artifact selection hook" begin
    selector = joinpath(pkgdir(AMDGPU.ROCm_Runtime), ".pkg", "select_artifacts.jl")
    mktempdir() do project
        cmd = `$(Base.julia_cmd()) --startup-file=no --project=$project $selector`
        @test success(pipeline(addenv(cmd, "JULIA_LOAD_PATH" => "@"); stderr))
    end
end
