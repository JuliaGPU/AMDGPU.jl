#= Allocator Caching System
# Instead of always going to the host to allocate memory (which is very slow
# and high latency), we can request larger blocks of memory and split them up
# on-device. To keep complexity low, we don't track device-side allocations,
# and instead assume that all allocations have a lifetime which ends when the
# kernel exits (which works because the host tracks per-kernel allocations and
# frees them after kernel exit).
#
# The allocator keeps a pointer to the currently-cached page, as well as the
# offset into that page. Allocations which are less than or equal to the
# remaining space in the page will be serviced directly from the page. If
# instead the allocation is smaller than the size of a page, but is too large
# to be stored on the current page, then a new page is allocated from the host.
# If the allocation is larger than the size of a page, then the allocation
# bypasses the device-side allocator and is directly allocated from the host.
#
# The above page caching is only used for non-coherent, zero-initialized
# allocation requests; all other allocations will be directly allocator from
# the host.
=#

export malloc, free

const DEVICE_PAGE_SIZE = Csize_t(2^12) # 4096

@cenum MallocState::UInt32 begin
    MALLOC_UNINITIALIZED
    MALLOC_START
    MALLOC_FINISH
end

malloc(sz) = device_malloc(sz)
function device_malloc(sz::Csize_t, coherent::Bool=false, zeroed::Bool=true)
    if coherent || !zeroed || sz > DEVICE_PAGE_SIZE
        return _device_alloc_host_page(sz, coherent, zeroed)
    end
    # FIXME: Make this optional, based on a Preferences variable
    debug_machine_T = MallocState
    debug_machine_T_ptr = Base.pointer_from_objref(debug_machine_T)
    debug_machine_hc_ptr = get_global_pointer(Val(:__global_debug_machine_hostcall),
                                              HostCall{MultiStateMachine{debug_machine_T,UInt64},Tuple{Ptr{Cvoid},UInt64,Csize_t},UInt64})
    debug_machine_hc = unsafe_load(debug_machine_hc_ptr)
    state = hostcall!(debug_machine_hc,
                      debug_machine_T_ptr,
                      _completion_signal(),
                      Base.unsafe_trunc(Csize_t, workgroupDim().x))
    idx = Base.unsafe_trunc(Int32, workitemIdx().x)
    state[idx] = MALLOC_START
    cached_page_ptr = alloc_local(:__cached_page_ptr, UInt64, 1, true)
    cached_page_offset = alloc_local(:__cached_page_offset, Csize_t, 1, true)
    allocated_page = alloc_local(:__allocated_page, UInt64, 1)
    allocator_lock = alloc_local(:__allocator_lock, Int64, 1, true)
    # Clear allocated page slot
    unsafe_store!(allocated_page, UInt64(0))
    # Take allocator lock
    if idx != readfirstlane(idx)
        @goto page_allocated
    end
    while atomic_cas!(allocator_lock, 0, 1) != 0
    end
    if (cached_page = unsafe_load(cached_page_ptr)) == 0
        # Cold cache, allocate a new host page
        cached_page = _device_alloc_swap_page(cached_page_ptr, cached_page_offset)
    end
    offset = unsafe_load(cached_page_offset)
    if DEVICE_PAGE_SIZE - offset < sz
        # Page is too small, need a new one
        cached_page = _device_alloc_swap_page(cached_page_ptr, cached_page_offset)
    end
    # Increment the offset
    unsafe_store!(cached_page_offset, offset + sz)
    # Share the page
    atomic_store!(allocated_page, cached_page + offset)
    # Release allocator lock
    atomic_store!(allocator_lock, 0)
    @label page_allocated
    state[idx] = MALLOC_FINISH
    return Ptr{Cvoid}(atomic_load(allocated_page))
end
function _device_alloc_swap_page(cached_page_ptr, cached_page_offset)
    page = reinterpret(UInt64, _device_alloc_host_page(DEVICE_PAGE_SIZE))
    unsafe_store!(cached_page_ptr, page)
    unsafe_store!(cached_page_offset, Csize_t(0))
    return page
end
function _device_alloc_host_page(sz::Csize_t, coherent::Bool=false, zeroed::Bool=true)
    malloc_gbl = get_global_pointer(Val(:__global_malloc_hostcall),
                                    HostCall{Ptr{Cvoid},Tuple{UInt64,Csize_t,Bool,Bool},UInt64})
    malloc_hc = Base.unsafe_load(malloc_gbl)
    kern = _completion_signal()
    return hostcall!(malloc_hc, kern, sz, coherent, zeroed)
end

free(ptr) = device_free_host_page(ptr)
function device_free_host_page(ptr::Ptr{Cvoid})
    free_gbl = get_global_pointer(Val(:__global_free_hostcall),
                                  HostCall{Nothing,Tuple{UInt64,Ptr{Cvoid}},UInt64})
    free_hc = Base.unsafe_load(free_gbl)
    kern = _completion_signal()
    hostcall!(free_hc, kern, ptr)
end
