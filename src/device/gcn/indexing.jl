# Indexing and dimensions
export workitemIdx, workgroupIdx, workgroupDim, gridDim, gridDimWG
export threadIdx, blockIdx, blockDim

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

@generated function _dim(::Val{base}, ::Val{off}, ::Val{range}, ::Type{T}) where {base, off, range, T}
    T_int8 = LLVM.Int8Type(JuliaContext())
    T_int32 = LLVM.Int32Type(JuliaContext())
    _as = Base.libllvm_version < v"7.0" ? 2 : 4
    T_ptr_i8 = LLVM.PointerType(T_int8, _as)
    T_ptr_i32 = LLVM.PointerType(T_int32, _as)
    T_ptr_T = LLVM.PointerType(convert(LLVMType, T), _as)

    # create function
    llvm_f, _ = create_function(T_int32)
    mod = LLVM.parent(llvm_f)

    # generate IR
    Builder(JuliaContext()) do builder
        entry = BasicBlock(llvm_f, "entry", JuliaContext())
        position!(builder, entry)

        # get the kernel dispatch pointer
        intr_typ = LLVM.FunctionType(T_ptr_i8)
        intr = LLVM.Function(mod, "llvm.amdgcn.dispatch.ptr", intr_typ)
        ptr = call!(builder, intr)

        # load the index
        offset = base+((off-1)*sizeof(T))
        idx_ptr_i8 = inbounds_gep!(builder, ptr, [ConstantInt(offset,JuliaContext())])
        idx_ptr_T = bitcast!(builder, idx_ptr_i8, T_ptr_T)
        idx_T = load!(builder, idx_ptr_T)
        idx = zext!(builder, idx_T, T_int32)

        # attach range metadata
        range_metadata = MDNode([ConstantInt(T(range.start), JuliaContext()),
                                 ConstantInt(T(range.stop), JuliaContext())],
                                JuliaContext())
        metadata(idx_T)[LLVM.MD_range] = range_metadata
        ret!(builder, idx)
    end

    call_function(llvm_f, UInt32)
end

# TODO: look these up for the current agent/queue
const max_block_size = (x=1024, y=1024, z=1024)
const max_grid_size  = (x=65535, y=65535, z=65535)

for dim in (:x, :y, :z)
    # Workitem index
    fname = Symbol("workitem")
    fn = Symbol("workitemIdx_$dim")
    intr = Symbol("$dim")
    @eval @inline $fn() = Int(_index($(Val(fname)), $(Val(intr)), $(Val(0:max_block_size[dim])))) + 1
    cufn = Symbol("threadIdx_$dim")
    @eval @inline $cufn() = $fn()

    # Workgroup index
    fname = Symbol("workgroup")
    fn = Symbol("workgroupIdx_$dim")
    intr = Symbol("$dim")
    @eval @inline $fn() = Int(_index($(Val(fname)), $(Val(intr)), $(Val(0:max_grid_size[dim])))) + 1
    cufn = Symbol("blockIdx_$dim")
    @eval @inline $cufn() = $fn()
end
_packet_names = fieldnames(HSA.KernelDispatchPacket)
_packet_offsets = fieldoffset.(HSA.KernelDispatchPacket, 1:length(_packet_names))
for (dim,off) in ((:x,1), (:y,2), (:z,3))
    # Workitem dimension
    fn = Symbol("workgroupDim_$dim")
    base = _packet_offsets[findfirst(x->x==:workgroup_size_x,_packet_names)]
    @eval @inline $fn() = Int(_dim($(Val(base)), $(Val(off)), $(Val(0:max_block_size[dim])), UInt16))
    cufn = Symbol("blockDim_$dim")
    @eval @inline $cufn() = $fn()

    # Grid dimension (in workitems)
    fn = Symbol("gridDim_$dim")
    base = _packet_offsets[findfirst(x->x==:grid_size_x,_packet_names)]
    @eval @inline $fn() = Int(_dim($(Val(base)), $(Val(off)), $(Val(0:max_grid_size[dim])), UInt32))
    # Grid dimension (in workgroups)
    fn_wg = Symbol("gridDimWG_$dim")
    fn_wi_idx = Symbol("workitemIdx_$dim")
    @eval @inline $fn_wg() = $fn()/$fn_wi_idx()
end

@inline workitemIdx() = (x=workitemIdx_x(), y=workitemIdx_y(), z=workitemIdx_z())
@inline workgroupIdx() = (x=workgroupIdx_x(), y=workgroupIdx_y(), z=workgroupIdx_z())
@inline workgroupDim() = (x=workgroupDim_x(), y=workgroupDim_y(), z=workgroupDim_z())
@inline gridDim() = (x=gridDim_x(), y=gridDim_y(), z=gridDim_z())
@inline gridDimWG() = (x=gridDimWG_x(), y=gridDimWG_y(), z=gridDimWG_z())

# For compat with CUDAnative et. al

@inline threadIdx() = (x=threadIdx_x(), y=threadIdx_y(), z=threadIdx_z())
@inline blockIdx() = (x=blockIdx_x(), y=blockIdx_y(), z=blockIdx_z())
@inline blockDim() = (x=blockDim_x(), y=blockDim_y(), z=blockDim_z())
