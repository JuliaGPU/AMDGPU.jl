function versioninfo(io::IO=stdout)
    println("HSA Runtime ($(hsa_configured ? "ready" : "MISSING"))")
    if hsa_configured
        println("- Path: $libhsaruntime_path")
        println("- Version: $(libhsaruntime_version)")
        println("- Initialized: $(repr(HSA_REFCOUNT[] > 0))")
    end
    println("ld.lld ($(lld_configured ? "ready" : "MISSING"))")
    if lld_configured
        println("- Path: $ld_lld_path")
    end
    println("ROCm-Device-Libs ($(device_libs_configured ? "ready" : "MISSING"))")
    if device_libs_configured
        println("- Path: $device_libs_path")
        # TODO: println("- Version: $(device_libs_version)")
        println("- Downloaded: $(repr(device_libs_downloaded))")
    end
    println("HIP Runtime ($(hip_configured ? "ready" : "MISSING"))")
    if hip_configured
        println("- Path: $libhip_path")
        # TODO: println("- Version: $(libhip_version)")
    end
    println("rocBLAS ($(librocblas !== nothing ? "ready" : "MISSING"))")
    if librocblas !== nothing
        println("- Path: $(Libdl.dlpath(librocblas))")
    end
    println("rocSOLVER ($(librocsolver !== nothing ? "ready" : "MISSING"))")
    if librocsolver !== nothing
        println("- Path: $(Libdl.dlpath(librocsolver))")
    end
    println("rocFFT ($(librocfft !== nothing ? "ready" : "MISSING"))")
    if librocfft !== nothing
        println("- Path: $(Libdl.dlpath(librocfft))")
    end
    println("rocRAND ($(librocrand !== nothing ? "ready" : "MISSING"))")
    if librocrand !== nothing
        println("- Path: $(Libdl.dlpath(librocrand))")
    end
    println("rocSPARSE ($(librocsparse !== nothing ? "ready" : "MISSING"))")
    if librocsparse !== nothing
        println("- Path: $(Libdl.dlpath(librocsparse))")
    end
    println("rocALUTION ($(librocalution !== nothing ? "ready" : "MISSING"))")
    if librocalution !== nothing
        println("- Path: $(Libdl.dlpath(librocalution))")
    end
    println("MIOpen ($(libmiopen !== nothing ? "ready" : "MISSING"))")
    if libmiopen !== nothing
        println("- Path: $(Libdl.dlpath(libmiopen))")
    end

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
