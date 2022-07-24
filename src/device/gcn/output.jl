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

const GLOBAL_OUTPUT_CONTEXT_TYPE = OutputContext{HostCall{UInt64,Int64,Tuple{LLVMPtr{DeviceStaticString{2^16},AS.Global}}}}

### macros

macro rocprint(oc, str)
    rocprint(oc, str)
end
macro rocprintln(oc, str)
    rocprint(oc, str, true)
end

macro rocprint(str)
    @gensym oc_ptr oc
    ex = quote
        $(esc(oc_ptr)) = AMDGPU.Device.get_global_pointer(Val(:__global_output_context),
                                                         $GLOBAL_OUTPUT_CONTEXT_TYPE)
        $(esc(oc)) = Base.unsafe_load($(esc(oc_ptr)))
    end
    push!(ex.args, rocprint(oc, str))
    ex
end
macro rocprintln(str)
    @gensym oc_ptr oc
    ex = quote
        $(esc(oc_ptr)) = AMDGPU.Device.get_global_pointer(Val(:__global_output_context),
                                                         $GLOBAL_OUTPUT_CONTEXT_TYPE)
        $(esc(oc)) = Base.unsafe_load($(esc(oc_ptr)))
    end
    push!(ex.args, rocprint(oc, str, true))
    ex
end

### parse-time helpers

function rocprint(oc, str, nl::Bool=false)
    ex = Expr(:block)
    if !(str isa Expr)
        str = Expr(:string, str)
    end
    @assert str.head == :string
    for (idx,arg) in enumerate(str.args)
        if nl && idx == length(str.args)
            arg *= '\n'
        end
        push!(ex.args, :($hostcall_device_lock!($(esc(oc)).hostcall)))
        N = rocprint!(ex, 1, oc, arg)
        N = rocprint!(ex, N, oc, '\0')
        push!(ex.args, :($hostcall_device_trigger_and_return!($(esc(oc)).hostcall)))
    end
    push!(ex.args, :(nothing))
    return ex
end
function rocprint!(ex, N, oc, str::String)
    @gensym str_ptr
    push!(ex.args, :($str_ptr = AMDGPU.Device.alloc_string($(Val(Symbol(str))))))
    push!(ex.args, :(AMDGPU.Device.memcpy!($(esc(oc)).hostcall.buf_ptr+$(N-1), $str_ptr, $(length(str)))))
    return N+length(str)
end
function rocprint!(ex, N, oc, char::Char)
    @assert char == '\0' "Non-null chars not yet implemented"
    byte = UInt8(char)
    ptr = :(reinterpret(LLVMPtr{UInt8,AS.Global}, $(esc(oc)).hostcall.buf_ptr))
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

macro rocprintf(fmt, args...)
    ex = Expr(:block)
    @gensym device_ptr device_fmt_ptr printf_hc
    push!(ex.args, :($device_fmt_ptr = AMDGPU.Device.alloc_string($(Val(Symbol(fmt))))))
    push!(ex.args, :($printf_hc = unsafe_load(AMDGPU.Device.get_global_pointer(Val(:__global_printf_context),
                                                                        HostCall{UInt64,Int64,Tuple{LLVMPtr{ROCPrintfBuffer,AS.Global}}}))))
    push!(ex.args, :($device_ptr = reinterpret($(LLVMPtr{UInt64,AS.Global}), $printf_hc.buf_ptr)))

    push!(ex.args, :($hostcall_device_lock!($printf_hc)))

    push!(ex.args, :($device_ptr = AMDGPU.Device._rocprintf_fmt($device_ptr, $device_fmt_ptr, $(sizeof(fmt)))))
    for arg in args
        push!(ex.args, :($device_ptr = AMDGPU.Device._rocprintf_arg($device_ptr, $(esc(arg)))))
    end
    push!(ex.args, :(unsafe_store!($device_ptr, UInt64(0))))

    push!(ex.args, :($hostcall_device_trigger_and_return!($printf_hc)))
    push!(ex.args, :(nothing))
    ex
end

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
    fmt_ptr = Ptr{UInt64}(unsafe_load(ptr))
    ptr += sizeof(UInt64)
    fmt_len = unsafe_load(ptr)
    ptr += sizeof(UInt64)
    fmt_buf = Vector{UInt8}(undef, fmt_len)
    HSA.memory_copy(convert(Ptr{Cvoid}, pointer(fmt_buf)), convert(Ptr{Cvoid}, fmt_ptr), fmt_len) |> Runtime.check
    fmt = String(fmt_buf)
    args = []
    while true
        T_ptr = Ptr{UInt64}(unsafe_load(ptr))
        ptr += sizeof(UInt64)
        UInt64(T_ptr) == 0 && break
        T = unsafe_pointer_to_objref(T_ptr)
        valid, arg = Runtime.semi_safe_load(convert(Ptr{T}, ptr))
        if !valid
            @warn "@rocprintf: Memory read failed! Printed string may include garbage\nFuture read failures will be ignored" maxlog=1
        end
        arg = arg::T
        push!(args, arg)
        ptr += sizeof(arg)
    end
    return (fmt, args)
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
