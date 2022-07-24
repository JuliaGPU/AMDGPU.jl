const SC_PAGESIZE = 30
const MS_ASYNC = 1
if Sys.islinux()
    const PAGESIZE = ccall(:sysconf, Clong, (Cint,), SC_PAGESIZE)
end
"Returns the number of pages that the object pointed to by `ptr` spans."
function _pages_spanned(ptr::Ptr{T}) where T
    num_pages = ceil(Int, sizeof(T) / PAGESIZE)
    if sizeof(T) + rem(UInt64(ptr), PAGESIZE) > num_pages * PAGESIZE
        num_pages += 1
    end
    num_pages
end
"Executes `f` per page spanned by `ptr`, and reduces with `f_red`."
function _per_page(f, f_red, ptr::Ptr{T}) where T
    base = Csize_t(ptr) ÷ PAGESIZE * PAGESIZE
    num_pages = _pages_spanned(ptr)
    return reduce(f_red, map(f, [base + PAGESIZE*(i-1) for i in 1:num_pages]))
end
""""
Checks if loading from `ptr` is likely to be safe (all memory pages are present).
If deemed safe, then we load and return the object.
If deemed unsafe, then we return a zero'd object of the same type.

N.B. This function is only valid for statically-sized objects. It also makes no guarantees
that the load will not result in a crash.
"""
function semi_safe_load(ptr::Ptr{T}) where T
    # Check all pages for validity
    valid = _per_page(&, ptr) do base
        ccall(:msync, Cint, (Csize_t, Csize_t, Cint), base, PAGESIZE, 1) == 0
    end
    if valid
        return true, unsafe_load(ptr)
    else
        objref = Ref{T}()
        ccall(:memset, Cvoid, (Ptr{Cvoid}, Cint, Csize_t),
                              Base.pointer_from_objref(objref), 0, sizeof(T))
        return false, objref[]
    end
end
