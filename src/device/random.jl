# Copied from CUDA.jl/src/device/random.jl


## random number generation

using Random
import RandomNumbers


# global state

# NOTE: the generated function is `alwaysinline`, which ensures we don't access LDS in a
#       non-kernel function
@llvmgenerated builder function emit_global_random_values(::Val{name})::LLVMPtr{UInt32,AS.Local} where name
    T_val = convert(LLVMType, UInt32)
    T_ptr = convert(LLVMType, LLVMPtr{UInt32,AS.Local})

    # create a global memory global variable
    T_global = LLVM.ArrayType(T_val, 32)
    gv = GlobalVariable(current_module(builder), T_global, "__zeroinit_global_random_$(name)", AS.Local)
    gv.linkage = LLVM.API.LLVMExternalLinkage

    ptr = gep!(builder, T_global, gv, [ConstantInt(0), ConstantInt(0)])
    bitcast!(builder, ptr, T_ptr)
end

# shared memory with the actual seed, per warp, loaded lazily or overridden by calling `seed!`
@inline function global_random_keys()
    ptr = emit_global_random_values(Val{:keys}())
    return ROCDeviceArray{UInt32,1,AS.Local}((32,), ptr)
end

# shared memory with per-warp counters, incremented when generating numbers
@inline function global_random_counters()
    ptr = emit_global_random_values(Val{:counters}())
    return ROCDeviceArray{UInt32,1,AS.Local}((32,), ptr)
end

# generators

using Random123: philox2x_round, philox2x_bumpkey

# GPU-compatible/optimized version of the generator from Random123.jl
struct Philox2x32{R} <: RandomNumbers.AbstractRNG{UInt64}
    @inline function Philox2x32{R}() where R
        rng = new{R}()
        if rng.key == 0
            # initialize the key. this happens when first accessing
            # the (0-initialized) shared memory key from each block.
            @static if VERSION >= v"1.11-"
                Random.seed!(rng, nothing)
            else
                rng.key = Random.make_seed()
            end
        end
        return rng
    end
end

# default to 7 rounds; enough to pass SmallCrush
@inline Philox2x32() = Philox2x32{7}()

@inline function Base.getproperty(rng::Philox2x32, field::Symbol)
    threadId = workitemIdx().x +
        (workitemIdx().y - Int32(1)) * workgroupDim().x +
        (workitemIdx().z - Int32(1)) * workgroupDim().x * workgroupDim().y
    wavefrontsize_log2 = ifelse(wavefrontsize() == UInt32(32), 0x5, 0x6)
    warpId = (threadId - Int32(1)) >> wavefrontsize_log2 + Int32(1)  # fld1 by 32

    if field === :key
        @inbounds global_random_keys()[warpId]
    elseif field === :ctr1
        @inbounds global_random_counters()[warpId]
    elseif field === :ctr2
        blockId = workgroupIdx().x +
            (workgroupIdx().y - Int32(1)) * gridGroupDim().x +
            (workgroupIdx().z - Int32(1)) * gridGroupDim().x * gridGroupDim().y
        globalId = threadId + (blockId - Int32(1)) *
            (workgroupDim().x * workgroupDim().y * workgroupDim().z)
        globalId % UInt32
    end::UInt32
end

@inline function Base.setproperty!(rng::Philox2x32, field::Symbol, x)
    threadId = workitemIdx().x +
        (workitemIdx().y - Int32(1)) * workgroupDim().x +
        (workitemIdx().z - Int32(1)) * workgroupDim().x * workgroupDim().y
    wavefrontsize_log2 = ifelse(wavefrontsize() == UInt32(32), 0x5, 0x6)
    warpId = (threadId - Int32(1)) >> wavefrontsize_log2 + Int32(1)  # fld1 by 32

    if field === :key
        @inbounds global_random_keys()[warpId] = x
    elseif field === :ctr1
        @inbounds global_random_counters()[warpId] = x
    end
end

@device_override @inline Random.default_rng() = Philox2x32()

"""
    Random.seed!(rng::Philox2x32, seed::Integer, [counter::Integer=0])

Seed the on-device Philox2x32 generator with an UInt32 number.
Should be called by at least one thread per warp.
"""
function Random.seed!(rng::Philox2x32, seed::Integer, counter::Integer=0)
    rng.key = seed % UInt32
    rng.ctr1 = counter
    return
end

# seeding the implicit default RNG
if VERSION >= v"1.11-"
    @device_override Random.seed!(seed) =
        Random.seed!(Random.default_rng(), seed)
else
    @device_override Random.seed!(::Random._GLOBAL_RNG, seed) =
        Random.seed!(Random.default_rng(), seed)
end

if VERSION >= v"1.11-"
    # `Random.seed!(::AbstractRNG)` now passes a `nothing` seed value
    Random.seed!(rng::Philox2x32, seed::Nothing) =
        Random.seed!(rng, Base.unsafe_trunc(UInt32, readcyclecounter()))
else
    # ... where it used to call `Random_make_seed()`
    @device_override Random.make_seed() = Base.unsafe_trunc(UInt32, readcyclecounter())
end

"""
    Random.rand(rng::Philox2x32, UInt32)

Generate a byte of random data using the on-device Tausworthe generator.
"""
function Random.rand(rng::Philox2x32{R},::Type{UInt64}) where {R}
    ctr1, ctr2, key = rng.ctr1, rng.ctr2, rng.key

    if R > 0                               ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 1  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 2  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 3  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 4  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 5  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 6  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 7  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 8  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 9  key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 10 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 11 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 12 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 13 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 14 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end
    if R > 15 key = philox2x_bumpkey(key); ctr1, ctr2 = philox2x_round(ctr1, ctr2, key); end

    # update the warp counter
    # NOTE: this performs the same update on every thread in the warp, but each warp writes
    #       to a unique location so the duplicate writes are innocuous
    # XXX: what if this overflows? we can't increment ctr2. bump the key?
    rng.ctr1 += Int32(1)

    # NOTE: it's too expensive to keep both numbers around in case the user only wanted one,
    #       so just make our 2x32 generator return 64-bit numbers by default.
    return (ctr1 % UInt64) << 32 | (ctr2 % UInt64)
end



# normally distributed random numbers using Ziggurat algorithm
#
# copied from Base because we don't support its global tables

# a hacky method of exposing constant tables as constant GPU memory
@llvmgenerated builder function emit_constant_array(::Val{name}, ::Type{T})::LLVMPtr{T,AS.Constant} where {name, T}
    data = getfield(Random, name)::AbstractArray{T}
    T_val = convert(LLVMType, T)
    T_ptr = convert(LLVMType, LLVMPtr{T,AS.Constant})

    # create a global memory global variable
    # TODO: global_var alignment?
    T_global = LLVM.ArrayType(T_val, length(data))
    # XXX: why can't we use a single name like emit_shmem
    gv = GlobalVariable(current_module(builder), T_global, "gpu_$(name)_data", AS.Constant)
    gv.alignment = 16
    gv.linkage = LLVM.API.LLVMInternalLinkage
    gv.initializer = ConstantArray(data)

    ptr = gep!(builder, T_global, gv, [ConstantInt(0), ConstantInt(0)])
    bitcast!(builder, ptr, T_ptr)
end

for var in [:ki, :wi, :fi, :ke, :we, :fe]
    val = getfield(Random, var)
    gpu_var = Symbol("gpu_$var")
    arr_typ = :(ROCDeviceArray{$(eltype(val)),$(ndims(val)),AS.Constant})
    @eval @inline $gpu_var() =
        $arr_typ($(size(val)), emit_constant_array($(Val(var)), $(eltype(val))))
end

## randn

@device_override @inline function Random.randn(rng::AbstractRNG)
    @label retry
    r = Random.rand(rng, Random.UInt52Raw())
    @inbounds begin
        r &= 0x000fffffffffffff
        rabs = Int64(r >> 1) # One bit for the sign
        idx = rabs & 0xFF
        x = ifelse(r % Bool, -rabs, rabs)*gpu_wi()[idx+1]
        rabs < gpu_ki()[idx+1] && return x # 99.3% of the time we return here 1st try
        # TODO: This code could be outlined once LLVM supports LDS access in recursively-called functions
        @inbounds if idx == 0
            while true
                xx = -Random.ziggurat_nor_inv_r*log(Random.rand(rng))
                yy = -log(Random.rand(rng))
                yy+yy > xx*xx &&
                    return (rabs >> 8) % Bool ? -Random.ziggurat_nor_r-xx : Random.ziggurat_nor_r+xx
            end
        elseif (gpu_fi()[idx] - gpu_fi()[idx+1])*Random.rand(rng) + gpu_fi()[idx+1] < exp(-0.5*x*x)
            return x # return from the triangular area
        else
            @goto retry
        end
    end
end

## randexp

@device_override @inline function Random.randexp(rng::AbstractRNG)
    @label retry
    ri = Random.rand(rng, Random.UInt52Raw())
    @inbounds begin
        ri &= 0x000fffffffffffff
        idx = ri & 0xFF
        x = ri*gpu_we()[idx+1]
        ri < gpu_ke()[idx+1] && return x # 98.9% of the time we return here 1st try
        # TODO: This code could be outlined once LLVM supports LDS access in recursively-called functions
        @inbounds if idx == 0
            return Random.ziggurat_exp_r - log(Random.rand(rng))
        elseif (gpu_fe()[idx] - gpu_fe()[idx+1])*Random.rand(rng) + gpu_fe()[idx+1] < exp(-x)
            return x # return from the triangular area
        else
            @goto retry
        end
    end
end
