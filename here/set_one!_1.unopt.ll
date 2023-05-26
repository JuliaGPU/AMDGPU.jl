; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@0 = private unnamed_addr constant [19 x i8] c"Inexact conversion\00", align 1
@_j_const1 = private unnamed_addr addrspace(1) constant i64 1
@1 = private unnamed_addr constant [8 x i8] c"ERROR: \00", align 1
@2 = private unnamed_addr constant [27 x i8] c"Out-of-bounds array access\00", align 1
@3 = private unnamed_addr constant [2 x i8] c".\00", align 1
@exception.1 = private unnamed_addr constant [10 x i8] c"exception\00", align 1
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 10300, align 4
@_j_const1.19 = private unnamed_addr addrspace(1) constant i64 1
@4 = private unnamed_addr constant [42 x i8] c"Device-to-host string conversion failed.\0A\00", align 1
@5 = private unnamed_addr constant [108 x i8] c"ERROR: a %s was thrown during kernel execution.\0A       Run Julia on debug level 2 for device stack traces.\0A\00", align 1
@_j_const1.3 = private unnamed_addr addrspace(1) constant i64 1
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_1787(i64 zeroext %0, i64 signext %1) unnamed_addr #0 !dbg !64 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -13
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 14
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !67
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %7 = icmp eq i64 %6, %1, !dbg !72
   %8 = zext i1 %7 to i8, !dbg !72
; └
  %9 = trunc i8 %8 to i1, !dbg !75
  %10 = xor i1 %9, true, !dbg !75
  br i1 %10, label %L6, label %L5, !dbg !75

L5:                                               ; preds = %L2
  br label %L20, !dbg !75

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ┌ @ promotion.jl:499 within `==`
   %11 = icmp eq i64 %6, 5, !dbg !76
   %12 = zext i1 %11 to i8, !dbg !76
; └
  %13 = trunc i8 %12 to i1, !dbg !77
  %14 = xor i1 %13, true, !dbg !77
  br i1 %14, label %L10, label %L9, !dbg !77

L9:                                               ; preds = %L6
  br label %L13, !dbg !77

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %15 = icmp eq i64 %6, 6, !dbg !76
   %16 = zext i1 %15 to i8, !dbg !76
; └
  %17 = trunc i8 %16 to i1, !dbg !77
  %18 = xor i1 %17, true, !dbg !77
  br i1 %18, label %L18, label %L13, !dbg !77

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !78
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !78
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %19 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !90
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %20 = load i64, i64 addrspace(5)* %19, align 8, !dbg !93, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %21 = inttoptr i64 %20 to i64*, !dbg !108
    %22 = getelementptr inbounds i64, i64* %21, i64 0, !dbg !108
    %23 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !108, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %23, i64* %22, align 1, !dbg !108, !tbaa !118, !alias.scope !116, !noalias !117
    br label %L18, !dbg !108

L18:                                              ; preds = %L10, %L13
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !119
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
  br label %L2, !dbg !122

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !71
}

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #1

; Function Attrs: readnone
declare [5 x i64] @julia.gpu.state_getter() local_unnamed_addr #2

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__1780({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #0 !dbg !123 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %4 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !124, !range !140
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %5 = add i32 %4, 1, !dbg !141
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %6 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !145, !range !140
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %7 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !150, !range !140
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %8 = zext i32 %5 to i64, !dbg !155
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %9 = icmp eq i64 %8, 1, !dbg !173
     %10 = zext i1 %9 to i8, !dbg !173
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %11 = trunc i8 %10 to i1, !dbg !174
      %12 = and i1 true, %11, !dbg !174
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %13 = xor i1 %12, true, !dbg !177
; │└└
   %14 = zext i1 %13 to i8, !dbg !135
   %15 = trunc i8 %14 to i1, !dbg !135
   %16 = xor i1 %15, true, !dbg !135
   br i1 %16, label %L15, label %L14, !dbg !135

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L21, !dbg !179

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %17 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !180
; │└
   %18 = load i64, i64 addrspace(11)* %17, align 8, !dbg !182, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
   call fastcc void @julia_hostcall_device_signal_wait_cas__1790(i64 zeroext %18, i64 signext 1, i64 signext 2) #0, !dbg !182
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │┌ @ Base.jl:37 within `getproperty`
    %19 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !187
; │└
   %20 = load i64, i64 addrspace(11)* %19, align 8, !dbg !188, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
   call fastcc void @julia_hostcall_device_signal_wait_1787(i64 zeroext %20, i64 signext 4) #0, !dbg !188
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ Base.jl:37 within `getproperty`
    %21 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !189
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    %22 = load i64, i64 addrspace(11)* %21, align 8, !dbg !191, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
    %23 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %22, i64 0, i32 3) [ "jl_roots"(i64 addrspace(11)* %21) ], !dbg !191
    br label %L21, !dbg !191

L21:                                              ; preds = %L15, %L14
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !194
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !137
; └
}

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #3

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #4

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:157 within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__1813({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #0 !dbg !198 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
  call fastcc void @julia_hostcall_device_trigger_and_return__1780({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %0) #0, !dbg !199
  ret void, !dbg !199
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:45 within `#throw_inexacterror`
; Function Attrs: noinline noreturn
define internal fastcc void @julia__throw_inexacterror_1799({} addrspace(10)* noundef nonnull %0, i64 signext %1) unnamed_addr #5 !dbg !200 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %4 = alloca [5 x i64], align 8, addrspace(5)
  %5 = call {}*** @julia.get_pgcstack()
  %6 = bitcast {}*** %5 to {}**
  %current_task = getelementptr inbounds {}*, {}** %6, i64 -13
  %7 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %7, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:84 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !201
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !201
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %8 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !213
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %9 = load i64, i64 addrspace(5)* %8, align 8, !dbg !215, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %10 = inttoptr i64 %9 to { i64, i8 addrspace(1)*, i64 }*, !dbg !217
    %11 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %10, i64 0, !dbg !217
    %12 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3 to i8 addrspace(5)*, !dbg !217
    %13 = bitcast { i64, i8 addrspace(1)*, i64 }* %11 to i8*, !dbg !217
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %12, i8* %13, i64 24, i1 false), !dbg !217, !tbaa !221, !alias.scope !222, !noalias !223
    %14 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, align 8, !dbg !217
; │└
   %15 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !220
   call fastcc void @julia_hostcall_device_lock__1816({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %15) #0, !dbg !220
; │┌ @ Base.jl:37 within `getproperty`
    %16 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !224
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %17 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %16, align 8, !dbg !225, !tbaa !96, !alias.scope !100, !noalias !103
      %18 = ptrtoint i8 addrspace(1)* %17 to i64, !dbg !225
; ││└└
    %19 = addrspacecast i8 addrspace(1)* %17 to i8*, !dbg !231
    %20 = getelementptr i8, i8* %19, i64 0, !dbg !231
    %21 = ptrtoint i8* %20 to i64, !dbg !231
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %22 = addrspacecast i8* %20 to i8 addrspace(1)*, !dbg !233
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %22, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([8 x i8], [8 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*), i64 7, i1 false), !dbg !238
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %23 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !224
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %24 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %23, align 8, !dbg !225, !tbaa !96, !alias.scope !100, !noalias !103
      %25 = ptrtoint i8 addrspace(1)* %24 to i64, !dbg !225
; ││└└
    %26 = addrspacecast i8 addrspace(1)* %24 to i8*, !dbg !231
    %27 = getelementptr i8, i8* %26, i64 7, !dbg !231
    %28 = ptrtoint i8* %27 to i64, !dbg !231
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %29 = addrspacecast i8* %27 to i8 addrspace(1)*, !dbg !233
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %29, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([19 x i8], [19 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*), i64 18, i1 false), !dbg !238
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %30 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !224
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %31 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %30, align 8, !dbg !225, !tbaa !96, !alias.scope !100, !noalias !103
      %32 = ptrtoint i8 addrspace(1)* %31 to i64, !dbg !225
; ││└└
    %33 = addrspacecast i8 addrspace(1)* %31 to i8*, !dbg !231
    %34 = getelementptr i8, i8* %33, i64 25, !dbg !231
    %35 = ptrtoint i8* %34 to i64, !dbg !231
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %36 = addrspacecast i8* %34 to i8 addrspace(1)*, !dbg !233
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %36, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([2 x i8], [2 x i8]* @3, i32 0, i32 0) to i8 addrspace(1)*), i64 1, i1 false), !dbg !238
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %37 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !224
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %38 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %37, align 8, !dbg !242, !tbaa !96, !alias.scope !100, !noalias !103
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %39 = getelementptr inbounds i8, i8 addrspace(1)* %38, i64 26, !dbg !243
      store i8 10, i8 addrspace(1)* %39, align 1, !dbg !243, !tbaa !251
; │└└└
; │┌ @ Base.jl:37 within `getproperty`
    %40 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !224
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %41 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %40, align 8, !dbg !242, !tbaa !96, !alias.scope !100, !noalias !103
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %42 = getelementptr inbounds i8, i8 addrspace(1)* %41, i64 27, !dbg !243
      store i8 0, i8 addrspace(1)* %42, align 1, !dbg !243, !tbaa !251
; │└└└
   %43 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !220
   call fastcc void @julia_hostcall_device_trigger_and_return__1813({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %43) #0, !dbg !220
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i1 = call [5 x i64] @julia.gpu.state_getter(), !dbg !254
      store [5 x i64] %state.i1, [5 x i64] addrspace(5)* %4, align 8, !dbg !254
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %44 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %4, i32 0, i32 0, !dbg !262
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %45 = load i64, i64 addrspace(5)* %44, align 8, !dbg !263, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %46 = inttoptr i64 %45 to i64*, !dbg !264
    %47 = getelementptr inbounds i64, i64* %46, i64 0, !dbg !264
    %48 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !264, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %48, i64* %47, align 1, !dbg !264, !tbaa !118, !alias.scope !116, !noalias !117
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:13 within `#throw_inexacterror`
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.1 to i64)), !dbg !268
  call fastcc void @gpu_signal_exception(), !dbg !268
  call void @llvm.amdgcn.endpgm(), !dbg !268
  unreachable, !dbg !268
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #7

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #6

;  @ boot.jl:652 within `checked_trunc_sint`
define internal fastcc i32 @julia_checked_trunc_sint_1796(i64 signext %0) unnamed_addr #0 !dbg !269 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
;  @ boot.jl:654 within `checked_trunc_sint`
  %4 = trunc i64 %0 to i32, !dbg !270
;  @ boot.jl:655 within `checked_trunc_sint`
  %5 = sext i32 %4 to i64, !dbg !271
;  @ boot.jl:656 within `checked_trunc_sint`
  %6 = icmp eq i64 %0, %5, !dbg !272
  %7 = zext i1 %6 to i8, !dbg !272
  %8 = trunc i8 %7 to i1, !dbg !272
  %9 = xor i1 %8, true, !dbg !272
  br i1 %9, label %L7, label %L5, !dbg !272

L5:                                               ; preds = %top
;  @ boot.jl:657 within `checked_trunc_sint`
  ret i32 %4, !dbg !273

L7:                                               ; preds = %top
;  @ boot.jl:656 within `checked_trunc_sint`
  call fastcc void @julia__throw_inexacterror_1799({} addrspace(10)* addrspacecast ({}* inttoptr (i64 139821335096008 to {}*) to {} addrspace(10)*), i64 signext %0) #13, !dbg !272
  unreachable, !dbg !272
}

;  @ boot.jl:693 within `toInt32`
define internal fastcc i32 @julia_toInt32_1793(i64 signext %0) unnamed_addr #0 !dbg !274 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
  %4 = call fastcc i32 @julia_checked_trunc_sint_1796(i64 signext %0) #0, !dbg !275
  ret i32 %4, !dbg !275
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__1790(i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #0 !dbg !276 {
top:
  %3 = alloca [5 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -13
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 14
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %7 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !277
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %8 = icmp eq i64 %7, %1, !dbg !282
   %9 = zext i1 %8 to i8, !dbg !282
; └
  %10 = trunc i8 %9 to i1, !dbg !284
  %11 = xor i1 %10, true, !dbg !284
  br i1 %11, label %L6, label %L5, !dbg !284

L5:                                               ; preds = %L2
  br label %L20, !dbg !284

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ┌ @ promotion.jl:499 within `==`
   %12 = icmp eq i64 %7, 5, !dbg !285
   %13 = zext i1 %12 to i8, !dbg !285
; └
  %14 = trunc i8 %13 to i1, !dbg !286
  %15 = xor i1 %14, true, !dbg !286
  br i1 %15, label %L10, label %L9, !dbg !286

L9:                                               ; preds = %L6
  br label %L13, !dbg !286

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %16 = icmp eq i64 %7, 6, !dbg !285
   %17 = zext i1 %16 to i8, !dbg !285
; └
  %18 = trunc i8 %17 to i1, !dbg !286
  %19 = xor i1 %18, true, !dbg !286
  br i1 %19, label %L18, label %L13, !dbg !286

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !287
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %3, align 8, !dbg !287
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %20 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !298
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %21 = load i64, i64 addrspace(5)* %20, align 8, !dbg !300, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %22 = inttoptr i64 %21 to i64*, !dbg !302
    %23 = getelementptr inbounds i64, i64* %22, i64 0, !dbg !302
    %24 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !302, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %24, i64* %23, align 1, !dbg !302, !tbaa !118, !alias.scope !116, !noalias !117
    br label %L18, !dbg !302

L18:                                              ; preds = %L10, %L13
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !306
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !309

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !281
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:114 within `hostcall_device_lock!`
define internal fastcc void @julia_hostcall_device_lock__1816({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #0 !dbg !310 {
top:
  %1 = alloca [5 x i64], align 8, addrspace(5)
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -13
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %5 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !311, !range !140
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %6 = add i32 %5, 1, !dbg !328
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %7 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !331, !range !140
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %8 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !336, !range !140
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %9 = zext i32 %6 to i64, !dbg !341
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %10 = icmp eq i64 %9, 1, !dbg !357
     %11 = zext i1 %10 to i8, !dbg !357
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %12 = trunc i8 %11 to i1, !dbg !358
      %13 = and i1 true, %12, !dbg !358
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %14 = xor i1 %13, true, !dbg !360
; │└└
   %15 = zext i1 %14 to i8, !dbg !321
   %16 = trunc i8 %15 to i1, !dbg !321
   %17 = xor i1 %16, true, !dbg !321
   br i1 %17, label %L14, label %L13, !dbg !321

L13:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L36, !dbg !362

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │┌ @ Base.jl:37 within `getproperty`
    %18 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !363
; │└
   br label %L16, !dbg !365

L16:                                              ; preds = %L32, %L14
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
     %19 = load i64, i64 addrspace(11)* %18, align 8, !dbg !366, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
     %20 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %19, i64 0, i64 1, i32 4) [ "jl_roots"(i64 addrspace(11)* %18) ], !dbg !366
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││┌ @ promotion.jl:499 within `==`
     %21 = icmp eq i64 %20, 0, !dbg !371
     %22 = zext i1 %21 to i8, !dbg !371
; ││└
    %23 = trunc i8 %22 to i1, !dbg !372
    %24 = xor i1 %23, true, !dbg !372
    br i1 %24, label %L20, label %L19, !dbg !372

L19:                                              ; preds = %L16
    br label %L34, !dbg !372

L20:                                              ; preds = %L16
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││┌ @ promotion.jl:499 within `==`
     %25 = icmp eq i64 %20, 5, !dbg !373
     %26 = zext i1 %25 to i8, !dbg !373
; ││└
    %27 = trunc i8 %26 to i1, !dbg !374
    %28 = xor i1 %27, true, !dbg !374
    br i1 %28, label %L24, label %L23, !dbg !374

L23:                                              ; preds = %L20
    br label %L27, !dbg !374

L24:                                              ; preds = %L20
; ││┌ @ promotion.jl:499 within `==`
     %29 = icmp eq i64 %20, 6, !dbg !373
     %30 = zext i1 %29 to i8, !dbg !373
; ││└
    %31 = trunc i8 %30 to i1, !dbg !374
    %32 = xor i1 %31, true, !dbg !374
    br i1 %32, label %L32, label %L27, !dbg !374

L27:                                              ; preds = %L24, %L23
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
        %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !375
        store [5 x i64] %state.i, [5 x i64] addrspace(5)* %1, align 8, !dbg !375
; ││││└└
; ││││┌ @ Base.jl:37 within `getproperty`
       %33 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %1, i32 0, i32 0, !dbg !384
; ││││└
; ││││┌ @ pointer.jl:30 within `convert`
       %34 = load i64, i64 addrspace(5)* %33, align 8, !dbg !385, !tbaa !96, !alias.scope !100, !noalias !103
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
      %35 = inttoptr i64 %34 to i64*, !dbg !387
      %36 = getelementptr inbounds i64, i64* %35, i64 0, !dbg !387
      %37 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !387, !tbaa !112, !alias.scope !116, !noalias !117
      store i64 %37, i64* %36, align 1, !dbg !387, !tbaa !118, !alias.scope !116, !noalias !117
      br label %L32, !dbg !387

L32:                                              ; preds = %L24, %L27
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
     call void @llvm.amdgcn.s.sleep(i32 5), !dbg !391
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
    br label %L16, !dbg !394

L34:                                              ; preds = %L19
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
    br label %L35, !dbg !370

L35:                                              ; preds = %L34
    br label %L36, !dbg !370

L36:                                              ; preds = %L35, %L13
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !395
; │└
; │ @ none within `macro expansion`
   br label %L38, !dbg !323

L38:                                              ; preds = %L36
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
  ret void, !dbg !327
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:49 within `#throw_boundserror`
; Function Attrs: noinline noreturn
define internal fastcc void @julia__throw_boundserror_1763({ [1 x i64], i8 addrspace(1)* } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, [1 x i64] addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(8) %1) unnamed_addr #5 !dbg !398 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %4 = alloca [5 x i64], align 8, addrspace(5)
  %5 = alloca [5 x i64], align 8, addrspace(5)
  %6 = call {}*** @julia.get_pgcstack()
  %7 = bitcast {}*** %6 to {}**
  %current_task = getelementptr inbounds {}*, {}** %7, i64 -13
  %8 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %8, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:84 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !399
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !399
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %9 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !410
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %10 = load i64, i64 addrspace(5)* %9, align 8, !dbg !412, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:85 within `macro expansion`
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %11 = inttoptr i64 %10 to { i64, i8 addrspace(1)*, i64 }*, !dbg !414
    %12 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %11, i64 0, !dbg !414
    %13 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3 to i8 addrspace(5)*, !dbg !414
    %14 = bitcast { i64, i8 addrspace(1)*, i64 }* %12 to i8*, !dbg !414
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %13, i8* %14, i64 24, i1 false), !dbg !414, !tbaa !221, !alias.scope !222, !noalias !223
    %15 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, align 8, !dbg !414
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %16 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !418, !range !140
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %17 = add i32 %16, 1, !dbg !434
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %18 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !437, !range !140
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %19 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !442, !range !140
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %20 = zext i32 %17 to i64, !dbg !447
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %21 = icmp eq i64 %20, 1, !dbg !463
       %22 = zext i1 %21 to i8, !dbg !463
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %23 = trunc i8 %22 to i1, !dbg !464
        %24 = and i1 true, %23, !dbg !464
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %25 = xor i1 %24, true, !dbg !466
; │││└└
     %26 = zext i1 %25 to i8, !dbg !427
     %27 = trunc i8 %26 to i1, !dbg !427
     %28 = xor i1 %27, true, !dbg !427
     br i1 %28, label %L19, label %L18, !dbg !427

L18:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L41, !dbg !468

L19:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ Base.jl:37 within `getproperty`
      %29 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 0, !dbg !469
; │││└
     br label %L21, !dbg !470

L21:                                              ; preds = %L37, %L19
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %30 = load i64, i64 addrspace(5)* %29, align 8, !dbg !471, !tbaa !96, !alias.scope !100, !noalias !103
       %31 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %30, i64 0, i64 1, i32 4), !dbg !471
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %32 = icmp eq i64 %31, 0, !dbg !476
       %33 = zext i1 %32 to i8, !dbg !476
; ││││└
      %34 = trunc i8 %33 to i1, !dbg !477
      %35 = xor i1 %34, true, !dbg !477
      br i1 %35, label %L25, label %L24, !dbg !477

L24:                                              ; preds = %L21
      br label %L39, !dbg !477

L25:                                              ; preds = %L21
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %36 = icmp eq i64 %31, 5, !dbg !478
       %37 = zext i1 %36 to i8, !dbg !478
; ││││└
      %38 = trunc i8 %37 to i1, !dbg !479
      %39 = xor i1 %38, true, !dbg !479
      br i1 %39, label %L29, label %L28, !dbg !479

L28:                                              ; preds = %L25
      br label %L32, !dbg !479

L29:                                              ; preds = %L25
; ││││┌ @ promotion.jl:499 within `==`
       %40 = icmp eq i64 %31, 6, !dbg !478
       %41 = zext i1 %40 to i8, !dbg !478
; ││││└
      %42 = trunc i8 %41 to i1, !dbg !479
      %43 = xor i1 %42, true, !dbg !479
      br i1 %43, label %L37, label %L32, !dbg !479

L32:                                              ; preds = %L29, %L28
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i2 = call [5 x i64] @julia.gpu.state_getter(), !dbg !480
          store [5 x i64] %state.i2, [5 x i64] addrspace(5)* %5, align 8, !dbg !480
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %44 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %5, i32 0, i32 0, !dbg !488
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %45 = load i64, i64 addrspace(5)* %44, align 8, !dbg !489, !tbaa !96, !alias.scope !100, !noalias !103
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %46 = inttoptr i64 %45 to i64*, !dbg !490
        %47 = getelementptr inbounds i64, i64* %46, i64 0, !dbg !490
        %48 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !490, !tbaa !112, !alias.scope !116, !noalias !117
        store i64 %48, i64* %47, align 1, !dbg !490, !tbaa !118, !alias.scope !116, !noalias !117
        br label %L37, !dbg !490

L37:                                              ; preds = %L29, %L32
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !494
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L21, !dbg !497

L39:                                              ; preds = %L24
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L40, !dbg !475

L40:                                              ; preds = %L39
      br label %L41, !dbg !475

L41:                                              ; preds = %L40, %L18
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !498
; │││└
; │││ @ none within `macro expansion`
     br label %L43, !dbg !429

L43:                                              ; preds = %L41
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
    br label %L44, !dbg !432

L44:                                              ; preds = %L43
; │└
; │┌ @ Base.jl:37 within `getproperty`
    %49 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !501
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %50 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %49, align 8, !dbg !502, !tbaa !96, !alias.scope !100, !noalias !103
      %51 = ptrtoint i8 addrspace(1)* %50 to i64, !dbg !502
; ││└└
    %52 = addrspacecast i8 addrspace(1)* %50 to i8*, !dbg !506
    %53 = getelementptr i8, i8* %52, i64 0, !dbg !506
    %54 = ptrtoint i8* %53 to i64, !dbg !506
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %55 = addrspacecast i8* %53 to i8 addrspace(1)*, !dbg !508
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %55, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([8 x i8], [8 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*), i64 7, i1 false), !dbg !513
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %56 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !501
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %57 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %56, align 8, !dbg !502, !tbaa !96, !alias.scope !100, !noalias !103
      %58 = ptrtoint i8 addrspace(1)* %57 to i64, !dbg !502
; ││└└
    %59 = addrspacecast i8 addrspace(1)* %57 to i8*, !dbg !506
    %60 = getelementptr i8, i8* %59, i64 7, !dbg !506
    %61 = ptrtoint i8* %60 to i64, !dbg !506
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %62 = addrspacecast i8* %60 to i8 addrspace(1)*, !dbg !508
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %62, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([27 x i8], [27 x i8]* @2, i32 0, i32 0) to i8 addrspace(1)*), i64 26, i1 false), !dbg !513
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %63 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !501
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %64 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %63, align 8, !dbg !502, !tbaa !96, !alias.scope !100, !noalias !103
      %65 = ptrtoint i8 addrspace(1)* %64 to i64, !dbg !502
; ││└└
    %66 = addrspacecast i8 addrspace(1)* %64 to i8*, !dbg !506
    %67 = getelementptr i8, i8* %66, i64 33, !dbg !506
    %68 = ptrtoint i8* %67 to i64, !dbg !506
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %69 = addrspacecast i8* %67 to i8 addrspace(1)*, !dbg !508
; │└└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %69, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([2 x i8], [2 x i8]* @3, i32 0, i32 0) to i8 addrspace(1)*), i64 1, i1 false), !dbg !513
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %70 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !501
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %71 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %70, align 8, !dbg !517, !tbaa !96, !alias.scope !100, !noalias !103
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %72 = getelementptr inbounds i8, i8 addrspace(1)* %71, i64 34, !dbg !518
      store i8 10, i8 addrspace(1)* %72, align 1, !dbg !518, !tbaa !251
; │└└└
; │┌ @ Base.jl:37 within `getproperty`
    %73 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3, i32 0, i32 1, !dbg !501
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %74 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %73, align 8, !dbg !517, !tbaa !96, !alias.scope !100, !noalias !103
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %75 = getelementptr inbounds i8, i8 addrspace(1)* %74, i64 35, !dbg !518
      store i8 0, i8 addrspace(1)* %75, align 1, !dbg !518, !tbaa !251
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
    %76 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %3 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !526
    call fastcc void @julia_hostcall_device_trigger_and_return__1780({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %76) #0, !dbg !526
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i1 = call [5 x i64] @julia.gpu.state_getter(), !dbg !528
      store [5 x i64] %state.i1, [5 x i64] addrspace(5)* %4, align 8, !dbg !528
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %77 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %4, i32 0, i32 0, !dbg !534
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %78 = load i64, i64 addrspace(5)* %77, align 8, !dbg !535, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %79 = inttoptr i64 %78 to i64*, !dbg !536
    %80 = getelementptr inbounds i64, i64* %79, i64 0, !dbg !536
    %81 = load i64, i64 addrspace(1)* @_j_const1, align 1, !dbg !536, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %81, i64* %80, align 1, !dbg !536, !tbaa !118, !alias.scope !116, !noalias !117
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:13 within `#throw_boundserror`
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.1 to i64)), !dbg !539
  call fastcc void @gpu_signal_exception(), !dbg !539
  call void @llvm.amdgcn.endpgm(), !dbg !539
  unreachable, !dbg !539
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #4

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #7

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #8

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #9

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #10 {
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
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #11 {
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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !540
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !546
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
define internal void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #11 {
  %4 = inttoptr i64 %0 to %0 addrspace(1)*
  %5 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 0
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !547
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !540
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %63, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !546
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %63

24:                                               ; preds = %3
  %25 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !548
  %26 = icmp sgt i32 %25, 8999
  br i1 %26, label %27, label %31

27:                                               ; preds = %24
  %28 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %29 = bitcast %1 addrspace(1)* %28 to i64 addrspace(1)* addrspace(1)*
  %30 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %29, align 8, !tbaa !549
  store atomic i64 %1, i64 addrspace(1)* %30 syncscope("one-as") release, align 8
  br label %63

31:                                               ; preds = %24
  %32 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 7, i32 0
  %33 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %32, align 16, !tbaa !549
  %34 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 8
  %35 = cmpxchg i32 addrspace(1)* %34, i32 0, i32 1 syncscope("one-as") acquire monotonic, align 4
  %36 = extractvalue { i32, i1 } %35, 1
  br i1 %36, label %40, label %37

37:                                               ; preds = %37, %31
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  %38 = cmpxchg i32 addrspace(1)* %34, i32 0, i32 1 syncscope("one-as") acquire monotonic, align 4
  %39 = extractvalue { i32, i1 } %38, 1
  br i1 %39, label %40, label %37

40:                                               ; preds = %37, %31
  %41 = add nsw i64 %1, 1
  %42 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 7
  %43 = load volatile i64, i64 addrspace(1)* %42, align 16, !tbaa !550
  %44 = icmp ugt i64 %41, %43
  br i1 %44, label %45, label %62

45:                                               ; preds = %40
  store atomic i64 %41, i64 addrspace(1)* %42 syncscope("one-as") monotonic, align 16
  %46 = icmp slt i32 %25, 8000
  br i1 %46, label %47, label %56

47:                                               ; preds = %45
  %48 = trunc i64 %41 to i32
  %49 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 0, i32 4
  %50 = load i32, i32 addrspace(1)* %49, align 8, !tbaa !555
  %51 = shl i32 %50, 1
  %52 = add i32 %51, 268435455
  %53 = and i32 %52, %48
  %54 = shl i32 %53, 4
  %55 = zext i32 %54 to i64
  br label %56

56:                                               ; preds = %47, %45
  %57 = phi i64 [ %55, %47 ], [ %41, %45 ]
  %58 = trunc i64 %57 to i32
  %59 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %60 = bitcast %1 addrspace(1)* %59 to i32 addrspace(1)* addrspace(1)*
  %61 = load i32 addrspace(1)*, i32 addrspace(1)* addrspace(1)* %60, align 8, !tbaa !549
  store volatile i32 %58, i32 addrspace(1)* %61, align 4, !tbaa !548
  br label %62

62:                                               ; preds = %56, %40
  store atomic i32 0, i32 addrspace(1)* %34 syncscope("one-as") release, align 4
  br label %63

63:                                               ; preds = %62, %27, %17, %13
  ret void
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:65 within `report_exception`
define internal fastcc void @gpu_report_exception(i64 zeroext %0) unnamed_addr #0 !dbg !556 {
top:
  %1 = alloca [5 x i64], align 8, addrspace(5)
  %2 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %3 = alloca [5 x i64], align 8, addrspace(5)
  %4 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %5 = alloca [5 x i64], align 8, addrspace(5)
  %6 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %7 = alloca [5 x i64], align 8, addrspace(5)
  %8 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %9 = alloca [5 x i64], align 8, addrspace(5)
  %10 = alloca [5 x i64], align 8, addrspace(5)
  %11 = alloca [5 x i64], align 8, addrspace(5)
  %12 = alloca [5 x i64], align 8, addrspace(5)
  %13 = alloca [5 x i64], align 8, addrspace(5)
  %14 = alloca [5 x i64], align 8, addrspace(5)
  %15 = alloca [5 x i64], align 8, addrspace(5)
  %16 = alloca [5 x i64], align 8, addrspace(5)
  %17 = alloca [5 x i64], align 8, addrspace(5)
  %18 = alloca [5 x i64], align 8, addrspace(5)
  %19 = alloca [5 x i64], align 8, addrspace(5)
  %20 = call {}*** @julia.get_pgcstack()
  %21 = bitcast {}*** %20 to {}**
  %current_task = getelementptr inbounds {}*, {}** %21, i64 -13
  %22 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %22, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:66 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:43 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %23 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !557
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %24 = addrspacecast i8 addrspace(1)* %23 to i8 addrspace(1)**, !dbg !562
     %25 = bitcast i8 addrspace(1)** %24 to i8*, !dbg !562
     br label %check.i, !dbg !562

check.i:                                          ; preds = %check.i, %top
     %26 = phi i64 [ 0, %top ], [ %27, %check.i ], !dbg !562
     %27 = add i64 %26, 1, !dbg !562
     %28 = getelementptr i8, i8* %25, i64 %26, !dbg !562
     %29 = load i8, i8* %28, align 1, !dbg !562
     %30 = icmp eq i8 %29, 0, !dbg !562
     br i1 %30, label %julia_report_exception_2154u2156.exit, label %check.i, !dbg !562

julia_report_exception_2154u2156.exit:            ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ int.jl:1042 within `+` @ int.jl:87
    %31 = add i64 %26, 1, !dbg !570
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i2 = call [5 x i64] @julia.gpu.state_getter(), !dbg !574
       store [5 x i64] %state.i2, [5 x i64] addrspace(5)* %1, align 8, !dbg !574
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %32 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %1, i32 0, i32 3, !dbg !583
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %33 = load i64, i64 addrspace(5)* %32, align 8, !dbg !585, !tbaa !96, !alias.scope !100, !noalias !103
; ││└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %34 = inttoptr i64 %33 to { i64, i8 addrspace(1)*, i64 }*, !dbg !587
     %35 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, !dbg !587
     %36 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2 to i8 addrspace(5)*, !dbg !587
     %37 = bitcast { i64, i8 addrspace(1)*, i64 }* %35 to i8*, !dbg !587
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %36, i8* %37, i64 24, i1 false), !dbg !587, !tbaa !221, !alias.scope !222, !noalias !223
     %38 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, align 8, !dbg !587
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %39 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !590, !range !140
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %40 = add i32 %39, 1, !dbg !608
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %41 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !610, !range !140
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %42 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !615, !range !140
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %43 = zext i32 %40 to i64, !dbg !620
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %44 = icmp eq i64 %43, 1, !dbg !636
         %45 = zext i1 %44 to i8, !dbg !636
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %46 = trunc i8 %45 to i1, !dbg !637
          %47 = and i1 true, %46, !dbg !637
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %48 = xor i1 %47, true, !dbg !639
; │││││└└
       %49 = zext i1 %48 to i8, !dbg !599
       %50 = trunc i8 %49 to i1, !dbg !599
       %51 = xor i1 %50, true, !dbg !599
       br i1 %51, label %L23, label %L22, !dbg !599

L22:                                              ; preds = %julia_report_exception_2154u2156.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L45, !dbg !641

L23:                                              ; preds = %julia_report_exception_2154u2156.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ Base.jl:37 within `getproperty`
        %52 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !642
; │││││└
       br label %L25, !dbg !643

L25:                                              ; preds = %L41, %L23
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %53 = load i64, i64 addrspace(5)* %52, align 8, !dbg !644, !tbaa !96, !alias.scope !100, !noalias !103
         %54 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %53, i64 0, i64 1, i32 4), !dbg !644
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %55 = icmp eq i64 %54, 0, !dbg !649
         %56 = zext i1 %55 to i8, !dbg !649
; ││││││└
        %57 = trunc i8 %56 to i1, !dbg !650
        %58 = xor i1 %57, true, !dbg !650
        br i1 %58, label %L29, label %L28, !dbg !650

L28:                                              ; preds = %L25
        br label %L43, !dbg !650

L29:                                              ; preds = %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %59 = icmp eq i64 %54, 5, !dbg !651
         %60 = zext i1 %59 to i8, !dbg !651
; ││││││└
        %61 = trunc i8 %60 to i1, !dbg !652
        %62 = xor i1 %61, true, !dbg !652
        br i1 %62, label %L33, label %L32, !dbg !652

L32:                                              ; preds = %L29
        br label %L36, !dbg !652

L33:                                              ; preds = %L29
; ││││││┌ @ promotion.jl:499 within `==`
         %63 = icmp eq i64 %54, 6, !dbg !651
         %64 = zext i1 %63 to i8, !dbg !651
; ││││││└
        %65 = trunc i8 %64 to i1, !dbg !652
        %66 = xor i1 %65, true, !dbg !652
        br i1 %66, label %L41, label %L36, !dbg !652

L36:                                              ; preds = %L33, %L32
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i6 = call [5 x i64] @julia.gpu.state_getter(), !dbg !653
            store [5 x i64] %state.i6, [5 x i64] addrspace(5)* %19, align 8, !dbg !653
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %67 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %19, i32 0, i32 0, !dbg !661
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %68 = load i64, i64 addrspace(5)* %67, align 8, !dbg !662, !tbaa !96, !alias.scope !100, !noalias !103
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %69 = inttoptr i64 %68 to i64*, !dbg !663
          %70 = getelementptr inbounds i64, i64* %69, i64 0, !dbg !663
          %71 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !663, !tbaa !112, !alias.scope !116, !noalias !117
          store i64 %71, i64* %70, align 1, !dbg !663, !tbaa !118, !alias.scope !116, !noalias !117
          br label %L41, !dbg !663

L41:                                              ; preds = %L36, %L33
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !667
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !670

L43:                                              ; preds = %L28
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L44, !dbg !648

L44:                                              ; preds = %L43
        br label %L45, !dbg !648

L45:                                              ; preds = %L44, %L22
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !671
; │││││└
; │││││ @ none within `macro expansion`
       br label %L47, !dbg !601

L47:                                              ; preds = %L45
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %72 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !674, !range !140
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %73 = add i32 %72, 1, !dbg !684
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %74 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !686, !range !140
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %75 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !690, !range !140
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %76 = zext i32 %73 to i64, !dbg !694
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %77 = icmp eq i64 %76, 1, !dbg !702
         %78 = zext i1 %77 to i8, !dbg !702
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %79 = trunc i8 %78 to i1, !dbg !703
          %80 = and i1 true, %79, !dbg !703
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %81 = xor i1 %80, true, !dbg !704
; │││││└└
       %82 = zext i1 %81 to i8, !dbg !679
       %83 = trunc i8 %82 to i1, !dbg !679
       %84 = xor i1 %83, true, !dbg !679
       br i1 %84, label %L60, label %L59, !dbg !679

L59:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L70, !dbg !705

L60:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ Base.jl:37 within `getproperty`
        %85 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 1, !dbg !706
; │││││└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %86 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %85, align 8, !dbg !708, !tbaa !96, !alias.scope !100, !noalias !103
          %87 = ptrtoint i8 addrspace(1)* %86 to i64, !dbg !708
; ││││││└└
        %88 = addrspacecast i8 addrspace(1)* %86 to i8*, !dbg !711
        %89 = getelementptr i8, i8* %88, i64 1, !dbg !711
        %90 = ptrtoint i8* %89 to i64, !dbg !711
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %91 = addrspacecast i8* %89 to i8 addrspace(1)*, !dbg !713
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %92 = ptrtoint i8 addrspace(1)* %91 to i64, !dbg !718
; ││││││└└
        %93 = addrspacecast i8 addrspace(1)* %91 to i8*, !dbg !720
        %94 = getelementptr i8, i8* %93, i64 -1, !dbg !720
        %95 = ptrtoint i8* %94 to i64, !dbg !720
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %96 = addrspacecast i8* %94 to i8 addrspace(1)*, !dbg !722
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %97 = bitcast i8 addrspace(1)* %96 to i64 addrspace(1)*, !dbg !725
          store i64 %31, i64 addrspace(1)* %97, align 1, !dbg !725, !tbaa !251
          br label %L70, !dbg !725

L70:                                              ; preds = %L60, %L59
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !734
; │││││└
; │││││ @ none within `macro expansion`
       br label %L72, !dbg !680

L72:                                              ; preds = %L70
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L73, !dbg !736

L73:                                              ; preds = %L72
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:169
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52 within `alloc_local` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          br label %L75, !dbg !741

L75:                                              ; preds = %L73
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %98 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !751, !range !140
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %99 = add i32 %98, 1, !dbg !757
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %100 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !759, !range !140
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %101 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !763, !range !140
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %102 = zext i32 %99 to i64, !dbg !767
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %103 = icmp eq i64 %102, 1, !dbg !775
         %104 = zext i1 %103 to i8, !dbg !775
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %105 = trunc i8 %104 to i1, !dbg !776
          %106 = and i1 true, %105, !dbg !776
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %107 = xor i1 %106, true, !dbg !777
; │││││└└
       %108 = zext i1 %107 to i8, !dbg !756
       %109 = trunc i8 %108 to i1, !dbg !756
       %110 = xor i1 %109, true, !dbg !756
       br i1 %110, label %L89, label %L88, !dbg !756

L88:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L152, !dbg !778

L89:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ Base.jl:37 within `getproperty`
        %111 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !779
        br label %L90, !dbg !779

L90:                                              ; preds = %L106, %L89
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %112 = load i64, i64 addrspace(5)* %111, align 8, !dbg !781, !tbaa !96, !alias.scope !100, !noalias !103
         %113 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %112, i64 1, i64 2, i32 4), !dbg !781
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %114 = icmp eq i64 %113, 1, !dbg !784
         %115 = zext i1 %114 to i8, !dbg !784
; ││││││└
        %116 = trunc i8 %115 to i1, !dbg !785
        %117 = xor i1 %116, true, !dbg !785
        br i1 %117, label %L94, label %L93, !dbg !785

L93:                                              ; preds = %L90
        br label %L108, !dbg !785

L94:                                              ; preds = %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %118 = icmp eq i64 %113, 5, !dbg !786
         %119 = zext i1 %118 to i8, !dbg !786
; ││││││└
        %120 = trunc i8 %119 to i1, !dbg !787
        %121 = xor i1 %120, true, !dbg !787
        br i1 %121, label %L98, label %L97, !dbg !787

L97:                                              ; preds = %L94
        br label %L101, !dbg !787

L98:                                              ; preds = %L94
; ││││││┌ @ promotion.jl:499 within `==`
         %122 = icmp eq i64 %113, 6, !dbg !786
         %123 = zext i1 %122 to i8, !dbg !786
; ││││││└
        %124 = trunc i8 %123 to i1, !dbg !787
        %125 = xor i1 %124, true, !dbg !787
        br i1 %125, label %L106, label %L101, !dbg !787

L101:                                             ; preds = %L98, %L97
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i14 = call [5 x i64] @julia.gpu.state_getter(), !dbg !788
            store [5 x i64] %state.i14, [5 x i64] addrspace(5)* %18, align 8, !dbg !788
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %126 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %18, i32 0, i32 0, !dbg !794
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %127 = load i64, i64 addrspace(5)* %126, align 8, !dbg !795, !tbaa !96, !alias.scope !100, !noalias !103
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %128 = inttoptr i64 %127 to i64*, !dbg !796
          %129 = getelementptr inbounds i64, i64* %128, i64 0, !dbg !796
          %130 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !796, !tbaa !112, !alias.scope !116, !noalias !117
          store i64 %130, i64* %129, align 1, !dbg !796, !tbaa !118, !alias.scope !116, !noalias !117
          br label %L106, !dbg !796

L106:                                             ; preds = %L101, %L98
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !799
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !801

L108:                                             ; preds = %L93
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L109, !dbg !783

L109:                                             ; preds = %L108
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ Base.jl:37 within `getproperty`
        %131 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !802
        br label %L110, !dbg !802

L110:                                             ; preds = %L126, %L109
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %132 = load i64, i64 addrspace(5)* %131, align 8, !dbg !804, !tbaa !96, !alias.scope !100, !noalias !103
         %133 = call fastcc i64 @__ockl_hsa_signal_load(i64 %132, i32 2), !dbg !804
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││││┌ @ promotion.jl:499 within `==`
         %134 = icmp eq i64 %133, 4, !dbg !809
         %135 = zext i1 %134 to i8, !dbg !809
; ││││││└
        %136 = trunc i8 %135 to i1, !dbg !810
        %137 = xor i1 %136, true, !dbg !810
        br i1 %137, label %L114, label %L113, !dbg !810

L113:                                             ; preds = %L110
        br label %L128, !dbg !810

L114:                                             ; preds = %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││││┌ @ promotion.jl:499 within `==`
         %138 = icmp eq i64 %133, 5, !dbg !811
         %139 = zext i1 %138 to i8, !dbg !811
; ││││││└
        %140 = trunc i8 %139 to i1, !dbg !812
        %141 = xor i1 %140, true, !dbg !812
        br i1 %141, label %L118, label %L117, !dbg !812

L117:                                             ; preds = %L114
        br label %L121, !dbg !812

L118:                                             ; preds = %L114
; ││││││┌ @ promotion.jl:499 within `==`
         %142 = icmp eq i64 %133, 6, !dbg !811
         %143 = zext i1 %142 to i8, !dbg !811
; ││││││└
        %144 = trunc i8 %143 to i1, !dbg !812
        %145 = xor i1 %144, true, !dbg !812
        br i1 %145, label %L126, label %L121, !dbg !812

L121:                                             ; preds = %L118, %L117
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i15 = call [5 x i64] @julia.gpu.state_getter(), !dbg !813
            store [5 x i64] %state.i15, [5 x i64] addrspace(5)* %17, align 8, !dbg !813
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %146 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %17, i32 0, i32 0, !dbg !819
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %147 = load i64, i64 addrspace(5)* %146, align 8, !dbg !820, !tbaa !96, !alias.scope !100, !noalias !103
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %148 = inttoptr i64 %147 to i64*, !dbg !821
          %149 = getelementptr inbounds i64, i64* %148, i64 0, !dbg !821
          %150 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !821, !tbaa !112, !alias.scope !116, !noalias !117
          store i64 %150, i64* %149, align 1, !dbg !821, !tbaa !118, !alias.scope !116, !noalias !117
          br label %L126, !dbg !821

L126:                                             ; preds = %L121, %L118
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !824
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !826

L128:                                             ; preds = %L113
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
        br label %L129, !dbg !808

L129:                                             ; preds = %L128
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:178
       br label %L130, !dbg !827

L130:                                             ; preds = %L129
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:179
; │││││┌ @ Base.jl:37 within `getproperty`
        %151 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 1, !dbg !828
; │││││└
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %152 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %151, align 8, !dbg !830, !tbaa !96, !alias.scope !100, !noalias !103
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %153 = bitcast i8 addrspace(1)* %152 to i8 addrspace(1)* addrspace(1)*, !dbg !831
          %154 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %153, align 1, !dbg !831, !tbaa !251
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %155 = ptrtoint i8 addrspace(1)* %154 to i64, !dbg !840
; │││││└└
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %156 = icmp eq i64 %155, 0, !dbg !843
        %157 = zext i1 %156 to i8, !dbg !843
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %158 = trunc i8 %157 to i1, !dbg !845
         %159 = and i1 true, %158, !dbg !845
; │││││└└
       %160 = zext i1 %159 to i8, !dbg !842
       %161 = trunc i8 %160 to i1, !dbg !842
       %162 = xor i1 %161, true, !dbg !842
       br i1 %162, label %L146, label %L138, !dbg !842

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ Base.jl:37 within `getproperty`
        %163 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !846
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %164 = load i64, i64 addrspace(5)* %163, align 8, !dbg !848, !tbaa !96, !alias.scope !100, !noalias !103
        %165 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %164, i64 5, i32 3), !dbg !848
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i13 = call [5 x i64] @julia.gpu.state_getter(), !dbg !851
           store [5 x i64] %state.i13, [5 x i64] addrspace(5)* %16, align 8, !dbg !851
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %166 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %16, i32 0, i32 0, !dbg !857
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %167 = load i64, i64 addrspace(5)* %166, align 8, !dbg !858, !tbaa !96, !alias.scope !100, !noalias !103
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %168 = inttoptr i64 %167 to i64*, !dbg !859
         %169 = getelementptr inbounds i64, i64* %168, i64 0, !dbg !859
         %170 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !859, !tbaa !112, !alias.scope !116, !noalias !117
         store i64 %170, i64* %169, align 1, !dbg !859, !tbaa !118, !alias.scope !116, !noalias !117
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !862
        unreachable, !dbg !862

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %171 = bitcast i8 addrspace(1)* %154 to i64 addrspace(1)*, !dbg !866
          %172 = load i64, i64 addrspace(1)* %171, align 1, !dbg !866, !tbaa !251
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %173 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !873
          store i64 %172, i64 addrspace(3)* %173, align 1, !dbg !873, !tbaa !879
          br label %L150, !dbg !873

L150:                                             ; preds = %L146
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ Base.jl:37 within `getproperty`
        %174 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !881
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %175 = load i64, i64 addrspace(5)* %174, align 8, !dbg !883, !tbaa !96, !alias.scope !100, !noalias !103
        %176 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %175, i64 0, i32 3), !dbg !883
        br label %L152, !dbg !883

L152:                                             ; preds = %L150, %L88
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !885
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %177 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !887
          %178 = load i64, i64 addrspace(3)* %177, align 1, !dbg !887, !tbaa !879
; │││││└└└
       br label %L156, !dbg !893

L156:                                             ; preds = %L152
; │││└└
     br label %L157, !dbg !740

L157:                                             ; preds = %L156
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
     br label %L158, !dbg !606

L158:                                             ; preds = %L157
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:6 within `malloc`
    br label %L160, !dbg !894

L160:                                             ; preds = %L158
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %179 = inttoptr i64 %178 to i8 addrspace(1)*, !dbg !895
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:49 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %180 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !896
; │└
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %181 = icmp eq i64 %180, 0, !dbg !898
    %182 = zext i1 %181 to i8, !dbg !898
; ││ @ int.jl:492 within `==`
; ││┌ @ bool.jl:38 within `&`
     %183 = trunc i8 %182 to i1, !dbg !900
     %184 = and i1 true, %183, !dbg !900
; │└└
   %185 = zext i1 %184 to i8, !dbg !897
   %186 = trunc i8 %185 to i1, !dbg !897
   %187 = xor i1 %186, true, !dbg !897
   br i1 %187, label %L222, label %L165, !dbg !897

L165:                                             ; preds = %L160
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i12 = call [5 x i64] @julia.gpu.state_getter(), !dbg !901
       store [5 x i64] %state.i12, [5 x i64] addrspace(5)* %3, align 8, !dbg !901
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %188 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !909
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %189 = load i64, i64 addrspace(5)* %188, align 8, !dbg !910, !tbaa !96, !alias.scope !100, !noalias !103
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %190 = inttoptr i64 %189 to { i64, i8 addrspace(1)*, i64 }*, !dbg !911
     %191 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %190, i64 0, !dbg !911
     %192 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to i8 addrspace(5)*, !dbg !911
     %193 = bitcast { i64, i8 addrspace(1)*, i64 }* %191 to i8*, !dbg !911
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %192, i8* %193, i64 24, i1 false), !dbg !911, !tbaa !221, !alias.scope !222, !noalias !223
     %194 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, align 8, !dbg !911
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %195 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !914, !range !140
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %196 = add i32 %195, 1, !dbg !924
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %197 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !926, !range !140
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %198 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !930, !range !140
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %199 = zext i32 %196 to i64, !dbg !934
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %200 = icmp eq i64 %199, 1, !dbg !942
        %201 = zext i1 %200 to i8, !dbg !942
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %202 = trunc i8 %201 to i1, !dbg !943
         %203 = and i1 true, %202, !dbg !943
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %204 = xor i1 %203, true, !dbg !944
; ││││└└
      %205 = zext i1 %204 to i8, !dbg !919
      %206 = trunc i8 %205 to i1, !dbg !919
      %207 = xor i1 %206, true, !dbg !919
      br i1 %207, label %L183, label %L182, !dbg !919

L182:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L205, !dbg !945

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %208 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 0, !dbg !946
; ││││└
      br label %L185, !dbg !947

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %209 = load i64, i64 addrspace(5)* %208, align 8, !dbg !948, !tbaa !96, !alias.scope !100, !noalias !103
        %210 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %209, i64 0, i64 1, i32 4), !dbg !948
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %211 = icmp eq i64 %210, 0, !dbg !951
        %212 = zext i1 %211 to i8, !dbg !951
; │││││└
       %213 = trunc i8 %212 to i1, !dbg !952
       %214 = xor i1 %213, true, !dbg !952
       br i1 %214, label %L189, label %L188, !dbg !952

L188:                                             ; preds = %L185
       br label %L203, !dbg !952

L189:                                             ; preds = %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %215 = icmp eq i64 %210, 5, !dbg !953
        %216 = zext i1 %215 to i8, !dbg !953
; │││││└
       %217 = trunc i8 %216 to i1, !dbg !954
       %218 = xor i1 %217, true, !dbg !954
       br i1 %218, label %L193, label %L192, !dbg !954

L192:                                             ; preds = %L189
       br label %L196, !dbg !954

L193:                                             ; preds = %L189
; │││││┌ @ promotion.jl:499 within `==`
        %219 = icmp eq i64 %210, 6, !dbg !953
        %220 = zext i1 %219 to i8, !dbg !953
; │││││└
       %221 = trunc i8 %220 to i1, !dbg !954
       %222 = xor i1 %221, true, !dbg !954
       br i1 %222, label %L201, label %L196, !dbg !954

L196:                                             ; preds = %L193, %L192
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i11 = call [5 x i64] @julia.gpu.state_getter(), !dbg !955
           store [5 x i64] %state.i11, [5 x i64] addrspace(5)* %15, align 8, !dbg !955
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %223 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %15, i32 0, i32 0, !dbg !961
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %224 = load i64, i64 addrspace(5)* %223, align 8, !dbg !962, !tbaa !96, !alias.scope !100, !noalias !103
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %225 = inttoptr i64 %224 to i64*, !dbg !963
         %226 = getelementptr inbounds i64, i64* %225, i64 0, !dbg !963
         %227 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !963, !tbaa !112, !alias.scope !116, !noalias !117
         store i64 %227, i64* %226, align 1, !dbg !963, !tbaa !118, !alias.scope !116, !noalias !117
         br label %L201, !dbg !963

L201:                                             ; preds = %L196, %L193
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !966
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !968

L203:                                             ; preds = %L188
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L204, !dbg !950

L204:                                             ; preds = %L203
       br label %L205, !dbg !950

L205:                                             ; preds = %L204, %L182
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !969
; ││││└
; ││││ @ none within `macro expansion`
      br label %L207, !dbg !920

L207:                                             ; preds = %L205
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
     br label %L208, !dbg !922

L208:                                             ; preds = %L207
; ││└
; ││┌ @ Base.jl:37 within `getproperty`
     %228 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !971
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %229 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %228, align 8, !dbg !972, !tbaa !96, !alias.scope !100, !noalias !103
       %230 = ptrtoint i8 addrspace(1)* %229 to i64, !dbg !972
; │││└└
     %231 = addrspacecast i8 addrspace(1)* %229 to i8*, !dbg !974
     %232 = getelementptr i8, i8* %231, i64 0, !dbg !974
     %233 = ptrtoint i8* %232 to i64, !dbg !974
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %234 = addrspacecast i8* %232 to i8 addrspace(1)*, !dbg !975
; ││└└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %234, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @4, i32 0, i32 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !978
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %235 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !971
; ││└
; ││┌ @ essentials.jl:513 within `reinterpret`
     %236 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %235, align 8, !dbg !982, !tbaa !96, !alias.scope !100, !noalias !103
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %237 = getelementptr inbounds i8, i8 addrspace(1)* %236, i64 41, !dbg !983
       store i8 0, i8 addrspace(1)* %237, align 1, !dbg !983, !tbaa !251
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %238 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !988
     call fastcc void @julia_hostcall_device_trigger_and_return__2222({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %238) #0, !dbg !988
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !736

L222:                                             ; preds = %L160
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:54 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %179, i8 addrspace(1)* %23, i64 %26, i1 false), !dbg !990
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:56 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %239 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !994
; ││└└
    %240 = addrspacecast i8 addrspace(1)* %179 to i8*, !dbg !996
    %241 = getelementptr i8, i8* %240, i64 %26, !dbg !996
    %242 = ptrtoint i8* %241 to i64, !dbg !996
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %243 = addrspacecast i8* %241 to i8 addrspace(1)*, !dbg !998
; │└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %243, align 1, !dbg !1001, !tbaa !251
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %244 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !1007
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !736

L231:                                             ; preds = %L222, %L208
       %value_phi1 = phi i64 [ 0, %L208 ], [ %244, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:67 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:186 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i10 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1009
      store [5 x i64] %state.i10, [5 x i64] addrspace(5)* %5, align 8, !dbg !1009
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %245 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %5, i32 0, i32 2, !dbg !1016
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %246 = load i64, i64 addrspace(5)* %245, align 8, !dbg !1017, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %247 = inttoptr i64 %246 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1018
    %248 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %247, i64 0, !dbg !1018
    %249 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6 to i8 addrspace(5)*, !dbg !1018
    %250 = bitcast { i64, i8 addrspace(1)*, i64 }* %248 to i8*, !dbg !1018
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %249, i8* %250, i64 24, i1 false), !dbg !1018, !tbaa !221, !alias.scope !222, !noalias !223
    %251 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, align 8, !dbg !1018
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:187 within `macro expansion`
; │┌ @ Base.jl:37 within `getproperty`
    %252 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 1, !dbg !1020
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %253 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %252, align 8, !dbg !1022, !tbaa !96, !alias.scope !100, !noalias !103
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:192 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %254 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1023, !range !140
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %255 = add i32 %254, 1, !dbg !1033
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %256 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1035, !range !140
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %257 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1039, !range !140
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %258 = zext i32 %255 to i64, !dbg !1043
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %259 = icmp eq i64 %258, 1, !dbg !1051
       %260 = zext i1 %259 to i8, !dbg !1051
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %261 = trunc i8 %260 to i1, !dbg !1052
        %262 = and i1 true, %261, !dbg !1052
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %263 = xor i1 %262, true, !dbg !1053
; │││└└
     %264 = zext i1 %263 to i8, !dbg !1028
     %265 = trunc i8 %264 to i1, !dbg !1028
     %266 = xor i1 %265, true, !dbg !1028
     br i1 %266, label %L254, label %L253, !dbg !1028

L253:                                             ; preds = %L231
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L276, !dbg !1054

L254:                                             ; preds = %L231
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ Base.jl:37 within `getproperty`
      %267 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !1055
; │││└
     br label %L256, !dbg !1056

L256:                                             ; preds = %L272, %L254
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %268 = load i64, i64 addrspace(5)* %267, align 8, !dbg !1057, !tbaa !96, !alias.scope !100, !noalias !103
       %269 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %268, i64 0, i64 1, i32 4), !dbg !1057
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %270 = icmp eq i64 %269, 0, !dbg !1060
       %271 = zext i1 %270 to i8, !dbg !1060
; ││││└
      %272 = trunc i8 %271 to i1, !dbg !1061
      %273 = xor i1 %272, true, !dbg !1061
      br i1 %273, label %L260, label %L259, !dbg !1061

L259:                                             ; preds = %L256
      br label %L274, !dbg !1061

L260:                                             ; preds = %L256
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %274 = icmp eq i64 %269, 5, !dbg !1062
       %275 = zext i1 %274 to i8, !dbg !1062
; ││││└
      %276 = trunc i8 %275 to i1, !dbg !1063
      %277 = xor i1 %276, true, !dbg !1063
      br i1 %277, label %L264, label %L263, !dbg !1063

L263:                                             ; preds = %L260
      br label %L267, !dbg !1063

L264:                                             ; preds = %L260
; ││││┌ @ promotion.jl:499 within `==`
       %278 = icmp eq i64 %269, 6, !dbg !1062
       %279 = zext i1 %278 to i8, !dbg !1062
; ││││└
      %280 = trunc i8 %279 to i1, !dbg !1063
      %281 = xor i1 %280, true, !dbg !1063
      br i1 %281, label %L272, label %L267, !dbg !1063

L267:                                             ; preds = %L264, %L263
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i9 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1064
          store [5 x i64] %state.i9, [5 x i64] addrspace(5)* %14, align 8, !dbg !1064
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %282 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %14, i32 0, i32 0, !dbg !1070
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %283 = load i64, i64 addrspace(5)* %282, align 8, !dbg !1071, !tbaa !96, !alias.scope !100, !noalias !103
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %284 = inttoptr i64 %283 to i64*, !dbg !1072
        %285 = getelementptr inbounds i64, i64* %284, i64 0, !dbg !1072
        %286 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1072, !tbaa !112, !alias.scope !116, !noalias !117
        store i64 %286, i64* %285, align 1, !dbg !1072, !tbaa !118, !alias.scope !116, !noalias !117
        br label %L272, !dbg !1072

L272:                                             ; preds = %L267, %L264
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1075
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L256, !dbg !1077

L274:                                             ; preds = %L259
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L275, !dbg !1059

L275:                                             ; preds = %L274
      br label %L276, !dbg !1059

L276:                                             ; preds = %L275, %L253
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1078
; │││└
; │││ @ none within `macro expansion`
     br label %L278, !dbg !1029

L278:                                             ; preds = %L276
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
    br label %L279, !dbg !1031

L279:                                             ; preds = %L278
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:194 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %287 = bitcast i8 addrspace(1)* %253 to i64 addrspace(1)*, !dbg !1080
      store i64 1, i64 addrspace(1)* %287, align 1, !dbg !1080, !tbaa !251
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %288 = ptrtoint i8 addrspace(1)* %253 to i64, !dbg !1087
; ││└└
    %289 = addrspacecast i8 addrspace(1)* %253 to i8*, !dbg !1089
    %290 = getelementptr i8, i8* %289, i64 8, !dbg !1089
    %291 = ptrtoint i8* %290 to i64, !dbg !1089
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %292 = addrspacecast i8* %290 to i8 addrspace(1)*, !dbg !1091
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:197 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ essentials.jl:513 within `reinterpret`
     %293 = ptrtoint i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([108 x i8], [108 x i8]* @5, i32 0, i32 0) to i8 addrspace(1)*) to i64, !dbg !1094
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %294 = bitcast i8 addrspace(1)* %292 to i64 addrspace(1)*, !dbg !1098
       store i64 %293, i64 addrspace(1)* %294, align 1, !dbg !1098, !tbaa !251
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %295 = ptrtoint i8 addrspace(1)* %292 to i64, !dbg !1104
; │││└└
     %296 = addrspacecast i8 addrspace(1)* %292 to i8*, !dbg !1106
     %297 = getelementptr i8, i8* %296, i64 8, !dbg !1106
     %298 = ptrtoint i8* %297 to i64, !dbg !1106
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %299 = addrspacecast i8* %297 to i8 addrspace(1)*, !dbg !1108
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %300 = bitcast i8 addrspace(1)* %299 to i64 addrspace(1)*, !dbg !1111
       store i64 107, i64 addrspace(1)* %300, align 1, !dbg !1111, !tbaa !251
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:157 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %301 = ptrtoint i8 addrspace(1)* %299 to i64, !dbg !1118
; │││└└
     %302 = addrspacecast i8 addrspace(1)* %299 to i8*, !dbg !1120
     %303 = getelementptr i8, i8* %302, i64 8, !dbg !1120
     %304 = ptrtoint i8* %303 to i64, !dbg !1120
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %305 = addrspacecast i8* %303 to i8 addrspace(1)*, !dbg !1122
; │└└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %306 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1125, !range !140
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %307 = add i32 %306, 1, !dbg !1132
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %308 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1134, !range !140
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %309 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1138, !range !140
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %310 = zext i32 %307 to i64, !dbg !1142
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %311 = icmp eq i64 %310, 1, !dbg !1150
     %312 = zext i1 %311 to i8, !dbg !1150
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %313 = trunc i8 %312 to i1, !dbg !1151
      %314 = and i1 true, %313, !dbg !1151
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %315 = xor i1 %314, true, !dbg !1152
; │└└
   %316 = zext i1 %315 to i8, !dbg !1130
   %317 = trunc i8 %316 to i1, !dbg !1130
   %318 = xor i1 %317, true, !dbg !1130
   br i1 %318, label %L308, label %L307, !dbg !1130

L307:                                             ; preds = %L279
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L323, !dbg !1153

L308:                                             ; preds = %L279
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:162 within `_pointer_from_type`
; │││┌ @ pointer.jl:155 within `pointer_from_objref`
      %319 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* addrspacecast ({}* inttoptr (i64 139925250646112 to {}*) to {} addrspace(11)*)) #12, !dbg !1154
; │││└
; │││┌ @ boot.jl:795 within `UInt64`
      %320 = ptrtoint {}* %319 to i64, !dbg !1161
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %321 = bitcast i8 addrspace(1)* %305 to i64 addrspace(1)*, !dbg !1162
       store i64 %320, i64 addrspace(1)* %321, align 1, !dbg !1162, !tbaa !251
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %322 = ptrtoint i8 addrspace(1)* %305 to i64, !dbg !1168
; │││└└
     %323 = addrspacecast i8 addrspace(1)* %305 to i8*, !dbg !1170
     %324 = getelementptr i8, i8* %323, i64 8, !dbg !1170
     %325 = ptrtoint i8* %324 to i64, !dbg !1170
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %326 = addrspacecast i8* %324 to i8 addrspace(1)*, !dbg !1172
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %327 = bitcast i8 addrspace(1)* %326 to i64 addrspace(1)*, !dbg !1175
       store i64 %value_phi1, i64 addrspace(1)* %327, align 1, !dbg !1175, !tbaa !251
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %328 = ptrtoint i8 addrspace(1)* %326 to i64, !dbg !1182
; │││└└
     %329 = addrspacecast i8 addrspace(1)* %326 to i8*, !dbg !1184
     %330 = getelementptr i8, i8* %329, i64 8, !dbg !1184
     %331 = ptrtoint i8* %330 to i64, !dbg !1184
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %332 = addrspacecast i8* %330 to i8 addrspace(1)*, !dbg !1186
; │└└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %333 = bitcast i8 addrspace(1)* %332 to i64 addrspace(1)*, !dbg !1189
      store i64 0, i64 addrspace(1)* %333, align 1, !dbg !1189, !tbaa !251
      br label %L323, !dbg !1189

L323:                                             ; preds = %L308, %L307
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !1195
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:200 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %334 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1197, !range !140
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %335 = add i32 %334, 1, !dbg !1206
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %336 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1208, !range !140
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %337 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1212, !range !140
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %338 = zext i32 %335 to i64, !dbg !1216
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %339 = icmp eq i64 %338, 1, !dbg !1224
       %340 = zext i1 %339 to i8, !dbg !1224
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %341 = trunc i8 %340 to i1, !dbg !1225
        %342 = and i1 true, %341, !dbg !1225
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %343 = xor i1 %342, true, !dbg !1226
; │││└└
     %344 = zext i1 %343 to i8, !dbg !1202
     %345 = trunc i8 %344 to i1, !dbg !1202
     %346 = xor i1 %345, true, !dbg !1202
     br i1 %346, label %L337, label %L336, !dbg !1202

L336:                                             ; preds = %L323
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L379, !dbg !1227

L337:                                             ; preds = %L323
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ Base.jl:37 within `getproperty`
      %347 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !1228
      br label %L338, !dbg !1228

L338:                                             ; preds = %L354, %L337
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %348 = load i64, i64 addrspace(5)* %347, align 8, !dbg !1230, !tbaa !96, !alias.scope !100, !noalias !103
       %349 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %348, i64 1, i64 2, i32 4), !dbg !1230
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %350 = icmp eq i64 %349, 1, !dbg !1233
       %351 = zext i1 %350 to i8, !dbg !1233
; ││││└
      %352 = trunc i8 %351 to i1, !dbg !1234
      %353 = xor i1 %352, true, !dbg !1234
      br i1 %353, label %L342, label %L341, !dbg !1234

L341:                                             ; preds = %L338
      br label %L356, !dbg !1234

L342:                                             ; preds = %L338
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %354 = icmp eq i64 %349, 5, !dbg !1235
       %355 = zext i1 %354 to i8, !dbg !1235
; ││││└
      %356 = trunc i8 %355 to i1, !dbg !1236
      %357 = xor i1 %356, true, !dbg !1236
      br i1 %357, label %L346, label %L345, !dbg !1236

L345:                                             ; preds = %L342
      br label %L349, !dbg !1236

L346:                                             ; preds = %L342
; ││││┌ @ promotion.jl:499 within `==`
       %358 = icmp eq i64 %349, 6, !dbg !1235
       %359 = zext i1 %358 to i8, !dbg !1235
; ││││└
      %360 = trunc i8 %359 to i1, !dbg !1236
      %361 = xor i1 %360, true, !dbg !1236
      br i1 %361, label %L354, label %L349, !dbg !1236

L349:                                             ; preds = %L346, %L345
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i8 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1237
          store [5 x i64] %state.i8, [5 x i64] addrspace(5)* %13, align 8, !dbg !1237
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %362 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %13, i32 0, i32 0, !dbg !1243
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %363 = load i64, i64 addrspace(5)* %362, align 8, !dbg !1244, !tbaa !96, !alias.scope !100, !noalias !103
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %364 = inttoptr i64 %363 to i64*, !dbg !1245
        %365 = getelementptr inbounds i64, i64* %364, i64 0, !dbg !1245
        %366 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1245, !tbaa !112, !alias.scope !116, !noalias !117
        store i64 %366, i64* %365, align 1, !dbg !1245, !tbaa !118, !alias.scope !116, !noalias !117
        br label %L354, !dbg !1245

L354:                                             ; preds = %L349, %L346
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1248
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L338, !dbg !1250

L356:                                             ; preds = %L341
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L357, !dbg !1232

L357:                                             ; preds = %L356
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ Base.jl:37 within `getproperty`
      %367 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !1251
      br label %L358, !dbg !1251

L358:                                             ; preds = %L374, %L357
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %368 = load i64, i64 addrspace(5)* %367, align 8, !dbg !1253, !tbaa !96, !alias.scope !100, !noalias !103
       %369 = call fastcc i64 @__ockl_hsa_signal_load(i64 %368, i32 2), !dbg !1253
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:499 within `==`
       %370 = icmp eq i64 %369, 4, !dbg !1256
       %371 = zext i1 %370 to i8, !dbg !1256
; ││││└
      %372 = trunc i8 %371 to i1, !dbg !1257
      %373 = xor i1 %372, true, !dbg !1257
      br i1 %373, label %L362, label %L361, !dbg !1257

L361:                                             ; preds = %L358
      br label %L376, !dbg !1257

L362:                                             ; preds = %L358
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││┌ @ promotion.jl:499 within `==`
       %374 = icmp eq i64 %369, 5, !dbg !1258
       %375 = zext i1 %374 to i8, !dbg !1258
; ││││└
      %376 = trunc i8 %375 to i1, !dbg !1259
      %377 = xor i1 %376, true, !dbg !1259
      br i1 %377, label %L366, label %L365, !dbg !1259

L365:                                             ; preds = %L362
      br label %L369, !dbg !1259

L366:                                             ; preds = %L362
; ││││┌ @ promotion.jl:499 within `==`
       %378 = icmp eq i64 %369, 6, !dbg !1258
       %379 = zext i1 %378 to i8, !dbg !1258
; ││││└
      %380 = trunc i8 %379 to i1, !dbg !1259
      %381 = xor i1 %380, true, !dbg !1259
      br i1 %381, label %L374, label %L369, !dbg !1259

L369:                                             ; preds = %L366, %L365
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i7 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1260
          store [5 x i64] %state.i7, [5 x i64] addrspace(5)* %12, align 8, !dbg !1260
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %382 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %12, i32 0, i32 0, !dbg !1266
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %383 = load i64, i64 addrspace(5)* %382, align 8, !dbg !1267, !tbaa !96, !alias.scope !100, !noalias !103
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %384 = inttoptr i64 %383 to i64*, !dbg !1268
        %385 = getelementptr inbounds i64, i64* %384, i64 0, !dbg !1268
        %386 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1268, !tbaa !112, !alias.scope !116, !noalias !117
        store i64 %386, i64* %385, align 1, !dbg !1268, !tbaa !118, !alias.scope !116, !noalias !117
        br label %L374, !dbg !1268

L374:                                             ; preds = %L369, %L366
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1271
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L358, !dbg !1273

L376:                                             ; preds = %L361
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
      br label %L377, !dbg !1255

L377:                                             ; preds = %L376
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ Base.jl:37 within `getproperty`
      %387 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !1274
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %388 = load i64, i64 addrspace(5)* %387, align 8, !dbg !1276, !tbaa !96, !alias.scope !100, !noalias !103
      %389 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %388, i64 0, i32 3), !dbg !1276
      br label %L379, !dbg !1276

L379:                                             ; preds = %L377, %L336
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1278
; │││└
; │││ @ none within `macro expansion`
     br label %L381, !dbg !1203

L381:                                             ; preds = %L379
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
    br label %L382, !dbg !1205

L382:                                             ; preds = %L381
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i5 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1280
      store [5 x i64] %state.i5, [5 x i64] addrspace(5)* %7, align 8, !dbg !1280
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %390 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %7, i32 0, i32 4, !dbg !1288
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %391 = load i64, i64 addrspace(5)* %390, align 8, !dbg !1289, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %392 = inttoptr i64 %391 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1290
    %393 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %392, i64 0, !dbg !1290
    %394 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8 to i8 addrspace(5)*, !dbg !1290
    %395 = bitcast { i64, i8 addrspace(1)*, i64 }* %393 to i8*, !dbg !1290
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %394, i8* %395, i64 24, i1 false), !dbg !1290, !tbaa !221, !alias.scope !222, !noalias !223
    %396 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, align 8, !dbg !1290
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %397 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1292, !range !140
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %398 = add i32 %397, 1, !dbg !1303
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %399 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1305, !range !140
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %400 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1309, !range !140
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %401 = zext i32 %398 to i64, !dbg !1313
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %402 = icmp eq i64 %401, 1, !dbg !1321
        %403 = zext i1 %402 to i8, !dbg !1321
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %404 = trunc i8 %403 to i1, !dbg !1322
         %405 = and i1 true, %404, !dbg !1322
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %406 = xor i1 %405, true, !dbg !1323
; ││││└└
      %407 = zext i1 %406 to i8, !dbg !1297
      %408 = trunc i8 %407 to i1, !dbg !1297
      %409 = xor i1 %408, true, !dbg !1297
      br i1 %409, label %L401, label %L400, !dbg !1297

L400:                                             ; preds = %L382
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L423, !dbg !1324

L401:                                             ; preds = %L382
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %410 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1325
; ││││└
      br label %L403, !dbg !1326

L403:                                             ; preds = %L419, %L401
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %411 = load i64, i64 addrspace(5)* %410, align 8, !dbg !1327, !tbaa !96, !alias.scope !100, !noalias !103
        %412 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %411, i64 0, i64 1, i32 4), !dbg !1327
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %413 = icmp eq i64 %412, 0, !dbg !1330
        %414 = zext i1 %413 to i8, !dbg !1330
; │││││└
       %415 = trunc i8 %414 to i1, !dbg !1331
       %416 = xor i1 %415, true, !dbg !1331
       br i1 %416, label %L407, label %L406, !dbg !1331

L406:                                             ; preds = %L403
       br label %L421, !dbg !1331

L407:                                             ; preds = %L403
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %417 = icmp eq i64 %412, 5, !dbg !1332
        %418 = zext i1 %417 to i8, !dbg !1332
; │││││└
       %419 = trunc i8 %418 to i1, !dbg !1333
       %420 = xor i1 %419, true, !dbg !1333
       br i1 %420, label %L411, label %L410, !dbg !1333

L410:                                             ; preds = %L407
       br label %L414, !dbg !1333

L411:                                             ; preds = %L407
; │││││┌ @ promotion.jl:499 within `==`
        %421 = icmp eq i64 %412, 6, !dbg !1332
        %422 = zext i1 %421 to i8, !dbg !1332
; │││││└
       %423 = trunc i8 %422 to i1, !dbg !1333
       %424 = xor i1 %423, true, !dbg !1333
       br i1 %424, label %L419, label %L414, !dbg !1333

L414:                                             ; preds = %L411, %L410
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i4 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1334
           store [5 x i64] %state.i4, [5 x i64] addrspace(5)* %11, align 8, !dbg !1334
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %425 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %11, i32 0, i32 0, !dbg !1340
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %426 = load i64, i64 addrspace(5)* %425, align 8, !dbg !1341, !tbaa !96, !alias.scope !100, !noalias !103
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %427 = inttoptr i64 %426 to i64*, !dbg !1342
         %428 = getelementptr inbounds i64, i64* %427, i64 0, !dbg !1342
         %429 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1342, !tbaa !112, !alias.scope !116, !noalias !117
         store i64 %429, i64* %428, align 1, !dbg !1342, !tbaa !118, !alias.scope !116, !noalias !117
         br label %L419, !dbg !1342

L419:                                             ; preds = %L414, %L411
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1345
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L403, !dbg !1347

L421:                                             ; preds = %L406
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L422, !dbg !1329

L422:                                             ; preds = %L421
       br label %L423, !dbg !1329

L423:                                             ; preds = %L422, %L400
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1348
; ││││└
; ││││ @ none within `macro expansion`
      br label %L425, !dbg !1298

L425:                                             ; preds = %L423
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %430 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1350, !range !140
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %431 = add i32 %430, 1, !dbg !1359
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %432 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1361, !range !140
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %433 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1365, !range !140
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %434 = zext i32 %431 to i64, !dbg !1369
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %435 = icmp eq i64 %434, 1, !dbg !1377
        %436 = zext i1 %435 to i8, !dbg !1377
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %437 = trunc i8 %436 to i1, !dbg !1378
         %438 = and i1 true, %437, !dbg !1378
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %439 = xor i1 %438, true, !dbg !1379
; ││││└└
      %440 = zext i1 %439 to i8, !dbg !1355
      %441 = trunc i8 %440 to i1, !dbg !1355
      %442 = xor i1 %441, true, !dbg !1355
      br i1 %442, label %L438, label %L437, !dbg !1355

L437:                                             ; preds = %L425
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L448, !dbg !1380

L438:                                             ; preds = %L425
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ Base.jl:37 within `getproperty`
       %443 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 1, !dbg !1381
; ││││└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %444 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %443, align 8, !dbg !1383, !tbaa !96, !alias.scope !100, !noalias !103
         %445 = ptrtoint i8 addrspace(1)* %444 to i64, !dbg !1383
; │││││└└
       %446 = addrspacecast i8 addrspace(1)* %444 to i8*, !dbg !1385
       %447 = getelementptr i8, i8* %446, i64 1, !dbg !1385
       %448 = ptrtoint i8* %447 to i64, !dbg !1385
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %449 = addrspacecast i8* %447 to i8 addrspace(1)*, !dbg !1386
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %450 = ptrtoint i8 addrspace(1)* %449 to i64, !dbg !1389
; │││││└└
       %451 = addrspacecast i8 addrspace(1)* %449 to i8*, !dbg !1391
       %452 = getelementptr i8, i8* %451, i64 -1, !dbg !1391
       %453 = ptrtoint i8* %452 to i64, !dbg !1391
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %454 = addrspacecast i8* %452 to i8 addrspace(1)*, !dbg !1392
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %455 = bitcast i8 addrspace(1)* %454 to i64 addrspace(1)*, !dbg !1395
         store i64 %value_phi1, i64 addrspace(1)* %455, align 1, !dbg !1395, !tbaa !251
         br label %L448, !dbg !1395

L448:                                             ; preds = %L438, %L437
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1401
; ││││└
; ││││ @ none within `macro expansion`
      br label %L450, !dbg !1356

L450:                                             ; preds = %L448
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %456 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1403, !range !140
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %457 = add i32 %456, 1, !dbg !1412
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %458 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1414, !range !140
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %459 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1418, !range !140
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %460 = zext i32 %457 to i64, !dbg !1422
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %461 = icmp eq i64 %460, 1, !dbg !1430
        %462 = zext i1 %461 to i8, !dbg !1430
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %463 = trunc i8 %462 to i1, !dbg !1431
         %464 = and i1 true, %463, !dbg !1431
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %465 = xor i1 %464, true, !dbg !1432
; ││││└└
      %466 = zext i1 %465 to i8, !dbg !1408
      %467 = trunc i8 %466 to i1, !dbg !1408
      %468 = xor i1 %467, true, !dbg !1408
      br i1 %468, label %L463, label %L462, !dbg !1408

L462:                                             ; preds = %L450
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L505, !dbg !1433

L463:                                             ; preds = %L450
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ Base.jl:37 within `getproperty`
       %469 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1434
       br label %L464, !dbg !1434

L464:                                             ; preds = %L480, %L463
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %470 = load i64, i64 addrspace(5)* %469, align 8, !dbg !1436, !tbaa !96, !alias.scope !100, !noalias !103
        %471 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %470, i64 1, i64 2, i32 4), !dbg !1436
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %472 = icmp eq i64 %471, 1, !dbg !1439
        %473 = zext i1 %472 to i8, !dbg !1439
; │││││└
       %474 = trunc i8 %473 to i1, !dbg !1440
       %475 = xor i1 %474, true, !dbg !1440
       br i1 %475, label %L468, label %L467, !dbg !1440

L467:                                             ; preds = %L464
       br label %L482, !dbg !1440

L468:                                             ; preds = %L464
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %476 = icmp eq i64 %471, 5, !dbg !1441
        %477 = zext i1 %476 to i8, !dbg !1441
; │││││└
       %478 = trunc i8 %477 to i1, !dbg !1442
       %479 = xor i1 %478, true, !dbg !1442
       br i1 %479, label %L472, label %L471, !dbg !1442

L471:                                             ; preds = %L468
       br label %L475, !dbg !1442

L472:                                             ; preds = %L468
; │││││┌ @ promotion.jl:499 within `==`
        %480 = icmp eq i64 %471, 6, !dbg !1441
        %481 = zext i1 %480 to i8, !dbg !1441
; │││││└
       %482 = trunc i8 %481 to i1, !dbg !1442
       %483 = xor i1 %482, true, !dbg !1442
       br i1 %483, label %L480, label %L475, !dbg !1442

L475:                                             ; preds = %L472, %L471
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i3 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1443
           store [5 x i64] %state.i3, [5 x i64] addrspace(5)* %10, align 8, !dbg !1443
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %484 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %10, i32 0, i32 0, !dbg !1449
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %485 = load i64, i64 addrspace(5)* %484, align 8, !dbg !1450, !tbaa !96, !alias.scope !100, !noalias !103
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %486 = inttoptr i64 %485 to i64*, !dbg !1451
         %487 = getelementptr inbounds i64, i64* %486, i64 0, !dbg !1451
         %488 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1451, !tbaa !112, !alias.scope !116, !noalias !117
         store i64 %488, i64* %487, align 1, !dbg !1451, !tbaa !118, !alias.scope !116, !noalias !117
         br label %L480, !dbg !1451

L480:                                             ; preds = %L475, %L472
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1454
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L464, !dbg !1456

L482:                                             ; preds = %L467
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L483, !dbg !1438

L483:                                             ; preds = %L482
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ Base.jl:37 within `getproperty`
       %489 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1457
       br label %L484, !dbg !1457

L484:                                             ; preds = %L500, %L483
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %490 = load i64, i64 addrspace(5)* %489, align 8, !dbg !1459, !tbaa !96, !alias.scope !100, !noalias !103
        %491 = call fastcc i64 @__ockl_hsa_signal_load(i64 %490, i32 2), !dbg !1459
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:499 within `==`
        %492 = icmp eq i64 %491, 4, !dbg !1462
        %493 = zext i1 %492 to i8, !dbg !1462
; │││││└
       %494 = trunc i8 %493 to i1, !dbg !1463
       %495 = xor i1 %494, true, !dbg !1463
       br i1 %495, label %L488, label %L487, !dbg !1463

L487:                                             ; preds = %L484
       br label %L502, !dbg !1463

L488:                                             ; preds = %L484
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; │││││┌ @ promotion.jl:499 within `==`
        %496 = icmp eq i64 %491, 5, !dbg !1464
        %497 = zext i1 %496 to i8, !dbg !1464
; │││││└
       %498 = trunc i8 %497 to i1, !dbg !1465
       %499 = xor i1 %498, true, !dbg !1465
       br i1 %499, label %L492, label %L491, !dbg !1465

L491:                                             ; preds = %L488
       br label %L495, !dbg !1465

L492:                                             ; preds = %L488
; │││││┌ @ promotion.jl:499 within `==`
        %500 = icmp eq i64 %491, 6, !dbg !1464
        %501 = zext i1 %500 to i8, !dbg !1464
; │││││└
       %502 = trunc i8 %501 to i1, !dbg !1465
       %503 = xor i1 %502, true, !dbg !1465
       br i1 %503, label %L500, label %L495, !dbg !1465

L495:                                             ; preds = %L492, %L491
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !1466
           store [5 x i64] %state.i, [5 x i64] addrspace(5)* %9, align 8, !dbg !1466
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %504 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %9, i32 0, i32 0, !dbg !1472
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %505 = load i64, i64 addrspace(5)* %504, align 8, !dbg !1473, !tbaa !96, !alias.scope !100, !noalias !103
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %506 = inttoptr i64 %505 to i64*, !dbg !1474
         %507 = getelementptr inbounds i64, i64* %506, i64 0, !dbg !1474
         %508 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1474, !tbaa !112, !alias.scope !116, !noalias !117
         store i64 %508, i64* %507, align 1, !dbg !1474, !tbaa !118, !alias.scope !116, !noalias !117
         br label %L500, !dbg !1474

L500:                                             ; preds = %L495, %L492
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1477
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L484, !dbg !1479

L502:                                             ; preds = %L487
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
       br label %L503, !dbg !1461

L503:                                             ; preds = %L502
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ Base.jl:37 within `getproperty`
       %509 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1480
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       %510 = load i64, i64 addrspace(5)* %509, align 8, !dbg !1482, !tbaa !96, !alias.scope !100, !noalias !103
       %511 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %510, i64 0, i32 3), !dbg !1482
       br label %L505, !dbg !1482

L505:                                             ; preds = %L503, %L462
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1484
; ││││└
; ││││ @ none within `macro expansion`
      br label %L507, !dbg !1409

L507:                                             ; preds = %L505
; ││└└
    br label %L508, !dbg !1411

L508:                                             ; preds = %L507
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
    br label %L509, !dbg !1301

L509:                                             ; preds = %L508
; │└
   br label %L510, !dbg !1302

L510:                                             ; preds = %L509
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:72 within `report_exception`
  ret void, !dbg !1486
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:30 within `signal_exception`
define internal fastcc void @gpu_signal_exception() unnamed_addr #0 !dbg !1487 {
top:
  %0 = alloca [5 x i64], align 8, addrspace(5)
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !1488
     store [5 x i64] %state.i, [5 x i64] addrspace(5)* %0, align 8, !dbg !1488
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %4 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !1497
; │└
; │┌ @ pointer.jl:30 within `convert`
    %5 = load i64, i64 addrspace(5)* %4, align 8, !dbg !1499, !tbaa !96, !alias.scope !100, !noalias !103
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
   %6 = inttoptr i64 %5 to i64*, !dbg !1501
   %7 = getelementptr inbounds i64, i64* %6, i64 0, !dbg !1501
   %8 = load i64, i64 addrspace(1)* @_j_const1.3, align 1, !dbg !1501, !tbaa !112, !alias.scope !116, !noalias !117
   store i64 %8, i64* %7, align 1, !dbg !1501, !tbaa !118, !alias.scope !116, !noalias !117
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `signal_exception`
  ret void, !dbg !1505
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2222({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #0 !dbg !1506 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %4 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1507, !range !140
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %5 = add i32 %4, 1, !dbg !1522
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %6 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1525, !range !140
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %7 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1530, !range !140
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %8 = zext i32 %5 to i64, !dbg !1535
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %9 = icmp eq i64 %8, 1, !dbg !1551
     %10 = zext i1 %9 to i8, !dbg !1551
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %11 = trunc i8 %10 to i1, !dbg !1552
      %12 = and i1 true, %11, !dbg !1552
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %13 = xor i1 %12, true, !dbg !1554
; │└└
   %14 = zext i1 %13 to i8, !dbg !1517
   %15 = trunc i8 %14 to i1, !dbg !1517
   %16 = xor i1 %15, true, !dbg !1517
   br i1 %16, label %L15, label %L14, !dbg !1517

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L21, !dbg !1556

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %17 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !1557
; │└
   %18 = load i64, i64 addrspace(11)* %17, align 8, !dbg !1559, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
   call fastcc void @julia_hostcall_device_signal_wait_cas__2232(i64 zeroext %18, i64 signext 1, i64 signext 2) #0, !dbg !1559
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │┌ @ Base.jl:37 within `getproperty`
    %19 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !1560
; │└
   %20 = load i64, i64 addrspace(11)* %19, align 8, !dbg !1561, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
   call fastcc void @julia_hostcall_device_signal_wait_2229(i64 zeroext %20, i64 signext 4) #0, !dbg !1561
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ Base.jl:37 within `getproperty`
    %21 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !1562
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    %22 = load i64, i64 addrspace(11)* %21, align 8, !dbg !1564, !tbaa !183, !invariant.load !66, !alias.scope !185, !noalias !186
    %23 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %22, i64 0, i32 3) [ "jl_roots"(i64 addrspace(11)* %21) ], !dbg !1564
    br label %L21, !dbg !1564

L21:                                              ; preds = %L15, %L14
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !1567
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !1519
; └
}

; Function Attrs: nounwind readnone
declare nonnull {}* @julia.pointer_from_objref({} addrspace(11)*) local_unnamed_addr #12

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2232(i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #0 !dbg !1570 {
top:
  %3 = alloca [5 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -13
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 14
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %7 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !1571
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %8 = icmp eq i64 %7, %1, !dbg !1576
   %9 = zext i1 %8 to i8, !dbg !1576
; └
  %10 = trunc i8 %9 to i1, !dbg !1578
  %11 = xor i1 %10, true, !dbg !1578
  br i1 %11, label %L6, label %L5, !dbg !1578

L5:                                               ; preds = %L2
  br label %L20, !dbg !1578

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ┌ @ promotion.jl:499 within `==`
   %12 = icmp eq i64 %7, 5, !dbg !1579
   %13 = zext i1 %12 to i8, !dbg !1579
; └
  %14 = trunc i8 %13 to i1, !dbg !1580
  %15 = xor i1 %14, true, !dbg !1580
  br i1 %15, label %L10, label %L9, !dbg !1580

L9:                                               ; preds = %L6
  br label %L13, !dbg !1580

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %16 = icmp eq i64 %7, 6, !dbg !1579
   %17 = zext i1 %16 to i8, !dbg !1579
; └
  %18 = trunc i8 %17 to i1, !dbg !1580
  %19 = xor i1 %18, true, !dbg !1580
  br i1 %19, label %L18, label %L13, !dbg !1580

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !1581
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %3, align 8, !dbg !1581
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %20 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !1592
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %21 = load i64, i64 addrspace(5)* %20, align 8, !dbg !1594, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %22 = inttoptr i64 %21 to i64*, !dbg !1596
    %23 = getelementptr inbounds i64, i64* %22, i64 0, !dbg !1596
    %24 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1596, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %24, i64* %23, align 1, !dbg !1596, !tbaa !118, !alias.scope !116, !noalias !117
    br label %L18, !dbg !1596

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1600
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !1603

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !1575
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2229(i64 zeroext %0, i64 signext %1) unnamed_addr #0 !dbg !1604 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -13
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 14
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !1605
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %7 = icmp eq i64 %6, %1, !dbg !1610
   %8 = zext i1 %7 to i8, !dbg !1610
; └
  %9 = trunc i8 %8 to i1, !dbg !1612
  %10 = xor i1 %9, true, !dbg !1612
  br i1 %10, label %L6, label %L5, !dbg !1612

L5:                                               ; preds = %L2
  br label %L20, !dbg !1612

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ┌ @ promotion.jl:499 within `==`
   %11 = icmp eq i64 %6, 5, !dbg !1613
   %12 = zext i1 %11 to i8, !dbg !1613
; └
  %13 = trunc i8 %12 to i1, !dbg !1614
  %14 = xor i1 %13, true, !dbg !1614
  br i1 %14, label %L10, label %L9, !dbg !1614

L9:                                               ; preds = %L6
  br label %L13, !dbg !1614

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %15 = icmp eq i64 %6, 6, !dbg !1613
   %16 = zext i1 %15 to i8, !dbg !1613
; └
  %17 = trunc i8 %16 to i1, !dbg !1614
  %18 = xor i1 %17, true, !dbg !1614
  br i1 %18, label %L18, label %L13, !dbg !1614

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !1615
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !1615
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %19 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !1626
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %20 = load i64, i64 addrspace(5)* %19, align 8, !dbg !1628, !tbaa !96, !alias.scope !100, !noalias !103
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %21 = inttoptr i64 %20 to i64*, !dbg !1630
    %22 = getelementptr inbounds i64, i64* %21, i64 0, !dbg !1630
    %23 = load i64, i64 addrspace(1)* @_j_const1.19, align 1, !dbg !1630, !tbaa !112, !alias.scope !116, !noalias !117
    store i64 %23, i64* %22, align 1, !dbg !1630, !tbaa !118, !alias.scope !116, !noalias !117
    br label %L18, !dbg !1630

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1634
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
  br label %L2, !dbg !1637

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !1609
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:366 within `set_one!`
define amdgpu_kernel void @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE({ [1 x i64], i8 addrspace(1)* } %0) local_unnamed_addr #0 !dbg !1638 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)* }, align 8, addrspace(5)
  %2 = addrspacecast { [1 x i64], i8 addrspace(1)* } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)* } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)* } %0, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, align 8
  br label %top

top:                                              ; preds = %conversion
  %3 = alloca [1 x i64], align 8, addrspace(5)
  %4 = alloca [1 x i64], align 8, addrspace(5)
  %5 = call {}*** @julia.get_pgcstack()
  %6 = bitcast {}*** %5 to {}**
  %current_task = getelementptr inbounds {}*, {}** %6, i64 -13
  %7 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %7, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:367 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %8 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1639, !range !140
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %9 = add i32 %8, 1, !dbg !1650
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %10 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1653, !range !140
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %11 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1658, !range !140
; └└└└
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:132 within `workgroupIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %12 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1663, !range !1670
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %13 = add i32 %12, 1, !dbg !1671
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1673, !range !1670
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %15 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1678, !range !1670
; └└└└
; ┌ @ int.jl:1040 within `-`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %16 = zext i32 %13 to i64, !dbg !1683
; │└└└└
; │ @ int.jl:1042 within `-` @ int.jl:86
   %17 = sub i64 %16, 1, !dbg !1693
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:140 within `workgroupDim`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %18 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1695
      %19 = getelementptr inbounds i8, i8 addrspace(4)* %18, i64 4, !dbg !1695
      %20 = bitcast i8 addrspace(4)* %19 to i16 addrspace(4)*, !dbg !1695
      %21 = load i16, i16 addrspace(4)* %20, align 2, !dbg !1695, !range !1703
      %22 = zext i16 %21 to i32, !dbg !1695
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %23 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1704
      %24 = getelementptr inbounds i8, i8 addrspace(4)* %23, i64 6, !dbg !1704
      %25 = bitcast i8 addrspace(4)* %24 to i16 addrspace(4)*, !dbg !1704
      %26 = load i16, i16 addrspace(4)* %25, align 2, !dbg !1704, !range !1703
      %27 = zext i16 %26 to i32, !dbg !1704
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %28 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1709
      %29 = getelementptr inbounds i8, i8 addrspace(4)* %28, i64 8, !dbg !1709
      %30 = bitcast i8 addrspace(4)* %29 to i16 addrspace(4)*, !dbg !1709
      %31 = load i16, i16 addrspace(4)* %30, align 2, !dbg !1709, !range !1703
      %32 = zext i16 %31 to i32, !dbg !1709
; └└└└
; ┌ @ int.jl:1040 within `*`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %33 = zext i32 %22 to i64, !dbg !1714
; │└└└└
; │ @ int.jl:1042 within `*` @ int.jl:88
   %34 = mul i64 %17, %33, !dbg !1720
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %35 = zext i32 %9 to i64, !dbg !1722
; │└└└└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %36 = add i64 %35, %34, !dbg !1727
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:368 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#getindex`
   br label %L28, !dbg !1729

L28:                                              ; preds = %top
; │┌ @ abstractarray.jl:707 within `checkbounds`
    %37 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !1733
    store i64 %36, i64 addrspace(5)* %37, align 8, !dbg !1733, !tbaa !96, !alias.scope !100, !noalias !103
; ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %38 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 0, !dbg !1736
; │││││└└
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ tuple.jl:29 within `getindex`
         %39 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %38, i32 0, i32 0, !dbg !1748
; ││││││└
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %40 = load i64, i64 addrspace(11)* %39, align 8, !dbg !1753, !alias.scope !185, !noalias !186
            %41 = icmp slt i64 %40, 0, !dbg !1753
; │││││││││└
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %42 = zext i1 %41 to i8, !dbg !1763
            %43 = trunc i8 %42 to i1, !dbg !1763
            %44 = xor i1 %43, true, !dbg !1763
            %45 = load i64, i64 addrspace(11)* %39, align 8, !dbg !1763, !alias.scope !185, !noalias !186
            %46 = select i1 %44, i64 %45, i64 0, !dbg !1763
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %47 = icmp sle i64 1, %36, !dbg !1765
      %48 = icmp sle i64 %36, %46, !dbg !1765
; │││└
; │││┌ @ bool.jl:38 within `&`
      %49 = and i1 %47, %48, !dbg !1769
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    %50 = zext i1 %49 to i8, !dbg !1747
    %51 = trunc i8 %50 to i1, !dbg !1747
    %52 = xor i1 %51, true, !dbg !1747
    br i1 %52, label %L38, label %L37, !dbg !1747

L37:                                              ; preds = %L28
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L40, !dbg !1771

L38:                                              ; preds = %L28
; ││ @ abstractarray.jl:709 within `checkbounds`
    %53 = addrspacecast [1 x i64] addrspace(5)* %3 to [1 x i64] addrspace(11)*, !dbg !1747
    call fastcc void @julia__throw_boundserror_1763({ [1 x i64], i8 addrspace(1)* } addrspace(11)* nocapture readonly %2, [1 x i64] addrspace(11)* nocapture readonly %53) #13, !dbg !1747
    unreachable, !dbg !1747

L40:                                              ; preds = %L37
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L41, !dbg !1771

L41:                                              ; preds = %L40
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:89 within `#getindex`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %54 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 1, !dbg !1772
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
; ││││┌ @ int.jl:86 within `-`
       %55 = sub i64 %36, 1, !dbg !1776
; ││││└
      %56 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %54, align 8, !dbg !1777, !alias.scope !185, !noalias !186
      %57 = bitcast i8 addrspace(1)* %56 to i32 addrspace(1)*, !dbg !1777
      %58 = getelementptr inbounds i32, i32 addrspace(1)* %57, i64 %55, !dbg !1777
      %59 = load i32, i32 addrspace(1)* %58, align 4, !dbg !1777, !tbaa !251
; │└└└
   br label %L46, !dbg !1775

L46:                                              ; preds = %L41
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:523 within `rem`
    %60 = sext i32 %59 to i64, !dbg !1784
; │└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %61 = add i64 %60, 3, !dbg !1786
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
   br label %L49, !dbg !1788

L49:                                              ; preds = %L46
; │┌ @ abstractarray.jl:707 within `checkbounds`
    %62 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %4, i32 0, i32 0, !dbg !1790
    store i64 %36, i64 addrspace(5)* %62, align 8, !dbg !1790, !tbaa !96, !alias.scope !100, !noalias !103
; ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %63 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 0, !dbg !1791
; │││││└└
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ tuple.jl:29 within `getindex`
         %64 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %63, i32 0, i32 0, !dbg !1798
; ││││││└
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %65 = load i64, i64 addrspace(11)* %64, align 8, !dbg !1800, !alias.scope !185, !noalias !186
            %66 = icmp slt i64 %65, 0, !dbg !1800
; │││││││││└
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %67 = zext i1 %66 to i8, !dbg !1805
            %68 = trunc i8 %67 to i1, !dbg !1805
            %69 = xor i1 %68, true, !dbg !1805
            %70 = load i64, i64 addrspace(11)* %64, align 8, !dbg !1805, !alias.scope !185, !noalias !186
            %71 = select i1 %69, i64 %70, i64 0, !dbg !1805
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %72 = icmp sle i64 1, %36, !dbg !1806
      %73 = icmp sle i64 %36, %71, !dbg !1806
; │││└
; │││┌ @ bool.jl:38 within `&`
      %74 = and i1 %72, %73, !dbg !1808
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    %75 = zext i1 %74 to i8, !dbg !1797
    %76 = trunc i8 %75 to i1, !dbg !1797
    %77 = xor i1 %76, true, !dbg !1797
    br i1 %77, label %L59, label %L58, !dbg !1797

L58:                                              ; preds = %L49
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L61, !dbg !1809

L59:                                              ; preds = %L49
; ││ @ abstractarray.jl:709 within `checkbounds`
    %78 = addrspacecast [1 x i64] addrspace(5)* %4 to [1 x i64] addrspace(11)*, !dbg !1797
    call fastcc void @julia__throw_boundserror_1763({ [1 x i64], i8 addrspace(1)* } addrspace(11)* nocapture readonly %2, [1 x i64] addrspace(11)* nocapture readonly %78) #13, !dbg !1797
    unreachable, !dbg !1797

L61:                                              ; preds = %L58
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L62, !dbg !1809

L62:                                              ; preds = %L61
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:95 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %79 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 1, !dbg !1810
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:783 within `Int32`
      %80 = call fastcc i32 @julia_toInt32_1793(i64 signext %61) #0, !dbg !1813
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
; ││││┌ @ int.jl:86 within `-`
       %81 = sub i64 %36, 1, !dbg !1818
; ││││└
      %82 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %79, align 8, !dbg !1819, !alias.scope !185, !noalias !186
      %83 = bitcast i8 addrspace(1)* %82 to i32 addrspace(1)*, !dbg !1819
      %84 = getelementptr inbounds i32, i32 addrspace(1)* %83, i64 %81, !dbg !1819
      store i32 %80, i32 addrspace(1)* %84, align 4, !dbg !1819, !tbaa !251
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:96 within `#setindex!`
   br label %L68, !dbg !1823

L68:                                              ; preds = %L62
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `set_one!`
  ret void, !dbg !1824
}

attributes #0 = { "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #1 = { nounwind willreturn }
attributes #2 = { readnone }
attributes #3 = { convergent nounwind willreturn }
attributes #4 = { nounwind readnone speculatable willreturn }
attributes #5 = { noinline noreturn "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #6 = { argmemonly nofree nounwind willreturn }
attributes #7 = { cold noreturn nounwind }
attributes #8 = { alwaysinline convergent nounwind readnone willreturn }
attributes #9 = { alwaysinline nounwind }
attributes #10 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #11 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #12 = { nounwind readnone }
attributes #13 = { noreturn "frame-pointer"="all" "probe-stack"="inline-asm" }

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
!63 = !{void ({ [1 x i64], i8 addrspace(1)* })* @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE}
!64 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_1787", scope: null, file: !5, line: 57, type: !65, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!65 = !DISubroutineType(types: !66)
!66 = !{}
!67 = !DILocation(line: 12, scope: !68, inlinedAt: !69)
!68 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!69 = !DILocation(line: 61, scope: !70, inlinedAt: !71)
!70 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!71 = !DILocation(line: 60, scope: !64)
!72 = !DILocation(line: 499, scope: !73, inlinedAt: !75)
!73 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!74 = !DIFile(filename: "promotion.jl", directory: ".")
!75 = !DILocation(line: 62, scope: !70, inlinedAt: !71)
!76 = !DILocation(line: 499, scope: !73, inlinedAt: !77)
!77 = !DILocation(line: 64, scope: !70, inlinedAt: !71)
!78 = !DILocation(line: 40, scope: !79, inlinedAt: !81)
!79 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!80 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl", directory: ".")
!81 = !DILocation(line: 0, scope: !82, inlinedAt: !83)
!82 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!83 = !DILocation(line: 0, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!85 = !DILocation(line: 11, scope: !86, inlinedAt: !87)
!86 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!87 = !DILocation(line: 31, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!89 = !DILocation(line: 65, scope: !70, inlinedAt: !71)
!90 = !DILocation(line: 37, scope: !91, inlinedAt: !85)
!91 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!92 = !DIFile(filename: "Base.jl", directory: ".")
!93 = !DILocation(line: 30, scope: !94, inlinedAt: !85)
!94 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!95 = !DIFile(filename: "pointer.jl", directory: ".")
!96 = !{!97, !97, i64 0}
!97 = !{!"jtbaa_stack", !98, i64 0}
!98 = !{!"jtbaa", !99, i64 0}
!99 = !{!"jtbaa"}
!100 = !{!101}
!101 = !{!"jnoalias_stack", !102}
!102 = !{!"jnoalias"}
!103 = !{!104, !105, !106, !107}
!104 = !{!"jnoalias_gcframe", !102}
!105 = !{!"jnoalias_data", !102}
!106 = !{!"jnoalias_typemd", !102}
!107 = !{!"jnoalias_const", !102}
!108 = !DILocation(line: 126, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!110 = !DILocation(line: 126, scope: !109, inlinedAt: !111)
!111 = !DILocation(line: 33, scope: !88, inlinedAt: !89)
!112 = !{!113, !113, i64 0}
!113 = !{!"jtbaa_immut", !114, i64 0}
!114 = !{!"jtbaa_value", !115, i64 0}
!115 = !{!"jtbaa_data", !98, i64 0}
!116 = !{!105}
!117 = !{!104, !101, !106, !107}
!118 = !{!115, !115, i64 0}
!119 = !DILocation(line: 108, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !66)
!121 = !DILocation(line: 70, scope: !70, inlinedAt: !71)
!122 = !DILocation(line: 71, scope: !70, inlinedAt: !71)
!123 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_1780", scope: null, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!124 = !DILocation(line: 40, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!126 = !DILocation(line: 3, scope: !127, inlinedAt: !129)
!127 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!128 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!129 = !DILocation(line: 3, scope: !130, inlinedAt: !131)
!130 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!131 = !DILocation(line: 89, scope: !132, inlinedAt: !133)
!132 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!133 = !DILocation(line: 124, scope: !134, inlinedAt: !135)
!134 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!135 = !DILocation(line: 92, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!137 = !DILocation(line: 0, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!139 = !DILocation(line: 0, scope: !123)
!140 = !{i32 0, i32 1023}
!141 = !DILocation(line: 87, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!143 = !DIFile(filename: "int.jl", directory: ".")
!144 = !DILocation(line: 1042, scope: !142, inlinedAt: !131)
!145 = !DILocation(line: 40, scope: !125, inlinedAt: !146)
!146 = !DILocation(line: 3, scope: !127, inlinedAt: !147)
!147 = !DILocation(line: 3, scope: !130, inlinedAt: !148)
!148 = !DILocation(line: 89, scope: !149, inlinedAt: !133)
!149 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!150 = !DILocation(line: 40, scope: !125, inlinedAt: !151)
!151 = !DILocation(line: 3, scope: !127, inlinedAt: !152)
!152 = !DILocation(line: 3, scope: !130, inlinedAt: !153)
!153 = !DILocation(line: 89, scope: !154, inlinedAt: !133)
!154 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!155 = !DILocation(line: 763, scope: !156, inlinedAt: !157)
!156 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!157 = !DILocation(line: 789, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!159 = !DILocation(line: 7, scope: !160, inlinedAt: !162)
!160 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!161 = !DIFile(filename: "number.jl", directory: ".")
!162 = !DILocation(line: 358, scope: !163, inlinedAt: !164)
!163 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!164 = !DILocation(line: 381, scope: !165, inlinedAt: !166)
!165 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!166 = !DILocation(line: 449, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!168 = !DILocation(line: 492, scope: !169, inlinedAt: !170)
!169 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!170 = !DILocation(line: 269, scope: !171, inlinedAt: !135)
!171 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !172, file: !172, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!172 = !DIFile(filename: "operators.jl", directory: ".")
!173 = !DILocation(line: 499, scope: !167, inlinedAt: !166)
!174 = !DILocation(line: 38, scope: !175, inlinedAt: !168)
!175 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!176 = !DIFile(filename: "bool.jl", directory: ".")
!177 = !DILocation(line: 35, scope: !178, inlinedAt: !170)
!178 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!179 = !DILocation(line: 93, scope: !136, inlinedAt: !137)
!180 = !DILocation(line: 37, scope: !181, inlinedAt: !182)
!181 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!182 = !DILocation(line: 174, scope: !136, inlinedAt: !137)
!183 = !{!184, !184, i64 0, i64 1}
!184 = !{!"jtbaa_const", !98, i64 0}
!185 = !{!107}
!186 = !{!104, !101, !105, !106}
!187 = !DILocation(line: 37, scope: !181, inlinedAt: !188)
!188 = !DILocation(line: 176, scope: !136, inlinedAt: !137)
!189 = !DILocation(line: 37, scope: !181, inlinedAt: !190)
!190 = !DILocation(line: 188, scope: !136, inlinedAt: !137)
!191 = !DILocation(line: 19, scope: !192, inlinedAt: !193)
!192 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!193 = !DILocation(line: 19, scope: !192, inlinedAt: !190)
!194 = !DILocation(line: 6, scope: !195, inlinedAt: !197)
!195 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !196, file: !196, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !66)
!196 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!197 = !DILocation(line: 109, scope: !136, inlinedAt: !137)
!198 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_1813", scope: null, file: !9, line: 157, type: !65, scopeLine: 157, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !66)
!199 = !DILocation(line: 158, scope: !198)
!200 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_1799", scope: null, file: !11, line: 45, type: !65, scopeLine: 45, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!201 = !DILocation(line: 40, scope: !202, inlinedAt: !203)
!202 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!203 = !DILocation(line: 0, scope: !204, inlinedAt: !205)
!204 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!205 = !DILocation(line: 0, scope: !206, inlinedAt: !207)
!206 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!207 = !DILocation(line: 15, scope: !208, inlinedAt: !209)
!208 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!209 = !DILocation(line: 84, scope: !210, inlinedAt: !212)
!210 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!211 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!212 = !DILocation(line: 8, scope: !200)
!213 = !DILocation(line: 37, scope: !214, inlinedAt: !207)
!214 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!215 = !DILocation(line: 30, scope: !216, inlinedAt: !207)
!216 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!217 = !DILocation(line: 111, scope: !218, inlinedAt: !219)
!218 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!219 = !DILocation(line: 111, scope: !218, inlinedAt: !220)
!220 = !DILocation(line: 85, scope: !210, inlinedAt: !212)
!221 = !{!98, !98, i64 0}
!222 = !{!105, !101}
!223 = !{!104, !106, !107}
!224 = !DILocation(line: 37, scope: !214, inlinedAt: !220)
!225 = !DILocation(line: 513, scope: !226, inlinedAt: !228)
!226 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!227 = !DIFile(filename: "essentials.jl", directory: ".")
!228 = !DILocation(line: 100, scope: !229, inlinedAt: !231)
!229 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!230 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl", directory: ".")
!231 = !DILocation(line: 114, scope: !232, inlinedAt: !220)
!232 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!233 = !DILocation(line: 513, scope: !226, inlinedAt: !234)
!234 = !DILocation(line: 102, scope: !235, inlinedAt: !236)
!235 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!236 = !DILocation(line: 471, scope: !237, inlinedAt: !231)
!237 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!238 = !DILocation(line: 40, scope: !202, inlinedAt: !239)
!239 = !DILocation(line: 0, scope: !204, inlinedAt: !240)
!240 = !DILocation(line: 0, scope: !241, inlinedAt: !220)
!241 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!242 = !DILocation(line: 513, scope: !226, inlinedAt: !220)
!243 = !DILocation(line: 40, scope: !202, inlinedAt: !244)
!244 = !DILocation(line: 46, scope: !245, inlinedAt: !246)
!245 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!246 = !DILocation(line: 46, scope: !247, inlinedAt: !248)
!247 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!248 = !DILocation(line: 88, scope: !249, inlinedAt: !250)
!249 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!250 = !DILocation(line: 88, scope: !249, inlinedAt: !220)
!251 = !{!252, !252, i64 0, i64 0}
!252 = !{!"custom_tbaa_addrspace(1)", !253, i64 0}
!253 = !{!"custom_tbaa"}
!254 = !DILocation(line: 40, scope: !202, inlinedAt: !255)
!255 = !DILocation(line: 0, scope: !204, inlinedAt: !256)
!256 = !DILocation(line: 0, scope: !206, inlinedAt: !257)
!257 = !DILocation(line: 11, scope: !258, inlinedAt: !259)
!258 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!259 = !DILocation(line: 31, scope: !260, inlinedAt: !261)
!260 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!261 = !DILocation(line: 9, scope: !200)
!262 = !DILocation(line: 37, scope: !214, inlinedAt: !257)
!263 = !DILocation(line: 30, scope: !216, inlinedAt: !257)
!264 = !DILocation(line: 126, scope: !265, inlinedAt: !266)
!265 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !66)
!266 = !DILocation(line: 126, scope: !265, inlinedAt: !267)
!267 = !DILocation(line: 33, scope: !260, inlinedAt: !261)
!268 = !DILocation(line: 13, scope: !200)
!269 = distinct !DISubprogram(name: "checked_trunc_sint", linkageName: "julia_checked_trunc_sint_1796", scope: null, file: !13, line: 652, type: !65, scopeLine: 652, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !66)
!270 = !DILocation(line: 654, scope: !269)
!271 = !DILocation(line: 655, scope: !269)
!272 = !DILocation(line: 656, scope: !269)
!273 = !DILocation(line: 657, scope: !269)
!274 = distinct !DISubprogram(name: "toInt32", linkageName: "julia_toInt32_1793", scope: null, file: !13, line: 693, type: !65, scopeLine: 693, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !66)
!275 = !DILocation(line: 693, scope: !274)
!276 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_1790", scope: null, file: !5, line: 32, type: !65, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!277 = !DILocation(line: 27, scope: !278, inlinedAt: !279)
!278 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!279 = !DILocation(line: 37, scope: !280, inlinedAt: !281)
!280 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!281 = !DILocation(line: 36, scope: !276)
!282 = !DILocation(line: 499, scope: !283, inlinedAt: !284)
!283 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!284 = !DILocation(line: 38, scope: !280, inlinedAt: !281)
!285 = !DILocation(line: 499, scope: !283, inlinedAt: !286)
!286 = !DILocation(line: 40, scope: !280, inlinedAt: !281)
!287 = !DILocation(line: 40, scope: !288, inlinedAt: !289)
!288 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!289 = !DILocation(line: 0, scope: !290, inlinedAt: !291)
!290 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!291 = !DILocation(line: 0, scope: !292, inlinedAt: !293)
!292 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!293 = !DILocation(line: 11, scope: !294, inlinedAt: !295)
!294 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!295 = !DILocation(line: 31, scope: !296, inlinedAt: !297)
!296 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!297 = !DILocation(line: 41, scope: !280, inlinedAt: !281)
!298 = !DILocation(line: 37, scope: !299, inlinedAt: !293)
!299 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!300 = !DILocation(line: 30, scope: !301, inlinedAt: !293)
!301 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!302 = !DILocation(line: 126, scope: !303, inlinedAt: !304)
!303 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!304 = !DILocation(line: 126, scope: !303, inlinedAt: !305)
!305 = !DILocation(line: 33, scope: !296, inlinedAt: !297)
!306 = !DILocation(line: 108, scope: !307, inlinedAt: !308)
!307 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !66)
!308 = !DILocation(line: 46, scope: !280, inlinedAt: !281)
!309 = !DILocation(line: 47, scope: !280, inlinedAt: !281)
!310 = distinct !DISubprogram(name: "hostcall_device_lock!", linkageName: "julia_hostcall_device_lock!_1816", scope: null, file: !9, line: 114, type: !65, scopeLine: 114, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!311 = !DILocation(line: 40, scope: !312, inlinedAt: !313)
!312 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!313 = !DILocation(line: 3, scope: !314, inlinedAt: !315)
!314 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!315 = !DILocation(line: 3, scope: !316, inlinedAt: !317)
!316 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!317 = !DILocation(line: 89, scope: !318, inlinedAt: !319)
!318 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!319 = !DILocation(line: 124, scope: !320, inlinedAt: !321)
!320 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!321 = !DILocation(line: 92, scope: !322, inlinedAt: !323)
!322 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!323 = !DILocation(line: 0, scope: !324, inlinedAt: !325)
!324 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!325 = !DILocation(line: 0, scope: !326, inlinedAt: !327)
!326 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!327 = !DILocation(line: 115, scope: !310)
!328 = !DILocation(line: 87, scope: !329, inlinedAt: !330)
!329 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!330 = !DILocation(line: 1042, scope: !329, inlinedAt: !317)
!331 = !DILocation(line: 40, scope: !312, inlinedAt: !332)
!332 = !DILocation(line: 3, scope: !314, inlinedAt: !333)
!333 = !DILocation(line: 3, scope: !316, inlinedAt: !334)
!334 = !DILocation(line: 89, scope: !335, inlinedAt: !319)
!335 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!336 = !DILocation(line: 40, scope: !312, inlinedAt: !337)
!337 = !DILocation(line: 3, scope: !314, inlinedAt: !338)
!338 = !DILocation(line: 3, scope: !316, inlinedAt: !339)
!339 = !DILocation(line: 89, scope: !340, inlinedAt: !319)
!340 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!341 = !DILocation(line: 763, scope: !342, inlinedAt: !343)
!342 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!343 = !DILocation(line: 789, scope: !344, inlinedAt: !345)
!344 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!345 = !DILocation(line: 7, scope: !346, inlinedAt: !347)
!346 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!347 = !DILocation(line: 358, scope: !348, inlinedAt: !349)
!348 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!349 = !DILocation(line: 381, scope: !350, inlinedAt: !351)
!350 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!351 = !DILocation(line: 449, scope: !352, inlinedAt: !353)
!352 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!353 = !DILocation(line: 492, scope: !354, inlinedAt: !355)
!354 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!355 = !DILocation(line: 269, scope: !356, inlinedAt: !321)
!356 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !172, file: !172, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!357 = !DILocation(line: 499, scope: !352, inlinedAt: !351)
!358 = !DILocation(line: 38, scope: !359, inlinedAt: !353)
!359 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!360 = !DILocation(line: 35, scope: !361, inlinedAt: !355)
!361 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!362 = !DILocation(line: 93, scope: !322, inlinedAt: !323)
!363 = !DILocation(line: 37, scope: !364, inlinedAt: !365)
!364 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!365 = !DILocation(line: 124, scope: !322, inlinedAt: !323)
!366 = !DILocation(line: 27, scope: !367, inlinedAt: !368)
!367 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!368 = !DILocation(line: 37, scope: !369, inlinedAt: !370)
!369 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!370 = !DILocation(line: 36, scope: !369, inlinedAt: !365)
!371 = !DILocation(line: 499, scope: !352, inlinedAt: !372)
!372 = !DILocation(line: 38, scope: !369, inlinedAt: !370)
!373 = !DILocation(line: 499, scope: !352, inlinedAt: !374)
!374 = !DILocation(line: 40, scope: !369, inlinedAt: !370)
!375 = !DILocation(line: 40, scope: !312, inlinedAt: !376)
!376 = !DILocation(line: 0, scope: !324, inlinedAt: !377)
!377 = !DILocation(line: 0, scope: !378, inlinedAt: !379)
!378 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!379 = !DILocation(line: 11, scope: !380, inlinedAt: !381)
!380 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!381 = !DILocation(line: 31, scope: !382, inlinedAt: !383)
!382 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!383 = !DILocation(line: 41, scope: !369, inlinedAt: !370)
!384 = !DILocation(line: 37, scope: !364, inlinedAt: !379)
!385 = !DILocation(line: 30, scope: !386, inlinedAt: !379)
!386 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!387 = !DILocation(line: 126, scope: !388, inlinedAt: !389)
!388 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!389 = !DILocation(line: 126, scope: !388, inlinedAt: !390)
!390 = !DILocation(line: 33, scope: !382, inlinedAt: !383)
!391 = !DILocation(line: 108, scope: !392, inlinedAt: !393)
!392 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!393 = !DILocation(line: 46, scope: !369, inlinedAt: !370)
!394 = !DILocation(line: 47, scope: !369, inlinedAt: !370)
!395 = !DILocation(line: 6, scope: !396, inlinedAt: !397)
!396 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !196, file: !196, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !66)
!397 = !DILocation(line: 109, scope: !322, inlinedAt: !323)
!398 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_1763", scope: null, file: !11, line: 49, type: !65, scopeLine: 49, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!399 = !DILocation(line: 40, scope: !400, inlinedAt: !401)
!400 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!401 = !DILocation(line: 0, scope: !402, inlinedAt: !403)
!402 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!403 = !DILocation(line: 0, scope: !404, inlinedAt: !405)
!404 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!405 = !DILocation(line: 15, scope: !406, inlinedAt: !407)
!406 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!407 = !DILocation(line: 84, scope: !408, inlinedAt: !409)
!408 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!409 = !DILocation(line: 8, scope: !398)
!410 = !DILocation(line: 37, scope: !411, inlinedAt: !405)
!411 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!412 = !DILocation(line: 30, scope: !413, inlinedAt: !405)
!413 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!414 = !DILocation(line: 111, scope: !415, inlinedAt: !416)
!415 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!416 = !DILocation(line: 111, scope: !415, inlinedAt: !417)
!417 = !DILocation(line: 85, scope: !408, inlinedAt: !409)
!418 = !DILocation(line: 40, scope: !400, inlinedAt: !419)
!419 = !DILocation(line: 3, scope: !420, inlinedAt: !421)
!420 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!421 = !DILocation(line: 3, scope: !422, inlinedAt: !423)
!422 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!423 = !DILocation(line: 89, scope: !424, inlinedAt: !425)
!424 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!425 = !DILocation(line: 124, scope: !426, inlinedAt: !427)
!426 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!427 = !DILocation(line: 92, scope: !428, inlinedAt: !429)
!428 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!429 = !DILocation(line: 0, scope: !402, inlinedAt: !430)
!430 = !DILocation(line: 0, scope: !431, inlinedAt: !432)
!431 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!432 = !DILocation(line: 115, scope: !433, inlinedAt: !417)
!433 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!434 = !DILocation(line: 87, scope: !435, inlinedAt: !436)
!435 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!436 = !DILocation(line: 1042, scope: !435, inlinedAt: !423)
!437 = !DILocation(line: 40, scope: !400, inlinedAt: !438)
!438 = !DILocation(line: 3, scope: !420, inlinedAt: !439)
!439 = !DILocation(line: 3, scope: !422, inlinedAt: !440)
!440 = !DILocation(line: 89, scope: !441, inlinedAt: !425)
!441 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!442 = !DILocation(line: 40, scope: !400, inlinedAt: !443)
!443 = !DILocation(line: 3, scope: !420, inlinedAt: !444)
!444 = !DILocation(line: 3, scope: !422, inlinedAt: !445)
!445 = !DILocation(line: 89, scope: !446, inlinedAt: !425)
!446 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!447 = !DILocation(line: 763, scope: !448, inlinedAt: !449)
!448 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!449 = !DILocation(line: 789, scope: !450, inlinedAt: !451)
!450 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!451 = !DILocation(line: 7, scope: !452, inlinedAt: !453)
!452 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!453 = !DILocation(line: 358, scope: !454, inlinedAt: !455)
!454 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!455 = !DILocation(line: 381, scope: !456, inlinedAt: !457)
!456 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!457 = !DILocation(line: 449, scope: !458, inlinedAt: !459)
!458 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!459 = !DILocation(line: 492, scope: !460, inlinedAt: !461)
!460 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!461 = !DILocation(line: 269, scope: !462, inlinedAt: !427)
!462 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !172, file: !172, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!463 = !DILocation(line: 499, scope: !458, inlinedAt: !457)
!464 = !DILocation(line: 38, scope: !465, inlinedAt: !459)
!465 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!466 = !DILocation(line: 35, scope: !467, inlinedAt: !461)
!467 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!468 = !DILocation(line: 93, scope: !428, inlinedAt: !429)
!469 = !DILocation(line: 37, scope: !411, inlinedAt: !470)
!470 = !DILocation(line: 124, scope: !428, inlinedAt: !429)
!471 = !DILocation(line: 27, scope: !472, inlinedAt: !473)
!472 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!473 = !DILocation(line: 37, scope: !474, inlinedAt: !475)
!474 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!475 = !DILocation(line: 36, scope: !474, inlinedAt: !470)
!476 = !DILocation(line: 499, scope: !458, inlinedAt: !477)
!477 = !DILocation(line: 38, scope: !474, inlinedAt: !475)
!478 = !DILocation(line: 499, scope: !458, inlinedAt: !479)
!479 = !DILocation(line: 40, scope: !474, inlinedAt: !475)
!480 = !DILocation(line: 40, scope: !400, inlinedAt: !481)
!481 = !DILocation(line: 0, scope: !402, inlinedAt: !482)
!482 = !DILocation(line: 0, scope: !404, inlinedAt: !483)
!483 = !DILocation(line: 11, scope: !484, inlinedAt: !485)
!484 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!485 = !DILocation(line: 31, scope: !486, inlinedAt: !487)
!486 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!487 = !DILocation(line: 41, scope: !474, inlinedAt: !475)
!488 = !DILocation(line: 37, scope: !411, inlinedAt: !483)
!489 = !DILocation(line: 30, scope: !413, inlinedAt: !483)
!490 = !DILocation(line: 126, scope: !491, inlinedAt: !492)
!491 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!492 = !DILocation(line: 126, scope: !491, inlinedAt: !493)
!493 = !DILocation(line: 33, scope: !486, inlinedAt: !487)
!494 = !DILocation(line: 108, scope: !495, inlinedAt: !496)
!495 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!496 = !DILocation(line: 46, scope: !474, inlinedAt: !475)
!497 = !DILocation(line: 47, scope: !474, inlinedAt: !475)
!498 = !DILocation(line: 6, scope: !499, inlinedAt: !500)
!499 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !196, file: !196, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!500 = !DILocation(line: 109, scope: !428, inlinedAt: !429)
!501 = !DILocation(line: 37, scope: !411, inlinedAt: !417)
!502 = !DILocation(line: 513, scope: !503, inlinedAt: !504)
!503 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!504 = !DILocation(line: 100, scope: !505, inlinedAt: !506)
!505 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!506 = !DILocation(line: 114, scope: !507, inlinedAt: !417)
!507 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!508 = !DILocation(line: 513, scope: !503, inlinedAt: !509)
!509 = !DILocation(line: 102, scope: !510, inlinedAt: !511)
!510 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!511 = !DILocation(line: 471, scope: !512, inlinedAt: !506)
!512 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!513 = !DILocation(line: 40, scope: !400, inlinedAt: !514)
!514 = !DILocation(line: 0, scope: !402, inlinedAt: !515)
!515 = !DILocation(line: 0, scope: !516, inlinedAt: !417)
!516 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!517 = !DILocation(line: 513, scope: !503, inlinedAt: !417)
!518 = !DILocation(line: 40, scope: !400, inlinedAt: !519)
!519 = !DILocation(line: 46, scope: !520, inlinedAt: !521)
!520 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!521 = !DILocation(line: 46, scope: !522, inlinedAt: !523)
!522 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!523 = !DILocation(line: 88, scope: !524, inlinedAt: !525)
!524 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!525 = !DILocation(line: 88, scope: !524, inlinedAt: !417)
!526 = !DILocation(line: 158, scope: !527, inlinedAt: !417)
!527 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !66)
!528 = !DILocation(line: 40, scope: !400, inlinedAt: !529)
!529 = !DILocation(line: 0, scope: !402, inlinedAt: !530)
!530 = !DILocation(line: 0, scope: !404, inlinedAt: !531)
!531 = !DILocation(line: 11, scope: !484, inlinedAt: !532)
!532 = !DILocation(line: 31, scope: !486, inlinedAt: !533)
!533 = !DILocation(line: 9, scope: !398)
!534 = !DILocation(line: 37, scope: !411, inlinedAt: !531)
!535 = !DILocation(line: 30, scope: !413, inlinedAt: !531)
!536 = !DILocation(line: 126, scope: !491, inlinedAt: !537)
!537 = !DILocation(line: 126, scope: !491, inlinedAt: !538)
!538 = !DILocation(line: 33, scope: !486, inlinedAt: !533)
!539 = !DILocation(line: 13, scope: !398)
!540 = !{!541, !542, i64 16}
!541 = !{!"amd_signal_s", !542, i64 0, !543, i64 8, !542, i64 16, !545, i64 24, !545, i64 28, !542, i64 32, !542, i64 40, !543, i64 48, !543, i64 56}
!542 = !{!"long", !543, i64 0}
!543 = !{!"omnipotent char", !544, i64 0}
!544 = !{!"Simple C/C++ TBAA"}
!545 = !{!"int", !543, i64 0}
!546 = !{!541, !545, i64 24}
!547 = !{!541, !542, i64 0}
!548 = !{!545, !545, i64 0}
!549 = !{!543, !543, i64 0}
!550 = !{!551, !542, i64 80}
!551 = !{!"amd_queue_s", !552, i64 0, !543, i64 40, !542, i64 56, !545, i64 64, !545, i64 68, !545, i64 72, !545, i64 76, !542, i64 80, !545, i64 88, !543, i64 92, !542, i64 128, !545, i64 136, !545, i64 140, !543, i64 144, !542, i64 160, !542, i64 168, !545, i64 176, !545, i64 180, !543, i64 184, !554, i64 192, !543, i64 200}
!552 = !{!"hsa_queue_s", !543, i64 0, !545, i64 4, !553, i64 8, !554, i64 16, !545, i64 24, !545, i64 28, !542, i64 32}
!553 = !{!"any pointer", !543, i64 0}
!554 = !{!"hsa_signal_s", !542, i64 0}
!555 = !{!551, !545, i64 24}
!556 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_2154", scope: null, file: !28, line: 65, type: !65, scopeLine: 65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!557 = !DILocation(line: 513, scope: !558, inlinedAt: !559)
!558 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!559 = !DILocation(line: 43, scope: !560, inlinedAt: !561)
!560 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!561 = !DILocation(line: 66, scope: !556)
!562 = !DILocation(line: 40, scope: !563, inlinedAt: !564)
!563 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!564 = !DILocation(line: 3, scope: !565, inlinedAt: !567)
!565 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !566, file: !566, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!566 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!567 = !DILocation(line: 3, scope: !568, inlinedAt: !569)
!568 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !566, file: !566, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!569 = !DILocation(line: 44, scope: !560, inlinedAt: !561)
!570 = !DILocation(line: 87, scope: !571, inlinedAt: !572)
!571 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!572 = !DILocation(line: 1042, scope: !571, inlinedAt: !573)
!573 = !DILocation(line: 47, scope: !560, inlinedAt: !561)
!574 = !DILocation(line: 40, scope: !563, inlinedAt: !575)
!575 = !DILocation(line: 0, scope: !576, inlinedAt: !577)
!576 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!577 = !DILocation(line: 0, scope: !578, inlinedAt: !579)
!578 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!579 = !DILocation(line: 23, scope: !580, inlinedAt: !581)
!580 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!581 = !DILocation(line: 4, scope: !582, inlinedAt: !573)
!582 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!583 = !DILocation(line: 37, scope: !584, inlinedAt: !579)
!584 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!585 = !DILocation(line: 30, scope: !586, inlinedAt: !579)
!586 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!587 = !DILocation(line: 111, scope: !588, inlinedAt: !589)
!588 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!589 = !DILocation(line: 111, scope: !588, inlinedAt: !581)
!590 = !DILocation(line: 40, scope: !563, inlinedAt: !591)
!591 = !DILocation(line: 3, scope: !592, inlinedAt: !593)
!592 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!593 = !DILocation(line: 3, scope: !594, inlinedAt: !595)
!594 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!595 = !DILocation(line: 89, scope: !596, inlinedAt: !597)
!596 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!597 = !DILocation(line: 124, scope: !598, inlinedAt: !599)
!598 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!599 = !DILocation(line: 92, scope: !600, inlinedAt: !601)
!600 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!601 = !DILocation(line: 0, scope: !576, inlinedAt: !602)
!602 = !DILocation(line: 0, scope: !603, inlinedAt: !604)
!603 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!604 = !DILocation(line: 71, scope: !605, inlinedAt: !606)
!605 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!606 = !DILocation(line: 65, scope: !605, inlinedAt: !607)
!607 = !DILocation(line: 5, scope: !582, inlinedAt: !573)
!608 = !DILocation(line: 87, scope: !571, inlinedAt: !609)
!609 = !DILocation(line: 1042, scope: !571, inlinedAt: !595)
!610 = !DILocation(line: 40, scope: !563, inlinedAt: !611)
!611 = !DILocation(line: 3, scope: !592, inlinedAt: !612)
!612 = !DILocation(line: 3, scope: !594, inlinedAt: !613)
!613 = !DILocation(line: 89, scope: !614, inlinedAt: !597)
!614 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!615 = !DILocation(line: 40, scope: !563, inlinedAt: !616)
!616 = !DILocation(line: 3, scope: !592, inlinedAt: !617)
!617 = !DILocation(line: 3, scope: !594, inlinedAt: !618)
!618 = !DILocation(line: 89, scope: !619, inlinedAt: !597)
!619 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!620 = !DILocation(line: 763, scope: !621, inlinedAt: !622)
!621 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!622 = !DILocation(line: 789, scope: !623, inlinedAt: !624)
!623 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!624 = !DILocation(line: 7, scope: !625, inlinedAt: !626)
!625 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!626 = !DILocation(line: 358, scope: !627, inlinedAt: !628)
!627 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!628 = !DILocation(line: 381, scope: !629, inlinedAt: !630)
!629 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!630 = !DILocation(line: 449, scope: !631, inlinedAt: !632)
!631 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!632 = !DILocation(line: 492, scope: !633, inlinedAt: !634)
!633 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!634 = !DILocation(line: 269, scope: !635, inlinedAt: !599)
!635 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !172, file: !172, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!636 = !DILocation(line: 499, scope: !631, inlinedAt: !630)
!637 = !DILocation(line: 38, scope: !638, inlinedAt: !632)
!638 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!639 = !DILocation(line: 35, scope: !640, inlinedAt: !634)
!640 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!641 = !DILocation(line: 93, scope: !600, inlinedAt: !601)
!642 = !DILocation(line: 37, scope: !584, inlinedAt: !643)
!643 = !DILocation(line: 124, scope: !600, inlinedAt: !601)
!644 = !DILocation(line: 27, scope: !645, inlinedAt: !646)
!645 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!646 = !DILocation(line: 37, scope: !647, inlinedAt: !648)
!647 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!648 = !DILocation(line: 36, scope: !647, inlinedAt: !643)
!649 = !DILocation(line: 499, scope: !631, inlinedAt: !650)
!650 = !DILocation(line: 38, scope: !647, inlinedAt: !648)
!651 = !DILocation(line: 499, scope: !631, inlinedAt: !652)
!652 = !DILocation(line: 40, scope: !647, inlinedAt: !648)
!653 = !DILocation(line: 40, scope: !563, inlinedAt: !654)
!654 = !DILocation(line: 0, scope: !576, inlinedAt: !655)
!655 = !DILocation(line: 0, scope: !578, inlinedAt: !656)
!656 = !DILocation(line: 11, scope: !657, inlinedAt: !658)
!657 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!658 = !DILocation(line: 31, scope: !659, inlinedAt: !660)
!659 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!660 = !DILocation(line: 41, scope: !647, inlinedAt: !648)
!661 = !DILocation(line: 37, scope: !584, inlinedAt: !656)
!662 = !DILocation(line: 30, scope: !586, inlinedAt: !656)
!663 = !DILocation(line: 126, scope: !664, inlinedAt: !665)
!664 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!665 = !DILocation(line: 126, scope: !664, inlinedAt: !666)
!666 = !DILocation(line: 33, scope: !659, inlinedAt: !660)
!667 = !DILocation(line: 108, scope: !668, inlinedAt: !669)
!668 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!669 = !DILocation(line: 46, scope: !647, inlinedAt: !648)
!670 = !DILocation(line: 47, scope: !647, inlinedAt: !648)
!671 = !DILocation(line: 6, scope: !672, inlinedAt: !673)
!672 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !196, file: !196, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!673 = !DILocation(line: 109, scope: !600, inlinedAt: !601)
!674 = !DILocation(line: 40, scope: !563, inlinedAt: !675)
!675 = !DILocation(line: 3, scope: !592, inlinedAt: !676)
!676 = !DILocation(line: 3, scope: !594, inlinedAt: !677)
!677 = !DILocation(line: 89, scope: !596, inlinedAt: !678)
!678 = !DILocation(line: 124, scope: !598, inlinedAt: !679)
!679 = !DILocation(line: 92, scope: !600, inlinedAt: !680)
!680 = !DILocation(line: 0, scope: !576, inlinedAt: !681)
!681 = !DILocation(line: 0, scope: !682, inlinedAt: !683)
!682 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!683 = !DILocation(line: 72, scope: !605, inlinedAt: !606)
!684 = !DILocation(line: 87, scope: !571, inlinedAt: !685)
!685 = !DILocation(line: 1042, scope: !571, inlinedAt: !677)
!686 = !DILocation(line: 40, scope: !563, inlinedAt: !687)
!687 = !DILocation(line: 3, scope: !592, inlinedAt: !688)
!688 = !DILocation(line: 3, scope: !594, inlinedAt: !689)
!689 = !DILocation(line: 89, scope: !614, inlinedAt: !678)
!690 = !DILocation(line: 40, scope: !563, inlinedAt: !691)
!691 = !DILocation(line: 3, scope: !592, inlinedAt: !692)
!692 = !DILocation(line: 3, scope: !594, inlinedAt: !693)
!693 = !DILocation(line: 89, scope: !619, inlinedAt: !678)
!694 = !DILocation(line: 763, scope: !621, inlinedAt: !695)
!695 = !DILocation(line: 789, scope: !623, inlinedAt: !696)
!696 = !DILocation(line: 7, scope: !625, inlinedAt: !697)
!697 = !DILocation(line: 358, scope: !627, inlinedAt: !698)
!698 = !DILocation(line: 381, scope: !629, inlinedAt: !699)
!699 = !DILocation(line: 449, scope: !631, inlinedAt: !700)
!700 = !DILocation(line: 492, scope: !633, inlinedAt: !701)
!701 = !DILocation(line: 269, scope: !635, inlinedAt: !679)
!702 = !DILocation(line: 499, scope: !631, inlinedAt: !699)
!703 = !DILocation(line: 38, scope: !638, inlinedAt: !700)
!704 = !DILocation(line: 35, scope: !640, inlinedAt: !701)
!705 = !DILocation(line: 93, scope: !600, inlinedAt: !680)
!706 = !DILocation(line: 37, scope: !584, inlinedAt: !707)
!707 = !DILocation(line: 152, scope: !600, inlinedAt: !680)
!708 = !DILocation(line: 513, scope: !558, inlinedAt: !709)
!709 = !DILocation(line: 100, scope: !710, inlinedAt: !711)
!710 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!711 = !DILocation(line: 114, scope: !712, inlinedAt: !707)
!712 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!713 = !DILocation(line: 513, scope: !558, inlinedAt: !714)
!714 = !DILocation(line: 102, scope: !715, inlinedAt: !716)
!715 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!716 = !DILocation(line: 471, scope: !717, inlinedAt: !711)
!717 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!718 = !DILocation(line: 513, scope: !558, inlinedAt: !719)
!719 = !DILocation(line: 100, scope: !710, inlinedAt: !720)
!720 = !DILocation(line: 115, scope: !721, inlinedAt: !707)
!721 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!722 = !DILocation(line: 513, scope: !558, inlinedAt: !723)
!723 = !DILocation(line: 102, scope: !715, inlinedAt: !724)
!724 = !DILocation(line: 471, scope: !717, inlinedAt: !720)
!725 = !DILocation(line: 40, scope: !563, inlinedAt: !726)
!726 = !DILocation(line: 46, scope: !727, inlinedAt: !728)
!727 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!728 = !DILocation(line: 46, scope: !729, inlinedAt: !730)
!729 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!730 = !DILocation(line: 88, scope: !731, inlinedAt: !732)
!731 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!732 = !DILocation(line: 88, scope: !731, inlinedAt: !733)
!733 = !DILocation(line: 88, scope: !731, inlinedAt: !707)
!734 = !DILocation(line: 6, scope: !672, inlinedAt: !735)
!735 = !DILocation(line: 109, scope: !600, inlinedAt: !680)
!736 = !DILocation(line: 168, scope: !600, inlinedAt: !737)
!737 = !DILocation(line: 0, scope: !576, inlinedAt: !738)
!738 = !DILocation(line: 0, scope: !739, inlinedAt: !740)
!739 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!740 = !DILocation(line: 73, scope: !605, inlinedAt: !606)
!741 = !DILocation(line: 40, scope: !563, inlinedAt: !742)
!742 = !DILocation(line: 2, scope: !743, inlinedAt: !745)
!743 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !744, file: !744, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!744 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!745 = !DILocation(line: 2, scope: !746, inlinedAt: !747)
!746 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !744, file: !744, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!747 = !DILocation(line: 52, scope: !748, inlinedAt: !749)
!748 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !744, file: !744, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!749 = !DILocation(line: 52, scope: !748, inlinedAt: !750)
!750 = !DILocation(line: 169, scope: !600, inlinedAt: !737)
!751 = !DILocation(line: 40, scope: !563, inlinedAt: !752)
!752 = !DILocation(line: 3, scope: !592, inlinedAt: !753)
!753 = !DILocation(line: 3, scope: !594, inlinedAt: !754)
!754 = !DILocation(line: 89, scope: !596, inlinedAt: !755)
!755 = !DILocation(line: 124, scope: !598, inlinedAt: !756)
!756 = !DILocation(line: 92, scope: !600, inlinedAt: !737)
!757 = !DILocation(line: 87, scope: !571, inlinedAt: !758)
!758 = !DILocation(line: 1042, scope: !571, inlinedAt: !754)
!759 = !DILocation(line: 40, scope: !563, inlinedAt: !760)
!760 = !DILocation(line: 3, scope: !592, inlinedAt: !761)
!761 = !DILocation(line: 3, scope: !594, inlinedAt: !762)
!762 = !DILocation(line: 89, scope: !614, inlinedAt: !755)
!763 = !DILocation(line: 40, scope: !563, inlinedAt: !764)
!764 = !DILocation(line: 3, scope: !592, inlinedAt: !765)
!765 = !DILocation(line: 3, scope: !594, inlinedAt: !766)
!766 = !DILocation(line: 89, scope: !619, inlinedAt: !755)
!767 = !DILocation(line: 763, scope: !621, inlinedAt: !768)
!768 = !DILocation(line: 789, scope: !623, inlinedAt: !769)
!769 = !DILocation(line: 7, scope: !625, inlinedAt: !770)
!770 = !DILocation(line: 358, scope: !627, inlinedAt: !771)
!771 = !DILocation(line: 381, scope: !629, inlinedAt: !772)
!772 = !DILocation(line: 449, scope: !631, inlinedAt: !773)
!773 = !DILocation(line: 492, scope: !633, inlinedAt: !774)
!774 = !DILocation(line: 269, scope: !635, inlinedAt: !756)
!775 = !DILocation(line: 499, scope: !631, inlinedAt: !772)
!776 = !DILocation(line: 38, scope: !638, inlinedAt: !773)
!777 = !DILocation(line: 35, scope: !640, inlinedAt: !774)
!778 = !DILocation(line: 93, scope: !600, inlinedAt: !737)
!779 = !DILocation(line: 37, scope: !584, inlinedAt: !780)
!780 = !DILocation(line: 174, scope: !600, inlinedAt: !737)
!781 = !DILocation(line: 27, scope: !645, inlinedAt: !782)
!782 = !DILocation(line: 37, scope: !647, inlinedAt: !783)
!783 = !DILocation(line: 36, scope: !647, inlinedAt: !780)
!784 = !DILocation(line: 499, scope: !631, inlinedAt: !785)
!785 = !DILocation(line: 38, scope: !647, inlinedAt: !783)
!786 = !DILocation(line: 499, scope: !631, inlinedAt: !787)
!787 = !DILocation(line: 40, scope: !647, inlinedAt: !783)
!788 = !DILocation(line: 40, scope: !563, inlinedAt: !789)
!789 = !DILocation(line: 0, scope: !576, inlinedAt: !790)
!790 = !DILocation(line: 0, scope: !578, inlinedAt: !791)
!791 = !DILocation(line: 11, scope: !657, inlinedAt: !792)
!792 = !DILocation(line: 31, scope: !659, inlinedAt: !793)
!793 = !DILocation(line: 41, scope: !647, inlinedAt: !783)
!794 = !DILocation(line: 37, scope: !584, inlinedAt: !791)
!795 = !DILocation(line: 30, scope: !586, inlinedAt: !791)
!796 = !DILocation(line: 126, scope: !664, inlinedAt: !797)
!797 = !DILocation(line: 126, scope: !664, inlinedAt: !798)
!798 = !DILocation(line: 33, scope: !659, inlinedAt: !793)
!799 = !DILocation(line: 108, scope: !668, inlinedAt: !800)
!800 = !DILocation(line: 46, scope: !647, inlinedAt: !783)
!801 = !DILocation(line: 47, scope: !647, inlinedAt: !783)
!802 = !DILocation(line: 37, scope: !584, inlinedAt: !803)
!803 = !DILocation(line: 176, scope: !600, inlinedAt: !737)
!804 = !DILocation(line: 12, scope: !805, inlinedAt: !806)
!805 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!806 = !DILocation(line: 61, scope: !807, inlinedAt: !808)
!807 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!808 = !DILocation(line: 60, scope: !807, inlinedAt: !803)
!809 = !DILocation(line: 499, scope: !631, inlinedAt: !810)
!810 = !DILocation(line: 62, scope: !807, inlinedAt: !808)
!811 = !DILocation(line: 499, scope: !631, inlinedAt: !812)
!812 = !DILocation(line: 64, scope: !807, inlinedAt: !808)
!813 = !DILocation(line: 40, scope: !563, inlinedAt: !814)
!814 = !DILocation(line: 0, scope: !576, inlinedAt: !815)
!815 = !DILocation(line: 0, scope: !578, inlinedAt: !816)
!816 = !DILocation(line: 11, scope: !657, inlinedAt: !817)
!817 = !DILocation(line: 31, scope: !659, inlinedAt: !818)
!818 = !DILocation(line: 65, scope: !807, inlinedAt: !808)
!819 = !DILocation(line: 37, scope: !584, inlinedAt: !816)
!820 = !DILocation(line: 30, scope: !586, inlinedAt: !816)
!821 = !DILocation(line: 126, scope: !664, inlinedAt: !822)
!822 = !DILocation(line: 126, scope: !664, inlinedAt: !823)
!823 = !DILocation(line: 33, scope: !659, inlinedAt: !818)
!824 = !DILocation(line: 108, scope: !668, inlinedAt: !825)
!825 = !DILocation(line: 70, scope: !807, inlinedAt: !808)
!826 = !DILocation(line: 71, scope: !807, inlinedAt: !808)
!827 = !DILocation(line: 178, scope: !600, inlinedAt: !737)
!828 = !DILocation(line: 37, scope: !584, inlinedAt: !829)
!829 = !DILocation(line: 179, scope: !600, inlinedAt: !737)
!830 = !DILocation(line: 513, scope: !558, inlinedAt: !829)
!831 = !DILocation(line: 40, scope: !563, inlinedAt: !832)
!832 = !DILocation(line: 9, scope: !727, inlinedAt: !833)
!833 = !DILocation(line: 9, scope: !834, inlinedAt: !835)
!834 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!835 = !DILocation(line: 85, scope: !836, inlinedAt: !837)
!836 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!837 = !DILocation(line: 85, scope: !836, inlinedAt: !838)
!838 = !DILocation(line: 85, scope: !836, inlinedAt: !839)
!839 = !DILocation(line: 180, scope: !600, inlinedAt: !737)
!840 = !DILocation(line: 513, scope: !558, inlinedAt: !841)
!841 = !DILocation(line: 100, scope: !710, inlinedAt: !842)
!842 = !DILocation(line: 181, scope: !600, inlinedAt: !737)
!843 = !DILocation(line: 499, scope: !631, inlinedAt: !844)
!844 = !DILocation(line: 492, scope: !633, inlinedAt: !842)
!845 = !DILocation(line: 38, scope: !638, inlinedAt: !844)
!846 = !DILocation(line: 37, scope: !584, inlinedAt: !847)
!847 = !DILocation(line: 182, scope: !600, inlinedAt: !737)
!848 = !DILocation(line: 19, scope: !849, inlinedAt: !850)
!849 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!850 = !DILocation(line: 19, scope: !849, inlinedAt: !847)
!851 = !DILocation(line: 40, scope: !563, inlinedAt: !852)
!852 = !DILocation(line: 0, scope: !576, inlinedAt: !853)
!853 = !DILocation(line: 0, scope: !578, inlinedAt: !854)
!854 = !DILocation(line: 11, scope: !657, inlinedAt: !855)
!855 = !DILocation(line: 31, scope: !659, inlinedAt: !856)
!856 = !DILocation(line: 183, scope: !600, inlinedAt: !737)
!857 = !DILocation(line: 37, scope: !584, inlinedAt: !854)
!858 = !DILocation(line: 30, scope: !586, inlinedAt: !854)
!859 = !DILocation(line: 126, scope: !664, inlinedAt: !860)
!860 = !DILocation(line: 126, scope: !664, inlinedAt: !861)
!861 = !DILocation(line: 33, scope: !659, inlinedAt: !856)
!862 = !DILocation(line: 1, scope: !863, inlinedAt: !865)
!863 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !864, file: !864, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!864 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!865 = !DILocation(line: 184, scope: !600, inlinedAt: !737)
!866 = !DILocation(line: 40, scope: !563, inlinedAt: !867)
!867 = !DILocation(line: 9, scope: !727, inlinedAt: !868)
!868 = !DILocation(line: 9, scope: !834, inlinedAt: !869)
!869 = !DILocation(line: 85, scope: !836, inlinedAt: !870)
!870 = !DILocation(line: 85, scope: !836, inlinedAt: !871)
!871 = !DILocation(line: 85, scope: !836, inlinedAt: !872)
!872 = !DILocation(line: 186, scope: !600, inlinedAt: !737)
!873 = !DILocation(line: 40, scope: !563, inlinedAt: !874)
!874 = !DILocation(line: 46, scope: !727, inlinedAt: !875)
!875 = !DILocation(line: 46, scope: !729, inlinedAt: !876)
!876 = !DILocation(line: 88, scope: !731, inlinedAt: !877)
!877 = !DILocation(line: 88, scope: !731, inlinedAt: !878)
!878 = !DILocation(line: 88, scope: !731, inlinedAt: !872)
!879 = !{!880, !880, i64 0, i64 0}
!880 = !{!"custom_tbaa_addrspace(3)", !253, i64 0}
!881 = !DILocation(line: 37, scope: !584, inlinedAt: !882)
!882 = !DILocation(line: 188, scope: !600, inlinedAt: !737)
!883 = !DILocation(line: 19, scope: !849, inlinedAt: !884)
!884 = !DILocation(line: 19, scope: !849, inlinedAt: !882)
!885 = !DILocation(line: 6, scope: !672, inlinedAt: !886)
!886 = !DILocation(line: 109, scope: !600, inlinedAt: !737)
!887 = !DILocation(line: 40, scope: !563, inlinedAt: !888)
!888 = !DILocation(line: 9, scope: !727, inlinedAt: !889)
!889 = !DILocation(line: 9, scope: !834, inlinedAt: !890)
!890 = !DILocation(line: 85, scope: !836, inlinedAt: !891)
!891 = !DILocation(line: 85, scope: !836, inlinedAt: !892)
!892 = !DILocation(line: 85, scope: !836, inlinedAt: !893)
!893 = !DILocation(line: 191, scope: !600, inlinedAt: !737)
!894 = !DILocation(line: 6, scope: !582, inlinedAt: !573)
!895 = !DILocation(line: 513, scope: !558, inlinedAt: !573)
!896 = !DILocation(line: 513, scope: !558, inlinedAt: !897)
!897 = !DILocation(line: 49, scope: !560, inlinedAt: !561)
!898 = !DILocation(line: 499, scope: !631, inlinedAt: !899)
!899 = !DILocation(line: 492, scope: !633, inlinedAt: !897)
!900 = !DILocation(line: 38, scope: !638, inlinedAt: !899)
!901 = !DILocation(line: 40, scope: !563, inlinedAt: !902)
!902 = !DILocation(line: 0, scope: !576, inlinedAt: !903)
!903 = !DILocation(line: 0, scope: !578, inlinedAt: !904)
!904 = !DILocation(line: 15, scope: !905, inlinedAt: !906)
!905 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!906 = !DILocation(line: 69, scope: !907, inlinedAt: !908)
!907 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!908 = !DILocation(line: 50, scope: !560, inlinedAt: !561)
!909 = !DILocation(line: 37, scope: !584, inlinedAt: !904)
!910 = !DILocation(line: 30, scope: !586, inlinedAt: !904)
!911 = !DILocation(line: 111, scope: !588, inlinedAt: !912)
!912 = !DILocation(line: 111, scope: !588, inlinedAt: !913)
!913 = !DILocation(line: 70, scope: !907, inlinedAt: !908)
!914 = !DILocation(line: 40, scope: !563, inlinedAt: !915)
!915 = !DILocation(line: 3, scope: !592, inlinedAt: !916)
!916 = !DILocation(line: 3, scope: !594, inlinedAt: !917)
!917 = !DILocation(line: 89, scope: !596, inlinedAt: !918)
!918 = !DILocation(line: 124, scope: !598, inlinedAt: !919)
!919 = !DILocation(line: 92, scope: !600, inlinedAt: !920)
!920 = !DILocation(line: 0, scope: !576, inlinedAt: !921)
!921 = !DILocation(line: 0, scope: !603, inlinedAt: !922)
!922 = !DILocation(line: 115, scope: !923, inlinedAt: !913)
!923 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!924 = !DILocation(line: 87, scope: !571, inlinedAt: !925)
!925 = !DILocation(line: 1042, scope: !571, inlinedAt: !917)
!926 = !DILocation(line: 40, scope: !563, inlinedAt: !927)
!927 = !DILocation(line: 3, scope: !592, inlinedAt: !928)
!928 = !DILocation(line: 3, scope: !594, inlinedAt: !929)
!929 = !DILocation(line: 89, scope: !614, inlinedAt: !918)
!930 = !DILocation(line: 40, scope: !563, inlinedAt: !931)
!931 = !DILocation(line: 3, scope: !592, inlinedAt: !932)
!932 = !DILocation(line: 3, scope: !594, inlinedAt: !933)
!933 = !DILocation(line: 89, scope: !619, inlinedAt: !918)
!934 = !DILocation(line: 763, scope: !621, inlinedAt: !935)
!935 = !DILocation(line: 789, scope: !623, inlinedAt: !936)
!936 = !DILocation(line: 7, scope: !625, inlinedAt: !937)
!937 = !DILocation(line: 358, scope: !627, inlinedAt: !938)
!938 = !DILocation(line: 381, scope: !629, inlinedAt: !939)
!939 = !DILocation(line: 449, scope: !631, inlinedAt: !940)
!940 = !DILocation(line: 492, scope: !633, inlinedAt: !941)
!941 = !DILocation(line: 269, scope: !635, inlinedAt: !919)
!942 = !DILocation(line: 499, scope: !631, inlinedAt: !939)
!943 = !DILocation(line: 38, scope: !638, inlinedAt: !940)
!944 = !DILocation(line: 35, scope: !640, inlinedAt: !941)
!945 = !DILocation(line: 93, scope: !600, inlinedAt: !920)
!946 = !DILocation(line: 37, scope: !584, inlinedAt: !947)
!947 = !DILocation(line: 124, scope: !600, inlinedAt: !920)
!948 = !DILocation(line: 27, scope: !645, inlinedAt: !949)
!949 = !DILocation(line: 37, scope: !647, inlinedAt: !950)
!950 = !DILocation(line: 36, scope: !647, inlinedAt: !947)
!951 = !DILocation(line: 499, scope: !631, inlinedAt: !952)
!952 = !DILocation(line: 38, scope: !647, inlinedAt: !950)
!953 = !DILocation(line: 499, scope: !631, inlinedAt: !954)
!954 = !DILocation(line: 40, scope: !647, inlinedAt: !950)
!955 = !DILocation(line: 40, scope: !563, inlinedAt: !956)
!956 = !DILocation(line: 0, scope: !576, inlinedAt: !957)
!957 = !DILocation(line: 0, scope: !578, inlinedAt: !958)
!958 = !DILocation(line: 11, scope: !657, inlinedAt: !959)
!959 = !DILocation(line: 31, scope: !659, inlinedAt: !960)
!960 = !DILocation(line: 41, scope: !647, inlinedAt: !950)
!961 = !DILocation(line: 37, scope: !584, inlinedAt: !958)
!962 = !DILocation(line: 30, scope: !586, inlinedAt: !958)
!963 = !DILocation(line: 126, scope: !664, inlinedAt: !964)
!964 = !DILocation(line: 126, scope: !664, inlinedAt: !965)
!965 = !DILocation(line: 33, scope: !659, inlinedAt: !960)
!966 = !DILocation(line: 108, scope: !668, inlinedAt: !967)
!967 = !DILocation(line: 46, scope: !647, inlinedAt: !950)
!968 = !DILocation(line: 47, scope: !647, inlinedAt: !950)
!969 = !DILocation(line: 6, scope: !672, inlinedAt: !970)
!970 = !DILocation(line: 109, scope: !600, inlinedAt: !920)
!971 = !DILocation(line: 37, scope: !584, inlinedAt: !913)
!972 = !DILocation(line: 513, scope: !558, inlinedAt: !973)
!973 = !DILocation(line: 100, scope: !710, inlinedAt: !974)
!974 = !DILocation(line: 114, scope: !712, inlinedAt: !913)
!975 = !DILocation(line: 513, scope: !558, inlinedAt: !976)
!976 = !DILocation(line: 102, scope: !715, inlinedAt: !977)
!977 = !DILocation(line: 471, scope: !717, inlinedAt: !974)
!978 = !DILocation(line: 40, scope: !563, inlinedAt: !979)
!979 = !DILocation(line: 0, scope: !576, inlinedAt: !980)
!980 = !DILocation(line: 0, scope: !981, inlinedAt: !913)
!981 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!982 = !DILocation(line: 513, scope: !558, inlinedAt: !913)
!983 = !DILocation(line: 40, scope: !563, inlinedAt: !984)
!984 = !DILocation(line: 46, scope: !727, inlinedAt: !985)
!985 = !DILocation(line: 46, scope: !729, inlinedAt: !986)
!986 = !DILocation(line: 88, scope: !731, inlinedAt: !987)
!987 = !DILocation(line: 88, scope: !731, inlinedAt: !913)
!988 = !DILocation(line: 158, scope: !989, inlinedAt: !913)
!989 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!990 = !DILocation(line: 40, scope: !563, inlinedAt: !991)
!991 = !DILocation(line: 0, scope: !576, inlinedAt: !992)
!992 = !DILocation(line: 0, scope: !981, inlinedAt: !993)
!993 = !DILocation(line: 54, scope: !560, inlinedAt: !561)
!994 = !DILocation(line: 513, scope: !558, inlinedAt: !995)
!995 = !DILocation(line: 100, scope: !710, inlinedAt: !996)
!996 = !DILocation(line: 114, scope: !712, inlinedAt: !997)
!997 = !DILocation(line: 56, scope: !560, inlinedAt: !561)
!998 = !DILocation(line: 513, scope: !558, inlinedAt: !999)
!999 = !DILocation(line: 102, scope: !715, inlinedAt: !1000)
!1000 = !DILocation(line: 471, scope: !717, inlinedAt: !996)
!1001 = !DILocation(line: 40, scope: !563, inlinedAt: !1002)
!1002 = !DILocation(line: 46, scope: !727, inlinedAt: !1003)
!1003 = !DILocation(line: 46, scope: !729, inlinedAt: !1004)
!1004 = !DILocation(line: 88, scope: !731, inlinedAt: !1005)
!1005 = !DILocation(line: 88, scope: !731, inlinedAt: !1006)
!1006 = !DILocation(line: 88, scope: !731, inlinedAt: !997)
!1007 = !DILocation(line: 513, scope: !558, inlinedAt: !1008)
!1008 = !DILocation(line: 57, scope: !560, inlinedAt: !561)
!1009 = !DILocation(line: 40, scope: !563, inlinedAt: !1010)
!1010 = !DILocation(line: 0, scope: !576, inlinedAt: !1011)
!1011 = !DILocation(line: 0, scope: !578, inlinedAt: !1012)
!1012 = !DILocation(line: 19, scope: !1013, inlinedAt: !1014)
!1013 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1014 = !DILocation(line: 186, scope: !907, inlinedAt: !1015)
!1015 = !DILocation(line: 67, scope: !556)
!1016 = !DILocation(line: 37, scope: !584, inlinedAt: !1012)
!1017 = !DILocation(line: 30, scope: !586, inlinedAt: !1012)
!1018 = !DILocation(line: 111, scope: !588, inlinedAt: !1019)
!1019 = !DILocation(line: 111, scope: !588, inlinedAt: !1014)
!1020 = !DILocation(line: 37, scope: !584, inlinedAt: !1021)
!1021 = !DILocation(line: 187, scope: !907, inlinedAt: !1015)
!1022 = !DILocation(line: 513, scope: !558, inlinedAt: !1021)
!1023 = !DILocation(line: 40, scope: !563, inlinedAt: !1024)
!1024 = !DILocation(line: 3, scope: !592, inlinedAt: !1025)
!1025 = !DILocation(line: 3, scope: !594, inlinedAt: !1026)
!1026 = !DILocation(line: 89, scope: !596, inlinedAt: !1027)
!1027 = !DILocation(line: 124, scope: !598, inlinedAt: !1028)
!1028 = !DILocation(line: 92, scope: !600, inlinedAt: !1029)
!1029 = !DILocation(line: 0, scope: !576, inlinedAt: !1030)
!1030 = !DILocation(line: 0, scope: !603, inlinedAt: !1031)
!1031 = !DILocation(line: 115, scope: !923, inlinedAt: !1032)
!1032 = !DILocation(line: 192, scope: !907, inlinedAt: !1015)
!1033 = !DILocation(line: 87, scope: !571, inlinedAt: !1034)
!1034 = !DILocation(line: 1042, scope: !571, inlinedAt: !1026)
!1035 = !DILocation(line: 40, scope: !563, inlinedAt: !1036)
!1036 = !DILocation(line: 3, scope: !592, inlinedAt: !1037)
!1037 = !DILocation(line: 3, scope: !594, inlinedAt: !1038)
!1038 = !DILocation(line: 89, scope: !614, inlinedAt: !1027)
!1039 = !DILocation(line: 40, scope: !563, inlinedAt: !1040)
!1040 = !DILocation(line: 3, scope: !592, inlinedAt: !1041)
!1041 = !DILocation(line: 3, scope: !594, inlinedAt: !1042)
!1042 = !DILocation(line: 89, scope: !619, inlinedAt: !1027)
!1043 = !DILocation(line: 763, scope: !621, inlinedAt: !1044)
!1044 = !DILocation(line: 789, scope: !623, inlinedAt: !1045)
!1045 = !DILocation(line: 7, scope: !625, inlinedAt: !1046)
!1046 = !DILocation(line: 358, scope: !627, inlinedAt: !1047)
!1047 = !DILocation(line: 381, scope: !629, inlinedAt: !1048)
!1048 = !DILocation(line: 449, scope: !631, inlinedAt: !1049)
!1049 = !DILocation(line: 492, scope: !633, inlinedAt: !1050)
!1050 = !DILocation(line: 269, scope: !635, inlinedAt: !1028)
!1051 = !DILocation(line: 499, scope: !631, inlinedAt: !1048)
!1052 = !DILocation(line: 38, scope: !638, inlinedAt: !1049)
!1053 = !DILocation(line: 35, scope: !640, inlinedAt: !1050)
!1054 = !DILocation(line: 93, scope: !600, inlinedAt: !1029)
!1055 = !DILocation(line: 37, scope: !584, inlinedAt: !1056)
!1056 = !DILocation(line: 124, scope: !600, inlinedAt: !1029)
!1057 = !DILocation(line: 27, scope: !645, inlinedAt: !1058)
!1058 = !DILocation(line: 37, scope: !647, inlinedAt: !1059)
!1059 = !DILocation(line: 36, scope: !647, inlinedAt: !1056)
!1060 = !DILocation(line: 499, scope: !631, inlinedAt: !1061)
!1061 = !DILocation(line: 38, scope: !647, inlinedAt: !1059)
!1062 = !DILocation(line: 499, scope: !631, inlinedAt: !1063)
!1063 = !DILocation(line: 40, scope: !647, inlinedAt: !1059)
!1064 = !DILocation(line: 40, scope: !563, inlinedAt: !1065)
!1065 = !DILocation(line: 0, scope: !576, inlinedAt: !1066)
!1066 = !DILocation(line: 0, scope: !578, inlinedAt: !1067)
!1067 = !DILocation(line: 11, scope: !657, inlinedAt: !1068)
!1068 = !DILocation(line: 31, scope: !659, inlinedAt: !1069)
!1069 = !DILocation(line: 41, scope: !647, inlinedAt: !1059)
!1070 = !DILocation(line: 37, scope: !584, inlinedAt: !1067)
!1071 = !DILocation(line: 30, scope: !586, inlinedAt: !1067)
!1072 = !DILocation(line: 126, scope: !664, inlinedAt: !1073)
!1073 = !DILocation(line: 126, scope: !664, inlinedAt: !1074)
!1074 = !DILocation(line: 33, scope: !659, inlinedAt: !1069)
!1075 = !DILocation(line: 108, scope: !668, inlinedAt: !1076)
!1076 = !DILocation(line: 46, scope: !647, inlinedAt: !1059)
!1077 = !DILocation(line: 47, scope: !647, inlinedAt: !1059)
!1078 = !DILocation(line: 6, scope: !672, inlinedAt: !1079)
!1079 = !DILocation(line: 109, scope: !600, inlinedAt: !1029)
!1080 = !DILocation(line: 40, scope: !563, inlinedAt: !1081)
!1081 = !DILocation(line: 46, scope: !727, inlinedAt: !1082)
!1082 = !DILocation(line: 46, scope: !729, inlinedAt: !1083)
!1083 = !DILocation(line: 88, scope: !731, inlinedAt: !1084)
!1084 = !DILocation(line: 88, scope: !731, inlinedAt: !1085)
!1085 = !DILocation(line: 88, scope: !731, inlinedAt: !1086)
!1086 = !DILocation(line: 194, scope: !907, inlinedAt: !1015)
!1087 = !DILocation(line: 513, scope: !558, inlinedAt: !1088)
!1088 = !DILocation(line: 100, scope: !710, inlinedAt: !1089)
!1089 = !DILocation(line: 114, scope: !712, inlinedAt: !1090)
!1090 = !DILocation(line: 195, scope: !907, inlinedAt: !1015)
!1091 = !DILocation(line: 513, scope: !558, inlinedAt: !1092)
!1092 = !DILocation(line: 102, scope: !715, inlinedAt: !1093)
!1093 = !DILocation(line: 471, scope: !717, inlinedAt: !1089)
!1094 = !DILocation(line: 513, scope: !558, inlinedAt: !1095)
!1095 = !DILocation(line: 154, scope: !1096, inlinedAt: !1097)
!1096 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1097 = !DILocation(line: 197, scope: !907, inlinedAt: !1015)
!1098 = !DILocation(line: 40, scope: !563, inlinedAt: !1099)
!1099 = !DILocation(line: 46, scope: !727, inlinedAt: !1100)
!1100 = !DILocation(line: 46, scope: !729, inlinedAt: !1101)
!1101 = !DILocation(line: 88, scope: !731, inlinedAt: !1102)
!1102 = !DILocation(line: 88, scope: !731, inlinedAt: !1103)
!1103 = !DILocation(line: 88, scope: !731, inlinedAt: !1095)
!1104 = !DILocation(line: 513, scope: !558, inlinedAt: !1105)
!1105 = !DILocation(line: 100, scope: !710, inlinedAt: !1106)
!1106 = !DILocation(line: 114, scope: !712, inlinedAt: !1107)
!1107 = !DILocation(line: 155, scope: !1096, inlinedAt: !1097)
!1108 = !DILocation(line: 513, scope: !558, inlinedAt: !1109)
!1109 = !DILocation(line: 102, scope: !715, inlinedAt: !1110)
!1110 = !DILocation(line: 471, scope: !717, inlinedAt: !1106)
!1111 = !DILocation(line: 40, scope: !563, inlinedAt: !1112)
!1112 = !DILocation(line: 46, scope: !727, inlinedAt: !1113)
!1113 = !DILocation(line: 46, scope: !729, inlinedAt: !1114)
!1114 = !DILocation(line: 88, scope: !731, inlinedAt: !1115)
!1115 = !DILocation(line: 88, scope: !731, inlinedAt: !1116)
!1116 = !DILocation(line: 88, scope: !731, inlinedAt: !1117)
!1117 = !DILocation(line: 156, scope: !1096, inlinedAt: !1097)
!1118 = !DILocation(line: 513, scope: !558, inlinedAt: !1119)
!1119 = !DILocation(line: 100, scope: !710, inlinedAt: !1120)
!1120 = !DILocation(line: 114, scope: !712, inlinedAt: !1121)
!1121 = !DILocation(line: 157, scope: !1096, inlinedAt: !1097)
!1122 = !DILocation(line: 513, scope: !558, inlinedAt: !1123)
!1123 = !DILocation(line: 102, scope: !715, inlinedAt: !1124)
!1124 = !DILocation(line: 471, scope: !717, inlinedAt: !1120)
!1125 = !DILocation(line: 40, scope: !563, inlinedAt: !1126)
!1126 = !DILocation(line: 3, scope: !592, inlinedAt: !1127)
!1127 = !DILocation(line: 3, scope: !594, inlinedAt: !1128)
!1128 = !DILocation(line: 89, scope: !596, inlinedAt: !1129)
!1129 = !DILocation(line: 124, scope: !598, inlinedAt: !1130)
!1130 = !DILocation(line: 92, scope: !600, inlinedAt: !1131)
!1131 = !DILocation(line: 200, scope: !907, inlinedAt: !1015)
!1132 = !DILocation(line: 87, scope: !571, inlinedAt: !1133)
!1133 = !DILocation(line: 1042, scope: !571, inlinedAt: !1128)
!1134 = !DILocation(line: 40, scope: !563, inlinedAt: !1135)
!1135 = !DILocation(line: 3, scope: !592, inlinedAt: !1136)
!1136 = !DILocation(line: 3, scope: !594, inlinedAt: !1137)
!1137 = !DILocation(line: 89, scope: !614, inlinedAt: !1129)
!1138 = !DILocation(line: 40, scope: !563, inlinedAt: !1139)
!1139 = !DILocation(line: 3, scope: !592, inlinedAt: !1140)
!1140 = !DILocation(line: 3, scope: !594, inlinedAt: !1141)
!1141 = !DILocation(line: 89, scope: !619, inlinedAt: !1129)
!1142 = !DILocation(line: 763, scope: !621, inlinedAt: !1143)
!1143 = !DILocation(line: 789, scope: !623, inlinedAt: !1144)
!1144 = !DILocation(line: 7, scope: !625, inlinedAt: !1145)
!1145 = !DILocation(line: 358, scope: !627, inlinedAt: !1146)
!1146 = !DILocation(line: 381, scope: !629, inlinedAt: !1147)
!1147 = !DILocation(line: 449, scope: !631, inlinedAt: !1148)
!1148 = !DILocation(line: 492, scope: !633, inlinedAt: !1149)
!1149 = !DILocation(line: 269, scope: !635, inlinedAt: !1130)
!1150 = !DILocation(line: 499, scope: !631, inlinedAt: !1147)
!1151 = !DILocation(line: 38, scope: !638, inlinedAt: !1148)
!1152 = !DILocation(line: 35, scope: !640, inlinedAt: !1149)
!1153 = !DILocation(line: 93, scope: !600, inlinedAt: !1131)
!1154 = !DILocation(line: 155, scope: !1155, inlinedAt: !1156)
!1155 = distinct !DISubprogram(name: "pointer_from_objref;", linkageName: "pointer_from_objref", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1156 = !DILocation(line: 162, scope: !1157, inlinedAt: !1158)
!1157 = distinct !DISubprogram(name: "_pointer_from_type;", linkageName: "_pointer_from_type", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1158 = !DILocation(line: 166, scope: !1159, inlinedAt: !1160)
!1159 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !211, file: !211, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1160 = !DILocation(line: 107, scope: !600, inlinedAt: !1131)
!1161 = !DILocation(line: 795, scope: !623, inlinedAt: !1156)
!1162 = !DILocation(line: 40, scope: !563, inlinedAt: !1163)
!1163 = !DILocation(line: 46, scope: !727, inlinedAt: !1164)
!1164 = !DILocation(line: 46, scope: !729, inlinedAt: !1165)
!1165 = !DILocation(line: 88, scope: !731, inlinedAt: !1166)
!1166 = !DILocation(line: 88, scope: !731, inlinedAt: !1167)
!1167 = !DILocation(line: 88, scope: !731, inlinedAt: !1158)
!1168 = !DILocation(line: 513, scope: !558, inlinedAt: !1169)
!1169 = !DILocation(line: 100, scope: !710, inlinedAt: !1170)
!1170 = !DILocation(line: 114, scope: !712, inlinedAt: !1171)
!1171 = !DILocation(line: 167, scope: !1159, inlinedAt: !1160)
!1172 = !DILocation(line: 513, scope: !558, inlinedAt: !1173)
!1173 = !DILocation(line: 102, scope: !715, inlinedAt: !1174)
!1174 = !DILocation(line: 471, scope: !717, inlinedAt: !1170)
!1175 = !DILocation(line: 40, scope: !563, inlinedAt: !1176)
!1176 = !DILocation(line: 46, scope: !727, inlinedAt: !1177)
!1177 = !DILocation(line: 46, scope: !729, inlinedAt: !1178)
!1178 = !DILocation(line: 88, scope: !731, inlinedAt: !1179)
!1179 = !DILocation(line: 88, scope: !731, inlinedAt: !1180)
!1180 = !DILocation(line: 88, scope: !731, inlinedAt: !1181)
!1181 = !DILocation(line: 169, scope: !1159, inlinedAt: !1160)
!1182 = !DILocation(line: 513, scope: !558, inlinedAt: !1183)
!1183 = !DILocation(line: 100, scope: !710, inlinedAt: !1184)
!1184 = !DILocation(line: 114, scope: !712, inlinedAt: !1185)
!1185 = !DILocation(line: 170, scope: !1159, inlinedAt: !1160)
!1186 = !DILocation(line: 513, scope: !558, inlinedAt: !1187)
!1187 = !DILocation(line: 102, scope: !715, inlinedAt: !1188)
!1188 = !DILocation(line: 471, scope: !717, inlinedAt: !1184)
!1189 = !DILocation(line: 40, scope: !563, inlinedAt: !1190)
!1190 = !DILocation(line: 46, scope: !727, inlinedAt: !1191)
!1191 = !DILocation(line: 46, scope: !729, inlinedAt: !1192)
!1192 = !DILocation(line: 88, scope: !731, inlinedAt: !1193)
!1193 = !DILocation(line: 88, scope: !731, inlinedAt: !1194)
!1194 = !DILocation(line: 88, scope: !731, inlinedAt: !1160)
!1195 = !DILocation(line: 6, scope: !672, inlinedAt: !1196)
!1196 = !DILocation(line: 109, scope: !600, inlinedAt: !1131)
!1197 = !DILocation(line: 40, scope: !563, inlinedAt: !1198)
!1198 = !DILocation(line: 3, scope: !592, inlinedAt: !1199)
!1199 = !DILocation(line: 3, scope: !594, inlinedAt: !1200)
!1200 = !DILocation(line: 89, scope: !596, inlinedAt: !1201)
!1201 = !DILocation(line: 124, scope: !598, inlinedAt: !1202)
!1202 = !DILocation(line: 92, scope: !600, inlinedAt: !1203)
!1203 = !DILocation(line: 0, scope: !576, inlinedAt: !1204)
!1204 = !DILocation(line: 0, scope: !739, inlinedAt: !1205)
!1205 = !DILocation(line: 158, scope: !989, inlinedAt: !1131)
!1206 = !DILocation(line: 87, scope: !571, inlinedAt: !1207)
!1207 = !DILocation(line: 1042, scope: !571, inlinedAt: !1200)
!1208 = !DILocation(line: 40, scope: !563, inlinedAt: !1209)
!1209 = !DILocation(line: 3, scope: !592, inlinedAt: !1210)
!1210 = !DILocation(line: 3, scope: !594, inlinedAt: !1211)
!1211 = !DILocation(line: 89, scope: !614, inlinedAt: !1201)
!1212 = !DILocation(line: 40, scope: !563, inlinedAt: !1213)
!1213 = !DILocation(line: 3, scope: !592, inlinedAt: !1214)
!1214 = !DILocation(line: 3, scope: !594, inlinedAt: !1215)
!1215 = !DILocation(line: 89, scope: !619, inlinedAt: !1201)
!1216 = !DILocation(line: 763, scope: !621, inlinedAt: !1217)
!1217 = !DILocation(line: 789, scope: !623, inlinedAt: !1218)
!1218 = !DILocation(line: 7, scope: !625, inlinedAt: !1219)
!1219 = !DILocation(line: 358, scope: !627, inlinedAt: !1220)
!1220 = !DILocation(line: 381, scope: !629, inlinedAt: !1221)
!1221 = !DILocation(line: 449, scope: !631, inlinedAt: !1222)
!1222 = !DILocation(line: 492, scope: !633, inlinedAt: !1223)
!1223 = !DILocation(line: 269, scope: !635, inlinedAt: !1202)
!1224 = !DILocation(line: 499, scope: !631, inlinedAt: !1221)
!1225 = !DILocation(line: 38, scope: !638, inlinedAt: !1222)
!1226 = !DILocation(line: 35, scope: !640, inlinedAt: !1223)
!1227 = !DILocation(line: 93, scope: !600, inlinedAt: !1203)
!1228 = !DILocation(line: 37, scope: !584, inlinedAt: !1229)
!1229 = !DILocation(line: 174, scope: !600, inlinedAt: !1203)
!1230 = !DILocation(line: 27, scope: !645, inlinedAt: !1231)
!1231 = !DILocation(line: 37, scope: !647, inlinedAt: !1232)
!1232 = !DILocation(line: 36, scope: !647, inlinedAt: !1229)
!1233 = !DILocation(line: 499, scope: !631, inlinedAt: !1234)
!1234 = !DILocation(line: 38, scope: !647, inlinedAt: !1232)
!1235 = !DILocation(line: 499, scope: !631, inlinedAt: !1236)
!1236 = !DILocation(line: 40, scope: !647, inlinedAt: !1232)
!1237 = !DILocation(line: 40, scope: !563, inlinedAt: !1238)
!1238 = !DILocation(line: 0, scope: !576, inlinedAt: !1239)
!1239 = !DILocation(line: 0, scope: !578, inlinedAt: !1240)
!1240 = !DILocation(line: 11, scope: !657, inlinedAt: !1241)
!1241 = !DILocation(line: 31, scope: !659, inlinedAt: !1242)
!1242 = !DILocation(line: 41, scope: !647, inlinedAt: !1232)
!1243 = !DILocation(line: 37, scope: !584, inlinedAt: !1240)
!1244 = !DILocation(line: 30, scope: !586, inlinedAt: !1240)
!1245 = !DILocation(line: 126, scope: !664, inlinedAt: !1246)
!1246 = !DILocation(line: 126, scope: !664, inlinedAt: !1247)
!1247 = !DILocation(line: 33, scope: !659, inlinedAt: !1242)
!1248 = !DILocation(line: 108, scope: !668, inlinedAt: !1249)
!1249 = !DILocation(line: 46, scope: !647, inlinedAt: !1232)
!1250 = !DILocation(line: 47, scope: !647, inlinedAt: !1232)
!1251 = !DILocation(line: 37, scope: !584, inlinedAt: !1252)
!1252 = !DILocation(line: 176, scope: !600, inlinedAt: !1203)
!1253 = !DILocation(line: 12, scope: !805, inlinedAt: !1254)
!1254 = !DILocation(line: 61, scope: !807, inlinedAt: !1255)
!1255 = !DILocation(line: 60, scope: !807, inlinedAt: !1252)
!1256 = !DILocation(line: 499, scope: !631, inlinedAt: !1257)
!1257 = !DILocation(line: 62, scope: !807, inlinedAt: !1255)
!1258 = !DILocation(line: 499, scope: !631, inlinedAt: !1259)
!1259 = !DILocation(line: 64, scope: !807, inlinedAt: !1255)
!1260 = !DILocation(line: 40, scope: !563, inlinedAt: !1261)
!1261 = !DILocation(line: 0, scope: !576, inlinedAt: !1262)
!1262 = !DILocation(line: 0, scope: !578, inlinedAt: !1263)
!1263 = !DILocation(line: 11, scope: !657, inlinedAt: !1264)
!1264 = !DILocation(line: 31, scope: !659, inlinedAt: !1265)
!1265 = !DILocation(line: 65, scope: !807, inlinedAt: !1255)
!1266 = !DILocation(line: 37, scope: !584, inlinedAt: !1263)
!1267 = !DILocation(line: 30, scope: !586, inlinedAt: !1263)
!1268 = !DILocation(line: 126, scope: !664, inlinedAt: !1269)
!1269 = !DILocation(line: 126, scope: !664, inlinedAt: !1270)
!1270 = !DILocation(line: 33, scope: !659, inlinedAt: !1265)
!1271 = !DILocation(line: 108, scope: !668, inlinedAt: !1272)
!1272 = !DILocation(line: 70, scope: !807, inlinedAt: !1255)
!1273 = !DILocation(line: 71, scope: !807, inlinedAt: !1255)
!1274 = !DILocation(line: 37, scope: !584, inlinedAt: !1275)
!1275 = !DILocation(line: 188, scope: !600, inlinedAt: !1203)
!1276 = !DILocation(line: 19, scope: !849, inlinedAt: !1277)
!1277 = !DILocation(line: 19, scope: !849, inlinedAt: !1275)
!1278 = !DILocation(line: 6, scope: !672, inlinedAt: !1279)
!1279 = !DILocation(line: 109, scope: !600, inlinedAt: !1203)
!1280 = !DILocation(line: 40, scope: !563, inlinedAt: !1281)
!1281 = !DILocation(line: 0, scope: !576, inlinedAt: !1282)
!1282 = !DILocation(line: 0, scope: !578, inlinedAt: !1283)
!1283 = !DILocation(line: 27, scope: !1284, inlinedAt: !1285)
!1284 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1285 = !DILocation(line: 10, scope: !1286, inlinedAt: !1287)
!1286 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !27, retainedNodes: !66)
!1287 = !DILocation(line: 71, scope: !556)
!1288 = !DILocation(line: 37, scope: !584, inlinedAt: !1283)
!1289 = !DILocation(line: 30, scope: !586, inlinedAt: !1283)
!1290 = !DILocation(line: 111, scope: !588, inlinedAt: !1291)
!1291 = !DILocation(line: 111, scope: !588, inlinedAt: !1285)
!1292 = !DILocation(line: 40, scope: !563, inlinedAt: !1293)
!1293 = !DILocation(line: 3, scope: !592, inlinedAt: !1294)
!1294 = !DILocation(line: 3, scope: !594, inlinedAt: !1295)
!1295 = !DILocation(line: 89, scope: !596, inlinedAt: !1296)
!1296 = !DILocation(line: 124, scope: !598, inlinedAt: !1297)
!1297 = !DILocation(line: 92, scope: !600, inlinedAt: !1298)
!1298 = !DILocation(line: 0, scope: !576, inlinedAt: !1299)
!1299 = !DILocation(line: 0, scope: !603, inlinedAt: !1300)
!1300 = !DILocation(line: 71, scope: !605, inlinedAt: !1301)
!1301 = !DILocation(line: 65, scope: !605, inlinedAt: !1302)
!1302 = !DILocation(line: 11, scope: !1286, inlinedAt: !1287)
!1303 = !DILocation(line: 87, scope: !571, inlinedAt: !1304)
!1304 = !DILocation(line: 1042, scope: !571, inlinedAt: !1295)
!1305 = !DILocation(line: 40, scope: !563, inlinedAt: !1306)
!1306 = !DILocation(line: 3, scope: !592, inlinedAt: !1307)
!1307 = !DILocation(line: 3, scope: !594, inlinedAt: !1308)
!1308 = !DILocation(line: 89, scope: !614, inlinedAt: !1296)
!1309 = !DILocation(line: 40, scope: !563, inlinedAt: !1310)
!1310 = !DILocation(line: 3, scope: !592, inlinedAt: !1311)
!1311 = !DILocation(line: 3, scope: !594, inlinedAt: !1312)
!1312 = !DILocation(line: 89, scope: !619, inlinedAt: !1296)
!1313 = !DILocation(line: 763, scope: !621, inlinedAt: !1314)
!1314 = !DILocation(line: 789, scope: !623, inlinedAt: !1315)
!1315 = !DILocation(line: 7, scope: !625, inlinedAt: !1316)
!1316 = !DILocation(line: 358, scope: !627, inlinedAt: !1317)
!1317 = !DILocation(line: 381, scope: !629, inlinedAt: !1318)
!1318 = !DILocation(line: 449, scope: !631, inlinedAt: !1319)
!1319 = !DILocation(line: 492, scope: !633, inlinedAt: !1320)
!1320 = !DILocation(line: 269, scope: !635, inlinedAt: !1297)
!1321 = !DILocation(line: 499, scope: !631, inlinedAt: !1318)
!1322 = !DILocation(line: 38, scope: !638, inlinedAt: !1319)
!1323 = !DILocation(line: 35, scope: !640, inlinedAt: !1320)
!1324 = !DILocation(line: 93, scope: !600, inlinedAt: !1298)
!1325 = !DILocation(line: 37, scope: !584, inlinedAt: !1326)
!1326 = !DILocation(line: 124, scope: !600, inlinedAt: !1298)
!1327 = !DILocation(line: 27, scope: !645, inlinedAt: !1328)
!1328 = !DILocation(line: 37, scope: !647, inlinedAt: !1329)
!1329 = !DILocation(line: 36, scope: !647, inlinedAt: !1326)
!1330 = !DILocation(line: 499, scope: !631, inlinedAt: !1331)
!1331 = !DILocation(line: 38, scope: !647, inlinedAt: !1329)
!1332 = !DILocation(line: 499, scope: !631, inlinedAt: !1333)
!1333 = !DILocation(line: 40, scope: !647, inlinedAt: !1329)
!1334 = !DILocation(line: 40, scope: !563, inlinedAt: !1335)
!1335 = !DILocation(line: 0, scope: !576, inlinedAt: !1336)
!1336 = !DILocation(line: 0, scope: !578, inlinedAt: !1337)
!1337 = !DILocation(line: 11, scope: !657, inlinedAt: !1338)
!1338 = !DILocation(line: 31, scope: !659, inlinedAt: !1339)
!1339 = !DILocation(line: 41, scope: !647, inlinedAt: !1329)
!1340 = !DILocation(line: 37, scope: !584, inlinedAt: !1337)
!1341 = !DILocation(line: 30, scope: !586, inlinedAt: !1337)
!1342 = !DILocation(line: 126, scope: !664, inlinedAt: !1343)
!1343 = !DILocation(line: 126, scope: !664, inlinedAt: !1344)
!1344 = !DILocation(line: 33, scope: !659, inlinedAt: !1339)
!1345 = !DILocation(line: 108, scope: !668, inlinedAt: !1346)
!1346 = !DILocation(line: 46, scope: !647, inlinedAt: !1329)
!1347 = !DILocation(line: 47, scope: !647, inlinedAt: !1329)
!1348 = !DILocation(line: 6, scope: !672, inlinedAt: !1349)
!1349 = !DILocation(line: 109, scope: !600, inlinedAt: !1298)
!1350 = !DILocation(line: 40, scope: !563, inlinedAt: !1351)
!1351 = !DILocation(line: 3, scope: !592, inlinedAt: !1352)
!1352 = !DILocation(line: 3, scope: !594, inlinedAt: !1353)
!1353 = !DILocation(line: 89, scope: !596, inlinedAt: !1354)
!1354 = !DILocation(line: 124, scope: !598, inlinedAt: !1355)
!1355 = !DILocation(line: 92, scope: !600, inlinedAt: !1356)
!1356 = !DILocation(line: 0, scope: !576, inlinedAt: !1357)
!1357 = !DILocation(line: 0, scope: !682, inlinedAt: !1358)
!1358 = !DILocation(line: 72, scope: !605, inlinedAt: !1301)
!1359 = !DILocation(line: 87, scope: !571, inlinedAt: !1360)
!1360 = !DILocation(line: 1042, scope: !571, inlinedAt: !1353)
!1361 = !DILocation(line: 40, scope: !563, inlinedAt: !1362)
!1362 = !DILocation(line: 3, scope: !592, inlinedAt: !1363)
!1363 = !DILocation(line: 3, scope: !594, inlinedAt: !1364)
!1364 = !DILocation(line: 89, scope: !614, inlinedAt: !1354)
!1365 = !DILocation(line: 40, scope: !563, inlinedAt: !1366)
!1366 = !DILocation(line: 3, scope: !592, inlinedAt: !1367)
!1367 = !DILocation(line: 3, scope: !594, inlinedAt: !1368)
!1368 = !DILocation(line: 89, scope: !619, inlinedAt: !1354)
!1369 = !DILocation(line: 763, scope: !621, inlinedAt: !1370)
!1370 = !DILocation(line: 789, scope: !623, inlinedAt: !1371)
!1371 = !DILocation(line: 7, scope: !625, inlinedAt: !1372)
!1372 = !DILocation(line: 358, scope: !627, inlinedAt: !1373)
!1373 = !DILocation(line: 381, scope: !629, inlinedAt: !1374)
!1374 = !DILocation(line: 449, scope: !631, inlinedAt: !1375)
!1375 = !DILocation(line: 492, scope: !633, inlinedAt: !1376)
!1376 = !DILocation(line: 269, scope: !635, inlinedAt: !1355)
!1377 = !DILocation(line: 499, scope: !631, inlinedAt: !1374)
!1378 = !DILocation(line: 38, scope: !638, inlinedAt: !1375)
!1379 = !DILocation(line: 35, scope: !640, inlinedAt: !1376)
!1380 = !DILocation(line: 93, scope: !600, inlinedAt: !1356)
!1381 = !DILocation(line: 37, scope: !584, inlinedAt: !1382)
!1382 = !DILocation(line: 152, scope: !600, inlinedAt: !1356)
!1383 = !DILocation(line: 513, scope: !558, inlinedAt: !1384)
!1384 = !DILocation(line: 100, scope: !710, inlinedAt: !1385)
!1385 = !DILocation(line: 114, scope: !712, inlinedAt: !1382)
!1386 = !DILocation(line: 513, scope: !558, inlinedAt: !1387)
!1387 = !DILocation(line: 102, scope: !715, inlinedAt: !1388)
!1388 = !DILocation(line: 471, scope: !717, inlinedAt: !1385)
!1389 = !DILocation(line: 513, scope: !558, inlinedAt: !1390)
!1390 = !DILocation(line: 100, scope: !710, inlinedAt: !1391)
!1391 = !DILocation(line: 115, scope: !721, inlinedAt: !1382)
!1392 = !DILocation(line: 513, scope: !558, inlinedAt: !1393)
!1393 = !DILocation(line: 102, scope: !715, inlinedAt: !1394)
!1394 = !DILocation(line: 471, scope: !717, inlinedAt: !1391)
!1395 = !DILocation(line: 40, scope: !563, inlinedAt: !1396)
!1396 = !DILocation(line: 46, scope: !727, inlinedAt: !1397)
!1397 = !DILocation(line: 46, scope: !729, inlinedAt: !1398)
!1398 = !DILocation(line: 88, scope: !731, inlinedAt: !1399)
!1399 = !DILocation(line: 88, scope: !731, inlinedAt: !1400)
!1400 = !DILocation(line: 88, scope: !731, inlinedAt: !1382)
!1401 = !DILocation(line: 6, scope: !672, inlinedAt: !1402)
!1402 = !DILocation(line: 109, scope: !600, inlinedAt: !1356)
!1403 = !DILocation(line: 40, scope: !563, inlinedAt: !1404)
!1404 = !DILocation(line: 3, scope: !592, inlinedAt: !1405)
!1405 = !DILocation(line: 3, scope: !594, inlinedAt: !1406)
!1406 = !DILocation(line: 89, scope: !596, inlinedAt: !1407)
!1407 = !DILocation(line: 124, scope: !598, inlinedAt: !1408)
!1408 = !DILocation(line: 92, scope: !600, inlinedAt: !1409)
!1409 = !DILocation(line: 0, scope: !576, inlinedAt: !1410)
!1410 = !DILocation(line: 0, scope: !739, inlinedAt: !1411)
!1411 = !DILocation(line: 73, scope: !605, inlinedAt: !1301)
!1412 = !DILocation(line: 87, scope: !571, inlinedAt: !1413)
!1413 = !DILocation(line: 1042, scope: !571, inlinedAt: !1406)
!1414 = !DILocation(line: 40, scope: !563, inlinedAt: !1415)
!1415 = !DILocation(line: 3, scope: !592, inlinedAt: !1416)
!1416 = !DILocation(line: 3, scope: !594, inlinedAt: !1417)
!1417 = !DILocation(line: 89, scope: !614, inlinedAt: !1407)
!1418 = !DILocation(line: 40, scope: !563, inlinedAt: !1419)
!1419 = !DILocation(line: 3, scope: !592, inlinedAt: !1420)
!1420 = !DILocation(line: 3, scope: !594, inlinedAt: !1421)
!1421 = !DILocation(line: 89, scope: !619, inlinedAt: !1407)
!1422 = !DILocation(line: 763, scope: !621, inlinedAt: !1423)
!1423 = !DILocation(line: 789, scope: !623, inlinedAt: !1424)
!1424 = !DILocation(line: 7, scope: !625, inlinedAt: !1425)
!1425 = !DILocation(line: 358, scope: !627, inlinedAt: !1426)
!1426 = !DILocation(line: 381, scope: !629, inlinedAt: !1427)
!1427 = !DILocation(line: 449, scope: !631, inlinedAt: !1428)
!1428 = !DILocation(line: 492, scope: !633, inlinedAt: !1429)
!1429 = !DILocation(line: 269, scope: !635, inlinedAt: !1408)
!1430 = !DILocation(line: 499, scope: !631, inlinedAt: !1427)
!1431 = !DILocation(line: 38, scope: !638, inlinedAt: !1428)
!1432 = !DILocation(line: 35, scope: !640, inlinedAt: !1429)
!1433 = !DILocation(line: 93, scope: !600, inlinedAt: !1409)
!1434 = !DILocation(line: 37, scope: !584, inlinedAt: !1435)
!1435 = !DILocation(line: 174, scope: !600, inlinedAt: !1409)
!1436 = !DILocation(line: 27, scope: !645, inlinedAt: !1437)
!1437 = !DILocation(line: 37, scope: !647, inlinedAt: !1438)
!1438 = !DILocation(line: 36, scope: !647, inlinedAt: !1435)
!1439 = !DILocation(line: 499, scope: !631, inlinedAt: !1440)
!1440 = !DILocation(line: 38, scope: !647, inlinedAt: !1438)
!1441 = !DILocation(line: 499, scope: !631, inlinedAt: !1442)
!1442 = !DILocation(line: 40, scope: !647, inlinedAt: !1438)
!1443 = !DILocation(line: 40, scope: !563, inlinedAt: !1444)
!1444 = !DILocation(line: 0, scope: !576, inlinedAt: !1445)
!1445 = !DILocation(line: 0, scope: !578, inlinedAt: !1446)
!1446 = !DILocation(line: 11, scope: !657, inlinedAt: !1447)
!1447 = !DILocation(line: 31, scope: !659, inlinedAt: !1448)
!1448 = !DILocation(line: 41, scope: !647, inlinedAt: !1438)
!1449 = !DILocation(line: 37, scope: !584, inlinedAt: !1446)
!1450 = !DILocation(line: 30, scope: !586, inlinedAt: !1446)
!1451 = !DILocation(line: 126, scope: !664, inlinedAt: !1452)
!1452 = !DILocation(line: 126, scope: !664, inlinedAt: !1453)
!1453 = !DILocation(line: 33, scope: !659, inlinedAt: !1448)
!1454 = !DILocation(line: 108, scope: !668, inlinedAt: !1455)
!1455 = !DILocation(line: 46, scope: !647, inlinedAt: !1438)
!1456 = !DILocation(line: 47, scope: !647, inlinedAt: !1438)
!1457 = !DILocation(line: 37, scope: !584, inlinedAt: !1458)
!1458 = !DILocation(line: 176, scope: !600, inlinedAt: !1409)
!1459 = !DILocation(line: 12, scope: !805, inlinedAt: !1460)
!1460 = !DILocation(line: 61, scope: !807, inlinedAt: !1461)
!1461 = !DILocation(line: 60, scope: !807, inlinedAt: !1458)
!1462 = !DILocation(line: 499, scope: !631, inlinedAt: !1463)
!1463 = !DILocation(line: 62, scope: !807, inlinedAt: !1461)
!1464 = !DILocation(line: 499, scope: !631, inlinedAt: !1465)
!1465 = !DILocation(line: 64, scope: !807, inlinedAt: !1461)
!1466 = !DILocation(line: 40, scope: !563, inlinedAt: !1467)
!1467 = !DILocation(line: 0, scope: !576, inlinedAt: !1468)
!1468 = !DILocation(line: 0, scope: !578, inlinedAt: !1469)
!1469 = !DILocation(line: 11, scope: !657, inlinedAt: !1470)
!1470 = !DILocation(line: 31, scope: !659, inlinedAt: !1471)
!1471 = !DILocation(line: 65, scope: !807, inlinedAt: !1461)
!1472 = !DILocation(line: 37, scope: !584, inlinedAt: !1469)
!1473 = !DILocation(line: 30, scope: !586, inlinedAt: !1469)
!1474 = !DILocation(line: 126, scope: !664, inlinedAt: !1475)
!1475 = !DILocation(line: 126, scope: !664, inlinedAt: !1476)
!1476 = !DILocation(line: 33, scope: !659, inlinedAt: !1471)
!1477 = !DILocation(line: 108, scope: !668, inlinedAt: !1478)
!1478 = !DILocation(line: 70, scope: !807, inlinedAt: !1461)
!1479 = !DILocation(line: 71, scope: !807, inlinedAt: !1461)
!1480 = !DILocation(line: 37, scope: !584, inlinedAt: !1481)
!1481 = !DILocation(line: 188, scope: !600, inlinedAt: !1409)
!1482 = !DILocation(line: 19, scope: !849, inlinedAt: !1483)
!1483 = !DILocation(line: 19, scope: !849, inlinedAt: !1481)
!1484 = !DILocation(line: 6, scope: !672, inlinedAt: !1485)
!1485 = !DILocation(line: 109, scope: !600, inlinedAt: !1409)
!1486 = !DILocation(line: 72, scope: !556)
!1487 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2358", scope: null, file: !28, line: 30, type: !65, scopeLine: 30, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1488 = !DILocation(line: 40, scope: !1489, inlinedAt: !1490)
!1489 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1490 = !DILocation(line: 0, scope: !1491, inlinedAt: !1492)
!1491 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1492 = !DILocation(line: 0, scope: !1493, inlinedAt: !1494)
!1493 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1494 = !DILocation(line: 11, scope: !1495, inlinedAt: !1496)
!1495 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1496 = !DILocation(line: 31, scope: !1487)
!1497 = !DILocation(line: 37, scope: !1498, inlinedAt: !1494)
!1498 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1499 = !DILocation(line: 30, scope: !1500, inlinedAt: !1494)
!1500 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1501 = !DILocation(line: 126, scope: !1502, inlinedAt: !1503)
!1502 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !66)
!1503 = !DILocation(line: 126, scope: !1502, inlinedAt: !1504)
!1504 = !DILocation(line: 33, scope: !1487)
!1505 = !DILocation(line: 37, scope: !1487)
!1506 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2222", scope: null, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1507 = !DILocation(line: 40, scope: !1508, inlinedAt: !1509)
!1508 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1509 = !DILocation(line: 3, scope: !1510, inlinedAt: !1511)
!1510 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1511 = !DILocation(line: 3, scope: !1512, inlinedAt: !1513)
!1512 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1513 = !DILocation(line: 89, scope: !1514, inlinedAt: !1515)
!1514 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1515 = !DILocation(line: 124, scope: !1516, inlinedAt: !1517)
!1516 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1517 = !DILocation(line: 92, scope: !1518, inlinedAt: !1519)
!1518 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1519 = !DILocation(line: 0, scope: !1520, inlinedAt: !1521)
!1520 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1521 = !DILocation(line: 0, scope: !1506)
!1522 = !DILocation(line: 87, scope: !1523, inlinedAt: !1524)
!1523 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1524 = !DILocation(line: 1042, scope: !1523, inlinedAt: !1513)
!1525 = !DILocation(line: 40, scope: !1508, inlinedAt: !1526)
!1526 = !DILocation(line: 3, scope: !1510, inlinedAt: !1527)
!1527 = !DILocation(line: 3, scope: !1512, inlinedAt: !1528)
!1528 = !DILocation(line: 89, scope: !1529, inlinedAt: !1515)
!1529 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1530 = !DILocation(line: 40, scope: !1508, inlinedAt: !1531)
!1531 = !DILocation(line: 3, scope: !1510, inlinedAt: !1532)
!1532 = !DILocation(line: 3, scope: !1512, inlinedAt: !1533)
!1533 = !DILocation(line: 89, scope: !1534, inlinedAt: !1515)
!1534 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1535 = !DILocation(line: 763, scope: !1536, inlinedAt: !1537)
!1536 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1537 = !DILocation(line: 789, scope: !1538, inlinedAt: !1539)
!1538 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1539 = !DILocation(line: 7, scope: !1540, inlinedAt: !1541)
!1540 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1541 = !DILocation(line: 358, scope: !1542, inlinedAt: !1543)
!1542 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1543 = !DILocation(line: 381, scope: !1544, inlinedAt: !1545)
!1544 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1545 = !DILocation(line: 449, scope: !1546, inlinedAt: !1547)
!1546 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1547 = !DILocation(line: 492, scope: !1548, inlinedAt: !1549)
!1548 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1549 = !DILocation(line: 269, scope: !1550, inlinedAt: !1517)
!1550 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !172, file: !172, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1551 = !DILocation(line: 499, scope: !1546, inlinedAt: !1545)
!1552 = !DILocation(line: 38, scope: !1553, inlinedAt: !1547)
!1553 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1554 = !DILocation(line: 35, scope: !1555, inlinedAt: !1549)
!1555 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1556 = !DILocation(line: 93, scope: !1518, inlinedAt: !1519)
!1557 = !DILocation(line: 37, scope: !1558, inlinedAt: !1559)
!1558 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1559 = !DILocation(line: 174, scope: !1518, inlinedAt: !1519)
!1560 = !DILocation(line: 37, scope: !1558, inlinedAt: !1561)
!1561 = !DILocation(line: 176, scope: !1518, inlinedAt: !1519)
!1562 = !DILocation(line: 37, scope: !1558, inlinedAt: !1563)
!1563 = !DILocation(line: 188, scope: !1518, inlinedAt: !1519)
!1564 = !DILocation(line: 19, scope: !1565, inlinedAt: !1566)
!1565 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1566 = !DILocation(line: 19, scope: !1565, inlinedAt: !1563)
!1567 = !DILocation(line: 6, scope: !1568, inlinedAt: !1569)
!1568 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !196, file: !196, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !66)
!1569 = !DILocation(line: 109, scope: !1518, inlinedAt: !1519)
!1570 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2232", scope: null, file: !5, line: 32, type: !65, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1571 = !DILocation(line: 27, scope: !1572, inlinedAt: !1573)
!1572 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1573 = !DILocation(line: 37, scope: !1574, inlinedAt: !1575)
!1574 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1575 = !DILocation(line: 36, scope: !1570)
!1576 = !DILocation(line: 499, scope: !1577, inlinedAt: !1578)
!1577 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1578 = !DILocation(line: 38, scope: !1574, inlinedAt: !1575)
!1579 = !DILocation(line: 499, scope: !1577, inlinedAt: !1580)
!1580 = !DILocation(line: 40, scope: !1574, inlinedAt: !1575)
!1581 = !DILocation(line: 40, scope: !1582, inlinedAt: !1583)
!1582 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1583 = !DILocation(line: 0, scope: !1584, inlinedAt: !1585)
!1584 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1585 = !DILocation(line: 0, scope: !1586, inlinedAt: !1587)
!1586 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1587 = !DILocation(line: 11, scope: !1588, inlinedAt: !1589)
!1588 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1589 = !DILocation(line: 31, scope: !1590, inlinedAt: !1591)
!1590 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1591 = !DILocation(line: 41, scope: !1574, inlinedAt: !1575)
!1592 = !DILocation(line: 37, scope: !1593, inlinedAt: !1587)
!1593 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1594 = !DILocation(line: 30, scope: !1595, inlinedAt: !1587)
!1595 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1596 = !DILocation(line: 126, scope: !1597, inlinedAt: !1598)
!1597 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1598 = !DILocation(line: 126, scope: !1597, inlinedAt: !1599)
!1599 = !DILocation(line: 33, scope: !1590, inlinedAt: !1591)
!1600 = !DILocation(line: 108, scope: !1601, inlinedAt: !1602)
!1601 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !26, retainedNodes: !66)
!1602 = !DILocation(line: 46, scope: !1574, inlinedAt: !1575)
!1603 = !DILocation(line: 47, scope: !1574, inlinedAt: !1575)
!1604 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2229", scope: null, file: !5, line: 57, type: !65, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1605 = !DILocation(line: 12, scope: !1606, inlinedAt: !1607)
!1606 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1607 = !DILocation(line: 61, scope: !1608, inlinedAt: !1609)
!1608 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1609 = !DILocation(line: 60, scope: !1604)
!1610 = !DILocation(line: 499, scope: !1611, inlinedAt: !1612)
!1611 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1612 = !DILocation(line: 62, scope: !1608, inlinedAt: !1609)
!1613 = !DILocation(line: 499, scope: !1611, inlinedAt: !1614)
!1614 = !DILocation(line: 64, scope: !1608, inlinedAt: !1609)
!1615 = !DILocation(line: 40, scope: !1616, inlinedAt: !1617)
!1616 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1617 = !DILocation(line: 0, scope: !1618, inlinedAt: !1619)
!1618 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1619 = !DILocation(line: 0, scope: !1620, inlinedAt: !1621)
!1620 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1621 = !DILocation(line: 11, scope: !1622, inlinedAt: !1623)
!1622 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1623 = !DILocation(line: 31, scope: !1624, inlinedAt: !1625)
!1624 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1625 = !DILocation(line: 65, scope: !1608, inlinedAt: !1609)
!1626 = !DILocation(line: 37, scope: !1627, inlinedAt: !1621)
!1627 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1628 = !DILocation(line: 30, scope: !1629, inlinedAt: !1621)
!1629 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1630 = !DILocation(line: 126, scope: !1631, inlinedAt: !1632)
!1631 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !95, file: !95, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1632 = !DILocation(line: 126, scope: !1631, inlinedAt: !1633)
!1633 = !DILocation(line: 33, scope: !1624, inlinedAt: !1625)
!1634 = !DILocation(line: 108, scope: !1635, inlinedAt: !1636)
!1635 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !66)
!1636 = !DILocation(line: 70, scope: !1608, inlinedAt: !1609)
!1637 = !DILocation(line: 71, scope: !1608, inlinedAt: !1609)
!1638 = distinct !DISubprogram(name: "set_one!", linkageName: "julia_set_one!_1748", scope: null, file: !19, line: 366, type: !65, scopeLine: 366, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1639 = !DILocation(line: 40, scope: !1640, inlinedAt: !1641)
!1640 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1641 = !DILocation(line: 3, scope: !1642, inlinedAt: !1643)
!1642 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1643 = !DILocation(line: 3, scope: !1644, inlinedAt: !1645)
!1644 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1645 = !DILocation(line: 89, scope: !1646, inlinedAt: !1647)
!1646 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1647 = !DILocation(line: 124, scope: !1648, inlinedAt: !1649)
!1648 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1649 = !DILocation(line: 367, scope: !1638)
!1650 = !DILocation(line: 87, scope: !1651, inlinedAt: !1652)
!1651 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1652 = !DILocation(line: 1042, scope: !1651, inlinedAt: !1645)
!1653 = !DILocation(line: 40, scope: !1640, inlinedAt: !1654)
!1654 = !DILocation(line: 3, scope: !1642, inlinedAt: !1655)
!1655 = !DILocation(line: 3, scope: !1644, inlinedAt: !1656)
!1656 = !DILocation(line: 89, scope: !1657, inlinedAt: !1647)
!1657 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1658 = !DILocation(line: 40, scope: !1640, inlinedAt: !1659)
!1659 = !DILocation(line: 3, scope: !1642, inlinedAt: !1660)
!1660 = !DILocation(line: 3, scope: !1644, inlinedAt: !1661)
!1661 = !DILocation(line: 89, scope: !1662, inlinedAt: !1647)
!1662 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1663 = !DILocation(line: 40, scope: !1640, inlinedAt: !1664)
!1664 = !DILocation(line: 3, scope: !1642, inlinedAt: !1665)
!1665 = !DILocation(line: 3, scope: !1644, inlinedAt: !1666)
!1666 = !DILocation(line: 95, scope: !1667, inlinedAt: !1668)
!1667 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1668 = !DILocation(line: 132, scope: !1669, inlinedAt: !1649)
!1669 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1670 = !{i32 0, i32 -2}
!1671 = !DILocation(line: 87, scope: !1651, inlinedAt: !1672)
!1672 = !DILocation(line: 1042, scope: !1651, inlinedAt: !1666)
!1673 = !DILocation(line: 40, scope: !1640, inlinedAt: !1674)
!1674 = !DILocation(line: 3, scope: !1642, inlinedAt: !1675)
!1675 = !DILocation(line: 3, scope: !1644, inlinedAt: !1676)
!1676 = !DILocation(line: 95, scope: !1677, inlinedAt: !1668)
!1677 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1678 = !DILocation(line: 40, scope: !1640, inlinedAt: !1679)
!1679 = !DILocation(line: 3, scope: !1642, inlinedAt: !1680)
!1680 = !DILocation(line: 3, scope: !1644, inlinedAt: !1681)
!1681 = !DILocation(line: 95, scope: !1682, inlinedAt: !1668)
!1682 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1683 = !DILocation(line: 708, scope: !1684, inlinedAt: !1685)
!1684 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1685 = !DILocation(line: 784, scope: !1686, inlinedAt: !1687)
!1686 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1687 = !DILocation(line: 7, scope: !1688, inlinedAt: !1689)
!1688 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !161, file: !161, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1689 = !DILocation(line: 525, scope: !1690, inlinedAt: !1691)
!1690 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1691 = !DILocation(line: 1040, scope: !1692, inlinedAt: !1649)
!1692 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1693 = !DILocation(line: 86, scope: !1692, inlinedAt: !1694)
!1694 = !DILocation(line: 1042, scope: !1692, inlinedAt: !1649)
!1695 = !DILocation(line: 40, scope: !1640, inlinedAt: !1696)
!1696 = !DILocation(line: 33, scope: !1642, inlinedAt: !1697)
!1697 = !DILocation(line: 33, scope: !1698, inlinedAt: !1699)
!1698 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1699 = !DILocation(line: 103, scope: !1700, inlinedAt: !1701)
!1700 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1701 = !DILocation(line: 140, scope: !1702, inlinedAt: !1649)
!1702 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1703 = !{i16 0, i16 1023}
!1704 = !DILocation(line: 40, scope: !1640, inlinedAt: !1705)
!1705 = !DILocation(line: 33, scope: !1642, inlinedAt: !1706)
!1706 = !DILocation(line: 33, scope: !1698, inlinedAt: !1707)
!1707 = !DILocation(line: 103, scope: !1708, inlinedAt: !1701)
!1708 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1709 = !DILocation(line: 40, scope: !1640, inlinedAt: !1710)
!1710 = !DILocation(line: 33, scope: !1642, inlinedAt: !1711)
!1711 = !DILocation(line: 33, scope: !1698, inlinedAt: !1712)
!1712 = !DILocation(line: 103, scope: !1713, inlinedAt: !1701)
!1713 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !128, file: !128, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1714 = !DILocation(line: 708, scope: !1684, inlinedAt: !1715)
!1715 = !DILocation(line: 784, scope: !1686, inlinedAt: !1716)
!1716 = !DILocation(line: 7, scope: !1688, inlinedAt: !1717)
!1717 = !DILocation(line: 525, scope: !1690, inlinedAt: !1718)
!1718 = !DILocation(line: 1040, scope: !1719, inlinedAt: !1649)
!1719 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1720 = !DILocation(line: 88, scope: !1719, inlinedAt: !1721)
!1721 = !DILocation(line: 1042, scope: !1719, inlinedAt: !1649)
!1722 = !DILocation(line: 708, scope: !1684, inlinedAt: !1723)
!1723 = !DILocation(line: 784, scope: !1686, inlinedAt: !1724)
!1724 = !DILocation(line: 7, scope: !1688, inlinedAt: !1725)
!1725 = !DILocation(line: 525, scope: !1690, inlinedAt: !1726)
!1726 = !DILocation(line: 1040, scope: !1651, inlinedAt: !1649)
!1727 = !DILocation(line: 87, scope: !1651, inlinedAt: !1728)
!1728 = !DILocation(line: 1042, scope: !1651, inlinedAt: !1649)
!1729 = !DILocation(line: 87, scope: !1730, inlinedAt: !1732)
!1730 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !1731, file: !1731, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1731 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!1732 = !DILocation(line: 368, scope: !1638)
!1733 = !DILocation(line: 707, scope: !1734, inlinedAt: !1729)
!1734 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !1735, file: !1735, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1735 = !DIFile(filename: "abstractarray.jl", directory: ".")
!1736 = !DILocation(line: 37, scope: !1737, inlinedAt: !1738)
!1737 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !92, file: !92, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1738 = !DILocation(line: 73, scope: !1739, inlinedAt: !1740)
!1739 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !1731, file: !1731, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1740 = !DILocation(line: 98, scope: !1741, inlinedAt: !1742)
!1741 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !1735, file: !1735, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1742 = !DILocation(line: 133, scope: !1743, inlinedAt: !1744)
!1743 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !1735, file: !1735, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1744 = !DILocation(line: 382, scope: !1745, inlinedAt: !1746)
!1745 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !1735, file: !1735, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1746 = !DILocation(line: 694, scope: !1734, inlinedAt: !1747)
!1747 = !DILocation(line: 709, scope: !1734, inlinedAt: !1729)
!1748 = !DILocation(line: 29, scope: !1749, inlinedAt: !1751)
!1749 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !1750, file: !1750, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1750 = !DIFile(filename: "tuple.jl", directory: ".")
!1751 = !DILocation(line: 273, scope: !1752, inlinedAt: !1740)
!1752 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !1750, file: !1750, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1753 = !DILocation(line: 83, scope: !1754, inlinedAt: !1755)
!1754 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1755 = !DILocation(line: 510, scope: !1756, inlinedAt: !1757)
!1756 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !74, file: !74, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1757 = !DILocation(line: 444, scope: !1758, inlinedAt: !1760)
!1758 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !1759, file: !1759, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1759 = !DIFile(filename: "range.jl", directory: ".")
!1760 = !DILocation(line: 457, scope: !1758, inlinedAt: !1761)
!1761 = !DILocation(line: 459, scope: !1762, inlinedAt: !1751)
!1762 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !1759, file: !1759, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1763 = !DILocation(line: 575, scope: !1764, inlinedAt: !1755)
!1764 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !227, file: !227, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1765 = !DILocation(line: 488, scope: !1766, inlinedAt: !1767)
!1766 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !143, file: !143, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1767 = !DILocation(line: 768, scope: !1768, inlinedAt: !1746)
!1768 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !1735, file: !1735, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1769 = !DILocation(line: 38, scope: !1770, inlinedAt: !1767)
!1770 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !176, file: !176, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1771 = !DILocation(line: 710, scope: !1734, inlinedAt: !1729)
!1772 = !DILocation(line: 37, scope: !1737, inlinedAt: !1773)
!1773 = !DILocation(line: 68, scope: !1774, inlinedAt: !1775)
!1774 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !1731, file: !1731, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1775 = !DILocation(line: 89, scope: !1730, inlinedAt: !1732)
!1776 = !DILocation(line: 86, scope: !1692, inlinedAt: !1777)
!1777 = !DILocation(line: 40, scope: !1640, inlinedAt: !1778)
!1778 = !DILocation(line: 9, scope: !1779, inlinedAt: !1780)
!1779 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1780 = !DILocation(line: 9, scope: !1781, inlinedAt: !1782)
!1781 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1782 = !DILocation(line: 85, scope: !1783, inlinedAt: !1775)
!1783 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1784 = !DILocation(line: 523, scope: !1690, inlinedAt: !1785)
!1785 = !DILocation(line: 1040, scope: !1651, inlinedAt: !1732)
!1786 = !DILocation(line: 87, scope: !1651, inlinedAt: !1787)
!1787 = !DILocation(line: 1042, scope: !1651, inlinedAt: !1732)
!1788 = !DILocation(line: 93, scope: !1789, inlinedAt: !1732)
!1789 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !1731, file: !1731, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1790 = !DILocation(line: 707, scope: !1734, inlinedAt: !1788)
!1791 = !DILocation(line: 37, scope: !1737, inlinedAt: !1792)
!1792 = !DILocation(line: 73, scope: !1739, inlinedAt: !1793)
!1793 = !DILocation(line: 98, scope: !1741, inlinedAt: !1794)
!1794 = !DILocation(line: 133, scope: !1743, inlinedAt: !1795)
!1795 = !DILocation(line: 382, scope: !1745, inlinedAt: !1796)
!1796 = !DILocation(line: 694, scope: !1734, inlinedAt: !1797)
!1797 = !DILocation(line: 709, scope: !1734, inlinedAt: !1788)
!1798 = !DILocation(line: 29, scope: !1749, inlinedAt: !1799)
!1799 = !DILocation(line: 273, scope: !1752, inlinedAt: !1793)
!1800 = !DILocation(line: 83, scope: !1754, inlinedAt: !1801)
!1801 = !DILocation(line: 510, scope: !1756, inlinedAt: !1802)
!1802 = !DILocation(line: 444, scope: !1758, inlinedAt: !1803)
!1803 = !DILocation(line: 457, scope: !1758, inlinedAt: !1804)
!1804 = !DILocation(line: 459, scope: !1762, inlinedAt: !1799)
!1805 = !DILocation(line: 575, scope: !1764, inlinedAt: !1801)
!1806 = !DILocation(line: 488, scope: !1766, inlinedAt: !1807)
!1807 = !DILocation(line: 768, scope: !1768, inlinedAt: !1796)
!1808 = !DILocation(line: 38, scope: !1770, inlinedAt: !1807)
!1809 = !DILocation(line: 710, scope: !1734, inlinedAt: !1788)
!1810 = !DILocation(line: 37, scope: !1737, inlinedAt: !1811)
!1811 = !DILocation(line: 68, scope: !1774, inlinedAt: !1812)
!1812 = !DILocation(line: 95, scope: !1789, inlinedAt: !1732)
!1813 = !DILocation(line: 783, scope: !1814, inlinedAt: !1815)
!1814 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !13, file: !13, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1815 = !DILocation(line: 7, scope: !1688, inlinedAt: !1816)
!1816 = !DILocation(line: 88, scope: !1817, inlinedAt: !1812)
!1817 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1818 = !DILocation(line: 86, scope: !1692, inlinedAt: !1819)
!1819 = !DILocation(line: 40, scope: !1640, inlinedAt: !1820)
!1820 = !DILocation(line: 46, scope: !1779, inlinedAt: !1821)
!1821 = !DILocation(line: 46, scope: !1822, inlinedAt: !1816)
!1822 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !230, file: !230, type: !65, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !66)
!1823 = !DILocation(line: 96, scope: !1789, inlinedAt: !1732)
!1824 = !DILocation(line: 369, scope: !1638)
