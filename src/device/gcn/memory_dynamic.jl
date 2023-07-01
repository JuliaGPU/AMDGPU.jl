export malloc, free

# @device_function function dm_alloc(sz::Csize_t)
#     ccall("extern __ockl_dm_alloc", llvmcall, Ptr{Cvoid}, (Csize_t,), sz)
# end

# @device_function function dm_free(ptr::Ptr{Cvoid})
#     ccall("extern __ockl_dm_free", llvmcall, Nothing, (Csize_t,), ptr)
# end

function malloc(bytesize::Csize_t)::Ptr{Cvoid}
    mhc = Base.unsafe_load(malloc_hc())
    return hostcall!(mhc, bytesize)
end

function free(ptr::Ptr{Cvoid})
    return
    # free_gbl = Base.unsafe_load(free_hc())
    # hostcall!(free_gbl, ptr)
end
