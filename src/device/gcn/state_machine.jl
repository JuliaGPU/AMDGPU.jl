import CEnum
import Adapt
import .AMDGPU.Runtime: ROCSignal, Mem
import .AMDGPU: HSA

struct StateMachine{E<:CEnum.Cenum,S}
    signal::S
end
function StateMachine(::Type{E}, signal, init=nothing) where {E<:CEnum.Cenum}
    s = StateMachine{E,typeof(signal)}(signal)
    if init !== nothing
        s[] = init
    end
    return s
end
Adapt.adapt_storage(::AMDGPU.Runtime.Adaptor, s::StateMachine{E,ROCSignal}) where E =
    StateMachine{E,UInt64}(s.signal.signal[].handle)

struct MultiStateMachine{E<:CEnum.Cenum,B}
    buffer::B
end
function MultiStateMachine(::Type{E}, buffer, init=nothing) where {E<:CEnum.Cenum}
    s = MultiStateMachine{E,typeof(buffer)}(buffer)
    if init !== nothing
        s[] = init
    end
    return s
end
Adapt.adapt_storage(::AMDGPU.Runtime.Adaptor, s::MultiStateMachine{E,Mem.Buffer}) where E =
    MultiStateMachine{E,UInt64}(UInt64(s.buffer.ptr))

### Device-side atomic orderings

const DEVICE_ATOMIC_MONOTONIC = Int32(1)
const DEVICE_ATOMIC_ACQUIRE = Int32(2)
const DEVICE_ATOMIC_RELEASE = Int32(3)
const DEVICE_ATOMIC_ACQ_REL = Int32(4)
const DEVICE_ATOMIC_SEQ_CST = Int32(5)

@inline function device_order(::Val{order}) where order
    if order == :relaxed || order == :monotonic
        DEVICE_ATOMIC_MONOTONIC
    elseif order == :acquire
        DEVICE_ATOMIC_ACQUIRE
    elseif order == :release
        DEVICE_ATOMIC_ACQUIRE
    elseif order == :acquire_release
        DEVICE_ATOMIC_ACQ_REL
    elseif order == :sequentially_consistent
        DEVICE_ATOMIC_SEQ_CST
    else
        throw(ArgumentError("Invalid atomic ordering: $order"))
    end
end
@inline function device_order_load(::Val{order}) where order
    if order != :relaxed && order != :monotonic && order != :acquire
        throw(ArgumentError("Invalid atomic ordering for signal load: $order"))
    end
    return device_order(Val{order}())
end
@inline function device_order_store(::Val{order}) where order
    if order != :relaxed && order != :monotonic && order != :release
        throw(ArgumentError("Invalid atomic ordering for signal store: $order"))
    end
    return device_order(Val{order}())
end

# Loads

function get_value(s::StateMachine{E,ROCSignal}, ::Val{order}=Val{:acquire}()) where {E,order}
    value = if order == :relaxed
        HSA.signal_load_relaxed(s.signal.signal[])
    elseif order == :acquire
        HSA.signal_load_scacquire(s.signal.signal[])
    else
        throw(ArgumentError("Invalid atomic ordering for signal load: $order"))
    end
    return E(value)
end
function get_value(s::StateMachine{E,UInt64}, ::Val{order}=Val{:acquire}()) where {E,order}
    value = device_signal_load(s.signal, device_order_load(Val{order}()))
    return E(Base.unsafe_trunc(UInt32, value))
end
Base.getindex(s::StateMachine) = get_value(s)

function get_value(s::MultiStateMachine{E,Mem.Buffer}, ::Val{order}=Val{:acquire}()) where {E,order}
    hbuf = Vector{UInt32}(undef, s.buffer.bytesize ÷ sizeof(UInt32))
    Mem.download!(pointer(hbuf), s.buffer, s.buffer.bytesize)
    return map(E, hbuf)
end
get_value(s::MultiStateMachine{E,Mem.Buffer} where E, idx, order=Val{:acquire}()) =
    get_value(s, order)[idx]
function get_value(s::MultiStateMachine{E,UInt64}, idx, order=Val{:acquire}()) where E
    value = atomic_load(LLVMPtr{UInt32,1}(s.buffer) + ((idx - 1) * sizeof(UInt32)), order)
    return E(Base.unsafe_trunc(UInt32, value))
end
Base.getindex(s::MultiStateMachine, idx) = get_value(s, idx)
Base.getindex(s::MultiStateMachine) = get_value(s)

# Stores

function set_value!(s::StateMachine{E,ROCSignal}, value, ::Val{order}=Val{:release}()) where {E,order}
    if order == :relaxed
        HSA.signal_store_relaxed(s.signal.signal[], Int64(value))
    elseif order == :release
        HSA.signal_store_screlease(s.signal.signal[], Int64(value))
    else
        throw(ArgumentError("Invalid atomic ordering for signal store: $order"))
    end
end
function set_value!(s::StateMachine{E,UInt64}, value, ::Val{order}=Val{:release}()) where {E,order}
    device_signal_store!(s.signal, Int64(value), device_order_store(Val{order}()))
end
Base.setindex!(s::StateMachine, value) = set_value!(s, value)

function set_value!(s::MultiStateMachine{E,Mem.Buffer}, value, ::Val{order}=Val{:release}()) where {E,order}
    hbuf = fill(UInt32(value), s.buffer.bytesize ÷ sizeof(UInt32))
    Mem.upload!(s.buffer, pointer(hbuf), s.buffer.bytesize)
end
set_value!(s::MultiStateMachine{E,UInt64}, value, idx, ::Val{order}=Val{:release}()) where {E,order} =
    atomic_store!(LLVMPtr{UInt32,1}(s.buffer) + ((idx - 1) * sizeof(UInt32)),
                  Base.unsafe_trunc(UInt32, Int64(value)),
                  Val{order}())
Base.setindex!(s::MultiStateMachine, value, idx) = set_value!(s, value, idx)
Base.setindex!(s::MultiStateMachine, value) = set_value!(s, value)

# CAS

function transition!(s::StateMachine{E,ROCSignal}, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
    prev = if order == :relaxed
        HSA.signal_cas_relaxed(s.signal.signal[], Int64(expected), Int64(value))
    elseif order == :acquire
        HSA.signal_cas_scacquire(s.signal.signal[], Int64(expected), Int64(value))
    elseif order == :release
        HSA.signal_cas_screlease(s.signal.signal[], Int64(expected), Int64(value))
    elseif order == :acquire_release
        HSA.signal_cas_scacq_screl(s.signal.signal[], Int64(expected), Int64(value))
    else
        throw(ArgumentError("Invalid atomic ordering for signal CAS: $order"))
    end
    return E(prev)
end
function transition!(s::StateMachine{E,UInt64}, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
    prev = device_signal_cas!(s.signal, Int64(expected), Int64(value), device_order(Val{order}()))
    return E(Base.unsafe_trunc(UInt32, prev))
end
function transition_wait!(state::StateMachine{E,UInt64}, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
    while true
        loaded = transition!(state, expected, value, order)
        loaded == expected && return nothing
        device_sleep(Int32(1))
    end
end
function waitfor(state::StateMachine{E,UInt64}, value, ::Val{order}=Val{:acquire}()) where {E,order}
    while true
        loaded = get_value(state, order)
        loaded == value && return
        device_sleep(Int32(1))
    end
end

# FIXME: transition!(s::MultiStateMachine{E,Mem.Buffer}, idx, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
function transition!(s::MultiStateMachine{E,UInt64}, idx, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
    # FIXME: ordering
    prev = atomic_cas!(LLVMPtr{UInt32,1}(s.buffer) + ((idx - 1) * sizeof(UInt32)),
                       Base.unsafe_trunc(UInt32, Int64(expected)),
                       Base.unsafe_trunc(UInt32, Int64(value)))
    return E(Base.unsafe_trunc(UInt32, prev))
end
function transition_wait!(state::MultiStateMachine{E,UInt64}, idx, expected, value, ::Val{order}=Val{:acquire_release}()) where {E,order}
    while true
        loaded = transition!(state, idx, expected, value, Val{order}())
        loaded == expected && return nothing
        device_sleep(Int32(1))
    end
end
function waitfor(state::MultiStateMachine{E,UInt64}, idx, value, ::Val{order}=Val{:acquire}()) where {E,order}
    while true
        loaded = get_value(state, idx, order)
        loaded == value && return
        device_sleep(Int32(1))
    end
end
