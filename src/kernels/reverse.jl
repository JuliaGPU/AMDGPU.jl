# Adapted from CUDA.jl.

# 1D case.

Base.reverse(x::AnyROCVector) = @inbounds reverse(x, 1, length(x))

Base.@propagate_inbounds function Base.reverse(
    x::AnyROCVector, start::Integer, stop::Integer = length(x),
)
    y = similar(x)

    start > 1 && copyto!(y, 1, x, 1, start - 1)
    stop < length(x) && copyto!(y, stop + 1, x, stop + 1)
    _reverse!(@view(y[start:stop]), @view(x[start:stop]))

    return y
end

Base.@propagate_inbounds function Base.reverse!(
    x::AnyROCVector, start::Integer, stop::Integer = length(x),
)
    _reverse!(@view(x[start:stop]))
    return x
end

Base.reverse!(x::AnyROCVector) = @inbounds reverse!(x, 1, length(x))

# N-D case.

function Base.reverse(x::AnyROCArray; dims=:)
    isa(dims, Colon) && (dims = 1:ndims(x);)

    applicable(iterate, dims) || throw(ArgumentError(
        "Dimension `$dims` is not an iterable."))
    all(1 .≤ dims .≤ ndims(x)) || throw(ArgumentError(
        "Dimension `$dims` is not 1 ≤ $dims ≤ $(ndims(x))"))

    all(size(x)[[dims...]] .== 1) && return copy(x) # Dims to reverse are 1.

    y = similar(x)
    _reverse!(y, x; dims)
    return y
end

function Base.reverse!(x::AnyROCArray; dims=:)
    isa(dims, Colon) && (dims = 1:ndims(x);)

    applicable(iterate, dims) || throw(ArgumentError(
        "Dimension `$dims` is not an iterable."))
    all(1 .≤ dims .≤ ndims(x)) || throw(ArgumentError(
        "Dimension `$dims` is not 1 ≤ $dims ≤ $(ndims(x))"))

    _reverse!(x; dims)
    return x
end

# Out-of-place kernel, swapping a single element per thread.

function _reverse!(
    y::AnyROCArray{T, N}, x::AnyROCArray{T, N}; dims=1:ndims(x),
) where {T, N}
    size(x) == size(y) || throw(DimensionMismatch(
        "Input and output arrays must equal in size, instead: " *
        "`$(size(x))` vs `$(size(y))`."))

    rev_dims = ntuple(d -> (d ∈ dims) && (size(x, d) > 1), N)

    ref = size(x) .+ 1
    lin_ids = LinearIndices(x)
    nd_ids = CartesianIndices(x)

    function _kernel!(y::AbstractArray{T, N}, x::AbstractArray{T, N}) where {T, N}
        i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x

        if i ≤ length(x)
            idx = Tuple(nd_ids[i])
            idx = ifelse.(rev_dims, ref .- idx, idx)
            idx_out = lin_ids[idx...]
            y[idx_out] = x[i]
        end
        return
    end

    groupsize = 256
    gridsize = cld(length(x), groupsize)
    @roc groupsize=groupsize gridsize=gridsize _kernel!(y, x)
end

# In-place kernel, swapping elements on half the number of threads.

function _reverse!(x::AnyROCArray{T, N}; dims=1:ndims(x)) where {T, N}
    rev_dims = ntuple(d -> (d ∈ dims) && (size(x, d) > 1), N)
    half_dim = findlast(rev_dims)
    half_dim ≡ nothing && return # No reverse needed in this case.

    reduced_sz = ntuple(d -> (d == half_dim) ? cld(size(x, d), 2) : size(x, d), N)
    reduced_len = prod(reduced_sz)

    ref = size(x) .+ 1
    lin_ids = LinearIndices(x)
    nd_ids = CartesianIndices(reduced_sz)

    function _kernel!(x::AbstractArray{T, N}) where {T, N}
        i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x

        if i ≤ reduced_len
            idx = Tuple(nd_ids[i])
            idx_in = lin_ids[idx...]
            idx = ifelse.(rev_dims, ref .- idx, idx)
            idx_out = lin_ids[idx...]

            if idx_in < idx_out
                x[idx_in], x[idx_out] = x[idx_out], x[idx_in]
            end
        end
        return
    end

    groupsize = 256
    gridsize = cld(prod(reduced_sz), groupsize)
    @roc groupsize=groupsize gridsize=gridsize _kernel!(x)
end
