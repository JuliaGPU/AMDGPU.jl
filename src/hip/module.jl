mutable struct HIPModule
    handle::hipModule_t

    function HIPModule(data::Vector{UInt8})
        mod_ref = Ref{hipModule_t}()
        hipModuleLoadData(mod_ref, data) |> check
        mod = new(mod_ref[])

        finalizer(mod) do mod
            hipModuleUnload(mod) |> check
        end
        mod
    end
end

Base.unsafe_convert(::Type{hipModule_t}, mod::HIPModule) = mod.handle

struct HIPFunction
    handle::hipFunction_t
    mod::HIPModule

    function HIPFunction(mod::HIPModule, name::String)
        fun_ref = Ref{hipFunction_t}()
        hipModuleGetFunction(fun_ref, mod, name) |> check
        new(fun_ref[], mod)
    end
end

Base.unsafe_convert(::Type{hipFunction_t}, fun::HIPFunction) = fun.handle
