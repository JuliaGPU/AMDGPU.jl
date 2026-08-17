Base.sort!(x::AnyROCArray; dims::Union{Nothing, Integer}=nothing, kwargs...) =
    isnothing(dims) ? (AK.sort!(x; kwargs...); x) : _sort_dims!(x, dims; kwargs...)

# Base's out-of-place `sort(x; dims)` sorts chunks with the CPU algorithm, which trips
# scalar indexing - route it through `sort!` instead.
Base.sort(x::AnyROCArray; kwargs...) = sort!(copy(x); kwargs...)

Base.sortperm!(ix::AnyROCArray, x::AnyROCArray; dims::Union{Nothing, Integer}=nothing, kwargs...) =
    isnothing(dims) ?
        (AK.sortperm!(ix, x; kwargs...); ix) :
        _sortperm_dims!(ix, x, dims; kwargs...)

Base.sortperm(x::AnyROCArray; dims::Union{Nothing, Integer}=nothing, kwargs...) =
    isnothing(dims) ?
        sortperm!(ROCArray(1:length(x)), x; kwargs...) :
        sortperm!(reshape(ROCArray(1:length(x)), size(x)), x; dims, kwargs...)

# Sorting along `dims`. AcceleratedKernels has no `dims` argument yet
# (JuliaGPU/AcceleratedKernels.jl#59), and one sort per slice would serialize into too many
# tiny kernels. Instead each element is tagged with the index of its slice and the array is
# sorted once, ordered lexicographically by `(slice, element)`; slices then come out grouped
# and internally sorted, and are scattered back. Drop this once AK supports `dims` directly.

# Tag element `(i, j - 1)` of the `(sd * n, rest)` view of `x` with its slice index, plus its
# linear index for `sortperm`. Broadcast alongside `x` itself, so the ranges stay lazy.
_slice_kv(::Type{K}, sd, i, j, v) where K = (K(mod1(i, sd) + sd * j), v)
_slice_kvi(::Type{K}, ::Type{I}, sd, n, i, j, v) where {K, I} =
    (K(mod1(i, sd) + sd * j), v, I(i + sd * n * j))

_slice_value(kv) = kv[2]
_slice_index(kv) = kv[3]

# `x` seen as `(sd, n, rest)`: `n` elements along `dims`, strided by `sd`, over `rest` groups.
function _slice_layout(x::AnyROCArray, dims::Integer)
    1 ≤ dims ≤ ndims(x) || throw(ArgumentError("dimension out of range"))
    n = size(x, dims)
    sd = prod(size(x)[1:dims - 1])
    return n, sd, length(x) ÷ (n * sd)
end

# Smallest key type that can enumerate the slices of `x`.
_slice_keytype(x::AnyROCArray) = length(x) ≤ typemax(Int32) ? Int32 : Int64

# `(slice, element)` ordering, ties broken by the user-supplied ordering.
_slice_lt(ord) = (a, b) -> a[1] == b[1] ? Base.Order.lt(ord, a[2], b[2]) : a[1] < b[1]

# Scatter the sorted - and therefore slice-grouped - `kv` back over `dst`.
function _slice_scatter!(f::F, dst, kv, n, sd, rest) where F
    if sd == 1
        reshape(dst, n, rest) .= f.(reshape(kv, n, rest))
    else
        reshape(dst, sd, n, rest) .= f.(PermutedDimsArray(reshape(kv, n, sd, rest), (2, 1, 3)))
    end
    return dst
end

function _sort_dims!(
    x::AnyROCArray, dims::Integer;
    lt=isless, by=identity, rev::Union{Nothing, Bool}=nothing,
    order::Base.Order.Ordering=Base.Order.Forward, kwargs...,
)
    isempty(x) && return x
    n, sd, rest = _slice_layout(x, dims)
    K = _slice_keytype(x)

    kv = similar(x, Tuple{K, eltype(x)}, length(x))
    reshape(kv, sd * n, rest) .= _slice_kv.(
        K, sd, 1:sd * n, (0:rest - 1)', reshape(x, sd * n, rest))

    AK.sort!(kv; lt=_slice_lt(Base.Order.ord(lt, by, rev, order)), kwargs...)

    return _slice_scatter!(_slice_value, x, kv, n, sd, rest)
end

function _sortperm_dims!(
    ix::AnyROCArray, x::AnyROCArray, dims::Integer;
    lt=isless, by=identity, rev::Union{Nothing, Bool}=nothing,
    order::Base.Order.Ordering=Base.Order.Forward, kwargs...,
)
    axes(ix) == axes(x) || throw(DimensionMismatch(
        "index array has axes $(axes(ix)), but sorted array has axes $(axes(x))"))
    isempty(x) && return ix
    n, sd, rest = _slice_layout(x, dims)
    K, I = _slice_keytype(x), eltype(ix)

    kv = similar(x, Tuple{K, eltype(x), I}, length(x))
    reshape(kv, sd * n, rest) .= _slice_kvi.(
        K, I, sd, n, 1:sd * n, (0:rest - 1)', reshape(x, sd * n, rest))

    AK.sort!(kv; lt=_slice_lt(Base.Order.ord(lt, by, rev, order)), kwargs...)

    return _slice_scatter!(_slice_index, ix, kv, n, sd, rest)
end
