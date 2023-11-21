export wavefrontsize

_Clong = Sys.islinux() ? Clong : Clonglong
_Culong = Sys.islinux() ? Culong : Culonglong

for (name,op) in ((:add,typeof(+)), (:max,typeof(max)), (:min,typeof(min)))
    wfred_name = Symbol("wfred_$name")
    wfscan_name = Symbol("wfscan_$name")
    for jltype in (Cint, _Clong, Cuint, _Culong, Float16, Float32, Float64)
        type_suffix = fntypes[jltype]

        @eval @device_function $(wfred_name)(x::$jltype) = ccall(
            $("extern __ockl_wfred_$(name)_$(type_suffix)"), llvmcall,
            $jltype, ($jltype,), x)

        @eval @device_function $(wfscan_name)(x::$jltype, inclusive::Bool) = ccall(
            $("extern __ockl_wfscan_$(name)_$(type_suffix)"), llvmcall,
            $jltype, ($jltype, Bool), x, inclusive)
    end
    @eval @inline wfred(::$op, x) = $(wfred_name)(x)
    @eval @inline wfscan(::$op, x, inclusive::Bool) = $(wfscan_name)(x, inclusive)
end

for (name,op) in ((:and,typeof(&)), (:or,typeof(|)), (:xor,typeof(⊻)))
    wfred_name = Symbol("wfred_$name")
    wfscan_name = Symbol("wfscan_$name")
    for jltype in (Cint, _Clong, Cuint, _Culong)
        type_suffix = fntypes[jltype]

        @eval @device_function $(wfred_name)(x::$jltype) = ccall(
            $("extern __ockl_wfred_$(name)_$(type_suffix)"), llvmcall,
            $jltype, ($jltype,), x)

        @eval @device_function $(wfscan_name)(x::$jltype, inclusive::Bool) = ccall(
            $("extern __ockl_wfscan_$(name)_$(type_suffix)"), llvmcall,
            $jltype, ($jltype, Bool), x, inclusive)
    end
    @eval @inline wfred(::$op, x) = $(wfred_name)(x)
    @eval @inline wfscan(::$op, x, inclusive::Bool) = $(wfscan_name)(x, inclusive)
end

for jltype in (Cuint, _Culong)
    type_suffix = fntypes[jltype]
    @eval @device_function wfbcast(x::$jltype, i::Cuint) = ccall(
        $("extern __ockl_wfbcast_$(type_suffix)"), llvmcall,
        $jltype, ($jltype, Cuint), x, i)
end

@eval @device_function wfany(x::Cint) = ccall(
    $("extern __ockl_wfany_$(fntypes[Cint])"), llvmcall, Bool, (Cint,), x)
@eval @device_function wfall(x::Cint) = ccall(
    $("extern __ockl_wfall_$(fntypes[Cint])"), llvmcall, Bool, (Cint,), x)
@eval @device_function wfsame(x::Cint) = ccall(
    $("extern __ockl_wfsame_$(fntypes[Cint])"), llvmcall, Bool, (Cint,), x)

"""
    wfred(op::Function, val::T) where T -> T

Performs a wavefront-wide reduction on `val` in each lane, and returns the
result. A limited subset of functions are available to be passed as `op`. When
`op` is one of `(+, max, min, &, |, ⊻)`, `T` may be
`<:Union{Cint, Clong, Cuint, Culong}`. When `op` is one of `(+, max, min)`,
`T` may also be `<:Union{Float32, Float64}`.
"""
wfred

"""
    wfscan(op::Function, val::T) where T -> T

Performs a wavefront-wide scan on `val` in each lane, and returns the
result. A limited subset of functions are available to be passed as `op`. When
`op` is one of `(+, max, min, &, |, ⊻)`, `T` may be
`<:Union{Cint, Clong, Cuint, Culong}`. When `op` is one of `(+, max, min)`,
`T` may also be `<:Union{Float32, Float64}`.
"""
wfscan

"Returns the wavefront size of the currently-executing kernel."
@inline wavefrontsize() = ccall("llvm.amdgcn.wavefrontsize", llvmcall, UInt32, ())
