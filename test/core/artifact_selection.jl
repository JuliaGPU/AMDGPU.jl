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

@testset "HSA_OVERRIDE_GFX_VERSION" begin
    runtime = AMDGPU.ROCm_Runtime
    mktempdir() do nodes
        for (node, target) in ("0" => 0, "1" => 110501, "2" => 90010)
            mkpath(joinpath(nodes, node))
            write(joinpath(nodes, node, "properties"),
                "simd_count 16\ngfx_target_version $target\nvendor_id 4098\n")
        end
        arch(env...) = runtime.rocm_arch_linux(nodes, Dict{String, String}(env...))

        @test arch() == ["gfx1151", "gfx90a"]
        @test arch("HSA_OVERRIDE_GFX_VERSION" => "") == ["gfx1151", "gfx90a"]
        @test arch("HSA_OVERRIDE_GFX_VERSION_1" => "11.0.0") == ["gfx1100", "gfx90a"]
        @test arch("HSA_OVERRIDE_GFX_VERSION_2" => "9.0.8") == ["gfx1151", "gfx908"]
        @test arch("HSA_OVERRIDE_GFX_VERSION_2" => "9.0.12") == ["gfx1151", "gfx90c"]

        # rejected by the runtime: other major version, or malformed
        @test (@test_logs (:warn, r"major version") match_mode=:any arch(
            "HSA_OVERRIDE_GFX_VERSION" => "11.0.0")) == ["gfx1100", "gfx90a"]
        # the per-node variable takes precedence
        @test (@test_logs (:warn, r"major version") match_mode=:any arch(
            "HSA_OVERRIDE_GFX_VERSION" => "11.0.0",
            "HSA_OVERRIDE_GFX_VERSION_1" => "11.0.3")) == ["gfx1103", "gfx90a"]
        for invalid in ("11.0", "11.0.0.0", "11.0.0 ", "gfx1100", "11.0.256", "64.0.0")
            @test (@test_logs (:warn, r"invalid") match_mode=:any arch(
                "HSA_OVERRIDE_GFX_VERSION_1" => invalid)) == ["gfx1151", "gfx90a"]
        end
    end

    @test runtime.rocm_arch_matches("gfx110X", "gfx1100")
    @test !runtime.rocm_arch_matches("gfx110X", "gfx1151")
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

# The version of the back-end JLL is the LLVM version it is built from, so any looser bound
# would let a new LLVM, and the device libraries built with it, reach released versions.
@testset "AMDGPU_LLVM_Backend_jll is pinned" begin
    version = Base.thispatch(pkgversion(AMDGPU.AMDGPU_LLVM_Backend_jll))
    compat = Pkg.TOML.parsefile(joinpath(pkgdir(AMDGPU), "Project.toml"))["compat"]["AMDGPU_LLVM_Backend_jll"]
    bound = Pkg.Types.semver_spec(compat)
    @test version in bound
    @test Base.nextpatch(version) ∉ bound
    # the LLVM version comes from the library, not from the version of the JLL
    @test AMDGPU.Compiler.external_llvm_version() >= v"23"
end
