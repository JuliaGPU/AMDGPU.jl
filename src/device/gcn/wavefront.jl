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

"""
    wavefrontsize()::Cuint

Get the wavefront size of the device that executes current kernel.
"""
wavefrontsize()::Cuint = ccall("llvm.amdgcn.wavefrontsize", llvmcall, Cuint, ())

"""
    activelane()::Cuint

Get id of the current lane within a wavefront/warp.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = i
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Array(x)
1×8 Matrix{Int32}:
 0  1  2  3  4  5  6  7
```
"""
activelane()::Cuint = ccall("extern __ockl_activelane_u32", llvmcall, Cuint, ())

"""
    ballot(predicate::Bool)::Cuint

Return a value whose `N`th bit is set if and only if `predicate` evaluates to
`true` for the `N`th lane and the lane is active.

```jldoctest
julia> function ker!(x)
           x[1] = AMDGPU.Device.ballot(true)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cuint}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{UInt32, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 0xffffffff
```
"""
ballot(predicate::Bool)::Cuint = ccall(
    "llvm.amdgcn.ballot", llvmcall, Cuint, (Bool,), predicate)

"""
    activemask()::Cuint

Get the mask of all active lanes in a warp.
"""
activemask()::Cuint = ballot(true)

"""
    bpermute(addr::Integer, val::Cint)::Cint

Read data stored in `val` from the lane VGPR (vector general purpose register)
given by `addr`.

The permute instruction moves data between lanes but still uses
the notion of byte addressing, as do other LDS instructions.
Hence, the value in the `addr` VGPR should be `desired_lane_id * 4`,
since VGPR values are 4 bytes wide.

Example below shifts all values in the wavefront by 1 to the "left".

```jldoctest
julia> function ker!(x)
           i::Cint = AMDGPU.Device.activelane()
           # `addr` points to the next immediate lane.
           addr = ((i + 1) % 8) * 4 # VGPRs are 4 bytes wide
           # Read data from the next immediate lane.
           x[i + 1] = AMDGPU.Device.bpermute(addr, i)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int32, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  0
```
"""
bpermute(addr::Integer, val::Cint)::Cint = ccall(
    "llvm.amdgcn.ds.bpermute", llvmcall, Cint, (Cint, Cint), addr, val)

"""
    permute(addr::Integer, val::Cint)::Cint

Put data stored in `val` to the lane VGPR (vector general purpose register)
given by `addr`.

Example below shifts all values in the wavefront by 1 to the "right".

```jldoctest
julia> function ker!(x)
           i::Cint = AMDGPU.Device.activelane()
           # `addr` points to the next immediate lane.
           addr = ((i + 1) % 8) * 4 # VGPRs are 4 bytes wide
           # Put data into the next immediate lane.
           x[i + 1] = AMDGPU.Device.permute(addr, i)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int32, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 7  0  1  2  3  4  5  6
```
"""
permute(addr::Integer, val::Cint)::Cint = ccall(
    "llvm.amdgcn.ds.permute", llvmcall, Cint, (Cint, Cint), addr, val)

_shfl(op, x::UInt8) = op(Cint(x)) % UInt8
_shfl(op, x::UInt16) = op(Cint(x)) % UInt16
_shfl(op, x::UInt32) = reinterpret(UInt32, op(reinterpret(Cint, x)))
_shfl(op, x::UInt64) =
    (UInt64(op((x >>> 32) % Cint)) << 32) |
    UInt64(op((x & typemax(UInt32)) % Cint))
_shfl(op, x::UInt128) =
    (UInt128(_shfl(op, (x >>> 64) % UInt64)) << 64) |
    UInt128(_shfl(op, ((x & typemax(UInt64)) % UInt64)))

_shfl(op, x::Int8) = reinterpret(Int8, _shfl(op, reinterpret(UInt8, x)))
_shfl(op, x::Int16) = reinterpret(Int16, _shfl(op, reinterpret(UInt16, x)))
_shfl(op, x::Int64) = reinterpret(Int64, _shfl(op, reinterpret(UInt64, x)))
_shfl(op, x::Int128) = reinterpret(Int128, _shfl(op, reinterpret(UInt128, x)))

_shfl(op, x::Float16) = reinterpret(Float16, _shfl(op, reinterpret(UInt16, x)))
_shfl(op, x::Float32) = reinterpret(Float32, op(reinterpret(Cint, x)))
_shfl(op, x::Float64) = reinterpret(Float64, _shfl(op, reinterpret(UInt64, x)))

_shfl(op, x::Bool) = op(Cint(x)) % Bool
_shfl(op, x::Complex) = Complex(_shfl(op, real(x)), _shfl(op, imag(x)))

function shfl(val::Cint, lane, width = 32)
    self::Cint = activelane()
    index::Cint = (lane & (width - 0x1)) + (self & ~(width - 0x1))
    bpermute(index << 0x2, val)
end

function shfl_up(val::Cint, δ, width = 32)
    self::Cint = activelane()
    index::Cint = self - Cint(δ)
    # Check if `index` is lower than `self` partitioned by `width`.
    index = ifelse(index < (self & ~(width - 0x1)), self, index)
    bpermute(index << 0x2, val)
end

function shfl_down(val::Cint, δ, width = 32)
    self::Cint = activelane()
    index::Cint = self + Cint(δ)
    index = ifelse((self & (width - 0x1)) + δ ≥ width, self, index)
    bpermute(index << 0x2, val)
end

function shfl_xor(val::Cint, lane_mask, width = 32)
    self::Cint = activelane()
    index::Cint = self ⊻ Cint(lane_mask)
    index = ifelse(index ≥ (self + width) & ~(width - 0x1), self, index)
    bpermute(index << 0x2, val)
end

"""
    shfl(val, lane, width = 32)

Read data stored in `val` from a `lane`
(this is a more high-level op than [`bpermute`](@ref)).

If `lane` is outside the range `[0:width - 1]`, the value returned corresponds
to the value held by the `lane modulo width` (within the same subsection).

```jldoctest
julia> function ker!(x)
           i::UInt32 = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl(i, i + 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt32}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Int.(x)
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  0
```

If `width` is less than wavefront size then each subsection of the wavefront
behaves as a separate entity with a starting logical lane ID of 0.

```jldoctest
julia> function ker!(x)
           i::UInt32 = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl(i, i + 1, 4) # <-- Notice width = 4.
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt32}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Int.(x)
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  0  5  6  7  4
```
"""
@inline shfl(val, lane, width = 32) = _shfl(x -> shfl(x, lane, width), val)

"""
    shfl_up(val, δ, width = 32)

Same as [`shfl`](@ref), but instead of specifying lane ID,
accepts `δ` that is subtracted from the current lane ID.
I.e. read from a lane with lower ID relative to the caller.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_up(i, 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 0  0  1  2  3  4  5  6
```
"""
@inline shfl_up(val, δ, width = 32) = _shfl(x -> shfl_up(x, δ, width), val)

"""
    shfl_down(val, δ, width = 32)

Same as [`shfl`](@ref), but instead of specifying lane ID,
accepts `δ` that is added to the current lane ID.
I.e. read from a lane with higher ID relative to the caller.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_down(i, 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  7
"""
@inline shfl_down(val, δ, width = 32) = _shfl(x -> shfl_down(x, δ, width), val)

"""
    shfl_xor(val, lane_mask, width = 32)

Same as [`shfl`](@ref), but instead of specifying lane ID,
performs bitwise XOR of the caller's lane ID with the `lane_mask`.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_xor(i, 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  0  3  2  5  4  7  6
```
"""
@inline shfl_xor(val, lane_mask, width = 32) =
    _shfl(x -> shfl_xor(x, lane_mask, width), val)
