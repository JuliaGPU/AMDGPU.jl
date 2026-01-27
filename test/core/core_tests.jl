using Test
using AMDGPU
using AMDGPU: HIP, Runtime, Device, Mem

@testset "core" begin

@testset "Functional" begin
    @test AMDGPU.has_rocm_gpu() isa Bool
    @test AMDGPU.functional() isa Bool
end

@testset "HIPDevice" begin
    @testset "Device props" begin
        devices = AMDGPU.devices()
        for (idx, device) in enumerate(devices)
            @test AMDGPU.device_id(device) == idx

            if HIP.runtime_version() > v"6"
                device_name = HIP.name(device)
                @test length(device_name) > 0
            end

            @test occursin("gfx", HIP.gcn_arch(device))
            @test HIP.wavefrontsize(device) in (32, 64)
        end
    end
end

@testset "ISA parsing" begin
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx1030")
    @test dev_isa == "gfx1030"
    @test isempty(features)
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:sramecc+:xnack-")
    @test dev_isa == "gfx90a"
    @test features == "+sramecc"
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:sramecc+:xnack+")
    @test dev_isa == "gfx90a"
    @test features == "+sramecc,+xnack"
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:xnack-")
    @test dev_isa == "gfx90a"
    @test isempty(features)
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:xnack+")
    @test dev_isa == "gfx90a"
    @test features == "+xnack"
end

@testset "Comparison" begin
    s = AMDGPU.stream()
    @test s == deepcopy(s)

    c = AMDGPU.context()
    @test c == deepcopy(c)

    d = AMDGPU.device()
    @test d == deepcopy(d)
end

end
