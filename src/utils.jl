function versioninfo(io::IO=stdout)
    println("HSA Runtime ($(hsa_configured ? "ready" : "MISSING"))")
    if hsa_configured
        println("- Version: $(libhsaruntime_version)")
        println("- Initialized: $(repr(HSA_REFCOUNT[] > 0))")
    end
    println("ld.lld ($(lld_configured ? "ready" : "MISSING"))")
    if lld_configured
        println("- Path: $ld_lld_path")
    end
    println("ROCm-Device-Libs ($(device_libs_configured ? "ready" : "MISSING"))")
    if device_libs_configured
        # TODO: println("- Version: $(device_libs_version)")
        println("- Downloaded: $(repr(device_libs_downloaded))")
    end
    println("HIP Runtime ($(hip_configured ? "ready" : "MISSING"))")
    if hip_configured
        # TODO: println("- Version: $(libhip_version)")
    end
    println("rocBLAS ($(librocblas !== nothing ? "ready" : "MISSING"))")
    println("rocSOLVER ($(librocsolver !== nothing ? "ready" : "MISSING"))")
    println("rocFFT ($(librocfft !== nothing ? "ready" : "MISSING"))")
    println("rocRAND ($(librocrand !== nothing ? "ready" : "MISSING"))")
    println("rocSPARSE ($(librocsparse !== nothing ? "ready" : "MISSING"))")
    println("rocALUTION ($(librocalution !== nothing ? "ready" : "MISSING"))")
    println("MIOpen ($(libmiopen !== nothing ? "ready" : "MISSING"))")

    if hsa_configured && HSA_REFCOUNT[] > 0
        println("HSA Agents ($(length(agents()))):")
        for agent in agents()
            println("- ", repr(agent))
        end
    end
end

function has_rocm_gpu()
    if !AMDGPU.hsa_configured 
        return false
    else
        return length(AMDGPU.get_agents(:gpu)) > 0
    end
end
