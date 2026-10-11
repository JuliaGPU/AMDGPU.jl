"Allocates on-device memory statically from the specified address space."
@llvmgenerated builder function alloc_special(
    ::Val{id}, ::Type{T}, ::Val{as}, ::Val{len}, ::Val{zeroinit} = Val{false}(),
)::LLVMPtr{T,as} where {id,T,as,len,zeroinit}
    eltyp = convert(LLVMType, T)

    # old versions of GPUArrays invoke _shmem with an integer id; make sure those are unique
    name = id
    if !isa(id, String) || !isa(id, Symbol)
        name = "alloc_special_$id"
    end
    if zeroinit
        name = "__zeroinit_" * name
    end

    T_ptr_i8 = convert(LLVMType, LLVMPtr{T,as})

    # create the global variable
    gv_typ = LLVM.ArrayType(eltyp, len)
    gv = GlobalVariable(current_module(builder), gv_typ, name, as)
    if len > 0
        if as == AS.Local
            gv.linkage = LLVM.API.LLVMExternalLinkage
            # NOTE: Backend doesn't support initializer for local AS
        elseif as == AS.Private
            gv.linkage = LLVM.API.LLVMInternalLinkage
            gv.initializer = null(gv_typ)
        end
    end

    # By requesting a larger-than-datatype alignment,
    # we might be able to vectorize.
    # TODO: Make the alignment configurable
    gv.alignment = Base.max(32, Base.datatype_alignment(T))

    # generate IR
    ptr_with_as = gep!(builder, gv_typ, gv, [ConstantInt(0), ConstantInt(0)])
    bitcast!(builder, ptr_with_as, T_ptr_i8)
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

# TODO docs
macro ROCDynamicLocalArray(T, dims, zeroinit=true, offset=0)
    zeroinit = zeroinit isa Expr ? zeroinit.args[1] : zeroinit
    @assert zeroinit isa Bool "@ROCDynamicLocalArray requires a constant `zeroinit` argument"

    @gensym id DA ptr
    quote
        let
            $ptr = $alloc_local(
                $(QuoteNode(Symbol(:ROCDynamicLocalArray_, id))),
                $(esc(T)), 0, $zeroinit)
            $DA = $ROCDeviceArray($(esc(dims)), $ptr + $(esc(offset)))
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

# TODO: Support various types of len
# NOTE: these shadow LLVM.Build's `memcpy!` and `memset!`, so use those qualified.
@llvmgenerated builder function memcpy!(dest_ptr::LLVMPtr{UInt8,DestAS}, src_ptr::LLVMPtr{UInt8,SrcAS}, len::LT)::Nothing where {DestAS,SrcAS,LT<:Union{Int64,UInt64}}
    LLVM.memcpy!(builder, dest_ptr, src_ptr, len)
    nothing
end
memcpy!(dest_ptr::LLVMPtr{T,DestAS}, src_ptr::LLVMPtr{T,SrcAS}, len::Integer) where {T,DestAS,SrcAS} =
    memcpy!(reinterpret(LLVMPtr{UInt8,DestAS}, dest_ptr), reinterpret(LLVMPtr{UInt8,SrcAS}, src_ptr), UInt64(len))
@llvmgenerated builder function memset!(dest_ptr::LLVMPtr{UInt8,DestAS}, value::UInt8, len::LT)::Nothing where {DestAS,LT<:Union{Int64,UInt64}}
    LLVM.memset!(builder, dest_ptr, value, len)
    nothing
end
memset!(dest_ptr::LLVMPtr{T,DestAS}, value::UInt8, len::Integer) where {T,DestAS} =
    memset!(convert(LLVMPtr{UInt8,DestAS}, dest_ptr), value, UInt64(len))
