@testset "Wavefront Operations" begin
    wavefrontsize = AMDGPU.wavefrontsize(AMDGPU.default_device())

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
            wait(@roc groupsize=wavefrontsize reduce_kernel(op,RX,RY))
            @test Array(RY)[1] == reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,wavefrontsize))
            wait(@roc groupsize=wavefrontsize scan_kernel(op,RX,RY))
            @test Array(RY) == accumulate(op,X)
        end
    end
    for T in (Float32, Float64)
        X = rand(T, wavefrontsize)
        for op in (Base.:+, max, min)
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            wait(@roc groupsize=wavefrontsize reduce_kernel(op,RX,RY))
            @test Array(RY)[1] ≈ reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,wavefrontsize))
            wait(@roc groupsize=wavefrontsize scan_kernel(op,RX,RY))
            @test Array(RY) ≈ accumulate(op,X)
        end
    end
    for X in (rand(Cint(0):Cint(1), wavefrontsize),
              zeros(Cint, wavefrontsize),
              ones(Cint, wavefrontsize),
              )
        RX, RY = ROCArray(X), ROCArray(zeros(Bool,3))
        wait(@roc groupsize=wavefrontsize bool_kernel(RX,RY))
        Y = Array(RY)
        @test_skip Y[1] == all(x->x==1,X)
        @test_skip Y[2] == any(x->x==1,X)
        @test_skip Y[3] == (length(unique(X)) == 1)
    end
end

@testset "Wavefront Information" begin
    wavefrontsize = AMDGPU.wavefrontsize(AMDGPU.default_device())

    @test wavefrontsize == 32 || wavefrontsize == 64

    function kernel(X)
        X[1] = Device.wavefrontsize()
        nothing
    end
    RX = ROCArray(zeros(UInt32, 1))
    wait(@roc kernel(RX))
    @allowscalar @test RX[1] == wavefrontsize
end
