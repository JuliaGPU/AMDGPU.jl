CodeInfo(
     @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:361 within `conv`
    ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:82 within `#getindex`
1 ──│       goto #6 if not true
    │┌ @ abstractarray.jl:707 within `checkbounds`
2 ──││ %2  = Core.tuple(1)::Tuple{Int64}
│   ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│   ││┌ @ abstractarray.jl:382 within `eachindex`
│   │││┌ @ abstractarray.jl:133 within `axes1`
│   ││││┌ @ abstractarray.jl:98 within `axes`
│   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
│   ││││││┌ @ Base.jl:37 within `getproperty`
│   │││││││ %3  = Base.getfield(y, :shape)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:273 within `map`
│   ││││││┌ @ tuple.jl:29 within `getindex`
│   │││││││ %4  = Base.getfield(%3, 1, true)::Int64
│   ││││││└
│   ││││││┌ @ range.jl:459 within `oneto`
│   │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│   ││││││││┌ @ promotion.jl:510 within `max`
│   │││││││││┌ @ int.jl:83 within `<`
│   ││││││││││ %5  = Base.slt_int(%4, 0)::Bool
│   │││││││││└
│   │││││││││┌ @ essentials.jl:575 within `ifelse`
│   ││││││││││ %6  = Core.ifelse(%5, 0, %4)::Int64
│   ││└└└└└└└└
│   ││┌ @ abstractarray.jl:768 within `checkindex`
│   │││┌ @ int.jl:488 within `<=`
│   ││││ %7  = Base.sle_int(1, %6)::Bool
│   │││└
│   │││┌ @ bool.jl:38 within `&`
│   ││││ %8  = Base.and_int(true, %7)::Bool
│   ││└└
│   ││ @ abstractarray.jl:709 within `checkbounds`
└───││       goto #4 if not %8
    ││ @ abstractarray.jl:710 within `checkbounds`
3 ──││       goto #5
    ││ @ abstractarray.jl:709 within `checkbounds`
4 ──││       invoke Base.throw_boundserror(y::AMDGPU.Device.ROCDeviceVector{Float32, 1}, %2::Tuple{Int64})::Union{}
└───││       unreachable
5 ──││       nothing::Nothing
    │└
    │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
    │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
    ││┌ @ Base.jl:37 within `getproperty`
6 ┄─│││ %14 = Base.getfield(y, :ptr)::Core.LLVMPtr{Float32, 1}
│   │└└
│   │┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:85 within `unsafe_load`
│   ││┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:9 within `pointerref`
│   │││┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/base.jl:39
│   ││││ %15 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(1)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %3 = getelementptr inbounds float, float addrspace(1)* %2, i64 %1\n  %4 = load float, float addrspace(1)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││ %16 = Base.llvmcall(%15, Float32, Tuple{Core.LLVMPtr{Float32, 1}, Int64}, %14, 0)::Float32
│   │└└└
└───│       goto #7
    └
    ┌ @ float.jl:876 within `UInt32`
    │┌ @ float.jl:536 within `<=`
7 ──││ %18 = Base.le_float(0.0f0, %16)::Bool
│   │└
└───│       goto #9 if not %18
    │┌ @ float.jl:536 within `<=`
8 ──││ %20 = Base.le_float(%16, 4.2949673f9)::Bool
│   │└
└───│       goto #10
9 ──│       nothing::Nothing
10 ┄│ %23 = φ (#8 => %20, #9 => false)::Bool
└───│       goto #13 if not %23
    │┌ @ float.jl:392 within `round`
11 ─││ %25 = Base.trunc_llvm(%16)::Float32
│   │└
│   │┌ @ float.jl:533 within `==`
│   ││ %26 = Base.eq_float(%25, %16)::Bool
│   │└
└───│       goto #13 if not %26
    │ @ float.jl:877 within `UInt32`
    │┌ @ float.jl:340 within `unsafe_trunc`
12 ─││ %28 = Base.fptoui(UInt32, %16)::UInt32
│   │└
└───│       goto #14
    │ @ float.jl:879 within `UInt32`
13 ┄│ %30 = invoke Base.InexactError(:UInt32::Symbol, UInt32::Any, %16::Any)::InexactError
│   │       Base.throw(%30)::Union{}
└───│       unreachable
    └
    ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
14 ─│       goto #19 if not true
    │┌ @ abstractarray.jl:707 within `checkbounds`
15 ─││ %34 = Core.tuple(1)::Tuple{Int64}
│   ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│   ││┌ @ abstractarray.jl:382 within `eachindex`
│   │││┌ @ abstractarray.jl:133 within `axes1`
│   ││││┌ @ abstractarray.jl:98 within `axes`
│   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
│   ││││││┌ @ Base.jl:37 within `getproperty`
│   │││││││ %35 = Base.getfield(x, :shape)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:273 within `map`
│   ││││││┌ @ tuple.jl:29 within `getindex`
│   │││││││ %36 = Base.getfield(%35, 1, true)::Int64
│   ││││││└
│   ││││││┌ @ range.jl:459 within `oneto`
│   │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│   ││││││││┌ @ promotion.jl:510 within `max`
│   │││││││││┌ @ int.jl:83 within `<`
│   ││││││││││ %37 = Base.slt_int(%36, 0)::Bool
│   │││││││││└
│   │││││││││┌ @ essentials.jl:575 within `ifelse`
│   ││││││││││ %38 = Core.ifelse(%37, 0, %36)::Int64
│   ││└└└└└└└└
│   ││┌ @ abstractarray.jl:768 within `checkindex`
│   │││┌ @ int.jl:488 within `<=`
│   ││││ %39 = Base.sle_int(1, %38)::Bool
│   │││└
│   │││┌ @ bool.jl:38 within `&`
│   ││││ %40 = Base.and_int(true, %39)::Bool
│   ││└└
│   ││ @ abstractarray.jl:709 within `checkbounds`
└───││       goto #17 if not %40
    ││ @ abstractarray.jl:710 within `checkbounds`
16 ─││       goto #18
    ││ @ abstractarray.jl:709 within `checkbounds`
17 ─││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{UInt32, 1}, %34::Tuple{Int64})::Union{}
└───││       unreachable
18 ─││       nothing::Nothing
    │└
    │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
    │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
    ││┌ @ Base.jl:37 within `getproperty`
19 ┄│││ %46 = Base.getfield(x, :ptr)::Core.LLVMPtr{UInt32, 1}
│   │└└
│   │┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:88 within `unsafe_store!`
│   ││┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:46 within `pointerset`
│   │││┌ @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/RFlwq/src/interop/base.jl:39
│   ││││ %47 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i32 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to i32 addrspace(1)*\n  %4 = getelementptr inbounds i32, i32 addrspace(1)* %3, i64 %2\n  store i32 %1, i32 addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%47, Nothing, Tuple{Core.LLVMPtr{UInt32, 1}, UInt32, Int64}, %46, %28, 0)::Nothing
│   │└└└
│   │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└───│       goto #20
    └
     @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:362 within `conv`
20 ─       return nothing
) => Nothing
