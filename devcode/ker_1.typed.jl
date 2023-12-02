CodeInfo(
    @ REPL[2]:2 within `ker`
   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
1 ─│       goto #6 if not true
   │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:684
   ││┌ @ abstractarray.jl:386 within `eachindex`
   │││┌ @ abstractarray.jl:134 within `axes1`
   ││││┌ @ abstractarray.jl:98 within `axes`
   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
   ││││││┌ @ Base.jl:37 within `getproperty`
2 ─│││││││ %2  = Base.getfield(x, :shape)::Tuple{Int64}
│  │││││└└
│  │││││┌ @ tuple.jl:291 within `map`
│  ││││││┌ @ tuple.jl:31 within `getindex`
│  │││││││ %3  = Base.getfield(%2, 1, true)::Int64
│  ││││││└
│  ││││││┌ @ range.jl:469 within `oneto`
│  │││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│  ││││││││┌ @ promotion.jl:532 within `max`
│  │││││││││┌ @ int.jl:83 within `<`
│  ││││││││││ %4  = Base.slt_int(%3, 0)::Bool
│  │││││││││└
│  │││││││││┌ @ essentials.jl:642 within `ifelse`
│  ││││││││││ %5  = Core.ifelse(%4, 0, %3)::Int64
│  ││└└└└└└└└
│  ││┌ @ abstractarray.jl:760 within `checkindex`
│  │││┌ @ essentials.jl:519 within `unsigned`
│  ││││┌ @ essentials.jl:576 within `reinterpret`
│  │││││ %6  = Base.bitcast(UInt64, %5)::UInt64
│  │││└└
│  │││┌ @ int.jl:513 within `<`
│  ││││ %7  = Base.ult_int(0xffffffffffffffff, %6)::Bool
│  ││└└
│  ││ @ abstractarray.jl:699 within `checkbounds`
└──││       goto #4 if not %7
   ││ @ abstractarray.jl:700 within `checkbounds`
3 ─││       goto #5
   ││ @ abstractarray.jl:699 within `checkbounds`
4 ─││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int64, 1}, (0,)::Tuple{Int64})::Union{}
└──││       unreachable
5 ─││       nothing::Nothing
   │└
   │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
   ││┌ @ Base.jl:37 within `getproperty`
6 ┄│││ %13 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int64, 1}
│  │└└
│  │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!`
│  ││┌ @ none within `pointerset`
│  │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
│  ││││ %14 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to i64 addrspace(1)*\n  %4 = getelementptr inbounds i64, i64 addrspace(1)* %3, i64 %2\n  store i64 %1, i64 addrspace(1)* %4, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│  ││││       Base.llvmcall(%14, Nothing, Tuple{Core.LLVMPtr{Int64, 1}, Int64, Int64}, %13, 1, -1)::Nothing
│  │└└└
│  │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└──│       goto #7
   └
    @ REPL[2]:3 within `ker`
7 ─       return nothing
) => Nothing
