# Device ID => HIPMemoryPool
const MEMORY_POOLS = AMDGPU.LockedObject(Dict{Int64, HIP.HIPMemoryPool}())

function pool_create(dev::HIPDevice)
    mp = MEMORY_POOLS.payload
    did = HIP.device_id(dev)

    pool = get(mp, did, nothing)
    pool ≡ nothing || return pool

    Base.@lock MEMORY_POOLS.lock begin
        get!(mp, HIP.device_id(dev)) do
            max_size::UInt64 = AMDGPU.hard_memory_limit()
            max_size = max_size != typemax(UInt64) ? max_size : UInt64(0)

            pool = HIP.HIPMemoryPool(dev; max_size)
            # Allow pool to use up all device memory.
            soft_limit = AMDGPU.soft_memory_limit()
            HIP.attribute!(pool, HIP.hipMemPoolAttrReleaseThreshold, soft_limit)

            HIP.memory_pool!(dev, pool)
            return pool
        end
    end
end

# ccall integration
Base.unsafe_convert(T, buf::AbstractAMDBuffer) = convert(T, buf)

struct HIPBuffer <: AbstractAMDBuffer
    device::HIPDevice # TODO not used?
    ctx::HIPContext
    ptr::Ptr{Cvoid}
    bytesize::Int
    own::Bool
end

function HIPBuffer(bytesize; stream::HIP.HIPStream)
    dev, ctx = stream.device, stream.ctx
    bytesize == 0 && return HIPBuffer(dev, ctx, C_NULL, 0, true)

    pool = pool_create(dev)

    ptr_ref = Ref{Ptr{Cvoid}}()
    ptr = alloc_or_retry!(isnothing; stream) do
        try
            HIP.hipMallocFromPoolAsync(ptr_ref, bytesize, pool, stream)
            ptr = ptr_ref[]
            ptr == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
            return ptr
        catch err
            # Only retry for OOM. Any other error (e.g. hipErrorLaunchFailure
            # from a prior kernel exception surfacing here) must propagate
            # immediately so the caller sees the real cause.
            err isa HIP.HIPError || rethrow(err)
            err.code in (HIP.hipErrorOutOfMemory, HIP.hipErrorMemoryAllocation) ||
                rethrow(err)
            @debug "hipMallocFromPoolAsync exception. Requested $(Base.format_bytes(bytesize))." exception=(err, catch_backtrace())
            return nothing
        end
    end
    ptr == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))

    AMDGPU.account!(AMDGPU.memory_stats(dev), bytesize)
    HIPBuffer(dev, ctx, ptr, bytesize, true)
end

function HIPBuffer(ptr::Ptr{Cvoid}, bytesize::Int; own::Bool = false)
    s = AMDGPU.stream()
    HIPBuffer(s.device, s.ctx, ptr, bytesize, own)
end

Base.sizeof(b::HIPBuffer) = UInt64(b.bytesize)

Base.convert(::Type{Ptr{T}}, buf::HIPBuffer) where T = convert(Ptr{T}, buf.ptr)

function view(buf::HIPBuffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    HIPBuffer(buf.device, buf.ctx, buf.ptr + bytesize, buf.bytesize - bytesize, buf.own)
end

function free(buf::HIPBuffer; stream::HIP.HIPStream)
    buf.own || return

    buf.ptr == C_NULL && return
    HIP.hipFreeAsync(buf, stream)
    AMDGPU.account!(AMDGPU.memory_stats(buf.device), -buf.bytesize)
    return
end

function upload!(dst::HIPBuffer, src::Ptr, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return
    HIP.hipMemcpyHtoDAsync(dst, src, bytesize, stream)
    return
end

function download!(dst::Ptr, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return
    HIP.hipMemcpyDtoHAsync(dst, src, bytesize, stream)
    return
end

function transfer!(dst::HIPBuffer, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return
    HIP.hipMemcpyDtoDAsync(dst, src, bytesize, stream)
    return
end

## Host memory pinning state

const __pin_lock = ReentrantLock()
const __pinned_memory = Dict{Ptr{Cvoid}, Int}()   # ptr => bytesize
const __pin_count    = Dict{Ptr{Cvoid}, Int}()     # ptr => refcount

struct HostBuffer <: AbstractAMDBuffer
    device::HIPDevice
    ctx::HIPContext
    ptr::Ptr{Cvoid}
    dev_ptr::Ptr{Cvoid}
    bytesize::Int
    own::Bool
end

function HostBuffer()
    s = AMDGPU.stream()
    HostBuffer(s.device, s.ctx, C_NULL, C_NULL, 0, true)
end

"""
Allocate host-pinned memory via `hipHostMalloc`.
Freed by `hipHostFree` through [`free`](@ref).
"""
function HostBuffer(
    bytesize::Integer, flags = 0; stream::HIP.HIPStream = AMDGPU.stream(),
)
    bytesize == 0 && return HostBuffer()

    ptr_ref = Ref{Ptr{Cvoid}}()
    HIP.hipHostMalloc(ptr_ref, bytesize, flags)
    ptr = ptr_ref[]
    dev_ptr = get_device_ptr(ptr)
    HostBuffer(stream.device, stream.ctx, ptr, dev_ptr, bytesize, true)
end

"""
Register (pin) an existing host pointer via `hipHostRegister`.
Freed by `hipHostUnregister` through [`free`](@ref).
"""
function HostBuffer(
    ptr::Ptr{Cvoid}, sz::Integer;
    stream::HIP.HIPStream = AMDGPU.stream(), own::Bool = false,
)
    register(ptr, sz)
    dev_ptr = get_device_ptr(ptr)
    HostBuffer(stream.device, stream.ctx, ptr, dev_ptr, sz, own)
end

Base.sizeof(b::HostBuffer) = UInt64(b.bytesize)

function view(buf::HostBuffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    HostBuffer(
        buf.device, buf.ctx,
        buf.ptr + bytesize, buf.dev_ptr + bytesize,
        buf.bytesize - bytesize, buf.own)
end

upload!(dst::HostBuffer, src::Ptr, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

upload!(dst::HostBuffer, src::HIPBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyDeviceToHost, stream)

download!(dst::Ptr, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

download!(dst::HIPBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToDevice, stream)

transfer!(dst::HostBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

# download!(::Ptr, ::HIPBuffer)
transfer!(dst::HostBuffer, src::HIPBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyDeviceToHost, stream)

# upload!(::HIPBuffer, ::Ptr)
transfer!(dst::HIPBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToDevice, stream)

Base.convert(::Type{Ptr{T}}, buf::HostBuffer) where T = convert(Ptr{T}, buf.ptr)

@inline device_ptr(buf::HostBuffer) = buf.dev_ptr

function free(buf::HostBuffer; kwargs...)
    buf.own || return
    buf.ptr == C_NULL && return
    if is_registered(buf.ptr)
        unregister(buf.ptr)
    else
        HIP.hipHostFree(buf.ptr)
    end
    return
end

function get_device_ptr(ptr::Ptr{Cvoid})
    ptr == C_NULL && return C_NULL
    ptr_ref = Ref{Ptr{Cvoid}}()
    HIP.hipHostGetDevicePointer(ptr_ref, ptr, 0)
    ptr_ref[]
end

function attributes(ptr)
    data = Ref{HIP.hipPointerAttribute_t}()
    HIP.hipPointerGetAttributes(data, ptr)
    return data[]
end


"""
    register(ptr::Ptr{Cvoid}, sz::Integer)

Page-lock host memory at `ptr` via `hipHostRegister` with refcounting.
Subsequent calls on the same pointer increment the refcount; the
actual `hipHostUnregister` only happens when the count drops to zero
via [`unregister`](@ref).
"""
function register(ptr::Ptr{Cvoid}, sz::Integer)
    ptr == C_NULL && error("Cannot register `NULL` pointer.")

    Base.@lock __pin_lock begin
        count = get(__pin_count, ptr, 0)
        if count > 0
            __pin_count[ptr] = count + 1
            return
        end

        memtype = attributes(ptr).type
        if memtype == HIP.hipMemoryTypeUnregistered
            HIP.hipHostRegister(ptr, sz, HIP.hipHostRegisterMapped)
            __pinned_memory[ptr] = Int(sz)
            __pin_count[ptr] = 1
        elseif memtype == HIP.hipMemoryTypeHost
            # Already pinned externally (e.g. hipHostMalloc); nothing to track.
        else
            error("Cannot register pointer with memory type `$memtype`.")
        end
    end
    return
end

"""
    unregister(ptr::Ptr{Cvoid})

Decrement the refcount for `ptr`. When it reaches zero the underlying
`hipHostUnregister` call is issued and tracking state is cleaned up.
"""
function unregister(ptr::Ptr{Cvoid})
    ptr == C_NULL && error("Cannot unregister `NULL` pointer.")

    do_unregister = false
    Base.@lock __pin_lock begin
        count = get(__pin_count, ptr, 0)
        count == 0 && error("Cannot unregister untracked pointer $ptr.")

        if count == 1
            delete!(__pinned_memory, ptr)
            delete!(__pin_count, ptr)
            do_unregister = true
        else
            __pin_count[ptr] = count - 1
        end
    end

    if do_unregister
        HIP.hipHostUnregister(ptr)
    end
    return
end

"""
    is_registered(ptr::Ptr{Cvoid}) -> Bool

Return `true` if `ptr` is tracked as registered (pinned) memory that
should be freed via `hipHostUnregister` rather than `hipHostFree`.
"""
function is_registered(ptr::Ptr{Cvoid})
    Base.@lock __pin_lock begin
        haskey(__pin_count, ptr)
    end
end

pin(ptr, sz) = register(Ptr{Cvoid}(ptr), sz)
unpin(ptr) = unregister(Ptr{Cvoid}(ptr))

function is_pinned(ptr)
    ptr == C_NULL && return false
    data = attributes(ptr)
    return data.type == HIP.hipMemoryTypeHost
end

"""
Asynchronous 3D array copy.

# Arguments:

- `width::Integer`: Width of 3D memory copy.
- `height::Integer = 1`: Height of 3D memory copy.
- `depth::Integer = 1`: Depth of 3D memory copy.
- `dstPos::ROCDim3 = (1, 1, 1)`:
    Starting position of the destination data for the copy.
- `srcPos::ROCDim3 = (1, 1, 1)`:
    Starting position of the source data for the copy.
- `dstPitch::Integer = 0`: Pitch in bytes of the destination data for the copy.
- `srcPitch::Integer = 0`: Pitch in bytes of the source data for the copy.
- `async::Bool = false`: If `false`, then synchronize `stream` immediately.
- `stream::HIP.HIPStream = AMDGPU.stream()`: Stream on which to perform the copy.
"""
function unsafe_copy3d!(
    dst::Ptr{T}, dstTyp::Type{D},
    src::Ptr{T}, srcTyp::Type{S},
    width::Integer, height::Integer = 1, depth::Integer = 1;
    dstPos::ROCDim = (1, 1, 1), srcPos::ROCDim = (1, 1, 1),
    dstPitch::Integer = 0, dstWidth::Integer = 0, dstHeight::Integer = 0,
    srcPitch::Integer = 0, srcWidth::Integer = 0, srcHeight::Integer = 0,
    async::Bool = false, stream::HIP.HIPStream = AMDGPU.stream(),
) where {T, D, S}
    (width == 0 || height == 0 || depth == 0) && return dst

    srcPos, dstPos = ROCDim3(srcPos), ROCDim3(dstPos)
    srcPos = HIP.hipPos((srcPos[1] - 1) * sizeof(T), srcPos[2] - 1, srcPos[3] - 1)
    dstPos = HIP.hipPos((dstPos[1] - 1) * sizeof(T), dstPos[2] - 1, dstPos[3] - 1)

    extent = HIP.hipExtent(width * sizeof(T), height, depth)
    kind = if D <: HIPBuffer && S <: HIPBuffer
        HIP.hipMemcpyDeviceToDevice
    elseif D <: HIPBuffer && S <: HostBuffer
        HIP.hipMemcpyHostToDevice
    elseif D <: HostBuffer && S <: HIPBuffer
        HIP.hipMemcpyDeviceToHost
    elseif D <: HostBuffer && S <: HostBuffer
        HIP.hipMemcpyHostToHost
    end

    srcPtr = HIP.hipPitchedPtr(src, srcPitch, srcWidth, srcHeight)
    dstPtr = HIP.hipPitchedPtr(dst, dstPitch, dstWidth, dstHeight)
    params = Ref(HIP.hipMemcpy3DParms(
        C_NULL, srcPos, srcPtr,
        C_NULL, dstPos, dstPtr, extent, kind))

    HIP.hipMemcpy3DAsync(params, stream)
    async || AMDGPU.synchronize(stream)
    return dst
end
