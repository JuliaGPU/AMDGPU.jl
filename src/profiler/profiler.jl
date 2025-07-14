module Profiler
    import AMDGPU: librocprofiler_sdk_tool
    const ROCPROFILER_UINT64_C = UInt64
    const ROCPROFILER_CONTEXT_NONE = typemax(UInt64)
    const hipCpuDeviceId = Cint(-1)
    const hipInvalidDeviceId = Cint(-2)
    __ushort_as_half(x::Cushort) = reinterpret(Float16, x)
    const NULL = C_NULL
    const INT_MIN = typemin(Cint)

    include("librocprof.jl")

    version() = VersionNumber(ROCPROFILER_VERSION_MAJOR, ROCPROFILER_VERSION_MINOR, ROCPROFILER_VERSION_PATCH)
end
