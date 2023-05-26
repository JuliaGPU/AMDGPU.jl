; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@0 = private unnamed_addr constant [19 x i8] c"Inexact conversion\00", align 1
@1 = private unnamed_addr constant [8 x i8] c"ERROR: \00", align 1
@2 = private unnamed_addr constant [27 x i8] c"Out-of-bounds array access\00", align 1
@3 = private unnamed_addr constant [108 x i8] c"ERROR: a %s was thrown during kernel execution.\0A       Run Julia on debug level 2 for device stack traces.\0A\00", align 1
@exception.4 = private unnamed_addr constant [10 x i8] c"exception\00", align 1
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@4 = private unnamed_addr constant [42 x i8] c"Device-to-host string conversion failed.\0A\00", align 1

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #0

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #2

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #4

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #2

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #4

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #5

; Function Attrs: nounwind
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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !64
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !70
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
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !71
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !64
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %28, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !70
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %28

24:                                               ; preds = %3
  %25 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %26 = bitcast %1 addrspace(1)* %25 to i64 addrspace(1)* addrspace(1)*
  %27 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %26, align 8, !tbaa !72
  store atomic i64 %1, i64 addrspace(1)* %27 syncscope("one-as") release, align 8
  br label %28

28:                                               ; preds = %24, %17, %13
  ret void
}

;  @ boot.jl:693 within `toInt32`
define internal fastcc i32 @julia_toInt32_2205([5 x i64] %state, i64 signext %0) unnamed_addr #9 !dbg !73 {
top:
  %1 = call fastcc i32 @julia_checked_trunc_sint_2208([5 x i64] %state, i64 %0), !dbg !76
  ret i32 %1, !dbg !76
}

;  @ boot.jl:652 within `checked_trunc_sint`
define internal fastcc i32 @julia_checked_trunc_sint_2208([5 x i64] %state, i64 signext %0) unnamed_addr #9 !dbg !77 {
top:
;  @ boot.jl:656 within `checked_trunc_sint`
  %1 = add i64 %0, -2147483648, !dbg !78
  %2 = icmp ult i64 %1, -4294967296, !dbg !78
  br i1 %2, label %L7, label %L5, !dbg !78

L5:                                               ; preds = %top
;  @ boot.jl:654 within `checked_trunc_sint`
  %3 = trunc i64 %0 to i32, !dbg !79
;  @ boot.jl:657 within `checked_trunc_sint`
  ret i32 %3, !dbg !80

L7:                                               ; preds = %top
;  @ boot.jl:656 within `checked_trunc_sint`
  call fastcc void @julia__throw_inexacterror_2211([5 x i64] %state), !dbg !78
  unreachable, !dbg !78
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2232([5 x i64] %state, i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #9 !dbg !81 {
top:
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !82
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %3, %1, !dbg !87
; └
  br i1 %.not, label %L20, label %L6, !dbg !90

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !91

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !92
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !104
    store i64 1, i64* %4, align 1, !dbg !104, !tbaa !109, !alias.scope !113, !noalias !116
    br label %L18, !dbg !104

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !121
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !124

L20:                                              ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !86
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2222([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #9 !dbg !125 {
top:
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !126, !range !142
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %.not = icmp eq i32 %1, 0, !dbg !143
; │└└
   br i1 %.not, label %L15, label %L21, !dbg !137

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %2 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !152
; │└
   %3 = load i64, i64* %2, align 8, !dbg !155, !tbaa !156, !alias.scope !158, !noalias !159
   call fastcc void @julia_hostcall_device_signal_wait_cas__2232([5 x i64] %state, i64 %3, i64 1, i64 2), !dbg !155
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
   call fastcc void @julia_hostcall_device_signal_wait_2229([5 x i64] %state, i64 %3, i64 4), !dbg !160
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    call fastcc void @__ockl_hsa_signal_store(i64 %3, i64 0, i32 3), !dbg !161
    br label %L21, !dbg !161

L21:                                              ; preds = %L15, %top
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !165
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !139
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:65 within `report_exception`
define internal fastcc void @gpu_report_exception([5 x i64] %state, i64 zeroext %0) unnamed_addr #9 !dbg !169 {
top:
  %1 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:66 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:43 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %2 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !170
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     br label %check.i, !dbg !176

check.i:                                          ; preds = %check.i, %top
     %3 = phi i64 [ 0, %top ], [ %4, %check.i ], !dbg !176
     %4 = add i64 %3, 1, !dbg !176
     %5 = getelementptr i8, i8 addrspace(1)* %2, i64 %3, !dbg !176
     %6 = addrspacecast i8 addrspace(1)* %5 to i8*, !dbg !176
     %7 = load i8, i8* %6, align 1, !dbg !176
     %8 = icmp eq i8 %7, 0, !dbg !176
     br i1 %8, label %julia_report_exception_2154u2156.exit, label %check.i, !dbg !176

julia_report_exception_2154u2156.exit:            ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i2.fca.3.extract = extractvalue [5 x i64] %state, 3, !dbg !184
; ││└└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %9 = inttoptr i64 %state.i2.fca.3.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !194
     %.sroa.080.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %9, i64 0, i32 0, !dbg !194
     %.sroa.080.0.copyload = load i64, i64* %.sroa.080.0..sroa_idx, align 1, !dbg !194, !tbaa !197, !alias.scope !198, !noalias !199
     %.sroa.685.0..sroa_idx86 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %9, i64 0, i32 1, !dbg !194
     %.sroa.685.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.685.0..sroa_idx86, align 1, !dbg !194, !tbaa !197, !alias.scope !198, !noalias !199
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %10 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !200, !range !142
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %.not = icmp eq i32 %10, 0, !dbg !218
; │││││└└
       br i1 %.not, label %L25.preheader, label %L45, !dbg !209

L25.preheader:                                    ; preds = %julia_report_exception_2154u2156.exit
       %state.i6.fca.0.extract = extractvalue [5 x i64] %state, 0
       %11 = inttoptr i64 %state.i6.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L25, !dbg !225

L25:                                              ; preds = %L41, %L25.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %12 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.080.0.copyload, i64 0, i64 1, i32 4), !dbg !229
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %12, label %L41 [
    i64 0, label %L45
    i64 5, label %L36
    i64 6, label %L36
  ], !dbg !225

L36:                                              ; preds = %L25, %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %11, align 1, !dbg !232, !tbaa !109, !alias.scope !113, !noalias !116
          br label %L41, !dbg !232

L41:                                              ; preds = %L36, %L25
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !238
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !241

L45:                                              ; preds = %L25, %julia_report_exception_2154u2156.exit
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !242
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L60, label %L70, !dbg !245

L60:                                              ; preds = %L45
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %13 = bitcast i8 addrspace(1)* %.sroa.685.0.copyload to i64 addrspace(1)*, !dbg !250
          store i64 %4, i64 addrspace(1)* %13, align 1, !dbg !250, !tbaa !261
          br label %L70, !dbg !250

L70:                                              ; preds = %L60, %L45
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !264
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L90.preheader, label %L152, !dbg !266

L90.preheader:                                    ; preds = %L70
       %state.i14.fca.0.extract = extractvalue [5 x i64] %state, 0
       %14 = inttoptr i64 %state.i14.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L90, !dbg !271

L90:                                              ; preds = %L106, %L90.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %15 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.080.0.copyload, i64 1, i64 2, i32 4), !dbg !274
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %15, label %L106 [
    i64 1, label %L110
    i64 5, label %L101
    i64 6, label %L101
  ], !dbg !271

L101:                                             ; preds = %L90, %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %14, align 1, !dbg !276, !tbaa !109, !alias.scope !113, !noalias !116
          br label %L106, !dbg !276

L106:                                             ; preds = %L101, %L90
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !280
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !282

L110:                                             ; preds = %L126, %L90
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %16 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.080.0.copyload, i32 2), !dbg !283
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
        switch i64 %16, label %L126 [
    i64 4, label %L130
    i64 5, label %L121
    i64 6, label %L121
  ], !dbg !289

L121:                                             ; preds = %L110, %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %14, align 1, !dbg !290, !tbaa !109, !alias.scope !113, !noalias !116
          br label %L126, !dbg !290

L126:                                             ; preds = %L121, %L110
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !294
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !296

L130:                                             ; preds = %L110
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %17 = bitcast i8 addrspace(1)* %.sroa.685.0.copyload to i8 addrspace(1)* addrspace(1)*, !dbg !297
          %18 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %17, align 1, !dbg !297, !tbaa !261
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %.not129 = icmp eq i8 addrspace(1)* %18, null, !dbg !306
; │││││└
       br i1 %.not129, label %L138, label %L146, !dbg !308

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.080.0.copyload, i64 5, i32 3), !dbg !309
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %14, align 1, !dbg !313, !tbaa !109, !alias.scope !113, !noalias !116
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !317
        unreachable, !dbg !317

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %19 = bitcast i8 addrspace(1)* %18 to i64 addrspace(1)*, !dbg !321
          %20 = load i64, i64 addrspace(1)* %19, align 1, !dbg !321, !tbaa !261
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          store i64 %20, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !328, !tbaa !334
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.080.0.copyload, i64 0, i32 3), !dbg !336
        br label %L152, !dbg !336

L152:                                             ; preds = %L146, %L70
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !339
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %21 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !341, !tbaa !334
; │└└└└└└└
; │┌ @ essentials.jl:513 within `reinterpret`
    %22 = inttoptr i64 %21 to i8 addrspace(1)*, !dbg !348
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:49 within `device_string_to_host`
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %.not96 = icmp eq i64 %21, 0, !dbg !349
; │└
   br i1 %.not96, label %L165, label %L222, !dbg !351

L165:                                             ; preds = %L152
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i12.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !352
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %23 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1 to i8 addrspace(5)*, !dbg !361
     %24 = inttoptr i64 %state.i12.fca.1.extract to i8*, !dbg !361
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %23, i8* noundef nonnull align 1 dereferenceable(24) %24, i64 24, i1 false), !dbg !361, !tbaa !197, !alias.scope !198, !noalias !199
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L183, label %L205, !dbg !364

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %25 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !369
       %26 = load i64, i64 addrspace(5)* %25, align 8, !tbaa !372, !alias.scope !374, !noalias !375
       %state.i11.fca.0.extract = extractvalue [5 x i64] %state, 0
       %27 = inttoptr i64 %state.i11.fca.0.extract to i64*
; ││││└
      br label %L185, !dbg !371

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %28 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %26, i64 0, i64 1, i32 4), !dbg !376
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %28, label %L201 [
    i64 0, label %L205
    i64 5, label %L196
    i64 6, label %L196
  ], !dbg !379

L196:                                             ; preds = %L185, %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %27, align 1, !dbg !380, !tbaa !109, !alias.scope !113, !noalias !116
         br label %L201, !dbg !380

L201:                                             ; preds = %L196, %L185
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !384
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !386

L205:                                             ; preds = %L185, %L165
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !387
; ││└└└
; ││┌ @ Base.jl:37 within `getproperty`
     %29 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !389
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %30 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %29, align 8, !dbg !390, !tbaa !372, !alias.scope !374, !noalias !375
; ││└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(41) %30, i8 addrspace(1)* noundef align 1 dereferenceable(41) addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @4, i64 0, i64 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !395
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %31 = getelementptr inbounds i8, i8 addrspace(1)* %30, i64 41, !dbg !399
       store i8 0, i8 addrspace(1)* %31, align 1, !dbg !399, !tbaa !261
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %32 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1 to { i64, i8 addrspace(1)*, i64 }*, !dbg !404
     call fastcc void @julia_hostcall_device_trigger_and_return__2222([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %32), !dbg !404
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !406

L222:                                             ; preds = %L152
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:54 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nonnull align 1 %22, i8 addrspace(1)* align 1 %2, i64 %3, i1 false), !dbg !407
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:56 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %33 = getelementptr i8, i8 addrspace(1)* %22, i64 %3, !dbg !411
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %33, align 1, !dbg !413, !tbaa !261
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !406

L231:                                             ; preds = %L222, %L205
       %value_phi1 = phi i64 [ 0, %L205 ], [ %21, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:67 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:186 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i10.fca.2.extract = extractvalue [5 x i64] %state, 2, !dbg !419
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %34 = inttoptr i64 %state.i10.fca.2.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !426
    %.sroa.062.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, i32 0, !dbg !426
    %.sroa.062.0.copyload = load i64, i64* %.sroa.062.0..sroa_idx, align 1, !dbg !426, !tbaa !197, !alias.scope !198, !noalias !199
    %.sroa.566.0..sroa_idx67 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, i32 1, !dbg !426
    %.sroa.566.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.566.0..sroa_idx67, align 1, !dbg !426, !tbaa !197, !alias.scope !198, !noalias !199
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:192 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L256.preheader, label %L276, !dbg !428

L256.preheader:                                   ; preds = %L231
     %state.i9.fca.0.extract = extractvalue [5 x i64] %state, 0
     %35 = inttoptr i64 %state.i9.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L256, !dbg !433

L256:                                             ; preds = %L272, %L256.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %36 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.062.0.copyload, i64 0, i64 1, i32 4), !dbg !436
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %36, label %L272 [
    i64 0, label %L276
    i64 5, label %L267
    i64 6, label %L267
  ], !dbg !433

L267:                                             ; preds = %L256, %L256
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %35, align 1, !dbg !438, !tbaa !109, !alias.scope !113, !noalias !116
        br label %L272, !dbg !438

L272:                                             ; preds = %L267, %L256
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !442
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L256, !dbg !444

L276:                                             ; preds = %L256, %L231
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !445
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:194 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %37 = bitcast i8 addrspace(1)* %.sroa.566.0.copyload to i64 addrspace(1)*, !dbg !447
      store i64 1, i64 addrspace(1)* %37, align 1, !dbg !447, !tbaa !261
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %38 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 8, !dbg !454
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:197 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %39 = bitcast i8 addrspace(1)* %38 to i64 addrspace(1)*, !dbg !456
       store i64 ptrtoint (i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([108 x i8], [108 x i8]* @3, i64 0, i64 0) to i8 addrspace(1)*) to i64), i64 addrspace(1)* %39, align 1, !dbg !456, !tbaa !261
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %40 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 16, !dbg !465
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %41 = bitcast i8 addrspace(1)* %40 to i64 addrspace(1)*, !dbg !467
       store i64 107, i64 addrspace(1)* %41, align 1, !dbg !467, !tbaa !261
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
   br i1 %.not, label %L308, label %L323, !dbg !474

L308:                                             ; preds = %L276
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:197 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:157 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %42 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 24, !dbg !476
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:162 within `_pointer_from_type`
; │││┌ @ boot.jl:795 within `UInt64`
      %43 = ptrtoint {}* inttoptr (i64 139925250646112 to {}*) to i64, !dbg !478
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %44 = bitcast i8 addrspace(1)* %42 to i64 addrspace(1)*, !dbg !485
       store i64 %43, i64 addrspace(1)* %44, align 1, !dbg !485, !tbaa !261
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %45 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 32, !dbg !491
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %46 = bitcast i8 addrspace(1)* %45 to i64 addrspace(1)*, !dbg !493
       store i64 %value_phi1, i64 addrspace(1)* %46, align 1, !dbg !493, !tbaa !261
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %47 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 40, !dbg !500
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %48 = bitcast i8 addrspace(1)* %47 to i64 addrspace(1)*, !dbg !502
      store i64 0, i64 addrspace(1)* %48, align 1, !dbg !502, !tbaa !261
      br label %L323, !dbg !502

L323:                                             ; preds = %L308, %L276
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !508
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L338.preheader, label %L379, !dbg !510

L338.preheader:                                   ; preds = %L323
     %state.i8.fca.0.extract = extractvalue [5 x i64] %state, 0
     %49 = inttoptr i64 %state.i8.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L338, !dbg !514

L338:                                             ; preds = %L354, %L338.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %50 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.062.0.copyload, i64 1, i64 2, i32 4), !dbg !517
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %50, label %L354 [
    i64 1, label %L358
    i64 5, label %L349
    i64 6, label %L349
  ], !dbg !514

L349:                                             ; preds = %L338, %L338
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %49, align 1, !dbg !519, !tbaa !109, !alias.scope !113, !noalias !116
        br label %L354, !dbg !519

L354:                                             ; preds = %L349, %L338
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !523
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L338, !dbg !525

L358:                                             ; preds = %L374, %L338
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %51 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.062.0.copyload, i32 2), !dbg !526
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
      switch i64 %51, label %L374 [
    i64 4, label %L377
    i64 5, label %L369
    i64 6, label %L369
  ], !dbg !530

L369:                                             ; preds = %L358, %L358
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %49, align 1, !dbg !531, !tbaa !109, !alias.scope !113, !noalias !116
        br label %L374, !dbg !531

L374:                                             ; preds = %L369, %L358
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !535
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L358, !dbg !537

L377:                                             ; preds = %L358
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.062.0.copyload, i64 0, i32 3), !dbg !538
      br label %L379, !dbg !538

L379:                                             ; preds = %L377, %L323
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !541
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i5.fca.4.extract = extractvalue [5 x i64] %state, 4, !dbg !543
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %52 = inttoptr i64 %state.i5.fca.4.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !551
    %.sroa.051.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %52, i64 0, i32 0, !dbg !551
    %.sroa.051.0.copyload = load i64, i64* %.sroa.051.0..sroa_idx, align 1, !dbg !551, !tbaa !197, !alias.scope !198, !noalias !199
    %.sroa.555.0..sroa_idx56 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %52, i64 0, i32 1, !dbg !551
    %53 = bitcast i8 addrspace(1)** %.sroa.555.0..sroa_idx56 to i64 addrspace(1)**, !dbg !551
    %.sroa.555.0.copyload110111 = load i64 addrspace(1)*, i64 addrspace(1)** %53, align 1, !dbg !551, !tbaa !197, !alias.scope !198, !noalias !199
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L403.preheader, label %L423, !dbg !553

L403.preheader:                                   ; preds = %L379
      %state.i4.fca.0.extract = extractvalue [5 x i64] %state, 0
      %54 = inttoptr i64 %state.i4.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L403, !dbg !559

L403:                                             ; preds = %L419, %L403.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %55 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.051.0.copyload, i64 0, i64 1, i32 4), !dbg !562
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %55, label %L419 [
    i64 0, label %L423
    i64 5, label %L414
    i64 6, label %L414
  ], !dbg !559

L414:                                             ; preds = %L403, %L403
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %54, align 1, !dbg !564, !tbaa !109, !alias.scope !113, !noalias !116
         br label %L419, !dbg !564

L419:                                             ; preds = %L414, %L403
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !568
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L403, !dbg !570

L423:                                             ; preds = %L403, %L379
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !571
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L438, label %L448, !dbg !573

L438:                                             ; preds = %L423
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         store i64 %value_phi1, i64 addrspace(1)* %.sroa.555.0.copyload110111, align 1, !dbg !577, !tbaa !261
         br label %L448, !dbg !577

L448:                                             ; preds = %L438, %L423
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !584
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L464.preheader, label %L505, !dbg !586

L464.preheader:                                   ; preds = %L448
      %state.i3.fca.0.extract = extractvalue [5 x i64] %state, 0
      %56 = inttoptr i64 %state.i3.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L464, !dbg !590

L464:                                             ; preds = %L480, %L464.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %57 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.051.0.copyload, i64 1, i64 2, i32 4), !dbg !593
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %57, label %L480 [
    i64 1, label %L484
    i64 5, label %L475
    i64 6, label %L475
  ], !dbg !590

L475:                                             ; preds = %L464, %L464
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %56, align 1, !dbg !595, !tbaa !109, !alias.scope !113, !noalias !116
         br label %L480, !dbg !595

L480:                                             ; preds = %L475, %L464
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !599
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L464, !dbg !601

L484:                                             ; preds = %L500, %L464
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %58 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.051.0.copyload, i32 2), !dbg !602
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
       switch i64 %58, label %L500 [
    i64 4, label %L503
    i64 5, label %L495
    i64 6, label %L495
  ], !dbg !606

L495:                                             ; preds = %L484, %L484
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %56, align 1, !dbg !607, !tbaa !109, !alias.scope !113, !noalias !116
         br label %L500, !dbg !607

L500:                                             ; preds = %L495, %L484
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !611
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L484, !dbg !613

L503:                                             ; preds = %L484
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.051.0.copyload, i64 0, i32 3), !dbg !614
       br label %L505, !dbg !614

L505:                                             ; preds = %L503, %L448
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !617
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:72 within `report_exception`
  ret void, !dbg !619
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2229([5 x i64] %state, i64 zeroext %0, i64 signext %1) unnamed_addr #9 !dbg !620 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %2 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !621
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not3 = icmp eq i64 %2, %1, !dbg !626
; └
  br i1 %.not3, label %L20, label %L6, !dbg !628

L6:                                               ; preds = %L18, %top
  %3 = phi i64 [ %5, %L18 ], [ %2, %top ]
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !629

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !630
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !641
    store i64 1, i64* %4, align 1, !dbg !641, !tbaa !109, !alias.scope !113, !noalias !116
    br label %L18, !dbg !641

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !645
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %5 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !621
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %5, %1, !dbg !626
; └
  br i1 %.not, label %L20, label %L6, !dbg !628

L20:                                              ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !625
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:45 within `#throw_inexacterror`
; Function Attrs: noinline noreturn
define internal fastcc void @julia__throw_inexacterror_2211([5 x i64] %state) unnamed_addr #10 !dbg !648 {
top:
  %0 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:84 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !649
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %1 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0 to i8 addrspace(5)*, !dbg !660
    %2 = inttoptr i64 %state.i.fca.1.extract to i8*, !dbg !660
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %1, i8* noundef nonnull align 1 dereferenceable(24) %2, i64 24, i1 false), !dbg !660, !tbaa !197, !alias.scope !198, !noalias !199
; │└
   %3 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0 to { i64, i8 addrspace(1)*, i64 }*, !dbg !663
   call fastcc void @julia_hostcall_device_lock__2228([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %3), !dbg !663
; │┌ @ Base.jl:37 within `getproperty`
    %4 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0, i32 0, i32 1, !dbg !664
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %5 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %4, align 8, !dbg !666, !tbaa !372, !alias.scope !374, !noalias !375
; │└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(7) %5, i8 addrspace(1)* noundef align 1 dereferenceable(7) addrspacecast (i8* getelementptr inbounds ([8 x i8], [8 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*), i64 7, i1 false), !dbg !672
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %6 = getelementptr i8, i8 addrspace(1)* %5, i64 7, !dbg !670
; │└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(18) %6, i8 addrspace(1)* noundef align 1 dereferenceable(18) addrspacecast (i8* getelementptr inbounds ([19 x i8], [19 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*), i64 18, i1 false), !dbg !672
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %7 = getelementptr i8, i8 addrspace(1)* %5, i64 25, !dbg !670
; │└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     store i8 46, i8 addrspace(1)* %7, align 1, !dbg !672
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %8 = getelementptr inbounds i8, i8 addrspace(1)* %5, i64 26, !dbg !676
      store i8 10, i8 addrspace(1)* %8, align 1, !dbg !676, !tbaa !261
      %9 = getelementptr inbounds i8, i8 addrspace(1)* %5, i64 27, !dbg !676
      store i8 0, i8 addrspace(1)* %9, align 1, !dbg !676, !tbaa !261
; │└└└
   call fastcc void @julia_hostcall_device_trigger_and_return__2225([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %3), !dbg !663
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i1.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !684
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %10 = inttoptr i64 %state.i1.fca.0.extract to i64*, !dbg !692
    store i64 1, i64* %10, align 1, !dbg !692, !tbaa !109, !alias.scope !113, !noalias !116
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:13 within `#throw_inexacterror`
  call fastcc void @gpu_report_exception([5 x i64] %state, i64 ptrtoint ([10 x i8]* @exception.4 to i64)), !dbg !696
  call fastcc void @gpu_signal_exception([5 x i64] %state), !dbg !696
  call void @llvm.amdgcn.endpgm(), !dbg !696
  unreachable, !dbg !696
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2199([5 x i64] %state, i64 zeroext %0, i64 signext %1) unnamed_addr #9 !dbg !697 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %2 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !698
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not3 = icmp eq i64 %2, %1, !dbg !703
; └
  br i1 %.not3, label %L20, label %L6, !dbg !705

L6:                                               ; preds = %L18, %top
  %3 = phi i64 [ %5, %L18 ], [ %2, %top ]
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !706

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !707
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !718
    store i64 1, i64* %4, align 1, !dbg !718, !tbaa !109, !alias.scope !113, !noalias !116
    br label %L18, !dbg !718

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !722
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %5 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !698
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %5, %1, !dbg !703
; └
  br i1 %.not, label %L20, label %L6, !dbg !705

L20:                                              ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !702
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2202([5 x i64] %state, i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #9 !dbg !725 {
top:
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !726
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %3, %1, !dbg !731
; └
  br i1 %.not, label %L20, label %L6, !dbg !733

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !734

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !735
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !746
    store i64 1, i64* %4, align 1, !dbg !746, !tbaa !109, !alias.scope !113, !noalias !116
    br label %L18, !dbg !746

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !750
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !753

L20:                                              ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !730
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:30 within `signal_exception`
define internal fastcc void @gpu_signal_exception([5 x i64] %state) unnamed_addr #9 !dbg !754 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !755
; └└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
   %0 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !764
   store i64 1, i64* %0, align 1, !dbg !764, !tbaa !109, !alias.scope !113, !noalias !116
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `signal_exception`
  ret void, !dbg !768
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:49 within `#throw_boundserror`
; Function Attrs: noinline noreturn
define internal fastcc void @julia__throw_boundserror_2175([5 x i64] %state) unnamed_addr #10 !dbg !769 {
top:
  %0 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:84 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !770
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %1 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0 to i8 addrspace(5)*, !dbg !781
    %2 = inttoptr i64 %state.i.fca.1.extract to i8*, !dbg !781
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %1, i8* noundef nonnull align 1 dereferenceable(24) %2, i64 24, i1 false), !dbg !781, !tbaa !197, !alias.scope !198, !noalias !199
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %3 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !785, !range !142
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %.not = icmp eq i32 %3, 0, !dbg !801
; │││└└
     br i1 %.not, label %L19, label %top.L41_crit_edge, !dbg !794

top.L41_crit_edge:                                ; preds = %top
; └└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %.pre = extractvalue [5 x i64] %state, 0, !dbg !808
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %.pre15 = inttoptr i64 %.pre to i64*, !dbg !816
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br label %L41, !dbg !794

L19:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ Base.jl:37 within `getproperty`
      %4 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0, i32 0, i32 0, !dbg !820
      %5 = load i64, i64 addrspace(5)* %4, align 8, !tbaa !372, !alias.scope !374, !noalias !375
      %state.i2.fca.0.extract = extractvalue [5 x i64] %state, 0
      %6 = inttoptr i64 %state.i2.fca.0.extract to i64*
; │││└
     br label %L21, !dbg !822

L21:                                              ; preds = %L37, %L19
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %7 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %5, i64 0, i64 1, i32 4), !dbg !823
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %7, label %L37 [
    i64 0, label %L41
    i64 5, label %L32
    i64 6, label %L32
  ], !dbg !828

L32:                                              ; preds = %L21, %L21
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %6, align 1, !dbg !829, !tbaa !109, !alias.scope !113, !noalias !116
        br label %L37, !dbg !829

L37:                                              ; preds = %L32, %L21
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !833
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L21, !dbg !836

L41:                                              ; preds = %L21, %top.L41_crit_edge
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %.pre-phi = phi i64* [ %.pre15, %top.L41_crit_edge ], [ %6, %L21 ], !dbg !816
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !837
; │└└└
; │┌ @ Base.jl:37 within `getproperty`
    %8 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0, i32 0, i32 1, !dbg !840
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %9 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %8, align 8, !dbg !841, !tbaa !372, !alias.scope !374, !noalias !375
; │└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(7) %9, i8 addrspace(1)* noundef align 1 dereferenceable(7) addrspacecast (i8* getelementptr inbounds ([8 x i8], [8 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*), i64 7, i1 false), !dbg !847
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %10 = getelementptr i8, i8 addrspace(1)* %9, i64 7, !dbg !845
; │└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(26) %10, i8 addrspace(1)* noundef align 1 dereferenceable(26) addrspacecast (i8* getelementptr inbounds ([27 x i8], [27 x i8]* @2, i64 0, i64 0) to i8 addrspace(1)*), i64 26, i1 false), !dbg !847
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %11 = getelementptr i8, i8 addrspace(1)* %9, i64 33, !dbg !845
; │└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     store i8 46, i8 addrspace(1)* %11, align 1, !dbg !847
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %12 = getelementptr inbounds i8, i8 addrspace(1)* %9, i64 34, !dbg !851
      store i8 10, i8 addrspace(1)* %12, align 1, !dbg !851, !tbaa !261
      %13 = getelementptr inbounds i8, i8 addrspace(1)* %9, i64 35, !dbg !851
      store i8 0, i8 addrspace(1)* %13, align 1, !dbg !851, !tbaa !261
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
    %14 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %0 to { i64, i8 addrspace(1)*, i64 }*, !dbg !859
    call fastcc void @julia_hostcall_device_trigger_and_return__2192([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %14), !dbg !859
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    store i64 1, i64* %.pre-phi, align 1, !dbg !816, !tbaa !109, !alias.scope !113, !noalias !116
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:13 within `#throw_boundserror`
  call fastcc void @gpu_report_exception([5 x i64] %state, i64 ptrtoint ([10 x i8]* @exception.4 to i64)), !dbg !861
  call fastcc void @gpu_signal_exception([5 x i64] %state), !dbg !861
  call void @llvm.amdgcn.endpgm(), !dbg !861
  unreachable, !dbg !861
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:114 within `hostcall_device_lock!`
define internal fastcc void @julia_hostcall_device_lock__2228([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #9 !dbg !862 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !863, !range !142
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %.not = icmp eq i32 %1, 0, !dbg !880
; │└└
   br i1 %.not, label %L14, label %L36, !dbg !873

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │┌ @ Base.jl:37 within `getproperty`
    %2 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !887
    %3 = load i64, i64* %2, align 8, !tbaa !156, !alias.scope !158, !noalias !159
; │└
   br label %L16, !dbg !889

L16:                                              ; preds = %L32, %L14
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
     %4 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %3, i64 0, i64 1, i32 4), !dbg !890
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
    switch i64 %4, label %L32 [
    i64 0, label %L36
    i64 5, label %L27
    i64 6, label %L27
  ], !dbg !895

L27:                                              ; preds = %L16, %L16
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
        %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !896
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
      %5 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !905
      store i64 1, i64* %5, align 1, !dbg !905, !tbaa !109, !alias.scope !113, !noalias !116
      br label %L32, !dbg !905

L32:                                              ; preds = %L27, %L16
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
     call void @llvm.amdgcn.s.sleep(i32 5), !dbg !909
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
    br label %L16, !dbg !912

L36:                                              ; preds = %L16, %top
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !913
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
  ret void, !dbg !879
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2192([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #9 !dbg !916 {
top:
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !917, !range !142
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %.not = icmp eq i32 %1, 0, !dbg !932
; │└└
   br i1 %.not, label %L15, label %L21, !dbg !927

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %2 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !939
; │└
   %3 = load i64, i64* %2, align 8, !dbg !941, !tbaa !156, !alias.scope !158, !noalias !159
   call fastcc void @julia_hostcall_device_signal_wait_cas__2202([5 x i64] %state, i64 %3, i64 1, i64 2), !dbg !941
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
   call fastcc void @julia_hostcall_device_signal_wait_2199([5 x i64] %state, i64 %3, i64 4), !dbg !942
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    call fastcc void @__ockl_hsa_signal_store(i64 %3, i64 0, i32 3), !dbg !943
    br label %L21, !dbg !943

L21:                                              ; preds = %L15, %top
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !947
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !929
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:366 within `set_one!`
define amdgpu_kernel void @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE([5 x i64] %state, { [1 x i64], i8 addrspace(1)* } %0) local_unnamed_addr #9 !dbg !950 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)* }, align 8, addrspace(5)
  %.fca.0.0.extract = extractvalue { [1 x i64], i8 addrspace(1)* } %0, 0, 0
  %.fca.0.0.gep = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(5)* %1, i32 0, i32 0, i32 0
  store i64 %.fca.0.0.extract, i64 addrspace(5)* %.fca.0.0.gep, align 8
  %.fca.1.extract = extractvalue { [1 x i64], i8 addrspace(1)* } %0, 1
  %.fca.1.gep = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(5)* %1, i32 0, i32 1
  store i8 addrspace(1)* %.fca.1.extract, i8 addrspace(1)* addrspace(5)* %.fca.1.gep, align 8
  %2 = alloca [1 x i64], align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:367 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %3 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !951, !range !142
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %4 = add nuw nsw i32 %3, 1, !dbg !962
; └└└
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:132 within `workgroupIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %5 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !965, !range !972
; └└└└
; ┌ @ int.jl:1042 within `-` @ int.jl:86
   %6 = zext i32 %5 to i64, !dbg !973
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:140 within `workgroupDim`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %7 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !976
      %8 = getelementptr inbounds i8, i8 addrspace(4)* %7, i64 4, !dbg !976
      %9 = bitcast i8 addrspace(4)* %8 to i16 addrspace(4)*, !dbg !976
      %10 = load i16, i16 addrspace(4)* %9, align 4, !dbg !976, !range !984
; └└└└
; ┌ @ int.jl:1040 within `*`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %11 = zext i16 %10 to i64, !dbg !985
; │└└└└
; │ @ int.jl:1042 within `*` @ int.jl:88
   %12 = mul nuw nsw i64 %11, %6, !dbg !996
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %13 = zext i32 %4 to i64, !dbg !998
; │└└└└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %14 = add nuw nsw i64 %12, %13, !dbg !1003
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:368 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#getindex`
; │┌ @ abstractarray.jl:707 within `checkbounds`
    %15 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !1005
    store i64 %14, i64 addrspace(5)* %15, align 8, !dbg !1005, !tbaa !372, !alias.scope !374, !noalias !375
; ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %16 = icmp sgt i64 %.fca.0.0.extract, 0, !dbg !1012
            %17 = select i1 %16, i64 %.fca.0.0.extract, i64 0, !dbg !1012
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %.not = icmp ugt i64 %14, %17, !dbg !1033
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    br i1 %.not, label %L38, label %L41, !dbg !1032

L38:                                              ; preds = %conversion
    %18 = addrspacecast { [1 x i64], i8 addrspace(1)* } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)* }*
    %19 = addrspacecast [1 x i64] addrspace(5)* %2 to [1 x i64]*, !dbg !1032
    call fastcc void @julia__throw_boundserror_2175([5 x i64] %state), !dbg !1032
    unreachable, !dbg !1032

L41:                                              ; preds = %conversion
    %20 = bitcast i8 addrspace(1)* %.fca.1.extract to i32 addrspace(1)*, !dbg !1032
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:89 within `#getindex`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
; ││││┌ @ int.jl:86 within `-`
       %21 = add nsw i64 %14, -1, !dbg !1037
; ││││└
      %22 = getelementptr inbounds i32, i32 addrspace(1)* %20, i64 %21, !dbg !1038
      %23 = load i32, i32 addrspace(1)* %22, align 4, !dbg !1038, !tbaa !261
; └└└└
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:523 within `rem`
    %24 = sext i32 %23 to i64, !dbg !1046
; │└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %25 = add nsw i64 %24, 3, !dbg !1048
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:95 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:783 within `Int32`
      %26 = call fastcc i32 @julia_toInt32_2205([5 x i64] %state, i64 %25), !dbg !1050
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i32 %26, i32 addrspace(1)* %22, align 4, !dbg !1057, !tbaa !261
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `set_one!`
  ret void, !dbg !1061
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:157 within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2225([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #9 !dbg !1062 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
  call fastcc void @julia_hostcall_device_trigger_and_return__2192([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %0), !dbg !1063
  ret void, !dbg !1063
}

attributes #0 = { nounwind willreturn }
attributes #1 = { convergent nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { argmemonly nofree nounwind willreturn }
attributes #4 = { cold noreturn nounwind }
attributes #5 = { convergent nounwind readnone willreturn }
attributes #6 = { nounwind }
attributes #7 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #8 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #9 = { "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #10 = { noinline noreturn "frame-pointer"="all" "probe-stack"="inline-asm" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !8, !10, !12, !14, !15, !16, !17, !18, !20, !22, !23, !24, !25, !26, !27, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !57, !58, !59, !60}
!opencl.ocl.version = !{!61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61}
!llvm.ident = !{!62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62}
!julia.kernel = !{!63}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!6 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!7 = !DIFile(filename: "none", directory: ".")
!8 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !9, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!9 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl", directory: ".")
!10 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !11, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!11 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!12 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !13, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!13 = !DIFile(filename: "boot.jl", directory: ".")
!14 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !13, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!15 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!16 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !9, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!17 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !11, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!18 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !19, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!19 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl", directory: ".")
!20 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!21 = !DIFile(filename: "/home/pxl-th/.julia/dev/GPUCompiler/src/runtime.jl", directory: ".")
!22 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!23 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!24 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!25 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!26 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!27 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!28 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!29 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!30 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!31 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!32 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!33 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!34 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!35 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!36 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!37 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!38 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!39 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!40 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!41 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!42 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!43 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!44 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!45 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!46 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!47 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!48 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!49 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!50 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!51 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!52 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!53 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!54 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!55 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !56, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!56 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!57 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!58 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!59 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!60 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!61 = !{i32 2, i32 0}
!62 = !{!"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"}
!63 = !{void ([5 x i64], { [1 x i64], i8 addrspace(1)* })* @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE}
!64 = !{!65, !66, i64 16}
!65 = !{!"amd_signal_s", !66, i64 0, !67, i64 8, !66, i64 16, !69, i64 24, !69, i64 28, !66, i64 32, !66, i64 40, !67, i64 48, !67, i64 56}
!66 = !{!"long", !67, i64 0}
!67 = !{!"omnipotent char", !68, i64 0}
!68 = !{!"Simple C/C++ TBAA"}
!69 = !{!"int", !67, i64 0}
!70 = !{!65, !69, i64 24}
!71 = !{!65, !66, i64 0}
!72 = !{!67, !67, i64 0}
!73 = distinct !DISubprogram(name: "toInt32", linkageName: "julia_toInt32_2205", scope: null, file: !13, line: 693, type: !74, scopeLine: 693, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !75)
!74 = !DISubroutineType(types: !75)
!75 = !{}
!76 = !DILocation(line: 693, scope: !73)
!77 = distinct !DISubprogram(name: "checked_trunc_sint", linkageName: "julia_checked_trunc_sint_2208", scope: null, file: !13, line: 652, type: !74, scopeLine: 652, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !75)
!78 = !DILocation(line: 656, scope: !77)
!79 = !DILocation(line: 654, scope: !77)
!80 = !DILocation(line: 657, scope: !77)
!81 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2232", scope: null, file: !5, line: 32, type: !74, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!82 = !DILocation(line: 27, scope: !83, inlinedAt: !84)
!83 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!84 = !DILocation(line: 37, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!86 = !DILocation(line: 36, scope: !81)
!87 = !DILocation(line: 499, scope: !88, inlinedAt: !90)
!88 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!89 = !DIFile(filename: "promotion.jl", directory: ".")
!90 = !DILocation(line: 38, scope: !85, inlinedAt: !86)
!91 = !DILocation(line: 40, scope: !85, inlinedAt: !86)
!92 = !DILocation(line: 40, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!94 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl", directory: ".")
!95 = !DILocation(line: 0, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!97 = !DILocation(line: 0, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!99 = !DILocation(line: 11, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!101 = !DILocation(line: 31, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!103 = !DILocation(line: 41, scope: !85, inlinedAt: !86)
!104 = !DILocation(line: 126, scope: !105, inlinedAt: !107)
!105 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!106 = !DIFile(filename: "pointer.jl", directory: ".")
!107 = !DILocation(line: 126, scope: !105, inlinedAt: !108)
!108 = !DILocation(line: 33, scope: !102, inlinedAt: !103)
!109 = !{!110, !110, i64 0}
!110 = !{!"jtbaa_data", !111, i64 0}
!111 = !{!"jtbaa", !112, i64 0}
!112 = !{!"jtbaa"}
!113 = !{!114}
!114 = !{!"jnoalias_data", !115}
!115 = !{!"jnoalias"}
!116 = !{!117, !118, !119, !120}
!117 = !{!"jnoalias_gcframe", !115}
!118 = !{!"jnoalias_stack", !115}
!119 = !{!"jnoalias_typemd", !115}
!120 = !{!"jnoalias_const", !115}
!121 = !DILocation(line: 108, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !75)
!123 = !DILocation(line: 46, scope: !85, inlinedAt: !86)
!124 = !DILocation(line: 47, scope: !85, inlinedAt: !86)
!125 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2222", scope: null, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!126 = !DILocation(line: 40, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!128 = !DILocation(line: 3, scope: !129, inlinedAt: !131)
!129 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!130 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!131 = !DILocation(line: 3, scope: !132, inlinedAt: !133)
!132 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!133 = !DILocation(line: 89, scope: !134, inlinedAt: !135)
!134 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!135 = !DILocation(line: 124, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!137 = !DILocation(line: 92, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!139 = !DILocation(line: 0, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!141 = !DILocation(line: 0, scope: !125)
!142 = !{i32 0, i32 1023}
!143 = !DILocation(line: 499, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!145 = !DILocation(line: 449, scope: !144, inlinedAt: !146)
!146 = !DILocation(line: 492, scope: !147, inlinedAt: !149)
!147 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!148 = !DIFile(filename: "int.jl", directory: ".")
!149 = !DILocation(line: 269, scope: !150, inlinedAt: !137)
!150 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !151, file: !151, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!151 = !DIFile(filename: "operators.jl", directory: ".")
!152 = !DILocation(line: 37, scope: !153, inlinedAt: !155)
!153 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!154 = !DIFile(filename: "Base.jl", directory: ".")
!155 = !DILocation(line: 174, scope: !138, inlinedAt: !139)
!156 = !{!157, !157, i64 0}
!157 = !{!"jtbaa_const", !111, i64 0}
!158 = !{!120}
!159 = !{!117, !118, !114, !119}
!160 = !DILocation(line: 176, scope: !138, inlinedAt: !139)
!161 = !DILocation(line: 19, scope: !162, inlinedAt: !163)
!162 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!163 = !DILocation(line: 19, scope: !162, inlinedAt: !164)
!164 = !DILocation(line: 188, scope: !138, inlinedAt: !139)
!165 = !DILocation(line: 6, scope: !166, inlinedAt: !168)
!166 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !167, file: !167, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !75)
!167 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!168 = !DILocation(line: 109, scope: !138, inlinedAt: !139)
!169 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_2154", scope: null, file: !28, line: 65, type: !74, scopeLine: 65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!170 = !DILocation(line: 513, scope: !171, inlinedAt: !173)
!171 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !172, file: !172, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!172 = !DIFile(filename: "essentials.jl", directory: ".")
!173 = !DILocation(line: 43, scope: !174, inlinedAt: !175)
!174 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!175 = !DILocation(line: 66, scope: !169)
!176 = !DILocation(line: 40, scope: !177, inlinedAt: !178)
!177 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!178 = !DILocation(line: 3, scope: !179, inlinedAt: !181)
!179 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !180, file: !180, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!180 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!181 = !DILocation(line: 3, scope: !182, inlinedAt: !183)
!182 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !180, file: !180, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!183 = !DILocation(line: 44, scope: !174, inlinedAt: !175)
!184 = !DILocation(line: 40, scope: !177, inlinedAt: !185)
!185 = !DILocation(line: 0, scope: !186, inlinedAt: !187)
!186 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!187 = !DILocation(line: 0, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!189 = !DILocation(line: 23, scope: !190, inlinedAt: !191)
!190 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!191 = !DILocation(line: 4, scope: !192, inlinedAt: !193)
!192 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!193 = !DILocation(line: 47, scope: !174, inlinedAt: !175)
!194 = !DILocation(line: 111, scope: !195, inlinedAt: !196)
!195 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!196 = !DILocation(line: 111, scope: !195, inlinedAt: !191)
!197 = !{!111, !111, i64 0}
!198 = !{!114, !118}
!199 = !{!117, !119, !120}
!200 = !DILocation(line: 40, scope: !177, inlinedAt: !201)
!201 = !DILocation(line: 3, scope: !202, inlinedAt: !203)
!202 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!203 = !DILocation(line: 3, scope: !204, inlinedAt: !205)
!204 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!205 = !DILocation(line: 89, scope: !206, inlinedAt: !207)
!206 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!207 = !DILocation(line: 124, scope: !208, inlinedAt: !209)
!208 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!209 = !DILocation(line: 92, scope: !210, inlinedAt: !211)
!210 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!211 = !DILocation(line: 0, scope: !186, inlinedAt: !212)
!212 = !DILocation(line: 0, scope: !213, inlinedAt: !214)
!213 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!214 = !DILocation(line: 71, scope: !215, inlinedAt: !216)
!215 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!216 = !DILocation(line: 65, scope: !215, inlinedAt: !217)
!217 = !DILocation(line: 5, scope: !192, inlinedAt: !193)
!218 = !DILocation(line: 499, scope: !219, inlinedAt: !220)
!219 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!220 = !DILocation(line: 449, scope: !219, inlinedAt: !221)
!221 = !DILocation(line: 492, scope: !222, inlinedAt: !223)
!222 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!223 = !DILocation(line: 269, scope: !224, inlinedAt: !209)
!224 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !151, file: !151, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!225 = !DILocation(line: 38, scope: !226, inlinedAt: !227)
!226 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!227 = !DILocation(line: 36, scope: !226, inlinedAt: !228)
!228 = !DILocation(line: 124, scope: !210, inlinedAt: !211)
!229 = !DILocation(line: 27, scope: !230, inlinedAt: !231)
!230 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!231 = !DILocation(line: 37, scope: !226, inlinedAt: !227)
!232 = !DILocation(line: 126, scope: !233, inlinedAt: !234)
!233 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!234 = !DILocation(line: 126, scope: !233, inlinedAt: !235)
!235 = !DILocation(line: 33, scope: !236, inlinedAt: !237)
!236 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!237 = !DILocation(line: 41, scope: !226, inlinedAt: !227)
!238 = !DILocation(line: 108, scope: !239, inlinedAt: !240)
!239 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!240 = !DILocation(line: 46, scope: !226, inlinedAt: !227)
!241 = !DILocation(line: 47, scope: !226, inlinedAt: !227)
!242 = !DILocation(line: 6, scope: !243, inlinedAt: !244)
!243 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !167, file: !167, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!244 = !DILocation(line: 109, scope: !210, inlinedAt: !211)
!245 = !DILocation(line: 92, scope: !210, inlinedAt: !246)
!246 = !DILocation(line: 0, scope: !186, inlinedAt: !247)
!247 = !DILocation(line: 0, scope: !248, inlinedAt: !249)
!248 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!249 = !DILocation(line: 72, scope: !215, inlinedAt: !216)
!250 = !DILocation(line: 40, scope: !177, inlinedAt: !251)
!251 = !DILocation(line: 46, scope: !252, inlinedAt: !254)
!252 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!253 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl", directory: ".")
!254 = !DILocation(line: 46, scope: !255, inlinedAt: !256)
!255 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!256 = !DILocation(line: 88, scope: !257, inlinedAt: !258)
!257 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!258 = !DILocation(line: 88, scope: !257, inlinedAt: !259)
!259 = !DILocation(line: 88, scope: !257, inlinedAt: !260)
!260 = !DILocation(line: 152, scope: !210, inlinedAt: !246)
!261 = !{!262, !262, i64 0, i64 0}
!262 = !{!"custom_tbaa_addrspace(1)", !263, i64 0}
!263 = !{!"custom_tbaa"}
!264 = !DILocation(line: 6, scope: !243, inlinedAt: !265)
!265 = !DILocation(line: 109, scope: !210, inlinedAt: !246)
!266 = !DILocation(line: 92, scope: !210, inlinedAt: !267)
!267 = !DILocation(line: 0, scope: !186, inlinedAt: !268)
!268 = !DILocation(line: 0, scope: !269, inlinedAt: !270)
!269 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!270 = !DILocation(line: 73, scope: !215, inlinedAt: !216)
!271 = !DILocation(line: 38, scope: !226, inlinedAt: !272)
!272 = !DILocation(line: 36, scope: !226, inlinedAt: !273)
!273 = !DILocation(line: 174, scope: !210, inlinedAt: !267)
!274 = !DILocation(line: 27, scope: !230, inlinedAt: !275)
!275 = !DILocation(line: 37, scope: !226, inlinedAt: !272)
!276 = !DILocation(line: 126, scope: !233, inlinedAt: !277)
!277 = !DILocation(line: 126, scope: !233, inlinedAt: !278)
!278 = !DILocation(line: 33, scope: !236, inlinedAt: !279)
!279 = !DILocation(line: 41, scope: !226, inlinedAt: !272)
!280 = !DILocation(line: 108, scope: !239, inlinedAt: !281)
!281 = !DILocation(line: 46, scope: !226, inlinedAt: !272)
!282 = !DILocation(line: 47, scope: !226, inlinedAt: !272)
!283 = !DILocation(line: 12, scope: !284, inlinedAt: !285)
!284 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!285 = !DILocation(line: 61, scope: !286, inlinedAt: !287)
!286 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!287 = !DILocation(line: 60, scope: !286, inlinedAt: !288)
!288 = !DILocation(line: 176, scope: !210, inlinedAt: !267)
!289 = !DILocation(line: 62, scope: !286, inlinedAt: !287)
!290 = !DILocation(line: 126, scope: !233, inlinedAt: !291)
!291 = !DILocation(line: 126, scope: !233, inlinedAt: !292)
!292 = !DILocation(line: 33, scope: !236, inlinedAt: !293)
!293 = !DILocation(line: 65, scope: !286, inlinedAt: !287)
!294 = !DILocation(line: 108, scope: !239, inlinedAt: !295)
!295 = !DILocation(line: 70, scope: !286, inlinedAt: !287)
!296 = !DILocation(line: 71, scope: !286, inlinedAt: !287)
!297 = !DILocation(line: 40, scope: !177, inlinedAt: !298)
!298 = !DILocation(line: 9, scope: !252, inlinedAt: !299)
!299 = !DILocation(line: 9, scope: !300, inlinedAt: !301)
!300 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!301 = !DILocation(line: 85, scope: !302, inlinedAt: !303)
!302 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!303 = !DILocation(line: 85, scope: !302, inlinedAt: !304)
!304 = !DILocation(line: 85, scope: !302, inlinedAt: !305)
!305 = !DILocation(line: 180, scope: !210, inlinedAt: !267)
!306 = !DILocation(line: 499, scope: !219, inlinedAt: !307)
!307 = !DILocation(line: 492, scope: !222, inlinedAt: !308)
!308 = !DILocation(line: 181, scope: !210, inlinedAt: !267)
!309 = !DILocation(line: 19, scope: !310, inlinedAt: !311)
!310 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!311 = !DILocation(line: 19, scope: !310, inlinedAt: !312)
!312 = !DILocation(line: 182, scope: !210, inlinedAt: !267)
!313 = !DILocation(line: 126, scope: !233, inlinedAt: !314)
!314 = !DILocation(line: 126, scope: !233, inlinedAt: !315)
!315 = !DILocation(line: 33, scope: !236, inlinedAt: !316)
!316 = !DILocation(line: 183, scope: !210, inlinedAt: !267)
!317 = !DILocation(line: 1, scope: !318, inlinedAt: !320)
!318 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !319, file: !319, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!319 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!320 = !DILocation(line: 184, scope: !210, inlinedAt: !267)
!321 = !DILocation(line: 40, scope: !177, inlinedAt: !322)
!322 = !DILocation(line: 9, scope: !252, inlinedAt: !323)
!323 = !DILocation(line: 9, scope: !300, inlinedAt: !324)
!324 = !DILocation(line: 85, scope: !302, inlinedAt: !325)
!325 = !DILocation(line: 85, scope: !302, inlinedAt: !326)
!326 = !DILocation(line: 85, scope: !302, inlinedAt: !327)
!327 = !DILocation(line: 186, scope: !210, inlinedAt: !267)
!328 = !DILocation(line: 40, scope: !177, inlinedAt: !329)
!329 = !DILocation(line: 46, scope: !252, inlinedAt: !330)
!330 = !DILocation(line: 46, scope: !255, inlinedAt: !331)
!331 = !DILocation(line: 88, scope: !257, inlinedAt: !332)
!332 = !DILocation(line: 88, scope: !257, inlinedAt: !333)
!333 = !DILocation(line: 88, scope: !257, inlinedAt: !327)
!334 = !{!335, !335, i64 0, i64 0}
!335 = !{!"custom_tbaa_addrspace(3)", !263, i64 0}
!336 = !DILocation(line: 19, scope: !310, inlinedAt: !337)
!337 = !DILocation(line: 19, scope: !310, inlinedAt: !338)
!338 = !DILocation(line: 188, scope: !210, inlinedAt: !267)
!339 = !DILocation(line: 6, scope: !243, inlinedAt: !340)
!340 = !DILocation(line: 109, scope: !210, inlinedAt: !267)
!341 = !DILocation(line: 40, scope: !177, inlinedAt: !342)
!342 = !DILocation(line: 9, scope: !252, inlinedAt: !343)
!343 = !DILocation(line: 9, scope: !300, inlinedAt: !344)
!344 = !DILocation(line: 85, scope: !302, inlinedAt: !345)
!345 = !DILocation(line: 85, scope: !302, inlinedAt: !346)
!346 = !DILocation(line: 85, scope: !302, inlinedAt: !347)
!347 = !DILocation(line: 191, scope: !210, inlinedAt: !267)
!348 = !DILocation(line: 513, scope: !171, inlinedAt: !193)
!349 = !DILocation(line: 499, scope: !219, inlinedAt: !350)
!350 = !DILocation(line: 492, scope: !222, inlinedAt: !351)
!351 = !DILocation(line: 49, scope: !174, inlinedAt: !175)
!352 = !DILocation(line: 40, scope: !177, inlinedAt: !353)
!353 = !DILocation(line: 0, scope: !186, inlinedAt: !354)
!354 = !DILocation(line: 0, scope: !188, inlinedAt: !355)
!355 = !DILocation(line: 15, scope: !356, inlinedAt: !357)
!356 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!357 = !DILocation(line: 69, scope: !358, inlinedAt: !360)
!358 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!359 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!360 = !DILocation(line: 50, scope: !174, inlinedAt: !175)
!361 = !DILocation(line: 111, scope: !195, inlinedAt: !362)
!362 = !DILocation(line: 111, scope: !195, inlinedAt: !363)
!363 = !DILocation(line: 70, scope: !358, inlinedAt: !360)
!364 = !DILocation(line: 92, scope: !210, inlinedAt: !365)
!365 = !DILocation(line: 0, scope: !186, inlinedAt: !366)
!366 = !DILocation(line: 0, scope: !213, inlinedAt: !367)
!367 = !DILocation(line: 115, scope: !368, inlinedAt: !363)
!368 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!369 = !DILocation(line: 37, scope: !370, inlinedAt: !371)
!370 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!371 = !DILocation(line: 124, scope: !210, inlinedAt: !365)
!372 = !{!373, !373, i64 0}
!373 = !{!"jtbaa_stack", !111, i64 0}
!374 = !{!118}
!375 = !{!117, !114, !119, !120}
!376 = !DILocation(line: 27, scope: !230, inlinedAt: !377)
!377 = !DILocation(line: 37, scope: !226, inlinedAt: !378)
!378 = !DILocation(line: 36, scope: !226, inlinedAt: !371)
!379 = !DILocation(line: 38, scope: !226, inlinedAt: !378)
!380 = !DILocation(line: 126, scope: !233, inlinedAt: !381)
!381 = !DILocation(line: 126, scope: !233, inlinedAt: !382)
!382 = !DILocation(line: 33, scope: !236, inlinedAt: !383)
!383 = !DILocation(line: 41, scope: !226, inlinedAt: !378)
!384 = !DILocation(line: 108, scope: !239, inlinedAt: !385)
!385 = !DILocation(line: 46, scope: !226, inlinedAt: !378)
!386 = !DILocation(line: 47, scope: !226, inlinedAt: !378)
!387 = !DILocation(line: 6, scope: !243, inlinedAt: !388)
!388 = !DILocation(line: 109, scope: !210, inlinedAt: !365)
!389 = !DILocation(line: 37, scope: !370, inlinedAt: !363)
!390 = !DILocation(line: 513, scope: !171, inlinedAt: !391)
!391 = !DILocation(line: 100, scope: !392, inlinedAt: !393)
!392 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!393 = !DILocation(line: 114, scope: !394, inlinedAt: !363)
!394 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!395 = !DILocation(line: 40, scope: !177, inlinedAt: !396)
!396 = !DILocation(line: 0, scope: !186, inlinedAt: !397)
!397 = !DILocation(line: 0, scope: !398, inlinedAt: !363)
!398 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!399 = !DILocation(line: 40, scope: !177, inlinedAt: !400)
!400 = !DILocation(line: 46, scope: !252, inlinedAt: !401)
!401 = !DILocation(line: 46, scope: !255, inlinedAt: !402)
!402 = !DILocation(line: 88, scope: !257, inlinedAt: !403)
!403 = !DILocation(line: 88, scope: !257, inlinedAt: !363)
!404 = !DILocation(line: 158, scope: !405, inlinedAt: !363)
!405 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!406 = !DILocation(line: 168, scope: !210, inlinedAt: !267)
!407 = !DILocation(line: 40, scope: !177, inlinedAt: !408)
!408 = !DILocation(line: 0, scope: !186, inlinedAt: !409)
!409 = !DILocation(line: 0, scope: !398, inlinedAt: !410)
!410 = !DILocation(line: 54, scope: !174, inlinedAt: !175)
!411 = !DILocation(line: 114, scope: !394, inlinedAt: !412)
!412 = !DILocation(line: 56, scope: !174, inlinedAt: !175)
!413 = !DILocation(line: 40, scope: !177, inlinedAt: !414)
!414 = !DILocation(line: 46, scope: !252, inlinedAt: !415)
!415 = !DILocation(line: 46, scope: !255, inlinedAt: !416)
!416 = !DILocation(line: 88, scope: !257, inlinedAt: !417)
!417 = !DILocation(line: 88, scope: !257, inlinedAt: !418)
!418 = !DILocation(line: 88, scope: !257, inlinedAt: !412)
!419 = !DILocation(line: 40, scope: !177, inlinedAt: !420)
!420 = !DILocation(line: 0, scope: !186, inlinedAt: !421)
!421 = !DILocation(line: 0, scope: !188, inlinedAt: !422)
!422 = !DILocation(line: 19, scope: !423, inlinedAt: !424)
!423 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!424 = !DILocation(line: 186, scope: !358, inlinedAt: !425)
!425 = !DILocation(line: 67, scope: !169)
!426 = !DILocation(line: 111, scope: !195, inlinedAt: !427)
!427 = !DILocation(line: 111, scope: !195, inlinedAt: !424)
!428 = !DILocation(line: 92, scope: !210, inlinedAt: !429)
!429 = !DILocation(line: 0, scope: !186, inlinedAt: !430)
!430 = !DILocation(line: 0, scope: !213, inlinedAt: !431)
!431 = !DILocation(line: 115, scope: !368, inlinedAt: !432)
!432 = !DILocation(line: 192, scope: !358, inlinedAt: !425)
!433 = !DILocation(line: 38, scope: !226, inlinedAt: !434)
!434 = !DILocation(line: 36, scope: !226, inlinedAt: !435)
!435 = !DILocation(line: 124, scope: !210, inlinedAt: !429)
!436 = !DILocation(line: 27, scope: !230, inlinedAt: !437)
!437 = !DILocation(line: 37, scope: !226, inlinedAt: !434)
!438 = !DILocation(line: 126, scope: !233, inlinedAt: !439)
!439 = !DILocation(line: 126, scope: !233, inlinedAt: !440)
!440 = !DILocation(line: 33, scope: !236, inlinedAt: !441)
!441 = !DILocation(line: 41, scope: !226, inlinedAt: !434)
!442 = !DILocation(line: 108, scope: !239, inlinedAt: !443)
!443 = !DILocation(line: 46, scope: !226, inlinedAt: !434)
!444 = !DILocation(line: 47, scope: !226, inlinedAt: !434)
!445 = !DILocation(line: 6, scope: !243, inlinedAt: !446)
!446 = !DILocation(line: 109, scope: !210, inlinedAt: !429)
!447 = !DILocation(line: 40, scope: !177, inlinedAt: !448)
!448 = !DILocation(line: 46, scope: !252, inlinedAt: !449)
!449 = !DILocation(line: 46, scope: !255, inlinedAt: !450)
!450 = !DILocation(line: 88, scope: !257, inlinedAt: !451)
!451 = !DILocation(line: 88, scope: !257, inlinedAt: !452)
!452 = !DILocation(line: 88, scope: !257, inlinedAt: !453)
!453 = !DILocation(line: 194, scope: !358, inlinedAt: !425)
!454 = !DILocation(line: 114, scope: !394, inlinedAt: !455)
!455 = !DILocation(line: 195, scope: !358, inlinedAt: !425)
!456 = !DILocation(line: 40, scope: !177, inlinedAt: !457)
!457 = !DILocation(line: 46, scope: !252, inlinedAt: !458)
!458 = !DILocation(line: 46, scope: !255, inlinedAt: !459)
!459 = !DILocation(line: 88, scope: !257, inlinedAt: !460)
!460 = !DILocation(line: 88, scope: !257, inlinedAt: !461)
!461 = !DILocation(line: 88, scope: !257, inlinedAt: !462)
!462 = !DILocation(line: 154, scope: !463, inlinedAt: !464)
!463 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!464 = !DILocation(line: 197, scope: !358, inlinedAt: !425)
!465 = !DILocation(line: 114, scope: !394, inlinedAt: !466)
!466 = !DILocation(line: 155, scope: !463, inlinedAt: !464)
!467 = !DILocation(line: 40, scope: !177, inlinedAt: !468)
!468 = !DILocation(line: 46, scope: !252, inlinedAt: !469)
!469 = !DILocation(line: 46, scope: !255, inlinedAt: !470)
!470 = !DILocation(line: 88, scope: !257, inlinedAt: !471)
!471 = !DILocation(line: 88, scope: !257, inlinedAt: !472)
!472 = !DILocation(line: 88, scope: !257, inlinedAt: !473)
!473 = !DILocation(line: 156, scope: !463, inlinedAt: !464)
!474 = !DILocation(line: 92, scope: !210, inlinedAt: !475)
!475 = !DILocation(line: 200, scope: !358, inlinedAt: !425)
!476 = !DILocation(line: 114, scope: !394, inlinedAt: !477)
!477 = !DILocation(line: 157, scope: !463, inlinedAt: !464)
!478 = !DILocation(line: 795, scope: !479, inlinedAt: !480)
!479 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!480 = !DILocation(line: 162, scope: !481, inlinedAt: !482)
!481 = distinct !DISubprogram(name: "_pointer_from_type;", linkageName: "_pointer_from_type", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!482 = !DILocation(line: 166, scope: !483, inlinedAt: !484)
!483 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!484 = !DILocation(line: 107, scope: !210, inlinedAt: !475)
!485 = !DILocation(line: 40, scope: !177, inlinedAt: !486)
!486 = !DILocation(line: 46, scope: !252, inlinedAt: !487)
!487 = !DILocation(line: 46, scope: !255, inlinedAt: !488)
!488 = !DILocation(line: 88, scope: !257, inlinedAt: !489)
!489 = !DILocation(line: 88, scope: !257, inlinedAt: !490)
!490 = !DILocation(line: 88, scope: !257, inlinedAt: !482)
!491 = !DILocation(line: 114, scope: !394, inlinedAt: !492)
!492 = !DILocation(line: 167, scope: !483, inlinedAt: !484)
!493 = !DILocation(line: 40, scope: !177, inlinedAt: !494)
!494 = !DILocation(line: 46, scope: !252, inlinedAt: !495)
!495 = !DILocation(line: 46, scope: !255, inlinedAt: !496)
!496 = !DILocation(line: 88, scope: !257, inlinedAt: !497)
!497 = !DILocation(line: 88, scope: !257, inlinedAt: !498)
!498 = !DILocation(line: 88, scope: !257, inlinedAt: !499)
!499 = !DILocation(line: 169, scope: !483, inlinedAt: !484)
!500 = !DILocation(line: 114, scope: !394, inlinedAt: !501)
!501 = !DILocation(line: 170, scope: !483, inlinedAt: !484)
!502 = !DILocation(line: 40, scope: !177, inlinedAt: !503)
!503 = !DILocation(line: 46, scope: !252, inlinedAt: !504)
!504 = !DILocation(line: 46, scope: !255, inlinedAt: !505)
!505 = !DILocation(line: 88, scope: !257, inlinedAt: !506)
!506 = !DILocation(line: 88, scope: !257, inlinedAt: !507)
!507 = !DILocation(line: 88, scope: !257, inlinedAt: !484)
!508 = !DILocation(line: 6, scope: !243, inlinedAt: !509)
!509 = !DILocation(line: 109, scope: !210, inlinedAt: !475)
!510 = !DILocation(line: 92, scope: !210, inlinedAt: !511)
!511 = !DILocation(line: 0, scope: !186, inlinedAt: !512)
!512 = !DILocation(line: 0, scope: !269, inlinedAt: !513)
!513 = !DILocation(line: 158, scope: !405, inlinedAt: !475)
!514 = !DILocation(line: 38, scope: !226, inlinedAt: !515)
!515 = !DILocation(line: 36, scope: !226, inlinedAt: !516)
!516 = !DILocation(line: 174, scope: !210, inlinedAt: !511)
!517 = !DILocation(line: 27, scope: !230, inlinedAt: !518)
!518 = !DILocation(line: 37, scope: !226, inlinedAt: !515)
!519 = !DILocation(line: 126, scope: !233, inlinedAt: !520)
!520 = !DILocation(line: 126, scope: !233, inlinedAt: !521)
!521 = !DILocation(line: 33, scope: !236, inlinedAt: !522)
!522 = !DILocation(line: 41, scope: !226, inlinedAt: !515)
!523 = !DILocation(line: 108, scope: !239, inlinedAt: !524)
!524 = !DILocation(line: 46, scope: !226, inlinedAt: !515)
!525 = !DILocation(line: 47, scope: !226, inlinedAt: !515)
!526 = !DILocation(line: 12, scope: !284, inlinedAt: !527)
!527 = !DILocation(line: 61, scope: !286, inlinedAt: !528)
!528 = !DILocation(line: 60, scope: !286, inlinedAt: !529)
!529 = !DILocation(line: 176, scope: !210, inlinedAt: !511)
!530 = !DILocation(line: 62, scope: !286, inlinedAt: !528)
!531 = !DILocation(line: 126, scope: !233, inlinedAt: !532)
!532 = !DILocation(line: 126, scope: !233, inlinedAt: !533)
!533 = !DILocation(line: 33, scope: !236, inlinedAt: !534)
!534 = !DILocation(line: 65, scope: !286, inlinedAt: !528)
!535 = !DILocation(line: 108, scope: !239, inlinedAt: !536)
!536 = !DILocation(line: 70, scope: !286, inlinedAt: !528)
!537 = !DILocation(line: 71, scope: !286, inlinedAt: !528)
!538 = !DILocation(line: 19, scope: !310, inlinedAt: !539)
!539 = !DILocation(line: 19, scope: !310, inlinedAt: !540)
!540 = !DILocation(line: 188, scope: !210, inlinedAt: !511)
!541 = !DILocation(line: 6, scope: !243, inlinedAt: !542)
!542 = !DILocation(line: 109, scope: !210, inlinedAt: !511)
!543 = !DILocation(line: 40, scope: !177, inlinedAt: !544)
!544 = !DILocation(line: 0, scope: !186, inlinedAt: !545)
!545 = !DILocation(line: 0, scope: !188, inlinedAt: !546)
!546 = !DILocation(line: 27, scope: !547, inlinedAt: !548)
!547 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!548 = !DILocation(line: 10, scope: !549, inlinedAt: !550)
!549 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !75)
!550 = !DILocation(line: 71, scope: !169)
!551 = !DILocation(line: 111, scope: !195, inlinedAt: !552)
!552 = !DILocation(line: 111, scope: !195, inlinedAt: !548)
!553 = !DILocation(line: 92, scope: !210, inlinedAt: !554)
!554 = !DILocation(line: 0, scope: !186, inlinedAt: !555)
!555 = !DILocation(line: 0, scope: !213, inlinedAt: !556)
!556 = !DILocation(line: 71, scope: !215, inlinedAt: !557)
!557 = !DILocation(line: 65, scope: !215, inlinedAt: !558)
!558 = !DILocation(line: 11, scope: !549, inlinedAt: !550)
!559 = !DILocation(line: 38, scope: !226, inlinedAt: !560)
!560 = !DILocation(line: 36, scope: !226, inlinedAt: !561)
!561 = !DILocation(line: 124, scope: !210, inlinedAt: !554)
!562 = !DILocation(line: 27, scope: !230, inlinedAt: !563)
!563 = !DILocation(line: 37, scope: !226, inlinedAt: !560)
!564 = !DILocation(line: 126, scope: !233, inlinedAt: !565)
!565 = !DILocation(line: 126, scope: !233, inlinedAt: !566)
!566 = !DILocation(line: 33, scope: !236, inlinedAt: !567)
!567 = !DILocation(line: 41, scope: !226, inlinedAt: !560)
!568 = !DILocation(line: 108, scope: !239, inlinedAt: !569)
!569 = !DILocation(line: 46, scope: !226, inlinedAt: !560)
!570 = !DILocation(line: 47, scope: !226, inlinedAt: !560)
!571 = !DILocation(line: 6, scope: !243, inlinedAt: !572)
!572 = !DILocation(line: 109, scope: !210, inlinedAt: !554)
!573 = !DILocation(line: 92, scope: !210, inlinedAt: !574)
!574 = !DILocation(line: 0, scope: !186, inlinedAt: !575)
!575 = !DILocation(line: 0, scope: !248, inlinedAt: !576)
!576 = !DILocation(line: 72, scope: !215, inlinedAt: !557)
!577 = !DILocation(line: 40, scope: !177, inlinedAt: !578)
!578 = !DILocation(line: 46, scope: !252, inlinedAt: !579)
!579 = !DILocation(line: 46, scope: !255, inlinedAt: !580)
!580 = !DILocation(line: 88, scope: !257, inlinedAt: !581)
!581 = !DILocation(line: 88, scope: !257, inlinedAt: !582)
!582 = !DILocation(line: 88, scope: !257, inlinedAt: !583)
!583 = !DILocation(line: 152, scope: !210, inlinedAt: !574)
!584 = !DILocation(line: 6, scope: !243, inlinedAt: !585)
!585 = !DILocation(line: 109, scope: !210, inlinedAt: !574)
!586 = !DILocation(line: 92, scope: !210, inlinedAt: !587)
!587 = !DILocation(line: 0, scope: !186, inlinedAt: !588)
!588 = !DILocation(line: 0, scope: !269, inlinedAt: !589)
!589 = !DILocation(line: 73, scope: !215, inlinedAt: !557)
!590 = !DILocation(line: 38, scope: !226, inlinedAt: !591)
!591 = !DILocation(line: 36, scope: !226, inlinedAt: !592)
!592 = !DILocation(line: 174, scope: !210, inlinedAt: !587)
!593 = !DILocation(line: 27, scope: !230, inlinedAt: !594)
!594 = !DILocation(line: 37, scope: !226, inlinedAt: !591)
!595 = !DILocation(line: 126, scope: !233, inlinedAt: !596)
!596 = !DILocation(line: 126, scope: !233, inlinedAt: !597)
!597 = !DILocation(line: 33, scope: !236, inlinedAt: !598)
!598 = !DILocation(line: 41, scope: !226, inlinedAt: !591)
!599 = !DILocation(line: 108, scope: !239, inlinedAt: !600)
!600 = !DILocation(line: 46, scope: !226, inlinedAt: !591)
!601 = !DILocation(line: 47, scope: !226, inlinedAt: !591)
!602 = !DILocation(line: 12, scope: !284, inlinedAt: !603)
!603 = !DILocation(line: 61, scope: !286, inlinedAt: !604)
!604 = !DILocation(line: 60, scope: !286, inlinedAt: !605)
!605 = !DILocation(line: 176, scope: !210, inlinedAt: !587)
!606 = !DILocation(line: 62, scope: !286, inlinedAt: !604)
!607 = !DILocation(line: 126, scope: !233, inlinedAt: !608)
!608 = !DILocation(line: 126, scope: !233, inlinedAt: !609)
!609 = !DILocation(line: 33, scope: !236, inlinedAt: !610)
!610 = !DILocation(line: 65, scope: !286, inlinedAt: !604)
!611 = !DILocation(line: 108, scope: !239, inlinedAt: !612)
!612 = !DILocation(line: 70, scope: !286, inlinedAt: !604)
!613 = !DILocation(line: 71, scope: !286, inlinedAt: !604)
!614 = !DILocation(line: 19, scope: !310, inlinedAt: !615)
!615 = !DILocation(line: 19, scope: !310, inlinedAt: !616)
!616 = !DILocation(line: 188, scope: !210, inlinedAt: !587)
!617 = !DILocation(line: 6, scope: !243, inlinedAt: !618)
!618 = !DILocation(line: 109, scope: !210, inlinedAt: !587)
!619 = !DILocation(line: 72, scope: !169)
!620 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2229", scope: null, file: !5, line: 57, type: !74, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!621 = !DILocation(line: 12, scope: !622, inlinedAt: !623)
!622 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!623 = !DILocation(line: 61, scope: !624, inlinedAt: !625)
!624 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!625 = !DILocation(line: 60, scope: !620)
!626 = !DILocation(line: 499, scope: !627, inlinedAt: !628)
!627 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!628 = !DILocation(line: 62, scope: !624, inlinedAt: !625)
!629 = !DILocation(line: 64, scope: !624, inlinedAt: !625)
!630 = !DILocation(line: 40, scope: !631, inlinedAt: !632)
!631 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!632 = !DILocation(line: 0, scope: !633, inlinedAt: !634)
!633 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!634 = !DILocation(line: 0, scope: !635, inlinedAt: !636)
!635 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!636 = !DILocation(line: 11, scope: !637, inlinedAt: !638)
!637 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!638 = !DILocation(line: 31, scope: !639, inlinedAt: !640)
!639 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!640 = !DILocation(line: 65, scope: !624, inlinedAt: !625)
!641 = !DILocation(line: 126, scope: !642, inlinedAt: !643)
!642 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!643 = !DILocation(line: 126, scope: !642, inlinedAt: !644)
!644 = !DILocation(line: 33, scope: !639, inlinedAt: !640)
!645 = !DILocation(line: 108, scope: !646, inlinedAt: !647)
!646 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !75)
!647 = !DILocation(line: 70, scope: !624, inlinedAt: !625)
!648 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_2211", scope: null, file: !11, line: 45, type: !74, scopeLine: 45, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!649 = !DILocation(line: 40, scope: !650, inlinedAt: !651)
!650 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!651 = !DILocation(line: 0, scope: !652, inlinedAt: !653)
!652 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!653 = !DILocation(line: 0, scope: !654, inlinedAt: !655)
!654 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!655 = !DILocation(line: 15, scope: !656, inlinedAt: !657)
!656 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!657 = !DILocation(line: 84, scope: !658, inlinedAt: !659)
!658 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!659 = !DILocation(line: 8, scope: !648)
!660 = !DILocation(line: 111, scope: !661, inlinedAt: !662)
!661 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!662 = !DILocation(line: 111, scope: !661, inlinedAt: !663)
!663 = !DILocation(line: 85, scope: !658, inlinedAt: !659)
!664 = !DILocation(line: 37, scope: !665, inlinedAt: !663)
!665 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!666 = !DILocation(line: 513, scope: !667, inlinedAt: !668)
!667 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !172, file: !172, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!668 = !DILocation(line: 100, scope: !669, inlinedAt: !670)
!669 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!670 = !DILocation(line: 114, scope: !671, inlinedAt: !663)
!671 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!672 = !DILocation(line: 40, scope: !650, inlinedAt: !673)
!673 = !DILocation(line: 0, scope: !652, inlinedAt: !674)
!674 = !DILocation(line: 0, scope: !675, inlinedAt: !663)
!675 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!676 = !DILocation(line: 40, scope: !650, inlinedAt: !677)
!677 = !DILocation(line: 46, scope: !678, inlinedAt: !679)
!678 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!679 = !DILocation(line: 46, scope: !680, inlinedAt: !681)
!680 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!681 = !DILocation(line: 88, scope: !682, inlinedAt: !683)
!682 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!683 = !DILocation(line: 88, scope: !682, inlinedAt: !663)
!684 = !DILocation(line: 40, scope: !650, inlinedAt: !685)
!685 = !DILocation(line: 0, scope: !652, inlinedAt: !686)
!686 = !DILocation(line: 0, scope: !654, inlinedAt: !687)
!687 = !DILocation(line: 11, scope: !688, inlinedAt: !689)
!688 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!689 = !DILocation(line: 31, scope: !690, inlinedAt: !691)
!690 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!691 = !DILocation(line: 9, scope: !648)
!692 = !DILocation(line: 126, scope: !693, inlinedAt: !694)
!693 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !75)
!694 = !DILocation(line: 126, scope: !693, inlinedAt: !695)
!695 = !DILocation(line: 33, scope: !690, inlinedAt: !691)
!696 = !DILocation(line: 13, scope: !648)
!697 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2199", scope: null, file: !5, line: 57, type: !74, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!698 = !DILocation(line: 12, scope: !699, inlinedAt: !700)
!699 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!700 = !DILocation(line: 61, scope: !701, inlinedAt: !702)
!701 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!702 = !DILocation(line: 60, scope: !697)
!703 = !DILocation(line: 499, scope: !704, inlinedAt: !705)
!704 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!705 = !DILocation(line: 62, scope: !701, inlinedAt: !702)
!706 = !DILocation(line: 64, scope: !701, inlinedAt: !702)
!707 = !DILocation(line: 40, scope: !708, inlinedAt: !709)
!708 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!709 = !DILocation(line: 0, scope: !710, inlinedAt: !711)
!710 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!711 = !DILocation(line: 0, scope: !712, inlinedAt: !713)
!712 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!713 = !DILocation(line: 11, scope: !714, inlinedAt: !715)
!714 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!715 = !DILocation(line: 31, scope: !716, inlinedAt: !717)
!716 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!717 = !DILocation(line: 65, scope: !701, inlinedAt: !702)
!718 = !DILocation(line: 126, scope: !719, inlinedAt: !720)
!719 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!720 = !DILocation(line: 126, scope: !719, inlinedAt: !721)
!721 = !DILocation(line: 33, scope: !716, inlinedAt: !717)
!722 = !DILocation(line: 108, scope: !723, inlinedAt: !724)
!723 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !75)
!724 = !DILocation(line: 70, scope: !701, inlinedAt: !702)
!725 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2202", scope: null, file: !5, line: 32, type: !74, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!726 = !DILocation(line: 27, scope: !727, inlinedAt: !728)
!727 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!728 = !DILocation(line: 37, scope: !729, inlinedAt: !730)
!729 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!730 = !DILocation(line: 36, scope: !725)
!731 = !DILocation(line: 499, scope: !732, inlinedAt: !733)
!732 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!733 = !DILocation(line: 38, scope: !729, inlinedAt: !730)
!734 = !DILocation(line: 40, scope: !729, inlinedAt: !730)
!735 = !DILocation(line: 40, scope: !736, inlinedAt: !737)
!736 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!737 = !DILocation(line: 0, scope: !738, inlinedAt: !739)
!738 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!739 = !DILocation(line: 0, scope: !740, inlinedAt: !741)
!740 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!741 = !DILocation(line: 11, scope: !742, inlinedAt: !743)
!742 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!743 = !DILocation(line: 31, scope: !744, inlinedAt: !745)
!744 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!745 = !DILocation(line: 41, scope: !729, inlinedAt: !730)
!746 = !DILocation(line: 126, scope: !747, inlinedAt: !748)
!747 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!748 = !DILocation(line: 126, scope: !747, inlinedAt: !749)
!749 = !DILocation(line: 33, scope: !744, inlinedAt: !745)
!750 = !DILocation(line: 108, scope: !751, inlinedAt: !752)
!751 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !75)
!752 = !DILocation(line: 46, scope: !729, inlinedAt: !730)
!753 = !DILocation(line: 47, scope: !729, inlinedAt: !730)
!754 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2358", scope: null, file: !28, line: 30, type: !74, scopeLine: 30, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!755 = !DILocation(line: 40, scope: !756, inlinedAt: !757)
!756 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!757 = !DILocation(line: 0, scope: !758, inlinedAt: !759)
!758 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!759 = !DILocation(line: 0, scope: !760, inlinedAt: !761)
!760 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!761 = !DILocation(line: 11, scope: !762, inlinedAt: !763)
!762 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!763 = !DILocation(line: 31, scope: !754)
!764 = !DILocation(line: 126, scope: !765, inlinedAt: !766)
!765 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !75)
!766 = !DILocation(line: 126, scope: !765, inlinedAt: !767)
!767 = !DILocation(line: 33, scope: !754)
!768 = !DILocation(line: 37, scope: !754)
!769 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_2175", scope: null, file: !11, line: 49, type: !74, scopeLine: 49, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!770 = !DILocation(line: 40, scope: !771, inlinedAt: !772)
!771 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!772 = !DILocation(line: 0, scope: !773, inlinedAt: !774)
!773 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!774 = !DILocation(line: 0, scope: !775, inlinedAt: !776)
!775 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!776 = !DILocation(line: 15, scope: !777, inlinedAt: !778)
!777 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!778 = !DILocation(line: 84, scope: !779, inlinedAt: !780)
!779 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !359, file: !359, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!780 = !DILocation(line: 8, scope: !769)
!781 = !DILocation(line: 111, scope: !782, inlinedAt: !783)
!782 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!783 = !DILocation(line: 111, scope: !782, inlinedAt: !784)
!784 = !DILocation(line: 85, scope: !779, inlinedAt: !780)
!785 = !DILocation(line: 40, scope: !771, inlinedAt: !786)
!786 = !DILocation(line: 3, scope: !787, inlinedAt: !788)
!787 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!788 = !DILocation(line: 3, scope: !789, inlinedAt: !790)
!789 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!790 = !DILocation(line: 89, scope: !791, inlinedAt: !792)
!791 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!792 = !DILocation(line: 124, scope: !793, inlinedAt: !794)
!793 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!794 = !DILocation(line: 92, scope: !795, inlinedAt: !796)
!795 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!796 = !DILocation(line: 0, scope: !773, inlinedAt: !797)
!797 = !DILocation(line: 0, scope: !798, inlinedAt: !799)
!798 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!799 = !DILocation(line: 115, scope: !800, inlinedAt: !784)
!800 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!801 = !DILocation(line: 499, scope: !802, inlinedAt: !803)
!802 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!803 = !DILocation(line: 449, scope: !802, inlinedAt: !804)
!804 = !DILocation(line: 492, scope: !805, inlinedAt: !806)
!805 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!806 = !DILocation(line: 269, scope: !807, inlinedAt: !794)
!807 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !151, file: !151, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!808 = !DILocation(line: 40, scope: !771, inlinedAt: !809)
!809 = !DILocation(line: 0, scope: !773, inlinedAt: !810)
!810 = !DILocation(line: 0, scope: !775, inlinedAt: !811)
!811 = !DILocation(line: 11, scope: !812, inlinedAt: !813)
!812 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!813 = !DILocation(line: 31, scope: !814, inlinedAt: !815)
!814 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!815 = !DILocation(line: 9, scope: !769)
!816 = !DILocation(line: 126, scope: !817, inlinedAt: !818)
!817 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!818 = !DILocation(line: 126, scope: !817, inlinedAt: !819)
!819 = !DILocation(line: 33, scope: !814, inlinedAt: !815)
!820 = !DILocation(line: 37, scope: !821, inlinedAt: !822)
!821 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!822 = !DILocation(line: 124, scope: !795, inlinedAt: !796)
!823 = !DILocation(line: 27, scope: !824, inlinedAt: !825)
!824 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!825 = !DILocation(line: 37, scope: !826, inlinedAt: !827)
!826 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!827 = !DILocation(line: 36, scope: !826, inlinedAt: !822)
!828 = !DILocation(line: 38, scope: !826, inlinedAt: !827)
!829 = !DILocation(line: 126, scope: !817, inlinedAt: !830)
!830 = !DILocation(line: 126, scope: !817, inlinedAt: !831)
!831 = !DILocation(line: 33, scope: !814, inlinedAt: !832)
!832 = !DILocation(line: 41, scope: !826, inlinedAt: !827)
!833 = !DILocation(line: 108, scope: !834, inlinedAt: !835)
!834 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!835 = !DILocation(line: 46, scope: !826, inlinedAt: !827)
!836 = !DILocation(line: 47, scope: !826, inlinedAt: !827)
!837 = !DILocation(line: 6, scope: !838, inlinedAt: !839)
!838 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !167, file: !167, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!839 = !DILocation(line: 109, scope: !795, inlinedAt: !796)
!840 = !DILocation(line: 37, scope: !821, inlinedAt: !784)
!841 = !DILocation(line: 513, scope: !842, inlinedAt: !843)
!842 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !172, file: !172, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!843 = !DILocation(line: 100, scope: !844, inlinedAt: !845)
!844 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!845 = !DILocation(line: 114, scope: !846, inlinedAt: !784)
!846 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!847 = !DILocation(line: 40, scope: !771, inlinedAt: !848)
!848 = !DILocation(line: 0, scope: !773, inlinedAt: !849)
!849 = !DILocation(line: 0, scope: !850, inlinedAt: !784)
!850 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!851 = !DILocation(line: 40, scope: !771, inlinedAt: !852)
!852 = !DILocation(line: 46, scope: !853, inlinedAt: !854)
!853 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!854 = !DILocation(line: 46, scope: !855, inlinedAt: !856)
!855 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!856 = !DILocation(line: 88, scope: !857, inlinedAt: !858)
!857 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!858 = !DILocation(line: 88, scope: !857, inlinedAt: !784)
!859 = !DILocation(line: 158, scope: !860, inlinedAt: !784)
!860 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !75)
!861 = !DILocation(line: 13, scope: !769)
!862 = distinct !DISubprogram(name: "hostcall_device_lock!", linkageName: "julia_hostcall_device_lock!_2228", scope: null, file: !9, line: 114, type: !74, scopeLine: 114, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!863 = !DILocation(line: 40, scope: !864, inlinedAt: !865)
!864 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!865 = !DILocation(line: 3, scope: !866, inlinedAt: !867)
!866 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!867 = !DILocation(line: 3, scope: !868, inlinedAt: !869)
!868 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!869 = !DILocation(line: 89, scope: !870, inlinedAt: !871)
!870 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!871 = !DILocation(line: 124, scope: !872, inlinedAt: !873)
!872 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!873 = !DILocation(line: 92, scope: !874, inlinedAt: !875)
!874 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!875 = !DILocation(line: 0, scope: !876, inlinedAt: !877)
!876 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!877 = !DILocation(line: 0, scope: !878, inlinedAt: !879)
!878 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!879 = !DILocation(line: 115, scope: !862)
!880 = !DILocation(line: 499, scope: !881, inlinedAt: !882)
!881 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!882 = !DILocation(line: 449, scope: !881, inlinedAt: !883)
!883 = !DILocation(line: 492, scope: !884, inlinedAt: !885)
!884 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!885 = !DILocation(line: 269, scope: !886, inlinedAt: !873)
!886 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !151, file: !151, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!887 = !DILocation(line: 37, scope: !888, inlinedAt: !889)
!888 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!889 = !DILocation(line: 124, scope: !874, inlinedAt: !875)
!890 = !DILocation(line: 27, scope: !891, inlinedAt: !892)
!891 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!892 = !DILocation(line: 37, scope: !893, inlinedAt: !894)
!893 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!894 = !DILocation(line: 36, scope: !893, inlinedAt: !889)
!895 = !DILocation(line: 38, scope: !893, inlinedAt: !894)
!896 = !DILocation(line: 40, scope: !864, inlinedAt: !897)
!897 = !DILocation(line: 0, scope: !876, inlinedAt: !898)
!898 = !DILocation(line: 0, scope: !899, inlinedAt: !900)
!899 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!900 = !DILocation(line: 11, scope: !901, inlinedAt: !902)
!901 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!902 = !DILocation(line: 31, scope: !903, inlinedAt: !904)
!903 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!904 = !DILocation(line: 41, scope: !893, inlinedAt: !894)
!905 = !DILocation(line: 126, scope: !906, inlinedAt: !907)
!906 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !106, file: !106, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!907 = !DILocation(line: 126, scope: !906, inlinedAt: !908)
!908 = !DILocation(line: 33, scope: !903, inlinedAt: !904)
!909 = !DILocation(line: 108, scope: !910, inlinedAt: !911)
!910 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!911 = !DILocation(line: 46, scope: !893, inlinedAt: !894)
!912 = !DILocation(line: 47, scope: !893, inlinedAt: !894)
!913 = !DILocation(line: 6, scope: !914, inlinedAt: !915)
!914 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !167, file: !167, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !75)
!915 = !DILocation(line: 109, scope: !874, inlinedAt: !875)
!916 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2192", scope: null, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!917 = !DILocation(line: 40, scope: !918, inlinedAt: !919)
!918 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!919 = !DILocation(line: 3, scope: !920, inlinedAt: !921)
!920 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!921 = !DILocation(line: 3, scope: !922, inlinedAt: !923)
!922 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!923 = !DILocation(line: 89, scope: !924, inlinedAt: !925)
!924 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!925 = !DILocation(line: 124, scope: !926, inlinedAt: !927)
!926 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!927 = !DILocation(line: 92, scope: !928, inlinedAt: !929)
!928 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!929 = !DILocation(line: 0, scope: !930, inlinedAt: !931)
!930 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!931 = !DILocation(line: 0, scope: !916)
!932 = !DILocation(line: 499, scope: !933, inlinedAt: !934)
!933 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!934 = !DILocation(line: 449, scope: !933, inlinedAt: !935)
!935 = !DILocation(line: 492, scope: !936, inlinedAt: !937)
!936 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!937 = !DILocation(line: 269, scope: !938, inlinedAt: !927)
!938 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !151, file: !151, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!939 = !DILocation(line: 37, scope: !940, inlinedAt: !941)
!940 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !154, file: !154, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!941 = !DILocation(line: 174, scope: !928, inlinedAt: !929)
!942 = !DILocation(line: 176, scope: !928, inlinedAt: !929)
!943 = !DILocation(line: 19, scope: !944, inlinedAt: !945)
!944 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!945 = !DILocation(line: 19, scope: !944, inlinedAt: !946)
!946 = !DILocation(line: 188, scope: !928, inlinedAt: !929)
!947 = !DILocation(line: 6, scope: !948, inlinedAt: !949)
!948 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !167, file: !167, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !75)
!949 = !DILocation(line: 109, scope: !928, inlinedAt: !929)
!950 = distinct !DISubprogram(name: "set_one!", linkageName: "julia_set_one!_2160", scope: null, file: !19, line: 366, type: !74, scopeLine: 366, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!951 = !DILocation(line: 40, scope: !952, inlinedAt: !953)
!952 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!953 = !DILocation(line: 3, scope: !954, inlinedAt: !955)
!954 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!955 = !DILocation(line: 3, scope: !956, inlinedAt: !957)
!956 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!957 = !DILocation(line: 89, scope: !958, inlinedAt: !959)
!958 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!959 = !DILocation(line: 124, scope: !960, inlinedAt: !961)
!960 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!961 = !DILocation(line: 367, scope: !950)
!962 = !DILocation(line: 87, scope: !963, inlinedAt: !964)
!963 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!964 = !DILocation(line: 1042, scope: !963, inlinedAt: !957)
!965 = !DILocation(line: 40, scope: !952, inlinedAt: !966)
!966 = !DILocation(line: 3, scope: !954, inlinedAt: !967)
!967 = !DILocation(line: 3, scope: !956, inlinedAt: !968)
!968 = !DILocation(line: 95, scope: !969, inlinedAt: !970)
!969 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!970 = !DILocation(line: 132, scope: !971, inlinedAt: !961)
!971 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!972 = !{i32 0, i32 -2}
!973 = !DILocation(line: 86, scope: !974, inlinedAt: !975)
!974 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!975 = !DILocation(line: 1042, scope: !974, inlinedAt: !961)
!976 = !DILocation(line: 40, scope: !952, inlinedAt: !977)
!977 = !DILocation(line: 33, scope: !954, inlinedAt: !978)
!978 = !DILocation(line: 33, scope: !979, inlinedAt: !980)
!979 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!980 = !DILocation(line: 103, scope: !981, inlinedAt: !982)
!981 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!982 = !DILocation(line: 140, scope: !983, inlinedAt: !961)
!983 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !130, file: !130, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!984 = !{i16 0, i16 1023}
!985 = !DILocation(line: 708, scope: !986, inlinedAt: !987)
!986 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !13, file: !13, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!987 = !DILocation(line: 784, scope: !988, inlinedAt: !989)
!988 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !13, file: !13, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!989 = !DILocation(line: 7, scope: !990, inlinedAt: !992)
!990 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !991, file: !991, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!991 = !DIFile(filename: "number.jl", directory: ".")
!992 = !DILocation(line: 525, scope: !993, inlinedAt: !994)
!993 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!994 = !DILocation(line: 1040, scope: !995, inlinedAt: !961)
!995 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!996 = !DILocation(line: 88, scope: !995, inlinedAt: !997)
!997 = !DILocation(line: 1042, scope: !995, inlinedAt: !961)
!998 = !DILocation(line: 708, scope: !986, inlinedAt: !999)
!999 = !DILocation(line: 784, scope: !988, inlinedAt: !1000)
!1000 = !DILocation(line: 7, scope: !990, inlinedAt: !1001)
!1001 = !DILocation(line: 525, scope: !993, inlinedAt: !1002)
!1002 = !DILocation(line: 1040, scope: !963, inlinedAt: !961)
!1003 = !DILocation(line: 87, scope: !963, inlinedAt: !1004)
!1004 = !DILocation(line: 1042, scope: !963, inlinedAt: !961)
!1005 = !DILocation(line: 707, scope: !1006, inlinedAt: !1008)
!1006 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !1007, file: !1007, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1007 = !DIFile(filename: "abstractarray.jl", directory: ".")
!1008 = !DILocation(line: 87, scope: !1009, inlinedAt: !1011)
!1009 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !1010, file: !1010, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1010 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!1011 = !DILocation(line: 368, scope: !950)
!1012 = !DILocation(line: 575, scope: !1013, inlinedAt: !1014)
!1013 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !172, file: !172, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1014 = !DILocation(line: 510, scope: !1015, inlinedAt: !1016)
!1015 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !89, file: !89, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1016 = !DILocation(line: 444, scope: !1017, inlinedAt: !1019)
!1017 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !1018, file: !1018, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1018 = !DIFile(filename: "range.jl", directory: ".")
!1019 = !DILocation(line: 457, scope: !1017, inlinedAt: !1020)
!1020 = !DILocation(line: 459, scope: !1021, inlinedAt: !1022)
!1021 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !1018, file: !1018, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1022 = !DILocation(line: 273, scope: !1023, inlinedAt: !1025)
!1023 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !1024, file: !1024, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1024 = !DIFile(filename: "tuple.jl", directory: ".")
!1025 = !DILocation(line: 98, scope: !1026, inlinedAt: !1027)
!1026 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !1007, file: !1007, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1027 = !DILocation(line: 133, scope: !1028, inlinedAt: !1029)
!1028 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !1007, file: !1007, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1029 = !DILocation(line: 382, scope: !1030, inlinedAt: !1031)
!1030 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !1007, file: !1007, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1031 = !DILocation(line: 694, scope: !1006, inlinedAt: !1032)
!1032 = !DILocation(line: 709, scope: !1006, inlinedAt: !1008)
!1033 = !DILocation(line: 488, scope: !1034, inlinedAt: !1035)
!1034 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !148, file: !148, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1035 = !DILocation(line: 768, scope: !1036, inlinedAt: !1031)
!1036 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !1007, file: !1007, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1037 = !DILocation(line: 86, scope: !974, inlinedAt: !1038)
!1038 = !DILocation(line: 40, scope: !952, inlinedAt: !1039)
!1039 = !DILocation(line: 9, scope: !1040, inlinedAt: !1041)
!1040 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1041 = !DILocation(line: 9, scope: !1042, inlinedAt: !1043)
!1042 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1043 = !DILocation(line: 85, scope: !1044, inlinedAt: !1045)
!1044 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1045 = !DILocation(line: 89, scope: !1009, inlinedAt: !1011)
!1046 = !DILocation(line: 523, scope: !993, inlinedAt: !1047)
!1047 = !DILocation(line: 1040, scope: !963, inlinedAt: !1011)
!1048 = !DILocation(line: 87, scope: !963, inlinedAt: !1049)
!1049 = !DILocation(line: 1042, scope: !963, inlinedAt: !1011)
!1050 = !DILocation(line: 783, scope: !1051, inlinedAt: !1052)
!1051 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !13, file: !13, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1052 = !DILocation(line: 7, scope: !990, inlinedAt: !1053)
!1053 = !DILocation(line: 88, scope: !1054, inlinedAt: !1055)
!1054 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1055 = !DILocation(line: 95, scope: !1056, inlinedAt: !1011)
!1056 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !1010, file: !1010, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1057 = !DILocation(line: 40, scope: !952, inlinedAt: !1058)
!1058 = !DILocation(line: 46, scope: !1040, inlinedAt: !1059)
!1059 = !DILocation(line: 46, scope: !1060, inlinedAt: !1053)
!1060 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !253, file: !253, type: !74, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !75)
!1061 = !DILocation(line: 369, scope: !950)
!1062 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2225", scope: null, file: !9, line: 157, type: !74, scopeLine: 157, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !75)
!1063 = !DILocation(line: 158, scope: !1062)
