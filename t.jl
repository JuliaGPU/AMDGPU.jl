using AMDGPU

function main()
    data = rand(ComplexF32, (100, 100, 8, 20, 200))
    cu_result = AMDGPU.zeros(ComplexF32, (100, 100, 20, 200))

    Threads.@threads for i in axes(data, 5)
        for t in axes(data, 4)
            cu_result[:, :, t, i] .= sum(ROCArray(data[:, :, :, t, i]))
        end
    end
end

function main2()
    Threads.@threads for i in 1:10
        # ROCArray{Int}(undef, 16)
        sum(AMDGPU.ones(Int, 16))
    end
end

main2()

# println("Starting first iteration")
# main()
# println("First iteration finished")
# main()
# println("Second iteration finished")
