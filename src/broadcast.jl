# broadcasting

using Base.Broadcast: BroadcastStyle, Broadcasted

struct ROCArrayStyle{N} <: AbstractGPUArrayStyle{N} end
ROCArrayStyle(::Val{N}) where N = ROCArrayStyle{N}()
ROCArrayStyle{M}(::Val{N}) where {N,M} = ROCArrayStyle{N}()

BroadcastStyle(::Type{<:ROCArray{T,N}}) where {T,N} = ROCArrayStyle{N}()

Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}) where {N,T} =
    similar(ROCArray{T}, axes(bc))

Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}, dims...) where {N,T} =
    ROCArray{T}(undef, dims...)

# broadcasting type ctors isn't GPU compatible
Broadcast.broadcasted(::ROCArrayStyle{N}, f::Type{T}, args...) where {N, T} =
    Broadcasted{ROCArrayStyle{N}}((x...) -> T(x...), args, nothing)
