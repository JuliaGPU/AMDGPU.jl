import Base: FastMath

import SpecialFunctions

for jltype in (Float64, Float32, Float16)
    type_suffix = fntypes[jltype]

    # Single-argument functions.

    for (mod, intrinsic) in (
        (:Base, :acos), (:Base, :acosh), (nothing, :acospi), (:Base, :cos), (:Base, :cosh), (:Base, :cospi),
        (:Base, :asin), (:Base, :asinh), (nothing, :asinpi), (:Base, :sin), (:Base, :sinh), (:Base, :sinpi),
        (:Base, :atan), (:Base, :atanh), (nothing, :atanpi), (:Base, :tan), (:Base, :tanh), (nothing, :tanpi),
        (:Base, :log), (:Base, :log2), (:Base, :log10), (:Base, :log1p), (nothing, :logb), (nothing, :ilogb),
        (:Base, :exp), (:Base, :exp2), (:Base, :exp10),
        (:Base, :sqrt), (:Base, :cbrt), (nothing, :rsqrt),
        (nothing, :lgamma), (nothing, :lgamma_r),
        (:Base, :floor), (:Base, :ceil), (:Base, :trunc),
        (nothing, :nearbyint), (nothing, :nextafter),
    )
        fname = "extern __ocml_$(intrinsic)_$(type_suffix)"
        if isnothing(mod)
            @eval @device_function function $intrinsic(x::$jltype)
                ccall($fname, llvmcall, $jltype, ($jltype,), x)
            end
        else
            @eval @device_override function $mod.$intrinsic(x::$jltype)
                ccall($fname, llvmcall, $jltype, ($jltype,), x)
            end
        end
    end

    fname = "extern __ocml_fabs_$(type_suffix)"
    @eval @device_override function Base.abs(x::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype,), x)
    end

    # Return boolean value.

    for intrinsic in (:isnan, :isfinite, :isinf, :signbit)
        fname = "extern __ocml_$(intrinsic)_$(fntypes[jltype])"
        @eval @device_override function Base.$intrinsic(x::$jltype)
            ccall($fname, llvmcall, Int32, ($jltype,), x) != zero($jltype)
        end
    end

    # Multi-argument functions.

    fname = "extern __ocml_ldexp_$(fntypes[jltype])"
    @eval @device_override function Base.ldexp(x::$jltype, y::Int32)
        ccall($fname, llvmcall, $jltype, ($jltype, Int32), x, y)
    end

    fname = "extern __ocml_scalbn_$(fntypes[jltype])"
    @eval @device_function function scalbn(x::$jltype, y::Int32)
        ccall($fname, llvmcall, $jltype, ($jltype, Int32), x, y)
    end

    fname = "extern __ocml_hypot_$(fntypes[jltype])"
    @eval @device_override function Base.hypot(x::$jltype, y::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype), x, y)
    end

    fname = "extern __ocml_fma_$(fntypes[jltype])"
    @eval @device_override function Base.fma(x::$jltype, y::$jltype, z::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype, $jltype), x, y, z)
    end

    fname = "extern __ocml_min_$(fntypes[jltype])"
    @eval @device_override function Base.min(x::$jltype, y::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype), x, y)
    end

    fname = "extern __ocml_max_$(fntypes[jltype])"
    @eval @device_override function Base.max(x::$jltype, y::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype), x, y)
    end

    fname = "extern __ocml_copysign_$(fntypes[jltype])"
    @eval @device_override function Base.copysign(x::$jltype, y::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype), x, y)
    end

    fname = "extern __ocml_pow_$(fntypes[jltype])"
    @eval @device_override function Base.:(^)(x::$jltype, y::$jltype)
        ccall($fname, llvmcall, $jltype, ($jltype, $jltype), x, y)
    end

    fname = "extern __ocml_pown_$(fntypes[jltype])"
    @eval @device_override function Base.:(^)(x::$jltype, y::Int32)
        ccall($fname, llvmcall, $jltype, ($jltype, Int32), x, y)
    end
end

@device_override @inline function Base.:(^)(x::Float32, y::Int64)
    y == -1 && return inv(x)
    y == 0 && return one(x)
    y == 1 && return x
    y == 2 && return x*x
    y == 3 && return x*x*x
    x ^ Float32(y)
end

@device_override @inline function Base.:(^)(x::Float64, y::Int64)
    y == -1 && return inv(x)
    y == 0 && return one(x)
    y == 1 && return x
    y == 2 && return x*x
    y == 3 && return x*x*x
    x ^ Float64(y)
end

const MATH_INTRINSICS = GCNIntrinsic[]

# for jltype in (Float16, Float32, Float64)
#     for intrinsic in (
#         :sin, :cos, :tan, :asin, :acos, :atan, :atan2,
#         :sinh, :cosh, :tanh, :asinh, :acosh, :atanh,
#         :sinpi, :cospi, :tanpi,
#         :asinpi, :acospi, :atanpi, :atan2pi,
#         :sqrt, :rsqrt, :cbrt, :rcbrt, :recip,
#         :log, :log2, :log10, :log1p, :logb, :ilogb,
#         :exp, :exp2, :exp10, :expm1,
#         :erf, :erfinv, :erfc, :erfcinv, :erfcx,
#         # TODO: :brev, :clz, :ffs, :byte_perm, :popc,
#         :isnormal, :nearbyint, :nextafter,
#         :lgamma)
#         # FIXME: :lgamma_r segfaults on GPU

#         if intrinsic == :sin && jltype == Float16
#             continue # FIXME: https://github.com/JuliaGPU/AMDGPU.jl/issues/177
#             push!(MATH_INTRINSICS, GCNIntrinsic(intrinsic, inp_args=(jltype,), out_arg=jltype, isbroken=true))
#         end

#         push!(MATH_INTRINSICS, GCNIntrinsic(intrinsic, inp_args=(jltype,), out_arg=jltype))
#     end

#     push!(MATH_INTRINSICS, GCNIntrinsic(:besselj0, :j0; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:besselj1, :j1; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:bessely0, :y0; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:bessely1, :y1; inp_args=(jltype,), out_arg=jltype))

#     push!(MATH_INTRINSICS, GCNIntrinsic(:sin_fast, :native_sin; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:cos_fast, :native_cos; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:sqrt_fast, :native_sqrt; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:rsqrt_fast, :native_rsqrt; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:recip_fast, :native_recip; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:log_fast, :native_log; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:log2_fast, :native_log2; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:log10_fast, :native_log10; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:exp_fast, :native_exp; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:exp2_fast, :native_exp2; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:exp10_fast, :native_exp10; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:abs, :fabs; inp_args=(jltype,), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:gamma, :tgamma; inp_args=(jltype,), out_arg=jltype))
#     # TODO: abs(::Union{Int32,Int64})

#     # Multi-argument functions
#     push!(MATH_INTRINSICS, GCNIntrinsic(:^, :pow; inp_args=(jltype,jltype), out_arg=jltype))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:^, :pown; inp_args=(jltype,Union{UInt32,Int32}), out_arg=jltype))
#     # TODO: :copysign,
#     push!(MATH_INTRINSICS, GCNIntrinsic(:ldexp; inp_args=(jltype,Union{UInt32,Int32}), out_arg=jltype))

#     @eval @device_override function Base.frexp(x::$jltype)
#         ref = Ref{Int32}()
#         ret = ccall($("extern __ocml_frexp_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Ptr{Int32}), x, ref)
#         return (ret, Base.unsafe_trunc(Int64, ref[]))
#     end
#     @eval @device_override function Base.sincos(x::$jltype)
#         ref = Ref{$jltype}()
#         ret = ccall($("extern __ocml_sincos_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Ptr{$jltype}), x, ref)
#         return (ret, ref[])
#     end
#     @eval @device_override function Base.sincospi(x::$jltype)
#         ref = Ref{$jltype}()
#         ret = ccall($("extern __ocml_sincospi_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Ptr{$jltype}), x, ref)
#         return (ret, ref[])
#     end

#     push!(MATH_INTRINSICS, GCNIntrinsic(:hypot; inp_args=(jltype,jltype), out_arg=jltype))
# end

# for jltype in (Float32, Float64)
#     push!(MATH_INTRINSICS, GCNIntrinsic(:isfinite; inp_args=(jltype,), out_arg=Int32, tobool=true))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:isinf; inp_args=(jltype,), out_arg=Int32, tobool=true))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:isnan; inp_args=(jltype,), out_arg=Int32, tobool=true))
#     push!(MATH_INTRINSICS, GCNIntrinsic(:signbit; inp_args=(jltype,), out_arg=Int32, tobool=true))
# end

for intr in MATH_INTRINSICS
    inp_vars = [gensym() for _ in 1:length(intr.inp_args)]
    inp_expr = [:($(inp_vars[idx])::$arg) for (idx,arg) in enumerate(intr.inp_args)]
    libname = Symbol("__$(intr.roclib)_$(intr.rocname)_$(intr.suffix)")
    mod = if isdefined(Base, intr.jlname)
        Base
    elseif isdefined(FastMath, intr.jlname)
        FastMath
    elseif isdefined(SpecialFunctions, intr.jlname)
        SpecialFunctions
    else
        nothing
    end
    ex = quote
        y = _intr($(Val(libname)), $(intr.out_arg), $(inp_expr...))
        y = $(intr.isinverted ? :(1-y) : :y)
        y = $(intr.tobool ? :(y != zero(y)) : :y)
        return y
    end
    if mod !== nothing
        @eval @device_override function $mod.$(intr.jlname)($(inp_expr...))
            $ex
        end
    else
        @eval @device_function function $(intr.jlname)($(inp_expr...))
            $ex
        end
    end
end

## non-trivial intrinsics

# ocml_sin seems broken for F16 (see #177)
# @device_override Base.sin(x::Float16) = sin(Float32(x))

# @device_override Base.hypot(x::T, y::T) where T <: Integer = hypot(float(x), float(y))

# Non-matching types
# @device_override @inline function Base.:(^)(x::T, y::S) where {T<:Union{Float16, Float32,Float64}, S<:Union{Int64,UInt64}}
#     y == -1 && return inv(x)
#     y == 0 && return one(x)
#     y == 1 && return x
#     y == 2 && return x*x
#     y == 3 && return x*x*x
#     if S === Int64 && typemin(Int32) <= y <= typemax(Int32)
#         return x ^ unsafe_trunc(Int32, y)
#     elseif S === UInt64 && typemin(UInt32) <= y <= typemax(UInt32)
#         return x ^ unsafe_trunc(UInt32, y)
#     end
#     x ^ T(y)
# end
# @device_override Base.:(^)(x::Integer, p::T) where T<:Union{Float16, Float32, Float64} = T(x) ^ p

# @device_override @inline function Base.:(^)(x::Integer, p::Integer)
#     p < 0 && throw("Negative integer power not supported")
#     p == 0 && return one(x)
#     p == 1 && return x
#     p == 2 && return x*x
#     p == 3 && return x*x*x

#     t = trailing_zeros(p) + 1
#     p >>= t
#     while (t -= 1) > 0
#         x *= x
#     end
#     y = x
#     while p > 0
#         t = trailing_zeros(p) + 1
#         p >>= t
#         while (t -= 1) >= 0
#             x *= x
#         end
#         y *= x
#     end
#     return y
# end
