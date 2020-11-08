# Julia wrapper for header: rocrand_version.h
# Automatically generated using Clang.jl

# Julia wrapper for header: rocrand_discrete_types.h
# Automatically generated using Clang.jl

# Julia wrapper for header: rocrand.h
# Automatically generated using Clang.jl


function rocrand_create_generator(generator, rng_type)
    @check ccall((:rocrand_create_generator, librocrand), rocrand_status,
                 (Ptr{rocrand_generator}, rocrand_rng_type),
                 generator, rng_type)
end

function rocrand_destroy_generator(generator)
    @check ccall((:rocrand_destroy_generator, librocrand), rocrand_status,
                 (rocrand_generator,),
                 generator)
end

function rocrand_generate(generator, output_data, n)
    @check ccall((:rocrand_generate, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{UInt32}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_char(generator, output_data, n)
    @check ccall((:rocrand_generate_char, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cuchar}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_short(generator, output_data, n)
    @check ccall((:rocrand_generate_short, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{UInt16}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_uniform(generator, output_data, n)
    @check ccall((:rocrand_generate_uniform, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cfloat}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_uniform_double(generator, output_data, n)
    @check ccall((:rocrand_generate_uniform_double, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cdouble}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_uniform_half(generator, output_data, n)
    @check ccall((:rocrand_generate_uniform_half, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{half}, Cint),
                 generator, output_data, n)
end

function rocrand_generate_normal(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_normal, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cfloat}, Cint, Cfloat, Cfloat),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_normal_double(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_normal_double, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cdouble}, Cint, Cdouble, Cdouble),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_normal_half(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_normal_half, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{half}, Cint, half, half),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_log_normal(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_log_normal, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cfloat}, Cint, Cfloat, Cfloat),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_log_normal_double(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_log_normal_double, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{Cdouble}, Cint, Cdouble, Cdouble),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_log_normal_half(generator, output_data, n, mean, stddev)
    @check ccall((:rocrand_generate_log_normal_half, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{half}, Cint, half, half),
                 generator, output_data, n, mean, stddev)
end

function rocrand_generate_poisson(generator, output_data, n, lambda)
    @check ccall((:rocrand_generate_poisson, librocrand), rocrand_status,
                 (rocrand_generator, Ptr{UInt32}, Cint, Cdouble),
                 generator, output_data, n, lambda)
end

function rocrand_initialize_generator(generator)
    @check ccall((:rocrand_initialize_generator, librocrand), rocrand_status,
                 (rocrand_generator,),
                 generator)
end

function rocrand_set_stream(generator, stream)
    @check ccall((:rocrand_set_stream, librocrand), rocrand_status,
                 (rocrand_generator, Cint),
                 generator, stream)
end

function rocrand_set_seed(generator, seed)
    @check ccall((:rocrand_set_seed, librocrand), rocrand_status,
                 (rocrand_generator, Culonglong),
                 generator, seed)
end

function rocrand_set_offset(generator, offset)
    @check ccall((:rocrand_set_offset, librocrand), rocrand_status,
                 (rocrand_generator, Culonglong),
                 generator, offset)
end

function rocrand_set_quasi_random_generator_dimensions(generator, dimensions)
    @check ccall((:rocrand_set_quasi_random_generator_dimensions, librocrand), rocrand_status,
                 (rocrand_generator, UInt32),
                 generator, dimensions)
end

function rocrand_get_version(version)
    @check ccall((:rocrand_get_version, librocrand), rocrand_status,
                 (Ptr{Cint},),
                 version)
end

function rocrand_create_poisson_distribution(lambda, discrete_distribution)
    @check ccall((:rocrand_create_poisson_distribution, librocrand), rocrand_status,
                 (Cdouble, Ptr{rocrand_discrete_distribution}),
                 lambda, discrete_distribution)
end

function rocrand_create_discrete_distribution(probabilities, size, offset,
                                              discrete_distribution)
    @check ccall((:rocrand_create_discrete_distribution, librocrand), rocrand_status,
                 (Ptr{Cdouble}, UInt32, UInt32, Ptr{rocrand_discrete_distribution}),
                 probabilities, size, offset, discrete_distribution)
end

function rocrand_destroy_discrete_distribution(discrete_distribution)
    @check ccall((:rocrand_destroy_discrete_distribution, librocrand), rocrand_status,
                 (rocrand_discrete_distribution,),
                 discrete_distribution)
end
