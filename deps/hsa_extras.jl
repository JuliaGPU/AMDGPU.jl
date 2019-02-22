# Extra stuff

# Utilities to make life easier when interoperating with C
const HSA_MUTABLE_TYPES = Union{hsa_region_t}

#=
Base.setproperty!(ref::Ref{T}, value, prop::Symbol) where T<:HSA_MUTABLE_TYPES =
    setproperty!(ref, value, Val(prop)
@generated function Base.setproperty!(ref::Ref{T}, value, prop::Val{V}) where {T<:HSA_MUTABLE_TYPES,V} =
    ftype = fieldtype(ref.parameters[1], V)
    return quote
        ptr = Ptr{$ftype}
        unsafe_store!(ptr, 
    end
end
=#

#= FIXME
function memset!(ref::Ref{Nothing}, value)
    _ptr = Base.unsafe_convert(Ptr{Nothing}, ref)
    ptr = Base.unsafe_convert(Ptr{UInt}, _ptr)
    value = UInt(value)
    unsafe_store!(ptr, value)
end
=#
memset!(ref::Ref{T}, value::T) where T<:Union{Unsigned,Signed} =
    _memset!(ref, value, T)
function _memset!(ref, value, ::Type{T}; len=1) where T
    ptr = Base.unsafe_convert(Ptr{T}, ref)
    for i in 1:len
        unsafe_store!(ptr, value, i)
    end
end
function _memset!(ref::Ref{Ptr{Nothing}}, value; len=1)
    ptr = Base.unsafe_convert(Ptr{UInt8}, ref[])
    value = UInt8(value)
    for i in 1:len
        unsafe_store!(ptr, value, i)
    end
end
    

# Convenience constructors
const HSA_ZEROABLE_TYPES = Union{hsa_region_t}

newref!(::Type{Ref{T}}, value) where T<:HSA_ZEROABLE_TYPES = Ref{T}(T(value))

# Overloads for interface functions
function hsa_agent_get_info(agent, attribute, value::String)
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Cstring), agent, attribute, value)
end
function hsa_agent_get_info(agent, attribute, value::Ref{T}) where T
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ptr{T}), agent, attribute, value)
end

function hsa_isa_get_info_alt(isa, attribute, value::String)
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, Cstring), isa, attribute, value)
end
