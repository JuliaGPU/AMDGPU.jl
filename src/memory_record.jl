# NOTE: EXPERIMENTAL API.

# TODO use locks
struct CacheAllocator
    busy::Dict{UInt64, Vector{ROCArray}} # hash((T, dims)) => ROCArray[]
    free::Dict{UInt64, Vector{ROCArray}}
end

CacheAllocator() = CacheAllocator(
    Dict{UInt64, Vector{ROCArray}}(),
    Dict{UInt64, Vector{ROCArray}}(),
)

const CACHE_ALLOCS::LockedObject{Dict{Symbol, CacheAllocator}} = LockedObject(Dict{Symbol, CacheAllocator}())

function cache_alloc!(cache_name::Symbol)
    allocs = CACHE_ALLOCS.payload
    alloc = get(allocs, cache_name, nothing)
    alloc ≡ nothing || return alloc

    return Base.@lock CACHE_ALLOCS.lock begin
        allocs[cache_name] = CacheAllocator()
    end
end

function with_caching_allocator(f, alloc_name::Symbol, args...)
    alloc = cache_alloc!(alloc_name)
    # Enable usage of cache allocator during allocations.
    cache_alloc_name!(alloc_name)
    res = f(args...)
    # Mark all allocations during `f` as free to re-use and disable allocator.
    free_busy!(alloc)
    cache_alloc_name!(:none)
    return res
end

function with_no_caching(f)
    alloc_name = cache_alloc_name()
    cache_alloc_name!(:none)
    res = f()
    cache_alloc_name!(alloc_name)
    return res
end

function invalidate_caching_allocator!(alloc_name::Symbol; free::Bool = true)
    alloc = cache_alloc!(alloc_name)
    alloc ≡ nothing && return

    # TODO lock
    for (_, pool) in alloc.free
        map(AMDGPU.unsafe_free!, pool)
    end
    # TODO is other threads use the same, signal that it is invalidated somehow?
    # TODO error if pool is in use, i.e. non empty `busy`?
    for (_, pool) in alloc.busy
        # isempty(pool) || error(
        #     "Invalidating `$alloc_name` caching pool while it is in use is not allowed.")
        map(AMDGPU.unsafe_free!, pool)
    end
    empty!(alloc.busy)
    empty!(alloc.free)
    return
end

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

function alloc!(
    alloc::CacheAllocator, ::Type{Mem.HIPBuffer}, ::Type{T}, dims::Dims{N},
)::Maybe{ROCArray{T, N, Mem.HIPBuffer}} where {T, N}
    uid = hash((T, dims))
    free_pool = get_free_pool(alloc, uid)
    isempty(free_pool) && return nothing

    # @info "Cache hit"
    busy_pool = get_busy_pool(alloc, uid)
    x = pop!(free_pool)
    # Array was manually freed via `unsafe_free!`.
    x.buf.freed && return nothing

    push!(busy_pool, x)
    return x
end

# Mark `x` array as busy, used during cache misses to add new allocations.
function add_busy!(alloc::CacheAllocator, x::ROCArray{T}) where T
    uid = hash((T, size(x)))
    busy_pool = get_busy_pool(alloc, uid)
    push!(busy_pool, x)
    return
end

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
