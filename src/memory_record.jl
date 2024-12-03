# NOTE: EXPERIMENTAL API.

struct CacheAllocator
    busy::Dict{UInt64, Vector{ROCArray}} # hash((T, dims)) => ROCArray[]
    free::Dict{UInt64, Vector{ROCArray}}
end

CacheAllocator() = CacheAllocator(
    Dict{UInt64, Vector{ROCArray}}(),
    Dict{UInt64, Vector{ROCArray}}(),
)

const CACHE_ALLOC::Ref{Maybe{CacheAllocator}} = Ref{Maybe{CacheAllocator}}(nothing)

function get_free_pool(alloc::CacheAllocator, uid)
    free_pool = get(alloc.free, uid, nothing)
    if free_pool ≡ nothing
        # TODO lock & create pool
        free_pool = ROCArray[]
        alloc.free[uid] = free_pool
    end
    return free_pool
end

function get_busy_pool(alloc::CacheAllocator, uid)
    busy_pool = get(alloc.busy, uid, nothing)
    if busy_pool ≡ nothing
        # TODO lock & create pool
        busy_pool = ROCArray[]
        alloc.busy[uid] = busy_pool
    end
    return busy_pool
end

function cache_alloc(
    alloc::CacheAllocator, ::Type{Mem.HIPBuffer}, ::Type{T}, dims::Dims{N},
)::Maybe{ROCArray{T, N, Mem.HIPBuffer}} where {T, N}
    uid = hash((T, dims))
    free_pool = get_free_pool(alloc, uid)
    isempty(free_pool) && return nothing

    @info "Cache hit"
    busy_pool = get_busy_pool(alloc, uid)
    x = pop!(free_pool)
    push!(busy_pool, x)
    return x
end

function add_busy!(alloc::CacheAllocator, x::ROCArray{T}) where T
    uid = hash((T, size(x)))
    busy_pool = get_busy_pool(alloc, uid)
    push!(busy_pool, x)
    return
end

# TODO option to actually free (call unsafe_free!)

function free_busy!(alloc::CacheAllocator)
    for uid in alloc.busy.keys
        free_pool = get_free_pool(alloc, uid)
        busy_pool = get_busy_pool(alloc, uid)
        if !isempty(busy_pool)
            append!(free_pool, busy_pool)
            empty!(busy_pool)
        end
    end
end

const MemoryRecords = LockedObject(Dict{UInt64, ROCArray}())

const RECORD_MEMORY::Ref{Bool} = Ref(false)

function record_memory!(rec::Bool; free::Bool = true, sync::Bool = false)
    RECORD_MEMORY[] = rec
    if !rec
        free && free_records!(; sync)
    end
    return
end

record_memory() = RECORD_MEMORY[]

function record!(x)
    Base.lock(records -> records[_hash(x)] = x, MemoryRecords)
    return
end

function free_records!(; sync::Bool = false)
    Base.lock(MemoryRecords) do records
        for (k, x) in records
            unsafe_free!(x)
        end
        empty!(records)
    end
    sync && AMDGPU.synchronize()
    return
end

function remove_record!(x)
    record_memory() || return

    k = _hash(x)
    Base.lock(MemoryRecords) do records
        if k in records.keys
            pop!(records, k)
        end
    end
    return
end

_hash(x::ROCArray) =
    Base.hash(x.buf.rc.obj.mem.ptr,
        Base.hash(x.offset,
            Base.hash(x.dims)))
