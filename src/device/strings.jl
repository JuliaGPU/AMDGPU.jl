## Device-side string utilities

@inline @generated function alloc_string(::Val{sym}) where sym
    str = String(sym)
    @dispose ctx=Context() begin
        T_pint8 = LLVM.PointerType(LLVM.Int8Type(), AS.Global)
        llvm_f, _ = create_function(T_pint8)

        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            position!(builder, entry)

            str_ptr = globalstring_ptr!(builder, str)
            ptr = addrspacecast!(builder, str_ptr, T_pint8)
            ret!(builder, ptr)
        end
        call_function(llvm_f, LLVMPtr{UInt8, AS.Global})
    end
end

@generated function string_length(ex::Union{Ptr,LLVMPtr})
    @dispose ctx=Context() begin
        T_ex = convert(LLVMType, ex)
        T_ex_ptr = LLVM.PointerType(T_ex)
        T_i8 = LLVM.Int8Type()
        T_i8_ptr = LLVM.PointerType(T_i8)
        T_i64 = LLVM.Int64Type()
        llvm_f, _ = create_function(T_i64, [T_ex])
        mod = LLVM.parent(llvm_f)

        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            check = BasicBlock(llvm_f, "check")
            done = BasicBlock(llvm_f, "done")

            position!(builder, entry)
            init_offset = ConstantInt(0)
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
            next_offset = add!(builder, offset, ConstantInt(1))
            append!(LLVM.incoming(offset), [(init_offset, entry), (next_offset, check)])

            ptr = gep!(builder, T_i8, input_ptr, [offset])
            value = load!(builder, T_i8, ptr)
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, value, ConstantInt(0x0))
            br!(builder, cond, done, check)

            position!(builder, done)
            ret!(builder, offset)
        end
        call_function(llvm_f, Int64, Tuple{ex}, :ex)
    end
end

macro strptr(str::String)
    sym = Val(Symbol(str))
    return :(alloc_string($sym))
end
