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

    # Allocating a ROCArray inside the differentiated function must not be
    # differentiated through `pool_alloc` (its statistics counters are atomic and
    # on Julia 1.13 lower to `julia.atomicmodify`, which Enzyme rejects). The
    # constructor rules make the allocation inactive and zero the shadow.
    function square_into_kernel!(y, x)
        i = workitemIdx().x
        y[i] = x[i] * x[i]
        return
    end

    function copy_kernel!(y, x)
        i = workitemIdx().x
        y[i] = x[i]
        return
    end

    function square_via_temporary!(y, x)
        tmp = similar(x)
        @roc groupsize=length(x) gridsize=1 square_into_kernel!(tmp, x)
        @roc groupsize=length(x) gridsize=1 copy_kernel!(y, tmp)
        return nothing
    end

    @testset "Allocation inside differentiated function" begin
        x = ROCArray(collect(1.0:64.0))
        dx = ROCArray(ones(Float64, 64))
        y = ROCArray(zeros(Float64, 64))
        dy = ROCArray(zeros(Float64, 64))
        Enzyme.autodiff(Forward, square_via_temporary!, Duplicated(y, dy), Duplicated(x, dx))
        @test all(y .≈ (1:64) .^ 2)
        @test all(dy .≈ (2:2:128))

        x = ROCArray(collect(1.0:64.0))
        dx = ROCArray(zeros(Float64, 64))
        y = ROCArray(zeros(Float64, 64))
        dy = ROCArray(ones(Float64, 64))
        Enzyme.autodiff(Reverse, square_via_temporary!, Duplicated(y, dy), Duplicated(x, dx))
        @test all(y .≈ (1:64) .^ 2)
        @test all(dx .≈ (2:2:128))
    end

    end # @testset "enzyme"
else
    @info "Skipping Enzyme tests (Enzyme not installed)"
end
