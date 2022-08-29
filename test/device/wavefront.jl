@testset "Wavefront Operations" begin
    function reduce_kernel(op,X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[1] = AMDGPU.Device.wfred(op,X[idx])
        nothing
    end
    function scan_kernel(op,X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[idx] = AMDGPU.Device.wfscan(op,X[idx],true)
        nothing
    end
    function bool_kernel(X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[1] = AMDGPU.Device.wfany(X[idx])
        Y[2] = AMDGPU.Device.wfall(X[idx])
        Y[3] = AMDGPU.Device.wfsame(X[idx])
        nothing
    end

    for T in (Cint, Clong, Cuint, Culong)
        X = rand(T(1):T(100), 64)
        for op in (Base.:+, max, min, Base.:&, Base.:|, Base.:⊻)
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            wait(@roc groupsize=64 reduce_kernel(op,RX,RY))
            @test Array(RY)[1] == reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,64))
            wait(@roc groupsize=64 scan_kernel(op,RX,RY))
            @test Array(RY) == accumulate(op,X)
        end
    end
    for T in (Float32, Float64)
        X = rand(T, 64)
        for op in (Base.:+, max, min)
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            wait(@roc groupsize=64 reduce_kernel(op,RX,RY))
            @test Array(RY)[1] ≈ reduce(op,X)

            RX, RY = ROCArray(X), ROCArray(zeros(T,64))
            wait(@roc groupsize=64 scan_kernel(op,RX,RY))
            @test Array(RY) ≈ accumulate(op,X)
        end
    end
    for X in (rand(Cint(0):Cint(1), 64),
              zeros(Cint, 64),
              ones(Cint, 64),
              )
        RX, RY = ROCArray(X), ROCArray(zeros(Bool,3))
        wait(@roc groupsize=64 bool_kernel(RX,RY))
        Y = Array(RY)
        @test_skip Y[1] == all(x->x==1,X)
        @test_skip Y[2] == any(x->x==1,X)
        @test_skip Y[3] == (length(unique(X)) == 1)
    end
end

@testset "Wavefront Information" begin
    function kernel(X)
        X[1] = Device.wavefrontsize()
        nothing
    end
    RX = ROCArray(zeros(UInt32, 1))
    wait(@roc kernel(RX))
    @allowscalar @test RX[1] == 64
end
