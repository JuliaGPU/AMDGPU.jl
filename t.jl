using AMDGPU

function main()
    @show Base.format_bytes(AMDGPU.memory_stats().live)
    AMDGPU.record_memory!(true)

    res = nothing

    for i in 1:2
        x = AMDGPU.rand(Float32, 1024)
        y = sum(x; dims=1)
        if i == 1
            res = y
            AMDGPU.remove_record!(res)
        end
    end

    AMDGPU.record_memory!(false)
    @show Base.format_bytes(AMDGPU.memory_stats().live)
    println("Done")

    @show res
    return
end
main()
