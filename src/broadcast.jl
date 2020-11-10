# broadcasting

using Base.Broadcast: BroadcastStyle, Broadcasted

struct ROCArrayStyle{N} <: AbstractGPUArrayStyle{N} end
ROCArrayStyle(::Val{N}) where N = ROCArrayStyle{N}()
ROCArrayStyle{M}(::Val{N}) where {N,M} = ROCArrayStyle{N}()

BroadcastStyle(::Type{<:ROCArray{T,N}}) where {T,N} = ROCArrayStyle{N}()

Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}) where {N,T} =
    similar(ROCArray{T}, axes(bc))

Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}, dims...) where {N,T} =
    ROCArray{T}(undef, dims...)


## replace base functions with libdevice alternatives

rocfunc(f) = f
rocfunc(::Type{T}) where T = (x...) -> T(x...) # broadcasting type ctors isn't GPU compatible

Broadcast.broadcasted(::ROCArrayStyle{N}, f, args...) where {N} =
    Broadcasted{ROCArrayStyle{N}}(rocfunc(f), args, nothing)

const device_intrinsics = :[
    cos, cospi, sin, sinpi, tan, acos, asin, atan,
    cosh, sinh, tanh, acosh, asinh, atanh,
    log, log10, log1p, log2, logb, ilogb,
    exp, exp2, exp10, expm1, ldexp,
    erf, erfinv, erfc, erfcinv, erfcx,
    brev, clz, ffs, byte_perm, popc,
    isfinite, isinf, isnan, nearbyint,
    nextafter, signbit, copysign, abs,
    sqrt, rsqrt, cbrt, rcbrt, pow,
    ceil, floor, saturate,
    lgamma, tgamma,
    j0, j1, jn, y0, y1, yn,
    normcdf, normcdfinv, hypot,
    fma, sad, dim, mul24, mul64hi, hadd, rhadd, scalbn].args

for f in device_intrinsics
    isdefined(Base, f) || continue
    @eval rocfunc(::typeof(Base.$f)) = $f
end

# broadcast ^

rocliteral_pow(::typeof(^), x::T, ::Val{0}) where {T<:Real} = one(x)
rocliteral_pow(::typeof(^), x::T, ::Val{1}) where {T<:Real} = x
rocliteral_pow(::typeof(^), x::T, ::Val{2}) where {T<:Real} = x * x
rocliteral_pow(::typeof(^), x::T, ::Val{3}) where {T<:Real} = x * x * x
rocliteral_pow(::typeof(^), x::T, ::Val{p}) where {T<:Real,p} = pow(x, Int32(p))

rocfunc(::typeof(Base.literal_pow)) = rocliteral_pow
rocfunc(::typeof(Base.:(^))) = pow

using MacroTools

const _rocfuncs = [copy(device_intrinsics); :^]
rocfuncs() = (global _rocfuncs; _rocfuncs)

_rocint(x::Int) = Int32(x)
_rocint(x::Expr) = x.head == :call && x.args[1] == :Int32 && x.args[2] isa Int ? Int32(x.args[2]) : x
_rocint(x) = x

function _rocpowliteral(x::Expr)
    if x.head == :call && x.args[1] == :(AMDGPU.rocfunc(^)) && x.args[3] isa Int32
        num = x.args[3]
        if 0 <= num <= 3
            sym = gensym(:x)
            new_x = Expr(:block, :($sym = $(x.args[2])))

            if iszero(num)
                push!(new_x.args, :(one($sym)))
            else
                unroll = Expr(:call, :*)
                for x = one(num):num
                    push!(unroll.args, sym)
                end
                push!(new_x.args, unroll)
            end

            x = new_x
        end
    end
    x
end
_rocpowliteral(x) = x

function replace_device(ex)
    global _rocfuncs
    MacroTools.postwalk(ex) do x
        x = x in _rocfuncs ? :(AMDGPU.rocfunc($x)) : x
        x = _rocint(x)
        x = _rocpowliteral(x)
        x
    end
end

macro rocfunc(ex)
    global _rocfuncs
    def = MacroTools.splitdef(ex)
    f = def[:name]
    def[:name] = Symbol(:cu, f)
    def[:body] = replace_device(def[:body])
    push!(_rocfuncs, f)
    quote
        $(esc(MacroTools.combinedef(def)))
        AMDGPU.rocfunc(::typeof($(esc(f)))) = $(esc(def[:name]))
    end
end
