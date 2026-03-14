# WMMA (Wavefront Matrix Multiply-Accumulate) intrinsics for RDNA 3 (GFX11)
# https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/AMDGPU/llvm.amdgcn.wmma_32.ll

export WMMA

module WMMA

export Fragment, M, N, K
export ColMajor, RowMajor
export load_a, load_b, load_c, store_d, mma, fill_c

import Core: LLVMPtr, VecElement
import ...BFloat16s: BFloat16
import ..activelane

# WMMA tile dimensions (fixed for RDNA 3).
const M, N, K = 16, 16, 16

const LLVMVec16F16 = NTuple{16, VecElement{Float16}}
const LLVMVec16BF16 = NTuple{16, VecElement{BFloat16}}
const LLVMVec16I16 = NTuple{16, VecElement{Int16}}
const LLVMVec8F32 = NTuple{8, VecElement{Float32}}

"""
    Fragment{M, N, T, L}

A fragment of a matrix for WMMA operations.
- `M`, `N`: logical matrix dimensions this fragment represents a piece of
- `T`: element type
- `L`: number of elements stored per thread

For wave32 mode on RDNA 3:
- A fragment (16xK): 16 elements per thread (8 VGPRs for FP16)
- B fragment (Kx16): 16 elements per thread (8 VGPRs for FP16)
- C/D fragment (16x16): 8 elements per thread (8 VGPRs for FP32, or 8 VGPRs holding 16 FP16)
"""
struct Fragment{M, N, T, L}
    data::NTuple{L, VecElement{T}}
end

const FragmentA{T} = Fragment{M, K, T, 16}
const FragmentB{T} = Fragment{K, N, T, 16}
const FragmentC_F32 = Fragment{M, N, Float32, 8}
const FragmentC_F16 = Fragment{M, N, Float16, 16}
const FragmentC_BF16 = Fragment{M, N, BFloat16, 16}

"""
    ColMajor

Layout type representing a matrix stored in column-major (Julia/Fortran) order,
where `ptr[col * stride + row]` addresses element `(row, col)`.
"""
struct ColMajor end

"""
    RowMajor

Layout type representing a matrix stored in row-major (C) order,
where `ptr[row * stride + col]` addresses element `(row, col)`.
"""
struct RowMajor end

"""
    fill_c(::Type{Float32}, x::Float32)

Create and return fragment for `C` filled with given value `x`.
"""
fill_c(::Type{Float32}, x::Float32) = FragmentC_F32(ntuple(_ -> VecElement(x), Val(8)))

# Signature for BFloat16 is:
# @llvm.amdgcn.wmma.f32.16x16x16.bf16(<16 x i16>, <16 x i16> , <8 x float>)
# thus conversion.
_llvm_inttype(x) = x
_llvm_inttype(x::BFloat16) = reinterpret(Int16, x)
_llvm_inttype(::Type{Float16}) = Float16
_llvm_inttype(::Type{BFloat16}) = Int16

for (fname, intrinsic, ret_T, arg_T) in (
    (:_f32_16x16x16_f16, "llvm.amdgcn.wmma.f32.16x16x16.f16", LLVMVec8F32, LLVMVec16F16),
    (:_f32_16x16x16_bf16, "llvm.amdgcn.wmma.f32.16x16x16.bf16", LLVMVec8F32, LLVMVec16I16),
)
    @eval $fname(a::$arg_T, b::$arg_T, c::$ret_T) = ccall(
        $intrinsic, llvmcall, $ret_T,
        ($arg_T, $arg_T, $ret_T), a, b, c)
end

"""
    load_a(ptr::LLVMPtr{T}, stride::Int32, layout=ColMajor()) where T

Load matrix `A` (M×K) from memory and return the resulting fragment.
`stride` is the leading dimension in number of elements.

- `ColMajor()`: column-major storage, `ptr[col * stride + row]`
- `RowMajor()`: row-major storage, `ptr[row * stride + col]`
"""
function load_a(ptr::LLVMPtr{T}, stride::Int32, ::ColMajor=ColMajor()) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    data = ntuple(Val(16)) do col
        offset = (Int32(col - 1) * stride + row) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return FragmentA{_llvm_inttype(T)}(data)
end

function load_a(ptr::LLVMPtr{T}, stride::Int32, ::RowMajor) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    data = ntuple(Val(16)) do col
        offset = (row * stride + Int32(col - 1)) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return FragmentA{_llvm_inttype(T)}(data)
end

"""
    load_b(ptr::LLVMPtr{T}, stride::Int32, layout=ColMajor()) where T

Load matrix `B` (K×N) from memory and return the resulting fragment.
`stride` is the leading dimension in number of elements.

- `ColMajor()`: column-major storage, `ptr[col * stride + row]`
- `RowMajor()`: row-major storage, `ptr[row * stride + col]`
"""
function load_b(ptr::LLVMPtr{T}, stride::Int32, ::ColMajor=ColMajor()) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    base = ptr + col * stride * Int32(sizeof(T))
    data = ntuple(Val(16)) do row
        VecElement(_llvm_inttype(unsafe_load(base + Int32(row - 1) * Int32(sizeof(T)))))
    end
    return FragmentB{_llvm_inttype(T)}(data)
end

function load_b(ptr::LLVMPtr{T}, stride::Int32, ::RowMajor) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    data = ntuple(Val(16)) do row
        offset = (Int32(row - 1) * stride + col) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return FragmentB{_llvm_inttype(T)}(data)
end

"""
    load_c(ptr::LLVMPtr{Float32}, stride::Int32, layout=ColMajor())

Load matrix `C` (M×N) from memory and return the resulting fragment.
`stride` is the leading dimension in number of elements.

- `ColMajor()`: column-major storage, `ptr[col * stride + row]`
- `RowMajor()`: row-major storage, `ptr[row * stride + col]`
"""
function load_c(ptr::LLVMPtr{Float32}, stride::Int32, ::ColMajor=ColMajor())::FragmentC_F32
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(2 * (k - 1)) + half
        offset = (col * stride + row) * Int32(sizeof(Float32))
        VecElement(unsafe_load(ptr + offset))
    end
    return FragmentC_F32(data)
end

function load_c(ptr::LLVMPtr{Float32}, stride::Int32, ::RowMajor)::FragmentC_F32
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(2 * (k - 1)) + half
        offset = (row * stride + col) * Int32(sizeof(Float32))
        VecElement(unsafe_load(ptr + offset))
    end
    return FragmentC_F32(data)
end

"""
    store_d(ptr::LLVMPtr{Float32}, frag::FragmentC_F32, stride::Int32, layout=ColMajor())

Store the result matrix `D` to the memory location given by `ptr`.

# Arguments

- `ptr`: Address to store the matrix to.
- `frag`: Corresponding fragment.
- `stride`: Leading dimension of the matrix for `ptr` in number of elements.
- `layout`: `ColMajor()` (default) or `RowMajor()`.
"""
function store_d(ptr::LLVMPtr{Float32}, frag::FragmentC_F32, stride::Int32, ::ColMajor=ColMajor())
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

function store_d(ptr::LLVMPtr{Float32}, frag::FragmentC_F32, stride::Int32, ::RowMajor)
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    for k in 1:8
        row = Int32(2 * (k - 1)) + half
        offset = (row * stride + col) * Int32(sizeof(Float32))
        unsafe_store!(ptr + offset, frag.data[k].value)
    end
    return
end

"""
    mma(
        a::FragmentA{T}, b::FragmentB{T}, c::FragmentC_F32,
    ) where T <: Union{Float16, BFloat16}

Perform matrix multiply-accumulate operation `D = A ⋅ B + C` with loaded fragments.
`A` and `B` can be either in `Float16` or in `BFloat16`.
"""
mma

for (fname, arg_T) in ((_f32_16x16x16_f16, Float16), (_f32_16x16x16_bf16, Int16))
    @eval mma(a::FragmentA{$arg_T}, b::FragmentB{$arg_T}, c::FragmentC_F32) =
        FragmentC_F32($fname(a.data, b.data, c.data))
end

end # module WMMA
