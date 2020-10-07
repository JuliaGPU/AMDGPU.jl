@testset "Wavefront Operations" begin
    function reduce_kernel(op,X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[1] = AMDGPU.wfred(op,X[idx])
        nothing
    end
    function scan_kernel(op,X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[idx] = AMDGPU.wfscan(op,X[idx],true)
        nothing
    end
    function bool_kernel(X,Y)
        idx = AMDGPU.workitemIdx().x
        Y[1] = AMDGPU.wfany(X[idx])
        Y[2] = AMDGPU.wfall(X[idx])
        Y[3] = AMDGPU.wfsame(X[idx])
        nothing
    end

    for T in (Cint, Clong, Cuint, Culong)
        X = rand(T(1):T(100), 64)
        for op in (Base.:+, max, min, Base.:&, Base.:|, Base.:⊻)
            @info "reduce $T $op"
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            wait(@roc groupsize=64 reduce_kernel(op,RX,RY))
            @test Array(RY)[1] == reduce(op,X)

            @info "scan $T $op"
            RX, RY = ROCArray(X), ROCArray(zeros(T,64))
            wait(@roc groupsize=64 scan_kernel(op,RX,RY))
            @test Array(RY) == accumulate(op,X)
        end
    end
    for T in (Float32, Float64)
        X = rand(T, 64)
        for op in (Base.:+, max, min)
            @info "reduce $T $op"
            RX, RY = ROCArray(X), ROCArray(zeros(T,1))
            wait(@roc groupsize=64 reduce_kernel(op,RX,RY))
            @test Array(RY)[1] ≈ reduce(op,X)

            @info "scan $T $op"
            RX, RY = ROCArray(X), ROCArray(zeros(T,64))
            wait(@roc groupsize=64 scan_kernel(op,RX,RY))
            @test Array(RY) ≈ accumulate(op,X)
        end
    end
    for X in (rand(Cint(0):Cint(1), 64),
              zeros(Cint, 64),
              ones(Cint, 64),
              )
        @info "all/any/same $(typeof(X))"
        RX, RY = ROCArray(X), ROCArray(zeros(Bool,3))
        wait(@roc groupsize=64 bool_kernel(RX,RY))
        Y = Array(RY)
        @test Y[1] == all(x->x==1,X)
        @test Y[2] == any(x->x==1,X)
        @test Y[3] == (length(unique(X)) == 1)
    end
end
