using ForwardDiff
using ForwardDiff: Dual
using SpecialFunctions

function test_derivative(f, x::T) where T
    buf = ROCArray(zeros(T))

    function kernel(a, x)
        a[] = ForwardDiff.derivative(f, x)
        return
    end
    @roc kernel(buf, x)
    AMDGPU.synchronize()
    return AMDGPU.@allowscalar buf[]
end

testf(rocf, f, x) = test_derivative(rocf, x) ≈ ForwardDiff.derivative(f, x)

@testset "UNARY" begin
    function is_defined(intr)
        for (mod, intrinsic) in AMDGPU.Device.DEFINED_UNARY_INTRNISICS
            intr == intrinsic && return true
        end
        for (fname, intrinsic) in AMDGPU.Device.DEFINED_SF_INTRINSICS
            intr == fname && return true
        end
        return false
    end

    nonneg = [:log, :log1p, :log10, :log2, :sqrt, :asin, :acosh, :erfcinv]
    fs = filter(x -> (x[3] == 1) && is_defined(x), keys(ForwardDiff.DiffRules.DEFINED_DIFFRULES))

    for (m, fn, _) ∈ fs
        rocf = @eval $fn
        f = @eval $fn

        x32 = rand(Float32)
        x64 = rand(Float64)
        nx32 = -x32
        nx64 = -x64

        if fn == :acosh
            x32 += 1
            x64 += 1
        end

        @test testf(rocf, f, x32)
        @test testf(rocf, f, x64)

        if fn ∉ nonneg
            @test testf(rocf, f, nx32)
            @test testf(rocf, f, nx64)
        end
    end
end

@testset "POW" begin
    x32 = rand(Float32)
    x64 = rand(Float64)
    y32 = rand(Float32)
    y64 = rand(Float64)
    y = Int32(7)

    @test testf(x->x^y, x->x^y, x32)
    @test testf(x->x^y, x->x^y, x64)
    @test testf(x->x^y32, x->x^y32, x32)
    @test testf(x->x^y64, x->x^y64, x64)

    @test testf(y->x32^y, y->x32^y, y32)
    @test testf(y->x64^y, y->x64^y, y64)

    @test testf(x->x^x, x->x^x, x32)
    @test testf(x->x^x, x->x^x, x64)
end

@testset "LITERAL_POW" begin
    for x in [rand(Float32, 10), rand(Float64, 10)],
        p in [1, 2, 3, 4, 5]
        @test ForwardDiff.gradient(_x -> sum(_x .^ p), x) ≈ p .* (x .^ (p - 1))
    end
end

#= FIXME
@testset "Broadcast Fix" begin
    if AMDGPU.libmiopen !== nothing
        using NNlib

        f(x) = logσ.(x)
        ds = Dual.(rand(5),1)
        @test f(ds) ≈ collect(f(ROCArray(ds)))
    end
end
=#
