CodeInfo(
    @ /home/pxlth/.julia/dev/AMDGPU/t.jl:4 within `ker!`
   ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43 within `sync_workgroup_or`
1 ─│ %1  = $(Expr(:foreigncall, "extern __ockl_wgred_or_i32", Int32, svec(Int32), 0, :(:llvmcall), 0, 0))::Int32
│  └
│  ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
│  │ %2  = $(Expr(:boundscheck, true))::Bool
└──│       goto #6 if not %2
2 ─│ %4  =   builtin Core.tuple(1)::Tuple{Int64}
│  │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│  ││┌ @ abstractarray.jl:389 within `eachindex`
│  │││┌ @ abstractarray.jl:137 within `axes1`
│  ││││┌ @ abstractarray.jl:98 within `axes`
│  │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
│  ││││││┌ @ Base_compiler.jl:55 within `getproperty`
│  │││││││ %5  =   builtin Base.getfield(x, :dims)::Tuple{Int64}
│  │││││└└
│  │││││┌ @ tuple.jl:358 within `map`
│  ││││││┌ @ tuple.jl:33 within `getindex`
│  │││││││ %6  = $(Expr(:boundscheck, true))::Bool
│  │││││││ %7  =   builtin Base.getfield(%5, 1, %6)::Int64
│  ││└└└└└
│  ││┌ @ abstractarray.jl:754 within `checkindex`
│  │││┌ @ int.jl:86 within `-`
│  ││││ %8  = intrinsic Base.sub_int(1, 1)::Int64
│  │││└
│  │││┌ @ essentials.jl:668 within `unsigned`
│  ││││┌ @ essentials.jl:731 within `reinterpret`
│  │││││ %9  = intrinsic Base.bitcast(UInt64, %8)::UInt64
│  │││││ %10 = intrinsic Base.bitcast(UInt64, %7)::UInt64
│  │││└└
│  │││┌ @ int.jl:519 within `<`
│  ││││ %11 = intrinsic Base.ult_int(%9, %10)::Bool
│  ││└└
│  ││ @ abstractarray.jl:699 within `checkbounds`
└──││       goto #4 if not %11
3 ─││       goto #5
4 ─││          invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int64, 1}, %4::Tuple{Int64})::Union{}
└──││       unreachable
5 ─││       nothing::Nothing
   │└
   │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:62 within `pointer`
   ││┌ @ Base_compiler.jl:55 within `getproperty`
6 ┄│││ %17 =   builtin Base.getfield(x, :ptr)::Core.LLVMPtr{Int64, 1}
│  │└└
│  │┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
│  ││┌ @ number.jl:7 within `convert`
│  │││┌ @ boot.jl:957 within `Int64`
│  ││││┌ @ boot.jl:876 within `toInt64`
│  │││││ %18 = intrinsic Core.sext_int(Core.Int64, %1)::Int64
│  ││└└└
│  ││┌ @ none within `pointerset`
│  │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│  ││││ %19 =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(ptr addrspace(1) %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = getelementptr inbounds i64, ptr addrspace(1) %0, i64 %2\n  store i64 %1, ptr addrspace(1) %3, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│  ││││┌ @ int.jl:86 within `-`
│  │││││ %20 = intrinsic Base.sub_int(1, 1)::Int64
│  ││││└
│  ││││       intrinsic (Core.Intrinsics.llvmcall)(%19, Nothing, Tuple{Core.LLVMPtr{Int64, 1}, Int64, Int64}, %17, %18, %20)::Nothing
│  │└└└
│  │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└──│       goto #7
   └
    @ /home/pxlth/.julia/dev/AMDGPU/t.jl:5 within `ker!`
7 ─       return nothing
) => Nothing
