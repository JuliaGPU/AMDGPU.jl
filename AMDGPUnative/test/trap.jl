@testset "Trapping" begin
    # TODO: Remove dummy argument once HSARuntime is fixed
    function trapkern(x)
        AMDGPUnative.trap()
        nothing
    end
    function debugtrapkern(x)
        AMDGPUnative.debugtrap()
        nothing
    end

    iob = IOBuffer()
    AMDGPUnative.code_gcn(iob, trapkern, Tuple{Int}; kernel=true)
    @test occursin("s_trap 2", String(take!(iob)))
    iob = IOBuffer()
    AMDGPUnative.code_gcn(iob, debugtrapkern, Tuple{Int}; kernel=true)
    @test occursin("s_trap 3", String(take!(iob)))
end
