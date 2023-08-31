Base.sort!(x::AnyROCVector; kwargs...) = bitonic_sort!(x; dims=1, kwargs...)

Base.sort!(x::AnyROCArray; dims, kwargs...) = bitonic_sort!(x; dims, kwargs...)

function Base.sortperm!(
    ix::AnyROCArray, x::AnyROCArray;
    initialized::Bool = false, kwargs...,
)
    axes(ix) == axes(x) || throw(ArgumentError(
        "Index array must have the same size as the source array, instead: " *
        "$(size(ix)) vs $(size(x))."))

    initialized || (ix .= LinearIndices(x);)
    bitonic_sort!((x, ix); kwargs...)
    return ix
end

function Base.sortperm(x::AnyROCVector; kwargs...)
    sortperm!(ROCArray(1:length(x)), x; initialized=true, dims=1)
end

function Base.sortperm(x::AnyROCArray; dims, kwargs...)
    sortperm!(ROCArray(1:length(x)), x; initialized=true, dims)
end

# TODO dims
function bitonic_sort!(
    X; lt = isless, by = identity, rev::Bool = false, dims::Int,
)
    _shmem(x::Tuple, groupsize) = prod(groupsize) * sum(sizeof.(eltype.(x)))
    _shmem(x::AbstractArray, groupsize) = prod(groupsize) * sizeof(eltype(x))

    len_x = typeof(X) <: Tuple ? length(X[1]) : length(X)
    I = len_x ≤ typemax(Int32) ? Int32 : Int64
    threads = min(256, prevpow(2, len_x))

    # Compile kernels.
    ker_1 = @roc launch=false cmp_small_kern!(
        X, I(len_x), one(I), one(I), one(I), by, lt, Val(rev))
    ker_2 = @roc launch=false cmp_ker!(
        X, I(len_x), one(I), one(I), by, lt, Val(rev))

    # Cutoff for when to use `ker_1` vs `ker_2`.
    log_threads = Int(log2(threads))

    k₀ = ceil(Int, log2(len_x))
    for k in k₀:-1:1
        j_end = k₀ - k + 1
        for j in 1:j_end
            if k₀ - k - j + 2 ≤ log_threads
                pseudo_block_len = 1 << abs(j_end + 1 - j)
                n_pseudo_blocks = nextpow(2, len_x) ÷ pseudo_block_len
                pseudo_blocks_per_block = threads ÷ pseudo_block_len

                gridsize = max(1, n_pseudo_blocks ÷ pseudo_blocks_per_block)
                groupsize = (pseudo_block_len, threads ÷ pseudo_block_len)
                ker_1(
                    X, I(len_x), I(k), I(j), I(j_end), by, lt, Val(rev);
                    gridsize, groupsize, shmem=_shmem(X, groupsize))
            else
                gridsize = cld(len_x, threads)
                ker_2(
                    X, I(len_x), I(k), I(j), by, lt, Val(rev);
                    gridsize, groupsize=threads)
            end
        end
    end
    return X
end

function cmp_ker!(x, lenₓ::I, k::I, j::I, by, lt, rev) where I
    idx::I = workgroupDim().x * (workgroupIdx().x - 0x1) + workitemIdx().x - 0x1
    lo, n, dir = get_range(lenₓ, idx, k, j)

    if !(lo < 0x0 || n < 0x0) && !(idx ≥ lenₓ)
        m = gp2lt(n)
        if lo ≤ idx < lo + n - m
            i1, i2 = idx, idx + m
            cmp!(x, i1, i2, dir, by, lt, rev)
        end
    end
    return
end

function cmp_small_kern!(x, lenₓ::I, k::I, j₀::I, jₑ::I, by, lt, rev) where I
    bidx::I = (workgroupIdx().x - 0x1) * workgroupDim().y + workitemIdx().y - 0x1
    _lo, _n, dir = block_range(lenₓ, bidx, k, j₀)

    idx = _lo + I(workitemIdx().x) - 0x1
    in_range = workitemIdx().x ≤ _n && _lo ≥ 0x0
    swap = init_shmem(x, idx, in_range)

    lo, n = _lo, _n
    for j in j₀:jₑ
        if in_range && !(lo < 0x0 || n < 0x0)
            m = gp2lt(n)
            if lo ≤ idx < lo + n - m
                i1, i2 = idx - _lo, idx - _lo + m
                cmp_small!(swap, i1, i2, dir, by, lt, rev)
            end
        end
        lo, n = bisect_range(idx, lo, n)
        sync_workgroup()
    end
    finalize_shmem!(x, swap, idx, in_range)
    return
end

function bisect_range(idx::I, lo::I, n::I) where I
    n ≤ 0x1 && return -one(I), -one(I)

    m = gp2lt(n)
    if idx < lo + m
        n = m
    else
        lo += m
        n -= m
    end
    lo, n
end

# TODO inbounds
function cmp!(
    x::AbstractArray, i1::I, i2::I, dir::Bool, by, lt, rev,
) where I
    i1, i2 = i1 + one(I), i2 + one(I)
    if dir != _lt_fn(by(x[i1]), by(x[i2]), lt, rev)
        x[i1], x[i2] = x[i2], x[i1]
    end
end

function cmp!(
    X::Tuple, i1::I, i2::I, dir::Bool, by, lt, rev,
) where I
    i1, i2 = i1 + one(I), i2 + one(I)
    x, ix = X
    cmp_res = _lt_fn(
        (by(x[ix[i1]]), ix[i1]),
        (by(x[ix[i2]]), ix[i2]), lt, rev)
    if dir != cmp_res
        ix[i1], ix[i2] = ix[i2], ix[i1]
    end
end

function cmp_small!(
    swap::AbstractArray, i1::I, i2::I, dir::Bool, by, lt, rev,
) where I
    i1, i2 = i1 + one(I), i2 + one(I)
    if dir != _lt_fn(by(swap[i1]), by(swap[i2]), lt, rev)
        swap[i1], swap[i2] = swap[i2], swap[i1]
    end
end

function cmp_small!(
    swap::Tuple, i1::I, i2::I, dir::Bool, by, lt, rev,
) where I
    i1, i2 = i1 + one(I), i2 + one(I)
    x, ix = swap
    cmp_res = _lt_fn(
        (by(x[i1]), ix[i1]),
        (by(x[i2]), ix[i2]), lt, rev)
    if dir != cmp_res
        x[i1], x[i2] = x[i2], x[i1]
        ix[i1], ix[i2] = ix[i2], ix[i1]
    end
end

@inline function _lt_fn(a::T, b::T, lt, rev::Val{R}) where {T, R}
    R ? lt(b, a) : lt(a, b)
end

@inline function _lt_fn(a::Tuple{T, J}, b::Tuple{T, J}, lt, rev::Val{R}) where {T, J, R}
    if R
        if b[1] == a[1]
            return b[2] > a[2] # Compare indices.
        else
            return lt(b[1], a[1])
        end
    else
        return lt(a, b)
    end
end

# TODO inbounds
function init_shmem(x::AbstractArray{T}, idx, in_range::Bool, offset=0) where T
    swap = @ROCDynamicLocalArray(
        T, (workgroupDim().x, workgroupDim().y), false, offset)
    if in_range
        swap[workitemIdx().x, workitemIdx().y] = x[idx + 0x1]
    end
    sync_workgroup()
    @view(swap[:, workitemIdx().y])
end

function init_shmem(
    X::Tuple{AbstractArray{T}, AbstractArray{J}}, idx, in_range::Bool,
) where {T, J}
    x, ix = X
    idx_swap = init_shmem(ix, idx, in_range)
    offset = (workgroupDim().x * workgroupDim().y) * sizeof(J)
    swap = init_shmem(x, idx_swap[workitemIdx().x] - 0x1, in_range, offset)
    swap, idx_swap
end

"""
Copy `swap` back into global memory `x`.
"""
function finalize_shmem!(
    x::AbstractArray, swap::AbstractArray, idx, in_range::Bool,
)
    if in_range
        # TODO inbounds
        x[idx + 0x1] = swap[workitemIdx().x]
    end
end

function finalize_shmem!(X::Tuple, swap::Tuple, idx, in_range::Bool)
    x, ix = X
    x_swap, idx_swap = swap
    finalize_shmem!(ix, idx_swap, idx, in_range)
end

function get_range_part1(n::I, index::I, k::I) where I
    lo = zero(I)
    dir = true
    for iter in one(I):(k - one(I))
        if n ≤ one(I)
            return -one(I), -one(I), false
        end

        if index < lo + n ÷ 0x2
            n = n ÷ 0x2
            dir = !dir
        else
            lo = lo + n ÷ 0x2
            n = n - n ÷ 0x2
        end
    end
    lo, n, dir
end

function get_range_part2(lo::I, n::I, index::I, j::I) where I
    for iter in one(I):(j - one(I))
        lo, n = bisect_range(index, lo, n)
    end
    lo, n
end

"""
Determines parameters for swapping when the grid index directly maps to an
Array index for swapping.
"""
function get_range(n, idx, k, j)
    lo, n, dir = get_range_part1(n, idx, k)
    lo, n = get_range_part2(lo, n, idx, j)
    lo, n, dir
end


function block_range(n::I, bidx::I, k::I, j::I) where I
    lo = zero(I)
    dir = true
    tmp = bidx * I(2)

    # Part 1.
    for i in one(I):(k - one(I))
        tmp ÷= I(2)
        n ≤ one(I) && return -one(I), -one(I), false

        if tmp % I(2) == zero(I)
            n ÷= I(2)
            dir = !dir
        else
            lo += n ÷ I(2)
            n -= n ÷ I(2)
        end
    end

    # Part 2.
    for i in one(I):(j - one(I))
        tmp ÷= I(2)
        n ≤ one(I) && return -one(I), -one(I), false

        m = gp2lt(n)
        if tmp % I(2) == zero(I)
            n = m
        else
            lo += m
            n -= m
        end
    end

    (zero(I) ≤ n ≤ one(I)) && return -one(I), -one(I), false
    lo, n, dir
end

@inline function gp2lt(x::I)::I where I
    x -= one(I)
    x |= x >> 0x1
    x |= x >> 0x2
    x |= x >> 0x4
    x |= x >> 0x8
    x |= x >> 0x102
    x ⊻ (x >> 0x1)
end
