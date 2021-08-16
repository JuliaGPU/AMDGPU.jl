# support for device-side exceptions (from CUDAnative/src/exceptions.jl)

## exception type

struct KernelException <: Exception
    dev::RuntimeDevice
    exstr::Union{String,Nothing}
end
KernelException(dev::RuntimeDevice) = KernelException(dev::RuntimeDevice, nothing)
KernelException(agent::HSAAgent, exstr=nothing) = KernelException(RuntimeDevice(agent), exstr)

function Base.showerror(io::IO, err::KernelException)
    print(io, "KernelException: exception(s) thrown during kernel execution on device $(err.dev.device)")
    if err.exstr !== nothing
        println(io, ":")
        print(io, err.exstr)
    end
end

## exception ring buffer

struct ExceptionEntry
    kern::UInt64
    ptr::LLVMPtr{UInt8,AS.Global}
end
# FIXME: https://github.com/JuliaLang/julia/issues/38864
#ExceptionEntry(kern) = ExceptionEntry(kern, LLVMPtr{UInt8,AS.Global}(0))
#ExceptionEntry() = ExceptionEntry(0)

## exception codegen

# emit a global variable for storing the current exception status
function emit_exception_user!(mod::LLVM.Module)
    # add a fake user for __ockl_hsa_signal_store and __ockl_hsa_signal_load
    if !haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
        ctx = LLVM.context(mod)
        #Context() do ctx
            ft = LLVM.FunctionType(LLVM.VoidType(ctx))
            fn = LLVM.Function(mod, "__fake_global_exception_flag_user", ft)
            Builder(ctx) do builder
                entry = BasicBlock(fn, "entry"; ctx)
                position!(builder, entry)
                T_nothing = LLVM.VoidType(ctx)
                T_i32 = LLVM.Int32Type(ctx)
                T_i64 = LLVM.Int64Type(ctx)
                T_signal_store = LLVM.FunctionType(T_nothing, [T_i64, T_i64, T_i32])
                signal_store = LLVM.Function(mod, "__ockl_hsa_signal_store", T_signal_store)
                call!(builder, signal_store, [ConstantInt(0; ctx),
                                              ConstantInt(0; ctx),
                                              # __ATOMIC_RELEASE == 3
                                              ConstantInt(Int32(3); ctx)])
                T_signal_load = LLVM.FunctionType(T_i64, [T_i64, T_i32])
                signal_load = LLVM.Function(mod, "__ockl_hsa_signal_load", T_signal_load)
                loaded_value = call!(builder, signal_load, [ConstantInt(0; ctx),
                                                            # __ATOMIC_ACQUIRE == 2
                                                            ConstantInt(Int32(2); ctx)])
                ret!(builder)
            end
        #end
    end
    @assert haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
end
function delete_exception_user!(mod::LLVM.Module)
    fns = LLVM.functions(mod)
    if haskey(fns, "__fake_global_exception_flag_user")
        unsafe_delete!(mod, fns["__fake_global_exception_flag_user"])
    end
    @assert !haskey(LLVM.functions(mod), "__fake_global_exception_flag_user")
end
