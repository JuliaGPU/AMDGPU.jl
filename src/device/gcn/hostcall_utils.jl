"Calls the host function stored in `hc` with arguments `args`."
@inline function hostcall!(hc::HostCall, args...)
    hostcall!(Val{:group}(), hc, args...)
end

@inline function hostcall!(
    ::Val{mode}, hc::HostCall{RT, AT}, args...,
) where {mode, RT, AT}
    hostcall_device_lock!(Val{mode}(), hc)
    hostcall_device_write_args!(Val{mode}(), hc, args...)
    return hostcall_device_trigger_and_return!(Val{mode}(), hc)
end

macro device_execution_gate(mode, exec_ex)
    if mode isa QuoteNode
        mode = mode.value::Symbol
    end
    @assert mode in (:grid, :group, :wave, :lane) "Invalid mode: $mode"
    ex = Expr(:block)
    if mode == :grid
        push!(ex.args, quote
            # Must be on first item of first group
            if $workgroupIdx().x != 1 || $workitemIdx().x != 1
                @goto gated_done
            end
        end)
    elseif mode == :group
        push!(ex.args, quote
            # Must be on first item of each group
            if $workitemIdx().x != 1
                @goto gated_done
            end
        end)
    elseif mode == :wave
        push!(ex.args, quote
            # Must be on first lane of each wavefront of each group
            is_not_first_lane = Core.Intrinsics.urem_int(
                $workitemIdx().x - UInt32(1), $wavefrontsize()) != 0
            if is_not_first_lane
                @goto gated_done
            end
        end)
    end
    push!(ex.args, quote
        $(esc(exec_ex))
        @label gated_done
        $sync_workgroup()
    end)
    return ex
end

@inline function hostcall_device_lock!(hc::HostCall)
    hostcall_device_lock!(Val{:group}(), hc)
end

@inline @generated function hostcall_device_lock!(
    ::Val{mode}, hc::HostCall,
) where mode
    return quote
        @device_execution_gate $mode begin
            # Acquire lock on hostcall buffer
            hostcall_device_signal_wait_cas!(
                hc.signal_handle, READY_SENTINEL, DEVICE_LOCK_SENTINEL)
        end
    end
end

@inline function hostcall_device_write_args!(hc::HostCall, args...)
    hostcall_device_write_args!(Val{:group}(), hc, args...)
end

@inline @generated function hostcall_device_write_args!(
    ::Val{mode}, hc::HostCall{RT, AT}, args...,
) where {mode, RT, AT}
    ex = Expr(:block)

    # Copy arguments into buffer
    # Modified from CUDAnative src/device/cuda/dynamic_parallelism.jl
    off = 1
    for i in 1:length(args)
        T = args[i]
        sz = sizeof(T)
        # FIXME: Use proper alignment
        ptr = :(reinterpret(LLVMPtr{$T,AS.Global}, hc.buf_ptr + $off - 1))
        push!(ex.args, :(Base.unsafe_store!($ptr, args[$i])))
        off += sz
    end

    return macroexpand(@__MODULE__, quote
        @device_execution_gate $mode begin
            $ex
        end
    end)
end

@inline function hostcall_device_trigger_and_return!(hc::HostCall)
    hostcall_device_trigger_and_return!(Val{:group}(), hc::HostCall)
end

@inline @generated function hostcall_device_trigger_and_return!(
    ::Val{mode}, hc::HostCall{RT, AT},
) where {mode, RT, AT}
    ex = Expr(:block)
    @gensym shmem buf_ptr ret_ptr

    push!(ex.args, quote
        if $RT !== Nothing
            $shmem = $alloc_local(:hostcall_return, $RT, 1)
        end

        @device_execution_gate $mode begin
            # Ensure arguments are written
            $hostcall_device_signal_wait_cas!(
                hc.signal_handle, $DEVICE_LOCK_SENTINEL, $DEVICE_MSG_SENTINEL)
            # Wait on host message
            $hostcall_device_signal_wait(hc.signal_handle, $HOST_MSG_SENTINEL)
            # Get return buffer and load first value
            if $RT !== Nothing
                $buf_ptr = reinterpret(LLVMPtr{LLVMPtr{$RT,AS.Global}, AS.Global}, hc.buf_ptr)
                $ret_ptr = unsafe_load($buf_ptr)
                if UInt64($ret_ptr) == 0
                    $device_signal_store!(hc.signal_handle, $DEVICE_ERR_SENTINEL)
                    $signal_exception()
                    $trap()
                end
                unsafe_store!($shmem, unsafe_load($ret_ptr)::$RT)
            end
            $device_signal_store!(hc.signal_handle, $READY_SENTINEL)
        end
        if $RT !== Nothing
            return unsafe_load($shmem)
        else
            return nothing
        end
    end)

    return ex
end

@inline @generated function hostcall_device_args_size(args...)
    sz = 0
    for arg in args
        sz += sizeof(arg)
    end
    return sz
end

@generated function hostcall_host_read_args(hc::HostCall{RT,AT}) where {RT,AT}
    ex = Expr(:tuple)

    # Copy arguments into buffer
    off = 1
    for i in 1:length(AT.parameters)
        T = AT.parameters[i]
        sz = sizeof(T)
        # FIXME: Use correct alignment
        push!(ex.args, quote
            lref = Ref{$T}()
            HSA.memory_copy(
                reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{$T}, lref)),
                reinterpret(Ptr{Cvoid}, hc.buf_ptr + $off - 1), $sz) |> Runtime.check
            lref[]
        end)
        off += sz
    end

    return ex
end

struct HostCallException <: Exception
    reason::String
    err::Union{Exception, Nothing}
    bt::Union{Vector, Nothing}
end

HostCallException(reason) = HostCallException(reason, nothing, backtrace())

HostCallException(reason, err) = HostCallException(reason, err, catch_backtrace())

function Base.showerror(io::IO, err::HostCallException)
    print(io, "HostCallException: $(err.reason)")
    if err.err !== nothing || err.bt !== nothing
        print(io, ":\n")
    end
    err.err !== nothing && Base.showerror(io, err.err)
    err.bt !== nothing && Base.show_backtrace(io, err.bt)
end

const NAMED_PERDEVICE_HOSTCALLS = Dict{
    HIP.HIPDevice, Dict{Symbol, Tuple{HostCallHolder, Mem.HostBuffer}}}()

function named_perdevice_hostcall(func, dev::HIP.HIPDevice, name::Symbol)
    Base.@lock Runtime.RT_LOCK begin
        hcs = get!(
            () -> Dict{Symbol, Tuple{HostCall, Mem.HostBuffer}}(),
            NAMED_PERDEVICE_HOSTCALLS, dev)
        get!(func, hcs, name)
    end
end

# TODO rename
function get_named_perdevice_hostcall(dev::HIP.HIPDevice, name::Symbol)
    Base.@lock Runtime.RT_LOCK begin
        hcs = get(
            () -> Dict{Symbol, Tuple{HostCall, Mem.HostBuffer}}(),
            NAMED_PERDEVICE_HOSTCALLS, dev)
        get(hcs, name, nothing)
    end
end

function remove_perdevice_hostcall!(dev::HIP.HIPDevice, name::Symbol)
    Base.@lock Runtime.RT_LOCK begin
        dev_hcs = get(NAMED_PERDEVICE_HOSTCALLS, dev, nothing)
        isnothing(dev_hcs) && return

        pop!(dev_hcs, name)
        return
    end
end
