module Device

using ..BFloat16s
using ..GPUCompiler
using ..LLVM
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
import ..UnsafeAtomics

include("addrspaces.jl")
include("globals.jl")
include("strings.jl")
include("exceptions.jl")
include("gcn.jl")
include("runtime.jl")
include("quirks.jl")
include("random.jl")

end
