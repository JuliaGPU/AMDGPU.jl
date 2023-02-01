@testset "NNlib comparison" begin
    for (T, atol) in ((Float16, 1f-3), (Float32, 1f-6))
        @show T

        x, dy = randn(T, 16), randn(T, 16)
        xd, dyd = ROCArray(x), ROCArray(dy)

        y = NNlib.relu(x)
        yd = MIOpen.relu(xd)
        @test all(isapprox.(Array(yd), y; atol))

        y = NNlib.leakyrelu(x, 0.1)
        yd = MIOpen.leakyrelu(xd, 0.1)
        @test all(isapprox.(Array(yd), y; atol))

        y = NNlib.softplus(x)
        yd = MIOpen.softrelu(xd)
        @test all(isapprox.(Array(yd), y; atol))

        y = NNlib.relu6(x)
        yd = MIOpen.clippedrelu(xd, 6)
        @test all(isapprox.(Array(yd), y; atol))

        y = NNlib.elu(x, 0.1)
        yd = MIOpen.elu(xd, 0.1)
        @test all(isapprox.(Array(yd), y; atol))

        y = abs.(x)
        yd = MIOpen.abs(xd)
        @test all(isapprox.(Array(yd), y; atol))

        y = NNlib.sigmoid(x)
        yd = MIOpen.sigmoid(xd)
        @test all(isapprox.(Array(yd), y; atol))

        y = tanh.(x)
        yd = MIOpen.tanh(xd)
        @test all(isapprox.(Array(yd), y; atol))

        # Non-negative values.

        x, dy = rand(T, 16), rand(T, 16)
        xd, dyd = ROCArray(x), ROCArray(dy)
        α, β, γ = T(1), T(1.1), T(1.2)

        y = (α .+ β .* x).^γ
        yd = MIOpen.power(xd, γ; α, β)
        @test all(isapprox.(Array(yd), y; atol=T == Float16 ? 1f-2 : atol))
    end
end
