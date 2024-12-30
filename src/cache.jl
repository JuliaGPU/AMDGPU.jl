# a cache for library handles
# Copied from CUDA.jl/lib/utils/cache.jl

# TODO:
# - store ctor/dtor in cache
# - clean cache when under memory pressure

export HandleCache

struct HandleCache{K, V}
    active_handles::Set{Pair{K, V}}
    idle_handles::Dict{K, Vector{V}}
    lock::Base.ThreadSynchronizer
    # TODO when finalizers are run on their own tasks use reentrant lock

    max_entries::Int

    function HandleCache{K, V}(max_entries::Int = 32) where {K, V}
        new{K,V}(
            Set{Pair{K, V}}(),
            Dict{K, Vector{V}}(),
            Base.ThreadSynchronizer(),
            max_entries)
    end
end

# remove a handle from the cache, or create a new one
function Base.pop!(f::Function, cache::HandleCache{K, V}, key) where {K, V}
    # Check cache.
    handle, n_active_handles = Base.@lock cache.lock begin
        if haskey(cache.idle_handles, key) && !isempty(cache.idle_handles[key])
            pop!(cache.idle_handles[key]), length(cache.active_handles)
        else
            nothing, length(cache.active_handles)
        end
    end

    # If didn't find anything, but lots of active handles - try to free some.
    if handle ≡ nothing && n_active_handles > cache.max_entries
        GC.gc(false)
        Base.@lock cache.lock begin
            if haskey(cache.idle_handles, key) && !isempty(cache.idle_handles[key])
                handle = pop!(cache.idle_handles[key])
            end
        end
    end

    # If still nothing, create a new handle.
    handle ≡ nothing && (handle = f();)

    Base.@lock cache.lock push!(cache.active_handles, key => handle)
    return handle::V
end

# put a handle in the cache, or destroy it if it doesn't fit
function Base.push!(f::Function, cache::HandleCache{K, V}, key::K, handle::V) where {K, V}
    saved = Base.@lock cache.lock begin
        if (key => handle) ∉ cache.active_handles
            error("Trying to free active handle that is not managed by cache.\n $(display(cache.active_handles))")
        end
        delete!(cache.active_handles, key => handle)

        if haskey(cache.idle_handles, key)
            if length(cache.idle_handles[key]) > cache.max_entries
                false
            else
                push!(cache.idle_handles[key], handle)
                true
            end
        else
            cache.idle_handles[key] = [handle]
            true
        end
    end

    saved || f()
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
