function Base.accumulate(op, A::AnyROCArray; dims::Maybe{Integer} = nothing, kw...)
    if dims ≡ nothing && !(A isa AbstractVector)
        return reshape(accumulate(op, A[:]; kw...), size(A))
    end

    nt = values(kw)
    if isempty(kw)
        out = similar(A, Base.promote_op(op, eltype(A), eltype(A)))
    elseif keys(nt) === (:init,)
        out = similar(A, Base.promote_op(op, typeof(nt.init), eltype(A)))
    else
        throw(ArgumentError("accumulate does not support the keyword arguments $(setdiff(keys(nt), (:init,)))"))
    end
    accumulate!(op, out, A; dims, kw...)
end

Base._accumulate!(op, output::AnyROCArray, input::AnyROCVector, dims::Nothing, init::Nothing) =
    scan!(op, output, input; dims=1)

Base._accumulate!(op, output::AnyROCArray, input::AnyROCArray, dims::Integer, init::Nothing) =
    scan!(op, output, input; dims=dims)

Base._accumulate!(op, output::AnyROCArray, input::ROCVector, dims::Nothing, init::Some) =
    scan!(op, output, input; dims=1, init=init)

Base._accumulate!(op, output::AnyROCArray, input::AnyROCArray, dims::Integer, init::Some) =
    scan!(op, output, input; dims=dims, init=init)

Base.accumulate_pairwise!(op, result::AnyROCVector, v::AnyROCVector) = accumulate!(op, result, v)

function scan!(
    f::Function, output::AnyROCArray{T}, input::AnyROCArray;
    dims::Integer, init=nothing, neutral=GPUArrays.neutral_element(f, T),
) where T
    dims > 0 || throw(ArgumentError("`dims`=$dims must be a positive integer."))
    inds_t = axes(input)
    axes(output) == inds_t || throw(DimensionMismatch(
        "Shape of `input`=$(size(input)) must match `output`=$(size(output))."))

    dims > ndims(input) && return copyto!(output, input)
    isempty(inds_t[dims]) && return output

    # iteration domain across the main dimension
    Rdim = CartesianIndices((size(input, dims),))

    # iteration domain for the other dimensions
    Rpre = CartesianIndices(size(input)[1:dims - 1])
    Rpost = CartesianIndices(size(input)[dims + 1:end])
    Rother = CartesianIndices((length(Rpre), length(Rpost)))

    # determine how many threads we can launch for the scan kernel
    kernel = @roc launch=false partial_scan(
        f, output, input, Rdim, Rpre, Rpost, Rother, neutral, init, Val(true))

    # TODO once we can provide functions to Occupancy API, use them.
    max_block_size = 1024
    kernel_config = launch_configuration(
        kernel; shmem=2 * max_block_size * sizeof(T), max_block_size)

    # Determine the grid layout to cover the other dimensions.
    if length(Rother) > 1
        max_other_blocks = Device._max_grid_size.y
        blocks_other = (
            min(length(Rother), max_other_blocks),
            cld(length(Rother), max_other_blocks))
    else
        blocks_other = (1, 1)
    end

    full = nextpow(2, length(Rdim))
    if full ≤ kernel_config.groupsize
        @roc(
            groupsize=full, gridsize=(1, blocks_other...),
            shmem=(2 * full * sizeof(T)), name="scan",
            partial_scan(
                f, output, input, Rdim, Rpre, Rpost, Rother,
                neutral, init, Val(true)))
    else
        # Perform partial scans across the scanning dimension.
        # NOTE: don't set init here to avoid applying the value multiple times.
        partial = prevpow(2, kernel_config.groupsize)
        blocks_dim = cld(length(Rdim), partial)
        @roc(
            groupsize=partial, gridsize=(blocks_dim, blocks_other...),
            shmem=(2 * partial * sizeof(T)), name="scan",
            partial_scan(
                f, output, input, Rdim, Rpre, Rpost, Rother,
                neutral, nothing, Val(true)))

        # Get the total of each thread block (except the first) of the partial scans.
        aggregates = fill(neutral, Base.setindex(size(input), blocks_dim, dims))
        copyto!(aggregates, selectdim(output, dims, partial:partial:length(Rdim)))
        accumulate!(f, aggregates, aggregates; dims)

        # Add those totals to the partial scan result.
        # NOTE:
        #   We assume that this kernel requires fewer resources than
        #   the scan kernel. If that does not hold, launch with fewer threads
        #   and calculate the aggregate block index within the kernel itself.
        @roc(
            groupsize=partial, gridsize=(blocks_dim, blocks_other...),
            aggregate_partial_scan(
                f, output, aggregates, Rdim, Rpre, Rpost, Rother, init))

        unsafe_free!(aggregates)
    end
    return output
end

function partial_scan(
    op::Function, output::AbstractArray{T}, input::AbstractArray,
    Rdim, Rpre, Rpost, Rother, neutral, init, ::Val{inclusive} = Val(true),
) where {T, inclusive}
    threads = workgroupDim().x
    thread = workitemIdx().x

    temp = @ROCDynamicLocalArray(T, 2 * threads, false)

    # Iterate the main dimension using threads and the first block dimension.
    i = (workgroupIdx().x - 0x1) * workgroupDim().x + workitemIdx().x
    # Iterate the other dimensions using the remaining block dimensions.
    j = (workgroupIdx().z - 0x1) * gridGroupDim().y + workgroupIdx().y

    j > length(Rother) && return

    @inbounds begin
        I = Rother[j]
        Ipre = Rpre[I[1]]
        Ipost = Rpost[I[2]]
    end

    # Load input into shared memory (apply `op` to have the correct type).
    @inbounds temp[thread] = if i ≤ length(Rdim)
        op(neutral, input[Ipre, i, Ipost])
    else
        op(neutral, neutral)
    end

    # Build sum in-place up the tree.
    offset = 1
    d = threads >> 1
    while d > 0
        sync_workgroup()
        @inbounds if thread ≤ d
            ai = offset * (2 * thread - 1)
            bi = offset * (2 * thread)
            temp[bi] = op(temp[ai], temp[bi])
        end
        offset *= 2
        d >>= 1
    end

    # Clear the last element.
    @inbounds if thread == 1
        temp[threads] = neutral
    end

    # Traverse down tree & build scan.
    d = 1
    while d < threads
        offset >>= 1
        sync_workgroup()
        @inbounds if thread ≤ d
            ai = offset * (2 * thread - 1)
            bi = offset * (2 * thread)
            t = temp[ai]
            temp[ai] = temp[bi]
            temp[bi] = op(t, temp[bi])
        end
        d *= 2
    end

    sync_workgroup()

    # Write results to device memory.
    @inbounds if i ≤ length(Rdim)
        val = if inclusive
            op(temp[thread], input[Ipre, i, Ipost])
        else
            temp[thread]
        end
        if init ≢ nothing
            val = op(something(init), val)
        end
        output[Ipre, i, Ipost] = val
    end
    return
end

function aggregate_partial_scan(
    op::Function, output::AbstractArray, aggregates::AbstractArray,
    Rdim, Rpre, Rpost, Rother, init,
)
    threads = workgroupDim().x
    thread = workitemIdx().x
    block = workgroupIdx().x

    # Iterate the main dimension using threads and the first block dimension.
    i = (workgroupIdx().x - 0x1) * workgroupDim().x + workitemIdx().x
    # Iterate the other dimensions using the remaining block dimensions.
    j = (workgroupIdx().z - 0x1) * gridGroupDim().y + workgroupIdx().y

    @inbounds if i ≤ length(Rdim) && j ≤ length(Rother)
        I = Rother[j]
        Ipre = Rpre[I[1]]
        Ipost = Rpost[I[2]]

        val = if block > 1
            op(aggregates[Ipre, block-1, Ipost], output[Ipre, i, Ipost])
        else
            output[Ipre, i, Ipost]
        end

        if init !== nothing
            val = op(something(init), val)
        end

        output[Ipre, i, Ipost] = val
    end
    return
end
