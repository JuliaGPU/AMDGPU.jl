# Execution control
# copied from CUDAdrv/src/execution.jl

export ROCDim, ROCModule, ROCFunction, roccall

mutable struct ROCModule
    #data::String
    data::Vector{UInt8}
    options::Dict{Any,Any}
end
mutable struct ROCFunction
    mod::ROCModule
    entry::String
end

"""
    ROCDim3(x)

    ROCDim3((x,))
    ROCDim3((x, y))
    ROCDim3((x, y, x))

A type used to specify dimensions, consisting of 3 integers for respectively
the `x`, `y` and `z` dimension. Unspecified dimensions default to `1`.

Often accepted as argument through the `ROCDim` type alias, eg. in the case of
[`roccall`](@ref) or [`launch`](@ref), allowing to pass dimensions as a plain
integer or a tuple without having to construct an explicit `ROCDim3` object.
"""
struct ROCDim3
    x::Cuint
    y::Cuint
    z::Cuint
end

ROCDim3(dims::Integer)             = ROCDim3(dims,    Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{1,<:Integer}) = ROCDim3(dims[1], Cuint(1), Cuint(1))
ROCDim3(dims::NTuple{2,<:Integer}) = ROCDim3(dims[1], dims[2],  Cuint(1))
ROCDim3(dims::NTuple{3,<:Integer}) = ROCDim3(dims[1], dims[2],  dims[3])

# Type alias for conveniently specifying the dimensions
# (e.g. `(len, 2)` instead of `ROCDim3((len, 2))`)
const ROCDim = Union{Integer,
                    Tuple{Integer},
                    Tuple{Integer, Integer},
                    Tuple{Integer, Integer, Integer}}

function Base.getindex(dims::ROCDim3, idx::Int)
    return idx == 1 ? dims.x :
           idx == 2 ? dims.y :
           idx == 3 ? dims.z :
           error("Invalid dimension: $idx")
end

"""
    launch(queue::HSAQueue, signal::HSASignal, f::ROCFunction,
           groupsize::ROCDim, gridsize::ROCDim, args...)

Low-level call to launch a ROC function `f` on the GPU, using `groupsize` and
`gridsize` as respectively the grid and block configuration. The kernel is
launched on queue `queue` and is waited on by signal `signal`.

Arguments to a kernel should either be bitstype, in which case they will be
copied to the internal kernel parameter buffer, or a pointer to device memory.

This is a low-level call, prefer to use [`roccall`](@ref) instead.
"""
@inline function launch(queue::HSAQueue, signal::HSASignal, f::ROCFunction,
                        groupsize::ROCDim, gridsize::ROCDim, args...)
    groupsize = ROCDim3(groupsize)
    gridsize = ROCDim3(gridsize)
    (groupsize.x>0 && groupsize.y>0 && groupsize.z>0) ||
        throw(ArgumentError("Group dimensions should be non-null"))
    (gridsize.x>0 && gridsize.y>0 && gridsize.z>0) ||
        throw(ArgumentError("Grid dimensions should be non-null"))

    _launch(queue, signal, f, groupsize, gridsize, args...)
end

# we need a generated function to get an args array,
# without having to inspect the types at runtime
@generated function _launch(queue::HSAQueue, signal::HSASignal, f::ROCFunction,
                            groupsize::ROCDim3, gridsize::ROCDim3,
                            args::NTuple{N,Any}) where N
    all(isbitstype, args.parameters) ||
        throw(ArgumentError("Arguments to kernel should be bitstype."))

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

    # If f has N parameters, then kernelParams needs to be an array of N
    # pointers.  Each of kernelParams[0] through kernelParams[N-1] must point
    # to a region of memory from which the actual kernel parameter will be
    # copied.

    # put arguments in Ref boxes so that we can get a pointers to them
    arg_refs = Vector{Symbol}(undef, N)
    for i in 1:N
        arg_refs[i] = gensym()
        push!(ex.args, :($(arg_refs[i]) = Base.RefValue(args[$i])))
    end

    # generate an array with pointers
    arg_ptrs = [:(Base.unsafe_convert(Ptr{Cvoid}, $(arg_refs[i]))) for i in 1:N]

    append!(ex.args, (quote
        GC.@preserve $(arg_refs...) begin
            kernelParams = [$(arg_ptrs...)]

            # link with ld.lld
            ld_path = HSARuntime.ld_lld_path
            @assert ld_path != "" "ld.lld was not found; cannot link kernel"
            # TODO: Do this more idiomatically
            io = open("/tmp/amdgpu-dump.o", "w")
            write(io, f.mod.data)
            close(io)
            run(`$ld_path -shared -o /tmp/amdgpu.exe /tmp/amdgpu-dump.o`)
            io = open("/tmp/amdgpu.exe", "r")
            data = read(io)
            close(io)

            # generate executable and kernel instance
            exe = HSAExecutable(queue.agent, data, f.entry)
            kern = HSAKernelInstance(queue.agent, exe, f.entry, args)
            HSARuntime.launch!(queue, kern, signal;
                workgroup_size=groupsize, grid_size=gridsize)
        end
    end).args)

    return ex
end

"""
    roccall(queue::HSAQueue, signal::HSASignal, f::ROCFunction, types, values...;
             groupsize::ROCDim, gridsize::ROCDim)

`ccall`-like interface for launching a ROC function `f` on a GPU.

For example:

    vadd = ROCFunction(md, "vadd")
    a = rand(Float32, 10)
    b = rand(Float32, 10)
    ad = Mem.upload(a)
    bd = Mem.upload(b)
    c = zeros(Float32, 10)
    cd = Mem.alloc(c)

    roccall(vadd, (Ptr{Cfloat},Ptr{Cfloat},Ptr{Cfloat}), ad, bd, cd;
             gridsize=10)
    Mem.download!(c, cd)

The `groupsize` and `gridsize` arguments control the launch configuration, and should both
consist of either an integer, or a tuple of 1 to 3 integers (omitted dimensions default to
1). The `types` argument can contain both a tuple of types, and a tuple type, the latter
being slightly faster.
"""
roccall

@inline function roccall(queue::HSAQueue, signal::HSASignal, f::ROCFunction, types::NTuple{N,DataType}, values::Vararg{Any,N};
                          kwargs...) where N
    # this cannot be inferred properly (because types only contains `DataType`s),
    # which results in the call `@generated _roccall` getting expanded upon first use
    _roccall(queue, signal, f, Tuple{types...}, values; kwargs...)
end

@inline function roccall(queue::HSAQueue, signal::HSASignal, f::ROCFunction, tt::Type, values::Vararg{Any,N};
                          kwargs...) where N
    # in this case, the type of `tt` is `Tuple{<:DataType,...}`,
    # which means the generated function can be expanded earlier
    _roccall(queue, signal, f, tt, values; kwargs...)
end

# we need a generated function to get a tuple of converted arguments (using unsafe_convert),
# without having to inspect the types at runtime
@generated function _roccall(queue::HSAQueue, signal::HSASignal, f::ROCFunction, tt::Type, args::NTuple{N,Any};
                              groupsize::ROCDim=1, gridsize::ROCDim=1) where N
    types = tt.parameters[1].parameters     # the type of `tt` is Type{Tuple{<:DataType...}}

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

    # convert the argument values to match the kernel's signature (specified by the user)
    # (this mimics `lower-ccall` in julia-syntax.scm)
    converted_args = Vector{Symbol}(undef, N)
    arg_ptrs = Vector{Symbol}(undef, N)
    for i in 1:N
        converted_args[i] = gensym()
        arg_ptrs[i] = gensym()
        push!(ex.args, :($(converted_args[i]) = Base.cconvert($(types[i]), args[$i])))
        push!(ex.args, :($(arg_ptrs[i]) = Base.unsafe_convert($(types[i]), $(converted_args[i]))))
    end

    append!(ex.args, (quote
        GC.@preserve $(converted_args...) begin
            launch(queue, signal, f, groupsize, gridsize, ($(arg_ptrs...),))
        end
    end).args)

    return ex
end
