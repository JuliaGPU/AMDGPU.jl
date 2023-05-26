"Internal representation of a static string."
struct DeviceStaticString{N} end

Base.unsafe_load(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}) =
    unsafe_string(reinterpret(Cstring, ptr))
Base.unsafe_store!(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}, x) = nothing

const OUTPUT_CONTEXT_TYPE = HostCall{
    Nothing, Tuple{LLVMPtr{DeviceStaticString{2^16}, AS.Global}}}

const PRINTF_OUTPUT_CONTEXT_TYPE = HostCall{
    Nothing, Tuple{LLVMPtr{UInt8, AS.Global}}}

function rocprint(oc, str...)
    ex = Expr(:block)
    strs = Expr[]
    for s in str
        if !(s isa Expr)
            s = Expr(:string, s)
        end
        @assert s.head == :string
        push!(strs, s)
    end
    push!(ex.args, :($hostcall_device_lock!($oc)))
    N = 1
    # Write strings & null termination to hostcall buffer.
    for str in strs
        N = rocprint!(ex, N, oc, str)
    end
    rocprint!(ex, N, oc, '\0')
    # Make host read args, execute function & wait for return.
    push!(ex.args, :($hostcall_device_trigger_and_return!($oc)))
    push!(ex.args, :(nothing))
    return ex
end

function rocprint!(ex, N, oc, str::String)
    @gensym str_ptr
    push!(ex.args, :($str_ptr = $alloc_string($(Val(Symbol(str))))))
    push!(ex.args, :($memcpy!(
        $oc.buf_ptr + $(N - 1), $str_ptr, $(length(str)))))
    return N + length(str)
end

function rocprint!(ex, N, oc, char::Char)
    @assert length(codeunits(string(char))) == 1 "Multi-codeunit chars not yet implemented"
    byte = UInt8(char)
    ptr = :(reinterpret($(LLVMPtr{UInt8, AS.Global}), $oc.buf_ptr))
    push!(ex.args, :(Base.unsafe_store!($ptr, $byte, $N)))
    return N + 1
end

function rocprint!(ex, N, oc, iex::Expr)
    for arg in iex.args
        N = rocprint!(ex, N, oc, arg)
    end
    return N
end

function rocprint!(ex, N, oc, ::S) where S
    error("Dynamic printing of $S only supported via @rocprintf")
end

macro rocprint(str...)
    if first(str) isa String || Meta.isexpr(first(str), :string)
        # No OutputContext
        @gensym oc_ptr oc
        ex = quote
            $oc_ptr = $output_context()
            $oc = Base.unsafe_load($oc_ptr)
        end
        push!(ex.args, rocprint(oc, str...))
        return esc(ex)
    else
        return esc(rocprint(first(str), str[2:end]...))
    end
end

macro rocprintln(str...)
    if first(str) isa String || Meta.isexpr(first(str), :string)
        # No OutputContext
        @gensym oc_ptr oc
        ex = quote
            $oc_ptr = $output_context()
            $oc = Base.unsafe_load($oc_ptr)
        end
        push!(ex.args, rocprint(oc, str..., '\n'))
        return esc(ex)
    else
        return esc(rocprint(first(str), str[2:end]..., '\n'))
    end
end

# @rocprintf impementation.

struct ROCPrintfBuffer end

Base.sizeof(::ROCPrintfBuffer) = 0

Base.unsafe_store!(::LLVMPtr{ROCPrintfBuffer, AS.Global}, x) = nothing

# TODO add docs about format.
function Base.unsafe_load(ptr::LLVMPtr{ROCPrintfBuffer, AS.Global})
    ptr = reinterpret(Ptr{UInt64}, ptr)

    # Read number of argument blocks in buffer.
    blocks = unsafe_load(ptr)
    ptr += sizeof(UInt64)

    # Read pointer to format string.
    fmt_ptr = Ptr{UInt64}(unsafe_load(ptr))
    ptr += sizeof(UInt64)
    # Read format string length.
    fmt_len = unsafe_load(ptr)
    ptr += sizeof(UInt64)

    # Read format string into host buffer.
    fmt_buf = Vector{UInt8}(undef, fmt_len)
    HSA.memory_copy(
        convert(Ptr{Cvoid}, pointer(fmt_buf)),
        convert(Ptr{Cvoid}, fmt_ptr), fmt_len) |> Runtime.check
    fmt = String(fmt_buf)

    # Read arguments
    block = 1
    all_args = []
    while block <= blocks
        args = []
        while true
            # Read argument type
            T_ptr = Ptr{UInt64}(unsafe_load(ptr))
            Core.println("T_ptr       ", T_ptr)
            ptr += sizeof(UInt64)
            if UInt64(T_ptr) == 0
                # Terminator
                break
            end
            Core.println("Cstring ptr ", pointer_from_objref(Cstring))
            T = unsafe_pointer_to_objref(T_ptr)
            Core.println("T ", T)
            # Read argument.
            arg = unsafe_load(reinterpret(Ptr{T}, ptr))
            push!(args, arg)
            ptr += sizeof(arg)
        end
        push!(all_args, args)
        block += 1
    end

    return (fmt, all_args)
end

function _rocprintf_fmt(ptr::LLVMPtr{UInt64, AS.Global}, fmt_ptr, fmt_len::Int64)
    unsafe_store!(ptr, reinterpret(UInt64, fmt_ptr))
    ptr += sizeof(UInt64)
    unsafe_store!(ptr, UInt64(fmt_len))
    ptr += sizeof(UInt64)
    return ptr
end

function _pointer_from_type(::Type{T}) where T
    UInt64(pointer_from_objref(T))
end

function _rocprintf_arg(ptr::LLVMPtr{UInt64, AS.Global}, arg::T) where T
    unsafe_store!(ptr, _pointer_from_type(T))
    ptr += sizeof(UInt64)

    unsafe_store!(reinterpret(LLVMPtr{T, AS.Global}, ptr), arg)
    ptr += sizeof(arg)
    return ptr
end

macro rocprintf(args...)
    mode = :group
    # TODO allow specifying mode as first arg

    @assert first(args) isa String "@rocprintf format-string must be a String"

    fmt = args[1]
    args = args[2:end]

    @gensym printf_hc device_ptr device_fmt_ptr write_size
    ex = quote
        # Load printf HostCall.
        $printf_hc = Base.unsafe_load($printf_output_context())
        $device_ptr = reinterpret(
            $(LLVMPtr{UInt64, AS.Global}), $printf_hc.buf_ptr)
        # Allocate device-side format pointer.
        $device_fmt_ptr = $alloc_string($(Val(Symbol(fmt))))
        # Lock hostcall buffer.
        $hostcall_device_lock!($printf_hc)
        # Write block count.
        Base.unsafe_store!($device_ptr, UInt64(1)) # TODO take into account mode
        $device_ptr += sizeof(UInt64)
        # Write fmt string pointer & its bytesize.
        $device_ptr = $_rocprintf_fmt(
            $device_ptr, $device_fmt_ptr, $(sizeof(fmt)))
        # Calculate total write size per args block.
        $write_size =
            $hostcall_device_args_size($(map(esc, args)...)) + # Space for arguments.
            $(length(args)) * sizeof(UInt64) + # Space for type tags. # TODO what if args are less than uint64?
            sizeof(UInt64) # Space for terminator.
        # TODO account for offset for different modes.
    end

    # Write arguments & terminating null word.
    ex_args = Expr(:block)
    for arg in args
        push!(ex_args.args, :($device_ptr = $_rocprintf_arg(
            $device_ptr, $(esc(arg)))))
    end
    push!(ex_args.args, :(unsafe_store!($device_ptr, 0)))
    push!(ex.args, :(@device_execution_gate $mode $ex_args))

    # Submit & unlock hostcall buffer.
    push!(ex.args, :($hostcall_device_trigger_and_return!($printf_hc)))
    push!(ex.args, :(nothing))
    ex
end
