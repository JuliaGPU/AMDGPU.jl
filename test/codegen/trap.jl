if !IS_NAVI_2
    @testset "Trapping" begin
        function trapkern()
            Device.trap()
            nothing
        end
        function debugtrapkern()
            Device.debugtrap()
            nothing
        end

        iob = IOBuffer()
        AMDGPU.code_gcn(iob, trapkern, Tuple{}; kernel=true)
        @test occursin("s_trap 2", String(take!(iob)))
        iob = IOBuffer()
        AMDGPU.code_gcn(iob, debugtrapkern, Tuple{}; kernel=true)
        @test occursin("s_trap 3", String(take!(iob)))
    end
end
