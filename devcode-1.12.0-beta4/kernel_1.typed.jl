CodeInfo(
     @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
    ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
    ││┌ @ none within `kernel_state`
    │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
1 ──││││ %1   =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @entry() #0 {\nentry:\n  %state = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter()\n  ret { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state\n}\n\n; Function Attrs: readnone\ndeclare { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││ %2   = intrinsic (Core.Intrinsics.llvmcall)(%1, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││└└
│   ││┌ @ Base_compiler.jl:54 within `getproperty`
│   │││ %3   =   builtin Base.getfield(%2, :output_context)::Ptr{Nothing}
│   ││└
│   ││┌ @ pointer.jl:30 within `convert`
│   │││ %4   = intrinsic Base.bitcast(Ptr{AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}}, %3)::Ptr{AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}}
│   ││└
│   ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:73 within `output_context`
│   ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54 within `alloc_local` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││ %5   =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n@alloc_special___print_hostcall = external addrspace(3) global [1 x i64], align 32\n\n; Function Attrs: alwaysinline\ndefine ptr addrspace(3) @entry() #0 {\nentry:\n  ret ptr addrspace(3) @alloc_special___print_hostcall\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   │││││ %6   = intrinsic (Core.Intrinsics.llvmcall)(%5, Core.LLVMPtr{UInt64, 3}, Tuple{})::Core.LLVMPtr{UInt64, 3}
│   ││└└└
│   ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
│   ││┌ @ essentials.jl:733 within `reinterpret`
│   │││ %7   = intrinsic Base.bitcast(UInt64, %4)::UInt64
│   ││└
│   ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
│   │││┌ @ none within `pointerset`
│   ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││ %8   =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(ptr addrspace(3) %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = getelementptr inbounds i64, ptr addrspace(3) %0, i64 %2\n  store i64 %1, ptr addrspace(3) %3, align 1, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(3)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   │││││        intrinsic (Core.Intrinsics.llvmcall)(%8, Nothing, Tuple{Core.LLVMPtr{UInt64, 3}, UInt64, Int64}, %6, %7, 0)::Nothing
│   │└└└└
│   │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
│   │┌ @ pointer.jl:151 within `unsafe_load` @ pointer.jl:151
│   ││ %10  = intrinsic Base.pointerref(%4, 1, 1)::AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}
│   │└
│   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %11  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││ %12  = intrinsic (Core.Intrinsics.llvmcall)(%11, UInt32, Tuple{})::UInt32
│   │││││└└
│   │││││┌ @ int.jl:863 within `+` @ int.jl:87
│   ││││││ %13  = intrinsic Base.add_int(%12, 0x00000001)::UInt32
│   ││││└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %14  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        intrinsic (Core.Intrinsics.llvmcall)(%14, UInt32, Tuple{})::UInt32
│   ││││└└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %16  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        intrinsic (Core.Intrinsics.llvmcall)(%16, UInt32, Tuple{})::UInt32
│   │││└└└└
│   │││┌ @ operators.jl:321 within `!=`
│   ││││┌ @ int.jl:524 within `==` @ promotion.jl:487
│   │││││┌ @ promotion.jl:404 within `promote`
│   ││││││┌ @ promotion.jl:379 within `_promote`
│   │││││││┌ @ number.jl:7 within `convert`
│   ││││││││┌ @ boot.jl:962 within `UInt64`
│   │││││││││┌ @ boot.jl:936 within `toUInt64`
│   ││││││││││ %18  = intrinsic Core.zext_int(Core.UInt64, %13)::UInt64
│   │││││└└└└└
│   │││││ @ int.jl:524 within `==` @ promotion.jl:487 @ promotion.jl:637
│   │││││ %19  =   builtin (%18 === 0x0000000000000001)::Bool
│   │││││ @ int.jl:524 within `==`
│   │││││┌ @ bool.jl:40 within `&`
│   ││││││ %20  = intrinsic Base.and_int(true, %19)::Bool
│   ││││└└
│   ││││┌ @ bool.jl:37 within `!`
│   │││││ %21  = intrinsic Base.not_int(%20)::Bool
│   │││└└
└───│││        goto #3 if not %21
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
2 ──│││        goto #13
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
    │││┌ @ Base_compiler.jl:54 within `getproperty`
3 ──││││ %24  =   builtin Base.getfield(%10, :signal_handle)::UInt64
    │││└
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
4 ┄─│││││ %25  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_cas", Int64, svec(UInt64, Int64, Int64, Int32), 0, :(:llvmcall), :(%24), 0, 1, 4, 4, 1, 0, :(%24)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
│   ││││┌ @ promotion.jl:637 within `==`
│   │││││ %26  =   builtin (%25 === AMDGPU.Device.READY_SENTINEL)::Bool
│   ││││└
└───││││        goto #6 if not %26
5 ──││││        goto #11
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
    ││││┌ @ promotion.jl:637 within `==`
6 ──│││││ %29  =   builtin (%25 === AMDGPU.Device.DEVICE_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #8 if not %29
7 ──││││        goto #9
    ││││┌ @ promotion.jl:637 within `==`
8 ──│││││ %32  =   builtin (%25 === AMDGPU.Device.HOST_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #10 if not %32
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
9 ┄─││││││││ %34  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @entry() #0 {\nentry:\n  %state = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter()\n  ret { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state\n}\n\n; Function Attrs: readnone\ndeclare { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %35  = intrinsic (Core.Intrinsics.llvmcall)(%34, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base_compiler.jl:54 within `getproperty`
│   │││││││ %36  =   builtin Base.getfield(%35, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
│   ││││││        intrinsic Base.pointerset(%36, 1, 1, 1)::Ptr{Int32}
│   │││││└
│   │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
└───││││││        $(Expr(:foreigncall, "llvm.amdgcn.endpgm", Nothing, svec(), 0, :(:llvmcall)))::Nothing
    ││││└└
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
10 ┄│││││        $(Expr(:foreigncall, "llvm.amdgcn.s.sleep", Nothing, svec(Int32), 0, :(:llvmcall), 5, 5))::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
└───││││        goto #4
11 ─││││        goto #12
12 ─││││        nothing::Nothing
    │││└
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
13 ┄│││││        intrinsic (Core.Intrinsics.llvmcall)(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
│   ││││        $(Expr(:foreigncall, "llvm.amdgcn.s.barrier", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
│   │││││        intrinsic (Core.Intrinsics.llvmcall)(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
└───│││││        goto #14
14 ─│││││        goto #15
    │└└└└
    │┌ @ none within `alloc_string`
    ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
15 ─│││ %48  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n@0 = private unnamed_addr constant [13 x i8] c\"Hello World!\\00\", align 1\n\n; Function Attrs: alwaysinline\ndefine ptr addrspace(1) @entry() #0 {\nentry:\n  ret ptr addrspace(1) addrspacecast (ptr @0 to ptr addrspace(1))\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   │││ %49  = intrinsic (Core.Intrinsics.llvmcall)(%48, Core.LLVMPtr{UInt8, 1}, Tuple{})::Core.LLVMPtr{UInt8, 1}
│   │└└
│   │┌ @ Base_compiler.jl:54 within `getproperty`
│   ││ %50  =   builtin Base.getfield(%10, :buf_ptr)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:147 within `+`
│   ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `add_ptr`
│   │││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %51  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine ptr addrspace(1) @entry(ptr addrspace(1) %0, i64 %1) #0 {\nentry:\n  %2 = getelementptr i8, ptr addrspace(1) %0, i64 %1\n  ret ptr addrspace(1) %2\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   ││││ %52  = intrinsic (Core.Intrinsics.llvmcall)(%51, Core.LLVMPtr{UInt8, 1}, Tuple{Core.LLVMPtr{UInt8, 1}, Int64}, %50, 0)::Core.LLVMPtr{UInt8, 1}
│   │└└└
│   │┌ @ none within `memcpy!`
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││ %53  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(ptr addrspace(1) %0, ptr addrspace(1) %1, i64 %2) #0 {\nentry:\n  call void @llvm.memcpy.p1i8.p1i8.i64(ptr addrspace(1) %0, ptr addrspace(1) %1, i64 %2, i1 false)\n  ret void\n}\n\n; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)\ndeclare void @llvm.memcpy.p1i8.p1i8.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }\n", "entry")::Tuple{String, String}
│   │││        intrinsic (Core.Intrinsics.llvmcall)(%53, Nothing, Tuple{Core.LLVMPtr{UInt8, 1}, Core.LLVMPtr{UInt8, 1}, Int64}, %52, %49, 12)::Nothing
│   │└└
│   │┌ @ Base_compiler.jl:54 within `getproperty`
│   ││ %55  =   builtin Base.getfield(%10, :buf_ptr)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ essentials.jl:733 within `reinterpret`
│   ││ %56  = intrinsic Base.bitcast(Core.LLVMPtr{UInt8, 1}, %55)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
│   ││┌ @ none within `pointerset`
│   │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %57  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(ptr addrspace(1) %0, i8 %1, i64 %2) #0 {\nentry:\n  %3 = getelementptr inbounds i8, ptr addrspace(1) %0, i64 %2\n  store i8 %1, ptr addrspace(1) %3, align 1, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││        intrinsic (Core.Intrinsics.llvmcall)(%57, Nothing, Tuple{Core.LLVMPtr{UInt8, 1}, UInt8, Int64}, %56, 0x00, 12)::Nothing
│   │└└└
│   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %59  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││ %60  = intrinsic (Core.Intrinsics.llvmcall)(%59, UInt32, Tuple{})::UInt32
│   │││││└└
│   │││││┌ @ int.jl:863 within `+` @ int.jl:87
│   ││││││ %61  = intrinsic Base.add_int(%60, 0x00000001)::UInt32
│   ││││└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %62  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        intrinsic (Core.Intrinsics.llvmcall)(%62, UInt32, Tuple{})::UInt32
│   ││││└└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %64  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        intrinsic (Core.Intrinsics.llvmcall)(%64, UInt32, Tuple{})::UInt32
│   │││└└└└
│   │││┌ @ operators.jl:321 within `!=`
│   ││││┌ @ int.jl:524 within `==` @ promotion.jl:487
│   │││││┌ @ promotion.jl:404 within `promote`
│   ││││││┌ @ promotion.jl:379 within `_promote`
│   │││││││┌ @ number.jl:7 within `convert`
│   ││││││││┌ @ boot.jl:962 within `UInt64`
│   │││││││││┌ @ boot.jl:936 within `toUInt64`
│   ││││││││││ %66  = intrinsic Core.zext_int(Core.UInt64, %61)::UInt64
│   │││││└└└└└
│   │││││ @ int.jl:524 within `==` @ promotion.jl:487 @ promotion.jl:637
│   │││││ %67  =   builtin (%66 === 0x0000000000000001)::Bool
│   │││││ @ int.jl:524 within `==`
│   │││││┌ @ bool.jl:40 within `&`
│   ││││││ %68  = intrinsic Base.and_int(true, %67)::Bool
│   ││││└└
│   ││││┌ @ bool.jl:37 within `!`
│   │││││ %69  = intrinsic Base.not_int(%68)::Bool
│   │││└└
└───│││        goto #17 if not %69
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
16 ─│││        goto #36
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
    │││┌ @ Base_compiler.jl:54 within `getproperty`
17 ─││││ %72  =   builtin Base.getfield(%10, :signal_handle)::UInt64
    │││└
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
18 ┄│││││ %73  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_cas", Int64, svec(UInt64, Int64, Int64, Int32), 0, :(:llvmcall), :(%72), 1, 2, 4, 4, 2, 1, :(%72)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
│   ││││┌ @ promotion.jl:637 within `==`
│   │││││ %74  =   builtin (%73 === 1)::Bool
│   ││││└
└───││││        goto #20 if not %74
19 ─││││        goto #25
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
    ││││┌ @ promotion.jl:637 within `==`
20 ─│││││ %77  =   builtin (%73 === AMDGPU.Device.DEVICE_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #22 if not %77
21 ─││││        goto #23
    ││││┌ @ promotion.jl:637 within `==`
22 ─│││││ %80  =   builtin (%73 === AMDGPU.Device.HOST_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #24 if not %80
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
23 ┄││││││││ %82  =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @entry() #0 {\nentry:\n  %state = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter()\n  ret { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state\n}\n\n; Function Attrs: readnone\ndeclare { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %83  = intrinsic (Core.Intrinsics.llvmcall)(%82, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base_compiler.jl:54 within `getproperty`
│   │││││││ %84  =   builtin Base.getfield(%83, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
│   ││││││        intrinsic Base.pointerset(%84, 1, 1, 1)::Ptr{Int32}
│   │││││└
│   │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
└───││││││        $(Expr(:foreigncall, "llvm.amdgcn.endpgm", Nothing, svec(), 0, :(:llvmcall)))::Nothing
    ││││└└
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
24 ┄│││││        $(Expr(:foreigncall, "llvm.amdgcn.s.sleep", Nothing, svec(Int32), 0, :(:llvmcall), 5, 5))::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
└───││││        goto #18
25 ─││││        goto #26
    │││└
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
    │││┌ @ Base_compiler.jl:54 within `getproperty`
26 ─││││ %90  =   builtin Base.getfield(%10, :signal_handle)::UInt64
    │││└
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
27 ┄│││││ %91  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_load", Int64, svec(UInt64, Int32), 0, :(:llvmcall), :(%90), 2, 2, :(%90)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
│   ││││┌ @ promotion.jl:637 within `==`
│   │││││ %92  =   builtin (%91 === 4)::Bool
│   ││││└
└───││││        goto #29 if not %92
28 ─││││        goto #34
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
    ││││┌ @ promotion.jl:637 within `==`
29 ─│││││ %95  =   builtin (%91 === AMDGPU.Device.DEVICE_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #31 if not %95
30 ─││││        goto #32
    ││││┌ @ promotion.jl:637 within `==`
31 ─│││││ %98  =   builtin (%91 === AMDGPU.Device.HOST_ERR_SENTINEL)::Bool
│   ││││└
└───││││        goto #33 if not %98
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
32 ┄││││││││ %100 =   builtin Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @entry() #0 {\nentry:\n  %state = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter()\n  ret { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state\n}\n\n; Function Attrs: readnone\ndeclare { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %101 = intrinsic (Core.Intrinsics.llvmcall)(%100, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base_compiler.jl:54 within `getproperty`
│   │││││││ %102 =   builtin Base.getfield(%101, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
│   ││││││        intrinsic Base.pointerset(%102, 1, 1, 1)::Ptr{Int32}
│   │││││└
│   │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
└───││││││        $(Expr(:foreigncall, "llvm.amdgcn.endpgm", Nothing, svec(), 0, :(:llvmcall)))::Nothing
    ││││└└
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
33 ┄│││││        $(Expr(:foreigncall, "llvm.amdgcn.s.sleep", Nothing, svec(Int32), 0, :(:llvmcall), 5, 5))::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
└───││││        goto #27
34 ─││││        goto #35
    │││└
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
    │││┌ @ Base_compiler.jl:54 within `getproperty`
35 ─││││ %108 =   builtin Base.getfield(%10, :signal_handle)::UInt64
│   │││└
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
└───││││        $(Expr(:foreigncall, "extern __ockl_hsa_signal_store", Int64, svec(UInt64, Int64, Int32), 0, :(:llvmcall), :(%108), 0, 3, 3, 0, :(%108)))::Int64
    │││└
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
36 ┄│││││        intrinsic (Core.Intrinsics.llvmcall)(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
│   ││││        $(Expr(:foreigncall, "llvm.amdgcn.s.barrier", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
│   │││││        intrinsic (Core.Intrinsics.llvmcall)(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
└───│││││        goto #37
37 ─│││││        goto #38
38 ─│││││        return Main.nothing
    └└└└└
) => Nothing
