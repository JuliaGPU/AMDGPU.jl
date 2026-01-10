using Test
using AMDGPU
using AMDGPU: ROCArray

@testset "Selection" begin
    x = rand(Int32, 16)
    m = rand(Bool, 16)
    xd, md = ROCArray.((x, m))
    @test x[m] == Array(xd[md])

    x = rand(Int32, 1, 16)
    xd = ROCArray(x)
    @test x[:, m] == Array(xd[:, md])

    x = rand(Int32, 3, 1, 16)
    xd = ROCArray(x)
    @test x[:, :, m] == Array(xd[:, :, md])
end
