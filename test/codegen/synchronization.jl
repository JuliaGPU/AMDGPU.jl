@testset "Synchronization" begin
    # TODO: Remove dummy argument
    function synckern(x)
        Device.sync_workgroup()
        nothing
    end

    iob = IOBuffer()
    AMDGPU.code_gcn(iob, synckern, Tuple{Int}; kernel=true)
    @test occursin("s_barrier", String(take!(iob)))
end
