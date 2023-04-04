## Device-side string utilities

@generated function string_length(ex::Union{Ptr,LLVMPtr})
    Context() do ctx
        T_ex = convert(LLVMType, ex; ctx)
        T_ex_ptr = LLVM.PointerType(T_ex)
        T_i8 = LLVM.Int8Type(ctx)
        T_i8_ptr = LLVM.PointerType(T_i8)
        T_i64 = LLVM.Int64Type(ctx)
        llvm_f, _ = create_function(T_i64, [T_ex])
        mod = LLVM.parent(llvm_f)

        IRBuilder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            check = BasicBlock(llvm_f, "check"; ctx)
            done = BasicBlock(llvm_f, "done"; ctx)

            position!(builder, entry)
            init_offset = ConstantInt(0; ctx)
            input_ptr = if T_ex isa LLVM.PointerType
                parameters(llvm_f)[1]
            else
                inttoptr!(builder, parameters(llvm_f)[1], T_ex_ptr)
            end
            if LLVM.addrspace(value_type(input_ptr)) != LLVM.addrspace(T_ex_ptr)
                input_ptr = addrspacecast!(builder, input_ptr, T_ex_ptr)
            end
            input_ptr = bitcast!(builder, input_ptr, T_i8_ptr)
            br!(builder, check)

            position!(builder, check)
            offset = phi!(builder, T_i64)
            next_offset = add!(builder, offset, ConstantInt(1; ctx))
            append!(LLVM.incoming(offset), [(init_offset, entry), (next_offset, check)])

            ptr = gep!(builder, T_i8, input_ptr, [offset])
            value = load!(builder, T_i8, ptr)
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, value, ConstantInt(0x0; ctx))
            br!(builder, cond, done, check)

            position!(builder, done)
            ret!(builder, offset)
        end
        call_function(llvm_f, Csize_t, Tuple{ex}, :ex)
    end
end
