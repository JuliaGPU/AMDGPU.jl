CodeInfo(
    @ /home/pxlth/.julia/dev/t.jl:4 within `ker!`
   ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `setindex!`
1 ─│ %1  = $(Expr(:boundscheck, true))::Bool
└──│       goto #6 if not %1
   │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
   ││┌ @ abstractarray.jl:389 within `eachindex`
   │││┌ @ abstractarray.jl:137 within `axes1`
   ││││┌ @ abstractarray.jl:98 within `axes`
   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
   ││││││┌ @ Base_compiler.jl:54 within `getproperty`
2 ─│││││││ %3  =   builtin Base.getfield(x, :dims)::Tuple{Int64}
│  │││││└└
│  │││││┌ @ tuple.jl:358 within `map`
│  ││││││┌ @ tuple.jl:33 within `getindex`
│  │││││││ %4  = $(Expr(:boundscheck, true))::Bool
│  │││││││ %5  =   builtin Base.getfield(%3, 1, %4)::Int64
│  ││└└└└└
│  ││┌ @ abstractarray.jl:754 within `checkindex`
│  │││┌ @ essentials.jl:668 within `unsigned`
│  ││││┌ @ essentials.jl:733 within `reinterpret`
│  │││││ %6  = intrinsic Base.bitcast(UInt64, %5)::UInt64
│  │││└└
│  │││┌ @ int.jl:519 within `<`
│  ││││ %7  = intrinsic Base.ult_int(0xffffffffffffffff, %6)::Bool
│  ││└└
│  ││ @ abstractarray.jl:699 within `checkbounds`
└──││       goto #4 if not %7
3 ─││       goto #5
4 ─││          invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int64, 1}, (0,)::Tuple{Int64})::Union{}
└──││       unreachable
5 ─││       nothing::Nothing
   │└
   │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `setindex!`
   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
   ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
   │││┌ @ Base_compiler.jl:54 within `getproperty`
6 ┄││││ %13 =   builtin Base.getfield(x, :ptr)::Core.LLVMPtr{Int64, 1}
│  │└└└
│  │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!`
│  ││┌ @ none within `pointerset`
│  │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│  ││││ %14 =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(ptr addrspace(1) %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = getelementptr inbounds i64, ptr addrspace(1) %0, i64 %2\n  store i64 %1, ptr addrspace(1) %3, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│  ││││       intrinsic (Core.Intrinsics.llvmcall)(%14, Nothing, Tuple{Core.LLVMPtr{Int64, 1}, Int64, Int64}, %13, 1, -1)::Nothing
│  │└└└
│  │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `setindex!`
└──│       goto #7
   └
    @ /home/pxlth/.julia/dev/t.jl:5 within `ker!`
7 ─       return nothing
) => Nothing
