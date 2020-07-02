
function status_string(status::Status, status_string::Ref{Cstring})
    ccall((:hsa_status_string, "libhsa-runtime64"), Status, (Status, Ref{Cstring}), status, status_string)
end

function init()
    ccall((:hsa_init, "libhsa-runtime64"), Status, ())
end

function shut_down()
    ccall((:hsa_shut_down, "libhsa-runtime64"), Status, ())
end

function system_get_info(attribute::SystemInfo, value::Ref{Cvoid})
    ccall((:hsa_system_get_info, "libhsa-runtime64"), Status, (SystemInfo, Ref{Cvoid}), attribute, value)
end

function extension_get_name(extension::UInt16, name::String)
    ccall((:hsa_extension_get_name, "libhsa-runtime64"), Status, (UInt16, Cstring), extension, name)
end

function system_extension_supported(extension::UInt16, version_major::UInt16, version_minor::UInt16, result::Ref{Bool})
    ccall((:hsa_system_extension_supported, "libhsa-runtime64"), Status, (UInt16, UInt16, UInt16, Ref{Bool}), extension, version_major, version_minor, result)
end

function system_major_extension_supported(extension::UInt16, version_major::UInt16, version_minor::Ref{UInt16}, result::Ref{Bool})
    ccall((:hsa_system_major_extension_supported, "libhsa-runtime64"), Status, (UInt16, UInt16, Ref{UInt16}, Ref{Bool}), extension, version_major, version_minor, result)
end

function system_get_extension_table(extension::UInt16, version_major::UInt16, version_minor::UInt16, table::Ref{Cvoid})
    ccall((:hsa_system_get_extension_table, "libhsa-runtime64"), Status, (UInt16, UInt16, UInt16, Ref{Cvoid}), extension, version_major, version_minor, table)
end

function system_get_major_extension_table(extension::UInt16, version_major::UInt16, table_length::Integer, table::Ref{Cvoid})
    ccall((:hsa_system_get_major_extension_table, "libhsa-runtime64"), Status, (UInt16, UInt16, Csize_t, Ref{Cvoid}), extension, version_major, table_length, table)
end

function agent_get_info(agent::Agent, attribute::AgentInfo,
                        value::Union{Ref{T},Vector{T}}) where T
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), Status,
          (Agent, AgentInfo, Ref{T}), agent, attribute, value)
end

function agent_get_info(agent::Agent, attribute::AgentInfo, value::String)
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), Status,
          (Agent, AgentInfo, Cstring), agent, attribute, value)
end

#FIXME: function iterate_agents(callback::Ref{Cvoid}, data::Ref{Cvoid})
function iterate_agents(callback, data)
    ccall((:hsa_iterate_agents, "libhsa-runtime64"), Status, (Ptr{Cvoid}, Ptr{Cvoid}), callback, data)
end

function agent_get_exception_policies(agent::Agent, profile::Profile, mask::Ref{UInt16})
    ccall((:hsa_agent_get_exception_policies, "libhsa-runtime64"), Status, (Agent, Profile, Ref{UInt16}), agent, profile, mask)
end

function cache_get_info(cache::Cache, attribute::CacheInfo, value::Ref{Cvoid})
    ccall((:hsa_cache_get_info, "libhsa-runtime64"), Status, (Cache, CacheInfo, Ref{Cvoid}), cache, attribute, value)
end

function agent_iterate_caches(agent::Agent, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_agent_iterate_caches, "libhsa-runtime64"), Status, (Agent, Ref{Cvoid}, Ref{Cvoid}), agent, callback, data)
end

function agent_extension_supported(extension::UInt16, agent::Agent, version_major::UInt16, version_minor::UInt16, result::Ref{Bool})
    ccall((:hsa_agent_extension_supported, "libhsa-runtime64"), Status, (UInt16, Agent, UInt16, UInt16, Ref{Bool}), extension, agent, version_major, version_minor, result)
end

function agent_major_extension_supported(extension::UInt16, agent::Agent, version_major::UInt16, version_minor::Ref{UInt16}, result::Ref{Bool})
    ccall((:hsa_agent_major_extension_supported, "libhsa-runtime64"), Status, (UInt16, Agent, UInt16, Ref{UInt16}, Ref{Bool}), extension, agent, version_major, version_minor, result)
end

function signal_create(initial_value::SignalValue, num_consumers::Integer,
                       consumers::Ref{Agent}, signal::Ref{Signal})
    ccall((:hsa_signal_create, "libhsa-runtime64"), Status,
          (SignalValue, UInt32, Ref{Agent}, Ref{Signal}),
          initial_value, num_consumers, consumers, signal)
end

function signal_create(initial_value::SignalValue, num_consumers::Integer,
                       consumers::Ptr{Cvoid}, signal::Ref{Signal})
    ccall((:hsa_signal_create, "libhsa-runtime64"), Status,
          (SignalValue, UInt32, Ptr{Cvoid}, Ref{Signal}),
          initial_value, num_consumers, consumers, signal)
end

function signal_destroy(signal::Signal)
    ccall((:hsa_signal_destroy, "libhsa-runtime64"), Status, (Signal,), signal)
end

function signal_load_scacquire(signal::Signal)
    ccall((:hsa_signal_load_scacquire, "libhsa-runtime64"), SignalValue, (Signal,), signal)
end

function signal_load_relaxed(signal::Signal)
    ccall((:hsa_signal_load_relaxed, "libhsa-runtime64"), SignalValue, (Signal,), signal)
end

function signal_load_acquire(signal::Signal)
    ccall((:hsa_signal_load_acquire, "libhsa-runtime64"), SignalValue, (Signal,), signal)
end

function signal_store_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_store_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_store_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_store_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_store_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_store_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_silent_store_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_silent_store_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_silent_store_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_silent_store_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_exchange_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_scacq_screl, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_acq_rel, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_scacquire, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_acquire, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_relaxed, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_screlease, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_exchange_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_exchange_release, "libhsa-runtime64"), SignalValue, (Signal, SignalValue), signal, value)
end

function signal_cas_scacq_screl(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_scacq_screl, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_acq_rel(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_acq_rel, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_scacquire(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_scacquire, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_acquire(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_acquire, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_relaxed(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_relaxed, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_screlease(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_screlease, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_cas_release(signal::Signal, expected::SignalValue, value::SignalValue)
    ccall((:hsa_signal_cas_release, "libhsa-runtime64"), SignalValue, (Signal, SignalValue, SignalValue), signal, expected, value)
end

function signal_add_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_scacq_screl, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_acq_rel, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_scacquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_acquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_add_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_add_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_scacq_screl, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_acq_rel, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_scacquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_acquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_subtract_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_subtract_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_scacq_screl, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_acq_rel, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_scacquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_acquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_and_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_and_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_scacq_screl, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_acq_rel, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_scacquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_acquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_or_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_or_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_scacq_screl(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_scacq_screl, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_acq_rel(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_acq_rel, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_scacquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_scacquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_acquire(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_acquire, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_relaxed(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_relaxed, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_screlease(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_screlease, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_xor_release(signal::Signal, value::SignalValue)
    ccall((:hsa_signal_xor_release, "libhsa-runtime64"), Cvoid, (Signal, SignalValue), signal, value)
end

function signal_wait_scacquire(signal::Signal, condition::SignalCondition, compare_value::SignalValue, timeout_hint::UInt64, wait_state_hint::WaitState)
    ccall((:hsa_signal_wait_scacquire, "libhsa-runtime64"), SignalValue, (Signal, SignalCondition, SignalValue, UInt64, WaitState), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_wait_relaxed(signal::Signal, condition::SignalCondition, compare_value::SignalValue, timeout_hint::UInt64, wait_state_hint::WaitState)
    ccall((:hsa_signal_wait_relaxed, "libhsa-runtime64"), SignalValue, (Signal, SignalCondition, SignalValue, UInt64, WaitState), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_wait_acquire(signal::Signal, condition::SignalCondition, compare_value::SignalValue, timeout_hint::UInt64, wait_state_hint::WaitState)
    ccall((:hsa_signal_wait_acquire, "libhsa-runtime64"), SignalValue, (Signal, SignalCondition, SignalValue, UInt64, WaitState), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_group_create(num_signals::Integer, signals::Ref{Signal}, num_consumers::Integer, consumers::Ref{Agent}, signal_group::Ref{SignalGroup})
    ccall((:hsa_signal_group_create, "libhsa-runtime64"), Status, (UInt32, Ref{Signal}, UInt32, Ref{Agent}, Ref{SignalGroup}), num_signals, signals, num_consumers, consumers, signal_group)
end

function signal_group_destroy(signal_group::SignalGroup)
    ccall((:hsa_signal_group_destroy, "libhsa-runtime64"), Status, (SignalGroup,), signal_group)
end

function signal_group_wait_any_scacquire(signal_group::SignalGroup, conditions::Ref{SignalCondition}, compare_values::Ref{SignalValue}, wait_state_hint::WaitState, signal::Ref{Signal}, value::Ref{SignalValue})
    ccall((:hsa_signal_group_wait_any_scacquire, "libhsa-runtime64"), Status, (SignalGroup, Ref{SignalCondition}, Ref{SignalValue}, WaitState, Ref{Signal}, Ref{SignalValue}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function signal_group_wait_any_relaxed(signal_group::SignalGroup, conditions::Ref{SignalCondition}, compare_values::Ref{SignalValue}, wait_state_hint::WaitState, signal::Ref{Signal}, value::Ref{SignalValue})
    ccall((:hsa_signal_group_wait_any_relaxed, "libhsa-runtime64"), Status, (SignalGroup, Ref{SignalCondition}, Ref{SignalValue}, WaitState, Ref{Signal}, Ref{SignalValue}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function queue_create(agent::Agent, size::Integer, type::QueueType, callback::Ptr{Cvoid}, data::Ptr{Cvoid}, private_segment_size::Integer, group_segment_size::Integer, queue::Ref{Ptr{Queue}})
    ccall((:hsa_queue_create, "libhsa-runtime64"), Status, (Agent, UInt32, QueueType, Ptr{Cvoid}, Ptr{Cvoid}, UInt32, UInt32, Ref{Ptr{Queue}}), agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function soft_queue_create(region::Region, size::Integer, type::QueueType, features::Integer, doorbell_signal::Signal, queue::Ref{Ref{Queue}})
    ccall((:hsa_soft_queue_create, "libhsa-runtime64"), Status, (Region, UInt32, QueueType, UInt32, Signal, Ref{Ref{Queue}}), region, size, type, features, doorbell_signal, queue)
end

function queue_destroy(queue::Ref{Queue})
    ccall((:hsa_queue_destroy, "libhsa-runtime64"), Status, (Ref{Queue},), queue)
end

function queue_inactivate(queue::Ref{Queue})
    ccall((:hsa_queue_inactivate, "libhsa-runtime64"), Status, (Ref{Queue},), queue)
end

function queue_load_read_index_acquire(queue::Ref{Queue})
    ccall((:hsa_queue_load_read_index_acquire, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_load_read_index_scacquire(queue::Ref{Queue})
    ccall((:hsa_queue_load_read_index_scacquire, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_load_read_index_relaxed(queue::Ref{Queue})
    ccall((:hsa_queue_load_read_index_relaxed, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_load_write_index_acquire(queue::Ref{Queue})
    ccall((:hsa_queue_load_write_index_acquire, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_load_write_index_scacquire(queue::Ref{Queue})
    ccall((:hsa_queue_load_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_load_write_index_relaxed(queue::Ref{Queue})
    ccall((:hsa_queue_load_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ref{Queue},), queue)
end

function queue_store_write_index_relaxed(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_store_write_index_relaxed, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function queue_store_write_index_release(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_store_write_index_release, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function queue_store_write_index_screlease(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_store_write_index_screlease, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function queue_cas_write_index_acq_rel(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_acq_rel, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_scacq_screl(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_scacq_screl, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_acquire(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_acquire, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_scacquire(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_relaxed(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_release(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_release, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_screlease(queue::Ref{Queue}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_screlease, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64, UInt64), queue, expected, value)
end

function queue_add_write_index_acq_rel(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_acq_rel, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_scacq_screl(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_scacq_screl, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_acquire(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_acquire, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_scacquire(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_scacquire, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_relaxed(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_relaxed, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_release(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_release, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_add_write_index_screlease(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_add_write_index_screlease, "libhsa-runtime64"), UInt64, (Ref{Queue}, UInt64), queue, value)
end

function queue_store_read_index_relaxed(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_store_read_index_relaxed, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function queue_store_read_index_release(queue::Ref{Queue}, value::UInt64)
    ccall((:hsa_queue_store_read_index_release, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function queue_store_read_index_screlease(queue::Ref{Queue}, value::Integer)
    ccall((:hsa_queue_store_read_index_screlease, "libhsa-runtime64"), Cvoid, (Ref{Queue}, UInt64), queue, value)
end

function region_get_info(region::Region, attribute::RegionInfo, value::Ref{T}) where T
    ccall((:hsa_region_get_info, "libhsa-runtime64"), Status, (Region, RegionInfo, Ref{T}), region, attribute, value)
end

function agent_iterate_regions(agent::Agent, callback::Ref{Cvoid}, data::Ref{T}) where T
    ccall((:hsa_agent_iterate_regions, "libhsa-runtime64"), Status, (Agent, Ref{Cvoid}, Ref{T}), agent, callback, data)
end

function memory_allocate(region::Region, size::Integer, ptr::Ref{Ptr{T}}) where T
    ccall((:hsa_memory_allocate, "libhsa-runtime64"), Status, (Region, Csize_t, Ref{Ptr{T}}), region, size, ptr)
end

function memory_free(ptr::Ptr{T}) where T
    ccall((:hsa_memory_free, "libhsa-runtime64"), Status, (Ptr{T},), ptr)
end

function memory_copy(dst::Ptr{T}, src::Ptr{T}, size::Integer) where T
    ccall((:hsa_memory_copy, "libhsa-runtime64"), Status, (Ptr{T}, Ptr{T}, Csize_t), dst, src, size)
end

function memory_assign_agent(ptr::Ref{Cvoid}, agent::Agent, access::AccessPermission)
    ccall((:hsa_memory_assign_agent, "libhsa-runtime64"), Status, (Ref{Cvoid}, Agent, AccessPermission), ptr, agent, access)
end

function memory_register(ptr::Ref{Cvoid}, size::Integer)
    ccall((:hsa_memory_register, "libhsa-runtime64"), Status, (Ref{Cvoid}, Csize_t), ptr, size)
end

function memory_deregister(ptr::Ref{Cvoid}, size::Integer)
    ccall((:hsa_memory_deregister, "libhsa-runtime64"), Status, (Ref{Cvoid}, Csize_t), ptr, size)
end

function isa_from_name(name, isa::Ref{ISA})
    ccall((:hsa_isa_from_name, "libhsa-runtime64"), Status, (Cstring, Ref{ISA}), name, isa)
end

function agent_iterate_isas(agent::Agent, callback::Ref{Cvoid}, data::Ref{ISA})
    ccall((:hsa_agent_iterate_isas, "libhsa-runtime64"), Status, (Agent, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function isa_get_info(isa::ISA, attribute::ISAInfo, index::Integer, value::Ref{Cvoid})
    ccall((:hsa_isa_get_info, "libhsa-runtime64"), Status, (ISA, ISAInfo, UInt32, Ref{Cvoid}), isa, attribute, index, value)
end

function isa_get_info_alt(isa::ISA, attribute::ISAInfo,
                          value::Union{Vector{T},Ref{T}}) where T
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), Status,
          (ISA, ISAInfo, Ref{T}), isa, attribute, value)
end

function isa_get_info_alt(isa::ISA, attribute::ISAInfo, value::String)
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), Status,
          (ISA, ISAInfo, Cstring), isa, attribute, value)
end

function isa_get_exception_policies(isa::ISA, profile::Profile, mask::Ref{UInt16})
    ccall((:hsa_isa_get_exception_policies, "libhsa-runtime64"), Status, (ISA, Profile, Ref{UInt16}), isa, profile, mask)
end

function isa_get_round_method(isa::ISA, fp_type::FPType, flush_mode::FlushMode, round_method::Ref{RoundMethod})
    ccall((:hsa_isa_get_round_method, "libhsa-runtime64"), Status, (ISA, FPType, FlushMode, Ref{RoundMethod}), isa, fp_type, flush_mode, round_method)
end

function wavefront_get_info(wavefront::Wavefront, attribute::WavefrontInfo, value::Ref{Cvoid})
    ccall((:hsa_wavefront_get_info, "libhsa-runtime64"), Status, (Wavefront, WavefrontInfo, Ref{Cvoid}), wavefront, attribute, value)
end

function isa_iterate_wavefronts(isa::ISA, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_isa_iterate_wavefronts, "libhsa-runtime64"), Status, (ISA, Ref{Cvoid}, Ref{Cvoid}), isa, callback, data)
end

function isa_compatible(code_object_isa::ISA, agent_isa::ISA, result::Ref{Bool})
    ccall((:hsa_isa_compatible, "libhsa-runtime64"), Status, (ISA, ISA, Ref{Bool}), code_object_isa, agent_isa, result)
end

function code_object_reader_create_from_file(file::File, code_object_reader::Ref{CodeObjectReader})
    ccall((:hsa_code_object_reader_create_from_file, "libhsa-runtime64"), Status, (File, Ref{CodeObjectReader}), file, code_object_reader)
end

function code_object_reader_create_from_memory(code_object::Union{Vector{UInt8},Ref{UInt8}}, size::Integer, code_object_reader::Ref{CodeObjectReader})
    ccall((:hsa_code_object_reader_create_from_memory, "libhsa-runtime64"), Status, (Ref{UInt8}, Csize_t, Ref{CodeObjectReader}), code_object, size, code_object_reader)
end

function code_object_reader_destroy(code_object_reader::CodeObjectReader)
    ccall((:hsa_code_object_reader_destroy, "libhsa-runtime64"), Status, (CodeObjectReader,), code_object_reader)
end

function executable_create(profile::Profile, executable_state::ExecutableState, options, executable::Ref{Executable})
    ccall((:hsa_executable_create, "libhsa-runtime64"), Status, (Profile, ExecutableState, Cstring, Ref{Executable}), profile, executable_state, options, executable)
end

function executable_create_alt(profile::Profile, default_float_rounding_mode::DefaultFloatRoundingMode, options, executable::Ref{Executable})
    ccall((:hsa_executable_create_alt, "libhsa-runtime64"), Status, (Profile, DefaultFloatRoundingMode, Cstring, Ref{Executable}), profile, default_float_rounding_mode, options, executable)
end

function executable_destroy(executable::Executable)
    ccall((:hsa_executable_destroy, "libhsa-runtime64"), Status, (Executable,), executable)
end

function executable_load_program_code_object(executable::Executable, code_object_reader::CodeObjectReader, options, loaded_code_object::Ref{LoadedCodeObject})
    ccall((:hsa_executable_load_program_code_object, "libhsa-runtime64"), Status, (Executable, CodeObjectReader, Cstring, Ref{LoadedCodeObject}), executable, code_object_reader, options, loaded_code_object)
end

function executable_load_agent_code_object(executable::Executable, agent::Agent, code_object_reader::CodeObjectReader, options, loaded_code_object::Ref{LoadedCodeObject})
    ccall((:hsa_executable_load_agent_code_object, "libhsa-runtime64"), Status, (Executable, Agent, CodeObjectReader, Cstring, Ref{LoadedCodeObject}), executable, agent, code_object_reader, options, loaded_code_object)
end
# FIXME: temporary dispatch while sorting out calls to this function
function executable_load_agent_code_object(executable::Executable, agent::Agent, code_object_reader::CodeObjectReader, options, loaded_code_object)
    ccall((:hsa_executable_load_agent_code_object, "libhsa-runtime64"), Status, (Executable, Agent, CodeObjectReader, Ptr{Cvoid}, Ptr{Cvoid}), executable, agent, code_object_reader, options, loaded_code_object)
end

function executable_freeze(executable::Executable, options)
    ccall((:hsa_executable_freeze, "libhsa-runtime64"), Status, (Executable, Cstring), executable, options)
end

function executable_get_info(executable::Executable, attribute::ExecutableInfo, value::Ref{Cvoid})
    ccall((:hsa_executable_get_info, "libhsa-runtime64"), Status, (Executable, ExecutableInfo, Ref{Cvoid}), executable, attribute, value)
end

function executable_global_variable_define(executable::Executable, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_global_variable_define, "libhsa-runtime64"), Status, (Executable, Cstring, Ref{Cvoid}), executable, variable_name, address)
end

function executable_agent_global_variable_define(executable::Executable, agent::Agent, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_agent_global_variable_define, "libhsa-runtime64"), Status, (Executable, Agent, Cstring, Ref{Cvoid}), executable, agent, variable_name, address)
end

function executable_readonly_variable_define(executable::Executable, agent::Agent, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_readonly_variable_define, "libhsa-runtime64"), Status, (Executable, Agent, Cstring, Ref{Cvoid}), executable, agent, variable_name, address)
end

function executable_validate(executable::Executable, result::Ref{UInt32})
    ccall((:hsa_executable_validate, "libhsa-runtime64"), Status, (Executable, Ref{UInt32}), executable, result)
end

function executable_validate_alt(executable::Executable, options, result::Ref{UInt32})
    ccall((:hsa_executable_validate_alt, "libhsa-runtime64"), Status, (Executable, Cstring, Ref{UInt32}), executable, options, result)
end

function executable_get_symbol(executable::Executable, module_name, symbol_name, agent::Agent, call_conventionInteger, symbol::Ref{ExecutableSymbol})
    ccall((:hsa_executable_get_symbol, "libhsa-runtime64"), Status, (Executable, Cstring, Cstring, Agent, Int32, Ref{ExecutableSymbol}), executable, module_name, symbol_name, agent, call_convention, symbol)
end

function executable_get_symbol_by_name(executable::Executable, symbol_name, agent::Ref{Agent}, symbol::Ref{ExecutableSymbol})
    ccall((:hsa_executable_get_symbol_by_name, "libhsa-runtime64"), Status, (Executable, Cstring, Ref{Agent}, Ref{ExecutableSymbol}), executable, symbol_name, agent, symbol)
end

function executable_symbol_get_info(executable_symbol::ExecutableSymbol,
                                    attribute::ExecutableSymbolInfo,
                                    value::Union{Ref{T},Vector{T}}) where T
    ccall((:hsa_executable_symbol_get_info, "libhsa-runtime64"), Status,
          (ExecutableSymbol, ExecutableSymbolInfo, Ref{T}),
          executable_symbol, attribute, value)
end

function executable_symbol_get_info(executable_symbol::ExecutableSymbol,
                                    attribute::ExecutableSymbolInfo,
                                    value::String)
    ccall((:hsa_executable_symbol_get_info, "libhsa-runtime64"), Status,
          (ExecutableSymbol, ExecutableSymbolInfo, Cstring),
          executable_symbol, attribute, value)
end

function executable_iterate_symbols(executable::Executable, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_executable_iterate_symbols, "libhsa-runtime64"), Status, (Executable, Ref{Cvoid}, Ref{Cvoid}), executable, callback, data)
end

function executable_iterate_agent_symbols(executable::Executable, agent::Agent, callback::Ptr{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_executable_iterate_agent_symbols, "libhsa-runtime64"), Status, (Executable, Agent, Ptr{Cvoid}, Ref{Cvoid}), executable, agent, callback, data)
end

function executable_iterate_program_symbols(executable::Executable, callback::Ptr{Cvoid}, data::Ptr{Cvoid})
    ccall((:hsa_executable_iterate_program_symbols, "libhsa-runtime64"), Status, (Executable, Ptr{Cvoid}, Ptr{Cvoid}), executable, callback, data)
end

function code_object_serialize(code_object::CodeObject, alloc_callback::Ref{Cvoid}, callback_data::CallbackData, options, serialized_code_object::Ref{Ref{Cvoid}}, serialized_code_object_size::Ref{Csize_t})
    ccall((:hsa_code_object_serialize, "libhsa-runtime64"), Status, (CodeObject, Ref{Cvoid}, CallbackData, Cstring, Ref{Ref{Cvoid}}, Ref{Csize_t}), code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
end

function code_object_deserialize(serialized_code_object::Ref{Cvoid}, serialized_code_object_size::Integer, options, code_object::Ref{CodeObject})
    ccall((:hsa_code_object_deserialize, "libhsa-runtime64"), Status, (Ref{Cvoid}, Csize_t, Cstring, Ref{CodeObject}), serialized_code_object, serialized_code_object_size, options, code_object)
end

function code_object_destroy(code_object::CodeObject)
    ccall((:hsa_code_object_destroy, "libhsa-runtime64"), Status, (CodeObject,), code_object)
end

function code_object_get_info(code_object::CodeObject, attribute::CodeObjectInfo, value::Ref{Cvoid})
    ccall((:hsa_code_object_get_info, "libhsa-runtime64"), Status, (CodeObject, CodeObjectInfo, Ref{Cvoid}), code_object, attribute, value)
end

function executable_load_code_object(executable::Executable, agent::Agent, code_object::CodeObject, options)
    ccall((:hsa_executable_load_code_object, "libhsa-runtime64"), Status, (Executable, Agent, CodeObject, Cstring), executable, agent, code_object, options)
end

function code_object_get_symbol(code_object::CodeObject, symbol_name, symbol::Ref{CodeSymbol})
    ccall((:hsa_code_object_get_symbol, "libhsa-runtime64"), Status, (CodeObject, Cstring, Ref{CodeSymbol}), code_object, symbol_name, symbol)
end

function code_object_get_symbol_from_name(code_object::CodeObject, module_name, symbol_name, symbol::Ref{CodeSymbol})
    ccall((:hsa_code_object_get_symbol_from_name, "libhsa-runtime64"), Status, (CodeObject, Cstring, Cstring, Ref{CodeSymbol}), code_object, module_name, symbol_name, symbol)
end

function code_symbol_get_info(code_symbol::CodeSymbol, attribute::CodeSymbolInfo, value::Ref{Cvoid})
    ccall((:hsa_code_symbol_get_info, "libhsa-runtime64"), Status, (CodeSymbol, CodeSymbolInfo, Ref{Cvoid}), code_symbol, attribute, value)
end

function code_object_iterate_symbols(code_object::CodeObject, callback::Ptr{Cvoid}, data::Ptr{Cvoid})
    ccall((:hsa_code_object_iterate_symbols, "libhsa-runtime64"), Status, (CodeObject, Ptr{Cvoid}, Ptr{Cvoid}), code_object, callback, data)
end

function amd_queue_intercept_register(queue::Ref{Queue}, callback::QueueInterceptHandler, user_data::Ref{Cvoid})
    ccall((:hsa_amd_queue_intercept_register, "libhsa-runtime64"), Status, (Ref{Queue}, QueueInterceptHandler, Ref{Cvoid}), queue, callback, user_data)
end

function amd_queue_intercept_create(agent_handle::Agent, size::Integer, type::QueueType, callback::Ref{Cvoid}, data::Ref{Cvoid}, private_segment_size::Integer, group_segment_size::Integer, queue::Ref{Ref{Queue}})
    ccall((:hsa_amd_queue_intercept_create, "libhsa-runtime64"), Status, (Agent, UInt32, QueueType, Ref{Cvoid}, Ref{Cvoid}, UInt32, UInt32, Ref{Ref{Queue}}), agent_handle, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function amd_runtime_queue_create_register(callback::RuntimeQueueNotifier, user_data::Ref{Cvoid})
    ccall((:hsa_amd_runtime_queue_create_register, "libhsa-runtime64"), Status, (RuntimeQueueNotifier, Ref{Cvoid}), callback, user_data)
end
#=
function copyApi(src::Ref{Cvoid}, dest::Ref{Cvoid}, size::Integer)
    ccall((:copyApi, "libhsa-runtime64"), Cvoid, (Ref{Cvoid}, Ref{Cvoid}, Csize_t), src, dest, size)
end

function copyElement(dest::Ref{ApiTableVersion}, src::Ref{ApiTableVersion})
    ccall((:copyElement, "libhsa-runtime64"), Cvoid, (Ref{ApiTableVersion}, Ref{ApiTableVersion}), dest, src)
end

function copyTables(src::Ref{HsaApiTable}, dest::Ref{HsaApiTable})
    ccall((:copyTables, "libhsa-runtime64"), Cvoid, (Ref{HsaApiTable}, Ref{HsaApiTable}), src, dest)
end
=#
function ext_image_get_capability(agent::Agent, geometry::ImageGeometry, image_format::Ref{ImageFormat}, capability_mask::Ref{UInt32})
    ccall((:hsa_ext_image_get_capability, "libhsa-runtime64"), Status, (Agent, ImageGeometry, Ref{ImageFormat}, Ref{UInt32}), agent, geometry, image_format, capability_mask)
end

function ext_image_get_capability_with_layout(agent::Agent, geometry::ImageGeometry, image_format::Ref{ImageFormat}, image_data_layout::ImageDataLayout, capability_mask::Ref{UInt32})
    ccall((:hsa_ext_image_get_capability_with_layout, "libhsa-runtime64"), Status, (Agent, ImageGeometry, Ref{ImageFormat}, ImageDataLayout, Ref{UInt32}), agent, geometry, image_format, image_data_layout, capability_mask)
end

function ext_image_data_get_info(agent::Agent, image_descriptor::Ref{ExtImageDescriptor}, access_permission::AccessPermission, image_data_info::Ref{ImageDataInfo})
    ccall((:hsa_ext_image_data_get_info, "libhsa-runtime64"), Status, (Agent, Ref{ExtImageDescriptor}, AccessPermission, Ref{ImageDataInfo}), agent, image_descriptor, access_permission, image_data_info)
end

function ext_image_data_get_info_with_layout(agent::Agent, image_descriptor::Ref{ExtImageDescriptor}, access_permission::AccessPermission, image_data_layout::ImageDataLayout, image_data_row_pitch::Integer, image_data_slice_pitch::Integer, image_data_info::Ref{ImageDataInfo})
    ccall((:hsa_ext_image_data_get_info_with_layout, "libhsa-runtime64"), Status, (Agent, Ref{ExtImageDescriptor}, AccessPermission, ImageDataLayout, Csize_t, Csize_t, Ref{ImageDataInfo}), agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
end

function ext_image_create(agent::Agent, image_descriptor::Ref{ExtImageDescriptor}, image_data::Ref{Cvoid}, access_permission::AccessPermission, image::Ref{Image})
    ccall((:hsa_ext_image_create, "libhsa-runtime64"), Status, (Agent, Ref{ExtImageDescriptor}, Ref{Cvoid}, AccessPermission, Ref{Image}), agent, image_descriptor, image_data, access_permission, image)
end

function ext_image_create_with_layout(agent::Agent, image_descriptor::Ref{ExtImageDescriptor}, image_data::Ref{Cvoid}, access_permission::AccessPermission, image_data_layout::ImageDataLayout, image_data_row_pitch::Integer, image_data_slice_pitch::Integer, image::Ref{Image})
    ccall((:hsa_ext_image_create_with_layout, "libhsa-runtime64"), Status, (Agent, Ref{ExtImageDescriptor}, Ref{Cvoid}, AccessPermission, ImageDataLayout, Csize_t, Csize_t, Ref{Image}), agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
end

function ext_image_destroy(agent::Agent, image::Image)
    ccall((:hsa_ext_image_destroy, "libhsa-runtime64"), Status, (Agent, Image), agent, image)
end

function ext_image_copy(agent::Agent, src_image::Image, src_offset::Ref{Dim3}, dst_image::Image, dst_offset::Ref{Dim3}, range::Ref{Dim3})
    ccall((:hsa_ext_image_copy, "libhsa-runtime64"), Status, (Agent, Image, Ref{Dim3}, Image, Ref{Dim3}, Ref{Dim3}), agent, src_image, src_offset, dst_image, dst_offset, range)
end

function ext_image_import(agent::Agent, src_memory::Ref{Cvoid}, src_row_pitch::Integer, src_slice_pitch::Integer, dst_image::Image, image_region::Ref{ImageRegion})
    ccall((:hsa_ext_image_import, "libhsa-runtime64"), Status, (Agent, Ref{Cvoid}, Csize_t, Csize_t, Image, Ref{ImageRegion}), agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
end

function ext_image_export(agent::Agent, src_image::Image, dst_memory::Ref{Cvoid}, dst_row_pitch::Integer, dst_slice_pitch::Integer, image_region::Ref{ImageRegion})
    ccall((:hsa_ext_image_export, "libhsa-runtime64"), Status, (Agent, Image, Ref{Cvoid}, Csize_t, Csize_t, Ref{ImageRegion}), agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
end

function ext_image_clear(agent::Agent, image::Image, data::Ref{Cvoid}, image_region::Ref{ImageRegion})
    ccall((:hsa_ext_image_clear, "libhsa-runtime64"), Status, (Agent, Image, Ref{Cvoid}, Ref{ImageRegion}), agent, image, data, image_region)
end

function ext_sampler_create(agent::Agent, sampler_descriptor::Ref{ExtSamplerDescriptor}, sampler::Ref{Sampler})
    ccall((:hsa_ext_sampler_create, "libhsa-runtime64"), Status, (Agent, Ref{ExtSamplerDescriptor}, Ref{Sampler}), agent, sampler_descriptor, sampler)
end

function ext_sampler_destroy(agent::Agent, sampler::Sampler)
    ccall((:hsa_ext_sampler_destroy, "libhsa-runtime64"), Status, (Agent, Sampler), agent, sampler)
end

function amd_coherency_get_type(agent::Agent, type::Ref{CoherencyType})
    ccall((:hsa_amd_coherency_get_type, "libhsa-runtime64"), Status, (Agent, Ref{CoherencyType}), agent, type)
end

function amd_coherency_set_type(agent::Agent, type::CoherencyType)
    ccall((:hsa_amd_coherency_set_type, "libhsa-runtime64"), Status, (Agent, CoherencyType), agent, type)
end

function amd_profiling_set_profiler_enabled(queue::Ref{Queue}, enable::Cint)
    ccall((:hsa_amd_profiling_set_profiler_enabled, "libhsa-runtime64"), Status, (Ref{Queue}, Cint), queue, enable)
end

function amd_profiling_async_copy_enable(enable::Bool)
    ccall((:hsa_amd_profiling_async_copy_enable, "libhsa-runtime64"), Status, (Bool,), enable)
end

function amd_profiling_get_dispatch_time(agent::Agent, signal::Signal, time::Ref{ProfilingDispatchTime})
    ccall((:hsa_amd_profiling_get_dispatch_time, "libhsa-runtime64"), Status, (Agent, Signal, Ref{ProfilingDispatchTime}), agent, signal, time)
end

function amd_profiling_get_async_copy_time(signal::Signal, time::Ref{ProfilingAsyncCopyTime})
    ccall((:hsa_amd_profiling_get_async_copy_time, "libhsa-runtime64"), Status, (Signal, Ref{ProfilingAsyncCopyTime}), signal, time)
end

function amd_profiling_convert_tick_to_system_domain(agent::Agent, agent_tick::UInt64, system_tick::Ref{UInt64})
    ccall((:hsa_amd_profiling_convert_tick_to_system_domain, "libhsa-runtime64"), Status, (Agent, UInt64, Ref{UInt64}), agent, agent_tick, system_tick)
end

function amd_signal_create(initial_value::SignalValue, num_consumers::Integer, consumers::Ref{Agent}, attributes::UInt64, signal::Ref{Signal})
    ccall((:hsa_amd_signal_create, "libhsa-runtime64"), Status, (SignalValue, UInt32, Ref{Agent}, UInt64, Ref{Signal}), initial_value, num_consumers, consumers, attributes, signal)
end

function amd_signal_async_handler(signal::Signal, cond::SignalCondition, value::SignalValue, handler::SignalHandler, arg::Ref{Cvoid})
    ccall((:hsa_amd_signal_async_handler, "libhsa-runtime64"), Status, (Signal, SignalCondition, SignalValue, SignalHandler, Ref{Cvoid}), signal, cond, value, handler, arg)
end

function amd_async_function(callback::Ref{Cvoid}, arg::Ref{Cvoid})
    ccall((:hsa_amd_async_function, "libhsa-runtime64"), Status, (Ref{Cvoid}, Ref{Cvoid}), callback, arg)
end

function amd_signal_wait_any(signal_count::Integer, signals::Ref{Signal}, conds::Ref{SignalCondition}, values::Ref{SignalValue}, timeout_hint::UInt64, wait_hint::WaitState, satisfying_value::Ref{SignalValue})
    ccall((:hsa_amd_signal_wait_any, "libhsa-runtime64"), UInt32, (UInt32, Ref{Signal}, Ref{SignalCondition}, Ref{SignalValue}, UInt64, WaitState, Ref{SignalValue}), signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
end

function amd_image_get_info_max_dim(agent::Agent, attribute::AgentInfo, value::Ref{Cvoid})
    ccall((:hsa_amd_image_get_info_max_dim, "libhsa-runtime64"), Status, (Agent, AgentInfo, Ref{Cvoid}), agent, attribute, value)
end

function amd_queue_cu_set_mask(queue::Ref{Queue}, num_cu_mask_count::Integer, cu_mask::Ref{UInt32})
    ccall((:hsa_amd_queue_cu_set_mask, "libhsa-runtime64"), Status, (Ref{Queue}, UInt32, Ref{UInt32}), queue, num_cu_mask_count, cu_mask)
end

function amd_memory_pool_get_info(memory_pool::MemoryPool, attribute::MemoryPoolInfo, value::Ref{Cvoid})
    ccall((:hsa_amd_memory_pool_get_info, "libhsa-runtime64"), Status, (MemoryPool, MemoryPoolInfo, Ref{Cvoid}), memory_pool, attribute, value)
end

function amd_agent_iterate_memory_pools(agent::Agent, callback::Ptr{Cvoid}, data::Ptr{Cvoid})
    ccall((:hsa_amd_agent_iterate_memory_pools, "libhsa-runtime64"), Status, (Agent, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function amd_memory_pool_allocate(memory_pool::MemoryPool, size::Integer, flags::Integer, ptr::Ref{Ref{Cvoid}})
    ccall((:hsa_amd_memory_pool_allocate, "libhsa-runtime64"), Status, (MemoryPool, Csize_t, UInt32, Ref{Ref{Cvoid}}), memory_pool, size, flags, ptr)
end

function amd_memory_pool_free(ptr::Ref{Cvoid})
    ccall((:hsa_amd_memory_pool_free, "libhsa-runtime64"), Status, (Ref{Cvoid},), ptr)
end

function amd_memory_async_copy(dst::Ref{Cvoid}, dst_agent::Agent, src::Ref{Cvoid}, src_agent::Agent, size::Integer, num_dep_signals::Integer, dep_signals::Ref{Signal}, completion_signal::Signal)
    ccall((:hsa_amd_memory_async_copy, "libhsa-runtime64"), Status, (Ref{Cvoid}, Agent, Ref{Cvoid}, Agent, Csize_t, UInt32, Ref{Signal}, Signal), dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
end

function amd_memory_async_copy_rect(dst::Ref{PitchedPtr}, dst_offset::Ref{Dim3}, src::Ref{PitchedPtr}, src_offset::Ref{Dim3}, range::Ref{Dim3}, copy_agent::Agent, dir::CopyDirection, num_dep_signals::Integer, dep_signals::Ref{Signal}, completion_signal::Signal)
    ccall((:hsa_amd_memory_async_copy_rect, "libhsa-runtime64"), Status, (Ref{PitchedPtr}, Ref{Dim3}, Ref{PitchedPtr}, Ref{Dim3}, Ref{Dim3}, Agent, CopyDirection, UInt32, Ref{Signal}, Signal), dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal)
end

function amd_agent_memory_pool_get_info(agent::Agent, memory_pool::MemoryPool, attribute::AgentMemoryPoolInfo, value::Ref{Cvoid})
    ccall((:hsa_amd_agent_memory_pool_get_info, "libhsa-runtime64"), Status, (Agent, MemoryPool, AgentMemoryPoolInfo, Ref{Cvoid}), agent, memory_pool, attribute, value)
end

function amd_agents_allow_access(num_agents::Integer, agents::Ref{Agent}, flags::Ref{UInt32}, ptr::Ref{Cvoid})
    ccall((:hsa_amd_agents_allow_access, "libhsa-runtime64"), Status, (UInt32, Ref{Agent}, Ref{UInt32}, Ref{Cvoid}), num_agents, agents, flags, ptr)
end

function amd_memory_pool_can_migrate(src_memory_pool::MemoryPool, dst_memory_pool::MemoryPool, result::Ref{Bool})
    ccall((:hsa_amd_memory_pool_can_migrate, "libhsa-runtime64"), Status, (MemoryPool, MemoryPool, Ref{Bool}), src_memory_pool, dst_memory_pool, result)
end

function amd_memory_migrate(ptr::Ref{Cvoid}, memory_pool::MemoryPool, flags::Integer)
    ccall((:hsa_amd_memory_migrate, "libhsa-runtime64"), Status, (Ref{Cvoid}, MemoryPool, UInt32), ptr, memory_pool, flags)
end

function amd_memory_lock(host_ptr::Ptr{Cvoid}, size::Integer, agents::Ref{Agent}, num_agent::Integer, agent_ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_memory_lock, "libhsa-runtime64"), Status, (Ptr{Cvoid}, Csize_t, Ref{Agent}, Cint, Ref{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, agent_ptr)
end

function amd_memory_lock_to_pool(host_ptr::Ref{Cvoid}, size::Integer, agents::Ref{Agent}, num_agent::Cint, pool::MemoryPool, flags::Integer, agent_ptr::Ref{Ref{Cvoid}})
    ccall((:hsa_amd_memory_lock_to_pool, "libhsa-runtime64"), Status, (Ref{Cvoid}, Csize_t, Ref{Agent}, Cint, MemoryPool, UInt32, Ref{Ref{Cvoid}}), host_ptr, size, agents, num_agent, pool, flags, agent_ptr)
end

function amd_memory_unlock(host_ptr::Ptr{Cvoid})
    ccall((:hsa_amd_memory_unlock, "libhsa-runtime64"), Status, (Ptr{Cvoid},), host_ptr)
end

function amd_memory_fill(ptr::Ptr{Cvoid}, value::UInt32, count::Integer)
    ccall((:hsa_amd_memory_fill, "libhsa-runtime64"), Status, (Ptr{Cvoid}, UInt32, Csize_t), ptr, value, count)
end

function amd_interop_map_buffer(num_agents::Integer, agents::Ref{Agent}, interop_handle::Cint, flags::Integer, size::Ref{Csize_t}, ptr::Ref{Ref{Cvoid}}, metadata_size::Ref{Csize_t}, metadata::Ref{Ref{Cvoid}})
    ccall((:hsa_amd_interop_map_buffer, "libhsa-runtime64"), Status, (UInt32, Ref{Agent}, Cint, UInt32, Ref{Csize_t}, Ref{Ref{Cvoid}}, Ref{Csize_t}, Ref{Ref{Cvoid}}), num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
end

function amd_interop_unmap_buffer(ptr::Ref{Cvoid})
    ccall((:hsa_amd_interop_unmap_buffer, "libhsa-runtime64"), Status, (Ref{Cvoid},), ptr)
end

function amd_image_create(agent::Agent, image_descriptor::Ref{ExtImageDescriptor}, image_layout::Ref{AMDImageDescriptor}, image_data::Ref{Cvoid}, access_permission::AccessPermission, image::Ref{Image})
    ccall((:hsa_amd_image_create, "libhsa-runtime64"), Status, (Agent, Ref{ExtImageDescriptor}, Ref{AMDImageDescriptor}, Ref{Cvoid}, AccessPermission, Ref{Image}), agent, image_descriptor, image_layout, image_data, access_permission, image)
end

function amd_pointer_info(ptr::Ptr{Cvoid}, info::Ref{PointerInfo}, alloc::Ptr{Cvoid}, num_agents_accessible::Ptr{UInt32}, accessible)
    ccall((:hsa_amd_pointer_info, "libhsa-runtime64"), Status, (Ptr{Cvoid}, Ref{PointerInfo}, Ptr{Cvoid}, Ptr{UInt32}, Ptr{Cvoid}), ptr, info, alloc, num_agents_accessible, accessible)
end

function amd_pointer_info_set_userdata(ptr::Ref{Cvoid}, userdata::Ref{Cvoid})
    ccall((:hsa_amd_pointer_info_set_userdata, "libhsa-runtime64"), Status, (Ref{Cvoid}, Ref{Cvoid}), ptr, userdata)
end

function amd_ipc_memory_create(ptr::Ref{Cvoid}, len::Integer, handle::Ref{IPCMemory})
    ccall((:hsa_amd_ipc_memory_create, "libhsa-runtime64"), Status, (Ref{Cvoid}, Csize_t, Ref{IPCMemory}), ptr, len, handle)
end

function amd_ipc_memory_attach(handle::Ref{IPCMemory}, len::Integer, num_agents::Integer, mapping_agents::Ref{Agent}, mapped_ptr::Ref{Ref{Cvoid}})
    ccall((:hsa_amd_ipc_memory_attach, "libhsa-runtime64"), Status, (Ref{IPCMemory}, Csize_t, UInt32, Ref{Agent}, Ref{Ref{Cvoid}}), handle, len, num_agents, mapping_agents, mapped_ptr)
end

function amd_ipc_memory_detach(mapped_ptr::Ref{Cvoid})
    ccall((:hsa_amd_ipc_memory_detach, "libhsa-runtime64"), Status, (Ref{Cvoid},), mapped_ptr)
end

function amd_ipc_signal_create(signal::Signal, handle::Ref{IPCSignal})
    ccall((:hsa_amd_ipc_signal_create, "libhsa-runtime64"), Status, (Signal, Ref{IPCSignal}), signal, handle)
end

function amd_ipc_signal_attach(handle::Ref{IPCSignal}, signal::Ref{Signal})
    ccall((:hsa_amd_ipc_signal_attach, "libhsa-runtime64"), Status, (Ref{IPCSignal}, Ref{Signal}), handle, signal)
end

function amd_register_system_event_handler(callback::SystemEventCallback, data::Ref{Cvoid})
    ccall((:hsa_amd_register_system_event_handler, "libhsa-runtime64"), Status, (SystemEventCallback, Ref{Cvoid}), callback, data)
end

function amd_queue_set_priority(queue::Ref{Queue}, priority::QueuePriority)
    ccall((:hsa_amd_queue_set_priority, "libhsa-runtime64"), Status, (Ref{Queue}, QueuePriority), queue, priority)
end

function amd_register_deallocation_callback(ptr::Ref{Cvoid}, callback::DeallocationCallback, user_data::Ref{Cvoid})
    ccall((:hsa_amd_register_deallocation_callback, "libhsa-runtime64"), Status, (Ref{Cvoid}, DeallocationCallback, Ref{Cvoid}), ptr, callback, user_data)
end

function amd_deregister_deallocation_callback(ptr::Ref{Cvoid}, callback::DeallocationCallback)
    ccall((:hsa_amd_deregister_deallocation_callback, "libhsa-runtime64"), Status, (Ref{Cvoid}, DeallocationCallback), ptr, callback)
end

function ext_tools_set_correlation_handler(agent::Agent, correlation_handle::Ref{Cvoid})
    ccall((:hsa_ext_tools_set_correlation_handler, "libhsa-runtime64"), Status, (Agent, Ref{Cvoid}), agent, correlation_handle)
end

function ext_tools_wave_control(agent::Agent, action::WaveAction, mode::WaveMode, trap_id::Integer, msg_ptr::Ref{Cvoid})
    ccall((:hsa_ext_tools_wave_control, "libhsa-runtime64"), Status, (Agent, WaveAction, WaveMode, UInt32, Ref{Cvoid}), agent, action, mode, trap_id, msg_ptr)
end

#=
function ext_tools_flush_cache(agent::Agent, options::CacheFlushOptions)
    ccall((:hsa_ext_tools_flush_cache, "libhsa-runtime64"), Status, (Agent, CacheFlushOptions), agent, options)
end
=#

function ext_tools_install_trap(agent::Agent, type::TrapType, trap_handler::Ref{Cvoid}, trap_buffer::Ref{Cvoid}, trap_handler_size::Integer, trap_buffer_size::Integer)
    ccall((:hsa_ext_tools_install_trap, "libhsa-runtime64"), Status, (Agent, TrapType, Ref{Cvoid}, Ref{Cvoid}, Csize_t, Csize_t), agent, type, trap_handler, trap_buffer, trap_handler_size, trap_buffer_size)
end

function ext_tools_set_exception_policy(agent::Agent, exception_policy::ExceptionPolicy)
    ccall((:hsa_ext_tools_set_exception_policy, "libhsa-runtime64"), Status, (Agent, ExceptionPolicy), agent, exception_policy)
end

function ext_tools_get_exception_policy(agent::Agent, exception_policy::Ref{ExceptionPolicy})
    ccall((:hsa_ext_tools_get_exception_policy, "libhsa-runtime64"), Status, (Agent, Ref{ExceptionPolicy}), agent, exception_policy)
end

function ext_tools_set_kernel_execution_mode(agent::Agent, mode::KernelExecutionMode)
    ccall((:hsa_ext_tools_set_kernel_execution_mode, "libhsa-runtime64"), Status, (Agent, KernelExecutionMode), agent, mode)
end

function ext_tools_get_kernel_execution_mode(agent::Agent, mode::Ref{KernelExecutionMode})
    ccall((:hsa_ext_tools_get_kernel_execution_mode, "libhsa-runtime64"), Status, (Agent, Ref{KernelExecutionMode}), agent, mode)
end

function ext_tools_register(agent::Agent)
    ccall((:hsa_ext_tools_register, "libhsa-runtime64"), Status, (Agent,), agent)
end

function ext_tools_unregister(agent::Agent)
    ccall((:hsa_ext_tools_unregister, "libhsa-runtime64"), Status, (Agent,), agent)
end

function ext_tools_address_watch(agent::Agent, num_watch_points::Integer, mode::Ref{AddressWatchMode}, watch_address::Ref{Ref{Cvoid}}, watch_mask::Ref{UInt64}, watch_event::Ref{ToolsEvent})
    ccall((:hsa_ext_tools_address_watch, "libhsa-runtime64"), Status, (Agent, UInt32, Ref{AddressWatchMode}, Ref{Ref{Cvoid}}, Ref{UInt64}, Ref{ToolsEvent}), agent, num_watch_points, mode, watch_address, watch_mask, watch_event)
end

function ext_tools_get_dispatch_debug_info(agent::Agent, info::Ref{DispatchDebugInfo})
    ccall((:hsa_ext_tools_get_dispatch_debug_info, "libhsa-runtime64"), Status, (Agent, Ref{DispatchDebugInfo}), agent, info)
end

function ext_tools_dmacopy(agent::Agent, src_addr::Ref{UInt32}, dst_addr::Ref{UInt32}, size::Integer)
    ccall((:hsa_ext_tools_dmacopy, "libhsa-runtime64"), Status, (Agent, Ref{UInt32}, Ref{UInt32}, UInt32), agent, src_addr, dst_addr, size)
end

function ext_tools_create_event(agent::Agent, auto_reset::Bool, event::Ref{ToolsEvent}, event_id::Ref{UInt32})
    ccall((:hsa_ext_tools_create_event, "libhsa-runtime64"), Status, (Agent, Bool, Ref{ToolsEvent}, Ref{UInt32}), agent, auto_reset, event, event_id)
end

function ext_tools_wait_event(timeoutInteger, event::ToolsEvent)
    ccall((:hsa_ext_tools_wait_event, "libhsa-runtime64"), EventWaitStatus, (Int32, ToolsEvent), timeout, event)
end

function ext_tools_destroy_event(event::ToolsEvent)
    ccall((:hsa_ext_tools_destroy_event, "libhsa-runtime64"), Status, (ToolsEvent,), event)
end

function ext_program_create(machine_model::MachineModel, profile::Profile, default_float_rounding_mode::DefaultFloatRoundingMode, options, program::Ref{ExtProgram})
    ccall((:hsa_ext_program_create, "libhsa-runtime64"), Status, (MachineModel, Profile, DefaultFloatRoundingMode, Cstring, Ref{ExtProgram}), machine_model, profile, default_float_rounding_mode, options, program)
end

function ext_program_destroy(program::ExtProgram)
    ccall((:hsa_ext_program_destroy, "libhsa-runtime64"), Status, (ExtProgram,), program)
end

function ext_program_add_module(program::ExtProgram, _module::ExtModule)
    ccall((:hsa_ext_program_add_module, "libhsa-runtime64"), Status, (ExtProgram, ExtModule), program, _module)
end

function ext_program_iterate_modules(program::ExtProgram, callback::Ptr{Cvoid}, data::Ptr{Cvoid})
    ccall((:hsa_ext_program_iterate_modules, "libhsa-runtime64"), Status, (ExtProgram, Ptr{Cvoid}, Ptr{Cvoid}), program, callback, data)
end

function ext_program_get_info(program::ExtProgram, attribute::ProgramInfo, value::Ref{Cvoid})
    ccall((:hsa_ext_program_get_info, "libhsa-runtime64"), Status, (ExtProgram, ProgramInfo, Ref{Cvoid}), program, attribute, value)
end

function ext_program_finalize(program::ExtProgram, isa::ISA, call_conventionInteger, control_directives::ExtControlDirectives, options, code_object_type::CodeObjectType, code_object::Ref{CodeObject})
    ccall((:hsa_ext_program_finalize, "libhsa-runtime64"), Status, (ExtProgram, ISA, Int32, ExtControlDirectives, Cstring, CodeObjectType, Ref{CodeObject}), program, isa, call_convention, control_directives, options, code_object_type, code_object)
end

function ven_amd_aqlprofile_version_major()
    ccall((:hsa_ven_amd_aqlprofile_version_major, "libhsa-runtime64"), UInt32, ())
end

function ven_amd_aqlprofile_version_minor()
    ccall((:hsa_ven_amd_aqlprofile_version_minor, "libhsa-runtime64"), UInt32, ())
end

function ven_amd_aqlprofile_validate_event(agent::Agent, event::Ref{AQLProfileEvent}, result::Ref{Bool})
    ccall((:hsa_ven_amd_aqlprofile_validate_event, "libhsa-runtime64"), Status, (Agent, Ref{AQLProfileEvent}, Ref{Bool}), agent, event, result)
end

function ven_amd_aqlprofile_start(profile::Ref{AQLProfile}, aql_start_packet::Ref{AQLPm4Packet})
    ccall((:hsa_ven_amd_aqlprofile_start, "libhsa-runtime64"), Status, (Ref{AQLProfile}, Ref{AQLPm4Packet}), profile, aql_start_packet)
end

function ven_amd_aqlprofile_stop(profile::Ref{AQLProfile}, aql_stop_packet::Ref{AQLPm4Packet})
    ccall((:hsa_ven_amd_aqlprofile_stop, "libhsa-runtime64"), Status, (Ref{AQLProfile}, Ref{AQLPm4Packet}), profile, aql_stop_packet)
end

function ven_amd_aqlprofile_read(profile::Ref{AQLProfile}, aql_read_packet::Ref{AQLPm4Packet})
    ccall((:hsa_ven_amd_aqlprofile_read, "libhsa-runtime64"), Status, (Ref{AQLProfile}, Ref{AQLPm4Packet}), profile, aql_read_packet)
end

function ven_amd_aqlprofile_legacy_get_pm4(aql_packet::Ref{AQLPm4Packet}, data::Ref{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_legacy_get_pm4, "libhsa-runtime64"), Status, (Ref{AQLPm4Packet}, Ref{Cvoid}), aql_packet, data)
end

function ven_amd_aqlprofile_get_info(profile::Ref{AQLProfile}, attribute::AQLProfileInfoType, value::Ref{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_get_info, "libhsa-runtime64"), Status, (Ref{AQLProfile}, AQLProfileInfoType, Ref{Cvoid}), profile, attribute, value)
end

function ven_amd_aqlprofile_iterate_data(profile::Ref{AQLProfile}, callback::AQLProfileDataCallback, data::Ptr{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_iterate_data, "libhsa-runtime64"), Status, (Ref{AQLProfile}, AQLProfileDataCallback, Ptr{Cvoid}), profile, callback, data)
end

function ven_amd_aqlprofile_error_string(str::Ref{Cstring})
    ccall((:hsa_ven_amd_aqlprofile_error_string, "libhsa-runtime64"), Status, (Ref{Cstring},), str)
end

function ven_amd_loader_query_host_address(device_address::Ref{Cvoid}, host_address::Ref{Ref{Cvoid}})
    ccall((:hsa_ven_amd_loader_query_host_address, "libhsa-runtime64"), Status, (Ref{Cvoid}, Ref{Ref{Cvoid}}), device_address, host_address)
end

function ven_amd_loader_query_segment_descriptors(segment_descriptors::Ref{SegmentDescriptor}, num_segment_descriptors::Ref{Csize_t})
    ccall((:hsa_ven_amd_loader_query_segment_descriptors, "libhsa-runtime64"), Status, (Ref{SegmentDescriptor}, Ref{Csize_t}), segment_descriptors, num_segment_descriptors)
end

function ven_amd_loader_query_executable(device_address::Ref{Cvoid}, executable::Ref{Executable})
    ccall((:hsa_ven_amd_loader_query_executable, "libhsa-runtime64"), Status, (Ref{Cvoid}, Ref{Executable}), device_address, executable)
end

function ven_amd_loader_executable_iterate_loaded_code_objects(executable::Executable, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_ven_amd_loader_executable_iterate_loaded_code_objects, "libhsa-runtime64"), Status, (Executable, Ref{Cvoid}, Ref{Cvoid}), executable, callback, data)
end

function ven_amd_loader_loaded_code_object_get_info(loaded_code_object::LoadedCodeObject, attribute::LoadedCodeObjectInfo, value::Ref{Cvoid})
    ccall((:hsa_ven_amd_loader_loaded_code_object_get_info, "libhsa-runtime64"), Status, (LoadedCodeObject, LoadedCodeObjectInfo, Ref{Cvoid}), loaded_code_object, attribute, value)
end
