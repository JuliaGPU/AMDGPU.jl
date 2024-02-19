@testset "Wavefront Shuffle" begin
    ws = AMDGPU.HIP.wavefrontsize(AMDGPU.device())

    # Shift values between lanes by 1 to the left in a wavefront.
    function ker_shfl!(x, ::Type{T}, ws) where T
        i = AMDGPU.Device.activelane()
        x[i + 1] = AMDGPU.Device.shfl(T(i), i + 1, ws)
        return
    end

    # Same as above, but fill both high and low bits.
    function ker_shfl_composed!(x, ::Type{T}, ws) where T
        i = AMDGPU.Device.activelane()
        v = T(i) << (sizeof(T) * 4) | T(i)
        x[i + 1] = AMDGPU.Device.shfl(v, i + 1, ws)
        return
    end

    # Same as the first kernel, but instead test for even lane id.
    function ker_shfl_bool!(x, ws)
        i = AMDGPU.Device.activelane()
        x[i + 1] = AMDGPU.Device.shfl(i % 2 == 0, i + 1, ws)
        return
    end

    @testset "shfl T=$T" for T in (
        UInt8, UInt16, UInt32,
        Int8, Int16, Int32,
        Float16, Float32, Float64,
    )
        target = Array{T}(undef, ws)
        for i in 1:ws
            target[i] = i % ws
        end

        x = ROCArray{T}(undef, ws)
        @roc groupsize=ws ker_shfl!(x, T, ws)
        @test Array(x) == target
    end

    @testset "shfl composed T=$T" for T in (UInt64, UInt128, Int64, Int128)
        target = Array{T}(undef, ws)
        for i in 1:ws
            v = T(i % ws)
            v = (v << (sizeof(T) * 4)) | v
            target[i] = v
        end

        x = ROCArray{T}(undef, ws)
        @roc groupsize=ws ker_shfl_composed!(x, T, ws)
        @test Array(x) == target
    end

    @testset "shfl boolean" begin
        target = [i % 2 == 0 for i in 1:ws]

        x = ROCArray{Bool}(undef, ws)
        @roc groupsize=ws ker_shfl_bool!(x, ws)
        @test Array(x) == target
    end
end

@testset "Wavefront Operations" begin
    wavefrontsize = AMDGPU.HIP.wavefrontsize(AMDGPU.device())

    function reduce_kernel(op,X,Y)
        idx = workitemIdx().x
        Y[1] = AMDGPU.Device.wfred(op,X[idx])
        nothing
    end
    function scan_kernel(op,X,Y)
        idx = workitemIdx().x
        Y[idx] = AMDGPU.Device.wfscan(op,X[idx],true)
        nothing
    end
    function bool_kernel(X,Y)
        idx = workitemIdx().x
        Y[1] = AMDGPU.Device.wfany(X[idx])
        Y[2] = AMDGPU.Device.wfall(X[idx])
        Y[3] = AMDGPU.Device.wfsame(X[idx])
        nothing
    end

    for T in (Cint, Clong, Cuint, Culong)
        X = rand(T(1):T(100), wavefrontsize)
        for op in (Base.:+, max, min, Base.:&, Base.:|, Base.:⊻)
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            @roc groupsize=wavefrontsize reduce_kernel(op,RX,RY)
            @test Array(RY)[1] == reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,wavefrontsize))
            @roc groupsize=wavefrontsize scan_kernel(op,RX,RY)
            @test Array(RY) == accumulate(op,X)
        end
    end

    for T in (Float16, Float32, Float64)
        X = rand(T, wavefrontsize)
        for op in (Base.:+, max, min)
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            @roc groupsize=wavefrontsize reduce_kernel(op,RX,RY)
            @test Array(RY)[1] ≈ reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,wavefrontsize))
            @roc groupsize=wavefrontsize scan_kernel(op,RX,RY)
            @test Array(RY) ≈ accumulate(op,X)
        end
    end

    for X in (
        rand(Cint(0):Cint(1), wavefrontsize),
        zeros(Cint, wavefrontsize),
        ones(Cint, wavefrontsize),
    )
        RX, RY = ROCArray(X), ROCArray(zeros(Bool,3))
        @roc groupsize=wavefrontsize bool_kernel(RX,RY)
        Y = Array(RY)

        @test_skip Y[1] == all(x -> x == 1, X)
        @test_skip Y[2] == any(x->x==1,X)
        @test_skip Y[3] == (length(unique(X)) == 1)
    end
end

@testset "Wavefront Information" begin
    wavefrontsize = AMDGPU.HIP.wavefrontsize(AMDGPU.device())
    @test wavefrontsize == 32 || wavefrontsize == 64

    function kernel(X)
        X[1] = Device.wavefrontsize()
        nothing
    end
    RX = ROCArray(zeros(UInt32, 1))
    @roc kernel(RX)
    AMDGPU.synchronize()
    @allowscalar @test RX[1] == wavefrontsize
end
