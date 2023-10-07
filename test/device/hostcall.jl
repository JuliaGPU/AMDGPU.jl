@testset "Hostcall" begin

@testset "Call: No return or arguments" begin
    function kernel(a,b,sig)
        hostcall!(sig)
        b[1] = a[1]
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))

    dref = Ref{Bool}(false)
    hc = HostCallHolder(Nothing, Tuple{}) do
        dref[] = true
        nothing
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 1f0
    @test dref[] == true
end

@testset "Call: Error" begin
    function kernel(a,b,sig)
        hostcall!(sig)
        b[1] = a[1]
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    dref = Ref{Bool}(false)

    @test_logs (:error, "HostCall error") begin
        hc = HostCallHolder(Nothing, Tuple{}) do
            error("Some error")
            dref[] = true
            nothing
        end

        @roc kernel(RA, RB, hc)
        @test_throws ErrorException AMDGPU.synchronize(; stop_hostcalls=true)
        AMDGPU.reset_exception_holder!(AMDGPU.device())

        @test Array(RB)[1] == 0f0
        @test dref[] == false
        sleep(1) # Give time for the task to shut down.
        @test Base.istaskfailed(hc.task)
    end
end

@testset "Call: (0 args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig)::Float32
        b[1] = a[1] + inc
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Float32, Tuple{}) do
        1f0
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 2f0
end

@testset "Call: (1 arg)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0)::Float32
        b[1] = a[1] + inc
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Float32, Tuple{Float32}) do arg1
        arg1 + 1f0
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 44f0
end

@testset "Call: (2 homogeneous args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0, 3f0)::Float32
        b[1] = a[1] + inc
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Float32, Tuple{Float32,Float32}) do arg1, arg2
        arg1 + arg2 + 1f0
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 47f0
end

@testset "Call: (2 heterogeneous args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0, Int16(3))::Float32
        b[1] = a[1] + inc
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Float32, Tuple{Float32,Int16}) do arg1, arg2
        arg1 + Float32(arg2) + 1f0
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 47f0
end

@testset "Call: (2 heterogeneous args, return homogeneous tuple)" begin
    function kernel(a,b,sig)
        inc1, inc2 = hostcall!(sig, 42f0, Int16(3))::Tuple{Float32,Float32}
        b[1] = a[1] + inc1 + inc2
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Tuple{Float32,Float32}, Tuple{Float32,Int16}) do arg1, arg2
        (arg1 + Float32(arg2) + 1f0, 1f0)
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 48f0
end

@testset "Call: (2 heterogeneous args, return heterogeneous tuple)" begin
    function kernel(a,b,sig)
        inc1, inc2 = hostcall!(sig, 42f0, Int16(3))::Tuple{Float32,Int64}
        b[1] = a[1] + inc1 + Float32(inc2)
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Tuple{Float32,Int64}, Tuple{Float32,Int16}) do arg1, arg2
        (arg1 + Float32(arg2) + 1f0, 1)
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 48f0
end

@testset "Call: (2 hostcalls, 1 kernel)" begin
    function kernel(a,b,sig1,sig2)
        inc1 = hostcall!(sig1, 3f0)::Float32
        inc2 = hostcall!(sig2, 4f0)::Float32
        b[1] = a[1] + inc1 + inc2
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc1 = HostCallHolder(Float32, Tuple{Float32}) do arg1
        arg1 + 1f0
    end
    hc2 = HostCallHolder(Float32, Tuple{Float32}) do arg1
        arg1 + 2f0
    end

    @roc kernel(RA, RB, hc1, hc2)
    AMDGPU.synchronize(; stop_hostcalls=true)
    @test Array(RB)[1] == 11f0
end

@testset "Call: (1 hostcall, 2 kernels)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 3f0)::Float32
        b[1] = a[1] + inc
        nothing
    end

    RA = ROCArray(ones(Float32, 1))
    RB = ROCArray(zeros(Float32, 1))
    hc = HostCallHolder(Float32, Tuple{Float32}; continuous=true) do arg1
        arg1 + 1f0
    end

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)

    @roc kernel(RA, RB, hc)
    AMDGPU.synchronize(; stop_hostcalls=true)

    # Next time HC will be called from the kernel is its last time.
    # So that it shutdowns correctly and does not stick to the end.
    AMDGPU.Device.finish!(hc)

    @test Array(RB)[1] == 5f0

    # Give HostCall task time to exit.
    sleep(2)
    @test istaskdone(hc)
end

end
