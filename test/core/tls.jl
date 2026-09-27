using Test
using AMDGPU
using AMDGPU: ROCArray, HIPDevice, HIPStream

@testset "Device" begin
    d1 = @inferred AMDGPU.device()
    @test d1 isa HIPDevice

    AMDGPU.device!(d1)

    d2 = AMDGPU.device()
    @test d1 ≡ d2

    x = AMDGPU.device!(() -> ROCArray{Int}(undef, 16), d1)
    @test AMDGPU.device(x) ≡ d1
end

@testset "GC finalizers leave task-local state alone" begin
    # GC runs finalizers on whichever task it interrupts. Freeing an array makes
    # HIP calls, which must not create state on that task.
    weak_array() = WeakRef(ROCArray{Float32}(undef, 16))
    w = weak_array()
    no_state, collected = fetch(@async begin
        GC.gc(true)
        (AMDGPU.task_local_state() ≡ nothing, w.value ≡ nothing)
    end)
    @test collected
    @test no_state
end

if length(AMDGPU.devices()) > 1
    @testset "Scoped switch in a GC finalizer" begin
        # Destructors use `context!(f, ctx)`. In a GC finalizer, it must switch
        # for the HIP calls in `f` without touching the interrupted task's state.
        default = fetch(@async AMDGPU.device())
        other = first(d for d in AMDGPU.devices() if d != default)
        ctx = AMDGPU.HIPContext(other)
        seen = Ref{Any}(nothing)
        function weak_switcher()
            obj = Ref(0)
            finalizer(obj) do _
                seen[] = AMDGPU.context!(ctx) do
                    AMDGPU.HIP.hipDeviceSynchronize() # a checked call
                    AMDGPU.HIP.device()
                end
            end
            return WeakRef(obj)
        end
        w = weak_switcher()
        no_state, collected = fetch(@async begin
            GC.gc(true)
            (AMDGPU.task_local_state() ≡ nothing, w.value ≡ nothing)
        end)
        @test collected
        @test seen[] == other
        @test no_state
    end
end

@testset "Stream" begin
    s1 = @inferred AMDGPU.stream()
    @test s1 isa AMDGPU.HIPStream

    AMDGPU.stream!(s1)

    s2 = AMDGPU.stream()
    @test s1 ≡ s2

    AMDGPU.stream!(() -> AMDGPU.ones(Float32, 16), s1)
    @test AMDGPU.stream() ≡ s1

    @testset "Priority" begin
        @test AMDGPU.priority() == :normal

        AMDGPU.priority!(:low)
        @test AMDGPU.priority() == :low

        AMDGPU.priority!(:high)
        @test AMDGPU.priority() == :high

        AMDGPU.priority!(:normal)
        s1 = AMDGPU.stream()

        AMDGPU.priority!(() -> AMDGPU.ones(Float32, 16), :low)
        s2 = AMDGPU.stream()
        @test s1 ≡ s2
    end

    @testset "Validity" begin
        s = HIPStream()
        @test AMDGPU.HIP.isvalid(s)

        finalize(s)
        @test !AMDGPU.HIP.isvalid(s)

        # Must return true without segfaulting on an already-finalized stream.
        @test AMDGPU.HIP.isdone(s) == true
    end

    if length(AMDGPU.devices()) > 1
        @testset "Stream finalizer keeps the running task's device" begin
            # Finalizers run on whichever task triggers GC. The stream finalizer
            # must not move that task onto the stream's device.
            default = fetch(@async AMDGPU.device())
            other = first(d for d in AMDGPU.devices() if d != default)
            s = AMDGPU.device!(() -> HIPStream(), other)
            @test s.device == other
            @test fetch(@async (finalize(s); AMDGPU.device())) == default
        end
    end
end
