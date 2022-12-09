"Internal representation of a static string."
struct DeviceStaticString{N} end

Base.unsafe_load(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}) =
    unsafe_string(reinterpret(Cstring, ptr))
Base.unsafe_store!(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}, x) = nothing

struct OutputContext{HC}
    hostcall::HC
end
function OutputContext(io::IO=stdout; device=AMDGPU.default_device(), continuous=true, buf_len=2^16, name=nothing, kwargs...)
    hc = if name !== nothing
        named_perdevice_hostcall(device, name) do
            create_output_context_hostcall(io; device, continuous, buf_len, kwargs...)
        end
    else
        create_output_context_hostcall(io; device, continuous, buf_len, kwargs...)
    end
    return OutputContext(hc)
end
function create_output_context_hostcall(io; buf_len, kwargs...)
    hc = HostCall(Int64, Tuple{LLVMPtr{DeviceStaticString{buf_len},AS.Global}}; buf_len, kwargs...) do bytes
        str = unsafe_load(reinterpret(LLVMPtr{DeviceStaticString{buf_len},AS.Global}, hc.buf_ptr))
        print(io, str)
        return Int64(length(str))
    end
    return hc
end

const GLOBAL_OUTPUT_CONTEXT_TYPE = OutputContext{HostCall{Int64,Tuple{LLVMPtr{DeviceStaticString{2^16},AS.Global}},UInt64}}

### macros

macro rocprint(str...)
    if first(str) isa String || Meta.isexpr(first(str), :string)
        # No OutputContext
        @gensym oc_ptr oc
        ex = quote
            $oc_ptr = $get_global_pointer($(Val(:__global_output_context)),
                                          $GLOBAL_OUTPUT_CONTEXT_TYPE)
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
            $oc_ptr = $get_global_pointer($(Val(:__global_output_context)),
                                                 $GLOBAL_OUTPUT_CONTEXT_TYPE)
            $oc = Base.unsafe_load($oc_ptr)
        end
        push!(ex.args, rocprint(oc, str..., '\n'))
        return esc(ex)
    else
        return esc(rocprint(first(str), str[2:end]..., '\n'))
    end
end

### parse-time helpers

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
    push!(ex.args, :($hostcall_device_lock!($oc.hostcall)))
    N = 1
    for str in strs
        N = rocprint!(ex, N, oc, str)
    end
    rocprint!(ex, N, oc, '\0')
    push!(ex.args, :($hostcall_device_trigger_and_return!($oc.hostcall)))
    push!(ex.args, :(nothing))
    return ex
end
function rocprint!(ex, N, oc, str::String)
    @gensym str_ptr
    push!(ex.args, :($str_ptr = $alloc_string($(Val(Symbol(str))))))
    push!(ex.args, :($memcpy!($oc.hostcall.buf_ptr+$(N-1), $str_ptr, $(length(str)))))
    return N+length(str)
end
function rocprint!(ex, N, oc, char::Char)
    @assert length(codeunits(string(char))) == 1 "Multi-codeunit chars not yet implemented"
    byte = UInt8(char)
    ptr = :(reinterpret($(LLVMPtr{UInt8,AS.Global}), $oc.hostcall.buf_ptr))
    push!(ex.args, :(Base.unsafe_store!($ptr, $byte, $N)))
    return N+1
end
function rocprint!(ex, N, oc, iex::Expr)
    for arg in iex.args
        N = rocprint!(ex, N, oc, arg)
    end
    return N
end
function rocprint!(ex, N, oc, sym::S) where S
    error("Dynamic printing of $S only supported via @rocprintf")
end

## @rocprintf

# Serializes execution of a function within a wavefront
# From implementation by @jonathanvdc in CUDAnative.jl#419
function wave_serialized(func::Function)
    # Get the current thread's ID
    thread_id = workitemIdx().x - 1

    # Get the size of a wavefront
    size = wavefrontsize()

    local result
    i = 0
    while i < size
        if thread_id % size == i
            result = func()
        end
        i += 1
    end
    return result
end

struct ROCPrintfBuffer end
Base.sizeof(::ROCPrintfBuffer) = 0
Base.unsafe_store!(::LLVMPtr{ROCPrintfBuffer,as} where as, x) = nothing
function Base.unsafe_load(ptr::LLVMPtr{ROCPrintfBuffer,as} where as)
    ptr = reinterpret(Ptr{UInt64}, ptr)

    # Read number of argument blocks in buffer
    blocks = unsafe_load(ptr)
    ptr += sizeof(UInt64)

    # Read pointer to format string
    fmt_ptr = Ptr{UInt64}(unsafe_load(ptr))
    ptr += sizeof(UInt64)

    # Read format string length
    fmt_len = unsafe_load(ptr)
    ptr += sizeof(UInt64)

    # Read format string into host buffer
    fmt_buf = Vector{UInt8}(undef, fmt_len)
    HSA.memory_copy(convert(Ptr{Cvoid}, pointer(fmt_buf)), convert(Ptr{Cvoid}, fmt_ptr), fmt_len) |> Runtime.check
    fmt = String(fmt_buf)

    # Read arguments
    block = 1
    all_args = []
    while block <= blocks
        args = []
        while true
            # Read argument type
            T_ptr = Ptr{UInt64}(unsafe_load(ptr))
            ptr += sizeof(UInt64)
            if UInt64(T_ptr) == 0
                # Terminator
                break
            end
            T = unsafe_pointer_to_objref(T_ptr)

            # Read argument
            #=
            valid, arg = Runtime.semi_safe_load(convert(Ptr{T}, ptr))::Tuple{Bool,T}
            if !valid
                @warn "@rocprintf: Memory read failed! Printed string may include garbage\nFuture read failures will be ignored" maxlog=1
            end
            =#
            arg = unsafe_load(reinterpret(Ptr{T}, ptr))
            push!(args, arg)
            ptr += sizeof(arg)
        end
        push!(all_args, args)
        block += 1
    end

    return (fmt, all_args)
end

function _rocprintf_fmt(ptr, fmt_ptr, fmt_len)
    unsafe_store!(ptr, reinterpret(UInt64, fmt_ptr))
    ptr += sizeof(UInt64)
    unsafe_store!(ptr, UInt64(fmt_len))
    ptr += sizeof(UInt64)
    return ptr
end
@generated function pointer_from_type(::Type{T}) where T
    ptr = pointer_from_objref(T)
    return UInt64(ptr)
end
function _rocprintf_arg(ptr, arg::T) where T
    T_ptr = pointer_from_type(T)
    unsafe_store!(ptr, T_ptr)
    ptr += sizeof(UInt64)
    unsafe_store!(reinterpret(LLVMPtr{T,1}, ptr), arg)
    ptr += sizeof(arg)
    #= FIXME
    ref_arg = Ref{T}(arg)
    GC.@preserve ref_arg begin
    ptr_arg = convert(DevicePtr{UInt8,AS.Global},
                      convert(DevicePtr{T,AS.Global},
                      Base.unsafe_convert(Ptr{T}, ref_arg)))
    memcpy!(ptr, ptr_arg, sizeof(arg), Val(true))
    end
    =#
    return ptr
end
#= TODO: Not really useful until we can work with device-side strings
function _rocprintf_string(ptr, str::String)
    @gensym T_str T_str_len str_ptr
    quote
        $T_str, $T_str_len = AMDGPU._rocprintf_T_str(String)
        AMDGPU.Device.memcpy!($ptr, $T_str, $T_str_len)
        $ptr += $T_str_len
        unsafe_store!($ptr, UInt8(0))
        $ptr += 1
        $str_ptr = Base.unsafe_convert(DevicePtr{UInt8,AS.Generic}, $str_ptr)
        $str_ptr = AMDGPU.Device.alloc_string($(Val(Symbol(str))))
        AMDGPU.Device.memcpy!($ptr, $str_ptr, $(length(str)))
        $ptr += $(length(str))
        $ptr
    end
end
@generated function _rocprintf_T_str(::Type{T}) where T
    quote
        (AMDGPU.Device.alloc_string($(Val(Symbol(repr(T))))), $(sizeof(repr(T))))
    end
end
=#

function unsafe_ceil(x, y)
    up = Core.Intrinsics.urem_int(x, y) > 0
    return Core.Intrinsics.udiv_int(x, y) + up
end

macro rocprintf(args...)
    mode = :group
    @assert first(args) isa Union{QuoteNode,String} "First argument must be an inline Symbol or String"
    if first(args) isa QuoteNode
        mode = args[1].value::Symbol
        args = args[2:end]
        @assert mode isa Symbol "Execution mode must be a Symbol"
        @assert mode in (:grid, :group, :wave, :lane) "Invalid execution mode: $mode"
    end
    @assert first(args) isa String "Format must be a String"
    fmt = args[1]
    args = args[2:end]

    ex = Expr(:block)
    @gensym device_ptr device_fmt_ptr printf_hc write_size

    if mode == :grid
        push!(ex.args, quote
            # Skip all execution if not on the first group
            if prod($workgroupIdx()) != 1
                return
            end
        end)
    end

    # Allocate device-side format pointer
    push!(ex.args, :($device_fmt_ptr = $alloc_string($(Val(Symbol(fmt))))))

    # Load HostCall object
    push!(ex.args, :($printf_hc = unsafe_load($get_global_pointer(Val(:__global_printf_context),
                                                                        HostCall{Int64,Tuple{LLVMPtr{ROCPrintfBuffer,AS.Global}},UInt64}))))
    push!(ex.args, :($device_ptr = reinterpret($(LLVMPtr{UInt64,AS.Global}), $printf_hc.buf_ptr)))

    # Lock hostcall buffer
    push!(ex.args, :($hostcall_device_lock!($printf_hc)))

    # Write block count
    # FIXME: Use y and z dims
    if mode == :grid
        push!(ex.args, :(unsafe_store!($device_ptr, UInt64(1))))
    elseif mode == :group
        push!(ex.args, :(unsafe_store!($device_ptr, UInt64(1))))
    elseif mode == :wave
        waves_per_group = :($unsafe_ceil(reinterpret(UInt64, $workgroupDim().x),
                                         Base.unsafe_trunc(UInt64, $wavefrontsize())))
        push!(ex.args, :(unsafe_store!($device_ptr, $waves_per_group)))
    elseif mode == :lane
        push!(ex.args, :(unsafe_store!($device_ptr, reinterpret(UInt64, $workgroupDim().x))))
    end
    push!(ex.args, :($device_ptr += sizeof(UInt64)))

    # Write format string pointer
    push!(ex.args, :($device_ptr = $_rocprintf_fmt($device_ptr, $device_fmt_ptr, $(sizeof(fmt)))))

    # Calculate total write size per args block
    push!(ex.args, :($write_size = $hostcall_device_args_size($(map(esc, args)...)) # Space for arguments
                                 + $(length(args))*sizeof(UInt64) + # Space for type tags
                                 + sizeof(UInt64))) # Space for terminator

    # Calulate offset into buffer
    # FIXME: Use y and z dims
    offset = if mode == :grid
        :(0)
    elseif mode == :group
        :(0)
    elseif mode == :wave
        wave_idx = :(Core.Intrinsics.udiv_int(reinterpret(UInt64, $workitemIdx().x - 1),
                                              Base.unsafe_trunc(UInt64, $wavefrontsize())))
        :($wave_idx * $write_size)
    elseif mode == :lane
        lane_idx = :(workitemIdx().x - 1)
        :($lane_idx * $write_size)
    end
    push!(ex.args, :($device_ptr += $offset))

    # Write arguments and terminating null word
    ex_args = Expr(:block)
    for arg in args
        push!(ex_args.args, :($device_ptr = $_rocprintf_arg($device_ptr, $(esc(arg)))))
    end
    push!(ex_args.args, :(unsafe_store!($device_ptr, 0)))
    push!(ex.args, :(@device_execution_gate $mode $ex_args))

    # Submit and unlock hostcall buffer
    push!(ex.args, :($hostcall_device_trigger_and_return!($printf_hc)))
    push!(ex.args, :(nothing))
    ex
end
