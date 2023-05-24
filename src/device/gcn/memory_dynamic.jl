export malloc, free

malloc(sz) = device_malloc(sz)
function device_malloc(sz::Csize_t)
    malloc_gbl = get_global_pointer(
        Val(:__global_malloc_hostcall),
        HostCall{Ptr{Cvoid}, Tuple{UInt64, Csize_t}})
    malloc_hc = Base.unsafe_load(malloc_gbl)
    kern = _completion_signal()
    ptr = hostcall!(malloc_hc, kern, sz)
    return ptr
end

free(ptr) = device_free(ptr)
function device_free(ptr::Ptr{Cvoid})
    free_gbl = get_global_pointer(
        Val(:__global_free_hostcall),
        HostCall{Nothing, Tuple{UInt64, Ptr{Cvoid}}})
    free_hc = Base.unsafe_load(free_gbl)
    kern = _completion_signal()
    hostcall!(free_hc, kern, ptr)
end
