export malloc, free

function malloc(bytesize::Csize_t)
    malloc_gbl = Base.unsafe_load(malloc_hc())
    llvm_ptr = hostcall!(malloc_gbl, bytesize)
    return Ptr{Cvoid}(llvm_ptr)
end

function free(ptr::Ptr{Cvoid})
    free_gbl = Base.unsafe_load(free_hc())
    hostcall!(free_gbl, ptr)
end
