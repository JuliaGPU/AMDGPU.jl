# copied from CUDAnative PR 422

# Gets a pointer to a global with a particular name. If the global
# does not exist yet, then it is declared in the global memory address
# space.
@generated function get_global_pointer(::Val{global_name}, ::Type{T})::AMDGPU.LLVMPtr{T} where {global_name, T}
    Context() do ctx
        T_global = convert(LLVMType, T; ctx)
        T_result = convert(LLVMType, Ptr{T}; ctx)

        # Create a thunk that computes a pointer to the global.
        llvm_f, _ = create_function(T_result)
        mod = LLVM.parent(llvm_f)

        # Figure out if the global has been defined already.
        global_set = LLVM.globals(mod)
        global_name_string = String(global_name)
        if haskey(global_set, global_name_string)
            global_var = global_set[global_name_string]
        else
            # If the global hasn't been defined already, then we'll define
            # it in the global address space, i.e., address space one.
            global_var = GlobalVariable(mod, T_global, global_name_string, 1)
            linkage!(global_var, LLVM.API.LLVMExternalLinkage)
            extinit!(global_var, true)
            #set_used!(mod, global_var)
        end

        # Generate IR that computes the global's address.
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # Cast the global variable's type to the result type.
            result = ptrtoint!(builder, global_var, T_result)
            ret!(builder, result)
        end

        # Call the function.
        quote
            AMDGPU.LLVMPtr{T, AMDGPU.AS.Global}(convert(Csize_t, $(call_function(llvm_f, Ptr{T}))))
        end
    end
end
