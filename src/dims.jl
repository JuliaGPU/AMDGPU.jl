"""
    ROCDim3(x)
    ROCDim3((x,))
    ROCDim3((x, y))
    ROCDim3((x, y, x))

A type used to specify dimensions, consisting of 3 integers for the `x`, `y`,
and `z` dimension, respectively. Unspecified dimensions default to `1`.

Often accepted as argument through the `ROCDim` type alias, eg. in the case of
[`roccall`](@ref) or [`launch_kernel!`](@ref), allowing to pass dimensions as a
plain integer or a tuple without having to construct an explicit `ROCDim3`
object.
"""
struct ROCDim3
    x::Cuint
    y::Cuint
    z::Cuint
end

ROCDim3(dims::Integer)             = ROCDim3(dims,    Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{1,<:Integer}) = ROCDim3(dims[1], Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{2,<:Integer}) = ROCDim3(dims[1], dims[2],  Cuint(1))
ROCDim3(dims::NTuple{3,<:Integer}) = ROCDim3(dims[1], dims[2],  dims[3])

# Type alias for conveniently specifying the dimensions
# (e.g. `(len, 2)` instead of `ROCDim3((len, 2))`)
const ROCDim = Union{Integer,
                     Tuple{Integer},
                     Tuple{Integer, Integer},
                     Tuple{Integer, Integer, Integer}}

function Base.getindex(dims::ROCDim3, idx::Int)
    return idx == 1 ? dims.x :
           idx == 2 ? dims.y :
           idx == 3 ? dims.z :
           error("Invalid dimension: $idx")
end
