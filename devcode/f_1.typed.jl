CodeInfo(
    @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:364 within `f`
   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
1 ─│       goto #7 if not true
   │┌ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
   ││┌ @ abstractarray.jl:382 within `eachindex`
   │││┌ @ abstractarray.jl:133 within `axes1`
   ││││┌ @ abstractarray.jl:98 within `axes`
   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
   ││││││┌ @ Base.jl:37 within `getproperty`
2 ─│││││││ %2  = Base.getfield(x, :shape)::Tuple{Int64}
│  │││││└└
│  │││││┌ @ tuple.jl:273 within `map`
│  ││││││┌ @ tuple.jl:29 within `getindex`
│  │││││││ %3  = Base.getfield(%2, 1, true)::Int64
│  ││││││└
│  ││││││┌ @ range.jl:459 within `oneto`
│  │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│  ││││││││┌ @ promotion.jl:510 within `max`
│  │││││││││┌ @ int.jl:83 within `<`
│  ││││││││││ %4  = Base.slt_int(%3, 0)::Bool
│  │││││││││└
│  │││││││││┌ @ essentials.jl:575 within `ifelse`
│  ││││││││││ %5  = Core.ifelse(%4, 0, %3)::Int64
│  ││└└└└└└└└
│  ││┌ @ abstractarray.jl:768 within `checkindex`
│  │││┌ @ int.jl:488 within `<=`
│  ││││ %6  = Base.sle_int(2, %5)::Bool
│  │││└
│  │││┌ @ bool.jl:38 within `&`
│  ││││ %7  = Base.and_int(true, %6)::Bool
│  ││└└
│  ││ @ abstractarray.jl:709 within `checkbounds`
└──││       goto #4 if not %7
3 ─││       goto #5
   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:56 within `signal_exception`
   ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
   │││││┌ @ none within `kernel_state`
   ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
4 ─│││││││ %10 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { i64, i64, i64, i64, i64, i64, i32, i32 } @entry() #0 {\nentry:\n  %state = call { i64, i64, i64, i64, i64, i64, i32, i32 } @julia.gpu.state_getter()\n  ret { i64, i64, i64, i64, i64, i64, i32, i32 } %state\n}\n\n; Function Attrs: readnone\ndeclare { i64, i64, i64, i64, i64, i64, i32, i32 } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│  │││││││ %11 = Base.llvmcall(%10, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│  │││││└└
│  │││││┌ @ Base.jl:37 within `getproperty`
│  ││││││ %12 = Base.getfield(%11, :exception_flag)::Ptr{Int32}
│  ││││└└
│  ││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
│  │││││       Base.pointerset(%12, 1, 1, 1)::Ptr{Int32}
│  ││││└
│  ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:58 within `signal_exception`
│  ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
│  │││││       $(Expr(:foreigncall, "llvm.amdgcn.endpgm", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│  │││└└
│  │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
│  │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
└──││││       $(Expr(:foreigncall, "llvm.trap", Nothing, svec(), 0, :(:llvmcall)))::Nothing
   ││└└
   ││ @ abstractarray.jl:710 within `checkbounds`
5 ┄││       goto #6
6 ─││       nothing::Nothing
   │└
   │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
   ││┌ @ Base.jl:37 within `getproperty`
7 ┄│││ %18 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int32, 1}
│  │└└
│  │┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:88 within `unsafe_store!`
│  ││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `pointerset`
│  │││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
│  ││││ %19 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i32 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to i32 addrspace(1)*\n  %4 = getelementptr inbounds i32, i32 addrspace(1)* %3, i64 %2\n  store i32 %1, i32 addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│  ││││       Base.llvmcall(%19, Nothing, Tuple{Core.LLVMPtr{Int32, 1}, Int32, Int64}, %18, 1, 1)::Nothing
│  │└└└
│  │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└──│       goto #8
   └
    @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:365 within `f`
8 ─       return AMDGPU.nothing
) => Nothing
