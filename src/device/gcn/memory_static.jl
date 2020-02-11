export alloc_special

"Allocates on-device memory statically from the specified address space."
@generated function alloc_special(::Val{id}, ::Type{T}, ::Val{as}, ::Val{len}=Val(0)) where {id,T,as,len}
    eltyp = convert(LLVMType, T)

    # old versions of GPUArrays invoke _shmem with an integer id; make sure those are unique
    if !isa(id, String) || !isa(id, Symbol)
        id = "shmem$id"
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
