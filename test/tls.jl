"""
Create new task and new TLS, run `f` that modifies TLS and
return its initial state and after the change.
"""
function async_tls(f = () -> nothing; init = false)
    pre_tls = Ref{AMDGPU.TaskLocalState}()
    post_tls = Ref{AMDGPU.TaskLocalState}()
    wait(@async begin
        if init
            pre_tls[] = copy(AMDGPU.task_local_state!())
        end
        f()
        post_tls[] = copy(AMDGPU.task_local_state!())
    end)
    if init
        return pre_tls[], post_tls[]
    else
        return post_tls[]
    end
end

@testset "Basics" begin
    device = @inferred AMDGPU.device()
    @test device isa HIPDevice

    context = @inferred AMDGPU.context()
    @test context isa HIPContext
    @test AMDGPU.device_id(AMDGPU.device(context)) == AMDGPU.device_id(device)

    stream = @inferred AMDGPU.stream()
    @test stream isa HIPStream
    @test AMDGPU.device_id(AMDGPU.device(context)) == AMDGPU.device_id(device)

    tls = @inferred AMDGPU.task_local_state!()
    @test tls isa AMDGPU.TaskLocalState
    @test device === tls.device
    @test stream === tls.stream
    @test stream.priority == tls.stream.priority
    @test context === tls.context
end

if length(AMDGPU.devices()) > 1
    @testset "Devices" begin
        dev1 = AMDGPU.devices()[1]
        tls1 = copy(AMDGPU.task_local_state!())
        @assert tls1.device === dev1

        dev2 = AMDGPU.devices()[2]
        AMDGPU.device!(dev2)
        tls2 = copy(AMDGPU.task_local_state!())
        @test tls2.device === dev2
        @test tls2.stream isa HIPStream
        @test AMDGPU.device_id(AMDGPU.device(tls2.context)) == 2
        @test AMDGPU.device_id(AMDGPU.device(tls2.stream)) == 2

        @test tls1.device !== tls2.device
        @test tls1.context !== tls2.context
        @test tls1.stream !== tls2.stream

        AMDGPU.device!(dev1)
        tls3 = copy(AMDGPU.task_local_state!())
        @test tls3.device === dev1
        @test tls1.device === tls3.device
        @test tls1.context === tls3.context
        @test tls1.stream === tls3.stream
        @test AMDGPU.device_id(AMDGPU.device(tls3.context)) == 1
        @test AMDGPU.device_id(AMDGPU.device(tls3.stream)) == 1
    end
else
    @test_skip "TLS Multi-GPU"
end

@testset "Streams" begin
    strm = AMDGPU.stream()
    @test strm.priority == :normal

    # Create new task and get its TLS. Should be different than current.
    tls2 = async_tls()
    @test tls2.device === AMDGPU.device()
    @test tls2.context === AMDGPU.context()
    @test tls2.stream !== strm
    @test tls2.stream.priority == :normal

    # TLS from a different task does not modify original TLS.
    @test AMDGPU.stream() === strm

    AMDGPU.priority!(:high)
    strm2 = AMDGPU.stream()
    @test strm2 !== strm
    @test strm2.priority == :high

    AMDGPU.priority!(:low)
    strm2 = AMDGPU.stream()
    @test strm2 !== strm
    @test strm2.priority == :low

    AMDGPU.priority!(:normal)
    @test AMDGPU.stream().priority == :normal
end

function async_tls_lib(f = () -> nothing; lib::Symbol)
    tls = Ref{Any}()
    wait(@async begin
        f()
        tls[] = task_local_storage(lib)
    end)
    return tls[]
end

if AMDGPU.functional(:rocblas)
    @testset "rocBLAS" begin
        handle = AMDGPU.rocBLAS.handle()
        @test handle isa AMDGPU.rocBLAS.rocblas_handle

        # FIXME: Switch context/stream, check handle differs
    end
else
    @test_skip "rocBLAS"
end
if AMDGPU.functional(:rocrand)
end
if AMDGPU.functional(:rocfft)
end
if AMDGPU.functional(:MIOpen)
end
