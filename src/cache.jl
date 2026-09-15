# a cache for library handles
# Copied from CUDA.jl/lib/utils/cache.jl

# TODO:
# - clean cache when under memory pressure (currently only a fixed count budget,
#   `max_idle`, bounds the total number of idle handles across all keys)

export HandleCache

# One idle handle, together with the destructor that reclaims it and the global
# insertion order used to pick an eviction victim.
struct IdleHandle{V}
    handle::V
    dtor::Any
    seq::Int
end

struct HandleCache{K, V}
    active_handles::Set{Pair{K, V}}
    idle_handles::Dict{K, Vector{IdleHandle{V}}}
    lock::Base.ThreadSynchronizer
    # TODO when finalizers are run on their own tasks use reentrant lock

    # Maximum number of idle handles kept per cache key.
    max_entries::Int
    # Maximum number of idle handles kept across *all* keys. This bounds the
    # cache for workloads that use a large number of distinct keys (e.g. rocFFT
    # plans for many different shapes), which would otherwise leak one handle
    # per key forever since no single key ever reaches `max_entries`. See #1053.
    max_idle::Int
    # Stamps each idle handle so `_evict_idle!` can evict in least-recently-cached
    # order across all keys, instead of whichever key `Dict` iteration visits first.
    seq::Base.RefValue{Int}

    function HandleCache{K, V}(max_entries::Int = 32, max_idle::Int = 64) where {K, V}
        new{K,V}(
            Set{Pair{K, V}}(),
            Dict{K, Vector{IdleHandle{V}}}(),
            Base.ThreadSynchronizer(),
            max_entries, max_idle, Ref(0))
    end
end

# Total number of idle handles across all keys.
# Must be called while holding `cache.lock`.
total_idle(cache::HandleCache) = sum(length, values(cache.idle_handles); init = 0)

# Take an idle handle for `key` out of the cache, or `nothing` if there is none.
# Its destructor is dropped: the caller owns the handle again, and hands us a
# fresh destructor when it comes back through `push!`.
# Must be called while holding `cache.lock`.
function _take_idle!(cache::HandleCache{K, V}, key) where {K, V}
    entries = get(cache.idle_handles, key, nothing)
    entries ≡ nothing && return nothing
    entry = pop!(entries)
    isempty(entries) && delete!(cache.idle_handles, key)
    return entry.handle
end

# Evict idle handles until at most `max_idle` remain across all keys, returning
# the destructors of the evicted handles to be run by the caller outside the
# lock. Victims are chosen in least-recently-cached order across all keys, so a
# key that keeps being reused survives churn from keys that are used once.
# Each key's vector is in ascending `seq` order, so only its front is a
# candidate, making the scan O(number of keys) per eviction.
# Must be called while holding `cache.lock`.
function _evict_idle!(cache::HandleCache{K, V}) where {K, V}
    evicted = Any[]
    total = total_idle(cache)
    while total > cache.max_idle
        victim, oldest = nothing, typemax(Int)
        for (key, entries) in cache.idle_handles
            if entries[1].seq < oldest
                victim, oldest = key, entries[1].seq
            end
        end
        victim ≡ nothing && break

        entries = cache.idle_handles[victim]
        push!(evicted, popfirst!(entries).dtor)
        isempty(entries) && delete!(cache.idle_handles, victim)
        total -= 1
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

        entries = get(cache.idle_handles, key, nothing)
        # Keep the original semantics: save while the key holds ≤ `max_entries`,
        # so a key can grow to `max_entries + 1`.
        saved = (entries ≡ nothing ? 0 : length(entries)) ≤ cache.max_entries
        if saved
            # Only materialise the vector once we know we are filling it, so a
            # key is present in `idle_handles` iff it holds at least one handle.
            entries ≡ nothing &&
                (entries = cache.idle_handles[key] = IdleHandle{V}[])
            push!(entries, IdleHandle{V}(handle, f, (cache.seq[] += 1)))
        end

        # Enforce the global idle-handle budget.
        to_destroy = _evict_idle!(cache)
        saved || push!(to_destroy, f)
        to_destroy
    end

    # Run every destructor even if one throws: the handles are already gone from
    # the bookkeeping, so bailing out here would leak the rest silently.
    for dtor in dtors
        try
            dtor()
        catch err
            @error "Error while destroying cached handle" exception=(err, catch_backtrace())
        end
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
