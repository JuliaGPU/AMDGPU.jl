# generic APIs

## API functions

function sparsetodense(A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, index::SparseChar,
                       algo::rocsparse_sparse_to_dense_alg=rocsparse_sparse_to_dense_alg_default) where {T}
    m,n = size(A)
    B = ROCMatrix{T}(undef, m, n)
    desc_sparse = ROCSparseMatrixDescriptor(A, index)
    desc_dense = ROCDenseMatrixDescriptor(B)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_sparse_to_dense(handle(), desc_sparse, desc_dense, algo, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        rocsparse_sparse_to_dense(handle(), desc_sparse, desc_dense, algo, buffer_size, buffer)
    end
    return B
end

function densetosparse(A::ROCMatrix{T}, fmt::Symbol, index::SparseChar,
                       algo::rocsparse_dense_to_sparse_alg=rocsparse_dense_to_sparse_alg_default) where {T}
    m,n = size(A)
    desc_sparse, offsets = if fmt == :coo
        ROCSparseMatrixDescriptor(ROCSparseMatrixCOO, T, Cint, m, n, index), nothing
    elseif fmt == :csr
        rowPtr = ROCVector{Cint}(undef, m+1)
        ROCSparseMatrixDescriptor(ROCSparseMatrixCSR, rowPtr, T, Cint, m, n, index), rowPtr
    elseif fmt == :csc
        colPtr = ROCVector{Cint}(undef, n+1)
        ROCSparseMatrixDescriptor(ROCSparseMatrixCSC, colPtr, T, Cint, m, n, index), colPtr
    else
        error("Format :$fmt not available, use :csc, :csr or :coo.")
    end
    desc_dense = ROCDenseMatrixDescriptor(A)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    return with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        # Analysis
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, C_NULL, buffer)
        nnzB = Ref{Int64}()
        rocsparse_spmat_get_size(desc_sparse, Ref{Int64}(), Ref{Int64}(), nnzB)
        if fmt == :coo
            rowInd = ROCVector{Cint}(undef, nnzB[])
            colInd = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCOO{T, Cint}(rowInd, colInd, nzVal, (m,n))
            rocsparse_coo_set_pointers(desc_sparse, B.rowInd, B.colInd, B.nzVal)
        elseif fmt == :csr
            colVal = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCSR{T, Cint}(offsets, colVal, nzVal, (m,n))
            rocsparse_csr_set_pointers(desc_sparse, B.rowPtr, B.colVal, B.nzVal)
        elseif fmt == :csc
            rowVal = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCSC{T, Cint}(offsets, rowVal, nzVal, (m,n))
            rocsparse_csc_set_pointers(desc_sparse, B.colPtr, B.rowVal, B.nzVal)
        else
            error("Format :$fmt not available, use :csc, :csr or :coo.")
        end
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, buffer_size, buffer)
        B
    end
end

function gather!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_gather(handle(), descY, descX)
    X
end

function scatter!(Y::ROCVector, X::ROCSparseVector, index::SparseChar)
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_scatter(handle(), descX, descY)
    return Y
end

function axpby!(alpha::Number, X::ROCSparseVector{T}, beta::Number, Y::ROCVector{T}, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_axpby(handle(), Ref{T}(alpha), descX, Ref{T}(beta), descY)
    return Y
end

function rot!(X::ROCSparseVector{T}, Y::ROCVector{T}, c::Number, s::Number, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_rot(handle(), Ref{T}(c), Ref{T}(s), descX, descY)
    return X, Y
end

function vv!(transx::SparseChar, X::ROCSparseVector{T}, Y::DenseROCVector{T}, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    result = Ref{T}()

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spvv(handle(), transx, descX, descY, result, T, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        rocsparse_spvv(handle(), transx, descX, descY, result, T, buffer_size, buffer)
    end
    return result[]
end

# The state that `rocsparse_spmv` or `rocsparse_spmm` keeps between the products of one sparse
# matrix that share `key`. The analysis of the sparsity pattern lives in `descA`; `descX` and
# `descY` are pointed at the dense operands of each product in turn.
#
# TODO: move `mv!` to `rocsparse_v2_spmv` (ROCm 7.0 and later), which replaces the deprecated
# `rocsparse_spmv` and keeps the analysis in a `rocsparse_spmv_descr` of its own instead of in
# `descA`. There is no such routine for `rocsparse_spmm`.
struct AnalysisPlan{K,D}
    key::K
    descA::ROCSparseMatrixDescriptor
    descX::D
    descY::D
    buffer::ROCVector{UInt8}
    buffer_size::Base.RefValue{Csize_t}
end

# What distinguishes the analyses of the matrix-vector products of one sparse matrix: the
# operation, index base and algorithm.
const SpMVKey = Tuple{SparseChar, SparseChar, rocsparse_spmv_alg}

# For the sparse-dense matrix products: the operations, index base and algorithm, whether the
# sparse and the dense operands are described through their transposes, and the sizes and
# leading dimensions of the dense ones.
const SpMMKey = Tuple{
    SparseChar, SparseChar, SparseChar, rocsparse_spmm_alg, Bool, Bool,
    NTuple{2,Int}, Int, NTuple{2,Int}, Int}

const SpMVPlan = AnalysisPlan{SpMVKey, ROCDenseVectorDescriptor}
const SpMMPlan = AnalysisPlan{SpMMKey, ROCDenseMatrixDescriptor}

plan_type(::SpMVKey) = SpMVPlan
plan_type(::SpMMKey) = SpMMPlan

function AnalysisPlan(
    key::SpMVKey, A::AnalyzedMatrix, X::DenseROCVector{T}, Y::DenseROCVector{T},
) where T
    transa, index, algo = key
    descA = ROCSparseMatrixDescriptor(A, index)
    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)
    # the scalars only matter to the compute stage
    alpha, beta = Ref{T}(1), Ref{T}(0)
    buffer_size = Ref{Csize_t}()
    rocsparse_spmv(
        handle(), transa, alpha, descA, descX, beta, descY, T, algo,
        rocsparse_spmv_stage_buffer_size, buffer_size, C_NULL)
    buffer = ROCVector{UInt8}(undef, Int(buffer_size[]))
    rocsparse_spmv(
        handle(), transa, alpha, descA, descX, beta, descY, T, algo,
        rocsparse_spmv_stage_preprocess, buffer_size, buffer)
    return AnalysisPlan(key, descA, descX, descY, buffer, buffer_size)
end

function AnalysisPlan(
    key::SpMMKey, A::AnalyzedMatrix, B::DenseROCMatrix{T}, C::DenseROCMatrix{T},
) where T
    transa, transb, index, algo, sparse_transposed, dense_transposed = key
    descA = ROCSparseMatrixDescriptor(A, index; transposed=sparse_transposed)
    descB = ROCDenseMatrixDescriptor(B; transposed=dense_transposed)
    descC = ROCDenseMatrixDescriptor(C; transposed=dense_transposed)
    # the scalars only matter to the compute stage
    alpha, beta = Ref{T}(1), Ref{T}(0)
    buffer_size = Ref{Csize_t}()
    rocsparse_spmm(
        handle(), transa, transb, alpha, descA, descB, beta, descC, T, algo,
        rocsparse_spmm_stage_buffer_size, buffer_size, C_NULL)
    buffer = ROCVector{UInt8}(undef, Int(buffer_size[]))
    rocsparse_spmm(
        handle(), transa, transb, alpha, descA, descB, beta, descC, T, algo,
        rocsparse_spmm_stage_preprocess, buffer_size, buffer)
    return AnalysisPlan(key, descA, descB, descC, buffer, buffer_size)
end

# A matrix keeps this many plans, the most recently used ones. Dense operands of ever new
# sizes would otherwise add a plan each.
const MAX_ANALYSIS_PLANS = 8

# The plan cached on `A` for the product of `key` with the dense operands `X` and `Y`,
# analyzing `A` if there is none yet. Call with `A.analysis_cache.lock` held.
function analysis_plan(key, A::AnalyzedMatrix, X, Y)
    P = plan_type(key)
    plans = A.analysis_cache.plans
    for (i, plan) in enumerate(plans)
        # `plans` holds both kinds of plan; the check on the concrete type makes the
        # accesses below static
        plan isa P || continue
        plan.key == key || continue
        if i != lastindex(plans)
            deleteat!(plans, i)
            push!(plans, plan)
        end
        return plan
    end
    plan = AnalysisPlan(key, A, X, Y)::P
    length(plans) >= MAX_ANALYSIS_PLANS && popfirst!(plans)
    push!(plans, plan)
    return plan
end

"""
    mv!(
        transa::SparseChar, alpha::Number,
        A::Union{ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO},
        X::ROCVector, beta::Number, Y::ROCVector, index::SparseChar,
        algo::rocsparse_spmv_alg = rocsparse_spmv_alg_default)

Performs `Y = alpha * op(A) * X + beta * Y` with `rocsparse_spmv`.

rocSPARSE analyzes the sparsity pattern of `A` before the first product. With the ROCm 6
runtime and later, that analysis is kept on `A` and reused by the following products with the
same `transa`, `index` and `algo`. It is discarded when a field of `A` is assigned or `A` is
the destination of `copyto!`. After writing new indices into the index arrays of `A` in
place, call [`reset_analysis_cache!`](@ref).
"""
function mv!(
    transa::SparseChar, alpha::Number, A::Union{ROCSparseMatrixCSR{T}, ROCSparseMatrixCSC{T}, ROCSparseMatrixCOO{T}},
    X::DenseROCVector{T}, beta::Number, Y::DenseROCVector{T}, index::SparseChar,
    algo::rocsparse_spmv_alg = rocsparse_spmv_alg_default,
) where T

    # Support transa = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa

    m,n = size(A)
    if transa == 'N'
        chkmvdims(X,n,Y,m)
    elseif transa == 'T' || transa == 'C'
        chkmvdims(X,m,Y,n)
    end

    if HIP.runtime_version() ≥ v"6-"
        @lock A.analysis_cache.lock begin
            plan = analysis_plan((transa, index, algo), A, X, Y)
            # The row-wise CSR kernel accumulates long rows onto `beta * Y`, which leaves
            # non-finite entries of `Y` in place and loses the digits of the result that
            # large entries of `Y` push out. It runs for CSR and for transposed CSC.
            row_wise = A isa ROCSparseMatrixCSR ? transa == 'N' :
                A isa ROCSparseMatrixCSC && transa != 'N'
            row_wise && iszero(beta) && fill!(Y, zero(T))
            rocsparse_dnvec_set_values(plan.descX, X)
            rocsparse_dnvec_set_values(plan.descY, Y)
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), plan.descA, plan.descX,
                Ref{T}(beta), plan.descY, T, algo,
                rocsparse_spmv_stage_compute, plan.buffer_size, plan.buffer)
        end
    else
        descA = ROCSparseMatrixDescriptor(A, index)
        descX = ROCDenseVectorDescriptor(X)
        descY = ROCDenseVectorDescriptor(Y)
        function bufferSize()
            out = Ref{Csize_t}()
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo, out, C_NULL)
            return out[]
        end
        with_workspace(bufferSize) do buffer
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo, Ref{Csize_t}(sizeof(buffer)), buffer)
        end
    end
    Y
end

# `C = alpha * op(A) * op(B) + beta * C` for a sparse `A`, reusing the analysis of `A` kept
# from an earlier product with the same `SpMMKey`. `sparse_transposed` and `dense_transposed`
# tell whether `A`, and `B` and `C`, are described to rocSPARSE through their transposes.
function spmm!(
    transa::SparseChar, transb::SparseChar, alpha::Number, A::AnalyzedMatrix,
    B::DenseROCMatrix{T}, beta::Number, C::DenseROCMatrix{T}, index::SparseChar,
    algo::rocsparse_spmm_alg; sparse_transposed::Bool, dense_transposed::Bool,
) where T
    key = (
        transa, transb, index, algo, sparse_transposed, dense_transposed,
        size(B), stride(B, 2), size(C), stride(C, 2))
    @lock A.analysis_cache.lock begin
        plan = analysis_plan(key, A, B, C)
        rocsparse_dnmat_set_values(plan.descX, B)
        rocsparse_dnmat_set_values(plan.descY, C)
        rocsparse_spmm(
            handle(), transa, transb, Ref{T}(alpha), plan.descA, plan.descX, Ref{T}(beta),
            plan.descY, T, algo, rocsparse_spmm_stage_compute, plan.buffer_size, plan.buffer)
    end
    return C
end

function mm!(
    transa::SparseChar, transb::SparseChar, alpha::Number, A::Union{ROCSparseMatrixCSR{T}, ROCSparseMatrixCSC{T}, ROCSparseMatrixCOO{T}},
    B::DenseROCMatrix{T}, beta::Number, C::DenseROCMatrix{T}, index::SparseChar,
    algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default,
) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Matrix-matrix multiplication with the adjoint of a CSC matrix" *
                            " is not supported. Use a CSR or COO matrix instead."))
    end

    # a CSC matrix is passed as the CSR matrix that its transpose is
    sparse_transposed = isa(A, ROCSparseMatrixCSC)
    if sparse_transposed
        k,m = size(A)
        transa = transa == 'N' ? 'T' : 'N'
    else
        m,k = size(A)
    end
    n = size(C)[2]

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    elseif transa == 'N' && transb != 'N'
        chkmmdims(B,C,n,k,m,n)
    elseif transa != 'N' && transb == 'N'
        chkmmdims(B,C,m,n,k,n)
    elseif transa != 'N' && transb != 'N'
        chkmmdims(B,C,n,m,k,n)
    end

    return spmm!(
        transa, transb, alpha, A, B, beta, C, index, algo;
        sparse_transposed, dense_transposed=false)
end

function mm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::DenseROCMatrix{T},
             B::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}},
             beta::Number, C::DenseROCMatrix{T}, index::SparseChar, algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(B, ROCSparseMatrixCSR) && transb == 'C' && T <: Complex
        throw(ArgumentError("Matrix-matrix multiplication with the adjoint of a complex CSR matrix" *
                            " is not supported by the current CUDA version. Use a CSC or COO matrix instead."))
    end

    m,k = size(A)
    n = size(C)[2]

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    elseif transa == 'N' && transb != 'N'
        chkmmdims(B,C,n,k,m,n)
    elseif transa != 'N' && transb == 'N'
        chkmmdims(B,C,m,n,k,n)
    elseif transa != 'N' && transb != 'N'
        chkmmdims(B,C,n,m,k,n)
    end

    # C' = op(B)' * op(A)', with the dense operands described through their row-major
    # views; a CSR B is passed as is with the flipped operation. rocSPARSE requires a COO
    # matrix to be sorted by the row index of its descriptor, which the transposed COO
    # descriptor (the index arrays swapped) is not, so a COO B goes through CSC.
    B isa ROCSparseMatrixCOO && (B = ROCSparseMatrixCSC(B))
    sparse_transposed = !isa(B, ROCSparseMatrixCSR)
    if !sparse_transposed
        transb = transb == 'N' ? 'T' : 'N'
    end

    return spmm!(
        transb, transa, alpha, B, A, beta, C, index, algo;
        sparse_transposed, dense_transposed=true)
end

function gemm!(
    transa::SparseChar, transb::SparseChar, α::Number, A::ROCSparseMatrixCSR{T},
    B::ROCSparseMatrixCSR{T}, β::Number, C::ROCSparseMatrixCSR{T},
    index::SparseChar,
) where T
    m, k = size(A)
    n = size(C)[2]
    alpha = convert(T, α)
    beta = convert(T, β)

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    else
        throw(ArgumentError("Sparse mm! only supports transa ($transa) = 'N' and transb ($transb) = 'N'"))
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCSparseMatrixDescriptor(B, index)
    descC = ROCSparseMatrixDescriptor(C, index)

    function bufferSize()
        out = Ref{Csize_t}(0)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_buffer_size, out, C_NULL)
        return out[]
    end
    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_nnz, buffer_len_ref, buffer)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

function gemm(
    transa::SparseChar, transb::SparseChar, α::Number,
    A::ROCSparseMatrixCSR{T,Ti}, B::ROCSparseMatrixCSR{T,Ti},
    index::SparseChar,
) where {T,Ti}
    m, k = size(A)
    k == size(B, 1) || throw(DimensionMismatch(
        "A has dimensions $(size(A)) but B has dimensions $(size(B))"))
    n = size(B, 2)
    alpha = convert(T, α)
    beta = zero(T)

    if transa != 'N' || transb != 'N'
        throw(ArgumentError("Sparse gemm only supports transa ($transa) = 'N' and transb ($transb) = 'N'"))
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCSparseMatrixDescriptor(B, index)
    rowPtrC = ROCVector{Ti}(undef, m + 1)
    descC = ROCSparseMatrixDescriptor(ROCSparseMatrixCSR, rowPtrC, T, Ti, m, n, index)

    function bufferSize()
        out = Ref{Csize_t}(0)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_buffer_size, out, C_NULL)
        return out[]
    end

    return with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_nnz, buffer_len_ref, buffer)

        nnzC = Ref{Int64}()
        rocsparse_spmat_get_size(descC, Ref{Int64}(), Ref{Int64}(), nnzC)
        colValC = ROCVector{Ti}(undef, nnzC[])
        nzValC = ROCVector{T}(undef, nnzC[])
        C = ROCSparseMatrixCSR{T,Ti}(rowPtrC, colValC, nzValC, (m, n))
        rocsparse_csr_set_pointers(descC, C.rowPtr, C.colVal, C.nzVal)

        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_compute, buffer_len_ref, buffer)
        C
    end
end

# the stages of a sparse triangular solve, in a workspace of the size it asks for
function spsv!(transa, alpha, descA, descX, descY, ::Type{T}, algo) where T
    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_compute, buffer_len_ref, buffer)
    end
end

function sv!(transa::SparseChar, uplo::SparseChar, diag::SparseChar,
             alpha::Number, A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, X::DenseROCVector{T},
             Y::DenseROCVector{T}, index::SparseChar, algo::rocsparse_spsv_alg=rocsparse_spsv_alg_default) where T

    # Support transa = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Backward and forward sweeps with the adjoint of a complex CSC matrix is not supported. Use a CSR or COO matrix instead."))
    end

    mA,nA = size(A)
    mX = length(X)
    mY = length(Y)

    (mA != nA) && throw(DimensionMismatch("A must be square, but has dimensions ($mA,$nA)!"))
    (mX != mA) && throw(DimensionMismatch("X must have length $mA, but has length $mX"))
    (mY != mA) && throw(DimensionMismatch("Y must have length $mA, but has length $mY"))

    if isa(A, ROCSparseMatrixCSC)
        descA = ROCSparseMatrixDescriptor(A, index, transposed=true)
        transa = transa == 'N' ? 'T' : 'N'
        uplo = uplo == 'U' ? 'L' : 'U'
    else
        descA = ROCSparseMatrixDescriptor(A, index)
    end

    rocsparse_uplo = Ref{rocsparse_fill_mode}(uplo)
    rocsparse_diag = Ref{rocsparse_diag_type}(diag)

    rocsparse_spmat_set_attribute(descA, 'F', rocsparse_uplo, Csize_t(sizeof(rocsparse_uplo)))
    rocsparse_spmat_set_attribute(descA, 'D', rocsparse_diag, Csize_t(sizeof(rocsparse_diag)))

    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)

    spsv!(transa, alpha, descA, descX, descY, T, algo)
    return Y
end

# the stages of a sparse triangular solve with multiple right-hand sides
function spsm!(transa, transb, alpha, descA, descB, descC, ::Type{T}, algo) where T
    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_compute, buffer_len_ref, buffer)
    end
end

function sm!(transa::SparseChar, transb::SparseChar, uplo::SparseChar, diag::SparseChar,
             alpha::Number, A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, B::DenseROCMatrix{T},
             C::DenseROCMatrix{T}, index::SparseChar, algo::rocsparse_spsm_alg=rocsparse_spsm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Backward and forward sweeps with the adjoint of a complex CSC matrix is not supported. Use a CSR or COO matrix instead."))
    end

    mA,nA = size(A)
    mB,nB = size(B)
    mC,nC = size(C)

    (mA != nA) && throw(DimensionMismatch("A must be square, but has dimensions ($mA,$nA)!"))
    (mC != mA) && throw(DimensionMismatch("C must have $mA rows, but has $mC rows"))
    (mB != mA) && (transb == 'N') && throw(DimensionMismatch("B must have $mA rows, but has $mB rows"))
    (nB != mA) && (transb != 'N') && throw(DimensionMismatch("B must have $mA columns, but has $nB columns"))
    (nB != nC) && (transb == 'N') && throw(DimensionMismatch("B and C must have the same number of columns, but B has $nB columns and C has $nC columns"))
    (mB != nC) && (transb != 'N') && throw(DimensionMismatch("B must have the same the number of rows that C has as columns, but B has $mB rows and C has $nC columns"))

    if isa(A, ROCSparseMatrixCSC)
        descA = ROCSparseMatrixDescriptor(A, index, transposed=true)
        transa = transa == 'N' ? 'T' : 'N'
        uplo = uplo == 'U' ? 'L' : 'U'
    else
        descA = ROCSparseMatrixDescriptor(A, index)
    end

    rocsparse_uplo = Ref{rocsparse_fill_mode}(uplo)
    rocsparse_diag = Ref{rocsparse_diag_type}(diag)

    rocsparse_spmat_set_attribute(descA, 'F', rocsparse_uplo, Csize_t(sizeof(rocsparse_uplo)))
    rocsparse_spmat_set_attribute(descA, 'D', rocsparse_diag, Csize_t(sizeof(rocsparse_diag)))

    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCDenseMatrixDescriptor(C)

    spsm!(transa, transb, alpha, descA, descB, descC, T, algo)
    return C
end

function sddmm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::DenseROCMatrix{T}, B::DenseROCMatrix{T},
                beta::Number, C::ROCSparseMatrixCSR{T}, index::SparseChar, algo::rocsparse_sddmm_alg=rocsparse_sddmm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    m,k = size(A)
    n = size(C)[2]

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    elseif transa == 'N' && transb != 'N'
        chkmmdims(B,C,n,k,m,n)
    elseif transa != 'N' && transb == 'N'
        chkmmdims(B,C,m,n,k,n)
    elseif transa != 'N' && transb != 'N'
        chkmmdims(B,C,n,m,k,n)
    end

    descA = ROCDenseMatrixDescriptor(A)
    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCSparseMatrixDescriptor(C, index)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_sddmm_buffer_size(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, out)
        return out[]
    end
    with_workspace(bufferSize) do buffer
        rocsparse_sddmm_preprocess(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, buffer)
        rocsparse_sddmm(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, buffer)
    end
    return C
end
