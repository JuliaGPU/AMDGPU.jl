# Indexing and dimensions

export workitemIdx, workgroupIdx
export threadIdx, blockIdx

@generated function _index(::Val{fname}, ::Val{name}, ::Val{range}) where {fname, name, range}
    T_int32 = LLVM.Int32Type(JuliaContext())

    # create function
    llvm_f, _ = create_function(T_int32)
    mod = LLVM.parent(llvm_f)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        # call the indexing intrinsic
        intr_typ = LLVM.FunctionType(T_int32)
        intr = LLVM.Function(mod, "llvm.amdgcn.$fname.id.$name", intr_typ)
        idx = call!(builder, intr)

        # attach range metadata
        range_metadata = MDNode([ConstantInt(Int32(range.start), JuliaContext()),
                                 ConstantInt(Int32(range.stop), JuliaContext())],
                                JuliaContext())
        metadata(idx)[LLVM.MD_range] = range_metadata

        ret!(builder, idx)
    end

    call_function(llvm_f, UInt32)
end

# TODO: look these up for the current agent/queue
const max_block_size = (x=1024, y=1024, z=1024)
const max_grid_size  = (x=2147483647, y=65535, z=65535)

for dim in (:x, :y, :z)
    # Workitem index
    fname = Symbol("workitem")
    fn = Symbol("workitemIdx_$dim")
    intr = Symbol("$dim")
    @eval @inline $fn() = Int(_index($(Val(fname)), $(Val(intr)), $(Val(0:max_block_size[dim])))) + 1

    # Workgroup index
    fname = Symbol("workgroup")
    fn = Symbol("workgroupIdx_$dim")
    intr = Symbol("$dim")
    @eval @inline $fn() = Int(_index($(Val(fname)), $(Val(intr)), $(Val(0:max_block_size[dim])))) + 1
end

@inline workitemIdx() = (x=workitemIdx_x(), y=workitemIdx_y(), z=workitemIdx_z())
@inline workgroupIdx() = (x=workgroupIdx_x(), y=workgroupIdx_y(), z=workgroupIdx_z())

# For compat with CUDAnative et. al

@inline threadIdx() = (x=workitemIdx_x(), y=workitemIdx_y(), z=workitemIdx_z())
@inline blockIdx() = (x=workgroupIdx_x(), y=workgroupIdx_y(), z=workgroupIdx_z())
