# Copied from CUDA.jl/src/device/quirks.jl

# math.jl
@device_override Base.Math.throw_complex_domainerror(f::Symbol, x) =
    @gpu_throw "DomainError" "This operation requires a complex input to return a complex result"
@device_override Base.Math.throw_exp_domainerror(f::Symbol, x) =
    @gpu_throw "DomainError" "Exponentiation yielding a complex result requires a complex argument"

# intfuncs.jl
@device_override Base.throw_domerr_powbysq(::Any, p) =
    @gpu_throw "DomainError" "Cannot raise an integer to a negative power"
@device_override Base.throw_domerr_powbysq(::Integer, p) =
    @gpu_throw "DomainError" "Cannot raise an integer to a negative power"
@device_override Base.throw_domerr_powbysq(::AbstractMatrix, p) =
    @gpu_throw "DomainError" "Cannot raise an integer to a negative power"
@device_override Base.__throw_gcd_overflow(a, b) =
    @gpu_throw "OverflowError" "GCD overflow"

# checked.jl
@device_override Base.Checked.throw_overflowerr_binaryop(op, x, y) =
    @gpu_throw "OverflowError" "Binary operation overflowed"
@device_override Base.Checked.throw_overflowerr_negation(op, x, y) =
    @gpu_throw "OverflowError" "Negation overflowed"
@device_override function Base.Checked.checked_abs(x::Base.Checked.SignedInt)
    r = ifelse(x < 0, -x, x)
    r < 0 && @gpu_throw("OverflowError", "checked arithmetic: cannot compute |x|")
    r
end

# boot.jl
@device_override Core.throw_inexacterror(f::Symbol, ::Type{T}, val) where {T} =
    @gpu_throw "InexactError" "Inexact conversion"

# abstractarray.jl
@device_override Base.throw_boundserror(A, I) =
    @gpu_throw "BoundsError" "Out-of-bounds array access"

# trig.jl
@device_override Base.Math.sincos_domain_error(x) =
    @gpu_throw "DomainError" "sincos(x) is only defined for finite x"

# multidimensional.jl
@device_override Base.@propagate_inbounds function Base.getindex(
    iter::CartesianIndices{N,R}, I::Vararg{Int, N},
) where {N,R}
    @boundscheck checkbounds(iter, I...)
    index = map(iter.indices, I) do r, i
        @inbounds getindex(r, i)
    end
    CartesianIndex(index)
end

# range.jl
@eval begin
    @device_override function Base.StepRangeLen{T,R,S,L}(
        ref::R, step::S, len::Integer, offset::Integer=1,
    ) where {T,R,S,L}
        if T <: Integer && !isinteger(ref + step)
            @gpu_throw("ArgumentError", "StepRangeLen{<:Integer} cannot have non-integer step")
        end
        len = convert(L, len)
        len >= zero(len) || @gpu_throw("ArgumentError", "StepRangeLen length cannot be negative")
        offset = convert(L, offset)
        L1 = oneunit(typeof(len))
        L1 <= offset <= max(L1, len) || @gpu_throw("ArgumentError", "StepRangeLen: offset must be in [1,...]")
        $(Expr(:new, :(StepRangeLen{T,R,S,L}), :ref, :step, :len, :offset))
    end
end

# LinearAlgebra
@device_override function Base.setindex!(
    D::LinearAlgebra.Diagonal, v, i::Int, j::Int,
)
    @boundscheck checkbounds(D, i, j)
    if i == j
        @inbounds D.diag[i] = v
    elseif !iszero(v)
        @gpu_throw("ArgumentError", "Cannot set off-diagonal entry to a nonzero value")
    end
    return v
end

# TODO remove once we support strings/exceptions.
@device_override Base._throw_dmrs(n, str, dims) =
    @gpu_throw "DimensionMismatch" "Dimensions mismatch when reshaping. New dimensions must be consistent with array size"
