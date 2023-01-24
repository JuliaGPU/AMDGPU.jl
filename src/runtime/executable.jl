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

has_exception(e::ROCExecutable) = haskey(e.globals, :__global_exception_flag)

function get_exception(
    exe::ROCExecutable; check_exceptions::Bool = true, signal_handle::UInt64,
)
    has_exception(exe) || return nothing

    # Check if any wavefront for this kernel threw an exception
    ex_flag = get_global(exe, :__global_exception_flag)
    ex_flag_ptr = Base.unsafe_convert(Ptr{Int64}, ex_flag)
    ex_flag_value = Base.unsafe_load(ex_flag_ptr)
    ex_flag_value == 0 && return nothing

    ex_string = nothing
    fetch_ex_strings =
        check_exceptions && haskey(exe.globals, :__global_exception_ring)

    if fetch_ex_strings
        ex_strings = String[]
        # Check for and collect any exceptions, and clear their slots
        ex_ring = get_global(exe, :__global_exception_ring)
        ex_ring_ptr_ptr = Base.unsafe_convert(
            Ptr{Ptr{AMDGPU.Device.ExceptionEntry}}, ex_ring)
        ex_ring_ptr = unsafe_load(ex_ring_ptr_ptr)

        while (ex_ring_value = unsafe_load(ex_ring_ptr)).kern != 1
            if ex_ring_value.kern == signal_handle && reinterpret(Ptr{UInt8}, ex_ring_value.ptr) != C_NULL
                ex_ring_value_str = unsafe_string(
                    reinterpret(Ptr{UInt8}, ex_ring_value.ptr))
                push!(ex_strings, ex_ring_value_str)

                # FIXME: Write rest of entry first, then CAS 0 to kern field
                entry = AMDGPU.Device.ExceptionEntry(
                    UInt64(0), Core.LLVMPtr{UInt8,1}(0))
                unsafe_store!(ex_ring_ptr, entry)
            end
            ex_ring_ptr += sizeof(AMDGPU.Device.ExceptionEntry)
        end
        unique!(ex_strings)
        ex_string = join(ex_strings, '\n')
    end

    KernelException(exe.device, ex_string)
end
