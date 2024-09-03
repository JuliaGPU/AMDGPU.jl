@testitem "enzyme" begin

using AMDGPU
using EnzymeCore, Enzyme
using GPUCompiler

@testset "CompilerJob from backend" begin
    job = EnzymeCore.compiler_job_from_backend(ROCBackend(), typeof(()->nothing), Tuple{})
    @test job isa GPUCompiler.CompilerJob
end

function square_kernel!(x)
    i = workgroupIdx().x
    x[i] *= x[i]
    AMDGPU.sync_workgroup()
    return
end

function square!(x)
    @roc groupsize=length(x) gridsize=1 square_kernel!(x)
    return nothing
end

@testset "Forward Kernel" begin
    A = AMDGPU.rand(64)
    dA = AMDGPU.ones(64)
    A .= (1:1:64)
    dA .= 1
    Enzyme.autodiff(Forward, square!, Duplicated(A, dA))
    @test all(dA .≈ (2:2:128))
    display(dA); println()
end


end
