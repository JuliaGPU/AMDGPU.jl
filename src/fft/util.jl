import .AMDGPU: ROCArray
import AbstractFFTs: complexfloat, realfloat

const rocfftComplexes = Union{ComplexF32, ComplexF64}
const rocfftReals     = Union{Float32, Float64}

rocfftfloat(x) = _rocfftfloat(float(x))
_rocfftfloat(::Type{T}) where {T<:rocfftReals} = T
_rocfftfloat(::Type{Float16}) = Float32       # TODO I assume no Float16 for FFT available
_rocfftfloat(::Type{Complex{T}}) where {T} = Complex{_rocfftfloat(T)}
_rocfftfloat(::Type{T}) where {T} = error("type $T not supported")
_rocfftfloat(x::T) where {T} = _rocfftfloat(T)(x)

complexfloat(x::ROCArray{Complex{<:rocfftReals}}) = x
realfloat(x::ROCArray{<:rocfftReals}) = x

complexfloat(x::ROCArray{T}) where {T<:Complex} = copy1(typeof(rocfftfloat(zero(T))), x)
complexfloat(x::ROCArray{T}) where {T<:Real}    = copy1(typeof(complex(rocfftfloat(zero(T)))), x)

realfloat(x::ROCArray{T}) where {T<:Real} = copy1(typeof(rocfftfloat(zero(T))), x)

function copy1(::Type{T}, x) where {T}
    y = ROCArray{T}(undef, map(length, axes(x)))
    y .= broadcast(xi -> convert(T, xi), x)
end
