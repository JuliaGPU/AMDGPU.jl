@testset "Hostcall" begin

@testset "Call: Async" begin
    function kernel(a,b,sig)
        hostcall!(sig)
        b[1] = a[1]

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    dref = Ref{Bool}(false)
    hc = HostCall(Nothing, Tuple{}) do
        dref[] = true
    end

    wait(@roc kernel(HA, HB, hc))

    @test Array(HB)[1] == 1f0
    sleep(1)
    @test dref[] == true
end

@testset "Call: Async error" begin
    function kernel(a,b,sig)
        hostcall!(sig)
        b[1] = a[1]

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    dref = Ref{Bool}(false)

    # This should throw an exception and the error message should be logged.
    @test_logs (:error, "Hostcall error") begin
        hc, hc_task = HostCall(Nothing, Tuple{}; return_task=true) do
            error("Some error")
            dref[] = true
        end

        wait(@roc kernel(HA, HB, hc))
        sleep(1)

        @test Array(HB)[1] == 1f0
        @test dref[] == false
        @test Base.istaskfailed(hc_task)
    end
end

@testset "Call: Sync (0 args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig)::Float32
        b[1] = a[1] + inc

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Float32, Tuple{}) do
        1f0
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 2f0
end

@testset "Call: Sync (1 arg)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0)::Float32
        b[1] = a[1] + inc

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Float32, Tuple{Float32}) do arg1
        arg1 + 1f0
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 44f0
end

@testset "Call: Sync (2 homogeneous args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0, 3f0)::Float32
        b[1] = a[1] + inc

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Float32, Tuple{Float32,Float32}) do arg1, arg2
        arg1 + arg2 + 1f0
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 47f0
end

@testset "Call: Sync (2 heterogeneous args)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 42f0, Int16(3))::Float32
        b[1] = a[1] + inc

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Float32, Tuple{Float32,Int16}) do arg1, arg2
        arg1 + Float32(arg2) + 1f0
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 47f0
end

@testset "Call: Sync (2 heterogeneous args, return homogeneous tuple)" begin
    function kernel(a,b,sig)
        inc1, inc2 = hostcall!(sig, 42f0, Int16(3))::Tuple{Float32,Float32}
        b[1] = a[1] + inc1 + inc2

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Tuple{Float32,Float32}, Tuple{Float32,Int16}) do arg1, arg2
        (arg1 + Float32(arg2) + 1f0, 1f0)
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 48f0
end

@testset "Call: Sync (2 heterogeneous args, return heterogeneous tuple)" begin
    function kernel(a,b,sig)
        inc1, inc2 = hostcall!(sig, 42f0, Int16(3))::Tuple{Float32,Int64}
        b[1] = a[1] + inc1 + Float32(inc2)

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Tuple{Float32,Int64}, Tuple{Float32,Int16}) do arg1, arg2
        (arg1 + Float32(arg2) + 1f0, 1)
    end

    wait(@roc kernel(HA, HB, hc))

    sleep(1)
    @test Array(HB)[1] == 48f0
end

@testset "Call: Sync (2 hostcalls, 1 kernel)" begin
    function kernel(a,b,sig1,sig2)
        inc1 = hostcall!(sig1, 3f0)::Float32
        inc2 = hostcall!(sig2, 4f0)::Float32
        b[1] = a[1] + inc1 + inc2

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc1 = HostCall(Float32, Tuple{Float32}) do arg1
        arg1 + 1f0
    end
    hc2 = HostCall(Float32, Tuple{Float32}) do arg1
        arg1 + 2f0
    end

    wait(@roc kernel(HA, HB, hc1, hc2))

    sleep(1)
    @test Array(HB)[1] == 11f0
end

@testset "Call: Sync (1 hostcall, 2 kernels)" begin
    function kernel(a,b,sig)
        inc = hostcall!(sig, 3f0)::Float32
        b[1] = a[1] + inc

        nothing
    end

    A = ones(Float32, 1)
    B = zeros(Float32, 1)
    HA = HSAArray(A)
    HB = HSAArray(B)

    hc = HostCall(Float32, Tuple{Float32}; continuous=true) do arg1
        arg1 + 1f0
    end

    # FIXME: wait() hangs here, probably race condition?
    @roc kernel(HA, HB, hc)
    @roc kernel(HA, HB, hc)

    sleep(1)
    @test Array(HB)[1] == 5f0
end

end
