module rocFFT

import ..AMDGPU
import .AMDGPU: librocfft
import ..HIP: hipStream_t

using CEnum

include("librocfft_common.jl")
include("error.jl")
version() = VersionNumber(rocfft_version_major, rocfft_version_minor, rocfft_version_patch)

include("librocfft.jl")
include("util.jl")
include("fft.jl")

# TODO use TLS library state

if AMDGPU.functional(:rocfft)
    const INITIALIZED = Threads.Atomic{Int64}(0)
    @eval function rocfft_setup_once()
        if Threads.atomic_cas!(INITIALIZED, 0, 1) == 0
            rocfft_setup()
            atexit(rocfft_cleanup)
        end
    end
else
    @eval rocfft_setup_once() =
        throw(ArgumentError("rocFFT is not functional"))
end

end
