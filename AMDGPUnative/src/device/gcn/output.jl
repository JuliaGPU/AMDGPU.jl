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

### macros

macro rocprint(oc, str)
    rocprint(oc, str)
end
macro rocprintln(oc, str)
    rocprint(oc, str, true)
end

### parse-time helpers

function rocprint(oc, str, nl=false)
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
    return ex
end
function rocprint!(ex, N, oc, str::String)
    # TODO: push!(ex.args, :($rocprint!($(esc(oc)), $(Val(Symbol(str))))))
    off = N
    ptr = :(Base.unsafe_convert(DevicePtr{UInt8,AS.Global}, $(esc(oc)).hostcall.buf_ptr))
    for byte in codeunits(str)
        push!(ex.args, :(Base.unsafe_store!($ptr, $byte, $off)))
        off += 1
    end

    return off
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

#= TODO: LLVM hates me, but this should eventually work
# FIXME: Pass N and offset oc.buf_ptr appropriately
@inline @generated function rocprint!(oc::OutputContext, ::Val{str}) where str
    T_int1 = LLVM.Int1Type(JuliaContext())
    T_int32 = LLVM.Int32Type(JuliaContext())
    T_pint8 = LLVM.PointerType(LLVM.Int8Type(JuliaContext()))
    T_pint8_global = LLVM.PointerType(LLVM.Int8Type(JuliaContext()), convert(Int, AS.Global))
    T_nothing = LLVM.VoidType(JuliaContext())
    llvm_f, _ = create_function(T_nothing, [T_pint8_global])
    mod = LLVM.parent(llvm_f)
    T_intr = LLVM.FunctionType(T_nothing, [T_pint8_global, T_pint8, T_int32, T_int32, T_int1])
    intr = LLVM.Function(mod, "llvm.memcpy.p1i8.p0i8.i32", T_intr)
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)
        str_ptr = globalstring_ptr!(builder, String(str))
        buf_ptr = parameters(llvm_f)[1]
        # NOTE: There's a hidden alignment parameter (argument 4) that's not documented in the LangRef
        call!(builder, intr, [buf_ptr, str_ptr, ConstantInt(Int32(length(string(str))), JuliaContext()), ConstantInt(Int32(2), JuliaContext()), ConstantInt(T_int1, 0)])
        ret!(builder)
    end
    Core.println(unsafe_string(LLVM.API.LLVMPrintValueToString(LLVM.ref(llvm_f))))
    call_function(llvm_f, Nothing, Tuple{DevicePtr{UInt8,AS.Global}}, :((oc.hostcall.buf_ptr,)))
end
=#
