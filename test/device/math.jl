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

@testset "Fast min/max" begin
    function ker!(x)
        x[1] = @fastmath max(x[1], eltype(x))
        x[1] = @fastmath min(x[1], eltype(x))
        return
    end

    for T in (Float16, Float32, Float64)
        x = ROCArray(ones(T, 2))
        @roc ker!(x)
        xh = Array(x)
        @test xh[1] ≈ 1
        @test xh[2] ≈ 0
    end
end
