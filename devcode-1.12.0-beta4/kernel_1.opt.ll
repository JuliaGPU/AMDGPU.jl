; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { ptr addrspace(1) }

@alloc_special___print_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@0 = private unnamed_addr constant [13 x i8] c"Hello World!\00", align 1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5.p0.i64(ptr addrspace(5) noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #1

; Function Attrs: cold convergent nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.readfirstlane(i32) #5

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #6

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #7 {
  %3 = inttoptr i64 %0 to ptr addrspace(1)
  %4 = getelementptr inbounds %0, ptr addrspace(1) %3, i64 0, i32 1
  switch i32 %1, label %5 [
    i32 1, label %7
    i32 2, label %7
    i32 5, label %9
  ]

5:                                                ; preds = %2
  %6 = load atomic i64, ptr addrspace(1) %4 syncscope("one-as") monotonic, align 8
  br label %11

7:                                                ; preds = %2, %2
  %8 = load atomic i64, ptr addrspace(1) %4 syncscope("one-as") acquire, align 8
  br label %11

9:                                                ; preds = %2
  %10 = load atomic i64, ptr addrspace(1) %4 seq_cst, align 8
  br label %11

11:                                               ; preds = %9, %7, %5
  %12 = phi i64 [ %6, %5 ], [ %10, %9 ], [ %8, %7 ]
  ret i64 %12
}

; Function Attrs: convergent norecurse nounwind
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #8 {
  %5 = inttoptr i64 %0 to ptr addrspace(1)
  %6 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 1
  switch i32 %3, label %7 [
    i32 1, label %9
    i32 2, label %9
    i32 3, label %11
    i32 4, label %13
    i32 5, label %15
  ]

7:                                                ; preds = %4
  %8 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") monotonic monotonic, align 8
  br label %17

9:                                                ; preds = %4, %4
  %10 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") acquire monotonic, align 8
  br label %17

11:                                               ; preds = %4
  %12 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") release monotonic, align 8
  br label %17

13:                                               ; preds = %4
  %14 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") acq_rel monotonic, align 8
  br label %17

15:                                               ; preds = %4
  %16 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 seq_cst monotonic, align 8
  br label %17

17:                                               ; preds = %15, %13, %11, %9, %7
  %18 = phi { i64, i1 } [ %8, %7 ], [ %16, %15 ], [ %14, %13 ], [ %12, %11 ], [ %10, %9 ]
  %19 = extractvalue { i64, i1 } %18, 1
  br i1 %19, label %20, label %31

20:                                               ; preds = %17
  %21 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 2
  %22 = load i64, ptr addrspace(1) %21, align 16, !tbaa !9
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to ptr addrspace(1)
  %26 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 3
  %27 = load i32, ptr addrspace(1) %26, align 8, !tbaa !15
  %28 = zext i32 %27 to i64
  store atomic i64 %28, ptr addrspace(1) %25 syncscope("one-as") release, align 8
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
  %4 = inttoptr i64 %0 to ptr addrspace(1)
  %5 = load i64, ptr addrspace(1) %4, align 64, !tbaa !16
  %6 = icmp eq i64 %5, 1
  %7 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 1
  br i1 %6, label %8, label %23

8:                                                ; preds = %3
  switch i32 %2, label %9 [
    i32 3, label %10
    i32 5, label %11
  ]

9:                                                ; preds = %8
  store atomic i64 %1, ptr addrspace(1) %7 syncscope("one-as") monotonic, align 8
  br label %12

10:                                               ; preds = %8
  store atomic i64 %1, ptr addrspace(1) %7 syncscope("one-as") release, align 8
  br label %12

11:                                               ; preds = %8
  store atomic i64 %1, ptr addrspace(1) %7 seq_cst, align 8
  br label %12

12:                                               ; preds = %11, %10, %9
  %13 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 2
  %14 = load i64, ptr addrspace(1) %13, align 16, !tbaa !9
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %25, label %16

16:                                               ; preds = %12
  %17 = inttoptr i64 %14 to ptr addrspace(1)
  %18 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 3
  %19 = load i32, ptr addrspace(1) %18, align 8, !tbaa !15
  %20 = zext i32 %19 to i64
  store atomic i64 %20, ptr addrspace(1) %17 syncscope("one-as") release, align 8
  %21 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %19)
  %22 = and i32 %21, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %22)
  br label %25

23:                                               ; preds = %3
  %24 = load ptr addrspace(1), ptr addrspace(1) %7, align 8, !tbaa !17
  store atomic i64 %1, ptr addrspace(1) %24 syncscope("one-as") release, align 8
  br label %25

25:                                               ; preds = %23, %16, %12
  ret void
}

;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
define amdgpu_kernel void @_Z6kernel({ ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state) local_unnamed_addr #9 !dbg !18 {
conversion:
  %pointerref = alloca [3 x i64], align 8, addrspace(5)
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %state.i.fca.10.extract = extractvalue { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, 10, !dbg !22
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
; ││┌ @ essentials.jl:733 within `reinterpret`
     %bitcast_coercion = ptrtoint ptr %state.i.fca.10.extract to i64, !dbg !37
; ││└
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       store i64 %bitcast_coercion, ptr addrspace(3) @alloc_special___print_hostcall, align 1, !dbg !41, !tbaa !50
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; │┌ @ pointer.jl:151 within `unsafe_load` @ pointer.jl:151
    call void @llvm.memcpy.p5.p0.i64(ptr addrspace(5) noundef align 8 dereferenceable(24) %pointerref, ptr noundef nonnull align 1 dereferenceable(24) %state.i.fca.10.extract, i64 24, i1 false), !dbg !53, !tbaa !58, !alias.scope !61, !noalias !65
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %0 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !69, !range !87
; │││└└└└
; │││┌ @ operators.jl:321 within `!=`
; ││││┌ @ int.jl:524 within `==` @ promotion.jl:487 @ promotion.jl:637
       %.not = icmp eq i32 %0, 0, !dbg !88
; │││└└
     br i1 %.not, label %L25.preheader, label %L43, !dbg !79

L25.preheader:                                    ; preds = %conversion
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %pointerref.unbox23.pre = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !98, !tbaa !105, !alias.scope !107, !noalias !108
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L25, !dbg !109

L25:                                              ; preds = %L39, %L25.preheader
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %1 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.unbox23.pre, i64 0, i64 1, i32 4), !dbg !98
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:637 within `==`
       %.not41.not = icmp eq i64 %1, 0, !dbg !110
; ││││└
      br i1 %.not41.not, label %L43, label %L29, !dbg !109

L29:                                              ; preds = %L25
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
      %2 = add i64 %1, -7, !dbg !111
      %or.cond = icmp ult i64 %2, -2, !dbg !111
      br i1 %or.cond, label %L39, label %L34, !dbg !111

L34:                                              ; preds = %L29
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i30.fca.0.extract = extractvalue { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, 0, !dbg !112
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        store i32 1, ptr %state.i30.fca.0.extract, align 1, !dbg !120
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !123
        unreachable, !dbg !123

L39:                                              ; preds = %L29
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !127
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L25, !dbg !130

L43:                                              ; preds = %L25, %conversion
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !131
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !137
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !138
; │└└└└
; │┌ @ Base_compiler.jl:54 within `getproperty`
    %pointerref.buf_ptr_ptr = getelementptr inbounds i8, ptr addrspace(5) %pointerref, i32 8, !dbg !140
; │└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:147 within `+`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `add_ptr`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %pointerref.buf_ptr_ptr.unbox = load ptr addrspace(1), ptr addrspace(5) %pointerref.buf_ptr_ptr, align 8, !dbg !143, !tbaa !105, !alias.scope !107, !noalias !108
; │└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) noundef align 1 dereferenceable(12) %pointerref.buf_ptr_ptr.unbox, ptr addrspace(1) noundef align 1 dereferenceable(12) addrspacecast (ptr @0 to ptr addrspace(1)), i64 12, i1 false), !dbg !150
; │└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %3 = getelementptr inbounds i8, ptr addrspace(1) %pointerref.buf_ptr_ptr.unbox, i64 12, !dbg !154
      store i8 0, ptr addrspace(1) %3, align 1, !dbg !154, !tbaa !159
; │└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
     br i1 %.not, label %L73.preheader, label %L110, !dbg !161

L73.preheader:                                    ; preds = %L43
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %pointerref.unbox.pre = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !167, !tbaa !105, !alias.scope !107, !noalias !108
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L73, !dbg !171

L73:                                              ; preds = %L87, %L73.preheader
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %4 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.unbox.pre, i64 1, i64 2, i32 4), !dbg !167
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:637 within `==`
       %.not43.not = icmp eq i64 %4, 1, !dbg !172
; ││││└
      br i1 %.not43.not, label %L91.preheader, label %L77, !dbg !171

L91.preheader:                                    ; preds = %L73
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %5 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.unbox.pre, i32 2), !dbg !173
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:637 within `==`
       %.not4446 = icmp eq i64 %5, 4, !dbg !179
; ││││└
      br i1 %.not4446, label %L108, label %L95, !dbg !180

L77:                                              ; preds = %L73
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
      %6 = add i64 %4, -7, !dbg !181
      %or.cond3 = icmp ult i64 %6, -2, !dbg !181
      br i1 %or.cond3, label %L87, label %L82, !dbg !181

L82:                                              ; preds = %L77
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i29.fca.0.extract = extractvalue { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, 0, !dbg !182
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        store i32 1, ptr %state.i29.fca.0.extract, align 1, !dbg !188
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !190
        unreachable, !dbg !190

L87:                                              ; preds = %L77
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !192
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L73, !dbg !194

L95:                                              ; preds = %L105, %L91.preheader
      %7 = phi i64 [ %9, %L105 ], [ %5, %L91.preheader ]
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
      %8 = add i64 %7, -7, !dbg !195
      %or.cond5 = icmp ult i64 %8, -2, !dbg !195
      br i1 %or.cond5, label %L105, label %L100, !dbg !195

L100:                                             ; preds = %L95
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %state.i28.fca.0.extract = extractvalue { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, 0, !dbg !196
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        store i32 1, ptr %state.i28.fca.0.extract, align 1, !dbg !202
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !204
        unreachable, !dbg !204

L105:                                             ; preds = %L95
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !206
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %9 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.unbox.pre, i32 2), !dbg !173
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:637 within `==`
       %.not44 = icmp eq i64 %9, 4, !dbg !179
; ││││└
      br i1 %.not44, label %L108, label %L95, !dbg !180

L108:                                             ; preds = %L105, %L91.preheader
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      call fastcc void @__ockl_hsa_signal_store(i64 %pointerref.unbox.pre, i64 0, i32 3), !dbg !208
      br label %L110, !dbg !208

L110:                                             ; preds = %L108, %L43
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !212
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !215
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !216
       ret void, !dbg !216
; └└└└└
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { convergent nocallback nofree nounwind willreturn }
attributes #2 = { cold convergent nocallback nofree noreturn nounwind }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { alwaysinline convergent nocallback nofree nounwind willreturn memory(none) }
attributes #6 = { alwaysinline nounwind }
attributes #7 = { mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none) "denormal-fp-math"="dynamic,dynamic" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #8 = { convergent norecurse nounwind "denormal-fp-math"="dynamic,dynamic" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
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
!7 = !{!"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"}
!8 = !{ptr @_Z6kernel}
!9 = !{!10, !11, i64 16}
!10 = !{!"amd_signal_s", !11, i64 0, !12, i64 8, !11, i64 16, !14, i64 24, !14, i64 28, !11, i64 32, !11, i64 40, !12, i64 48, !12, i64 56}
!11 = !{!"long", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!"int", !12, i64 0}
!15 = !{!10, !14, i64 24}
!16 = !{!10, !11, i64 0}
!17 = !{!12, !12, i64 0}
!18 = distinct !DISubprogram(name: "kernel", linkageName: "julia_kernel_12794", scope: null, file: !19, line: 3, type: !20, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!19 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!20 = !DISubroutineType(types: !21)
!21 = !{}
!22 = !DILocation(line: 39, scope: !23, inlinedAt: !25)
!23 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !24, file: !24, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!24 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!25 = !DILocation(line: 0, scope: !26, inlinedAt: !28)
!26 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!27 = !DIFile(filename: "none", directory: ".")
!28 = !DILocation(line: 0, scope: !29, inlinedAt: !30)
!29 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!30 = !DILocation(line: 71, scope: !31, inlinedAt: !33)
!31 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!32 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!33 = !DILocation(line: 69, scope: !34, inlinedAt: !36)
!34 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !35, file: !35, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!35 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!36 = !DILocation(line: 3, scope: !18)
!37 = !DILocation(line: 733, scope: !38, inlinedAt: !40)
!38 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !39, file: !39, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!39 = !DIFile(filename: "essentials.jl", directory: ".")
!40 = !DILocation(line: 74, scope: !31, inlinedAt: !33)
!41 = !DILocation(line: 39, scope: !23, inlinedAt: !42)
!42 = !DILocation(line: 0, scope: !26, inlinedAt: !43)
!43 = !DILocation(line: 0, scope: !44, inlinedAt: !45)
!44 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!45 = !DILocation(line: 88, scope: !46, inlinedAt: !48)
!46 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !47, file: !47, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!47 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!48 = !DILocation(line: 88, scope: !46, inlinedAt: !49)
!49 = !DILocation(line: 88, scope: !46, inlinedAt: !40)
!50 = !{!51, !51, i64 0, i64 0}
!51 = !{!"custom_tbaa_addrspace(3)", !52, i64 0}
!52 = !{!"custom_tbaa"}
!53 = !DILocation(line: 151, scope: !54, inlinedAt: !56)
!54 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !55, file: !55, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!55 = !DIFile(filename: "pointer.jl", directory: ".")
!56 = !DILocation(line: 151, scope: !54, inlinedAt: !57)
!57 = !DILocation(line: 70, scope: !34, inlinedAt: !36)
!58 = !{!59, !59, i64 0}
!59 = !{!"jtbaa", !60, i64 0}
!60 = !{!"jtbaa"}
!61 = !{!62, !64}
!62 = !{!"jnoalias_data", !63}
!63 = !{!"jnoalias"}
!64 = !{!"jnoalias_stack", !63}
!65 = !{!66, !67, !68}
!66 = !{!"jnoalias_gcframe", !63}
!67 = !{!"jnoalias_typemd", !63}
!68 = !{!"jnoalias_const", !63}
!69 = !DILocation(line: 39, scope: !23, inlinedAt: !70)
!70 = !DILocation(line: 3, scope: !71, inlinedAt: !73)
!71 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !72, file: !72, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!72 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!73 = !DILocation(line: 3, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !72, file: !72, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!75 = !DILocation(line: 87, scope: !76, inlinedAt: !77)
!76 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !72, file: !72, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!77 = !DILocation(line: 122, scope: !78, inlinedAt: !79)
!78 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !72, file: !72, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!79 = !DILocation(line: 30, scope: !80, inlinedAt: !82)
!80 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !81, file: !81, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!81 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!82 = !DILocation(line: 0, scope: !26, inlinedAt: !83)
!83 = !DILocation(line: 0, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!85 = !DILocation(line: 53, scope: !86, inlinedAt: !57)
!86 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !81, file: !81, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!87 = !{i32 0, i32 1023}
!88 = !DILocation(line: 637, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !90, file: !90, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!90 = !DIFile(filename: "promotion.jl", directory: ".")
!91 = !DILocation(line: 487, scope: !89, inlinedAt: !92)
!92 = !DILocation(line: 524, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!94 = !DIFile(filename: "int.jl", directory: ".")
!95 = !DILocation(line: 321, scope: !96, inlinedAt: !79)
!96 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !97, file: !97, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!97 = !DIFile(filename: "operators.jl", directory: ".")
!98 = !DILocation(line: 27, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!100 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!101 = !DILocation(line: 37, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!103 = !DILocation(line: 36, scope: !102, inlinedAt: !104)
!104 = !DILocation(line: 62, scope: !80, inlinedAt: !82)
!105 = !{!106, !106, i64 0}
!106 = !{!"jtbaa_stack", !59, i64 0}
!107 = !{!64}
!108 = !{!66, !62, !67, !68}
!109 = !DILocation(line: 38, scope: !102, inlinedAt: !103)
!110 = !DILocation(line: 637, scope: !89, inlinedAt: !109)
!111 = !DILocation(line: 40, scope: !102, inlinedAt: !103)
!112 = !DILocation(line: 39, scope: !23, inlinedAt: !113)
!113 = !DILocation(line: 0, scope: !26, inlinedAt: !114)
!114 = !DILocation(line: 0, scope: !29, inlinedAt: !115)
!115 = !DILocation(line: 11, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!117 = !DILocation(line: 113, scope: !118, inlinedAt: !119)
!118 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !32, file: !32, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!119 = !DILocation(line: 41, scope: !102, inlinedAt: !103)
!120 = !DILocation(line: 178, scope: !121, inlinedAt: !122)
!121 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !55, file: !55, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!122 = !DILocation(line: 178, scope: !121, inlinedAt: !117)
!123 = !DILocation(line: 6, scope: !124, inlinedAt: !126)
!124 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !125, file: !125, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!125 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!126 = !DILocation(line: 115, scope: !118, inlinedAt: !119)
!127 = !DILocation(line: 108, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!129 = !DILocation(line: 46, scope: !102, inlinedAt: !103)
!130 = !DILocation(line: 47, scope: !102, inlinedAt: !103)
!131 = !DILocation(line: 5, scope: !132, inlinedAt: !134)
!132 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !133, file: !133, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!133 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!134 = !DILocation(line: 27, scope: !135, inlinedAt: !136)
!135 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !133, file: !133, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!136 = !DILocation(line: 47, scope: !80, inlinedAt: !82)
!137 = !DILocation(line: 28, scope: !135, inlinedAt: !136)
!138 = !DILocation(line: 5, scope: !132, inlinedAt: !139)
!139 = !DILocation(line: 29, scope: !135, inlinedAt: !136)
!140 = !DILocation(line: 54, scope: !141, inlinedAt: !57)
!141 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !142, file: !142, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!142 = !DIFile(filename: "Base_compiler.jl", directory: ".")
!143 = !DILocation(line: 39, scope: !23, inlinedAt: !144)
!144 = !DILocation(line: 114, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !47, file: !47, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!146 = !DILocation(line: 114, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "add_ptr;", linkageName: "add_ptr", scope: !47, file: !47, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!148 = !DILocation(line: 147, scope: !149, inlinedAt: !57)
!149 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !47, file: !47, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!150 = !DILocation(line: 39, scope: !23, inlinedAt: !151)
!151 = !DILocation(line: 0, scope: !26, inlinedAt: !152)
!152 = !DILocation(line: 0, scope: !153, inlinedAt: !57)
!153 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!154 = !DILocation(line: 39, scope: !23, inlinedAt: !155)
!155 = !DILocation(line: 0, scope: !26, inlinedAt: !156)
!156 = !DILocation(line: 0, scope: !44, inlinedAt: !157)
!157 = !DILocation(line: 88, scope: !46, inlinedAt: !158)
!158 = !DILocation(line: 88, scope: !46, inlinedAt: !57)
!159 = !{!160, !160, i64 0, i64 0}
!160 = !{!"custom_tbaa_addrspace(1)", !52, i64 0}
!161 = !DILocation(line: 30, scope: !80, inlinedAt: !162)
!162 = !DILocation(line: 0, scope: !26, inlinedAt: !163)
!163 = !DILocation(line: 0, scope: !164, inlinedAt: !165)
!164 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !27, file: !27, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!165 = !DILocation(line: 97, scope: !166, inlinedAt: !57)
!166 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !81, file: !81, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!167 = !DILocation(line: 27, scope: !99, inlinedAt: !168)
!168 = !DILocation(line: 37, scope: !102, inlinedAt: !169)
!169 = !DILocation(line: 36, scope: !102, inlinedAt: !170)
!170 = !DILocation(line: 113, scope: !80, inlinedAt: !162)
!171 = !DILocation(line: 38, scope: !102, inlinedAt: !169)
!172 = !DILocation(line: 637, scope: !89, inlinedAt: !171)
!173 = !DILocation(line: 12, scope: !174, inlinedAt: !175)
!174 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!175 = !DILocation(line: 61, scope: !176, inlinedAt: !177)
!176 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!177 = !DILocation(line: 60, scope: !176, inlinedAt: !178)
!178 = !DILocation(line: 116, scope: !80, inlinedAt: !162)
!179 = !DILocation(line: 637, scope: !89, inlinedAt: !180)
!180 = !DILocation(line: 62, scope: !176, inlinedAt: !177)
!181 = !DILocation(line: 40, scope: !102, inlinedAt: !169)
!182 = !DILocation(line: 39, scope: !23, inlinedAt: !183)
!183 = !DILocation(line: 0, scope: !26, inlinedAt: !184)
!184 = !DILocation(line: 0, scope: !29, inlinedAt: !185)
!185 = !DILocation(line: 11, scope: !116, inlinedAt: !186)
!186 = !DILocation(line: 113, scope: !118, inlinedAt: !187)
!187 = !DILocation(line: 41, scope: !102, inlinedAt: !169)
!188 = !DILocation(line: 178, scope: !121, inlinedAt: !189)
!189 = !DILocation(line: 178, scope: !121, inlinedAt: !186)
!190 = !DILocation(line: 6, scope: !124, inlinedAt: !191)
!191 = !DILocation(line: 115, scope: !118, inlinedAt: !187)
!192 = !DILocation(line: 108, scope: !128, inlinedAt: !193)
!193 = !DILocation(line: 46, scope: !102, inlinedAt: !169)
!194 = !DILocation(line: 47, scope: !102, inlinedAt: !169)
!195 = !DILocation(line: 64, scope: !176, inlinedAt: !177)
!196 = !DILocation(line: 39, scope: !23, inlinedAt: !197)
!197 = !DILocation(line: 0, scope: !26, inlinedAt: !198)
!198 = !DILocation(line: 0, scope: !29, inlinedAt: !199)
!199 = !DILocation(line: 11, scope: !116, inlinedAt: !200)
!200 = !DILocation(line: 113, scope: !118, inlinedAt: !201)
!201 = !DILocation(line: 65, scope: !176, inlinedAt: !177)
!202 = !DILocation(line: 178, scope: !121, inlinedAt: !203)
!203 = !DILocation(line: 178, scope: !121, inlinedAt: !200)
!204 = !DILocation(line: 6, scope: !124, inlinedAt: !205)
!205 = !DILocation(line: 115, scope: !118, inlinedAt: !201)
!206 = !DILocation(line: 108, scope: !128, inlinedAt: !207)
!207 = !DILocation(line: 70, scope: !176, inlinedAt: !177)
!208 = !DILocation(line: 19, scope: !209, inlinedAt: !210)
!209 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !100, file: !100, type: !20, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!210 = !DILocation(line: 19, scope: !209, inlinedAt: !211)
!211 = !DILocation(line: 128, scope: !80, inlinedAt: !162)
!212 = !DILocation(line: 5, scope: !132, inlinedAt: !213)
!213 = !DILocation(line: 27, scope: !135, inlinedAt: !214)
!214 = !DILocation(line: 47, scope: !80, inlinedAt: !162)
!215 = !DILocation(line: 28, scope: !135, inlinedAt: !214)
!216 = !DILocation(line: 5, scope: !132, inlinedAt: !217)
!217 = !DILocation(line: 29, scope: !135, inlinedAt: !214)
