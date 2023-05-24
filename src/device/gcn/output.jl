"Internal representation of a static string."
struct DeviceStaticString{N} end

Base.unsafe_load(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}) =
    unsafe_string(reinterpret(Cstring, ptr))
Base.unsafe_store!(ptr::LLVMPtr{<:DeviceStaticString,AS.Global}, x) = nothing

struct OutputContext{HC}
    hostcall::HC
end

function OutputContext(
    io::IO=stdout; device=AMDGPU.default_device(), continuous=true,
    buf_len=2^16, name=nothing, kwargs...,
)
    hc = if name !== nothing
        named_perdevice_hostcall(device, name) do
            create_output_context_hostcall(; buf_len, device, continuous, kwargs...)
        end
    else
        create_output_context_hostcall(; buf_len, device, continuous, kwargs...)
    end
    return OutputContext(hc)
end

function create_output_context_hostcall(; buf_len, kwargs...)
    ret_typ = Nothing
    args_typ = Tuple{LLVMPtr{DeviceStaticString{buf_len}, AS.Global}}
    hc = HostCall(ret_typ, args_typ; buf_len, kwargs...) do bytes
        str_ptr = reinterpret(
            LLVMPtr{DeviceStaticString{buf_len}, AS.Global}, hc.buf_ptr)
        str = unsafe_load(str_ptr)
        # FIXME using regular `print(io, ...)` hangs the task for some reason...
        Core.print(str)
        return nothing
    end
    return hc
end

const GLOBAL_OUTPUT_CONTEXT_TYPE = OutputContext{
    HostCall{Nothing, Tuple{LLVMPtr{DeviceStaticString{2^16}, AS.Global}}}}

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
    # Write strings & null termination to hostcall buffer.
    for str in strs
        N = rocprint!(ex, N, oc, str)
    end
    rocprint!(ex, N, oc, '\0')
    # Make host read args, execute function & wait for return.
    push!(ex.args, :($hostcall_device_trigger_and_return!($oc.hostcall)))
    push!(ex.args, :(nothing))
    return ex
end

function rocprint!(ex, N, oc, str::String)
    @gensym str_ptr
    push!(ex.args, :($str_ptr = $alloc_string($(Val(Symbol(str))))))
    push!(ex.args, :($memcpy!($oc.hostcall.buf_ptr + $(N - 1), $str_ptr, $(length(str)))))
    return N + length(str)
end

function rocprint!(ex, N, oc, char::Char)
    @assert length(codeunits(string(char))) == 1 "Multi-codeunit chars not yet implemented"
    byte = UInt8(char)
    ptr = :(reinterpret($(LLVMPtr{UInt8,AS.Global}), $oc.hostcall.buf_ptr))
    push!(ex.args, :(Base.unsafe_store!($ptr, $byte, $N)))
    return N + 1
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
