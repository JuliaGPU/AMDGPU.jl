# The record of a kernel exception, in host memory shared by the kernels on a device. The
# first work-item to throw claims it by storing the kernel it belongs to, and then records
# where it threw; the host looks up what was thrown there (see `AMDGPU.throw_if_exception`).
struct ExceptionInfo
    # the handle of the kernel that threw, or 0 if none did
    kernel::UInt64
    # the throw site, see `GPUCompiler.uses_exception_sites`
    site::Int32
    workgroup::NTuple{3, Int32}
    workitem::NTuple{3, Int32}
end
ExceptionInfo() = ExceptionInfo(0, 0, (0, 0, 0), (0, 0, 0))

function alloc_exception_info()
    ei_ptr = Mem.HostBuffer(sizeof(ExceptionInfo), HIP.hipHostAllocDefault)
    unsafe_store!(convert(Ptr{ExceptionInfo}, ei_ptr), ExceptionInfo())
    return ei_ptr
end

# a pointer to a field of the exception record at `ei`
@inline @generated function exception_field(ei::Ptr{UInt64}, ::Val{field}) where {field}
    i = Base.fieldindex(ExceptionInfo, field)
    T = fieldtype(ExceptionInfo, i)
    return :(reinterpret(Ptr{$T}, ei + $(fieldoffset(ExceptionInfo, i))))
end

# the calling work-item has thrown at `site`, and its wavefront stops executing.
#
# nothing reachable from the throw overlays may throw, not even a checked conversion like
# `UInt64(0)`: the resulting inference cycle taints Base on Julia 1.12+ (#808)
@inline function signal_exception!(site::Int32)
    state = kernel_state()
    ei = state.exception_info
    claim = reinterpret(LLVMPtr{UInt64, AS.Generic}, exception_field(ei, Val(:kernel)))
    # the first writer wins; it is the only one to store the rest of the record
    if llvm_atomic_cas(claim, 0 % UInt64, reinterpret(UInt64, state.kernel)) == 0 % UInt64
        unsafe_store!(exception_field(ei, Val(:site)), site)
        wg = workgroupIdx()
        unsafe_store!(exception_field(ei, Val(:workgroup)),
                      (wg.x % Int32, wg.y % Int32, wg.z % Int32))
        wi = workitemIdx()
        unsafe_store!(exception_field(ei, Val(:workitem)),
                      (wi.x % Int32, wi.y % Int32, wi.z % Int32))
    end
    endpgm()
    return
end

# throw a device-side exception of type `name`, reported with `reason`
using GPUCompiler: @gputhrow
