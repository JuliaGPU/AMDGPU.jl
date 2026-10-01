# Calculate the size of an LLVM type.
llvmsize(::LLVM.HalfType) = sizeof(Float16)
llvmsize(::LLVM.FloatType) = sizeof(Float32)
llvmsize(::LLVM.DoubleType) = sizeof(Float64)
function llvmsize(::LLVM.IntegerType)
    div(Int(LLVM.GenericValue(LLVM.Int128Type(), -1).intwidth), 8)
end

llvmsize(ty::LLVM.ArrayType) = ty.length * llvmsize(ty.element_type)
llvmsize(ty::LLVM.StructType) = ispacked(ty) ?
    sum(llvmsize(elem) for elem in ty.elements) :
    8 * length(ty.elements) # FIXME: Properly determine non-packed sizing
llvmsize(ty::LLVM.PointerType) = div(Sys.WORD_SIZE, 8)
llvmsize(ty::LLVM.VectorType) = ty.length
llvmsize(ty) = error("Unknown size for type: $ty, typeof: $(typeof(ty))")

function zeroinit_lds!(mod::LLVM.Module, entry::LLVM.Function)
    if entry.callconv != LLVM.CallConv.AMDGPUKERNEL
        return entry
    end

    to_init = []
    for gbl in mod.globals
        if startswith(gbl.name, "__zeroinit")
            as = gbl.value_type.addrspace
            if as == AMDGPU.Device.AS.Local
                sz = llvmsize(gbl.global_value_type)
                push!(to_init, (gbl, sz))
            end
        end
    end
    isempty(to_init) && return entry

    @dispose builder=IRBuilder() begin
        # Make these the first operations we do.
        instruction = first(entry.entry.instructions)
        position!(builder, LLVM.before(instruction))

        # Use memset to clear all values to 0.
        for (gbl, sz) in to_init
            sz == 0 && continue
            LLVM.memset!(builder, gbl,
                ConstantInt(UInt8(0)), ConstantInt(sz), gbl.alignment)
        end

        # Synchronize the workgroup to prevent races.
        sync_f = LLVM.Function(mod, Intrinsic("llvm.amdgcn.s.barrier"))
        call!(builder, sync_f.function_type, sync_f)
    end
    return entry
end
