using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim
using FFTW

if length(AMDGPU.devices()) <= 1
    @info "Skipping Multi-GPU tests (requires more than 1 GPU)"
else

@testset "Multi-GPU" begin
    @testset "Device switching" begin
        d1 = AMDGPU.device()
        s1 = AMDGPU.stream()
        id1 = AMDGPU.device_id()
        @test id1 == 1
        @test s1.device == d1

        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()
        s2 = AMDGPU.stream()
        id2 = AMDGPU.device_id()
        @test s2.device == d2

        @test d1 != d2
        @test s1 != s2
        @test id1 != id2

        AMDGPU.device_id!(1)
        @test d1 == AMDGPU.device()
    end

    @testset "Arrays" begin
        d1 = AMDGPU.device()

        x1 = AMDGPU.ones(Int, 16)
        @test AMDGPU.device(x1) == d1

        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        x2 = AMDGPU.ones(Int, 16)
        @test AMDGPU.device(x2) != d1
        @test AMDGPU.device(x2) == d2

        @test sum(x2) == 16

        AMDGPU.device_id!(1)
        @test sum(x1) == 16
    end

    @testset "Copying" begin
        AMDGPU.device_id!(1)
        d1 = AMDGPU.device()
        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        # Copy from d1 to host, then from host to d2 and compare with host.
        h = zeros(Int32, 16)

        AMDGPU.device!(d1)
        x1 = AMDGPU.rand(Int32, 16)
        copyto!(h, x1)

        AMDGPU.device!(d2)
        x2 = AMDGPU.zeros(Int32, 16)
        copyto!(x2, h)

        @test Array(x2) == h
    end

    @testset "Kernel" begin
        function add_one!(x)
            i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
            x[i] += 1
            return
        end

        AMDGPU.device_id!(1)
        d1 = AMDGPU.device()
        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        AMDGPU.device!(d1)
        x1 = AMDGPU.zeros(Int32, 16)
        @roc groupsize=length(x1) add_one!(x1)

        AMDGPU.device!(d2)
        x2 = AMDGPU.zeros(Int32, 16)
        @roc groupsize=length(x2) add_one!(x2)
        @test sum(x2) == 16

        AMDGPU.device!(d1)
        @test sum(x1) == 16
    end

    @testset "Correctly switching HIP context" begin
        f() = return

        AMDGPU.device_id!(1)
        @test AMDGPU.device() == AMDGPU.HIP.device()
        @test AMDGPU.stream().device == AMDGPU.HIP.device()

        # This will create task, but HIP uses thread local storage.
        # So this will change HIP global state outside of task.
        wait(Threads.@spawn begin
            AMDGPU.device_id!(2)
            @test AMDGPU.stream().device == AMDGPU.HIP.device()
            @roc f()
            AMDGPU.synchronize()
        end)

        @test AMDGPU.device() == AMDGPU.device(1)

        # Here we test that we correctly switch back to the TLS context.
        @roc f()

        @test AMDGPU.stream().device == AMDGPU.HIP.device()
        @test AMDGPU.device() == AMDGPU.device(1)
        @test AMDGPU.HIP.device() == AMDGPU.device(1)
    end

    if AMDGPU.functional(:rocfft)
        @testset "FFT plan cache across devices" begin
            using AMDGPU.rocFFT: IDLE_HANDLES,
                N_PLANS_CREATED, N_PLANS_DESTROYED, rocfft_transform_type_real_forward

            # Lengths not used by any other testset, to avoid key collisions.
            # Both factor into small primes, so rocFFT avoids its Bluestein path.
            len = 8192     # 2^13
            len_c = 6144   # 2^11 * 3

            key(ctx, len) = (ctx, rocfft_transform_type_real_forward, (len,), Float32, false, (1,))
            idle_handles_for(key) = Base.@lock IDLE_HANDLES.lock begin
                get(IDLE_HANDLES.idle_handles, key, nothing)
            end
            has_handle(entries, h) = entries !== nothing && any(e -> e.handle[1] == h, entries)
            is_active(h) = Base.@lock IDLE_HANDLES.lock begin
                any(e -> e[2][1] == h, IDLE_HANDLES.active_handles)
            end
            total_idle() = Base.@lock IDLE_HANDLES.lock AMDGPU.total_idle(IDLE_HANDLES)

            try
                AMDGPU.device_id!(1)
                ctx1 = AMDGPU.context()
                x1 = ROCArray(rand(Float32, len))
                p1 = plan_rfft(x1, (1,))
                @test p1.ctx == ctx1
                handle1 = p1.handle

                # Switch devices, then finalize the device-1 plan while device 2 is current.
                AMDGPU.device_id!(2)
                ctx2 = AMDGPU.context()
                @test ctx1 != ctx2
                finalize(p1)

                # The handle must be released cleanly (no stale active entry)
                # and filed under device 1's key.
                @test !is_active(handle1)
                @test has_handle(idle_handles_for(key(ctx1, len)), handle1)

                # A fresh plan for the same shape on device 1 must hit the cache
                # (same underlying rocfft_plan handle), not rebuild, and still
                # compute the right FFT.
                AMDGPU.device_id!(1)
                x1b = ROCArray(rand(Float32, len))
                p1b = plan_rfft(x1b, (1,))
                @test p1b.ctx == ctx1
                @test p1b.handle == handle1
                y1b = p1b * x1b
                @test Array(y1b) ≈ rfft(Array(x1b))
                finalize(p1b)
                AMDGPU.unsafe_free!(y1b)
                AMDGPU.unsafe_free!(x1)
                AMDGPU.unsafe_free!(x1b)

                # The same shape on device 2 must get its own plan, not device 1's.
                AMDGPU.device_id!(2)
                x2 = ROCArray(rand(Float32, len))
                p2 = plan_rfft(x2, (1,))
                @test p2.ctx == ctx2
                @test p2.handle != handle1
                y2 = p2 * x2
                @test Array(y2) ≈ rfft(Array(x2))
                finalize(p2)
                AMDGPU.unsafe_free!(y2)
                AMDGPU.unsafe_free!(x2)

                # A distinct-shape plan: create on device 1, finalize while
                # device 2 is current (so it goes idle under device 1's key),
                # then force it out via eviction while still on device 2, so its
                # destructor runs from device 2 for a device-1 plan. This only
                # checks that the eviction happens and the create/destroy/idle
                # counts stay consistent; it cannot observe which context the
                # destructor ran in.
                AMDGPU.device_id!(1)
                xc = ROCArray(rand(Float32, len_c))
                pc = plan_rfft(xc, (1,))
                @test pc.ctx == ctx1
                handle_c = pc.handle

                AMDGPU.device_id!(2)
                finalize(pc)
                AMDGPU.unsafe_free!(xc)
                @test has_handle(idle_handles_for(key(ctx1, len_c)), handle_c)

                created_before = N_PLANS_CREATED[]
                destroyed_before = N_PLANS_DESTROYED[]
                idle_before = total_idle()

                # Eviction is oldest-first and at most `max_idle` entries are
                # idle, so `max_idle` newer distinct-shape entries are enough to
                # evict `handle_c`; a few more for margin.
                for i in 1:(IDLE_HANDLES.max_idle + 4)
                    xi = ROCArray(rand(Float32, 4096 + 2i))
                    pi_ = plan_rfft(xi, (1,))
                    yi = pi_ * xi
                    AMDGPU.unsafe_free!(yi)
                    finalize(pi_)
                    AMDGPU.unsafe_free!(xi)
                end

                @test !has_handle(idle_handles_for(key(ctx1, len_c)), handle_c)

                idle_after = total_idle()
                @test idle_after <= IDLE_HANDLES.max_idle
                Δcreated = N_PLANS_CREATED[] - created_before
                Δdestroyed = N_PLANS_DESTROYED[] - destroyed_before
                Δidle = idle_after - idle_before
                @test Δcreated == Δdestroyed + Δidle
            finally
                AMDGPU.device_id!(1)
            end
        end
    end
end
end
