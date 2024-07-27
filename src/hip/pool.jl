mutable struct HIPMemoryPool
    handle::hipMemPool_t

    function HIPMemoryPool(dev::HIPDevice;
        alloc_type::hipMemAllocationType = hipMemAllocationTypePinned,
        handle_type::hipMemAllocationHandleType = hipMemHandleTypeNone,
        max_size::Csize_t = 0,
    )
        location = hipMemLocation(hipMemLocationTypeDevice, device_id(dev))
        props = Ref(hipMemPoolProps(
            alloc_type, handle_type, location,
            C_NULL, max_size, ntuple(i->Cuchar(0), 56)))

        handle_ref = Ref{hipMemPool_t}()
        hipMemPoolCreate(handle_ref, props)
        # No finalizer, since the pool can be active
        # without any references to it.
        return new(handle_ref[])
    end

    global function default_memory_pool(dev::HIPDevice)
        handle_ref = Ref{hipMemPool_t}()
        hipDeviceGetDefaultMemPool(handle_ref, device_id(dev))
        new(handle_ref[])
    end

    global function memory_pool(dev::HIPDevice)
        handle_ref = Ref{hipMemPool_t}()
        hipDeviceGetMemPool(handle_ref, device_id(dev))
        new(handle_ref[])
    end
end

Base.unsafe_convert(::Type{hipMemPool_t}, pool::HIPMemoryPool) = pool.handle
Base.:(==)(a::HIPMemoryPool, b::HIPMemoryPool) = a.handle == b.handle
Base.hash(pool::HIPMemoryPool, h::UInt) = hash(pool.handle, h)

function attribute(X::Type, pool::HIPMemoryPool, attr::hipMemPoolAttr)
    value = Ref{X}()
    hipMemPoolGetAttribute(pool, attr, value)
    value[]
end

function attribute!(pool::HIPMemoryPool, attr::hipMemPoolAttr, value)
    hipMemPoolSetAttribute(pool, attr, Ref(value))
end

function trim(pool::HIPMemoryPool, bytes_to_keep::Integer = 0)
    hipMemPoolTrimTo(pool, bytes_to_keep)
end

function memory_pool!(dev::HIPDevice, pool::HIPMemoryPool)
    hipDeviceSetMemPool(device_id(dev), pool)
end

used_memory(pool::HIPMemoryPool) = attribute(UInt64, pool, hipMemPoolAttrUsedMemCurrent)

reserved_memory(pool::HIPMemoryPool) = attribute(UInt64, pool, hipMemPoolAttrReservedMemCurrent)
