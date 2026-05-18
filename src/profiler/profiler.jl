module Profiler
    import AMDGPU: librocprofiler64v2

    include("librocprof.jl")

    version() = VersionNumber(rocprofiler_version_major(), rocprofiler_version_minor())
end
