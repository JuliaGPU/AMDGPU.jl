# references to values that reside in GPU memory

"""
    ROCRef{T}()
    ROCRef{T}(x)
    ROCRef(x)
    ROCRef(A::ROCArray, i::Integer=1)

A reference to a single value of type `T` that resides in GPU memory, e.g. to pass a
device-side scalar to a library routine. The first three forms allocate a new value
(optionally initialized to `x`), while the last one refers to element `i` of the
(strided) device array `A` without copying it.

Reading a reference with `r[]` copies the value to the host, after the operations on the
current stream have completed; writing it with `r[] = x` copies `x` to the device.

```julia
alpha = ROCRef(2f0)
rocBLAS.scal!(length(x), alpha, x, 1)   # scale by a scalar that resides on the device

result = ROCRef{Float32}()
rocBLAS.dot(length(x), x, 1, y, 1, result)  # keep the result on the device
result[]
```
"""
struct ROCRef{T, A <: AbstractArray{T}} <: Ref{T}
    x::A
    i::Int

    function ROCRef{T, A}(x::A, i::Integer) where {T, A <: AbstractArray{T}}
        check_ref_eltype(T)
        checkbounds(x, i)
        new{T, A}(x, i)
    end
end

# values are copied as is, so they can't be boxed or carry a type tag (isbits unions)
check_ref_eltype(::Type{T}) where T = isbitstype(T) || throw(ArgumentError(
    "ROCRef only supports values of a bits type, got $T"))

ROCRef(x::StridedROCArray{T}, i::Integer=1) where T = ROCRef{T, typeof(x)}(x, i)
ROCRef{T}(x::StridedROCArray{T}, i::Integer=1) where T = ROCRef(x, i)

ROCRef{T}() where T = (check_ref_eltype(T); ROCRef(ROCVector{T}(undef, 1)))
function ROCRef{T}(x) where T
    ref = ROCRef{T}()
    ref[] = x
    return ref
end
ROCRef(x::T) where T = ROCRef{T}(x)

Base.unsafe_convert(::Type{Ptr{T}}, r::ROCRef{T}) where T = pointer(r.x, r.i)
Base.unsafe_convert(::Type{Ptr{Cvoid}}, r::ROCRef{T}) where T =
    convert(Ptr{Cvoid}, Base.unsafe_convert(Ptr{T}, r))

function Base.setindex!(r::ROCRef{T}, x) where T
    cpu = Ref{T}(convert(T, x))
    GC.@preserve cpu r begin
        # a blocking copy, so `cpu` can be released right away
        Mem.memcpy!(Base.unsafe_convert(Ptr{T}, r), Base.unsafe_convert(Ptr{T}, cpu),
                    aligned_sizeof(T); stream=stream())
    end
    return r
end

function Base.getindex(r::ROCRef{T}) where T
    cpu = Ref{T}()
    stm = stream()
    GC.@preserve cpu r begin
        Mem.memcpy!(Base.unsafe_convert(Ptr{T}, cpu), Base.unsafe_convert(Ptr{T}, r),
                    aligned_sizeof(T); stream=stm)
    end
    synchronize(stm)
    return cpu[]
end

function Base.show(io::IO, r::ROCRef{T}) where T
    print(io, "ROCRef{$T}(")
    show(io, r[])
    print(io, ")")
end
