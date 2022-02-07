## COV_EXCL_START

# TODO
# - serial version for lower latency
# - group-stride loop to delay need for second kernel launch

# Reduce a value across a group, using local memory for communication
@inline function reduce_group(op, val::T, neutral, ::Val{maxitems}) where {T, maxitems}
    items = workgroupDim().x
    item = workitemIdx().x

    # shared mem for a complete reduction
    shared = ROCDeviceArray((2*maxitems,), alloc_special(Val(:reduce_block), T, Val(AS.Local), Val(2*maxitems)))
    @inbounds shared[item] = val

    # perform a reduction
    d = items>>1
    while d > 0
        sync_workgroup()
        if item <= d
            shared[item] = op(shared[item], shared[item+d])
        end
        d >>= 1
    end

    # load the final value on the first item
    if item == 1
        val = @inbounds shared[item]
    end

    return val
end

Base.@propagate_inbounds _map_getindex(args::Tuple, I) = ((args[1][I]), _map_getindex(Base.tail(args), I)...)
Base.@propagate_inbounds _map_getindex(args::Tuple{Any}, I) = ((args[1][I]),)
Base.@propagate_inbounds _map_getindex(args::Tuple{}, I) = ()

# Reduce an array across the grid. All elements to be processed can be addressed by the
# product of the two iterators `Rreduce` and `Rother`, where the latter iterator will have
# singleton entries for the dimensions that should be reduced (and vice versa).
function partial_mapreduce_device(f, op, neutral, maxitems, Rreduce, Rother, R, As...)
    # decompose the 1D hardware indices into separate ones for reduction (across items
    # and possibly groups if it doesn't fit) and other elements (remaining groups)
    localIdx_reduce = workitemIdx().x
    localDim_reduce = workgroupDim().x
    groupIdx_reduce, groupIdx_other = fldmod1(workgroupIdx().x, length(Rother))
    groupDim_reduce = gridDimWG().x ÷ length(Rother)

    # group-based indexing into the values outside of the reduction dimension
    # (that means we can safely synchronize items within this group)
    iother = groupIdx_other
    @inbounds if iother <= length(Rother)
        Iother = Rother[iother]

        # load the neutral value
        Iout = CartesianIndex(Tuple(Iother)..., groupIdx_reduce)
        neutral = if neutral === nothing
            R[Iout]
        else
            neutral
        end

        val = op(neutral, neutral)

        # reduce serially across chunks of input vector that don't fit in a group
        ireduce = localIdx_reduce + (groupIdx_reduce - 1) * localDim_reduce
        while ireduce <= length(Rreduce)
            Ireduce = Rreduce[ireduce]
            J = Base.max(Iother, Ireduce)
            val = op(val, f(_map_getindex(As, J)...))
            ireduce += localDim_reduce * groupDim_reduce
        end

        val = reduce_group(op, val, neutral, maxitems)

        # write back to memory
        if localIdx_reduce == 1
            R[Iout] = val
        end
    end

    return
end

## COV_EXCL_STOP

function GPUArrays.mapreducedim!(f::F, op::OP, R::ROCArray{T},
                                 A::Union{AbstractArray,Broadcast.Broadcasted};
                                 init=nothing) where {F, OP, T}
    Base.check_reducedims(R, A)
    length(A) == 0 && return R # isempty(::Broadcasted) iterates

    # add singleton dimensions to the output container, if needed
    if ndims(R) < ndims(A)
        dims = Base.fill_to_length(size(R), 1, Val(ndims(A)))
        R = reshape(R, dims)
    end

    # iteration domain, split in two: one part covers the dimensions that should
    # be reduced, and the other covers the rest. combining both covers all values.
    Rall = CartesianIndices(axes(A))
    Rother = CartesianIndices(axes(R))
    Rreduce = CartesianIndices(ifelse.(axes(A) .== axes(R), Ref(Base.OneTo(1)), axes(A)))
    # NOTE: we hard-code `OneTo` (`first.(axes(A))` would work too) or we get a
    #       CartesianIndices object with UnitRanges that behave badly on the GPU.
    @assert length(Rall) == length(Rother) * length(Rreduce)

    # allocate an additional, empty dimension to write the reduced value to.
    # this does not affect the actual location in memory of the final values,
    # but allows us to write a generalized kernel supporting partial reductions.
    R′ = reshape(R, (size(R)..., 1))

    # how many items do we want?
    #
    # items in a group work together to reduce values across the reduction dimensions;
    # we want as many as possible to improve algorithm efficiency and execution occupancy.
    wanted_items = nextpow(2, length(Rreduce))
    function compute_items(max_items)
        if wanted_items > max_items
            prevpow(2, max_items)
        else
            wanted_items
        end
    end

    # how many items can we launch?
    #
    # we might not be able to launch all those items to reduce each slice in one go.
    # that's why each items also loops across their inputs, processing multiple values
    # so that we can span the entire reduction dimension using a single item group.

    # group size is restricted by local memory
    agent = R.buf.agent
    region = first(filter(region->segment_type(region) == HSA.REGION_SEGMENT_GROUP, regions(agent)))
    max_lmem_elements = max_size(region) ÷ sizeof(T)
    isa = first(isas(agent))
    max_items = Base.min(max_group_size(isa), compute_items(max_lmem_elements ÷ 2))
    # TODO: dynamic local memory to avoid two compilations

    #= TODO: let the runtime suggest a group size
    args = (f, op, init, Val(max_items), Rreduce, Rother, R′, A)
    kernel_args = rocconvert.(args)
    kernel_tt = Tuple{Core.Typeof.(kernel_args)...}
    kernel = rocfunction(partial_mapreduce_device, kernel_tt)
    reduce_items = compute_items(suggest_groupsize(kernel.fun, wanted_items).x)
    =#
    reduce_items = max_items

    # how many groups should we launch?
    #
    # even though we can always reduce each slice in a single item group, that may not be
    # optimal as it might not saturate the GPU. we already launch some groups to process
    # independent dimensions in parallel; pad that number to ensure full occupancy.
    other_groups = length(Rother)
    reduce_groups = cld(length(Rreduce), reduce_items)

    # determine the launch configuration
    items = reduce_items
    groups = reduce_groups*other_groups
    gridsize = items*groups

    # perform the actual reduction
    if reduce_groups == 1
        # we can cover the dimensions to reduce using a single group
        wait(@roc gridsize=gridsize groupsize=items partial_mapreduce_device(
            f, op, init, Val(items), Rreduce, Rother, R′, A))
    else
        # we need multiple steps to cover all values to reduce
        partial = similar(R, (size(R)..., reduce_groups))
        if init === nothing
            # without an explicit initializer we need to copy from the output container
            sz = prod(size(R))
            for i in 1:reduce_groups
                # TODO: async copies (or async fill!, but then we'd need to load first)
                #       or maybe just broadcast since that extends singleton dimensions
                copyto!(partial, (i-1)*sz+1, R, 1, sz)
            end
        end
        wait(@roc gridsize=gridsize groupsize=items partial_mapreduce_device(
            f, op, init, Val(items), Rreduce, Rother, partial, A))

        GPUArrays.mapreducedim!(identity, op, R′, partial; init=init)
    end

    return R
end
