getinfo(exsym::HSA.ExecutableSymbol, attribute::HSA.ExecutableSymbolInfo,
        value::Union{Vector, Base.RefValue}) =
    HSA.executable_symbol_get_info(exsym, attribute, value)

const EXECUTABLE_SYMBOL_INFO_MAP = Dict(
    HSA.EXECUTABLE_SYMBOL_INFO_TYPE => HSA.SymbolKind,
    HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH => Int,
    HSA.EXECUTABLE_SYMBOL_INFO_NAME => Vector{UInt8},

    HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT => UInt64,
    HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE => UInt32,
    HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE => UInt32,
    HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE => UInt32,
)
getinfo_map(::HSA.ExecutableSymbol) = EXECUTABLE_SYMBOL_INFO_MAP

executable_symbol_type(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE)

# TODO: Symbol name length

executable_symbol_name(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME)

executable_symbol_kernel_object(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT)

executable_symbol_kernel_kernarg_segment_size(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE)

executable_symbol_kernel_group_segment_size(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE)

executable_symbol_kernel_private_segment_size(sym::HSA.ExecutableSymbol) =
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE)

### @cfunction Callbacks ###

function iterate_exec_agent_syms_cb(exe::HSA.Executable, agent::HSA.Agent,
                                    sym::HSA.ExecutableSymbol,
                                    sym_ref::Ptr{HSA.ExecutableSymbol})
    if executable_symbol_type(sym) == HSA.SYMBOL_KIND_KERNEL
        # FIXME: Ensure name matches
        #name = executable_symbol_name(sym)
        Base.unsafe_store!(sym_ref, sym)
        return HSA.STATUS_INFO_BREAK
    end

    return HSA.STATUS_SUCCESS
end

mutable struct ROCExecutable
    device::ROCDevice
    executable::Ref{HSA.Executable}
    data::Vector{UInt8}
    globals::Dict{Symbol, Mem.Buffer}
end

# TODO Docstring
function ROCExecutable(device::ROCDevice, data::Vector{UInt8}, symbol::String; globals=())
    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data),
                                              code_object_reader) |> check

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(profile(device),
                              HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
                              C_NULL, executable) |> check

    _globals = Dict{Symbol,Mem.Buffer}()
    for (gbl,sz) in globals
        gbl_buf = Mem.alloc(device, sz; coherent=true)
        HSA.executable_agent_global_variable_define(executable[], device.agent,
                                                    string(gbl), gbl_buf.ptr) |> check
        _globals[gbl] = gbl_buf
    end

    HSA.executable_load_agent_code_object(executable[], device.agent,
                                          code_object_reader[],
                                          C_NULL, C_NULL) |> check

    HSA.executable_freeze(executable[], "") |> check

    exe = ROCExecutable(device, executable, data, _globals)

    # TODO: Ensure no derived kernels are in flight during finalization
    AMDGPU.hsaref!()
    finalizer(exe) do e
        HSA.executable_destroy(e.executable[]) |> check
        for buf in values(e.globals)
            Mem.free(buf)
        end
        HSA.code_object_reader_destroy(code_object_reader[]) |> check
        AMDGPU.hsaunref!()
    end

    return exe
end

function get_global(exe::ROCExecutable, symbol::Symbol)
    @assert symbol in keys(exe.globals) "No such global in executable: $symbol"
    return exe.globals[symbol]
end

function get_exception(
    exe::ROCExecutable, state::AMDGPU.KernelState; check_exceptions::Bool = true, signal_handle::UInt64,
)
    # Check if any wavefront for this kernel threw an exception
    ex_flag_value = Base.unsafe_load(state.exception_flag_ptr)
    ex_flag_value == 0 && return nothing

    fetch_ex_strings =
        check_exceptions && haskey(exe.globals, :__global_exception_ring)

    exceptions = WorkgroupException[]
    if fetch_ex_strings
        # Check for and collect any exceptions, and clear their slots
        ex_ring = get_global(exe, :__global_exception_ring)
        ex_ring_ptr_ptr = Base.unsafe_convert(
            Ptr{Ptr{AMDGPU.Device.ExceptionEntry}}, ex_ring)
        ex_ring_ptr = unsafe_load(ex_ring_ptr_ptr)

        while (ex_ring_value = unsafe_load(ex_ring_ptr)).kern != 1
            if ex_ring_value.kern == signal_handle
                @assert ex_ring_value.string_ptr != C_NULL
                workgroup = ex_ring_value.workgroup
                workgroup_size = ex_ring_value.workgroup_size
                ex_ring_value_str = unsafe_string(
                    reinterpret(Ptr{UInt8}, ex_ring_value.string_ptr))
                indices = Vector{UInt32}(undef, workgroup_size)
                ccall(:memcpy, Cvoid, (Ptr{UInt32}, Ptr{UInt32}, Csize_t),
                      reinterpret(Ptr{UInt32}, pointer(indices)),
                      reinterpret(Ptr{UInt32}, ex_ring_value.indices_ptr),
                      workgroup_size * sizeof(UInt32))
                frames = ExceptionFrame[]
                ex_frame = reinterpret(Ptr{AMDGPU.Device.ExceptionFrame},
                                       ex_ring_value.frame)
                # Walk the linked-list of frames
                while reinterpret(UInt64, ex_frame) != 0
                    # Copy the device frame to a host frame
                    device_frame = unsafe_load(ex_frame)
                    frame = ExceptionFrame(device_frame.idx,
                                           unsafe_string(device_frame.func),
                                           unsafe_string(device_frame.file),
                                           device_frame.line)
                    push!(frames, frame)
                    ex_frame = reinterpret(Ptr{AMDGPU.Device.ExceptionFrame},
                                           device_frame.next)
                end
                push!(exceptions, WorkgroupException(ex_ring_value_str,
                                                     workgroup,
                                                     map(i->i>0, indices),
                                                     frames))

                # FIXME: Clear fields

                # Clear entry
                # FIXME: CAS kern to 0
                unsafe_store!(ex_ring_ptr, AMDGPU.Device.ExceptionEntry())
            end
            ex_ring_ptr += sizeof(AMDGPU.Device.ExceptionEntry)
        end
    end
    dropped = unsafe_load(state.exception_dropped_ptr) == 1

    return KernelException(exe.device, exceptions, dropped)
end
