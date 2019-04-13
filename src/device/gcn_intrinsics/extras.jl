export dotrap, dodebugtrap

@inline dotrap() = ccall("llvm.trap", llvmcall, Cvoid, ())
@inline dodebugtrap() = ccall("llvm.debugtrap", llvmcall, Cvoid, ())
