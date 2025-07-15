CodeInfo(
     @ /home/pxlth/.julia/dev/t.jl:6 within `ker!`
    ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:80 within `#getindex`
1 ──│ %1  = $(Expr(:boundscheck, true))::Bool
└───│       goto #6 if not %1
    │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
    ││┌ @ abstractarray.jl:389 within `eachindex`
    │││┌ @ abstractarray.jl:137 within `axes1`
    ││││┌ @ abstractarray.jl:98 within `axes`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
    ││││││┌ @ Base.jl:49 within `getproperty`
2 ──│││││││ %3  = Base.getfield(x, :dims)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:355 within `map`
│   ││││││┌ @ tuple.jl:31 within `getindex`
│   │││││││ %4  = $(Expr(:boundscheck, true))::Bool
│   │││││││ %5  = Base.getfield(%3, 1, %4)::Int64
│   ││└└└└└
│   ││┌ @ abstractarray.jl:754 within `checkindex`
│   │││┌ @ essentials.jl:668 within `unsigned`
│   ││││┌ @ essentials.jl:730 within `reinterpret`
│   │││││ %6  = Base.bitcast(UInt64, %5)::UInt64
│   │││└└
│   │││┌ @ int.jl:513 within `<`
│   ││││ %7  = Base.ult_int(0x0000000000000000, %6)::Bool
│   ││└└
│   ││ @ abstractarray.jl:699 within `checkbounds`
└───││       goto #4 if not %7
3 ──││       goto #5
4 ──││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int64, 1}, (1,)::Tuple{Int64})::Union{}
└───││       unreachable
5 ──││       nothing::Nothing
    │└
    │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:81 within `#getindex`
    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
    │││┌ @ Base.jl:49 within `getproperty`
6 ┄─││││ %13 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int64, 1}
│   │└└└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:85 within `unsafe_load`
│   ││┌ @ none within `pointerref`
│   │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %14 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i64 @entry(i8 addrspace(1)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(1)* %0 to i64 addrspace(1)*\n  %3 = getelementptr inbounds i64, i64 addrspace(1)* %2, i64 %1\n  %4 = load i64, i64 addrspace(1)* %3, align 8, !tbaa !0\n  ret i64 %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││ %15 = Base.llvmcall(%14, Int64, Tuple{Core.LLVMPtr{Int64, 1}, Int64}, %13, 0)::Int64
└───││││       goto #7
    └└└└
    ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `#setindex!`
7 ──│ %17 = $(Expr(:boundscheck, true))::Bool
└───│       goto #12 if not %17
    │┌ @ abstractarray.jl:697 within `checkbounds`
8 ──││ %19 = Core.tuple(0)::Tuple{Int64}
│   ││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│   ││┌ @ abstractarray.jl:389 within `eachindex`
│   │││┌ @ abstractarray.jl:137 within `axes1`
│   ││││┌ @ abstractarray.jl:98 within `axes`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
│   ││││││┌ @ Base.jl:49 within `getproperty`
│   │││││││ %20 = Base.getfield(x, :dims)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:355 within `map`
│   ││││││┌ @ tuple.jl:31 within `getindex`
│   │││││││ %21 = $(Expr(:boundscheck, true))::Bool
│   │││││││ %22 = Base.getfield(%20, 1, %21)::Int64
│   ││└└└└└
│   ││┌ @ abstractarray.jl:754 within `checkindex`
│   │││┌ @ int.jl:86 within `-`
│   ││││ %23 = Base.sub_int(0, 1)::Int64
│   │││└
│   │││┌ @ essentials.jl:668 within `unsigned`
│   ││││┌ @ essentials.jl:730 within `reinterpret`
│   │││││ %24 = Base.bitcast(UInt64, %23)::UInt64
│   │││││ @ essentials.jl:730 within `reinterpret`
│   │││││ %25 = Base.bitcast(UInt64, %22)::UInt64
│   │││└└
│   │││┌ @ int.jl:513 within `<`
│   ││││ %26 = Base.ult_int(%24, %25)::Bool
│   ││└└
│   ││ @ abstractarray.jl:699 within `checkbounds`
└───││       goto #10 if not %26
9 ──││       goto #11
10 ─││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int64, 1}, %19::Tuple{Int64})::Union{}
└───││       unreachable
11 ─││       nothing::Nothing
    │└
    │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#setindex!`
    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
    │││┌ @ Base.jl:49 within `getproperty`
12 ┄││││ %32 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int64, 1}
│   │└└└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!`
│   ││┌ @ none within `pointerset`
│   │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %33 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to i64 addrspace(1)*\n  %4 = getelementptr inbounds i64, i64 addrspace(1)* %3, i64 %2\n  store i64 %1, i64 addrspace(1)* %4, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││┌ @ int.jl:86 within `-`
│   │││││ %34 = Base.sub_int(0, 1)::Int64
│   ││││└
│   ││││       Base.llvmcall(%33, Nothing, Tuple{Core.LLVMPtr{Int64, 1}, Int64, Int64}, %32, %15, %34)::Nothing
│   │└└└
│   │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#setindex!`
└───│       goto #13
    └
     @ /home/pxlth/.julia/dev/t.jl:7 within `ker!`
13 ─       return nothing
) => Nothing
