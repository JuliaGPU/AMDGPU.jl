# Indexing and dimensions

@device_function @generated function _index(::Val{fname}, ::Val{name}, ::Val{range}) where {fname, name, range}
    @dispose ctx=Context() begin
        T_int32 = LLVM.Int32Type()

        # create function
        llvm_f, _ = create_function(T_int32)
        mod = LLVM.parent(llvm_f)

        # generate IR
        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            position!(builder, entry)

            # call the indexing intrinsic
            intr_typ = LLVM.FunctionType(T_int32)
            intr = LLVM.Function(mod, "llvm.amdgcn.$fname.id.$name", intr_typ)
            idx = call!(builder, intr_typ, intr)

            # attach range metadata
            metadata(idx)[LLVM.MD_range] = MDNode([
                ConstantInt(UInt32(range.start)),
                ConstantInt(UInt32(range.stop))])
            ret!(builder, idx)
        end

        call_function(llvm_f, UInt32)
    end
end

@device_function @generated function _dim(::Val{base}, ::Val{off}, ::Val{range}, ::Type{T}) where {base, off, range, T}
    @dispose ctx=Context() begin
        T_int8 = LLVM.Int8Type()
        T_int32 = LLVM.Int32Type()

        _as = convert(Int, AS.Constant)
        T_ptr_i8 = LLVM.PointerType(T_int8, _as)
        T_ptr_i32 = LLVM.PointerType(T_int32, _as)

        T_T = convert(LLVMType, T)
        T_ptr_T = LLVM.PointerType(T_T, _as)

        # create function
        llvm_f, _ = create_function(T_int32)
        mod = LLVM.parent(llvm_f)

        # generate IR
        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            position!(builder, entry)

            # get the kernel dispatch pointer
            intr_typ = LLVM.FunctionType(T_ptr_i8)
            intr = LLVM.Function(mod, "llvm.amdgcn.dispatch.ptr", intr_typ)
            ptr = call!(builder, intr_typ, intr)

            # load the index
            offset = base + ((off - 1) * aligned_sizeof(T))
            if aligned_sizeof(T) < 4
                # Load the aligned dword containing the field and extract it
                # with shift/mask. SMEM has no sub-dword loads, so whether a
                # bare i16 load of the dispatch packet is widened to an
                # s_load_dword depends on the surrounding use pattern (e.g. a
                # zext to i64 -- Julia's default integer arithmetic --
                # defeats it); the VMEM fallback is a per-wave read of
                # uncached fine-grained queue memory that stalls every wave
                # at kernel entry. A dword-aligned dword load is always
                # SMEM-selectable.
                byte = offset % 4
                @assert byte + aligned_sizeof(T) <= 4 "packet field straddles a dword boundary"
                idx_ptr_i8 = inbounds_gep!(builder, T_int8, ptr, [ConstantInt(offset - byte)])
                idx_ptr_i32 = bitcast!(builder, idx_ptr_i8, T_ptr_i32)
                word = load!(builder, T_int32, idx_ptr_i32)
                metadata(word)[LLVM.MD_invariant_load] = MDNode(LLVM.Metadata[])
                idx = word
                if byte != 0
                    idx = lshr!(builder, idx, ConstantInt(Int32(8 * byte)))
                end
                mask = (Int64(1) << (8 * aligned_sizeof(T))) - 1
                idx = and!(builder, idx, ConstantInt(Int32(mask)))
                ret!(builder, idx)
            else
                idx_ptr_i8 = inbounds_gep!(builder, T_int8, ptr, [ConstantInt(offset)])
                idx_ptr_T = bitcast!(builder, idx_ptr_i8, T_ptr_T)
                idx_T = load!(builder, T_T, idx_ptr_T)
                idx = zext!(builder, idx_T, T_int32)

                # attach range metadata
                metadata(idx_T)[LLVM.MD_range] = MDNode([
                    ConstantInt(T(range.start)),
                    ConstantInt(T(range.stop))])
                metadata(idx_T)[LLVM.MD_invariant_load] = MDNode(LLVM.Metadata[])
                ret!(builder, idx)
            end
        end

        call_function(llvm_f, UInt32)
    end
end

# TODO: look these up for the current device/queue
# TODO: grids can be up to typemax(UInt64)
const _max_group_size = 1024
const _max_groups     = (x=typemax(UInt32), y=typemax(UInt32), z=typemax(UInt32))
const _max_grid_size  = (x=typemax(UInt32), y=typemax(UInt32), z=typemax(UInt32))

for dim in (:x, :y, :z)
    intr = Symbol("$dim")

    # Workitem index
    fname, fn = Symbol("workitem"), Symbol("workitemIdx_$dim")
    @eval @device_function @inline $fn() = _index($(Val(fname)), $(Val(intr)), $(Val(0:(_max_group_size - 1)))) + 0x1
    cufn = Symbol("threadIdx_$dim")
    @eval @device_function @inline $cufn() = $fn()

    # Workgroup index
    fname, fn = Symbol("workgroup"), Symbol("workgroupIdx_$dim")
    @eval @device_function @inline $fn() = _index($(Val(fname)), $(Val(intr)), $(Val(0:(_max_groups[dim] - 1)))) + 0x1
    cufn = Symbol("blockIdx_$dim")
    @eval @device_function @inline $cufn() = $fn()
end
for (dim,off) in ((:x,1), (:y,2), (:z,3))
    # Workgroup dimension (in workitems)
    fn = Symbol("workgroupDim_$dim")
    base = _packet_offsets[findfirst(x->x==:workgroup_size_x,_packet_names)]
    @eval @device_function @inline $fn() = _dim($(Val(base)), $(Val(off)), $(Val(0:(_max_group_size - 1))), UInt16)
    cufn = Symbol("blockDim_$dim")
    @eval @device_function @inline $cufn() = $fn()

    # Grid dimension (in workitems)
    fn = Symbol("gridItemDim_$dim")
    base = _packet_offsets[findfirst(x->x==:grid_size_x,_packet_names)]
    @eval @device_function @inline $fn() = _dim($(Val(base)), $(Val(off)), $(Val(0:(_max_grid_size[dim] - 1))), UInt32)
    # Grid dimension (in workgroups)
    fn_wg = Symbol("gridGroupDim_$dim")
    fn_wg_dim = Symbol("workgroupDim_$dim")
    # N.B. Don't use div to avoid inserting an exception path
    @eval @device_function @inline $fn_wg() = Core.Intrinsics.udiv_int($fn(), $fn_wg_dim())
end

"""
    workitemIdx()::ROCDim3

Returns the work item index within the work group.
See also: [`threadIdx`](@ref)
"""
@device_function @inline workitemIdx() = (x=workitemIdx_x(), y=workitemIdx_y(), z=workitemIdx_z())

"""
    workgroupIdx()::ROCDim3

Returns the work group index.
See also: [`blockIdx`](@ref)
"""
@device_function @inline workgroupIdx() = (x=workgroupIdx_x(), y=workgroupIdx_y(), z=workgroupIdx_z())

"""
    workgroupDim()::ROCDim3

Returns the size of each workgroup in workitems.
See also: [`blockDim`](@ref)
"""
@device_function @inline workgroupDim() = (x=workgroupDim_x(), y=workgroupDim_y(), z=workgroupDim_z())

"""
    gridItemDim()::ROCDim3

Returns the size of the grid in workitems.
This behaviour is different from CUDA where `gridDim` gives the size of the grid in blocks.
"""
@device_function @inline gridItemDim() = (x=gridItemDim_x(), y=gridItemDim_y(), z=gridItemDim_z())

"""
    gridGroupDim()::ROCDim3

Returns the size of the grid in workgroups.
This is equivalent to CUDA's `gridDim`.
"""
@device_function @inline gridGroupDim() = (x=gridGroupDim_x(), y=gridGroupDim_y(), z=gridGroupDim_z())

# For compat with CUDAnative et. al

"""
    threadIdx()::ROCDim3

Returns the thread index within the block.
See also: [`workitemIdx`](@ref)
"""
@device_function @inline threadIdx() = (x=threadIdx_x(), y=threadIdx_y(), z=threadIdx_z())

"""
    blockIdx()::ROCDim3

Returns the block index within the grid.
See also: [`workgroupIdx`](@ref)
"""
@device_function @inline blockIdx() = (x=blockIdx_x(), y=blockIdx_y(), z=blockIdx_z())

"""
    blockDim()::ROCDim3

Returns the dimensions of the block.
See also: [`workgroupDim`](@ref)
"""
@device_function @inline blockDim() = (x=blockDim_x(), y=blockDim_y(), z=blockDim_z())
