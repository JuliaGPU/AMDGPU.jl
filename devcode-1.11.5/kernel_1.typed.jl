CodeInfo(
     @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
    ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
    ││┌ @ none within `kernel_state`
    │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
1 ──││││ %1   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @entry() #0 {\nentry:\n  %state = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter()\n  ret { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state\n}\n\n; Function Attrs: readnone\ndeclare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││ %2   = Base.llvmcall(%1, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││└└
│   ││┌ @ Base.jl:49 within `getproperty`
│   │││ %3   = Base.getfield(%2, :output_context)::Ptr{Nothing}
│   ││└
│   ││┌ @ pointer.jl:30 within `convert`
│   │││ %4   = Base.bitcast(Ptr{AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}}, %3)::Ptr{AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}}
│   ││└
│   ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:73 within `output_context`
│   ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54 within `alloc_local` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││ %5   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n@alloc_special___print_hostcall = external addrspace(3) global [1 x i64], align 32\n\n; Function Attrs: alwaysinline\ndefine i8 addrspace(3)* @entry() #0 {\nentry:\n  ret i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special___print_hostcall to i8 addrspace(3)*)\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   │││││ %6   = Base.llvmcall(%5, Core.LLVMPtr{UInt64, 3}, Tuple{})::Core.LLVMPtr{UInt64, 3}
│   ││└└└
│   ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
│   ││┌ @ essentials.jl:730 within `reinterpret`
│   │││ %7   = Base.bitcast(UInt64, %4)::UInt64
│   ││└
│   ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
│   │││┌ @ none within `pointerset`
│   ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││ %8   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(3)* %0, i64 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(3)* %0 to i64 addrspace(3)*\n  %4 = getelementptr inbounds i64, i64 addrspace(3)* %3, i64 %2\n  store i64 %1, i64 addrspace(3)* %4, align 1, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(3)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   │││││        Base.llvmcall(%8, Nothing, Tuple{Core.LLVMPtr{UInt64, 3}, UInt64, Int64}, %6, %7, 0)::Nothing
│   │└└└└
│   │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
│   │┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
│   ││ %10  = Base.pointerref(%4, 1, 1)::AMDGPU.Device.HostCall{Nothing, Tuple{Core.LLVMPtr{AMDGPU.Device.DeviceStaticString{65536}, 1}}}
│   │└
│   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %11  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││ %12  = Base.llvmcall(%11, UInt32, Tuple{})::UInt32
│   │││││└└
│   │││││┌ @ int.jl:1013 within `+` @ int.jl:87
│   ││││││ %13  = Base.add_int(%12, 0x00000001)::UInt32
│   ││││└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %14  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        Base.llvmcall(%14, UInt32, Tuple{})::UInt32
│   ││││└└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %16  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        Base.llvmcall(%16, UInt32, Tuple{})::UInt32
│   │││└└└└
│   │││┌ @ operators.jl:277 within `!=`
│   ││││┌ @ int.jl:518 within `==` @ promotion.jl:483
│   │││││┌ @ promotion.jl:400 within `promote`
│   ││││││┌ @ promotion.jl:375 within `_promote`
│   │││││││┌ @ number.jl:7 within `convert`
│   ││││││││┌ @ boot.jl:897 within `UInt64`
│   │││││││││┌ @ boot.jl:871 within `toUInt64`
│   ││││││││││ %18  = Core.zext_int(Core.UInt64, %13)::UInt64
│   │││││└└└└└
│   │││││ @ int.jl:518 within `==` @ promotion.jl:483 @ promotion.jl:639
│   │││││ %19  = (%18 === 0x0000000000000001)::Bool
│   │││││ @ int.jl:518 within `==`
│   │││││┌ @ bool.jl:38 within `&`
│   ││││││ %20  = Base.and_int(true, %19)::Bool
│   ││││└└
│   ││││┌ @ bool.jl:35 within `!`
│   │││││ %21  = Base.not_int(%20)::Bool
│   │││└└
└───│││        goto #3 if not %21
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
2 ──│││        goto #13
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
    │││┌ @ Base.jl:49 within `getproperty`
3 ──││││ %24  = Base.getfield(%10, :signal_handle)::UInt64
│   │││└
└───│││ %25  = AMDGPU.Device.READY_SENTINEL::Int64
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
4 ┄─│││││ %26  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_cas", Int64, svec(UInt64, Int64, Int64, Int32), 0, :(:llvmcall), :(%24), 0, 1, 4, 4, 1, 0, :(%24)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %27  = (%26 === %25)::Bool
│   ││││└
└───││││        goto #6 if not %27
5 ──││││        goto #11
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
6 ──││││ %30  = AMDGPU.Device.DEVICE_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %31  = (%26 === %30)::Bool
│   ││││└
└───││││        goto #8 if not %31
7 ──││││        goto #9
8 ──││││ %34  = AMDGPU.Device.HOST_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %35  = (%26 === %34)::Bool
│   ││││└
└───││││        goto #10 if not %35
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
9 ┄─││││││││ %37  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @entry() #0 {\nentry:\n  %state = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter()\n  ret { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state\n}\n\n; Function Attrs: readnone\ndeclare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %38  = Base.llvmcall(%37, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base.jl:49 within `getproperty`
│   │││││││ %39  = Base.getfield(%38, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
│   ││││││        Base.pointerset(%39, 1, 1, 1)::Ptr{Int32}
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
13 ┄│││││        Base.llvmcall(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
│   ││││        $(Expr(:foreigncall, "llvm.amdgcn.s.barrier", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
│   │││││        Base.llvmcall(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   │││└└
│   │││ @ none within `macro expansion`
└───│││        goto #14
14 ─│││        goto #15
    │└└
    │┌ @ none within `alloc_string`
    ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
15 ─│││ %51  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n@0 = private unnamed_addr constant [13 x i8] c\"Hello World!\\00\", align 1\n\n; Function Attrs: alwaysinline\ndefine i8 addrspace(1)* @entry() #0 {\nentry:\n  ret i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([13 x i8], [13 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*)\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   │││ %52  = Base.llvmcall(%51, Core.LLVMPtr{UInt8, 1}, Tuple{})::Core.LLVMPtr{UInt8, 1}
│   │└└
│   │┌ @ Base.jl:49 within `getproperty`
│   ││ %53  = Base.getfield(%10, :buf_ptr)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:147 within `+`
│   ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `add_ptr`
│   │││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %54  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i8 addrspace(1)* @entry(i8 addrspace(1)* %0, i64 %1) #0 {\nentry:\n  %2 = getelementptr i8, i8 addrspace(1)* %0, i64 %1\n  ret i8 addrspace(1)* %2\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│   ││││ %55  = Base.llvmcall(%54, Core.LLVMPtr{UInt8, 1}, Tuple{Core.LLVMPtr{UInt8, 1}, Int64}, %53, 0)::Core.LLVMPtr{UInt8, 1}
│   │└└└
│   │┌ @ none within `memcpy!`
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││ %56  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i64 %2) #0 {\nentry:\n  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %0, i8 addrspace(1)* %1, i64 %2, i1 false)\n  ret void\n}\n\n; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)\ndeclare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }\n", "entry")::Tuple{String, String}
│   │││        Base.llvmcall(%56, Nothing, Tuple{Core.LLVMPtr{UInt8, 1}, Core.LLVMPtr{UInt8, 1}, Int64}, %55, %52, 12)::Nothing
│   │└└
│   │┌ @ Base.jl:49 within `getproperty`
│   ││ %58  = Base.getfield(%10, :buf_ptr)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ essentials.jl:730 within `reinterpret`
│   ││ %59  = Base.bitcast(Core.LLVMPtr{UInt8, 1}, %58)::Core.LLVMPtr{UInt8, 1}
│   │└
│   │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
│   ││┌ @ none within `pointerset`
│   │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   ││││ %60  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i8 %1, i64 %2) #0 {\nentry:\n  %3 = getelementptr inbounds i8, i8 addrspace(1)* %0, i64 %2\n  store i8 %1, i8 addrspace(1)* %3, align 1, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││        Base.llvmcall(%60, Nothing, Tuple{Core.LLVMPtr{UInt8, 1}, UInt8, Int64}, %59, 0x00, 12)::Nothing
│   │└└└
│   │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
│   ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %62  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││ %63  = Base.llvmcall(%62, UInt32, Tuple{})::UInt32
│   │││││└└
│   │││││┌ @ int.jl:1013 within `+` @ int.jl:87
│   ││││││ %64  = Base.add_int(%63, 0x00000001)::UInt32
│   ││││└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %65  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        Base.llvmcall(%65, UInt32, Tuple{})::UInt32
│   ││││└└└
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│   │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
│   │││││││ %67  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   │││││││        Base.llvmcall(%67, UInt32, Tuple{})::UInt32
│   │││└└└└
│   │││┌ @ operators.jl:277 within `!=`
│   ││││┌ @ int.jl:518 within `==` @ promotion.jl:483
│   │││││┌ @ promotion.jl:400 within `promote`
│   ││││││┌ @ promotion.jl:375 within `_promote`
│   │││││││┌ @ number.jl:7 within `convert`
│   ││││││││┌ @ boot.jl:897 within `UInt64`
│   │││││││││┌ @ boot.jl:871 within `toUInt64`
│   ││││││││││ %69  = Core.zext_int(Core.UInt64, %64)::UInt64
│   │││││└└└└└
│   │││││ @ int.jl:518 within `==` @ promotion.jl:483 @ promotion.jl:639
│   │││││ %70  = (%69 === 0x0000000000000001)::Bool
│   │││││ @ int.jl:518 within `==`
│   │││││┌ @ bool.jl:38 within `&`
│   ││││││ %71  = Base.and_int(true, %70)::Bool
│   ││││└└
│   ││││┌ @ bool.jl:35 within `!`
│   │││││ %72  = Base.not_int(%71)::Bool
│   │││└└
└───│││        goto #17 if not %72
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
16 ─│││        goto #36
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
    │││┌ @ Base.jl:49 within `getproperty`
17 ─││││ %75  = Base.getfield(%10, :signal_handle)::UInt64
    │││└
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
18 ┄│││││ %76  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_cas", Int64, svec(UInt64, Int64, Int64, Int32), 0, :(:llvmcall), :(%75), 1, 2, 4, 4, 2, 1, :(%75)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %77  = (%76 === 1)::Bool
│   ││││└
└───││││        goto #20 if not %77
19 ─││││        goto #25
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
20 ─││││ %80  = AMDGPU.Device.DEVICE_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %81  = (%76 === %80)::Bool
│   ││││└
└───││││        goto #22 if not %81
21 ─││││        goto #23
22 ─││││ %84  = AMDGPU.Device.HOST_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %85  = (%76 === %84)::Bool
│   ││││└
└───││││        goto #24 if not %85
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
23 ┄││││││││ %87  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @entry() #0 {\nentry:\n  %state = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter()\n  ret { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state\n}\n\n; Function Attrs: readnone\ndeclare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %88  = Base.llvmcall(%87, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base.jl:49 within `getproperty`
│   │││││││ %89  = Base.getfield(%88, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
│   ││││││        Base.pointerset(%89, 1, 1, 1)::Ptr{Int32}
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
    │││┌ @ Base.jl:49 within `getproperty`
26 ─││││ %95  = Base.getfield(%10, :signal_handle)::UInt64
    │││└
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
27 ┄│││││ %96  = $(Expr(:foreigncall, "extern __ockl_hsa_signal_load", Int64, svec(UInt64, Int32), 0, :(:llvmcall), :(%95), 2, 2, :(%95)))::Int64
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %97  = (%96 === 4)::Bool
│   ││││└
└───││││        goto #29 if not %97
28 ─││││        goto #34
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
29 ─││││ %100 = AMDGPU.Device.DEVICE_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %101 = (%96 === %100)::Bool
│   ││││└
└───││││        goto #31 if not %101
30 ─││││        goto #32
31 ─││││ %104 = AMDGPU.Device.HOST_ERR_SENTINEL::Int64
│   ││││┌ @ promotion.jl:639 within `==`
│   │││││ %105 = (%96 === %104)::Bool
│   ││││└
└───││││        goto #33 if not %105
    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
    ││││││┌ @ none within `kernel_state`
    │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
32 ┄││││││││ %107 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @entry() #0 {\nentry:\n  %state = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter()\n  ret { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state\n}\n\n; Function Attrs: readnone\ndeclare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { readnone }\n", "entry")::Tuple{String, String}
│   ││││││││ %108 = Base.llvmcall(%107, AMDGPU.KernelState, Tuple{})::AMDGPU.KernelState
│   ││││││└└
│   ││││││┌ @ Base.jl:49 within `getproperty`
│   │││││││ %109 = Base.getfield(%108, :exception_flag)::Ptr{Int32}
│   │││││└└
│   │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
│   ││││││        Base.pointerset(%109, 1, 1, 1)::Ptr{Int32}
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
    │││┌ @ Base.jl:49 within `getproperty`
35 ─││││ %115 = Base.getfield(%10, :signal_handle)::UInt64
│   │││└
│   │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
└───││││        $(Expr(:foreigncall, "extern __ockl_hsa_signal_store", Int64, svec(UInt64, Int64, Int32), 0, :(:llvmcall), :(%115), 0, 3, 3, 0, :(%115)))::Int64
    │││└
    │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
36 ┄│││││        Base.llvmcall(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   ││││└
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
│   ││││        $(Expr(:foreigncall, "llvm.amdgcn.s.barrier", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│   ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
│   ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
│   │││││        Base.llvmcall(("define void @fence() #0 {\nentry:\n    fence syncscope(\"workgroup\") seq_cst\n    ret void\n}\nattributes #0 = { alwaysinline }\n", "fence"), AMDGPU.Device.Nothing, Tuple{})::Nothing
│   │││└└
│   │││ @ none within `macro expansion`
└───│││        goto #37
37 ─│││        goto #38
38 ─│││        return Main.nothing
    └└└
) => Nothing
