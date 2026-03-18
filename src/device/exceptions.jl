# Exception reason codes — encoded in bits [7:0] of the packed exception UInt64
# 0 means no exception
module ExceptionCode
    const NONE          = UInt8(0)
    const UNKNOWN       = UInt8(1)
    const BOUNDS_ERROR  = UInt8(2)
    const DOMAIN_ERROR  = UInt8(3)
    const OVERFLOW_ERROR = UInt8(4)
    const INEXACT_ERROR = UInt8(5)
    const ARGUMENT_ERROR = UInt8(6)
    const DIVIDE_ERROR  = UInt8(7)
    const DIM_MISMATCH  = UInt8(8)
end

const EXCEPTION_REASON_STRINGS = Dict{UInt8, String}(
    ExceptionCode.NONE          => "No exception",
    ExceptionCode.UNKNOWN       => "Unknown exception",
    ExceptionCode.BOUNDS_ERROR  => "BoundsError: Out-of-bounds array access",
    ExceptionCode.DOMAIN_ERROR  => "DomainError",
    ExceptionCode.OVERFLOW_ERROR => "OverflowError",
    ExceptionCode.INEXACT_ERROR => "InexactError: Inexact conversion",
    ExceptionCode.ARGUMENT_ERROR => "ArgumentError",
    ExceptionCode.DIVIDE_ERROR  => "DivideError: Integer division error",
    ExceptionCode.DIM_MISMATCH  => "DimensionMismatch",
)

# Packed exception format (UInt64):
#   [63:48] workgroup_x (16 bits)
#   [47:32] workgroup_y (16 bits)
#   [31:16] workgroup_z (16 bits)
#   [15:8]  reserved
#   [7:0]   error code (non-zero = exception occurred)

@inline function pack_exception(code::UInt8)
    wg = workgroupIdx()
    wg_x = UInt64(wg.x % UInt16) << 48
    wg_y = UInt64(wg.y % UInt16) << 32
    wg_z = UInt64(wg.z % UInt16) << 16
    return wg_x | wg_y | wg_z | UInt64(code)
end

@inline function unpack_exception(packed::UInt64)
    wg_x = UInt16((packed >> 48) & 0xFFFF)
    wg_y = UInt16((packed >> 32) & 0xFFFF)
    wg_z = UInt16((packed >> 16) & 0xFFFF)
    code  = UInt8(packed & 0xFF)
    return (; wg_x, wg_y, wg_z, code)
end

# Legacy compat — ExceptionInfo is now just a UInt64
const ExceptionInfo = UInt64

function alloc_exception_info()
    ei_ptr = Mem.HostBuffer(sizeof(UInt64), HIP.hipHostAllocDefault)
    unsafe_store!(convert(Ptr{UInt64}, ei_ptr), UInt64(0))
    return ei_ptr
end

@inline function signal_exception!(ei::Ptr{UInt64}, code::UInt8)
    packed = pack_exception(code)
    # First writer wins via atomic CAS; losers are no-ops.
    ei_llvm = reinterpret(LLVMPtr{UInt64, AS.Generic}, ei)
    llvm_atomic_cas(ei_llvm, UInt64(0), packed)
    endpgm()
    return
end

macro gpu_throw(reason)
    code = _reason_to_code(reason)
    quote
        ei = kernel_state().exception_info
        signal_exception!(ei, $code)
        throw(nothing) # unreachable, but keeps Julia's type system happy
    end
end

# Map reason strings to error codes at macro expansion time
function _reason_to_code(reason::String)
    if startswith(reason, "BoundsError")
        ExceptionCode.BOUNDS_ERROR
    elseif startswith(reason, "DomainError")
        ExceptionCode.DOMAIN_ERROR
    elseif startswith(reason, "OverflowError")
        ExceptionCode.OVERFLOW_ERROR
    elseif startswith(reason, "InexactError")
        ExceptionCode.INEXACT_ERROR
    elseif startswith(reason, "ArgumentError")
        ExceptionCode.ARGUMENT_ERROR
    elseif startswith(reason, "DivideError")
        ExceptionCode.DIVIDE_ERROR
    elseif startswith(reason, "DimensionMismatch")
        ExceptionCode.DIM_MISMATCH
    else
        ExceptionCode.UNKNOWN
    end
end
_reason_to_code(reason) = ExceptionCode.UNKNOWN
