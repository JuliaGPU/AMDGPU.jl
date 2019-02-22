# Julia wrapper for header: /home/jpsamaroo/AMDGPURuntime/ext/include/hsa/hsa.h
# Automatically generated using Clang.jl wrap_c


function hsa_status_string(status, status_string)
    ccall((:hsa_status_string, "libhsa-runtime64"), hsa_status_t, (hsa_status_t, Ptr{Cstring}), status, status_string)
end

function hsa_init()
    ccall((:hsa_init, "libhsa-runtime64"), hsa_status_t, ())
end

function hsa_shut_down()
    ccall((:hsa_shut_down, "libhsa-runtime64"), hsa_status_t, ())
end

function hsa_system_get_info(attribute, value)
    ccall((:hsa_system_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_system_info_t, Ptr{Cvoid}), attribute, value)
end

function hsa_extension_get_name(extension, name)
    ccall((:hsa_extension_get_name, "libhsa-runtime64"), hsa_status_t, (UInt16, Ptr{Cstring}), extension, name)
end

function hsa_system_extension_supported(extension, version_major, version_minor, result)
    ccall((:hsa_system_extension_supported, "libhsa-runtime64"), hsa_status_t, (UInt16, UInt16, UInt16, Ptr{Bool}), extension, version_major, version_minor, result)
end

function hsa_system_major_extension_supported(extension, version_major, version_minor, result)
    ccall((:hsa_system_major_extension_supported, "libhsa-runtime64"), hsa_status_t, (UInt16, UInt16, Ptr{UInt16}, Ptr{Bool}), extension, version_major, version_minor, result)
end

function hsa_system_get_extension_table(extension, version_major, version_minor, table)
    ccall((:hsa_system_get_extension_table, "libhsa-runtime64"), hsa_status_t, (UInt16, UInt16, UInt16, Ptr{Cvoid}), extension, version_major, version_minor, table)
end

function hsa_system_get_major_extension_table(extension, version_major, table_length, table)
    ccall((:hsa_system_get_major_extension_table, "libhsa-runtime64"), hsa_status_t, (UInt16, UInt16, Csize_t, Ptr{Cvoid}), extension, version_major, table_length, table)
end

function hsa_agent_get_info(agent, attribute, value)
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ptr{Cvoid}), agent, attribute, value)
end

function hsa_iterate_agents(callback, data)
    ccall((:hsa_iterate_agents, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), callback, data)
end

function hsa_agent_get_exception_policies(agent, profile, mask)
    ccall((:hsa_agent_get_exception_policies, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_profile_t, Ptr{UInt16}), agent, profile, mask)
end

function hsa_cache_get_info(cache, attribute, value)
    ccall((:hsa_cache_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_cache_t, hsa_cache_info_t, Ptr{Cvoid}), cache, attribute, value)
end

function hsa_agent_iterate_caches(agent, callback, data)
    ccall((:hsa_agent_iterate_caches, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_agent_extension_supported(extension, agent, version_major, version_minor, result)
    ccall((:hsa_agent_extension_supported, "libhsa-runtime64"), hsa_status_t, (UInt16, hsa_agent_t, UInt16, UInt16, Ptr{Bool}), extension, agent, version_major, version_minor, result)
end

function hsa_agent_major_extension_supported(extension, agent, version_major, version_minor, result)
    ccall((:hsa_agent_major_extension_supported, "libhsa-runtime64"), hsa_status_t, (UInt16, hsa_agent_t, UInt16, Ptr{UInt16}, Ptr{Bool}), extension, agent, version_major, version_minor, result)
end

function hsa_signal_create(initial_value, num_consumers, consumers, signal)
    ccall((:hsa_signal_create, "libhsa-runtime64"), hsa_status_t, (hsa_signal_value_t, UInt32, Ptr{hsa_agent_t}, Ptr{hsa_signal_t}), initial_value, num_consumers, consumers, signal)
end

function hsa_signal_destroy(signal)
    ccall((:hsa_signal_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_scacquire(signal)
    ccall((:hsa_signal_load_scacquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_relaxed(signal)
    ccall((:hsa_signal_load_relaxed, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_acquire(signal)
    ccall((:hsa_signal_load_acquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_store_relaxed(signal, value)
    ccall((:hsa_signal_store_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_store_screlease(signal, value)
    ccall((:hsa_signal_store_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_store_release(signal, value)
    ccall((:hsa_signal_store_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_silent_store_relaxed(signal, value)
    ccall((:hsa_signal_silent_store_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_silent_store_screlease(signal, value)
    ccall((:hsa_signal_silent_store_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_scacq_screl(signal, value)
    ccall((:hsa_signal_exchange_scacq_screl, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_acq_rel(signal, value)
    ccall((:hsa_signal_exchange_acq_rel, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_scacquire(signal, value)
    ccall((:hsa_signal_exchange_scacquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_acquire(signal, value)
    ccall((:hsa_signal_exchange_acquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_relaxed(signal, value)
    ccall((:hsa_signal_exchange_relaxed, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_screlease(signal, value)
    ccall((:hsa_signal_exchange_screlease, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_release(signal, value)
    ccall((:hsa_signal_exchange_release, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_cas_scacq_screl(signal, expected, value)
    ccall((:hsa_signal_cas_scacq_screl, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_acq_rel(signal, expected, value)
    ccall((:hsa_signal_cas_acq_rel, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_scacquire(signal, expected, value)
    ccall((:hsa_signal_cas_scacquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_acquire(signal, expected, value)
    ccall((:hsa_signal_cas_acquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_relaxed(signal, expected, value)
    ccall((:hsa_signal_cas_relaxed, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_screlease(signal, expected, value)
    ccall((:hsa_signal_cas_screlease, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_release(signal, expected, value)
    ccall((:hsa_signal_cas_release, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_add_scacq_screl(signal, value)
    ccall((:hsa_signal_add_scacq_screl, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_acq_rel(signal, value)
    ccall((:hsa_signal_add_acq_rel, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_scacquire(signal, value)
    ccall((:hsa_signal_add_scacquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_acquire(signal, value)
    ccall((:hsa_signal_add_acquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_relaxed(signal, value)
    ccall((:hsa_signal_add_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_screlease(signal, value)
    ccall((:hsa_signal_add_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_release(signal, value)
    ccall((:hsa_signal_add_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_scacq_screl(signal, value)
    ccall((:hsa_signal_subtract_scacq_screl, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_acq_rel(signal, value)
    ccall((:hsa_signal_subtract_acq_rel, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_scacquire(signal, value)
    ccall((:hsa_signal_subtract_scacquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_acquire(signal, value)
    ccall((:hsa_signal_subtract_acquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_relaxed(signal, value)
    ccall((:hsa_signal_subtract_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_screlease(signal, value)
    ccall((:hsa_signal_subtract_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_release(signal, value)
    ccall((:hsa_signal_subtract_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_scacq_screl(signal, value)
    ccall((:hsa_signal_and_scacq_screl, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_acq_rel(signal, value)
    ccall((:hsa_signal_and_acq_rel, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_scacquire(signal, value)
    ccall((:hsa_signal_and_scacquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_acquire(signal, value)
    ccall((:hsa_signal_and_acquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_relaxed(signal, value)
    ccall((:hsa_signal_and_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_screlease(signal, value)
    ccall((:hsa_signal_and_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_release(signal, value)
    ccall((:hsa_signal_and_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_scacq_screl(signal, value)
    ccall((:hsa_signal_or_scacq_screl, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_acq_rel(signal, value)
    ccall((:hsa_signal_or_acq_rel, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_scacquire(signal, value)
    ccall((:hsa_signal_or_scacquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_acquire(signal, value)
    ccall((:hsa_signal_or_acquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_relaxed(signal, value)
    ccall((:hsa_signal_or_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_screlease(signal, value)
    ccall((:hsa_signal_or_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_release(signal, value)
    ccall((:hsa_signal_or_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_scacq_screl(signal, value)
    ccall((:hsa_signal_xor_scacq_screl, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_acq_rel(signal, value)
    ccall((:hsa_signal_xor_acq_rel, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_scacquire(signal, value)
    ccall((:hsa_signal_xor_scacquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_acquire(signal, value)
    ccall((:hsa_signal_xor_acquire, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_relaxed(signal, value)
    ccall((:hsa_signal_xor_relaxed, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_screlease(signal, value)
    ccall((:hsa_signal_xor_screlease, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_release(signal, value)
    ccall((:hsa_signal_xor_release, "libhsa-runtime64"), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_wait_scacquire(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_scacquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function hsa_signal_wait_relaxed(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_relaxed, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function hsa_signal_wait_acquire(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_acquire, "libhsa-runtime64"), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function hsa_signal_group_create(num_signals, signals, num_consumers, consumers, signal_group)
    ccall((:hsa_signal_group_create, "libhsa-runtime64"), hsa_status_t, (UInt32, Ptr{hsa_signal_t}, UInt32, Ptr{hsa_agent_t}, Ptr{hsa_signal_group_t}), num_signals, signals, num_consumers, consumers, signal_group)
end

function hsa_signal_group_destroy(signal_group)
    ccall((:hsa_signal_group_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_signal_group_t,), signal_group)
end

function hsa_signal_group_wait_any_scacquire(signal_group, conditions, compare_values, wait_state_hint, signal, value)
    ccall((:hsa_signal_group_wait_any_scacquire, "libhsa-runtime64"), hsa_status_t, (hsa_signal_group_t, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, hsa_wait_state_t, Ptr{hsa_signal_t}, Ptr{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function hsa_signal_group_wait_any_relaxed(signal_group, conditions, compare_values, wait_state_hint, signal, value)
    ccall((:hsa_signal_group_wait_any_relaxed, "libhsa-runtime64"), hsa_status_t, (hsa_signal_group_t, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, hsa_wait_state_t, Ptr{hsa_signal_t}, Ptr{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function hsa_queue_create(agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
    ccall((:hsa_queue_create, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, UInt32, hsa_queue_type32_t, Ptr{Cvoid}, Ptr{Cvoid}, UInt32, UInt32, Ptr{Ptr{hsa_queue_t}}), agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function hsa_soft_queue_create(region, size, type, features, doorbell_signal, queue)
    ccall((:hsa_soft_queue_create, "libhsa-runtime64"), hsa_status_t, (hsa_region_t, UInt32, hsa_queue_type32_t, UInt32, hsa_signal_t, Ptr{Ptr{hsa_queue_t}}), region, size, type, features, doorbell_signal, queue)
end

function hsa_queue_destroy(queue)
    ccall((:hsa_queue_destroy, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_inactivate(queue)
    ccall((:hsa_queue_inactivate, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_acquire(queue)
    ccall((:hsa_queue_load_read_index_acquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_scacquire(queue)
    ccall((:hsa_queue_load_read_index_scacquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_relaxed(queue)
    ccall((:hsa_queue_load_read_index_relaxed, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_acquire(queue)
    ccall((:hsa_queue_load_write_index_acquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_scacquire(queue)
    ccall((:hsa_queue_load_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_relaxed(queue)
    ccall((:hsa_queue_load_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_store_write_index_relaxed(queue, value)
    ccall((:hsa_queue_store_write_index_relaxed, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_write_index_release(queue, value)
    ccall((:hsa_queue_store_write_index_release, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_write_index_screlease(queue, value)
    ccall((:hsa_queue_store_write_index_screlease, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_cas_write_index_acq_rel(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_acq_rel, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_scacq_screl(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_scacq_screl, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_acquire(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_acquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_scacquire(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_relaxed(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_release(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_release, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_screlease(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_screlease, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_add_write_index_acq_rel(queue, value)
    ccall((:hsa_queue_add_write_index_acq_rel, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_scacq_screl(queue, value)
    ccall((:hsa_queue_add_write_index_scacq_screl, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_acquire(queue, value)
    ccall((:hsa_queue_add_write_index_acquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_scacquire(queue, value)
    ccall((:hsa_queue_add_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_relaxed(queue, value)
    ccall((:hsa_queue_add_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_release(queue, value)
    ccall((:hsa_queue_add_write_index_release, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_screlease(queue, value)
    ccall((:hsa_queue_add_write_index_screlease, "libhsa-runtime64"), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_relaxed(queue, value)
    ccall((:hsa_queue_store_read_index_relaxed, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_release(queue, value)
    ccall((:hsa_queue_store_read_index_release, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_screlease(queue, value)
    ccall((:hsa_queue_store_read_index_screlease, "libhsa-runtime64"), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_region_get_info(region, attribute, value)
    ccall((:hsa_region_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_region_t, hsa_region_info_t, Ptr{Cvoid}), region, attribute, value)
end

function hsa_agent_iterate_regions(agent, callback, data)
    ccall((:hsa_agent_iterate_regions, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_memory_allocate(region, size, ptr)
    ccall((:hsa_memory_allocate, "libhsa-runtime64"), hsa_status_t, (hsa_region_t, Csize_t, Ptr{Ptr{Cvoid}}), region, size, ptr)
end

function hsa_memory_free(ptr)
    ccall((:hsa_memory_free, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid},), ptr)
end

function hsa_memory_copy(dst, src, size)
    ccall((:hsa_memory_copy, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), dst, src, size)
end

function hsa_memory_assign_agent(ptr, agent, access)
    ccall((:hsa_memory_assign_agent, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, hsa_agent_t, hsa_access_permission_t), ptr, agent, access)
end

function hsa_memory_register(ptr, size)
    ccall((:hsa_memory_register, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t), ptr, size)
end

function hsa_memory_deregister(ptr, size)
    ccall((:hsa_memory_deregister, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t), ptr, size)
end

function hsa_isa_from_name(name, isa)
    ccall((:hsa_isa_from_name, "libhsa-runtime64"), hsa_status_t, (Cstring, Ptr{hsa_isa_t}), name, isa)
end

function hsa_agent_iterate_isas(agent, callback, data)
    ccall((:hsa_agent_iterate_isas, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_isa_get_info(isa, attribute, index, value)
    ccall((:hsa_isa_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, UInt32, Ptr{Cvoid}), isa, attribute, index, value)
end

function hsa_isa_get_info_alt(isa, attribute, value)
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, Ptr{Cvoid}), isa, attribute, value)
end

function hsa_isa_get_exception_policies(isa, profile, mask)
    ccall((:hsa_isa_get_exception_policies, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_profile_t, Ptr{UInt16}), isa, profile, mask)
end

function hsa_isa_get_round_method(isa, fp_type, flush_mode, round_method)
    ccall((:hsa_isa_get_round_method, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_fp_type_t, hsa_flush_mode_t, Ptr{hsa_round_method_t}), isa, fp_type, flush_mode, round_method)
end

function hsa_wavefront_get_info(wavefront, attribute, value)
    ccall((:hsa_wavefront_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_wavefront_t, hsa_wavefront_info_t, Ptr{Cvoid}), wavefront, attribute, value)
end

function hsa_isa_iterate_wavefronts(isa, callback, data)
    ccall((:hsa_isa_iterate_wavefronts, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, Ptr{Cvoid}, Ptr{Cvoid}), isa, callback, data)
end

function hsa_isa_compatible(code_object_isa, agent_isa, result)
    ccall((:hsa_isa_compatible, "libhsa-runtime64"), hsa_status_t, (hsa_isa_t, hsa_isa_t, Ptr{Bool}), code_object_isa, agent_isa, result)
end

function hsa_code_object_reader_create_from_file(file, code_object_reader)
    ccall((:hsa_code_object_reader_create_from_file, "libhsa-runtime64"), hsa_status_t, (hsa_file_t, Ptr{hsa_code_object_reader_t}), file, code_object_reader)
end

function hsa_code_object_reader_create_from_memory(code_object, size, code_object_reader)
    ccall((:hsa_code_object_reader_create_from_memory, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_code_object_reader_t}), code_object, size, code_object_reader)
end

function hsa_code_object_reader_destroy(code_object_reader)
    ccall((:hsa_code_object_reader_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_reader_t,), code_object_reader)
end

function hsa_executable_create(profile, executable_state, options, executable)
    ccall((:hsa_executable_create, "libhsa-runtime64"), hsa_status_t, (hsa_profile_t, hsa_executable_state_t, Cstring, Ptr{hsa_executable_t}), profile, executable_state, options, executable)
end

function hsa_executable_create_alt(profile, default_float_rounding_mode, options, executable)
    ccall((:hsa_executable_create_alt, "libhsa-runtime64"), hsa_status_t, (hsa_profile_t, hsa_default_float_rounding_mode_t, Cstring, Ptr{hsa_executable_t}), profile, default_float_rounding_mode, options, executable)
end

function hsa_executable_destroy(executable)
    ccall((:hsa_executable_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t,), executable)
end

function hsa_executable_load_program_code_object(executable, code_object_reader, options, loaded_code_object)
    ccall((:hsa_executable_load_program_code_object, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_code_object_reader_t, Cstring, Ptr{hsa_loaded_code_object_t}), executable, code_object_reader, options, loaded_code_object)
end

function hsa_executable_load_agent_code_object(executable, agent, code_object_reader, options, loaded_code_object)
    ccall((:hsa_executable_load_agent_code_object, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_reader_t, Cstring, Ptr{hsa_loaded_code_object_t}), executable, agent, code_object_reader, options, loaded_code_object)
end

function hsa_executable_freeze(executable, options)
    ccall((:hsa_executable_freeze, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Cstring), executable, options)
end

function hsa_executable_get_info(executable, attribute, value)
    ccall((:hsa_executable_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_executable_info_t, Ptr{Cvoid}), executable, attribute, value)
end

function hsa_executable_global_variable_define(executable, variable_name, address)
    ccall((:hsa_executable_global_variable_define, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Cstring, Ptr{Cvoid}), executable, variable_name, address)
end

function hsa_executable_agent_global_variable_define(executable, agent, variable_name, address)
    ccall((:hsa_executable_agent_global_variable_define, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_agent_t, Cstring, Ptr{Cvoid}), executable, agent, variable_name, address)
end

function hsa_executable_readonly_variable_define(executable, agent, variable_name, address)
    ccall((:hsa_executable_readonly_variable_define, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_agent_t, Cstring, Ptr{Cvoid}), executable, agent, variable_name, address)
end

function hsa_executable_validate(executable, result)
    ccall((:hsa_executable_validate, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Ptr{UInt32}), executable, result)
end

function hsa_executable_validate_alt(executable, options, result)
    ccall((:hsa_executable_validate_alt, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Cstring, Ptr{UInt32}), executable, options, result)
end

function hsa_executable_get_symbol(executable, module_name, symbol_name, agent, call_convention, symbol)
    ccall((:hsa_executable_get_symbol, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Cstring, Cstring, hsa_agent_t, Int32, Ptr{hsa_executable_symbol_t}), executable, module_name, symbol_name, agent, call_convention, symbol)
end

function hsa_executable_get_symbol_by_name(executable, symbol_name, agent, symbol)
    ccall((:hsa_executable_get_symbol_by_name, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Cstring, Ptr{hsa_agent_t}, Ptr{hsa_executable_symbol_t}), executable, symbol_name, agent, symbol)
end

function hsa_executable_symbol_get_info(executable_symbol, attribute, value)
    ccall((:hsa_executable_symbol_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_executable_symbol_t, hsa_executable_symbol_info_t, Ptr{Cvoid}), executable_symbol, attribute, value)
end

function hsa_executable_iterate_symbols(executable, callback, data)
    ccall((:hsa_executable_iterate_symbols, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, callback, data)
end

function hsa_executable_iterate_agent_symbols(executable, agent, callback, data)
    ccall((:hsa_executable_iterate_agent_symbols, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, agent, callback, data)
end

function hsa_executable_iterate_program_symbols(executable, callback, data)
    ccall((:hsa_executable_iterate_program_symbols, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, callback, data)
end

function hsa_code_object_serialize(code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
    ccall((:hsa_code_object_serialize, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t, Ptr{Cvoid}, hsa_callback_data_t, Cstring, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}), code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
end

function hsa_code_object_deserialize(serialized_code_object, serialized_code_object_size, options, code_object)
    ccall((:hsa_code_object_deserialize, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t, Cstring, Ptr{hsa_code_object_t}), serialized_code_object, serialized_code_object_size, options, code_object)
end

function hsa_code_object_destroy(code_object)
    ccall((:hsa_code_object_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t,), code_object)
end

function hsa_code_object_get_info(code_object, attribute, value)
    ccall((:hsa_code_object_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t, hsa_code_object_info_t, Ptr{Cvoid}), code_object, attribute, value)
end

function hsa_executable_load_code_object(executable, agent, code_object, options)
    ccall((:hsa_executable_load_code_object, "libhsa-runtime64"), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_t, Cstring), executable, agent, code_object, options)
end

function hsa_code_object_get_symbol(code_object, symbol_name, symbol)
    ccall((:hsa_code_object_get_symbol, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t, Cstring, Ptr{hsa_code_symbol_t}), code_object, symbol_name, symbol)
end

function hsa_code_object_get_symbol_from_name(code_object, module_name, symbol_name, symbol)
    ccall((:hsa_code_object_get_symbol_from_name, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t, Cstring, Cstring, Ptr{hsa_code_symbol_t}), code_object, module_name, symbol_name, symbol)
end

function hsa_code_symbol_get_info(code_symbol, attribute, value)
    ccall((:hsa_code_symbol_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_code_symbol_t, hsa_code_symbol_info_t, Ptr{Cvoid}), code_symbol, attribute, value)
end

function hsa_code_object_iterate_symbols(code_object, callback, data)
    ccall((:hsa_code_object_iterate_symbols, "libhsa-runtime64"), hsa_status_t, (hsa_code_object_t, Ptr{Cvoid}, Ptr{Cvoid}), code_object, callback, data)
end
# Julia wrapper for header: /home/jpsamaroo/AMDGPURuntime/ext/include/hsa/hsa_ext_amd.h
# Automatically generated using Clang.jl wrap_c


function hsa_amd_coherency_get_type(agent, type)
    ccall((:hsa_amd_coherency_get_type, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_amd_coherency_type_t}), agent, type)
end

function hsa_amd_coherency_set_type(agent, type)
    ccall((:hsa_amd_coherency_set_type, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_amd_coherency_type_t), agent, type)
end

function hsa_amd_profiling_set_profiler_enabled(queue, enable)
    ccall((:hsa_amd_profiling_set_profiler_enabled, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_queue_t}, Cint), queue, enable)
end

function hsa_amd_profiling_async_copy_enable(enable)
    ccall((:hsa_amd_profiling_async_copy_enable, "libhsa-runtime64"), hsa_status_t, (Bool,), enable)
end

function hsa_amd_profiling_get_dispatch_time(agent, signal, time)
    ccall((:hsa_amd_profiling_get_dispatch_time, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_signal_t, Ptr{hsa_amd_profiling_dispatch_time_t}), agent, signal, time)
end

function hsa_amd_profiling_get_async_copy_time(signal, time)
    ccall((:hsa_amd_profiling_get_async_copy_time, "libhsa-runtime64"), hsa_status_t, (hsa_signal_t, Ptr{hsa_amd_profiling_async_copy_time_t}), signal, time)
end

function hsa_amd_profiling_convert_tick_to_system_domain(agent, agent_tick, system_tick)
    ccall((:hsa_amd_profiling_convert_tick_to_system_domain, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, UInt64, Ptr{UInt64}), agent, agent_tick, system_tick)
end

function hsa_amd_signal_create(initial_value, num_consumers, consumers, attributes, signal)
    ccall((:hsa_amd_signal_create, "libhsa-runtime64"), hsa_status_t, (hsa_signal_value_t, UInt32, Ptr{hsa_agent_t}, UInt64, Ptr{hsa_signal_t}), initial_value, num_consumers, consumers, attributes, signal)
end

function hsa_amd_signal_async_handler(signal, cond, value, handler, arg)
    ccall((:hsa_amd_signal_async_handler, "libhsa-runtime64"), hsa_status_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, hsa_amd_signal_handler, Ptr{Cvoid}), signal, cond, value, handler, arg)
end

function hsa_amd_async_function(callback, arg)
    ccall((:hsa_amd_async_function, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), callback, arg)
end

function hsa_amd_signal_wait_any(signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
    ccall((:hsa_amd_signal_wait_any, "libhsa-runtime64"), UInt32, (UInt32, Ptr{hsa_signal_t}, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, UInt64, hsa_wait_state_t, Ptr{hsa_signal_value_t}), signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
end

function hsa_amd_image_get_info_max_dim(agent, attribute, value)
    ccall((:hsa_amd_image_get_info_max_dim, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ptr{Cvoid}), agent, attribute, value)
end

function hsa_amd_queue_cu_set_mask(queue, num_cu_mask_count, cu_mask)
    ccall((:hsa_amd_queue_cu_set_mask, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_queue_t}, UInt32, Ptr{UInt32}), queue, num_cu_mask_count, cu_mask)
end

function hsa_amd_memory_pool_get_info(memory_pool, attribute, value)
    ccall((:hsa_amd_memory_pool_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_info_t, Ptr{Cvoid}), memory_pool, attribute, value)
end

function hsa_amd_agent_iterate_memory_pools(agent, callback, data)
    ccall((:hsa_amd_agent_iterate_memory_pools, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_amd_memory_pool_allocate(memory_pool, size, flags, ptr)
    ccall((:hsa_amd_memory_pool_allocate, "libhsa-runtime64"), hsa_status_t, (hsa_amd_memory_pool_t, Csize_t, UInt32, Ptr{Ptr{Cvoid}}), memory_pool, size, flags, ptr)
end

function hsa_amd_memory_pool_free(ptr)
    ccall((:hsa_amd_memory_pool_free, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid},), ptr)
end

function hsa_amd_memory_async_copy(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
    ccall((:hsa_amd_memory_async_copy, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, hsa_agent_t, Ptr{Cvoid}, hsa_agent_t, Csize_t, UInt32, Ptr{hsa_signal_t}, hsa_signal_t), dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
end

function hsa_amd_agent_memory_pool_get_info(agent, memory_pool, attribute, value)
    ccall((:hsa_amd_agent_memory_pool_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_amd_memory_pool_t, hsa_amd_agent_memory_pool_info_t, Ptr{Cvoid}), agent, memory_pool, attribute, value)
end

function hsa_amd_agents_allow_access(num_agents, agents, flags, ptr)
    ccall((:hsa_amd_agents_allow_access, "libhsa-runtime64"), hsa_status_t, (UInt32, Ptr{hsa_agent_t}, Ptr{UInt32}, Ptr{Cvoid}), num_agents, agents, flags, ptr)
end

function hsa_amd_memory_pool_can_migrate(src_memory_pool, dst_memory_pool, result)
    ccall((:hsa_amd_memory_pool_can_migrate, "libhsa-runtime64"), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_t, Ptr{Bool}), src_memory_pool, dst_memory_pool, result)
end

function hsa_amd_memory_migrate(ptr, memory_pool, flags)
    ccall((:hsa_amd_memory_migrate, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, hsa_amd_memory_pool_t, UInt32), ptr, memory_pool, flags)
end

function hsa_amd_memory_lock(host_ptr, size, agents, num_agent, agent_ptr)
    ccall((:hsa_amd_memory_lock, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_agent_t}, Cint, Ptr{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, agent_ptr)
end

function hsa_amd_memory_unlock(host_ptr)
    ccall((:hsa_amd_memory_unlock, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid},), host_ptr)
end

function hsa_amd_memory_fill(ptr, value, count)
    ccall((:hsa_amd_memory_fill, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, UInt32, Csize_t), ptr, value, count)
end

function hsa_amd_interop_map_buffer(num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
    ccall((:hsa_amd_interop_map_buffer, "libhsa-runtime64"), hsa_status_t, (UInt32, Ptr{hsa_agent_t}, Cint, UInt32, Ptr{Csize_t}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}, Ptr{Ptr{Cvoid}}), num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
end

function hsa_amd_interop_unmap_buffer(ptr)
    ccall((:hsa_amd_interop_unmap_buffer, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid},), ptr)
end

function hsa_amd_image_create(agent, image_descriptor, image_layout, image_data, access_permission, image)
    ccall((:hsa_amd_image_create, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{hsa_amd_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_layout, image_data, access_permission, image)
end

function hsa_amd_pointer_info(ptr, info, alloc, num_agents_accessible, accessible)
    ccall((:hsa_amd_pointer_info, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Ptr{hsa_amd_pointer_info_t}, Ptr{Cvoid}, Ptr{UInt32}, Ptr{Ptr{hsa_agent_t}}), ptr, info, alloc, num_agents_accessible, accessible)
end

function hsa_amd_pointer_info_set_userdata(ptr, userdata)
    ccall((:hsa_amd_pointer_info_set_userdata, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), ptr, userdata)
end

function hsa_amd_ipc_memory_create(ptr, len, handle)
    ccall((:hsa_amd_ipc_memory_create, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_amd_ipc_memory_t}), ptr, len, handle)
end

function hsa_amd_ipc_memory_attach(handle, len, num_agents, mapping_agents, mapped_ptr)
    ccall((:hsa_amd_ipc_memory_attach, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_amd_ipc_memory_t}, Csize_t, UInt32, Ptr{hsa_agent_t}, Ptr{Ptr{Cvoid}}), handle, len, num_agents, mapping_agents, mapped_ptr)
end

function hsa_amd_ipc_memory_detach(mapped_ptr)
    ccall((:hsa_amd_ipc_memory_detach, "libhsa-runtime64"), hsa_status_t, (Ptr{Cvoid},), mapped_ptr)
end

function hsa_amd_ipc_signal_create(signal, handle)
    ccall((:hsa_amd_ipc_signal_create, "libhsa-runtime64"), hsa_status_t, (hsa_signal_t, Ptr{hsa_amd_ipc_signal_t}), signal, handle)
end

function hsa_amd_ipc_signal_attach(handle, signal)
    ccall((:hsa_amd_ipc_signal_attach, "libhsa-runtime64"), hsa_status_t, (Ptr{hsa_amd_ipc_signal_t}, Ptr{hsa_signal_t}), handle, signal)
end
# Julia wrapper for header: /home/jpsamaroo/AMDGPURuntime/ext/include/hsa/hsa_ext_finalize.h
# Automatically generated using Clang.jl wrap_c


function hsa_ext_program_create(machine_model, profile, default_float_rounding_mode, options, program)
    ccall((:hsa_ext_program_create, "libhsa-runtime64"), hsa_status_t, (hsa_machine_model_t, hsa_profile_t, hsa_default_float_rounding_mode_t, Cstring, Ptr{hsa_ext_program_t}), machine_model, profile, default_float_rounding_mode, options, program)
end

function hsa_ext_program_destroy(program)
    ccall((:hsa_ext_program_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_ext_program_t,), program)
end

function hsa_ext_program_add_module(program, _module)
    ccall((:hsa_ext_program_add_module, "libhsa-runtime64"), hsa_status_t, (hsa_ext_program_t, hsa_ext_module_t), program, _module)
end

function hsa_ext_program_iterate_modules(program, callback, data)
    ccall((:hsa_ext_program_iterate_modules, "libhsa-runtime64"), hsa_status_t, (hsa_ext_program_t, Ptr{Cvoid}, Ptr{Cvoid}), program, callback, data)
end

function hsa_ext_program_get_info(program, attribute, value)
    ccall((:hsa_ext_program_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_ext_program_t, hsa_ext_program_info_t, Ptr{Cvoid}), program, attribute, value)
end

function hsa_ext_program_finalize(program, isa, call_convention, control_directives, options, code_object_type, code_object)
    ccall((:hsa_ext_program_finalize, "libhsa-runtime64"), hsa_status_t, (hsa_ext_program_t, hsa_isa_t, Int32, hsa_ext_control_directives_t, Cstring, hsa_code_object_type_t, Ptr{hsa_code_object_t}), program, isa, call_convention, control_directives, options, code_object_type, code_object)
end
# Julia wrapper for header: /home/jpsamaroo/AMDGPURuntime/ext/include/hsa/hsa_ext_image.h
# Automatically generated using Clang.jl wrap_c


function hsa_ext_image_get_capability(agent, geometry, image_format, capability_mask)
    ccall((:hsa_ext_image_get_capability, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ptr{hsa_ext_image_format_t}, Ptr{UInt32}), agent, geometry, image_format, capability_mask)
end

function hsa_ext_image_get_capability_with_layout(agent, geometry, image_format, image_data_layout, capability_mask)
    ccall((:hsa_ext_image_get_capability_with_layout, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ptr{hsa_ext_image_format_t}, hsa_ext_image_data_layout_t, Ptr{UInt32}), agent, geometry, image_format, image_data_layout, capability_mask)
end

function hsa_ext_image_data_get_info(agent, image_descriptor, access_permission, image_data_info)
    ccall((:hsa_ext_image_data_get_info, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, hsa_access_permission_t, Ptr{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_info)
end

function hsa_ext_image_data_get_info_with_layout(agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
    ccall((:hsa_ext_image_data_get_info_with_layout, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ptr{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
end

function hsa_ext_image_create(agent, image_descriptor, image_data, access_permission, image)
    ccall((:hsa_ext_image_create, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image)
end

function hsa_ext_image_create_with_layout(agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
    ccall((:hsa_ext_image_create_with_layout, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
end

function hsa_ext_image_destroy(agent, image)
    ccall((:hsa_ext_image_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_t), agent, image)
end

function hsa_ext_image_copy(agent, src_image, src_offset, dst_image, dst_offset, range)
    ccall((:hsa_ext_image_copy, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{hsa_dim3_t}, hsa_ext_image_t, Ptr{hsa_dim3_t}, Ptr{hsa_dim3_t}), agent, src_image, src_offset, dst_image, dst_offset, range)
end

function hsa_ext_image_import(agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
    ccall((:hsa_ext_image_import, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Csize_t, Csize_t, hsa_ext_image_t, Ptr{hsa_ext_image_region_t}), agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
end

function hsa_ext_image_export(agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
    ccall((:hsa_ext_image_export, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{Cvoid}, Csize_t, Csize_t, Ptr{hsa_ext_image_region_t}), agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
end

function hsa_ext_image_clear(agent, image, data, image_region)
    ccall((:hsa_ext_image_clear, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{Cvoid}, Ptr{hsa_ext_image_region_t}), agent, image, data, image_region)
end

function hsa_ext_sampler_create(agent, sampler_descriptor, sampler)
    ccall((:hsa_ext_sampler_create, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_sampler_descriptor_t}, Ptr{hsa_ext_sampler_t}), agent, sampler_descriptor, sampler)
end

function hsa_ext_sampler_destroy(agent, sampler)
    ccall((:hsa_ext_sampler_destroy, "libhsa-runtime64"), hsa_status_t, (hsa_agent_t, hsa_ext_sampler_t), agent, sampler)
end
