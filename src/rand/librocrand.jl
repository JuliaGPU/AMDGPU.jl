struct uint4
    x::Cuint
    y::Cuint
    z::Cuint
    w::Cuint
end

struct rocrand_discrete_distribution_st
    size::Cuint
    offset::Cuint
    alias::Ptr{Cuint}
    probability::Ptr{Cdouble}
    cdf::Ptr{Cdouble}
end

const rocrand_discrete_distribution = Ptr{rocrand_discrete_distribution_st}

mutable struct rocrand_generator_base_type end

const rocrand_generator = Ptr{rocrand_generator_base_type}

@cenum rocrand_rng_type::UInt32 begin
    ROCRAND_RNG_PSEUDO_DEFAULT = 400
    ROCRAND_RNG_PSEUDO_XORWOW = 401
    ROCRAND_RNG_PSEUDO_MRG32K3A = 402
    ROCRAND_RNG_PSEUDO_MTGP32 = 403
    ROCRAND_RNG_PSEUDO_PHILOX4_32_10 = 404
    ROCRAND_RNG_PSEUDO_MRG31K3P = 405
    ROCRAND_RNG_PSEUDO_LFSR113 = 406
    ROCRAND_RNG_PSEUDO_MT19937 = 407
    ROCRAND_RNG_PSEUDO_THREEFRY2_32_20 = 408
    ROCRAND_RNG_PSEUDO_THREEFRY2_64_20 = 409
    ROCRAND_RNG_PSEUDO_THREEFRY4_32_20 = 410
    ROCRAND_RNG_PSEUDO_THREEFRY4_64_20 = 411
    ROCRAND_RNG_QUASI_DEFAULT = 500
    ROCRAND_RNG_QUASI_SOBOL32 = 501
    ROCRAND_RNG_QUASI_SCRAMBLED_SOBOL32 = 502
    ROCRAND_RNG_QUASI_SOBOL64 = 504
    ROCRAND_RNG_QUASI_SCRAMBLED_SOBOL64 = 505
end

@cenum rocrand_ordering::UInt32 begin
    ROCRAND_ORDERING_PSEUDO_BEST = 100
    ROCRAND_ORDERING_PSEUDO_DEFAULT = 101
    ROCRAND_ORDERING_PSEUDO_SEEDED = 102
    ROCRAND_ORDERING_PSEUDO_LEGACY = 103
    ROCRAND_ORDERING_PSEUDO_DYNAMIC = 104
    ROCRAND_ORDERING_QUASI_DEFAULT = 201
end

@cenum rocrand_direction_vector_set::UInt32 begin
    ROCRAND_DIRECTION_VECTORS_32_JOEKUO6 = 101
    ROCRAND_SCRAMBLED_DIRECTION_VECTORS_32_JOEKUO6 = 102
    ROCRAND_DIRECTION_VECTORS_64_JOEKUO6 = 103
    ROCRAND_SCRAMBLED_DIRECTION_VECTORS_64_JOEKUO6 = 104
end

function rocrand_create_generator(generator, rng_type)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_create_generator(generator::Ptr{rocrand_generator},
                                                      rng_type::rocrand_rng_type)::rocrand_status)
end

function rocrand_create_generator_host(generator, rng_type)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_create_generator_host(generator::Ptr{rocrand_generator},
                                                           rng_type::rocrand_rng_type)::rocrand_status)
end

function rocrand_create_generator_host_blocking(generator, rng_type)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_create_generator_host_blocking(generator::Ptr{rocrand_generator},
                                                                    rng_type::rocrand_rng_type)::rocrand_status)
end

function rocrand_destroy_generator(generator)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_destroy_generator(generator::rocrand_generator)::rocrand_status)
end

function rocrand_generate(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate(generator::rocrand_generator,
                                              output_data::Ptr{Cuint},
                                              n::Csize_t)::rocrand_status)
end

function rocrand_generate_long_long(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_long_long(generator::rocrand_generator,
                                                        output_data::Ptr{Culonglong},
                                                        n::Csize_t)::rocrand_status)
end

function rocrand_generate_char(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_char(generator::rocrand_generator,
                                                   output_data::Ptr{Cuchar},
                                                   n::Csize_t)::rocrand_status)
end

function rocrand_generate_short(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_short(generator::rocrand_generator,
                                                    output_data::Ptr{Cushort},
                                                    n::Csize_t)::rocrand_status)
end

function rocrand_generate_uniform(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_uniform(generator::rocrand_generator,
                                                      output_data::Ptr{Cfloat},
                                                      n::Csize_t)::rocrand_status)
end

function rocrand_generate_uniform_double(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_uniform_double(generator::rocrand_generator,
                                                             output_data::Ptr{Cdouble},
                                                             n::Csize_t)::rocrand_status)
end

function rocrand_generate_uniform_half(generator, output_data, n)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_uniform_half(generator::rocrand_generator,
                                                           output_data::Ptr{half},
                                                           n::Csize_t)::rocrand_status)
end

function rocrand_generate_normal(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_normal(generator::rocrand_generator,
                                                     output_data::Ptr{Cfloat}, n::Csize_t,
                                                     mean::Cfloat,
                                                     stddev::Cfloat)::rocrand_status)
end

function rocrand_generate_normal_double(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_normal_double(generator::rocrand_generator,
                                                            output_data::Ptr{Cdouble},
                                                            n::Csize_t, mean::Cdouble,
                                                            stddev::Cdouble)::rocrand_status)
end

function rocrand_generate_normal_half(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_normal_half(generator::rocrand_generator,
                                                          output_data::Ptr{half},
                                                          n::Csize_t, mean::half,
                                                          stddev::half)::rocrand_status)
end

function rocrand_generate_log_normal(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_log_normal(generator::rocrand_generator,
                                                         output_data::Ptr{Cfloat},
                                                         n::Csize_t, mean::Cfloat,
                                                         stddev::Cfloat)::rocrand_status)
end

function rocrand_generate_log_normal_double(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_log_normal_double(generator::rocrand_generator,
                                                                output_data::Ptr{Cdouble},
                                                                n::Csize_t, mean::Cdouble,
                                                                stddev::Cdouble)::rocrand_status)
end

function rocrand_generate_log_normal_half(generator, output_data, n, mean, stddev)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_log_normal_half(generator::rocrand_generator,
                                                              output_data::Ptr{half},
                                                              n::Csize_t, mean::half,
                                                              stddev::half)::rocrand_status)
end

function rocrand_generate_poisson(generator, output_data, n, lambda)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_generate_poisson(generator::rocrand_generator,
                                                      output_data::Ptr{Cuint}, n::Csize_t,
                                                      lambda::Cdouble)::rocrand_status)
end

function rocrand_initialize_generator(generator)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_initialize_generator(generator::rocrand_generator)::rocrand_status)
end

function rocrand_set_stream(generator, stream)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_stream(generator::rocrand_generator,
                                                stream::hipStream_t)::rocrand_status)
end

function rocrand_set_seed(generator, seed)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_seed(generator::rocrand_generator,
                                              seed::Culonglong)::rocrand_status)
end

function rocrand_set_seed_uint4(generator, seed)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_seed_uint4(generator::rocrand_generator,
                                                    seed::uint4)::rocrand_status)
end

function rocrand_set_offset(generator, offset)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_offset(generator::rocrand_generator,
                                                offset::Culonglong)::rocrand_status)
end

function rocrand_set_ordering(generator, order)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_ordering(generator::rocrand_generator,
                                                  order::rocrand_ordering)::rocrand_status)
end

function rocrand_set_quasi_random_generator_dimensions(generator, dimensions)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_set_quasi_random_generator_dimensions(generator::rocrand_generator,
                                                                           dimensions::Cuint)::rocrand_status)
end

function rocrand_get_version(version)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_get_version(version::Ptr{Cint})::rocrand_status)
end

function rocrand_create_poisson_distribution(lambda, discrete_distribution)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_create_poisson_distribution(lambda::Cdouble,
                                                                 discrete_distribution::Ptr{rocrand_discrete_distribution})::rocrand_status)
end

function rocrand_create_discrete_distribution(probabilities, size, offset,
                                              discrete_distribution)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_create_discrete_distribution(probabilities::Ptr{Cdouble},
                                                                  size::Cuint,
                                                                  offset::Cuint,
                                                                  discrete_distribution::Ptr{rocrand_discrete_distribution})::rocrand_status)
end

function rocrand_destroy_discrete_distribution(discrete_distribution)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_destroy_discrete_distribution(discrete_distribution::rocrand_discrete_distribution)::rocrand_status)
end

function rocrand_get_direction_vectors32(vectors, set)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_get_direction_vectors32(vectors::Ptr{Ptr{Cuint}},
                                                             set::rocrand_direction_vector_set)::rocrand_status)
end

function rocrand_get_direction_vectors64(vectors, set)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_get_direction_vectors64(vectors::Ptr{Ptr{Culonglong}},
                                                             set::rocrand_direction_vector_set)::rocrand_status)
end

function rocrand_get_scramble_constants32(constants)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_get_scramble_constants32(constants::Ptr{Ptr{Cuint}})::rocrand_status)
end

function rocrand_get_scramble_constants64(constants)
    AMDGPU.prepare_state()
    @check @ccall(librocrand.rocrand_get_scramble_constants64(constants::Ptr{Ptr{Culonglong}})::rocrand_status)
end

const ROCRAND_VERSION = 400200

# Skipping MacroDefinition: ROCRANDAPI __attribute__ ( ( visibility ( "default" ) ) )

const ROCRAND_DEFAULT_MAX_BLOCK_SIZE = 256
