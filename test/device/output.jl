import .Device: OutputContext

@testset "@rocprintln" begin

@testset "Plain, no newline" begin
    kernel(oc) = @rocprint oc "Hello World!"

    iob = IOBuffer()
    oc = OutputContext(iob)
    wait(@roc kernel(oc))
    @test String(take!(iob)) == "Hello World!"
end

@testset "Plain, with newline" begin
    kernel(oc) = @rocprintln oc "Hello World!"

    iob = IOBuffer()
    oc = OutputContext(iob)
    wait(@roc kernel(oc))
    @test String(take!(iob)) == "Hello World!\n"
end

@testset "Plain, multiple calls" begin
    function kernel(oc)
        @rocprint oc "Hello World!"
        @rocprintln oc "Goodbye World!"
    end

    iob = IOBuffer()
    oc = OutputContext(iob)
    wait(@roc kernel(oc))
    @test String(take!(iob)) == "Hello World!Goodbye World!\n"
end

@testset "Plain, global context" begin
    function kernel()
        @rocprint "Hello World!"
        @rocprintln "Goodbye World!"
    end

    _, msg = @grab_output wait(@roc kernel())
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
    kernel() = @rocprintf "Hello World!\n"

    _, msg = @grab_output wait(@roc kernel())
    @test msg == "Hello World!\n"
end

@testset "Integer argument" begin
    kernel(x) = @rocprintf "Value: %d\n" x

    _, msg = @grab_output wait(@roc kernel(42))
    @test msg == "Value: 42\n"
end

@testset "Multiple arguments" begin
    function kernel(x)
        y = 0.123401
        @rocprintf "Value: %d | %.4f\n" x y
    end

    _, msg = @grab_output wait(@roc kernel(42))
    @test msg == "Value: 42 | 0.1234\n"
end

@testset "Per-lane" begin
    kernel() = @rocprintf :lane "[%d] " workitemIdx().x

    # One group, one wavefront
    exp = reduce(*, ["[$i] " for i in 1:8])
    _, msg = @grab_output wait(@roc groupsize=8 kernel())
    @test msg == exp

    # One group, multiple wavefronts
    exp = reduce(*, ["[$i] " for i in 1:128])
    _, msg = @grab_output wait(@roc groupsize=128 kernel())
    @test msg == exp

    # Multiple groups, one wavefront each
    exp = reduce(*, ["[$i] " for i in vcat(1:64, 1:64, 1:64, 1:64)])
    _, msg = @grab_output wait(@roc groupsize=64 gridsize=256 kernel())
    @test msg == exp

    # Multiple groups, multiple wavefronts each
    exp = reduce(*, ["[$i] " for i in vcat(1:128, 1:128)])
    _, msg = @grab_output wait(@roc groupsize=128 gridsize=256 kernel())
    @test msg == exp
end

@testset "Per-wavefront" begin
    kernel() = @rocprintf :wave "[%d] " workitemIdx().x
    wsize::Int64 = AMDGPU.wavefrontsize(ROCDevice())

    # One group, one wavefront
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=1 kernel())
    @test msg == exp

    # One group, multiple wavefronts
    groupsize = 128
    exp = reduce(*, ["[$i] " for i in collect(1:wsize:groupsize)])
    _, msg = @grab_output wait(@roc groupsize=groupsize kernel())
    @test msg == exp

    # Multiple groups, one wavefront each
    gridsize = 256
    exp = repeat("[1] ", gridsize ÷ wsize)
    _, msg = @grab_output(wait(@roc groupsize=wsize gridsize=gridsize kernel()))
    @test msg == exp

    # Multiple groups, multiple wavefronts each
    groupsize = 128
    n_groups = gridsize ÷ groupsize
    exp = repeat(
        reduce(*, ["[$i] " for i in collect(1:wsize:groupsize)]),
        n_groups)
    _, msg = @grab_output(wait(@roc groupsize=128 gridsize=256 kernel()))
    @test msg == exp
end

@testset "Per-workgroup" begin
    kernel() = @rocprintf :group "[%d] " workitemIdx().x

    # One group, one wavefront
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=8 kernel())
    @test msg == exp

    # One group, multiple wavefronts
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=128 kernel())
    @test msg == exp

    # Multiple groups, one wavefront each
    exp = reduce(*, ["[$i] " for i in [1, 1, 1, 1]])
    _, msg = @grab_output wait(@roc groupsize=64 gridsize=256 kernel())
    @test msg == exp

    # Multiple groups, multiple wavefronts each
    exp = reduce(*, ["[$i] " for i in [1, 1]])
    _, msg = @grab_output wait(@roc groupsize=128 gridsize=256 kernel())
    @test msg == exp
end

@testset "Per-grid" begin
    kernel() = @rocprintf :grid "[%d] " workitemIdx().x

    # One group, one wavefront
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=8 kernel())
    @test msg == exp

    # One group, multiple wavefronts
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=128 kernel())
    @test msg == exp

    # Multiple groups, one wavefront each
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=64 gridsize=256 kernel())
    @test msg == exp

    # Multiple groups, multiple wavefronts each
    exp = "[1] "
    _, msg = @grab_output wait(@roc groupsize=128 gridsize=256 kernel())
    @test msg == exp
end

end
