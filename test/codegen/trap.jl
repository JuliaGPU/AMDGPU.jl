@testset "Trapping" begin
    # TODO: Remove dummy argument
    function trapkern(x)
        Device.trap()
        nothing
    end
    function debugtrapkern(x)
        Device.debugtrap()
        nothing
    end

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, trapkern, Tuple{Int}; kernel=true)
    @test occursin("s_trap 2", String(take!(iob)))
    iob = IOBuffer()
    AMDGPU.code_gcn(iob, debugtrapkern, Tuple{Int}; kernel=true)
    @test occursin("s_trap 3", String(take!(iob)))
end
