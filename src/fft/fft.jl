abstract type ROCFFTPlan{T, K, inplace} <: Plan{T} end

Base.unsafe_convert(::Type{rocfft_plan}, p::ROCFFTPlan) = p.handle

function unsafe_free!(plan::ROCFFTPlan)
    rocfft_plan_destroy(plan.handle)
    unsafe_free!(plan.workarea)
    rocfft_execution_info_destroy(plan.execution_info)
end

# TODO mul overrides?

const ROCFFT_FORWARD = true
const ROCFFT_INVERSE = false

# TODO: Real to Complex full not possible atm
# K is flag for forward/inverse
mutable struct cROCFFTPlan{T,K,inplace,N} <: ROCFFTPlan{T,K,inplace}
    handle::rocfft_plan
    workarea::ROCVector{Int8}
    execution_info::rocfft_execution_info
    sz::NTuple{N,Int} # Julia size of input array
    osz::NTuple{N,Int} # Julia size of output array
    xtype::rocfft_transform_type
    region::Any
    pinv::ScaledPlan # required by AbstractFFTs API

    function cROCFFTPlan{T,K,inplace,N}(
        handle::rocfft_plan, workarea::ROCVector{Int8},
        X::ROCArray{T,N}, sizey::Tuple,
        xtype::rocfft_transform_type, region,
    ) where {T,inplace,N,K}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]

        # assign to the current stream
        rocfft_execution_info_set_stream(info, AMDGPU.stream())
        if length(workarea) > 0
            rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        end
        p = new(handle, workarea, info, size(X), sizey, xtype, region)
        finalizer(unsafe_free!, p)
        p
    end
end

mutable struct rROCFFTPlan{T,K,inplace,N} <: ROCFFTPlan{T,K,inplace}
    handle::rocfft_plan
    workarea::ROCVector{Int8}
    execution_info::rocfft_execution_info
    sz::NTuple{N,Int} # Julia size of input array
    osz::NTuple{N,Int} # Julia size of output array
    xtype::rocfft_transform_type
    region::Any
    pinv::ScaledPlan # required by AbstractFFTs API

    function rROCFFTPlan{T,K,inplace,N}(
        handle::rocfft_plan, workarea::ROCVector{Int8}, X::ROCArray{T,N},
        sizey::Tuple, xtype::rocfft_transform_type, region,
    ) where {T,inplace,N,K}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]

        rocfft_execution_info_set_stream(info, AMDGPU.stream())
        if length(workarea) > 0
            rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        end
        p = new(handle, workarea, info, size(X), sizey, xtype, region)
        finalizer(unsafe_free!, p)
        p
    end
end

const xtypenames = (
    "complex forward", "complex inverse", "real forward", "real inverse")

function showfftdims(io, sz, T)
    if isempty(sz)
        print(io,"0-dimensional")
    elseif length(sz) == 1
        print(io, sz[1], "-element")
    else
        print(io, join(sz, "×"))
    end
    print(io, " ROCArray of ", T)
end

function Base.show(io::IO, p::ROCFFTPlan{T,K,inplace}) where {T,K,inplace}
    print(io,
        inplace ? "rocFFT in-place " : "rocFFT ",
        xtypenames[Int(p.xtype) + 1], " plan for ")
    showfftdims(io, p.sz, T)
end

Base.size(p::ROCFFTPlan) = p.sz

# inplace/notinplace complex
for (f, xtype, inplace, forward) in (
    (:plan_fft!, :rocfft_transform_type_complex_forward, :true, :true),
    (:plan_bfft!, :rocfft_transform_type_complex_inverse, :true, :false),
    (:plan_fft, :rocfft_transform_type_complex_forward, :false, :true),
    (:plan_bfft, :rocfft_transform_type_complex_inverse, :false, :false),
)
    @eval begin
        function $f(X::ROCArray{T, N}, region) where {T <: rocfftComplexes, N}
            _inplace = $(inplace)
            _xtype = $(xtype)
            pp = get_plan(_xtype, size(X), T, _inplace, region)
            cROCFFTPlan{T,$forward,_inplace,N}(pp..., X, size(X), _xtype, region)
        end
    end
end

function plan_rfft(X::ROCArray{T,N}, region) where {T<:rocfftReals,N}
    inplace = false
    xtype = rocfft_transform_type_real_forward
    pp = get_plan(xtype, size(X), T, inplace, region)
    ydims = collect(size(X))
    ydims[region[1]] = div(ydims[region[1]],2) + 1
    return rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}(
        pp..., X, (ydims...,), xtype, region)
end

function plan_brfft(X::ROCArray{T,N}, d::Integer, region::Any) where {T <: rocfftComplexes, N}
    inplace = false
    xtype = rocfft_transform_type_real_inverse
    ydims = collect(size(X))
    ydims[region[1]] = d
    pp = get_plan(xtype, (ydims...,), T, inplace, region)
    return rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}(
        pp..., X, (ydims...,), xtype, region)
end

# FIXME: plan_inv methods allocate needlessly (to provide type parameters and normalization function)
# Perhaps use FakeArray types to avoid this.
function plan_inv(p::cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_inverse
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(
        cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}(
            pp..., X, p.sz, xtype, p.region),
        normalization(X, p.region))
end

function plan_inv(p::cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_forward
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(
        cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}(pp..., X, p.sz, xtype, p.region),
        normalization(X, p.region))
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}) where {T<:rocfftReals,N,inplace}
    X = ROCArray{complex(T)}(undef, p.osz)
    Y = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_real_inverse
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    scale = normalization(Y, p.region)
    ScaledPlan(
        rROCFFTPlan{complex(T),ROCFFT_INVERSE,inplace,N}(
            pp..., X, p.sz, xtype, p.region),
        scale)
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{real(T)}(undef, p.osz)
    xtype = rocfft_transform_type_real_forward
    pp = get_plan(xtype, p.osz, T, inplace, p.region)
    scale = normalization(X, p.region)
    ScaledPlan(
        rROCFFTPlan{real(T),ROCFFT_FORWARD,inplace,N}(
            pp..., X, p.sz, xtype, p.region),
        scale)
end

## plan execution

function assert_applicable(p::ROCFFTPlan{T}, X::ROCArray{T}) where T
    (size(X) == p.sz) ||
        throw(ArgumentError("rocFFT plan applied to wrong-size input"))
end

function assert_applicable(p::ROCFFTPlan{T,K}, X::ROCArray{T}, Y::ROCArray{Ty}) where {T,K,Ty}
    assert_applicable(p, X)
    (size(Y) == p.osz) ||
        throw(ArgumentError("rocFFT plan applied to wrong-size output"))
    # type errors should be impossible by dispatch, but just in case:
    if p.xtype == rocfft_transform_type_real_inverse
        (Ty == real(T)) || throw(ArgumentError("Type mismatch for argument Y"))
    elseif p.xtype == rocfft_transform_type_real_forward
        (Ty == complex(T)) || throw(ArgumentError("Type mismatch for argument Y"))
    else
        (Ty == T) || throw(ArgumentError("Type mismatch for argument Y"))
    end
end

# TODO update stream

function unsafe_execute!(plan::cROCFFTPlan{T,K,true,N}, X::ROCArray{T,N}) where {T,K,N}
    println("LLLLLLLLLLLLLLLLLLLLll")
    @show plan
    @show plan.sz
    @show plan.osz
    @show plan.execution_info
    @show size(plan.workarea)
    @show sum(plan.workarea)
    rocfft_execute(plan, [pointer(X),], C_NULL, plan.execution_info)
end

function unsafe_execute!(
    plan::cROCFFTPlan{T,K,false,N}, X::ROCArray{T,N}, Y::ROCArray{T},
) where {T,N,K}
    X = copy(X) # since input array can also be modified
    rocfft_execute(plan, [pointer(X),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(
    plan::rROCFFTPlan{T,ROCFFT_FORWARD,false,N},
    X::ROCArray{T,N}, Y::ROCArray{<:rocfftComplexes,N},
) where {T<:rocfftReals,N}
    @assert plan.xtype == rocfft_transform_type_real_forward
    Xcopy = copy(X)
    rocfft_execute(plan, [pointer(Xcopy),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(
    plan::rROCFFTPlan{T,ROCFFT_INVERSE,false,N},
    X::ROCArray{T,N}, Y::ROCArray{<:rocfftReals,N},
) where {T<:rocfftComplexes,N}
    @assert plan.xtype == rocfft_transform_type_real_inverse
    Xcopy = copy(X)
    rocfft_execute(plan, [pointer(Xcopy),], [pointer(Y),], plan.execution_info)
end


function LinearAlgebra.mul!(y::ROCArray{Ty}, p::ROCFFTPlan{T,K,false}, x::ROCArray{T}) where {T,Ty,K}
    assert_applicable(p, x, y)
    unsafe_execute!(p, x, y)
    return y
end

function Base.:(*)(p::cROCFFTPlan{T,K,true,N}, x::ROCArray{T,N}) where {T,K,N}
    assert_applicable(p, x)
    unsafe_execute!(p, x)
    x
end

function Base.:(*)(p::cROCFFTPlan{T,K,false,N}, x::ROCArray{T,N}) where {T,K,N}
    y = ROCArray{T}(undef, p.osz)
    mul!(y, p, x)
end

function Base.:(*)(p::rROCFFTPlan{T,ROCFFT_FORWARD,false,N}, x::ROCArray{T,N}) where {T<:rocfftReals,N}
    @assert p.xtype == rocfft_transform_type_real_forward
    y = ROCArray{complex(T)}(undef, p.osz)
    mul!(y, p, x)
end

function Base.:(*)(p::rROCFFTPlan{T,ROCFFT_INVERSE,false,N}, x::ROCArray{T,N}) where {T<:rocfftComplexes,N}
    @assert p.xtype == rocfft_transform_type_real_inverse
    y = ROCArray{real(T)}(undef, p.osz)
    mul!(y, p, x)
end
