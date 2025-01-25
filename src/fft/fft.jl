abstract type ROCFFTPlan{T, K, inplace} <: Plan{T} end

Base.eltype(::ROCFFTPlan{T}) where T = T

is_inplace(::ROCFFTPlan{<:Any, <:Any, inplace}) where inplace = inplace

Base.unsafe_convert(::Type{rocfft_plan}, p::ROCFFTPlan) = p.handle

function AMDGPU.unsafe_free!(plan::ROCFFTPlan)
    if plan.handle != C_NULL
        release_plan!(plan)
        plan.handle = C_NULL
    end
    if !isnothing(plan.buffer)
        unsafe_free!(plan.buffer)
    end
    unsafe_free!(plan.workarea)
    rocfft_execution_info_destroy(plan.execution_info)
end

const ROCFFT_FORWARD = true
const ROCFFT_INVERSE = false

# TODO: Real to Complex full not possible atm
# For R2C -> cast array to Complex first

# K is flag for forward/inverse
mutable struct cROCFFTPlan{T,K,inplace,N,R,B} <: ROCFFTPlan{T, K, inplace}
    handle::rocfft_plan
    stream::HIPStream
    workarea::ROCVector{Int8}
    execution_info::rocfft_execution_info
    sz::NTuple{N, Int} # Julia size of input array
    osz::NTuple{N, Int} # Julia size of output array
    xtype::rocfft_transform_type
    region::NTuple{R,Int}
    buffer::B
    # These two fields are used in the dtor as a key for HandleCache.
    input_sz_as_key::Bool
    key_T::Type
    # required by AbstractFFTs API
    pinv::ScaledPlan

    function cROCFFTPlan{T,K,inplace,N,R,B}(
        handle::rocfft_plan, workarea::ROCVector{Int8},
        X::ROCArray{T,N}, sizey::Tuple,
        xtype::rocfft_transform_type, region::NTuple{R,Int},
        buffer::B, input_sz_as_key::Bool, key_T::Type,
    ) where {T,K,inplace,N,R,B}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]

        # assign to the current stream
        stream = AMDGPU.stream()
        rocfft_execution_info_set_stream(info, stream)
        if length(workarea) > 0
            rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        end
        p = new(handle, stream, workarea, info, size(X), sizey, xtype, region, buffer, input_sz_as_key, key_T)
        return finalizer(AMDGPU.unsafe_free!, p)
    end
end

mutable struct rROCFFTPlan{T,K,inplace,N,R,B} <: ROCFFTPlan{T,K,inplace}
    handle::rocfft_plan
    stream::HIPStream
    workarea::ROCVector{Int8}
    execution_info::rocfft_execution_info
    sz::NTuple{N,Int} # Julia size of input array
    osz::NTuple{N,Int} # Julia size of output array
    xtype::rocfft_transform_type
    region::NTuple{R,Int}
    buffer::B
    # These two fields are used in the dtor as a key for HandleCache.
    input_sz_as_key::Bool
    key_T::Type
    # required by AbstractFFTs API
    pinv::ScaledPlan

    function rROCFFTPlan{T,K,inplace,N,R,B}(
        handle::rocfft_plan, workarea::ROCVector{Int8}, X::ROCArray{T,N},
        sizey::Tuple, xtype::rocfft_transform_type, region::NTuple{R,Int},
        buffer::B, input_sz_as_key::Bool, key_T::Type,
    ) where {T,inplace,N,K,R,B}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]

        stream = AMDGPU.stream()
        rocfft_execution_info_set_stream(info, stream)
        if length(workarea) > 0
            rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        end
        p = new(handle, stream, workarea, info, size(X), sizey, xtype, region, buffer, input_sz_as_key, key_T)
        return finalizer(unsafe_free!, p)
    end
end

function update_stream!(plan::ROCFFTPlan)
    new_stream = AMDGPU.stream()
    if plan.stream != new_stream
        plan.stream = new_stream
        info = plan.execution_info
        rocfft_execution_info_set_stream(info, new_stream)
    end
    return
end

const xtypenames = ("complex forward", "complex inverse", "real forward", "real inverse")

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
    @eval function $f(X::ROCArray{T, N}, region) where {T <: rocfftComplexes, N}
        _inplace = $(inplace)
        _xtype = $(xtype)
        R = length(region)
        region = NTuple{R,Int}(region)
        pp = get_plan(_xtype, size(X), T, _inplace, region)
        return cROCFFTPlan{T,$forward,_inplace,N,R,Nothing}(pp..., X, size(X), _xtype, region, nothing, false, T)
    end
end

function plan_rfft(X::ROCArray{T,N}, region) where {T<:rocfftReals,N}
    inplace = false
    xtype = rocfft_transform_type_real_forward
    R = length(region)
    region = NTuple{R,Int}(region)
    pp = get_plan(xtype, size(X), T, inplace, region)
    ydims = collect(size(X))
    ydims[region[1]] = div(ydims[region[1]],2) + 1

    # The buffer is not needed for real-to-complex (`mul!`),
    # but it’s required for complex-to-real (`ldiv!`).
    buffer = ROCArray{complex(T)}(undef, ydims...)
    B = typeof(buffer)

    return rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N,R,B}(pp..., X, (ydims...,), xtype, region, buffer, true, T)
end

function plan_brfft(X::ROCArray{T,N}, d::Integer, region) where {T <: rocfftComplexes, N}
    inplace = false
    xtype = rocfft_transform_type_real_inverse
    R = length(region)
    region = NTuple{R,Int}(region)
    ydims = collect(size(X))
    ydims[region[1]] = d
    pp = get_plan(xtype, (ydims...,), T, inplace, region)

    # Buffer to not modify the input in a complex-to-real FFT.
    buffer = ROCArray{T}(undef, size(X))
    B = typeof(buffer)

    return rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N,R,B}(pp..., X, (ydims...,), xtype, region, buffer, false, T)
end

# FIXME: plan_inv methods allocate needlessly (to provide type parameters and normalization function)
# Perhaps use FakeArray types to avoid this.
function plan_inv(p::cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N,R,B}) where {T<:rocfftComplexes,N,inplace,R,B}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_inverse
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(
        cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N,R,B}(pp..., X, p.sz, xtype, p.region, p.buffer, false, T),
        normalization(X, p.region))
end

function plan_inv(p::cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N,R,B}) where {T<:rocfftComplexes,N,inplace,R,B}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_forward
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(
        cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N,R,B}(pp..., X, p.sz, xtype, p.region, p.buffer, false, T),
        normalization(X, p.region))
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N,R,B}) where {T<:rocfftReals,N,inplace,R,B}
    X = ROCArray{complex(T)}(undef, p.osz)
    Y = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_real_inverse
    pp = get_plan(xtype, p.sz, T, inplace, p.region)
    scale = normalization(Y, p.region)
    ScaledPlan(
        rROCFFTPlan{complex(T),ROCFFT_INVERSE,inplace,N,R,B}(pp..., X, p.sz, xtype, p.region, p.buffer, false, T),
        scale)
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N,R,B}) where {T<:rocfftComplexes,N,inplace,R,B}
    X = ROCArray{real(T)}(undef, p.osz)
    xtype = rocfft_transform_type_real_forward
    pp = get_plan(xtype, p.osz, T, inplace, p.region)
    scale = normalization(X, p.region)
    ScaledPlan(
        rROCFFTPlan{real(T),ROCFFT_FORWARD,inplace,N,R,B}(pp..., X, p.sz, xtype, p.region, p.buffer, true, T),
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

function unsafe_execute!(plan::cROCFFTPlan{T,K,true,N}, X::ROCArray{T,N}) where {T,K,N}
    update_stream!(plan)
    rocfft_execute(plan, [pointer(X),], C_NULL, plan.execution_info)
end

function unsafe_execute!(
    plan::cROCFFTPlan{T,K,false,N}, X::ROCArray{T,N}, Y::ROCArray{T},
) where {T,N,K}
    update_stream!(plan)
    rocfft_execute(plan, [pointer(X),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(
    plan::rROCFFTPlan{T,ROCFFT_FORWARD,false,N},
    X::ROCArray{T,N}, Y::ROCArray{<:rocfftComplexes,N},
) where {T<:rocfftReals,N}
    @assert plan.xtype == rocfft_transform_type_real_forward
    update_stream!(plan)
    rocfft_execute(plan, [pointer(X),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(
    plan::rROCFFTPlan{T,ROCFFT_INVERSE,false,N},
    X::ROCArray{T,N}, Y::ROCArray{<:rocfftReals,N},
) where {T<:rocfftComplexes,N}
    @assert plan.xtype == rocfft_transform_type_real_inverse
    update_stream!(plan)
    rocfft_execute(plan, [pointer(X),], [pointer(Y),], plan.execution_info)
end

function LinearAlgebra.mul!(y::ROCArray{Ty}, p::ROCFFTPlan{T,K,false}, x::ROCArray{T}) where {T,Ty,K}
    if T<:Complex
        # Out-of-place complex-to-real FFT will always overwrite input x.
        # We copy the input x in an auxiliary buffer.
        z = p.buffer
        copyto!(z, x)
    else
        z = x
    end
    assert_applicable(p, z, y)
    unsafe_execute!(p, z, y)
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
    # Out-of-place complex-to-real FFT will always overwrite input x.
    # We copy the input x in an auxiliary buffer.
    z = p.buffer
    copyto!(z, x)
    mul!(y, p, z)
end
