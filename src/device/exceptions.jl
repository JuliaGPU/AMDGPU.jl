#= Exception System Design
#
# Each device+executable pair has a ring buffer dedicated to storing
# information about exceptions. Each workgroup in the kernel has, for each
# possible exception location, an LDS slot where a ring buffer index can be
# stored. When a wavefront hits an exception on any set of lanes, if a ring
# buffer index for the current exception location hasn't already been stored, a
# search of the ring buffer occurs.  If an empty slot is found, a temporary
# value is CAS'd into the slot, the ring buffer index is CAS'd, an exception
# entry object is allocated, and then the pointer to the entry is CAS'd into
# the ring buffer slot. If a slot is not available, then a per-kernel flag is
# stored to indicate that some exceptions were missed. If a ring buffer index
# already exists for the workgroup, then the entry in that slot will be
# updated.
#
# The exception entry object contains a pointer to the exception string, the
# workgroup index, and a pointer to a UInt32 array indicating which workitem
# indices triggered the matching exception.
=#

## Exception ring buffer entry

struct ExceptionFrame
    idx::Cint
    func::Ptr{Cchar}
    file::Ptr{Cchar}
    line::Cint
    next::LLVMPtr{UInt64,AS.Global}
end
ExceptionFrame() = ExceptionFrame(0, C_NULL, C_NULL, 0, LLVMPtr{UInt64,AS.Global}(0))

const EXC_FRAME_NEXT_OFFSET =
    fieldoffset(ExceptionFrame,
                findfirst(f->f==:next, fieldnames(ExceptionFrame)))

struct ExceptionEntry
    kern::UInt64
    workgroup::UInt64
    workgroup_size::UInt64
    string_ptr::LLVMPtr{UInt8,AS.Global}
    indices_ptr::LLVMPtr{UInt32,AS.Global}
    frame::LLVMPtr{UInt64,AS.Global}
end
ExceptionEntry(kern) =
    ExceptionEntry(kern,
                   UInt64(0),
                   UInt64(0),
                   LLVMPtr{UInt8,AS.Global}(0),
                   LLVMPtr{UInt32,AS.Global}(0),
                   LLVMPtr{UInt64,AS.Global}(0))
ExceptionEntry() = ExceptionEntry(0)

const EXC_ENTRY_KERN_EMPTY = UInt64(0)
const EXC_ENTRY_KERN_TAIL = UInt64(1)
const EXC_ENTRY_KERN_LOCKED = UInt64(2)

const EXC_ENTRY_WORKGROUP_OFFSET =
    fieldoffset(ExceptionEntry,
                findfirst(f->f==:workgroup, fieldnames(ExceptionEntry)))
const EXC_ENTRY_WORKGROUP_SIZE_OFFSET =
    fieldoffset(ExceptionEntry,
                findfirst(f->f==:workgroup_size, fieldnames(ExceptionEntry)))
const EXC_ENTRY_STRING_PTR_OFFSET =
    fieldoffset(ExceptionEntry,
                findfirst(f->f==:string_ptr, fieldnames(ExceptionEntry)))
const EXC_ENTRY_INDICES_PTR_OFFSET =
    fieldoffset(ExceptionEntry,
                findfirst(f->f==:indices_ptr, fieldnames(ExceptionEntry)))
const EXC_ENTRY_FRAME_OFFSET =
    fieldoffset(ExceptionEntry,
                findfirst(f->f==:frame, fieldnames(ExceptionEntry)))

@cenum ReportExceptionState::UInt32 begin
    REPORT_EXCEPTION_UNINITIALIZED
    REPORT_EXCEPTION_START
    REPORT_EXCEPTION_LEADER_LOCK_LOCK_START
    REPORT_EXCEPTION_LEADER_LOCK_LOCK_FINISH
    REPORT_EXCEPTION_LEADER_LOCK_SLOT_START
    REPORT_EXCEPTION_LEADER_LOCK_SLOT_FINISH
    REPORT_EXCEPTION_LEADER_WRITE_SLOT_START
    REPORT_EXCEPTION_LEADER_WRITE_SLOT_FINISH
    REPORT_EXCEPTION_ALL_SLOT_LOAD_START
    REPORT_EXCEPTION_ALL_SLOT_LOAD_FINISH
    REPORT_EXCEPTION_ALL_SLOT_LOAD_FAILED
    REPORT_EXCEPTION_ALL_WRITE_INDICES_START
    REPORT_EXCEPTION_ALL_WRITE_INDICES_FINISH
    REPORT_EXCEPTION_LEADER_UNLOCK_SLOT_START
    REPORT_EXCEPTION_LEADER_UNLOCK_SLOT_FINISH
    REPORT_EXCEPTION_LEADER_UNLOCK_LOCK_START
    REPORT_EXCEPTION_LEADER_UNLOCK_LOCK_FINISH
    REPORT_EXCEPTION_FINISH
end

function device_report_exception(ex_str_ptr::Ptr{Cchar})
    ring_ptr = get_global_pointer(Val(:__global_exception_ring), LLVMPtr{ExceptionEntry,AS.Global})
    ring_ptr = reinterpret(LLVMPtr{UInt64,AS.Global}, unsafe_load(ring_ptr))

    idx = Base.unsafe_trunc(Int32, workitemIdx().x)
    # Workgroup-wide exception lock, only one wavefront wins this
    exc_lock = alloc_local(:exc_lock, Int64, 1, true)
    # Workgroup-wide exception entry pointer
    entry_ptr_shared = alloc_local(:entry_ptr, LLVMPtr{UInt64,AS.Global}, 1, true)
    # Elect leader lane
    leader = idx == readfirstlane(idx)

    # FIXME: Make this optional, based on a Preferences variable
    debug_machine_T = ReportExceptionState
    debug_machine_T_ptr = Base.pointer_from_objref(debug_machine_T)
    debug_machine_hc_ptr = get_global_pointer(Val(:__global_debug_machine_hostcall),
                                              HostCall{MultiStateMachine{debug_machine_T,UInt64},Tuple{Ptr{Cvoid},UInt64,Csize_t},UInt64})
    debug_machine_hc = unsafe_load(debug_machine_hc_ptr)
    state = hostcall!(debug_machine_hc,
                      debug_machine_T_ptr,
                      _completion_signal(),
                      Base.unsafe_trunc(Csize_t, workgroupDim().x))

    state[idx] = REPORT_EXCEPTION_START
    if leader
        # Lock exception lock
        state[idx] = REPORT_EXCEPTION_LEADER_LOCK_LOCK_START
        while atomic_cas!(exc_lock, 0, Int64(idx)) != 0
        end
        state[idx] = REPORT_EXCEPTION_LEADER_LOCK_LOCK_FINISH
        # TODO: Check if a matching exception has been registered kernel-globally
        if reinterpret(UInt64, unsafe_load(entry_ptr_shared)) == 0
            # Locate an empty slot and share the index
            state[idx] = REPORT_EXCEPTION_LEADER_LOCK_SLOT_START
            slot = leader_locate_exception_slot(ring_ptr)
            state[idx] = REPORT_EXCEPTION_LEADER_LOCK_SLOT_FINISH
            if reinterpret(UInt64, slot) != 0
                # Allocate buffers and fill out details
                state[idx] = REPORT_EXCEPTION_LEADER_WRITE_SLOT_START
                leader_write_exception_slot!(slot, ex_str_ptr)
                state[idx] = REPORT_EXCEPTION_LEADER_WRITE_SLOT_FINISH
                atomic_store!(entry_ptr_shared, slot)
            end
        end
    end

    # Load exception slot on all active workitems
    state[idx] = REPORT_EXCEPTION_ALL_SLOT_LOAD_START
    entry_ptr = atomic_load(entry_ptr_shared)
    state[idx] = REPORT_EXCEPTION_ALL_SLOT_LOAD_FINISH

    if reinterpret(UInt64, entry_ptr) != 0
        # Record which workitems are executing this exception
        state[idx] = REPORT_EXCEPTION_ALL_WRITE_INDICES_START
        all_write_exception_slot_indices!(entry_ptr)
        state[idx] = REPORT_EXCEPTION_ALL_WRITE_INDICES_FINISH
        if leader
            # Unlock the exception slot
            state[idx] = REPORT_EXCEPTION_LEADER_UNLOCK_SLOT_START
            leader_unlock_exception_slot!(entry_ptr)
            state[idx] = REPORT_EXCEPTION_LEADER_UNLOCK_SLOT_FINISH
        end
    else
        state[idx] = REPORT_EXCEPTION_ALL_SLOT_LOAD_FAILED
    end
    if leader
        # Unlock exception lock
        state[idx] = REPORT_EXCEPTION_LEADER_UNLOCK_LOCK_START
        atomic_store!(exc_lock, 0)
        state[idx] = REPORT_EXCEPTION_LEADER_UNLOCK_LOCK_FINISH
    end
    state[idx] = REPORT_EXCEPTION_FINISH

    return
end
function leader_locate_exception_slot(ring_ptr::T) where T
    while true
        # Try to lock this slot, and skip if we fail (because another wavefront wrote first)
        # N.B. The reinterpret gives us direct access to the `kern` field
        prev = atomic_cas!(reinterpret(LLVMPtr{UInt64,AS.Global}, ring_ptr),
                           EXC_ENTRY_KERN_EMPTY,
                           EXC_ENTRY_KERN_LOCKED)
        if prev == EXC_ENTRY_KERN_EMPTY
            # Success!
            return ring_ptr
        elseif prev == EXC_ENTRY_KERN_TAIL
            # Tail slot, give up
            unsafe_store!(exception_dropped(), 1)
            return T(0)
        end
        ring_ptr += sizeof(ExceptionEntry)
    end
end
function leader_write_exception_slot!(entry_ptr, ex_str_ptr)
    # Store workgroup ID
    # TODO: All dimensions
    workgroup_id = workgroupIdx().x
    atomic_store!(reinterpret(LLVMPtr{UInt64,AS.Global},
                              entry_ptr+EXC_ENTRY_WORKGROUP_OFFSET),
                  reinterpret(UInt64, workgroup_id))

    # Store workgroup size
    # TODO: All dimensions
    workgroup_size = workgroupDim().x
    atomic_store!(reinterpret(LLVMPtr{UInt64,AS.Global},
                              entry_ptr+EXC_ENTRY_WORKGROUP_SIZE_OFFSET),
                  reinterpret(UInt64, workgroup_size))

    # Allocate and store string
    ex_str = device_string_to_host(ex_str_ptr)
    atomic_store!(reinterpret(LLVMPtr{UInt64,AS.Global},
                              entry_ptr+EXC_ENTRY_STRING_PTR_OFFSET),
                  reinterpret(UInt64, ex_str))

    # Allocate and store indices
    # TODO: All dimensions
    indices_ptr = reinterpret(LLVMPtr{UInt32,1},
                              device_malloc(Base.unsafe_trunc(Csize_t, workgroup_size * sizeof(UInt32)), false, true))
    atomic_store!(reinterpret(LLVMPtr{UInt64,AS.Global},
                              entry_ptr+EXC_ENTRY_INDICES_PTR_OFFSET),
                  reinterpret(UInt64, indices_ptr))
end
function all_write_exception_slot_indices!(entry_ptr)
    indices_ptr = reinterpret(LLVMPtr{LLVMPtr{UInt32,AS.Global},AS.Global},
                              entry_ptr+EXC_ENTRY_INDICES_PTR_OFFSET)
    indices = unsafe_load(indices_ptr)
    atomic_store!(indices+((workitemIdx().x-1)*sizeof(UInt32)), UInt32(1))
end
function leader_unlock_exception_slot!(entry_ptr)
    our_signal = _completion_signal()
    atomic_store!(reinterpret(LLVMPtr{UInt64,AS.Global}, entry_ptr), our_signal)
end

@cenum ReportExceptionFrameState::UInt32 begin
    REPORT_EXCEPTION_FRAME_UNINITIALIZED
    REPORT_EXCEPTION_FRAME_FETCH_ENTRY_START
    REPORT_EXCEPTION_FRAME_FETCH_ENTRY_FINISH
    REPORT_EXCEPTION_FRAME_ALLOC_STRINGS_START
    REPORT_EXCEPTION_FRAME_ALLOC_STRINGS_FINISH
    REPORT_EXCEPTION_FRAME_STORE_FRAME_START
    REPORT_EXCEPTION_FRAME_STORE_FRAME_FINISH
    REPORT_EXCEPTION_FRAME_STORE_FRAME_FAILED
end

function device_report_exception_frame(idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint)
    # FIXME: Make this optional, based on a Preferences variable
    #=
    debug_machine_T = ReportExceptionFrameState
    debug_machine_T_ptr = Base.pointer_from_objref(debug_machine_T)
    debug_machine_hc_ptr = get_global_pointer(Val(:__global_debug_machine_hostcall),
                                              HostCall{MultiStateMachine{debug_machine_T,UInt64},Tuple{Ptr{Cvoid},UInt64,Csize_t},UInt64})
    debug_machine_hc = unsafe_load(debug_machine_hc_ptr)
    state = hostcall!(debug_machine_hc,
                      debug_machine_T_ptr,
                      _completion_signal(),
                      Base.unsafe_trunc(Csize_t, workgroupDim().x))
    idx = workitemIdx().x
    =#

    # Fetch exception entry pointer
    #state[idx] = REPORT_EXCEPTION_FRAME_FETCH_ENTRY_START
    entry_ptr_shared = alloc_local(:entry_ptr, LLVMPtr{UInt64,AS.Global}, 1, true)
    entry_ptr = atomic_load(entry_ptr_shared)
    #state[idx] = REPORT_EXCEPTION_FRAME_FETCH_ENTRY_FINISH

    if reinterpret(UInt64, entry_ptr) != 0
        # Pass arguments in host buffers
        #state[idx] = REPORT_EXCEPTION_FRAME_ALLOC_STRINGS_START
        #func_str = device_string_to_host(func)
        func_str = func
        #file_str = device_string_to_host(file)
        file_str = file
        #state[idx] = REPORT_EXCEPTION_FRAME_ALLOC_STRINGS_FINISH

        # Store frame info into exception entry
        #state[idx] = REPORT_EXCEPTION_FRAME_STORE_FRAME_START
        frame_ptr = reinterpret(LLVMPtr{UInt64,AS.Global},
                                entry_ptr+EXC_ENTRY_FRAME_OFFSET)
        while reinterpret(UInt64, frame_ptr) != 0 # Guard against accidental null dereference
            if unsafe_load(frame_ptr) == 0
                # Frame slot is available, take it
                # Allocate new frame
                frame_sz = Base.unsafe_trunc(Csize_t, sizeof(ExceptionFrame))
                new_frame_ptr = reinterpret(LLVMPtr{ExceptionFrame,AS.Global},
                                            device_malloc(frame_sz))
                # Write frame data
                new_frame = ExceptionFrame(idx, func_str, file_str, line,
                                           LLVMPtr{UInt64,AS.Global}(0))
                unsafe_store!(new_frame_ptr, new_frame)
                # Store the frame pointer to the slot
                unsafe_store!(frame_ptr, reinterpret(UInt64, new_frame_ptr))
                break
            else
                # Frame slot is taken
                # Go to next frame
                frame_ptr = reinterpret(LLVMPtr{UInt64,AS.Global},
                                        unsafe_load(frame_ptr)+EXC_FRAME_NEXT_OFFSET)
            end
        end
        #state[idx] = REPORT_EXCEPTION_FRAME_STORE_FRAME_FINISH
    else
        #state[idx] = REPORT_EXCEPTION_FRAME_STORE_FRAME_FAILED
    end
    return
end
@inline device_report_exception_frames() =
    ccall("extern amdgpu.emit_exception_frames", llvmcall, Nothing, ())
