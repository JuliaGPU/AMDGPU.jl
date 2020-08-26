import AbstractFFTs: plan_fft, plan_fft!, plan_bfft, plan_bfft!,
    plan_rfft, plan_brfft, plan_inv, normalization, fft, bfft, ifft, rfft,
    Plan, ScaledPlan

using LinearAlgebra

const ROCFFT_FORWARD = true
const ROCFFT_INVERSE = false

abstract type ROCFFTPlan{T,K,inplace} <: Plan{T} end

Base.unsafe_convert(::Type{rocfft_plan}, p::ROCFFTPlan) = p.handle

function unsafe_free!(plan::ROCFFTPlan)
    rocfft_plan_destroy(plan.handle)
    rocfft_execution_info_destroy(plan.execution_info)
end

# TODO: Real to Complex full not possible atm
# K is flag for forward/inverse
mutable struct cROCFFTPlan{T,K,inplace,N} <: ROCFFTPlan{T,K,inplace}
    handle::rocfft_plan
    workarea::ROCArray{Int8,1}
    execution_info::rocfft_execution_info
    sz::NTuple{N,Int} # Julia size of input array
    osz::NTuple{N,Int} # Julia size of output array
    xtype::rocfft_transform_type
    region
    pinv::ScaledPlan # required by AbstractFFTs API

    function cROCFFTPlan{T,K,inplace,N}(handle::rocfft_plan, workarea::ROCArray{Int8,1}, X::ROCArray{T,N}, sizey::Tuple,
                                      xtype::rocfft_transform_type, region) where {T,inplace,N,K}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]
        rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        p = new(handle, workarea, info, size(X), sizey, xtype, region)
        finalizer(unsafe_free!, p)
        p
    end
end

mutable struct rROCFFTPlan{T,K,inplace,N} <: ROCFFTPlan{T,K,inplace}
    handle::rocfft_plan
    workarea::ROCArray{Int8,1}
    execution_info::rocfft_execution_info
    sz::NTuple{N,Int} # Julia size of input array
    osz::NTuple{N,Int} # Julia size of output array
    xtype::rocfft_transform_type
    region
    pinv::ScaledPlan # required by AbstractFFTs API

    function rROCFFTPlan{T,K,inplace,N}(handle::rocfft_plan, workarea::ROCArray{Int8,1}, X::ROCArray{T,N}, sizey::Tuple,
                                      xtype::rocfft_transform_type, region) where {T,inplace,N,K}
        info_ref = Ref{rocfft_execution_info}()
        rocfft_execution_info_create(info_ref)
        info = info_ref[]
        rocfft_execution_info_set_work_buffer(info, workarea, length(workarea))
        p = new(handle, workarea, info, size(X), sizey, xtype, region)
        finalizer(unsafe_free!, p)
        p
    end
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
    print(io, inplace ? "rocFFT in-place " : "rocFFT ",
          xtypenames[Int(p.xtype)+1],
          " plan for ")
    showfftdims(io, p.sz, T)
end

Base.size(p::ROCFFTPlan) = p.sz

function create_plan(xtype::rocfft_transform_type, xdims, T, inplace, region)
    precision = (real(T) == Float64) ? rocfft_precision_double : rocfft_precision_single
    sz = [xdims[i] for i in region]
    csz = copy(sz)
    cxdims = [xdims...]
    csz[1] = div(sz[1],2) + 1
    cxdims[region[1]] = csz[1]
    nrank = length(region)
    batch = prod(xdims) ÷ prod(sz)

    handle_ref = Ref{rocfft_plan}()
    worksize_ref = Ref{Csize_t}()
    placement = inplace ? rocfft_placement_inplace : rocfft_placement_notinplace
    rsz = (length(sz) > 1) ? rsz = reverse(sz) : sz
    if batch == 1
        rocfft_plan_create(handle_ref, placement, xtype, precision, nrank, sz, 1, C_NULL)
    else
        cdims = collect(xdims)
        cdims[region[1]] = div(cdims[region[1]],2)+1
        plan_desc_ref = Ref{rocfft_plan_description}()
        rocfft_plan_description_create(plan_desc_ref)
        description = plan_desc_ref[]
        if xtype == rocfft_transform_type_real_forward
            in_array_type = rocfft_array_type_real
            # TODO: output to full array
            out_array_type = rocfft_array_type_hermitian_interleaved
        elseif xtype == rocfft_transform_type_real_inverse
            # TODO: also for complex_interleaved
            in_array_type = rocfft_array_type_hermitian_interleaved
            out_array_type = rocfft_array_type_real
        else
            in_array_type = rocfft_array_type_complex_interleaved
            out_array_type = rocfft_array_type_complex_interleaved
        end
        if ((region...,) == ((1:nrank)...,))
            # handle simple case ... simply! (for robustness)
            rocfft_plan_description_set_data_layout(description, in_array_type, out_array_type,
                                                    C_NULL, C_NULL,
                                                    nrank, C_NULL, 0,
                                                    nrank, C_NULL, 0)
            rocfft_plan_create(handle_ref, placement, xtype, precision, nrank, sz, batch, description)
        else
            strides = [prod(xdims[1:region[k]-1]) for k=1:nrank]
            real_strides = [prod(cdims[1:region[k]-1]) for k=1:nrank]
            if nrank==1 || all(diff(collect(region)) .== 1)
                # _stride: successive elements in dimension of region
                # _dist: distance between first elements of batches
                if region[1] == 1
                    idist = prod(sz)
                    cdist = prod(csz)
                else
                    if region[end] != length(xdims)
                        throw(ArgumentError("batching dims must be sequential"))
                    end
                    idist = 1
                    cdist = 1
                end
                ostrides = copy(strides)
                istrides = copy(strides)
                if xtype == rocfft_transform_type_real_forward
                    odist = cdist
                    ostrides .= real_strides
                else
                    odist = idist
                end
                if xtype == rocfft_transform_type_real_inverse
                    idist = cdist
                    istrides .= real_strides
                end
            else
                if any(diff(collect(region)) .< 1)
                    throw(ArgumentError("region must be an increasing sequence"))
                end

                if region[1] == 1
                    ii=1
                    while (ii < nrank) && (region[ii] == region[ii+1]-1)
                        ii += 1
                    end
                    idist = prod(xdims[1:ii])
                    cdist = prod(cdims[1:ii])
                    ngaps = 0
                else
                    istride = prod(xdims[1:region[1]-1])
                    idist = 1
                    cdist = 1
                    ngaps = 1
                end
                nem = ones(Int,nrank)
                cem = ones(Int,nrank)
                id = 1
                for ii=1:nrank-1
                    if region[ii+1] > region[ii]+1
                        ngaps += 1
                    end
                    while id < region[ii+1]
                        nem[ii] *= xdims[id]
                        cem[ii] *= cdims[id]
                        id += 1
                    end
                    @assert nem[ii] >= sz[ii]
                end
                if region[end] < length(xdims)
                    ngaps += 1
                end
                # CUFFT represents batches by a single stride (_dist)
                # ROCFFT can have multiple strides, but non sequential batch dims are also not working
                # so we must verify that region is consistent with this:
                if ngaps > 1
                    throw(ArgumentError("batch regions must be sequential"))
                end

                ostrides = copy(strides)
                istrides = copy(strides)
                if xtype == rocfft_transform_type_real_forward
                    odist = cdist
                    ostrides .= real_strides
                else
                    odist = idist
                end
                if xtype == rocfft_transform_type_real_inverse
                    idist = cdist
                    istrides .= real_strides
                end
            end
            rocfft_plan_description_set_data_layout(description, in_array_type, out_array_type,
                                                    C_NULL, C_NULL,
                                                    length(istrides), istrides, idist,
                                                    length(ostrides), ostrides, odist)
            rocfft_plan_create(handle_ref, placement, xtype, precision, nrank, sz, batch, description)
            rocfft_plan_description_destroy(description)
        end
    end
    rocfft_plan_get_work_buffer_size(handle_ref[], worksize_ref)
    # TODO allow empty array in ../array.jl
    workarea = worksize_ref[]>0 ? ROCArray{Int8}(undef, (Int(worksize_ref[]),)) : ROCArray{Int8}(undef, (1,))
    return handle_ref[], workarea
end

# promote to a complex floating-point type (out-of-place only),
# so implementations only need Complex{Float} methods
for f in (:fft, :bfft, :ifft)
    pf = Symbol("plan_", f)
    @eval begin
        $f(x::ROCArray{<:Real}, region=1:ndims(x)) = $f(complexfloat(x), region)
        $pf(x::ROCArray{<:Real}, region) = $pf(complexfloat(x), region)
        $f(x::ROCArray{<:Complex{<:Union{Integer,Rational}}}, region=1:ndims(x)) = $f(complexfloat(x), region)
        $pf(x::ROCArray{<:Complex{<:Union{Integer,Rational}}}, region) = $pf(complexfloat(x), region)
    end
end
rfft(x::ROCArray{<:Union{Integer,Rational}}, region=1:ndims(x)) = rfft(realfloat(x), region)
plan_rfft(x::ROCArray{<:Real}, region) = plan_rfft(realfloat(x), region)

# inplace/notinplace complex
for (f,xtype,inplace,forward) in ((:plan_fft!, :rocfft_transform_type_complex_forward, :true, :true),
                          (:plan_bfft!, :rocfft_transform_type_complex_inverse, :true, :false),
                          (:plan_fft, :rocfft_transform_type_complex_forward, :false, :true),
                          (:plan_bfft, :rocfft_transform_type_complex_inverse, :false, :false))
    @eval begin
        function $f(X::ROCArray{T,N}, region) where {T<:rocfftComplexes,N}
            _inplace = $(inplace)
            _xtype = $(xtype)
            K = $(forward)
            pp = create_plan(_xtype, size(X), T, _inplace, region)
            return cROCFFTPlan{T,K,_inplace,N}(pp..., X, size(X), _xtype, region)
        end
    end # eval
end

function plan_rfft(X::ROCArray{T,N}, region) where {T<:rocfftReals,N}
    inplace = false
    xtype = rocfft_transform_type_real_forward
    pp = create_plan(xtype, size(X), T, inplace, region)
    ydims = collect(size(X))
    ydims[region[1]] = div(ydims[region[1]],2) + 1
    return rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}(pp..., X, (ydims...,), xtype, region)
end

function plan_brfft(X::ROCArray{T,N}, d::Integer, region::Any) where {T<:rocfftComplexes,N}
    inplace = false
    xtype = rocfft_transform_type_real_inverse
    ydims = collect(size(X))
    ydims[region[1]] = d
    pp = create_plan(xtype, (ydims...,), T, inplace, region)
    return rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}(pp..., X, (ydims...,), xtype, region)
end

# FIXME: plan_inv methods allocate needlessly (to provide type parameters and normalization function)
# Perhaps use FakeArray types to avoid this.
function plan_inv(p::cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_inverse
    pp = create_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}(pp..., X, p.sz, xtype, p.region),
               normalization(X, p.region))
end

function plan_inv(p::cROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_complex_forward
    pp = create_plan(xtype, p.sz, T, inplace, p.region)
    ScaledPlan(cROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}(pp..., X, p.sz, xtype, p.region),
               normalization(X, p.region))
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_FORWARD,inplace,N}) where {T<:rocfftReals,N,inplace}
    X = ROCArray{complex(T)}(undef, p.osz)
    Y = ROCArray{T}(undef, p.sz)
    xtype = rocfft_transform_type_real_inverse
    pp = create_plan(xtype, p.sz, T, inplace, p.region)
    scale = normalization(Y, p.region)
    ScaledPlan(rROCFFTPlan{complex(T),ROCFFT_INVERSE,inplace,N}(pp..., X, p.sz, xtype, p.region), scale)
end

function plan_inv(p::rROCFFTPlan{T,ROCFFT_INVERSE,inplace,N}) where {T<:rocfftComplexes,N,inplace}
    X = ROCArray{real(T)}(undef, p.osz)
    xtype = rocfft_transform_type_real_forward
    pp = create_plan(xtype, p.osz, T, inplace, p.region)
    scale = normalization(X, p.region)
    ScaledPlan(rROCFFTPlan{real(T),ROCFFT_FORWARD,inplace,N}(pp..., X, p.sz, xtype, p.region), scale)
end

## plan execution

function assert_applicable(p::ROCFFTPlan{T}, X::ROCArray{T}) where T
    (size(X) == p.sz) ||
        throw(ArgumentError("rocFFT plan applied to wrong-size input"))
end

function assert_applicable(p::ROCFFTPlan{T,K}, X::ROCArray{T}, Y::ROCArray{Ty}) where {T,K,Ty}
    assert_applicable(p, X)
    (size(Y) == p.osz) ||
        throw(ArgumentError("RocFFT plan applied to wrong-size output"))
    # type errors should be impossible by dispatch, but just in case:
    if p.xtype == rocfft_transform_type_real_inverse
        (Ty == real(T)) ||
            throw(ArgumentError("Type mismatch for argument Y"))
    elseif p.xtype == rocfft_transform_type_real_forward
        (Ty == complex(T)) ||
            throw(ArgumentError("Type mismatch for argument Y"))
    else
        (Ty == T) ||
            throw(ArgumentError("Type mismatch for argument Y"))
    end
end

function unsafe_execute!(plan::cROCFFTPlan{T,K,true,N}, X::ROCArray{T,N}) where {T,K,N}
    rocfft_execute(plan, [pointer(X),], C_NULL, plan.execution_info)
end

function unsafe_execute!(plan::cROCFFTPlan{T,K,false,N}, X::ROCArray{T,N}, Y::ROCArray{T}) where {T,N,K}
    Xcopy = copy(X) # since input array can also be modified
    rocfft_execute(plan, [pointer(Xcopy),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(plan::rROCFFTPlan{T,ROCFFT_FORWARD,false,N}, X::ROCArray{T,N}, Y::ROCArray{<:rocfftComplexes,N}) where {T<:rocfftReals,N}
    @assert plan.xtype == rocfft_transform_type_real_forward
    Xcopy = copy(X)
    rocfft_execute(plan, [pointer(Xcopy),], [pointer(Y),], plan.execution_info)
end

function unsafe_execute!(plan::rROCFFTPlan{T,ROCFFT_INVERSE,false,N}, X::ROCArray{T,N}, Y::ROCArray{<:rocfftReals,N}) where {T<:rocfftComplexes,N}
    @assert plan.xtype == rocfft_transform_type_real_inverse
    Xcopy = copy(X)
    rocfft_execute(plan, [pointer(Xcopy),], [pointer(Y),], plan.execution_info)
end


function LinearAlgebra.mul!(y::ROCArray{Ty}, p::ROCFFTPlan{T,K,false}, x::ROCArray{T}) where {T,Ty,K}
    assert_applicable(p, x, y)
    unsafe_execute!(p, x, y)
    # 0 is default stream, TODO: make this more scalable
    hipStreamSynchronize(Ptr{Cvoid}(UInt64(0)))
    return y
end

function Base.:(*)(p::cROCFFTPlan{T,K,true,N}, x::ROCArray{T,N}) where {T,K,N}
    assert_applicable(p, x)
    unsafe_execute!(p, x)
    hipStreamSynchronize(Ptr{Cvoid}(UInt64(0)))
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
