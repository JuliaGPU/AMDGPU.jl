# WMMA (Wavefront Matrix Multiply-Accumulate) intrinsics for RDNA 4 (GFX12 / gfx1201)
#
# Based on:
# - AMD GPUOpen: https://gpuopen.com/learn/using_matrix_core_amd_rdna4/
# - LLVM: https://github.com/llvm/llvm-project/commit/829afc4c91fcac3823cdf06baf683fe3356a9e91
# - LLVM intrinsics: llvm.amdgcn.wmma.* with _gfx12 suffix
# - RDNA3 implementation of WMMA

"""
WMMA module for AMD RDNA4 architecture GPUs.

RDNA4 (gfx1200+) introduces a simplified VGPR layout for WMMA operations compared to RDNA3:
- Each lane in a wavefront handles 8 elements (vs 16 with duplication in RDNA3)
- No data duplication for A and B matrices (128-bit vs 256-bit)
- New intrinsic names with `_gfx12` suffix and explicit vector type annotations
- Support for FP8, BF8 types

Tile dimensions: M = N = K = 16 (same as RDNA3)
"""

export WMMA_RDNA4

module WMMA_RDNA4

# Exported types and functions
export Fragment, M, N, K
export ColMajor, RowMajor
export load_a, load_b, load_c, store_d, mma, fill_c

# Imports
import Core: LLVMPtr, VecElement
import ...BFloat16s: BFloat16
import ..activelane

# WMMA tile dimensions (fixed for RDNA 4, same as RDNA 3).
const M, N, K = 16, 16, 16

# Vector types for Wave32 mode on RDNA4.
# Each thread handles 8 elements for A and B fragments (vs 16 in RDNA3 with duplication)
const LLVMVec8F16 = NTuple{8, VecElement{Float16}}
const LLVMVec8BF16 = NTuple{8, VecElement{BFloat16}}
const LLVMVec8I16 = NTuple{8, VecElement{Int16}}
const LLVMVec8F32 = NTuple{8, VecElement{Float32}}
const LLVMVec2I32 = NTuple{2, VecElement{Int32}}

"""
    Fragment{M, N, T, L}

A fragment of a matrix for WMMA operations.
- `M`, `N`: logical matrix dimensions this fragment represents a piece of
- `T`: element type
- `L`: number of elements stored per thread

For wave32 mode on RDNA 4:
- A fragment (16xK): 8 elements per thread (4 VGPRs for FP16/BF16)
- B fragment (Kx16): 8 elements per thread (4 VGPRs for FP16/BF16)
- C/D fragment (16x16): 8 elements per thread (4 VGPRs for FP32)

This is simpler than RDNA3 where A and B fragments had 16 elements per thread
with data duplication.
"""
struct Fragment{M, N, T, L}
    data::NTuple{L, VecElement{T}}
end

# Fragment type aliases
const FragmentA{T} = Fragment{M, K, T, 8}
const FragmentB{T} = Fragment{K, N, T, 8}
const FragmentC_F32 = Fragment{M, N, Float32, 8}
const FragmentC_F16 = Fragment{M, N, Float16, 8}
const FragmentC_BF16 = Fragment{M, N, BFloat16, 8}

"""
    ColMajor

Layout type representing a matrix stored in column-major (Julia/Fortran) order,
where element `(row, col)` is at `ptr[col * stride + row]`.
"""
struct ColMajor end

"""
    RowMajor

Layout type representing a matrix stored in row-major (C) order,
where element `(row, col)` is at `ptr[row * stride + col]`.
"""
struct RowMajor end

"""
    fill_c(::Type{Float32}, x::Float32)

Create and return fragment for `C` filled with given value `x`.
"""
fill_c(::Type{Float32}, x::Float32) = FragmentC_F32(ntuple(_ -> VecElement(x), Val(8)))

# =============================================================================
# Broadcasting over Fragments
# =============================================================================

# Based on CUDA.jl's implementation:
# https://github.com/JuliaGPU/CUDA.jl/blob/main/src/device/intrinsics/wmma.jl

struct FragmentBroadcastStyle <: Base.Broadcast.BroadcastStyle end

Base.BroadcastStyle(::Type{<:Fragment}) = FragmentBroadcastStyle()
Base.BroadcastStyle(::FragmentBroadcastStyle, ::Base.Broadcast.DefaultArrayStyle{0}) = FragmentBroadcastStyle()

Base.broadcastable(frag::Fragment) = frag
Base.axes(frag::Fragment) = axes(frag.data)

@inline _bc_get(x, i) = x
@inline _bc_get(frag::Fragment, i) = frag.data[i].value

@inline _bc_find(args::Tuple) = _bc_find(args[1], Base.tail(args))
@inline _bc_find(frag::Fragment, rest) = frag
@inline _bc_find(::Any, rest) = _bc_find(rest)

_eltype(::Fragment{M, N, T, L}) where {M, N, T, L} = T

@inline function Base.copy(bc::Base.Broadcast.Broadcasted{FragmentBroadcastStyle})
    dim = Base.Broadcast.combine_axes(bc.args...)
    length(dim) == 1 ||
        throw(DimensionMismatch("Fragment broadcast supports only one dimension"))
    N = length(dim[1])
    frag = _bc_find(bc.args)
    ET = _eltype(frag)
    data = ntuple(i -> VecElement(ET(bc.f(map(arg -> _bc_get(arg, i), bc.args)...))), Val(N))
    return typeof(frag)(data)
end

# =============================================================================
# Type Conversion for LLVM Intrinsics
# =============================================================================

# RDNA4 WMMA intrinsics expect specific types:
# - f16: Float16 as VecElement
# - bf16: Int16 (reinterpreted from BFloat16) as VecElement
# - f32: Float32 as VecElement

"""
    _llvm_inttype(x)

Convert Julia types to the types expected by LLVM WMMA intrinsics.
For BFloat16, we need to reinterpret as Int16.
"""
_llvm_inttype(x) = x
_llvm_inttype(x::BFloat16) = reinterpret(Int16, x)
_llvm_inttype(::Type{Float16}) = Float16
_llvm_inttype(::Type{BFloat16}) = Int16

# =============================================================================
# LLVM WMMA Intrinsics for RDNA4
# =============================================================================

# RDNA4 uses new intrinsic names with explicit vector type annotations.
# The pattern is: llvm.amdgcn.wmma.<result_type>.<M>x<N>x<K>.<input_type>.v<result_vec>v<input_vec>
#
# For wave32:
# - f32 output: v8f32 (8 x Float32)
# - f16 input: v8f16 (8 x Float16)
# - bf16 input: v8i16 (8 x Int16, reinterpreted from BFloat16)
#
# For wave64:
# - f32 output: v4f32 (4 x Float32)
# - f16 input: v4f16 (4 x Float16)
# - bf16 input: v4i16 (4 x Int16)

"""
    mma(a::FragmentA{T}, b::FragmentB{T}, c::FragmentC_F32) where T

Perform matrix multiply-accumulate operation `D = A \\cdot B + C` with loaded fragments.
`A` and `B` can be either in `Float16` or in `BFloat16`.
"""
mma

# Define the low-level LLVM intrinsic wrappers
for (fname, intrinsic, ret_T, arg_T) in (
    # Float16: f32 = f16 * f16 + f32
    (:_f32_16x16x16_f16, "llvm.amdgcn.wmma.f32.16x16x16.f16.v8f32.v8f16", LLVMVec8F32, LLVMVec8F16),
    # BFloat16: f32 = bf16 * bf16 + f32
    (:_f32_16x16x16_bf16, "llvm.amdgcn.wmma.f32.16x16x16.bf16.v8f32.v8i16", LLVMVec8F32, LLVMVec8I16),
)
    @eval $fname(a::$arg_T, b::$arg_T, c::$ret_T) = ccall(
        $intrinsic, llvmcall, $ret_T,
        ($arg_T, $arg_T, $ret_T), a, b, c)
end

# Implement mma for each type
@eval mma(a::FragmentA{Float16}, b::FragmentB{Float16}, c::FragmentC_F32) =
    FragmentC_F32(_f32_16x16x16_f16(a.data, b.data, c.data))

@eval mma(a::FragmentA{Int16}, b::FragmentB{Int16}, c::FragmentC_F32) =
    FragmentC_F32(_f32_16x16x16_bf16(a.data, b.data, c.data))

# =============================================================================
# Load Functions
# =============================================================================

"""
    load_a(ptr::LLVMPtr{T}, stride::Int32, layout) where T

Load matrix `A` (M×K) from memory and return the resulting fragment.
`stride` is the leading dimension in number of elements.

For RDNA4, each lane loads 8 elements of the matrix (vs 16 in RDNA3 with duplication).
The distribution is:
- lane 0-15: rows 0-15, columns 0-7 (half 0) and 8-15 (half 1)
- lane 16-31: rows 0-15, columns 16-23 and 24-31

This results in a clean distribution with no data duplication.

- `ColMajor`: column-major storage, `ptr[col * stride + row]`
- `RowMajor`: row-major storage, `ptr[row * stride + col]`
"""
function load_a(ptr::LLVMPtr{T}, stride::Int32, ::Type{ColMajor}) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        col = Int32(k - 1) + (half * 8)
        offset = (col * stride + row) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return FragmentA{_llvm_inttype(T)}(data)
end

function load_a(ptr::LLVMPtr{T}, stride::Int32, ::Type{RowMajor}) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    row = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        col = Int32(k - 1) + (half * 8)
        offset = (row * stride + col) * Int32(sizeof(T))
        VecElement(_llvm_inttype(unsafe_load(ptr + offset)))
    end
    return FragmentA{_llvm_inttype(T)}(data)
end

"""
    load_b(ptr::LLVMPtr{T}, stride::Int32, layout) where T

Load matrix `B` (K×N) from memory and return the resulting fragment.
`stride` is the leading dimension in number of elements.

- `ColMajor`: column-major storage, `ptr[col * stride + row]`
- `RowMajor`: row-major storage, `ptr[row * stride + col]`
"""
function load_b(ptr::LLVMPtr{T}, stride::Int32, ::Type{ColMajor}) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    base = ptr + col * stride * Int32(sizeof(T))
    data = ntuple(Val(8)) do k
        row = Int32(k - 1) + (half * 8)
        VecElement(_llvm_inttype(unsafe_load(base + row * Int32(sizeof(T)))))
    end
    return FragmentB{_llvm_inttype(T)}(data)
end

function load_b(ptr::LLVMPtr{T}, stride::Int32, ::Type{RowMajor}) where T <: Union{Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    base = ptr + col * Int32(sizeof(T))
    data = ntuple(Val(8)) do k
        row = Int32(k - 1) + (half * 8)
        VecElement(_llvm_inttype(unsafe_load(base + row * stride * Int32(sizeof(T)))))
    end
    return FragmentB{_llvm_inttype(T)}(data)
end

"""
    load_c(ptr::LLVMPtr{T}, stride::Int32, layout) where T

Load matrix `C` (M×N) from memory and return a `FragmentC_F32`.
`stride` is the leading dimension in number of elements.
`T` may be `Float32`, `Float16`, or `BFloat16`; non-Float32 values are
widened to `Float32` on load.

- `ColMajor`: column-major storage, `ptr[col * stride + row]`
- `RowMajor`: row-major storage, `ptr[row * stride + col]`
"""
function load_c(ptr::LLVMPtr{T}, stride::Int32, ::Type{ColMajor})::FragmentC_F32 where T <: Union{Float32, Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(k - 1) + (half * 8)
        offset = (col * stride + row) * Int32(sizeof(T))
        VecElement(Float32(unsafe_load(ptr + offset)))
    end
    return FragmentC_F32(data)
end

function load_c(ptr::LLVMPtr{T}, stride::Int32, ::Type{RowMajor})::FragmentC_F32 where T <: Union{Float32, Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    data = ntuple(Val(8)) do k
        row = Int32(k - 1) + (half * 8)
        offset = (row * stride + col) * Int32(sizeof(T))
        VecElement(Float32(unsafe_load(ptr + offset)))
    end
    return FragmentC_F32(data)
end

# =============================================================================
# Store Functions
# =============================================================================

"""
    store_d(ptr::LLVMPtr{T}, frag::FragmentC_F32, stride::Int32, layout) where T

Store the result matrix `D` to the memory location given by `ptr`.
`T` may be `Float32`, `Float16`, or `BFloat16`; fragment values are
narrowed from `Float32` on store.

# Arguments
- `ptr`: Address to store the matrix to.
- `frag`: Corresponding fragment.
- `stride`: Leading dimension of the matrix for `ptr` in number of elements.
- `layout`: `ColMajor` (default) or `RowMajor`.
"""
function store_d(ptr::LLVMPtr{T}, frag::FragmentC_F32, stride::Int32, ::Type{ColMajor}) where T <: Union{Float32, Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    for k in 1:8
        row = Int32(k - 1) + (half * 8)
        offset = (col * stride + row) * Int32(sizeof(T))
        unsafe_store!(ptr + offset, T(frag.data[k].value))
    end
    return
end

function store_d(ptr::LLVMPtr{T}, frag::FragmentC_F32, stride::Int32, ::Type{RowMajor}) where T <: Union{Float32, Float16, BFloat16}
    lane = unsafe_trunc(Int32, activelane())
    col = lane & Int32(15)
    half = lane >> 4
    for k in 1:8
        row = Int32(k - 1) + (half * 8)
        offset = (row * stride + col) * Int32(sizeof(T))
        unsafe_store!(ptr + offset, T(frag.data[k].value))
    end
    return
end

end # module WMMA_RDNA4
