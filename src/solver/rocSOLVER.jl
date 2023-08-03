module rocSOLVER

using LinearAlgebra
using LinearAlgebra: Factorization, AbstractQ, QRCompactWY, QRCompactWYQ, QRPackedQ

using ..AMDGPU
import AMDGPU: librocsolver
import AMDGPU: HIP, rocBLAS
import AMDGPU: HandleCache, library_state, check
import .HIP: HIPContext, HIPStream, hipContext_t, hipStream_t, hipEvent_t
import .rocBLAS: rocblas_status, rocblas_handle, rocblas_side, rocblas_operation

include("librocsolver.jl")
include("highlevel.jl")

function version()
    len_ref = Ref{Csize_t}()
    rocsolver_get_version_string_size(len_ref) |> check
    len = len_ref[]

    buf = Vector{Cchar}(undef, len)
    rocsolver_get_version_string(buf, len) |> check
    str = unsafe_string(reinterpret(Cstring, pointer(buf)))

    VersionNumber(join(split(str, '.')[1:3], '.'))
end

end
