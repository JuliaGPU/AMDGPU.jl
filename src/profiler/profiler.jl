module Profiler
    using AMDGPU: AMDGPU, librocprofiler_sdk_tool, @check

    const ROCPROFILER_UINT64_C = UInt64
    const ROCPROFILER_CONTEXT_NONE = typemax(UInt64)
    const hipCpuDeviceId = Cint(-1)
    const hipInvalidDeviceId = Cint(-2)
    __ushort_as_half(x::Cushort) = reinterpret(Float16, x)
    const NULL = C_NULL
    const INT_MIN = typemin(Cint)

    include("librocprof.jl")

    function version()
        major, minor, patch = Ref{UInt32}(), Ref{UInt32}(), Ref{UInt32}()
        @check rocprofiler_get_version(major, minor, patch)
        return VersionNumber(major[], minor[], patch[])
    end

    struct rocProfilerException <: Exception
        status::rocprofiler_status_t
    end

    function Base.showerror(io::IO, exception::rocProfilerException)
        print(io, """
        MIOpenException:
        - status: $(exception.status)
        """)
    end

    function AMDGPU.check(status::rocprofiler_status_t)
        if status != ROCPROFILER_STATUS_SUCCESS
            throw(rocProfilerException(status))
        end
    end
end
