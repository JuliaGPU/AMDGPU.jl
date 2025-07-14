"""
- `status::Int32`: whether exception has been thrown (0 - no, 1 - yes).
"""
struct ExceptionInfo
    status::Int32
    output_lock::Int32

    thread::@NamedTuple{x::Int32, y::Int32, z::Int32}
    block::@NamedTuple{x::Int32, y::Int32, z::Int32}

    subtype::Ptr{UInt8}
    reason::Ptr{UInt8}
    subtype_length::Csize_t
    reason_length::Csize_t

    ExceptionInfo() = new(
        Int32(0), Int32(0),
        (; x=Int32(0), y=Int32(0), z=Int32(0)),
        (; x=Int32(0), y=Int32(0), z=Int32(0)),
        C_NULL, C_NULL, Csize_t(0), Csize_t(0))
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
        unsafe_load(convert(Ptr{@NamedTuple{x::Int32, y::Int32, z::Int32}}, ei + offset))
    elseif field == :block
        offset = 2 * sizeof(Int32) + sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32})
        unsafe_load(convert(Ptr{@NamedTuple{x::Int32, y::Int32, z::Int32}}, ei + offset))
    elseif field == :subtype
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32})
        unsafe_load(convert(Ptr{Ptr{UInt8}}, ei + offset))
    elseif field == :reason
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            sizeof(Ptr{UInt8})
        unsafe_load(convert(Ptr{Ptr{UInt8}}, ei + offset))
    elseif field == :subtype_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            2 * sizeof(Ptr{UInt8})
        unsafe_load(convert(Ptr{Int32}, ei + offset))
    elseif field == :reason_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            2 * sizeof(Ptr{UInt8}) +
            sizeof(Csize_t)
        unsafe_load(convert(Ptr{Int32}, ei + offset))
    end
end

@inline function Base.setproperty!(ei::Ptr{ExceptionInfo}, field::Symbol, value)
    if field == :status
        unsafe_store!(convert(Ptr{Int32}, ei), value)
    elseif field == :output_lock
        unsafe_store!(convert(Ptr{Int32}, ei + sizeof(Int32)), value)
    elseif field == :thread
        offset = 2 * sizeof(Int32)
        unsafe_store!(convert(Ptr{@NamedTuple{x::Int32, y::Int32, z::Int32}}, ei + offset), value)
    elseif field == :block
        offset = 2 * sizeof(Int32) + sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32})
        unsafe_store!(convert(Ptr{@NamedTuple{x::Int32, y::Int32, z::Int32}}, ei + offset), value)
    elseif field == :subtype
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32})
        unsafe_store!(convert(Ptr{Ptr{UInt8}}, ei + offset), value)
    elseif field == :reason
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            sizeof(Ptr{UInt8})
        unsafe_store!(convert(Ptr{Ptr{UInt8}}, ei + offset), value)
    elseif field == :subtype_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            2 * sizeof(Ptr{UInt8})
        unsafe_store!(convert(Ptr{Int32}, ei + offset), value)
    elseif field == :reason_length
        offset =
            2 * sizeof(Int32) +
            2 * sizeof(@NamedTuple{x::Int32, y::Int32, z::Int32}) +
            2 * sizeof(Ptr{UInt8}) +
            sizeof(Csize_t)
        unsafe_store!(convert(Ptr{Int32}, ei + offset), value)
    end
end

function alloc_exception_info()
    ei_ptr = Mem.HostBuffer(sizeof(ExceptionInfo), HIP.hipHostAllocDefault)
    unsafe_store!(convert(Ptr{ExceptionInfo}, ei_ptr), ExceptionInfo())
    return ei_ptr
end

@inline function lock_output!(ei::Ptr{ExceptionInfo})
    if llvm_atomic_cas(ei.output_lock_ptr, Int32(0), Int32(1)) == Int32(0)
        # Take the lock & write thread info.
        ei.thread = workitemIdx()
        ei.block = workgroupIdx()
        sync_workgroup()
        return true
    elseif (
        ei.output_lock == Int32(1) &&
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

macro gpu_throw(subtype, reason)
    quote
        ei = kernel_state().exception_info
        if lock_output!(ei)
            subtype_ptr = @strptr $subtype
            ei.subtype = reinterpret(Ptr{UInt8}, subtype_ptr)
            ei.subtype_length = string_length(subtype_ptr)

            reason_ptr = @strptr $reason
            ei.reason = reinterpret(Ptr{UInt8}, reason_ptr)
            ei.reason_length = string_length(reason_ptr)
        end

        throw(nothing)
    end
end
