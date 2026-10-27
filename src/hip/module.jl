mutable struct HIPModule
    handle::hipModule_t

    function HIPModule(data)
        # During stream capture no GPU work is actually executing, so syncing
        # would call hipStreamQuery on a capturing stream, which returns
        # hipErrorStreamCaptureUnsupported and invalidates the capture.
        is_capturing() || device_synchronize()

        mod_ref = Ref{hipModule_t}()
        hipModuleLoadData(mod_ref, data)
        mod = new(mod_ref[])
        return finalizer(hipModuleUnload, mod)
    end
end

Base.unsafe_convert(::Type{hipModule_t}, mod::HIPModule) = mod.handle
Base.:(==)(a::HIPModule, b::HIPModule) = a.handle == b.handle
Base.hash(m::HIPModule, h::UInt) = hash(m.handle, h)

"""
    module_global(mod::HIPModule, name::AbstractString)

Device address and size (in bytes) of the global variable `name` in a loaded module.
Throws if the module defines no such symbol.
"""
function module_global(mod::HIPModule, name::AbstractString)
    ptr_ref = Ref{hipDeviceptr_t}()
    bytes_ref = Ref{Csize_t}()
    hipModuleGetGlobal(ptr_ref, bytes_ref, mod, name)
    return ptr_ref[], Int(bytes_ref[])
end

mutable struct HIPFunction
    const handle::hipFunction_t
    const mod::HIPModule
    const global_hostcalls::Vector{Symbol}

    # queried for every KernelAbstractions launch, so cached; see `max_threads_per_block`
    # and `launch_configuration`
    @atomic max_threads::Int                 # 0 until queried
    @atomic launch_config::NTuple{2, Cint}  # (gridsize, groupsize), (0, 0) until queried

    function HIPFunction(mod::HIPModule, name::String, global_hostcalls::Vector{Symbol})
        fun_ref = Ref{hipFunction_t}()
        hipModuleGetFunction(fun_ref, mod, name)
        new(fun_ref[], mod, global_hostcalls, 0, (Cint(0), Cint(0)))
    end
end

Base.unsafe_convert(::Type{hipFunction_t}, fun::HIPFunction) = fun.handle
Base.:(==)(a::HIPFunction, b::HIPFunction) = a.handle == b.handle
Base.hash(fun::HIPFunction, h::UInt) = hash(fun.handle, h)

"""
    max_threads_per_block(fun::HIPFunction)::Int

The maximum number of work-items in a workgroup that `fun` can be launched with.
"""
function max_threads_per_block(fun::HIPFunction)
    # fixed when the function is loaded
    threads = @atomic :monotonic fun.max_threads
    if threads == 0
        threads_ref = Ref{Cint}()
        hipFuncGetAttribute(threads_ref, HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, fun)
        threads = Int(threads_ref[])
        @atomic :monotonic fun.max_threads = threads
    end
    return threads
end

"""
    launch_configuration(fun::HIPFunction; shmem=0, max_block_size=0)

The workgroup size with the best occupancy for `fun`, using `shmem` bytes of dynamic shared
memory, and the number of workgroups that reach that occupancy, as a named tuple
`(; gridsize, groupsize)`. A positive `max_block_size` limits the workgroup size; HIP rounds
it up to the wavefront size.

Without dynamic shared memory, the result is cached in `fun`.
"""
function launch_configuration(fun::HIPFunction; shmem::Integer = 0, max_block_size::Integer = 0)
    if shmem == 0
        # the occupancy only depends on the resources the function uses, which are fixed
        # when it is loaded
        config = @atomic :monotonic fun.launch_config
        if config[2] == 0
            config = query_launch_configuration(fun, 0, 0)
            @atomic :monotonic fun.launch_config = config
        end
        # HIP picks the largest block size the occupancy allows, capped by the limit rounded
        # up to the wavefront size, so a limit that admits the unconstrained choice doesn't
        # change the result
        gridsize, groupsize = config
        if max_block_size <= 0 || max_block_size >= groupsize
            return (; gridsize, groupsize)
        end
    end
    gridsize, groupsize = query_launch_configuration(fun, shmem, max_block_size)
    return (; gridsize, groupsize)
end

function query_launch_configuration(fun::HIPFunction, shmem::Integer, max_block_size::Integer)
    grid_size_ref, block_size_ref = Ref{Cint}(), Ref{Cint}()
    hipModuleOccupancyMaxPotentialBlockSize(
        grid_size_ref, block_size_ref, fun, shmem, max_block_size)
    return (grid_size_ref[], block_size_ref[])
end
