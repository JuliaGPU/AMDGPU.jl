; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@alloc_special___print_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@0 = private unnamed_addr constant [13 x i8] c"Hello World!\00", align 1

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #0

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.readfirstlane(i32) #5

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #6

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #7 {
  %3 = inttoptr i64 %0 to %0 addrspace(1)*
  %4 = getelementptr inbounds %0, %0 addrspace(1)* %3, i64 0, i32 1, i32 0
  switch i32 %1, label %5 [
    i32 1, label %7
    i32 2, label %7
    i32 5, label %9
  ]

5:                                                ; preds = %2
  %6 = load atomic i64, i64 addrspace(1)* %4 syncscope("one-as") monotonic, align 8
  br label %11

7:                                                ; preds = %2, %2
  %8 = load atomic i64, i64 addrspace(1)* %4 syncscope("one-as") acquire, align 8
  br label %11

9:                                                ; preds = %2
  %10 = load atomic i64, i64 addrspace(1)* %4 seq_cst, align 8
  br label %11

11:                                               ; preds = %9, %7, %5
  %12 = phi i64 [ %6, %5 ], [ %10, %9 ], [ %8, %7 ]
  ret i64 %12
}

; Function Attrs: convergent norecurse nounwind
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #8 {
  %5 = inttoptr i64 %0 to %0 addrspace(1)*
  %6 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 1, i32 0
  switch i32 %3, label %7 [
    i32 1, label %9
    i32 2, label %9
    i32 3, label %11
    i32 4, label %13
    i32 5, label %15
  ]

7:                                                ; preds = %4
  %8 = cmpxchg i64 addrspace(1)* %6, i64 %1, i64 %2 syncscope("one-as") monotonic monotonic, align 8
  br label %17

9:                                                ; preds = %4, %4
  %10 = cmpxchg i64 addrspace(1)* %6, i64 %1, i64 %2 syncscope("one-as") acquire monotonic, align 8
  br label %17

11:                                               ; preds = %4
  %12 = cmpxchg i64 addrspace(1)* %6, i64 %1, i64 %2 syncscope("one-as") release monotonic, align 8
  br label %17

13:                                               ; preds = %4
  %14 = cmpxchg i64 addrspace(1)* %6, i64 %1, i64 %2 syncscope("one-as") acq_rel monotonic, align 8
  br label %17

15:                                               ; preds = %4
  %16 = cmpxchg i64 addrspace(1)* %6, i64 %1, i64 %2 seq_cst monotonic, align 8
  br label %17

17:                                               ; preds = %15, %13, %11, %9, %7
  %18 = phi { i64, i1 } [ %8, %7 ], [ %16, %15 ], [ %14, %13 ], [ %12, %11 ], [ %10, %9 ]
  %19 = extractvalue { i64, i1 } %18, 1
  br i1 %19, label %20, label %31

20:                                               ; preds = %17
  %21 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 2
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !9
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !15
  %28 = zext i32 %27 to i64
  store atomic i64 %28, i64 addrspace(1)* %25 syncscope("one-as") release, align 8
  %29 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %27)
  %30 = and i32 %29, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %30)
  br label %31

31:                                               ; preds = %24, %20, %17
  %32 = extractvalue { i64, i1 } %18, 0
  ret i64 %32
}

; Function Attrs: convergent norecurse nounwind
define internal fastcc void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #8 {
  %4 = inttoptr i64 %0 to %0 addrspace(1)*
  %5 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 0
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !16
  %7 = icmp eq i64 %6, 1
  br i1 %7, label %8, label %24

8:                                                ; preds = %3
  %9 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1, i32 0
  switch i32 %2, label %10 [
    i32 3, label %11
    i32 5, label %12
  ]

10:                                               ; preds = %8
  store atomic i64 %1, i64 addrspace(1)* %9 syncscope("one-as") monotonic, align 8
  br label %13

11:                                               ; preds = %8
  store atomic i64 %1, i64 addrspace(1)* %9 syncscope("one-as") release, align 8
  br label %13

12:                                               ; preds = %8
  store atomic i64 %1, i64 addrspace(1)* %9 seq_cst, align 8
  br label %13

13:                                               ; preds = %12, %11, %10
  %14 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 2
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !9
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %28, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !15
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %28

24:                                               ; preds = %3
  %25 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %26 = bitcast %1 addrspace(1)* %25 to i64 addrspace(1)* addrspace(1)*
  %27 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %26, align 8, !tbaa !17
  store atomic i64 %1, i64 addrspace(1)* %27 syncscope("one-as") release, align 8
  br label %28

28:                                               ; preds = %24, %17, %13
  ret void
}

;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
define amdgpu_kernel void @_Z6kernel({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) local_unnamed_addr #9 !dbg !18 {
conversion:
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %state.i.fca.10.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 10, !dbg !22
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       store i64 %state.i.fca.10.extract, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special___print_hostcall, i32 0, i32 0), align 32, !dbg !37, !tbaa !47
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; │┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
    %0 = inttoptr i64 %state.i.fca.10.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !50
    %.sroa.025.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !50
    %.sroa.025.0.copyload = load i64, i64* %.sroa.025.0..sroa_idx, align 1, !dbg !50, !tbaa !55, !alias.scope !58, !noalias !62
    %.sroa.529.0..sroa_idx30 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 1, !dbg !50
    %.sroa.529.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.529.0..sroa_idx30, align 1, !dbg !50, !tbaa !55, !alias.scope !58, !noalias !62
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !66, !range !84
; │││└└└└
; │││┌ @ operators.jl:277 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:483 @ promotion.jl:639
       %.not = icmp eq i32 %1, 0, !dbg !85
; │││└└
     br i1 %.not, label %L26, label %L46, !dbg !76

L26:                                              ; preds = %L42, %conversion
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %2 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.025.0.copyload, i64 0, i64 1, i32 4), !dbg !95
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %2, label %L42 [
    i64 0, label %L46
    i64 5, label %L37
    i64 6, label %L37
  ], !dbg !102

L37:                                              ; preds = %L26, %L26
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i3.fca.0.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !103
; │││││└└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %3 = inttoptr i64 %state.i3.fca.0.extract to i32*, !dbg !111
        store i32 1, i32* %3, align 1, !dbg !111
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !114
        unreachable, !dbg !114

L42:                                              ; preds = %L26
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !118
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L26, !dbg !121

L46:                                              ; preds = %L26, %conversion
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !122
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !128
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !129
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(12) %.sroa.529.0.copyload, i8 addrspace(1)* noundef align 1 dereferenceable(12) addrspacecast (i8* getelementptr inbounds ([13 x i8], [13 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*), i64 12, i1 false), !dbg !131
; │└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %4 = getelementptr inbounds i8, i8 addrspace(1)* %.sroa.529.0.copyload, i64 12, !dbg !135
      store i8 0, i8 addrspace(1)* %4, align 1, !dbg !135, !tbaa !140
; │└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
     br i1 %.not, label %L76, label %L117, !dbg !142

L76:                                              ; preds = %L92, %L46
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %5 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.025.0.copyload, i64 1, i64 2, i32 4), !dbg !148
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %5, label %L92 [
    i64 1, label %L95
    i64 5, label %L87
    i64 6, label %L87
  ], !dbg !152

L87:                                              ; preds = %L76, %L76
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i2.fca.0.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !153
; │││││└└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %6 = inttoptr i64 %state.i2.fca.0.extract to i32*, !dbg !159
        store i32 1, i32* %6, align 1, !dbg !159
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !161
        unreachable, !dbg !161

L92:                                              ; preds = %L76
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !163
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L76, !dbg !165

L95:                                              ; preds = %L76
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %7 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.025.0.copyload, i32 2), !dbg !166
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:639 within `==`
       %.not4755 = icmp eq i64 %7, 4, !dbg !172
; ││││└
      br i1 %.not4755, label %L115, label %L100, !dbg !173

L100:                                             ; preds = %L112, %L95
      %8 = phi i64 [ %10, %L112 ], [ %7, %L95 ]
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
      %.off = add i64 %8, -5, !dbg !174
      %switch = icmp ult i64 %.off, 2, !dbg !174
      br i1 %switch, label %L107, label %L112, !dbg !174

L107:                                             ; preds = %L100
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i1.fca.0.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !175
; │││││└└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %9 = inttoptr i64 %state.i1.fca.0.extract to i32*, !dbg !181
        store i32 1, i32* %9, align 1, !dbg !181
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !183
        unreachable, !dbg !183

L112:                                             ; preds = %L100
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !185
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %10 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.025.0.copyload, i32 2), !dbg !166
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:639 within `==`
       %.not47 = icmp eq i64 %10, 4, !dbg !172
; ││││└
      br i1 %.not47, label %L115, label %L100, !dbg !173

L115:                                             ; preds = %L112, %L95
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.025.0.copyload, i64 0, i32 3), !dbg !187
      br label %L117, !dbg !187

L117:                                             ; preds = %L115, %L46
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !191
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !194
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !195
; │││└└
; │││ @ none within `macro expansion`
     ret void, !dbg !143
; └└└
}

attributes #0 = { convergent nocallback nofree nounwind willreturn }
attributes #1 = { cold nocallback nofree noreturn nounwind }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { alwaysinline convergent nocallback nofree nounwind willreturn memory(none) }
attributes #6 = { alwaysinline nounwind }
attributes #7 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #8 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #9 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4}
!opencl.ocl.version = !{!6, !6, !6, !6, !6, !6, !6, !6, !6}
!llvm.ident = !{!7, !7, !7, !7, !7, !7, !7, !7, !7}
!julia.kernel = !{!8}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 0}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "julia", directory: ".")
!6 = !{i32 2, i32 0}
!7 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!8 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 })* @_Z6kernel}
!9 = !{!10, !11, i64 16}
!10 = !{!"amd_signal_s", !11, i64 0, !12, i64 8, !11, i64 16, !14, i64 24, !14, i64 28, !11, i64 32, !11, i64 40, !12, i64 48, !12, i64 56}
!11 = !{!"long", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!"int", !12, i64 0}
!15 = !{!10, !14, i64 24}
!16 = !{!10, !11, i64 0}
!17 = !{!12, !12, i64 0}
!18 = distinct !DISubprogram(name: "kernel", linkageName: "julia_kernel_14203", scope: null, file: !19, line: 3, type: !20, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!19 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!20 = !DISubroutineType(types: !21)
!21 = !{}
!22 = !DILocation(line: 39, scope: !23, inlinedAt: !25)
!23 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !24, file: !24, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!24 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!25 = !DILocation(line: 0, scope: !26, inlinedAt: !28)
!26 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!27 = !DIFile(filename: "none", directory: ".")
!28 = !DILocation(line: 0, scope: !29, inlinedAt: !30)
!29 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!30 = !DILocation(line: 71, scope: !31, inlinedAt: !33)
!31 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!32 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!33 = !DILocation(line: 69, scope: !34, inlinedAt: !36)
!34 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !35, file: !35, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!35 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!36 = !DILocation(line: 3, scope: !18)
!37 = !DILocation(line: 39, scope: !23, inlinedAt: !38)
!38 = !DILocation(line: 0, scope: !26, inlinedAt: !39)
!39 = !DILocation(line: 0, scope: !40, inlinedAt: !41)
!40 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!41 = !DILocation(line: 88, scope: !42, inlinedAt: !44)
!42 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !43, file: !43, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!43 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!44 = !DILocation(line: 88, scope: !42, inlinedAt: !45)
!45 = !DILocation(line: 88, scope: !42, inlinedAt: !46)
!46 = !DILocation(line: 74, scope: !31, inlinedAt: !33)
!47 = !{!48, !48, i64 0, i64 0}
!48 = !{!"custom_tbaa_addrspace(3)", !49, i64 0}
!49 = !{!"custom_tbaa"}
!50 = !DILocation(line: 153, scope: !51, inlinedAt: !53)
!51 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !52, file: !52, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!52 = !DIFile(filename: "pointer.jl", directory: ".")
!53 = !DILocation(line: 153, scope: !51, inlinedAt: !54)
!54 = !DILocation(line: 70, scope: !34, inlinedAt: !36)
!55 = !{!56, !56, i64 0}
!56 = !{!"jtbaa", !57, i64 0}
!57 = !{!"jtbaa"}
!58 = !{!59, !61}
!59 = !{!"jnoalias_data", !60}
!60 = !{!"jnoalias"}
!61 = !{!"jnoalias_stack", !60}
!62 = !{!63, !64, !65}
!63 = !{!"jnoalias_gcframe", !60}
!64 = !{!"jnoalias_typemd", !60}
!65 = !{!"jnoalias_const", !60}
!66 = !DILocation(line: 39, scope: !23, inlinedAt: !67)
!67 = !DILocation(line: 3, scope: !68, inlinedAt: !70)
!68 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !69, file: !69, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!69 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!70 = !DILocation(line: 3, scope: !71, inlinedAt: !72)
!71 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !69, file: !69, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!72 = !DILocation(line: 87, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !69, file: !69, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!74 = !DILocation(line: 122, scope: !75, inlinedAt: !76)
!75 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !69, file: !69, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!76 = !DILocation(line: 30, scope: !77, inlinedAt: !79)
!77 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !78, file: !78, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!78 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!79 = !DILocation(line: 0, scope: !26, inlinedAt: !80)
!80 = !DILocation(line: 0, scope: !81, inlinedAt: !82)
!81 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!82 = !DILocation(line: 53, scope: !83, inlinedAt: !54)
!83 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !78, file: !78, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!84 = !{i32 0, i32 1023}
!85 = !DILocation(line: 639, scope: !86, inlinedAt: !88)
!86 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !87, file: !87, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!87 = !DIFile(filename: "promotion.jl", directory: ".")
!88 = !DILocation(line: 483, scope: !86, inlinedAt: !89)
!89 = !DILocation(line: 518, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !91, file: !91, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!91 = !DIFile(filename: "int.jl", directory: ".")
!92 = !DILocation(line: 277, scope: !93, inlinedAt: !76)
!93 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !94, file: !94, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!94 = !DIFile(filename: "operators.jl", directory: ".")
!95 = !DILocation(line: 27, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!97 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!98 = !DILocation(line: 37, scope: !99, inlinedAt: !100)
!99 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!100 = !DILocation(line: 36, scope: !99, inlinedAt: !101)
!101 = !DILocation(line: 62, scope: !77, inlinedAt: !79)
!102 = !DILocation(line: 38, scope: !99, inlinedAt: !100)
!103 = !DILocation(line: 39, scope: !23, inlinedAt: !104)
!104 = !DILocation(line: 0, scope: !26, inlinedAt: !105)
!105 = !DILocation(line: 0, scope: !29, inlinedAt: !106)
!106 = !DILocation(line: 11, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!108 = !DILocation(line: 113, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!110 = !DILocation(line: 41, scope: !99, inlinedAt: !100)
!111 = !DILocation(line: 180, scope: !112, inlinedAt: !113)
!112 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !52, file: !52, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!113 = !DILocation(line: 180, scope: !112, inlinedAt: !108)
!114 = !DILocation(line: 6, scope: !115, inlinedAt: !117)
!115 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !116, file: !116, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!116 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!117 = !DILocation(line: 115, scope: !109, inlinedAt: !110)
!118 = !DILocation(line: 108, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!120 = !DILocation(line: 46, scope: !99, inlinedAt: !100)
!121 = !DILocation(line: 47, scope: !99, inlinedAt: !100)
!122 = !DILocation(line: 5, scope: !123, inlinedAt: !125)
!123 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !124, file: !124, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!124 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!125 = !DILocation(line: 27, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !124, file: !124, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!127 = !DILocation(line: 47, scope: !77, inlinedAt: !79)
!128 = !DILocation(line: 28, scope: !126, inlinedAt: !127)
!129 = !DILocation(line: 5, scope: !123, inlinedAt: !130)
!130 = !DILocation(line: 29, scope: !126, inlinedAt: !127)
!131 = !DILocation(line: 39, scope: !23, inlinedAt: !132)
!132 = !DILocation(line: 0, scope: !26, inlinedAt: !133)
!133 = !DILocation(line: 0, scope: !134, inlinedAt: !54)
!134 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!135 = !DILocation(line: 39, scope: !23, inlinedAt: !136)
!136 = !DILocation(line: 0, scope: !26, inlinedAt: !137)
!137 = !DILocation(line: 0, scope: !40, inlinedAt: !138)
!138 = !DILocation(line: 88, scope: !42, inlinedAt: !139)
!139 = !DILocation(line: 88, scope: !42, inlinedAt: !54)
!140 = !{!141, !141, i64 0, i64 0}
!141 = !{!"custom_tbaa_addrspace(1)", !49, i64 0}
!142 = !DILocation(line: 30, scope: !77, inlinedAt: !143)
!143 = !DILocation(line: 0, scope: !26, inlinedAt: !144)
!144 = !DILocation(line: 0, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!146 = !DILocation(line: 97, scope: !147, inlinedAt: !54)
!147 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !78, file: !78, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!148 = !DILocation(line: 27, scope: !96, inlinedAt: !149)
!149 = !DILocation(line: 37, scope: !99, inlinedAt: !150)
!150 = !DILocation(line: 36, scope: !99, inlinedAt: !151)
!151 = !DILocation(line: 113, scope: !77, inlinedAt: !143)
!152 = !DILocation(line: 38, scope: !99, inlinedAt: !150)
!153 = !DILocation(line: 39, scope: !23, inlinedAt: !154)
!154 = !DILocation(line: 0, scope: !26, inlinedAt: !155)
!155 = !DILocation(line: 0, scope: !29, inlinedAt: !156)
!156 = !DILocation(line: 11, scope: !107, inlinedAt: !157)
!157 = !DILocation(line: 113, scope: !109, inlinedAt: !158)
!158 = !DILocation(line: 41, scope: !99, inlinedAt: !150)
!159 = !DILocation(line: 180, scope: !112, inlinedAt: !160)
!160 = !DILocation(line: 180, scope: !112, inlinedAt: !157)
!161 = !DILocation(line: 6, scope: !115, inlinedAt: !162)
!162 = !DILocation(line: 115, scope: !109, inlinedAt: !158)
!163 = !DILocation(line: 108, scope: !119, inlinedAt: !164)
!164 = !DILocation(line: 46, scope: !99, inlinedAt: !150)
!165 = !DILocation(line: 47, scope: !99, inlinedAt: !150)
!166 = !DILocation(line: 12, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!168 = !DILocation(line: 61, scope: !169, inlinedAt: !170)
!169 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!170 = !DILocation(line: 60, scope: !169, inlinedAt: !171)
!171 = !DILocation(line: 116, scope: !77, inlinedAt: !143)
!172 = !DILocation(line: 639, scope: !86, inlinedAt: !173)
!173 = !DILocation(line: 62, scope: !169, inlinedAt: !170)
!174 = !DILocation(line: 64, scope: !169, inlinedAt: !170)
!175 = !DILocation(line: 39, scope: !23, inlinedAt: !176)
!176 = !DILocation(line: 0, scope: !26, inlinedAt: !177)
!177 = !DILocation(line: 0, scope: !29, inlinedAt: !178)
!178 = !DILocation(line: 11, scope: !107, inlinedAt: !179)
!179 = !DILocation(line: 113, scope: !109, inlinedAt: !180)
!180 = !DILocation(line: 65, scope: !169, inlinedAt: !170)
!181 = !DILocation(line: 180, scope: !112, inlinedAt: !182)
!182 = !DILocation(line: 180, scope: !112, inlinedAt: !179)
!183 = !DILocation(line: 6, scope: !115, inlinedAt: !184)
!184 = !DILocation(line: 115, scope: !109, inlinedAt: !180)
!185 = !DILocation(line: 108, scope: !119, inlinedAt: !186)
!186 = !DILocation(line: 70, scope: !169, inlinedAt: !170)
!187 = !DILocation(line: 19, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !21)
!189 = !DILocation(line: 19, scope: !188, inlinedAt: !190)
!190 = !DILocation(line: 128, scope: !77, inlinedAt: !143)
!191 = !DILocation(line: 5, scope: !123, inlinedAt: !192)
!192 = !DILocation(line: 27, scope: !126, inlinedAt: !193)
!193 = !DILocation(line: 47, scope: !77, inlinedAt: !143)
!194 = !DILocation(line: 28, scope: !126, inlinedAt: !193)
!195 = !DILocation(line: 5, scope: !123, inlinedAt: !196)
!196 = !DILocation(line: 29, scope: !126, inlinedAt: !193)
