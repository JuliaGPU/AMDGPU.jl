using Test
using AMDGPU
using AMDGPU: HIP, Runtime, Device, Mem

@testset "core" begin

@testset "Functional" begin
    @test AMDGPU.has_rocm_gpu() isa Bool
    @test AMDGPU.functional() isa Bool
end

@testset "versioninfo probe isolation" begin
    probe(code; timeout = 60) = AMDGPU._version_subprocess(code; timeout)

    # A clean child returns its stdout. Library paths reach it through `repr`,
    # so Windows separators must survive the round trip.
    @test probe("print(\"4.2.0\")") == "4.2.0"
    @test probe("print($(repr(raw"C:\rocm\lib")))") == raw"C:\rocm\lib"

    # No package environment, so probing can't trigger a precompile (#1040).
    @test probe("print(Base.load_path())") == "String[]"
    @test probe("using Adapt; print(\"loaded\")") === :exit1

    # A failing child reports why without taking down this process — the point
    # of the isolation: a SIGSEGV in a vendor library (issue #920) must not
    # crash the caller.
    @test probe("ccall(:abort, Cvoid, ())") === :crashed       # SIGABRT
    @test probe("unsafe_store!(Ptr{Int}(0), 0)") === :crashed  # SIGSEGV
    @test probe("exit(2)") === :exit2                          # nonzero exit
    @test probe("1 + 1") === :empty                            # no output
    @test probe("while true; end"; timeout = 2) === :timeout   # hang -> timeout

    # On a working setup the probe returns a version; repeats hit the cache.
    if AMDGPU.functional(:rocsparse)
        AMDGPU._ROCSPARSE_VERSION = ""
        v = AMDGPU._rocsparse_version_isolated()
        @test tryparse(VersionNumber, v) !== nothing
        @test AMDGPU._rocsparse_version_isolated() === v
    end
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
