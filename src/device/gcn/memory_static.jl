"Allocates on-device memory statically from the specified address space."
@generated function alloc_special(
    ::Val{id}, ::Type{T}, ::Val{as}, ::Val{len}, ::Val{zeroinit} = Val{false}(),
) where {id,T,as,len,zeroinit}
    @dispose ctx=Context() begin
        eltyp = convert(LLVMType, T; ctx)

        # old versions of GPUArrays invoke _shmem with an integer id; make sure those are unique
        if !isa(id, String) || !isa(id, Symbol)
            id = "alloc_special_$id"
        end
        if zeroinit
            id = "__zeroinit_" * id
        end

        T_ptr_i8 = convert(LLVMType, LLVMPtr{T,as}; ctx)

        # create a function
        llvm_f, _ = create_function(T_ptr_i8)

        # create the global variable
        mod = LLVM.parent(llvm_f)
        gv_typ = LLVM.ArrayType(eltyp, len)
        gv = GlobalVariable(mod, gv_typ, string(id), as)
        if len > 0
            if as == AS.Local
                linkage!(gv, LLVM.API.LLVMExternalLinkage)
                # NOTE: Backend doesn't support initializer for local AS
            elseif as == AS.Private
                linkage!(gv, LLVM.API.LLVMInternalLinkage)
                initializer!(gv, null(gv_typ))
            end
        end

        # By requesting a larger-than-datatype alignment,
        # we might be able to vectorize.
        # TODO: Make the alignment configurable
        alignment!(gv, Base.max(32, Base.datatype_alignment(T)))

        # generate IR
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            ptr_with_as = gep!(builder, gv_typ, gv,
                [ConstantInt(0; ctx), ConstantInt(0; ctx)])
            ptr = bitcast!(builder, ptr_with_as, T_ptr_i8)
            ret!(builder, ptr)
        end

        call_function(llvm_f, LLVMPtr{T,as})
    end
end

@inline alloc_local(id, T, len, zeroinit=false) =
    alloc_special(Val{id}(), T, Val{AS.Local}(), Val{len}(), Val{zeroinit}())
@inline alloc_scratch(id, T, len) =
    alloc_special(Val{id}(), T, Val{AS.Private}(), Val{len}(), Val{false}())

macro ROCStaticLocalArray(T, dims, zeroinit=true)
    zeroinit = zeroinit isa Expr ? zeroinit.args[1] : zeroinit
    @assert zeroinit isa Bool "@ROCStaticLocalArray requires a constant `zeroinit` argument"

    @gensym id len
    quote
        $len = prod($(esc(dims)))
        $ROCDeviceArray($(esc(dims)),
            $alloc_local($(QuoteNode(Symbol(:ROCStaticLocalArray_, id))),
            $(esc(T)), $len, $zeroinit))
    end
end

macro ROCDynamicLocalArray(T, dims, zeroinit=true)
    if Base.libllvm_version < v"14"
        @warn "@ROCDynamicLocalArray is unsupported on LLVM <14\nUndefined behavior may result"
    end

    zeroinit = zeroinit isa Expr ? zeroinit.args[1] : zeroinit
    @assert zeroinit isa Bool "@ROCDynamicLocalArray requires a constant `zeroinit` argument"

    @gensym id DA
    quote
        let
            $DA = $ROCDeviceArray($(esc(dims)),
                $alloc_local($(QuoteNode(Symbol(:ROCDynamicLocalArray_, id))),
                $(esc(T)), 0, $zeroinit))
            if $zeroinit
                # Zeroinit doesn't work at the compiler level for dynamic LDS
                # allocations, so zero it here
                for idx in 1:prod($(esc(dims)))
                    @inbounds $DA[idx] = zero($(esc(T)))
                end
                $sync_workgroup()
            end
            $DA
        end
    end
end

@inline @generated function alloc_string(::Val{str}) where str
    @dispose ctx=Context() begin
        T_pint8 = LLVM.PointerType(LLVM.Int8Type(ctx), AS.Global)
        llvm_f, _ = create_function(T_pint8)
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)
            str_ptr = globalstring_ptr!(builder, String(str))
            ptr = addrspacecast!(builder, str_ptr, T_pint8)
            ret!(builder, ptr)
        end
        call_function(llvm_f, LLVMPtr{UInt8,AS.Global})
    end
end

# TODO: Support various types of len
@inline @generated function memcpy!(dest_ptr::LLVMPtr{UInt8,DestAS}, src_ptr::LLVMPtr{UInt8,SrcAS}, len::LT) where {DestAS,SrcAS,LT<:Union{Int64,UInt64}}
    @dispose ctx=Context() begin
        T_nothing = LLVM.VoidType(ctx)
        T_pint8_dest = convert(LLVMType, dest_ptr; ctx)
        T_pint8_src = convert(LLVMType, src_ptr; ctx)
        T_int64 = convert(LLVMType, len; ctx)
        T_int1 = LLVM.Int1Type(ctx)

        llvm_f, _ = create_function(T_nothing, [T_pint8_dest, T_pint8_src, T_int64])
        mod = LLVM.parent(llvm_f)
        T_intr = LLVM.FunctionType(T_nothing, [T_pint8_dest, T_pint8_src, T_int64, T_int1])
        intr = LLVM.Function(mod, "llvm.memcpy.p$(DestAS)i8.p$(SrcAS)i8.i64", T_intr)
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            dest_ptr_i8 = parameters(llvm_f)[1]
            src_ptr_i8  = parameters(llvm_f)[2]
            call!(builder, T_intr, intr, [dest_ptr_i8, src_ptr_i8, parameters(llvm_f)[3], ConstantInt(T_int1, 0)])
            ret!(builder)
        end
        call_function(llvm_f, Nothing, Tuple{LLVMPtr{UInt8,DestAS},LLVMPtr{UInt8,SrcAS},LT}, :dest_ptr, :src_ptr, :len)
    end
end
memcpy!(dest_ptr::LLVMPtr{T,DestAS}, src_ptr::LLVMPtr{T,SrcAS}, len::Integer) where {T,DestAS,SrcAS} =
    memcpy!(reinterpret(LLVMPtr{UInt8,DestAS}, dest_ptr), reinterpret(LLVMPtr{UInt8,SrcAS}, src_ptr), UInt64(len))
@inline @generated function memset!(dest_ptr::LLVMPtr{UInt8,DestAS}, value::UInt8, len::LT) where {DestAS,LT<:Union{Int64,UInt64}}
    @dispose ctx=Context() begin
        T_nothing = LLVM.VoidType(ctx)
        T_pint8_dest = convert(LLVMType, dest_ptr; ctx)
        T_int8 = convert(LLVMType, value; ctx)
        T_int64 = convert(LLVMType, len; ctx)
        T_int1 = LLVM.Int1Type(ctx)

        llvm_f, _ = create_function(T_nothing, [T_pint8_dest, T_int8, T_int64])
        mod = LLVM.parent(llvm_f)
        T_intr = LLVM.FunctionType(T_nothing, [T_pint8_dest, T_int8, T_int64, T_int1])
        intr = LLVM.Function(mod, "llvm.memset.p$(DestAS)i8.i64", T_intr)
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            call!(builder, T_intr, intr, [parameters(llvm_f)[1], parameters(llvm_f)[2], parameters(llvm_f)[3], ConstantInt(T_int1, 0)])
            ret!(builder)
        end
        call_function(llvm_f, Nothing, Tuple{LLVMPtr{UInt8,DestAS},UInt8,LT}, :dest_ptr, :value, :len)
    end
end
memset!(dest_ptr::LLVMPtr{T,DestAS}, value::UInt8, len::Integer) where {T,DestAS} =
    memset!(convert(LLVMPtr{UInt8,DestAS}, dest_ptr), value, UInt64(len))
