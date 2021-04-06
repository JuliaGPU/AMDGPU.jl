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

# Atomic store using LLVM intrinsics
# Necessary for writing the AQL packet header to the queue
# prior to launching a kernel.
@eval atomic_store_n!(x::Ptr{UInt16}, v::UInt16) =
    Base.llvmcall($"""
    %ptr = inttoptr i$(Sys.WORD_SIZE) %0 to i16*
    store atomic i16 %1, i16* %ptr release, align 64
    ret void
    """, Cvoid, Tuple{Ptr{UInt16}, UInt16},
    Base.unsafe_convert(Ptr{UInt16}, x), v)

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
