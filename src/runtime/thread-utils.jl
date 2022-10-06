import ..LLVM

## Lazy Initialization
# Borrowed from CUDA.jl

"""
    LazyInitialized{T}()

A thread-safe, lazily-initialized wrapper for a value of type `T`. Initialize and fetch the
value by calling `get!`. The constructor is ensured to only be called once.

This type is intended for lazy initialization of e.g. global structures, without using
`__init__`. It is similar to protecting accesses using a lock, but is much cheaper.

"""
struct LazyInitialized{T}
    # 0: uninitialized
    # 1: initializing
    # 2: initialized
    guard::Threads.Atomic{Int}
    value::Base.RefValue{T}

    LazyInitialized{T}() where {T} =
        new(Threads.Atomic{Int}(0), Ref{T}())
end

@inline function Base.get!(constructor, x::LazyInitialized; hook=nothing)
    while x.guard[] != 2
        initialize!(x, constructor, hook)
    end
    LLVM.Interop.assume(isassigned(x.value)) # to get rid of the check
    x.value[]
end

@noinline function initialize!(x::LazyInitialized, constructor::F1, hook::F2) where {F1, F2}
    status = Threads.atomic_cas!(x.guard, 0, 1)
    if status == 0
        try
            x.value[] = constructor()
            x.guard[] = 2
        catch
            x.guard[] = 0
            rethrow()
        end

        if hook !== nothing
            hook()
        end
    else
        yield()
    end
    return
end

## Memoization
# Borrowed from CUDA.jl

export @memoize

"""
    @memoize [key::T] [maxlen=...] begin
        # expensive computation
    end::T

Low-level, no-frills memoization macro that stores values in a thread-local, typed cache.
The types of the caches are derived from the syntactical type assertions.

The cache consists of two levels, the outer one indexed with the thread index. If no `key`
is specified, the second level of the cache is dropped.

If the the `maxlen` option is specified, the `key` is assumed to be an  integer, and the
secondary cache will be a vector with length `maxlen`. Otherwise, a dictionary is used.
"""
macro memoize(ex...)
    code = ex[end]
    args = ex[1:end-1]

    # decode the code body
    @assert Meta.isexpr(code, :(::))
    rettyp = code.args[2]
    code = code.args[1]

    # decode the arguments
    key = nothing
    if length(args) >= 1
        arg = args[1]
        @assert Meta.isexpr(arg, :(::))
        key = (val=arg.args[1], typ=arg.args[2])
    end
    options = Dict()
    for arg in args[2:end]
        @assert Meta.isexpr(arg, :(=))
        options[arg.args[1]] = arg.args[2]
    end

    # the global cache is an array with one entry per thread. if we don't have to key on
    # anything, that entry will be the memoized new_value, or else a dictionary of values.
    @gensym global_cache

    # generate code to access memoized values
    # (assuming the global_cache can be indexed with the thread ID)
    if key === nothing
        # if we don't have to key on anything, use the global cache directly
        global_cache_eltyp = :(Union{Nothing,$rettyp})
        ex = quote
            cache = get!($(esc(global_cache))) do
                [nothing for _ in 1:Threads.nthreads()]
            end
            cached_value = @inbounds cache[Threads.threadid()]
            if cached_value !== nothing
                cached_value
            else
                new_value = $(esc(code))::$rettyp
                @inbounds cache[Threads.threadid()] = new_value
                new_value
            end
        end
    elseif haskey(options, :maxlen)
        # if we know the length of the cache, use a fixed-size array
        global_cache_eltyp = :(Vector{Union{Nothing,$rettyp}})
        global_init = :(Union{Nothing,$rettyp}[nothing for _ in 1:$(esc(options[:maxlen]))])
        ex = quote
            cache = get!($(esc(global_cache))) do
                [$global_init for _ in 1:Threads.nthreads()]
            end
            local_cache = @inbounds begin
                tid = Threads.threadid()
                LLVM.Interop.assume(isassigned(cache, tid))
                cache[tid]
            end
            cached_value = @inbounds local_cache[$(esc(key.val))]
            if cached_value !== nothing
                cached_value
            else
                new_value = $(esc(code))::$rettyp
                @inbounds local_cache[$(esc(key.val))] = new_value
                new_value
            end
        end
    else
        # otherwise, fall back to a dictionary
        global_cache_eltyp = :(Dict{$(key.typ),$rettyp})
        global_init = :(Dict{$(key.typ),$rettyp}())
        ex = quote
            cache = get!($(esc(global_cache))) do
                [$global_init for _ in 1:Threads.nthreads()]
            end
            local_cache = @inbounds begin
                tid = Threads.threadid()
                LLVM.Interop.assume(isassigned(cache, tid))
                cache[tid]
            end
            cached_value = get(local_cache, $(esc(key.val)), nothing)
            if cached_value !== nothing
                cached_value
            else
                new_value = $(esc(code))::$rettyp
                local_cache[$(esc(key.val))] = new_value
                new_value
            end
        end
    end

    # define the per-thread cache
    @eval __module__ begin
        const $global_cache = LazyInitialized{Vector{$(global_cache_eltyp)}}()
    end

    quote
        $ex
    end
end

## Safe (non-yielding) locking primitives
# Borrowed from CUDA.jl

macro spinlock(l, ex)
    quote
        temp = $(esc(l))
        while !trylock(temp)
            ccall(:jl_cpu_pause, Cvoid, ())
            # Temporary solution before we have gc transition support in codegen.
            ccall(:jl_gc_safepoint, Cvoid, ())
            # we can't yield here
        end
        try
            $(esc(ex))
        finally
            unlock(temp)
        end
    end
end
