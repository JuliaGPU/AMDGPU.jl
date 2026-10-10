module Device

using ..BFloat16s
using ..GPUCompiler
using ..LLVM, ..LLVM.IR, ..LLVM.Build
using ..LLVM.Interop

import ..Adapt
import Core: LLVMPtr
import ..LinearAlgebra

import ..HSA
import ..HIP
import ..Runtime
import ..Mem
import ..AMDGPU
import .AMDGPU: method_table
import .AMDGPU: aligned_sizeof
import .AMDGPU: libhsaruntime
import ..UnsafeAtomics

@inline function use_emulated_signals()
    if haskey(ENV, "JULIA_AMDGPU_FORCE_EMULATED_SIGNALS")
        return parse(Bool, ENV["JULIA_AMDGPU_FORCE_EMULATED_SIGNALS"])
    end
    return isempty(libhsaruntime)
end

include("addrspaces.jl")
include("strings.jl")
include("exceptions.jl")
include("gcn.jl")
include("runtime.jl")
include("quirks.jl")
include("random.jl")

end
