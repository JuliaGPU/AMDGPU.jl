import .Device: OutputContext

@testset "@rocprintln" begin

@testset "Plain, no newline" begin
    function kernel(oc)
        @rocprint oc "Hello World!"
        nothing
    end

    iob = IOBuffer()
    oc = OutputContext(iob)
    @roc kernel(oc)
    sleep(1)
    @test String(take!(iob)) == "Hello World!"
end

@testset "Plain, with newline" begin
    function kernel(oc)
        @rocprintln oc "Hello World!"
        nothing
    end

    iob = IOBuffer()
    oc = OutputContext(iob)
    @roc kernel(oc)
    sleep(1)
    @test String(take!(iob)) == "Hello World!\n"
end

@testset "Plain, multiple calls" begin
    function kernel(oc)
        @rocprint oc "Hello World!"
        @rocprintln oc "Goodbye World!"
        nothing
    end

    iob = IOBuffer()
    oc = OutputContext(iob)
    @roc kernel(oc)
    sleep(1)
    @test String(take!(iob)) == "Hello World!Goodbye World!\n"
end

@testset "Plain, global context" begin
    function kernel(x)
        @rocprint "Hello World!"
        @rocprintln "Goodbye World!"
        nothing
    end

    _, msg = @grab_output wait(@roc kernel(1))
    @test msg == "Hello World!Goodbye World!\n"
end

#= TODO
@testset "Interpolated string" begin
    inner_str = "to the"
    function kernel(oc)
        @rocprintln oc "Hello $inner_str World!"
        nothing
    end

    iob = IOBuffer()
    oc = OutputContext(iob)
    @roc kernel(oc)
    sleep(1)
    @test String(take!(iob)) == "Hello to the World!\n"
end
=#

end

@testset "@rocprintf" begin

@testset "Plain" begin
    function kernel(x)
        @rocprintf "Hello World!\n"
        nothing
    end

    _, msg = @grab_output wait(@roc kernel(1))
    @test msg == "Hello World!\n"
end

@testset "Integer argument" begin
    function kernel(x)
        @rocprintf "Value: %d\n" x
        nothing
    end

    _, msg = @grab_output wait(@roc kernel(42))
    @test msg == "Value: 42\n"
end

@testset "Multiple arguments" begin
    function kernel(x)
        y = 0.123401
        @rocprintf "Value: %d | %.4f\n" x y
        nothing
    end

    _, msg = @grab_output wait(@roc kernel(42))
    @test msg == "Value: 42 | 0.1234\n"
end

@testset "Multiple workgroups" begin
    function kernel(x)
        gidx = workgroupIdx().x
        @rocprintf "[%d] " gidx
    end

    _, msg = @grab_output wait(@roc groupsize=8 gridsize=64 kernel(1))
    @test all(occursin("[$i] ", msg) for i in 1:8)
end

@test_skip "Wave serialized"
#=
@testset "Wave serialized" begin
    function kernel(x)
        for i in 1:workgroupDim().x
            idx = workitemIdx().x
            if idx == i
                @rocprintf "[%d] " idx
            end
            sync_workgroup()
        end
        nothing
    end

    _, msg = @grab_output wait(@roc groupsize=8 kernel(1))
    @test msg == "[1] [2] [3] [4] [5] [6] [7] [8] "
end
=#

end
