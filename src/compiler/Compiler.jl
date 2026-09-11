module Compiler

import Core: LLVMPtr

using ..GPUCompiler
using ..LLVM
using Printf

import AMDGPU_LLVM_Backend_jll # used for linking; GPUCompiler uses the in-tree backend otherwise
using AMDGPU_LLVM_Backend_jll: libamdgpu

import ..AMDGPU
import ..AMDGPU: AS
import ..Runtime
import ..Device
import ..HIP
import ..Mem

include("zeroinit_lds.jl")
include("device_libs.jl")
include("exceptions.jl")
include("output_context.jl")
include("dynamic_memory.jl")
include("codegen.jl")

end
