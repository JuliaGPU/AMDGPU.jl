const rocfftComplexes = Union{ComplexF32, ComplexF64}
const rocfftReals = Union{Float32, Float64}

rocfftfloat(::Type{T}) where {T} = error("type $T not supported")
rocfftfloat(::Type{Float16}) = FLoat32
rocfftfloat(::Type{T}) where {T<:rocfftReals} = T
rocfftfloat(::Type{Complex{T}}) where {T} = Complex{rocfftfloat(T)}

complexfloat(x::ROCArray{Complex{T}}) where {T<:rocfftReals} = x
complexfloat(x::ROCArray{T}) where {T<:Complex} = copy1(rocfftfloat(T), x)
complexfloat(x::ROCArray{T}) where {T<:Real} = copy1(complex(rocfftfloat(T)), x)

realfloat(x::ROCArray{T}) where {T<:Real} = copy1(rocfftfloat(T), x)

# TODO: use undef alloco
function copy1(::Type{T}, x) where T
    y = ROCArray(T, map(length, axes(x)))
    y .= broadcast(xi->convert(T,xi), x)
end
