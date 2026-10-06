using Test
using AMDGPU

import KernelInterface
import KernelInterface as KI
include(joinpath(pkgdir(KernelInterface), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

function ki_fill!(A)
    i = KI.get_global_id().x
    if i <= length(A)
        @inbounds A[i] = i
    end
    return
end

@testset "kernelinterface" begin

backend = ROCBackend()
Testsuite.testsuite(backend, ROCArray)

@testset "copyto!" begin
    # host to host
    a = zeros(Float32, 4)
    @test KI.copyto!(backend, a, ones(Float32, 4)) === a
    @test a == ones(Float32, 4)

    # contiguous views of host arrays (those of a `ROCArray` are `ROCArray`s)
    dev = AMDGPU.zeros(Float32, 4)
    host = Float32[1, 2, 3, 4, 5, 6]
    @test KI.copyto!(backend, dev, view(host, 2:5)) === dev
    KI.synchronize(backend)
    @test Array(dev) == [2, 3, 4, 5]
    KI.copyto!(backend, view(host, 1:4), AMDGPU.ones(Float32, 4))
    KI.synchronize(backend)
    @test host == [1, 1, 1, 1, 5, 6]

    # only contiguous arrays
    @test_throws ArgumentError KI.copyto!(backend, view(AMDGPU.zeros(Float32, 8), 1:2:8), AMDGPU.ones(Float32, 4))
end

@testset "launch keywords" begin
    A = AMDGPU.zeros(Int, 4)
    kernel = KI.@launch backend launch=false ki_fill!(A)

    # AMDGPU's launch options are passed on
    kernel(A; ndrange=4, stream=AMDGPU.stream())
    @test Array(A) == 1:4

    # but not ones that would override the launch geometry
    @test_throws ArgumentError kernel(A; ndrange=4, groupsize=8)
    @test_throws ArgumentError kernel(A; ndrange=4, gridsize=2)
end

@testset "wavefront size" begin
    # kernels are compiled for the device's wavefront size
    ws = AMDGPU.HIP.wavefrontsize(AMDGPU.device())
    A = AMDGPU.zeros(Int, 4)
    tt = Tuple{typeof(KI.argconvert(backend, A))}
    @test KI.kernel_function(backend, ki_fill!, tt; wavefrontsize64 = ws == 64) isa KI.Kernel
    @test_throws ArgumentError KI.kernel_function(backend, ki_fill!, tt; wavefrontsize64 = ws == 32)
end

end
