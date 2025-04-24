import Base.Broadcast: BroadcastStyle, Broadcasted

struct ROCArrayStyle{N, B} <: AbstractGPUArrayStyle{N} end
ROCArrayStyle{M, B}(::Val{N}) where {N, M, B} = ROCArrayStyle{N, B}()

# Identify the broadcast style of a wrapped ROCArray.
BroadcastStyle(::Type{<:ROCArray{T, N, B}}) where {T, N, B} =
    ROCArrayStyle{N, B}()
BroadcastStyle(W::Type{<:AnyROCArray{T, N}}) where {T, N} =
    ROCArrayStyle{N, buftype(Adapt.unwrap_type(W))}()

# TODO use unified buffer once we support it.
# Broadcast of two different buffers - choose `HIPBuffer`.
BroadcastStyle(
    ::ROCArrayStyle{N1, B1},
    ::ROCArrayStyle{N2, B2},
) where {N1,N2,B1,B2} = ROCArrayStyle{max(N1,N2), Mem.HIPBuffer}()

# Different N, same buffer type.
BroadcastStyle(
    ::ROCArrayStyle{N1, B},
    ::ROCArrayStyle{N2, B},
) where {N1,N2,B} = ROCArrayStyle{max(N1,N2), B}()

# Allocation of output arrays.
function Base.similar(
    bc::Broadcasted{ROCArrayStyle{N, B}}, ::Type{T}, dims,
) where {N, B, T}
    similar(ROCArray{T, length(dims), B}, dims)
end

# TODO: revise
# Broadcasting type ctors isn't GPU compatible.
Broadcast.broadcasted(::ROCArrayStyle{N, B}, f::Type{T}, args...) where {N, B, T} =
    Broadcasted{ROCArrayStyle{N, B}}((x...) -> T(x...), args, nothing)
