export barrier_and!, barrier_or!

## Kernel allocations

struct KernelMetadata
    kern::UInt64
    buf::Mem.Buffer
end

## Kernel module and function

export ROCModule, ROCFunction

const MAX_EXCEPTIONS = 256
const EXE_TO_MODULE_MAP = IdDict{ROCExecutable, WeakRef}()
mutable struct ROCModule
    exe::ROCExecutable
    metadata::Vector{KernelMetadata}
    exceptions::Mem.Buffer
end

function delete_metadata!(m::ROCModule; signal_handle::UInt64 = UInt64(0))
    isempty(m.metadata) && return nothing

    only_handle = signal_handle != UInt64(0)
    for i in length(m.metadata):-1:1
        meta = m.metadata[i]
        Mem.free(meta.buf)
        if only_handle && (meta.kern == signal_handle)
            deleteat!(m.metadata, i)
        end
    end
    only_handle || empty!(m.metadata)
    return nothing
end

function ROCModule(exe::ROCExecutable)
    device = exe.device
    metadata = KernelMetadata[]
    exceptions = Mem.alloc(device, sizeof(AMDGPU.Device.ExceptionEntry)*MAX_EXCEPTIONS; coherent=true)

    mod = ROCModule(exe, metadata, exceptions)
    EXE_TO_MODULE_MAP[exe] = WeakRef(mod)

    AMDGPU.hsaref!()
    return finalizer(mod) do m
        delete_metadata!(m)
        Mem.free(m.exceptions)
        delete!(EXE_TO_MODULE_MAP, m.exe)
        AMDGPU.hsaunref!()
    end
end
mutable struct ROCFunction
    mod::ROCModule
    entry::String
end

## Kernel instance

mutable struct ROCKernel{F,T<:Tuple}
    device::ROCDevice
    exe::ROCExecutable
    sym::String
    f::F
    args::T
    kernel_object::UInt64
    kernarg_segment_size::UInt32
    group_segment_size::UInt32
    private_segment_size::UInt32
    kernarg_address::Ptr{Nothing}
    state::AMDGPU.KernelState
end

function ROCKernel(kernel #= ::HostKernel =#, f::Core.Function, args::Tuple; localmem::Int=0)
    exe = kernel.mod.exe
    device = exe.device
    symbol = kernel.fun.entry
    agent_func = @cfunction(iterate_exec_agent_syms_cb, HSA.Status,
                            (HSA.Executable, HSA.Agent, HSA.ExecutableSymbol, Ptr{HSA.ExecutableSymbol}))
    exec_symbol_ref = Ref{HSA.ExecutableSymbol}()
    ret = HSA.executable_iterate_agent_symbols(exe.executable[], device.agent,
                                               agent_func, exec_symbol_ref)
    @assert ret == HSA.STATUS_SUCCESS || ret == HSA.STATUS_INFO_BREAK

    # TODO: Conditionally disable once ROCR is fixed
    if !isassigned(exec_symbol_ref)
        agent_ref = Ref(device.agent)
        GC.@preserve agent_ref begin
            HSA.executable_get_symbol_by_name(exe.executable[], symbol,
                                              agent_ref, exec_symbol_ref) |> check
        end
    end
    exec_symbol = exec_symbol_ref[]

    kernel_object = executable_symbol_kernel_object(exec_symbol)
    kernarg_segment_size = executable_symbol_kernel_kernarg_segment_size(exec_symbol)
    if kernarg_segment_size == 0
        # FIXME: Hidden arguments!
        if length(args) > 0
            kernarg_segment_size = UInt32(sum(sizeof(typeof(arg)) for arg in args))
        else
            # Allocate some memory anyway, #10
            kernarg_segment_size = UInt32(max(kernarg_segment_size, 8))
        end
    end

    group_segment_size = executable_symbol_kernel_group_segment_size(exec_symbol)
    group_segment_size = UInt32(group_segment_size + localmem)
    private_segment_size = executable_symbol_kernel_private_segment_size(exec_symbol)
    if private_segment_size > MAXIMUM_SCRATCH_ALLOCATION
        @debug "Excessive scratch allocation requested\nReducing per-lane scratch to $(Int(MAXIMUM_SCRATCH_ALLOCATION)) bytes"
        private_segment_size = MAXIMUM_SCRATCH_ALLOCATION
    end

    # Allocate the kernel argument buffer
    key = khash(f, khash(args))
    kernarg_address, do_write = Mem.alloc_pooled(device, key, :kernarg, kernarg_segment_size)

    if do_write
        # Fill kernel argument buffer
        # FIXME: Query kernarg segment alignment
        ctr = 0x0
        for arg in (kernel.state, f, args...)
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

    kernel = ROCKernel(device, exe, symbol, f, args, kernel_object,
                       kernarg_segment_size, group_segment_size,
                       private_segment_size, kernarg_address,
                       kernel.state)
    AMDGPU.hsaref!()
    finalizer(kernel) do k
        Mem.free_pooled(device, key, :kernarg, k.kernarg_address)
        AMDGPU.hsaunref!()
    end
    return kernel
end

"Sets the maximum amount of per-lane scratch memory that can be allocated for a
kernel. Consider setting this to a value below 2^14 if encountering
`QueueError`s with the `HSA.STATUS_ERROR_OUT_OF_RESOURCES` code."
set_max_scratch!(scratch::Integer) =
    @set_preferences!("max_scratch"=>scratch)
const MAXIMUM_SCRATCH_ALLOCATION = let
    if haskey(ENV, "JULIA_AMDGPU_MAX_SCRATCH")
        scratch = ENV["JULIA_AMDGPU_MAX_SCRATCH"]
        scratch = if uppercase(scratch) == "MAX"
            typemax(UInt32)
        else
            parse(UInt32, scratch)
        end
        set_max_scratch!(scratch)
        scratch
    else
        UInt32(@load_preference("max_scratch", 8192))
    end
end::UInt32
