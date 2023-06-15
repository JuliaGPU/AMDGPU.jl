const _ID_COUNTER = Threads.Atomic{UInt64}(0)
const refcounts = Dict{UInt64, Int}()
const liveness = Dict{UInt64, Bool}()

function _buffer_id!()::UInt64
    return Threads.atomic_add!(_ID_COUNTER, UInt64(1))
end

function refcount(buf::AbstractAMDBuffer)
    Base.lock(refcounts_lock) do
        get(refcounts, buf._id, 0)
    end
end

"""
    retain(buf::Buffer)

Increase the refcount of a buffer.
"""
function retain(buf::AbstractAMDBuffer)
    Base.lock(refcounts_lock) do
        live = get!(liveness, buf._id, true)
        @assert live "Trying to retain dead buffer!"
        count = get!(refcounts, buf._id, 0)
        refcounts[buf._id] = count + 1
    end
    return
end

"""
    release(buf::Buffer)

Decrease the refcount of a buffer. Returns `true` if the refcount has dropped
to 0, and some action needs to be taken.
"""
function release(buf::Buffer)
    while !Base.trylock(refcounts_lock) end
    try
        count = refcounts[buf._id]
        @assert count >= 1 "Buffer refcount dropping below 0!"
        refcounts[buf._id] = count - 1
        done = count == 1

        live = liveness[buf._id]

        if done
            live && free(buf)
            untrack(buf)
        end
        return done
    finally
        Base.unlock(refcounts_lock)
    end
end

function release(buf::HIPBuffer; stream::HIP.HIPStream)
    while !Base.trylock(refcounts_lock) end
    try
        count = refcounts[buf._id]
        @assert count >= 1 "Buffer refcount dropping below 0!"
        refcounts[buf._id] = count - 1
        done = count == 1

        live = liveness[buf._id]

        if done
            live && free(buf; stream)
            untrack(buf)
        end
        return done
    finally
        Base.unlock(refcounts_lock)
    end
end

"""
    free_if_live(buf::Buffer)

Frees the base pointer for `buf` if it is still live (not yet freed). Does not
update refcounts.
"""
function free_if_live(buf::Buffer)
    Base.lock(refcounts_lock) do
        if liveness[buf._id]
            liveness[buf._id] = false
            free(buf)
        end
    end
end

function free_if_live(buf::HIPBuffer; stream::HIP.HIPStream)
    Base.lock(refcounts_lock) do
        if liveness[buf._id]
            liveness[buf._id] = false
            free(buf; stream)
        end
    end
end

"""
    untrack(buf::Buffer)

Removes refcount tracking information for a buffer.
"""
function untrack(buf::AbstractAMDBuffer)
    while !Base.trylock(refcounts_lock) end
    try
        delete!(liveness, buf._id)
        delete!(refcounts, buf._id)
    finally
        Base.unlock(refcounts_lock)
    end
end
