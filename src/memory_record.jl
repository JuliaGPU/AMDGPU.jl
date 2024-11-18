# NOTE: EXPERIMENTAL API.

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
