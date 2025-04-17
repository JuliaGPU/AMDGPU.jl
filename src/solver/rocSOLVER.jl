module rocSOLVER

using CEnum: @cenum

using LinearAlgebra
using LinearAlgebra: Factorization, AbstractQ, QRCompactWY, QRCompactWYQ, QRPackedQ
using LinearAlgebra: BlasInt, BlasReal, BlasComplex, checksquare
using LinearAlgebra.LAPACK: chkargsok, chklapackerror, chktrans, chkside, chkdiag, chkuplo

using ..AMDGPU
import AMDGPU: librocsolver, HIP, rocBLAS
import AMDGPU: HandleCache, library_state, check, @check
import .HIP: HIPContext, HIPStream, hipContext_t, hipStream_t, hipEvent_t
import .rocBLAS: device_batch, rocblas_status, rocblas_handle, rocblas_side
import .rocBLAS: rocblas_half, rocblas_operation, rocblas_fill, rocblas_stride
import .rocBLAS: rocblas_int, rocblas_float_complex, rocblas_double_complex
import .rocBLAS: rocblas_float, rocblas_diagonal, rocblas_layer_mode

include("librocsolver.jl")
include("base.jl")
include("highlevel.jl")

end
