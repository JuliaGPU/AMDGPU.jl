# Extra stuff


"""
    ROCDim3(x)
    ROCDim3((x,))
    ROCDim3((x, y))
    ROCDim3((x, y, x))

A type used to specify dimensions, consisting of 3 integers for the `x`, `y`,
and `z` dimension, respectively. Unspecified dimensions default to `1`.

Often accepted as argument through the `ROCDim` type alias, eg. in the case of
[`roccall`](@ref) or [`launch`](@ref), allowing to pass dimensions as a plain
integer or a tuple without having to construct an explicit `ROCDim3` object.
"""
struct ROCDim3
    x::Cuint
    y::Cuint
    z::Cuint
end

ROCDim3(dims::Integer)             = ROCDim3(dims,    Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{1,<:Integer}) = ROCDim3(dims[1], Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{2,<:Integer}) = ROCDim3(dims[1], dims[2],  Cuint(1))
ROCDim3(dims::NTuple{3,<:Integer}) = ROCDim3(dims[1], dims[2],  dims[3])

# Type alias for conveniently specifying the dimensions
# (e.g. `(len, 2)` instead of `ROCDim3((len, 2))`)
const ROCDim = Union{Integer,
                    Tuple{Integer},
                    Tuple{Integer, Integer},
                    Tuple{Integer, Integer, Integer}}

function Base.getindex(dims::ROCDim3, idx::Int)
    return idx == 1 ? dims.x :
           idx == 2 ? dims.y :
           idx == 3 ? dims.z :
           error("Invalid dimension: $idx")
end


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
getinfo(agent::Agent, info::HSA.AMDAgentInfo, ret::Union{String, Base.RefValue, Vector}) =
    getinfo(agent, reinterpret(HSA.AgentInfo, info), ret)

function getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.isa_get_info_alt(isa, attribute, value)
end

function getinfo(exsym::HSA.ExecutableSymbol, attribute::HSA.ExecutableSymbolInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.executable_symbol_get_info(exsym, attribute, value)
end
