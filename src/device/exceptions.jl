"""
- `status::Int32`: whether exception has been thrown (0 - no, 1 - yes).
"""
struct ExceptionInfo
    status::Int32
    output_lock::Int32

    thread::@NamedTuple{x::UInt32, y::UInt32, z::UInt32}
    block::@NamedTuple{x::UInt32, y::UInt32, z::UInt32}

    reason::LLVMPtr{UInt8, AS.Global}
    reason_length::Int64

    ExceptionInfo() = new(
        Int32(0), Int32(0),
        (; x=UInt32(0), y=UInt32(0), z=UInt32(0)),
        (; x=UInt32(0), y=UInt32(0), z=UInt32(0)),
        LLVMPtr{UInt8, AS.Global}(), 0)
end

@inline function Base.getproperty(ei::Ptr{ExceptionInfo}, field::Symbol)
    if field == :status
        unsafe_load(convert(Ptr{Int32}, ei))
    elseif field == :output_lock
        unsafe_load(convert(Ptr{Int32}, ei + sizeof(Int32)))
    elseif field == :output_lock_ptr
        reinterpret(LLVMPtr{Int32, AS.Generic}, ei + sizeof(Int32))
    elseif field == :thread
        offset = 2 * sizeof(Int32)
        unsafe_load(convert(Ptr{@NamedTuple{x::UInt32, y::UInt32, z::UInt32}}, ei + offset))
    elseif field == :block
        offset = 2 * sizeof(Int32) + sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32})
        unsafe_load(convert(Ptr{@NamedTuple{x::UInt32, y::UInt32, z::UInt32}}, ei + offset))
    elseif field == :reason
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32})
        unsafe_load(convert(Ptr{LLVMPtr{UInt8, AS.Global}}, ei + offset))
    elseif field == :reason_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32}) +
            sizeof(LLVMPtr{UInt8, AS.Global})
        unsafe_load(convert(Ptr{Int64}, ei + offset))
    else
        getfield(ei, field)
    end
end

@inline function Base.setproperty!(ei::Ptr{ExceptionInfo}, field::Symbol, value)
    if field == :status
        unsafe_store!(convert(Ptr{Int32}, ei), value)
    elseif field == :output_lock
        unsafe_store!(convert(Ptr{Int32}, ei + sizeof(Int32)), value)
    elseif field == :thread
        offset = 2 * sizeof(Int32)
        unsafe_store!(convert(Ptr{@NamedTuple{x::UInt32, y::UInt32, z::UInt32}}, ei + offset), value)
    elseif field == :block
        offset = 2 * sizeof(Int32) + sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32})
        unsafe_store!(convert(Ptr{@NamedTuple{x::UInt32, y::UInt32, z::UInt32}}, ei + offset), value)
    elseif field == :reason
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32})
        unsafe_store!(convert(Ptr{LLVMPtr{UInt8, AS.Global}}, ei + offset), value)
    elseif field == :reason_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::UInt32, y::UInt32, z::UInt32}) +
            sizeof(LLVMPtr{UInt8, AS.Global})
        unsafe_store!(convert(Ptr{Int64}, ei + offset), value)
    else
        setfield!(ei, field, value)
    end
end

function alloc_exception_info()
    ei_ptr = Mem.HostBuffer(sizeof(ExceptionInfo), HIP.hipHostAllocDefault)
    unsafe_store!(convert(Ptr{ExceptionInfo}, ei_ptr), ExceptionInfo())
    return ei_ptr
end

@inline function lock_output!(ei::Ptr{ExceptionInfo})
    if llvm_atomic_cas(ei.output_lock_ptr, zero(Int32), one(Int32)) == zero(Int32)
        # Take the lock & write thread info.
        ei.thread = workitemIdx()
        ei.block = workgroupIdx()
        sync_workgroup()
        return true
    elseif (
        ei.output_lock == one(Int32) &&
        ei.thread == workitemIdx() &&
        ei.block == workgroupIdx()
    )
        # Thread already has the lock.
        return true
    else
        # Other thread has the lock.
        return false
    end
end

macro gpu_throw(reason)
    quote
        ei = kernel_state().exception_info
        if lock_output!(ei)
            reason_ptr = @strptr $reason
            ei.reason = reason_ptr
            ei.reason_length = string_length(reason_ptr)
        end
        throw(nothing)
    end
end
