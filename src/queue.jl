# Utilities for working with HSA queues

"""
An HSA queue.
Each queue is uniquely associated with an agent.
"""
mutable struct HSAQueue
    agent::HSAAgent
    queue::Ref{Ptr{HSA.Queue}}
end

const DEFAULT_QUEUES = IdDict{HSAAgent,HSAQueue}()

function HSAQueue(agent::HSAAgent)
    queue_size = Ref{UInt32}(0)
    getinfo(agent.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, queue_size) |> check
    @assert queue_size[] > 0
    queue = HSAQueue(agent, Ref{Ptr{HSA.Queue}}())
    HSA.queue_create(agent.agent, queue_size[], HSA.QUEUE_TYPE_SINGLE,
                     C_NULL, C_NULL, typemax(UInt32), typemax(UInt32),
                     queue.queue) |> check

    finalizer(queue) do queue
        HSA.queue_destroy(queue.queue[]) |> check
    end
    return queue
end

get_default_queue() = get_default_queue(get_default_agent())

"Gets the default queue for an agent, creating it if necessary"
function get_default_queue(agent::HSAAgent)
    if VERSION >= v"1.1"
        return get!(DEFAULT_QUEUES, agent) do
            HSAQueue(agent)
        end
    else
        if haskey(DEFAULT_QUEUES, agent)
            return DEFAULT_QUEUES[agent]
        else
            return HSAQueue(agent)
        end
    end
end

