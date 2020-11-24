# Automatically generated using Clang.jl


const ROCRAND_VERSION = 201005

struct rocrand_discrete_distribution_st
    size::UInt32
    offset::UInt32
    alias::Ptr{UInt32}
    probability::Ptr{Cdouble}
    cdf::Ptr{Cdouble}
end

const rocrand_discrete_distribution = Ptr{rocrand_discrete_distribution_st}
const ROCRAND_DEFAULT_MAX_BLOCK_SIZE = 256
const ROCRAND_DEFAULT_MIN_WARPS_PER_EU = 1
const rocrand_generator_base_type = Cvoid
const rocrand_generator = Ptr{rocrand_generator_base_type}
const half = Float16

@cenum rocrand_status::UInt32 begin
    ROCRAND_STATUS_SUCCESS = 0
    ROCRAND_STATUS_VERSION_MISMATCH = 100
    ROCRAND_STATUS_NOT_CREATED = 101
    ROCRAND_STATUS_ALLOCATION_FAILED = 102
    ROCRAND_STATUS_TYPE_ERROR = 103
    ROCRAND_STATUS_OUT_OF_RANGE = 104
    ROCRAND_STATUS_LENGTH_NOT_MULTIPLE = 105
    ROCRAND_STATUS_DOUBLE_PRECISION_REQUIRED = 106
    ROCRAND_STATUS_LAUNCH_FAILURE = 107
    ROCRAND_STATUS_INTERNAL_ERROR = 108
end

@cenum rocrand_rng_type::UInt32 begin
    ROCRAND_RNG_PSEUDO_DEFAULT = 400
    ROCRAND_RNG_PSEUDO_XORWOW = 401
    ROCRAND_RNG_PSEUDO_MRG32K3A = 402
    ROCRAND_RNG_PSEUDO_MTGP32 = 403
    ROCRAND_RNG_PSEUDO_PHILOX4_32_10 = 404
    ROCRAND_RNG_QUASI_DEFAULT = 500
    ROCRAND_RNG_QUASI_SOBOL32 = 501
end

