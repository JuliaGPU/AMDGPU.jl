export barrier_and!, barrier_or!

## Kernel allocations

struct KernelMetadata
    kern::UInt64
    buf::Mem.Buffer
end

## Kernel module and function

export ROCModule, ROCFunction

const MAX_EXCEPTIONS = 256
const EXE_TO_MODULE_MAP = IdDict{Any,WeakRef}()
mutable struct ROCModule{E}
    exe::ROCExecutable{E}
    metadata::Vector{KernelMetadata}
    exceptions::Mem.Buffer
end
function ROCModule(exe)
    device = exe.device
    metadata = KernelMetadata[]
    exceptions = Mem.alloc(device, sizeof(AMDGPU.Device.ExceptionEntry)*MAX_EXCEPTIONS; coherent=true)
    mod = ROCModule(exe, metadata, exceptions)
    EXE_TO_MODULE_MAP[exe] = WeakRef(mod)
    AMDGPU.hsaref!()
    return finalizer(mod) do x
        # FIXME: Free all metadata
        Mem.free(mod.exceptions)
        delete!(EXE_TO_MODULE_MAP, exe)
        AMDGPU.hsaunref!()
    end
end
mutable struct ROCFunction
    mod::ROCModule
    entry::String
end

## Kernel instance

mutable struct ROCKernel{T<:Tuple}
    device::ROCDevice
    exe::ROCExecutable
    sym::String
    args::T
    kernel_object::UInt64
    kernarg_segment_size::UInt32
    group_segment_size::UInt32
    private_segment_size::UInt32
    kernarg_address::Ptr{Nothing}
end

function ROCKernel(kernel, f::Core.Function, args::Tuple)
    kernel::HostKernel
    exe = kernel.mod.exe
    device = exe.device
    symbol = kernel.fun.entry
    agent_func = @cfunction(iterate_exec_agent_syms_cb, HSA.Status,
                           (HSA.Executable, HSA.Agent, HSA.ExecutableSymbol, Ptr{Cvoid}))
    exec_symbol = Ref{HSA.ExecutableSymbol}()
    exec_ptr = Base.unsafe_convert(Ref{Cvoid}, exec_symbol)
    HSA.executable_iterate_agent_symbols(exe.executable[], device.agent,
                                         agent_func, exec_ptr) |> check

    # TODO: Conditionally disable once ROCR is fixed
    if !isassigned(exec_symbol)
        agent_ref = Ref(device.agent)
        GC.@preserve agent_ref begin
            HSA.executable_get_symbol_by_name(exe.executable[], symbol,
                                              agent_ref, exec_symbol) |> check
        end
    end

    kernel_object = Ref{UInt64}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT,
            kernel_object) |> check

    kernarg_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE,
            kernarg_segment_size) |> check

    if kernarg_segment_size[] == 0
        # FIXME: Hidden arguments!
        if length(args) > 0
            kernarg_segment_size[] = sum(sizeof(typeof(arg)) for arg in args)
        else
            # Allocate some memory anyway, #10
            kernarg_segment_size[] = max(kernarg_segment_size[], 8)
        end
    end

    group_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE,
            group_segment_size) |> check

    private_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE,
            private_segment_size) |> check

    # Allocate the kernel argument buffer
    key = khash(f, khash(args))
    kernarg_address, do_write = Mem.alloc_pooled(device, key, :kernarg, kernarg_segment_size[])

    if do_write
        # Fill kernel argument buffer
        # FIXME: Query kernarg segment alignment
        ctr = 0x0
        for arg in (f, args...)
            rarg = Ref(arg)
            align = Base.datatype_alignment(typeof(arg))
            rem = mod(ctr, align)
            if rem > 0
                ctr += align-rem
            end
            sz = sizeof(typeof(arg))
            ccall(:memcpy, Cvoid,
                  (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
                  kernarg_address+ctr, rarg, sz)
            ctr += sz
        end
    end

    kernel = ROCKernel(device, exe, symbol, args, kernel_object[],
                               kernarg_segment_size[], group_segment_size[],
                               private_segment_size[], kernarg_address)
    AMDGPU.hsaref!()
    finalizer(kernel) do kernel
        Mem.free_pooled(device, key, :kernarg, kernarg_address)
        AMDGPU.hsaunref!()
    end
    return kernel
end
