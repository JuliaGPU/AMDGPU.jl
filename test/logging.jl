@testset "Basics" begin
    @assert AMDGPU.Runtime.LOGGING_STATIC_ENABLED
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing

    AMDGPU.Runtime.start_logging()
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink !== nothing
    A = AMDGPU.ones(3, 4)
    @testset "Log Structure" begin
        logs = AMDGPU.Runtime.fetch_logs!()
        @test logs isa Dict
        @test logs[myid()] isa Dict
        @test haskey(logs[myid()], :core)
        @test haskey(logs[myid()], :id)
        @test haskey(logs[myid()], :timeline)
        @test haskey(logs[myid()], :esat)
        @test haskey(logs[myid()], :psat)
    end
    AMDGPU.Runtime.stop_logging()
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing

    @testset "log_and_fetch!" begin
        AMDGPU.Runtime.log_and_fetch!() do
            @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink !== nothing
        end
        @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing
    end

    @testset "Buffer" begin
        local buf_ptr
        logs = AMDGPU.Runtime.log_and_fetch!() do
            buf = AMDGPU.Runtime.Mem.alloc(AMDGPU.default_device(), 64)
            buf_ptr = buf.ptr
            AMDGPU.Runtime.Mem.free(buf)
        end
        @test length(logs[myid()][:core]) == 4
        @test logs[myid()][:core][1].category == :alloc
        @test logs[myid()][:core][2].category == :alloc
        @test logs[myid()][:core][3].category == :free
        @test logs[myid()][:core][4].category == :free
        @test logs[myid()][:id][1].alloc_id == logs[myid()][:id][2].alloc_id
        @test logs[myid()][:timeline][1].size == 64
        @test buf_ptr ==
              logs[myid()][:timeline][2].ptr ==
              logs[myid()][:id][3].ptr ==
              logs[myid()][:id][4].ptr
    end

    @testset "Signal" begin
        local sig_handle
        logs = AMDGPU.Runtime.log_and_fetch!() do
            sig = AMDGPU.ROCSignal()
            sig_handle = AMDGPU.Runtime.get_handle(sig)
            finalize(sig)
        end
        @test length(logs[myid()][:core]) == 4
        @test logs[myid()][:core][1].category == :alloc_signal
        @test logs[myid()][:core][2].category == :alloc_signal
        @test logs[myid()][:core][3].category == :free_signal
        @test logs[myid()][:core][4].category == :free_signal
        @test logs[myid()][:id][1].alloc_id == logs[myid()][:id][2].alloc_id
        @test sig_handle ==
              logs[myid()][:timeline][2].signal ==
              logs[myid()][:id][3].signal ==
              logs[myid()][:id][4].signal
    end

    @testset "Queue" begin
        local queue_handle
        logs = AMDGPU.Runtime.log_and_fetch!() do
            queue = ROCQueue()
            queue_handle = AMDGPU.Runtime.get_handle(queue)
            AMDGPU.Runtime.kill_queue!(queue)
        end
        @test length(logs[myid()][:core]) == 4
        @test logs[myid()][:core][1].category == :alloc_queue
        @test logs[myid()][:core][2].category == :alloc_queue
        @test logs[myid()][:core][3].category == :kill_queue!
        @test logs[myid()][:core][4].category == :kill_queue!
        @test logs[myid()][:id][1].alloc_id == logs[myid()][:id][2].alloc_id
        @test reinterpret(UInt64, queue_handle) ==
              logs[myid()][:timeline][2].queue ==
              logs[myid()][:id][3].queue ==
              logs[myid()][:id][4].queue
    end

    @testset "Compilation and Launch" begin
        kernel() = nothing
        logs = AMDGPU.Runtime.log_and_fetch!() do
            wait(@roc kernel())
        end
        @test length(logs[myid()][:core]) == 14
        @test logs[myid()][:core][1].category == :cached_compile
        @test logs[myid()][:core][2].category == :compile
        @test logs[myid()][:core][3].category == :compile
        @test logs[myid()][:core][4].category == :link
        @test logs[myid()][:core][5].category == :alloc
        @test logs[myid()][:core][6].category == :alloc
        @test logs[myid()][:core][7].category == :link
        @test logs[myid()][:core][8].category == :cached_compile
        @test logs[myid()][:core][9].category == :alloc_signal
        @test logs[myid()][:core][10].category == :alloc_signal
        @test logs[myid()][:core][11].category == :launch_kernel!
        @test logs[myid()][:core][12].category == :launch_kernel!
        @test logs[myid()][:core][13].category == :wait
        @test logs[myid()][:core][14].category == :wait
        for id_idxs in [1:4, 7:8, 11:14]
            @test all(id->id.f == typeof(kernel), logs[myid()][:id][id_idxs])
            @test all(id->id.tt == Tuple{}, logs[myid()][:id][id_idxs])
        end
        @test length(unique(id->id.signal, logs[myid()][:id][11:14])) == 1
        @test logs[myid()][:timeline][10].signal == logs[myid()][:id][11].signal
        @test AMDGPU.Runtime.get_handle(AMDGPU.default_queue()) ==
              logs[myid()][:id][11].queue ==
              logs[myid()][:id][12].queue
    end
end
