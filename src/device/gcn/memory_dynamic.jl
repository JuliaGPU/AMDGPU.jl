export malloc, free

# @device_function function dm_alloc(sz::Csize_t)
#     ccall("extern __ockl_dm_alloc", llvmcall, Ptr{Cvoid}, (Csize_t,), sz)
# end

# @device_function function dm_free(ptr::Ptr{Cvoid})
#     ccall("extern __ockl_dm_free", llvmcall, Nothing, (Csize_t,), ptr)
# end

# no return type annotations: Julia 1.10's `@overlay` doesn't support them
@device_function function malloc(bytesize::Csize_t)
    mhc = Base.unsafe_load(malloc_hc())
    return hostcall!(mhc, bytesize)::Ptr{Cvoid}
end

@device_function function free(ptr::Ptr{Cvoid})
    fhc = Base.unsafe_load(free_hc())
    hostcall!(fhc, ptr)
    return
end
