# Calculate the size of an LLVM type.
llvmsize(::LLVM.LLVMHalf) = sizeof(Float16)
llvmsize(::LLVM.LLVMFloat) = sizeof(Float32)
llvmsize(::LLVM.LLVMDouble) = sizeof(Float64)
function llvmsize(::LLVM.IntegerType)
    div(Int(intwidth(GenericValue(LLVM.Int128Type(), -1))), 8)
end

llvmsize(ty::LLVM.ArrayType) = length(ty) * llvmsize(eltype(ty))
llvmsize(ty::LLVM.StructType) = ispacked(ty) ?
    sum(llvmsize(elem) for elem in elements(ty)) :
    8 * length(elements(ty)) # FIXME: Properly determine non-packed sizing
llvmsize(ty::LLVM.PointerType) = div(Sys.WORD_SIZE, 8)
llvmsize(ty::LLVM.VectorType) = size(ty)
llvmsize(ty) = error("Unknown size for type: $ty, typeof: $(typeof(ty))")

function zeroinit_lds!(mod::LLVM.Module, entry::LLVM.Function)
    if LLVM.callconv(entry) != LLVM.API.LLVMAMDGPUKERNELCallConv
        return entry
    end

    to_init = []
    for gbl in LLVM.globals(mod)
        if startswith(LLVM.name(gbl), "__zeroinit")
            as = LLVM.addrspace(value_type(gbl))
            if as == AMDGPU.Device.AS.Local
                push!(to_init, gbl)
            end
        end
    end
    isempty(to_init) && return entry

    @dispose builder=IRBuilder() begin
        # Make these the first operations we do.
        block = first(LLVM.blocks(entry))
        instruction = first(LLVM.instructions(block))
        position!(builder, instruction)

        # Use memset to clear all values to 0.
        for gbl in to_init
            sz = llvmsize(eltype(value_type(gbl)))
            sz == 0 && continue

            LLVM.memset!(builder, gbl,
                ConstantInt(UInt8(0)), ConstantInt(sz),
                LLVM.alignment(gbl))
        end

        # Synchronize the workgroup to prevent races.
        sync_ft = LLVM.FunctionType(LLVM.VoidType())
        sync_f = LLVM.Function(mod, "llvm.amdgcn.s.barrier", sync_ft)
        call!(builder, sync_ft, sync_f)
    end
    return entry
end
