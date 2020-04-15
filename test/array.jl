@testset "HSAArray" begin
    agent = get_default_agent()

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
end
