@device_function @inline trap() = ccall("llvm.trap", llvmcall, Cvoid, ())
@device_function @inline debugtrap() = ccall("llvm.debugtrap", llvmcall, Cvoid, ())

@device_function @inline sendmsg(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsg", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@device_function @inline sendmsghalt(x1, x2=Int32(0)) = ccall("llvm.amdgcn.s.sendmsghalt", llvmcall, Cvoid, (Int32, Int32), x1, x2)
@device_function @inline endpgm() = ccall("llvm.amdgcn.endpgm", llvmcall, Cvoid, ())
