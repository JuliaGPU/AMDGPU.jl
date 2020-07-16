# wrapper.jl
#
# "High level" blas interface to rocblas.
# Modeled from julia/src/base/linalg/blas.jl
# Modified from CuArrays/src/blas/wrapper.jl
#
# Author: Nick Henderson <nwh@stanford.edu>
# Created: 2014-08-26
# License: MIT
#

# Utility functions

# convert Char {N,T,C} to rocblas_operation_t
function rocblasop(trans::Char)
    if trans == 'N'
        return ROCBLAS_OPERATION_NONE
    end
    if trans == 'T'
        return ROCBLAS_OPERATION_TRANSPOSE
    end
    if trans == 'C'
        return ROCBLAS_OPERATION_CONJUGATE_TRANSPOSE
    end
    throw(ArgumentError("unknown rocblas operation $trans"))
end

# convert Char {U,L} to rocblas_fill_t
function rocblasfill(uplo::Char)
    if uplo == 'U'
        return ROCBLAS_FILL_UPPER
    end
    if uplo == 'L'
        return ROCBLAS_FILL_LOWER
    end
    throw(ArgumentError("unknown rocblas fill mode $uplo"))
end

# convert Char {U,N} to rocblas_diagonal_t
function rocblasdiag(diag::Char)
    if diag == 'U'
        return ROCBLAS_DIAGONAL_UNIT
    end
    if diag == 'N'
        return ROCBLAS_DIAGONAL_NON_UNIT
    end
    throw(ArgumentError("unknown rocblas diag mode $diag"))
end

# convert Char {L,R} to rocblas_side_t
function rocblasside(side::Char)
    if side == 'L'
        return ROCBLAS_SIDE_LEFT
    end
    if side == 'R'
        return ROCBLAS_SIDE_RIGHT
    end
    throw(ArgumentError("unknown rocblas side mode $side"))
end

# Level 1
## copy
for (fname, elty) in ((:rocblas_dcopy,:Float64),
                      (:rocblas_scopy,:Float32),
                      (:rocblas_zcopy,:ComplexF64),
                      (:rocblas_ccopy,:ComplexF32))
    @eval begin
        # SUBROUTINE DCOPY(N,DX,INCX,DY,INCY)
        function blascopy!(n::Integer,
                           DX::ROCArray{$elty},
                           incx::Integer,
                           DY::ROCArray{$elty},
                           incy::Integer)
              @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                           (rocblas_handle, Cint, Ptr{$elty}, Cint,
                            Ptr{$elty}, Cint),
                           handle(), n, DX, incx, DY, incy)
            DY
        end
    end
end

## scal
for (fname, elty) in ((:rocblas_dscal,:Float64),
                      (:rocblas_sscal,:Float32),
                      (:rocblas_zscal,:ComplexF64),
                      (:rocblas_cscal,:ComplexF32))
    @eval begin
        # SUBROUTINE DSCAL(N,DA,DX,INCX)
        function scal!(n::Integer,
                       DA::$elty,
                       DX::ROCArray{$elty},
                       incx::Integer)
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Ptr{$elty},
                          Cint),
                         handle(), n, [DA], DX, incx)
            DX
        end
    end
end
# In case DX is complex, and DA is real, use dscal/sscal to save flops
for (fname, elty, celty) in ((:rocblas_sscal, :Float32, :ComplexF32),
                             (:rocblas_dscal, :Float64, :ComplexF64))
    @eval begin
        # SUBROUTINE DSCAL(N,DA,DX,INCX)
        function scal!(n::Integer,
                       DA::$elty,
                       DX::ROCArray{$celty},
                       incx::Integer)
            #DY = reinterpret($elty,DX,(2*n,))
            #$(rocblascall(fname))(handle(),2*n,[DA],DY,incx)
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Ptr{$celty},
                          Cint),
                         handle(), 2*n, [DA], DX, incx)
            DX
        end
    end
end

## dot, dotc, dotu
# rocblas_status_t rocblas_ddot
#   (rocblas_handle handle,
#    int n,
#    const double *x, int incx,
#    const double *y, int incy,
#    double *result);
for (jname, fname, elty) in ((:dot,:rocblas_ddot,:Float64),
                             (:dot,:rocblas_sdot,:Float32),
                             (:dotc,:rocblas_zdotc,:ComplexF64),
                             (:dotc,:rocblas_cdotc,:ComplexF32),
                             (:dotu,:rocblas_zdotu,:ComplexF64),
                             (:dotu,:rocblas_cdotu,:ComplexF32))
    @eval begin
        function $jname(n::Integer,
                        DX::ROCArray{$elty},
                        incx::Integer,
                        DY::ROCArray{$elty},
                        incy::Integer)
            result = Ref{$elty}()
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Cint,
                          Ptr{$elty}, Cint, Ptr{$elty}),
                         handle(), n, DX, incx, DY, incy, result)
            return result[]
        end
    end
end

## nrm2
for (fname, elty, ret_type) in ((:rocblas_dnrm2,:Float64,:Float64),
                                (:rocblas_snrm2,:Float32,:Float32),
                                (:rocblas_dznrm2,:ComplexF64,:Float64),
                                (:rocblas_scnrm2,:ComplexF32,:Float32))
    @eval begin
        # SUBROUTINE DNRM2(N,X,INCX)
        function nrm2(n::Integer,
                      X::ROCArray{$elty},
                      incx::Integer)
            result = Ref{$ret_type}()
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Cint,
                          Ptr{$ret_type}),
                         handle(), n, X, incx, result)
            return result[]
        end
    end
end
# TODO: consider ROCVector and ROCStridedVector
#nrm2(x::StridedVector) = nrm2(length(x), x, stride(x,1))
nrm2(x::ROCArray) = nrm2(length(x), x, 1)

## asum
for (fname, elty, ret_type) in ((:rocblas_dasum,:Float64,:Float64),
                                (:rocblas_sasum,:Float32,:Float32),
                                (:rocblas_dzasum,:ComplexF64,:Float64),
                                (:rocblas_scasum,:ComplexF32,:Float32))
    @eval begin
        # SUBROUTINE ASUM(N, X, INCX)
        function asum(n::Integer,
                      X::ROCArray{$elty},
                      incx::Integer)
            result = Ref{$ret_type}()
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Cint,
                          Ptr{$ret_type}),
                         handle(), n, X, incx, result)
            return result[]
        end
    end
end

## axpy
for (fname, elty) in ((:rocblas_daxpy,:Float64),
                      (:rocblas_saxpy,:Float32),
                      (:rocblas_zaxpy,:ComplexF64),
                      (:rocblas_caxpy,:ComplexF32))
    @eval begin
        # SUBROUTINE DAXPY(N,DA,DX,INCX,DY,INCY)
        # DY <- DA*DX + DY
        # rocblas_status_t rocblas_saxpy(
        #   rocblas_handle handle,
        #   int n,
        #   const float *alpha, /* host or device pointer */
        #   const float *x,
        #   int incx,
        #   float *y,
        #   int incy);
        function axpy!(n::Integer,
                       alpha::($elty),
                       dx::ROCArray{$elty},
                       incx::Integer,
                       dy::ROCArray{$elty},
                       incy::Integer)
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ref{$elty}, Ptr{$elty},
                          Cint, Ptr{$elty},
                          Cint),
                         handle(), n, alpha, dx, incx, dy, incy)
            dy
        end
    end
end

function axpy!(alpha::Ta,
               x::ROCArray{T},
               rx::Union{UnitRange{Ti},AbstractRange{Ti}},
               y::ROCArray{T},
               ry::Union{UnitRange{Ti},AbstractRange{Ti}}) where {T<:ROCBLASFloat,Ta<:Number,Ti<:Integer}
    length(rx)==length(ry) || throw(DimensionMismatch(""))
    if minimum(rx) < 1 || maximum(rx) > length(x) || minimum(ry) < 1 || maximum(ry) > length(y)
        throw(BoundsError())
    end
    axpy!(length(rx), convert(T, alpha), pointer(x)+(first(rx)-1)*sizeof(T),
          step(rx), pointer(y)+(first(ry)-1)*sizeof(T), step(ry))
    y
end

#= FIXME
## iamax
# TODO: fix iamax in julia base
for (fname, elty) in ((:rocblasIdamax,:Float64),
                      (:rocblasIsamax,:Float32),
                      (:rocblasIzamax,:ComplexF64),
                      (:rocblasIcamax,:ComplexF32))
    @eval begin
        function iamax(n::Integer,
                       dx::ROCArray{$elty},
                       incx::Integer)
            result = Ref{Cint}()
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Cint,
                          Ptr{Cint}),
                         handle(), n, dx, incx, result)
            return result[]
        end
    end
end
iamax(dx::ROCArray) = iamax(length(dx), dx, 1)

## iamin
# iamin is not in standard blas is a ROCBLAS extension
for (fname, elty) in ((:rocblasIdamin,:Float64),
                      (:rocblasIsamin,:Float32),
                      (:rocblasIzamin,:ComplexF64),
                      (:rocblasIcamin,:ComplexF32))
    @eval begin
        function iamin(n::Integer,
                       dx::ROCArray{$elty},
                       incx::Integer)
            result = Ref{Cint}()
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{$elty}, Cint,
                          Ptr{Cint}),
                         handle(), n, dx, incx, result)
            return result[]
        end
    end
end
iamin(dx::ROCArray) = iamin(length(dx), dx, 1)
=#

# Level 2
## mv
### gemv
for (fname, elty) in ((:rocblas_dgemv,:Float64),
                      (:rocblas_sgemv,:Float32),
                      (:rocblas_zgemv,:ComplexF64),
                      (:rocblas_cgemv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgemv(
        #   rocblas_handle handle, rocblas_operation_t trans,
        #   int m, int n,
        #   const double *alpha,
        #   const double *A, int lda,
        #   const double *x, int incx,
        #   const double *beta,
        #   double *y, int incy)
        function gemv!(trans::Char,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       X::ROCVector{$elty},
                       beta::($elty),
                       Y::ROCVector{$elty})
            # handle trans
            roctrans = rocblasop(trans)
            m,n = size(A)
            # check dimensions
            length(X) == (trans == 'N' ? n : m) && length(Y) == (trans == 'N' ? m : n) || throw(DimensionMismatch(""))
            # compute increments
            lda = max(1,stride(A,2))
            incx = stride(X,1)
            incy = stride(Y,1)
            @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_operation_t, Cint, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty},
                         Cint, Ptr{$elty}, Ptr{$elty}, Cint), handle(),
                         roctrans, m, n, [alpha], A, lda, X, incx, [beta], Y,
                         incy)
            Y
        end
        function gemv(trans::Char, alpha::($elty), A::ROCMatrix{$elty}, X::ROCVector{$elty})
            gemv!(trans, alpha, A, X, zero($elty), similar(X, $elty, size(A, (trans == 'N' ? 1 : 2))))
        end
        function gemv(trans::Char, A::ROCMatrix{$elty}, X::ROCVector{$elty})
            gemv!(trans, one($elty), A, X, zero($elty), similar(X, $elty, size(A, (trans == 'N' ? 1 : 2))))
        end
    end
end

### (GB) general banded matrix-vector multiplication
for (fname, elty) in ((:rocblas_dgbmv,:Float64),
                      (:rocblas_sgbmv,:Float32),
                      (:rocblas_zgbmv,:ComplexF64),
                      (:rocblas_cgbmv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgbmv(
        #   rocblas_handle handle, rocblas_operation_t trans,
        #   int m, int n, int kl, int ku,
        #   const double *alpha, const double *A, int lda,
        #   const double *x, int incx,
        #   const double *beta, double *y, int incy)
        function gbmv!(trans::Char,
                       m::Integer,
                       kl::Integer,
                       ku::Integer,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty},
                       beta::($elty),
                       y::ROCVector{$elty})
            # handle trans
            roctrans = rocblasop(trans)
            n = size(A,2)
            # check dimensions
            length(x) == (trans == 'N' ? n : m) && length(y) == (trans == 'N' ? m : n) || throw(DimensionMismatch(""))
            # compute increments
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            incy = stride(y,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_operation_t, Cint, Cint,
                          Cint, Cint, Ptr{$elty}, Ptr{$elty}, Cint,
                          Ptr{$elty}, Cint, Ptr{$elty}, Ptr{$elty},
                          Cint), handle(), roctrans, m, n, kl, ku, [alpha], A,
                         lda, x, incx, [beta], y, incy)
            y
        end
        function gbmv(trans::Char,
                      m::Integer,
                      kl::Integer,
                      ku::Integer,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            # TODO: fix gbmv bug in julia
            n = size(A,2)
            leny = trans == 'N' ? m : n
            gbmv!(trans, m, kl, ku, alpha, A, x, zero($elty), similar(x, $elty, leny))
        end
        function gbmv(trans::Char,
                      m::Integer,
                      kl::Integer,
                      ku::Integer,
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            gbmv(trans, m, kl, ku, one($elty), A, x)
        end
    end
end

### symv
for (fname, elty) in ((:rocblas_dsymv,:Float64),
                      (:rocblas_ssymv,:Float32),
                      (:rocblas_zsymv,:ComplexF64),
                      (:rocblas_csymv,:ComplexF32))
    # Note that the complex symv are not BLAS but auiliary functions in LAPACK
    @eval begin
        # rocblas_status_t rocblas_dsymv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   int n, const double *alpha, const double *A, int lda,
        #   const double *x, int incx,
        #   const double *beta, double *y, int incy)
        function symv!(uplo::Char,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty},
                       beta::($elty),
                       y::ROCVector{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if m != length(x) || m != length(y) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            incy = stride(y,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t,
                         Cint,Ptr{$elty}, Ptr{$elty}, Cint,
                         Ptr{$elty}, Cint, Ptr{$elty},
                         Ptr{$elty},Cint),
                         handle(), rocuplo, n, [alpha],
                         A, lda, x, incx, [beta], y, incy)
            y
        end
        function symv(uplo::Char, alpha::($elty), A::ROCMatrix{$elty}, x::ROCVector{$elty})
                symv!(uplo, alpha, A, x, zero($elty), similar(x))
        end
        function symv(uplo::Char, A::ROCMatrix{$elty}, x::ROCVector{$elty})
            symv(uplo, one($elty), A, x)
        end
    end
end

### hemv
# TODO: fix chemv_ function call bug in julia
for (fname, elty) in ((:rocblas_zhemv,:ComplexF64),
                      (:rocblas_chemv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_chemv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   int n, const rocComplex *alpha, const rocComplex *A, int lda,
        #   const rocComplex *x, int incx,
        #   const rocComplex *beta, rocComplex *y, int incy)
        function hemv!(uplo::Char,
                       alpha::$elty,
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty},
                       beta::$elty,
                       y::ROCVector{$elty})
            # TODO: fix dimension check bug in julia
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if m != length(x) || m != length(y) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            incy = stride(y,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t,
                         Cint,Ptr{$elty}, Ptr{$elty}, Cint,
                         Ptr{$elty}, Cint, Ptr{$elty},
                         Ptr{$elty},Cint),
                         handle(), rocuplo, n, [alpha],
                         A, lda, x, incx, [beta], y, incy)
            y
        end
        function hemv(uplo::Char, alpha::($elty), A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            hemv!(uplo, alpha, A, x, zero($elty), similar(x))
        end
        function hemv(uplo::Char, A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            hemv(uplo, one($elty), A, x)
        end
    end
end

### sbmv, (SB) symmetric banded matrix-vector multiplication
# rocblas only has this for D and S
# TODO: check in julia, blas may not have sbmv for C and Z!
for (fname, elty) in ((:rocblas_dsbmv,:Float64),
                      (:rocblas_ssbmv,:Float32))
    @eval begin
        # rocblas_status_t rocblas_dsbmv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   int n, int k, const double *alpha, const double *A, int lda,
        #   const double *x, int incx,
        #   const double *beta, double *y, int incy)
        function sbmv!(uplo::Char,
                       k::Integer,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty},
                       beta::($elty),
                       y::ROCVector{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            #if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) || n != length(y) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            incy = stride(y,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, Cint, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty}, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint), handle(),
                         rocuplo, n, k, [alpha], A, lda, x, incx, [beta], y,
                         incy)
            y
        end
        function sbmv(uplo::Char, k::Integer, alpha::($elty),
                      A::ROCMatrix{$elty}, x::ROCVector{$elty})
            n = size(A,2)
            sbmv!(uplo, k, alpha, A, x, zero($elty), similar(x, $elty, n))
        end
        function sbmv(uplo::Char, k::Integer, A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            sbmv(uplo, k, one($elty), A, x)
        end
    end
end

### hbmv, (HB) Hermitian banded matrix-vector multiplication
for (fname, elty) in ((:rocblas_zhbmv,:ComplexF64),
                      (:rocblas_chbmv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_chbmv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   int n, int k, const rocComplex *alpha, const rocComplex *A, int lda,
        #   const rocComplex *x, int incx,
        #   const rocComplex *beta, rocComplex *y, int incy)
        function hbmv!(uplo::Char,
                       k::Integer,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty},
                       beta::($elty),
                       y::ROCVector{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) || n != length(y) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            incy = stride(y,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, Cint, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty}, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint), handle(),
                         rocuplo, n, k, [alpha], A, lda, x, incx, [beta], y,
                         incy)
            y
        end
        function hbmv(uplo::Char, k::Integer, alpha::($elty),
                      A::ROCMatrix{$elty}, x::ROCVector{$elty})
            n = size(A,2)
            hbmv!(uplo, k, alpha, A, x, zero($elty), similar(x, $elty, n))
        end
        function hbmv(uplo::Char, k::Integer, A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            hbmv(uplo, k, one($elty), A, x)
        end
    end
end

### tbmv, (TB) triangular banded matrix-vector multiplication
for (fname, elty) in ((:rocblas_stbmv,:Float32),
                      (:rocblas_dtbmv,:Float64),
                      (:rocblas_ztbmv,:ComplexF64),
                      (:rocblas_ctbmv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtbmv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int n, int k, const double *alpha, const double *A, int lda,
        #   const double *x, int incx)
        function tbmv!(uplo::Char,
                       trans::Char,
                       diag::Char,
                       k::Integer,
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty})
            rocuplo  = rocblasfill(uplo)
            roctrans = rocblasop(trans)
            rocdiag  = rocblasdiag(diag)
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, rocblas_operation_t,
                         rocblas_diagonal_t, Cint, Cint, Ptr{$elty}, Cint,
                         Ptr{$elty}, Cint), handle(), rocuplo, roctrans,
                         rocdiag, n, k, A, lda, x, incx)
            x
        end
        function tbmv(uplo::Char,
                      trans::Char,
                      diag::Char,
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            tbmv!(uplo, trans, diag, A, copy(x))
        end
    end
end

### tbsv, (TB) triangular banded matrix solve
for (fname, elty) in ((:rocblas_stbsv,:Float32),
                      (:rocblas_dtbsv,:Float64),
                      (:rocblas_ztbsv,:ComplexF64),
                      (:rocblas_ctbsv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtbsv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int n, int k, const double *alpha, const double *A, int lda,
        #   const double *x, int incx)
        function tbsv!(uplo::Char,
                       trans::Char,
                       diag::Char,
                       k::Integer,
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty})
            rocuplo  = rocblasfill(uplo)
            roctrans = rocblasop(trans)
            rocdiag  = rocblasdiag(diag)
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, rocblas_operation_t,
                         rocblas_diagonal_t, Cint, Cint, Ptr{$elty}, Cint,
                         Ptr{$elty}, Cint), handle(), rocuplo, roctrans,
                         rocdiag, n, k, A, lda, x, incx)
            x
        end
        function tbsv(uplo::Char,
                      trans::Char,
                      diag::Char,
                      k::Integer,
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            tbsv!(uplo, trans, diag, k, A, copy(x))
        end
    end
end

### trmv, Triangular matrix-vector multiplication
for (fname, elty) in ((:rocblas_dtrmv,:Float64),
                      (:rocblas_strmv,:Float32),
                      (:rocblas_ztrmv,:ComplexF64),
                      (:rocblas_ctrmv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtrmv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int n, const double *A, int lda,
        #   double *x, int incx)
        function trmv!(uplo::Char,
                       trans::Char,
                       diag::Char,
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty})
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if n != length(x)
                throw(DimensionMismatch("length(x)=$(length(x)) does not match size(A)=$(size(A))"))
            end
            rocuplo = rocblasfill(uplo)
            roctrans = rocblasop(trans)
            rocdiag = rocblasdiag(diag)
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t,
                          rocblas_operation_t, rocblas_diagonal_t, Cint,
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint), handle(),
                         rocuplo, roctrans, rocdiag, n, A, lda, x, incx)
            x
        end
        function trmv(uplo::Char,
                      trans::Char,
                      diag::Char,
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            trmv!(uplo, trans, diag, A, copy(x))
        end
    end
end

### trsv, Triangular matrix-vector solve
for (fname, elty) in ((:rocblas_dtrsv,:Float64),
                      (:rocblas_strsv,:Float32),
                      (:rocblas_ztrsv,:ComplexF64),
                      (:rocblas_ctrsv,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtrsv(
        #   rocblas_handle handle, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int n, const double *A, int lda,
        #   double *x, int incx)
        function trsv!(uplo::Char,
                       trans::Char,
                       diag::Char,
                       A::ROCMatrix{$elty},
                       x::ROCVector{$elty})
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if n != length(x)
                throw(DimensionMismatch("length(x)=$(length(x)) does not match size(A)=$(size(A))"))
            end
            rocuplo = rocblasfill(uplo)
            roctrans = rocblasop(trans)
            rocdiag = rocblasdiag(diag)
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t,
                          rocblas_operation_t, rocblas_diagonal_t, Cint,
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint), handle(),
                         rocuplo, roctrans, rocdiag, n, A, lda, x, incx)
            x
        end
        function trsv(uplo::Char,
                      trans::Char,
                      diag::Char,
                      A::ROCMatrix{$elty},
                      x::ROCVector{$elty})
            trsv!(uplo, trans, diag, A, copy(x))
        end
    end
end

### ger
for (fname, elty) in ((:rocblas_dger,:Float64),
                      (:rocblas_sger,:Float32),
                      (:rocblas_zgerc,:ComplexF64),
                      (:rocblas_cgerc,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dger(
        #   rocblas_handle handle, int m, int n, const double *alpha,
        #   const double *x, int incx,
        #   const double *y, int incy,
        #   double *A, int lda)
        function ger!(alpha::$elty,
                      x::ROCVector{$elty},
                      y::ROCVector{$elty},
                      A::ROCMatrix{$elty})
            m, n = size(A)
            m == length(x) || throw(DimensionMismatch(""))
            n == length(y) || throw(DimensionMismatch(""))
            incx = stride(x,1)
            incy = stride(y,1)
            lda = max(1,stride(A,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty},
                         Cint), handle(), m, n, [alpha], x, incx, y,
                         incy, A, lda)
            A
        end
    end
end

### syr
# TODO: check calls in julia b/c blas may not define syr for Z and C
for (fname, elty) in ((:rocblas_dsyr,:Float64),
                      (:rocblas_ssyr,:Float32),
                      (:rocblas_zsyr,:ComplexF64),
                      (:rocblas_csyr,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dsyr(
        #   rocblas_handle handle, rocblas_fill_t uplo, int n,
        #   const double *alpha, const double *x, int incx,
        #   double *A, int lda)
        function syr!(uplo::Char,
                      alpha::$elty,
                      x::ROCVector{$elty},
                      A::ROCMatrix{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            lda = max(1,stride(A,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty}, Cint),
                         handle(), rocuplo, n, [alpha], x, incx, A,
                         lda)
            A
        end
    end
end

### her
for (fname, elty) in ((:rocblas_zher,:ComplexF64),
                      (:rocblas_cher,:ComplexF32))
    @eval begin
        function her!(uplo::Char,
                      alpha::$elty,
                      x::ROCVector{$elty},
                      A::ROCMatrix{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            lda = max(1,stride(A,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, Cint,
                         Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty}, Cint),
                         handle(), rocuplo, n, [alpha], x, incx, A,
                         lda)
            A
        end
    end
end

### her2
for (fname, elty) in ((:rocblas_zher2,:ComplexF64),
                      (:rocblas_cher2,:ComplexF32))
    @eval begin
        function her2!(uplo::Char,
                      alpha::$elty,
                      x::ROCVector{$elty},
                      y::ROCVector{$elty},
                      A::ROCMatrix{$elty})
            rocuplo = rocblasfill(uplo)
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            length(y) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            incy = stride(y,1)
            lda = max(1,stride(A,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t, Cint,
                          Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty}, Cint,
                          Ptr{$elty}, Cint),
                         handle(), rocuplo, n, [alpha], x, incx, y, incy, A,
                         lda)
            A
        end
    end
end

# Level 3
## (GE) general matrix-matrix multiplication
for (fname, elty) in
        ((:rocblas_dgemm,:Float64),
         (:rocblas_sgemm,:Float32),
         (:rocblasHgemm, :Float16),
         (:rocblas_zgemm,:ComplexF64),
         (:rocblas_cgemm,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgemm(
        #   rocblas_handle handle, rocblas_operation_t transa, rocblas_operation_t transb,
        #   int m, int n, int k,
        #   const double *alpha, const double *A, int lda,
        #   const double *B, int ldb, const double *beta,
        #   double *C, int ldc)
        function gemm!(transA::Char,
                       transB::Char,
                       alpha::($elty),
                       A::ROCVecOrMat{$elty},
                       B::ROCVecOrMat{$elty},
                       beta::($elty),
                       C::ROCVecOrMat{$elty})
            m = size(A, transA == 'N' ? 1 : 2)
            k = size(A, transA == 'N' ? 2 : 1)
            n = size(B, transB == 'N' ? 2 : 1)
            if m != size(C,1) || n != size(C,2) || k != size(B, transB == 'N' ? 1 : 2)
                throw(DimensionMismatch(""))
            end
            roctransA = rocblasop(transA)
            roctransB = rocblasop(transB)
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_operation_t,
                          rocblas_operation_t, Cint, Cint, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint),
                         handle(), roctransA,
                         roctransB, m, n, k, [alpha], A, lda, B, ldb, [beta],
                         C, ldc)
            C
        end
        function gemm(transA::Char,
                      transB::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            gemm!(transA, transB, alpha, A, B, zero($elty),
                  similar(B, $elty, (size(A, transA == 'N' ? 1 : 2),
                                     size(B, transB == 'N' ? 2 : 1))))
        end
        function gemm(transA::Char,
                      transB::Char,
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            gemm(transA, transB, one($elty), A, B)
        end
    end
end

# helper function to get a device array of device pointers
function device_batch(batch::Array{T}) where {T<:ROCArray}
  E = eltype(T)
  ptrs = [Base.unsafe_convert(Ptr{E}, arr.buf) for arr in batch]
  ROCArray(ptrs)
end

## (GE) general matrix-matrix multiplication batched
for (fname, elty) in
        ((:rocblas_dgemmBatched,:Float64),
         (:rocblas_sgemmBatched,:Float32),
         (:rocblas_zgemmBatched,:ComplexF64),
         (:rocblas_cgemmBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgemmBatched(
        #   rocblas_handle handle, rocblas_operation_t transa, rocblas_operation_t transb,
        #   int m, int n, int k,
        #   const double *alpha, const double **A, int lda,
        #   const double **B, int ldb, const double *beta,
        #   double **C, int ldc, int batchCount)
        function gemm_batched!(transA::Char,
                               transB::Char,
                               alpha::($elty),
                               A::Array{ROCMatrix{$elty},1},
                               B::Array{ROCMatrix{$elty},1},
                               beta::($elty),
                               C::Array{ROCMatrix{$elty},1})
            if( length(A) != length(B) || length(A) != length(C) )
                throw(DimensionMismatch(""))
            end
            for (As,Bs,Cs) in zip(A,B,C)
                m = size(As, transA == 'N' ? 1 : 2)
                k = size(As, transA == 'N' ? 2 : 1)
                n = size(Bs, transB == 'N' ? 2 : 1)
                if m != size(Cs,1) || n != size(Cs,2) || k != size(Bs, transB == 'N' ? 1 : 2)
                    throw(DimensionMismatch(""))
                end
            end
            m = size(A[1], transA == 'N' ? 1 : 2)
            k = size(A[1], transA == 'N' ? 2 : 1)
            n = size(B[1], transB == 'N' ? 2 : 1)
            roctransA = rocblasop(transA)
            roctransB = rocblasop(transB)
            lda = max(1,stride(A[1],2))
            ldb = max(1,stride(B[1],2))
            ldc = max(1,stride(C[1],2))
            Aptrs = device_batch(A)
            Bptrs = device_batch(B)
            Cptrs = device_batch(C)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_operation_t,
                          rocblas_operation_t, Cint, Cint, Cint, Ptr{$elty},
                          Ptr{Ptr{$elty}}, Cint, Ptr{Ptr{$elty}}, Cint, Ptr{$elty},
                          Ptr{Ptr{$elty}}, Cint, Cint),
                         handle(), roctransA,
                         roctransB, m, n, k, [alpha], Aptrs, lda, Bptrs, ldb, [beta],
                         Cptrs, ldc, length(A))
            C
        end
        function gemm_batched(transA::Char,
                      transB::Char,
                      alpha::($elty),
                      A::Array{ROCMatrix{$elty},1},
                      B::Array{ROCMatrix{$elty},1})
            C = ROCMatrix{$elty}[similar( B[1], $elty, (size(A[1], transA == 'N' ? 1 : 2),size(B[1], transB == 'N' ? 2 : 1))) for i in 1:length(A)]
            gemm_batched!(transA, transB, alpha, A, B, zero($elty), C )
        end
        function gemm_batched(transA::Char,
                      transB::Char,
                      A::Array{ROCMatrix{$elty},1},
                      B::Array{ROCMatrix{$elty},1})
            gemm_batched(transA, transB, one($elty), A, B)
        end
    end
end


## (GE) general matrix-matrix multiplication strided batched
for (fname, elty) in
        ((:rocblas_dgemmStridedBatched,:Float64),
         (:rocblas_sgemmStridedBatched,:Float32),
         (:rocblas_zgemmStridedBatched,:ComplexF64),
         (:rocblas_cgemmStridedBatched,:ComplexF32))
    @eval begin

        # rocblas_status_t rocblas_dgemmStridedBatched(rocblas_handle handle,
        #                                   rocblas_operation_t transa,
        #                                   rocblas_operation_t transb,
        #                                   int m, int n, int k,
        #                                   const double          *alpha,
        #                                   const double          *A, int lda,
        #                                   long long int          strideA,
        #                                   const double          *B, int ldb,
        #                                   long long int          strideB,
        #                                   const double          *beta,
        #                                   double                *C, int ldc,
        #                                   long long int          strideC,
        #                                   int batchCount)

        function gemm_strided_batched!(transA::Char,
                               transB::Char,
                               alpha::($elty),
                               A::ROCArray{$elty, 3},
                               B::ROCArray{$elty, 3},
                               beta::($elty),
                               C::ROCArray{$elty, 3})
           m = size(A, transA == 'N' ? 1 : 2)
           k = size(A, transA == 'N' ? 2 : 1)
           n = size(B, transB == 'N' ? 2 : 1)

           @assert size(A, 3) == size(B, 3) == size(C, 3) "Batch size mismatch"

           if m != size(C,1) || n != size(C,2) || k != size(B, transB == 'N' ? 1 : 2)
               throw(DimensionMismatch(""))
           end
           roctransA = rocblasop(transA)
           roctransB = rocblasop(transB)
           lda = max(1,stride(A,2))
           ldb = max(1,stride(B,2))
           ldc = max(1,stride(C,2))

           strideA = stride(A, 3)
           strideB = stride(B, 3)
           strideC = stride(C, 3)
           batchCount = size(A, 3)
           @check ccall(($(string(fname)), librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_operation_t,
                         rocblas_operation_t, Cint, Cint, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Cint, Ptr{$elty}, Cint, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Cint, Cint),
                        handle(), roctransA,
                        roctransB, m, n, k, [alpha], A, lda, strideA, B, ldb, strideB, [beta],
                        C, ldc, strideC, batchCount)
           C
        end
        function gemm_strided_batched(transA::Char,
                      transB::Char,
                      alpha::($elty),
                      A::ROCArray{$elty, 3},
                      B::ROCArray{$elty, 3})
            C = similar(B, (size(A, transA == 'N' ? 1 : 2), size(B, transB == 'N' ? 2 : 1), size(A, 3)))
            gemm_strided_batched!(transA, transB, alpha, A, B, zero($elty), C )
        end
        function gemm_strided_batched(transA::Char,
                      transB::Char,
                      A::ROCArray{$elty, 3},
                      B::ROCArray{$elty, 3})
            gemm_strided_batched(transA, transB, one($elty), A, B)
        end
    end
end

## (SY) symmetric matrix-matrix and matrix-vector multiplication
for (fname, elty) in ((:rocblas_dsymm,:Float64),
                      (:rocblas_ssymm,:Float32),
                      (:rocblas_zsymm,:ComplexF64),
                      (:rocblas_csymm,:ComplexF32))
    # TODO: fix julia dimension checks in symm!
    @eval begin
        # rocblas_status_t rocblas_dsymm(
        #   rocblas_handle handle, rocblas_side_t side,
        #   rocblas_fill_t uplo, int m, int n,
        #   const double *alpha, const double *A, int lda,
        #   const double *B, int ldb,
        #   const double *beta, double *C, int ldc)
        function symm!(side::Char,
                       uplo::Char,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       B::ROCMatrix{$elty},
                       beta::($elty),
                       C::ROCMatrix{$elty})
            rocside = rocblasside(side)
            rocuplo = rocblasfill(uplo)
            k, nA = size(A)
            if k != nA throw(DimensionMismatch("Matrix A must be square")) end
            m = side == 'L' ? k : size(B,1)
            n = side == 'L' ? size(B,2) : k
            if m != size(C,1) || n != size(C,2) || k != size(B, side == 'L' ? 1 : 2)
                throw(DimensionMismatch(""))
            end
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_side_t,
                         rocblas_fill_t, Cint, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint),
                         handle(), rocside,
                         rocuplo, m, n, [alpha], A, lda, B, ldb, [beta], C,
                         ldc)
            C
        end
        function symm(side::Char,
                      uplo::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            symm!(side, uplo, alpha, A, B, zero($elty), similar(B))
        end
        function symm(side::Char,
                      uplo::Char,
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            symm(side, uplo, one($elty), A, B)
        end
    end
end

## syrk
for (fname, elty) in ((:rocblas_dsyrk,:Float64),
                      (:rocblas_ssyrk,:Float32),
                      (:rocblas_zsyrk,:ComplexF64),
                      (:rocblas_csyrk,:ComplexF32))
   @eval begin
       # rocblas_status_t rocblas_dsyrk(
       #   rocblas_handle handle, rocblas_fill_t uplo,
       #   rocblas_operation_t trans, int n, int k,
       #   const double *alpha, const double *A, int lda,
       #   const double *beta, double *C, int ldc)
       function syrk!(uplo::Char,
                      trans::Char,
                      alpha::($elty),
                      A::ROCVecOrMat{$elty},
                      beta::($elty),
                      C::ROCMatrix{$elty})
           rocuplo = rocblasfill(uplo)
           roctrans = rocblasop(trans)
           mC, n = size(C)
           if mC != n throw(DimensionMismatch("C must be square")) end
           nn = size(A, trans == 'N' ? 1 : 2)
           if nn != n throw(DimensionMismatch("syrk!")) end
           k  = size(A, trans == 'N' ? 2 : 1)
           lda = max(1,stride(A,2))
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_fill_t,
                         rocblas_operation_t, Cint, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Ptr{$elty}, Ptr{$elty}, Cint),
                        handle(), rocuplo, roctrans, n, k, [alpha], A,
                        lda, [beta], C, ldc)
            C
        end
    end
end
function syrk(uplo::Char,
              trans::Char,
              alpha::Number,
              A::ROCVecOrMat)
    T = eltype(A)
    n = size(A, trans == 'N' ? 1 : 2)
    syrk!(uplo, trans, convert(T,alpha), A, zero(T), similar(A, T, (n, n)))
end
syrk(uplo::Char, trans::Char, A::ROCVecOrMat) = syrk(uplo, trans,
                                                              one(eltype(A)),
                                                              A)

## hemm
for (fname, elty) in ((:rocblas_zhemm,:ComplexF64),
                      (:rocblas_chemm,:ComplexF32))
   @eval begin
       # rocblas_status_t rocblas_chemm(
       #   rocblas_handle handle, rocblas_side_t side, rocblas_fill_t uplo,
       #   int m, int n,
       #   const rocComplex *alpha,
       #   const rocComplex *A, int lda,
       #   const rocComplex *B, int ldb,
       #   const rocComplex *beta,
       #   rocComplex *C, int ldc)
       function hemm!(side::Char,
                      uplo::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty},
                      beta::($elty),
                      C::ROCMatrix{$elty})
           rocside = rocblasside(side)
           rocuplo = rocblasfill(uplo)
           mA, nA = size(A)
           m, n = size(B)
           mC, nC = size(C)
           if mA != nA throw(DimensionMismatch("A must be square")) end
           if ((m != mC) || (n != nC)) throw(DimensionMismatch("B and C must have same dimensions")) end
           if ((side == 'L') && (mA != m)) throw(DimensionMismatch("")) end
           if ((side == 'R') && (mA != n)) throw(DimensionMismatch("")) end
           lda = max(1,stride(A,2))
           ldb = max(1,stride(B,2))
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_side_t, rocblas_fill_t,
                        Cint, Cint, Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty},
                         Cint, Ptr{$elty}, Ptr{$elty}, Cint),
                        handle(),
                        rocside, rocuplo, m, n, [alpha], A, lda, B, ldb, [beta], C, ldc)
           C
       end
       function hemm(uplo::Char,
                     trans::Char,
                     alpha::($elty),
                     A::ROCMatrix{$elty},
                     B::ROCMatrix{$elty})
           m,n = size(B)
           hemm!( uplo, trans, alpha, A, B, zero($elty), similar(B, $elty, (m,n) ) )
       end
       hemm( uplo::Char, trans::Char, A::ROCMatrix{$elty}, B::ROCMatrix{$elty}) = hemm( uplo, trans, one($elty), A, B)
    end
end

## herk
for (fname, elty) in ((:rocblas_zherk,:ComplexF64),
                      (:rocblas_cherk,:ComplexF32))
   @eval begin
       # rocblas_status_t rocblas_cherk(
       #   rocblas_handle handle, rocblas_fill_t uplo, rocblas_operation_t trans,
       #   int n, int k,
       #   const float *alpha, const rocComplex *A, int lda,
       #   const float *beta, rocComplex *C, int ldc)
       function herk!(uplo::Char,
                      trans::Char,
                      alpha::($elty),
                      A::ROCVecOrMat{$elty},
                      beta::($elty),
                      C::ROCMatrix{$elty})
           rocuplo = rocblasfill(uplo)
           roctrans = rocblasop(trans)
           mC, n = size(C)
           if mC != n throw(DimensionMismatch("C must be square")) end
           nn = size(A, trans == 'N' ? 1 : 2)
           if nn != n throw(DimensionMismatch("syrk!")) end
           k  = size(A, trans == 'N' ? 2 : 1)
           lda = max(1,stride(A,2))
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_fill_t,
                         rocblas_operation_t, Cint, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Ptr{$elty}, Ptr{$elty}, Cint),
                        handle(), rocuplo, roctrans, n, k, [alpha], A,
                        lda, [beta], C, ldc)
           C
       end
       function herk(uplo::Char, trans::Char, alpha::($elty), A::ROCVecOrMat{$elty})
           n = size(A, trans == 'N' ? 1 : 2)
           herk!(uplo, trans, alpha, A, zero($elty), similar(A, $elty, (n,n)))
       end
       herk(uplo::Char, trans::Char, A::ROCVecOrMat{$elty}) = herk(uplo, trans, one($elty), A)
   end
end

## syr2k
for (fname, elty) in ((:rocblas_dsyr2k,:Float64),
                      (:rocblas_ssyr2k,:Float32),
                      (:rocblas_zsyr2k,:ComplexF64),
                      (:rocblas_csyr2k,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dsyr2k(
        #   rocblas_handle handle,
        #   rocblas_fill_t uplo, rocblas_operation_t trans,
        #   int n, int k,
        #   const double *alpha,
        #   const double *A, int lda,
        #   const double *B, int ldb,
        #   const double *beta,
        #   double *C, int ldc)
        function syr2k!(uplo::Char,
                        trans::Char,
                        alpha::($elty),
                        A::ROCVecOrMat{$elty},
                        B::ROCVecOrMat{$elty},
                        beta::($elty),
                        C::ROCMatrix{$elty})
            # TODO: check size of B in julia (syr2k!)
            rocuplo = rocblasfill(uplo)
            roctrans = rocblasop(trans)
            m, n = size(C)
            if m != n throw(DimensionMismatch("C must be square")) end
            nA = size(A, trans == 'N' ? 1 : 2)
            nB = size(B, trans == 'N' ? 1 : 2)
            if nA != n throw(DimensionMismatch("First dimension of op(A) must match C")) end
            if nB != n throw(DimensionMismatch("First dimension of op(B.') must match C")) end
            k  = size(A, trans == 'N' ? 2 : 1)
            if k != size(B, trans == 'N' ? 2 : 1) throw(DimensionMismatch(
                "Inner dimensions of op(A) and op(B.') must match")) end
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_fill_t,
                         rocblas_operation_t, Cint, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint),
                         handle(), rocuplo,
                         roctrans, n, k, [alpha], A, lda, B, ldb, [beta], C,
                         ldc)
            C
        end
    end
end
function syr2k(uplo::Char,
               trans::Char,
               alpha::Number,
               A::ROCVecOrMat,
               B::ROCVecOrMat)
    T = eltype(A)
    n = size(A, trans == 'N' ? 1 : 2)
    syr2k!(uplo, trans, convert(T,alpha), A, B, zero(T), similar(A, T, (n, n)))
end
syr2k(uplo::Char, trans::Char, A::ROCVecOrMat, B::ROCVecOrMat) = syr2k(uplo, trans, one(eltype(A)), A, B)

## her2k
for (fname, elty1, elty2) in ((:rocblas_zher2k,:ComplexF64,:Float64),
                              (:rocblas_cher2k,:ComplexF32,:Float32))
   @eval begin
       # rocblas_status_t rocblas_zher2k(
       #   rocblas_handle handle, rocblas_fill_t uplo, rocblas_operation_t trans,
       #   int n, int k,
       #   const cuDoubleComplex *alpha, const cuDoubleComplex *A, int lda,
       #   const cuDoubleComplex *B, int ldb,
       #   const double *beta, cuDoubleComplex *C, int ldc)
       function her2k!(uplo::Char,
                       trans::Char,
                       alpha::($elty1),
                       A::ROCVecOrMat{$elty1},
                       B::ROCVecOrMat{$elty1},
                       beta::($elty2),
                       C::ROCMatrix{$elty1})
           # TODO: check size of B in julia (her2k!)
           rocuplo = rocblasfill(uplo)
           roctrans = rocblasop(trans)
           m, n = size(C)
           if m != n throw(DimensionMismatch("C must be square")) end
           nA = size(A, trans == 'N' ? 1 : 2)
           nB = size(B, trans == 'N' ? 1 : 2)
           if nA != n throw(DimensionMismatch("First dimension of op(A) must match C")) end
           if nB != n throw(DimensionMismatch("First dimension of op(B.') must match C")) end
           k  = size(A, trans == 'N' ? 2 : 1)
           if k != size(B, trans == 'N' ? 2 : 1)
               throw(DimensionMismatch("Inner dimensions of op(A) and op(B.') must match"))
           end
           lda = max(1,stride(A,2))
           ldb = max(1,stride(B,2))
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_fill_t,
                        rocblas_operation_t, Cint, Cint, Ptr{$elty1},
                         Ptr{$elty1}, Cint, Ptr{$elty1}, Cint, Ptr{$elty2},
                         Ptr{$elty1}, Cint),
                        handle(), rocuplo, roctrans, n, k,
                        [alpha], A, lda, B, ldb, [beta], C, ldc)
           C
       end
       function her2k(uplo::Char,
                      trans::Char,
                      alpha::($elty1),
                      A::ROCVecOrMat{$elty1},
                      B::ROCVecOrMat{$elty1})
           n = size(A, trans == 'N' ? 1 : 2)
           her2k!(uplo, trans, alpha, A, B, zero($elty2), similar(A, $elty1, (n,n)))
       end
       her2k(uplo::Char,
             trans::Char,
             A::ROCVecOrMat{$elty1},
             B::ROCVecOrMat{$elty1}) = her2k(uplo, trans, one($elty1), A, B)
   end
end

## (TR) Triangular matrix and vector multiplication and solution
for (mmname, smname, elty) in
        ((:rocblas_dtrmm,:rocblas_dtrsm,:Float64),
         (:rocblas_strmm,:rocblas_strsm,:Float32),
         (:rocblas_ztrmm,:rocblas_ztrsm,:ComplexF64),
         (:rocblas_ctrmm,:rocblas_ctrsm,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtrmm(rocblas_handle handle,
        #   rocblas_side_t side, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int m, int n,
        #   const double *alpha, const double *A, int lda,
        #   const double *B, int ldb,
        #   double *C, int ldc)
        # Note: ROCBLAS differs from BLAS API for trmm
        #   BLAS: inplace modification of B
        #   ROCBLAS: store result in C
        function trmm!(side::Char,
                       uplo::Char,
                       transa::Char,
                       diag::Char,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       B::ROCMatrix{$elty},
                       C::ROCMatrix{$elty})
            rocside = rocblasside(side)
            rocuplo = rocblasfill(uplo)
            roctransa = rocblasop(transa)
            rocdiag = rocblasdiag(diag)
            m, n = size(B)
            mA, nA = size(A)
            # TODO: clean up error messages
            if mA != nA throw(DimensionMismatch("A must be square")) end
            if nA != (side == 'L' ? m : n) throw(DimensionMismatch("trmm!")) end
            mC, nC = size(C)
            if mC != m || nC != n throw(DimensionMismatch("trmm!")) end
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            @check ccall(($(string(mmname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_side_t,
                          rocblas_fill_t, rocblas_operation_t,
                          rocblas_diagonal_t, Cint, Cint, Ptr{$elty},
                          Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty},
                          Cint),
                         handle(), rocside, rocuplo, roctransa,
                         rocdiag, m, n, [alpha], A, lda, B, ldb, C, ldc)
            C
        end
        function trmm(side::Char,
                      uplo::Char,
                      transa::Char,
                      diag::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            trmm!(side, uplo, transa, diag, alpha, A, B, similar(B))
        end
        # rocblas_status_t rocblas_dtrsm(rocblas_handle handle,
        #   rocblas_side_t side, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int m, int n,
        #   const double *alpha,
        #   const double *A, int lda,
        #   double *B, int ldb)
        function trsm!(side::Char,
                       uplo::Char,
                       transa::Char,
                       diag::Char,
                       alpha::($elty),
                       A::ROCMatrix{$elty},
                       B::ROCMatrix{$elty})
            rocside = rocblasside(side)
            rocuplo = rocblasfill(uplo)
            roctransa = rocblasop(transa)
            rocdiag = rocblasdiag(diag)
            m, n = size(B)
            mA, nA = size(A)
            # TODO: clean up error messages
            if mA != nA throw(DimensionMismatch("A must be square")) end
            if nA != (side == 'L' ? m : n) throw(DimensionMismatch("trsm!")) end
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            @check ccall(($(string(smname)), librocblas), rocblas_status_t,
                          (rocblas_handle, rocblas_side_t,
                           rocblas_fill_t, rocblas_operation_t,
                           rocblas_diagonal_t, Cint, Cint, Ptr{$elty},
                           Ptr{$elty}, Cint, Ptr{$elty}, Cint),
                          handle(), rocside, rocuplo, roctransa, rocdiag,
                          m, n, [alpha], A, lda, B, ldb)
            B
        end
        function trsm(side::Char,
                      uplo::Char,
                      transa::Char,
                      diag::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      B::ROCMatrix{$elty})
            trsm!(side, uplo, transa, diag, alpha, A, copy(B))
        end
    end
end

## (TR) triangular triangular matrix solution batched
for (fname, elty) in
        ((:rocblas_dtrsmBatched,:Float64),
         (:rocblas_strsmBatched,:Float32),
         (:rocblas_ztrsmBatched,:ComplexF64),
         (:rocblas_ctrsmBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dtrsmBatched(rocblas_handle handle,
        #   rocblas_side_t side, rocblas_fill_t uplo,
        #   rocblas_operation_t trans, rocblas_diagonal_t diag,
        #   int m, int n,
        #   const double *alpha,
        #   const double **A, int lda,
        #   double **B, int ldb,
        #   int batchCount)
        function trsm_batched!(side::Char,
                               uplo::Char,
                               transa::Char,
                               diag::Char,
                               alpha::($elty),
                               A::Array{ROCMatrix{$elty},1},
                               B::Array{ROCMatrix{$elty},1})
            rocside = rocblasside(side)
            rocuplo = rocblasfill(uplo)
            roctransa = rocblasop(transa)
            rocdiag = rocblasdiag(diag)
            if( length(A) != length(B) )
                throw(DimensionMismatch(""))
            end
            for (As,Bs) in zip(A,B)
                mA, nA = size(As)
                m,n = size(Bs)
                if mA != nA throw(DimensionMismatch("A must be square")) end
                if nA != (side == 'L' ? m : n) throw(DimensionMismatch("trsm_batched!")) end
            end
            m,n = size(B[1])
            lda = max(1,stride(A[1],2))
            ldb = max(1,stride(B[1],2))
            Aptrs = device_batch(A)
            Bptrs = device_batch(B)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_side_t, rocblas_fill_t,
                          rocblas_operation_t, rocblas_diagonal_t, Cint, Cint,
                          Ptr{$elty}, Ptr{Ptr{$elty}}, Cint, Ptr{Ptr{$elty}},
                          Cint, Cint),
                         handle(), rocside, rocuplo,
                         roctransa, rocdiag, m, n, [alpha], Aptrs, lda,
                         Bptrs, ldb, length(A))
            B
        end
        function trsm_batched(side::Char,
                              uplo::Char,
                              transa::Char,
                              diag::Char,
                              alpha::($elty),
                              A::Array{ROCMatrix{$elty},1},
                              B::Array{ROCMatrix{$elty},1})
            trsm_batched!(side, uplo, transa, diag, alpha, A, copy(B) )
        end
    end
end

# TODO: julia, tr{m,s}m, Char -> Char
# TODO: julia, trmm!, alpha::Number -> alpha::$elty

# BLAS-like extensions
## geam
for (fname, elty) in ((:rocblas_dgeam,:Float64),
                      (:rocblas_sgeam,:Float32),
                      (:rocblas_zgeam,:ComplexF64),
                      (:rocblas_cgeam,:ComplexF32))
   @eval begin
       # rocblas_status_t rocblas_cgeam(
       #   rocblas_handle handle, rocblas_operation_t transa, rocblas_operation_t transb,
       #   int m, int n,
       #   const rocComplex *alpha,
       #   const rocComplex *A, int lda,
       #   const rocComplex *B, int ldb,
       #   const rocComplex *beta,
       #   rocComplex *C, int ldc)
       function geam!(transa::Char,
                      transb::Char,
                      alpha::($elty),
                      A::ROCMatrix{$elty},
                      beta::($elty),
                      B::ROCMatrix{$elty},
                      C::ROCMatrix{$elty})
           roctransa = rocblasop(transa)
           roctransb = rocblasop(transb)
           mA, nA = size(A)
           mB, nB = size(B)
           m, n = size(C)
           if ((transa == 'N') && ((mA != m) && (nA != n ))) throw(DimensionMismatch("")) end
           if ((transa == 'C' || transa == 'T') && ((nA != m) || (mA != n))) throw(DimensionMismatch("")) end
           if ((transb == 'N') && ((mB != m) || (nB != n ))) throw(DimensionMismatch("")) end
           if ((transb == 'C' || transb == 'T') && ((nB != m) || (mB != n))) throw(DimensionMismatch("")) end
           lda = max(1,stride(A,2))
           ldb = max(1,stride(B,2))
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_operation_t, rocblas_operation_t,
                         Cint, Cint, Ptr{$elty}, Ptr{$elty}, Cint, Ptr{$elty},
                         Ptr{$elty}, Cint, Ptr{$elty}, Cint), handle(),
                        roctransa, roctransb, m, n, [alpha], A, lda, [beta], B, ldb, C, ldc)
           C
       end
       function geam(transa::Char,
                     transb::Char,
                     alpha::($elty),
                     A::ROCMatrix{$elty},
                     beta::($elty),
                     B::ROCMatrix{$elty})
           m,n = size(B)
           if ((transb == 'T' || transb == 'C'))
               geam!( transa, transb, alpha, A, beta, B, similar(B, $elty, (n,m) ) )
           end
           if (transb == 'N')
               geam!( transa, transb, alpha, A, beta, B, similar(B, $elty, (m,n) ) )
           end
       end
       geam( uplo::Char, trans::Char, A::ROCMatrix{$elty}, B::ROCMatrix{$elty}) = geam( uplo, trans, one($elty), A, one($elty), B)
    end
end

## getrfBatched - performs LU factorizations

for (fname, elty) in
        ((:rocblas_dgetrfBatched,:Float64),
         (:rocblas_sgetrfBatched,:Float32),
         (:rocblas_zgetrfBatched,:ComplexF64),
         (:rocblas_cgetrfBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgetrfBatched(
        #   rocblas_handle handle, int n, double **A,
        #   int lda, int *PivotArray, int *infoArray,
        #   int batchSize)
        function getrf_batched!(A::Array{ROCMatrix{$elty},1},
                               Pivot::Bool)
            for As in A
                m,n = size(As)
                if m != n
                    throw(DimensionMismatch("All matrices must be square!"))
                end
            end
            m,n = size(A[1])
            lda = max(1,stride(A[1],2))
            Aptrs = device_batch(A)
            info  = ROCArray{Cint}(undef, length(A))
            pivotArray  = Pivot ? ROCArray{Int32}(undef, (n, length(A))) : C_NULL
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{Ptr{$elty}}, Cint,
                          Ptr{Cint}, Ptr{Cint}, Cint), handle(), n,
                         Aptrs, lda, pivotArray, info, length(A))
            if( !Pivot )
                pivotArray = ROCArray(zeros(Cint, (n, length(A))))
            end
            pivotArray, info, A
        end
        function getrf_batched(A::Array{ROCMatrix{$elty},1},
                               Pivot::Bool)
            newA = copy(A)
            pivotarray, info = getrf_batched!(newA, Pivot)
            pivotarray, info, newA
        end
    end
end

## getriBatched - performs batched matrix inversion

for (fname, elty) in
        ((:rocblas_dgetriBatched,:Float64),
         (:rocblas_sgetriBatched,:Float32),
         (:rocblas_zgetriBatched,:ComplexF64),
         (:rocblas_cgetriBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgetriBatched(
        #   rocblas_handle handle, int n, double **A,
        #   int lda, int *PivotArray, double **C,
        #   int ldc, int *info, int batchSize)
        function getri_batched(A::Array{ROCMatrix{$elty},1},
                              pivotArray::ROCMatrix{Cint})
            for As in A
                m,n = size(As)
                if m != n
                    throw(DimensionMismatch("All A matrices must be square!"))
                end
            end
            C = ROCMatrix{$elty}[similar(A[1]) for i in 1:length(A)]
            n = size(A[1])[1]
            lda = max(1,stride(A[1],2))
            ldc = max(1,stride(C[1],2))
            Aptrs = device_batch(A)
            Cptrs = device_batch(C)
            info = ROCArray(zeros(Cint,length(A)))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{Ptr{$elty}}, Cint,
                          Ptr{Cint}, Ptr{Ptr{$elty}}, Cint, Ptr{Cint}, Cint),
                         handle(), n, Aptrs, lda, pivotArray, Cptrs,
                         ldc, info, length(A))
            pivotArray, info, C
        end
    end
end

## matinvBatched - performs batched matrix inversion

for (fname, elty) in
        ((:rocblas_dmatinvBatched,:Float64),
         (:rocblas_smatinvBatched,:Float32),
         (:rocblas_zmatinvBatched,:ComplexF64),
         (:rocblas_cmatinvBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dmatinvBatched(
        #   rocblas_handle handle, int n, double **A,
        #   int lda, double **C, int ldc,
        #   int *info, int batchSize)
        function matinv_batched(A::Array{ROCMatrix{$elty},1})
            for As in A
                m,n = size(As)
                if m != n
                    throw(DimensionMismatch("All A matrices must be square!"))
                end
                if n >= 32
                    throw(ArgumentError("matinv requires all matrices be smaller than 32 x 32"))
                end
            end
            C = ROCMatrix{$elty}[similar(A[1]) for i in 1:length(A)]
            n = size(A[1])[1]
            lda = max(1,stride(A[1],2))
            ldc = max(1,stride(C[1],2))
            Aptrs = device_batch(A)
            Cptrs = device_batch(C)
            info = ROCArray(zeros(Cint,length(A)))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Ptr{Ptr{$elty}}, Cint,
                          Ptr{Ptr{$elty}}, Cint, Ptr{Cint}, Cint),
                         handle(), n, Aptrs, lda, Cptrs,
                         ldc, info, length(A))
            info, C
        end
    end
end

## geqrfBatched - performs batched QR factorizations

for (fname, elty) in
        ((:rocblas_dgeqrfBatched,:Float64),
         (:rocblas_sgeqrfBatched,:Float32),
         (:rocblas_zgeqrfBatched,:ComplexF64),
         (:rocblas_cgeqrfBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgeqrfBatched(
        #   rocblas_handle handle, int n, int m,
        #   double **A, int lda, double **TauArray,
        #   int *infoArray, int batchSize)
        function geqrf_batched!(A::Array{ROCMatrix{$elty},1})
            m,n = size(A[1])
            lda = max(1,stride(A[1],2))
            Aptrs = device_batch(A)
            hTauArray = [zeros($elty, min(m,n)) for i in 1:length(A)]
            TauArray = ROCArray{$elty,1}[]
            for i in 1:length(A)
                push!(TauArray,ROCArray(hTauArray[i]))
            end
            Tauptrs = device_batch(TauArray)
            info    = zero(Cint)
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, Cint, Cint, Ptr{Ptr{$elty}},
                          Cint, Ptr{Ptr{$elty}}, Ptr{Cint}, Cint),
                         handle(), m, n, Aptrs, lda,
                         Tauptrs, [info], length(A))
            if( info != 0 )
                throw(ArgumentError,string("Invalid value at ",-info))
            end
            TauArray, A
        end
        function geqrf_batched(A::Array{ROCMatrix{$elty},1})
            geqrf_batched!(copy(A))
        end
    end
end

## gelsBatched - performs batched least squares

for (fname, elty) in
        ((:rocblas_dgelsBatched,:Float64),
         (:rocblas_sgelsBatched,:Float32),
         (:rocblas_zgelsBatched,:ComplexF64),
         (:rocblas_cgelsBatched,:ComplexF32))
    @eval begin
        # rocblas_status_t rocblas_dgelsBatched(
        #   rocblas_handle handle, int m, int n,
        #   int nrhs, double **A, int lda,
        #   double **C, int ldc, int *infoArray,
        #   int *devInfoArray, int batchSize)
        function gels_batched!(trans::Char,
                              A::Array{ROCMatrix{$elty},1},
                              C::Array{ROCMatrix{$elty},1})
            roctrans = rocblasop(trans)
            if( length(A) != length(C) )
                throw(DimensionMismatch(""))
            end
            for (As,Cs) in zip(A,C)
                m,n = size(As)
                mC,nC = size(Cs)
                if( n != mC )
                    throw(DimensionMismatch(""))
                end
            end
            m,n = size(A[1])
            if( m < n )
                throw(ArgumentError("System must be overdetermined"))
            end
            nrhs = size(C[1])[2]
            lda = max(1,stride(A[1],2))
            ldc = max(1,stride(A[1],2))
            Aptrs = device_batch(A)
            Cptrs = device_batch(C)
            info  = zero(Cint)
            infoarray = ROCArray(zeros(Cint, length(A)))
            @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                         (rocblas_handle, rocblas_operation_t, Cint, Cint,
                          Cint, Ptr{Ptr{$elty}}, Cint, Ptr{Ptr{$elty}},
                          Cint, Ptr{Cint}, Ptr{Cint}, Cint),
                         handle(), roctrans, m, n, nrhs, Aptrs, lda,
                         Cptrs, ldc, [info], infoarray, length(A))
            if( info != 0 )
                throw(ArgumentError,string("Invalid value at ",-info))
            end
            A, C, infoarray
        end
        function gels_batched(trans::Char,
                             A::Array{ROCMatrix{$elty},1},
                             C::Array{ROCMatrix{$elty},1})
            gels_batched!(trans, copy(A), copy(C))
        end
    end
end

## dgmm
for (fname, elty) in ((:rocblas_ddgmm,:Float64),
                      (:rocblas_sdgmm,:Float32),
                      (:rocblas_zdgmm,:ComplexF64),
                      (:rocblas_cdgmm,:ComplexF32))
   @eval begin
       # rocblas_status_t rocblas_cdgmm(
       #   rocblas_handle handle, rocblas_side_t mode,
       #   int m, int n,
       #   const rocComplex *A, int lda,
       #   const rocComplex *X, int incx,
       #   rocComplex *C, int ldc)
       function dgmm!(mode::Char,
                      A::ROCMatrix{$elty},
                      X::ROCVector{$elty},
                      C::ROCMatrix{$elty})
           rocside = rocblasside(mode)
           m, n = size(C)
           mA, nA = size(A)
           lx = length(X)
           if ((mA != m) || (nA != n )) throw(DimensionMismatch("")) end
           if ((mode == 'L') && (lx != m)) throw(DimensionMismatch("")) end
           if ((mode == 'R') && (lx != n)) throw(DimensionMismatch("")) end
           lda = max(1,stride(A,2))
           incx = stride(X,1)
           ldc = max(1,stride(C,2))
           @check ccall(($(string(fname)),librocblas), rocblas_status_t,
                        (rocblas_handle, rocblas_side_t, Cint, Cint,
                         Ptr{$elty}, Cint, Ptr{$elty}, Cint, Ptr{$elty}, Cint),
                        handle(), rocside, m, n, A, lda, X, incx, C, ldc)
           C
       end
       function dgmm(mode::Char,
                     A::ROCMatrix{$elty},
                     X::ROCVector{$elty})
           m,n = size(A)
           dgmm!( mode, A, X, similar(A, $elty, (m,n) ) )
       end
    end
end
