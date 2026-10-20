using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
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

@testset "min/max" begin
    # NaNs propagate and -0 < +0, as on the host
    for T in (Float16, Float32, Float64)
        vals = T[NaN, -Inf, Inf, -floatmax(T), -1, -0.0, 0.0, 1, floatmax(T),
                 nextfloat(zero(T)), -nextfloat(zero(T)), floatmin(T) / 2, floatmin(T)]
        xs = repeat(vals; outer=length(vals))
        ys = repeat(vals; inner=length(vals))
        dxs, dys = ROCArray(xs), ROCArray(ys)
        @test isequal(Array(min.(dxs, dys)), min.(xs, ys))
        @test isequal(Array(max.(dxs, dys)), max.(xs, ys))
    end

    # Atomix implements these with a CAS loop around `min`/`max`, or with
    # `atomicrmw fminimum`/`fmaximum` on recent Julia versions
    function atomic_minmax!(a, xs)
        x = @inbounds xs[AMDGPU.workitemIdx().x]
        @inbounds AMDGPU.@atomic max(a[1], x)
        @inbounds AMDGPU.@atomic min(a[2], x)
        return
    end
    for T in (Float16, Float32, Float64)
        for (xs, expected) in ((T[1, NaN, 2], (T(NaN), T(NaN))),
                               (T[NaN, 2, 1], (T(NaN), T(NaN))),
                               (T[-0.0, 0.0], (T(0.0), T(-0.0))),
                               (T[0.0, -0.0], (T(0.0), T(-0.0))))
            a = ROCArray(T[xs[1], xs[1]])
            @roc groupsize=length(xs) atomic_minmax!(a, ROCArray(xs))
            @test isequal(Tuple(Array(a)), expected)
        end
    end
end

@testset "Fast min/max" begin
    function ker!(x)
        x[1] = @fastmath max(x[1], zero(eltype(x)))
        x[2] = @fastmath min(x[2], zero(eltype(x)))
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

@testset "Degree trigonometry" begin
    # `sind`/`cosd` are overridden in `device/quirks.jl` so that their
    # `DomainError` does not box its argument into a malloc hostcall.
    function kernel_ir(f, T)
        kernel(out, x) = (@inbounds out[1] = sum(f(x[1])); nothing)
        io = IOBuffer()
        AMDGPU.code_llvm(io, kernel,
            Tuple{AMDGPU.Device.ROCDeviceVector{T, 1}, AMDGPU.Device.ROCDeviceVector{T, 1}};
            kernel=true, dump_module=true)
        return String(take!(io))
    end

    for T in (Float32, Float64), f in (sind, cosd, tand, sincosd, cotd, secd, cscd)
        @test !occursin("__malloc_hostcall", kernel_ir(f, T))
    end

    angles = [0, 1, 30, 44.9, 45, 90, 135, 179.9, 180, 225,
              270, 315, 359.9, 360, 720, -45, -90, -180, -270, 12345.678]
    for T in (Float16, Float32, Float64)
        a = T.(angles)
        d_a = ROCArray(a)

        for f in (sind, cosd, tand, cotd, secd, cscd)
            @test Array(f.(d_a)) ≈ f.(a) nans=true
        end
        @test Array(map(x -> sincosd(x)[1], d_a)) ≈ first.(sincosd.(a)) nans=true
        @test Array(map(x -> sincosd(x)[2], d_a)) ≈ last.(sincosd.(a)) nans=true

        # Exact at the quadrant boundaries, unlike `sin(deg2rad(x))`.
        @test Array(sind.(ROCArray(T[0, 180, 360, -180]))) == T[0, 0, 0, 0]
        @test Array(cosd.(ROCArray(T[90, 270, -90]))) == T[0, 0, 0]

        @test all(isnan, Array(sind.(ROCArray(T[NaN]))))
        @test all(isnan, Array(cosd.(ROCArray(T[NaN]))))
    end
end
