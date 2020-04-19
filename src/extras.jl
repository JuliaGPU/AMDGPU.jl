# Extra stuff

newref!(::Type{Ref{HSA.Region}}, value) = Ref{HSA.Region}(HSA.Region(value))

# Memory
memset!(ref::Ref{T}, value::T) where T<:Integer = _memset!(ref, value, T)

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
    
# Overloads for interface functions

function getinfo(agent::Agent, attribute::HSA.AgentInfo,
                 value::Union{Vector,Base.RefValue,String})
    #TODO: allocation/create Refs here 
    # based on value of AgentInfo
    HSA.agent_get_info(agent, attribute, value)
end

function getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.isa_get_info_alt(isa, attribute, value)
end

function getinfo(exsym::HSA.ExecutableSymbol, attribute::HSA.ExecutableSymbolInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.executable_symbol_get_info(exsym, attribute, value)
end
