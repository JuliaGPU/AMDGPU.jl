# Pointers with address space information

# Address spaces

export AS, addrspace

abstract type AddressSpace end

module AS

import ..AddressSpace

struct Generic  <: AddressSpace end
struct Global   <: AddressSpace end
struct Region   <: AddressSpace end
struct Local    <: AddressSpace end
struct Constant <: AddressSpace end
struct Private  <: AddressSpace end

end # module

# Device pointer

"""
    DevicePtr{T,A}
"""
DevicePtr

if sizeof(Ptr{Cvoid}) == 8
    primitive type DevicePtr{T,A} <: Ref{T} 64 end
else
    primitive type DevicePtr{T,A} <: Ref{T} 32 end
end

# constructors

DevicePtr{T,A}(x::Union{Int,UInt,Ptr,DevicePtr}) where {T,A<:AddressSpace} = Base.bitcast(DevicePtr{T,A}, x)
DevicePtr{T}(ptr::Ptr{T}) where {T} = DevicePtr{T,AS.Generic}(ptr)
DevicePtr(ptr::Ptr{T}) where {T} = DevicePtr{T,AS.Generic}(ptr)


# getters

Base.eltype(::Type{<:DevicePtr{T}}) where {T} = T
addrspace(x::DevicePtr) = addrspace(typeof(x))
addrspace(::Type{DevicePtr{T,A}}) where {T,A} = A

# conversions

# to and from integers
# pointer to integer
Base.convert(::Type{T}, x::DevicePtr) where {T<:Integer} = T(UInt(x))
# integer to pointer
Base.convert(::Type{DevicePtr{T,A}}, x::Union{Int,UInt}) where {T,A<:AddressSpace} = DevicePtr{T,A}(x)
Int(x::DevicePtr)  = Base.bitcast(Int, x)
UInt(x::DevicePtr) = Base.bitcast(UInt, x)

# between host and device pointers
Base.convert(::Type{Ptr{T}},  p::DevicePtr)  where {T}                 = Base.bitcast(Ptr{T}, p)
Base.convert(::Type{DevicePtr{T,A}}, p::Ptr) where {T,A<:AddressSpace} = Base.bitcast(DevicePtr{T,A}, p)
Base.convert(::Type{DevicePtr{T}}, p::Ptr)   where {T}                 = Base.bitcast(DevicePtr{T,AS.Generic}, p)

# between CPU pointers, for the purpose of working with `ccall`
Base.unsafe_convert(::Type{Ptr{T}}, x::DevicePtr{T}) where {T} = reinterpret(Ptr{T}, x)

# between device pointers
Base.convert(::Type{<:DevicePtr}, p::DevicePtr)                         = throw(ArgumentError("cannot convert between incompatible device pointer types"))
Base.convert(::Type{DevicePtr{T,A}}, p::DevicePtr{T,A})   where {T,A}   = p
Base.unsafe_convert(::Type{DevicePtr{T,A}}, p::DevicePtr) where {T,A}   = Base.bitcast(DevicePtr{T,A}, p)

# identical addrspaces
Base.convert(::Type{DevicePtr{T,A}}, p::DevicePtr{U,A}) where {T,U,A} = Base.unsafe_convert(DevicePtr{T,A}, p)

# convert to & from generic
Base.convert(::Type{DevicePtr{T,AS.Generic}}, p::DevicePtr)               where {T}     = Base.unsafe_convert(DevicePtr{T,AS.Generic}, p)
Base.convert(::Type{DevicePtr{T,A}}, p::DevicePtr{U,AS.Generic})          where {T,U,A} = Base.unsafe_convert(DevicePtr{T,A}, p)
Base.convert(::Type{DevicePtr{T,AS.Generic}}, p::DevicePtr{T,AS.Generic}) where {T}     = p  # avoid ambiguities

# unspecified, preserve source addrspace
Base.convert(::Type{DevicePtr{T}}, p::DevicePtr{U,A}) where {T,U,A} = Base.unsafe_convert(DevicePtr{T,A}, p)

# limited pointer arithmetic & comparison
isequal(x::DevicePtr, y::DevicePtr) = (x === y) && addrspace(x) == addrspace(y)
isless(x::DevicePtr{T,A}, y::DevicePtr{T,A}) where {T,A<:AddressSpace} = x < y
Base.:(==)(x::DevicePtr, y::DevicePtr) = UInt(x) == UInt(y) && addrspace(x) == addrspace(y)
Base.:(<)(x::DevicePtr,  y::DevicePtr) = UInt(x) < UInt(y)
Base.:(-)(x::DevicePtr,  y::DevicePtr) = UInt(x) - UInt(y)
Base.:(+)(x::DevicePtr, y::Integer) = oftype(x, Base.add_ptr(UInt(x), (y % UInt) % UInt))
Base.:(-)(x::DevicePtr, y::Integer) = oftype(x, Base.sub_ptr(UInt(x), (y % UInt) % UInt))
Base.:(+)(x::Integer, y::DevicePtr) = y + x

# memory operations

# New values (LLVM 7+)
Base.convert(::Type{Int}, ::Type{AS.Generic})  = 0
Base.convert(::Type{Int}, ::Type{AS.Global})   = 1
Base.convert(::Type{Int}, ::Type{AS.Region})   = 2
Base.convert(::Type{Int}, ::Type{AS.Local})    = 3
Base.convert(::Type{Int}, ::Type{AS.Constant}) = 4
Base.convert(::Type{Int}, ::Type{AS.Private})  = 5

function tbaa_make_child(name::String, constant::Bool=false; ctx::LLVM.Context=JuliaContext())
    tbaa_root = MDNode([MDString("roctbaa", ctx)], ctx)
    tbaa_struct_type =
        MDNode([MDString("roctbaa_$name", ctx),
                tbaa_root,
                LLVM.ConstantInt(0, ctx)], ctx)
    tbaa_access_tag =
        MDNode([tbaa_struct_type,
                tbaa_struct_type,
                LLVM.ConstantInt(0, ctx),
                LLVM.ConstantInt(constant ? 1 : 0, ctx)], ctx)

    return tbaa_access_tag
end

tbaa_addrspace(as::Type{<:AddressSpace}) = tbaa_make_child(lowercase(String(as.name.name)))

@generated function Base.unsafe_load(p::DevicePtr{T,A}, i::Integer=1,
                                     ::Val{align}=Val(1)) where {T,A,align}
    eltyp = convert(LLVMType, T)
    T_int = convert(LLVMType, Int)
    T_ptr = convert(LLVMType, DevicePtr{T,A})
    T_actual_ptr = LLVM.PointerType(eltyp, convert(Int, A))

    # create a function
    param_types = [T_ptr, T_int]
    llvm_f, _ = create_function(eltyp, param_types)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        ptr = inttoptr!(builder, parameters(llvm_f)[1], T_actual_ptr)
        ptr = gep!(builder, ptr, [parameters(llvm_f)[2]])
        ld = load!(builder, ptr)

        if A != AS.Generic
            metadata(ld)[LLVM.MD_tbaa] = tbaa_addrspace(A)
        end

        alignment!(ld, align)
        ret!(builder, ld)
    end

    call_function(llvm_f, T, Tuple{DevicePtr{T,A}, Int}, :((p, Int(i-one(i)))))
end

@generated function Base.unsafe_store!(p::DevicePtr{T,A}, x, i::Integer=1,
                                       ::Val{align}=Val(1)) where {T,A,align}
    eltyp = convert(LLVMType, T)
    T_int = convert(LLVMType, Int)
    T_ptr = convert(LLVMType, DevicePtr{T,A})
    T_actual_ptr = LLVM.PointerType(eltyp, convert(Int, A))

    # create a function
    param_types = [T_ptr, eltyp, T_int]
    llvm_f, _ = create_function(LLVM.VoidType(JuliaContext()), param_types)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        ptr = inttoptr!(builder, parameters(llvm_f)[1], T_actual_ptr)
        ptr = gep!(builder, ptr, [parameters(llvm_f)[3]])
        val = parameters(llvm_f)[2]
        st = store!(builder, val, ptr)

        if A != AS.Generic
            metadata(st)[LLVM.MD_tbaa] = tbaa_addrspace(A)
        end

        alignment!(st, align)
        ret!(builder)
    end

    call_function(llvm_f, Cvoid, Tuple{DevicePtr{T,A}, T, Int},
                  :((p, convert(T,x), Int(i-one(i)))))
end

