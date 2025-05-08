import Base: FastMath
import SpecialFunctions

const DEFINED_UNARY_INTRNISICS = [
    (:Base, :acos), (:Base, :acosh), (nothing, :acospi), (:Base, :cos), (:Base, :cosh), (:Base, :cospi),
    (:Base, :asin), (:Base, :asinh), (nothing, :asinpi), (:Base, :sin), (:Base, :sinh), (:Base, :sinpi),
    (:Base, :atan), (:Base, :atanh), (nothing, :atanpi), (:Base, :tan), (:Base, :tanh), (nothing, :tanpi),
    (:Base, :log), (:Base, :log2), (:Base, :log10), (:Base, :log1p), (nothing, :logb), (nothing, :ilogb),
    (:Base, :exp), (:Base, :exp2), (:Base, :exp10),
    (:Base, :sqrt), (:Base, :cbrt), (nothing, :rsqrt),
    (:Base, :floor), (:Base, :ceil), (:Base, :trunc),
    (nothing, :nearbyint), (nothing, :nextafter),
]
# SpecialFunctions (SF.fname, OCML intrinsic).
const DEFINED_SF_INTRINSICS = [
    (:loggamma, :lgamma), (:gamma, :tgamma),
    (:bessely0, :y0), (:bessely1, :y1), (:besselj0, :j0), (:besselj1, :j1),
    (:erf, :erf), (:erfc, :erfc), (:erfcx, :erfcx), (:erfinv, :erfinv), (:erfcinv, :erfcinv),
]

for jltype in (Float64, Float32, Float16)
    type_suffix = fntypes[jltype]

    for (mod, intrinsic) in DEFINED_UNARY_INTRNISICS
        # sin(::Float16) is broken, we override it manually at the very bottom.
        jltype == Float16 && intrinsic == :sin && continue
        # log(::Float16) is broken, we override it manually at the very bottom.
        # https://github.com/ROCm/llvm-project/blob/592734c97a3ddcb7ca4009ac94550595a52450ce/amd/device-libs/ocml/src/logH.cl#L15
        jltype == Float16 && intrinsic == :log && continue

        fname = "extern __ocml_$(intrinsic)_$(type_suffix)"
        if isnothing(mod)
            @eval @device_function $intrinsic(x::$jltype) = ccall($fname, llvmcall, $jltype, ($jltype,), x)
        else
            @eval @device_override $mod.$intrinsic(x::$jltype) = ccall($fname, llvmcall, $jltype, ($jltype,), x)
        end
    end

    for (fname, intrinsic) in DEFINED_SF_INTRINSICS
        @eval @device_override SpecialFunctions.$(fname)(x::$jltype) = ccall(
            $("extern __ocml_$(intrinsic)_$(type_suffix)"), llvmcall, $jltype, ($jltype,), x)
    end

    @eval @device_override Base.abs(x::$jltype) = ccall(
        $("extern __ocml_fabs_$(type_suffix)"), llvmcall, $jltype, ($jltype,), x)

    for intrinsic in (:isnan, :isfinite, :isinf, :signbit)
        @eval @device_override Base.$intrinsic(x::$jltype) = ccall(
            $("extern __ocml_$(intrinsic)_$(fntypes[jltype])"), llvmcall, Int32, ($jltype,), x) != zero($jltype)
    end

    # Multi-argument functions.

    @eval @device_override Base.ldexp(x::$jltype, y::Int32) = ccall(
        $("extern __ocml_ldexp_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Int32), x, y)

    @eval @device_function scalbn(x::$jltype, y::Int32) = ccall(
        $("extern __ocml_scalbn_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Int32), x, y)

    @eval @device_override Base.hypot(x::$jltype, y::$jltype) = ccall(
        $("extern __ocml_hypot_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype), x, y)

    @eval @device_override Base.fma(x::$jltype, y::$jltype, z::$jltype) = ccall(
        $("extern __ocml_fma_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype, $jltype), x, y, z)

    @eval @device_override Base.min(x::$jltype, y::$jltype) = ccall(
        $("extern __ocml_min_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype), x, y)

    @eval @device_override Base.max(x::$jltype, y::$jltype) = ccall(
        $("extern __ocml_max_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype), x, y)

    @eval @device_override Base.copysign(x::$jltype, y::$jltype) = ccall(
        $("extern __ocml_copysign_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype), x, y)

    @eval @device_override Base.:(^)(x::$jltype, y::$jltype) = ccall(
        $("extern __ocml_pow_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, $jltype), x, y)

    @eval @device_override Base.:(^)(x::$jltype, y::Int32) = ccall(
        $("extern __ocml_pown_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Int32), x, y)

    @eval @device_override function Base.sincos(x::$jltype)
        ref = Ref{$jltype}()
        ret = ccall($("extern __ocml_sincos_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Ref{$jltype}), x, ref)
        return (ret, ref[])
    end
    @eval @device_override function Base.sincospi(x::$jltype)
        ref = Ref{$jltype}()
        ret = ccall($("extern __ocml_sincospi_$(fntypes[jltype])"), llvmcall, $jltype, ($jltype, Ref{$jltype}), x, ref)
        return (ret, ref[])
    end

    # TODO remove once we drop support for 1.12.
    # Fixes https://github.com/JuliaGPU/AMDGPU.jl/issues/756
    # TL;DR: Julia 1.12 moved to llvm.minimum/maximum & AMDGPU supports it since LLVM 19.
    if v"1.12-" ≤ VERSION < v"1.13-"
        @eval @device_override FastMath.max_fast(x::$jltype, y::$jltype) = Base.max(x, y)
        @eval @device_override FastMath.min_fast(x::$jltype, y::$jltype) = Base.min(x, y)
    end
end

@device_override @inline function Base.:(^)(x::Float32, y::Int64)
    y == -1 && return inv(x)
    y == 0 && return one(x)
    y == 1 && return x
    y == 2 && return x * x
    y == 3 && return x * x * x
    x ^ Float32(y)
end

@device_override @inline function Base.:(^)(x::Float64, y::Int64)
    y == -1 && return inv(x)
    y == 0 && return one(x)
    y == 1 && return x
    y == 2 && return x * x
    y == 3 && return x * x * x
    x ^ Float64(y)
end

@device_override Base.:(^)(x::Integer, p::T) where T<:Union{Float16, Float32, Float64} = T(x) ^ p

@device_override @inline function Base.:(^)(x::Integer, p::Integer)
    p < 0 && throw("Negative integer power not supported")
    p == 0 && return one(x)
    p == 1 && return x
    p == 2 && return x * x
    p == 3 && return x * x * x

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

# sin(Float16) is broken, so cast to Float32, see #177.
@device_override Base.sin(x::Float16) = Float16(sin(Float32(x)))
@device_override Base.log(x::Float16) = Float16(log(Float32(x)))
