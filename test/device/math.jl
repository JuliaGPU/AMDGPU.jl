using Base.FastMath

@testset "Math Intrinsics" begin
    for T in (Float16, Float32, Float64)
        a = rand(T, 16) .* T(42)
        d_a = ROCArray(a)

        for f in (frexp, x->ldexp(x, Int32(2)), sincos, sincospi)
            b = map(f, a)
            d_b = map(f, d_a)
            for out_idx in 1:length(f(a[1]))
                @test all(
                    sc -> (sc[1][out_idx] ≈ sc[2][out_idx]),
                    zip(b, Array(d_b)))
            end
        end
    end
end
