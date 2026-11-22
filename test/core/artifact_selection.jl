using Test
import AMDGPU
import Pkg

# Pkg runs the artifact selection hook in a subprocess. Under `Pkg.test` its load path has
# no `@stdlib`, so the hook can only load what ROCm_Runtime's `Project.toml` declares.
@testset "ROCm_Runtime artifact selection hook" begin
    selector = joinpath(pkgdir(AMDGPU.ROCm_Runtime), ".pkg", "select_artifacts.jl")
    mktempdir() do project
        cmd = `$(Base.julia_cmd()) --startup-file=no --project=$project $selector`
        @test success(pipeline(addenv(cmd, "JULIA_LOAD_PATH" => "@"); stderr))
    end
end

# The three descriptions of the shipped ROCm releases have to agree, and AMDGPU is bound to
# one ROCm minor, so that a new one only reaches users together with an AMDGPU release.
@testset "ROCm_Runtime release consistency" begin
    runtime = AMDGPU.ROCm_Runtime
    toolkits = runtime.rocm_toolkits
    version = pkgversion(runtime)
    @test Base.thisminor(version) == Base.thisminor(maximum(toolkits))

    artifacts = Pkg.TOML.parsefile(joinpath(pkgdir(runtime), "Artifacts.toml"))["ROCm_Runtime"]
    @test Set(entry["rocm"] for entry in artifacts) == Set("$(v.major).$(v.minor)" for v in toolkits)

    compat = Pkg.TOML.parsefile(joinpath(pkgdir(AMDGPU), "Project.toml"))["compat"]["ROCm_Runtime"]
    bound = Pkg.Types.semver_spec(compat)
    @test version in bound
    @test Base.nextminor(version) ∉ bound
end
