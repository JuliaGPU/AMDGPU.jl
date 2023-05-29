struct PoolAllocation
    addr::Ptr{Cvoid}
    refs::Threads.Atomic{Int}
end
PoolAllocation(addr) = PoolAllocation(addr, Threads.Atomic{Int}(1))
Base.hash(p::PoolAllocation) = hash(p.addr, hash(PoolAllocation))
Base.isequal(p1::P, p2::P) where P<:PoolAllocation = p1.addr == p2.addr

const ALLOC_POOL_BINNED = IdDict{ROCDevice,Dict{Int,Vector{Ptr{Cvoid}}}}()
const ALLOC_POOL_PTR_BIN_MAP = Dict{Ptr{Cvoid},Int}()
const ALLOC_POOL_SHARED = IdDict{ROCDevice,Dict{UInt64,PoolAllocation}}()
const ALLOC_POOL_LOCK = Threads.SpinLock()
const ALLOC_POOL_MAX_SIZE = Ref{Int}(64)
const ALLOC_POOL_MAX_BINS = 8

const POOLED_ALLOCS = Threads.Atomic{Int64}(0)

function alloc_pooled(device::ROCDevice, key::UInt64, kind::Symbol, bytesize::Integer)
    @assert kind == :kernarg "Pooled non-kernarg allocations not implemented"

    if bytesize == 0
        return C_NULL, false
    end

    # Try to grab from pool
    Base.lock(ALLOC_POOL_LOCK) do
        # Try to grab a shared allocation
        device_dict_shared = get!(()->Dict{UInt64,PoolAllocation}(), ALLOC_POOL_SHARED, device)
        if (alloc = get(device_dict_shared, key, nothing)) !== nothing
            Threads.atomic_add!(alloc.refs, 1)
            return alloc.addr, false
        end
        # Fallback, try to grab a binned (unshared) allocation
        device_dict_binned = get!(ALLOC_POOL_BINNED, device) do
            d = Dict{Int,Vector{Ptr{Cvoid}}}()
            for bin in 1:ALLOC_POOL_MAX_BINS
                d[bin] = Vector{Ptr{Cvoid}}()
            end
            d
        end
        bin_min = ceil(Int, log2(bytesize))
        if bin_min <= ALLOC_POOL_MAX_BINS
            # Find any compatible allocation
            bin = findfirst(bin->bin >= bin_min && length(device_dict_binned[bin]) > 0, bin_min:ALLOC_POOL_MAX_BINS)
            if bin !== nothing
                ptr = pop!(device_dict_binned[bin])
                ALLOC_POOL_PTR_BIN_MAP[ptr] = bin
                return ptr, true
            end
        end

        # No available allocations to grab, make a new one
        Base.unlock(ALLOC_POOL_LOCK)

        if bin_min <= ALLOC_POOL_MAX_BINS
            # Round-up bytesize to allow reuse in bins
            bytesize = 2^bin_min
        end

        # N.B. We use the region API because kernarg allocations don't
        # show up in the memory pools API
        kernarg_region = Runtime.get_region(device, :kernarg)
        kernarg_address = Ref{Ptr{Nothing}}(Ptr{Nothing}(0))
        allo_or_retry!() do
            HSA.memory_allocate(kernarg_region.region, bytesize, kernarg_address)
        end
        Threads.atomic_add!(POOLED_ALLOCS, Int64(bytesize))

        Base.lock(ALLOC_POOL_LOCK)

        # Try to share this allocation
        if length(device_dict_shared) < ALLOC_POOL_MAX_SIZE[]
            device_dict_shared[key] = PoolAllocation(kernarg_address[])
        end

        return kernarg_address[], true
    end
end

function free_pooled(device::ROCDevice, key::UInt64, kind::Symbol, ptr::Ptr{Cvoid})
    # Return to pool
    Runtime.@spinlock ALLOC_POOL_LOCK begin
        # Check if this pointer is a shared allocation
        device_dict_shared = get!(()->Dict{UInt64,PoolAllocation}(), ALLOC_POOL_SHARED, device)
        if (alloc = get(device_dict_shared, key, nothing)) !== nothing
            if Threads.atomic_sub!(alloc.refs, 1) == 1
                # TODO: Don't delete unless we're out of space
                delete!(device_dict_shared, key)
                # TODO: Consider putting into a bin if power-of-two bytesize
                check(HSA.memory_free(ptr))
            end
            return
        end
        # Check if this pointer is a binned allocation
        if !haskey(ALLOC_POOL_PTR_BIN_MAP, ptr)
            # Not binned or shared
            check(HSA.memory_free(ptr))
            return
        end
        bin = ALLOC_POOL_PTR_BIN_MAP[ptr]
        allocs = ALLOC_POOL_BINNED[device][bin]
        if length(allocs) < ALLOC_POOL_MAX_SIZE[]
            # Save for later
            push!(allocs, ptr)
        else
            # No free space
            check(HSA.memory_free(ptr))
        end
        return
    end
end
