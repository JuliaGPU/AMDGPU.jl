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


import Random
function Random.randn!(rng::GPUArrays.RNG, A::ROCArray{T}) where T<:Union{Float16, Float32, Float64}
    elements = (length(A) - 1) ÷ 2 + 1
    length(A) == 0 && return
    function _randn!_kernel(ctx, a, randstates)
        idx = 2*(GPUArrays.linear_index(ctx) - 1) + 1
        U1 = GPUArrays.gpu_rand(T, ctx, randstates)
        U2 = GPUArrays.gpu_rand(T, ctx, randstates)
        Z0 = sqrt(T(-2.0)*log(U1))*cos(T(2pi)*U2)
        Z1 = sqrt(T(-2.0)*log(U1))*sin(T(2pi)*U2)
        @inbounds a[idx] = Z0
        idx + 1 > length(a) && return
        @inbounds a[idx + 1] = Z1
        return
    end
    gpu_call(ROCArrayBackend(), _randn!_kernel, (A, rng.state); elements)
    A
end
