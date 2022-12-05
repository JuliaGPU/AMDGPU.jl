@inline trap() = ccall("llvm.trap", llvmcall, Cvoid, ())
@inline debugtrap() = ccall("llvm.debugtrap", llvmcall, Cvoid, ())

@inline assume(cond::Bool) =
    Base.llvmcall(("declare void @llvm.assume(i1)",
                    "%cond = icmp eq i8 %0, 1
                     call void @llvm.assume(i1 %cond)
                     ret void"), Nothing, Tuple{Bool}, cond)

## completion signal

const completion_signal_base = _packet_offsets[findfirst(x->x==:completion_signal,_packet_names)]

@generated function _completion_signal()
    Context() do ctx
        T_int8 = LLVM.Int8Type(ctx)
        T_int64 = LLVM.Int64Type(ctx)
        _as = convert(Int, AS.Constant)
        T_ptr_i8 = LLVM.PointerType(T_int8, _as)
        T_ptr_i64 = LLVM.PointerType(T_int64, _as)

        # create function
        llvm_f, _ = create_function(T_int64)
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # get the kernel dispatch pointer
            intr_typ = LLVM.FunctionType(T_ptr_i8)
            intr = LLVM.Function(mod, "llvm.amdgcn.dispatch.ptr", intr_typ)
            ptr = call!(builder, intr)

            # load the index
            signal_ptr_i8 = inbounds_gep!(builder, ptr, [ConstantInt(completion_signal_base; ctx)])
            signal_ptr = bitcast!(builder, signal_ptr_i8, T_ptr_i64)
            signal = load!(builder, signal_ptr)
            ret!(builder, signal)
        end

        call_function(llvm_f, UInt64)
    end
end

signal_completion(value::Int64) = device_signal_store!(_completion_signal(), value)

## misc. intrinsics
@inline sendmsg(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsg", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@inline sendmsghalt(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsghalt", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@inline endpgm() = ccall("llvm.amdgcn.endpgm", llvmcall, Cvoid, ())
