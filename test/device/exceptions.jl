@testset "Exceptions" begin

function oob_kernel(X)
    X[0] = 1
    nothing
end

RA = ROCArray(ones(Float32, 4))
try
    wait(@roc oob_kernel(RA))
catch err
    @test err isa AMDGPU.KernelException
    if err isa AMDGPU.KernelException
        @test err.exstr !== nothing
        @test occursin("BoundsError", err.exstr)
    end
end

end
