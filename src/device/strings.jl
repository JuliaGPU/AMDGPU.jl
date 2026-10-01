## Device-side string utilities

@llvmgenerated builder function alloc_string(::Val{sym})::LLVMPtr{UInt8,AS.Global} where sym
    globalstring_ptr!(builder, String(sym); addrspace=AS.Global)
end

@inline strlen(::Val{S}) where S = length(String(S))

macro strptr(str::String)
    sym = Val(Symbol(str))
    return :(alloc_string($sym), strlen($sym))
end
