@testset "getinfo queries" begin
    @testset "ROCDevice" begin
        device = AMDGPU.default_device()
        for (kind, T) in AMDGPU.Runtime.AGENT_INFO_MAP
            result = AMDGPU.getinfo(device, kind)
            result_raw = AMDGPU.getinfo(device.agent, kind)
            if T === Vector{UInt8}
                @test result isa AbstractString
                @test result_raw isa AbstractString
            else
                @test result isa T
                @test result_raw isa T
            end
            @test result == result_raw
        end
    end
    @testset "HSA.ISA" begin
        device = AMDGPU.default_device()
        device_isa = first(AMDGPU.Runtime.isas(device))
        for (kind, T) in AMDGPU.Runtime.ISA_INFO_MAP
            result = AMDGPU.getinfo(device_isa, kind)
            if T === Vector{UInt8}
                @test result isa AbstractString
            else
                @test result isa T
            end
        end
    end
    @testset "ROCMemoryRegion" begin
        device = AMDGPU.default_device()
        region = first(AMDGPU.Runtime.regions(device))
        for (kind, T) in AMDGPU.Runtime.REGION_INFO_MAP
            if kind == AMDGPU.HSA.REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE &&
               (AMDGPU.Runtime.region_segment(region) & AMDGPU.HSA.REGION_SEGMENT_PRIVATE == 0)
                # TODO: Test this too
                continue
            end
            result = AMDGPU.getinfo(region, kind)
            result_raw = AMDGPU.getinfo(region.region, kind)
            if T === Vector{UInt8}
                @test result isa AbstractString
                @test result_raw isa AbstractString
            else
                @test result isa T
                @test result_raw isa T
            end
            @test result == result_raw
        end
    end
    @testset "ROCMemoryPool" begin
        device = AMDGPU.default_device()
        pool = first(AMDGPU.Runtime.memory_pools(device))
        for (kind, T) in AMDGPU.Runtime.POOL_INFO_MAP
            result = AMDGPU.getinfo(pool, kind)
            result_raw = AMDGPU.getinfo(pool.pool, kind)
            if T === Vector{UInt8}
                @test result isa AbstractString
                @test result_raw isa AbstractString
            else
                @test result isa T
                @test result_raw isa T
            end
            @test result == result_raw
        end
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
        for (kind, T) in AMDGPU.Runtime.EXECUTABLE_SYMBOL_INFO_MAP
            result = AMDGPU.getinfo(exec_sym, kind)
            if T === Vector{UInt8}
                @test result isa AbstractString
            else
                @test result isa T
            end
        end
    end
end
