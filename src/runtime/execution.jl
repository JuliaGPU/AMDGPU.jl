## Abstract kernels for host-side and device-side launch

abstract type AbstractKernel{F,TT} end

# FIXME: there doesn't seem to be a way to access the documentation for the call-syntax,
#        so attach it to the type -- https://github.com/JuliaDocs/Documenter.jl/issues/558

"""
    (::HostKernel)(args...; kwargs...)
    (::DeviceKernel)(args...; kwargs...)

Low-level interface to call a compiled kernel, passing GPU-compatible arguments in `args`.
For a higher-level interface, use [`AMDGPU.@roc`](@ref).

The following keyword arguments are supported:
- `groupsize` (defaults to `1`) or `threads` (CUDA.jl compatibility shim)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `gridsize` (defaults to `1`)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `blocks` (CUDA.jl compatibility shim)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `config`: callback function to dynamically compute the launch configuration.
  should accept a `HostKernel` and return a name tuple with any of the above as fields.
- `queue` (defaults to the default queue)
"""
AbstractKernel
