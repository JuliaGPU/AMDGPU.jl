## COV_EXCL_START

# TODO
# - serial version for lower latency
# - group-stride loop to delay need for second kernel launch

# Reduce a value across a group, using local memory for communication
@inline function reduce_group(op, val::T, neutral) where T
    items = workgroupDim().x
    item = workitemIdx().x

    # Shared mem for a complete reduction.
    shared = ROCDeviceArray((items,), Device.alloc_local(:reduce_block, T, 0))
    @inbounds shared[item] = val

    # Perform a reduction.
    d = 1
    while d < items
        sync_workgroup()
        index = 2 * d * (item - 1) + 1
        @inbounds if index ≤ items
            other_val = if (index + d) ≤ items
                shared[index + d]
            else
                neutral
            end
            shared[index] = op(shared[index], other_val)
        end
        d *= 2
    end

    # Load the final value on the first item.
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
function partial_mapreduce_device(f, op, neutral, Rreduce, Rother, R, As...)
    # decompose the 1D hardware indices into separate ones for reduction (across items
    # and possibly groups if it doesn't fit) and other elements (remaining groups)
    localIdx_reduce = workitemIdx().x
    localDim_reduce = workgroupDim().x
    groupIdx_reduce, groupIdx_other = fldmod1(workgroupIdx().x, length(Rother))
    groupDim_reduce = gridGroupDim().x ÷ length(Rother)

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

        val = reduce_group(op, val, neutral)

        # write back to memory
        if localIdx_reduce == 1
            R[Iout] = val
        end
    end

    return
end

## COV_EXCL_STOP

function GPUArrays.mapreducedim!(
    f::F, op::OP, R::AnyROCArray{T},
    A::Union{AbstractArray,Broadcast.Broadcasted}; init=nothing,
) where {F, OP, T}
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
    max_block_size = 256
    compute_shmem(items) = items * sizeof(T)
    max_shmem = max_block_size |> compute_items |> compute_shmem
    @device_code dir="/home/pxl-th/reduce-normal" @roc launch=false partial_mapreduce_device(
        f, op, init, Rreduce, Rother, R′, A)
    exit()

    kernel = @roc launch=false partial_mapreduce_device(
        f, op, init, Rreduce, Rother, R′, A)
    kernel_config = launch_configuration(kernel; shmem=max_shmem, max_block_size)
    reduce_items = compute_items(kernel_config.blockdim)
    reduce_shmem = compute_shmem(reduce_items)

    # how many groups should we launch?
    #
    # even though we can always reduce each slice in a single item group, that may not be
    # optimal as it might not saturate the GPU. we already launch some groups to process
    # independent dimensions in parallel; pad that number to ensure full occupancy.
    other_groups = length(Rother)
    reduce_groups = cld(length(Rreduce), reduce_items)

    # determine the launch configuration
    blocks = reduce_items
    grid = reduce_groups * other_groups

    # perform the actual reduction
    if reduce_groups == 1
        # we can cover the dimensions to reduce using a single group
        # @device_code dir="/home/pxl-th/red-g2" partial_mapreduce_device(
        #     f, op, init, Val(blocks), Rreduce, Rother, R′, A)
        @roc griddim=grid blockdim=blocks shmem=reduce_shmem partial_mapreduce_device(
            f, op, init, Rreduce, Rother, R′, A)
    else
        # we need multiple steps to cover all values to reduce
        partial = similar(R, (size(R)..., reduce_groups))
        if init === nothing
            # without an explicit initializer we need to copy from the output container
            partial .= R
        end
        @roc griddim=grid blockdim=blocks shmem=reduce_shmem partial_mapreduce_device(
            f, op, init, Rreduce, Rother, partial, A)

        GPUArrays.mapreducedim!(identity, op, R′, partial; init=init)
    end

    return R
end
