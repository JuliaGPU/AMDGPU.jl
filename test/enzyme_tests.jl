@testitem "enzyme" begin

using AMDGPU
using EnzymeCore, Enzyme
using GPUCompiler

@testset "CompilerJob from backend" begin
    job = EnzymeCore.compiler_job_from_backend(ROCBackend(), typeof(()->nothing), Tuple{})
    @test job isa GPUCompiler.CompilerJob
end

function square_kernel!(x)
    i = workitemIdx().x
    x[i] *= x[i]
    AMDGPU.sync_workgroup()
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
end


end
