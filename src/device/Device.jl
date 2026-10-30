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
import ..UnsafeAtomics
import GPUToolbox

const EMULATED_SIGNALS = Ref{Bool}(false)

@inline use_emulated_signals() = EMULATED_SIGNALS[]
include("addrspaces.jl")
include("strings.jl")
include("exceptions.jl")
include("gcn.jl")
include("runtime.jl")
include("quirks.jl")
include("random.jl")

end
