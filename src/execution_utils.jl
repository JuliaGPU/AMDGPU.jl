# Execution control
# modeled after: CUDAdrv/src/execution.jl

export ROCDim, ROCModule, ROCFunction, roccall

## kernel allocations

struct KernelMetadata
    kern::UInt64
    buf::Mem.Buffer
end

## module and function

const MAX_EXCEPTIONS = 256
const EXE_TO_MODULE_MAP = IdDict{Any,WeakRef}()
mutable struct ROCModule{E}
    exe::RuntimeExecutable{E}
    metadata::Vector{KernelMetadata}
    exceptions::Mem.Buffer
end
function ROCModule(exe)
    metadata = KernelMetadata[]
    exceptions = Mem.alloc(sizeof(ExceptionEntry)*MAX_EXCEPTIONS; coherent=true)
    mod = ROCModule(exe, metadata, exceptions)
    _exe = exe.exe
    EXE_TO_MODULE_MAP[_exe] = WeakRef(mod)
    hsaref!()
    finalizer(mod) do x
        # FIXME: Free all metadata
        Mem.free(mod.exceptions)
        delete!(EXE_TO_MODULE_MAP, _exe)
        hsaunref!()
    end
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

A type used to specify dimensions, consisting of 3 integers for the `x`, `y`,
and `z` dimension, respectively. Unspecified dimensions default to `1`.

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
    roccall(f::ROCFunction, types, values...;
            queue::RuntimeQueue, signal::RuntimeEvent,
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

# we need a generated function to get a tuple of converted arguments (using unsafe_convert),
# without having to inspect the types at runtime
@generated function roccall(f::ROCFunction, tt::Type, args::Vararg{Any,N}; queue::RuntimeQueue,
                             signal::RuntimeEvent, groupsize::ROCDim=1, gridsize::ROCDim=groupsize) where N

    # the type of `tt` is Type{Tuple{<:DataType...}}
    types = tt.parameters[1].parameters

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

    # convert the argument values to match the kernel's signature (specified by the user)
    # (this mimics `lower-ccall` in julia-syntax.scm)
    converted_args = Vector{Symbol}(undef, length(args))
    arg_ptrs = Vector{Symbol}(undef, length(args))
    for i in 1:length(args)
        converted_args[i] = gensym()
        arg_ptrs[i] = gensym()
        push!(ex.args, :($(converted_args[i]) = Base.cconvert($(types[i]), args[$i])))
        push!(ex.args, :($(arg_ptrs[i]) = Base.unsafe_convert($(types[i]), $(converted_args[i]))))
    end

    append!(ex.args, (quote
        #GC.@preserve $(converted_args...) begin
            launch(queue, signal, f, groupsize, gridsize, ($(arg_ptrs...),))
        #end
    end).args)

    return ex
end

"""
    launch(queue::RuntimeQueue, signal::RuntimeEvent, f::ROCFunction,
           groupsize::ROCDim, gridsize::ROCDim, args...)

Low-level call to launch a ROC function `f` on the GPU, using `groupsize` and
`gridsize` as the grid and block configuration, respectively. The kernel is
launched on `queue` and is waited on by `signal`.

Arguments to a kernel should either be bitstype, in which case they will be
copied to the internal kernel parameter buffer, or a pointer to device memory.

This is a low-level call, preferably use [`roccall`](@ref) instead.
"""
@inline function launch(queue::RuntimeQueue, signal::RuntimeEvent, f::ROCFunction,
                        groupsize::ROCDim, gridsize::ROCDim, args...)
    groupsize = ROCDim3(groupsize)
    gridsize = ROCDim3(gridsize)
    (groupsize.x>0 && groupsize.y>0 && groupsize.z>0) ||
        throw(ArgumentError("Group dimensions must be non-zero"))
    (gridsize.x>0 && gridsize.y>0 && gridsize.z>0) ||
        throw(ArgumentError("Grid dimensions must be non-zero"))
    (groupsize.x<=_max_group_size.x+1 &&
     groupsize.y<=_max_group_size.y+1 &&
     groupsize.z<=_max_group_size.z+1) ||
        throw(ArgumentError("Group dimensions too large"))

    _launch(queue, signal, f, groupsize, gridsize, args...)
end

## HSA object preservation while a kernel is active

const SIGNAL_PRESERVED = IdDict{HSASignal, Vector{Any}}()

function preserve!(sig::HSASignal, @nospecialize(x))
    set = get!(()->Any[], SIGNAL_PRESERVED, sig)
    push!(set, x)
end
preserve!(sig::HSAStatusSignal, @nospecialize(x)) = preserve!(sig.signal, x)
preserve!(ev::RuntimeEvent, @nospecialize(x)) = preserve!(ev.event, x)

unpreserve!(sig::HSASignal) = delete!(SIGNAL_PRESERVED, sig)
unpreserve!(sig::HSAStatusSignal) = unpreserve!(sig.signal)
unpreserve!(ev::RuntimeEvent) = unpreserve!(ev.event)

# we need a generated function to get an args array,
# without having to inspect the types at runtime
@generated function _launch(queue::RuntimeQueue, signal::RuntimeEvent, f::ROCFunction,
                            groupsize::ROCDim3, gridsize::ROCDim3,
                            args::NTuple{N,Any}) where N

    all(isbitstype, args.parameters) ||
        throw(ArgumentError("Arguments to kernel should be bitstype."))

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

    # put arguments in Ref boxes so that we can get a pointers to them
    arg_refs = Vector{Symbol}(undef, N)
    for i in 1:N
        arg_refs[i] = gensym()
        push!(ex.args, :($(arg_refs[i]) = Base.RefValue(args[$i])))
    end

    append!(ex.args, (quote
        GC.@preserve $(arg_refs...) begin
            # create kernel instance
            kern = create_kernel(get_device(queue), f.mod.exe, f.entry, args)

            # launch kernel
            launch_kernel(queue, kern, signal;
                          groupsize=groupsize, gridsize=gridsize)

            # preserve kernel and arguments
            $preserve!(signal, kern)
            for arg in args
                $preserve!(signal, arg)
            end
        end
    end).args)

    return ex
end
