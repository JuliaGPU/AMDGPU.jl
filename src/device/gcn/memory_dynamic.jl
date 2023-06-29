export malloc, free

# @device_function function dm_alloc(sz::Csize_t)
#     ccall("extern __ockl_dm_alloc", llvmcall, Ptr{Cvoid}, (Csize_t,), sz)
# end

# @device_function function dm_free(ptr::Ptr{Cvoid})
#     ccall("extern __ockl_dm_free", llvmcall, Nothing, (Csize_t,), ptr)
# end

# TODO fix
function malloc(bytesize::Csize_t)
    return Ptr{Cvoid}(C_NULL)
    # malloc_gbl = Base.unsafe_load(malloc_hc())
    # llvm_ptr = hostcall!(malloc_gbl, bytesize)
    # return Ptr{Cvoid}(llvm_ptr)
end

function free(ptr::Ptr{Cvoid})
    return
    # free_gbl = Base.unsafe_load(free_hc())
    # hostcall!(free_gbl, ptr)
end
