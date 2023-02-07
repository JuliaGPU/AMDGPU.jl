const EXIT_ON_MEMORY_FAULT = Ref{Bool}(false)

function fault_handler(ev_ptr::Ptr{AMDGPU.HSA.AMDEvent}, data::Ptr{Cvoid})
    ev = unsafe_load(ev_ptr)
    event_type = ev.event_type
    fault_info = ev.memory_fault
    device = ROCDevice(fault_info.agent)
    addr = fault_info.virtual_address
    reasons = fault_info.fault_reason_mask
    reasons_vec = String[]
    for (name, code) in CEnum.name_value_pairs(AMDGPU.HSA.AMDMemoryFaultReason)
        if reasons | code > 0
            push!(reasons_vec, replace(string(name), "HSA_AMD_MEMORY_FAULT_"=>""))
        end
    end
    reasons_str = "\n$(join(reasons_vec, ", "))"

    do_exit = EXIT_ON_MEMORY_FAULT[]
    if do_exit
        exit_str = "\nJulia will now exit"
    else
        exit_str = "\nGPU kernels are now hung, please restart Julia"
    end

    @error "Memory Fault on $device at $(repr(addr)):$(reasons_str)$(exit_str)"
    if do_exit
        exit(1)
    else
        # TODO: Kill all queues on the device
    end
    return HSA.STATUS_SUCCESS
end

function setup_fault_handler()
    # Use custom fault handler so that `abort` is not called
    fault_handler_cb = @cfunction(fault_handler, HSA.Status, (Ptr{HSA.AMDEvent}, Ptr{Cvoid}))
    @assert AMDGPU.HSA.amd_register_system_event_handler(fault_handler_cb, C_NULL) == HSA.STATUS_SUCCESS
end
