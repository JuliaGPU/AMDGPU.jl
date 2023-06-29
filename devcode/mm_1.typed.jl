CodeInfo(
    @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:370 within `mm`
   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `#dm_alloc`
1 ─│     $(Expr(:foreigncall, "extern __ockl_dm_alloc", Ptr{Nothing}, svec(UInt64), 0, :(:llvmcall), 0x0000000000000080, 0x0000000000000080))::Ptr{Nothing}
│  └
│   @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:372 within `mm`
└──     return nothing
) => Nothing
