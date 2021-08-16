const _active_kernels = IdDict{HSAQueue,Vector{AMDGPU.HSAStatusSignal}}()

function active_kernels(queue::HSAQueue=get_default_queue())
    lock(RT_LOCK) do
        copy(_active_kernels[queue])
    end
end
active_kernels(queue::RuntimeQueue) = active_kernels(queue.queue)
