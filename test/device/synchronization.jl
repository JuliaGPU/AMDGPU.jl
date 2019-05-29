@testset "Synchronization" begin
    # TODO: Remove dummy argument once HSARuntime is fixed
    function synckern(x)
        sync_workgroup()
        nothing
    end

    iob = IOBuffer()
    AMDGPUnative.code_gcn(iob, synckern, Tuple{Int}; kernel=true)
    @test occursin("s_barrier", String(take!(iob)))
end
