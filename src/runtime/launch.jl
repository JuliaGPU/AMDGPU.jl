# Kernel and barrier launch
# modeled after: CUDAdrv/src/execution.jl

## HSA object preservation while a kernel is active

const SIGNAL_PRESERVED = IdDict{ROCSignal, Vector{Any}}()

function preserve!(sig::ROCSignal, @nospecialize(x))
    set = get!(()->Any[], SIGNAL_PRESERVED, sig)
    push!(set, x)
end
preserve!(sig::ROCKernelSignal, @nospecialize(x)) = preserve!(sig.signal, x)

unpreserve!(sig::ROCSignal) = delete!(SIGNAL_PRESERVED, sig)
unpreserve!(sig::ROCKernelSignal) = unpreserve!(sig.signal)

# we need a generated function to get an args array,
# without having to inspect the types at runtime
@generated function launch_kernel!(
    signal::ROCKernelSignal, groupsize::ROCDim,
    gridsize::ROCDim, args::NTuple{N,Any},
) where N
    all(isbitstype, args.parameters) ||
        throw(ArgumentError("Arguments to kernel should be bitstype."))

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

    # put arguments in Ref boxes so that we can get a pointers to them
    arg_refs = Vector{Symbol}(undef, N)
    for i in 1:N
        arg_refs[i] = gensym()
        push!(ex.args, :($(arg_refs[i]) = Base.RefValue(args[$i])))
    end

    append!(ex.args, (quote
        GC.@preserve $(arg_refs...) begin
            # validate launch parameters
            groupsize, gridsize = normalize_launch_dimensions(groupsize, gridsize)

            # launch kernel
            lock($RT_LOCK)
            try
                push!($_active_kernels[signal.queue], signal)
            finally
                unlock($RT_LOCK)
            end
            launch_kernel!(signal.queue, signal.kernel, signal.signal, groupsize, gridsize)

            # preserve kernel and arguments
            $preserve!(signal, signal.kernel)
            for arg in args
                $preserve!(signal, arg)
            end
        end
    end).args)

    return ex
end

struct ROCSignalSet{T}
    signals::Vector{ROCSignal}
end
ROCSignalSet{T}() where T = ROCSignalSet{T}(ROCSignal[])

Base.wait(ss::ROCSignalSet{HSA.BarrierAndPacket}) = wait.(ss.signals)

function Base.wait(ss::ROCSignalSet{HSA.BarrierOrPacket})
    #= FIXME
    # We need to hack around the fact that barrier OR packets don't handle more
    # than 5 dependencies. We could implement the waiting in software, and emit
    # a barrier that waits on a signal tied to that waiter.
    =#
    @warn "Waiting on OR barriers waits on all partitioned barriers to complete" maxlog=1
    wait.(ss.signals)
end

"Normalize and validate launch groupsize and gridsize."
function normalize_launch_dimensions(groupsize, gridsize)
    groupsize = ROCDim3(groupsize)
    gridsize = ROCDim3(gridsize)

    # Validate group and grid dimensions
    (groupsize.x > 0 && groupsize.y > 0 && groupsize.z > 0) ||
        throw(ArgumentError("Group dimensions must be non-zero"))
    (gridsize.x > 0 && gridsize.y > 0 && gridsize.z > 0) ||
        throw(ArgumentError("Grid dimensions must be non-zero"))
    (groupsize.x <= AMDGPU.Device._max_group_size &&
     groupsize.y <= AMDGPU.Device._max_group_size &&
     groupsize.z <= AMDGPU.Device._max_group_size &&
     groupsize.x * groupsize.y * groupsize.z <= AMDGPU.Device._max_group_size) ||
        throw(ArgumentError("Group dimensions too large"))

    return groupsize, gridsize
end

"""
    launch_kernel!(queue::ROCQueue, kern::ROCKernel, signal::ROCSignal,
                   groupsize::ROCDim, gridsize::ROCDim)

Low-level call to launch a function (encoded in `kern`) on the GPU, using
`groupsize` and `gridsize` as the grid and block configuration, respectively.
The kernel is launched on `queue` and will notify `signal` upon completion.

Arguments to a kernel should either be bitstype, in which case they will be
copied to the internal kernel parameter buffer, or a pointer to device memory.

This is a low-level call, preferably use [`roccall`](@ref) instead.
"""
function launch_kernel!(
    queue::ROCQueue, kernel::ROCKernel, signal::ROCSignal,
    groupsize::ROCDim3, gridsize::ROCDim3,
)
    @log_start(:launch_kernel!, (;f=typeof(kernel.f), tt=typeof(kernel.args), signal=get_handle(signal), queue=get_handle(queue)), nothing)

    enqueue_packet!(HSA.KernelDispatchPacket, queue) do _packet
        @set! _packet.setup = 3 << Int(HSA.KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
        @set! _packet.workgroup_size_x = groupsize.x
        @set! _packet.workgroup_size_y = groupsize.y
        @set! _packet.workgroup_size_z = groupsize.z
        @set! _packet.grid_size_x = gridsize.x
        @set! _packet.grid_size_y = gridsize.y
        @set! _packet.grid_size_z = gridsize.z
        @set! _packet.completion_signal = signal.signal[]
        @set! _packet.kernel_object = kernel.kernel_object
        @set! _packet.kernarg_address = kernel.kernarg_address
        @set! _packet.private_segment_size = kernel.private_segment_size
        @set! _packet.group_segment_size = kernel.group_segment_size
        _packet
    end

    @log_finish(:launch_kernel!, (;f=typeof(kernel.f), tt=typeof(kernel.args), signal=get_handle(signal), queue=get_handle(queue)), nothing)
end

function launch_barrier!(T, queue::ROCQueue, signals::Vector{ROCSignal})
    outset = ROCSignalSet{T}()
    if !isempty(signals)
        for signal_set in Iterators.partition(signals, 5)
            comp_signal = ROCSignal()
            enqueue_packet!(T, queue) do _packet
                @set! _packet.dep_signal = ntuple(i->length(signal_set)>=i ? signal_set[i].signal[] : HSA.Signal(0), 5)
                _packet
            end
            push!(outset.signals, comp_signal)
        end
    end
    return outset
end

# Atomic store using LLVM intrinsics
# Necessary for writing the AQL packet header to the queue
# prior to launching a kernel.
@eval atomic_store_n!(x::Ptr{UInt16}, v::UInt16) =
    Base.llvmcall($"""
    %ptr = inttoptr i$(Sys.WORD_SIZE) %0 to i16*
    store atomic i16 %1, i16* %ptr release, align 64
    ret void
    """, Cvoid, Tuple{Ptr{UInt16}, UInt16}, x, v)

function enqueue_packet!(f::Base.Callable, T, queue::ROCQueue)
    # Obtain the current queue write index and queue size
    queue_ptr = @atomic queue.queue
    active = @atomic queue.active
    if !active || queue_ptr == C_NULL
        status = queue.status
        @assert status != HSA.STATUS_SUCCESS
        throw(QueueError(queue_ptr, HSAError(status)))
    end
    _queue = unsafe_load(queue_ptr)
    queue_size = _queue.size
    write_index = HSA.queue_add_write_index_scacq_screl(queue_ptr, UInt64(1))

    # Yield until queue has space
    while write_index - HSA.queue_load_read_index_scacquire(queue_ptr) >= queue_size
        # TODO: Exponential backoff with initial `Libc.systemsleep` calls
        yield()
    end

    # TODO: Make this less ugly
    dispatch_packet = Ref{T}()
    ccall(:memset, Cvoid,
          (Ptr{Cvoid}, Cint, Csize_t),
          dispatch_packet, 0, sizeof(T))
    dispatch_packet[] = f(dispatch_packet[])

    queueMask = UInt32(queue_size - 1)
    baseaddr_ptr = Ptr{HSA.KernelDispatchPacket}(_queue.base_address)
    baseaddr_ptr = baseaddr_ptr + sizeof(HSA.KernelDispatchPacket) * (write_index & queueMask)
    dispatch_packet_ptr = convert(Ptr{HSA.KernelDispatchPacket}, Base.unsafe_convert(Ptr{T}, dispatch_packet))
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

    # TODO: Generalize to allow barrier on kernel
    packetheadertype(::Type{HSA.KernelDispatchPacket}) = HSA.PACKET_TYPE_KERNEL_DISPATCH
    packetheadertype(::Type{HSA.BarrierAndPacket}) = HSA.PACKET_TYPE_BARRIER_AND
    packetheadertype(::Type{HSA.BarrierOrPacket}) = HSA.PACKET_TYPE_BARRIER_OR

    # Create and atomically store the header
    # TODO: Generalize to make scopes configurable
    header = Ref{UInt16}(0)
    header[] |= UInt16(HSA.FENCE_SCOPE_SYSTEM) << UInt16(HSA.PACKET_HEADER_SCACQUIRE_FENCE_SCOPE)
    header[] |= UInt16(HSA.FENCE_SCOPE_SYSTEM) << UInt16(HSA.PACKET_HEADER_SCRELEASE_FENCE_SCOPE)
    header[] |= UInt16(packetheadertype(T))    << UInt16(HSA.PACKET_HEADER_TYPE)
    atomic_store_n!(Base.unsafe_convert(Ptr{UInt16}, baseaddr_ptr), header[])

    # Ring the doorbell to dispatch the kernel
    HSA.signal_store_relaxed(_queue.doorbell_signal, Int64(write_index))
end
