# NOTE: EXPERIMENTAL API.

struct CacheAllocator
    lock::ReentrantLock
    busy::Dict{UInt64, Vector{ROCArray}} # hash((T, dims)) => ROCArray[]
    free::Dict{UInt64, Vector{ROCArray}}
end

CacheAllocator() = CacheAllocator(
    ReentrantLock(),
    Dict{UInt64, Vector{ROCArray}}(),
    Dict{UInt64, Vector{ROCArray}}(),
)

const CACHE_ALLOCS::LockedObject{Dict{Symbol, CacheAllocator}} =
    LockedObject(Dict{Symbol, CacheAllocator}())

function cache_allocator!(cache_name::Symbol)
    allocs = CACHE_ALLOCS.payload
    alloc = get(allocs, cache_name, nothing)
    alloc ≡ nothing || return alloc

    return Base.@lock CACHE_ALLOCS.lock begin
        allocs[cache_name] = CacheAllocator()
    end
end

function get_free_pool(alloc::CacheAllocator, uid)
    free_pool = get(alloc.free, uid, nothing)
    if free_pool ≡ nothing
        free_pool = Base.@lock alloc.lock alloc.free[uid] = ROCArray[]
    end
    return free_pool
end

function get_busy_pool(alloc::CacheAllocator, uid)
    busy_pool = get(alloc.busy, uid, nothing)
    if busy_pool ≡ nothing
        busy_pool = Base.@lock alloc.lock alloc.busy[uid] = ROCArray[]
    end
    return busy_pool
end

function alloc!(
    alloc::CacheAllocator, ::Type{Mem.HIPBuffer}, ::Type{T}, dims::Dims{N},
)::Maybe{ROCArray{T, N, Mem.HIPBuffer}} where {T, N}
    uid = hash((T, dims))
    free_pool = get_free_pool(alloc, uid)
    isempty(free_pool) && return nothing

    busy_pool = get_busy_pool(alloc, uid)
    x = nothing
    while !isempty(free_pool) && x ≡ nothing
        tmp = pop!(free_pool)
        # Array was manually freed via `unsafe_free!`.
        tmp.buf.freed && continue
        x = tmp
    end
    x ≡ nothing && return nothing

    push!(busy_pool, x)
    return x
end

# Mark `x` array as busy, used during cache misses to add new allocations.
function add_busy!(alloc::CacheAllocator, x::ROCArray{T}) where T
    uid = hash((T, size(x)))
    busy_pool = get_busy_pool(alloc, uid)
    Base.@lock alloc.lock push!(busy_pool, x)
    return
end

function free_busy!(alloc::CacheAllocator)
    for uid in alloc.busy.keys
        free_pool = get_free_pool(alloc, uid)
        busy_pool = get_busy_pool(alloc, uid)
        isempty(busy_pool) && continue

        Base.@lock alloc.lock begin
            append!(free_pool, busy_pool)
            empty!(busy_pool)
        end
    end
end

# Public API.

"""
    with_caching_allocator(f, alloc_name::Symbol, args...)

Execute function `f` with arguments `args...` using
caching allocator given by its name `alloc_name`.

All GPU memory allocations will attempt to hit this cache
before doing actual allocation (in case of cache miss).
After executing `f`, all "busy" memory within the allocator is marked as free,
so it can be re-used with the next call.

# Returns

Result of the `f` function.
"""
function with_caching_allocator(f, alloc_name::Symbol, args...)
    alloc = cache_allocator!(alloc_name)
    # Enable usage of cache allocator during allocations.
    cache_alloc_name!(alloc_name)
    res = f(args...)
    # Mark all allocations during `f` as free to re-use and disable allocator.
    free_busy!(alloc)
    cache_alloc_name!(:none)
    return res
end

"""
    with_no_caching(f)

Execute function `f`, but avoid hitting any caching allocator.
This is useful to call from within [`with_caching_allocator`](@ref),
so that the memory is independent from it.

# Returns

Result of the `f` function.
"""
function with_no_caching(f)
    alloc_name = cache_alloc_name()
    cache_alloc_name!(:none)
    res = f()
    cache_alloc_name!(alloc_name)
    return res
end

"""
    invalidate_caching_allocator!(alloc_name::Symbol)

Free all memory held by caching allocator given by it name `alloc_name`.
"""
function invalidate_caching_allocator!(alloc_name::Symbol)
    alloc = cache_allocator!(alloc_name)
    alloc ≡ nothing && return

    Base.@lock alloc.lock begin
        for (_, pool) in alloc.free
            map(AMDGPU.unsafe_free!, pool)
        end
        # TODO is other threads use the same, signal that it is invalidated somehow?
        # TODO error if pool is in use, i.e. non empty `busy`?
        for (_, pool) in alloc.busy
            map(AMDGPU.unsafe_free!, pool)
        end
        empty!(alloc.busy)
        empty!(alloc.free)
    end
    return
end
