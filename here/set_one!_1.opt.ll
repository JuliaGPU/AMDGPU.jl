; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@exception.20 = private unnamed_addr constant [31 x i8] c"julia__throw_inexacterror_2795\00", align 1
@di_func.21 = private unnamed_addr constant [19 x i8] c"checked_trunc_sint\00", align 1
@di_func.23 = private unnamed_addr constant [8 x i8] c"toInt32\00", align 1
@di_func.25 = private unnamed_addr constant [6 x i8] c"Int32\00", align 1
@di_file.26 = private unnamed_addr constant [10 x i8] c"./boot.jl\00", align 1
@di_func.27 = private unnamed_addr constant [8 x i8] c"convert\00", align 1
@di_file.28 = private unnamed_addr constant [12 x i8] c"./number.jl\00", align 1
@di_func.29 = private unnamed_addr constant [14 x i8] c"unsafe_store!\00", align 1
@di_file.30 = private unnamed_addr constant [63 x i8] c"/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl\00", align 1
@di_func.38 = private unnamed_addr constant [11 x i8] c"#setindex!\00", align 1
@exception.42 = private unnamed_addr constant [30 x i8] c"julia__throw_boundserror_2759\00", align 1
@di_func.43 = private unnamed_addr constant [12 x i8] c"checkbounds\00", align 1
@di_file.44 = private unnamed_addr constant [19 x i8] c"./abstractarray.jl\00", align 1
@di_func.45 = private unnamed_addr constant [10 x i8] c"#getindex\00", align 1
@di_file.46 = private unnamed_addr constant [55 x i8] c"/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl\00", align 1
@di_func.47 = private unnamed_addr constant [9 x i8] c"set_one!\00", align 1
@di_file.48 = private unnamed_addr constant [45 x i8] c"/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl\00", align 1
@0 = private unnamed_addr constant [61 x i8] c"ERROR: a %s was thrown during kernel execution.\0AStacktrace:\0A\00", align 1
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@1 = private unnamed_addr constant [42 x i8] c"Device-to-host string conversion failed.\0A\00", align 1
@2 = private unnamed_addr constant [19 x i8] c" [%i] %s at %s:%i\0A\00", align 1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #1

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #3

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #5

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #3

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #3

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #6

; Function Attrs: nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #7

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #8 {
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
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #9 {
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
define internal fastcc void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #9 {
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

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #0

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2558([5 x i64] %state, i64 zeroext %0, i64 signext %1) unnamed_addr #10 !dbg !73 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl within `hostcall_device_signal_wait`
  call void @llvm.dbg.value(metadata i64 %0, metadata !83, metadata !DIExpression()), !dbg !85
  call void @llvm.dbg.value(metadata i64 %1, metadata !84, metadata !DIExpression()), !dbg !85
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %2 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !86
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not3 = icmp eq i64 %2, %1, !dbg !92
; └
  br i1 %.not3, label %L20, label %L6, !dbg !95

L6:                                               ; preds = %L18, %top
  %3 = phi i64 [ %5, %L18 ], [ %2, %top ]
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !96

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !97
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !109
    store i64 1, i64* %4, align 1, !dbg !109, !tbaa !114, !alias.scope !118, !noalias !121
    br label %L18, !dbg !109

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !126
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %5 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !86
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %5, %1, !dbg !92
; └
  br i1 %.not, label %L20, label %L6, !dbg !95

L20:                                              ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !91
}

;  @ boot.jl:693 within `toInt32`
define internal fastcc i32 @julia_toInt32_2789([5 x i64] %state, i64 signext %0) unnamed_addr #10 !dbg !129 {
top:
;  @ boot.jl within `toInt32`
  call void @llvm.dbg.value(metadata i64 %0, metadata !136, metadata !DIExpression()), !dbg !137
;  @ boot.jl:693 within `toInt32`
  %1 = call fastcc i32 @julia_checked_trunc_sint_2792([5 x i64] %state, i64 %0), !dbg !138
  ret i32 %1, !dbg !138
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:30 within `signal_exception`
define internal fastcc void @gpu_signal_exception([5 x i64] %state) unnamed_addr #10 !dbg !139 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !145
; └└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
   %0 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !154
   store i64 1, i64* %0, align 1, !dbg !154, !tbaa !114, !alias.scope !118, !noalias !121
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:40 within `signal_exception`
  ret void, !dbg !158
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:88 within `report_exception_frame`
define internal fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 signext %0, i64 zeroext %1, i64 zeroext %2, i32 signext %3) unnamed_addr #10 !dbg !159 {
top:
  %4 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %5 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl within `report_exception_frame`
  call void @llvm.dbg.value(metadata i32 %0, metadata !166, metadata !DIExpression()), !dbg !170
  call void @llvm.dbg.value(metadata i64 %1, metadata !167, metadata !DIExpression()), !dbg !170
  call void @llvm.dbg.value(metadata i64 %2, metadata !168, metadata !DIExpression()), !dbg !170
  call void @llvm.dbg.value(metadata i32 %3, metadata !169, metadata !DIExpression()), !dbg !170
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:91 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %6 = inttoptr i64 %1 to i8 addrspace(1)*, !dbg !171
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     br label %check.i, !dbg !177

check.i:                                          ; preds = %check.i, %top
     %7 = phi i64 [ 0, %top ], [ %8, %check.i ], !dbg !177
     %8 = add i64 %7, 1, !dbg !177
     %9 = getelementptr i8, i8 addrspace(1)* %6, i64 %7, !dbg !177
     %10 = addrspacecast i8 addrspace(1)* %9 to i8*, !dbg !177
     %11 = load i8, i8* %10, align 1, !dbg !177
     %12 = icmp eq i8 %11, 0, !dbg !177
     br i1 %12, label %julia_report_exception_frame_2432u2434.exit, label %check.i, !dbg !177

julia_report_exception_frame_2432u2434.exit:      ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i4.fca.3.extract = extractvalue [5 x i64] %state, 3, !dbg !185
; ││└└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %13 = inttoptr i64 %state.i4.fca.3.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !195
     %.sroa.0152.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %13, i64 0, i32 0, !dbg !195
     %.sroa.0152.0.copyload = load i64, i64* %.sroa.0152.0..sroa_idx, align 1, !dbg !195, !tbaa !198, !alias.scope !199, !noalias !200
     %.sroa.6157.0..sroa_idx158 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %13, i64 0, i32 1, !dbg !195
     %.sroa.6157.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.6157.0..sroa_idx158, align 1, !dbg !195, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %14 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !201, !range !220
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %.not = icmp eq i32 %14, 0, !dbg !221
; │││││└└
       br i1 %.not, label %L25.preheader, label %L45, !dbg !211

L25.preheader:                                    ; preds = %julia_report_exception_frame_2432u2434.exit
       %state.i8.fca.0.extract = extractvalue [5 x i64] %state, 0
       %15 = inttoptr i64 %state.i8.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L25, !dbg !230

L25:                                              ; preds = %L41, %L25.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %16 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0152.0.copyload, i64 0, i64 1, i32 4), !dbg !234
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %16, label %L41 [
    i64 0, label %L45
    i64 5, label %L36
    i64 6, label %L36
  ], !dbg !230

L36:                                              ; preds = %L25, %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %15, align 1, !dbg !237, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L41, !dbg !237

L41:                                              ; preds = %L36, %L25
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !243
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !246

L45:                                              ; preds = %L25, %julia_report_exception_frame_2432u2434.exit
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !247
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L60, label %L70, !dbg !251

L60:                                              ; preds = %L45
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %17 = bitcast i8 addrspace(1)* %.sroa.6157.0.copyload to i64 addrspace(1)*, !dbg !256
          store i64 %8, i64 addrspace(1)* %17, align 1, !dbg !256, !tbaa !267
          br label %L70, !dbg !256

L70:                                              ; preds = %L60, %L45
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !270
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L90.preheader, label %L152, !dbg !272

L90.preheader:                                    ; preds = %L70
       %state.i17.fca.0.extract = extractvalue [5 x i64] %state, 0
       %18 = inttoptr i64 %state.i17.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L90, !dbg !277

L90:                                              ; preds = %L106, %L90.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %19 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0152.0.copyload, i64 1, i64 2, i32 4), !dbg !280
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %19, label %L106 [
    i64 1, label %L110
    i64 5, label %L101
    i64 6, label %L101
  ], !dbg !277

L101:                                             ; preds = %L90, %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %18, align 1, !dbg !282, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L106, !dbg !282

L106:                                             ; preds = %L101, %L90
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !286
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !288

L110:                                             ; preds = %L126, %L90
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %20 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.0152.0.copyload, i32 2), !dbg !289
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
        switch i64 %20, label %L126 [
    i64 4, label %L130
    i64 5, label %L121
    i64 6, label %L121
  ], !dbg !295

L121:                                             ; preds = %L110, %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %18, align 1, !dbg !296, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L126, !dbg !296

L126:                                             ; preds = %L121, %L110
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !300
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !302

L130:                                             ; preds = %L110
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %21 = bitcast i8 addrspace(1)* %.sroa.6157.0.copyload to i8 addrspace(1)* addrspace(1)*, !dbg !303
          %22 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %21, align 1, !dbg !303, !tbaa !267
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %.not234 = icmp eq i8 addrspace(1)* %22, null, !dbg !312
; │││││└
       br i1 %.not234, label %L138, label %L146, !dbg !314

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0152.0.copyload, i64 5, i32 3), !dbg !315
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %18, align 1, !dbg !319, !tbaa !114, !alias.scope !118, !noalias !121
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !323
        unreachable, !dbg !323

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %23 = bitcast i8 addrspace(1)* %22 to i64 addrspace(1)*, !dbg !327
          %24 = load i64, i64 addrspace(1)* %23, align 1, !dbg !327, !tbaa !267
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          store i64 %24, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !334, !tbaa !340
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0152.0.copyload, i64 0, i32 3), !dbg !342
        br label %L152, !dbg !342

L152:                                             ; preds = %L146, %L70
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !345
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %25 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !347, !tbaa !340
; │└└└└└└└
; │┌ @ essentials.jl:513 within `reinterpret`
    %26 = inttoptr i64 %25 to i8 addrspace(1)*, !dbg !354
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %.not169 = icmp eq i64 %25, 0, !dbg !355
; │└
   br i1 %.not169, label %L165, label %L222, !dbg !357

L165:                                             ; preds = %L152
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i23.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !358
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %27 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to i8 addrspace(5)*, !dbg !367
     %28 = inttoptr i64 %state.i23.fca.1.extract to i8*, !dbg !367
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %27, i8* noundef nonnull align 1 dereferenceable(24) %28, i64 24, i1 false), !dbg !367, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L183, label %L205, !dbg !370

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %29 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 0, !dbg !375
       %30 = load i64, i64 addrspace(5)* %29, align 8, !tbaa !379, !alias.scope !381, !noalias !382
       %state.i27.fca.0.extract = extractvalue [5 x i64] %state, 0
       %31 = inttoptr i64 %state.i27.fca.0.extract to i64*
; ││││└
      br label %L185, !dbg !378

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %32 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %30, i64 0, i64 1, i32 4), !dbg !383
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %32, label %L201 [
    i64 0, label %L205
    i64 5, label %L196
    i64 6, label %L196
  ], !dbg !386

L196:                                             ; preds = %L185, %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %31, align 1, !dbg !387, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L201, !dbg !387

L201:                                             ; preds = %L196, %L185
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !391
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !393

L205:                                             ; preds = %L185, %L165
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !394
; ││└└└
; ││┌ @ Base.jl:37 within `getproperty`
     %33 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !396
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %34 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %33, align 8, !dbg !397, !tbaa !379, !alias.scope !381, !noalias !382
; ││└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(41) %34, i8 addrspace(1)* noundef align 1 dereferenceable(41) addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !402
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %35 = getelementptr inbounds i8, i8 addrspace(1)* %34, i64 41, !dbg !406
       store i8 0, i8 addrspace(1)* %35, align 1, !dbg !406, !tbaa !267
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %36 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to { i64, i8 addrspace(1)*, i64 }*, !dbg !411
     call fastcc void @julia_hostcall_device_trigger_and_return__2551([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %36), !dbg !411
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !413

L222:                                             ; preds = %L152
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nonnull align 1 %26, i8 addrspace(1)* align 1 %6, i64 %7, i1 false), !dbg !414
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %37 = getelementptr i8, i8 addrspace(1)* %26, i64 %7, !dbg !418
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %37, align 1, !dbg !420, !tbaa !267
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !413

L231:                                             ; preds = %L222, %L205
       %value_phi1 = phi i64 [ 0, %L205 ], [ %25, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %38 = inttoptr i64 %2 to i8 addrspace(1)*, !dbg !426
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     br label %check.i29, !dbg !429

check.i29:                                        ; preds = %check.i29, %L231
     %39 = phi i64 [ 0, %L231 ], [ %40, %check.i29 ], !dbg !429
     %40 = add i64 %39, 1, !dbg !429
     %41 = getelementptr i8, i8 addrspace(1)* %38, i64 %39, !dbg !429
     %42 = addrspacecast i8 addrspace(1)* %41 to i8*, !dbg !429
     %43 = load i8, i8* %42, align 1, !dbg !429
     %44 = icmp eq i8 %43, 0, !dbg !429
     br i1 %44, label %julia_report_exception_frame_2432u2455.exit, label %check.i29, !dbg !429

julia_report_exception_frame_2432u2455.exit:      ; preds = %check.i29
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %.sroa.0133.0.copyload = load i64, i64* %.sroa.0152.0..sroa_idx, align 1, !dbg !433, !tbaa !198, !alias.scope !199, !noalias !200
     %.sroa.6138.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.6157.0..sroa_idx158, align 1, !dbg !433, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L256.preheader, label %L276, !dbg !437

L256.preheader:                                   ; preds = %julia_report_exception_frame_2432u2455.exit
       %state.i26.fca.0.extract = extractvalue [5 x i64] %state, 0
       %45 = inttoptr i64 %state.i26.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L256, !dbg !443

L256:                                             ; preds = %L272, %L256.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %46 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0133.0.copyload, i64 0, i64 1, i32 4), !dbg !446
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %46, label %L272 [
    i64 0, label %L276
    i64 5, label %L267
    i64 6, label %L267
  ], !dbg !443

L267:                                             ; preds = %L256, %L256
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %45, align 1, !dbg !448, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L272, !dbg !448

L272:                                             ; preds = %L267, %L256
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !452
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L256, !dbg !454

L276:                                             ; preds = %L256, %julia_report_exception_frame_2432u2455.exit
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !455
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L291, label %L301, !dbg !457

L291:                                             ; preds = %L276
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %47 = bitcast i8 addrspace(1)* %.sroa.6138.0.copyload to i64 addrspace(1)*, !dbg !461
          store i64 %40, i64 addrspace(1)* %47, align 1, !dbg !461, !tbaa !267
          br label %L301, !dbg !461

L301:                                             ; preds = %L291, %L276
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !468
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L321.preheader, label %L383, !dbg !470

L321.preheader:                                   ; preds = %L301
       %state.i25.fca.0.extract = extractvalue [5 x i64] %state, 0
       %48 = inttoptr i64 %state.i25.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L321, !dbg !474

L321:                                             ; preds = %L337, %L321.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %49 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0133.0.copyload, i64 1, i64 2, i32 4), !dbg !477
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %49, label %L337 [
    i64 1, label %L341
    i64 5, label %L332
    i64 6, label %L332
  ], !dbg !474

L332:                                             ; preds = %L321, %L321
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %48, align 1, !dbg !479, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L337, !dbg !479

L337:                                             ; preds = %L332, %L321
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !483
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L321, !dbg !485

L341:                                             ; preds = %L357, %L321
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %50 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.0133.0.copyload, i32 2), !dbg !486
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
        switch i64 %50, label %L357 [
    i64 4, label %L361
    i64 5, label %L352
    i64 6, label %L352
  ], !dbg !490

L352:                                             ; preds = %L341, %L341
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %48, align 1, !dbg !491, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L357, !dbg !491

L357:                                             ; preds = %L352, %L341
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !495
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L341, !dbg !497

L361:                                             ; preds = %L341
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %51 = bitcast i8 addrspace(1)* %.sroa.6138.0.copyload to i8 addrspace(1)* addrspace(1)*, !dbg !498
          %52 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %51, align 1, !dbg !498, !tbaa !267
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %.not221 = icmp eq i8 addrspace(1)* %52, null, !dbg !505
; │││││└
       br i1 %.not221, label %L369, label %L377, !dbg !507

L369:                                             ; preds = %L361
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0133.0.copyload, i64 5, i32 3), !dbg !508
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %48, align 1, !dbg !511, !tbaa !114, !alias.scope !118, !noalias !121
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !515
        unreachable, !dbg !515

L377:                                             ; preds = %L361
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %53 = bitcast i8 addrspace(1)* %52 to i64 addrspace(1)*, !dbg !517
          %54 = load i64, i64 addrspace(1)* %53, align 1, !dbg !517, !tbaa !267
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          store i64 %54, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !524, !tbaa !340
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0133.0.copyload, i64 0, i32 3), !dbg !530
        br label %L383, !dbg !530

L383:                                             ; preds = %L377, %L301
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !533
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %55 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !535, !tbaa !340
; │└└└└└└└
; │┌ @ essentials.jl:513 within `reinterpret`
    %56 = inttoptr i64 %55 to i8 addrspace(1)*, !dbg !542
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %.not174 = icmp eq i64 %55, 0, !dbg !543
; │└
   br i1 %.not174, label %L396, label %L453, !dbg !545

L396:                                             ; preds = %L383
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i21.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !546
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %57 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5 to i8 addrspace(5)*, !dbg !552
     %58 = inttoptr i64 %state.i21.fca.1.extract to i8*, !dbg !552
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %57, i8* noundef nonnull align 1 dereferenceable(24) %58, i64 24, i1 false), !dbg !552, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L414, label %L436, !dbg !555

L414:                                             ; preds = %L396
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %59 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !559
       %60 = load i64, i64 addrspace(5)* %59, align 8, !tbaa !379, !alias.scope !381, !noalias !382
       %state.i20.fca.0.extract = extractvalue [5 x i64] %state, 0
       %61 = inttoptr i64 %state.i20.fca.0.extract to i64*
; ││││└
      br label %L416, !dbg !560

L416:                                             ; preds = %L432, %L414
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %62 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %60, i64 0, i64 1, i32 4), !dbg !561
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %62, label %L432 [
    i64 0, label %L436
    i64 5, label %L427
    i64 6, label %L427
  ], !dbg !564

L427:                                             ; preds = %L416, %L416
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %61, align 1, !dbg !565, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L432, !dbg !565

L432:                                             ; preds = %L427, %L416
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !569
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L416, !dbg !571

L436:                                             ; preds = %L416, %L396
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !572
; ││└└└
; ││┌ @ Base.jl:37 within `getproperty`
     %63 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 1, !dbg !574
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %64 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %63, align 8, !dbg !575, !tbaa !379, !alias.scope !381, !noalias !382
; ││└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(41) %64, i8 addrspace(1)* noundef align 1 dereferenceable(41) addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !578
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %65 = getelementptr inbounds i8, i8 addrspace(1)* %64, i64 41, !dbg !581
       store i8 0, i8 addrspace(1)* %65, align 1, !dbg !581, !tbaa !267
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %66 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5 to { i64, i8 addrspace(1)*, i64 }*, !dbg !586
     call fastcc void @julia_hostcall_device_trigger_and_return__2551([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %66), !dbg !586
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L462, !dbg !587

L453:                                             ; preds = %L383
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nonnull align 1 %56, i8 addrspace(1)* align 1 %38, i64 %39, i1 false), !dbg !588
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %67 = getelementptr i8, i8 addrspace(1)* %56, i64 %39, !dbg !592
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %67, align 1, !dbg !594, !tbaa !267
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L462, !dbg !587

L462:                                             ; preds = %L453, %L436
       %value_phi3 = phi i64 [ 0, %L436 ], [ %55, %L453 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:187 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i16.fca.2.extract = extractvalue [5 x i64] %state, 2, !dbg !600
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %68 = inttoptr i64 %state.i16.fca.2.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !607
    %.sroa.0115.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %68, i64 0, i32 0, !dbg !607
    %.sroa.0115.0.copyload = load i64, i64* %.sroa.0115.0..sroa_idx, align 1, !dbg !607, !tbaa !198, !alias.scope !199, !noalias !200
    %.sroa.5119.0..sroa_idx120 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %68, i64 0, i32 1, !dbg !607
    %.sroa.5119.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.5119.0..sroa_idx120, align 1, !dbg !607, !tbaa !198, !alias.scope !199, !noalias !200
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:193 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L487.preheader, label %L507, !dbg !609

L487.preheader:                                   ; preds = %L462
     %state.i15.fca.0.extract = extractvalue [5 x i64] %state, 0
     %69 = inttoptr i64 %state.i15.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L487, !dbg !614

L487:                                             ; preds = %L503, %L487.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %70 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0115.0.copyload, i64 0, i64 1, i32 4), !dbg !617
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %70, label %L503 [
    i64 0, label %L507
    i64 5, label %L498
    i64 6, label %L498
  ], !dbg !614

L498:                                             ; preds = %L487, %L487
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %69, align 1, !dbg !619, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L503, !dbg !619

L503:                                             ; preds = %L498, %L487
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !623
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L487, !dbg !625

L507:                                             ; preds = %L487, %L462
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !626
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %71 = bitcast i8 addrspace(1)* %.sroa.5119.0.copyload to i64 addrspace(1)*, !dbg !628
      store i64 1, i64 addrspace(1)* %71, align 1, !dbg !628, !tbaa !267
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:196 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %72 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 8, !dbg !635
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:153 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %73 = bitcast i8 addrspace(1)* %72 to i64 addrspace(1)*, !dbg !637
       store i64 ptrtoint (i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([19 x i8], [19 x i8]* @2, i64 0, i64 0) to i8 addrspace(1)*) to i64), i64 addrspace(1)* %73, align 1, !dbg !637, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %74 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 16, !dbg !646
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %75 = bitcast i8 addrspace(1)* %74 to i64 addrspace(1)*, !dbg !648
       store i64 18, i64 addrspace(1)* %75, align 1, !dbg !648, !tbaa !267
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
   br i1 %.not, label %L539, label %L585, !dbg !655

L539:                                             ; preds = %L507
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %76 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 24, !dbg !657
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %77 = bitcast i8 addrspace(1)* %76 to i64 addrspace(1)*, !dbg !659
       store i64 140431575652736, i64 addrspace(1)* %77, align 1, !dbg !659, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %78 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 32, !dbg !668
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %79 = bitcast i8 addrspace(1)* %78 to i32 addrspace(1)*, !dbg !670
       store i32 %0, i32 addrspace(1)* %79, align 1, !dbg !670, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %80 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 36, !dbg !677
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %81 = bitcast i8 addrspace(1)* %80 to i64 addrspace(1)*, !dbg !659
       store i64 140431490556000, i64 addrspace(1)* %81, align 1, !dbg !659, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %82 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 44, !dbg !668
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %83 = bitcast i8 addrspace(1)* %82 to i64 addrspace(1)*, !dbg !670
       store i64 %value_phi1, i64 addrspace(1)* %83, align 1, !dbg !670, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %84 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 52, !dbg !677
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %85 = bitcast i8 addrspace(1)* %84 to i64 addrspace(1)*, !dbg !659
       store i64 140431490556000, i64 addrspace(1)* %85, align 1, !dbg !659, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %86 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 60, !dbg !668
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %87 = bitcast i8 addrspace(1)* %86 to i64 addrspace(1)*, !dbg !670
       store i64 %value_phi3, i64 addrspace(1)* %87, align 1, !dbg !670, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %88 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 68, !dbg !677
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %89 = bitcast i8 addrspace(1)* %88 to i64 addrspace(1)*, !dbg !659
       store i64 140431575652736, i64 addrspace(1)* %89, align 1, !dbg !659, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %90 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 76, !dbg !668
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %91 = bitcast i8 addrspace(1)* %90 to i32 addrspace(1)*, !dbg !670
       store i32 %3, i32 addrspace(1)* %91, align 1, !dbg !670, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %92 = getelementptr i8, i8 addrspace(1)* %.sroa.5119.0.copyload, i64 80, !dbg !677
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %93 = bitcast i8 addrspace(1)* %92 to i64 addrspace(1)*, !dbg !679
      store i64 0, i64 addrspace(1)* %93, align 1, !dbg !679, !tbaa !267
      br label %L585, !dbg !679

L585:                                             ; preds = %L539, %L507
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !685
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L600.preheader, label %L641, !dbg !687

L600.preheader:                                   ; preds = %L585
     %state.i14.fca.0.extract = extractvalue [5 x i64] %state, 0
     %94 = inttoptr i64 %state.i14.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L600, !dbg !691

L600:                                             ; preds = %L616, %L600.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %95 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0115.0.copyload, i64 1, i64 2, i32 4), !dbg !694
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %95, label %L616 [
    i64 1, label %L620
    i64 5, label %L611
    i64 6, label %L611
  ], !dbg !691

L611:                                             ; preds = %L600, %L600
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %94, align 1, !dbg !696, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L616, !dbg !696

L616:                                             ; preds = %L611, %L600
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !700
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L600, !dbg !702

L620:                                             ; preds = %L636, %L600
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %96 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.0115.0.copyload, i32 2), !dbg !703
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
      switch i64 %96, label %L636 [
    i64 4, label %L639
    i64 5, label %L631
    i64 6, label %L631
  ], !dbg !707

L631:                                             ; preds = %L620, %L620
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %94, align 1, !dbg !708, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L636, !dbg !708

L636:                                             ; preds = %L631, %L620
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !712
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L620, !dbg !714

L639:                                             ; preds = %L620
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0115.0.copyload, i64 0, i32 3), !dbg !715
      br label %L641, !dbg !715

L641:                                             ; preds = %L639, %L585
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !718
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:94 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i12.fca.4.extract = extractvalue [5 x i64] %state, 4, !dbg !720
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %97 = inttoptr i64 %state.i12.fca.4.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !728
    %.sroa.0102.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %97, i64 0, i32 0, !dbg !728
    %.sroa.0102.0.copyload = load i64, i64* %.sroa.0102.0..sroa_idx, align 1, !dbg !728, !tbaa !198, !alias.scope !199, !noalias !200
    %.sroa.5106.0..sroa_idx107 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %97, i64 0, i32 1, !dbg !728
    %98 = bitcast i8 addrspace(1)** %.sroa.5106.0..sroa_idx107 to i64 addrspace(1)**, !dbg !728
    %.sroa.5106.0.copyload202203 = load i64 addrspace(1)*, i64 addrspace(1)** %98, align 1, !dbg !728, !tbaa !198, !alias.scope !199, !noalias !200
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L665.preheader, label %L685, !dbg !730

L665.preheader:                                   ; preds = %L641
      %state.i11.fca.0.extract = extractvalue [5 x i64] %state, 0
      %99 = inttoptr i64 %state.i11.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L665, !dbg !736

L665:                                             ; preds = %L681, %L665.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %100 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0102.0.copyload, i64 0, i64 1, i32 4), !dbg !739
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %100, label %L681 [
    i64 0, label %L685
    i64 5, label %L676
    i64 6, label %L676
  ], !dbg !736

L676:                                             ; preds = %L665, %L665
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %99, align 1, !dbg !741, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L681, !dbg !741

L681:                                             ; preds = %L676, %L665
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !745
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L665, !dbg !747

L685:                                             ; preds = %L665, %L641
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !748
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L700, label %L710, !dbg !750

L700:                                             ; preds = %L685
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         store i64 %value_phi1, i64 addrspace(1)* %.sroa.5106.0.copyload202203, align 1, !dbg !754, !tbaa !267
         br label %L710, !dbg !754

L710:                                             ; preds = %L700, %L685
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !761
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L726.preheader, label %L767, !dbg !763

L726.preheader:                                   ; preds = %L710
      %state.i10.fca.0.extract = extractvalue [5 x i64] %state, 0
      %101 = inttoptr i64 %state.i10.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L726, !dbg !767

L726:                                             ; preds = %L742, %L726.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %102 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.0102.0.copyload, i64 1, i64 2, i32 4), !dbg !770
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %102, label %L742 [
    i64 1, label %L746
    i64 5, label %L737
    i64 6, label %L737
  ], !dbg !767

L737:                                             ; preds = %L726, %L726
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %101, align 1, !dbg !772, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L742, !dbg !772

L742:                                             ; preds = %L737, %L726
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !776
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L726, !dbg !778

L746:                                             ; preds = %L762, %L726
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %103 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.0102.0.copyload, i32 2), !dbg !779
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
       switch i64 %103, label %L762 [
    i64 4, label %L765
    i64 5, label %L757
    i64 6, label %L757
  ], !dbg !783

L757:                                             ; preds = %L746, %L746
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %101, align 1, !dbg !784, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L762, !dbg !784

L762:                                             ; preds = %L757, %L746
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !788
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L746, !dbg !790

L765:                                             ; preds = %L746
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.0102.0.copyload, i64 0, i32 3), !dbg !791
       br label %L767, !dbg !791

L767:                                             ; preds = %L765, %L710
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !794
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:95 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %.sroa.091.0.copyload = load i64, i64* %.sroa.0102.0..sroa_idx, align 1, !dbg !796, !tbaa !198, !alias.scope !199, !noalias !200
    %.sroa.595.0.copyload191192 = load i64 addrspace(1)*, i64 addrspace(1)** %98, align 1, !dbg !796, !tbaa !198, !alias.scope !199, !noalias !200
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L793.preheader, label %L813, !dbg !800

L793.preheader:                                   ; preds = %L767
      %state.i6.fca.0.extract = extractvalue [5 x i64] %state, 0
      %104 = inttoptr i64 %state.i6.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L793, !dbg !806

L793:                                             ; preds = %L809, %L793.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %105 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.091.0.copyload, i64 0, i64 1, i32 4), !dbg !809
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %105, label %L809 [
    i64 0, label %L813
    i64 5, label %L804
    i64 6, label %L804
  ], !dbg !806

L804:                                             ; preds = %L793, %L793
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %104, align 1, !dbg !811, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L809, !dbg !811

L809:                                             ; preds = %L804, %L793
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !815
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L793, !dbg !817

L813:                                             ; preds = %L793, %L767
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !818
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L828, label %L838, !dbg !820

L828:                                             ; preds = %L813
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         store i64 %value_phi3, i64 addrspace(1)* %.sroa.595.0.copyload191192, align 1, !dbg !824, !tbaa !267
         br label %L838, !dbg !824

L838:                                             ; preds = %L828, %L813
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !831
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L854.preheader, label %L895, !dbg !833

L854.preheader:                                   ; preds = %L838
      %state.i5.fca.0.extract = extractvalue [5 x i64] %state, 0
      %106 = inttoptr i64 %state.i5.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L854, !dbg !837

L854:                                             ; preds = %L870, %L854.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %107 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.091.0.copyload, i64 1, i64 2, i32 4), !dbg !840
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %107, label %L870 [
    i64 1, label %L874
    i64 5, label %L865
    i64 6, label %L865
  ], !dbg !837

L865:                                             ; preds = %L854, %L854
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %106, align 1, !dbg !842, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L870, !dbg !842

L870:                                             ; preds = %L865, %L854
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !846
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L854, !dbg !848

L874:                                             ; preds = %L890, %L854
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %108 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.091.0.copyload, i32 2), !dbg !849
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
       switch i64 %108, label %L890 [
    i64 4, label %L893
    i64 5, label %L885
    i64 6, label %L885
  ], !dbg !853

L885:                                             ; preds = %L874, %L874
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %106, align 1, !dbg !854, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L890, !dbg !854

L890:                                             ; preds = %L885, %L874
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !858
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L874, !dbg !860

L893:                                             ; preds = %L874
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.091.0.copyload, i64 0, i32 3), !dbg !861
       br label %L895, !dbg !861

L895:                                             ; preds = %L893, %L838
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !864
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:96 within `report_exception_frame`
  ret void, !dbg !866
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2331([5 x i64] %state, i64 zeroext %0, i64 signext %1) unnamed_addr #10 !dbg !867 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl within `hostcall_device_signal_wait`
  call void @llvm.dbg.value(metadata i64 %0, metadata !870, metadata !DIExpression()), !dbg !872
  call void @llvm.dbg.value(metadata i64 %1, metadata !871, metadata !DIExpression()), !dbg !872
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %2 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !873
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not3 = icmp eq i64 %2, %1, !dbg !878
; └
  br i1 %.not3, label %L20, label %L6, !dbg !880

L6:                                               ; preds = %L18, %top
  %3 = phi i64 [ %5, %L18 ], [ %2, %top ]
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !881

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !882
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !893
    store i64 1, i64* %4, align 1, !dbg !893, !tbaa !114, !alias.scope !118, !noalias !121
    br label %L18, !dbg !893

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !897
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %5 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !873
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %5, %1, !dbg !878
; └
  br i1 %.not, label %L20, label %L6, !dbg !880

L20:                                              ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !877
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:366 within `set_one!`
define amdgpu_kernel void @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE([5 x i64] %state, { [1 x i64], i8 addrspace(1)* } %0) local_unnamed_addr #10 !dbg !900 {
conversion:
  %.fca.0.0.extract = extractvalue { [1 x i64], i8 addrspace(1)* } %0, 0, 0
  call void @llvm.dbg.declare(metadata { [1 x i64], i8 addrspace(1)* }* undef, metadata !911, metadata !DIExpression(DW_OP_deref)), !dbg !912
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:367 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !913, !range !220
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %2 = add nuw nsw i32 %1, 1, !dbg !924
; └└└
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:132 within `workgroupIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %3 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !927, !range !934
; └└└└
; ┌ @ int.jl:1042 within `-` @ int.jl:86
   %4 = zext i32 %3 to i64, !dbg !935
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:140 within `workgroupDim`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %5 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !938
      %6 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 4, !dbg !938
      %7 = bitcast i8 addrspace(4)* %6 to i16 addrspace(4)*, !dbg !938
      %8 = load i16, i16 addrspace(4)* %7, align 4, !dbg !938, !range !946
; └└└└
; ┌ @ int.jl:1040 within `*`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %9 = zext i16 %8 to i64, !dbg !947
; │└└└└
; │ @ int.jl:1042 within `*` @ int.jl:88
   %10 = mul nuw nsw i64 %9, %4, !dbg !958
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %11 = zext i32 %2 to i64, !dbg !960
; │└└└└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %12 = add nuw nsw i64 %10, %11, !dbg !965
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:368 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#getindex`
; │┌ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %13 = icmp sgt i64 %.fca.0.0.extract, 0, !dbg !967
            %14 = select i1 %13, i64 %.fca.0.0.extract, i64 0, !dbg !967
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %.not = icmp ugt i64 %12, %14, !dbg !994
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    br i1 %.not, label %L38, label %L62, !dbg !989

L38:                                              ; preds = %conversion
    call fastcc void @gpu_report_exception_name([5 x i64] %state, i64 ptrtoint ([30 x i8]* @exception.42 to i64)), !dbg !989
    call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 1, i64 ptrtoint ([12 x i8]* @di_func.43 to i64), i64 ptrtoint ([19 x i8]* @di_file.44 to i64), i32 709), !dbg !989
    call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 2, i64 ptrtoint ([10 x i8]* @di_func.45 to i64), i64 ptrtoint ([55 x i8]* @di_file.46 to i64), i32 87), !dbg !989
    call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 3, i64 ptrtoint ([9 x i8]* @di_func.47 to i64), i64 ptrtoint ([45 x i8]* @di_file.48 to i64), i32 368), !dbg !989
    call fastcc void @gpu_signal_exception([5 x i64] %state), !dbg !989
    call void @llvm.trap(), !dbg !989
    unreachable, !dbg !989

L62:                                              ; preds = %conversion
    %.fca.1.extract = extractvalue { [1 x i64], i8 addrspace(1)* } %0, 1
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:89 within `#getindex`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %15 = bitcast i8 addrspace(1)* %.fca.1.extract to i32 addrspace(1)*, !dbg !998
; ││││┌ @ int.jl:86 within `-`
       %16 = add nsw i64 %12, -1, !dbg !1006
; ││││└
      %17 = getelementptr inbounds i32, i32 addrspace(1)* %15, i64 %16, !dbg !998
      %18 = load i32, i32 addrspace(1)* %17, align 4, !dbg !998, !tbaa !267
; └└└└
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:523 within `rem`
    %19 = sext i32 %18 to i64, !dbg !1007
; │└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %20 = add nsw i64 %19, 3, !dbg !1009
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:95 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:783 within `Int32`
      %21 = call fastcc i32 @julia_toInt32_2789([5 x i64] %state, i64 %20), !dbg !1011
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i32 %21, i32 addrspace(1)* %17, align 4, !dbg !1018, !tbaa !267
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `set_one!`
  ret void, !dbg !1022
}

;  @ boot.jl:652 within `checked_trunc_sint`
define internal fastcc i32 @julia_checked_trunc_sint_2792([5 x i64] %state, i64 signext %0) unnamed_addr #10 !dbg !1023 {
top:
;  @ boot.jl within `checked_trunc_sint`
  call void @llvm.dbg.value(metadata i64 %0, metadata !1033, metadata !DIExpression()), !dbg !1034
;  @ boot.jl:656 within `checked_trunc_sint`
  %1 = add i64 %0, -2147483648, !dbg !1035
  %2 = icmp ult i64 %1, -4294967296, !dbg !1035
  br i1 %2, label %L7, label %L5, !dbg !1035

L5:                                               ; preds = %top
;  @ boot.jl:654 within `checked_trunc_sint`
  %3 = trunc i64 %0 to i32, !dbg !1036
;  @ boot.jl:657 within `checked_trunc_sint`
  ret i32 %3, !dbg !1037

L7:                                               ; preds = %top
;  @ boot.jl:656 within `checked_trunc_sint`
  call fastcc void @gpu_report_exception_name([5 x i64] %state, i64 ptrtoint ([31 x i8]* @exception.20 to i64)), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 1, i64 ptrtoint ([19 x i8]* @di_func.21 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 656), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 2, i64 ptrtoint ([8 x i8]* @di_func.23 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 693), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 3, i64 ptrtoint ([6 x i8]* @di_func.25 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 783), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 4, i64 ptrtoint ([8 x i8]* @di_func.27 to i64), i64 ptrtoint ([12 x i8]* @di_file.28 to i64), i32 7), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 5, i64 ptrtoint ([14 x i8]* @di_func.29 to i64), i64 ptrtoint ([63 x i8]* @di_file.30 to i64), i32 88), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 6, i64 ptrtoint ([11 x i8]* @di_func.38 to i64), i64 ptrtoint ([55 x i8]* @di_file.46 to i64), i32 95), !dbg !1035
  call fastcc void @gpu_report_exception_frame([5 x i64] %state, i32 7, i64 ptrtoint ([9 x i8]* @di_func.47 to i64), i64 ptrtoint ([45 x i8]* @di_file.48 to i64), i32 368), !dbg !1035
  call fastcc void @gpu_signal_exception([5 x i64] %state), !dbg !1035
  call void @llvm.trap(), !dbg !1035
  unreachable, !dbg !1035
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2324([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #10 !dbg !1038 {
top:
  call void @llvm.dbg.declare(metadata { i64, i8 addrspace(1)*, i64 }* %0, metadata !1047, metadata !DIExpression(DW_OP_deref)), !dbg !1048
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1049, !range !220
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %.not = icmp eq i32 %1, 0, !dbg !1063
; │└└
   br i1 %.not, label %L15, label %L21, !dbg !1059

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %2 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !1070
; │└
   %3 = load i64, i64* %2, align 8, !dbg !1072, !tbaa !1073, !alias.scope !1075, !noalias !1076
   call fastcc void @julia_hostcall_device_signal_wait_cas__2334([5 x i64] %state, i64 %3, i64 1, i64 2), !dbg !1072
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
   call fastcc void @julia_hostcall_device_signal_wait_2331([5 x i64] %state, i64 %3, i64 4), !dbg !1077
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    call fastcc void @__ockl_hsa_signal_store(i64 %3, i64 0, i32 3), !dbg !1078
    br label %L21, !dbg !1078

L21:                                              ; preds = %L15, %top
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !1082
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !1061
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2561([5 x i64] %state, i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #10 !dbg !1085 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl within `hostcall_device_signal_wait_cas!`
  call void @llvm.dbg.value(metadata i64 %0, metadata !1091, metadata !DIExpression()), !dbg !1094
  call void @llvm.dbg.value(metadata i64 %1, metadata !1092, metadata !DIExpression()), !dbg !1094
  call void @llvm.dbg.value(metadata i64 %2, metadata !1093, metadata !DIExpression()), !dbg !1094
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !1095
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %3, %1, !dbg !1100
; └
  br i1 %.not, label %L20, label %L6, !dbg !1102

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !1103

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !1104
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !1115
    store i64 1, i64* %4, align 1, !dbg !1115, !tbaa !114, !alias.scope !118, !noalias !121
    br label %L18, !dbg !1115

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1119
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !1122

L20:                                              ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !1099
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2551([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #10 !dbg !1123 {
top:
  call void @llvm.dbg.declare(metadata { i64, i8 addrspace(1)*, i64 }* %0, metadata !1126, metadata !DIExpression(DW_OP_deref)), !dbg !1127
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1128, !range !220
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %.not = icmp eq i32 %1, 0, !dbg !1142
; │└└
   br i1 %.not, label %L15, label %L21, !dbg !1138

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %2 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %0, i64 0, i32 0, !dbg !1149
; │└
   %3 = load i64, i64* %2, align 8, !dbg !1151, !tbaa !1073, !alias.scope !1075, !noalias !1076
   call fastcc void @julia_hostcall_device_signal_wait_cas__2561([5 x i64] %state, i64 %3, i64 1, i64 2), !dbg !1151
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
   call fastcc void @julia_hostcall_device_signal_wait_2558([5 x i64] %state, i64 %3, i64 4), !dbg !1152
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    call fastcc void @__ockl_hsa_signal_store(i64 %3, i64 0, i32 3), !dbg !1153
    br label %L21, !dbg !1153

L21:                                              ; preds = %L15, %top
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !1157
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !1140
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:78 within `report_exception_name`
define internal fastcc void @gpu_report_exception_name([5 x i64] %state, i64 zeroext %0) unnamed_addr #10 !dbg !1160 {
top:
  %1 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl within `report_exception_name`
  call void @llvm.dbg.value(metadata i64 %0, metadata !1166, metadata !DIExpression()), !dbg !1167
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:79 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %2 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !1168
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     br label %check.i, !dbg !1173

check.i:                                          ; preds = %check.i, %top
     %3 = phi i64 [ 0, %top ], [ %4, %check.i ], !dbg !1173
     %4 = add i64 %3, 1, !dbg !1173
     %5 = getelementptr i8, i8 addrspace(1)* %2, i64 %3, !dbg !1173
     %6 = addrspacecast i8 addrspace(1)* %5 to i8*, !dbg !1173
     %7 = load i8, i8* %6, align 1, !dbg !1173
     %8 = icmp eq i8 %7, 0, !dbg !1173
     br i1 %8, label %julia_report_exception_name_2256u2258.exit, label %check.i, !dbg !1173

julia_report_exception_name_2256u2258.exit:       ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i2.fca.3.extract = extractvalue [5 x i64] %state, 3, !dbg !1180
; ││└└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %9 = inttoptr i64 %state.i2.fca.3.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !1190
     %.sroa.080.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %9, i64 0, i32 0, !dbg !1190
     %.sroa.080.0.copyload = load i64, i64* %.sroa.080.0..sroa_idx, align 1, !dbg !1190, !tbaa !198, !alias.scope !199, !noalias !200
     %.sroa.685.0..sroa_idx86 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %9, i64 0, i32 1, !dbg !1190
     %.sroa.685.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.685.0..sroa_idx86, align 1, !dbg !1190, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %10 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1193, !range !220
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %.not = icmp eq i32 %10, 0, !dbg !1211
; │││││└└
       br i1 %.not, label %L25.preheader, label %L45, !dbg !1202

L25.preheader:                                    ; preds = %julia_report_exception_name_2256u2258.exit
       %state.i6.fca.0.extract = extractvalue [5 x i64] %state, 0
       %11 = inttoptr i64 %state.i6.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L25, !dbg !1218

L25:                                              ; preds = %L41, %L25.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %12 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.080.0.copyload, i64 0, i64 1, i32 4), !dbg !1222
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %12, label %L41 [
    i64 0, label %L45
    i64 5, label %L36
    i64 6, label %L36
  ], !dbg !1218

L36:                                              ; preds = %L25, %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %11, align 1, !dbg !1225, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L41, !dbg !1225

L41:                                              ; preds = %L36, %L25
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1231
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !1234

L45:                                              ; preds = %L25, %julia_report_exception_name_2256u2258.exit
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1235
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L60, label %L70, !dbg !1238

L60:                                              ; preds = %L45
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %13 = bitcast i8 addrspace(1)* %.sroa.685.0.copyload to i64 addrspace(1)*, !dbg !1243
          store i64 %4, i64 addrspace(1)* %13, align 1, !dbg !1243, !tbaa !267
          br label %L70, !dbg !1243

L70:                                              ; preds = %L60, %L45
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1253
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
       br i1 %.not, label %L90.preheader, label %L152, !dbg !1255

L90.preheader:                                    ; preds = %L70
       %state.i14.fca.0.extract = extractvalue [5 x i64] %state, 0
       %14 = inttoptr i64 %state.i14.fca.0.extract to i64*
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        br label %L90, !dbg !1260

L90:                                              ; preds = %L106, %L90.preheader
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %15 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.080.0.copyload, i64 1, i64 2, i32 4), !dbg !1263
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
        switch i64 %15, label %L106 [
    i64 1, label %L110
    i64 5, label %L101
    i64 6, label %L101
  ], !dbg !1260

L101:                                             ; preds = %L90, %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %14, align 1, !dbg !1265, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L106, !dbg !1265

L106:                                             ; preds = %L101, %L90
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1269
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !1271

L110:                                             ; preds = %L126, %L90
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %16 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.080.0.copyload, i32 2), !dbg !1272
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
        switch i64 %16, label %L126 [
    i64 4, label %L130
    i64 5, label %L121
    i64 6, label %L121
  ], !dbg !1278

L121:                                             ; preds = %L110, %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          store i64 1, i64* %14, align 1, !dbg !1279, !tbaa !114, !alias.scope !118, !noalias !121
          br label %L126, !dbg !1279

L126:                                             ; preds = %L121, %L110
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1283
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !1285

L130:                                             ; preds = %L110
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %17 = bitcast i8 addrspace(1)* %.sroa.685.0.copyload to i8 addrspace(1)* addrspace(1)*, !dbg !1286
          %18 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %17, align 1, !dbg !1286, !tbaa !267
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %.not129 = icmp eq i8 addrspace(1)* %18, null, !dbg !1295
; │││││└
       br i1 %.not129, label %L138, label %L146, !dbg !1297

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.080.0.copyload, i64 5, i32 3), !dbg !1298
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %14, align 1, !dbg !1302, !tbaa !114, !alias.scope !118, !noalias !121
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !1306
        unreachable, !dbg !1306

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %19 = bitcast i8 addrspace(1)* %18 to i64 addrspace(1)*, !dbg !1309
          %20 = load i64, i64 addrspace(1)* %19, align 1, !dbg !1309, !tbaa !267
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          store i64 %20, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !1316, !tbaa !340
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.080.0.copyload, i64 0, i32 3), !dbg !1322
        br label %L152, !dbg !1322

L152:                                             ; preds = %L146, %L70
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1325
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %21 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !1327, !tbaa !340
; │└└└└└└└
; │┌ @ essentials.jl:513 within `reinterpret`
    %22 = inttoptr i64 %21 to i8 addrspace(1)*, !dbg !1334
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %.not96 = icmp eq i64 %21, 0, !dbg !1335
; │└
   br i1 %.not96, label %L165, label %L222, !dbg !1337

L165:                                             ; preds = %L152
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i12.fca.1.extract = extractvalue [5 x i64] %state, 1, !dbg !1338
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %23 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1 to i8 addrspace(5)*, !dbg !1346
     %24 = inttoptr i64 %state.i12.fca.1.extract to i8*, !dbg !1346
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noundef align 8 dereferenceable(24) %23, i8* noundef nonnull align 1 dereferenceable(24) %24, i64 24, i1 false), !dbg !1346, !tbaa !198, !alias.scope !199, !noalias !200
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L183, label %L205, !dbg !1349

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %25 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !1354
       %26 = load i64, i64 addrspace(5)* %25, align 8, !tbaa !379, !alias.scope !381, !noalias !382
       %state.i11.fca.0.extract = extractvalue [5 x i64] %state, 0
       %27 = inttoptr i64 %state.i11.fca.0.extract to i64*
; ││││└
      br label %L185, !dbg !1356

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %28 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %26, i64 0, i64 1, i32 4), !dbg !1357
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %28, label %L201 [
    i64 0, label %L205
    i64 5, label %L196
    i64 6, label %L196
  ], !dbg !1360

L196:                                             ; preds = %L185, %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %27, align 1, !dbg !1361, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L201, !dbg !1361

L201:                                             ; preds = %L196, %L185
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1365
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !1367

L205:                                             ; preds = %L185, %L165
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1368
; ││└└└
; ││┌ @ Base.jl:37 within `getproperty`
     %29 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !1370
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %30 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %29, align 8, !dbg !1371, !tbaa !379, !alias.scope !381, !noalias !382
; ││└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noundef align 1 dereferenceable(41) %30, i8 addrspace(1)* noundef align 1 dereferenceable(41) addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !1376
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %31 = getelementptr inbounds i8, i8 addrspace(1)* %30, i64 41, !dbg !1380
       store i8 0, i8 addrspace(1)* %31, align 1, !dbg !1380, !tbaa !267
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %32 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1385
     call fastcc void @julia_hostcall_device_trigger_and_return__2324([5 x i64] %state, { i64, i8 addrspace(1)*, i64 }* %32), !dbg !1385
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !1387

L222:                                             ; preds = %L152
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nonnull align 1 %22, i8 addrspace(1)* align 1 %2, i64 %3, i1 false), !dbg !1388
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %33 = getelementptr i8, i8 addrspace(1)* %22, i64 %3, !dbg !1392
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %33, align 1, !dbg !1394, !tbaa !267
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !1387

L231:                                             ; preds = %L222, %L205
       %value_phi1 = phi i64 [ 0, %L205 ], [ %21, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:80 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:187 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i10.fca.2.extract = extractvalue [5 x i64] %state, 2, !dbg !1400
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %34 = inttoptr i64 %state.i10.fca.2.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !1407
    %.sroa.062.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, i32 0, !dbg !1407
    %.sroa.062.0.copyload = load i64, i64* %.sroa.062.0..sroa_idx, align 1, !dbg !1407, !tbaa !198, !alias.scope !199, !noalias !200
    %.sroa.566.0..sroa_idx67 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, i32 1, !dbg !1407
    %.sroa.566.0.copyload = load i8 addrspace(1)*, i8 addrspace(1)** %.sroa.566.0..sroa_idx67, align 1, !dbg !1407, !tbaa !198, !alias.scope !199, !noalias !200
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:193 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L256.preheader, label %L276, !dbg !1409

L256.preheader:                                   ; preds = %L231
     %state.i9.fca.0.extract = extractvalue [5 x i64] %state, 0
     %35 = inttoptr i64 %state.i9.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L256, !dbg !1414

L256:                                             ; preds = %L272, %L256.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %36 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.062.0.copyload, i64 0, i64 1, i32 4), !dbg !1417
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %36, label %L272 [
    i64 0, label %L276
    i64 5, label %L267
    i64 6, label %L267
  ], !dbg !1414

L267:                                             ; preds = %L256, %L256
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %35, align 1, !dbg !1419, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L272, !dbg !1419

L272:                                             ; preds = %L267, %L256
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1423
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L256, !dbg !1425

L276:                                             ; preds = %L256, %L231
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1426
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %37 = bitcast i8 addrspace(1)* %.sroa.566.0.copyload to i64 addrspace(1)*, !dbg !1428
      store i64 1, i64 addrspace(1)* %37, align 1, !dbg !1428, !tbaa !267
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:196 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
    %38 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 8, !dbg !1435
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:153 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %39 = bitcast i8 addrspace(1)* %38 to i64 addrspace(1)*, !dbg !1437
       store i64 ptrtoint (i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([61 x i8], [61 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*) to i64), i64 addrspace(1)* %39, align 1, !dbg !1437, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %40 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 16, !dbg !1446
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %41 = bitcast i8 addrspace(1)* %40 to i64 addrspace(1)*, !dbg !1448
       store i64 60, i64 addrspace(1)* %41, align 1, !dbg !1448, !tbaa !267
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
   br i1 %.not, label %L308, label %L321, !dbg !1455

L308:                                             ; preds = %L276
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %42 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 24, !dbg !1457
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %43 = bitcast i8 addrspace(1)* %42 to i64 addrspace(1)*, !dbg !1459
       store i64 140431490556000, i64 addrspace(1)* %43, align 1, !dbg !1459, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %44 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 32, !dbg !1468
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %45 = bitcast i8 addrspace(1)* %44 to i64 addrspace(1)*, !dbg !1470
       store i64 %value_phi1, i64 addrspace(1)* %45, align 1, !dbg !1470, !tbaa !267
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
     %46 = getelementptr i8, i8 addrspace(1)* %.sroa.566.0.copyload, i64 40, !dbg !1477
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %47 = bitcast i8 addrspace(1)* %46 to i64 addrspace(1)*, !dbg !1479
      store i64 0, i64 addrspace(1)* %47, align 1, !dbg !1479, !tbaa !267
      br label %L321, !dbg !1479

L321:                                             ; preds = %L308, %L276
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !1485
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
     br i1 %.not, label %L336.preheader, label %L377, !dbg !1487

L336.preheader:                                   ; preds = %L321
     %state.i8.fca.0.extract = extractvalue [5 x i64] %state, 0
     %48 = inttoptr i64 %state.i8.fca.0.extract to i64*
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L336, !dbg !1491

L336:                                             ; preds = %L352, %L336.preheader
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %49 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.062.0.copyload, i64 1, i64 2, i32 4), !dbg !1494
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      switch i64 %49, label %L352 [
    i64 1, label %L356
    i64 5, label %L347
    i64 6, label %L347
  ], !dbg !1491

L347:                                             ; preds = %L336, %L336
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %48, align 1, !dbg !1496, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L352, !dbg !1496

L352:                                             ; preds = %L347, %L336
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1500
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L336, !dbg !1502

L356:                                             ; preds = %L372, %L336
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %50 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.062.0.copyload, i32 2), !dbg !1503
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
      switch i64 %50, label %L372 [
    i64 4, label %L375
    i64 5, label %L367
    i64 6, label %L367
  ], !dbg !1507

L367:                                             ; preds = %L356, %L356
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        store i64 1, i64* %48, align 1, !dbg !1508, !tbaa !114, !alias.scope !118, !noalias !121
        br label %L372, !dbg !1508

L372:                                             ; preds = %L367, %L356
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1512
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L356, !dbg !1514

L375:                                             ; preds = %L356
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.062.0.copyload, i64 0, i32 3), !dbg !1515
      br label %L377, !dbg !1515

L377:                                             ; preds = %L375, %L321
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1518
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:84 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i5.fca.4.extract = extractvalue [5 x i64] %state, 4, !dbg !1520
; │└└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %51 = inttoptr i64 %state.i5.fca.4.extract to { i64, i8 addrspace(1)*, i64 }*, !dbg !1528
    %.sroa.051.0..sroa_idx = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %51, i64 0, i32 0, !dbg !1528
    %.sroa.051.0.copyload = load i64, i64* %.sroa.051.0..sroa_idx, align 1, !dbg !1528, !tbaa !198, !alias.scope !199, !noalias !200
    %.sroa.555.0..sroa_idx56 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %51, i64 0, i32 1, !dbg !1528
    %52 = bitcast i8 addrspace(1)** %.sroa.555.0..sroa_idx56 to i64 addrspace(1)**, !dbg !1528
    %.sroa.555.0.copyload110111 = load i64 addrspace(1)*, i64 addrspace(1)** %52, align 1, !dbg !1528, !tbaa !198, !alias.scope !199, !noalias !200
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L401.preheader, label %L421, !dbg !1530

L401.preheader:                                   ; preds = %L377
      %state.i4.fca.0.extract = extractvalue [5 x i64] %state, 0
      %53 = inttoptr i64 %state.i4.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L401, !dbg !1536

L401:                                             ; preds = %L417, %L401.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %54 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.051.0.copyload, i64 0, i64 1, i32 4), !dbg !1539
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %54, label %L417 [
    i64 0, label %L421
    i64 5, label %L412
    i64 6, label %L412
  ], !dbg !1536

L412:                                             ; preds = %L401, %L401
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %53, align 1, !dbg !1541, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L417, !dbg !1541

L417:                                             ; preds = %L412, %L401
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1545
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L401, !dbg !1547

L421:                                             ; preds = %L401, %L377
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1548
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L436, label %L446, !dbg !1550

L436:                                             ; preds = %L421
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         store i64 %value_phi1, i64 addrspace(1)* %.sroa.555.0.copyload110111, align 1, !dbg !1554, !tbaa !267
         br label %L446, !dbg !1554

L446:                                             ; preds = %L436, %L421
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1561
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
      br i1 %.not, label %L462.preheader, label %L503, !dbg !1563

L462.preheader:                                   ; preds = %L446
      %state.i3.fca.0.extract = extractvalue [5 x i64] %state, 0
      %55 = inttoptr i64 %state.i3.fca.0.extract to i64*
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       br label %L462, !dbg !1567

L462:                                             ; preds = %L478, %L462.preheader
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %56 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %.sroa.051.0.copyload, i64 1, i64 2, i32 4), !dbg !1570
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %56, label %L478 [
    i64 1, label %L482
    i64 5, label %L473
    i64 6, label %L473
  ], !dbg !1567

L473:                                             ; preds = %L462, %L462
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %55, align 1, !dbg !1572, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L478, !dbg !1572

L478:                                             ; preds = %L473, %L462
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1576
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L462, !dbg !1578

L482:                                             ; preds = %L498, %L462
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %57 = call fastcc i64 @__ockl_hsa_signal_load(i64 %.sroa.051.0.copyload, i32 2), !dbg !1579
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
       switch i64 %57, label %L498 [
    i64 4, label %L501
    i64 5, label %L493
    i64 6, label %L493
  ], !dbg !1583

L493:                                             ; preds = %L482, %L482
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         store i64 1, i64* %55, align 1, !dbg !1584, !tbaa !114, !alias.scope !118, !noalias !121
         br label %L498, !dbg !1584

L498:                                             ; preds = %L493, %L482
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1588
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L482, !dbg !1590

L501:                                             ; preds = %L482
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %.sroa.051.0.copyload, i64 0, i32 3), !dbg !1591
       br label %L503, !dbg !1591

L503:                                             ; preds = %L501, %L446
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1594
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:85 within `report_exception_name`
  ret void, !dbg !1596
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2334([5 x i64] %state, i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #10 !dbg !1597 {
top:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl within `hostcall_device_signal_wait_cas!`
  call void @llvm.dbg.value(metadata i64 %0, metadata !1600, metadata !DIExpression()), !dbg !1603
  call void @llvm.dbg.value(metadata i64 %1, metadata !1601, metadata !DIExpression()), !dbg !1603
  call void @llvm.dbg.value(metadata i64 %2, metadata !1602, metadata !DIExpression()), !dbg !1603
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !1604
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %.not = icmp eq i64 %3, %1, !dbg !1609
; └
  br i1 %.not, label %L20, label %L6, !dbg !1611

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
  switch i64 %3, label %L18 [
    i64 5, label %L13
    i64 6, label %L13
  ], !dbg !1612

L13:                                              ; preds = %L6, %L6
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i.fca.0.extract = extractvalue [5 x i64] %state, 0, !dbg !1613
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %4 = inttoptr i64 %state.i.fca.0.extract to i64*, !dbg !1624
    store i64 1, i64* %4, align 1, !dbg !1624, !tbaa !114, !alias.scope !118, !noalias !121
    br label %L18, !dbg !1624

L18:                                              ; preds = %L13, %L6
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1628
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !1631

L20:                                              ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !1608
}

attributes #0 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #1 = { nounwind willreturn }
attributes #2 = { convergent nounwind willreturn }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { argmemonly nofree nounwind willreturn }
attributes #5 = { cold noreturn nounwind }
attributes #6 = { convergent nounwind readnone willreturn }
attributes #7 = { nounwind }
attributes #8 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #9 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { "frame-pointer"="all" "probe-stack"="inline-asm" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !8, !10, !12, !14, !15, !16, !17, !18, !20, !22, !23, !24, !25, !26, !27, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !57, !58, !59, !60}
!opencl.ocl.version = !{!61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61, !61}
!llvm.ident = !{!62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62, !62}
!julia.kernel = !{!63}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!5 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!6 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!7 = !DIFile(filename: "none", directory: ".")
!8 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !9, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!9 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl", directory: ".")
!10 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !11, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!11 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!12 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !13, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!13 = !DIFile(filename: "boot.jl", directory: ".")
!14 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !13, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!15 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!16 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !9, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!17 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !11, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!18 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !19, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!19 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl", directory: ".")
!20 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!21 = !DIFile(filename: "/home/pxl-th/.julia/dev/GPUCompiler/src/runtime.jl", directory: ".")
!22 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!23 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!24 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!25 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!26 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!27 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!28 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!29 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!30 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!31 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!32 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!33 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!34 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!35 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!36 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!37 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!38 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!39 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!40 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!41 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!42 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!43 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!44 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!45 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!46 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!47 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!48 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!49 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!50 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!51 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!52 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!53 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!54 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !21, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!55 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !56, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!56 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!57 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!58 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !7, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!59 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
!60 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !28, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, nameTableKind: None)
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
!73 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2558", scope: null, file: !5, line: 57, type: !74, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !81)
!74 = !DISubroutineType(types: !75)
!75 = !{!76, !78, !79, !80}
!76 = !DICompositeType(tag: DW_TAG_structure_type, name: "Nothing", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140431575658144")
!77 = !{}
!78 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_signal_wait", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927453632")
!79 = !DIBasicType(name: "UInt64", size: 64, encoding: DW_ATE_unsigned)
!80 = !DIBasicType(name: "Int64", size: 64, encoding: DW_ATE_unsigned)
!81 = !{!82, !83, !84}
!82 = !DILocalVariable(name: "#self#", arg: 1, scope: !73, file: !5, line: 57, type: !78)
!83 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !73, file: !5, line: 57, type: !79)
!84 = !DILocalVariable(name: "value", arg: 3, scope: !73, file: !5, line: 57, type: !80)
!85 = !DILocation(line: 0, scope: !73)
!86 = !DILocation(line: 12, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!88 = !DISubroutineType(types: !77)
!89 = !DILocation(line: 61, scope: !90, inlinedAt: !91)
!90 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!91 = !DILocation(line: 60, scope: !73)
!92 = !DILocation(line: 499, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!94 = !DIFile(filename: "promotion.jl", directory: ".")
!95 = !DILocation(line: 62, scope: !90, inlinedAt: !91)
!96 = !DILocation(line: 64, scope: !90, inlinedAt: !91)
!97 = !DILocation(line: 40, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!99 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl", directory: ".")
!100 = !DILocation(line: 0, scope: !101, inlinedAt: !102)
!101 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!102 = !DILocation(line: 0, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!104 = !DILocation(line: 11, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!106 = !DILocation(line: 31, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!108 = !DILocation(line: 65, scope: !90, inlinedAt: !91)
!109 = !DILocation(line: 126, scope: !110, inlinedAt: !112)
!110 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!111 = !DIFile(filename: "pointer.jl", directory: ".")
!112 = !DILocation(line: 126, scope: !110, inlinedAt: !113)
!113 = !DILocation(line: 33, scope: !107, inlinedAt: !108)
!114 = !{!115, !115, i64 0}
!115 = !{!"jtbaa_data", !116, i64 0}
!116 = !{!"jtbaa", !117, i64 0}
!117 = !{!"jtbaa"}
!118 = !{!119}
!119 = !{!"jnoalias_data", !120}
!120 = !{!"jnoalias"}
!121 = !{!122, !123, !124, !125}
!122 = !{!"jnoalias_gcframe", !120}
!123 = !{!"jnoalias_stack", !120}
!124 = !{!"jnoalias_typemd", !120}
!125 = !{!"jnoalias_const", !120}
!126 = !DILocation(line: 108, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !77)
!128 = !DILocation(line: 70, scope: !90, inlinedAt: !91)
!129 = distinct !DISubprogram(name: "toInt32", linkageName: "julia_toInt32_2789", scope: null, file: !13, line: 693, type: !130, scopeLine: 693, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !134)
!130 = !DISubroutineType(types: !131)
!131 = !{!132, !133, !80}
!132 = !DIBasicType(name: "Int32", size: 32, encoding: DW_ATE_unsigned)
!133 = !DICompositeType(tag: DW_TAG_structure_type, name: "#toInt32", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140431516044848")
!134 = !{!135, !136}
!135 = !DILocalVariable(name: "#self#", arg: 1, scope: !129, file: !13, line: 693, type: !133)
!136 = !DILocalVariable(name: "x", arg: 2, scope: !129, file: !13, line: 693, type: !80)
!137 = !DILocation(line: 0, scope: !129)
!138 = !DILocation(line: 693, scope: !129)
!139 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2367", scope: null, file: !28, line: 30, type: !140, scopeLine: 30, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !143)
!140 = !DISubroutineType(types: !141)
!141 = !{!76, !142}
!142 = !DICompositeType(tag: DW_TAG_structure_type, name: "#signal_exception", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927429648")
!143 = !{!144}
!144 = !DILocalVariable(name: "#self#", arg: 1, scope: !139, file: !28, line: 30, type: !142)
!145 = !DILocation(line: 40, scope: !146, inlinedAt: !147)
!146 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !77)
!147 = !DILocation(line: 0, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !77)
!149 = !DILocation(line: 0, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !77)
!151 = !DILocation(line: 11, scope: !152, inlinedAt: !153)
!152 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !77)
!153 = !DILocation(line: 31, scope: !139)
!154 = !DILocation(line: 126, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !77)
!156 = !DILocation(line: 126, scope: !155, inlinedAt: !157)
!157 = !DILocation(line: 33, scope: !139)
!158 = !DILocation(line: 40, scope: !139)
!159 = distinct !DISubprogram(name: "report_exception_frame", linkageName: "julia_report_exception_frame_2432", scope: null, file: !28, line: 88, type: !160, scopeLine: 88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !164)
!160 = !DISubroutineType(types: !161)
!161 = !{!76, !162, !132, !163, !163, !132}
!162 = !DICompositeType(tag: DW_TAG_structure_type, name: "#report_exception_frame", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927534816")
!163 = !DIBasicType(name: "Ptr", size: 64, encoding: DW_ATE_unsigned)
!164 = !{!165, !166, !167, !168, !169}
!165 = !DILocalVariable(name: "#self#", arg: 1, scope: !159, file: !28, line: 88, type: !162)
!166 = !DILocalVariable(name: "idx", arg: 2, scope: !159, file: !28, line: 88, type: !132)
!167 = !DILocalVariable(name: "func", arg: 3, scope: !159, file: !28, line: 88, type: !163)
!168 = !DILocalVariable(name: "file", arg: 4, scope: !159, file: !28, line: 88, type: !163)
!169 = !DILocalVariable(name: "line", arg: 5, scope: !159, file: !28, line: 88, type: !132)
!170 = !DILocation(line: 0, scope: !159)
!171 = !DILocation(line: 513, scope: !172, inlinedAt: !174)
!172 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !173, file: !173, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!173 = !DIFile(filename: "essentials.jl", directory: ".")
!174 = !DILocation(line: 46, scope: !175, inlinedAt: !176)
!175 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!176 = !DILocation(line: 91, scope: !159)
!177 = !DILocation(line: 40, scope: !178, inlinedAt: !179)
!178 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!179 = !DILocation(line: 3, scope: !180, inlinedAt: !182)
!180 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !181, file: !181, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!181 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!182 = !DILocation(line: 3, scope: !183, inlinedAt: !184)
!183 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !181, file: !181, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!184 = !DILocation(line: 47, scope: !175, inlinedAt: !176)
!185 = !DILocation(line: 40, scope: !178, inlinedAt: !186)
!186 = !DILocation(line: 0, scope: !187, inlinedAt: !188)
!187 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!188 = !DILocation(line: 0, scope: !189, inlinedAt: !190)
!189 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!190 = !DILocation(line: 23, scope: !191, inlinedAt: !192)
!191 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!192 = !DILocation(line: 4, scope: !193, inlinedAt: !194)
!193 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!194 = !DILocation(line: 50, scope: !175, inlinedAt: !176)
!195 = !DILocation(line: 111, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!197 = !DILocation(line: 111, scope: !196, inlinedAt: !192)
!198 = !{!116, !116, i64 0}
!199 = !{!119, !123}
!200 = !{!122, !124, !125}
!201 = !DILocation(line: 40, scope: !178, inlinedAt: !202)
!202 = !DILocation(line: 3, scope: !203, inlinedAt: !205)
!203 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!204 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!205 = !DILocation(line: 3, scope: !206, inlinedAt: !207)
!206 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!207 = !DILocation(line: 89, scope: !208, inlinedAt: !209)
!208 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!209 = !DILocation(line: 124, scope: !210, inlinedAt: !211)
!210 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!211 = !DILocation(line: 92, scope: !212, inlinedAt: !213)
!212 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!213 = !DILocation(line: 0, scope: !187, inlinedAt: !214)
!214 = !DILocation(line: 0, scope: !215, inlinedAt: !216)
!215 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!216 = !DILocation(line: 71, scope: !217, inlinedAt: !218)
!217 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!218 = !DILocation(line: 65, scope: !217, inlinedAt: !219)
!219 = !DILocation(line: 5, scope: !193, inlinedAt: !194)
!220 = !{i32 0, i32 1023}
!221 = !DILocation(line: 499, scope: !222, inlinedAt: !223)
!222 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!223 = !DILocation(line: 449, scope: !222, inlinedAt: !224)
!224 = !DILocation(line: 492, scope: !225, inlinedAt: !227)
!225 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!226 = !DIFile(filename: "int.jl", directory: ".")
!227 = !DILocation(line: 269, scope: !228, inlinedAt: !211)
!228 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !229, file: !229, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!229 = !DIFile(filename: "operators.jl", directory: ".")
!230 = !DILocation(line: 38, scope: !231, inlinedAt: !232)
!231 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!232 = !DILocation(line: 36, scope: !231, inlinedAt: !233)
!233 = !DILocation(line: 124, scope: !212, inlinedAt: !213)
!234 = !DILocation(line: 27, scope: !235, inlinedAt: !236)
!235 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!236 = !DILocation(line: 37, scope: !231, inlinedAt: !232)
!237 = !DILocation(line: 126, scope: !238, inlinedAt: !239)
!238 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!239 = !DILocation(line: 126, scope: !238, inlinedAt: !240)
!240 = !DILocation(line: 33, scope: !241, inlinedAt: !242)
!241 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!242 = !DILocation(line: 41, scope: !231, inlinedAt: !232)
!243 = !DILocation(line: 108, scope: !244, inlinedAt: !245)
!244 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!245 = !DILocation(line: 46, scope: !231, inlinedAt: !232)
!246 = !DILocation(line: 47, scope: !231, inlinedAt: !232)
!247 = !DILocation(line: 6, scope: !248, inlinedAt: !250)
!248 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !249, file: !249, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!249 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!250 = !DILocation(line: 109, scope: !212, inlinedAt: !213)
!251 = !DILocation(line: 92, scope: !212, inlinedAt: !252)
!252 = !DILocation(line: 0, scope: !187, inlinedAt: !253)
!253 = !DILocation(line: 0, scope: !254, inlinedAt: !255)
!254 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!255 = !DILocation(line: 72, scope: !217, inlinedAt: !218)
!256 = !DILocation(line: 40, scope: !178, inlinedAt: !257)
!257 = !DILocation(line: 46, scope: !258, inlinedAt: !260)
!258 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!259 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl", directory: ".")
!260 = !DILocation(line: 46, scope: !261, inlinedAt: !262)
!261 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!262 = !DILocation(line: 88, scope: !263, inlinedAt: !264)
!263 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!264 = !DILocation(line: 88, scope: !263, inlinedAt: !265)
!265 = !DILocation(line: 88, scope: !263, inlinedAt: !266)
!266 = !DILocation(line: 152, scope: !212, inlinedAt: !252)
!267 = !{!268, !268, i64 0, i64 0}
!268 = !{!"custom_tbaa_addrspace(1)", !269, i64 0}
!269 = !{!"custom_tbaa"}
!270 = !DILocation(line: 6, scope: !248, inlinedAt: !271)
!271 = !DILocation(line: 109, scope: !212, inlinedAt: !252)
!272 = !DILocation(line: 92, scope: !212, inlinedAt: !273)
!273 = !DILocation(line: 0, scope: !187, inlinedAt: !274)
!274 = !DILocation(line: 0, scope: !275, inlinedAt: !276)
!275 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!276 = !DILocation(line: 73, scope: !217, inlinedAt: !218)
!277 = !DILocation(line: 38, scope: !231, inlinedAt: !278)
!278 = !DILocation(line: 36, scope: !231, inlinedAt: !279)
!279 = !DILocation(line: 174, scope: !212, inlinedAt: !273)
!280 = !DILocation(line: 27, scope: !235, inlinedAt: !281)
!281 = !DILocation(line: 37, scope: !231, inlinedAt: !278)
!282 = !DILocation(line: 126, scope: !238, inlinedAt: !283)
!283 = !DILocation(line: 126, scope: !238, inlinedAt: !284)
!284 = !DILocation(line: 33, scope: !241, inlinedAt: !285)
!285 = !DILocation(line: 41, scope: !231, inlinedAt: !278)
!286 = !DILocation(line: 108, scope: !244, inlinedAt: !287)
!287 = !DILocation(line: 46, scope: !231, inlinedAt: !278)
!288 = !DILocation(line: 47, scope: !231, inlinedAt: !278)
!289 = !DILocation(line: 12, scope: !290, inlinedAt: !291)
!290 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!291 = !DILocation(line: 61, scope: !292, inlinedAt: !293)
!292 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!293 = !DILocation(line: 60, scope: !292, inlinedAt: !294)
!294 = !DILocation(line: 176, scope: !212, inlinedAt: !273)
!295 = !DILocation(line: 62, scope: !292, inlinedAt: !293)
!296 = !DILocation(line: 126, scope: !238, inlinedAt: !297)
!297 = !DILocation(line: 126, scope: !238, inlinedAt: !298)
!298 = !DILocation(line: 33, scope: !241, inlinedAt: !299)
!299 = !DILocation(line: 65, scope: !292, inlinedAt: !293)
!300 = !DILocation(line: 108, scope: !244, inlinedAt: !301)
!301 = !DILocation(line: 70, scope: !292, inlinedAt: !293)
!302 = !DILocation(line: 71, scope: !292, inlinedAt: !293)
!303 = !DILocation(line: 40, scope: !178, inlinedAt: !304)
!304 = !DILocation(line: 9, scope: !258, inlinedAt: !305)
!305 = !DILocation(line: 9, scope: !306, inlinedAt: !307)
!306 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!307 = !DILocation(line: 85, scope: !308, inlinedAt: !309)
!308 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!309 = !DILocation(line: 85, scope: !308, inlinedAt: !310)
!310 = !DILocation(line: 85, scope: !308, inlinedAt: !311)
!311 = !DILocation(line: 180, scope: !212, inlinedAt: !273)
!312 = !DILocation(line: 499, scope: !222, inlinedAt: !313)
!313 = !DILocation(line: 492, scope: !225, inlinedAt: !314)
!314 = !DILocation(line: 181, scope: !212, inlinedAt: !273)
!315 = !DILocation(line: 19, scope: !316, inlinedAt: !317)
!316 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!317 = !DILocation(line: 19, scope: !316, inlinedAt: !318)
!318 = !DILocation(line: 182, scope: !212, inlinedAt: !273)
!319 = !DILocation(line: 126, scope: !238, inlinedAt: !320)
!320 = !DILocation(line: 126, scope: !238, inlinedAt: !321)
!321 = !DILocation(line: 33, scope: !241, inlinedAt: !322)
!322 = !DILocation(line: 183, scope: !212, inlinedAt: !273)
!323 = !DILocation(line: 1, scope: !324, inlinedAt: !326)
!324 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !325, file: !325, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!325 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!326 = !DILocation(line: 184, scope: !212, inlinedAt: !273)
!327 = !DILocation(line: 40, scope: !178, inlinedAt: !328)
!328 = !DILocation(line: 9, scope: !258, inlinedAt: !329)
!329 = !DILocation(line: 9, scope: !306, inlinedAt: !330)
!330 = !DILocation(line: 85, scope: !308, inlinedAt: !331)
!331 = !DILocation(line: 85, scope: !308, inlinedAt: !332)
!332 = !DILocation(line: 85, scope: !308, inlinedAt: !333)
!333 = !DILocation(line: 186, scope: !212, inlinedAt: !273)
!334 = !DILocation(line: 40, scope: !178, inlinedAt: !335)
!335 = !DILocation(line: 46, scope: !258, inlinedAt: !336)
!336 = !DILocation(line: 46, scope: !261, inlinedAt: !337)
!337 = !DILocation(line: 88, scope: !263, inlinedAt: !338)
!338 = !DILocation(line: 88, scope: !263, inlinedAt: !339)
!339 = !DILocation(line: 88, scope: !263, inlinedAt: !333)
!340 = !{!341, !341, i64 0, i64 0}
!341 = !{!"custom_tbaa_addrspace(3)", !269, i64 0}
!342 = !DILocation(line: 19, scope: !316, inlinedAt: !343)
!343 = !DILocation(line: 19, scope: !316, inlinedAt: !344)
!344 = !DILocation(line: 188, scope: !212, inlinedAt: !273)
!345 = !DILocation(line: 6, scope: !248, inlinedAt: !346)
!346 = !DILocation(line: 109, scope: !212, inlinedAt: !273)
!347 = !DILocation(line: 40, scope: !178, inlinedAt: !348)
!348 = !DILocation(line: 9, scope: !258, inlinedAt: !349)
!349 = !DILocation(line: 9, scope: !306, inlinedAt: !350)
!350 = !DILocation(line: 85, scope: !308, inlinedAt: !351)
!351 = !DILocation(line: 85, scope: !308, inlinedAt: !352)
!352 = !DILocation(line: 85, scope: !308, inlinedAt: !353)
!353 = !DILocation(line: 191, scope: !212, inlinedAt: !273)
!354 = !DILocation(line: 513, scope: !172, inlinedAt: !194)
!355 = !DILocation(line: 499, scope: !222, inlinedAt: !356)
!356 = !DILocation(line: 492, scope: !225, inlinedAt: !357)
!357 = !DILocation(line: 52, scope: !175, inlinedAt: !176)
!358 = !DILocation(line: 40, scope: !178, inlinedAt: !359)
!359 = !DILocation(line: 0, scope: !187, inlinedAt: !360)
!360 = !DILocation(line: 0, scope: !189, inlinedAt: !361)
!361 = !DILocation(line: 15, scope: !362, inlinedAt: !363)
!362 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!363 = !DILocation(line: 69, scope: !364, inlinedAt: !366)
!364 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!365 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!366 = !DILocation(line: 53, scope: !175, inlinedAt: !176)
!367 = !DILocation(line: 111, scope: !196, inlinedAt: !368)
!368 = !DILocation(line: 111, scope: !196, inlinedAt: !369)
!369 = !DILocation(line: 70, scope: !364, inlinedAt: !366)
!370 = !DILocation(line: 92, scope: !212, inlinedAt: !371)
!371 = !DILocation(line: 0, scope: !187, inlinedAt: !372)
!372 = !DILocation(line: 0, scope: !215, inlinedAt: !373)
!373 = !DILocation(line: 115, scope: !374, inlinedAt: !369)
!374 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!375 = !DILocation(line: 37, scope: !376, inlinedAt: !378)
!376 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !377, file: !377, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!377 = !DIFile(filename: "Base.jl", directory: ".")
!378 = !DILocation(line: 124, scope: !212, inlinedAt: !371)
!379 = !{!380, !380, i64 0}
!380 = !{!"jtbaa_stack", !116, i64 0}
!381 = !{!123}
!382 = !{!122, !119, !124, !125}
!383 = !DILocation(line: 27, scope: !235, inlinedAt: !384)
!384 = !DILocation(line: 37, scope: !231, inlinedAt: !385)
!385 = !DILocation(line: 36, scope: !231, inlinedAt: !378)
!386 = !DILocation(line: 38, scope: !231, inlinedAt: !385)
!387 = !DILocation(line: 126, scope: !238, inlinedAt: !388)
!388 = !DILocation(line: 126, scope: !238, inlinedAt: !389)
!389 = !DILocation(line: 33, scope: !241, inlinedAt: !390)
!390 = !DILocation(line: 41, scope: !231, inlinedAt: !385)
!391 = !DILocation(line: 108, scope: !244, inlinedAt: !392)
!392 = !DILocation(line: 46, scope: !231, inlinedAt: !385)
!393 = !DILocation(line: 47, scope: !231, inlinedAt: !385)
!394 = !DILocation(line: 6, scope: !248, inlinedAt: !395)
!395 = !DILocation(line: 109, scope: !212, inlinedAt: !371)
!396 = !DILocation(line: 37, scope: !376, inlinedAt: !369)
!397 = !DILocation(line: 513, scope: !172, inlinedAt: !398)
!398 = !DILocation(line: 100, scope: !399, inlinedAt: !400)
!399 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!400 = !DILocation(line: 114, scope: !401, inlinedAt: !369)
!401 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!402 = !DILocation(line: 40, scope: !178, inlinedAt: !403)
!403 = !DILocation(line: 0, scope: !187, inlinedAt: !404)
!404 = !DILocation(line: 0, scope: !405, inlinedAt: !369)
!405 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!406 = !DILocation(line: 40, scope: !178, inlinedAt: !407)
!407 = !DILocation(line: 46, scope: !258, inlinedAt: !408)
!408 = !DILocation(line: 46, scope: !261, inlinedAt: !409)
!409 = !DILocation(line: 88, scope: !263, inlinedAt: !410)
!410 = !DILocation(line: 88, scope: !263, inlinedAt: !369)
!411 = !DILocation(line: 158, scope: !412, inlinedAt: !369)
!412 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!413 = !DILocation(line: 168, scope: !212, inlinedAt: !273)
!414 = !DILocation(line: 40, scope: !178, inlinedAt: !415)
!415 = !DILocation(line: 0, scope: !187, inlinedAt: !416)
!416 = !DILocation(line: 0, scope: !405, inlinedAt: !417)
!417 = !DILocation(line: 57, scope: !175, inlinedAt: !176)
!418 = !DILocation(line: 114, scope: !401, inlinedAt: !419)
!419 = !DILocation(line: 59, scope: !175, inlinedAt: !176)
!420 = !DILocation(line: 40, scope: !178, inlinedAt: !421)
!421 = !DILocation(line: 46, scope: !258, inlinedAt: !422)
!422 = !DILocation(line: 46, scope: !261, inlinedAt: !423)
!423 = !DILocation(line: 88, scope: !263, inlinedAt: !424)
!424 = !DILocation(line: 88, scope: !263, inlinedAt: !425)
!425 = !DILocation(line: 88, scope: !263, inlinedAt: !419)
!426 = !DILocation(line: 513, scope: !172, inlinedAt: !427)
!427 = !DILocation(line: 46, scope: !175, inlinedAt: !428)
!428 = !DILocation(line: 92, scope: !159)
!429 = !DILocation(line: 40, scope: !178, inlinedAt: !430)
!430 = !DILocation(line: 3, scope: !180, inlinedAt: !431)
!431 = !DILocation(line: 3, scope: !183, inlinedAt: !432)
!432 = !DILocation(line: 47, scope: !175, inlinedAt: !428)
!433 = !DILocation(line: 111, scope: !196, inlinedAt: !434)
!434 = !DILocation(line: 111, scope: !196, inlinedAt: !435)
!435 = !DILocation(line: 4, scope: !193, inlinedAt: !436)
!436 = !DILocation(line: 50, scope: !175, inlinedAt: !428)
!437 = !DILocation(line: 92, scope: !212, inlinedAt: !438)
!438 = !DILocation(line: 0, scope: !187, inlinedAt: !439)
!439 = !DILocation(line: 0, scope: !215, inlinedAt: !440)
!440 = !DILocation(line: 71, scope: !217, inlinedAt: !441)
!441 = !DILocation(line: 65, scope: !217, inlinedAt: !442)
!442 = !DILocation(line: 5, scope: !193, inlinedAt: !436)
!443 = !DILocation(line: 38, scope: !231, inlinedAt: !444)
!444 = !DILocation(line: 36, scope: !231, inlinedAt: !445)
!445 = !DILocation(line: 124, scope: !212, inlinedAt: !438)
!446 = !DILocation(line: 27, scope: !235, inlinedAt: !447)
!447 = !DILocation(line: 37, scope: !231, inlinedAt: !444)
!448 = !DILocation(line: 126, scope: !238, inlinedAt: !449)
!449 = !DILocation(line: 126, scope: !238, inlinedAt: !450)
!450 = !DILocation(line: 33, scope: !241, inlinedAt: !451)
!451 = !DILocation(line: 41, scope: !231, inlinedAt: !444)
!452 = !DILocation(line: 108, scope: !244, inlinedAt: !453)
!453 = !DILocation(line: 46, scope: !231, inlinedAt: !444)
!454 = !DILocation(line: 47, scope: !231, inlinedAt: !444)
!455 = !DILocation(line: 6, scope: !248, inlinedAt: !456)
!456 = !DILocation(line: 109, scope: !212, inlinedAt: !438)
!457 = !DILocation(line: 92, scope: !212, inlinedAt: !458)
!458 = !DILocation(line: 0, scope: !187, inlinedAt: !459)
!459 = !DILocation(line: 0, scope: !254, inlinedAt: !460)
!460 = !DILocation(line: 72, scope: !217, inlinedAt: !441)
!461 = !DILocation(line: 40, scope: !178, inlinedAt: !462)
!462 = !DILocation(line: 46, scope: !258, inlinedAt: !463)
!463 = !DILocation(line: 46, scope: !261, inlinedAt: !464)
!464 = !DILocation(line: 88, scope: !263, inlinedAt: !465)
!465 = !DILocation(line: 88, scope: !263, inlinedAt: !466)
!466 = !DILocation(line: 88, scope: !263, inlinedAt: !467)
!467 = !DILocation(line: 152, scope: !212, inlinedAt: !458)
!468 = !DILocation(line: 6, scope: !248, inlinedAt: !469)
!469 = !DILocation(line: 109, scope: !212, inlinedAt: !458)
!470 = !DILocation(line: 92, scope: !212, inlinedAt: !471)
!471 = !DILocation(line: 0, scope: !187, inlinedAt: !472)
!472 = !DILocation(line: 0, scope: !275, inlinedAt: !473)
!473 = !DILocation(line: 73, scope: !217, inlinedAt: !441)
!474 = !DILocation(line: 38, scope: !231, inlinedAt: !475)
!475 = !DILocation(line: 36, scope: !231, inlinedAt: !476)
!476 = !DILocation(line: 174, scope: !212, inlinedAt: !471)
!477 = !DILocation(line: 27, scope: !235, inlinedAt: !478)
!478 = !DILocation(line: 37, scope: !231, inlinedAt: !475)
!479 = !DILocation(line: 126, scope: !238, inlinedAt: !480)
!480 = !DILocation(line: 126, scope: !238, inlinedAt: !481)
!481 = !DILocation(line: 33, scope: !241, inlinedAt: !482)
!482 = !DILocation(line: 41, scope: !231, inlinedAt: !475)
!483 = !DILocation(line: 108, scope: !244, inlinedAt: !484)
!484 = !DILocation(line: 46, scope: !231, inlinedAt: !475)
!485 = !DILocation(line: 47, scope: !231, inlinedAt: !475)
!486 = !DILocation(line: 12, scope: !290, inlinedAt: !487)
!487 = !DILocation(line: 61, scope: !292, inlinedAt: !488)
!488 = !DILocation(line: 60, scope: !292, inlinedAt: !489)
!489 = !DILocation(line: 176, scope: !212, inlinedAt: !471)
!490 = !DILocation(line: 62, scope: !292, inlinedAt: !488)
!491 = !DILocation(line: 126, scope: !238, inlinedAt: !492)
!492 = !DILocation(line: 126, scope: !238, inlinedAt: !493)
!493 = !DILocation(line: 33, scope: !241, inlinedAt: !494)
!494 = !DILocation(line: 65, scope: !292, inlinedAt: !488)
!495 = !DILocation(line: 108, scope: !244, inlinedAt: !496)
!496 = !DILocation(line: 70, scope: !292, inlinedAt: !488)
!497 = !DILocation(line: 71, scope: !292, inlinedAt: !488)
!498 = !DILocation(line: 40, scope: !178, inlinedAt: !499)
!499 = !DILocation(line: 9, scope: !258, inlinedAt: !500)
!500 = !DILocation(line: 9, scope: !306, inlinedAt: !501)
!501 = !DILocation(line: 85, scope: !308, inlinedAt: !502)
!502 = !DILocation(line: 85, scope: !308, inlinedAt: !503)
!503 = !DILocation(line: 85, scope: !308, inlinedAt: !504)
!504 = !DILocation(line: 180, scope: !212, inlinedAt: !471)
!505 = !DILocation(line: 499, scope: !222, inlinedAt: !506)
!506 = !DILocation(line: 492, scope: !225, inlinedAt: !507)
!507 = !DILocation(line: 181, scope: !212, inlinedAt: !471)
!508 = !DILocation(line: 19, scope: !316, inlinedAt: !509)
!509 = !DILocation(line: 19, scope: !316, inlinedAt: !510)
!510 = !DILocation(line: 182, scope: !212, inlinedAt: !471)
!511 = !DILocation(line: 126, scope: !238, inlinedAt: !512)
!512 = !DILocation(line: 126, scope: !238, inlinedAt: !513)
!513 = !DILocation(line: 33, scope: !241, inlinedAt: !514)
!514 = !DILocation(line: 183, scope: !212, inlinedAt: !471)
!515 = !DILocation(line: 1, scope: !324, inlinedAt: !516)
!516 = !DILocation(line: 184, scope: !212, inlinedAt: !471)
!517 = !DILocation(line: 40, scope: !178, inlinedAt: !518)
!518 = !DILocation(line: 9, scope: !258, inlinedAt: !519)
!519 = !DILocation(line: 9, scope: !306, inlinedAt: !520)
!520 = !DILocation(line: 85, scope: !308, inlinedAt: !521)
!521 = !DILocation(line: 85, scope: !308, inlinedAt: !522)
!522 = !DILocation(line: 85, scope: !308, inlinedAt: !523)
!523 = !DILocation(line: 186, scope: !212, inlinedAt: !471)
!524 = !DILocation(line: 40, scope: !178, inlinedAt: !525)
!525 = !DILocation(line: 46, scope: !258, inlinedAt: !526)
!526 = !DILocation(line: 46, scope: !261, inlinedAt: !527)
!527 = !DILocation(line: 88, scope: !263, inlinedAt: !528)
!528 = !DILocation(line: 88, scope: !263, inlinedAt: !529)
!529 = !DILocation(line: 88, scope: !263, inlinedAt: !523)
!530 = !DILocation(line: 19, scope: !316, inlinedAt: !531)
!531 = !DILocation(line: 19, scope: !316, inlinedAt: !532)
!532 = !DILocation(line: 188, scope: !212, inlinedAt: !471)
!533 = !DILocation(line: 6, scope: !248, inlinedAt: !534)
!534 = !DILocation(line: 109, scope: !212, inlinedAt: !471)
!535 = !DILocation(line: 40, scope: !178, inlinedAt: !536)
!536 = !DILocation(line: 9, scope: !258, inlinedAt: !537)
!537 = !DILocation(line: 9, scope: !306, inlinedAt: !538)
!538 = !DILocation(line: 85, scope: !308, inlinedAt: !539)
!539 = !DILocation(line: 85, scope: !308, inlinedAt: !540)
!540 = !DILocation(line: 85, scope: !308, inlinedAt: !541)
!541 = !DILocation(line: 191, scope: !212, inlinedAt: !471)
!542 = !DILocation(line: 513, scope: !172, inlinedAt: !436)
!543 = !DILocation(line: 499, scope: !222, inlinedAt: !544)
!544 = !DILocation(line: 492, scope: !225, inlinedAt: !545)
!545 = !DILocation(line: 52, scope: !175, inlinedAt: !428)
!546 = !DILocation(line: 40, scope: !178, inlinedAt: !547)
!547 = !DILocation(line: 0, scope: !187, inlinedAt: !548)
!548 = !DILocation(line: 0, scope: !189, inlinedAt: !549)
!549 = !DILocation(line: 15, scope: !362, inlinedAt: !550)
!550 = !DILocation(line: 69, scope: !364, inlinedAt: !551)
!551 = !DILocation(line: 53, scope: !175, inlinedAt: !428)
!552 = !DILocation(line: 111, scope: !196, inlinedAt: !553)
!553 = !DILocation(line: 111, scope: !196, inlinedAt: !554)
!554 = !DILocation(line: 70, scope: !364, inlinedAt: !551)
!555 = !DILocation(line: 92, scope: !212, inlinedAt: !556)
!556 = !DILocation(line: 0, scope: !187, inlinedAt: !557)
!557 = !DILocation(line: 0, scope: !215, inlinedAt: !558)
!558 = !DILocation(line: 115, scope: !374, inlinedAt: !554)
!559 = !DILocation(line: 37, scope: !376, inlinedAt: !560)
!560 = !DILocation(line: 124, scope: !212, inlinedAt: !556)
!561 = !DILocation(line: 27, scope: !235, inlinedAt: !562)
!562 = !DILocation(line: 37, scope: !231, inlinedAt: !563)
!563 = !DILocation(line: 36, scope: !231, inlinedAt: !560)
!564 = !DILocation(line: 38, scope: !231, inlinedAt: !563)
!565 = !DILocation(line: 126, scope: !238, inlinedAt: !566)
!566 = !DILocation(line: 126, scope: !238, inlinedAt: !567)
!567 = !DILocation(line: 33, scope: !241, inlinedAt: !568)
!568 = !DILocation(line: 41, scope: !231, inlinedAt: !563)
!569 = !DILocation(line: 108, scope: !244, inlinedAt: !570)
!570 = !DILocation(line: 46, scope: !231, inlinedAt: !563)
!571 = !DILocation(line: 47, scope: !231, inlinedAt: !563)
!572 = !DILocation(line: 6, scope: !248, inlinedAt: !573)
!573 = !DILocation(line: 109, scope: !212, inlinedAt: !556)
!574 = !DILocation(line: 37, scope: !376, inlinedAt: !554)
!575 = !DILocation(line: 513, scope: !172, inlinedAt: !576)
!576 = !DILocation(line: 100, scope: !399, inlinedAt: !577)
!577 = !DILocation(line: 114, scope: !401, inlinedAt: !554)
!578 = !DILocation(line: 40, scope: !178, inlinedAt: !579)
!579 = !DILocation(line: 0, scope: !187, inlinedAt: !580)
!580 = !DILocation(line: 0, scope: !405, inlinedAt: !554)
!581 = !DILocation(line: 40, scope: !178, inlinedAt: !582)
!582 = !DILocation(line: 46, scope: !258, inlinedAt: !583)
!583 = !DILocation(line: 46, scope: !261, inlinedAt: !584)
!584 = !DILocation(line: 88, scope: !263, inlinedAt: !585)
!585 = !DILocation(line: 88, scope: !263, inlinedAt: !554)
!586 = !DILocation(line: 158, scope: !412, inlinedAt: !554)
!587 = !DILocation(line: 168, scope: !212, inlinedAt: !471)
!588 = !DILocation(line: 40, scope: !178, inlinedAt: !589)
!589 = !DILocation(line: 0, scope: !187, inlinedAt: !590)
!590 = !DILocation(line: 0, scope: !405, inlinedAt: !591)
!591 = !DILocation(line: 57, scope: !175, inlinedAt: !428)
!592 = !DILocation(line: 114, scope: !401, inlinedAt: !593)
!593 = !DILocation(line: 59, scope: !175, inlinedAt: !428)
!594 = !DILocation(line: 40, scope: !178, inlinedAt: !595)
!595 = !DILocation(line: 46, scope: !258, inlinedAt: !596)
!596 = !DILocation(line: 46, scope: !261, inlinedAt: !597)
!597 = !DILocation(line: 88, scope: !263, inlinedAt: !598)
!598 = !DILocation(line: 88, scope: !263, inlinedAt: !599)
!599 = !DILocation(line: 88, scope: !263, inlinedAt: !593)
!600 = !DILocation(line: 40, scope: !178, inlinedAt: !601)
!601 = !DILocation(line: 0, scope: !187, inlinedAt: !602)
!602 = !DILocation(line: 0, scope: !189, inlinedAt: !603)
!603 = !DILocation(line: 19, scope: !604, inlinedAt: !605)
!604 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!605 = !DILocation(line: 187, scope: !364, inlinedAt: !606)
!606 = !DILocation(line: 93, scope: !159)
!607 = !DILocation(line: 111, scope: !196, inlinedAt: !608)
!608 = !DILocation(line: 111, scope: !196, inlinedAt: !605)
!609 = !DILocation(line: 92, scope: !212, inlinedAt: !610)
!610 = !DILocation(line: 0, scope: !187, inlinedAt: !611)
!611 = !DILocation(line: 0, scope: !215, inlinedAt: !612)
!612 = !DILocation(line: 115, scope: !374, inlinedAt: !613)
!613 = !DILocation(line: 193, scope: !364, inlinedAt: !606)
!614 = !DILocation(line: 38, scope: !231, inlinedAt: !615)
!615 = !DILocation(line: 36, scope: !231, inlinedAt: !616)
!616 = !DILocation(line: 124, scope: !212, inlinedAt: !610)
!617 = !DILocation(line: 27, scope: !235, inlinedAt: !618)
!618 = !DILocation(line: 37, scope: !231, inlinedAt: !615)
!619 = !DILocation(line: 126, scope: !238, inlinedAt: !620)
!620 = !DILocation(line: 126, scope: !238, inlinedAt: !621)
!621 = !DILocation(line: 33, scope: !241, inlinedAt: !622)
!622 = !DILocation(line: 41, scope: !231, inlinedAt: !615)
!623 = !DILocation(line: 108, scope: !244, inlinedAt: !624)
!624 = !DILocation(line: 46, scope: !231, inlinedAt: !615)
!625 = !DILocation(line: 47, scope: !231, inlinedAt: !615)
!626 = !DILocation(line: 6, scope: !248, inlinedAt: !627)
!627 = !DILocation(line: 109, scope: !212, inlinedAt: !610)
!628 = !DILocation(line: 40, scope: !178, inlinedAt: !629)
!629 = !DILocation(line: 46, scope: !258, inlinedAt: !630)
!630 = !DILocation(line: 46, scope: !261, inlinedAt: !631)
!631 = !DILocation(line: 88, scope: !263, inlinedAt: !632)
!632 = !DILocation(line: 88, scope: !263, inlinedAt: !633)
!633 = !DILocation(line: 88, scope: !263, inlinedAt: !634)
!634 = !DILocation(line: 195, scope: !364, inlinedAt: !606)
!635 = !DILocation(line: 114, scope: !401, inlinedAt: !636)
!636 = !DILocation(line: 196, scope: !364, inlinedAt: !606)
!637 = !DILocation(line: 40, scope: !178, inlinedAt: !638)
!638 = !DILocation(line: 46, scope: !258, inlinedAt: !639)
!639 = !DILocation(line: 46, scope: !261, inlinedAt: !640)
!640 = !DILocation(line: 88, scope: !263, inlinedAt: !641)
!641 = !DILocation(line: 88, scope: !263, inlinedAt: !642)
!642 = !DILocation(line: 88, scope: !263, inlinedAt: !643)
!643 = !DILocation(line: 153, scope: !644, inlinedAt: !645)
!644 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!645 = !DILocation(line: 198, scope: !364, inlinedAt: !606)
!646 = !DILocation(line: 114, scope: !401, inlinedAt: !647)
!647 = !DILocation(line: 154, scope: !644, inlinedAt: !645)
!648 = !DILocation(line: 40, scope: !178, inlinedAt: !649)
!649 = !DILocation(line: 46, scope: !258, inlinedAt: !650)
!650 = !DILocation(line: 46, scope: !261, inlinedAt: !651)
!651 = !DILocation(line: 88, scope: !263, inlinedAt: !652)
!652 = !DILocation(line: 88, scope: !263, inlinedAt: !653)
!653 = !DILocation(line: 88, scope: !263, inlinedAt: !654)
!654 = !DILocation(line: 155, scope: !644, inlinedAt: !645)
!655 = !DILocation(line: 92, scope: !212, inlinedAt: !656)
!656 = !DILocation(line: 201, scope: !364, inlinedAt: !606)
!657 = !DILocation(line: 114, scope: !401, inlinedAt: !658)
!658 = !DILocation(line: 156, scope: !644, inlinedAt: !645)
!659 = !DILocation(line: 40, scope: !178, inlinedAt: !660)
!660 = !DILocation(line: 46, scope: !258, inlinedAt: !661)
!661 = !DILocation(line: 46, scope: !261, inlinedAt: !662)
!662 = !DILocation(line: 88, scope: !263, inlinedAt: !663)
!663 = !DILocation(line: 88, scope: !263, inlinedAt: !664)
!664 = !DILocation(line: 88, scope: !263, inlinedAt: !665)
!665 = !DILocation(line: 166, scope: !666, inlinedAt: !667)
!666 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!667 = !DILocation(line: 107, scope: !212, inlinedAt: !656)
!668 = !DILocation(line: 114, scope: !401, inlinedAt: !669)
!669 = !DILocation(line: 167, scope: !666, inlinedAt: !667)
!670 = !DILocation(line: 40, scope: !178, inlinedAt: !671)
!671 = !DILocation(line: 46, scope: !258, inlinedAt: !672)
!672 = !DILocation(line: 46, scope: !261, inlinedAt: !673)
!673 = !DILocation(line: 88, scope: !263, inlinedAt: !674)
!674 = !DILocation(line: 88, scope: !263, inlinedAt: !675)
!675 = !DILocation(line: 88, scope: !263, inlinedAt: !676)
!676 = !DILocation(line: 169, scope: !666, inlinedAt: !667)
!677 = !DILocation(line: 114, scope: !401, inlinedAt: !678)
!678 = !DILocation(line: 170, scope: !666, inlinedAt: !667)
!679 = !DILocation(line: 40, scope: !178, inlinedAt: !680)
!680 = !DILocation(line: 46, scope: !258, inlinedAt: !681)
!681 = !DILocation(line: 46, scope: !261, inlinedAt: !682)
!682 = !DILocation(line: 88, scope: !263, inlinedAt: !683)
!683 = !DILocation(line: 88, scope: !263, inlinedAt: !684)
!684 = !DILocation(line: 88, scope: !263, inlinedAt: !667)
!685 = !DILocation(line: 6, scope: !248, inlinedAt: !686)
!686 = !DILocation(line: 109, scope: !212, inlinedAt: !656)
!687 = !DILocation(line: 92, scope: !212, inlinedAt: !688)
!688 = !DILocation(line: 0, scope: !187, inlinedAt: !689)
!689 = !DILocation(line: 0, scope: !275, inlinedAt: !690)
!690 = !DILocation(line: 158, scope: !412, inlinedAt: !656)
!691 = !DILocation(line: 38, scope: !231, inlinedAt: !692)
!692 = !DILocation(line: 36, scope: !231, inlinedAt: !693)
!693 = !DILocation(line: 174, scope: !212, inlinedAt: !688)
!694 = !DILocation(line: 27, scope: !235, inlinedAt: !695)
!695 = !DILocation(line: 37, scope: !231, inlinedAt: !692)
!696 = !DILocation(line: 126, scope: !238, inlinedAt: !697)
!697 = !DILocation(line: 126, scope: !238, inlinedAt: !698)
!698 = !DILocation(line: 33, scope: !241, inlinedAt: !699)
!699 = !DILocation(line: 41, scope: !231, inlinedAt: !692)
!700 = !DILocation(line: 108, scope: !244, inlinedAt: !701)
!701 = !DILocation(line: 46, scope: !231, inlinedAt: !692)
!702 = !DILocation(line: 47, scope: !231, inlinedAt: !692)
!703 = !DILocation(line: 12, scope: !290, inlinedAt: !704)
!704 = !DILocation(line: 61, scope: !292, inlinedAt: !705)
!705 = !DILocation(line: 60, scope: !292, inlinedAt: !706)
!706 = !DILocation(line: 176, scope: !212, inlinedAt: !688)
!707 = !DILocation(line: 62, scope: !292, inlinedAt: !705)
!708 = !DILocation(line: 126, scope: !238, inlinedAt: !709)
!709 = !DILocation(line: 126, scope: !238, inlinedAt: !710)
!710 = !DILocation(line: 33, scope: !241, inlinedAt: !711)
!711 = !DILocation(line: 65, scope: !292, inlinedAt: !705)
!712 = !DILocation(line: 108, scope: !244, inlinedAt: !713)
!713 = !DILocation(line: 70, scope: !292, inlinedAt: !705)
!714 = !DILocation(line: 71, scope: !292, inlinedAt: !705)
!715 = !DILocation(line: 19, scope: !316, inlinedAt: !716)
!716 = !DILocation(line: 19, scope: !316, inlinedAt: !717)
!717 = !DILocation(line: 188, scope: !212, inlinedAt: !688)
!718 = !DILocation(line: 6, scope: !248, inlinedAt: !719)
!719 = !DILocation(line: 109, scope: !212, inlinedAt: !688)
!720 = !DILocation(line: 40, scope: !178, inlinedAt: !721)
!721 = !DILocation(line: 0, scope: !187, inlinedAt: !722)
!722 = !DILocation(line: 0, scope: !189, inlinedAt: !723)
!723 = !DILocation(line: 27, scope: !724, inlinedAt: !725)
!724 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!725 = !DILocation(line: 10, scope: !726, inlinedAt: !727)
!726 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !77)
!727 = !DILocation(line: 94, scope: !159)
!728 = !DILocation(line: 111, scope: !196, inlinedAt: !729)
!729 = !DILocation(line: 111, scope: !196, inlinedAt: !725)
!730 = !DILocation(line: 92, scope: !212, inlinedAt: !731)
!731 = !DILocation(line: 0, scope: !187, inlinedAt: !732)
!732 = !DILocation(line: 0, scope: !215, inlinedAt: !733)
!733 = !DILocation(line: 71, scope: !217, inlinedAt: !734)
!734 = !DILocation(line: 65, scope: !217, inlinedAt: !735)
!735 = !DILocation(line: 11, scope: !726, inlinedAt: !727)
!736 = !DILocation(line: 38, scope: !231, inlinedAt: !737)
!737 = !DILocation(line: 36, scope: !231, inlinedAt: !738)
!738 = !DILocation(line: 124, scope: !212, inlinedAt: !731)
!739 = !DILocation(line: 27, scope: !235, inlinedAt: !740)
!740 = !DILocation(line: 37, scope: !231, inlinedAt: !737)
!741 = !DILocation(line: 126, scope: !238, inlinedAt: !742)
!742 = !DILocation(line: 126, scope: !238, inlinedAt: !743)
!743 = !DILocation(line: 33, scope: !241, inlinedAt: !744)
!744 = !DILocation(line: 41, scope: !231, inlinedAt: !737)
!745 = !DILocation(line: 108, scope: !244, inlinedAt: !746)
!746 = !DILocation(line: 46, scope: !231, inlinedAt: !737)
!747 = !DILocation(line: 47, scope: !231, inlinedAt: !737)
!748 = !DILocation(line: 6, scope: !248, inlinedAt: !749)
!749 = !DILocation(line: 109, scope: !212, inlinedAt: !731)
!750 = !DILocation(line: 92, scope: !212, inlinedAt: !751)
!751 = !DILocation(line: 0, scope: !187, inlinedAt: !752)
!752 = !DILocation(line: 0, scope: !254, inlinedAt: !753)
!753 = !DILocation(line: 72, scope: !217, inlinedAt: !734)
!754 = !DILocation(line: 40, scope: !178, inlinedAt: !755)
!755 = !DILocation(line: 46, scope: !258, inlinedAt: !756)
!756 = !DILocation(line: 46, scope: !261, inlinedAt: !757)
!757 = !DILocation(line: 88, scope: !263, inlinedAt: !758)
!758 = !DILocation(line: 88, scope: !263, inlinedAt: !759)
!759 = !DILocation(line: 88, scope: !263, inlinedAt: !760)
!760 = !DILocation(line: 152, scope: !212, inlinedAt: !751)
!761 = !DILocation(line: 6, scope: !248, inlinedAt: !762)
!762 = !DILocation(line: 109, scope: !212, inlinedAt: !751)
!763 = !DILocation(line: 92, scope: !212, inlinedAt: !764)
!764 = !DILocation(line: 0, scope: !187, inlinedAt: !765)
!765 = !DILocation(line: 0, scope: !275, inlinedAt: !766)
!766 = !DILocation(line: 73, scope: !217, inlinedAt: !734)
!767 = !DILocation(line: 38, scope: !231, inlinedAt: !768)
!768 = !DILocation(line: 36, scope: !231, inlinedAt: !769)
!769 = !DILocation(line: 174, scope: !212, inlinedAt: !764)
!770 = !DILocation(line: 27, scope: !235, inlinedAt: !771)
!771 = !DILocation(line: 37, scope: !231, inlinedAt: !768)
!772 = !DILocation(line: 126, scope: !238, inlinedAt: !773)
!773 = !DILocation(line: 126, scope: !238, inlinedAt: !774)
!774 = !DILocation(line: 33, scope: !241, inlinedAt: !775)
!775 = !DILocation(line: 41, scope: !231, inlinedAt: !768)
!776 = !DILocation(line: 108, scope: !244, inlinedAt: !777)
!777 = !DILocation(line: 46, scope: !231, inlinedAt: !768)
!778 = !DILocation(line: 47, scope: !231, inlinedAt: !768)
!779 = !DILocation(line: 12, scope: !290, inlinedAt: !780)
!780 = !DILocation(line: 61, scope: !292, inlinedAt: !781)
!781 = !DILocation(line: 60, scope: !292, inlinedAt: !782)
!782 = !DILocation(line: 176, scope: !212, inlinedAt: !764)
!783 = !DILocation(line: 62, scope: !292, inlinedAt: !781)
!784 = !DILocation(line: 126, scope: !238, inlinedAt: !785)
!785 = !DILocation(line: 126, scope: !238, inlinedAt: !786)
!786 = !DILocation(line: 33, scope: !241, inlinedAt: !787)
!787 = !DILocation(line: 65, scope: !292, inlinedAt: !781)
!788 = !DILocation(line: 108, scope: !244, inlinedAt: !789)
!789 = !DILocation(line: 70, scope: !292, inlinedAt: !781)
!790 = !DILocation(line: 71, scope: !292, inlinedAt: !781)
!791 = !DILocation(line: 19, scope: !316, inlinedAt: !792)
!792 = !DILocation(line: 19, scope: !316, inlinedAt: !793)
!793 = !DILocation(line: 188, scope: !212, inlinedAt: !764)
!794 = !DILocation(line: 6, scope: !248, inlinedAt: !795)
!795 = !DILocation(line: 109, scope: !212, inlinedAt: !764)
!796 = !DILocation(line: 111, scope: !196, inlinedAt: !797)
!797 = !DILocation(line: 111, scope: !196, inlinedAt: !798)
!798 = !DILocation(line: 10, scope: !726, inlinedAt: !799)
!799 = !DILocation(line: 95, scope: !159)
!800 = !DILocation(line: 92, scope: !212, inlinedAt: !801)
!801 = !DILocation(line: 0, scope: !187, inlinedAt: !802)
!802 = !DILocation(line: 0, scope: !215, inlinedAt: !803)
!803 = !DILocation(line: 71, scope: !217, inlinedAt: !804)
!804 = !DILocation(line: 65, scope: !217, inlinedAt: !805)
!805 = !DILocation(line: 11, scope: !726, inlinedAt: !799)
!806 = !DILocation(line: 38, scope: !231, inlinedAt: !807)
!807 = !DILocation(line: 36, scope: !231, inlinedAt: !808)
!808 = !DILocation(line: 124, scope: !212, inlinedAt: !801)
!809 = !DILocation(line: 27, scope: !235, inlinedAt: !810)
!810 = !DILocation(line: 37, scope: !231, inlinedAt: !807)
!811 = !DILocation(line: 126, scope: !238, inlinedAt: !812)
!812 = !DILocation(line: 126, scope: !238, inlinedAt: !813)
!813 = !DILocation(line: 33, scope: !241, inlinedAt: !814)
!814 = !DILocation(line: 41, scope: !231, inlinedAt: !807)
!815 = !DILocation(line: 108, scope: !244, inlinedAt: !816)
!816 = !DILocation(line: 46, scope: !231, inlinedAt: !807)
!817 = !DILocation(line: 47, scope: !231, inlinedAt: !807)
!818 = !DILocation(line: 6, scope: !248, inlinedAt: !819)
!819 = !DILocation(line: 109, scope: !212, inlinedAt: !801)
!820 = !DILocation(line: 92, scope: !212, inlinedAt: !821)
!821 = !DILocation(line: 0, scope: !187, inlinedAt: !822)
!822 = !DILocation(line: 0, scope: !254, inlinedAt: !823)
!823 = !DILocation(line: 72, scope: !217, inlinedAt: !804)
!824 = !DILocation(line: 40, scope: !178, inlinedAt: !825)
!825 = !DILocation(line: 46, scope: !258, inlinedAt: !826)
!826 = !DILocation(line: 46, scope: !261, inlinedAt: !827)
!827 = !DILocation(line: 88, scope: !263, inlinedAt: !828)
!828 = !DILocation(line: 88, scope: !263, inlinedAt: !829)
!829 = !DILocation(line: 88, scope: !263, inlinedAt: !830)
!830 = !DILocation(line: 152, scope: !212, inlinedAt: !821)
!831 = !DILocation(line: 6, scope: !248, inlinedAt: !832)
!832 = !DILocation(line: 109, scope: !212, inlinedAt: !821)
!833 = !DILocation(line: 92, scope: !212, inlinedAt: !834)
!834 = !DILocation(line: 0, scope: !187, inlinedAt: !835)
!835 = !DILocation(line: 0, scope: !275, inlinedAt: !836)
!836 = !DILocation(line: 73, scope: !217, inlinedAt: !804)
!837 = !DILocation(line: 38, scope: !231, inlinedAt: !838)
!838 = !DILocation(line: 36, scope: !231, inlinedAt: !839)
!839 = !DILocation(line: 174, scope: !212, inlinedAt: !834)
!840 = !DILocation(line: 27, scope: !235, inlinedAt: !841)
!841 = !DILocation(line: 37, scope: !231, inlinedAt: !838)
!842 = !DILocation(line: 126, scope: !238, inlinedAt: !843)
!843 = !DILocation(line: 126, scope: !238, inlinedAt: !844)
!844 = !DILocation(line: 33, scope: !241, inlinedAt: !845)
!845 = !DILocation(line: 41, scope: !231, inlinedAt: !838)
!846 = !DILocation(line: 108, scope: !244, inlinedAt: !847)
!847 = !DILocation(line: 46, scope: !231, inlinedAt: !838)
!848 = !DILocation(line: 47, scope: !231, inlinedAt: !838)
!849 = !DILocation(line: 12, scope: !290, inlinedAt: !850)
!850 = !DILocation(line: 61, scope: !292, inlinedAt: !851)
!851 = !DILocation(line: 60, scope: !292, inlinedAt: !852)
!852 = !DILocation(line: 176, scope: !212, inlinedAt: !834)
!853 = !DILocation(line: 62, scope: !292, inlinedAt: !851)
!854 = !DILocation(line: 126, scope: !238, inlinedAt: !855)
!855 = !DILocation(line: 126, scope: !238, inlinedAt: !856)
!856 = !DILocation(line: 33, scope: !241, inlinedAt: !857)
!857 = !DILocation(line: 65, scope: !292, inlinedAt: !851)
!858 = !DILocation(line: 108, scope: !244, inlinedAt: !859)
!859 = !DILocation(line: 70, scope: !292, inlinedAt: !851)
!860 = !DILocation(line: 71, scope: !292, inlinedAt: !851)
!861 = !DILocation(line: 19, scope: !316, inlinedAt: !862)
!862 = !DILocation(line: 19, scope: !316, inlinedAt: !863)
!863 = !DILocation(line: 188, scope: !212, inlinedAt: !834)
!864 = !DILocation(line: 6, scope: !248, inlinedAt: !865)
!865 = !DILocation(line: 109, scope: !212, inlinedAt: !834)
!866 = !DILocation(line: 96, scope: !159)
!867 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2331", scope: null, file: !5, line: 57, type: !74, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !868)
!868 = !{!869, !870, !871}
!869 = !DILocalVariable(name: "#self#", arg: 1, scope: !867, file: !5, line: 57, type: !78)
!870 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !867, file: !5, line: 57, type: !79)
!871 = !DILocalVariable(name: "value", arg: 3, scope: !867, file: !5, line: 57, type: !80)
!872 = !DILocation(line: 0, scope: !867)
!873 = !DILocation(line: 12, scope: !874, inlinedAt: !875)
!874 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!875 = !DILocation(line: 61, scope: !876, inlinedAt: !877)
!876 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!877 = !DILocation(line: 60, scope: !867)
!878 = !DILocation(line: 499, scope: !879, inlinedAt: !880)
!879 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!880 = !DILocation(line: 62, scope: !876, inlinedAt: !877)
!881 = !DILocation(line: 64, scope: !876, inlinedAt: !877)
!882 = !DILocation(line: 40, scope: !883, inlinedAt: !884)
!883 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!884 = !DILocation(line: 0, scope: !885, inlinedAt: !886)
!885 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!886 = !DILocation(line: 0, scope: !887, inlinedAt: !888)
!887 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!888 = !DILocation(line: 11, scope: !889, inlinedAt: !890)
!889 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!890 = !DILocation(line: 31, scope: !891, inlinedAt: !892)
!891 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!892 = !DILocation(line: 65, scope: !876, inlinedAt: !877)
!893 = !DILocation(line: 126, scope: !894, inlinedAt: !895)
!894 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!895 = !DILocation(line: 126, scope: !894, inlinedAt: !896)
!896 = !DILocation(line: 33, scope: !891, inlinedAt: !892)
!897 = !DILocation(line: 108, scope: !898, inlinedAt: !899)
!898 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !77)
!899 = !DILocation(line: 70, scope: !876, inlinedAt: !877)
!900 = distinct !DISubprogram(name: "set_one!", linkageName: "julia_set_one!_2744", scope: null, file: !19, line: 366, type: !901, scopeLine: 366, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !909)
!901 = !DISubroutineType(types: !902)
!902 = !{!76, !903, !904}
!903 = !DICompositeType(tag: DW_TAG_structure_type, name: "#set_one!", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927180048")
!904 = !DICompositeType(tag: DW_TAG_structure_type, name: "ROCDeviceArray", size: 128, align: 64, elements: !905, runtimeLang: DW_LANG_Julia, identifier: "140431678545744")
!905 = !{!906, !908}
!906 = !DICompositeType(tag: DW_TAG_structure_type, name: "Tuple", size: 64, align: 64, elements: !907, runtimeLang: DW_LANG_Julia, identifier: "140431554812112")
!907 = !{!80}
!908 = !DIBasicType(name: "LLVMPtr", size: 64, encoding: DW_ATE_unsigned)
!909 = !{!910, !911}
!910 = !DILocalVariable(name: "#self#", arg: 1, scope: !900, file: !19, line: 366, type: !903)
!911 = !DILocalVariable(name: "x", arg: 2, scope: !900, file: !19, line: 366, type: !904)
!912 = !DILocation(line: 366, scope: !900)
!913 = !DILocation(line: 40, scope: !914, inlinedAt: !915)
!914 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!915 = !DILocation(line: 3, scope: !916, inlinedAt: !917)
!916 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!917 = !DILocation(line: 3, scope: !918, inlinedAt: !919)
!918 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!919 = !DILocation(line: 89, scope: !920, inlinedAt: !921)
!920 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!921 = !DILocation(line: 124, scope: !922, inlinedAt: !923)
!922 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!923 = !DILocation(line: 367, scope: !900)
!924 = !DILocation(line: 87, scope: !925, inlinedAt: !926)
!925 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!926 = !DILocation(line: 1042, scope: !925, inlinedAt: !919)
!927 = !DILocation(line: 40, scope: !914, inlinedAt: !928)
!928 = !DILocation(line: 3, scope: !916, inlinedAt: !929)
!929 = !DILocation(line: 3, scope: !918, inlinedAt: !930)
!930 = !DILocation(line: 95, scope: !931, inlinedAt: !932)
!931 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!932 = !DILocation(line: 132, scope: !933, inlinedAt: !923)
!933 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!934 = !{i32 0, i32 -2}
!935 = !DILocation(line: 86, scope: !936, inlinedAt: !937)
!936 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!937 = !DILocation(line: 1042, scope: !936, inlinedAt: !923)
!938 = !DILocation(line: 40, scope: !914, inlinedAt: !939)
!939 = !DILocation(line: 33, scope: !916, inlinedAt: !940)
!940 = !DILocation(line: 33, scope: !941, inlinedAt: !942)
!941 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!942 = !DILocation(line: 103, scope: !943, inlinedAt: !944)
!943 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!944 = !DILocation(line: 140, scope: !945, inlinedAt: !923)
!945 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!946 = !{i16 0, i16 1023}
!947 = !DILocation(line: 708, scope: !948, inlinedAt: !949)
!948 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !13, file: !13, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!949 = !DILocation(line: 784, scope: !950, inlinedAt: !951)
!950 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !13, file: !13, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!951 = !DILocation(line: 7, scope: !952, inlinedAt: !954)
!952 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !953, file: !953, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!953 = !DIFile(filename: "number.jl", directory: ".")
!954 = !DILocation(line: 525, scope: !955, inlinedAt: !956)
!955 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!956 = !DILocation(line: 1040, scope: !957, inlinedAt: !923)
!957 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!958 = !DILocation(line: 88, scope: !957, inlinedAt: !959)
!959 = !DILocation(line: 1042, scope: !957, inlinedAt: !923)
!960 = !DILocation(line: 708, scope: !948, inlinedAt: !961)
!961 = !DILocation(line: 784, scope: !950, inlinedAt: !962)
!962 = !DILocation(line: 7, scope: !952, inlinedAt: !963)
!963 = !DILocation(line: 525, scope: !955, inlinedAt: !964)
!964 = !DILocation(line: 1040, scope: !925, inlinedAt: !923)
!965 = !DILocation(line: 87, scope: !925, inlinedAt: !966)
!966 = !DILocation(line: 1042, scope: !925, inlinedAt: !923)
!967 = !DILocation(line: 575, scope: !968, inlinedAt: !969)
!968 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !173, file: !173, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!969 = !DILocation(line: 510, scope: !970, inlinedAt: !971)
!970 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!971 = !DILocation(line: 444, scope: !972, inlinedAt: !974)
!972 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !973, file: !973, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!973 = !DIFile(filename: "range.jl", directory: ".")
!974 = !DILocation(line: 457, scope: !972, inlinedAt: !975)
!975 = !DILocation(line: 459, scope: !976, inlinedAt: !977)
!976 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !973, file: !973, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!977 = !DILocation(line: 273, scope: !978, inlinedAt: !980)
!978 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !979, file: !979, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!979 = !DIFile(filename: "tuple.jl", directory: ".")
!980 = !DILocation(line: 98, scope: !981, inlinedAt: !983)
!981 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !982, file: !982, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!982 = !DIFile(filename: "abstractarray.jl", directory: ".")
!983 = !DILocation(line: 133, scope: !984, inlinedAt: !985)
!984 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !982, file: !982, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!985 = !DILocation(line: 382, scope: !986, inlinedAt: !987)
!986 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !982, file: !982, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!987 = !DILocation(line: 694, scope: !988, inlinedAt: !989)
!988 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !982, file: !982, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!989 = !DILocation(line: 709, scope: !988, inlinedAt: !990)
!990 = !DILocation(line: 87, scope: !991, inlinedAt: !993)
!991 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !992, file: !992, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!992 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!993 = !DILocation(line: 368, scope: !900)
!994 = !DILocation(line: 488, scope: !995, inlinedAt: !996)
!995 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!996 = !DILocation(line: 768, scope: !997, inlinedAt: !987)
!997 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !982, file: !982, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!998 = !DILocation(line: 40, scope: !914, inlinedAt: !999)
!999 = !DILocation(line: 9, scope: !1000, inlinedAt: !1001)
!1000 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1001 = !DILocation(line: 9, scope: !1002, inlinedAt: !1003)
!1002 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1003 = !DILocation(line: 85, scope: !1004, inlinedAt: !1005)
!1004 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1005 = !DILocation(line: 89, scope: !991, inlinedAt: !993)
!1006 = !DILocation(line: 86, scope: !936, inlinedAt: !998)
!1007 = !DILocation(line: 523, scope: !955, inlinedAt: !1008)
!1008 = !DILocation(line: 1040, scope: !925, inlinedAt: !993)
!1009 = !DILocation(line: 87, scope: !925, inlinedAt: !1010)
!1010 = !DILocation(line: 1042, scope: !925, inlinedAt: !993)
!1011 = !DILocation(line: 783, scope: !1012, inlinedAt: !1013)
!1012 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !13, file: !13, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1013 = !DILocation(line: 7, scope: !952, inlinedAt: !1014)
!1014 = !DILocation(line: 88, scope: !1015, inlinedAt: !1016)
!1015 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1016 = !DILocation(line: 95, scope: !1017, inlinedAt: !993)
!1017 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !992, file: !992, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1018 = !DILocation(line: 40, scope: !914, inlinedAt: !1019)
!1019 = !DILocation(line: 46, scope: !1000, inlinedAt: !1020)
!1020 = !DILocation(line: 46, scope: !1021, inlinedAt: !1014)
!1021 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !77)
!1022 = !DILocation(line: 369, scope: !900)
!1023 = distinct !DISubprogram(name: "checked_trunc_sint", linkageName: "julia_checked_trunc_sint_2792", scope: null, file: !13, line: 652, type: !1024, scopeLine: 652, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !1031)
!1024 = !DISubroutineType(types: !1025)
!1025 = !{!132, !1026, !1027, !80}
!1026 = !DICompositeType(tag: DW_TAG_structure_type, name: "#checked_trunc_sint", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140431516274752")
!1027 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1028, size: 64, align: 64)
!1028 = !DICompositeType(tag: DW_TAG_structure_type, name: "jl_value_t", file: !1029, line: 71, align: 64, elements: !1030)
!1029 = !DIFile(filename: "julia.h", directory: "")
!1030 = !{!1027}
!1031 = !{!1032, !1033}
!1032 = !DILocalVariable(name: "#self#", arg: 1, scope: !1023, file: !13, line: 652, type: !1026)
!1033 = !DILocalVariable(name: "x", arg: 3, scope: !1023, file: !13, line: 652, type: !80)
!1034 = !DILocation(line: 0, scope: !1023)
!1035 = !DILocation(line: 656, scope: !1023)
!1036 = !DILocation(line: 654, scope: !1023)
!1037 = !DILocation(line: 657, scope: !1023)
!1038 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2324", scope: null, file: !7, type: !1039, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !1045)
!1039 = !DISubroutineType(types: !1040)
!1040 = !{!76, !1041, !1042, !1043}
!1041 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_trigger_and_return!", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428924587424")
!1042 = !DICompositeType(tag: DW_TAG_structure_type, name: "Val", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140424296109840")
!1043 = !DICompositeType(tag: DW_TAG_structure_type, name: "HostCall", size: 192, align: 64, elements: !1044, runtimeLang: DW_LANG_Julia, identifier: "140428927658912")
!1044 = !{!79, !908, !79}
!1045 = !{!1046, !1047}
!1046 = !DILocalVariable(name: "#self#", arg: 1, scope: !1038, file: !7, type: !1041)
!1047 = !DILocalVariable(name: "hc", arg: 3, scope: !1038, file: !7, type: !1043)
!1048 = !DILocation(line: 0, scope: !1038)
!1049 = !DILocation(line: 40, scope: !1050, inlinedAt: !1051)
!1050 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1051 = !DILocation(line: 3, scope: !1052, inlinedAt: !1053)
!1052 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1053 = !DILocation(line: 3, scope: !1054, inlinedAt: !1055)
!1054 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1055 = !DILocation(line: 89, scope: !1056, inlinedAt: !1057)
!1056 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1057 = !DILocation(line: 124, scope: !1058, inlinedAt: !1059)
!1058 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1059 = !DILocation(line: 92, scope: !1060, inlinedAt: !1061)
!1060 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1061 = !DILocation(line: 0, scope: !1062, inlinedAt: !1048)
!1062 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1063 = !DILocation(line: 499, scope: !1064, inlinedAt: !1065)
!1064 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1065 = !DILocation(line: 449, scope: !1064, inlinedAt: !1066)
!1066 = !DILocation(line: 492, scope: !1067, inlinedAt: !1068)
!1067 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1068 = !DILocation(line: 269, scope: !1069, inlinedAt: !1059)
!1069 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !229, file: !229, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1070 = !DILocation(line: 37, scope: !1071, inlinedAt: !1072)
!1071 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !377, file: !377, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1072 = !DILocation(line: 174, scope: !1060, inlinedAt: !1061)
!1073 = !{!1074, !1074, i64 0}
!1074 = !{!"jtbaa_const", !116, i64 0}
!1075 = !{!125}
!1076 = !{!122, !123, !119, !124}
!1077 = !DILocation(line: 176, scope: !1060, inlinedAt: !1061)
!1078 = !DILocation(line: 19, scope: !1079, inlinedAt: !1080)
!1079 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1080 = !DILocation(line: 19, scope: !1079, inlinedAt: !1081)
!1081 = !DILocation(line: 188, scope: !1060, inlinedAt: !1061)
!1082 = !DILocation(line: 6, scope: !1083, inlinedAt: !1084)
!1083 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !249, file: !249, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !77)
!1084 = !DILocation(line: 109, scope: !1060, inlinedAt: !1061)
!1085 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2561", scope: null, file: !5, line: 32, type: !1086, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !1089)
!1086 = !DISubroutineType(types: !1087)
!1087 = !{!76, !1088, !79, !80, !80}
!1088 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_signal_wait_cas!", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927475520")
!1089 = !{!1090, !1091, !1092, !1093}
!1090 = !DILocalVariable(name: "#self#", arg: 1, scope: !1085, file: !5, line: 32, type: !1088)
!1091 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !1085, file: !5, line: 32, type: !79)
!1092 = !DILocalVariable(name: "expected", arg: 3, scope: !1085, file: !5, line: 32, type: !80)
!1093 = !DILocalVariable(name: "value", arg: 4, scope: !1085, file: !5, line: 32, type: !80)
!1094 = !DILocation(line: 0, scope: !1085)
!1095 = !DILocation(line: 27, scope: !1096, inlinedAt: !1097)
!1096 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1097 = !DILocation(line: 37, scope: !1098, inlinedAt: !1099)
!1098 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1099 = !DILocation(line: 36, scope: !1085)
!1100 = !DILocation(line: 499, scope: !1101, inlinedAt: !1102)
!1101 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1102 = !DILocation(line: 38, scope: !1098, inlinedAt: !1099)
!1103 = !DILocation(line: 40, scope: !1098, inlinedAt: !1099)
!1104 = !DILocation(line: 40, scope: !1105, inlinedAt: !1106)
!1105 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1106 = !DILocation(line: 0, scope: !1107, inlinedAt: !1108)
!1107 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1108 = !DILocation(line: 0, scope: !1109, inlinedAt: !1110)
!1109 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1110 = !DILocation(line: 11, scope: !1111, inlinedAt: !1112)
!1111 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1112 = !DILocation(line: 31, scope: !1113, inlinedAt: !1114)
!1113 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1114 = !DILocation(line: 41, scope: !1098, inlinedAt: !1099)
!1115 = !DILocation(line: 126, scope: !1116, inlinedAt: !1117)
!1116 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1117 = !DILocation(line: 126, scope: !1116, inlinedAt: !1118)
!1118 = !DILocation(line: 33, scope: !1113, inlinedAt: !1114)
!1119 = !DILocation(line: 108, scope: !1120, inlinedAt: !1121)
!1120 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !77)
!1121 = !DILocation(line: 46, scope: !1098, inlinedAt: !1099)
!1122 = !DILocation(line: 47, scope: !1098, inlinedAt: !1099)
!1123 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2551", scope: null, file: !7, type: !1039, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !1124)
!1124 = !{!1125, !1126}
!1125 = !DILocalVariable(name: "#self#", arg: 1, scope: !1123, file: !7, type: !1041)
!1126 = !DILocalVariable(name: "hc", arg: 3, scope: !1123, file: !7, type: !1043)
!1127 = !DILocation(line: 0, scope: !1123)
!1128 = !DILocation(line: 40, scope: !1129, inlinedAt: !1130)
!1129 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1130 = !DILocation(line: 3, scope: !1131, inlinedAt: !1132)
!1131 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1132 = !DILocation(line: 3, scope: !1133, inlinedAt: !1134)
!1133 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1134 = !DILocation(line: 89, scope: !1135, inlinedAt: !1136)
!1135 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1136 = !DILocation(line: 124, scope: !1137, inlinedAt: !1138)
!1137 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1138 = !DILocation(line: 92, scope: !1139, inlinedAt: !1140)
!1139 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1140 = !DILocation(line: 0, scope: !1141, inlinedAt: !1127)
!1141 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1142 = !DILocation(line: 499, scope: !1143, inlinedAt: !1144)
!1143 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1144 = !DILocation(line: 449, scope: !1143, inlinedAt: !1145)
!1145 = !DILocation(line: 492, scope: !1146, inlinedAt: !1147)
!1146 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1147 = !DILocation(line: 269, scope: !1148, inlinedAt: !1138)
!1148 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !229, file: !229, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1149 = !DILocation(line: 37, scope: !1150, inlinedAt: !1151)
!1150 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !377, file: !377, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1151 = !DILocation(line: 174, scope: !1139, inlinedAt: !1140)
!1152 = !DILocation(line: 176, scope: !1139, inlinedAt: !1140)
!1153 = !DILocation(line: 19, scope: !1154, inlinedAt: !1155)
!1154 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1155 = !DILocation(line: 19, scope: !1154, inlinedAt: !1156)
!1156 = !DILocation(line: 188, scope: !1139, inlinedAt: !1140)
!1157 = !DILocation(line: 6, scope: !1158, inlinedAt: !1159)
!1158 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !249, file: !249, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !77)
!1159 = !DILocation(line: 109, scope: !1139, inlinedAt: !1140)
!1160 = distinct !DISubprogram(name: "report_exception_name", linkageName: "julia_report_exception_name_2256", scope: null, file: !28, line: 78, type: !1161, scopeLine: 78, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !1164)
!1161 = !DISubroutineType(types: !1162)
!1162 = !{!76, !1163, !163}
!1163 = !DICompositeType(tag: DW_TAG_structure_type, name: "#report_exception_name", align: 8, elements: !77, runtimeLang: DW_LANG_Julia, identifier: "140428927647184")
!1164 = !{!1165, !1166}
!1165 = !DILocalVariable(name: "#self#", arg: 1, scope: !1160, file: !28, line: 78, type: !1163)
!1166 = !DILocalVariable(name: "ex", arg: 2, scope: !1160, file: !28, line: 78, type: !163)
!1167 = !DILocation(line: 0, scope: !1160)
!1168 = !DILocation(line: 513, scope: !1169, inlinedAt: !1170)
!1169 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !173, file: !173, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1170 = !DILocation(line: 46, scope: !1171, inlinedAt: !1172)
!1171 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1172 = !DILocation(line: 79, scope: !1160)
!1173 = !DILocation(line: 40, scope: !1174, inlinedAt: !1175)
!1174 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1175 = !DILocation(line: 3, scope: !1176, inlinedAt: !1177)
!1176 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !181, file: !181, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1177 = !DILocation(line: 3, scope: !1178, inlinedAt: !1179)
!1178 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !181, file: !181, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1179 = !DILocation(line: 47, scope: !1171, inlinedAt: !1172)
!1180 = !DILocation(line: 40, scope: !1174, inlinedAt: !1181)
!1181 = !DILocation(line: 0, scope: !1182, inlinedAt: !1183)
!1182 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1183 = !DILocation(line: 0, scope: !1184, inlinedAt: !1185)
!1184 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1185 = !DILocation(line: 23, scope: !1186, inlinedAt: !1187)
!1186 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1187 = !DILocation(line: 4, scope: !1188, inlinedAt: !1189)
!1188 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1189 = !DILocation(line: 50, scope: !1171, inlinedAt: !1172)
!1190 = !DILocation(line: 111, scope: !1191, inlinedAt: !1192)
!1191 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1192 = !DILocation(line: 111, scope: !1191, inlinedAt: !1187)
!1193 = !DILocation(line: 40, scope: !1174, inlinedAt: !1194)
!1194 = !DILocation(line: 3, scope: !1195, inlinedAt: !1196)
!1195 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1196 = !DILocation(line: 3, scope: !1197, inlinedAt: !1198)
!1197 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1198 = !DILocation(line: 89, scope: !1199, inlinedAt: !1200)
!1199 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1200 = !DILocation(line: 124, scope: !1201, inlinedAt: !1202)
!1201 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !204, file: !204, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1202 = !DILocation(line: 92, scope: !1203, inlinedAt: !1204)
!1203 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1204 = !DILocation(line: 0, scope: !1182, inlinedAt: !1205)
!1205 = !DILocation(line: 0, scope: !1206, inlinedAt: !1207)
!1206 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1207 = !DILocation(line: 71, scope: !1208, inlinedAt: !1209)
!1208 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1209 = !DILocation(line: 65, scope: !1208, inlinedAt: !1210)
!1210 = !DILocation(line: 5, scope: !1188, inlinedAt: !1189)
!1211 = !DILocation(line: 499, scope: !1212, inlinedAt: !1213)
!1212 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1213 = !DILocation(line: 449, scope: !1212, inlinedAt: !1214)
!1214 = !DILocation(line: 492, scope: !1215, inlinedAt: !1216)
!1215 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !226, file: !226, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1216 = !DILocation(line: 269, scope: !1217, inlinedAt: !1202)
!1217 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !229, file: !229, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1218 = !DILocation(line: 38, scope: !1219, inlinedAt: !1220)
!1219 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1220 = !DILocation(line: 36, scope: !1219, inlinedAt: !1221)
!1221 = !DILocation(line: 124, scope: !1203, inlinedAt: !1204)
!1222 = !DILocation(line: 27, scope: !1223, inlinedAt: !1224)
!1223 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1224 = !DILocation(line: 37, scope: !1219, inlinedAt: !1220)
!1225 = !DILocation(line: 126, scope: !1226, inlinedAt: !1227)
!1226 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1227 = !DILocation(line: 126, scope: !1226, inlinedAt: !1228)
!1228 = !DILocation(line: 33, scope: !1229, inlinedAt: !1230)
!1229 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1230 = !DILocation(line: 41, scope: !1219, inlinedAt: !1220)
!1231 = !DILocation(line: 108, scope: !1232, inlinedAt: !1233)
!1232 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1233 = !DILocation(line: 46, scope: !1219, inlinedAt: !1220)
!1234 = !DILocation(line: 47, scope: !1219, inlinedAt: !1220)
!1235 = !DILocation(line: 6, scope: !1236, inlinedAt: !1237)
!1236 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !249, file: !249, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1237 = !DILocation(line: 109, scope: !1203, inlinedAt: !1204)
!1238 = !DILocation(line: 92, scope: !1203, inlinedAt: !1239)
!1239 = !DILocation(line: 0, scope: !1182, inlinedAt: !1240)
!1240 = !DILocation(line: 0, scope: !1241, inlinedAt: !1242)
!1241 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1242 = !DILocation(line: 72, scope: !1208, inlinedAt: !1209)
!1243 = !DILocation(line: 40, scope: !1174, inlinedAt: !1244)
!1244 = !DILocation(line: 46, scope: !1245, inlinedAt: !1246)
!1245 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1246 = !DILocation(line: 46, scope: !1247, inlinedAt: !1248)
!1247 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1248 = !DILocation(line: 88, scope: !1249, inlinedAt: !1250)
!1249 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1250 = !DILocation(line: 88, scope: !1249, inlinedAt: !1251)
!1251 = !DILocation(line: 88, scope: !1249, inlinedAt: !1252)
!1252 = !DILocation(line: 152, scope: !1203, inlinedAt: !1239)
!1253 = !DILocation(line: 6, scope: !1236, inlinedAt: !1254)
!1254 = !DILocation(line: 109, scope: !1203, inlinedAt: !1239)
!1255 = !DILocation(line: 92, scope: !1203, inlinedAt: !1256)
!1256 = !DILocation(line: 0, scope: !1182, inlinedAt: !1257)
!1257 = !DILocation(line: 0, scope: !1258, inlinedAt: !1259)
!1258 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1259 = !DILocation(line: 73, scope: !1208, inlinedAt: !1209)
!1260 = !DILocation(line: 38, scope: !1219, inlinedAt: !1261)
!1261 = !DILocation(line: 36, scope: !1219, inlinedAt: !1262)
!1262 = !DILocation(line: 174, scope: !1203, inlinedAt: !1256)
!1263 = !DILocation(line: 27, scope: !1223, inlinedAt: !1264)
!1264 = !DILocation(line: 37, scope: !1219, inlinedAt: !1261)
!1265 = !DILocation(line: 126, scope: !1226, inlinedAt: !1266)
!1266 = !DILocation(line: 126, scope: !1226, inlinedAt: !1267)
!1267 = !DILocation(line: 33, scope: !1229, inlinedAt: !1268)
!1268 = !DILocation(line: 41, scope: !1219, inlinedAt: !1261)
!1269 = !DILocation(line: 108, scope: !1232, inlinedAt: !1270)
!1270 = !DILocation(line: 46, scope: !1219, inlinedAt: !1261)
!1271 = !DILocation(line: 47, scope: !1219, inlinedAt: !1261)
!1272 = !DILocation(line: 12, scope: !1273, inlinedAt: !1274)
!1273 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1274 = !DILocation(line: 61, scope: !1275, inlinedAt: !1276)
!1275 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1276 = !DILocation(line: 60, scope: !1275, inlinedAt: !1277)
!1277 = !DILocation(line: 176, scope: !1203, inlinedAt: !1256)
!1278 = !DILocation(line: 62, scope: !1275, inlinedAt: !1276)
!1279 = !DILocation(line: 126, scope: !1226, inlinedAt: !1280)
!1280 = !DILocation(line: 126, scope: !1226, inlinedAt: !1281)
!1281 = !DILocation(line: 33, scope: !1229, inlinedAt: !1282)
!1282 = !DILocation(line: 65, scope: !1275, inlinedAt: !1276)
!1283 = !DILocation(line: 108, scope: !1232, inlinedAt: !1284)
!1284 = !DILocation(line: 70, scope: !1275, inlinedAt: !1276)
!1285 = !DILocation(line: 71, scope: !1275, inlinedAt: !1276)
!1286 = !DILocation(line: 40, scope: !1174, inlinedAt: !1287)
!1287 = !DILocation(line: 9, scope: !1245, inlinedAt: !1288)
!1288 = !DILocation(line: 9, scope: !1289, inlinedAt: !1290)
!1289 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1290 = !DILocation(line: 85, scope: !1291, inlinedAt: !1292)
!1291 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1292 = !DILocation(line: 85, scope: !1291, inlinedAt: !1293)
!1293 = !DILocation(line: 85, scope: !1291, inlinedAt: !1294)
!1294 = !DILocation(line: 180, scope: !1203, inlinedAt: !1256)
!1295 = !DILocation(line: 499, scope: !1212, inlinedAt: !1296)
!1296 = !DILocation(line: 492, scope: !1215, inlinedAt: !1297)
!1297 = !DILocation(line: 181, scope: !1203, inlinedAt: !1256)
!1298 = !DILocation(line: 19, scope: !1299, inlinedAt: !1300)
!1299 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1300 = !DILocation(line: 19, scope: !1299, inlinedAt: !1301)
!1301 = !DILocation(line: 182, scope: !1203, inlinedAt: !1256)
!1302 = !DILocation(line: 126, scope: !1226, inlinedAt: !1303)
!1303 = !DILocation(line: 126, scope: !1226, inlinedAt: !1304)
!1304 = !DILocation(line: 33, scope: !1229, inlinedAt: !1305)
!1305 = !DILocation(line: 183, scope: !1203, inlinedAt: !1256)
!1306 = !DILocation(line: 1, scope: !1307, inlinedAt: !1308)
!1307 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !325, file: !325, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1308 = !DILocation(line: 184, scope: !1203, inlinedAt: !1256)
!1309 = !DILocation(line: 40, scope: !1174, inlinedAt: !1310)
!1310 = !DILocation(line: 9, scope: !1245, inlinedAt: !1311)
!1311 = !DILocation(line: 9, scope: !1289, inlinedAt: !1312)
!1312 = !DILocation(line: 85, scope: !1291, inlinedAt: !1313)
!1313 = !DILocation(line: 85, scope: !1291, inlinedAt: !1314)
!1314 = !DILocation(line: 85, scope: !1291, inlinedAt: !1315)
!1315 = !DILocation(line: 186, scope: !1203, inlinedAt: !1256)
!1316 = !DILocation(line: 40, scope: !1174, inlinedAt: !1317)
!1317 = !DILocation(line: 46, scope: !1245, inlinedAt: !1318)
!1318 = !DILocation(line: 46, scope: !1247, inlinedAt: !1319)
!1319 = !DILocation(line: 88, scope: !1249, inlinedAt: !1320)
!1320 = !DILocation(line: 88, scope: !1249, inlinedAt: !1321)
!1321 = !DILocation(line: 88, scope: !1249, inlinedAt: !1315)
!1322 = !DILocation(line: 19, scope: !1299, inlinedAt: !1323)
!1323 = !DILocation(line: 19, scope: !1299, inlinedAt: !1324)
!1324 = !DILocation(line: 188, scope: !1203, inlinedAt: !1256)
!1325 = !DILocation(line: 6, scope: !1236, inlinedAt: !1326)
!1326 = !DILocation(line: 109, scope: !1203, inlinedAt: !1256)
!1327 = !DILocation(line: 40, scope: !1174, inlinedAt: !1328)
!1328 = !DILocation(line: 9, scope: !1245, inlinedAt: !1329)
!1329 = !DILocation(line: 9, scope: !1289, inlinedAt: !1330)
!1330 = !DILocation(line: 85, scope: !1291, inlinedAt: !1331)
!1331 = !DILocation(line: 85, scope: !1291, inlinedAt: !1332)
!1332 = !DILocation(line: 85, scope: !1291, inlinedAt: !1333)
!1333 = !DILocation(line: 191, scope: !1203, inlinedAt: !1256)
!1334 = !DILocation(line: 513, scope: !1169, inlinedAt: !1189)
!1335 = !DILocation(line: 499, scope: !1212, inlinedAt: !1336)
!1336 = !DILocation(line: 492, scope: !1215, inlinedAt: !1337)
!1337 = !DILocation(line: 52, scope: !1171, inlinedAt: !1172)
!1338 = !DILocation(line: 40, scope: !1174, inlinedAt: !1339)
!1339 = !DILocation(line: 0, scope: !1182, inlinedAt: !1340)
!1340 = !DILocation(line: 0, scope: !1184, inlinedAt: !1341)
!1341 = !DILocation(line: 15, scope: !1342, inlinedAt: !1343)
!1342 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1343 = !DILocation(line: 69, scope: !1344, inlinedAt: !1345)
!1344 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1345 = !DILocation(line: 53, scope: !1171, inlinedAt: !1172)
!1346 = !DILocation(line: 111, scope: !1191, inlinedAt: !1347)
!1347 = !DILocation(line: 111, scope: !1191, inlinedAt: !1348)
!1348 = !DILocation(line: 70, scope: !1344, inlinedAt: !1345)
!1349 = !DILocation(line: 92, scope: !1203, inlinedAt: !1350)
!1350 = !DILocation(line: 0, scope: !1182, inlinedAt: !1351)
!1351 = !DILocation(line: 0, scope: !1206, inlinedAt: !1352)
!1352 = !DILocation(line: 115, scope: !1353, inlinedAt: !1348)
!1353 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1354 = !DILocation(line: 37, scope: !1355, inlinedAt: !1356)
!1355 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !377, file: !377, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1356 = !DILocation(line: 124, scope: !1203, inlinedAt: !1350)
!1357 = !DILocation(line: 27, scope: !1223, inlinedAt: !1358)
!1358 = !DILocation(line: 37, scope: !1219, inlinedAt: !1359)
!1359 = !DILocation(line: 36, scope: !1219, inlinedAt: !1356)
!1360 = !DILocation(line: 38, scope: !1219, inlinedAt: !1359)
!1361 = !DILocation(line: 126, scope: !1226, inlinedAt: !1362)
!1362 = !DILocation(line: 126, scope: !1226, inlinedAt: !1363)
!1363 = !DILocation(line: 33, scope: !1229, inlinedAt: !1364)
!1364 = !DILocation(line: 41, scope: !1219, inlinedAt: !1359)
!1365 = !DILocation(line: 108, scope: !1232, inlinedAt: !1366)
!1366 = !DILocation(line: 46, scope: !1219, inlinedAt: !1359)
!1367 = !DILocation(line: 47, scope: !1219, inlinedAt: !1359)
!1368 = !DILocation(line: 6, scope: !1236, inlinedAt: !1369)
!1369 = !DILocation(line: 109, scope: !1203, inlinedAt: !1350)
!1370 = !DILocation(line: 37, scope: !1355, inlinedAt: !1348)
!1371 = !DILocation(line: 513, scope: !1169, inlinedAt: !1372)
!1372 = !DILocation(line: 100, scope: !1373, inlinedAt: !1374)
!1373 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1374 = !DILocation(line: 114, scope: !1375, inlinedAt: !1348)
!1375 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !259, file: !259, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1376 = !DILocation(line: 40, scope: !1174, inlinedAt: !1377)
!1377 = !DILocation(line: 0, scope: !1182, inlinedAt: !1378)
!1378 = !DILocation(line: 0, scope: !1379, inlinedAt: !1348)
!1379 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1380 = !DILocation(line: 40, scope: !1174, inlinedAt: !1381)
!1381 = !DILocation(line: 46, scope: !1245, inlinedAt: !1382)
!1382 = !DILocation(line: 46, scope: !1247, inlinedAt: !1383)
!1383 = !DILocation(line: 88, scope: !1249, inlinedAt: !1384)
!1384 = !DILocation(line: 88, scope: !1249, inlinedAt: !1348)
!1385 = !DILocation(line: 158, scope: !1386, inlinedAt: !1348)
!1386 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1387 = !DILocation(line: 168, scope: !1203, inlinedAt: !1256)
!1388 = !DILocation(line: 40, scope: !1174, inlinedAt: !1389)
!1389 = !DILocation(line: 0, scope: !1182, inlinedAt: !1390)
!1390 = !DILocation(line: 0, scope: !1379, inlinedAt: !1391)
!1391 = !DILocation(line: 57, scope: !1171, inlinedAt: !1172)
!1392 = !DILocation(line: 114, scope: !1375, inlinedAt: !1393)
!1393 = !DILocation(line: 59, scope: !1171, inlinedAt: !1172)
!1394 = !DILocation(line: 40, scope: !1174, inlinedAt: !1395)
!1395 = !DILocation(line: 46, scope: !1245, inlinedAt: !1396)
!1396 = !DILocation(line: 46, scope: !1247, inlinedAt: !1397)
!1397 = !DILocation(line: 88, scope: !1249, inlinedAt: !1398)
!1398 = !DILocation(line: 88, scope: !1249, inlinedAt: !1399)
!1399 = !DILocation(line: 88, scope: !1249, inlinedAt: !1393)
!1400 = !DILocation(line: 40, scope: !1174, inlinedAt: !1401)
!1401 = !DILocation(line: 0, scope: !1182, inlinedAt: !1402)
!1402 = !DILocation(line: 0, scope: !1184, inlinedAt: !1403)
!1403 = !DILocation(line: 19, scope: !1404, inlinedAt: !1405)
!1404 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1405 = !DILocation(line: 187, scope: !1344, inlinedAt: !1406)
!1406 = !DILocation(line: 80, scope: !1160)
!1407 = !DILocation(line: 111, scope: !1191, inlinedAt: !1408)
!1408 = !DILocation(line: 111, scope: !1191, inlinedAt: !1405)
!1409 = !DILocation(line: 92, scope: !1203, inlinedAt: !1410)
!1410 = !DILocation(line: 0, scope: !1182, inlinedAt: !1411)
!1411 = !DILocation(line: 0, scope: !1206, inlinedAt: !1412)
!1412 = !DILocation(line: 115, scope: !1353, inlinedAt: !1413)
!1413 = !DILocation(line: 193, scope: !1344, inlinedAt: !1406)
!1414 = !DILocation(line: 38, scope: !1219, inlinedAt: !1415)
!1415 = !DILocation(line: 36, scope: !1219, inlinedAt: !1416)
!1416 = !DILocation(line: 124, scope: !1203, inlinedAt: !1410)
!1417 = !DILocation(line: 27, scope: !1223, inlinedAt: !1418)
!1418 = !DILocation(line: 37, scope: !1219, inlinedAt: !1415)
!1419 = !DILocation(line: 126, scope: !1226, inlinedAt: !1420)
!1420 = !DILocation(line: 126, scope: !1226, inlinedAt: !1421)
!1421 = !DILocation(line: 33, scope: !1229, inlinedAt: !1422)
!1422 = !DILocation(line: 41, scope: !1219, inlinedAt: !1415)
!1423 = !DILocation(line: 108, scope: !1232, inlinedAt: !1424)
!1424 = !DILocation(line: 46, scope: !1219, inlinedAt: !1415)
!1425 = !DILocation(line: 47, scope: !1219, inlinedAt: !1415)
!1426 = !DILocation(line: 6, scope: !1236, inlinedAt: !1427)
!1427 = !DILocation(line: 109, scope: !1203, inlinedAt: !1410)
!1428 = !DILocation(line: 40, scope: !1174, inlinedAt: !1429)
!1429 = !DILocation(line: 46, scope: !1245, inlinedAt: !1430)
!1430 = !DILocation(line: 46, scope: !1247, inlinedAt: !1431)
!1431 = !DILocation(line: 88, scope: !1249, inlinedAt: !1432)
!1432 = !DILocation(line: 88, scope: !1249, inlinedAt: !1433)
!1433 = !DILocation(line: 88, scope: !1249, inlinedAt: !1434)
!1434 = !DILocation(line: 195, scope: !1344, inlinedAt: !1406)
!1435 = !DILocation(line: 114, scope: !1375, inlinedAt: !1436)
!1436 = !DILocation(line: 196, scope: !1344, inlinedAt: !1406)
!1437 = !DILocation(line: 40, scope: !1174, inlinedAt: !1438)
!1438 = !DILocation(line: 46, scope: !1245, inlinedAt: !1439)
!1439 = !DILocation(line: 46, scope: !1247, inlinedAt: !1440)
!1440 = !DILocation(line: 88, scope: !1249, inlinedAt: !1441)
!1441 = !DILocation(line: 88, scope: !1249, inlinedAt: !1442)
!1442 = !DILocation(line: 88, scope: !1249, inlinedAt: !1443)
!1443 = !DILocation(line: 153, scope: !1444, inlinedAt: !1445)
!1444 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1445 = !DILocation(line: 198, scope: !1344, inlinedAt: !1406)
!1446 = !DILocation(line: 114, scope: !1375, inlinedAt: !1447)
!1447 = !DILocation(line: 154, scope: !1444, inlinedAt: !1445)
!1448 = !DILocation(line: 40, scope: !1174, inlinedAt: !1449)
!1449 = !DILocation(line: 46, scope: !1245, inlinedAt: !1450)
!1450 = !DILocation(line: 46, scope: !1247, inlinedAt: !1451)
!1451 = !DILocation(line: 88, scope: !1249, inlinedAt: !1452)
!1452 = !DILocation(line: 88, scope: !1249, inlinedAt: !1453)
!1453 = !DILocation(line: 88, scope: !1249, inlinedAt: !1454)
!1454 = !DILocation(line: 155, scope: !1444, inlinedAt: !1445)
!1455 = !DILocation(line: 92, scope: !1203, inlinedAt: !1456)
!1456 = !DILocation(line: 201, scope: !1344, inlinedAt: !1406)
!1457 = !DILocation(line: 114, scope: !1375, inlinedAt: !1458)
!1458 = !DILocation(line: 156, scope: !1444, inlinedAt: !1445)
!1459 = !DILocation(line: 40, scope: !1174, inlinedAt: !1460)
!1460 = !DILocation(line: 46, scope: !1245, inlinedAt: !1461)
!1461 = !DILocation(line: 46, scope: !1247, inlinedAt: !1462)
!1462 = !DILocation(line: 88, scope: !1249, inlinedAt: !1463)
!1463 = !DILocation(line: 88, scope: !1249, inlinedAt: !1464)
!1464 = !DILocation(line: 88, scope: !1249, inlinedAt: !1465)
!1465 = !DILocation(line: 166, scope: !1466, inlinedAt: !1467)
!1466 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !365, file: !365, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1467 = !DILocation(line: 107, scope: !1203, inlinedAt: !1456)
!1468 = !DILocation(line: 114, scope: !1375, inlinedAt: !1469)
!1469 = !DILocation(line: 167, scope: !1466, inlinedAt: !1467)
!1470 = !DILocation(line: 40, scope: !1174, inlinedAt: !1471)
!1471 = !DILocation(line: 46, scope: !1245, inlinedAt: !1472)
!1472 = !DILocation(line: 46, scope: !1247, inlinedAt: !1473)
!1473 = !DILocation(line: 88, scope: !1249, inlinedAt: !1474)
!1474 = !DILocation(line: 88, scope: !1249, inlinedAt: !1475)
!1475 = !DILocation(line: 88, scope: !1249, inlinedAt: !1476)
!1476 = !DILocation(line: 169, scope: !1466, inlinedAt: !1467)
!1477 = !DILocation(line: 114, scope: !1375, inlinedAt: !1478)
!1478 = !DILocation(line: 170, scope: !1466, inlinedAt: !1467)
!1479 = !DILocation(line: 40, scope: !1174, inlinedAt: !1480)
!1480 = !DILocation(line: 46, scope: !1245, inlinedAt: !1481)
!1481 = !DILocation(line: 46, scope: !1247, inlinedAt: !1482)
!1482 = !DILocation(line: 88, scope: !1249, inlinedAt: !1483)
!1483 = !DILocation(line: 88, scope: !1249, inlinedAt: !1484)
!1484 = !DILocation(line: 88, scope: !1249, inlinedAt: !1467)
!1485 = !DILocation(line: 6, scope: !1236, inlinedAt: !1486)
!1486 = !DILocation(line: 109, scope: !1203, inlinedAt: !1456)
!1487 = !DILocation(line: 92, scope: !1203, inlinedAt: !1488)
!1488 = !DILocation(line: 0, scope: !1182, inlinedAt: !1489)
!1489 = !DILocation(line: 0, scope: !1258, inlinedAt: !1490)
!1490 = !DILocation(line: 158, scope: !1386, inlinedAt: !1456)
!1491 = !DILocation(line: 38, scope: !1219, inlinedAt: !1492)
!1492 = !DILocation(line: 36, scope: !1219, inlinedAt: !1493)
!1493 = !DILocation(line: 174, scope: !1203, inlinedAt: !1488)
!1494 = !DILocation(line: 27, scope: !1223, inlinedAt: !1495)
!1495 = !DILocation(line: 37, scope: !1219, inlinedAt: !1492)
!1496 = !DILocation(line: 126, scope: !1226, inlinedAt: !1497)
!1497 = !DILocation(line: 126, scope: !1226, inlinedAt: !1498)
!1498 = !DILocation(line: 33, scope: !1229, inlinedAt: !1499)
!1499 = !DILocation(line: 41, scope: !1219, inlinedAt: !1492)
!1500 = !DILocation(line: 108, scope: !1232, inlinedAt: !1501)
!1501 = !DILocation(line: 46, scope: !1219, inlinedAt: !1492)
!1502 = !DILocation(line: 47, scope: !1219, inlinedAt: !1492)
!1503 = !DILocation(line: 12, scope: !1273, inlinedAt: !1504)
!1504 = !DILocation(line: 61, scope: !1275, inlinedAt: !1505)
!1505 = !DILocation(line: 60, scope: !1275, inlinedAt: !1506)
!1506 = !DILocation(line: 176, scope: !1203, inlinedAt: !1488)
!1507 = !DILocation(line: 62, scope: !1275, inlinedAt: !1505)
!1508 = !DILocation(line: 126, scope: !1226, inlinedAt: !1509)
!1509 = !DILocation(line: 126, scope: !1226, inlinedAt: !1510)
!1510 = !DILocation(line: 33, scope: !1229, inlinedAt: !1511)
!1511 = !DILocation(line: 65, scope: !1275, inlinedAt: !1505)
!1512 = !DILocation(line: 108, scope: !1232, inlinedAt: !1513)
!1513 = !DILocation(line: 70, scope: !1275, inlinedAt: !1505)
!1514 = !DILocation(line: 71, scope: !1275, inlinedAt: !1505)
!1515 = !DILocation(line: 19, scope: !1299, inlinedAt: !1516)
!1516 = !DILocation(line: 19, scope: !1299, inlinedAt: !1517)
!1517 = !DILocation(line: 188, scope: !1203, inlinedAt: !1488)
!1518 = !DILocation(line: 6, scope: !1236, inlinedAt: !1519)
!1519 = !DILocation(line: 109, scope: !1203, inlinedAt: !1488)
!1520 = !DILocation(line: 40, scope: !1174, inlinedAt: !1521)
!1521 = !DILocation(line: 0, scope: !1182, inlinedAt: !1522)
!1522 = !DILocation(line: 0, scope: !1184, inlinedAt: !1523)
!1523 = !DILocation(line: 27, scope: !1524, inlinedAt: !1525)
!1524 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1525 = !DILocation(line: 10, scope: !1526, inlinedAt: !1527)
!1526 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !77)
!1527 = !DILocation(line: 84, scope: !1160)
!1528 = !DILocation(line: 111, scope: !1191, inlinedAt: !1529)
!1529 = !DILocation(line: 111, scope: !1191, inlinedAt: !1525)
!1530 = !DILocation(line: 92, scope: !1203, inlinedAt: !1531)
!1531 = !DILocation(line: 0, scope: !1182, inlinedAt: !1532)
!1532 = !DILocation(line: 0, scope: !1206, inlinedAt: !1533)
!1533 = !DILocation(line: 71, scope: !1208, inlinedAt: !1534)
!1534 = !DILocation(line: 65, scope: !1208, inlinedAt: !1535)
!1535 = !DILocation(line: 11, scope: !1526, inlinedAt: !1527)
!1536 = !DILocation(line: 38, scope: !1219, inlinedAt: !1537)
!1537 = !DILocation(line: 36, scope: !1219, inlinedAt: !1538)
!1538 = !DILocation(line: 124, scope: !1203, inlinedAt: !1531)
!1539 = !DILocation(line: 27, scope: !1223, inlinedAt: !1540)
!1540 = !DILocation(line: 37, scope: !1219, inlinedAt: !1537)
!1541 = !DILocation(line: 126, scope: !1226, inlinedAt: !1542)
!1542 = !DILocation(line: 126, scope: !1226, inlinedAt: !1543)
!1543 = !DILocation(line: 33, scope: !1229, inlinedAt: !1544)
!1544 = !DILocation(line: 41, scope: !1219, inlinedAt: !1537)
!1545 = !DILocation(line: 108, scope: !1232, inlinedAt: !1546)
!1546 = !DILocation(line: 46, scope: !1219, inlinedAt: !1537)
!1547 = !DILocation(line: 47, scope: !1219, inlinedAt: !1537)
!1548 = !DILocation(line: 6, scope: !1236, inlinedAt: !1549)
!1549 = !DILocation(line: 109, scope: !1203, inlinedAt: !1531)
!1550 = !DILocation(line: 92, scope: !1203, inlinedAt: !1551)
!1551 = !DILocation(line: 0, scope: !1182, inlinedAt: !1552)
!1552 = !DILocation(line: 0, scope: !1241, inlinedAt: !1553)
!1553 = !DILocation(line: 72, scope: !1208, inlinedAt: !1534)
!1554 = !DILocation(line: 40, scope: !1174, inlinedAt: !1555)
!1555 = !DILocation(line: 46, scope: !1245, inlinedAt: !1556)
!1556 = !DILocation(line: 46, scope: !1247, inlinedAt: !1557)
!1557 = !DILocation(line: 88, scope: !1249, inlinedAt: !1558)
!1558 = !DILocation(line: 88, scope: !1249, inlinedAt: !1559)
!1559 = !DILocation(line: 88, scope: !1249, inlinedAt: !1560)
!1560 = !DILocation(line: 152, scope: !1203, inlinedAt: !1551)
!1561 = !DILocation(line: 6, scope: !1236, inlinedAt: !1562)
!1562 = !DILocation(line: 109, scope: !1203, inlinedAt: !1551)
!1563 = !DILocation(line: 92, scope: !1203, inlinedAt: !1564)
!1564 = !DILocation(line: 0, scope: !1182, inlinedAt: !1565)
!1565 = !DILocation(line: 0, scope: !1258, inlinedAt: !1566)
!1566 = !DILocation(line: 73, scope: !1208, inlinedAt: !1534)
!1567 = !DILocation(line: 38, scope: !1219, inlinedAt: !1568)
!1568 = !DILocation(line: 36, scope: !1219, inlinedAt: !1569)
!1569 = !DILocation(line: 174, scope: !1203, inlinedAt: !1564)
!1570 = !DILocation(line: 27, scope: !1223, inlinedAt: !1571)
!1571 = !DILocation(line: 37, scope: !1219, inlinedAt: !1568)
!1572 = !DILocation(line: 126, scope: !1226, inlinedAt: !1573)
!1573 = !DILocation(line: 126, scope: !1226, inlinedAt: !1574)
!1574 = !DILocation(line: 33, scope: !1229, inlinedAt: !1575)
!1575 = !DILocation(line: 41, scope: !1219, inlinedAt: !1568)
!1576 = !DILocation(line: 108, scope: !1232, inlinedAt: !1577)
!1577 = !DILocation(line: 46, scope: !1219, inlinedAt: !1568)
!1578 = !DILocation(line: 47, scope: !1219, inlinedAt: !1568)
!1579 = !DILocation(line: 12, scope: !1273, inlinedAt: !1580)
!1580 = !DILocation(line: 61, scope: !1275, inlinedAt: !1581)
!1581 = !DILocation(line: 60, scope: !1275, inlinedAt: !1582)
!1582 = !DILocation(line: 176, scope: !1203, inlinedAt: !1564)
!1583 = !DILocation(line: 62, scope: !1275, inlinedAt: !1581)
!1584 = !DILocation(line: 126, scope: !1226, inlinedAt: !1585)
!1585 = !DILocation(line: 126, scope: !1226, inlinedAt: !1586)
!1586 = !DILocation(line: 33, scope: !1229, inlinedAt: !1587)
!1587 = !DILocation(line: 65, scope: !1275, inlinedAt: !1581)
!1588 = !DILocation(line: 108, scope: !1232, inlinedAt: !1589)
!1589 = !DILocation(line: 70, scope: !1275, inlinedAt: !1581)
!1590 = !DILocation(line: 71, scope: !1275, inlinedAt: !1581)
!1591 = !DILocation(line: 19, scope: !1299, inlinedAt: !1592)
!1592 = !DILocation(line: 19, scope: !1299, inlinedAt: !1593)
!1593 = !DILocation(line: 188, scope: !1203, inlinedAt: !1564)
!1594 = !DILocation(line: 6, scope: !1236, inlinedAt: !1595)
!1595 = !DILocation(line: 109, scope: !1203, inlinedAt: !1564)
!1596 = !DILocation(line: 85, scope: !1160)
!1597 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2334", scope: null, file: !5, line: 32, type: !1086, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !1598)
!1598 = !{!1599, !1600, !1601, !1602}
!1599 = !DILocalVariable(name: "#self#", arg: 1, scope: !1597, file: !5, line: 32, type: !1088)
!1600 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !1597, file: !5, line: 32, type: !79)
!1601 = !DILocalVariable(name: "expected", arg: 3, scope: !1597, file: !5, line: 32, type: !80)
!1602 = !DILocalVariable(name: "value", arg: 4, scope: !1597, file: !5, line: 32, type: !80)
!1603 = !DILocation(line: 0, scope: !1597)
!1604 = !DILocation(line: 27, scope: !1605, inlinedAt: !1606)
!1605 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1606 = !DILocation(line: 37, scope: !1607, inlinedAt: !1608)
!1607 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1608 = !DILocation(line: 36, scope: !1597)
!1609 = !DILocation(line: 499, scope: !1610, inlinedAt: !1611)
!1610 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !94, file: !94, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1611 = !DILocation(line: 38, scope: !1607, inlinedAt: !1608)
!1612 = !DILocation(line: 40, scope: !1607, inlinedAt: !1608)
!1613 = !DILocation(line: 40, scope: !1614, inlinedAt: !1615)
!1614 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !99, file: !99, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1615 = !DILocation(line: 0, scope: !1616, inlinedAt: !1617)
!1616 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1617 = !DILocation(line: 0, scope: !1618, inlinedAt: !1619)
!1618 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1619 = !DILocation(line: 11, scope: !1620, inlinedAt: !1621)
!1620 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1621 = !DILocation(line: 31, scope: !1622, inlinedAt: !1623)
!1622 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1623 = !DILocation(line: 41, scope: !1607, inlinedAt: !1608)
!1624 = !DILocation(line: 126, scope: !1625, inlinedAt: !1626)
!1625 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !111, file: !111, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1626 = !DILocation(line: 126, scope: !1625, inlinedAt: !1627)
!1627 = !DILocation(line: 33, scope: !1622, inlinedAt: !1623)
!1628 = !DILocation(line: 108, scope: !1629, inlinedAt: !1630)
!1629 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !77)
!1630 = !DILocation(line: 46, scope: !1607, inlinedAt: !1608)
!1631 = !DILocation(line: 47, scope: !1607, inlinedAt: !1608)
