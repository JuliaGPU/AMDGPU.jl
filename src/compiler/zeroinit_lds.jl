function zeroinit_lds!(mod::LLVM.Module, entry::LLVM.Function)
    if entry.callconv != LLVM.CallConv.AMDGPUKERNEL
        return entry
    end

    to_init = []
    for gbl in mod.globals
        if startswith(gbl.name, "__zeroinit")
            as = gbl.value_type.addrspace
            if as == AMDGPU.Device.AS.Local
                sz = LLVM.storage_size(mod.datalayout, gbl.global_value_type)
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
