# WMMA (Wavefront Matrix Multiply-Accumulate) intrinsics for RDNA 3 (GFX11)

export WMMAFragment, WMMA_M, WMMA_N, WMMA_K
export wmma_load_a, wmma_load_b, wmma_load_c, wmma_store_d, wmma_mma

# WMMA tile dimensions (fixed for RDNA 3).
const WMMA_M, WMMA_N, WMMA_K = 16, 16, 16

const LLVMVec16F16 = NTuple{16, VecElement{Float16}}
const LLVMVec16BF16 = NTuple{16, VecElement{BFloat16}}
const LLVMVec16I16 = NTuple{16, VecElement{Int16}}
const LLVMVec8F32 = NTuple{8, VecElement{Float32}}

"""
    WMMAFragment{M, N, T, L}

A fragment of a matrix for WMMA operations.
- `M`, `N`: logical matrix dimensions this fragment represents a piece of
- `T`: element type
- `L`: number of elements stored per thread

For wave32 mode on RDNA 3:
- A fragment (16xK): 16 elements per thread (8 VGPRs for FP16)
- B fragment (Kx16): 16 elements per thread (8 VGPRs for FP16)
- C/D fragment (16x16): 8 elements per thread (8 VGPRs for FP32, or 8 VGPRs holding 16 FP16)
"""
struct WMMAFragment{M, N, T, L}
    data::NTuple{L, VecElement{T}}
end

const WMMAFragmentA{T} = WMMAFragment{WMMA_M, WMMA_K, T, 16}
const WMMAFragmentB{T} = WMMAFragment{WMMA_K, WMMA_N, T, 16}
const WMMAFragmentC_F32 = WMMAFragment{WMMA_M, WMMA_N, Float32, 8}
const WMMAFragmentC_F16 = WMMAFragment{WMMA_M, WMMA_N, Float16, 16}
const WMMAFragmentC_BF16 = WMMAFragment{WMMA_M, WMMA_N, BFloat16, 16}

wmma_fill_c(::Type{Float32}, x::Float32) = WMMAFragmentC_F32(ntuple(_ -> VecElement(x), Val(8)))
wmma_fill_c(::Type{Float16}, x::Float16) = WMMAFragmentC_F16(ntuple(_ -> VecElement(x), Val(16)))
wmma_fill_c(::Type{BFloat16}, x::BFloat16) = WMMAFragmentC_F16(ntuple(_ -> VecElement(x), Val(16)))

# Signature for BFloat16 is:
# @llvm.amdgcn.wmma.f32.16x16x16.bf16(<16 x i16>, <16 x i16> , <8 x float>)
# thus conversion.
_llvm_inttype(x) = x
_llvm_inttype(x::BFloat16) = reinterpret(Int16, x)
_llvm_inttype(::Type{Float16}) = Float16
_llvm_inttype(::Type{BFloat16}) = Int16

for (fname, intrinsic, ret_T, arg_T) in (
    (:_wmma_f32_16x16x16_f16, "llvm.amdgcn.wmma.f32.16x16x16.f16", LLVMVec8F32, LLVMVec16F16),
    (:_wmma_f32_16x16x16_bf16, "llvm.amdgcn.wmma.f32.16x16x16.bf16", LLVMVec8F32, LLVMVec16I16),
)
    @eval $fname(a::$arg_T, b::$arg_T, c::$ret_T) = ccall(
        $intrinsic, llvmcall, $ret_T,
        ($arg_T, $arg_T, $ret_T), a, b, c)
end

function wmma_load_a(ptr::LLVMPtr{T}, stride::Int32) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    data = ntuple(Val(16)) do col
        offset = (Int32(col - 1) * stride + row) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return WMMAFragmentA{_llvm_inttype(T)}(data)
end

function wmma_load_b(ptr::LLVMPtr{T}, stride::Int32) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    base = ptr + col * stride * Int32(sizeof(T))
    data = ntuple(Val(16)) do row
        VecElement(_llvm_inttype(unsafe_load(base + Int32(row - 1) * Int32(sizeof(T)))))
    end
    return WMMAFragmentB{_llvm_inttype(T)}(data)
end

function wmma_load_c(ptr::LLVMPtr{Float32}, stride::Int32)::WMMAFragmentC_F32
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(2 * (k - 1)) + half
        offset = (col * stride + row) * Int32(sizeof(Float32))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return WMMAFragmentC_F32(data)
end

function wmma_store_d(ptr::LLVMPtr{Float32}, frag::WMMAFragmentC_F32, stride::Int32)
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    for k in 1:8
        row = Int32(2 * (k - 1)) + half
        offset = (col * stride + row) * Int32(sizeof(Float32))
        unsafe_store!(ptr + offset, frag.data[k].value)
    end
    return
end

for (fname, arg_T) in ((_wmma_f32_16x16x16_f16, Float16), (_wmma_f32_16x16x16_bf16, Int16))
    @eval wmma_mma(a::WMMAFragmentA{$arg_T}, b::WMMAFragmentB{$arg_T}, c::WMMAFragmentC_F32) =
        WMMAFragmentC_F32($fname(a.data, b.data, c.data))
end
