using Test
using AMDGPU
using AMDGPU: HIP

@testset "Memory pool" begin
    dev = AMDGPU.device()

    @testset "HIPMemoryPool with default keywords" begin
        pool = HIP.HIPMemoryPool(dev)
        @test pool.handle != C_NULL
        HIP.hipMemPoolDestroy(pool)
    end

    @testset "Exportable (IPC-capable) device memory" begin
        if AMDGPU.memory_pool_handle_type() == "posix_fd"
            @test AMDGPU.memory_pool_exportable(dev)
            x = AMDGPU.zeros(UInt8, 1 << 20)
            handle = Ref{HIP.hipIpcMemHandle_t}()
            @test (HIP.hipIpcGetMemHandle(handle, pointer(x)); true)
            AMDGPU.unsafe_free!(x)
        else
            @test !AMDGPU.memory_pool_exportable(dev)
        end
    end

    @testset "memory_pool_handle_type! argument check" begin
        @test_throws ArgumentError AMDGPU.memory_pool_handle_type!("cuda_ipc")
    end
end
