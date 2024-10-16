mutable struct HIPModule
    handle::hipModule_t

    function HIPModule(data)
        device_synchronize()

        # TODO use alloc_retry?
        mod_ref = Ref{hipModule_t}()
        hipModuleLoadData(mod_ref, data)
        mod = new(mod_ref[])
        return finalizer(hipModuleUnload, mod)
    end
end

Base.unsafe_convert(::Type{hipModule_t}, mod::HIPModule) = mod.handle
Base.:(==)(a::HIPModule, b::HIPModule) = a.handle == b.handle
Base.hash(m::HIPModule, h::UInt) = hash(m.handle, h)

struct HIPFunction
    handle::hipFunction_t
    mod::HIPModule
    global_hostcalls::Vector{Symbol}

    function HIPFunction(
        mod::HIPModule, name::String, global_hostcalls::Vector{Symbol},
    )
        fun_ref = Ref{hipFunction_t}()
        hipModuleGetFunction(fun_ref, mod, name)
        new(fun_ref[], mod, global_hostcalls)
    end
end

Base.unsafe_convert(::Type{hipFunction_t}, fun::HIPFunction) = fun.handle

function launch_configuration(
    fun::HIPFunction; shmem::Integer = 0, max_block_size::Integer = 0,
)
    grid_size_ref, block_size_ref = Ref{Cint}(), Ref{Cint}()
    hipModuleOccupancyMaxPotentialBlockSize(
        grid_size_ref, block_size_ref, fun, shmem, max_block_size)
    return (; gridsize=grid_size_ref[], groupsize=block_size_ref[])
end
