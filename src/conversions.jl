# Base.RefValue isn't GPU compatible, so provide a compatible alternative
struct ROCRefValue{T} <: Ref{T}
    x::T
end
Base.getindex(r::ROCRefValue) = r.x
Base.setindex!(r::ROCRefValue{T}, value::T) where T = (r.x = value;)
Adapt.adapt_structure(to::Runtime.Adaptor, r::Base.RefValue) = ROCRefValue(adapt(to, r[]))

# broadcast sometimes passes a ref(type), resulting in a GPU-incompatible DataType box.
# avoid that by using a special kind of ref that knows about the boxed type.
struct ROCRefType{T} <: Ref{DataType} end
Base.getindex(r::ROCRefType{T}) where T = T
Adapt.adapt_structure(to::Runtime.Adaptor, r::Base.RefValue{<:Union{DataType,Type}}) = ROCRefType{r[]}()
