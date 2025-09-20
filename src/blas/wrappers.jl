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

# Level 1
## copy
for (fname, elty) in (
    (:rocblas_dcopy,:Float64),
    (:rocblas_scopy,:Float32),
    (:rocblas_zcopy,:ComplexF64),
    (:rocblas_ccopy,:ComplexF32),
)
    @eval begin
        function blascopy!(
            n::Integer, DX::ROCArray{$elty}, incx::Integer,
            DY::ROCArray{$elty}, incy::Integer,
        )
            (; handle, stream) = lib_state()
            $(fname)(handle, n, DX, incx, DY, incy)
            DY
        end
    end
end

## scal
for (fname, elty) in (
    (:rocblas_dscal,:Float64),
    (:rocblas_sscal,:Float32),
    (:rocblas_zscal,:ComplexF64),
    (:rocblas_cscal,:ComplexF32),
)
    @eval begin
        function scal!(n::Integer, DA::$elty, DX::ROCArray{$elty}, incx::Integer)
            (; handle, stream) = lib_state()
            $(fname)(handle, n, Ref(DA), DX, incx)
            DX
        end
    end
end
# In case DX is complex, and DA is real, use dscal/sscal to save flops
for (fname, elty, celty) in ((:rocblas_sscal, :Float32, :ComplexF32),
                             (:rocblas_dscal, :Float64, :ComplexF64))
    @eval begin
        function scal!(n::Integer, DA::$elty, DX::ROCArray{$celty}, incx::Integer)
            (; handle, stream) = lib_state()
            $(fname)(handle, 2*n, Ref(DA), DX, incx)
            DX
        end
    end
end

for (jname, fname, elty) in ((:dot,:rocblas_ddot,:Float64),
                             (:dot,:rocblas_sdot,:Float32),
                             (:dot,:rocblas_hdot,:Float16),
                             (:dotc,:rocblas_zdotc,:ComplexF64),
                             (:dotc,:rocblas_cdotc,:ComplexF32),
                             (:dotu,:rocblas_zdotu,:ComplexF64),
                             (:dotu,:rocblas_cdotu,:ComplexF32))
    @eval begin
        function $jname(
            n::Integer, DX::ROCArray{$elty}, incx::Integer,
            DY::ROCArray{$elty}, incy::Integer,
        )
            result = Ref{$elty}()
            $(fname)(handle(), n, DX, incx, DY, incy, result)
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
        function nrm2(n::Integer, X::ROCArray{$elty}, incx::Integer)
            result = Ref{$ret_type}()
            $(fname)(handle(), n, X, incx, result)
            return result[]
        end
    end
end
# TODO: consider ROCVector and ROCStridedVector
#nrm2(x::StridedVector) = nrm2(length(x), x, stride(x,1))

## asum
for (fname, elty, ret_type) in ((:rocblas_dasum,:Float64,:Float64),
                                (:rocblas_sasum,:Float32,:Float32),
                                (:rocblas_dzasum,:ComplexF64,:Float64),
                                (:rocblas_scasum,:ComplexF32,:Float32))
    @eval begin
        function asum(n::Integer, X::ROCArray{$elty}, incx::Integer)
            result = Ref{$ret_type}()
            $(fname)(handle(), n, X, incx, result)
            return result[]
        end
    end
end

## axpy
for (fname, elty) in ((:rocblas_daxpy,:Float64),
                      (:rocblas_saxpy,:Float32),
                      (:rocblas_haxpy,:Float16),
                      (:rocblas_zaxpy,:ComplexF64),
                      (:rocblas_caxpy,:ComplexF32))
    @eval begin
        function axpy!(
            n::Integer, alpha::($elty), dx::ROCArray{$elty}, incx::Integer,
            dy::ROCArray{$elty}, incy::Integer,
        )
            (; handle, stream) = lib_state()
            $(fname)(handle, n, Ref(alpha), dx, incx, dy, incy)
            dy
        end
    end
end

function axpy!(
    alpha::Ta, x::ROCArray{T}, rx::Union{UnitRange{Ti},AbstractRange{Ti}},
    y::ROCArray{T}, ry::Union{UnitRange{Ti}, AbstractRange{Ti}},
) where {T <: ROCBLASFloat, Ta <: Number, Ti <: Integer}
    length(rx)==length(ry) || throw(DimensionMismatch(""))
    if minimum(rx) < 1 || maximum(rx) > length(x) || minimum(ry) < 1 || maximum(ry) > length(y)
        throw(BoundsError())
    end
    axpy!(
        length(rx), convert(T, alpha),
        pointer(x) + (first(rx) - 1) * sizeof(T), step(rx),
        pointer(y) + (first(ry) - 1) * sizeof(T), step(ry))
    y
end

for (fname, elty, cty, sty) in (
    (:rocblas_srot,  :Float32,    :Float32, :Float32),
    (:rocblas_drot,  :Float64,    :Float64, :Float64),
    (:rocblas_crot,  :ComplexF32, :Float32, :ComplexF32),
    (:rocblas_csrot, :ComplexF32, :Float32, :Float32),
    (:rocblas_zrot,  :ComplexF64, :Float64, :ComplexF64),
    (:rocblas_zdrot, :ComplexF64, :Float64, :Float64),
)
    @eval begin
        function rot!(
            n::Integer, dx::ROCArray{$elty}, incx::Integer, dy::ROCArray{$elty},
            incy::Integer, c::$cty, s::$sty,
        )
            $fname(handle(), n, dx, incx, dy, incy, Ref(c), Ref(s))
            dx, dy
        end
    end
end

# Level 2

for (fname, elty) in ((:rocblas_dgemv,:Float64),
                      (:rocblas_sgemv,:Float32),
                      (:rocblas_zgemv,:ComplexF64),
                      (:rocblas_cgemv,:ComplexF32))
    @eval begin
        function gemv!(
            trans::Char, alpha::($elty), A::ROCMatrix{$elty}, X::ROCVector{$elty},
            beta::($elty), Y::ROCVector{$elty},
        )
            m,n = size(A)
            # check dimensions
            length(X) == (trans == 'N' ? n : m) && length(Y) == (trans == 'N' ? m : n) || throw(DimensionMismatch(""))
            # compute increments
            lda = max(1,stride(A,2))
            incx, incy = stride(X,1), stride(Y,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, trans, m, n, Ref(alpha), A, lda, X, incx, Ref(beta), Y, incy)
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
        function gbmv!(
            trans::Char, m::Integer, kl::Integer, ku::Integer, alpha::($elty),
            A::ROCMatrix{$elty}, x::ROCVector{$elty}, beta::($elty), y::ROCVector{$elty},
        )
            n = size(A, 2)
            # check dimensions
            length(x) == (trans == 'N' ? n : m) && length(y) == (trans == 'N' ? m : n) || throw(DimensionMismatch(""))
            # compute increments
            lda = max(1, stride(A, 2))
            incx, incy = stride(x, 1), stride(y, 1)
            (; handle, stream) = lib_state()
            $(fname)(handle, trans, m, n, kl, ku, Ref(alpha), A, lda, x, incx, Ref(beta), y, incy)
            y
        end
        function gbmv(
            trans::Char, m::Integer, kl::Integer, ku::Integer, alpha::($elty),
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
            # TODO: fix gbmv bug in julia
            n = size(A,2)
            leny = trans == 'N' ? m : n
            gbmv!(trans, m, kl, ku, alpha, A, x, zero($elty), similar(x, $elty, leny))
        end
        function gbmv(
            trans::Char, m::Integer, kl::Integer, ku::Integer,
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
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
        function symv!(
            uplo::Char, alpha::($elty), A::ROCMatrix{$elty}, x::ROCVector{$elty},
            beta::($elty), y::ROCVector{$elty},
        )
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if m != length(x) || m != length(y) throw(DimensionMismatch("")) end
            lda = max(1, stride(A, 2))
            incx, incy = stride(x, 1), stride(y,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, Ref(alpha), A, lda, x, incx, Ref(beta), y, incy)
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
        function hemv!(
            uplo::Char, alpha::$elty, A::ROCMatrix{$elty}, x::ROCVector{$elty},
            beta::$elty, y::ROCVector{$elty},
        )
            # TODO: fix dimension check bug in julia
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if m != length(x) || m != length(y) throw(DimensionMismatch("")) end
            lda = max(1, stride(A, 2))
            incx, incy = stride(x, 1), stride(y, 1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, Ref(alpha), A, lda, x, incx, Ref(beta), y, incy)
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
        function sbmv!(
            uplo::Char, k::Integer, alpha::($elty), A::ROCMatrix{$elty},
            x::ROCVector{$elty}, beta::($elty), y::ROCVector{$elty},
        )
            m, n = size(A)
            #if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) || n != length(y) throw(DimensionMismatch("")) end
            lda = max(1, stride(A, 2))
            incx, incy = stride(x, 1), stride(y, 1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, k, Ref(alpha), A, lda, x, incx, Ref(beta), y, incy)
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
        function hbmv!(
            uplo::Char, k::Integer, alpha::($elty), A::ROCMatrix{$elty},
            x::ROCVector{$elty}, beta::($elty), y::ROCVector{$elty},
        )
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) || n != length(y) throw(DimensionMismatch("")) end
            lda = max(1,stride(A, 2))
            incx, incy = stride(x, 1), stride(y, 1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, k, Ref(alpha), A, lda, x, incx, Ref(beta), y, incy)
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
        function tbmv!(
            uplo::Char, trans::Char, diag::Char, k::Integer,
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, diag, n, k, A, lda, x, incx)
            x
        end
        function tbmv(
            uplo::Char, trans::Char, diag::Char,
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
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
        function tbsv!(
            uplo::Char, trans::Char, diag::Char, k::Integer,
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
            m, n = size(A)
            if !(1<=(1+k)<=n) throw(DimensionMismatch("Incorrect number of bands")) end
            if m < 1+k throw(DimensionMismatch("Array A has fewer than 1+k rows")) end
            if n != length(x) throw(DimensionMismatch("")) end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, diag, n, k, A, lda, x, incx)
            x
        end
        function tbsv(
            uplo::Char, trans::Char, diag::Char, k::Integer,
            A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
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
        function trmv!(
            uplo::Char, trans::Char, diag::Char, A::ROCMatrix{$elty}, x::ROCVector{$elty},
        )
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if n != length(x)
                throw(DimensionMismatch("length(x)=$(length(x)) does not match size(A)=$(size(A))"))
            end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, diag, n, A, lda, x, incx)
            x
        end
        function trmv(uplo::Char, trans::Char, diag::Char, A::ROCMatrix{$elty}, x::ROCVector{$elty})
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
        function trsv!(uplo::Char, trans::Char, diag::Char, A::ROCMatrix{$elty}, x::ROCVector{$elty})
            m, n = size(A)
            if m != n throw(DimensionMismatch("Matrix A is $m by $n but must be square")) end
            if n != length(x)
                throw(DimensionMismatch("length(x)=$(length(x)) does not match size(A)=$(size(A))"))
            end
            lda = max(1,stride(A,2))
            incx = stride(x,1)
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, diag, n, A, lda, x, incx)
            x
        end
        function trsv(uplo::Char, trans::Char, diag::Char, A::ROCMatrix{$elty}, x::ROCVector{$elty})
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
        function ger!(alpha::$elty, x::ROCVector{$elty}, y::ROCVector{$elty}, A::ROCMatrix{$elty})
            m, n = size(A)
            m == length(x) || throw(DimensionMismatch(""))
            n == length(y) || throw(DimensionMismatch(""))
            incx = stride(x,1)
            incy = stride(y,1)
            lda = max(1,stride(A,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, m, n, Ref(alpha), x, incx, y, incy, A, lda)
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
        function syr!(uplo::Char, alpha::$elty, x::ROCVector{$elty}, A::ROCMatrix{$elty})
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            lda = max(1,stride(A,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, Ref(alpha), x, incx, A, lda)
            A
        end
    end
end

### her
for (fname, elty) in ((:rocblas_zher,:ComplexF64),
                      (:rocblas_cher,:ComplexF32))
    @eval begin
        function her!(uplo::Char, alpha::$elty, x::ROCVector{$elty}, A::ROCMatrix{$elty})
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            lda = max(1,stride(A,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, Ref(alpha), x, incx, A, lda)
            A
        end
    end
end

### her2
for (fname, elty) in ((:rocblas_zher2,:ComplexF64),
                      (:rocblas_cher2,:ComplexF32))
    @eval begin
        function her2!(
            uplo::Char, alpha::$elty, x::ROCVector{$elty},
            y::ROCVector{$elty}, A::ROCMatrix{$elty},
        )
            m, n = size(A)
            m == n || throw(DimensionMismatch("Matrix A is $m by $n but must be square"))
            length(x) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            length(y) == n || throw(DimensionMismatch("Length of vector must be the same as the matrix dimensions"))
            incx = stride(x,1)
            incy = stride(y,1)
            lda = max(1,stride(A,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, n, Ref(alpha), x, incx, y, incy, A, lda)
            A
        end
    end
end

# Level 3
## (GE) general matrix-matrix multiplication
for (fname, elty) in (
    (:rocblas_dgemm,:Float64),
    (:rocblas_sgemm,:Float32),
    (:rocblas_hgemm,:Float16),
    (:rocblas_zgemm,:ComplexF64),
    (:rocblas_cgemm,:ComplexF32),
)
    @eval begin
        function gemm!(
            transA::Char, transB::Char, alpha::($elty),
            A::StridedROCVecOrMat{$elty}, B::StridedROCVecOrMat{$elty}, beta::($elty),
            C::StridedROCVecOrMat{$elty},
        )
            m = size(A, transA == 'N' ? 1 : 2)
            k = size(A, transA == 'N' ? 2 : 1)
            n = size(B, transB == 'N' ? 2 : 1)
            if m != size(C,1) || n != size(C,2) || k != size(B, transB == 'N' ? 1 : 2)
                throw(DimensionMismatch(""))
            end

            lda = max(1, stride(A, 2))
            ldb = max(1, stride(B, 2))
            ldc = max(1, stride(C, 2))
            (; handle, stream) = lib_state()
            $(fname)(handle, transA, transB,
                     m, n, k, Ref(alpha), A, lda, B, ldb, Ref(beta), C, ldc)
            C
        end
        function gemm(
            transA::Char, transB::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
        )
            gemm!(transA, transB, alpha, A, B, zero($elty),
                  similar(B, $elty, (size(A, transA == 'N' ? 1 : 2),
                                     size(B, transB == 'N' ? 2 : 1))))
        end
        function gemm(transA::Char, transB::Char, A::ROCMatrix{$elty}, B::ROCMatrix{$elty})
            gemm(transA, transB, one($elty), A, B)
        end
    end
end

# helper function to get a device array of device pointers
function device_batch(batch::Array{T}) where T <: ROCArray
    E = eltype(T)
    ROCArray([convert(Ptr{E}, arr.buf[]) for arr in batch])
end

function device_batch(x::AnyROCArray{T, 3}) where T
    shift = size(x, 1) * size(x, 2) * sizeof(T)
    buf = convert(AMDGPU.Mem.AbstractAMDBuffer, x.buf[])
    ROCArray([
        convert(Ptr{T}, AMDGPU.Mem.view(buf, shift * (i - 1)))
        for i in 1:size(x, 3)])
end

function device_batch(x::AnyROCArray{T, 3}, batch_count::Int) where T
    ptr = convert(Ptr{T}, x.buf[])
    ROCArray([ptr for i in 1:batch_count])
end

@inline function _check_gemm_batched_dims(transA::Char, transB::Char, A, B, C)
    a_broadcast = (size(A, 3) == 1) && (size(C, 3) > 1)
    b_broadcast = (size(B, 3) == 1) && (size(C, 3) > 1)
    is_valid =
        !(a_broadcast && b_broadcast) && # Either `A` or `B` can have size(X, 3) == 1
        ((size(A, 3) == 1) || (size(A, 3) == size(C, 3))) &&
        ((size(B, 3) == 1) || (size(B, 3) == size(C, 3)))
    if !is_valid
        throw(DimensionMismatch(
            "`A`, `B`, `C` must be either:\n" *
            "- All 3D with last dimension (batch count) equal.\n" *
            "- `A` or `B` can be 2D matrix.\n" *
            "Instead:\n" *
            "- size(A)=$(size(A))\n" *
            "- size(B)=$(size(B))\n" *
            "- size(C)=$(size(C))\n"))
    end
    m, k = size(A, transA == 'N' ? 1 : 2), size(A, transA == 'N' ? 2 : 1)
    n, g = size(B, transB == 'N' ? 2 : 1), size(B, transB == 'N' ? 1 : 2)
    if m != size(C, 1) || n != size(C, 2) || k != g
        throw(DimensionMismatch(
            "Invalid dimensions for `A`, `B` and `C`.\n" *
            "- size(A)=$(size(A)), transA=$transA \n" *
            "- size(B)=$(size(B)), transB=$transB \n" *
            "- size(C)=$(size(C))\n"))
    end
    lda = max(1, stride(A, 2))
    ldb = max(1, stride(B, 2))
    ldc = max(1, stride(C, 2))
    m, k, n, lda, ldb, ldc
end

@inline function _check_gemm_batched_dims(
    transA::Char, transB::Char, A::Array, B::Array, C::Array,
)
    if length(A) != length(B) || length(A) != length(C)
        throw(DimensionMismatch(
            "Batch count must be the same for `A`, `B` and `C`, instead:\n" *
            "- length(A)=$(length(A))\n" *
            "- length(B)=$(length(B))\n" *
            "- length(C)=$(length(C))\n"))
    end
    for (i, (As, Bs, Cs)) in enumerate(zip(A, B, C))
        m, k = size(As, transA == 'N' ? 1 : 2), size(As, transA == 'N' ? 2 : 1)
        n, g = size(Bs, transB == 'N' ? 2 : 1), size(Bs, transB == 'N' ? 1 : 2)
        if m != size(Cs, 1) || n != size(Cs, 2) || k != g
            throw(DimensionMismatch(
                "Invalid dimensions for $i-th entry in `A`, `B` and `C`.\n" *
                "- size(A[$i])=$(size(As)), transA=$transA \n" *
                "- size(B[$i])=$(size(Bs)), transB=$transB \n" *
                "- size(C[$i])=$(size(Cs))\n"))
        end
    end
    lda = max(1, stride(A[1], 2))
    ldb = max(1, stride(B[1], 2))
    ldc = max(1, stride(C[1], 2))
    m, k, n, lda, ldb, ldc
end

## (GE) general matrix-matrix multiplication batched
for (fname, elty) in
        ((:rocblas_dgemm_batched,:Float64),
         (:rocblas_sgemm_batched,:Float32),
         (:rocblas_hgemm_batched,:Float16),
         (:rocblas_zgemm_batched,:ComplexF64),
         (:rocblas_cgemm_batched,:ComplexF32))
    @eval begin
        function gemm_batched!(
            transA::Char, transB::Char,
            alpha::($elty), A::ROCArray{$elty, 3},
            B::ROCArray{$elty, 3}, beta::($elty), C::ROCArray{$elty, 3},
        )
            m, k, n, lda, ldb, ldc = _check_gemm_batched_dims(
                transA, transB, A, B, C)

            batch_count = size(C, 3)
            a_broadcast = (size(A, 3) == 1) && (batch_count > 1)
            b_broadcast = (size(B, 3) == 1) && (batch_count > 1)
            Ab = a_broadcast ? device_batch(A, batch_count) : device_batch(A)
            Bb = b_broadcast ? device_batch(B, batch_count) : device_batch(B)
            Cb = device_batch(C)

            (; handle, stream) = lib_state()
            $(fname)(
                handle, transA, transB,
                m, n, k, Ref(alpha), Ab, lda, Bb, ldb, Ref(beta),
                Cb, ldc, batch_count)
            C
        end
        function gemm_batched(
            transA::Char, transB::Char, alpha::($elty), A::T, B::K,
        ) where {
            T <: Union{AnyROCArray{$elty, 3}, Vector{ROCMatrix{$elty}}},
            K <: Union{AnyROCArray{$elty, 3}, Vector{ROCMatrix{$elty}}},
        }
            is_ab_vec = Int(T <: Vector) + Int(K <: Vector)
            (is_ab_vec != 0) && (is_ab_vec != 2) && throw(ArgumentError(
                "If `A` is a `Vector{ROCMatrix}`, then `B` must be too."))
            if T isa Vector
                C = ROCMatrix{$elty}[similar(B[i], $elty, (
                    size(A[i], transA == 'N' ? 1 : 2),
                    size(B[i], transB == 'N' ? 2 : 1))) for i in 1:length(A)]
            else
                m = size(A, transA == 'N' ? 1 : 2)
                k = size(B, transB == 'N' ? 2 : 1)
                C = similar(A, $elty, (m, k, max(size(A, 3), size(B, 3))))
            end
            gemm_batched!(transA, transB, alpha, A, B, zero($elty), C)
        end
        function gemm_batched(transA::Char, transB::Char, A::T, B::K) where {
            T <: Union{AnyROCArray{$elty, 3}, Vector{ROCMatrix{$elty}}},
            K <: Union{AnyROCArray{$elty, 3}, Vector{ROCMatrix{$elty}}},
        }
            gemm_batched(transA, transB, one($elty), A, B)
        end
    end
end


## (GE) general matrix-matrix multiplication strided batched
for (fname, elty) in
        ((:rocblas_dgemm_strided_batched,:Float64),
         (:rocblas_sgemm_strided_batched,:Float32),
         (:rocblas_zgemm_strided_batched,:ComplexF64),
         (:rocblas_cgemm_strided_batched,:ComplexF32))
    @eval begin
        function gemm_strided_batched!(
            transA::Char, transB::Char, alpha::($elty),
            A::ROCArray{$elty, 3}, B::ROCArray{$elty, 3},
            beta::($elty), C::ROCArray{$elty, 3},
        )
           m = size(A, transA == 'N' ? 1 : 2)
           k = size(A, transA == 'N' ? 2 : 1)
           n = size(B, transB == 'N' ? 2 : 1)
           @assert size(A, 3) == size(B, 3) == size(C, 3) "Batch size mismatch"

           if m != size(C,1) || n != size(C,2) || k != size(B, transB == 'N' ? 1 : 2)
               throw(DimensionMismatch(""))
           end
           lda = max(1,stride(A,2))
           ldb = max(1,stride(B,2))
           ldc = max(1,stride(C,2))

           strideA = stride(A, 3)
           strideB = stride(B, 3)
           strideC = stride(C, 3)
           batchCount = size(A, 3)
           (; handle, stream) = lib_state()
           $(fname)(handle, transA, transB, m, n, k, Ref(alpha), A, lda, strideA, B, ldb, strideB, Ref(beta), C, ldc, strideC, batchCount)
           C
        end
        function gemm_strided_batched(
            transA::Char, transB::Char, alpha::($elty),
            A::ROCArray{$elty, 3}, B::ROCArray{$elty, 3},
        )
            C = similar(B, (size(A, transA == 'N' ? 1 : 2), size(B, transB == 'N' ? 2 : 1), size(A, 3)))
            gemm_strided_batched!(transA, transB, alpha, A, B, zero($elty), C)
        end
        function gemm_strided_batched(
            transA::Char, transB::Char, A::ROCArray{$elty, 3}, B::ROCArray{$elty, 3},
        )
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
        function symm!(
            side::Char, uplo::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
            beta::($elty), C::ROCMatrix{$elty},
        )
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
            (; handle, stream) = lib_state()
            $(fname)(handle, side, uplo, m, n, Ref(alpha), A, lda, B, ldb, Ref(beta), C, ldc)
            C
        end
        function symm(
            side::Char, uplo::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
        )
            symm!(side, uplo, alpha, A, B, zero($elty), similar(B))
        end
        function symm(side::Char, uplo::Char, A::ROCMatrix{$elty}, B::ROCMatrix{$elty})
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
        function syrk!(
            uplo::Char, trans::Char, alpha::($elty),
            A::StridedROCVecOrMat{$elty}, beta::($elty), C::StridedROCMatrix{$elty},
        )
            mC, n = size(C)
            if mC != n throw(DimensionMismatch("C must be square")) end
            nn = size(A, trans == 'N' ? 1 : 2)
            if nn != n throw(DimensionMismatch("syrk!")) end
            k  = size(A, trans == 'N' ? 2 : 1)
            lda = max(1,stride(A,2))
            ldc = max(1,stride(C,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, n, k, Ref(alpha), A, lda, Ref(beta), C, ldc)
            C
        end
    end
end
function syrk(uplo::Char, trans::Char, alpha::Number, A::ROCVecOrMat)
    T = eltype(A)
    n = size(A, trans == 'N' ? 1 : 2)
    syrk!(uplo, trans, convert(T,alpha), A, zero(T), similar(A, T, (n, n)))
end
syrk(uplo::Char, trans::Char, A::ROCVecOrMat) = syrk(uplo, trans, one(eltype(A)), A)

## hemm
for (fname, elty) in ((:rocblas_zhemm,:ComplexF64),
                      (:rocblas_chemm,:ComplexF32))
    @eval begin
        function hemm!(
            side::Char, uplo::Char, alpha::($elty), A::ROCMatrix{$elty},
            B::ROCMatrix{$elty}, beta::($elty), C::ROCMatrix{$elty},
        )
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
            (; handle, stream) = lib_state()
            $(fname)(handle, side, uplo, m, n, Ref(alpha), A, lda, B, ldb, Ref(beta), C, ldc)
            C
        end
        function hemm(uplo::Char, trans::Char, alpha::($elty), A::ROCMatrix{$elty}, B::ROCMatrix{$elty})
            m,n = size(B)
            hemm!( uplo, trans, alpha, A, B, zero($elty), similar(B, $elty, (m,n) ) )
        end
        hemm( uplo::Char, trans::Char, A::ROCMatrix{$elty}, B::ROCMatrix{$elty}) =
            hemm( uplo, trans, one($elty), A, B)
    end
end

## herk
for (fname, elty) in ((:rocblas_zherk,:ComplexF64),
                      (:rocblas_cherk,:ComplexF32))
    @eval begin
        function herk!(
            uplo::Char, trans::Char, alpha::($elty), A::ROCVecOrMat{$elty},
            beta::($elty), C::ROCMatrix{$elty},
        )
            mC, n = size(C)
            if mC != n throw(DimensionMismatch("C must be square")) end
            nn = size(A, trans == 'N' ? 1 : 2)
            if nn != n throw(DimensionMismatch("syrk!")) end
            k  = size(A, trans == 'N' ? 2 : 1)
            lda = max(1,stride(A,2))
            ldc = max(1,stride(C,2))
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, n, k, Ref(alpha), A, lda, Ref(beta), C, ldc)
            C
        end
        function herk(uplo::Char, trans::Char, alpha::($elty), A::ROCVecOrMat{$elty})
            n = size(A, trans == 'N' ? 1 : 2)
            herk!(uplo, trans, alpha, A, zero($elty), similar(A, $elty, (n,n)))
        end
        herk(uplo::Char, trans::Char, A::ROCVecOrMat{$elty}) =
            herk(uplo, trans, one($elty), A)
   end
end

## syr2k
for (fname, elty) in ((:rocblas_dsyr2k,:Float64),
                      (:rocblas_ssyr2k,:Float32),
                      (:rocblas_zsyr2k,:ComplexF64),
                      (:rocblas_csyr2k,:ComplexF32))
    @eval begin
        function syr2k!(
            uplo::Char, trans::Char, alpha::($elty), A::ROCVecOrMat{$elty},
            B::ROCVecOrMat{$elty}, beta::($elty), C::ROCMatrix{$elty},
        )
            # TODO: check size of B in julia (syr2k!)
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
            (; handle, stream) = lib_state()
            $(fname)(handle, uplo, trans, n, k, Ref(alpha), A, lda, B, ldb, Ref(beta), C, ldc)
            C
        end
    end
end
function syr2k(uplo::Char, trans::Char, alpha::Number, A::ROCVecOrMat, B::ROCVecOrMat)
    T = eltype(A)
    n = size(A, trans == 'N' ? 1 : 2)
    syr2k!(uplo, trans, convert(T,alpha), A, B, zero(T), similar(A, T, (n, n)))
end
syr2k(uplo::Char, trans::Char, A::ROCVecOrMat, B::ROCVecOrMat) =
    syr2k(uplo, trans, one(eltype(A)), A, B)

## her2k
for (fname, elty1, elty2) in ((:rocblas_zher2k,:ComplexF64,:Float64),
                              (:rocblas_cher2k,:ComplexF32,:Float32))
    @eval begin
        function her2k!(
            uplo::Char, trans::Char, alpha::($elty1), A::ROCVecOrMat{$elty1},
            B::ROCVecOrMat{$elty1}, beta::($elty2), C::ROCMatrix{$elty1},
        )
           # TODO: check size of B in julia (her2k!)
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
           (; handle, stream) = lib_state()
           $(fname)(handle, uplo, trans, n, k, Ref(alpha), A, lda, B, ldb, Ref(beta), C, ldc)
           C
        end
        function her2k(
            uplo::Char, trans::Char, alpha::($elty1),
            A::ROCVecOrMat{$elty1}, B::ROCVecOrMat{$elty1},
        )
           n = size(A, trans == 'N' ? 1 : 2)
           her2k!(uplo, trans, alpha, A, B, zero($elty2), similar(A, $elty1, (n,n)))
        end
        her2k(uplo::Char, trans::Char, A::ROCVecOrMat{$elty1}, B::ROCVecOrMat{$elty1}) =
            her2k(uplo, trans, one($elty1), A, B)
   end
end

## (TR) Triangular matrix and vector multiplication and solution
for (mmname, smname, elty) in
        ((:rocblas_dtrmm,:rocblas_dtrsm,:Float64),
         (:rocblas_strmm,:rocblas_strsm,:Float32),
         (:rocblas_ztrmm,:rocblas_ztrsm,:ComplexF64),
         (:rocblas_ctrmm,:rocblas_ctrsm,:ComplexF32))
    @eval begin
        function trmm!(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty}, C::ROCMatrix{$elty},
        )
            m, n = size(B)
            mA, nA = size(A)
            # TODO: clean up error messages
            if mA != nA throw(DimensionMismatch("A must be square")) end
            if nA != (side == 'L' ? m : n) throw(DimensionMismatch("trmm!")) end
            lda = max(1, stride(A, 2))
            ldb = max(1, stride(B, 2))
            ldc = max(1, stride(C, 2))
            (; handle, stream) = lib_state()
            $(mmname)(
                handle, side, uplo, transa, diag, m, n, Ref(alpha),
                A, lda, B, ldb, C, ldc)
            C
        end
        function trmm(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
        )
            trmm!(side, uplo, transa, diag, alpha, A, B, similar(B))
        end
        function trsm!(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
        )
            m, n = size(B)
            mA, nA = size(A)
            # TODO: clean up error messages
            if mA != nA throw(DimensionMismatch("A must be square")) end
            if nA != (side == 'L' ? m : n) throw(DimensionMismatch("trsm!")) end
            lda = max(1,stride(A,2))
            ldb = max(1,stride(B,2))
            (; handle, stream) = lib_state()
            $(smname)(handle, side, uplo, transa, diag, m, n, Ref(alpha), A, lda, B, ldb)
            B
        end
        function trsm(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::ROCMatrix{$elty}, B::ROCMatrix{$elty},
        )
            trsm!(side, uplo, transa, diag, alpha, A, copy(B))
        end
    end
end

## (TR) triangular triangular matrix solution batched
for (fname, elty) in
        ((:rocblas_dtrsm_batched,:Float64),
         (:rocblas_strsm_batched,:Float32),
         (:rocblas_ztrsm_batched,:ComplexF64),
         (:rocblas_ctrsm_batched,:ComplexF32))
    @eval begin
        function trsm_batched!(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::Array{ROCMatrix{$elty},1}, B::Array{ROCMatrix{$elty},1},
        )
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
            (; handle, stream) = lib_state()
            $(fname)(handle, side, uplo, transa, diag, m, n, Ref(alpha), Aptrs, lda, Bptrs, ldb, length(A))
            B
        end
        function trsm_batched(
            side::Char, uplo::Char, transa::Char, diag::Char, alpha::($elty),
            A::Array{ROCMatrix{$elty},1}, B::Array{ROCMatrix{$elty},1},
        )
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
        function geam!(
            transa::Char, transb::Char, alpha::($elty), A::ROCMatrix{$elty},
            beta::($elty), B::ROCMatrix{$elty}, C::ROCMatrix{$elty},
        )
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
           (; handle, stream) = lib_state()
           $(fname)(handle, transa, transb, m, n, Ref(alpha), A, lda, Ref(beta), B, ldb, C, ldc)
           C
        end
        function geam(
            transa::Char, transb::Char, alpha::($elty), A::ROCMatrix{$elty},
            beta::($elty), B::ROCMatrix{$elty},
        )
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

## dgmm
for (fname, elty) in ((:rocblas_ddgmm,:Float64),
                      (:rocblas_sdgmm,:Float32),
                      (:rocblas_zdgmm,:ComplexF64),
                      (:rocblas_cdgmm,:ComplexF32))
   @eval begin
       function dgmm!(
           mode::Char, A::ROCMatrix{$elty}, X::ROCVector{$elty}, C::ROCMatrix{$elty},
        )
           m, n = size(C)
           mA, nA = size(A)
           lx = length(X)
           if ((mA != m) || (nA != n )) throw(DimensionMismatch("")) end
           if ((mode == 'L') && (lx != m)) throw(DimensionMismatch("")) end
           if ((mode == 'R') && (lx != n)) throw(DimensionMismatch("")) end
           lda = max(1,stride(A,2))
           incx = stride(X,1)
           ldc = max(1,stride(C,2))
           (; handle, stream) = lib_state()
           $(fname)(handle, mode, m, n, A, lda, X, incx, C, ldc)
           C
       end
       function dgmm(mode::Char, A::ROCMatrix{$elty}, X::ROCVector{$elty})
           m,n = size(A)
           dgmm!(mode, A, X, similar(A, $elty, (m,n) ) )
       end
    end
end
