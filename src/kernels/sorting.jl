Base.sort!(x::AnyROCArray; kwargs...) = (AK.sort!(x; kwargs...); return x)

# Base's out-of-place `sort(x; dims)` would sort chunks on the CPU, tripping scalar indexing.
Base.sort(x::AnyROCArray; kwargs...) = sort!(copy(x); kwargs...)

Base.sortperm!(ix::AnyROCArray, x::AnyROCArray; kwargs...) = (AK.sortperm!(ix, x; kwargs...); return ix)

# AcceleratedKernels wants the index array shaped like `x` when `dims` is given.
Base.sortperm(x::AnyROCArray; dims::Union{Nothing, Integer}=nothing, kwargs...) =
    isnothing(dims) ?
        sortperm!(ROCArray(1:length(x)), x; kwargs...) :
        sortperm!(reshape(ROCArray(1:length(x)), size(x)), x; dims, kwargs...)
