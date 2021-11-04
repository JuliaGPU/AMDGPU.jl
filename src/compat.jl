# Hacks that can be ripped out once we support device overrides

function LinearAlgebra.norm(v::ROCArray{T}, p::Real=2) where {T}
    if p == Inf
        maximum(abs.(v))
    elseif p == -Inf
        minimum(abs.(v))
    else
        mapreduce(x->AMDGPU.pow(AMDGPU.abs(x), p), +, v; init=zero(T))^(1/p)
    end
end

@inline function ssqs(x::T, y::T) where T<:Real
    k::Int = 0
    ρ = x*x + y*y
    if isfinite(ρ) && (isinf(x) || isinf(y))
        ρ = convert(T, Inf)
    elseif isinf(ρ) || (ρ==0 && (x!=0 || y!=0)) || ρ<nextfloat(zero(T))/(2*eps(T)^2)
        m::T = max(abs(x), abs(y))
        k = m==0 ? m : exponent(m)
        xk, yk = ldexp(x,-k), ldexp(y,-k)
        ρ = xk*xk + yk*yk
    end
    ρ, k
end

@inline function sqrt(z::Complex)
    z = float(z)
    x, y = reim(z)
    if x==y==0
        return Complex(zero(x),y)
    end
    ρ, k::Int = ssqs(x, y)
    if isfinite(x)
         ρ=ldexp(abs(x),-k)+sqrt(ρ)
    end
    if isodd(k)
        k = div(k-1,2)
    else
        k = div(k,2)-1
        ρ += ρ
    end
    ρ = ldexp(sqrt(ρ),k) #sqrt((abs(z)+abs(x))/2) without over/underflow
    ξ = ρ
    η = y
    if ρ != 0
        if isfinite(η)
            η=(η/ρ)/2
        end
        if x<0
            ξ = abs(η)
            η = copysign(ρ,y)
        end
    end
    Complex(ξ,η)
end


import Statistics
function Statistics.corzm(x::ROCArray{<:Any, 2}, vardim::Int=1)
    c = Statistics.unscaled_covzm(x, vardim)
    return Statistics.cov2cor!(c, sqrt.(LinearAlgebra.diag(c)))
end
