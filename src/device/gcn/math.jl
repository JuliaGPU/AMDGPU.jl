const MATH_INTRINSICS = GCNIntrinsic[]

for jltype in (Float16, Float32, Float64)
    for intrinsic in (
        :sin, :cos, :tan, :asin, :acos, :atan, :atan2,
        :sinh, :cosh, :tanh, :asinh, :acosh, :atanh,
        :sinpi, :cospi, :tanpi,
        :asinpi, :acospi, :atanpi, :atan2pi,
        :sqrt, :rsqrt, :cbrt, :rcbrt, :recip,
        :log, :log2, :log10, :log1p, :logb, :ilogb,
        :exp, :exp2, :exp10, :expm1,
        :erf, :erfinv, :erfc, :erfcinv, :erfcx,
        # TODO: :brev, :clz, :ffs, :byte_perm, :popc,
        :isnormal, :nearbyint, :nextafter,
        :tgamma, :j0, :j1, :y0, :y1)

        intrinsic == :expm1 && jltype == Float16 && continue
        intrinsic == :erfinv && jltype == Float16 && continue
        intrinsic == :erfcinv && jltype == Float16 && continue

        if intrinsic == :sin && jltype == Float16
            continue # FIXME: https://github.com/JuliaGPU/AMDGPU.jl/issues/177
            push!(MATH_INTRINSICS, GCNIntrinsic(intrinsic, inp_args=(jltype,), out_arg=jltype, isbroken=true))
        end

        push!(MATH_INTRINSICS, GCNIntrinsic(intrinsic, inp_args=(jltype,), out_arg=jltype))
    end

    push!(MATH_INTRINSICS, GCNIntrinsic(:sin_fast, :native_sin; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:cos_fast, :native_cos; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:sqrt_fast, :native_sqrt; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:rsqrt_fast, :native_rsqrt; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:recip_fast, :native_recip; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:log_fast, :native_log; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:log2_fast, :native_log2; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:log10_fast, :native_log10; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:exp_fast, :native_exp; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:exp2_fast, :native_exp2; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:exp10_fast, :native_exp10; inp_args=(jltype,), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:abs, :fabs; inp_args=(jltype,), out_arg=jltype))
    # TODO: abs(::Union{Int32,Int64})

    # Multi-argument functions
    push!(MATH_INTRINSICS, GCNIntrinsic(:pow; inp_args=(jltype,jltype), out_arg=jltype))
    push!(MATH_INTRINSICS, GCNIntrinsic(:pow, :pown; inp_args=(jltype,Union{UInt32,Int32}), out_arg=jltype))
    # TODO: push!(MATH_INTRINSICS, GCNIntrinsic(:pow, :pown; inp_args=(jltype,Union{UInt32,Int32}), out_arg=jltype))
    # TODO: :sincos, :frexp, :ldexp, :copysign,
    #push!(MATH_INTRINSICS, GCNIntrinsic(:ldexp; inp_args=(jltype,), out_arg=(jltype, Int32), isinverted=true))

    push!(MATH_INTRINSICS, GCNIntrinsic(:hypot; inp_args=(jltype,jltype), out_arg=jltype))

    # Multi-output functions
    push!(MATH_INTRINSICS, GCNIntrinsic(:sincospi; inp_args=(jltype,), out_arg=jltype, isbroken=true))
end

for jltype in (Float32, Float64)
    push!(MATH_INTRINSICS, GCNIntrinsic(:isfinite; inp_args=(jltype,), out_arg=Int32, tobool=true))
    push!(MATH_INTRINSICS, GCNIntrinsic(:isinf; inp_args=(jltype,), out_arg=Int32, tobool=true))
    push!(MATH_INTRINSICS, GCNIntrinsic(:isnan; inp_args=(jltype,), out_arg=Int32, tobool=true))
    push!(MATH_INTRINSICS, GCNIntrinsic(:signbit; inp_args=(jltype,), out_arg=Int32))
end

for intr in MATH_INTRINSICS
    inp_vars = [gensym() for _ in 1:length(intr.inp_args)]
    inp_expr = [:($(inp_vars[idx])::$arg) for (idx,arg) in enumerate(intr.inp_args)]
    libname = Symbol("__$(intr.roclib)_$(intr.rocname)_$(intr.suffix)")
    @eval @inline function $(intr.jlname)($(inp_expr...))
        y = _intr($(Val(libname)), $(intr.out_arg), $(inp_expr...))
        y = $(intr.isinverted ? :(1-y) : :y)
        y = $(intr.tobool ? :(y != zero(y)) : :y)
        return y
    end
end

# ocml_sin seems broken for F16 (see #177)
sin(x::Float16) = sin(Float32(x))

hypot(x::T, y::T) where T <: Integer = hypot(float(x), float(y))
abs(z::Complex) = hypot(real(z), imag(z))
abs(i::Integer) = Base.abs(i)

@inline function pow(x::T, y::Int64) where T<:Union{Float16, Float32,Float64}
    y == -1 && return inv(x)
    y == 0 && return one(x)
    y == 1 && return x
    y == 2 && return x*x
    y == 3 && return x*x*x
    pow(x, T(y))
end

pow(x::Integer, p::Union{Float16, Float32, Float64}) = pow(convert(typeof(p), x), p)
@inline function pow(x::Integer, p::Integer)
    p < 0 && throw("Negative integer power not supported")
    p == 0 && return one(x)
    p == 1 && return x
    p == 2 && return x*x
    p == 3 && return x*x*x

    t = trailing_zeros(p) + 1
    p >>= t
    while (t -= 1) > 0
        x *= x
    end
    y = x
    while p > 0
        t = trailing_zeros(p) + 1
        p >>= t
        while (t -= 1) >= 0
            x *= x
        end
        y *= x
    end
    return y
end