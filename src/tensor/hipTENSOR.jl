module hipTENSOR

using AMDGPU
using GPUToolbox: @gcsafe_ccall, @checked, @enum_without_prefix, @debug_ccall
using AMDGPU: Mem

using BFloat16s: BFloat16
import AMDGPU: libhiptensor, HandleCache, HIP, library_state
import AMDGPU.Mem: alloc_or_retry!
import .HIP: HIPContext, HIPStream, hipStream_t

using CEnum: @cenum

using Printf: @printf

export has_hiptensor

has_hiptensor() = AMDGPU.functional(:hiptensor)

# core library
include("libhiptensor.jl")

# low-level wrappers
include("error.jl")
include("types.jl")
include("operations.jl")

# high-level integrations
include("interfaces.jl")


## handles

function create_handle()
    AMDGPU.functional(:hiptensor) || error("hipTENSOR is not available")

    handle_ref = Ref{hiptensorHandle_t}()
    hiptensorCreate(handle_ref)
    handle_ref[]
end

const IDLE_HANDLES = HandleCache{HIPContext,hiptensorHandle_t}()

lib_state() = library_state(
    :hipTENSOR, hiptensorHandle_t, IDLE_HANDLES,
    create_handle, hiptensorDestroy, (handle, stream) -> 0 )

handle() = lib_state().handle
stream() = lib_state().stream

function version()
    ver = hiptensorGetVersion()
    major = ver ÷ 10000
    minor = (ver ÷ 100) % 100
    patch = ver % 100
    return VersionNumber(join((major,minor,patch), "."))
end

end
