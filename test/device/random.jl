using Random

const n = 256

function apply_seed(seed)
    if seed === missing
        # should result in different numbers across launches
        Random.seed!()
        # XXX: this currently doesn't work, because of the definition in Base,
        #      `seed!(r::MersenneTwister=default_rng())`, which breaks overriding
        #      `default_rng` with a non-MersenneTwister RNG.
    elseif seed !== nothing
        # should result in the same numbers
        Random.seed!(seed)
    elseif seed === nothing
        # should result in different numbers across launches,
        # as determined by the seed set during module loading.
    end
end

wavefrontsize64 = AMDGPU.HIP.wavefrontsize(AMDGPU.device()) == 32 ? [false, true] : [true]

@testset "rand($T), seed $seed, wavefrontsize64 = $wavefrontsize64" for T in (
    Int32, UInt32, Int64, UInt64, Int128, UInt128, Float16, Float32, Float64,
), seed in (nothing, #=missing,=# 1234), wavefrontsize64 in wavefrontsize64
    # different kernel invocations should get different numbers
    @testset "across launches" begin
        function kernel(A::AbstractArray{T}, seed) where {T}
            apply_seed(seed)
            tid = workitemIdx().x
            A[tid] = rand(T)
            return nothing
        end

        a = AMDGPU.zeros(T, n)
        b = AMDGPU.zeros(T, n)

        @roc groupsize=n kernel(a, seed)
        @roc groupsize=n kernel(b, seed)

        if seed === nothing || seed === missing
            @test Array(a) != Array(b)
        else
            @test Array(a) == Array(b)
        end
    end

    # multiple calls to rand should get different numbers
    @testset "across calls" begin
        function kernel(A::AbstractArray{T}, B::AbstractArray{T}, seed) where {T}
            apply_seed(seed)
            tid = workitemIdx().x
            A[tid] = rand(T)
            B[tid] = rand(T)
            return nothing
        end

        a = AMDGPU.zeros(T, n)
        b = AMDGPU.zeros(T, n)

        @roc groupsize=n kernel(a, b, seed)

        @test Array(a) != Array(b)
    end

    # different threads should get different numbers
    @testset "across threads" for active_dim in 1:6
        function kernel(A::AbstractArray{T}, seed) where {T}
            apply_seed(seed)
            id = workitemIdx().x*workitemIdx().y*workitemIdx().z*workgroupIdx().x*workgroupIdx().y*workgroupIdx().z
            if 1 <= id <= length(A)
                A[id] = rand(T)
            end
            return nothing
        end

        tx, ty, tz, bx, by, bz = [dim == active_dim ? 3 : 1 for dim in 1:6]
        gx, gy, gz = tx*bx, ty*by, tz*bz
        a = AMDGPU.zeros(T, 3)

        @roc groupsize=(tx, ty, tz) gridsize=(gx, gy, gz) kernel(a, seed)

        # NOTE: we don't just generate two numbers and compare them, instead generating a
        #       couple more and checking they're not all the same, in order to avoid
        #       occasional collisions with lower-precision types (i.e., Float16).
        @test length(unique(Array(a))) > 1
    end
end

@testset "basic randn($T), seed $seed, wavefrontsize64 = $wavefrontsize64" for T in (
    Float16, Float32, Float64,
), seed in (nothing, #=missing,=# 1234), wavefrontsize64 in wavefrontsize64
    function kernel(A::AbstractArray{T}, seed) where {T}
        apply_seed(seed)
        tid = workitemIdx().x
        A[tid] = randn(T)
        return
    end

    a = AMDGPU.zeros(T, n)
    b = AMDGPU.zeros(T, n)

    @roc groupsize=n kernel(a, seed)
    @roc groupsize=n kernel(b, seed)

    if seed === nothing || seed === missing
        @test Array(a) != Array(b)
    else
        @test Array(a) == Array(b)
    end
end

@testset "basic randexp($T), seed $seed, wavefrontsize64 = $wavefrontsize64" for T in (
    Float16, Float32, Float64,
), seed in (nothing, #=missing,=# 1234), wavefrontsize64 in wavefrontsize64
    function kernel(A::AbstractArray{T}, seed) where {T}
        apply_seed(seed)
        tid = workitemIdx().x
        A[tid] = randexp(T)
        return
    end

    a = AMDGPU.zeros(T, n)
    b = AMDGPU.zeros(T, n)

    @roc groupsize=n kernel(a, seed)
    @roc groupsize=n kernel(b, seed)

    if seed === nothing || seed === missing
        @test Array(a) != Array(b)
    else
        @test Array(a) == Array(b)
    end
end
