function alloc_or_retry!(f, isfailed; stream::HIP.HIPStream)
    res = f()
    isfailed(res) || return res

    phase = 1
    while true
        if phase == 1
            HIP.synchronize(stream)
        elseif phase == 2
            HIP.device_synchronize()
        elseif phase == 3
            GC.gc(false)
            HIP.device_synchronize()
        elseif phase == 4
            GC.gc(true)
            HIP.device_synchronize()
        elseif phase == 5
            HIP.trim(HIP.memory_pool(stream.device))
        else
            break
        end
        phase += 1

        res = f()
        isfailed(res) || break
    end

    if isfailed(res)
        pool = HIP.memory_pool(stream.device)
        error("""
        Failed to successfully execute function and free resources for it.
        Reporting current memory usage:
        - HIP pool used: $(Base.format_bytes(HIP.used_memory(pool))).
        - HIP pool reserved: $(Base.format_bytes(HIP.reserved_memory(pool))).
        - Hard memory limit: $(Base.format_bytes(AMDGPU.hard_memory_limit())).
        """)
    end
    return res
end
