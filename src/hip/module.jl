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

struct HIPFunction
    handle::hipFunction_t
    mod::HIPModule
    global_hostcalls::Vector{Symbol}

    function HIPFunction(mod::HIPModule, name::String, global_hostcalls::Vector{Symbol})
        fun_ref = Ref{hipFunction_t}()
        hipModuleGetFunction(fun_ref, mod, name)
        new(fun_ref[], mod, global_hostcalls)
    end
end

Base.unsafe_convert(::Type{hipFunction_t}, fun::HIPFunction) = fun.handle
Base.:(==)(a::HIPFunction, b::HIPFunction) = a.handle == b.handle
Base.hash(fun::HIPFunction, h::UInt) = hash(fun.handle, h)

function launch_configuration(fun::HIPFunction; shmem::Integer = 0, max_block_size::Integer = 0)
    grid_size_ref, block_size_ref = Ref{Cint}(), Ref{Cint}()
    hipModuleOccupancyMaxPotentialBlockSize(
        grid_size_ref, block_size_ref, fun, shmem, max_block_size)
    return (; gridsize=grid_size_ref[], groupsize=block_size_ref[])
end
