Base.accumulate!(op, B::AnyROCArray, A::AnyROCArray; init=zero(eltype(A)), kwargs...) =
    AK.accumulate!(op, B, A, ROCBackend(); init, kwargs...)

Base.accumulate(op, A::AnyROCArray; init=zero(eltype(A)), kwargs...) =
    AK.accumulate(op, A, ROCBackend(); init, kwargs...)

Base.cumsum(src::AnyROCArray; kwargs...) = AK.cumsum(src, ROCBackend(); kwargs...)
Base.cumprod(src::AnyROCArray; kwargs...) = AK.cumprod(src, ROCBackend(); kwargs...)
