# WMMA (Wavefront Matrix Multiply-Accumulate) intrinsics for RDNA 3 (GFX11)

export WMMAFragment
export wmma_load_a, wmma_load_b, wmma_load_c, wmma_store_d, wmma_mma
export WMMA_M, WMMA_N, WMMA_K

# WMMA tile dimensions (fixed for RDNA 3).
const WMMA_M = 16
const WMMA_N = 16
const WMMA_K = 16

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
    data::NTuple{L, T}
end

# Convenience type aliases
const WMMAFragmentA{T} = WMMAFragment{WMMA_M, WMMA_K, T, 16}
const WMMAFragmentB{T} = WMMAFragment{WMMA_K, WMMA_N, T, 16}
const WMMAFragmentC_F32 = WMMAFragment{WMMA_M, WMMA_N, Float32, 8}
const WMMAFragmentC_F16 = WMMAFragment{WMMA_M, WMMA_N, Float16, 16}

WMMAFragment{M, N, T, L}() where {M, N, T, L} =
    WMMAFragment{M, N, T, L}(ntuple(_ -> zero(T), Val(L)))

wmma_fill_c(::Type{Float32}, val::Float32) = WMMAFragmentC_F32(ntuple(_ -> val, Val(8)))
wmma_fill_c(::Type{Float16}, val::Float16) = WMMAFragmentC_F16(ntuple(_ -> val, Val(16)))

# ============================================================================
# LLVM intrinsic wrappers for WMMA
# ============================================================================

# The LLVM intrinsics for RDNA 3 WMMA operations (wave32):
#   llvm.amdgcn.wmma.f32.16x16x16.f16(<16 x half> A, <16 x half> B, <8 x float> C) -> <8 x float>
#   llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half> A, <16 x half> B, <16 x half> C, i1 opsel) -> <16 x half>

# LLVM vector types: NTuple{N, VecElement{T}} maps to <N x T>
const LLVMVec16F16 = NTuple{16, VecElement{Float16}}
const LLVMVec8F32 = NTuple{8, VecElement{Float32}}
const LLVMVec16F32 = NTuple{16, VecElement{Float32}}

# Conversion helpers between NTuple{N,T} and NTuple{N,VecElement{T}}
@inline _to_vec(t::NTuple{N, T}) where {N, T} = ntuple(i -> VecElement(t[i]), Val(N))
@inline _from_vec(t::NTuple{N, VecElement{T}}) where {N, T} = ntuple(i -> t[i].value, Val(N))

# Internal wrapper for FP16→FP32 WMMA (wave32)
@inline function _wmma_f32_16x16x16_f16(
    a::NTuple{16, Float16}, b::NTuple{16, Float16}, c::NTuple{8, Float32}
)
    a_vec = _to_vec(a)
    b_vec = _to_vec(b)
    c_vec = _to_vec(c)
    result = ccall(
        "llvm.amdgcn.wmma.f32.16x16x16.f16", llvmcall, LLVMVec8F32,
        (LLVMVec16F16, LLVMVec16F16, LLVMVec8F32),
        a_vec, b_vec, c_vec)
    return _from_vec(result)
end

# Internal wrapper for FP16→FP16 WMMA (wave32)
# opsel=false means result stored in low 16 bits of each VGPR
@inline function _wmma_f16_16x16x16_f16(
    a::NTuple{16, Float16}, b::NTuple{16, Float16}, c::NTuple{16, Float16},
    opsel::Bool = false
)
    a_vec = _to_vec(a)
    b_vec = _to_vec(b)
    c_vec = _to_vec(c)
    result = ccall(
        "llvm.amdgcn.wmma.f16.16x16x16.f16", llvmcall, LLVMVec16F16,
        (LLVMVec16F16, LLVMVec16F16, LLVMVec16F16, Bool),
        a_vec, b_vec, c_vec, opsel)
    return _from_vec(result)
end

@device_function function wmma_load_a(ptr::LLVMPtr{Float16}, stride::Int32)::WMMAFragmentA{Float16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    data = ntuple(Val(16)) do col
        offset = (Int32(col - 1) * stride + row) * Int32(sizeof(Float16))
        unsafe_load(ptr + offset)
    end
    return WMMAFragmentA{Float16}(data)
end

@device_function function wmma_load_b(ptr::LLVMPtr{Float16}, stride::Int32)::WMMAFragmentB{Float16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    base = ptr + col * stride * Int32(sizeof(Float16))
    data = ntuple(Val(16)) do row
        unsafe_load(base + Int32(row - 1) * Int32(sizeof(Float16)))
    end
    return WMMAFragmentB{Float16}(data)
end

@device_function function wmma_load_c(ptr::LLVMPtr{Float32}, stride::Int32)::WMMAFragmentC_F32
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(2 * (k - 1)) + half
        offset = (col * stride + row) * Int32(sizeof(Float32))
        unsafe_load(ptr + offset)
    end
    return WMMAFragmentC_F32(data)
end

@device_function function wmma_store_d(ptr::LLVMPtr{Float32}, frag::WMMAFragmentC_F32, stride::Int32)
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    for k in 1:8
        row = Int32(2 * (k - 1)) + half
        offset = (col * stride + row) * Int32(sizeof(Float32))
        unsafe_store!(ptr + offset, frag.data[k])
    end
    return
end

@device_function function wmma_mma(
    a::WMMAFragmentA{Float16}, b::WMMAFragmentB{Float16}, c::WMMAFragmentC_F32,
)::WMMAFragmentC_F32
    return WMMAFragmentC_F32(_wmma_f32_16x16x16_f16(a.data, b.data, c.data))
end

@device_function function wmma_mma(
    a::WMMAFragmentA{Float16}, b::WMMAFragmentB{Float16}, c::WMMAFragmentC_F16
)::WMMAFragmentC_F16
    return WMMAFragmentC_F16(_wmma_f16_16x16x16_f16(a.data, b.data, c.data, false))
end
