using Test
using AMDGPU
using AMDGPU: ROCArray, @roc, ROCBackend
using AMDGPU.Device: workitemIdx
using GPUCompiler

# Check if Enzyme packages are installed
const enzyme_uuid = Base.UUID("7da242da-08ed-463a-9acd-ee780be4f1d9")
const enzyme_available = Base.locate_package(Base.PkgId(enzyme_uuid, "Enzyme")) !== nothing

if enzyme_available
    using EnzymeCore, Enzyme

    AMDGPU.allowscalar(false)

    Enzyme.Compiler.VERBOSE_ERRORS[] = true

    @testset "enzyme" begin

    @testset "CompilerJob from backend" begin
        job = EnzymeCore.compiler_job_from_backend(
            ROCBackend(), typeof(() -> nothing), Tuple{})
        @test job isa GPUCompiler.CompilerJob
    end

    function square_kernel!(x)
        i = workitemIdx().x
        x[i] *= x[i]
        return
    end

    function square!(x)
        @roc groupsize=length(x) gridsize=1 square_kernel!(x)
        return nothing
    end

    @testset "Forward Kernel" begin
        A = ROCArray(collect(1.0:64.0))
        dA = ROCArray(ones(Float64, 64))
        Enzyme.autodiff(Forward, square!, Duplicated(A, dA))
        @test all(dA .≈ (2:2:128))

        A = ROCArray(collect(1.0:64.0))
        dA = ROCArray(ones(Float64, 64))
        dA2 = ROCArray(ones(Float64, 64) .* 3.0)
        Enzyme.autodiff(Forward, square!, BatchDuplicated(A, (dA, dA2)))
        @test all(dA .≈ (2:2:128))
        @test all(dA2 .≈ (2:2:128) .* 3)
    end

    @testset "Reverse Kernel" begin
        A = ROCArray(collect(1.0:64.0))
        dA = ROCArray(ones(Float64, 64))
        Enzyme.autodiff(Reverse, square!, Duplicated(A, dA))
        @test all(dA .≈ (2:2:128))

        A = ROCArray(collect(1.0:64.0))
        dA = ROCArray(ones(Float64, 64))
        dA2 = ROCArray(ones(Float64, 64) .* 3.0)
        Enzyme.autodiff(Reverse, square!, BatchDuplicated(A, (dA, dA2)))
        @test all(dA .≈ (2:2:128))
        @test all(dA2 .≈ (2:2:128) .* 3)
    end

    end # @testset "enzyme"
else
    @info "Skipping Enzyme tests (Enzyme not installed)"
end
