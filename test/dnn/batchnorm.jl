@testset "Different input dimensions" begin
    for sz in ((3, 2), (4, 3, 2), (5, 4, 3, 2))
        x = AMDGPU.ones(Float32, sz)
        γ = AMDGPU.ones(Float32, sz[end - 1])
        β = AMDGPU.zeros(Float32, sz[end - 1])
        μ = AMDGPU.zeros(Float32, sz[end - 1])
        ν = AMDGPU.ones(Float32, sz[end - 1])

        y = MIOpen.batchnorm_inference(x, γ, β, μ, ν)
        @test all(isapprox.(Array(y), 1; atol=1f-5))

        y, μ_saved, ν_saved = MIOpen.batchnorm_training(
            x, γ, β, μ, ν; iteration=0)
        @test all(isapprox.(Array(y), 0; atol=1f-5))

        hμ_saved, hν_saved = Array(μ_saved), Array(ν_saved)

        dy = AMDGPU.ones(Float32, size(y))
        dx, dγ, dβ = MIOpen.∇batchnorm(dy, x, γ, β, μ_saved, ν_saved)

        hμ_saved2, hν_saved2 = Array(μ_saved), Array(ν_saved)

        @test hμ_saved ≈ hμ_saved2
        @test hν_saved ≈ hν_saved2
    end
end
