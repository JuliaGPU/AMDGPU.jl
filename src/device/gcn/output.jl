export OutputContext, @rocprint, @rocprintln

"Internal representation of a static string."
struct DeviceStaticString{N} end
Base.sizeof(dss::DeviceStaticString{N}) where N = N

function Base.unsafe_load(ptr::DevicePtr{DeviceStaticString{N},AS.Global}) where N
    vec_ptr = convert(Ptr{UInt8}, ptr)
    vec_raw = Base.unsafe_wrap(Vector{UInt8}, vec_ptr, (N,))
    idx = findfirst(x->x==0, vec_raw)
    idx = idx === nothing ? N : idx
    return vec_raw[1:idx-1]
end
Base.unsafe_store!(ptr::DevicePtr{<:DeviceStaticString}, x) = nothing

struct OutputContext{HC}
    hostcall::HC
end
function OutputContext(io::IO=stdout; agent=get_default_agent(), buf_len=2^16, kwargs...)
    hc = HostCall(Int64, Tuple{DeviceStaticString{buf_len}}; agent=agent, continuous=true, kwargs...) do bytes
        print(io, String(bytes))
        Int64(length(bytes))
    end
    OutputContext(hc)
end

const GLOBAL_OUTPUT_CONTEXT_TYPE = OutputContext{HostCall{UInt64,Int64,Tuple{DeviceStaticString{2^16}}}}

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
        $(esc(oc_ptr)) = AMDGPU.get_global_pointer(Val(:__global_output_context),
                                                         $GLOBAL_OUTPUT_CONTEXT_TYPE)
        $(esc(oc)) = Base.unsafe_load($(esc(oc_ptr)))
    end
    push!(ex.args, rocprint(oc, str))
    ex
end
macro rocprintln(str)
    @gensym oc_ptr oc
    ex = quote
        $(esc(oc_ptr)) = AMDGPU.get_global_pointer(Val(:__global_output_context),
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
        N = rocprint!(ex, 1, oc, arg)
        N = rocprint!(ex, N, oc, '\0')
        dstr = DeviceStaticString{N}()
        push!(ex.args, :(hostcall!($(esc(oc)).hostcall, $dstr)))
    end
    push!(ex.args, :(nothing))
    return ex
end
function rocprint!(ex, N, oc, str::String)
    @gensym str_ptr
    push!(ex.args, :($str_ptr = AMDGPU.alloc_string($(Val(Symbol(str))))))
    push!(ex.args, :(AMDGPU.memcpy!($(esc(oc)).hostcall.buf_ptr+$(N-1), $str_ptr, $(length(str)))))
    return N+length(str)
end
function rocprint!(ex, N, oc, char::Char)
    @assert char == '\0' "Non-null chars not yet implemented"
    byte = UInt8(char)
    ptr = :(Base.unsafe_convert(DevicePtr{UInt8,AS.Global}, $(esc(oc)).hostcall.buf_ptr))
    push!(ex.args, :(Base.unsafe_store!($ptr, $byte, $N)))
    return N+1
end
function rocprint!(ex, N, oc, iex::Expr)
    for arg in iex.args
        N = rocprint!(ex, N, oc, arg)
    end
    return N
end
#= TODO: Support printing arbitrary values?
function rocprint!(ex, N, oc, sym::Symbol)
    push!(ex.args, :($rocprint!($(esc(oc)), $(QuoteNode(sym)))))
    return N+4
end
=#

### runtime helpers
