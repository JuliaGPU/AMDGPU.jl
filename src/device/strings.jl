## Device-side string utilities

@llvmgenerated builder function alloc_string(::Val{sym})::LLVMPtr{UInt8,AS.Global} where sym
    T_pint8 = LLVM.PointerType(LLVM.Int8Type(), AS.Global)
    str_ptr = globalstring_ptr!(builder, String(sym))
    addrspacecast!(builder, str_ptr, T_pint8)
end

@inline strlen(::Val{S}) where S = length(String(S))

macro strptr(str::String)
    sym = Val(Symbol(str))
    return :(alloc_string($sym), strlen($sym))
end
