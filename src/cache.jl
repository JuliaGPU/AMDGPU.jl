# a cache for library handles
# Copied from CUDA.jl/lib/utils/cache.jl

# TODO:
# - clean cache when under memory pressure (currently only a fixed count budget,
#   `max_idle`, bounds the total number of idle handles across all keys)

export HandleCache

struct HandleCache{K, V}
    active_handles::Set{Pair{K, V}}
    idle_handles::Dict{K, Vector{V}}
    # Destructor closure for every idle handle, kept parallel to `idle_handles`
    # so that idle handles for *any* key can be reclaimed (not just the one
    # currently being pushed).
    idle_dtors::Dict{K, Vector{Any}}
    lock::Base.ThreadSynchronizer
    # TODO when finalizers are run on their own tasks use reentrant lock

    # Maximum number of idle handles kept per cache key.
    max_entries::Int
    # Maximum number of idle handles kept across *all* keys. This bounds the
    # cache for workloads that use a large number of distinct keys (e.g. rocFFT
    # plans for many different shapes), which would otherwise leak one handle
    # per key forever since no single key ever reaches `max_entries`. See #1053.
    max_idle::Int

    function HandleCache{K, V}(max_entries::Int = 32, max_idle::Int = 64) where {K, V}
        new{K,V}(
            Set{Pair{K, V}}(),
            Dict{K, Vector{V}}(),
            Dict{K, Vector{Any}}(),
            Base.ThreadSynchronizer(),
            max_entries, max_idle)
    end
end

# Take an idle handle for `key` out of the cache, or `nothing` if there is none.
# Must be called while holding `cache.lock`.
function _take_idle!(cache::HandleCache, key)
    handles = get(cache.idle_handles, key, nothing)
    (handles ≡ nothing || isempty(handles)) && return nothing
    handle = pop!(handles)
    pop!(cache.idle_dtors[key])
    if isempty(handles)
        delete!(cache.idle_handles, key)
        delete!(cache.idle_dtors, key)
    end
    return handle
end

# Evict oldest idle handles (across all keys) until at most `max_idle` remain,
# returning the destructor closures of the evicted handles to be run by the
# caller outside the lock. Must be called while holding `cache.lock`.
function _evict_idle!(cache::HandleCache)
    evicted = Any[]
    total = sum(length, values(cache.idle_handles); init = 0)
    total ≤ cache.max_idle && return evicted
    for key in collect(keys(cache.idle_handles))
        handles = cache.idle_handles[key]
        dtors = cache.idle_dtors[key]
        while !isempty(handles) && total > cache.max_idle
            popfirst!(handles)
            push!(evicted, popfirst!(dtors))
            total -= 1
        end
        if isempty(handles)
            delete!(cache.idle_handles, key)
            delete!(cache.idle_dtors, key)
        end
        total ≤ cache.max_idle && break
    end
    return evicted
end

# remove a handle from the cache, or create a new one
function Base.pop!(f::Function, cache::HandleCache{K, V}, key) where {K, V}
    # Check cache.
    handle, n_active_handles = Base.@lock cache.lock begin
        _take_idle!(cache, key), length(cache.active_handles)
    end

    # If didn't find anything, but lots of active handles - try to free some.
    if handle ≡ nothing && n_active_handles > cache.max_entries
        GC.gc(false)
        Base.@lock cache.lock begin
            handle = _take_idle!(cache, key)
        end
    end

    # If still nothing, create a new handle.
    handle ≡ nothing && (handle = f();)

    Base.@lock cache.lock push!(cache.active_handles, key => handle)
    return handle::V
end

# put a handle in the cache, or destroy it if it doesn't fit
function Base.push!(f::Function, cache::HandleCache{K, V}, key::K, handle::V) where {K, V}
    dtors = Base.@lock cache.lock begin
        (key => handle) ∉ cache.active_handles && error(
            """Trying to free active handle that is not managed by cache.
            - Key: $key
            - Handle: $handle
            """)
        delete!(cache.active_handles, key => handle)

        handles = get!(() -> V[], cache.idle_handles, key)
        # `saved` matches the original off-by-one: up to `max_entries + 1` per key.
        saved = length(handles) ≤ cache.max_entries
        if saved
            push!(handles, handle)
            push!(get!(() -> Any[], cache.idle_dtors, key), f)
        end

        # Enforce the global idle-handle budget.
        to_destroy = _evict_idle!(cache)
        saved || push!(to_destroy, f)
        to_destroy
    end

    for dtor in dtors
        dtor()
    end
    return
end

# shorthand version to put a handle back without having to remember the key
function Base.push!(f::Function, cache::HandleCache{K, V}, handle::V) where {K, V}
    key = Base.@lock cache.lock begin
        key = nothing
        for entry in cache.active_handles
            if entry[2] == handle
                key = entry[1]
                break
            end
        end

        key ≡ nothing && error(
            "Attempt to cache handle $handle that was not created by the handle cache")
        key
    end
    push!(f, cache, key, handle)
end

# Copied from CUDA.jl/lib/cublas/CUBLAS.jl

function library_state(
    library_key::Symbol, ::Type{HandleType}, idle_handles,
    create_handle::Function, destroy_handle::Function, set_stream::Function,
) where HandleType
    tls = AMDGPU.task_local_state!()

    LibraryState = @NamedTuple{handle::HandleType, stream::HIPStream}
    states = get!(task_local_storage(), library_key) do
        Dict{HIPContext, LibraryState}()
    end::Dict{HIPContext, LibraryState}

    @noinline function new_state(tls)
        new_handle = pop!(
            () -> create_handle(), idle_handles, tls.context)::HandleType

        finalizer(current_task()) do task
            push!(idle_handles, tls.context, new_handle) do
                context!(tls.context) do
                    destroy_handle!(new_handle)
                end
            end
        end
        set_stream(new_handle, tls.stream)
        return (; handle=new_handle, tls.stream)
    end
    state = get!(() -> new_state(tls), states, tls.context)

    @noinline function update_stream(tls, state)
        set_stream(state.handle, tls.stream)
        return (; state.handle, tls.stream)
    end
    if state.stream != tls.stream
        states[tls.context] = state = update_stream(tls, state)
    end
    return state
end
