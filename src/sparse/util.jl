"""
check that the dimensions of matrix `X` and vector `Y` make sense for a multiplication
"""
function chkmvdims(X, n, Y, m)
    if length(X) != n
        throw(DimensionMismatch("X must have length $n, but has length $(length(X))"))
    elseif length(Y) != m
        throw(DimensionMismatch("Y must have length $m, but has length $(length(Y))"))
    end
end

"""
check that the dimensions of matrices `X` and `Y` make sense for a multiplication
"""
function chkmmdims( B, C, k, l, m, n )
    if size(B) != (k,l)
        throw(DimensionMismatch("B has dimensions $(size(B)) but needs ($k,$l)"))
    elseif size(C) != (m,n)
        throw(DimensionMismatch("C has dimensions $(size(C)) but needs ($m,$n)"))
    end
end

"""
    with_workspace([eltyp=UInt8], size) do workspace
        ...
    end

Create a GPU workspace vector with element type `eltyp` and size
in number of elements (in the default case of an UInt8 element type
this equals to the amount of bytes) specified by `size`,
and pass it to the do block.
"""
@inline with_workspace(f, size::Union{Integer,Function}) =
    with_workspace(f, UInt8, isa(size, Integer) ? ()->size : size)

function with_workspace(
    f::Function, eltyp::Type{T}, size::Union{Integer,Function},
) where {T}
    get_size() = Int(isa(size, Integer) ? size : size()::Integer)
    workspace = ROCVector{T}(undef, get_size())
    res = f(workspace)
    AMDGPU.unsafe_free!(workspace)
    return res
end

"""
    cint_view(A)

The legacy routines of rocSPARSE only take 32-bit indices (`rocsparse_int`). Return `A`
with `Cint` indices, sharing its values (which in-place routines update), or `A` itself if
its indices are `Cint` already.
"""
cint_view(A::Union{ROCSparseMatrixCSR{<:Any,Cint},ROCSparseMatrixCSC{<:Any,Cint},
                   ROCSparseMatrixCOO{<:Any,Cint},ROCSparseVector{<:Any,Cint}}) = A
cint_view(A::ROCSparseMatrixBSR{<:Any,Cint}) = A
function cint_view(A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC,ROCSparseMatrixCOO,ROCSparseVector})
    max(size(A)..., nnz(A) + 1) <= typemax(Cint) ||
        throw(ArgumentError("this rocSPARSE routine takes 32-bit indices, which cannot represent a $(join(size(A), '×')) array with $(nnz(A)) stored entries"))
    buffers = GPUArrays.sparse_buffers(A)
    return typeof(A).name.wrapper(map(b -> convert(ROCVector{Cint}, b), Base.front(buffers))...,
                                  last(buffers), A isa ROCSparseVector ? length(A) : size(A))
end
cint_view(A::ROCSparseMatrixBSR) =
    ROCSparseMatrixBSR{eltype(A),Cint}(A.rowPtr, A.colVal, nonzeros(A), size(A), A.blockDim,
                                       A.dir, A.nnzb)
