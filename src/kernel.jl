export barrier_and!, barrier_or!

mutable struct HSAKernelInstance{T<:Tuple}
    agent::HSAAgent
    exe::HSAExecutable
    sym::String
    args::T
    kernel_object::UInt64
    kernarg_segment_size::UInt32
    group_segment_size::UInt32
    private_segment_size::UInt32
    kernarg_address::Ptr{Nothing}
end

# TODO agent can be inferred from the executable
function HSAKernelInstance(agent::HSAAgent, exe::HSAExecutable, symbol::String, args::Tuple)
    agent_func = @cfunction(iterate_exec_agent_syms_cb, HSA.Status,
                           (HSA.Executable, HSA.Agent, HSA.ExecutableSymbol, Ptr{Cvoid}))
    exec_symbol = Ref{HSA.ExecutableSymbol}()
    exec_ptr = Base.unsafe_convert(Ref{Cvoid}, exec_symbol)
    HSA.executable_iterate_agent_symbols(exe.executable[], agent.agent,
                                         agent_func, exec_ptr) |> check

    # TODO: Conditionally disable once ROCR is fixed
    if !isassigned(exec_symbol)
        agent_ref = Ref(agent.agent)
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

    # N.B. We use the region API because kernarg allocations don't
    # show up in the memory pools API
    kernarg_region = get_region(agent, :kernarg)

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    HSA.memory_allocate(kernarg_region.region,
                        kernarg_segment_size[],
                        kernarg_address) |> check

    # Fill kernel argument buffer
    # FIXME: Query kernarg segment alignment
    ctr = 0x0
    for arg in args
        rarg = Ref(arg)
        align = Base.datatype_alignment(typeof(arg))
        rem = mod(ctr, align)
        if rem > 0
            ctr += align-rem
        end
        sz = sizeof(typeof(arg))
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            kernarg_address[]+ctr, rarg, sz)
        ctr += sz
    end


    kernel = HSAKernelInstance(agent, exe, symbol, args, kernel_object[],
                               kernarg_segment_size[], group_segment_size[],
                               private_segment_size[], kernarg_address[])
    AMDGPU.hsaref!()
    finalizer(kernel) do kernel
        HSA.memory_free(kernel.kernarg_address) |> check
        AMDGPU.hsaunref!()
    end
    return kernel
end

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
    exe::HSAExecutable{E}
    metadata::Vector{KernelMetadata}
    exceptions::Mem.Buffer
end
function ROCModule(exe)
    agent = exe.agent
    metadata = KernelMetadata[]
    exceptions = Mem.alloc(agent, sizeof(AMDGPU.ExceptionEntry)*MAX_EXCEPTIONS; coherent=true)
    mod = ROCModule(exe, metadata, exceptions)
    EXE_TO_MODULE_MAP[exe] = WeakRef(mod)
    AMDGPU.hsaref!()
    finalizer(mod) do x
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
