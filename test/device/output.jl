@testset "Output" begin

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
