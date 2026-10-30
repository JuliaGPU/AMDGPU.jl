using Test
using AMDGPU
using AMDGPU: HIPStream

# s_sleep instead of a clock: gfx11+ lacks s_memrealtime
function nap!(a, n)
    for _ in 1:n
        AMDGPU.Device.device_sleep(Int32(127))
    end
    a[1] = 1
    return
end
set2!(a) = (a[1] = 2; nothing)

@testset "Implicit synchronization of arrays" begin
    s1, s2 = HIPStream(), HIPStream()
    n = 300_000  # for about a second
    # compile the kernels first, so that nothing below waits for the compiler
    w = AMDGPU.zeros(Int, 1)
    @roc nap!(w, 1)
    @roc set2!(w)
    AMDGPU.synchronize()

    a = AMDGPU.zeros(Int, 4)
    @test AMDGPU.synchronization_enabled(a)

    # using the array on another stream waits for the stream that used it before
    @roc stream=s1 nap!(a, n)
    @roc stream=s2 set2!(a)
    @test AMDGPU.HIP.isdone(s1)
    AMDGPU.synchronize(a)
    @test Array(a)[1] == 2

    # disabled: no wait, but the memory is still recorded as used by the last stream
    @test AMDGPU.enable_synchronization!(a, false) === a
    @test !AMDGPU.synchronization_enabled(a)
    @test !AMDGPU.synchronization_enabled(reshape(a, 2, 2))  # same memory
    @roc stream=s1 nap!(a, n)
    @roc stream=s2 set2!(a)
    @test !AMDGPU.HIP.isdone(s1)
    @test a.buf[].stream === s2
    pointer(a)  # taking the pointer (for the task's stream) doesn't wait either
    @test !AMDGPU.HIP.isdone(s1)
    AMDGPU.synchronize(s1)
    AMDGPU.synchronize(s2)

    # re-enabled
    @test AMDGPU.enable_synchronization!(a) === a
    @test AMDGPU.synchronization_enabled(a)
    @roc stream=s1 nap!(a, n)
    @roc stream=s2 set2!(a)
    @test AMDGPU.HIP.isdone(s1)
    AMDGPU.synchronize(a)
    @test Array(a)[1] == 2

    # `synchronize(A)` waits for the stream that used the array last
    @roc stream=s1 nap!(a, n)
    AMDGPU.synchronize(a)
    @test AMDGPU.HIP.isdone(s1)
end
