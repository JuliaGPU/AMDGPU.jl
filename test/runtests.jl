using Test

include("setup.jl")

@testset "AMDGPU" begin
    @test length(AMDGPU.devices()) > 0
    @info "Testing using device $(AMDGPU.default_device())"
    AMDGPU.versioninfo()

    @testset "Core" begin
        include("pointer.jl")
    end
    @testset "HSA" begin
        include("hsa/error.jl")
        include("hsa/utils.jl")
        include("hsa/getinfo.jl")
        include("hsa/device.jl")
        include("hsa/queue.jl")
        include("hsa/memory.jl")
        include("hsa/hashing.jl")
    end
    @testset "Codegen" begin
        include("codegen/synchronization.jl")
        include("codegen/trap.jl")
    end
    @testset "Logging" begin
        include("logging.jl")
    end
    @testset "Device Functions" begin
        include("device/launch.jl")
        include("device/array.jl")
        include("device/vadd.jl")
        include("device/memory.jl")
        include("device/indexing.jl")
        include("device/hostcall.jl")
        include("device/output.jl")
        include("device/globals.jl")
        include("device/math.jl")
        include("device/wavefront.jl")
        include("device/execution_control.jl")
        include("device/exceptions.jl")
        # FIXME segfaults in a weird way (on check_ir)
        # include("device/deps.jl")
        include("device/queries.jl")
    end
    @testset "ROCArray - Base" begin
        include("rocarray/base.jl")
    end
    @testset "ROCArray - Broadcast" begin
        include("rocarray/broadcast.jl")
    end
    if CI
        @testset "ROCm libraries are functional" begin
            @test AMDGPU.functional(:rocblas)
            @test AMDGPU.functional(:rocrand)
            if !AMDGPU.use_artifacts
                # We don't have artifacts for these
                @test AMDGPU.functional(:rocfft)
            end
        end
    end
    @testset "rocBLAS" begin
        if AMDGPU.functional(:rocblas)
            include("rocarray/blas.jl")
        else
            @test_skip "rocBLAS"
        end
    end
    @testset "rocRAND" begin
        if AMDGPU.functional(:rocrand)
            include("rocarray/random.jl")
        else
            @test_skip "rocRAND"
        end
    end
    @testset "rocFFT" begin
        if AMDGPU.functional(:rocfft)
            include("rocarray/fft.jl")
        else
            @test_skip "rocFFT"
        end
    end
    @testset "NMF" begin
        if AMDGPU.functional(:rocblas)
            include("rocarray/nmf.jl")
        else
            @test_skip "NMF"
        end
    end
    @testset "MIOpen" begin
        if AMDGPU.functional(:MIOpen)
            include("dnn/miopen.jl")
        else
            @test_skip "MIOpen"
        end
    end
    @testset "External Packages" begin
        include("external/forwarddiff.jl")
    end
    @testset "GPUArrays test suite" begin
        TestSuite.test(ROCArray)
    end
end
