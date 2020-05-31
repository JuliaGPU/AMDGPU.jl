export alloc_special, alloc_local

"Allocates on-device memory statically from the specified address space."
@generated function alloc_special(::Val{id}, ::Type{T}, ::Val{as}, ::Val{len}) where {id,T,as,len}
    eltyp = convert(LLVMType, T)

    # old versions of GPUArrays invoke _shmem with an integer id; make sure those are unique
    if !isa(id, String) || !isa(id, Symbol)
        id = "alloc_special_$id"
    end

    T_ptr = convert(LLVMType, DevicePtr{T,as})

    # create a function
    llvm_f, _ = create_function(T_ptr)

    # create the global variable
    mod = LLVM.parent(llvm_f)
    gv_typ = LLVM.ArrayType(eltyp, len)
    gv = GlobalVariable(mod, gv_typ, string(id), convert(Int, as))
    if len > 0
        linkage!(gv, LLVM.API.LLVMInternalLinkage)
        #initializer!(gv, null(gv_typ))
    end

    # by requesting a larger-than-datatype alignment, we might be able to vectorize.
    # TODO: Make the alignment configurable
    alignment!(gv, Base.max(32, Base.datatype_alignment(T)))

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        ptr_with_as = gep!(builder, gv, [ConstantInt(0, JuliaContext()),
                                         ConstantInt(0, JuliaContext())])

        val = ptrtoint!(builder, ptr_with_as, T_ptr)
        ret!(builder, val)
    end

    call_function(llvm_f, DevicePtr{T,as})
end

@inline alloc_local(id, T, len) = alloc_special(Val(id), Val(T), Val(AS.Local), Val(len))

@inline @generated function alloc_string(::Val{str}) where str
    T_pint8_generic = LLVM.PointerType(LLVM.Int8Type(JuliaContext()), convert(Int, AS.Generic))
    llvm_f, _ = create_function(LLVM.Int64Type(JuliaContext()))
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)
        str_ptr = globalstring_ptr!(builder, String(str))
        str_ptr_i64 = ptrtoint!(builder, str_ptr, LLVM.Int64Type(JuliaContext()))
        ret!(builder, str_ptr_i64)
    end
    call_function(llvm_f, DevicePtr{UInt8,AS.Generic})
end

# TODO: Support various types of len
@inline @generated function memcpy!(dest_ptr::DevicePtr{UInt8,DestAS}, src_ptr::DevicePtr{UInt8,SrcAS}, len::LT) where {DestAS,SrcAS,LT<:Union{Int64,UInt64}}
    T_nothing = LLVM.VoidType(JuliaContext())
    dest_as = convert(Int, DestAS)
    src_as = convert(Int, SrcAS)
    T_int8 = LLVM.Int8Type(JuliaContext())
    T_int64 = LLVM.Int64Type(JuliaContext())
    T_pint8_dest = LLVM.PointerType(T_int8, dest_as)
    T_pint64_dest = LLVM.PointerType(T_int64, dest_as)
    T_pint8_src = LLVM.PointerType(T_int8, src_as)
    T_pint64_src = LLVM.PointerType(T_int64, src_as)
    T_int1 = LLVM.Int1Type(JuliaContext())

    llvm_f, _ = create_function(T_nothing, [T_int64, T_int64, T_int64])
    mod = LLVM.parent(llvm_f)
    T_intr = LLVM.FunctionType(T_nothing, [T_pint8_dest, T_pint8_src, T_int64, T_int1])
    intr = LLVM.Function(mod, "llvm.memcpy.p$(dest_as)i8.p$(src_as)i8.i64", T_intr)
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        dest_ptr_i64 = inttoptr!(builder, parameters(llvm_f)[1], T_pint64_dest)
        dest_ptr_i8 = bitcast!(builder, dest_ptr_i64, T_pint8_dest)

        src_ptr_i64 = inttoptr!(builder, parameters(llvm_f)[2], T_pint64_src)
        src_ptr_i8 = bitcast!(builder, src_ptr_i64, T_pint8_src)

        call!(builder, intr, [dest_ptr_i8, src_ptr_i8, parameters(llvm_f)[3], ConstantInt(T_int1, 0)])
        ret!(builder)
    end
    call_function(llvm_f, Nothing, Tuple{DevicePtr{UInt8,DestAS},DevicePtr{UInt8,SrcAS},LT}, :((dest_ptr, src_ptr, len)))
end
memcpy!(dest_ptr::DevicePtr{T,DestAS}, src_ptr::DevicePtr{T,SrcAS}, len::Integer) where {T,DestAS,SrcAS} =
    memcpy!(convert(DevicePtr{UInt8,DestAS}, dest_ptr), convert(DevicePtr{UInt8,SrcAS}, src_ptr), UInt64(len))
@inline @generated function memset!(dest_ptr::DevicePtr{UInt8,DestAS}, value::UInt8, len::LT) where {DestAS,LT<:Union{Int64,UInt64}}
    T_nothing = LLVM.VoidType(JuliaContext())
    dest_as = convert(Int, DestAS)
    T_int8 = LLVM.Int8Type(JuliaContext())
    T_int64 = LLVM.Int64Type(JuliaContext())
    T_pint8_dest = LLVM.PointerType(T_int8, dest_as)
    T_pint64_dest = LLVM.PointerType(T_int64, dest_as)
    T_int1 = LLVM.Int1Type(JuliaContext())

    llvm_f, _ = create_function(T_nothing, [T_int64, T_int8, T_int64])
    mod = LLVM.parent(llvm_f)
    T_intr = LLVM.FunctionType(T_nothing, [T_pint8_dest, T_int8, T_int64, T_int1])
    intr = LLVM.Function(mod, "llvm.memset.p$(dest_as)i8.i64", T_intr)
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        dest_ptr_i64 = inttoptr!(builder, parameters(llvm_f)[1], T_pint64_dest)
        dest_ptr_i8 = bitcast!(builder, dest_ptr_i64, T_pint8_dest)

        call!(builder, intr, [dest_ptr_i8, parameters(llvm_f)[2], parameters(llvm_f)[3], ConstantInt(T_int1, 0)])
        ret!(builder)
    end
    call_function(llvm_f, Nothing, Tuple{DevicePtr{UInt8,DestAS},UInt8,LT}, :((dest_ptr, value, len)))
end
memset!(dest_ptr::DevicePtr{T,DestAS}, value::UInt8, len::Integer) where {T,DestAS} =
    memset!(convert(DevicePtr{UInt8,DestAS}, dest_ptr), value, UInt64(len))
