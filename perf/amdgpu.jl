group = addgroup!(SUITE, "amdgpu")

let group = addgroup!(group, "synchronization")
    let group = addgroup!(group, "stream")
        group["blocking"]    = @benchmarkable AMDGPU.synchronize(; blocking=true)
        group["nonblocking"] = @benchmarkable AMDGPU.synchronize(; blocking=false)
    end
    let group = addgroup!(group, "context")
        group["device"] = @benchmarkable AMDGPU.device_synchronize()
    end
end
