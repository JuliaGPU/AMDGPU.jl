using HSARuntime
using Test

HSARuntime.init()

agent = first(get_agents(:gpu))
show(agent)

queue = HSAQueue(agent)

if profile(agent) == :base
    executable = HSAExecutable(agent, "vector_copy_base.brig")
else
    executable = HSAExecutable(agent, "vector_copy_full.brig")
end

@show executable

kernel = HSAKernel(agent, executable, "&__vector_copy_kernel")
inp = zeros(HSAArray{UInt32}, 1024, 1024)
out = ones(HSAArray{UInt32}, 1024, 1024)
args = HSAKernelArgs(inp, out)
signal = HSASignal()
launch(queue, kernel, args, signal;
       workgroup_size=(256,1,1),
       grid_size=(1024*1024,1,1))
wait(signal)

# Validate the data in the output buffer
valid = true
fail_index = 0
for idx in eachindex(inp)
    if out[idx] != inp[idx]
        fail_index = idx
        valid = false
        break
    end
end

@test valid "Validation failed at index: $fail_index"
