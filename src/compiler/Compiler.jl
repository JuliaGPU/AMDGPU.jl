module Compiler

import Core: LLVMPtr

using ..GPUCompiler
using ..LLVM, ..LLVM.IR, ..LLVM.Build, ..LLVM.Passes
using Printf

import GPUToolbox
import GPUToolbox: @gcsafe_ccall

import AMDGPU_LLVM_Backend_jll # used for linking; GPUCompiler uses the in-tree backend otherwise
# `libamdgpu` only exists on platforms the JLL has an artifact for (not macOS)
if AMDGPU_LLVM_Backend_jll.is_available()
    using AMDGPU_LLVM_Backend_jll: libamdgpu
end

import ..AMDGPU
import ..AMDGPU: AS
import ..Runtime
import ..Device
import ..HIP
import ..Mem

include("zeroinit_lds.jl")
include("device_libs.jl")
include("output_context.jl")
include("dynamic_memory.jl")
include("codegen.jl")

end
