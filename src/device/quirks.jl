# Copied from CUDA.jl/src/device/quirks.jl

macro print_and_throw(description)
    quote
        # FIXME
        # all functions that take part in exception reporting are not inlined
        @errprintf($description)
        throw(nothing)
    end
end

# math.jl
@device_override Base.Math.throw_complex_domainerror(f::Symbol, x) =
    @print_and_throw "This operation requires a complex input to return a complex result.\n"
@device_override Base.Math.throw_exp_domainerror(f::Symbol, x) =
    @print_and_throw "Exponentiation yielding a complex result requires a complex argument.\n"

# intfuncs.jl
@device_override Base.throw_domerr_powbysq(::Any, p) =
    @print_and_throw "Cannot raise an integer to a negative power.\n"
@device_override Base.throw_domerr_powbysq(::Integer, p) =
    @print_and_throw "Cannot raise an integer to a negative power.\n"
@device_override Base.throw_domerr_powbysq(::AbstractMatrix, p) =
    @print_and_throw "Cannot raise an integer to a negative power.\n"
@device_override Base.__throw_gcd_overflow(a, b) =
    @print_and_throw "GCD overflow.\n"

# checked.jl
@device_override Base.Checked.throw_overflowerr_binaryop(op, x, y) =
    @print_and_throw "Binary operation overflowed.\n"
@device_override Base.Checked.throw_overflowerr_negation(op, x, y) =
    @print_and_throw "Negation overflowed.\n"
@device_override function Base.Checked.checked_abs(x::Base.Checked.SignedInt)
    r = ifelse(x < 0, -x, x)
    r < 0 && @print_and_throw("checked arithmetic: cannot compute |x|.\n")
    r
end

# boot.jl
@device_override Core.throw_inexacterror(f::Symbol, ::Type{T}, val) where {T} =
    @print_and_throw "Inexact conversion.\n"

# abstractarray.jl
@device_override Base.throw_boundserror(A, I) =
    @print_and_throw "Out-of-bounds array access.\n"

# trig.jl
@device_override Base.Math.sincos_domain_error(x) =
    @print_and_throw "sincos(x) is only defined for finite x.\n"

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
            @print_and_throw("StepRangeLen{<:Integer} cannot have non-integer step.\n")
        end
        len = convert(L, len)
        len >= zero(len) || @print_and_throw("StepRangeLen length cannot be negative.\n")
        offset = convert(L, offset)
        L1 = oneunit(typeof(len))
        L1 <= offset <= max(L1, len) || @print_and_throw("StepRangeLen: offset must be in [1,...].\n")
        $(Expr(:new, :(StepRangeLen{T,R,S,L}), :ref, :step, :len, :offset))
    end
end

# LinearAlgebra
@static if VERSION >= v"1.8-"
    @device_override function Base.setindex!(
        D::LinearAlgebra.Diagonal, v, i::Int, j::Int,
    )
        @boundscheck checkbounds(D, i, j)
        if i == j
            @inbounds D.diag[i] = v
        elseif !iszero(v)
            @print_and_throw("Cannot set off-diagonal entry to a nonzero value.\n")
        end
        return v
    end
end
