export malloc, free

function malloc(sz::Csize_t)
    malloc_gbl = get_global_pointer(Val(:__global_malloc_hostcall),
                                    HostCall{UInt64,DevicePtr{UInt8,AS.Global},Tuple{UInt64,Csize_t}})
    malloc_hc = Base.unsafe_load(malloc_gbl)
    kern = _completion_signal()
    ptr = hostcall!(malloc_hc, kern, sz)
    return ptr
end

function free(ptr::DevicePtr{T,AS.Global}) where T
    free_gbl = get_global_pointer(Val(:__global_free_hostcall),
                                  HostCall{UInt64,Nothing,Tuple{UInt64,DevicePtr{UInt8,AS.Global}}})
    free_hc = Base.unsafe_load(free_gbl)
    kern = _completion_signal()
    hostcall!(free_hc, kern, Base.unsafe_convert(DevicePtr{UInt8,AS.Global}, ptr))
end
