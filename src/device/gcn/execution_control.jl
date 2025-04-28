@inline trap() = ccall("llvm.trap", llvmcall, Cvoid, ())
@inline debugtrap() = ccall("llvm.debugtrap", llvmcall, Cvoid, ())

@inline sendmsg(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsg", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@inline sendmsghalt(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsghalt", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@inline endpgm() = ccall("llvm.amdgcn.endpgm", llvmcall, Cvoid, ())
