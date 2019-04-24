using HSARuntime
using Test

if HSARuntime.configured
    HSARuntime.set_default_agent!(:gpu)
    agent = get_default_agent()
    agent_name = HSARuntime.get_name(agent)
    @test length(agent_name) > 0
    agent_isa = get_first_isa(agent)
    @test length(agent_isa) > 0
    @info "Testing with agent $agent_name with ISA $agent_isa"

    arr = HSAArray(agent, UInt32, (8, ))
    fill!(arr, UInt32(1))
    _arr = Array(arr)
    @test length(arr) == length(_arr)
    for idx in 1:length(arr)
        _arr[idx] = arr[idx]
    end
    @test arr == _arr
    fill!(_arr, UInt32(2))
    for idx in 1:length(arr)
        arr[idx] = _arr[idx]
    end
    @test arr == _arr

    arr1 = HSAArray(agent, UInt32, (8,))
    arr2 = HSAArray(agent, UInt32, (8,))
    fill!(arr1, 1)
    fill!(arr2, 2)
    arr3 = similar(arr1)
    for i in 1:length(arr1)
        arr3[i] = arr1[i] + arr2[i]
    end
    @test all(arr3 .== 3)
    @test all(isa.((arr1, arr2, arr3), Ref(HSAArray)))
    @test size(arr3) == size(arr1)

    @test_broken "MD-indexing"
    @test_broken "Broadcast"
else
    @warn("HSARuntime.jl has not been configured; skipping on-device tests.")
end

#=
queue = HSAQueue(agent)
kernel = HSAKernel(agent, executable, "&__vector_copy_kernel")
inp = zeros(HSAArray{UInt32}, 1024, 1024)
out = ones(HSAArray{UInt32}, 1024, 1024)
args = HSAKernelArgs(inp, out)
signal = HSASignal()
launch(queue, kernel, args, signal;
       workgroup_size=(256,1,1),
       grid_size=(1024*1024,1,1))
wait(signal)
=#
