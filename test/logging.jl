if AMDGPU.Runtime.LOGGING_STATIC_ENABLED
@testset "Basics" begin
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing

    AMDGPU.Runtime.start_logging()
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink !== nothing
    A = AMDGPU.ones(3, 4)
    @testset "Log Structure" begin
        logs = AMDGPU.Runtime.fetch_logs!()
        @test logs isa Dict
        logs = logs[myid()]
        @test logs isa Dict
        @test haskey(logs, :core)
        @test haskey(logs, :id)
        @test haskey(logs, :timeline)
        @test haskey(logs, :esat)
        @test haskey(logs, :psat)
    end
    AMDGPU.Runtime.stop_logging()
    @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing

    @testset "log_and_fetch!" begin
        AMDGPU.Runtime.log_and_fetch!() do
            @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink !== nothing
        end
        @test AMDGPU.Runtime.GLOBAL_TIMESPAN_CONTEXT.log_sink === nothing
    end

    function log_idx(logs, category, kind)
        for idx in 1:length(logs[:core])
            core_log = logs[:core][idx]
            if core_log.category == category && (kind == :all || core_log.kind == kind)
                return idx
            end
        end
        return nothing
    end

    @testset "Buffer" begin
        local buf_ptr
        logs = AMDGPU.Runtime.log_and_fetch!() do
            buf = AMDGPU.Runtime.Mem.alloc(AMDGPU.default_device(), 64)
            buf_ptr = buf.ptr
            AMDGPU.Runtime.Mem.free(buf)
        end
        logs = logs[myid()]
        @test length(logs[:core]) == 4
        alloc_start = something(log_idx(logs, :alloc, :start))
        alloc_finish = something(log_idx(logs, :alloc, :finish))
        free_start = something(log_idx(logs, :free, :start))
        free_finish = something(log_idx(logs, :free, :finish))
        @test alloc_start < alloc_finish < free_start < free_finish
        @test logs[:id][alloc_start].alloc_id == logs[:id][alloc_finish].alloc_id
        @test logs[:timeline][alloc_start].size == 64
        @test buf_ptr ==
              logs[:timeline][alloc_finish].ptr ==
              logs[:id][free_start].ptr ==
              logs[:id][free_finish].ptr
    end

    @testset "Signal" begin
        local sig_handle
        logs = AMDGPU.Runtime.log_and_fetch!() do
            sig = AMDGPU.ROCSignal(; pooled=false)
            sig_handle = AMDGPU.Runtime.get_handle(sig)
            finalize(sig)
        end
        logs = logs[myid()]
        @test length(logs[:core]) == 4
        alloc_start = something(log_idx(logs, :alloc_signal, :start))
        alloc_finish = something(log_idx(logs, :alloc_signal, :finish))
        free_start = something(log_idx(logs, :free_signal, :start))
        free_finish = something(log_idx(logs, :free_signal, :finish))
        @test alloc_start < alloc_finish < free_start < free_finish
        @test logs[:id][alloc_start].alloc_id == logs[:id][alloc_finish].alloc_id
        @test sig_handle ==
              logs[:timeline][alloc_finish].signal ==
              logs[:id][free_start].signal ==
              logs[:id][free_finish].signal
    end

    @testset "Queue" begin
        local queue_handle
        logs = AMDGPU.Runtime.log_and_fetch!() do
            queue = ROCQueue()
            queue_handle = AMDGPU.Runtime.get_handle(queue)
            AMDGPU.Runtime.kill_queue!(queue)
        end
        logs = logs[myid()]
        @test length(logs[:core]) == 4
        alloc_start = something(log_idx(logs, :alloc_queue, :start))
        alloc_finish = something(log_idx(logs, :alloc_queue, :finish))
        free_start = something(log_idx(logs, :kill_queue!, :start))
        free_finish = something(log_idx(logs, :kill_queue!, :finish))
        @test logs[:id][alloc_start].alloc_id == logs[:id][alloc_finish].alloc_id
        @test reinterpret(UInt64, queue_handle) ==
              logs[:timeline][alloc_finish].queue ==
              logs[:id][free_start].queue ==
              logs[:id][free_finish].queue
    end

    @testset "Compilation and Launch" begin
        function kernel()
            AMDGPU.malloc(Csize_t(1))
            nothing
        end
        logs = AMDGPU.Runtime.log_and_fetch!() do
            wait(@roc kernel())
        end
        logs = logs[myid()]
        cachedcomp_start = something(log_idx(logs, :cached_compile, :start))
        cachedcomp_finish = something(log_idx(logs, :cached_compile, :finish))
        compile_start = something(log_idx(logs, :compile, :start))
        compile_finish = something(log_idx(logs, :compile, :finish))
        link_start = something(log_idx(logs, :link, :start))
        link_finish = something(log_idx(logs, :link, :finish))
        ginit_start = something(log_idx(logs, :global_init, :start))
        ginit_finish = something(log_idx(logs, :global_init, :finish))
        launch_start = something(log_idx(logs, :launch_kernel!, :start))
        launch_finish = something(log_idx(logs, :launch_kernel!, :finish))
        wait_start = something(log_idx(logs, :wait, :start))
        wait_finish = something(log_idx(logs, :wait, :finish))
        @test cachedcomp_start <
              compile_start <
              compile_finish <
              link_start <
              ginit_start <
              ginit_finish <
              link_finish <
              cachedcomp_finish <
              launch_start <
              launch_finish <
              wait_start <
              wait_finish
        f_tt_idxs = [cachedcomp_start,
                     cachedcomp_finish,
                     compile_start,
                     compile_finish,
                     link_start,
                     link_finish,
                     ginit_start,
                     ginit_finish]
        @test all(id->id.f == typeof(kernel), logs[:id][f_tt_idxs])
        @test all(id->id.tt == Tuple{}, logs[:id][f_tt_idxs])
        @test logs[:id][ginit_start].gname == logs[:id][ginit_finish].gname
        # FIXME: Check f, tt => entry transition
    end
end
else # !AMDGPU.Runtime.LOGGING_STATIC_ENABLED
@warning "Logging is statically disabled, skipping logging tests\nThis can be fixed by calling `AMDGPU.Runtime.enable_logging!()` and re-running tests"
@test_skip "Logging"
end
