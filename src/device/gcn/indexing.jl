# Indexing and dimensions

# LLVM's !range is half-open [lo, hi); the ranges below are inclusive.
function _range_metadata(::Type{T}, range) where T
    lo = T(range.start)
    hi = T(range.stop) + one(T)
    lo == hi && return nothing
    return MDNode([ConstantInt(lo), ConstantInt(hi)])
end

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
            md = _range_metadata(UInt32, range)
            md === nothing || (metadata(idx)[LLVM.MD_range] = md)
            ret!(builder, idx)
        end

        call_function(llvm_f, UInt32)
    end
end

# Workgroup/grid dimensions come from the *hidden kernel arguments* (code object
# v5+): the runtime writes hidden_block_count_{x,y,z} (u32 at 0/4/8) and
# hidden_group_size_{x,y,z} (u16 at 12/14/16) into the kernarg segment after the
# explicit arguments, and `llvm.amdgcn.implicitarg.ptr` points at that block.
const _hidden_block_count_offset = 0    # u32 × 3
const _hidden_group_size_offset  = 12   # u16 × 3

@device_function @generated function _dim(::Val{offset}, ::Type{T}, ::Val{range}) where {offset, T, range}
    @dispose ctx=Context() begin
        T_int8 = LLVM.Int8Type()
        T_int32 = LLVM.Int32Type()

        _as = convert(Int, AS.Constant)
        T_ptr_i8 = LLVM.PointerType(T_int8, _as)

        T_T = convert(LLVMType, T)
        T_ptr_T = LLVM.PointerType(T_T, _as)

        # create function
        llvm_f, _ = create_function(T_int32)
        mod = LLVM.parent(llvm_f)

        # generate IR
        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            position!(builder, entry)

            # get the implicit (hidden) kernel argument pointer
            intr_typ = LLVM.FunctionType(T_ptr_i8)
            intr = LLVM.Function(mod, "llvm.amdgcn.implicitarg.ptr", intr_typ)
            ptr = call!(builder, intr_typ, intr)

            # load the field
            idx_ptr_i8 = inbounds_gep!(builder, T_int8, ptr, [ConstantInt(offset)])
            idx_ptr_T = bitcast!(builder, idx_ptr_i8, T_ptr_T)
            idx_T = load!(builder, T_T, idx_ptr_T)
            # the hidden block is at least 4-byte aligned; tell LLVM so the
            # backend keeps merged accesses SMEM-selectable
            alignment!(idx_T, gcd(4, offset))
            idx = zext!(builder, idx_T, T_int32)

            # attach range metadata; the hidden arguments never change during
            # a dispatch
            md = _range_metadata(T, range)
            md === nothing || (metadata(idx_T)[LLVM.MD_range] = md)
            metadata(idx_T)[LLVM.MD_invariant_load] = MDNode(LLVM.Metadata[])
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
    # N.B. These are sizes, so the range runs 1:max, not 0:(max - 1).
    # Workgroup dimension (in workitems): hidden_group_size_{x,y,z}
    fn = Symbol("workgroupDim_$dim")
    @eval @device_function @inline $fn() = _dim($(Val(_hidden_group_size_offset + 2 * (off - 1))), UInt16,
                                                $(Val(1:_max_group_size)))
    cufn = Symbol("blockDim_$dim")
    @eval @device_function @inline $cufn() = $fn()

    # Grid dimension (in workgroups): hidden_block_count_{x,y,z}
    fn_wg = Symbol("gridGroupDim_$dim")
    @eval @device_function @inline $fn_wg() = _dim($(Val(_hidden_block_count_offset + 4 * (off - 1))), UInt32,
                                                   $(Val(1:_max_groups[dim])))

    # Grid dimension (in workitems). Launches are always whole workgroups, so
    # this equals the dispatch packet's grid_size.
    fn_it = Symbol("gridItemDim_$dim")
    @eval @device_function @inline $fn_it() = $fn_wg() * $fn()
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
