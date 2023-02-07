@testset "getinfo queries" begin
    @testset "ROCDevice" begin
        device = AMDGPU.default_device()
        @test AMDGPU.Runtime.name(device) isa String
        @test AMDGPU.Runtime.device_type(device) isa AMDGPU.HSA.DeviceType
        @test AMDGPU.Runtime.device_wavefront_size(device) isa UInt32
    end
    @testset "HSA.ISA" begin
        device = AMDGPU.default_device()
        device_isa = AMDGPU.default_isa(device)
        @test AMDGPU.Runtime.isa_workgroup_max_size(device_isa) isa UInt32
    end
    @testset "ROCMemoryRegion" begin
        device = AMDGPU.default_device()
        region = first(AMDGPU.Runtime.regions(device))
        @test AMDGPU.Runtime.region_segment(region) isa AMDGPU.HSA.RegionSegment
        @test AMDGPU.Runtime.region_runtime_alloc_allowed(region) isa Bool
        @test AMDGPU.Runtime.region_runtime_alloc_granule(region) isa Csize_t
    end
    @testset "ROCMemoryPool" begin
        device = AMDGPU.default_device()
        pool = first(AMDGPU.Runtime.memory_pools(device))
        @test AMDGPU.Runtime.pool_segment(pool) isa AMDGPU.HSA.AMDSegment
        @test AMDGPU.Runtime.pool_size(pool) isa Csize_t
        @test AMDGPU.Runtime.pool_accessible_by_all(pool) isa Bool
    end
    @testset "HSA.ExecutableSymbol" begin
        device = AMDGPU.default_device()
        kernel = @roc launch=false identity(nothing)
        exe = kernel.mod.exe
        sym_name = kernel.fun.entry
        exec_sym = AMDGPU.Runtime.executable_symbol_any(exe, device)
        if exec_sym === nothing
            exec_sym = AMDGPU.Runtime.executable_symbol_by_name(exe, device, sym_name)
        end
        @test AMDGPU.Runtime.executable_symbol_name(exec_sym) isa String
        @test AMDGPU.Runtime.executable_symbol_kernel_private_segment_size(exec_sym) isa UInt32
    end
end
