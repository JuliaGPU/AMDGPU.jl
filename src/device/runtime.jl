# ROCm-specific runtime libraries


## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

function signal_exception()
    flag_ptr = get_global_pointer(Val(:__global_exception_flag), Int64)
    unsafe_store!(flag_ptr, 1)
    # TODO: Can we sync here?
    endpgm() # stop this wavefront
    return
end

function report_exception(ex)
    # Add kernel ID and exception string to exception ring buffer
    ring_ptr = get_global_pointer(Val(:__global_exception_ring), LLVMPtr{ExceptionEntry,AS.Global})
    ring_ptr = unsafe_load(ring_ptr)
    our_signal = _completion_signal()
    prev = UInt64(1)
    while prev != UInt64(0)
        # Try to write to this slot, and skip if we fail (because another wavefront wrote first)
        prev = atomic_cas!(reinterpret(LLVMPtr{UInt64,AS.Global}, ring_ptr), UInt64(0), our_signal)
        if prev == UInt64(0)
            # We get a ReadOnlyMemoryError without this copy because the data is pinned to the device
            # TODO: Don't use an expensive host malloc
            ex_len = string_length(ex)::Csize_t
            copy_buf = reinterpret(LLVMPtr{UInt8,AS.Global}, malloc(ex_len))
            memcpy!(copy_buf, reinterpret(LLVMPtr{UInt8,AS.Global}, ex), ex_len)
            Base.unsafe_store!(reinterpret(LLVMPtr{UInt64,AS.Global}, ring_ptr+sizeof(UInt64)), UInt64(copy_buf))
            break
        elseif prev == UInt64(1)
            # Tail slot, give up
            break
        end
        ring_ptr += sizeof(ExceptionEntry)
    end
    return
end

report_oom(sz) = @rocprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)

function device_string_to_host(ex)
    ex_ptr = reinterpret(LLVMPtr{UInt8,1}, ex)
    ex_len = string_length(ex_ptr)
    ex_str = reinterpret(LLVMPtr{UInt8,1}, malloc(Csize_t(ex_len+1)))
    if reinterpret(UInt64, ex_str) == 0
        @rocprintf("Device-to-host string conversion failed\n")
        return reinterpret(Cstring, 0)
    end
    memcpy!(ex_str, ex_ptr, ex_len)
    unsafe_store!(ex_str+ex_len, UInt8(0))
    reinterpret(Cstring, ex_str)
end

function report_exception_name(ex)
    # Pass argument in host buffer
    ex_str = device_string_to_host(ex)
    @rocprintf("""
        ERROR: a %s was thrown during kernel execution.
        Stacktrace:
        """, ex_str)
    free(reinterpret(Ptr{Cvoid}, ex_str))
    return
end

function report_exception_frame(idx, func, file, line)
    # Pass arguments in host buffers
    func_str = device_string_to_host(func)
    file_str = device_string_to_host(file)
    @rocprintf(" [%i] %s at %s:%i\n", idx, func_str, file_str, line)
    free(reinterpret(Ptr{Cvoid}, func_str))
    free(reinterpret(Ptr{Cvoid}, file_str))
    return
end


## ROCm device library

function load_and_link!(mod, path)
    @debug "Loading device library" path
    ctx = LLVM.context(mod)
    lib = parse(LLVM.Module, read(path); ctx)
    
    # for f in LLVM.functions(lib)
    #     attrs = function_attributes(f)
    #     delete!(attrs, StringAttribute("target-features"; ctx))
    # end

    # override triple and datalayout to avoid warnings
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))

    LLVM.link!(mod, lib)
end

function locate_lib(file)
    file_path = joinpath(device_libs_path, file*".bc")
    if !ispath(file_path)
        file_path = joinpath(device_libs_path, file*".amdgcn.bc")
        if !ispath(file_path)
            # failed to find matching bitcode file
            return nothing
        end
    end
    return file_path
end

function link_device_libs!(target, mod::LLVM.Module)
    # TODO: only link if used
    # TODO: make these globally/locally configurable

    device_libs_path === nothing && return

    # https://github.com/RadeonOpenCompute/ROCm-Device-Libs/blob/9420f6380990b09851edc2a5f9cbfaa88742b449/doc/OCML.md#controls
    # Note: It seems we need to load in reverse order, to avoid LLVM deleting the globals from the module, before we use them.

    # 1. Load other libraries
    libs = (
        "hc",
        "hip",
        "irif",
        "ockl",
        "opencl",
        "ocml",
    )

    for lib in libs
        lib_path = locate_lib(lib)
        lib_path === nothing && continue
        load_and_link!(mod, lib_path)
    end

    # 2. Load OCLC library
    isa_short = replace(target.dev_isa, "gfx"=>"")
    lib = locate_lib("oclc_isa_version_$isa_short")
    @assert lib !== nothing
    load_and_link!(mod, lib)

    # 3. Load options libraries
    options = Dict(
        :finite_only => false,
        :unsafe_math => false,
        :correctly_rounded_sqrt => true,
        :daz_opt => false,
        :wavefrontsize64 => true
    )
    for (option, value) in options
        toggle = value ? "on" : "off"
        lib = locate_lib("oclc_$(option)_$(toggle)")
        @assert lib !== nothing
        load_and_link!(mod, lib)
    end
end
