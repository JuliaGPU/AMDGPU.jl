Base.sort!(x::AnyROCArray; kwargs...) = (AK.sort!(x; kwargs...); return x)
Base.sortperm!(ix::AnyROCArray, x::AnyROCArray; kwargs...) = (AK.sortperm!(ix, x; kwargs...); return ix)
Base.sortperm(x::AnyROCArray; kwargs...) = sortperm!(ROCArray(1:length(x)), x; kwargs...)
