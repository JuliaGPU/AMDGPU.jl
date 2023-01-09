# Indexing and dimensions

@generated function _index(::Val{fname}, ::Val{name}, ::Val{range}) where {fname, name, range}
    Context() do ctx
        T_int32 = LLVM.Int32Type(ctx)

        # create function
        llvm_f, _ = create_function(T_int32)
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # call the indexing intrinsic
            intr_typ = LLVM.FunctionType(T_int32)
            intr = LLVM.Function(mod, "llvm.amdgcn.$fname.id.$name", intr_typ)
            idx = call!(builder, intr)

            # attach range metadata
            range_metadata = MDNode([ConstantInt(UInt32(range.start); ctx),
                                     ConstantInt(UInt32(range.stop); ctx)];
                                    ctx)
            metadata(idx)[LLVM.MD_range] = range_metadata
            ret!(builder, idx)
        end

        call_function(llvm_f, UInt32)
    end
end

@generated function _dim(::Val{base}, ::Val{off}, ::Val{range}, ::Type{T}) where {base, off, range, T}
    Context() do ctx
        T_int8 = LLVM.Int8Type(ctx)
        T_int32 = LLVM.Int32Type(ctx)
        _as = convert(Int, AS.Constant)
        T_ptr_i8 = LLVM.PointerType(T_int8, _as)
        T_ptr_i32 = LLVM.PointerType(T_int32, _as)
        T_ptr_T = LLVM.PointerType(convert(LLVMType, T; ctx), _as)

        # create function
        llvm_f, _ = create_function(T_int32)
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # get the kernel dispatch pointer
            intr_typ = LLVM.FunctionType(T_ptr_i8)
            intr = LLVM.Function(mod, "llvm.amdgcn.dispatch.ptr", intr_typ)
            ptr = call!(builder, intr)

            # load the index
            offset = base+((off-1)*sizeof(T))
            idx_ptr_i8 = inbounds_gep!(builder, ptr, [ConstantInt(offset; ctx)])
            idx_ptr_T = bitcast!(builder, idx_ptr_i8, T_ptr_T)
            idx_T = load!(builder, idx_ptr_T)
            idx = zext!(builder, idx_T, T_int32)

            # attach range metadata
            range_metadata = MDNode([ConstantInt(T(range.start); ctx),
                                     ConstantInt(T(range.stop); ctx)];
                                    ctx)
            metadata(idx_T)[LLVM.MD_range] = range_metadata
            ret!(builder, idx)
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
    @eval @inline $fn() = _index($(Val(fname)), $(Val(intr)), $(Val(0:(_max_group_size - 1)))) + 0x1
    cufn = Symbol("threadIdx_$dim")
    @eval @inline $cufn() = $fn()

    # Workgroup index
    fname, fn = Symbol("workgroup"), Symbol("workgroupIdx_$dim")
    @eval @inline $fn() = _index($(Val(fname)), $(Val(intr)), $(Val(0:(_max_groups[dim] - 1)))) + 0x1
    cufn = Symbol("blockIdx_$dim")
    @eval @inline $cufn() = $fn()
end
for (dim,off) in ((:x,1), (:y,2), (:z,3))
    # Workgroup dimension (in workitems)
    fn = Symbol("workgroupDim_$dim")
    base = _packet_offsets[findfirst(x->x==:workgroup_size_x,_packet_names)]
    @eval @inline $fn() = _dim($(Val(base)), $(Val(off)), $(Val(0:(_max_group_size - 1))), UInt16)
    cufn = Symbol("blockDim_$dim")
    @eval @inline $cufn() = $fn()

    # Grid dimension (in workitems)
    fn = Symbol("gridItemDim_$dim")
    base = _packet_offsets[findfirst(x->x==:grid_size_x,_packet_names)]
    @eval @inline $fn() = _dim($(Val(base)), $(Val(off)), $(Val(0:(_max_grid_size[dim] - 1))), UInt32)
    # Grid dimension (in workgroups)
    fn_wg = Symbol("gridGroupDim_$dim")
    fn_wg_dim = Symbol("workgroupDim_$dim")
    # N.B. Don't use div to avoid inserting an exception path
    @eval @inline $fn_wg() = Core.Intrinsics.udiv_int($fn(), $fn_wg_dim())
end

"""
    workitemIdx()::ROCDim3

Returns the work item index within the work group.
See also: [`threadIdx`](@ref)
"""
@inline workitemIdx() = (x=workitemIdx_x(), y=workitemIdx_y(), z=workitemIdx_z())

"""
    workgroupIdx()::ROCDim3

Returns the work group index.
See also: [`blockIdx`](@ref)
"""
@inline workgroupIdx() = (x=workgroupIdx_x(), y=workgroupIdx_y(), z=workgroupIdx_z())

"""
    workgroupDim()::ROCDim3

Returns the size of each workgroup in workitems.
See also: [`blockDim`](@ref)
"""
@inline workgroupDim() = (x=workgroupDim_x(), y=workgroupDim_y(), z=workgroupDim_z())

"""
    gridItemDim()::ROCDim3

Returns the size of the grid in workitems.
This behaviour is different from CUDA where `gridDim` gives the size of the grid in blocks.
"""
@inline gridItemDim() = (x=gridItemDim_x(), y=gridItemDim_y(), z=gridItemDim_z())

"""
    gridGroupDim()::ROCDim3

Returns the size of the grid in workgroups.
This is equivalent to CUDA's `gridDim`.
"""
@inline gridGroupDim() = (x=gridGroupDim_x(), y=gridGroupDim_y(), z=gridGroupDim_z())

# For compat with CUDAnative et. al

"""
    threadIdx()::ROCDim3

Returns the thread index within the block.
See also: [`workitemIdx`](@ref)
"""
@inline threadIdx() = (x=threadIdx_x(), y=threadIdx_y(), z=threadIdx_z())

"""
    blockIdx()::ROCDim3

Returns the block index within the grid.
See also: [`workgroupIdx`](@ref)
"""
@inline blockIdx() = (x=blockIdx_x(), y=blockIdx_y(), z=blockIdx_z())

"""
    blockDim()::ROCDim3

Returns the dimensions of the block.
See also: [`workgroupDim`](@ref)
"""
@inline blockDim() = (x=blockDim_x(), y=blockDim_y(), z=blockDim_z())
