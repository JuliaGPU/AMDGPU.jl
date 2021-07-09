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

function load_device_libs(dev_isa, ctx)
    device_libs_path === nothing && return

    isa_short = replace(dev_isa, "gfx"=>"")
    device_libs = LLVM.Module[]
    bitcode_files = (
        "hc.amdgcn.bc",
        "hip.amdgcn.bc",
        "irif.amdgcn.bc",
        "ockl.amdgcn.bc",
        "oclc_isa_version_$isa_short.amdgcn.bc",
        "opencl.amdgcn.bc",
        "ocml.amdgcn.bc",
    )

    for file in bitcode_files
        ispath(joinpath(device_libs_path, file)) || continue
        name, ext = splitext(file)
        file_path = joinpath(device_libs_path, file)
        lib = parse(LLVM.Module, read(file_path); ctx)
        for f in LLVM.functions(lib)
            attrs = function_attributes(f)
            delete!(attrs, StringAttribute("target-features"; ctx))
        end
        push!(device_libs, lib)
    end

    @assert !isempty(device_libs) "No device libs detected!"
    return device_libs
end

function link_device_libs!(mod::LLVM.Module, dev_isa::String, undefined_fns)
    ufns = undefined_fns
    # TODO: only link if used
    # TODO: make these globally/locally configurable
    ctx = LLVM.context(mod)
    libs = load_device_libs(dev_isa, ctx)::Vector{LLVM.Module}
    link_oclc_defaults!(mod, dev_isa, ctx)
    for lib in libs
        # override libdevice's triple and datalayout to avoid warnings
        triple!(lib, triple(mod))
        datalayout!(lib, datalayout(mod))
    end

    GPUCompiler.link_library!(mod, libs)
    dispose.(libs)
end

function link_oclc_defaults!(mod::LLVM.Module, dev_isa::String, ctx; finite_only=false,
                             unsafe_math=false, correctly_rounded_sqrt=true, daz=false)
    # link in some defaults for OCLC knobs, to prevent undefined variable errors
    lib = LLVM.Module("OCLC"; ctx)
    triple!(lib, triple(mod))
    datalayout!(lib, datalayout(mod))

    isa_short = replace(dev_isa, "gfx"=>"")
    for (name,value) in (
            "__oclc_ISA_version"=>parse(Int32, isa_short),
            "__oclc_finite_only_opt"=>Int32(finite_only),
            "__oclc_unsafe_math_opt"=>Int32(unsafe_math),
            "__oclc_correctly_rounded_sqrt32"=>Int32(correctly_rounded_sqrt),
            "__oclc_daz_opt"=>Int32(daz))
        gvtype = convert(LLVMType, typeof(value); ctx)
        gv = GlobalVariable(lib, gvtype, name, 4)
        init = ConstantInt(Int32(0); ctx)
        initializer!(gv, init)
        unnamed_addr!(gv, true)
        constant!(gv, true)
        linkage!(gv, LLVM.API.LLVMWeakAnyLinkage)
    end

    link!(mod, lib)
end
