; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@alloc_special___malloc_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@exception.8 = private unnamed_addr constant [10 x i8] c"exception\00", align 1

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #0

declare nonnull {}* @ijl_get_nth_field_checked({}*, i64) local_unnamed_addr

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #1

;  @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:385 within `llvm_atomic_cas`
define internal fastcc void @julia_llvm_atomic_cas_5065({ i64, i8 } addrspace(5)* noalias nocapture noundef nonnull sret({ i64, i8 }) align 8 dereferenceable(16) %0, i8 addrspace(1)* %1, i64 zeroext %2, i64 zeroext %3) unnamed_addr !dbg !134 {
top:
; ┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
   %4 = bitcast i8 addrspace(1)* %1 to i64 addrspace(1)*, !dbg !138
   %5 = cmpxchg i64 addrspace(1)* %4, i64 %2, i64 %3 acq_rel acquire, align 8, !dbg !138
   %6 = extractvalue { i64, i1 } %5, 0, !dbg !138
   %7 = extractvalue { i64, i1 } %5, 1, !dbg !138
   %8 = zext i1 %7 to i8, !dbg !138
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:463 within `macro expansion`
   %newstruct2.sroa.0.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 0, !dbg !144
   store i64 %6, i64 addrspace(5)* %newstruct2.sroa.0.0..sroa_idx, align 8, !dbg !144
   %newstruct2.sroa.2.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 1, !dbg !144
   store i8 %8, i8 addrspace(5)* %newstruct2.sroa.2.0..sroa_idx, align 8, !dbg !144
   ret void, !dbg !144
; └
}

;  @ boot.jl:764 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_5058(i8 zeroext %0) unnamed_addr !dbg !145 {
top:
  %1 = and i8 %0, 1, !dbg !147
  %2 = zext i8 %1 to i64, !dbg !147
  ret i64 %2, !dbg !147
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_5055(i8 zeroext %0) unnamed_addr !dbg !148 {
top:
  %1 = call fastcc i64 @julia_toUInt64_5058(i8 zeroext %0), !dbg !149
  ret i64 %1, !dbg !149
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_5052(i8 zeroext %0) unnamed_addr !dbg !150 {
top:
  %1 = call fastcc i64 @julia_UInt64_5055(i8 zeroext %0), !dbg !152
  ret i64 %1, !dbg !152
}

;  @ promotion.jl:367 within `_promote`
define internal fastcc void @julia__promote_5049([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !153 {
top:
;  @ promotion.jl:370 within `_promote`
  %3 = call fastcc i64 @julia_convert_5052(i8 zeroext %2), !dbg !155
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !155
  store i64 %1, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !155
  %newstruct.sroa.2.0..sroa_idx1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !155
  store i64 %3, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx1, align 8, !dbg !155
  ret void, !dbg !155
}

;  @ promotion.jl:391 within `promote`
define internal fastcc void @julia_promote_5046([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !156 {
top:
  %3 = alloca [2 x i64], align 8, addrspace(5)
;  @ promotion.jl:393 within `promote`
  call fastcc void @julia__promote_5049([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %3, i64 zeroext %1, i8 zeroext %2), !dbg !157
; ┌ @ tuple.jl:92 within `indexed_iterate` @ tuple.jl:92
   %memcpy_refined_src = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !158
; │ @ tuple.jl:92 within `indexed_iterate`
   %memcpy_refined_src1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !161
; └
;  @ promotion.jl:395 within `promote`
  %4 = load i64, i64 addrspace(5)* %memcpy_refined_src, align 8, !dbg !162, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = load i64, i64 addrspace(5)* %memcpy_refined_src1, align 8, !dbg !162, !tbaa !163, !alias.scope !167, !noalias !170
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !162
  store i64 %4, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !162
  %newstruct.sroa.2.0..sroa_idx3 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !162
  store i64 %5, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx3, align 8, !dbg !162
  ret void, !dbg !162
}

;  @ promotion.jl:461 within `==`
define internal fastcc i8 @julia____5043(i64 zeroext %0, i8 zeroext %1) unnamed_addr !dbg !175 {
top:
  %2 = alloca [2 x i64], align 8, addrspace(5)
  call fastcc void @julia_promote_5046([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %2, i64 zeroext %0, i8 zeroext %1), !dbg !176
  %3 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !176
  %4 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !176
;  @ promotion.jl:461 within `==` @ promotion.jl:521
  %unbox = load i64, i64 addrspace(5)* %3, align 8, !dbg !177, !tbaa !163, !alias.scope !167, !noalias !170
  %unbox1 = load i64, i64 addrspace(5)* %4, align 8, !dbg !177, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = icmp eq i64 %unbox, %unbox1, !dbg !177
  %6 = zext i1 %5 to i8, !dbg !177
;  @ promotion.jl:461 within `==`
  ret i8 %6, !dbg !176
}

declare nonnull {}* @ijl_apply_generic({}*, {}** noalias nocapture noundef readonly, i32) local_unnamed_addr

declare nonnull {}* @jl_f_tuple({}*, {}** noalias nocapture noundef readonly, i32) local_unnamed_addr

; Function Attrs: convergent norecurse nounwind
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #2 {
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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !179
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !185
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

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #0

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #3

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #4

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #5 {
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
define internal fastcc void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #2 {
  %4 = inttoptr i64 %0 to %0 addrspace(1)*
  %5 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 0
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !186
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !179
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %28, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !185
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %28

24:                                               ; preds = %3
  %25 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %26 = bitcast %1 addrspace(1)* %25 to i64 addrspace(1)* addrspace(1)*
  %27 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %26, align 8, !tbaa !187
  store atomic i64 %1, i64 addrspace(1)* %27 syncscope("one-as") release, align 8
  br label %28

28:                                               ; preds = %24, %17, %13
  ret void
}

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #6

; Function Attrs: nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #7

;  @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:385 within `llvm_atomic_cas`
define internal fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef nonnull sret({ i64, i8 }) align 8 dereferenceable(16) %0, i8 addrspace(1)* %1, i64 zeroext %2, i64 zeroext %3) unnamed_addr !dbg !188 {
top:
; ┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
   %4 = bitcast i8 addrspace(1)* %1 to i64 addrspace(1)*, !dbg !189
   %5 = cmpxchg i64 addrspace(1)* %4, i64 %2, i64 %3 acq_rel acquire, align 8, !dbg !189
   %6 = extractvalue { i64, i1 } %5, 0, !dbg !189
   %7 = extractvalue { i64, i1 } %5, 1, !dbg !189
   %8 = zext i1 %7 to i8, !dbg !189
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:463 within `macro expansion`
   %newstruct2.sroa.0.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 0, !dbg !194
   store i64 %6, i64 addrspace(5)* %newstruct2.sroa.0.0..sroa_idx, align 8, !dbg !194
   %newstruct2.sroa.2.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 1, !dbg !194
   store i8 %8, i8 addrspace(5)* %newstruct2.sroa.2.0..sroa_idx, align 8, !dbg !194
   ret void, !dbg !194
; └
}

;  @ promotion.jl:461 within `==`
define internal fastcc i8 @julia____2606(i64 zeroext %0, i8 zeroext %1) unnamed_addr !dbg !195 {
top:
  %2 = alloca [2 x i64], align 8, addrspace(5)
  call fastcc void @julia_promote_2609([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %2, i64 zeroext %0, i8 zeroext %1), !dbg !196
  %3 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !196
  %4 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !196
;  @ promotion.jl:461 within `==` @ promotion.jl:521
  %unbox = load i64, i64 addrspace(5)* %3, align 8, !dbg !197, !tbaa !163, !alias.scope !167, !noalias !170
  %unbox1 = load i64, i64 addrspace(5)* %4, align 8, !dbg !197, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = icmp eq i64 %unbox, %unbox1, !dbg !197
  %6 = zext i1 %5 to i8, !dbg !197
;  @ promotion.jl:461 within `==`
  ret i8 %6, !dbg !196
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #8

;  @ promotion.jl:391 within `promote`
define internal fastcc void @julia_promote_2609([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !199 {
top:
  %3 = alloca [2 x i64], align 8, addrspace(5)
;  @ promotion.jl:393 within `promote`
  call fastcc void @julia__promote_2612([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %3, i64 zeroext %1, i8 zeroext %2), !dbg !200
; ┌ @ tuple.jl:92 within `indexed_iterate` @ tuple.jl:92
   %memcpy_refined_src = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !201
; │ @ tuple.jl:92 within `indexed_iterate`
   %memcpy_refined_src1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !203
; └
;  @ promotion.jl:395 within `promote`
  %4 = load i64, i64 addrspace(5)* %memcpy_refined_src, align 8, !dbg !204, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = load i64, i64 addrspace(5)* %memcpy_refined_src1, align 8, !dbg !204, !tbaa !163, !alias.scope !167, !noalias !170
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !204
  store i64 %4, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !204
  %newstruct.sroa.2.0..sroa_idx1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !204
  store i64 %5, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx1, align 8, !dbg !204
  ret void, !dbg !204
}

;  @ promotion.jl:367 within `_promote`
define internal fastcc void @julia__promote_2612([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !205 {
top:
;  @ promotion.jl:370 within `_promote`
  %3 = call fastcc i64 @julia_convert_2615(i8 zeroext %2), !dbg !206
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !206
  store i64 %1, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !206
  %newstruct.sroa.2.0..sroa_idx1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !206
  store i64 %3, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx1, align 8, !dbg !206
  ret void, !dbg !206
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2615(i8 zeroext %0) unnamed_addr !dbg !207 {
top:
  %1 = call fastcc i64 @julia_UInt64_2618(i8 zeroext %0), !dbg !208
  ret i64 %1, !dbg !208
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2618(i8 zeroext %0) unnamed_addr !dbg !209 {
top:
  %1 = call fastcc i64 @julia_toUInt64_2621(i8 zeroext %0), !dbg !210
  ret i64 %1, !dbg !210
}

;  @ boot.jl:764 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2621(i8 zeroext %0) unnamed_addr !dbg !211 {
top:
  %1 = and i8 %0, 1, !dbg !212
  %2 = zext i8 %1 to i64, !dbg !212
  ret i64 %2, !dbg !212
}

declare {}* @jl_int64_type() local_unnamed_addr

;  @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:385 within `llvm_atomic_cas`
define internal fastcc void @julia_llvm_atomic_cas_2967({ i64, i8 } addrspace(5)* noalias nocapture noundef nonnull sret({ i64, i8 }) align 8 dereferenceable(16) %0, i8 addrspace(1)* %1, i64 zeroext %2, i64 zeroext %3) unnamed_addr !dbg !213 {
top:
; ┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
   %4 = bitcast i8 addrspace(1)* %1 to i64 addrspace(1)*, !dbg !214
   %5 = cmpxchg i64 addrspace(1)* %4, i64 %2, i64 %3 acq_rel acquire, align 8, !dbg !214
   %6 = extractvalue { i64, i1 } %5, 0, !dbg !214
   %7 = extractvalue { i64, i1 } %5, 1, !dbg !214
   %8 = zext i1 %7 to i8, !dbg !214
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:463 within `macro expansion`
   %newstruct2.sroa.0.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 0, !dbg !219
   store i64 %6, i64 addrspace(5)* %newstruct2.sroa.0.0..sroa_idx, align 8, !dbg !219
   %newstruct2.sroa.2.0..sroa_idx = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %0, i32 0, i32 1, !dbg !219
   store i8 %8, i8 addrspace(5)* %newstruct2.sroa.2.0..sroa_idx, align 8, !dbg !219
   ret void, !dbg !219
; └
}

;  @ promotion.jl:461 within `==`
define internal fastcc i8 @julia____2945(i64 zeroext %0, i8 zeroext %1) unnamed_addr !dbg !220 {
top:
  %2 = alloca [2 x i64], align 8, addrspace(5)
  call fastcc void @julia_promote_2948([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %2, i64 zeroext %0, i8 zeroext %1), !dbg !221
  %3 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !221
  %4 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !221
;  @ promotion.jl:461 within `==` @ promotion.jl:521
  %unbox = load i64, i64 addrspace(5)* %3, align 8, !dbg !222, !tbaa !163, !alias.scope !167, !noalias !170
  %unbox1 = load i64, i64 addrspace(5)* %4, align 8, !dbg !222, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = icmp eq i64 %unbox, %unbox1, !dbg !222
  %6 = zext i1 %5 to i8, !dbg !222
;  @ promotion.jl:461 within `==`
  ret i8 %6, !dbg !221
}

;  @ promotion.jl:391 within `promote`
define internal fastcc void @julia_promote_2948([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !224 {
top:
  %3 = alloca [2 x i64], align 8, addrspace(5)
;  @ promotion.jl:393 within `promote`
  call fastcc void @julia__promote_2951([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %3, i64 zeroext %1, i8 zeroext %2), !dbg !225
; ┌ @ tuple.jl:92 within `indexed_iterate` @ tuple.jl:92
   %memcpy_refined_src = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !226
; │ @ tuple.jl:92 within `indexed_iterate`
   %memcpy_refined_src1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !228
; └
;  @ promotion.jl:395 within `promote`
  %4 = load i64, i64 addrspace(5)* %memcpy_refined_src, align 8, !dbg !229, !tbaa !163, !alias.scope !167, !noalias !170
  %5 = load i64, i64 addrspace(5)* %memcpy_refined_src1, align 8, !dbg !229, !tbaa !163, !alias.scope !167, !noalias !170
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !229
  store i64 %4, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !229
  %newstruct.sroa.2.0..sroa_idx1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !229
  store i64 %5, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx1, align 8, !dbg !229
  ret void, !dbg !229
}

;  @ promotion.jl:367 within `_promote`
define internal fastcc void @julia__promote_2951([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !230 {
top:
;  @ promotion.jl:370 within `_promote`
  %3 = call fastcc i64 @julia_convert_2954(i8 zeroext %2), !dbg !231
  %newstruct.sroa.0.0..sroa_idx = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !231
  store i64 %1, i64 addrspace(5)* %newstruct.sroa.0.0..sroa_idx, align 8, !dbg !231
  %newstruct.sroa.2.0..sroa_idx1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %0, i32 0, i32 1, !dbg !231
  store i64 %3, i64 addrspace(5)* %newstruct.sroa.2.0..sroa_idx1, align 8, !dbg !231
  ret void, !dbg !231
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2954(i8 zeroext %0) unnamed_addr !dbg !232 {
top:
  %1 = call fastcc i64 @julia_UInt64_2957(i8 zeroext %0), !dbg !233
  ret i64 %1, !dbg !233
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2957(i8 zeroext %0) unnamed_addr !dbg !234 {
top:
  %1 = call fastcc i64 @julia_toUInt64_2960(i8 zeroext %0), !dbg !235
  ret i64 %1, !dbg !235
}

;  @ boot.jl:764 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2960(i8 zeroext %0) unnamed_addr !dbg !236 {
top:
  %1 = and i8 %0, 1, !dbg !237
  %2 = zext i8 %1 to i64, !dbg !237
  ret i64 %2, !dbg !237
}

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #9

declare noalias nonnull {}** @julia.new_gc_frame(i32) local_unnamed_addr

declare void @julia.push_gc_frame({}**, i32) local_unnamed_addr

declare {}** @julia.get_gc_frame_slot({}**, i32) local_unnamed_addr

declare void @julia.pop_gc_frame({}**) local_unnamed_addr

;  @ boot.jl:757 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2891({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !238 {
top:
  %1 = call fastcc i64 @julia_check_top_bit_2894({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !239
  ret i64 %1, !dbg !239
}

;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:118 within `gc_pool_alloc`
define internal fastcc nonnull {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !240 {
top:
;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:119 within `gc_pool_alloc`
; ┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `malloc` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:12
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:66 within `malloc_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.8.extract.i10 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 8, !dbg !242
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:75 within `malloc_hc`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       store i64 %state.i.fca.8.extract.i10, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special___malloc_hostcall, i32 0, i32 0), align 32, !dbg !258, !tbaa !268
; │└└└└
; │┌ @ pointer.jl:119 within `unsafe_load` @ pointer.jl:119
    %coercion.i = inttoptr i64 %state.i.fca.8.extract.i10 to { i64, i8 addrspace(1)*, i64 }*, !dbg !271
    %pointerref.sroa.0.0..sroa_idx.i = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %coercion.i, i64 0, i32 0, !dbg !271
    %pointerref.sroa.0.0.copyload.i = load i64, i64* %pointerref.sroa.0.0..sroa_idx.i, align 1, !dbg !271, !tbaa !275, !alias.scope !276, !noalias !277
    %pointerref.sroa.6.0..sroa_idx37.i = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %coercion.i, i64 0, i32 1, !dbg !271
    %pointerref.sroa.6.0.copyload.i = load i8 addrspace(1)*, i8 addrspace(1)** %pointerref.sroa.6.0..sroa_idx37.i, align 1, !dbg !271, !tbaa !275, !alias.scope !276, !noalias !277
; │└
; │ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `malloc` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:13
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:9
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !278, !range !298
; ││││└└└└
; ││││┌ @ operators.jl:276 within `!=`
; │││││┌ @ int.jl:518 within `==` @ promotion.jl:461 @ promotion.jl:521
        %2 = icmp eq i32 %1, 0, !dbg !299
; ││││└└
      br i1 %2, label %L26.i, label %L46.i, !dbg !308

L26.i:                                            ; preds = %L42.i, %top
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.sroa.0.0.copyload.i, i64 0, i64 1, i32 4), !dbg !309
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %3, label %L42.i [
    i64 0, label %L46.i
    i64 5, label %L37.i
    i64 6, label %L37.i
  ], !dbg !316

L37.i:                                            ; preds = %L26.i, %L26.i
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %state.i24.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !317
; ││││││└└└
; ││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
         %memcpy_refined_dst20.i = inttoptr i64 %state.i24.fca.0.extract.i to i32*, !dbg !325
         store i32 1, i32* %memcpy_refined_dst20.i, align 1, !dbg !325
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !328
         unreachable, !dbg !328

L42.i:                                            ; preds = %L26.i
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !332
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L26.i, !dbg !335

L46.i:                                            ; preds = %L26.i, %top
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !336
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:10
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
      br i1 %2, label %L61.i, label %L71.i, !dbg !340

L61.i:                                            ; preds = %L46.i
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:91
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││││┌ @ none within `pointerset`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %4 = bitcast i8 addrspace(1)* %pointerref.sroa.6.0.copyload.i to i64 addrspace(1)*, !dbg !345
         store i64 %0, i64 addrspace(1)* %4, align 1, !dbg !345, !tbaa !352
         br label %L71.i, !dbg !345

L71.i:                                            ; preds = %L61.i, %L46.i
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !354
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:11
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
      br i1 %2, label %L91.i, label %gpu_malloc.exit, !dbg !356

L91.i:                                            ; preds = %L107.i, %L71.i
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %5 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.sroa.0.0.copyload.i, i64 1, i64 2, i32 4), !dbg !361
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
       switch i64 %5, label %L107.i [
    i64 1, label %L110.i
    i64 5, label %L102.i
    i64 6, label %L102.i
  ], !dbg !365

L102.i:                                           ; preds = %L91.i, %L91.i
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %state.i23.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !366
; ││││││└└└
; ││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
         %memcpy_refined_dst11.i = inttoptr i64 %state.i23.fca.0.extract.i to i32*, !dbg !372
         store i32 1, i32* %memcpy_refined_dst11.i, align 1, !dbg !372
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !374
         unreachable, !dbg !374

L107.i:                                           ; preds = %L91.i
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !376
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L91.i, !dbg !378

L110.i:                                           ; preds = %L91.i
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.sroa.0.0.copyload.i, i32 2), !dbg !379
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:521 within `==`
        %.not1625 = icmp eq i64 %6, 4, !dbg !385
; │││││└
       br i1 %.not1625, label %L131.i, label %L115.i, !dbg !387

L115.i:                                           ; preds = %L127.i, %L110.i
       %7 = phi i64 [ %8, %L127.i ], [ %6, %L110.i ]
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
       %.off = add i64 %7, -5, !dbg !388
       %switch = icmp ult i64 %.off, 2, !dbg !388
       br i1 %switch, label %L122.i, label %L127.i, !dbg !388

L122.i:                                           ; preds = %L115.i
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %state.i22.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !389
; ││││││└└└
; ││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
         %memcpy_refined_dst8.i = inttoptr i64 %state.i22.fca.0.extract.i to i32*, !dbg !395
         store i32 1, i32* %memcpy_refined_dst8.i, align 1, !dbg !395
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !397
         unreachable, !dbg !397

L127.i:                                           ; preds = %L115.i
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !399
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %8 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.sroa.0.0.copyload.i, i32 2), !dbg !379
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:521 within `==`
        %.not16 = icmp eq i64 %8, 4, !dbg !385
; │││││└
       br i1 %.not16, label %L131.i, label %L115.i, !dbg !387

L131.i:                                           ; preds = %L127.i, %L110.i
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:120
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││┌ @ none within `pointerref`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %9 = bitcast i8 addrspace(1)* %pointerref.sroa.6.0.copyload.i to i8 addrspace(1)* addrspace(1)*, !dbg !401
         %10 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %9, align 1, !dbg !401, !tbaa !352
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:121
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:521
       %.not17 = icmp eq i8 addrspace(1)* %10, null, !dbg !410
; ││││└
      br i1 %.not17, label %L139.i, label %L147.i, !dbg !413

L139.i:                                           ; preds = %L131.i
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:122
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %pointerref.sroa.0.0.copyload.i, i64 5, i32 3), !dbg !414
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:123
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %state.i21.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !418
; │││││└└└
; │││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
        %memcpy_refined_dst.i14 = inttoptr i64 %state.i21.fca.0.extract.i to i32*, !dbg !424
        store i32 1, i32* %memcpy_refined_dst.i14, align 1, !dbg !424
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !426
; ││││└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:124
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
       unreachable, !dbg !428

L147.i:                                           ; preds = %L131.i
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:126
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││┌ @ none within `pointerref`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %11 = bitcast i8 addrspace(1)* %10 to i64 addrspace(1)*, !dbg !431
         %12 = load i64, i64 addrspace(1)* %11, align 1, !dbg !431, !tbaa !352
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││││┌ @ none within `pointerset`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         store i64 %12, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !438, !tbaa !268
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       call fastcc void @__ockl_hsa_signal_store(i64 %pointerref.sroa.0.0.copyload.i, i64 0, i32 3), !dbg !444
       br label %gpu_malloc.exit, !dbg !444

gpu_malloc.exit:                                  ; preds = %L147.i, %L71.i
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !447
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:131
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││┌ @ none within `pointerref`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %13 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !449, !tbaa !268
; └└└└└└└
;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:120 within `gc_pool_alloc`
; ┌ @ pointer.jl:278 within `==` @ promotion.jl:521
   %.not = icmp eq i64 %13, 0, !dbg !456
; └
  br i1 %.not, label %L7, label %L10, !dbg !460

L7:                                               ; preds = %gpu_malloc.exit
;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:121 within `gc_pool_alloc`
; ┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `report_oom`
   call fastcc void @gpu_report_oom({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !461
; └
;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:122 within `gc_pool_alloc`
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !464
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !465
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !476
    store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !476
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !479
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !482

L10:                                              ; preds = %gpu_malloc.exit
; └
;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:124 within `gc_pool_alloc`
; ┌ @ pointer.jl:253 within `unsafe_pointer_to_objref`
   %14 = inttoptr i64 %13 to {}*, !dbg !483
; └
  ret {}* %14, !dbg !485
}

;  @ essentials.jl:517 within `oftype`
define internal fastcc i64 @julia_oftype_2882({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !486 {
top:
  %1 = call fastcc i64 @julia_convert_2885({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !489
  ret i64 %1, !dbg !489
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:13 within `err_buffer!`
; Function Attrs: noreturn
define internal fastcc void @julia_err_buffer__5032({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr #10 !dbg !490 {
top:
  %0 = alloca [4 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 1)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 1)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:14 within `err_buffer!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.2.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 2, !dbg !491
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `err_buffer!`
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.2.extract to i8 addrspace(1)*, !dbg !498
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:16 within `err_buffer!`
  %1 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 8), !dbg !501
  %2 = bitcast {}* %1 to i8 addrspace(1)**, !dbg !501
  store i8 addrspace(1)* %bitcast_coercion, i8 addrspace(1)** %2, align 8, !dbg !501, !tbaa !502, !alias.scope !506, !noalias !507
  %3 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %1, {}** %3, align 8
  store {}* %1, {}* addrspace(5)* %.sub, align 8, !dbg !501
  %4 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 1, !dbg !501
  store {}* inttoptr (i64 140714619133632 to {}*), {}* addrspace(5)* %4, align 8, !dbg !501
  %5 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 2, !dbg !501
  store {}* inttoptr (i64 140714841350448 to {}*), {}* addrspace(5)* %5, align 8, !dbg !501
  %6 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 3, !dbg !501
  store {}* inttoptr (i64 140711540654808 to {}*), {}* addrspace(5)* %6, align 8, !dbg !501
  %7 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !501
  %8 = call nonnull {}* @ijl_apply_generic({}* inttoptr (i64 140712826536560 to {}*), {}** %7, i32 4), !dbg !501
  call void @llvm.trap(), !dbg !501
  unreachable, !dbg !501
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2549({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !508 {
top:
  %1 = call fastcc i64 @julia_toUInt64_2552({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !509
  ret i64 %1, !dbg !509
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_2623({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !510 {
top:
  %2 = alloca [2 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
  %3 = add i64 %1, -1, !dbg !512
  %4 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 16), !dbg !512
  %5 = bitcast {}* %4 to i8*, !dbg !512
  %6 = bitcast { i64, i8 }* %0 to i8*, !dbg !512
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %5, i8* noundef nonnull align 8 dereferenceable(16) %6, i64 16, i1 false), !dbg !512, !tbaa !275, !alias.scope !513, !noalias !514
  %7 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %4, {}** %7, align 8
  %8 = call {}* @ijl_get_nth_field_checked({}* nonnull %4, i64 %3), !dbg !512
; ┌ @ int.jl:87 within `+`
   %9 = add i64 %1, 1, !dbg !515
   %10 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
   store {}* %8, {}** %10, align 8
; └
  %11 = call fastcc {}* @ijl_box_int64({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %9), !dbg !512
  %12 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %11, {}** %12, align 8
  store {}* %8, {}* addrspace(5)* %.sub, align 8, !dbg !512
  %13 = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 1, !dbg !512
  store {}* %11, {}* addrspace(5)* %13, align 8, !dbg !512
  %14 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !512
  %15 = call nonnull {}* @jl_f_tuple({}* null, {}** %14, i32 2), !dbg !512
  call void @julia.pop_gc_frame({}** nonnull %gcframe)
  ret {}* %15, !dbg !512
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_4986({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !517 {
top:
  %1 = call fastcc i64 @julia_toUInt64_4989({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !518
  ret i64 %1, !dbg !518
}

;  @ REPL[2]:1 within `ker`
define amdgpu_kernel void @_Z3ker14ROCDeviceArrayI5Int64Li1ELi1EE({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr !dbg !519 {
conversion:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %1 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
  %2 = bitcast { i64, i8 } addrspace(5)* %1 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 16, i8 addrspace(5)* %2)
;  @ REPL[2]:2 within `ker`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
; │┌ @ abstractarray.jl:699 within `checkbounds`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_boundserror`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %3 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !521, !range !298
; ││││││└└
; ││││││┌ @ int.jl:1068 within `+` @ int.jl:87
         %4 = add nuw nsw i32 %3, 1, !dbg !544
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %5 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !547, !range !554
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %6 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !555
          %7 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 4, !dbg !555
          %8 = bitcast i8 addrspace(4)* %7 to i16 addrspace(4)*, !dbg !555
          %9 = load i16, i16 addrspace(4)* %8, align 4, !dbg !555, !range !563
          %10 = zext i16 %9 to i32, !dbg !555
; ││││└└└└
; ││││┌ @ int.jl:88 within `*`
       %11 = mul i32 %5, %10, !dbg !564
; ││││└
; ││││┌ @ int.jl:87 within `+`
       %12 = add i32 %4, %11, !dbg !566
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %13 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !567, !range !298
; ││││││└└
; ││││││┌ @ int.jl:1068 within `+` @ int.jl:87
         %14 = add nuw nsw i32 %13, 1, !dbg !574
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %15 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !576, !range !554
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %16 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 6, !dbg !582
          %17 = bitcast i8 addrspace(4)* %16 to i16 addrspace(4)*, !dbg !582
          %18 = load i16, i16 addrspace(4)* %17, align 2, !dbg !582, !range !563
          %19 = zext i16 %18 to i32, !dbg !582
; ││││└└└└
; ││││┌ @ int.jl:88 within `*`
       %20 = mul i32 %15, %19, !dbg !588
; ││││└
; ││││┌ @ int.jl:87 within `+`
       %21 = add i32 %14, %20, !dbg !589
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %22 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !590, !range !298
; ││││││└└
; ││││││┌ @ int.jl:1068 within `+` @ int.jl:87
         %23 = add nuw nsw i32 %22, 1, !dbg !597
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %24 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !599, !range !554
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %25 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 8, !dbg !605
          %26 = bitcast i8 addrspace(4)* %25 to i16 addrspace(4)*, !dbg !605
          %27 = load i16, i16 addrspace(4)* %26, align 4, !dbg !605, !range !563
          %28 = zext i16 %27 to i32, !dbg !605
; ││││└└└└
; ││││┌ @ int.jl:88 within `*`
       %29 = mul i32 %24, %28, !dbg !611
; ││││└
; ││││┌ @ int.jl:87 within `+`
       %30 = add i32 %23, %29, !dbg !612
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %31 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 12, !dbg !613
          %32 = bitcast i8 addrspace(4)* %31 to i32 addrspace(4)*, !dbg !613
          %33 = load i32, i32 addrspace(4)* %32, align 4, !dbg !613, !range !554
; ││││└└└└
; ││││┌ @ boot.jl:787 within `UInt64`
; │││││┌ @ boot.jl:761 within `toUInt64`
        %34 = zext i32 %33 to i64, !dbg !621
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %35 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 16, !dbg !625
          %36 = bitcast i8 addrspace(4)* %35 to i32 addrspace(4)*, !dbg !625
          %37 = load i32, i32 addrspace(4)* %36, align 4, !dbg !625, !range !554
; ││││└└└└
; ││││┌ @ boot.jl:787 within `UInt64`
; │││││┌ @ boot.jl:761 within `toUInt64`
        %38 = zext i32 %37 to i64, !dbg !621
        %39 = zext i32 %12 to i64, !dbg !621
        %40 = zext i32 %21 to i64, !dbg !621
        %41 = zext i32 %30 to i64, !dbg !621
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││││┌ @ int.jl:1068 within `-` @ int.jl:86
        %42 = add nsw i64 %40, -1, !dbg !630
        %43 = add nsw i64 %41, -1, !dbg !630
; │││││└
; │││││┌ @ int.jl:88 within `*`
        %44 = mul i64 %43, %38, !dbg !635
; │││││└
; │││││┌ @ int.jl:87 within `+`
        %45 = add i64 %42, %44, !dbg !636
; │││││└
; │││││┌ @ int.jl:88 within `*`
        %46 = mul i64 %45, %34, !dbg !635
; │││││└
; │││││┌ @ int.jl:87 within `+`
        %47 = add i64 %46, %39, !dbg !636
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %state.i.fca.1.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !637
; │││││└└
; │││││┌ @ essentials.jl:576 within `reinterpret`
        %bitcast_coercion.i = inttoptr i64 %state.i.fca.1.extract.i to i8 addrspace(1)*, !dbg !645
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
       call fastcc void @julia_llvm_atomic_cas_5065({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %1, i8 addrspace(1)* %bitcast_coercion.i, i64 zeroext 0, i64 zeroext %47), !dbg !647
       %48 = addrspacecast { i64, i8 } addrspace(5)* %1 to { i64, i8 }*, !dbg !647
       %49 = call fastcc {}* @julia_indexed_iterate_5062({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %48, i64 1), !dbg !647
       %50 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
       store {}* %49, {}** %50, align 8
       %51 = call {}* @ijl_get_nth_field_checked({}* nonnull %49, i64 0), !dbg !647
       %52 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
       store {}* %51, {}** %52, align 8
       %53 = call {}* @ijl_get_nth_field_checked({}* nonnull %49, i64 1), !dbg !647
       %54 = bitcast {}* %53 to i64*, !dbg !647
       %unbox.i = load i64, i64* %54, align 8, !dbg !647, !tbaa !648, !alias.scope !506, !noalias !507
       %55 = call fastcc {}* @julia_indexed_iterate_5060({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %48, i64 2), !dbg !647
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
       %56 = bitcast {}* %51 to i64*, !dbg !649
       %57 = getelementptr inbounds i64, i64* %56, i64 -1, !dbg !649
       %58 = load atomic i64, i64* %57 unordered, align 8, !dbg !649, !tbaa !650, !range !652
       %59 = and i64 %58, -16, !dbg !649
       %60 = inttoptr i64 %59 to {}*, !dbg !649
       %exactly_isa.i.not = icmp eq {}* %60, inttoptr (i64 192 to {}*), !dbg !649
       br i1 %exactly_isa.i.not, label %L105.i, label %L108.i, !dbg !649

L105.i:                                           ; preds = %conversion
; │││││┌ @ bool.jl:155 within `iszero`
; ││││││┌ @ bool.jl:35 within `!`
         %61 = bitcast {}* %51 to i8*, !dbg !653
         %unbox1.i = load i8, i8* %61, align 1, !dbg !653, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; │││││└└
       %extract.t = icmp ne i8 %unbox1.i, 1, !dbg !649
       br label %L115.i, !dbg !649

L108.i:                                           ; preds = %conversion
       %exactly_isa13.i.not = icmp eq {}* %60, inttoptr (i64 320 to {}*), !dbg !649
       br i1 %exactly_isa13.i.not, label %L110.i, label %L113.i, !dbg !649

L110.i:                                           ; preds = %L108.i
       %unbox14.i = load i64, i64* %56, align 8, !dbg !649, !tbaa !648, !alias.scope !506, !noalias !507
       %62 = call fastcc i8 @julia_iszero_4974({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox14.i), !dbg !649
       %63 = and i8 %62, 1, !dbg !649
       %extract.t45 = icmp ne i8 %63, 0, !dbg !649
       br label %L115.i, !dbg !649

L113.i:                                           ; preds = %L108.i
       call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !649
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %state.i.fca.0.extract.i2 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !660
; ││││││└└└
; ││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
         %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i2 to i32*, !dbg !666
         store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !666
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !668
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
        unreachable, !dbg !670

L115.i:                                           ; preds = %L110.i, %L105.i
        %value_phi.i.off0 = phi i1 [ %extract.t, %L105.i ], [ %extract.t45, %L110.i ]
; │││││└
       br i1 %exactly_isa.i.not, label %L119.i, label %L122.i, !dbg !649

L119.i:                                           ; preds = %L115.i
       %64 = bitcast {}* %51 to i8*, !dbg !649
       %unbox4.i = load i8, i8* %64, align 1, !dbg !649, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
       %65 = call fastcc i8 @julia____5043(i64 zeroext %47, i8 zeroext %unbox4.i), !dbg !649
       br label %L129.i, !dbg !649

L122.i:                                           ; preds = %L115.i
       %exactly_isa8.i.not = icmp eq {}* %60, inttoptr (i64 320 to {}*), !dbg !649
       br i1 %exactly_isa8.i.not, label %L124.i, label %L127.i, !dbg !649

L124.i:                                           ; preds = %L122.i
; │││││┌ @ promotion.jl:521 within `==`
        %unbox9.i = load i64, i64* %56, align 8, !dbg !671, !tbaa !648, !alias.scope !506, !noalias !507
        %66 = icmp eq i64 %47, %unbox9.i, !dbg !671
        %67 = zext i1 %66 to i8, !dbg !671
; │││││└
       br label %L129.i, !dbg !649

L127.i:                                           ; preds = %L122.i
       call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !649
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %state.i.fca.0.extract.i15 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !673
; ││││││└└└
; ││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
         %memcpy_refined_dst.i27 = inttoptr i64 %state.i.fca.0.extract.i15 to i32*, !dbg !679
         store i32 1, i32* %memcpy_refined_dst.i27, align 1, !dbg !679
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !681
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
        unreachable, !dbg !683

L129.i:                                           ; preds = %L124.i, %L119.i
        %value_phi5.i = phi i8 [ %65, %L119.i ], [ %67, %L124.i ]
; ││││└└
      %68 = and i8 %value_phi5.i, 1, !dbg !684
      %69 = icmp eq i8 %68, 0, !dbg !684
      %not.value_phi.i.off0 = xor i1 %value_phi.i.off0, true, !dbg !684
      %70 = select i1 %not.value_phi.i.off0, i1 %69, i1 false, !dbg !684
      br i1 %70, label %L135.i, label %L133.i, !dbg !684

L133.i:                                           ; preds = %L129.i
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
      call fastcc void @julia_err_buffer__5032({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !685
      unreachable, !dbg !685

L135.i:                                           ; preds = %L129.i
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
     call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !686
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %state.i.fca.0.extract.i30 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !687
; ││││└└└
; ││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
       %memcpy_refined_dst.i42 = inttoptr i64 %state.i.fca.0.extract.i30 to i32*, !dbg !693
       store i32 1, i32* %memcpy_refined_dst.i42, align 1, !dbg !693
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !695
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
      unreachable, !dbg !697
; └└└└
}

;  @ number.jl:42 within `iszero`
define internal fastcc i8 @julia_iszero_2876({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !698 {
top:
  %1 = call fastcc i64 @julia_zero_2879({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !699
; ┌ @ promotion.jl:521 within `==`
   %2 = icmp eq i64 %1, %0, !dbg !700
   %3 = zext i1 %2 to i8, !dbg !700
; └
  ret i8 %3, !dbg !699
}

;  @ number.jl:42 within `iszero`
define internal fastcc i8 @julia_iszero_4974({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !702 {
top:
  %1 = call fastcc i64 @julia_zero_4977({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !703
; ┌ @ promotion.jl:521 within `==`
   %2 = icmp eq i64 %1, %0, !dbg !704
   %3 = zext i1 %2 to i8, !dbg !704
; └
  ret i8 %3, !dbg !703
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:13 within `err_buffer!`
; Function Attrs: noreturn
define internal fastcc void @julia_err_buffer__2595({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr #10 !dbg !706 {
top:
  %0 = alloca [4 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 1)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 1)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:14 within `err_buffer!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.2.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 2, !dbg !707
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `err_buffer!`
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.2.extract to i8 addrspace(1)*, !dbg !714
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:16 within `err_buffer!`
  %1 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 8), !dbg !717
  %2 = bitcast {}* %1 to i8 addrspace(1)**, !dbg !717
  store i8 addrspace(1)* %bitcast_coercion, i8 addrspace(1)** %2, align 8, !dbg !717, !tbaa !502, !alias.scope !506, !noalias !507
  %3 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %1, {}** %3, align 8
  store {}* %1, {}* addrspace(5)* %.sub, align 8, !dbg !717
  %4 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 1, !dbg !717
  store {}* inttoptr (i64 140714619133632 to {}*), {}* addrspace(5)* %4, align 8, !dbg !717
  %5 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 2, !dbg !717
  store {}* inttoptr (i64 140714841350448 to {}*), {}* addrspace(5)* %5, align 8, !dbg !717
  %6 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 3, !dbg !717
  store {}* inttoptr (i64 140711540654808 to {}*), {}* addrspace(5)* %6, align 8, !dbg !717
  %7 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !717
  %8 = call nonnull {}* @ijl_apply_generic({}* inttoptr (i64 140712826536560 to {}*), {}** %7, i32 4), !dbg !717
  call void @llvm.trap(), !dbg !717
  unreachable, !dbg !717
}

;  @ boot.jl:757 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2552({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !718 {
top:
  %1 = call fastcc i64 @julia_check_top_bit_2555({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !719
  ret i64 %1, !dbg !719
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:13 within `err_buffer!`
; Function Attrs: noreturn
define internal fastcc void @julia_err_buffer__2934({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr #10 !dbg !720 {
top:
  %0 = alloca [4 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 1)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 1)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:14 within `err_buffer!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.2.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 2, !dbg !721
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `err_buffer!`
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.2.extract to i8 addrspace(1)*, !dbg !728
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:16 within `err_buffer!`
  %1 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 8), !dbg !731
  %2 = bitcast {}* %1 to i8 addrspace(1)**, !dbg !731
  store i8 addrspace(1)* %bitcast_coercion, i8 addrspace(1)** %2, align 8, !dbg !731, !tbaa !502, !alias.scope !506, !noalias !507
  %3 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %1, {}** %3, align 8
  store {}* %1, {}* addrspace(5)* %.sub, align 8, !dbg !731
  %4 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 1, !dbg !731
  store {}* inttoptr (i64 140714619133632 to {}*), {}* addrspace(5)* %4, align 8, !dbg !731
  %5 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 2, !dbg !731
  store {}* inttoptr (i64 140714841350448 to {}*), {}* addrspace(5)* %5, align 8, !dbg !731
  %6 = getelementptr inbounds [4 x {}*], [4 x {}*] addrspace(5)* %0, i32 0, i32 3, !dbg !731
  store {}* inttoptr (i64 140711540654808 to {}*), {}* addrspace(5)* %6, align 8, !dbg !731
  %7 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !731
  %8 = call nonnull {}* @ijl_apply_generic({}* inttoptr (i64 140712826536560 to {}*), {}** %7, i32 4), !dbg !731
  call void @llvm.trap(), !dbg !731
  unreachable, !dbg !731
}

;  @ boot.jl:644 within `check_top_bit`
define internal fastcc i64 @julia_check_top_bit_4992({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !732 {
top:
;  @ boot.jl:646 within `check_top_bit`
; ┌ @ boot.jl:636 within `is_top_bit_set`
   %1 = icmp sgt i64 %0, -1, !dbg !733
; └
  br i1 %1, label %L7, label %L5, !dbg !735

L5:                                               ; preds = %top
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_inexacterror`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %2 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !736, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %3 = add nuw nsw i32 %2, 1, !dbg !751
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %4 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !754, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %5 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !761
        %6 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 4, !dbg !761
        %7 = bitcast i8 addrspace(4)* %6 to i16 addrspace(4)*, !dbg !761
        %8 = load i16, i16 addrspace(4)* %7, align 4, !dbg !761, !range !563
        %9 = zext i16 %8 to i32, !dbg !761
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %10 = mul i32 %4, %9, !dbg !769
; ││└
; ││┌ @ int.jl:87 within `+`
     %11 = add i32 %3, %10, !dbg !771
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %12 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !772, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %13 = add nuw nsw i32 %12, 1, !dbg !779
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !781, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %15 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 6, !dbg !787
        %16 = bitcast i8 addrspace(4)* %15 to i16 addrspace(4)*, !dbg !787
        %17 = load i16, i16 addrspace(4)* %16, align 2, !dbg !787, !range !563
        %18 = zext i16 %17 to i32, !dbg !787
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %19 = mul i32 %14, %18, !dbg !793
; ││└
; ││┌ @ int.jl:87 within `+`
     %20 = add i32 %13, %19, !dbg !794
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %21 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !795, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %22 = add nuw nsw i32 %21, 1, !dbg !802
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %23 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !804, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %24 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 8, !dbg !810
        %25 = bitcast i8 addrspace(4)* %24 to i16 addrspace(4)*, !dbg !810
        %26 = load i16, i16 addrspace(4)* %25, align 4, !dbg !810, !range !563
        %27 = zext i16 %26 to i32, !dbg !810
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %28 = mul i32 %23, %27, !dbg !816
; ││└
; ││┌ @ int.jl:87 within `+`
     %29 = add i32 %22, %28, !dbg !817
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %30 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 12, !dbg !818
        %31 = bitcast i8 addrspace(4)* %30 to i32 addrspace(4)*, !dbg !818
        %32 = load i32, i32 addrspace(4)* %31, align 4, !dbg !818, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %33 = zext i32 %32 to i64, !dbg !826
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %34 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 16, !dbg !830
        %35 = bitcast i8 addrspace(4)* %34 to i32 addrspace(4)*, !dbg !830
        %36 = load i32, i32 addrspace(4)* %35, align 4, !dbg !830, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %37 = zext i32 %36 to i64, !dbg !826
      %38 = zext i32 %11 to i64, !dbg !826
      %39 = zext i32 %20 to i64, !dbg !826
      %40 = zext i32 %29 to i64, !dbg !826
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││┌ @ int.jl:1068 within `-` @ int.jl:86
      %41 = add nsw i64 %39, -1, !dbg !835
      %42 = add nsw i64 %40, -1, !dbg !835
; │││└
; │││┌ @ int.jl:88 within `*`
      %43 = mul i64 %42, %37, !dbg !840
; │││└
; │││┌ @ int.jl:87 within `+`
      %44 = add i64 %41, %43, !dbg !841
; │││└
; │││┌ @ int.jl:88 within `*`
      %45 = mul i64 %44, %33, !dbg !840
; │││└
; │││┌ @ int.jl:87 within `+`
      %46 = add i64 %45, %38, !dbg !841
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
    %47 = call fastcc i8 @julia_gate__5035({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %46), !dbg !842
    %48 = and i8 %47, 1, !dbg !842
    %.not = icmp eq i8 %48, 0, !dbg !842
    br i1 %.not, label %L97.i, label %L95.i, !dbg !842

L95.i:                                            ; preds = %L5
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
    call fastcc void @julia_err_buffer__5032({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !843
    unreachable, !dbg !843

L97.i:                                            ; preds = %L5
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
   call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !844
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !845
; ││└└└
; ││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
     %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !851
     store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !851
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
     call void @llvm.amdgcn.endpgm(), !dbg !853
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
    unreachable, !dbg !855

L7:                                               ; preds = %top
; └└
;  @ boot.jl:647 within `check_top_bit`
  ret i64 %0, !dbg !856
}

;  @ boot.jl:644 within `check_top_bit`
define internal fastcc i64 @julia_check_top_bit_2555({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !857 {
top:
;  @ boot.jl:646 within `check_top_bit`
; ┌ @ boot.jl:636 within `is_top_bit_set`
   %1 = icmp sgt i64 %0, -1, !dbg !858
; └
  br i1 %1, label %L7, label %L5, !dbg !860

L5:                                               ; preds = %top
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_inexacterror`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %2 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !861, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %3 = add nuw nsw i32 %2, 1, !dbg !876
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %4 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !879, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %5 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !886
        %6 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 4, !dbg !886
        %7 = bitcast i8 addrspace(4)* %6 to i16 addrspace(4)*, !dbg !886
        %8 = load i16, i16 addrspace(4)* %7, align 4, !dbg !886, !range !563
        %9 = zext i16 %8 to i32, !dbg !886
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %10 = mul i32 %4, %9, !dbg !894
; ││└
; ││┌ @ int.jl:87 within `+`
     %11 = add i32 %3, %10, !dbg !896
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %12 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !897, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %13 = add nuw nsw i32 %12, 1, !dbg !904
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !906, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %15 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 6, !dbg !912
        %16 = bitcast i8 addrspace(4)* %15 to i16 addrspace(4)*, !dbg !912
        %17 = load i16, i16 addrspace(4)* %16, align 2, !dbg !912, !range !563
        %18 = zext i16 %17 to i32, !dbg !912
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %19 = mul i32 %14, %18, !dbg !918
; ││└
; ││┌ @ int.jl:87 within `+`
     %20 = add i32 %13, %19, !dbg !919
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %21 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !920, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %22 = add nuw nsw i32 %21, 1, !dbg !927
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %23 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !929, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %24 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 8, !dbg !935
        %25 = bitcast i8 addrspace(4)* %24 to i16 addrspace(4)*, !dbg !935
        %26 = load i16, i16 addrspace(4)* %25, align 4, !dbg !935, !range !563
        %27 = zext i16 %26 to i32, !dbg !935
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %28 = mul i32 %23, %27, !dbg !941
; ││└
; ││┌ @ int.jl:87 within `+`
     %29 = add i32 %22, %28, !dbg !942
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %30 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 12, !dbg !943
        %31 = bitcast i8 addrspace(4)* %30 to i32 addrspace(4)*, !dbg !943
        %32 = load i32, i32 addrspace(4)* %31, align 4, !dbg !943, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %33 = zext i32 %32 to i64, !dbg !951
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %34 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 16, !dbg !955
        %35 = bitcast i8 addrspace(4)* %34 to i32 addrspace(4)*, !dbg !955
        %36 = load i32, i32 addrspace(4)* %35, align 4, !dbg !955, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %37 = zext i32 %36 to i64, !dbg !951
      %38 = zext i32 %11 to i64, !dbg !951
      %39 = zext i32 %20 to i64, !dbg !951
      %40 = zext i32 %29 to i64, !dbg !951
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││┌ @ int.jl:1068 within `-` @ int.jl:86
      %41 = add nsw i64 %39, -1, !dbg !960
      %42 = add nsw i64 %40, -1, !dbg !960
; │││└
; │││┌ @ int.jl:88 within `*`
      %43 = mul i64 %42, %37, !dbg !965
; │││└
; │││┌ @ int.jl:87 within `+`
      %44 = add i64 %41, %43, !dbg !966
; │││└
; │││┌ @ int.jl:88 within `*`
      %45 = mul i64 %44, %33, !dbg !965
; │││└
; │││┌ @ int.jl:87 within `+`
      %46 = add i64 %45, %38, !dbg !966
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
    %47 = call fastcc i8 @julia_gate__2598({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %46), !dbg !967
    %48 = and i8 %47, 1, !dbg !967
    %.not = icmp eq i8 %48, 0, !dbg !967
    br i1 %.not, label %L97.i, label %L95.i, !dbg !967

L95.i:                                            ; preds = %L5
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
    call fastcc void @julia_err_buffer__2595({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !968
    unreachable, !dbg !968

L97.i:                                            ; preds = %L5
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
   call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !969
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i.fca.0.extract.i.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !970
; ││└└└
; ││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
     %memcpy_refined_dst.i.i = inttoptr i64 %state.i.fca.0.extract.i.i to i32*, !dbg !976
     store i32 1, i32* %memcpy_refined_dst.i.i, align 1, !dbg !976
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
     call void @llvm.amdgcn.endpgm(), !dbg !978
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
    unreachable, !dbg !980

L7:                                               ; preds = %top
; └└
;  @ boot.jl:647 within `check_top_bit`
  ret i64 %0, !dbg !981
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_2964({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !982 {
top:
  %2 = call fastcc {}* @julia_indexed_iterate_2962({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %0, i64 %1), !dbg !983
  ret {}* %2, !dbg !983
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_2625({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !984 {
top:
  %2 = call fastcc {}* @julia_indexed_iterate_2623({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %0, i64 %1), !dbg !985
  ret {}* %2, !dbg !985
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_5062({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !986 {
top:
  %2 = call fastcc {}* @julia_indexed_iterate_5060({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %0, i64 %1), !dbg !987
  ret {}* %2, !dbg !987
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `gate!`
define internal fastcc i8 @julia_gate__2937({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !988 {
top:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %1 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.1.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !989
; └└
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.1.extract to i8 addrspace(1)*, !dbg !996
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
  call fastcc void @julia_llvm_atomic_cas_2967({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %1, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %0), !dbg !998
  %2 = addrspacecast { i64, i8 } addrspace(5)* %1 to { i64, i8 }*, !dbg !998
  %3 = call fastcc {}* @julia_indexed_iterate_2964({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 1), !dbg !998
  %4 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %3, {}** %4, align 8
  %5 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 0), !dbg !998
  %6 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
  store {}* %5, {}** %6, align 8
  %7 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 1), !dbg !998
  %8 = bitcast {}* %7 to i64*, !dbg !998
  %unbox = load i64, i64* %8, align 8, !dbg !998, !tbaa !648, !alias.scope !506, !noalias !507
  %9 = call fastcc {}* @julia_indexed_iterate_2962({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 2), !dbg !998
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
  %10 = bitcast {}* %5 to i64*, !dbg !999
  %11 = getelementptr inbounds i64, i64* %10, i64 -1, !dbg !999
  %12 = load atomic i64, i64* %11 unordered, align 8, !dbg !999, !tbaa !650, !range !652
  %13 = and i64 %12, -16, !dbg !999
  %14 = inttoptr i64 %13 to {}*, !dbg !999
  %exactly_isa.not = icmp eq {}* %14, inttoptr (i64 192 to {}*), !dbg !999
  br i1 %exactly_isa.not, label %L13, label %L16, !dbg !999

L13:                                              ; preds = %top
; ┌ @ bool.jl:155 within `iszero`
; │┌ @ bool.jl:35 within `!`
    %15 = bitcast {}* %5 to i8*, !dbg !1000
    %unbox1 = load i8, i8* %15, align 1, !dbg !1000, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; └└
  %extract.t = icmp ne i8 %unbox1, 1, !dbg !999
  br label %L23, !dbg !999

L16:                                              ; preds = %top
  %exactly_isa10.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !999
  br i1 %exactly_isa10.not, label %L18, label %L21, !dbg !999

L18:                                              ; preds = %L16
  %unbox11 = load i64, i64* %10, align 8, !dbg !999, !tbaa !648, !alias.scope !506, !noalias !507
  %16 = call fastcc i8 @julia_iszero_2876({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox11), !dbg !999
  %17 = and i8 %16, 1, !dbg !999
  %extract.t16 = icmp ne i8 %17, 0, !dbg !999
  br label %L23, !dbg !999

L21:                                              ; preds = %L16
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !999
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i2 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1004
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i14 = inttoptr i64 %state.i.fca.0.extract.i2 to i32*, !dbg !1010
    store i32 1, i32* %memcpy_refined_dst.i14, align 1, !dbg !1010
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1012
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1014

L23:                                              ; preds = %L18, %L13
   %value_phi.off0 = phi i1 [ %extract.t, %L13 ], [ %extract.t16, %L18 ]
; └
  br i1 %exactly_isa.not, label %L27, label %L30, !dbg !999

L27:                                              ; preds = %L23
  %18 = bitcast {}* %5 to i8*, !dbg !999
  %unbox4 = load i8, i8* %18, align 1, !dbg !999, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
  %19 = call fastcc i8 @julia____2945(i64 zeroext %0, i8 zeroext %unbox4), !dbg !999
  br label %L37, !dbg !999

L30:                                              ; preds = %L23
  %exactly_isa7.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !999
  br i1 %exactly_isa7.not, label %L32, label %L35, !dbg !999

L32:                                              ; preds = %L30
; ┌ @ promotion.jl:521 within `==`
   %unbox8 = load i64, i64* %10, align 8, !dbg !1015, !tbaa !648, !alias.scope !506, !noalias !507
   %20 = icmp eq i64 %unbox8, %0, !dbg !1015
   %21 = zext i1 %20 to i8, !dbg !1015
; └
  br label %L37, !dbg !999

L35:                                              ; preds = %L30
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !999
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1017
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !1023
    store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1023
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1025
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1027

L37:                                              ; preds = %L32, %L27
   %value_phi5 = phi i8 [ %19, %L27 ], [ %21, %L32 ]
; └
; ┌ @ essentials.jl:642 within `ifelse`
   %22 = select i1 %value_phi.off0, i8 1, i8 %value_phi5, !dbg !1028
   call void @julia.pop_gc_frame({}** nonnull %gcframe)
; └
  ret i8 %22, !dbg !999
}

;  @ boot.jl:757 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_4989({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1030 {
top:
  %1 = call fastcc i64 @julia_check_top_bit_4992({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1031
  ret i64 %1, !dbg !1031
}

;  @ number.jl:308 within `zero`
define internal fastcc i64 @julia_zero_2540({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr !dbg !1032 {
top:
  %0 = call fastcc i64 @julia_oftype_2543({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 0), !dbg !1033
  ret i64 %0, !dbg !1033
}

;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:212 within `box_int64`
define internal fastcc nonnull {}* @ijl_box_int64({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1034 {
top:
; ┌ @ none within `box`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:183
; ││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `malloc` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:12
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:66 within `malloc_hc`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %state.i.fca.8.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 8, !dbg !1035
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:75 within `malloc_hc`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││││┌ @ none within `pointerset`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         store i64 %state.i.fca.8.extract.i, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special___malloc_hostcall, i32 0, i32 0), align 32, !dbg !1049, !tbaa !268
; │││└└└└
; │││┌ @ pointer.jl:119 within `unsafe_load` @ pointer.jl:119
      %coercion.i = inttoptr i64 %state.i.fca.8.extract.i to { i64, i8 addrspace(1)*, i64 }*, !dbg !1056
      %pointerref.sroa.0.0..sroa_idx.i = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %coercion.i, i64 0, i32 0, !dbg !1056
      %pointerref.sroa.0.0.copyload.i = load i64, i64* %pointerref.sroa.0.0..sroa_idx.i, align 1, !dbg !1056, !tbaa !275, !alias.scope !276, !noalias !277
      %pointerref.sroa.6.0..sroa_idx37.i = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %coercion.i, i64 0, i32 1, !dbg !1056
      %pointerref.sroa.6.0.copyload.i = load i8 addrspace(1)*, i8 addrspace(1)** %pointerref.sroa.6.0..sroa_idx37.i, align 1, !dbg !1056, !tbaa !275, !alias.scope !276, !noalias !277
; │││└
; │││ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `malloc` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:13
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:9
; ││││┌ @ none within `hostcall_device_lock!`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
            %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1058, !range !298
; ││││││└└└└
; ││││││┌ @ operators.jl:276 within `!=`
; │││││││┌ @ int.jl:518 within `==` @ promotion.jl:461 @ promotion.jl:521
          %2 = icmp eq i32 %1, 0, !dbg !1069
; ││││││└└
        br i1 %2, label %L26.i, label %L46.i, !dbg !1073

L26.i:                                            ; preds = %L42.i, %top
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
          %3 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.sroa.0.0.copyload.i, i64 0, i64 1, i32 4), !dbg !1074
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
         switch i64 %3, label %L42.i [
    i64 0, label %L46.i
    i64 5, label %L37.i
    i64 6, label %L37.i
  ], !dbg !1078

L37.i:                                            ; preds = %L26.i, %L26.i
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││││┌ @ none within `kernel_state`
; ││││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
             %state.i24.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1079
; ││││││││└└└
; ││││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
           %memcpy_refined_dst20.i = inttoptr i64 %state.i24.fca.0.extract.i to i32*, !dbg !1085
           store i32 1, i32* %memcpy_refined_dst20.i, align 1, !dbg !1085
; ││││││││└
; ││││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
           call void @llvm.amdgcn.endpgm(), !dbg !1087
           unreachable, !dbg !1087

L42.i:                                            ; preds = %L26.i
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
          call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1089
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
         br label %L26.i, !dbg !1091

L46.i:                                            ; preds = %L26.i, %top
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !1092
; ││││└└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:10
; ││││┌ @ none within `hostcall_device_write_args!`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
        br i1 %2, label %L61.i, label %L71.i, !dbg !1094

L61.i:                                            ; preds = %L46.i
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:91
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││││││┌ @ none within `pointerset`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %4 = bitcast i8 addrspace(1)* %pointerref.sroa.6.0.copyload.i to i64 addrspace(1)*, !dbg !1098
           store i64 16, i64 addrspace(1)* %4, align 1, !dbg !1098, !tbaa !352
           br label %L71.i, !dbg !1098

L71.i:                                            ; preds = %L61.i, %L46.i
; ││││││└└└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !1105
; ││││└└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:11
; ││││┌ @ none within `hostcall_device_trigger_and_return!`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
        br i1 %2, label %L91.i, label %gpu_malloc.exit, !dbg !1107

L91.i:                                            ; preds = %L107.i, %L71.i
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
          %5 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.sroa.0.0.copyload.i, i64 1, i64 2, i32 4), !dbg !1111
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
         switch i64 %5, label %L107.i [
    i64 1, label %L110.i
    i64 5, label %L102.i
    i64 6, label %L102.i
  ], !dbg !1115

L102.i:                                           ; preds = %L91.i, %L91.i
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││││┌ @ none within `kernel_state`
; ││││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
             %state.i23.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1116
; ││││││││└└└
; ││││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
           %memcpy_refined_dst11.i = inttoptr i64 %state.i23.fca.0.extract.i to i32*, !dbg !1122
           store i32 1, i32* %memcpy_refined_dst11.i, align 1, !dbg !1122
; ││││││││└
; ││││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
           call void @llvm.amdgcn.endpgm(), !dbg !1124
           unreachable, !dbg !1124

L107.i:                                           ; preds = %L91.i
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
          call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1126
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
         br label %L91.i, !dbg !1128

L110.i:                                           ; preds = %L91.i
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
          %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.sroa.0.0.copyload.i, i32 2), !dbg !1129
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││││┌ @ promotion.jl:521 within `==`
          %.not110 = icmp eq i64 %6, 4, !dbg !1133
; │││││││└
         br i1 %.not110, label %L131.i, label %L115.i, !dbg !1135

L115.i:                                           ; preds = %L127.i, %L110.i
         %7 = phi i64 [ %8, %L127.i ], [ %6, %L110.i ]
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
         %.off = add i64 %7, -5, !dbg !1136
         %switch = icmp ult i64 %.off, 2, !dbg !1136
         br i1 %switch, label %L122.i, label %L127.i, !dbg !1136

L122.i:                                           ; preds = %L115.i
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││││┌ @ none within `kernel_state`
; ││││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
             %state.i22.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1137
; ││││││││└└└
; ││││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
           %memcpy_refined_dst8.i = inttoptr i64 %state.i22.fca.0.extract.i to i32*, !dbg !1143
           store i32 1, i32* %memcpy_refined_dst8.i, align 1, !dbg !1143
; ││││││││└
; ││││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
           call void @llvm.amdgcn.endpgm(), !dbg !1145
           unreachable, !dbg !1145

L127.i:                                           ; preds = %L115.i
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
          call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1147
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
          %8 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.sroa.0.0.copyload.i, i32 2), !dbg !1129
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││││┌ @ promotion.jl:521 within `==`
          %.not1 = icmp eq i64 %8, 4, !dbg !1133
; │││││││└
         br i1 %.not1, label %L131.i, label %L115.i, !dbg !1135

L131.i:                                           ; preds = %L127.i, %L110.i
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:120
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││││┌ @ none within `pointerref`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %9 = bitcast i8 addrspace(1)* %pointerref.sroa.6.0.copyload.i to i8 addrspace(1)* addrspace(1)*, !dbg !1149
           %10 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %9, align 1, !dbg !1149, !tbaa !352
; ││││││└└└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:121
; ││││││┌ @ int.jl:518 within `==` @ promotion.jl:521
         %.not2 = icmp eq i8 addrspace(1)* %10, null, !dbg !1156
; ││││││└
        br i1 %.not2, label %L139.i, label %L147.i, !dbg !1159

L139.i:                                           ; preds = %L131.i
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:122
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
         call fastcc void @__ockl_hsa_signal_store(i64 %pointerref.sroa.0.0.copyload.i, i64 5, i32 3), !dbg !1160
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:123
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
            %state.i21.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1163
; │││││││└└└
; │││││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
          %memcpy_refined_dst.i = inttoptr i64 %state.i21.fca.0.extract.i to i32*, !dbg !1169
          store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1169
; │││││││└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
          call void @llvm.amdgcn.endpgm(), !dbg !1171
; ││││││└└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:124
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
         unreachable, !dbg !1173

L147.i:                                           ; preds = %L131.i
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:126
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││││┌ @ none within `pointerref`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %11 = bitcast i8 addrspace(1)* %10 to i64 addrspace(1)*, !dbg !1175
           %12 = load i64, i64 addrspace(1)* %11, align 1, !dbg !1175, !tbaa !352
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; │││││││┌ @ none within `pointerset`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           store i64 %12, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !1182, !tbaa !268
; ││││││└└└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
         call fastcc void @__ockl_hsa_signal_store(i64 %pointerref.sroa.0.0.copyload.i, i64 0, i32 3), !dbg !1188
         br label %gpu_malloc.exit, !dbg !1188

gpu_malloc.exit:                                  ; preds = %L147.i, %L71.i
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !1191
; ││││││└
; ││││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:131
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; │││││││┌ @ none within `pointerref`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
           %13 = load i64, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special_hostcall_return, i32 0, i32 0), align 32, !dbg !1193, !tbaa !268
; ││└└└└└└└
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:187
; ││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:141 within `type_tag`
; │││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:141 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %14 = load i64, i64* bitcast ({}* ()* @jl_int64_type to i64*), align 4, !dbg !1200
; ││└└
; ││┌ @ int.jl:1068 within `|` @ int.jl:372
     %15 = or i64 %14, 3, !dbg !1206
; ││└
    %coercion = inttoptr i64 %13 to i64*, !dbg !1205
    store i64 %15, i64* %coercion, align 8, !dbg !1205, !tbaa !1209, !alias.scope !506, !noalias !507
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:190
; ││┌ @ pointer.jl:282 within `+`
     %16 = inttoptr i64 %13 to i8*, !dbg !1210
     %17 = getelementptr i8, i8* %16, i64 8, !dbg !1210
; ││└
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:191
    %coercion1 = bitcast i8* %17 to i64*, !dbg !1213
    store i64 %0, i64* %coercion1, align 8, !dbg !1213, !tbaa !1209, !alias.scope !506, !noalias !507
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:193
; ││┌ @ pointer.jl:253 within `unsafe_pointer_to_objref`
     %18 = bitcast i8* %17 to {}*, !dbg !1214
; └└└
  ret {}* %18, !dbg !1048
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `gate!`
define internal fastcc i8 @julia_gate__2598({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !1217 {
top:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %1 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.1.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !1218
; └└
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.1.extract to i8 addrspace(1)*, !dbg !1225
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
  call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %1, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %0), !dbg !1227
  %2 = addrspacecast { i64, i8 } addrspace(5)* %1 to { i64, i8 }*, !dbg !1227
  %3 = call fastcc {}* @julia_indexed_iterate_2625({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 1), !dbg !1227
  %4 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %3, {}** %4, align 8
  %5 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 0), !dbg !1227
  %6 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
  store {}* %5, {}** %6, align 8
  %7 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 1), !dbg !1227
  %8 = bitcast {}* %7 to i64*, !dbg !1227
  %unbox = load i64, i64* %8, align 8, !dbg !1227, !tbaa !648, !alias.scope !506, !noalias !507
  %9 = call fastcc {}* @julia_indexed_iterate_2623({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 2), !dbg !1227
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
  %10 = bitcast {}* %5 to i64*, !dbg !1228
  %11 = getelementptr inbounds i64, i64* %10, i64 -1, !dbg !1228
  %12 = load atomic i64, i64* %11 unordered, align 8, !dbg !1228, !tbaa !650, !range !652
  %13 = and i64 %12, -16, !dbg !1228
  %14 = inttoptr i64 %13 to {}*, !dbg !1228
  %exactly_isa.not = icmp eq {}* %14, inttoptr (i64 192 to {}*), !dbg !1228
  br i1 %exactly_isa.not, label %L13, label %L16, !dbg !1228

L13:                                              ; preds = %top
; ┌ @ bool.jl:155 within `iszero`
; │┌ @ bool.jl:35 within `!`
    %15 = bitcast {}* %5 to i8*, !dbg !1229
    %unbox1 = load i8, i8* %15, align 1, !dbg !1229, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; └└
  %extract.t = icmp ne i8 %unbox1, 1, !dbg !1228
  br label %L23, !dbg !1228

L16:                                              ; preds = %top
  %exactly_isa10.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !1228
  br i1 %exactly_isa10.not, label %L18, label %L21, !dbg !1228

L18:                                              ; preds = %L16
  %unbox11 = load i64, i64* %10, align 8, !dbg !1228, !tbaa !648, !alias.scope !506, !noalias !507
  %16 = call fastcc i8 @julia_iszero_2537({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox11), !dbg !1228
  %17 = and i8 %16, 1, !dbg !1228
  %extract.t16 = icmp ne i8 %17, 0, !dbg !1228
  br label %L23, !dbg !1228

L21:                                              ; preds = %L16
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1228
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i2 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1233
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i14 = inttoptr i64 %state.i.fca.0.extract.i2 to i32*, !dbg !1239
    store i32 1, i32* %memcpy_refined_dst.i14, align 1, !dbg !1239
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1241
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1243

L23:                                              ; preds = %L18, %L13
   %value_phi.off0 = phi i1 [ %extract.t, %L13 ], [ %extract.t16, %L18 ]
; └
  br i1 %exactly_isa.not, label %L27, label %L30, !dbg !1228

L27:                                              ; preds = %L23
  %18 = bitcast {}* %5 to i8*, !dbg !1228
  %unbox4 = load i8, i8* %18, align 1, !dbg !1228, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
  %19 = call fastcc i8 @julia____2606(i64 zeroext %0, i8 zeroext %unbox4), !dbg !1228
  br label %L37, !dbg !1228

L30:                                              ; preds = %L23
  %exactly_isa7.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !1228
  br i1 %exactly_isa7.not, label %L32, label %L35, !dbg !1228

L32:                                              ; preds = %L30
; ┌ @ promotion.jl:521 within `==`
   %unbox8 = load i64, i64* %10, align 8, !dbg !1244, !tbaa !648, !alias.scope !506, !noalias !507
   %20 = icmp eq i64 %unbox8, %0, !dbg !1244
   %21 = zext i1 %20 to i8, !dbg !1244
; └
  br label %L37, !dbg !1228

L35:                                              ; preds = %L30
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1228
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1246
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !1252
    store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1252
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1254
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1256

L37:                                              ; preds = %L32, %L27
   %value_phi5 = phi i8 [ %19, %L27 ], [ %21, %L32 ]
; └
; ┌ @ essentials.jl:642 within `ifelse`
   %22 = select i1 %value_phi.off0, i8 1, i8 %value_phi5, !dbg !1257
   call void @julia.pop_gc_frame({}** nonnull %gcframe)
; └
  ret i8 %22, !dbg !1228
}

;  @ number.jl:308 within `zero`
define internal fastcc i64 @julia_zero_2879({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr !dbg !1259 {
top:
  %0 = call fastcc i64 @julia_oftype_2882({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 0), !dbg !1260
  ret i64 %0, !dbg !1260
}

;  @ essentials.jl:517 within `oftype`
define internal fastcc i64 @julia_oftype_2543({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1261 {
top:
  %1 = call fastcc i64 @julia_convert_2546({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1262
  ret i64 %1, !dbg !1262
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2546({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1263 {
top:
  %1 = call fastcc i64 @julia_UInt64_2549({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1264
  ret i64 %1, !dbg !1264
}

;  @ number.jl:308 within `zero`
define internal fastcc i64 @julia_zero_4977({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr !dbg !1265 {
top:
  %0 = call fastcc i64 @julia_oftype_4980({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 0), !dbg !1266
  ret i64 %0, !dbg !1266
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_5060({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !1267 {
top:
  %2 = alloca [2 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
  %3 = add i64 %1, -1, !dbg !1268
  %4 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 16), !dbg !1268
  %5 = bitcast {}* %4 to i8*, !dbg !1268
  %6 = bitcast { i64, i8 }* %0 to i8*, !dbg !1268
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %5, i8* noundef nonnull align 8 dereferenceable(16) %6, i64 16, i1 false), !dbg !1268, !tbaa !275, !alias.scope !513, !noalias !514
  %7 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %4, {}** %7, align 8
  %8 = call {}* @ijl_get_nth_field_checked({}* nonnull %4, i64 %3), !dbg !1268
; ┌ @ int.jl:87 within `+`
   %9 = add i64 %1, 1, !dbg !1269
   %10 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
   store {}* %8, {}** %10, align 8
; └
  %11 = call fastcc {}* @ijl_box_int64({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %9), !dbg !1268
  %12 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %11, {}** %12, align 8
  store {}* %8, {}* addrspace(5)* %.sub, align 8, !dbg !1268
  %13 = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 1, !dbg !1268
  store {}* %11, {}* addrspace(5)* %13, align 8, !dbg !1268
  %14 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !1268
  %15 = call nonnull {}* @jl_f_tuple({}* null, {}** %14, i32 2), !dbg !1268
  call void @julia.pop_gc_frame({}** nonnull %gcframe)
  ret {}* %15, !dbg !1268
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {}* @julia_indexed_iterate_2962({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !1271 {
top:
  %2 = alloca [2 x {}*], align 8, addrspace(5)
  %.sub = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 0
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
  %3 = add i64 %1, -1, !dbg !1272
  %4 = call fastcc {}* @gpu_gc_pool_alloc({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 16), !dbg !1272
  %5 = bitcast {}* %4 to i8*, !dbg !1272
  %6 = bitcast { i64, i8 }* %0 to i8*, !dbg !1272
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %5, i8* noundef nonnull align 8 dereferenceable(16) %6, i64 16, i1 false), !dbg !1272, !tbaa !275, !alias.scope !513, !noalias !514
  %7 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %4, {}** %7, align 8
  %8 = call {}* @ijl_get_nth_field_checked({}* nonnull %4, i64 %3), !dbg !1272
; ┌ @ int.jl:87 within `+`
   %9 = add i64 %1, 1, !dbg !1273
   %10 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
   store {}* %8, {}** %10, align 8
; └
  %11 = call fastcc {}* @ijl_box_int64({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %9), !dbg !1272
  %12 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %11, {}** %12, align 8
  store {}* %8, {}* addrspace(5)* %.sub, align 8, !dbg !1272
  %13 = getelementptr inbounds [2 x {}*], [2 x {}*] addrspace(5)* %2, i32 0, i32 1, !dbg !1272
  store {}* %11, {}* addrspace(5)* %13, align 8, !dbg !1272
  %14 = addrspacecast {}* addrspace(5)* %.sub to {}**, !dbg !1272
  %15 = call nonnull {}* @jl_f_tuple({}* null, {}** %14, i32 2), !dbg !1272
  call void @julia.pop_gc_frame({}** nonnull %gcframe)
  ret {}* %15, !dbg !1272
}

;  @ boot.jl:644 within `check_top_bit`
define internal fastcc i64 @julia_check_top_bit_2894({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1275 {
top:
;  @ boot.jl:646 within `check_top_bit`
; ┌ @ boot.jl:636 within `is_top_bit_set`
   %1 = icmp sgt i64 %0, -1, !dbg !1276
; └
  br i1 %1, label %L7, label %L5, !dbg !1278

L5:                                               ; preds = %top
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_inexacterror`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %2 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1279, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %3 = add nuw nsw i32 %2, 1, !dbg !1294
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %4 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1297, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %5 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1304
        %6 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 4, !dbg !1304
        %7 = bitcast i8 addrspace(4)* %6 to i16 addrspace(4)*, !dbg !1304
        %8 = load i16, i16 addrspace(4)* %7, align 4, !dbg !1304, !range !563
        %9 = zext i16 %8 to i32, !dbg !1304
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %10 = mul i32 %4, %9, !dbg !1312
; ││└
; ││┌ @ int.jl:87 within `+`
     %11 = add i32 %3, %10, !dbg !1314
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %12 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1315, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %13 = add nuw nsw i32 %12, 1, !dbg !1322
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1324, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %15 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 6, !dbg !1330
        %16 = bitcast i8 addrspace(4)* %15 to i16 addrspace(4)*, !dbg !1330
        %17 = load i16, i16 addrspace(4)* %16, align 2, !dbg !1330, !range !563
        %18 = zext i16 %17 to i32, !dbg !1330
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %19 = mul i32 %14, %18, !dbg !1336
; ││└
; ││┌ @ int.jl:87 within `+`
     %20 = add i32 %13, %19, !dbg !1337
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %21 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1338, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %22 = add nuw nsw i32 %21, 1, !dbg !1345
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %23 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1347, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %24 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 8, !dbg !1353
        %25 = bitcast i8 addrspace(4)* %24 to i16 addrspace(4)*, !dbg !1353
        %26 = load i16, i16 addrspace(4)* %25, align 4, !dbg !1353, !range !563
        %27 = zext i16 %26 to i32, !dbg !1353
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %28 = mul i32 %23, %27, !dbg !1359
; ││└
; ││┌ @ int.jl:87 within `+`
     %29 = add i32 %22, %28, !dbg !1360
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %30 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 12, !dbg !1361
        %31 = bitcast i8 addrspace(4)* %30 to i32 addrspace(4)*, !dbg !1361
        %32 = load i32, i32 addrspace(4)* %31, align 4, !dbg !1361, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %33 = zext i32 %32 to i64, !dbg !1369
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %34 = getelementptr inbounds i8, i8 addrspace(4)* %5, i64 16, !dbg !1373
        %35 = bitcast i8 addrspace(4)* %34 to i32 addrspace(4)*, !dbg !1373
        %36 = load i32, i32 addrspace(4)* %35, align 4, !dbg !1373, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %37 = zext i32 %36 to i64, !dbg !1369
      %38 = zext i32 %11 to i64, !dbg !1369
      %39 = zext i32 %20 to i64, !dbg !1369
      %40 = zext i32 %29 to i64, !dbg !1369
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││┌ @ int.jl:1068 within `-` @ int.jl:86
      %41 = add nsw i64 %39, -1, !dbg !1378
      %42 = add nsw i64 %40, -1, !dbg !1378
; │││└
; │││┌ @ int.jl:88 within `*`
      %43 = mul i64 %42, %37, !dbg !1383
; │││└
; │││┌ @ int.jl:87 within `+`
      %44 = add i64 %41, %43, !dbg !1384
; │││└
; │││┌ @ int.jl:88 within `*`
      %45 = mul i64 %44, %33, !dbg !1383
; │││└
; │││┌ @ int.jl:87 within `+`
      %46 = add i64 %45, %38, !dbg !1384
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
    %47 = call fastcc i8 @julia_gate__2937({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %46), !dbg !1385
    %48 = and i8 %47, 1, !dbg !1385
    %.not = icmp eq i8 %48, 0, !dbg !1385
    br i1 %.not, label %L97.i, label %L95.i, !dbg !1385

L95.i:                                            ; preds = %L5
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
    call fastcc void @julia_err_buffer__2934({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !1386
    unreachable, !dbg !1386

L97.i:                                            ; preds = %L5
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
   call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1387
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i.fca.0.extract.i.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1388
; ││└└└
; ││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
     %memcpy_refined_dst.i.i = inttoptr i64 %state.i.fca.0.extract.i.i to i32*, !dbg !1394
     store i32 1, i32* %memcpy_refined_dst.i.i, align 1, !dbg !1394
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
     call void @llvm.amdgcn.endpgm(), !dbg !1396
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
    unreachable, !dbg !1398

L7:                                               ; preds = %top
; └└
;  @ boot.jl:647 within `check_top_bit`
  ret i64 %0, !dbg !1399
}

;  @ number.jl:42 within `iszero`
define internal fastcc i8 @julia_iszero_2537({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !1400 {
top:
  %1 = call fastcc i64 @julia_zero_2540({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !1401
; ┌ @ promotion.jl:521 within `==`
   %2 = icmp eq i64 %1, %0, !dbg !1402
   %3 = zext i1 %2 to i8, !dbg !1402
; └
  ret i8 %3, !dbg !1401
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:110 within `report_oom`
define internal fastcc void @gpu_report_oom({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state) unnamed_addr !dbg !1404 {
top:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %0 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:111 within `report_oom`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %1 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1405, !range !298
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %2 = add nuw nsw i32 %1, 1, !dbg !1418
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %3 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1421, !range !554
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %4 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1428
       %5 = getelementptr inbounds i8, i8 addrspace(4)* %4, i64 4, !dbg !1428
       %6 = bitcast i8 addrspace(4)* %5 to i16 addrspace(4)*, !dbg !1428
       %7 = load i16, i16 addrspace(4)* %6, align 4, !dbg !1428, !range !563
       %8 = zext i16 %7 to i32, !dbg !1428
; │└└└└
; │┌ @ int.jl:88 within `*`
    %9 = mul i32 %3, %8, !dbg !1436
; │└
; │┌ @ int.jl:87 within `+`
    %10 = add i32 %2, %9, !dbg !1438
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %11 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1439, !range !298
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %12 = add nuw nsw i32 %11, 1, !dbg !1446
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %13 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1448, !range !554
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %14 = getelementptr inbounds i8, i8 addrspace(4)* %4, i64 6, !dbg !1454
       %15 = bitcast i8 addrspace(4)* %14 to i16 addrspace(4)*, !dbg !1454
       %16 = load i16, i16 addrspace(4)* %15, align 2, !dbg !1454, !range !563
       %17 = zext i16 %16 to i32, !dbg !1454
; │└└└└
; │┌ @ int.jl:88 within `*`
    %18 = mul i32 %13, %17, !dbg !1460
; │└
; │┌ @ int.jl:87 within `+`
    %19 = add i32 %12, %18, !dbg !1461
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %20 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1462, !range !298
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %21 = add nuw nsw i32 %20, 1, !dbg !1469
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %22 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1471, !range !554
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %23 = getelementptr inbounds i8, i8 addrspace(4)* %4, i64 8, !dbg !1477
       %24 = bitcast i8 addrspace(4)* %23 to i16 addrspace(4)*, !dbg !1477
       %25 = load i16, i16 addrspace(4)* %24, align 4, !dbg !1477, !range !563
       %26 = zext i16 %25 to i32, !dbg !1477
; │└└└└
; │┌ @ int.jl:88 within `*`
    %27 = mul i32 %22, %26, !dbg !1483
; │└
; │┌ @ int.jl:87 within `+`
    %28 = add i32 %21, %27, !dbg !1484
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %29 = getelementptr inbounds i8, i8 addrspace(4)* %4, i64 12, !dbg !1485
       %30 = bitcast i8 addrspace(4)* %29 to i32 addrspace(4)*, !dbg !1485
       %31 = load i32, i32 addrspace(4)* %30, align 4, !dbg !1485, !range !554
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %32 = zext i32 %31 to i64, !dbg !1493
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %33 = getelementptr inbounds i8, i8 addrspace(4)* %4, i64 16, !dbg !1497
       %34 = bitcast i8 addrspace(4)* %33 to i32 addrspace(4)*, !dbg !1497
       %35 = load i32, i32 addrspace(4)* %34, align 4, !dbg !1497, !range !554
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %36 = zext i32 %35 to i64, !dbg !1493
     %37 = zext i32 %10 to i64, !dbg !1493
     %38 = zext i32 %19 to i64, !dbg !1493
     %39 = zext i32 %28 to i64, !dbg !1493
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %40 = add nsw i64 %38, -1, !dbg !1502
     %41 = add nsw i64 %39, -1, !dbg !1502
; ││└
; ││┌ @ int.jl:88 within `*`
     %42 = mul i64 %41, %36, !dbg !1507
; ││└
; ││┌ @ int.jl:87 within `+`
     %43 = add i64 %40, %42, !dbg !1508
; ││└
; ││┌ @ int.jl:88 within `*`
     %44 = mul i64 %43, %32, !dbg !1507
; ││└
; ││┌ @ int.jl:87 within `+`
     %45 = add i64 %44, %37, !dbg !1508
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.1.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !1509
; ││└└
; ││┌ @ essentials.jl:576 within `reinterpret`
     %bitcast_coercion = inttoptr i64 %state.i.fca.1.extract to i8 addrspace(1)*, !dbg !1517
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
    call fastcc void @julia_llvm_atomic_cas_2967({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %0, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %45), !dbg !1519
    %46 = addrspacecast { i64, i8 } addrspace(5)* %0 to { i64, i8 }*, !dbg !1519
    %47 = call fastcc {}* @julia_indexed_iterate_2964({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %46, i64 1), !dbg !1519
    %48 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
    store {}* %47, {}** %48, align 8
    %49 = call {}* @ijl_get_nth_field_checked({}* nonnull %47, i64 0), !dbg !1519
    %50 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
    store {}* %49, {}** %50, align 8
    %51 = call {}* @ijl_get_nth_field_checked({}* nonnull %47, i64 1), !dbg !1519
    %52 = bitcast {}* %51 to i64*, !dbg !1519
    %unbox = load i64, i64* %52, align 8, !dbg !1519, !tbaa !648, !alias.scope !506, !noalias !507
    %53 = call fastcc {}* @julia_indexed_iterate_2962({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %46, i64 2), !dbg !1519
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
    %54 = bitcast {}* %49 to i64*, !dbg !1520
    %55 = getelementptr inbounds i64, i64* %54, i64 -1, !dbg !1520
    %56 = load atomic i64, i64* %55 unordered, align 8, !dbg !1520, !tbaa !650, !range !652
    %57 = and i64 %56, -16, !dbg !1520
    %58 = inttoptr i64 %57 to {}*, !dbg !1520
    %exactly_isa.not = icmp eq {}* %58, inttoptr (i64 192 to {}*), !dbg !1520
    br i1 %exactly_isa.not, label %L105, label %L108, !dbg !1520

L105:                                             ; preds = %top
; ││┌ @ bool.jl:155 within `iszero`
; │││┌ @ bool.jl:35 within `!`
      %59 = bitcast {}* %49 to i8*, !dbg !1521
      %unbox1 = load i8, i8* %59, align 1, !dbg !1521, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; ││└└
    %extract.t = icmp ne i8 %unbox1, 1, !dbg !1520
    br label %L115, !dbg !1520

L108:                                             ; preds = %top
    %exactly_isa11.not = icmp eq {}* %58, inttoptr (i64 320 to {}*), !dbg !1520
    br i1 %exactly_isa11.not, label %L110, label %L113, !dbg !1520

L110:                                             ; preds = %L108
    %unbox12 = load i64, i64* %54, align 8, !dbg !1520, !tbaa !648, !alias.scope !506, !noalias !507
    %60 = call fastcc i8 @julia_iszero_2876({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox12), !dbg !1520
    %61 = and i8 %60, 1, !dbg !1520
    %extract.t16 = icmp ne i8 %61, 0, !dbg !1520
    br label %L115, !dbg !1520

L113:                                             ; preds = %L108
    call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1520
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %state.i.fca.0.extract.i2 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1525
; │││└└└
; │││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
      %memcpy_refined_dst.i14 = inttoptr i64 %state.i.fca.0.extract.i2 to i32*, !dbg !1531
      store i32 1, i32* %memcpy_refined_dst.i14, align 1, !dbg !1531
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
      call void @llvm.amdgcn.endpgm(), !dbg !1533
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
     unreachable, !dbg !1535

L115:                                             ; preds = %L110, %L105
     %value_phi.off0 = phi i1 [ %extract.t, %L105 ], [ %extract.t16, %L110 ]
; ││└
    br i1 %exactly_isa.not, label %L119, label %L122, !dbg !1520

L119:                                             ; preds = %L115
    %62 = bitcast {}* %49 to i8*, !dbg !1520
    %unbox4 = load i8, i8* %62, align 1, !dbg !1520, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
    %63 = call fastcc i8 @julia____2945(i64 zeroext %45, i8 zeroext %unbox4), !dbg !1520
    br label %L129, !dbg !1520

L122:                                             ; preds = %L115
    %exactly_isa7.not = icmp eq {}* %58, inttoptr (i64 320 to {}*), !dbg !1520
    br i1 %exactly_isa7.not, label %L124, label %L127, !dbg !1520

L124:                                             ; preds = %L122
; ││┌ @ promotion.jl:521 within `==`
     %unbox8 = load i64, i64* %54, align 8, !dbg !1536, !tbaa !648, !alias.scope !506, !noalias !507
     %64 = icmp eq i64 %45, %unbox8, !dbg !1536
     %65 = zext i1 %64 to i8, !dbg !1536
; ││└
    br label %L129, !dbg !1520

L127:                                             ; preds = %L122
    call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1520
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1538
; │││└└└
; │││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
      %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !1544
      store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1544
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
      call void @llvm.amdgcn.endpgm(), !dbg !1546
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
     unreachable, !dbg !1548

L129:                                             ; preds = %L124, %L119
     %value_phi5 = phi i8 [ %63, %L119 ], [ %65, %L124 ]
; │└└
   %66 = and i8 %value_phi5, 1, !dbg !1516
   %67 = icmp eq i8 %66, 0, !dbg !1516
   %not.value_phi.off0 = xor i1 %value_phi.off0, true, !dbg !1516
   %68 = select i1 %not.value_phi.off0, i1 %67, i1 false, !dbg !1516
   br i1 %68, label %L135, label %L133, !dbg !1516

L133:                                             ; preds = %L129
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__2934({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !1549
   unreachable, !dbg !1549

L135:                                             ; preds = %L129
   call void @julia.pop_gc_frame({}** nonnull %gcframe)
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:112 within `report_oom`
  ret void, !dbg !1550
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2885({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1551 {
top:
  %1 = call fastcc i64 @julia_UInt64_2888({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1552
  ret i64 %1, !dbg !1552
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_4983({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1553 {
top:
  %1 = call fastcc i64 @julia_UInt64_4986({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1554
  ret i64 %1, !dbg !1554
}

;  @ essentials.jl:517 within `oftype`
define internal fastcc i64 @julia_oftype_4980({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1555 {
top:
  %1 = call fastcc i64 @julia_convert_4983({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1556
  ret i64 %1, !dbg !1556
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `gate!`
define internal fastcc i8 @julia_gate__5035({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr !dbg !1557 {
top:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %1 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i.fca.1.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !1558
; └└
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast_coercion = inttoptr i64 %state.i.fca.1.extract to i8 addrspace(1)*, !dbg !1565
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
  call fastcc void @julia_llvm_atomic_cas_5065({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %1, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %0), !dbg !1567
  %2 = addrspacecast { i64, i8 } addrspace(5)* %1 to { i64, i8 }*, !dbg !1567
  %3 = call fastcc {}* @julia_indexed_iterate_5062({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 1), !dbg !1567
  %4 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
  store {}* %3, {}** %4, align 8
  %5 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 0), !dbg !1567
  %6 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
  store {}* %5, {}** %6, align 8
  %7 = call {}* @ijl_get_nth_field_checked({}* nonnull %3, i64 1), !dbg !1567
  %8 = bitcast {}* %7 to i64*, !dbg !1567
  %unbox = load i64, i64* %8, align 8, !dbg !1567, !tbaa !648, !alias.scope !506, !noalias !507
  %9 = call fastcc {}* @julia_indexed_iterate_5060({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %2, i64 2), !dbg !1567
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
  %10 = bitcast {}* %5 to i64*, !dbg !1568
  %11 = getelementptr inbounds i64, i64* %10, i64 -1, !dbg !1568
  %12 = load atomic i64, i64* %11 unordered, align 8, !dbg !1568, !tbaa !650, !range !652
  %13 = and i64 %12, -16, !dbg !1568
  %14 = inttoptr i64 %13 to {}*, !dbg !1568
  %exactly_isa.not = icmp eq {}* %14, inttoptr (i64 192 to {}*), !dbg !1568
  br i1 %exactly_isa.not, label %L13, label %L16, !dbg !1568

L13:                                              ; preds = %top
; ┌ @ bool.jl:155 within `iszero`
; │┌ @ bool.jl:35 within `!`
    %15 = bitcast {}* %5 to i8*, !dbg !1569
    %unbox1 = load i8, i8* %15, align 1, !dbg !1569, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; └└
  %extract.t = icmp ne i8 %unbox1, 1, !dbg !1568
  br label %L23, !dbg !1568

L16:                                              ; preds = %top
  %exactly_isa10.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !1568
  br i1 %exactly_isa10.not, label %L18, label %L21, !dbg !1568

L18:                                              ; preds = %L16
  %unbox11 = load i64, i64* %10, align 8, !dbg !1568, !tbaa !648, !alias.scope !506, !noalias !507
  %16 = call fastcc i8 @julia_iszero_4974({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox11), !dbg !1568
  %17 = and i8 %16, 1, !dbg !1568
  %extract.t29 = icmp ne i8 %17, 0, !dbg !1568
  br label %L23, !dbg !1568

L21:                                              ; preds = %L16
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1568
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i15 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1573
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i27 = inttoptr i64 %state.i.fca.0.extract.i15 to i32*, !dbg !1579
    store i32 1, i32* %memcpy_refined_dst.i27, align 1, !dbg !1579
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1581
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1583

L23:                                              ; preds = %L18, %L13
   %value_phi.off0 = phi i1 [ %extract.t, %L13 ], [ %extract.t29, %L18 ]
; └
  br i1 %exactly_isa.not, label %L27, label %L30, !dbg !1568

L27:                                              ; preds = %L23
  %18 = bitcast {}* %5 to i8*, !dbg !1568
  %unbox4 = load i8, i8* %18, align 1, !dbg !1568, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
  %19 = call fastcc i8 @julia____5043(i64 zeroext %0, i8 zeroext %unbox4), !dbg !1568
  br label %L37, !dbg !1568

L30:                                              ; preds = %L23
  %exactly_isa7.not = icmp eq {}* %14, inttoptr (i64 320 to {}*), !dbg !1568
  br i1 %exactly_isa7.not, label %L32, label %L35, !dbg !1568

L32:                                              ; preds = %L30
; ┌ @ promotion.jl:521 within `==`
   %unbox8 = load i64, i64* %10, align 8, !dbg !1584, !tbaa !648, !alias.scope !506, !noalias !507
   %20 = icmp eq i64 %unbox8, %0, !dbg !1584
   %21 = zext i1 %20 to i8, !dbg !1584
; └
  br label %L37, !dbg !1568

L35:                                              ; preds = %L30
  call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1568
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1586
; │└└└
; │┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
    %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !1592
    store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1592
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
    call void @llvm.amdgcn.endpgm(), !dbg !1594
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
   unreachable, !dbg !1596

L37:                                              ; preds = %L32, %L27
   %value_phi5 = phi i8 [ %19, %L27 ], [ %21, %L32 ]
; └
; ┌ @ essentials.jl:642 within `ifelse`
   %22 = select i1 %value_phi.off0, i8 1, i8 %value_phi5, !dbg !1597
   call void @julia.pop_gc_frame({}** nonnull %gcframe)
; └
  ret i8 %22, !dbg !1568
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 zeroext %0) unnamed_addr #11 !dbg !1599 {
top:
  %gcframe = call {}** @julia.new_gc_frame(i32 2)
  %1 = alloca { i64, i8 }, align 8, addrspace(5)
  %2 = alloca { i64, i8 }, align 8, addrspace(5)
  call void @julia.push_gc_frame({}** nonnull %gcframe, i32 2)
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:98 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %3 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1600, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %4 = add nuw nsw i32 %3, 1, !dbg !1615
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %5 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1618, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %6 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1625
        %7 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 4, !dbg !1625
        %8 = bitcast i8 addrspace(4)* %7 to i16 addrspace(4)*, !dbg !1625
        %9 = load i16, i16 addrspace(4)* %8, align 4, !dbg !1625, !range !563
        %10 = zext i16 %9 to i32, !dbg !1625
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %11 = mul i32 %5, %10, !dbg !1633
; ││└
; ││┌ @ int.jl:87 within `+`
     %12 = add i32 %4, %11, !dbg !1635
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %13 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1636, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %14 = add nuw nsw i32 %13, 1, !dbg !1643
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %15 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1645, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %16 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 6, !dbg !1651
        %17 = bitcast i8 addrspace(4)* %16 to i16 addrspace(4)*, !dbg !1651
        %18 = load i16, i16 addrspace(4)* %17, align 2, !dbg !1651, !range !563
        %19 = zext i16 %18 to i32, !dbg !1651
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %20 = mul i32 %15, %19, !dbg !1657
; ││└
; ││┌ @ int.jl:87 within `+`
     %21 = add i32 %14, %20, !dbg !1658
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %22 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1659, !range !298
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %23 = add nuw nsw i32 %22, 1, !dbg !1666
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %24 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1668, !range !554
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %25 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 8, !dbg !1674
        %26 = bitcast i8 addrspace(4)* %25 to i16 addrspace(4)*, !dbg !1674
        %27 = load i16, i16 addrspace(4)* %26, align 4, !dbg !1674, !range !563
        %28 = zext i16 %27 to i32, !dbg !1674
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %29 = mul i32 %24, %28, !dbg !1680
; ││└
; ││┌ @ int.jl:87 within `+`
     %30 = add i32 %23, %29, !dbg !1681
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %31 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 12, !dbg !1682
        %32 = bitcast i8 addrspace(4)* %31 to i32 addrspace(4)*, !dbg !1682
        %33 = load i32, i32 addrspace(4)* %32, align 4, !dbg !1682, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %34 = zext i32 %33 to i64, !dbg !1690
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %35 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 16, !dbg !1694
        %36 = bitcast i8 addrspace(4)* %35 to i32 addrspace(4)*, !dbg !1694
        %37 = load i32, i32 addrspace(4)* %36, align 4, !dbg !1694, !range !554
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %38 = zext i32 %37 to i64, !dbg !1690
      %39 = zext i32 %12 to i64, !dbg !1690
      %40 = zext i32 %21 to i64, !dbg !1690
      %41 = zext i32 %30 to i64, !dbg !1690
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││┌ @ int.jl:1068 within `-` @ int.jl:86
      %42 = add nsw i64 %40, -1, !dbg !1699
      %43 = add nsw i64 %41, -1, !dbg !1699
; │││└
; │││┌ @ int.jl:88 within `*`
      %44 = mul i64 %43, %38, !dbg !1704
; │││└
; │││┌ @ int.jl:87 within `+`
      %45 = add i64 %42, %44, !dbg !1705
; │││└
; │││┌ @ int.jl:88 within `*`
      %46 = mul i64 %45, %34, !dbg !1704
; │││└
; │││┌ @ int.jl:87 within `+`
      %47 = add i64 %46, %39, !dbg !1705
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i50.fca.1.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 1, !dbg !1706
; │││└└
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast_coercion = inttoptr i64 %state.i50.fca.1.extract to i8 addrspace(1)*, !dbg !1714
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
     call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %1, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %47), !dbg !1716
     %48 = addrspacecast { i64, i8 } addrspace(5)* %1 to { i64, i8 }*, !dbg !1716
     %49 = call fastcc {}* @julia_indexed_iterate_2625({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %48, i64 1), !dbg !1716
     %50 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
     store {}* %49, {}** %50, align 8
     %51 = call {}* @ijl_get_nth_field_checked({}* nonnull %49, i64 0), !dbg !1716
     %52 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
     store {}* %51, {}** %52, align 8
     %53 = call {}* @ijl_get_nth_field_checked({}* nonnull %49, i64 1), !dbg !1716
     %54 = bitcast {}* %53 to i64*, !dbg !1716
     %unbox = load i64, i64* %54, align 8, !dbg !1716, !tbaa !648, !alias.scope !506, !noalias !507
     %55 = call fastcc {}* @julia_indexed_iterate_2623({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %48, i64 2), !dbg !1716
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
     %56 = bitcast {}* %51 to i64*, !dbg !1717
     %57 = getelementptr inbounds i64, i64* %56, i64 -1, !dbg !1717
     %58 = load atomic i64, i64* %57 unordered, align 8, !dbg !1717, !tbaa !650, !range !652
     %59 = and i64 %58, -16, !dbg !1717
     %60 = inttoptr i64 %59 to {}*, !dbg !1717
     %exactly_isa.not = icmp eq {}* %60, inttoptr (i64 192 to {}*), !dbg !1717
     br i1 %exactly_isa.not, label %L105, label %L108, !dbg !1717

L105:                                             ; preds = %top
; │││┌ @ bool.jl:155 within `iszero`
; ││││┌ @ bool.jl:35 within `!`
       %61 = bitcast {}* %51 to i8*, !dbg !1718
       %unbox1 = load i8, i8* %61, align 1, !dbg !1718, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; │││└└
     %extract.t = icmp ne i8 %unbox1, 1, !dbg !1717
     br label %L115, !dbg !1717

L108:                                             ; preds = %top
     %exactly_isa44.not = icmp eq {}* %60, inttoptr (i64 320 to {}*), !dbg !1717
     br i1 %exactly_isa44.not, label %L110, label %L113, !dbg !1717

L110:                                             ; preds = %L108
     %unbox45 = load i64, i64* %56, align 8, !dbg !1717, !tbaa !648, !alias.scope !506, !noalias !507
     %62 = call fastcc i8 @julia_iszero_2537({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox45), !dbg !1717
     %63 = and i8 %62, 1, !dbg !1717
     %extract.t82 = icmp ne i8 %63, 0, !dbg !1717
     br label %L115, !dbg !1717

L113:                                             ; preds = %L108
     call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1717
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %state.i.fca.0.extract.i68 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1722
; ││││└└└
; ││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
       %memcpy_refined_dst.i80 = inttoptr i64 %state.i.fca.0.extract.i68 to i32*, !dbg !1728
       store i32 1, i32* %memcpy_refined_dst.i80, align 1, !dbg !1728
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !1730
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
      unreachable, !dbg !1732

L115:                                             ; preds = %L110, %L105
      %value_phi.off0 = phi i1 [ %extract.t, %L105 ], [ %extract.t82, %L110 ]
; │││└
     br i1 %exactly_isa.not, label %L119, label %L122, !dbg !1717

L119:                                             ; preds = %L115
     %64 = bitcast {}* %51 to i8*, !dbg !1717
     %unbox4 = load i8, i8* %64, align 1, !dbg !1717, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
     %65 = call fastcc i8 @julia____2606(i64 zeroext %47, i8 zeroext %unbox4), !dbg !1717
     br label %L129, !dbg !1717

L122:                                             ; preds = %L115
     %exactly_isa39.not = icmp eq {}* %60, inttoptr (i64 320 to {}*), !dbg !1717
     br i1 %exactly_isa39.not, label %L124, label %L127, !dbg !1717

L124:                                             ; preds = %L122
; │││┌ @ promotion.jl:521 within `==`
      %unbox40 = load i64, i64* %56, align 8, !dbg !1733, !tbaa !648, !alias.scope !506, !noalias !507
      %66 = icmp eq i64 %47, %unbox40, !dbg !1733
      %67 = zext i1 %66 to i8, !dbg !1733
; │││└
     br label %L129, !dbg !1717

L127:                                             ; preds = %L122
     call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1717
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %state.i.fca.0.extract.i53 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1735
; ││││└└└
; ││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
       %memcpy_refined_dst.i65 = inttoptr i64 %state.i.fca.0.extract.i53 to i32*, !dbg !1741
       store i32 1, i32* %memcpy_refined_dst.i65, align 1, !dbg !1741
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !1743
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
      unreachable, !dbg !1745

L129:                                             ; preds = %L124, %L119
      %value_phi5 = phi i8 [ %65, %L119 ], [ %67, %L124 ]
; ││└└
    %68 = and i8 %value_phi5, 1, !dbg !1713
    %69 = icmp eq i8 %68, 0, !dbg !1713
    %not.value_phi.off0 = xor i1 %value_phi.off0, true, !dbg !1713
    %70 = select i1 %not.value_phi.off0, i1 %69, i1 false, !dbg !1713
    br i1 %70, label %L151, label %L133, !dbg !1713

L133:                                             ; preds = %L129
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:340 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:26 within `err_str_buffer!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i49.fca.3.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 3, !dbg !1746
       %state.i49.fca.7.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 7, !dbg !1746
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:28 within `err_str_buffer!`
; │││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:294 within `atomic_pointermodify` @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:359
; ││││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:255 within `llvm_atomic_op`
; │││││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:255 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %71 = inttoptr i64 %state.i49.fca.3.extract to i32 addrspace(1)*, !dbg !1752
        %72 = atomicrmw add i32 addrspace(1)* %71, i32 1 acq_rel, align 4, !dbg !1752
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `err_str_buffer!`
; │││┌ @ operators.jl:378 within `>`
; ││││┌ @ int.jl:83 within `<`
       %.not = icmp slt i32 %state.i49.fca.7.extract, %72, !dbg !1761
; │││└└
     br i1 %.not, label %L151, label %L143, !dbg !1765

L143:                                             ; preds = %L133
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `err_str_buffer!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i48.fca.5.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 5, !dbg !1766
; │││└└
; │││┌ @ pointer.jl:119 within `unsafe_load`
; ││││┌ @ boot.jl:782 within `Int64`
; │││││┌ @ boot.jl:701 within `toInt64`
        %73 = sext i32 %72 to i64, !dbg !1770
; ││││└└
      %pointerref_idx = add nsw i64 %73, -1, !dbg !1774
      %74 = inttoptr i64 %state.i48.fca.5.extract to i64*, !dbg !1774
      %75 = getelementptr inbounds i64, i64* %74, i64 %pointerref_idx, !dbg !1774
      %pointerref = load i64, i64* %75, align 1, !dbg !1774, !tbaa !1209, !alias.scope !506, !noalias !507
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:34 within `err_str_buffer!`
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast_coercion37 = inttoptr i64 %pointerref to i8 addrspace(1)*, !dbg !1776
; │││└
     br label %L151, !dbg !1777

L151:                                             ; preds = %L143, %L133, %L129
     %value_phi10 = phi i8 addrspace(1)* [ null, %L129 ], [ %bitcast_coercion37, %L143 ], [ null, %L133 ]
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:99 within `err_device_string_to_host`
; │┌ @ int.jl:518 within `==` @ promotion.jl:521
    %.not83 = icmp eq i8 addrspace(1)* %value_phi10, null, !dbg !1778
; │└
   br i1 %.not83, label %L168, label %L157, !dbg !1781

L157:                                             ; preds = %L151
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:101 within `err_device_string_to_host`
; │┌ @ essentials.jl:576 within `reinterpret`
    %bitcast_coercion33 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !1782
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:102 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     br label %check.i, !dbg !1784

check.i:                                          ; preds = %check.i, %L157
     %76 = phi i64 [ 0, %L157 ], [ %77, %check.i ], !dbg !1784
     %77 = add i64 %76, 1, !dbg !1784
     %78 = getelementptr i8, i8 addrspace(1)* %bitcast_coercion33, i64 %76, !dbg !1784
     %79 = addrspacecast i8 addrspace(1)* %78 to i8*, !dbg !1784
     %80 = load i8, i8* %79, align 1, !dbg !1784
     %81 = icmp eq i8 %80, 0, !dbg !1784
     br i1 %81, label %julia_report_exception_2455u2533.exit, label %check.i, !dbg !1784

julia_report_exception_2455u2533.exit:            ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:105 within `err_device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nonnull align 1 %value_phi10, i8 addrspace(1)* align 1 %bitcast_coercion33, i64 %76, i1 false), !dbg !1791
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:106 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:114 within `+`
    %82 = getelementptr i8, i8 addrspace(1)* %value_phi10, i64 %76, !dbg !1796
; │└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      store i8 0, i8 addrspace(1)* %82, align 1, !dbg !1799, !tbaa !352
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:107 within `err_device_string_to_host`
   br label %L168, !dbg !1807

L168:                                             ; preds = %julia_report_exception_2455u2533.exit, %L151
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:117 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %83 = load i16, i16 addrspace(4)* %8, align 4, !dbg !1808, !range !563
       %84 = zext i16 %83 to i32, !dbg !1808
; │└└└└
; │┌ @ int.jl:88 within `*`
    %85 = mul i32 %5, %84, !dbg !1815
; │└
; │┌ @ int.jl:87 within `+`
    %86 = add i32 %4, %85, !dbg !1816
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %87 = load i16, i16 addrspace(4)* %17, align 2, !dbg !1817, !range !563
       %88 = zext i16 %87 to i32, !dbg !1817
; │└└└└
; │┌ @ int.jl:88 within `*`
    %89 = mul i32 %15, %88, !dbg !1823
; │└
; │┌ @ int.jl:87 within `+`
    %90 = add i32 %14, %89, !dbg !1824
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %91 = load i16, i16 addrspace(4)* %26, align 4, !dbg !1825, !range !563
       %92 = zext i16 %91 to i32, !dbg !1825
; │└└└└
; │┌ @ int.jl:88 within `*`
    %93 = mul i32 %24, %92, !dbg !1831
; │└
; │┌ @ int.jl:87 within `+`
    %94 = add i32 %23, %93, !dbg !1832
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %95 = load i32, i32 addrspace(4)* %32, align 4, !dbg !1833, !range !554
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %96 = zext i32 %95 to i64, !dbg !1839
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %97 = load i32, i32 addrspace(4)* %36, align 4, !dbg !1841, !range !554
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %98 = zext i32 %97 to i64, !dbg !1839
     %99 = zext i32 %86 to i64, !dbg !1839
     %100 = zext i32 %90 to i64, !dbg !1839
     %101 = zext i32 %94 to i64, !dbg !1839
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %102 = add nsw i64 %100, -1, !dbg !1845
     %103 = add nsw i64 %101, -1, !dbg !1845
; ││└
; ││┌ @ int.jl:88 within `*`
     %104 = mul i64 %103, %98, !dbg !1848
; ││└
; ││┌ @ int.jl:87 within `+`
     %105 = add i64 %102, %104, !dbg !1849
; ││└
; ││┌ @ int.jl:88 within `*`
     %106 = mul i64 %105, %96, !dbg !1848
; ││└
; ││┌ @ int.jl:87 within `+`
     %107 = add i64 %106, %99, !dbg !1849
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
    call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %2, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %107), !dbg !1850
    %108 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 }*, !dbg !1850
    %109 = call fastcc {}* @julia_indexed_iterate_2625({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %108, i64 1), !dbg !1850
    %110 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 0)
    store {}* %109, {}** %110, align 8
    %111 = call {}* @ijl_get_nth_field_checked({}* nonnull %109, i64 0), !dbg !1850
    %112 = call {}** @julia.get_gc_frame_slot({}** nonnull %gcframe, i32 1)
    store {}* %111, {}** %112, align 8
    %113 = call {}* @ijl_get_nth_field_checked({}* nonnull %109, i64 1), !dbg !1850
    %114 = bitcast {}* %113 to i64*, !dbg !1850
    %unbox14 = load i64, i64* %114, align 8, !dbg !1850, !tbaa !648, !alias.scope !506, !noalias !507
    %115 = call fastcc {}* @julia_indexed_iterate_2623({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { i64, i8 }* %108, i64 2), !dbg !1850
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
    %116 = bitcast {}* %111 to i64*, !dbg !1852
    %117 = getelementptr inbounds i64, i64* %116, i64 -1, !dbg !1852
    %118 = load atomic i64, i64* %117 unordered, align 8, !dbg !1852, !tbaa !650, !range !652
    %119 = and i64 %118, -16, !dbg !1852
    %120 = inttoptr i64 %119 to {}*, !dbg !1852
    %exactly_isa16.not = icmp eq {}* %120, inttoptr (i64 192 to {}*), !dbg !1852
    br i1 %exactly_isa16.not, label %L272, label %L275, !dbg !1852

L272:                                             ; preds = %L168
; ││┌ @ bool.jl:155 within `iszero`
; │││┌ @ bool.jl:35 within `!`
      %121 = bitcast {}* %111 to i8*, !dbg !1853
      %unbox17 = load i8, i8* %121, align 1, !dbg !1853, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
; ││└└
    %extract.t85 = icmp ne i8 %unbox17, 1, !dbg !1852
    br label %L282, !dbg !1852

L275:                                             ; preds = %L168
    %exactly_isa29.not = icmp eq {}* %120, inttoptr (i64 320 to {}*), !dbg !1852
    br i1 %exactly_isa29.not, label %L277, label %L280, !dbg !1852

L277:                                             ; preds = %L275
    %unbox30 = load i64, i64* %116, align 8, !dbg !1852, !tbaa !648, !alias.scope !506, !noalias !507
    %122 = call fastcc i8 @julia_iszero_2537({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %unbox30), !dbg !1852
    %123 = and i8 %122, 1, !dbg !1852
    %extract.t86 = icmp ne i8 %123, 0, !dbg !1852
    br label %L282, !dbg !1852

L280:                                             ; preds = %L275
    call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1852
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %state.i.fca.0.extract.i38 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1855
; │││└└└
; │││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
      %memcpy_refined_dst.i50 = inttoptr i64 %state.i.fca.0.extract.i38 to i32*, !dbg !1861
      store i32 1, i32* %memcpy_refined_dst.i50, align 1, !dbg !1861
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
      call void @llvm.amdgcn.endpgm(), !dbg !1863
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
     unreachable, !dbg !1865

L282:                                             ; preds = %L277, %L272
     %value_phi18.off0 = phi i1 [ %extract.t85, %L272 ], [ %extract.t86, %L277 ]
; ││└
    br i1 %exactly_isa16.not, label %L286, label %L289, !dbg !1852

L286:                                             ; preds = %L282
    %124 = bitcast {}* %111 to i8*, !dbg !1852
    %unbox21 = load i8, i8* %124, align 1, !dbg !1852, !tbaa !648, !range !659, !alias.scope !506, !noalias !507
    %125 = call fastcc i8 @julia____2606(i64 zeroext %107, i8 zeroext %unbox21), !dbg !1852
    br label %L296, !dbg !1852

L289:                                             ; preds = %L282
    %exactly_isa25.not = icmp eq {}* %120, inttoptr (i64 320 to {}*), !dbg !1852
    br i1 %exactly_isa25.not, label %L291, label %L294, !dbg !1852

L291:                                             ; preds = %L289
; ││┌ @ promotion.jl:521 within `==`
     %unbox26 = load i64, i64* %116, align 8, !dbg !1866, !tbaa !648, !alias.scope !506, !noalias !507
     %126 = icmp eq i64 %107, %unbox26, !dbg !1866
     %127 = zext i1 %126 to i8, !dbg !1866
; ││└
    br label %L296, !dbg !1852

L294:                                             ; preds = %L289
    call fastcc void @gpu_report_exception({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 ptrtoint ([10 x i8]* @exception.8 to i64)), !dbg !1852
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││┌ @ none within `kernel_state`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !1867
; │││└└└
; │││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
      %memcpy_refined_dst.i = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !1873
      store i32 1, i32* %memcpy_refined_dst.i, align 1, !dbg !1873
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
      call void @llvm.amdgcn.endpgm(), !dbg !1875
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
     unreachable, !dbg !1877

L296:                                             ; preds = %L291, %L286
     %value_phi22 = phi i8 [ %125, %L286 ], [ %127, %L291 ]
; │└└
   %128 = and i8 %value_phi22, 1, !dbg !1851
   %129 = icmp eq i8 %128, 0, !dbg !1851
   %not.value_phi18.off0 = xor i1 %value_phi18.off0, true, !dbg !1851
   %130 = select i1 %not.value_phi18.off0, i1 %129, i1 false, !dbg !1851
   br i1 %130, label %L302, label %L300, !dbg !1851

L300:                                             ; preds = %L296
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__2595({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state), !dbg !1878
   unreachable, !dbg !1878

L302:                                             ; preds = %L296
   call void @julia.pop_gc_frame({}** nonnull %gcframe)
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:121 within `report_exception`
  ret void, !dbg !1879
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2888({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 signext %0) unnamed_addr !dbg !1880 {
top:
  %1 = call fastcc i64 @julia_toUInt64_2891({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, i64 %0), !dbg !1881
  ret i64 %1, !dbg !1881
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #8

attributes #0 = { cold noreturn nounwind }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { nounwind willreturn }
attributes #4 = { convergent nounwind willreturn }
attributes #5 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { convergent nounwind readnone willreturn }
attributes #7 = { nounwind }
attributes #8 = { argmemonly nocallback nofree nounwind willreturn }
attributes #9 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #10 = { noreturn }
attributes #11 = { alwaysinline }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59, !60, !61, !62, !63, !64, !65, !66, !67, !68, !69, !70, !71, !72, !73, !74, !75, !76, !77, !78, !79, !80, !81, !82, !83, !84, !85, !86, !87, !88, !89, !90, !91, !92, !93, !94, !95, !96, !97, !98, !99, !100, !101, !102, !103, !104, !105, !106, !107, !108, !109, !110, !111, !112, !113, !114, !115, !116, !117, !118, !119, !120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130}
!opencl.ocl.version = !{!131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131, !131}
!llvm.ident = !{!132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132, !132}
!julia.kernel = !{!133}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "julia", directory: ".")
!6 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!7 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!8 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!9 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!10 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!11 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!12 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!13 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!14 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!15 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!16 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!17 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!18 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!19 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!20 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!21 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!22 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!23 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!24 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!25 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!26 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!27 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!28 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!29 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!30 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!31 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!32 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!33 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!34 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!35 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!36 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!37 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!38 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!39 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!40 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!41 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!42 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!43 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!44 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!45 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!46 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!47 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!48 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!49 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!50 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!51 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!52 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!53 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!54 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!55 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!56 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!57 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!58 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!59 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!60 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!61 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!62 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!63 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!64 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!65 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!66 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!67 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!68 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!69 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!70 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!71 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!72 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!73 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!74 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!75 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!76 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!77 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!78 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!79 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!80 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!81 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!82 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!83 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!84 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!85 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!86 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!87 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!88 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!89 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!90 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!91 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!92 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!93 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!94 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!95 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!96 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!97 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!98 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!99 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!100 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!101 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!102 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!103 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!104 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!105 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!106 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!107 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!108 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!109 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!110 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!111 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!112 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!113 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!114 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!115 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!116 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!117 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!118 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!119 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!120 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!121 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!122 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!123 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!124 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!125 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!126 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!127 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!128 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!129 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!130 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!131 = !{i32 2, i32 0}
!132 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!133 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { [1 x i64], i8 addrspace(1)*, i64 })* @_Z3ker14ROCDeviceArrayI5Int64Li1ELi1EE}
!134 = distinct !DISubprogram(name: "llvm_atomic_cas", linkageName: "julia_llvm_atomic_cas_5065", scope: null, file: !135, line: 385, type: !136, scopeLine: 385, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!135 = !DIFile(filename: "/home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl", directory: ".")
!136 = !DISubroutineType(types: !137)
!137 = !{}
!138 = !DILocation(line: 38, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!140 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl", directory: ".")
!141 = !DILocation(line: 461, scope: !142, inlinedAt: !143)
!142 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!143 = !DILocation(line: 385, scope: !134)
!144 = !DILocation(line: 463, scope: !142, inlinedAt: !143)
!145 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_5058", scope: null, file: !146, line: 764, type: !136, scopeLine: 764, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !137)
!146 = !DIFile(filename: "boot.jl", directory: ".")
!147 = !DILocation(line: 764, scope: !145)
!148 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_5055", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !137)
!149 = !DILocation(line: 787, scope: !148)
!150 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_5052", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !19, retainedNodes: !137)
!151 = !DIFile(filename: "number.jl", directory: ".")
!152 = !DILocation(line: 7, scope: !150)
!153 = distinct !DISubprogram(name: "_promote", linkageName: "julia__promote_5049", scope: null, file: !154, line: 367, type: !136, scopeLine: 367, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !137)
!154 = !DIFile(filename: "promotion.jl", directory: ".")
!155 = !DILocation(line: 370, scope: !153)
!156 = distinct !DISubprogram(name: "promote", linkageName: "julia_promote_5046", scope: null, file: !154, line: 391, type: !136, scopeLine: 391, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !21, retainedNodes: !137)
!157 = !DILocation(line: 393, scope: !156)
!158 = !DILocation(line: 92, scope: !159, inlinedAt: !161)
!159 = distinct !DISubprogram(name: "indexed_iterate;", linkageName: "indexed_iterate", scope: !160, file: !160, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !21, retainedNodes: !137)
!160 = !DIFile(filename: "tuple.jl", directory: ".")
!161 = !DILocation(line: 92, scope: !159, inlinedAt: !157)
!162 = !DILocation(line: 395, scope: !156)
!163 = !{!164, !164, i64 0}
!164 = !{!"jtbaa_stack", !165, i64 0}
!165 = !{!"jtbaa", !166, i64 0}
!166 = !{!"jtbaa"}
!167 = !{!168}
!168 = !{!"jnoalias_stack", !169}
!169 = !{!"jnoalias"}
!170 = !{!171, !172, !173, !174}
!171 = !{!"jnoalias_gcframe", !169}
!172 = !{!"jnoalias_data", !169}
!173 = !{!"jnoalias_typemd", !169}
!174 = !{!"jnoalias_const", !169}
!175 = distinct !DISubprogram(name: "==", linkageName: "julia_==_5043", scope: null, file: !154, line: 461, type: !136, scopeLine: 461, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !22, retainedNodes: !137)
!176 = !DILocation(line: 461, scope: !175)
!177 = !DILocation(line: 521, scope: !178, inlinedAt: !176)
!178 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !22, retainedNodes: !137)
!179 = !{!180, !181, i64 16}
!180 = !{!"amd_signal_s", !181, i64 0, !182, i64 8, !181, i64 16, !184, i64 24, !184, i64 28, !181, i64 32, !181, i64 40, !182, i64 48, !182, i64 56}
!181 = !{!"long", !182, i64 0}
!182 = !{!"omnipotent char", !183, i64 0}
!183 = !{!"Simple C/C++ TBAA"}
!184 = !{!"int", !182, i64 0}
!185 = !{!180, !184, i64 24}
!186 = !{!180, !181, i64 0}
!187 = !{!182, !182, i64 0}
!188 = distinct !DISubprogram(name: "llvm_atomic_cas", linkageName: "julia_llvm_atomic_cas_2628", scope: null, file: !135, line: 385, type: !136, scopeLine: 385, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!189 = !DILocation(line: 38, scope: !190, inlinedAt: !191)
!190 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!191 = !DILocation(line: 461, scope: !192, inlinedAt: !193)
!192 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!193 = !DILocation(line: 385, scope: !188)
!194 = !DILocation(line: 463, scope: !192, inlinedAt: !193)
!195 = distinct !DISubprogram(name: "==", linkageName: "julia_==_2606", scope: null, file: !154, line: 461, type: !136, scopeLine: 461, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !44, retainedNodes: !137)
!196 = !DILocation(line: 461, scope: !195)
!197 = !DILocation(line: 521, scope: !198, inlinedAt: !196)
!198 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !44, retainedNodes: !137)
!199 = distinct !DISubprogram(name: "promote", linkageName: "julia_promote_2609", scope: null, file: !154, line: 391, type: !136, scopeLine: 391, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !43, retainedNodes: !137)
!200 = !DILocation(line: 393, scope: !199)
!201 = !DILocation(line: 92, scope: !202, inlinedAt: !203)
!202 = distinct !DISubprogram(name: "indexed_iterate;", linkageName: "indexed_iterate", scope: !160, file: !160, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !43, retainedNodes: !137)
!203 = !DILocation(line: 92, scope: !202, inlinedAt: !200)
!204 = !DILocation(line: 395, scope: !199)
!205 = distinct !DISubprogram(name: "_promote", linkageName: "julia__promote_2612", scope: null, file: !154, line: 367, type: !136, scopeLine: 367, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !42, retainedNodes: !137)
!206 = !DILocation(line: 370, scope: !205)
!207 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2615", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !41, retainedNodes: !137)
!208 = !DILocation(line: 7, scope: !207)
!209 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2618", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !40, retainedNodes: !137)
!210 = !DILocation(line: 787, scope: !209)
!211 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2621", scope: null, file: !146, line: 764, type: !136, scopeLine: 764, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !137)
!212 = !DILocation(line: 764, scope: !211)
!213 = distinct !DISubprogram(name: "llvm_atomic_cas", linkageName: "julia_llvm_atomic_cas_2967", scope: null, file: !135, line: 385, type: !136, scopeLine: 385, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !78, retainedNodes: !137)
!214 = !DILocation(line: 38, scope: !215, inlinedAt: !216)
!215 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !78, retainedNodes: !137)
!216 = !DILocation(line: 461, scope: !217, inlinedAt: !218)
!217 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !78, retainedNodes: !137)
!218 = !DILocation(line: 385, scope: !213)
!219 = !DILocation(line: 463, scope: !217, inlinedAt: !218)
!220 = distinct !DISubprogram(name: "==", linkageName: "julia_==_2945", scope: null, file: !154, line: 461, type: !136, scopeLine: 461, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !88, retainedNodes: !137)
!221 = !DILocation(line: 461, scope: !220)
!222 = !DILocation(line: 521, scope: !223, inlinedAt: !221)
!223 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !88, retainedNodes: !137)
!224 = distinct !DISubprogram(name: "promote", linkageName: "julia_promote_2948", scope: null, file: !154, line: 391, type: !136, scopeLine: 391, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !87, retainedNodes: !137)
!225 = !DILocation(line: 393, scope: !224)
!226 = !DILocation(line: 92, scope: !227, inlinedAt: !228)
!227 = distinct !DISubprogram(name: "indexed_iterate;", linkageName: "indexed_iterate", scope: !160, file: !160, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !87, retainedNodes: !137)
!228 = !DILocation(line: 92, scope: !227, inlinedAt: !225)
!229 = !DILocation(line: 395, scope: !224)
!230 = distinct !DISubprogram(name: "_promote", linkageName: "julia__promote_2951", scope: null, file: !154, line: 367, type: !136, scopeLine: 367, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !86, retainedNodes: !137)
!231 = !DILocation(line: 370, scope: !230)
!232 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2954", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !85, retainedNodes: !137)
!233 = !DILocation(line: 7, scope: !232)
!234 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2957", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !84, retainedNodes: !137)
!235 = !DILocation(line: 787, scope: !234)
!236 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2960", scope: null, file: !146, line: 764, type: !136, scopeLine: 764, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !83, retainedNodes: !137)
!237 = !DILocation(line: 764, scope: !236)
!238 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2891", scope: null, file: !146, line: 757, type: !136, scopeLine: 757, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !75, retainedNodes: !137)
!239 = !DILocation(line: 757, scope: !238)
!240 = distinct !DISubprogram(name: "gc_pool_alloc", linkageName: "julia_gc_pool_alloc_2998", scope: null, file: !241, line: 118, type: !136, scopeLine: 118, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!241 = !DIFile(filename: "/home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl", directory: ".")
!242 = !DILocation(line: 38, scope: !243, inlinedAt: !244)
!243 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!244 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !247)
!245 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!246 = !DIFile(filename: "none", directory: ".")
!247 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !249)
!248 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!249 = distinct !DILocation(line: 66, scope: !250, inlinedAt: !252)
!250 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!251 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!252 = distinct !DILocation(line: 12, scope: !253, inlinedAt: !255)
!253 = distinct !DISubprogram(name: "malloc", linkageName: "julia_malloc_3127", scope: null, file: !254, line: 11, type: !136, scopeLine: 11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!254 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!255 = distinct !DILocation(line: 88, scope: !256, inlinedAt: !257)
!256 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !241, file: !241, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!257 = !DILocation(line: 119, scope: !240)
!258 = !DILocation(line: 38, scope: !243, inlinedAt: !259)
!259 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !260)
!260 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !262)
!261 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!262 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !265)
!263 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !264, file: !264, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!264 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl", directory: ".")
!265 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !266)
!266 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !267)
!267 = distinct !DILocation(line: 75, scope: !250, inlinedAt: !252)
!268 = !{!269, !269, i64 0, i64 0}
!269 = !{!"custom_tbaa_addrspace(3)", !270, i64 0}
!270 = !{!"custom_tbaa"}
!271 = !DILocation(line: 119, scope: !272, inlinedAt: !274)
!272 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!273 = !DIFile(filename: "pointer.jl", directory: ".")
!274 = distinct !DILocation(line: 119, scope: !272, inlinedAt: !252)
!275 = !{!165, !165, i64 0}
!276 = !{!172, !168}
!277 = !{!171, !173, !174}
!278 = !DILocation(line: 38, scope: !243, inlinedAt: !279)
!279 = distinct !DILocation(line: 3, scope: !280, inlinedAt: !282)
!280 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!281 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!282 = distinct !DILocation(line: 3, scope: !283, inlinedAt: !284)
!283 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!284 = distinct !DILocation(line: 87, scope: !285, inlinedAt: !286)
!285 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!286 = distinct !DILocation(line: 122, scope: !287, inlinedAt: !288)
!287 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!288 = distinct !DILocation(line: 30, scope: !289, inlinedAt: !291)
!289 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !290, file: !290, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!290 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!291 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !292)
!292 = distinct !DILocation(line: 0, scope: !293, inlinedAt: !294)
!293 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!294 = distinct !DILocation(line: 9, scope: !295, inlinedAt: !296)
!295 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !290, file: !290, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!296 = distinct !DILocation(line: 3, scope: !295, inlinedAt: !297)
!297 = distinct !DILocation(line: 13, scope: !253, inlinedAt: !255)
!298 = !{i32 0, i32 1023}
!299 = !DILocation(line: 521, scope: !300, inlinedAt: !301)
!300 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!301 = distinct !DILocation(line: 461, scope: !300, inlinedAt: !302)
!302 = distinct !DILocation(line: 518, scope: !303, inlinedAt: !305)
!303 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!304 = !DIFile(filename: "int.jl", directory: ".")
!305 = distinct !DILocation(line: 276, scope: !306, inlinedAt: !288)
!306 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !307, file: !307, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!307 = !DIFile(filename: "operators.jl", directory: ".")
!308 = !DILocation(line: 30, scope: !289, inlinedAt: !291)
!309 = !DILocation(line: 27, scope: !310, inlinedAt: !312)
!310 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!311 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!312 = distinct !DILocation(line: 37, scope: !313, inlinedAt: !314)
!313 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!314 = distinct !DILocation(line: 36, scope: !313, inlinedAt: !315)
!315 = distinct !DILocation(line: 62, scope: !289, inlinedAt: !291)
!316 = !DILocation(line: 38, scope: !313, inlinedAt: !314)
!317 = !DILocation(line: 38, scope: !243, inlinedAt: !318)
!318 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !319)
!319 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !320)
!320 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !322)
!321 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!322 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !324)
!323 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!324 = distinct !DILocation(line: 41, scope: !313, inlinedAt: !314)
!325 = !DILocation(line: 146, scope: !326, inlinedAt: !327)
!326 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!327 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !322)
!328 = !DILocation(line: 52, scope: !329, inlinedAt: !331)
!329 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !330, file: !330, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!330 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!331 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !324)
!332 = !DILocation(line: 108, scope: !333, inlinedAt: !334)
!333 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!334 = distinct !DILocation(line: 46, scope: !313, inlinedAt: !314)
!335 = !DILocation(line: 47, scope: !313, inlinedAt: !314)
!336 = !DILocation(line: 6, scope: !337, inlinedAt: !339)
!337 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !338, file: !338, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!338 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!339 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !291)
!340 = !DILocation(line: 30, scope: !289, inlinedAt: !341)
!341 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !342)
!342 = distinct !DILocation(line: 0, scope: !343, inlinedAt: !344)
!343 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!344 = distinct !DILocation(line: 10, scope: !295, inlinedAt: !296)
!345 = !DILocation(line: 38, scope: !243, inlinedAt: !346)
!346 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !347)
!347 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !348)
!348 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !349)
!349 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !350)
!350 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !351)
!351 = distinct !DILocation(line: 91, scope: !289, inlinedAt: !341)
!352 = !{!353, !353, i64 0, i64 0}
!353 = !{!"custom_tbaa_addrspace(1)", !270, i64 0}
!354 = !DILocation(line: 6, scope: !337, inlinedAt: !355)
!355 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !341)
!356 = !DILocation(line: 30, scope: !289, inlinedAt: !357)
!357 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !358)
!358 = distinct !DILocation(line: 0, scope: !359, inlinedAt: !360)
!359 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!360 = distinct !DILocation(line: 11, scope: !295, inlinedAt: !296)
!361 = !DILocation(line: 27, scope: !310, inlinedAt: !362)
!362 = distinct !DILocation(line: 37, scope: !313, inlinedAt: !363)
!363 = distinct !DILocation(line: 36, scope: !313, inlinedAt: !364)
!364 = distinct !DILocation(line: 113, scope: !289, inlinedAt: !357)
!365 = !DILocation(line: 38, scope: !313, inlinedAt: !363)
!366 = !DILocation(line: 38, scope: !243, inlinedAt: !367)
!367 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !368)
!368 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !369)
!369 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !370)
!370 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !371)
!371 = distinct !DILocation(line: 41, scope: !313, inlinedAt: !363)
!372 = !DILocation(line: 146, scope: !326, inlinedAt: !373)
!373 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !370)
!374 = !DILocation(line: 52, scope: !329, inlinedAt: !375)
!375 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !371)
!376 = !DILocation(line: 108, scope: !333, inlinedAt: !377)
!377 = distinct !DILocation(line: 46, scope: !313, inlinedAt: !363)
!378 = !DILocation(line: 47, scope: !313, inlinedAt: !363)
!379 = !DILocation(line: 12, scope: !380, inlinedAt: !381)
!380 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!381 = distinct !DILocation(line: 61, scope: !382, inlinedAt: !383)
!382 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!383 = distinct !DILocation(line: 60, scope: !382, inlinedAt: !384)
!384 = distinct !DILocation(line: 116, scope: !289, inlinedAt: !357)
!385 = !DILocation(line: 521, scope: !300, inlinedAt: !386)
!386 = distinct !DILocation(line: 62, scope: !382, inlinedAt: !383)
!387 = !DILocation(line: 62, scope: !382, inlinedAt: !383)
!388 = !DILocation(line: 64, scope: !382, inlinedAt: !383)
!389 = !DILocation(line: 38, scope: !243, inlinedAt: !390)
!390 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !391)
!391 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !392)
!392 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !393)
!393 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !394)
!394 = distinct !DILocation(line: 65, scope: !382, inlinedAt: !383)
!395 = !DILocation(line: 146, scope: !326, inlinedAt: !396)
!396 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !393)
!397 = !DILocation(line: 52, scope: !329, inlinedAt: !398)
!398 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !394)
!399 = !DILocation(line: 108, scope: !333, inlinedAt: !400)
!400 = distinct !DILocation(line: 70, scope: !382, inlinedAt: !383)
!401 = !DILocation(line: 38, scope: !243, inlinedAt: !402)
!402 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !403)
!403 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !405)
!404 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!405 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !407)
!406 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !264, file: !264, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!407 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !408)
!408 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !409)
!409 = distinct !DILocation(line: 120, scope: !289, inlinedAt: !357)
!410 = !DILocation(line: 521, scope: !300, inlinedAt: !411)
!411 = distinct !DILocation(line: 518, scope: !303, inlinedAt: !412)
!412 = distinct !DILocation(line: 121, scope: !289, inlinedAt: !357)
!413 = !DILocation(line: 121, scope: !289, inlinedAt: !357)
!414 = !DILocation(line: 19, scope: !415, inlinedAt: !416)
!415 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !311, file: !311, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!416 = distinct !DILocation(line: 19, scope: !415, inlinedAt: !417)
!417 = distinct !DILocation(line: 122, scope: !289, inlinedAt: !357)
!418 = !DILocation(line: 38, scope: !243, inlinedAt: !419)
!419 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !420)
!420 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !421)
!421 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !422)
!422 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !423)
!423 = distinct !DILocation(line: 123, scope: !289, inlinedAt: !357)
!424 = !DILocation(line: 146, scope: !326, inlinedAt: !425)
!425 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !422)
!426 = !DILocation(line: 52, scope: !329, inlinedAt: !427)
!427 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !423)
!428 = !DILocation(line: 1, scope: !429, inlinedAt: !430)
!429 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !330, file: !330, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!430 = distinct !DILocation(line: 124, scope: !289, inlinedAt: !357)
!431 = !DILocation(line: 38, scope: !243, inlinedAt: !432)
!432 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !433)
!433 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !434)
!434 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !435)
!435 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !436)
!436 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !437)
!437 = distinct !DILocation(line: 126, scope: !289, inlinedAt: !357)
!438 = !DILocation(line: 38, scope: !243, inlinedAt: !439)
!439 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !440)
!440 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !441)
!441 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !442)
!442 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !443)
!443 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !437)
!444 = !DILocation(line: 19, scope: !415, inlinedAt: !445)
!445 = distinct !DILocation(line: 19, scope: !415, inlinedAt: !446)
!446 = distinct !DILocation(line: 128, scope: !289, inlinedAt: !357)
!447 = !DILocation(line: 6, scope: !337, inlinedAt: !448)
!448 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !357)
!449 = !DILocation(line: 38, scope: !243, inlinedAt: !450)
!450 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !451)
!451 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !452)
!452 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !453)
!453 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !454)
!454 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !455)
!455 = distinct !DILocation(line: 131, scope: !289, inlinedAt: !357)
!456 = !DILocation(line: 521, scope: !457, inlinedAt: !458)
!457 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!458 = !DILocation(line: 278, scope: !459, inlinedAt: !460)
!459 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!460 = !DILocation(line: 120, scope: !240)
!461 = !DILocation(line: 88, scope: !462, inlinedAt: !463)
!462 = distinct !DISubprogram(name: "report_oom;", linkageName: "report_oom", scope: !241, file: !241, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!463 = !DILocation(line: 121, scope: !240)
!464 = !DILocation(line: 122, scope: !240)
!465 = !DILocation(line: 38, scope: !466, inlinedAt: !467)
!466 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!467 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !469)
!468 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!469 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !471)
!470 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!471 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !473)
!472 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!473 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !475)
!474 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2976", scope: null, file: !251, line: 89, type: !136, scopeLine: 89, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!475 = distinct !DILocation(line: 122, scope: !240)
!476 = !DILocation(line: 146, scope: !477, inlinedAt: !478)
!477 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!478 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !473)
!479 = !DILocation(line: 52, scope: !480, inlinedAt: !481)
!480 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !330, file: !330, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!481 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !475)
!482 = !DILocation(line: 93, scope: !474, inlinedAt: !475)
!483 = !DILocation(line: 253, scope: !484, inlinedAt: !485)
!484 = distinct !DISubprogram(name: "unsafe_pointer_to_objref;", linkageName: "unsafe_pointer_to_objref", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !98, retainedNodes: !137)
!485 = !DILocation(line: 124, scope: !240)
!486 = distinct !DISubprogram(name: "oftype", linkageName: "julia_oftype_2882", scope: null, file: !487, line: 517, type: !488, scopeLine: 517, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !80, retainedNodes: !137)
!487 = !DIFile(filename: "essentials.jl", directory: ".")
!488 = !DISubroutineType(cc: DW_CC_nocall, types: !137)
!489 = !DILocation(line: 517, scope: !486)
!490 = distinct !DISubprogram(name: "err_buffer!", linkageName: "julia_err_buffer!_5032", scope: null, file: !251, line: 13, type: !136, scopeLine: 13, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!491 = !DILocation(line: 38, scope: !492, inlinedAt: !493)
!492 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!493 = !DILocation(line: 0, scope: !494, inlinedAt: !495)
!494 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!495 = !DILocation(line: 0, scope: !496, inlinedAt: !497)
!496 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!497 = !DILocation(line: 14, scope: !490)
!498 = !DILocation(line: 576, scope: !499, inlinedAt: !500)
!499 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!500 = !DILocation(line: 15, scope: !490)
!501 = !DILocation(line: 16, scope: !490)
!502 = !{!503, !503, i64 0}
!503 = !{!"jtbaa_immut", !504, i64 0}
!504 = !{!"jtbaa_value", !505, i64 0}
!505 = !{!"jtbaa_data", !165, i64 0}
!506 = !{!172}
!507 = !{!171, !168, !173, !174}
!508 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2549", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !137)
!509 = !DILocation(line: 787, scope: !508)
!510 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2623", scope: null, file: !511, line: 175, type: !488, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !46, retainedNodes: !137)
!511 = !DIFile(filename: "namedtuple.jl", directory: ".")
!512 = !DILocation(line: 175, scope: !510)
!513 = !{!174, !172}
!514 = !{!171, !168, !173}
!515 = !DILocation(line: 87, scope: !516, inlinedAt: !512)
!516 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !46, retainedNodes: !137)
!517 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_4986", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !137)
!518 = !DILocation(line: 787, scope: !517)
!519 = distinct !DISubprogram(name: "ker", linkageName: "julia_ker_4928", scope: null, file: !520, line: 1, type: !136, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!520 = !DIFile(filename: "REPL[2]", directory: ".")
!521 = !DILocation(line: 38, scope: !522, inlinedAt: !523)
!522 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!523 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !525)
!524 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!525 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !527)
!526 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!527 = distinct !DILocation(line: 87, scope: !528, inlinedAt: !529)
!528 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!529 = distinct !DILocation(line: 122, scope: !530, inlinedAt: !531)
!530 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!531 = distinct !DILocation(line: 333, scope: !532, inlinedAt: !534)
!532 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!533 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!534 = distinct !DILocation(line: 7, scope: !535, inlinedAt: !537)
!535 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_4932", scope: null, file: !536, line: 44, type: !136, scopeLine: 44, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!536 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!537 = distinct !DILocation(line: 699, scope: !538, inlinedAt: !540)
!538 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !539, file: !539, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!539 = !DIFile(filename: "abstractarray.jl", directory: ".")
!540 = !DILocation(line: 88, scope: !541, inlinedAt: !543)
!541 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !542, file: !542, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!542 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!543 = !DILocation(line: 2, scope: !519)
!544 = !DILocation(line: 87, scope: !545, inlinedAt: !546)
!545 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!546 = distinct !DILocation(line: 1068, scope: !545, inlinedAt: !527)
!547 = !DILocation(line: 38, scope: !522, inlinedAt: !548)
!548 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !549)
!549 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !550)
!550 = distinct !DILocation(line: 93, scope: !551, inlinedAt: !552)
!551 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!552 = distinct !DILocation(line: 130, scope: !553, inlinedAt: !531)
!553 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!554 = !{i32 0, i32 -2}
!555 = !DILocation(line: 38, scope: !522, inlinedAt: !556)
!556 = distinct !DILocation(line: 32, scope: !524, inlinedAt: !557)
!557 = distinct !DILocation(line: 32, scope: !558, inlinedAt: !559)
!558 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!559 = distinct !DILocation(line: 101, scope: !560, inlinedAt: !561)
!560 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!561 = distinct !DILocation(line: 138, scope: !562, inlinedAt: !531)
!562 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!563 = !{i16 0, i16 1023}
!564 = !DILocation(line: 88, scope: !565, inlinedAt: !531)
!565 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!566 = !DILocation(line: 87, scope: !545, inlinedAt: !531)
!567 = !DILocation(line: 38, scope: !522, inlinedAt: !568)
!568 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !569)
!569 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !570)
!570 = distinct !DILocation(line: 87, scope: !571, inlinedAt: !572)
!571 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!572 = distinct !DILocation(line: 122, scope: !530, inlinedAt: !573)
!573 = distinct !DILocation(line: 334, scope: !532, inlinedAt: !534)
!574 = !DILocation(line: 87, scope: !545, inlinedAt: !575)
!575 = distinct !DILocation(line: 1068, scope: !545, inlinedAt: !570)
!576 = !DILocation(line: 38, scope: !522, inlinedAt: !577)
!577 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !578)
!578 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !579)
!579 = distinct !DILocation(line: 93, scope: !580, inlinedAt: !581)
!580 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!581 = distinct !DILocation(line: 130, scope: !553, inlinedAt: !573)
!582 = !DILocation(line: 38, scope: !522, inlinedAt: !583)
!583 = distinct !DILocation(line: 32, scope: !524, inlinedAt: !584)
!584 = distinct !DILocation(line: 32, scope: !558, inlinedAt: !585)
!585 = distinct !DILocation(line: 101, scope: !586, inlinedAt: !587)
!586 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!587 = distinct !DILocation(line: 138, scope: !562, inlinedAt: !573)
!588 = !DILocation(line: 88, scope: !565, inlinedAt: !573)
!589 = !DILocation(line: 87, scope: !545, inlinedAt: !573)
!590 = !DILocation(line: 38, scope: !522, inlinedAt: !591)
!591 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !592)
!592 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !593)
!593 = distinct !DILocation(line: 87, scope: !594, inlinedAt: !595)
!594 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!595 = distinct !DILocation(line: 122, scope: !530, inlinedAt: !596)
!596 = distinct !DILocation(line: 335, scope: !532, inlinedAt: !534)
!597 = !DILocation(line: 87, scope: !545, inlinedAt: !598)
!598 = distinct !DILocation(line: 1068, scope: !545, inlinedAt: !593)
!599 = !DILocation(line: 38, scope: !522, inlinedAt: !600)
!600 = distinct !DILocation(line: 3, scope: !524, inlinedAt: !601)
!601 = distinct !DILocation(line: 3, scope: !526, inlinedAt: !602)
!602 = distinct !DILocation(line: 93, scope: !603, inlinedAt: !604)
!603 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!604 = distinct !DILocation(line: 130, scope: !553, inlinedAt: !596)
!605 = !DILocation(line: 38, scope: !522, inlinedAt: !606)
!606 = distinct !DILocation(line: 32, scope: !524, inlinedAt: !607)
!607 = distinct !DILocation(line: 32, scope: !558, inlinedAt: !608)
!608 = distinct !DILocation(line: 101, scope: !609, inlinedAt: !610)
!609 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!610 = distinct !DILocation(line: 138, scope: !562, inlinedAt: !596)
!611 = !DILocation(line: 88, scope: !565, inlinedAt: !596)
!612 = !DILocation(line: 87, scope: !545, inlinedAt: !596)
!613 = !DILocation(line: 38, scope: !522, inlinedAt: !614)
!614 = distinct !DILocation(line: 32, scope: !524, inlinedAt: !615)
!615 = distinct !DILocation(line: 32, scope: !558, inlinedAt: !616)
!616 = distinct !DILocation(line: 108, scope: !617, inlinedAt: !618)
!617 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!618 = distinct !DILocation(line: 146, scope: !619, inlinedAt: !620)
!619 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!620 = distinct !DILocation(line: 336, scope: !532, inlinedAt: !534)
!621 = !DILocation(line: 761, scope: !622, inlinedAt: !623)
!622 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!623 = distinct !DILocation(line: 787, scope: !624, inlinedAt: !620)
!624 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!625 = !DILocation(line: 38, scope: !522, inlinedAt: !626)
!626 = distinct !DILocation(line: 32, scope: !524, inlinedAt: !627)
!627 = distinct !DILocation(line: 32, scope: !558, inlinedAt: !628)
!628 = distinct !DILocation(line: 108, scope: !629, inlinedAt: !618)
!629 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!630 = !DILocation(line: 86, scope: !631, inlinedAt: !632)
!631 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!632 = distinct !DILocation(line: 1068, scope: !631, inlinedAt: !633)
!633 = distinct !DILocation(line: 327, scope: !634, inlinedAt: !620)
!634 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!635 = !DILocation(line: 88, scope: !565, inlinedAt: !633)
!636 = !DILocation(line: 87, scope: !545, inlinedAt: !633)
!637 = !DILocation(line: 38, scope: !522, inlinedAt: !638)
!638 = distinct !DILocation(line: 0, scope: !639, inlinedAt: !640)
!639 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!640 = distinct !DILocation(line: 0, scope: !641, inlinedAt: !642)
!641 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!642 = distinct !DILocation(line: 38, scope: !643, inlinedAt: !644)
!643 = distinct !DISubprogram(name: "gate!;", linkageName: "gate!", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!644 = distinct !DILocation(line: 339, scope: !532, inlinedAt: !534)
!645 = !DILocation(line: 576, scope: !646, inlinedAt: !642)
!646 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!647 = !DILocation(line: 39, scope: !643, inlinedAt: !644)
!648 = !{!504, !504, i64 0}
!649 = !DILocation(line: 44, scope: !643, inlinedAt: !644)
!650 = !{!651, !651, i64 0}
!651 = !{!"jtbaa_tag", !505, i64 0}
!652 = !{i64 16, i64 0}
!653 = !DILocation(line: 35, scope: !654, inlinedAt: !656)
!654 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!655 = !DIFile(filename: "bool.jl", directory: ".")
!656 = distinct !DILocation(line: 155, scope: !657, inlinedAt: !658)
!657 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!658 = distinct !DILocation(line: 44, scope: !643, inlinedAt: !644)
!659 = !{i8 0, i8 2}
!660 = !DILocation(line: 38, scope: !466, inlinedAt: !661)
!661 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !662)
!662 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !663)
!663 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !664)
!664 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !665)
!665 = distinct !DILocation(line: 44, scope: !643, inlinedAt: !644)
!666 = !DILocation(line: 146, scope: !477, inlinedAt: !667)
!667 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !664)
!668 = !DILocation(line: 52, scope: !480, inlinedAt: !669)
!669 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !665)
!670 = !DILocation(line: 93, scope: !474, inlinedAt: !665)
!671 = !DILocation(line: 521, scope: !672, inlinedAt: !658)
!672 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!673 = !DILocation(line: 38, scope: !466, inlinedAt: !674)
!674 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !675)
!675 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !676)
!676 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !677)
!677 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !678)
!678 = distinct !DILocation(line: 44, scope: !643, inlinedAt: !644)
!679 = !DILocation(line: 146, scope: !477, inlinedAt: !680)
!680 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !677)
!681 = !DILocation(line: 52, scope: !480, inlinedAt: !682)
!682 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !678)
!683 = !DILocation(line: 93, scope: !474, inlinedAt: !678)
!684 = !DILocation(line: 339, scope: !532, inlinedAt: !534)
!685 = !DILocation(line: 351, scope: !532, inlinedAt: !534)
!686 = !DILocation(line: 8, scope: !535, inlinedAt: !537)
!687 = !DILocation(line: 38, scope: !466, inlinedAt: !688)
!688 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !689)
!689 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !690)
!690 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !691)
!691 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !692)
!692 = distinct !DILocation(line: 8, scope: !535, inlinedAt: !537)
!693 = !DILocation(line: 146, scope: !477, inlinedAt: !694)
!694 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !691)
!695 = !DILocation(line: 52, scope: !480, inlinedAt: !696)
!696 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !692)
!697 = !DILocation(line: 93, scope: !474, inlinedAt: !692)
!698 = distinct !DISubprogram(name: "iszero", linkageName: "julia_iszero_2876", scope: null, file: !151, line: 42, type: !136, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !82, retainedNodes: !137)
!699 = !DILocation(line: 42, scope: !698)
!700 = !DILocation(line: 521, scope: !701, inlinedAt: !699)
!701 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !82, retainedNodes: !137)
!702 = distinct !DISubprogram(name: "iszero", linkageName: "julia_iszero_4974", scope: null, file: !151, line: 42, type: !136, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !137)
!703 = !DILocation(line: 42, scope: !702)
!704 = !DILocation(line: 521, scope: !705, inlinedAt: !703)
!705 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !137)
!706 = distinct !DISubprogram(name: "err_buffer!", linkageName: "julia_err_buffer!_2595", scope: null, file: !251, line: 13, type: !136, scopeLine: 13, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!707 = !DILocation(line: 38, scope: !708, inlinedAt: !709)
!708 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!709 = !DILocation(line: 0, scope: !710, inlinedAt: !711)
!710 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!711 = !DILocation(line: 0, scope: !712, inlinedAt: !713)
!712 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!713 = !DILocation(line: 14, scope: !706)
!714 = !DILocation(line: 576, scope: !715, inlinedAt: !716)
!715 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!716 = !DILocation(line: 15, scope: !706)
!717 = !DILocation(line: 16, scope: !706)
!718 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2552", scope: null, file: !146, line: 757, type: !136, scopeLine: 757, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !137)
!719 = !DILocation(line: 757, scope: !718)
!720 = distinct !DISubprogram(name: "err_buffer!", linkageName: "julia_err_buffer!_2934", scope: null, file: !251, line: 13, type: !136, scopeLine: 13, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !89, retainedNodes: !137)
!721 = !DILocation(line: 38, scope: !722, inlinedAt: !723)
!722 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !89, retainedNodes: !137)
!723 = !DILocation(line: 0, scope: !724, inlinedAt: !725)
!724 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !89, retainedNodes: !137)
!725 = !DILocation(line: 0, scope: !726, inlinedAt: !727)
!726 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !89, retainedNodes: !137)
!727 = !DILocation(line: 14, scope: !720)
!728 = !DILocation(line: 576, scope: !729, inlinedAt: !730)
!729 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !89, retainedNodes: !137)
!730 = !DILocation(line: 15, scope: !720)
!731 = !DILocation(line: 16, scope: !720)
!732 = distinct !DISubprogram(name: "check_top_bit", linkageName: "julia_check_top_bit_4992", scope: null, file: !146, line: 644, type: !136, scopeLine: 644, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !137)
!733 = !DILocation(line: 636, scope: !734, inlinedAt: !735)
!734 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !137)
!735 = !DILocation(line: 646, scope: !732)
!736 = !DILocation(line: 38, scope: !737, inlinedAt: !738)
!737 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!738 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !740)
!739 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!740 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !742)
!741 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!742 = distinct !DILocation(line: 87, scope: !743, inlinedAt: !744)
!743 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!744 = distinct !DILocation(line: 122, scope: !745, inlinedAt: !746)
!745 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!746 = distinct !DILocation(line: 333, scope: !747, inlinedAt: !748)
!747 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!748 = distinct !DILocation(line: 7, scope: !749, inlinedAt: !750)
!749 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_4995", scope: null, file: !536, line: 40, type: !136, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!750 = distinct !DILocation(line: 646, scope: !732)
!751 = !DILocation(line: 87, scope: !752, inlinedAt: !753)
!752 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!753 = distinct !DILocation(line: 1068, scope: !752, inlinedAt: !742)
!754 = !DILocation(line: 38, scope: !737, inlinedAt: !755)
!755 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !756)
!756 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !757)
!757 = distinct !DILocation(line: 93, scope: !758, inlinedAt: !759)
!758 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!759 = distinct !DILocation(line: 130, scope: !760, inlinedAt: !746)
!760 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!761 = !DILocation(line: 38, scope: !737, inlinedAt: !762)
!762 = distinct !DILocation(line: 32, scope: !739, inlinedAt: !763)
!763 = distinct !DILocation(line: 32, scope: !764, inlinedAt: !765)
!764 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!765 = distinct !DILocation(line: 101, scope: !766, inlinedAt: !767)
!766 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!767 = distinct !DILocation(line: 138, scope: !768, inlinedAt: !746)
!768 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!769 = !DILocation(line: 88, scope: !770, inlinedAt: !746)
!770 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!771 = !DILocation(line: 87, scope: !752, inlinedAt: !746)
!772 = !DILocation(line: 38, scope: !737, inlinedAt: !773)
!773 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !774)
!774 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !775)
!775 = distinct !DILocation(line: 87, scope: !776, inlinedAt: !777)
!776 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!777 = distinct !DILocation(line: 122, scope: !745, inlinedAt: !778)
!778 = distinct !DILocation(line: 334, scope: !747, inlinedAt: !748)
!779 = !DILocation(line: 87, scope: !752, inlinedAt: !780)
!780 = distinct !DILocation(line: 1068, scope: !752, inlinedAt: !775)
!781 = !DILocation(line: 38, scope: !737, inlinedAt: !782)
!782 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !783)
!783 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !784)
!784 = distinct !DILocation(line: 93, scope: !785, inlinedAt: !786)
!785 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!786 = distinct !DILocation(line: 130, scope: !760, inlinedAt: !778)
!787 = !DILocation(line: 38, scope: !737, inlinedAt: !788)
!788 = distinct !DILocation(line: 32, scope: !739, inlinedAt: !789)
!789 = distinct !DILocation(line: 32, scope: !764, inlinedAt: !790)
!790 = distinct !DILocation(line: 101, scope: !791, inlinedAt: !792)
!791 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!792 = distinct !DILocation(line: 138, scope: !768, inlinedAt: !778)
!793 = !DILocation(line: 88, scope: !770, inlinedAt: !778)
!794 = !DILocation(line: 87, scope: !752, inlinedAt: !778)
!795 = !DILocation(line: 38, scope: !737, inlinedAt: !796)
!796 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !797)
!797 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !798)
!798 = distinct !DILocation(line: 87, scope: !799, inlinedAt: !800)
!799 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!800 = distinct !DILocation(line: 122, scope: !745, inlinedAt: !801)
!801 = distinct !DILocation(line: 335, scope: !747, inlinedAt: !748)
!802 = !DILocation(line: 87, scope: !752, inlinedAt: !803)
!803 = distinct !DILocation(line: 1068, scope: !752, inlinedAt: !798)
!804 = !DILocation(line: 38, scope: !737, inlinedAt: !805)
!805 = distinct !DILocation(line: 3, scope: !739, inlinedAt: !806)
!806 = distinct !DILocation(line: 3, scope: !741, inlinedAt: !807)
!807 = distinct !DILocation(line: 93, scope: !808, inlinedAt: !809)
!808 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!809 = distinct !DILocation(line: 130, scope: !760, inlinedAt: !801)
!810 = !DILocation(line: 38, scope: !737, inlinedAt: !811)
!811 = distinct !DILocation(line: 32, scope: !739, inlinedAt: !812)
!812 = distinct !DILocation(line: 32, scope: !764, inlinedAt: !813)
!813 = distinct !DILocation(line: 101, scope: !814, inlinedAt: !815)
!814 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!815 = distinct !DILocation(line: 138, scope: !768, inlinedAt: !801)
!816 = !DILocation(line: 88, scope: !770, inlinedAt: !801)
!817 = !DILocation(line: 87, scope: !752, inlinedAt: !801)
!818 = !DILocation(line: 38, scope: !737, inlinedAt: !819)
!819 = distinct !DILocation(line: 32, scope: !739, inlinedAt: !820)
!820 = distinct !DILocation(line: 32, scope: !764, inlinedAt: !821)
!821 = distinct !DILocation(line: 108, scope: !822, inlinedAt: !823)
!822 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!823 = distinct !DILocation(line: 146, scope: !824, inlinedAt: !825)
!824 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!825 = distinct !DILocation(line: 336, scope: !747, inlinedAt: !748)
!826 = !DILocation(line: 761, scope: !827, inlinedAt: !828)
!827 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!828 = distinct !DILocation(line: 787, scope: !829, inlinedAt: !825)
!829 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!830 = !DILocation(line: 38, scope: !737, inlinedAt: !831)
!831 = distinct !DILocation(line: 32, scope: !739, inlinedAt: !832)
!832 = distinct !DILocation(line: 32, scope: !764, inlinedAt: !833)
!833 = distinct !DILocation(line: 108, scope: !834, inlinedAt: !823)
!834 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!835 = !DILocation(line: 86, scope: !836, inlinedAt: !837)
!836 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!837 = distinct !DILocation(line: 1068, scope: !836, inlinedAt: !838)
!838 = distinct !DILocation(line: 327, scope: !839, inlinedAt: !825)
!839 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!840 = !DILocation(line: 88, scope: !770, inlinedAt: !838)
!841 = !DILocation(line: 87, scope: !752, inlinedAt: !838)
!842 = !DILocation(line: 339, scope: !747, inlinedAt: !748)
!843 = !DILocation(line: 351, scope: !747, inlinedAt: !748)
!844 = !DILocation(line: 8, scope: !749, inlinedAt: !750)
!845 = !DILocation(line: 38, scope: !466, inlinedAt: !846)
!846 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !847)
!847 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !848)
!848 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !849)
!849 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !850)
!850 = distinct !DILocation(line: 8, scope: !749, inlinedAt: !750)
!851 = !DILocation(line: 146, scope: !477, inlinedAt: !852)
!852 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !849)
!853 = !DILocation(line: 52, scope: !480, inlinedAt: !854)
!854 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !850)
!855 = !DILocation(line: 93, scope: !474, inlinedAt: !850)
!856 = !DILocation(line: 647, scope: !732)
!857 = distinct !DISubprogram(name: "check_top_bit", linkageName: "julia_check_top_bit_2555", scope: null, file: !146, line: 644, type: !136, scopeLine: 644, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !30, retainedNodes: !137)
!858 = !DILocation(line: 636, scope: !859, inlinedAt: !860)
!859 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !30, retainedNodes: !137)
!860 = !DILocation(line: 646, scope: !857)
!861 = !DILocation(line: 38, scope: !862, inlinedAt: !863)
!862 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!863 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !865)
!864 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!865 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !867)
!866 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!867 = distinct !DILocation(line: 87, scope: !868, inlinedAt: !869)
!868 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!869 = distinct !DILocation(line: 122, scope: !870, inlinedAt: !871)
!870 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!871 = distinct !DILocation(line: 333, scope: !872, inlinedAt: !873)
!872 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!873 = distinct !DILocation(line: 7, scope: !874, inlinedAt: !875)
!874 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_2558", scope: null, file: !536, line: 40, type: !136, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!875 = distinct !DILocation(line: 646, scope: !857)
!876 = !DILocation(line: 87, scope: !877, inlinedAt: !878)
!877 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!878 = distinct !DILocation(line: 1068, scope: !877, inlinedAt: !867)
!879 = !DILocation(line: 38, scope: !862, inlinedAt: !880)
!880 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !881)
!881 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !882)
!882 = distinct !DILocation(line: 93, scope: !883, inlinedAt: !884)
!883 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!884 = distinct !DILocation(line: 130, scope: !885, inlinedAt: !871)
!885 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!886 = !DILocation(line: 38, scope: !862, inlinedAt: !887)
!887 = distinct !DILocation(line: 32, scope: !864, inlinedAt: !888)
!888 = distinct !DILocation(line: 32, scope: !889, inlinedAt: !890)
!889 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!890 = distinct !DILocation(line: 101, scope: !891, inlinedAt: !892)
!891 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!892 = distinct !DILocation(line: 138, scope: !893, inlinedAt: !871)
!893 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!894 = !DILocation(line: 88, scope: !895, inlinedAt: !871)
!895 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!896 = !DILocation(line: 87, scope: !877, inlinedAt: !871)
!897 = !DILocation(line: 38, scope: !862, inlinedAt: !898)
!898 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !899)
!899 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !900)
!900 = distinct !DILocation(line: 87, scope: !901, inlinedAt: !902)
!901 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!902 = distinct !DILocation(line: 122, scope: !870, inlinedAt: !903)
!903 = distinct !DILocation(line: 334, scope: !872, inlinedAt: !873)
!904 = !DILocation(line: 87, scope: !877, inlinedAt: !905)
!905 = distinct !DILocation(line: 1068, scope: !877, inlinedAt: !900)
!906 = !DILocation(line: 38, scope: !862, inlinedAt: !907)
!907 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !908)
!908 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !909)
!909 = distinct !DILocation(line: 93, scope: !910, inlinedAt: !911)
!910 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!911 = distinct !DILocation(line: 130, scope: !885, inlinedAt: !903)
!912 = !DILocation(line: 38, scope: !862, inlinedAt: !913)
!913 = distinct !DILocation(line: 32, scope: !864, inlinedAt: !914)
!914 = distinct !DILocation(line: 32, scope: !889, inlinedAt: !915)
!915 = distinct !DILocation(line: 101, scope: !916, inlinedAt: !917)
!916 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!917 = distinct !DILocation(line: 138, scope: !893, inlinedAt: !903)
!918 = !DILocation(line: 88, scope: !895, inlinedAt: !903)
!919 = !DILocation(line: 87, scope: !877, inlinedAt: !903)
!920 = !DILocation(line: 38, scope: !862, inlinedAt: !921)
!921 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !922)
!922 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !923)
!923 = distinct !DILocation(line: 87, scope: !924, inlinedAt: !925)
!924 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!925 = distinct !DILocation(line: 122, scope: !870, inlinedAt: !926)
!926 = distinct !DILocation(line: 335, scope: !872, inlinedAt: !873)
!927 = !DILocation(line: 87, scope: !877, inlinedAt: !928)
!928 = distinct !DILocation(line: 1068, scope: !877, inlinedAt: !923)
!929 = !DILocation(line: 38, scope: !862, inlinedAt: !930)
!930 = distinct !DILocation(line: 3, scope: !864, inlinedAt: !931)
!931 = distinct !DILocation(line: 3, scope: !866, inlinedAt: !932)
!932 = distinct !DILocation(line: 93, scope: !933, inlinedAt: !934)
!933 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!934 = distinct !DILocation(line: 130, scope: !885, inlinedAt: !926)
!935 = !DILocation(line: 38, scope: !862, inlinedAt: !936)
!936 = distinct !DILocation(line: 32, scope: !864, inlinedAt: !937)
!937 = distinct !DILocation(line: 32, scope: !889, inlinedAt: !938)
!938 = distinct !DILocation(line: 101, scope: !939, inlinedAt: !940)
!939 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!940 = distinct !DILocation(line: 138, scope: !893, inlinedAt: !926)
!941 = !DILocation(line: 88, scope: !895, inlinedAt: !926)
!942 = !DILocation(line: 87, scope: !877, inlinedAt: !926)
!943 = !DILocation(line: 38, scope: !862, inlinedAt: !944)
!944 = distinct !DILocation(line: 32, scope: !864, inlinedAt: !945)
!945 = distinct !DILocation(line: 32, scope: !889, inlinedAt: !946)
!946 = distinct !DILocation(line: 108, scope: !947, inlinedAt: !948)
!947 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!948 = distinct !DILocation(line: 146, scope: !949, inlinedAt: !950)
!949 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!950 = distinct !DILocation(line: 336, scope: !872, inlinedAt: !873)
!951 = !DILocation(line: 761, scope: !952, inlinedAt: !953)
!952 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!953 = distinct !DILocation(line: 787, scope: !954, inlinedAt: !950)
!954 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!955 = !DILocation(line: 38, scope: !862, inlinedAt: !956)
!956 = distinct !DILocation(line: 32, scope: !864, inlinedAt: !957)
!957 = distinct !DILocation(line: 32, scope: !889, inlinedAt: !958)
!958 = distinct !DILocation(line: 108, scope: !959, inlinedAt: !948)
!959 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!960 = !DILocation(line: 86, scope: !961, inlinedAt: !962)
!961 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!962 = distinct !DILocation(line: 1068, scope: !961, inlinedAt: !963)
!963 = distinct !DILocation(line: 327, scope: !964, inlinedAt: !950)
!964 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!965 = !DILocation(line: 88, scope: !895, inlinedAt: !963)
!966 = !DILocation(line: 87, scope: !877, inlinedAt: !963)
!967 = !DILocation(line: 339, scope: !872, inlinedAt: !873)
!968 = !DILocation(line: 351, scope: !872, inlinedAt: !873)
!969 = !DILocation(line: 8, scope: !874, inlinedAt: !875)
!970 = !DILocation(line: 38, scope: !466, inlinedAt: !971)
!971 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !972)
!972 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !973)
!973 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !974)
!974 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !975)
!975 = distinct !DILocation(line: 8, scope: !874, inlinedAt: !875)
!976 = !DILocation(line: 146, scope: !477, inlinedAt: !977)
!977 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !974)
!978 = !DILocation(line: 52, scope: !480, inlinedAt: !979)
!979 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !975)
!980 = !DILocation(line: 93, scope: !474, inlinedAt: !975)
!981 = !DILocation(line: 647, scope: !857)
!982 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2964", scope: null, file: !511, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !91, retainedNodes: !137)
!983 = !DILocation(line: 175, scope: !982)
!984 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2625", scope: null, file: !511, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !47, retainedNodes: !137)
!985 = !DILocation(line: 175, scope: !984)
!986 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_5062", scope: null, file: !511, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !137)
!987 = !DILocation(line: 175, scope: !986)
!988 = distinct !DISubprogram(name: "gate!", linkageName: "julia_gate!_2937", scope: null, file: !251, line: 37, type: !136, scopeLine: 37, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!989 = !DILocation(line: 38, scope: !990, inlinedAt: !991)
!990 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!991 = !DILocation(line: 0, scope: !992, inlinedAt: !993)
!992 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!993 = !DILocation(line: 0, scope: !994, inlinedAt: !995)
!994 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!995 = !DILocation(line: 38, scope: !988)
!996 = !DILocation(line: 576, scope: !997, inlinedAt: !995)
!997 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!998 = !DILocation(line: 39, scope: !988)
!999 = !DILocation(line: 44, scope: !988)
!1000 = !DILocation(line: 35, scope: !1001, inlinedAt: !1002)
!1001 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!1002 = !DILocation(line: 155, scope: !1003, inlinedAt: !999)
!1003 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!1004 = !DILocation(line: 38, scope: !466, inlinedAt: !1005)
!1005 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1006)
!1006 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1007)
!1007 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1008)
!1008 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1009)
!1009 = distinct !DILocation(line: 44, scope: !988)
!1010 = !DILocation(line: 146, scope: !477, inlinedAt: !1011)
!1011 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1008)
!1012 = !DILocation(line: 52, scope: !480, inlinedAt: !1013)
!1013 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1009)
!1014 = !DILocation(line: 93, scope: !474, inlinedAt: !1009)
!1015 = !DILocation(line: 521, scope: !1016, inlinedAt: !999)
!1016 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!1017 = !DILocation(line: 38, scope: !466, inlinedAt: !1018)
!1018 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1019)
!1019 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1020)
!1020 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1021)
!1021 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1022)
!1022 = distinct !DILocation(line: 44, scope: !988)
!1023 = !DILocation(line: 146, scope: !477, inlinedAt: !1024)
!1024 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1021)
!1025 = !DILocation(line: 52, scope: !480, inlinedAt: !1026)
!1026 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1022)
!1027 = !DILocation(line: 93, scope: !474, inlinedAt: !1022)
!1028 = !DILocation(line: 642, scope: !1029, inlinedAt: !999)
!1029 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !77, retainedNodes: !137)
!1030 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_4989", scope: null, file: !146, line: 757, type: !136, scopeLine: 757, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !137)
!1031 = !DILocation(line: 757, scope: !1030)
!1032 = distinct !DISubprogram(name: "zero", linkageName: "julia_zero_2540", scope: null, file: !151, line: 308, type: !488, scopeLine: 308, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !37, retainedNodes: !137)
!1033 = !DILocation(line: 308, scope: !1032)
!1034 = distinct !DISubprogram(name: "box_int64", linkageName: "julia_box_int64_3002", scope: null, file: !241, line: 212, type: !136, scopeLine: 212, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1035 = !DILocation(line: 38, scope: !243, inlinedAt: !1036)
!1036 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1037)
!1037 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !1038)
!1038 = distinct !DILocation(line: 66, scope: !250, inlinedAt: !1039)
!1039 = distinct !DILocation(line: 12, scope: !253, inlinedAt: !1040)
!1040 = distinct !DILocation(line: 88, scope: !1041, inlinedAt: !1042)
!1041 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !241, file: !241, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1042 = !DILocation(line: 183, scope: !1043, inlinedAt: !1044)
!1043 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !241, file: !241, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1044 = !DILocation(line: 0, scope: !1045, inlinedAt: !1046)
!1045 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1046 = !DILocation(line: 0, scope: !1047, inlinedAt: !1048)
!1047 = distinct !DISubprogram(name: "box;", linkageName: "box", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1048 = !DILocation(line: 212, scope: !1034)
!1049 = !DILocation(line: 38, scope: !243, inlinedAt: !1050)
!1050 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1051)
!1051 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !1052)
!1052 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1053)
!1053 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1054)
!1054 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1055)
!1055 = distinct !DILocation(line: 75, scope: !250, inlinedAt: !1039)
!1056 = !DILocation(line: 119, scope: !272, inlinedAt: !1057)
!1057 = distinct !DILocation(line: 119, scope: !272, inlinedAt: !1039)
!1058 = !DILocation(line: 38, scope: !243, inlinedAt: !1059)
!1059 = distinct !DILocation(line: 3, scope: !280, inlinedAt: !1060)
!1060 = distinct !DILocation(line: 3, scope: !283, inlinedAt: !1061)
!1061 = distinct !DILocation(line: 87, scope: !285, inlinedAt: !1062)
!1062 = distinct !DILocation(line: 122, scope: !287, inlinedAt: !1063)
!1063 = distinct !DILocation(line: 30, scope: !289, inlinedAt: !1064)
!1064 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1065)
!1065 = distinct !DILocation(line: 0, scope: !293, inlinedAt: !1066)
!1066 = distinct !DILocation(line: 9, scope: !295, inlinedAt: !1067)
!1067 = distinct !DILocation(line: 3, scope: !295, inlinedAt: !1068)
!1068 = distinct !DILocation(line: 13, scope: !253, inlinedAt: !1040)
!1069 = !DILocation(line: 521, scope: !300, inlinedAt: !1070)
!1070 = distinct !DILocation(line: 461, scope: !300, inlinedAt: !1071)
!1071 = distinct !DILocation(line: 518, scope: !303, inlinedAt: !1072)
!1072 = distinct !DILocation(line: 276, scope: !306, inlinedAt: !1063)
!1073 = !DILocation(line: 30, scope: !289, inlinedAt: !1064)
!1074 = !DILocation(line: 27, scope: !310, inlinedAt: !1075)
!1075 = distinct !DILocation(line: 37, scope: !313, inlinedAt: !1076)
!1076 = distinct !DILocation(line: 36, scope: !313, inlinedAt: !1077)
!1077 = distinct !DILocation(line: 62, scope: !289, inlinedAt: !1064)
!1078 = !DILocation(line: 38, scope: !313, inlinedAt: !1076)
!1079 = !DILocation(line: 38, scope: !243, inlinedAt: !1080)
!1080 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1081)
!1081 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !1082)
!1082 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !1083)
!1083 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !1084)
!1084 = distinct !DILocation(line: 41, scope: !313, inlinedAt: !1076)
!1085 = !DILocation(line: 146, scope: !326, inlinedAt: !1086)
!1086 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !1083)
!1087 = !DILocation(line: 52, scope: !329, inlinedAt: !1088)
!1088 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !1084)
!1089 = !DILocation(line: 108, scope: !333, inlinedAt: !1090)
!1090 = distinct !DILocation(line: 46, scope: !313, inlinedAt: !1076)
!1091 = !DILocation(line: 47, scope: !313, inlinedAt: !1076)
!1092 = !DILocation(line: 6, scope: !337, inlinedAt: !1093)
!1093 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !1064)
!1094 = !DILocation(line: 30, scope: !289, inlinedAt: !1095)
!1095 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1096)
!1096 = distinct !DILocation(line: 0, scope: !343, inlinedAt: !1097)
!1097 = distinct !DILocation(line: 10, scope: !295, inlinedAt: !1067)
!1098 = !DILocation(line: 38, scope: !243, inlinedAt: !1099)
!1099 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1100)
!1100 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !1101)
!1101 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1102)
!1102 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1103)
!1103 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1104)
!1104 = distinct !DILocation(line: 91, scope: !289, inlinedAt: !1095)
!1105 = !DILocation(line: 6, scope: !337, inlinedAt: !1106)
!1106 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !1095)
!1107 = !DILocation(line: 30, scope: !289, inlinedAt: !1108)
!1108 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1109)
!1109 = distinct !DILocation(line: 0, scope: !359, inlinedAt: !1110)
!1110 = distinct !DILocation(line: 11, scope: !295, inlinedAt: !1067)
!1111 = !DILocation(line: 27, scope: !310, inlinedAt: !1112)
!1112 = distinct !DILocation(line: 37, scope: !313, inlinedAt: !1113)
!1113 = distinct !DILocation(line: 36, scope: !313, inlinedAt: !1114)
!1114 = distinct !DILocation(line: 113, scope: !289, inlinedAt: !1108)
!1115 = !DILocation(line: 38, scope: !313, inlinedAt: !1113)
!1116 = !DILocation(line: 38, scope: !243, inlinedAt: !1117)
!1117 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1118)
!1118 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !1119)
!1119 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !1120)
!1120 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !1121)
!1121 = distinct !DILocation(line: 41, scope: !313, inlinedAt: !1113)
!1122 = !DILocation(line: 146, scope: !326, inlinedAt: !1123)
!1123 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !1120)
!1124 = !DILocation(line: 52, scope: !329, inlinedAt: !1125)
!1125 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !1121)
!1126 = !DILocation(line: 108, scope: !333, inlinedAt: !1127)
!1127 = distinct !DILocation(line: 46, scope: !313, inlinedAt: !1113)
!1128 = !DILocation(line: 47, scope: !313, inlinedAt: !1113)
!1129 = !DILocation(line: 12, scope: !380, inlinedAt: !1130)
!1130 = distinct !DILocation(line: 61, scope: !382, inlinedAt: !1131)
!1131 = distinct !DILocation(line: 60, scope: !382, inlinedAt: !1132)
!1132 = distinct !DILocation(line: 116, scope: !289, inlinedAt: !1108)
!1133 = !DILocation(line: 521, scope: !300, inlinedAt: !1134)
!1134 = distinct !DILocation(line: 62, scope: !382, inlinedAt: !1131)
!1135 = !DILocation(line: 62, scope: !382, inlinedAt: !1131)
!1136 = !DILocation(line: 64, scope: !382, inlinedAt: !1131)
!1137 = !DILocation(line: 38, scope: !243, inlinedAt: !1138)
!1138 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1139)
!1139 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !1140)
!1140 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !1141)
!1141 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !1142)
!1142 = distinct !DILocation(line: 65, scope: !382, inlinedAt: !1131)
!1143 = !DILocation(line: 146, scope: !326, inlinedAt: !1144)
!1144 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !1141)
!1145 = !DILocation(line: 52, scope: !329, inlinedAt: !1146)
!1146 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !1142)
!1147 = !DILocation(line: 108, scope: !333, inlinedAt: !1148)
!1148 = distinct !DILocation(line: 70, scope: !382, inlinedAt: !1131)
!1149 = !DILocation(line: 38, scope: !243, inlinedAt: !1150)
!1150 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1151)
!1151 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !1152)
!1152 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1153)
!1153 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1154)
!1154 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1155)
!1155 = distinct !DILocation(line: 120, scope: !289, inlinedAt: !1108)
!1156 = !DILocation(line: 521, scope: !300, inlinedAt: !1157)
!1157 = distinct !DILocation(line: 518, scope: !303, inlinedAt: !1158)
!1158 = distinct !DILocation(line: 121, scope: !289, inlinedAt: !1108)
!1159 = !DILocation(line: 121, scope: !289, inlinedAt: !1108)
!1160 = !DILocation(line: 19, scope: !415, inlinedAt: !1161)
!1161 = distinct !DILocation(line: 19, scope: !415, inlinedAt: !1162)
!1162 = distinct !DILocation(line: 122, scope: !289, inlinedAt: !1108)
!1163 = !DILocation(line: 38, scope: !243, inlinedAt: !1164)
!1164 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1165)
!1165 = distinct !DILocation(line: 0, scope: !248, inlinedAt: !1166)
!1166 = distinct !DILocation(line: 11, scope: !321, inlinedAt: !1167)
!1167 = distinct !DILocation(line: 90, scope: !323, inlinedAt: !1168)
!1168 = distinct !DILocation(line: 123, scope: !289, inlinedAt: !1108)
!1169 = !DILocation(line: 146, scope: !326, inlinedAt: !1170)
!1170 = distinct !DILocation(line: 146, scope: !326, inlinedAt: !1167)
!1171 = !DILocation(line: 52, scope: !329, inlinedAt: !1172)
!1172 = distinct !DILocation(line: 92, scope: !323, inlinedAt: !1168)
!1173 = !DILocation(line: 1, scope: !429, inlinedAt: !1174)
!1174 = distinct !DILocation(line: 124, scope: !289, inlinedAt: !1108)
!1175 = !DILocation(line: 38, scope: !243, inlinedAt: !1176)
!1176 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1177)
!1177 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !1178)
!1178 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1179)
!1179 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1180)
!1180 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1181)
!1181 = distinct !DILocation(line: 126, scope: !289, inlinedAt: !1108)
!1182 = !DILocation(line: 38, scope: !243, inlinedAt: !1183)
!1183 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1184)
!1184 = distinct !DILocation(line: 0, scope: !261, inlinedAt: !1185)
!1185 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1186)
!1186 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1187)
!1187 = distinct !DILocation(line: 88, scope: !263, inlinedAt: !1181)
!1188 = !DILocation(line: 19, scope: !415, inlinedAt: !1189)
!1189 = distinct !DILocation(line: 19, scope: !415, inlinedAt: !1190)
!1190 = distinct !DILocation(line: 128, scope: !289, inlinedAt: !1108)
!1191 = !DILocation(line: 6, scope: !337, inlinedAt: !1192)
!1192 = distinct !DILocation(line: 47, scope: !289, inlinedAt: !1108)
!1193 = !DILocation(line: 38, scope: !243, inlinedAt: !1194)
!1194 = distinct !DILocation(line: 0, scope: !245, inlinedAt: !1195)
!1195 = distinct !DILocation(line: 0, scope: !404, inlinedAt: !1196)
!1196 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1197)
!1197 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1198)
!1198 = distinct !DILocation(line: 85, scope: !406, inlinedAt: !1199)
!1199 = distinct !DILocation(line: 131, scope: !289, inlinedAt: !1108)
!1200 = !DILocation(line: 38, scope: !1201, inlinedAt: !1202)
!1201 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1202 = !DILocation(line: 141, scope: !1043, inlinedAt: !1203)
!1203 = !DILocation(line: 141, scope: !1204, inlinedAt: !1205)
!1204 = distinct !DISubprogram(name: "type_tag;", linkageName: "type_tag", scope: !241, file: !241, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1205 = !DILocation(line: 187, scope: !1043, inlinedAt: !1044)
!1206 = !DILocation(line: 372, scope: !1207, inlinedAt: !1208)
!1207 = distinct !DISubprogram(name: "|;", linkageName: "|", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1208 = !DILocation(line: 1068, scope: !1207, inlinedAt: !1205)
!1209 = !{!505, !505, i64 0}
!1210 = !DILocation(line: 282, scope: !1211, inlinedAt: !1212)
!1211 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1212 = !DILocation(line: 190, scope: !1043, inlinedAt: !1044)
!1213 = !DILocation(line: 191, scope: !1043, inlinedAt: !1044)
!1214 = !DILocation(line: 253, scope: !1215, inlinedAt: !1216)
!1215 = distinct !DISubprogram(name: "unsafe_pointer_to_objref;", linkageName: "unsafe_pointer_to_objref", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1216 = !DILocation(line: 193, scope: !1043, inlinedAt: !1044)
!1217 = distinct !DISubprogram(name: "gate!", linkageName: "julia_gate!_2598", scope: null, file: !251, line: 37, type: !136, scopeLine: 37, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1218 = !DILocation(line: 38, scope: !1219, inlinedAt: !1220)
!1219 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1220 = !DILocation(line: 0, scope: !1221, inlinedAt: !1222)
!1221 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1222 = !DILocation(line: 0, scope: !1223, inlinedAt: !1224)
!1223 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1224 = !DILocation(line: 38, scope: !1217)
!1225 = !DILocation(line: 576, scope: !1226, inlinedAt: !1224)
!1226 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1227 = !DILocation(line: 39, scope: !1217)
!1228 = !DILocation(line: 44, scope: !1217)
!1229 = !DILocation(line: 35, scope: !1230, inlinedAt: !1231)
!1230 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1231 = !DILocation(line: 155, scope: !1232, inlinedAt: !1228)
!1232 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1233 = !DILocation(line: 38, scope: !466, inlinedAt: !1234)
!1234 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1235)
!1235 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1236)
!1236 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1237)
!1237 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1238)
!1238 = distinct !DILocation(line: 44, scope: !1217)
!1239 = !DILocation(line: 146, scope: !477, inlinedAt: !1240)
!1240 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1237)
!1241 = !DILocation(line: 52, scope: !480, inlinedAt: !1242)
!1242 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1238)
!1243 = !DILocation(line: 93, scope: !474, inlinedAt: !1238)
!1244 = !DILocation(line: 521, scope: !1245, inlinedAt: !1228)
!1245 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1246 = !DILocation(line: 38, scope: !466, inlinedAt: !1247)
!1247 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1248)
!1248 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1249)
!1249 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1250)
!1250 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1251)
!1251 = distinct !DILocation(line: 44, scope: !1217)
!1252 = !DILocation(line: 146, scope: !477, inlinedAt: !1253)
!1253 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1250)
!1254 = !DILocation(line: 52, scope: !480, inlinedAt: !1255)
!1255 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1251)
!1256 = !DILocation(line: 93, scope: !474, inlinedAt: !1251)
!1257 = !DILocation(line: 642, scope: !1258, inlinedAt: !1228)
!1258 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1259 = distinct !DISubprogram(name: "zero", linkageName: "julia_zero_2879", scope: null, file: !151, line: 308, type: !488, scopeLine: 308, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !81, retainedNodes: !137)
!1260 = !DILocation(line: 308, scope: !1259)
!1261 = distinct !DISubprogram(name: "oftype", linkageName: "julia_oftype_2543", scope: null, file: !487, line: 517, type: !488, scopeLine: 517, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !36, retainedNodes: !137)
!1262 = !DILocation(line: 517, scope: !1261)
!1263 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2546", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !35, retainedNodes: !137)
!1264 = !DILocation(line: 7, scope: !1263)
!1265 = distinct !DISubprogram(name: "zero", linkageName: "julia_zero_4977", scope: null, file: !151, line: 308, type: !488, scopeLine: 308, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !137)
!1266 = !DILocation(line: 308, scope: !1265)
!1267 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_5060", scope: null, file: !511, line: 175, type: !488, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !137)
!1268 = !DILocation(line: 175, scope: !1267)
!1269 = !DILocation(line: 87, scope: !1270, inlinedAt: !1268)
!1270 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !137)
!1271 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2962", scope: null, file: !511, line: 175, type: !488, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !90, retainedNodes: !137)
!1272 = !DILocation(line: 175, scope: !1271)
!1273 = !DILocation(line: 87, scope: !1274, inlinedAt: !1272)
!1274 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !90, retainedNodes: !137)
!1275 = distinct !DISubprogram(name: "check_top_bit", linkageName: "julia_check_top_bit_2894", scope: null, file: !146, line: 644, type: !136, scopeLine: 644, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !74, retainedNodes: !137)
!1276 = !DILocation(line: 636, scope: !1277, inlinedAt: !1278)
!1277 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !74, retainedNodes: !137)
!1278 = !DILocation(line: 646, scope: !1275)
!1279 = !DILocation(line: 38, scope: !1280, inlinedAt: !1281)
!1280 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1281 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1283)
!1282 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1283 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1285)
!1284 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1285 = distinct !DILocation(line: 87, scope: !1286, inlinedAt: !1287)
!1286 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1287 = distinct !DILocation(line: 122, scope: !1288, inlinedAt: !1289)
!1288 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1289 = distinct !DILocation(line: 333, scope: !1290, inlinedAt: !1291)
!1290 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1291 = distinct !DILocation(line: 7, scope: !1292, inlinedAt: !1293)
!1292 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_2897", scope: null, file: !536, line: 40, type: !136, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1293 = distinct !DILocation(line: 646, scope: !1275)
!1294 = !DILocation(line: 87, scope: !1295, inlinedAt: !1296)
!1295 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1296 = distinct !DILocation(line: 1068, scope: !1295, inlinedAt: !1285)
!1297 = !DILocation(line: 38, scope: !1280, inlinedAt: !1298)
!1298 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1299)
!1299 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1300)
!1300 = distinct !DILocation(line: 93, scope: !1301, inlinedAt: !1302)
!1301 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1302 = distinct !DILocation(line: 130, scope: !1303, inlinedAt: !1289)
!1303 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1304 = !DILocation(line: 38, scope: !1280, inlinedAt: !1305)
!1305 = distinct !DILocation(line: 32, scope: !1282, inlinedAt: !1306)
!1306 = distinct !DILocation(line: 32, scope: !1307, inlinedAt: !1308)
!1307 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1308 = distinct !DILocation(line: 101, scope: !1309, inlinedAt: !1310)
!1309 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1310 = distinct !DILocation(line: 138, scope: !1311, inlinedAt: !1289)
!1311 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1312 = !DILocation(line: 88, scope: !1313, inlinedAt: !1289)
!1313 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1314 = !DILocation(line: 87, scope: !1295, inlinedAt: !1289)
!1315 = !DILocation(line: 38, scope: !1280, inlinedAt: !1316)
!1316 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1317)
!1317 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1318)
!1318 = distinct !DILocation(line: 87, scope: !1319, inlinedAt: !1320)
!1319 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1320 = distinct !DILocation(line: 122, scope: !1288, inlinedAt: !1321)
!1321 = distinct !DILocation(line: 334, scope: !1290, inlinedAt: !1291)
!1322 = !DILocation(line: 87, scope: !1295, inlinedAt: !1323)
!1323 = distinct !DILocation(line: 1068, scope: !1295, inlinedAt: !1318)
!1324 = !DILocation(line: 38, scope: !1280, inlinedAt: !1325)
!1325 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1326)
!1326 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1327)
!1327 = distinct !DILocation(line: 93, scope: !1328, inlinedAt: !1329)
!1328 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1329 = distinct !DILocation(line: 130, scope: !1303, inlinedAt: !1321)
!1330 = !DILocation(line: 38, scope: !1280, inlinedAt: !1331)
!1331 = distinct !DILocation(line: 32, scope: !1282, inlinedAt: !1332)
!1332 = distinct !DILocation(line: 32, scope: !1307, inlinedAt: !1333)
!1333 = distinct !DILocation(line: 101, scope: !1334, inlinedAt: !1335)
!1334 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1335 = distinct !DILocation(line: 138, scope: !1311, inlinedAt: !1321)
!1336 = !DILocation(line: 88, scope: !1313, inlinedAt: !1321)
!1337 = !DILocation(line: 87, scope: !1295, inlinedAt: !1321)
!1338 = !DILocation(line: 38, scope: !1280, inlinedAt: !1339)
!1339 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1340)
!1340 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1341)
!1341 = distinct !DILocation(line: 87, scope: !1342, inlinedAt: !1343)
!1342 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1343 = distinct !DILocation(line: 122, scope: !1288, inlinedAt: !1344)
!1344 = distinct !DILocation(line: 335, scope: !1290, inlinedAt: !1291)
!1345 = !DILocation(line: 87, scope: !1295, inlinedAt: !1346)
!1346 = distinct !DILocation(line: 1068, scope: !1295, inlinedAt: !1341)
!1347 = !DILocation(line: 38, scope: !1280, inlinedAt: !1348)
!1348 = distinct !DILocation(line: 3, scope: !1282, inlinedAt: !1349)
!1349 = distinct !DILocation(line: 3, scope: !1284, inlinedAt: !1350)
!1350 = distinct !DILocation(line: 93, scope: !1351, inlinedAt: !1352)
!1351 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1352 = distinct !DILocation(line: 130, scope: !1303, inlinedAt: !1344)
!1353 = !DILocation(line: 38, scope: !1280, inlinedAt: !1354)
!1354 = distinct !DILocation(line: 32, scope: !1282, inlinedAt: !1355)
!1355 = distinct !DILocation(line: 32, scope: !1307, inlinedAt: !1356)
!1356 = distinct !DILocation(line: 101, scope: !1357, inlinedAt: !1358)
!1357 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1358 = distinct !DILocation(line: 138, scope: !1311, inlinedAt: !1344)
!1359 = !DILocation(line: 88, scope: !1313, inlinedAt: !1344)
!1360 = !DILocation(line: 87, scope: !1295, inlinedAt: !1344)
!1361 = !DILocation(line: 38, scope: !1280, inlinedAt: !1362)
!1362 = distinct !DILocation(line: 32, scope: !1282, inlinedAt: !1363)
!1363 = distinct !DILocation(line: 32, scope: !1307, inlinedAt: !1364)
!1364 = distinct !DILocation(line: 108, scope: !1365, inlinedAt: !1366)
!1365 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1366 = distinct !DILocation(line: 146, scope: !1367, inlinedAt: !1368)
!1367 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1368 = distinct !DILocation(line: 336, scope: !1290, inlinedAt: !1291)
!1369 = !DILocation(line: 761, scope: !1370, inlinedAt: !1371)
!1370 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1371 = distinct !DILocation(line: 787, scope: !1372, inlinedAt: !1368)
!1372 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1373 = !DILocation(line: 38, scope: !1280, inlinedAt: !1374)
!1374 = distinct !DILocation(line: 32, scope: !1282, inlinedAt: !1375)
!1375 = distinct !DILocation(line: 32, scope: !1307, inlinedAt: !1376)
!1376 = distinct !DILocation(line: 108, scope: !1377, inlinedAt: !1366)
!1377 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1378 = !DILocation(line: 86, scope: !1379, inlinedAt: !1380)
!1379 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1380 = distinct !DILocation(line: 1068, scope: !1379, inlinedAt: !1381)
!1381 = distinct !DILocation(line: 327, scope: !1382, inlinedAt: !1368)
!1382 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !73, retainedNodes: !137)
!1383 = !DILocation(line: 88, scope: !1313, inlinedAt: !1381)
!1384 = !DILocation(line: 87, scope: !1295, inlinedAt: !1381)
!1385 = !DILocation(line: 339, scope: !1290, inlinedAt: !1291)
!1386 = !DILocation(line: 351, scope: !1290, inlinedAt: !1291)
!1387 = !DILocation(line: 8, scope: !1292, inlinedAt: !1293)
!1388 = !DILocation(line: 38, scope: !466, inlinedAt: !1389)
!1389 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1390)
!1390 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1391)
!1391 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1392)
!1392 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1393)
!1393 = distinct !DILocation(line: 8, scope: !1292, inlinedAt: !1293)
!1394 = !DILocation(line: 146, scope: !477, inlinedAt: !1395)
!1395 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1392)
!1396 = !DILocation(line: 52, scope: !480, inlinedAt: !1397)
!1397 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1393)
!1398 = !DILocation(line: 93, scope: !474, inlinedAt: !1393)
!1399 = !DILocation(line: 647, scope: !1275)
!1400 = distinct !DISubprogram(name: "iszero", linkageName: "julia_iszero_2537", scope: null, file: !151, line: 42, type: !136, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !38, retainedNodes: !137)
!1401 = !DILocation(line: 42, scope: !1400)
!1402 = !DILocation(line: 521, scope: !1403, inlinedAt: !1401)
!1403 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !38, retainedNodes: !137)
!1404 = distinct !DISubprogram(name: "report_oom", linkageName: "julia_report_oom_2834", scope: null, file: !251, line: 110, type: !488, scopeLine: 110, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1405 = !DILocation(line: 38, scope: !1406, inlinedAt: !1407)
!1406 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1407 = !DILocation(line: 3, scope: !1408, inlinedAt: !1409)
!1408 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1409 = !DILocation(line: 3, scope: !1410, inlinedAt: !1411)
!1410 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1411 = !DILocation(line: 87, scope: !1412, inlinedAt: !1413)
!1412 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1413 = !DILocation(line: 122, scope: !1414, inlinedAt: !1415)
!1414 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1415 = !DILocation(line: 333, scope: !1416, inlinedAt: !1417)
!1416 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1417 = !DILocation(line: 111, scope: !1404)
!1418 = !DILocation(line: 87, scope: !1419, inlinedAt: !1420)
!1419 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1420 = !DILocation(line: 1068, scope: !1419, inlinedAt: !1411)
!1421 = !DILocation(line: 38, scope: !1406, inlinedAt: !1422)
!1422 = !DILocation(line: 3, scope: !1408, inlinedAt: !1423)
!1423 = !DILocation(line: 3, scope: !1410, inlinedAt: !1424)
!1424 = !DILocation(line: 93, scope: !1425, inlinedAt: !1426)
!1425 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1426 = !DILocation(line: 130, scope: !1427, inlinedAt: !1415)
!1427 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1428 = !DILocation(line: 38, scope: !1406, inlinedAt: !1429)
!1429 = !DILocation(line: 32, scope: !1408, inlinedAt: !1430)
!1430 = !DILocation(line: 32, scope: !1431, inlinedAt: !1432)
!1431 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1432 = !DILocation(line: 101, scope: !1433, inlinedAt: !1434)
!1433 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1434 = !DILocation(line: 138, scope: !1435, inlinedAt: !1415)
!1435 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1436 = !DILocation(line: 88, scope: !1437, inlinedAt: !1415)
!1437 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1438 = !DILocation(line: 87, scope: !1419, inlinedAt: !1415)
!1439 = !DILocation(line: 38, scope: !1406, inlinedAt: !1440)
!1440 = !DILocation(line: 3, scope: !1408, inlinedAt: !1441)
!1441 = !DILocation(line: 3, scope: !1410, inlinedAt: !1442)
!1442 = !DILocation(line: 87, scope: !1443, inlinedAt: !1444)
!1443 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1444 = !DILocation(line: 122, scope: !1414, inlinedAt: !1445)
!1445 = !DILocation(line: 334, scope: !1416, inlinedAt: !1417)
!1446 = !DILocation(line: 87, scope: !1419, inlinedAt: !1447)
!1447 = !DILocation(line: 1068, scope: !1419, inlinedAt: !1442)
!1448 = !DILocation(line: 38, scope: !1406, inlinedAt: !1449)
!1449 = !DILocation(line: 3, scope: !1408, inlinedAt: !1450)
!1450 = !DILocation(line: 3, scope: !1410, inlinedAt: !1451)
!1451 = !DILocation(line: 93, scope: !1452, inlinedAt: !1453)
!1452 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1453 = !DILocation(line: 130, scope: !1427, inlinedAt: !1445)
!1454 = !DILocation(line: 38, scope: !1406, inlinedAt: !1455)
!1455 = !DILocation(line: 32, scope: !1408, inlinedAt: !1456)
!1456 = !DILocation(line: 32, scope: !1431, inlinedAt: !1457)
!1457 = !DILocation(line: 101, scope: !1458, inlinedAt: !1459)
!1458 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1459 = !DILocation(line: 138, scope: !1435, inlinedAt: !1445)
!1460 = !DILocation(line: 88, scope: !1437, inlinedAt: !1445)
!1461 = !DILocation(line: 87, scope: !1419, inlinedAt: !1445)
!1462 = !DILocation(line: 38, scope: !1406, inlinedAt: !1463)
!1463 = !DILocation(line: 3, scope: !1408, inlinedAt: !1464)
!1464 = !DILocation(line: 3, scope: !1410, inlinedAt: !1465)
!1465 = !DILocation(line: 87, scope: !1466, inlinedAt: !1467)
!1466 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1467 = !DILocation(line: 122, scope: !1414, inlinedAt: !1468)
!1468 = !DILocation(line: 335, scope: !1416, inlinedAt: !1417)
!1469 = !DILocation(line: 87, scope: !1419, inlinedAt: !1470)
!1470 = !DILocation(line: 1068, scope: !1419, inlinedAt: !1465)
!1471 = !DILocation(line: 38, scope: !1406, inlinedAt: !1472)
!1472 = !DILocation(line: 3, scope: !1408, inlinedAt: !1473)
!1473 = !DILocation(line: 3, scope: !1410, inlinedAt: !1474)
!1474 = !DILocation(line: 93, scope: !1475, inlinedAt: !1476)
!1475 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1476 = !DILocation(line: 130, scope: !1427, inlinedAt: !1468)
!1477 = !DILocation(line: 38, scope: !1406, inlinedAt: !1478)
!1478 = !DILocation(line: 32, scope: !1408, inlinedAt: !1479)
!1479 = !DILocation(line: 32, scope: !1431, inlinedAt: !1480)
!1480 = !DILocation(line: 101, scope: !1481, inlinedAt: !1482)
!1481 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1482 = !DILocation(line: 138, scope: !1435, inlinedAt: !1468)
!1483 = !DILocation(line: 88, scope: !1437, inlinedAt: !1468)
!1484 = !DILocation(line: 87, scope: !1419, inlinedAt: !1468)
!1485 = !DILocation(line: 38, scope: !1406, inlinedAt: !1486)
!1486 = !DILocation(line: 32, scope: !1408, inlinedAt: !1487)
!1487 = !DILocation(line: 32, scope: !1431, inlinedAt: !1488)
!1488 = !DILocation(line: 108, scope: !1489, inlinedAt: !1490)
!1489 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1490 = !DILocation(line: 146, scope: !1491, inlinedAt: !1492)
!1491 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1492 = !DILocation(line: 336, scope: !1416, inlinedAt: !1417)
!1493 = !DILocation(line: 761, scope: !1494, inlinedAt: !1495)
!1494 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1495 = !DILocation(line: 787, scope: !1496, inlinedAt: !1492)
!1496 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1497 = !DILocation(line: 38, scope: !1406, inlinedAt: !1498)
!1498 = !DILocation(line: 32, scope: !1408, inlinedAt: !1499)
!1499 = !DILocation(line: 32, scope: !1431, inlinedAt: !1500)
!1500 = !DILocation(line: 108, scope: !1501, inlinedAt: !1490)
!1501 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1502 = !DILocation(line: 86, scope: !1503, inlinedAt: !1504)
!1503 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1504 = !DILocation(line: 1068, scope: !1503, inlinedAt: !1505)
!1505 = !DILocation(line: 327, scope: !1506, inlinedAt: !1492)
!1506 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1507 = !DILocation(line: 88, scope: !1437, inlinedAt: !1505)
!1508 = !DILocation(line: 87, scope: !1419, inlinedAt: !1505)
!1509 = !DILocation(line: 38, scope: !1406, inlinedAt: !1510)
!1510 = !DILocation(line: 0, scope: !1511, inlinedAt: !1512)
!1511 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1512 = !DILocation(line: 0, scope: !1513, inlinedAt: !1514)
!1513 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1514 = !DILocation(line: 38, scope: !1515, inlinedAt: !1516)
!1515 = distinct !DISubprogram(name: "gate!;", linkageName: "gate!", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1516 = !DILocation(line: 339, scope: !1416, inlinedAt: !1417)
!1517 = !DILocation(line: 576, scope: !1518, inlinedAt: !1514)
!1518 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1519 = !DILocation(line: 39, scope: !1515, inlinedAt: !1516)
!1520 = !DILocation(line: 44, scope: !1515, inlinedAt: !1516)
!1521 = !DILocation(line: 35, scope: !1522, inlinedAt: !1523)
!1522 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1523 = !DILocation(line: 155, scope: !1524, inlinedAt: !1520)
!1524 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1525 = !DILocation(line: 38, scope: !466, inlinedAt: !1526)
!1526 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1527)
!1527 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1528)
!1528 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1529)
!1529 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1530)
!1530 = distinct !DILocation(line: 44, scope: !1515, inlinedAt: !1516)
!1531 = !DILocation(line: 146, scope: !477, inlinedAt: !1532)
!1532 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1529)
!1533 = !DILocation(line: 52, scope: !480, inlinedAt: !1534)
!1534 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1530)
!1535 = !DILocation(line: 93, scope: !474, inlinedAt: !1530)
!1536 = !DILocation(line: 521, scope: !1537, inlinedAt: !1520)
!1537 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !92, retainedNodes: !137)
!1538 = !DILocation(line: 38, scope: !466, inlinedAt: !1539)
!1539 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1540)
!1540 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1541)
!1541 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1542)
!1542 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1543)
!1543 = distinct !DILocation(line: 44, scope: !1515, inlinedAt: !1516)
!1544 = !DILocation(line: 146, scope: !477, inlinedAt: !1545)
!1545 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1542)
!1546 = !DILocation(line: 52, scope: !480, inlinedAt: !1547)
!1547 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1543)
!1548 = !DILocation(line: 93, scope: !474, inlinedAt: !1543)
!1549 = !DILocation(line: 351, scope: !1416, inlinedAt: !1417)
!1550 = !DILocation(line: 112, scope: !1404)
!1551 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2885", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !79, retainedNodes: !137)
!1552 = !DILocation(line: 7, scope: !1551)
!1553 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_4983", scope: null, file: !151, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !13, retainedNodes: !137)
!1554 = !DILocation(line: 7, scope: !1553)
!1555 = distinct !DISubprogram(name: "oftype", linkageName: "julia_oftype_4980", scope: null, file: !487, line: 517, type: !488, scopeLine: 517, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !137)
!1556 = !DILocation(line: 517, scope: !1555)
!1557 = distinct !DISubprogram(name: "gate!", linkageName: "julia_gate!_5035", scope: null, file: !251, line: 37, type: !136, scopeLine: 37, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1558 = !DILocation(line: 38, scope: !1559, inlinedAt: !1560)
!1559 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1560 = !DILocation(line: 0, scope: !1561, inlinedAt: !1562)
!1561 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1562 = !DILocation(line: 0, scope: !1563, inlinedAt: !1564)
!1563 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1564 = !DILocation(line: 38, scope: !1557)
!1565 = !DILocation(line: 576, scope: !1566, inlinedAt: !1564)
!1566 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1567 = !DILocation(line: 39, scope: !1557)
!1568 = !DILocation(line: 44, scope: !1557)
!1569 = !DILocation(line: 35, scope: !1570, inlinedAt: !1571)
!1570 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1571 = !DILocation(line: 155, scope: !1572, inlinedAt: !1568)
!1572 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1573 = !DILocation(line: 38, scope: !466, inlinedAt: !1574)
!1574 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1575)
!1575 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1576)
!1576 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1577)
!1577 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1578)
!1578 = distinct !DILocation(line: 44, scope: !1557)
!1579 = !DILocation(line: 146, scope: !477, inlinedAt: !1580)
!1580 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1577)
!1581 = !DILocation(line: 52, scope: !480, inlinedAt: !1582)
!1582 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1578)
!1583 = !DILocation(line: 93, scope: !474, inlinedAt: !1578)
!1584 = !DILocation(line: 521, scope: !1585, inlinedAt: !1568)
!1585 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1586 = !DILocation(line: 38, scope: !466, inlinedAt: !1587)
!1587 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1588)
!1588 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1589)
!1589 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1590)
!1590 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1591)
!1591 = distinct !DILocation(line: 44, scope: !1557)
!1592 = !DILocation(line: 146, scope: !477, inlinedAt: !1593)
!1593 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1590)
!1594 = !DILocation(line: 52, scope: !480, inlinedAt: !1595)
!1595 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1591)
!1596 = !DILocation(line: 93, scope: !474, inlinedAt: !1591)
!1597 = !DILocation(line: 642, scope: !1598, inlinedAt: !1568)
!1598 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!1599 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_2455", scope: null, file: !251, line: 115, type: !136, scopeLine: 115, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1600 = !DILocation(line: 38, scope: !1601, inlinedAt: !1602)
!1601 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1602 = !DILocation(line: 3, scope: !1603, inlinedAt: !1604)
!1603 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1604 = !DILocation(line: 3, scope: !1605, inlinedAt: !1606)
!1605 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1606 = !DILocation(line: 87, scope: !1607, inlinedAt: !1608)
!1607 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1608 = !DILocation(line: 122, scope: !1609, inlinedAt: !1610)
!1609 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1610 = !DILocation(line: 333, scope: !1611, inlinedAt: !1612)
!1611 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1612 = !DILocation(line: 98, scope: !1613, inlinedAt: !1614)
!1613 = distinct !DISubprogram(name: "err_device_string_to_host;", linkageName: "err_device_string_to_host", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1614 = !DILocation(line: 116, scope: !1599)
!1615 = !DILocation(line: 87, scope: !1616, inlinedAt: !1617)
!1616 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1617 = !DILocation(line: 1068, scope: !1616, inlinedAt: !1606)
!1618 = !DILocation(line: 38, scope: !1601, inlinedAt: !1619)
!1619 = !DILocation(line: 3, scope: !1603, inlinedAt: !1620)
!1620 = !DILocation(line: 3, scope: !1605, inlinedAt: !1621)
!1621 = !DILocation(line: 93, scope: !1622, inlinedAt: !1623)
!1622 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1623 = !DILocation(line: 130, scope: !1624, inlinedAt: !1610)
!1624 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1625 = !DILocation(line: 38, scope: !1601, inlinedAt: !1626)
!1626 = !DILocation(line: 32, scope: !1603, inlinedAt: !1627)
!1627 = !DILocation(line: 32, scope: !1628, inlinedAt: !1629)
!1628 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1629 = !DILocation(line: 101, scope: !1630, inlinedAt: !1631)
!1630 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1631 = !DILocation(line: 138, scope: !1632, inlinedAt: !1610)
!1632 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1633 = !DILocation(line: 88, scope: !1634, inlinedAt: !1610)
!1634 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1635 = !DILocation(line: 87, scope: !1616, inlinedAt: !1610)
!1636 = !DILocation(line: 38, scope: !1601, inlinedAt: !1637)
!1637 = !DILocation(line: 3, scope: !1603, inlinedAt: !1638)
!1638 = !DILocation(line: 3, scope: !1605, inlinedAt: !1639)
!1639 = !DILocation(line: 87, scope: !1640, inlinedAt: !1641)
!1640 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1641 = !DILocation(line: 122, scope: !1609, inlinedAt: !1642)
!1642 = !DILocation(line: 334, scope: !1611, inlinedAt: !1612)
!1643 = !DILocation(line: 87, scope: !1616, inlinedAt: !1644)
!1644 = !DILocation(line: 1068, scope: !1616, inlinedAt: !1639)
!1645 = !DILocation(line: 38, scope: !1601, inlinedAt: !1646)
!1646 = !DILocation(line: 3, scope: !1603, inlinedAt: !1647)
!1647 = !DILocation(line: 3, scope: !1605, inlinedAt: !1648)
!1648 = !DILocation(line: 93, scope: !1649, inlinedAt: !1650)
!1649 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1650 = !DILocation(line: 130, scope: !1624, inlinedAt: !1642)
!1651 = !DILocation(line: 38, scope: !1601, inlinedAt: !1652)
!1652 = !DILocation(line: 32, scope: !1603, inlinedAt: !1653)
!1653 = !DILocation(line: 32, scope: !1628, inlinedAt: !1654)
!1654 = !DILocation(line: 101, scope: !1655, inlinedAt: !1656)
!1655 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1656 = !DILocation(line: 138, scope: !1632, inlinedAt: !1642)
!1657 = !DILocation(line: 88, scope: !1634, inlinedAt: !1642)
!1658 = !DILocation(line: 87, scope: !1616, inlinedAt: !1642)
!1659 = !DILocation(line: 38, scope: !1601, inlinedAt: !1660)
!1660 = !DILocation(line: 3, scope: !1603, inlinedAt: !1661)
!1661 = !DILocation(line: 3, scope: !1605, inlinedAt: !1662)
!1662 = !DILocation(line: 87, scope: !1663, inlinedAt: !1664)
!1663 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1664 = !DILocation(line: 122, scope: !1609, inlinedAt: !1665)
!1665 = !DILocation(line: 335, scope: !1611, inlinedAt: !1612)
!1666 = !DILocation(line: 87, scope: !1616, inlinedAt: !1667)
!1667 = !DILocation(line: 1068, scope: !1616, inlinedAt: !1662)
!1668 = !DILocation(line: 38, scope: !1601, inlinedAt: !1669)
!1669 = !DILocation(line: 3, scope: !1603, inlinedAt: !1670)
!1670 = !DILocation(line: 3, scope: !1605, inlinedAt: !1671)
!1671 = !DILocation(line: 93, scope: !1672, inlinedAt: !1673)
!1672 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1673 = !DILocation(line: 130, scope: !1624, inlinedAt: !1665)
!1674 = !DILocation(line: 38, scope: !1601, inlinedAt: !1675)
!1675 = !DILocation(line: 32, scope: !1603, inlinedAt: !1676)
!1676 = !DILocation(line: 32, scope: !1628, inlinedAt: !1677)
!1677 = !DILocation(line: 101, scope: !1678, inlinedAt: !1679)
!1678 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1679 = !DILocation(line: 138, scope: !1632, inlinedAt: !1665)
!1680 = !DILocation(line: 88, scope: !1634, inlinedAt: !1665)
!1681 = !DILocation(line: 87, scope: !1616, inlinedAt: !1665)
!1682 = !DILocation(line: 38, scope: !1601, inlinedAt: !1683)
!1683 = !DILocation(line: 32, scope: !1603, inlinedAt: !1684)
!1684 = !DILocation(line: 32, scope: !1628, inlinedAt: !1685)
!1685 = !DILocation(line: 108, scope: !1686, inlinedAt: !1687)
!1686 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1687 = !DILocation(line: 146, scope: !1688, inlinedAt: !1689)
!1688 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1689 = !DILocation(line: 336, scope: !1611, inlinedAt: !1612)
!1690 = !DILocation(line: 761, scope: !1691, inlinedAt: !1692)
!1691 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1692 = !DILocation(line: 787, scope: !1693, inlinedAt: !1689)
!1693 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1694 = !DILocation(line: 38, scope: !1601, inlinedAt: !1695)
!1695 = !DILocation(line: 32, scope: !1603, inlinedAt: !1696)
!1696 = !DILocation(line: 32, scope: !1628, inlinedAt: !1697)
!1697 = !DILocation(line: 108, scope: !1698, inlinedAt: !1687)
!1698 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !281, file: !281, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1699 = !DILocation(line: 86, scope: !1700, inlinedAt: !1701)
!1700 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1701 = !DILocation(line: 1068, scope: !1700, inlinedAt: !1702)
!1702 = !DILocation(line: 327, scope: !1703, inlinedAt: !1689)
!1703 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !533, file: !533, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1704 = !DILocation(line: 88, scope: !1634, inlinedAt: !1702)
!1705 = !DILocation(line: 87, scope: !1616, inlinedAt: !1702)
!1706 = !DILocation(line: 38, scope: !1601, inlinedAt: !1707)
!1707 = !DILocation(line: 0, scope: !1708, inlinedAt: !1709)
!1708 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1709 = !DILocation(line: 0, scope: !1710, inlinedAt: !1711)
!1710 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1711 = !DILocation(line: 38, scope: !1712, inlinedAt: !1713)
!1712 = distinct !DISubprogram(name: "gate!;", linkageName: "gate!", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1713 = !DILocation(line: 339, scope: !1611, inlinedAt: !1612)
!1714 = !DILocation(line: 576, scope: !1715, inlinedAt: !1711)
!1715 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !487, file: !487, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1716 = !DILocation(line: 39, scope: !1712, inlinedAt: !1713)
!1717 = !DILocation(line: 44, scope: !1712, inlinedAt: !1713)
!1718 = !DILocation(line: 35, scope: !1719, inlinedAt: !1720)
!1719 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1720 = !DILocation(line: 155, scope: !1721, inlinedAt: !1717)
!1721 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !655, file: !655, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1722 = !DILocation(line: 38, scope: !466, inlinedAt: !1723)
!1723 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1724)
!1724 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1725)
!1725 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1726)
!1726 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1727)
!1727 = distinct !DILocation(line: 44, scope: !1712, inlinedAt: !1713)
!1728 = !DILocation(line: 146, scope: !477, inlinedAt: !1729)
!1729 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1726)
!1730 = !DILocation(line: 52, scope: !480, inlinedAt: !1731)
!1731 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1727)
!1732 = !DILocation(line: 93, scope: !474, inlinedAt: !1727)
!1733 = !DILocation(line: 521, scope: !1734, inlinedAt: !1717)
!1734 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !154, file: !154, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1735 = !DILocation(line: 38, scope: !466, inlinedAt: !1736)
!1736 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1737)
!1737 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1738)
!1738 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1739)
!1739 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1740)
!1740 = distinct !DILocation(line: 44, scope: !1712, inlinedAt: !1713)
!1741 = !DILocation(line: 146, scope: !477, inlinedAt: !1742)
!1742 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1739)
!1743 = !DILocation(line: 52, scope: !480, inlinedAt: !1744)
!1744 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1740)
!1745 = !DILocation(line: 93, scope: !474, inlinedAt: !1740)
!1746 = !DILocation(line: 38, scope: !1601, inlinedAt: !1747)
!1747 = !DILocation(line: 0, scope: !1708, inlinedAt: !1748)
!1748 = !DILocation(line: 0, scope: !1710, inlinedAt: !1749)
!1749 = !DILocation(line: 26, scope: !1750, inlinedAt: !1751)
!1750 = distinct !DISubprogram(name: "err_str_buffer!;", linkageName: "err_str_buffer!", scope: !251, file: !251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1751 = !DILocation(line: 340, scope: !1611, inlinedAt: !1612)
!1752 = !DILocation(line: 38, scope: !1601, inlinedAt: !1753)
!1753 = !DILocation(line: 255, scope: !1754, inlinedAt: !1755)
!1754 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1755 = !DILocation(line: 255, scope: !1756, inlinedAt: !1757)
!1756 = distinct !DISubprogram(name: "llvm_atomic_op;", linkageName: "llvm_atomic_op", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1757 = !DILocation(line: 359, scope: !1758, inlinedAt: !1759)
!1758 = distinct !DISubprogram(name: "atomic_pointermodify;", linkageName: "atomic_pointermodify", scope: !135, file: !135, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1759 = !DILocation(line: 294, scope: !1758, inlinedAt: !1760)
!1760 = !DILocation(line: 28, scope: !1750, inlinedAt: !1751)
!1761 = !DILocation(line: 83, scope: !1762, inlinedAt: !1763)
!1762 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1763 = !DILocation(line: 378, scope: !1764, inlinedAt: !1765)
!1764 = distinct !DISubprogram(name: ">;", linkageName: ">", scope: !307, file: !307, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1765 = !DILocation(line: 31, scope: !1750, inlinedAt: !1751)
!1766 = !DILocation(line: 38, scope: !1601, inlinedAt: !1767)
!1767 = !DILocation(line: 0, scope: !1708, inlinedAt: !1768)
!1768 = !DILocation(line: 0, scope: !1710, inlinedAt: !1769)
!1769 = !DILocation(line: 33, scope: !1750, inlinedAt: !1751)
!1770 = !DILocation(line: 701, scope: !1771, inlinedAt: !1772)
!1771 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1772 = !DILocation(line: 782, scope: !1773, inlinedAt: !1774)
!1773 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !146, file: !146, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1774 = !DILocation(line: 119, scope: !1775, inlinedAt: !1769)
!1775 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !273, file: !273, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1776 = !DILocation(line: 576, scope: !1715, inlinedAt: !1777)
!1777 = !DILocation(line: 34, scope: !1750, inlinedAt: !1751)
!1778 = !DILocation(line: 521, scope: !1734, inlinedAt: !1779)
!1779 = !DILocation(line: 518, scope: !1780, inlinedAt: !1781)
!1780 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !304, file: !304, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1781 = !DILocation(line: 99, scope: !1613, inlinedAt: !1614)
!1782 = !DILocation(line: 576, scope: !1715, inlinedAt: !1783)
!1783 = !DILocation(line: 101, scope: !1613, inlinedAt: !1614)
!1784 = !DILocation(line: 38, scope: !1601, inlinedAt: !1785)
!1785 = !DILocation(line: 3, scope: !1786, inlinedAt: !1788)
!1786 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !1787, file: !1787, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1787 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!1788 = !DILocation(line: 3, scope: !1789, inlinedAt: !1790)
!1789 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !1787, file: !1787, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1790 = !DILocation(line: 102, scope: !1613, inlinedAt: !1614)
!1791 = !DILocation(line: 38, scope: !1601, inlinedAt: !1792)
!1792 = !DILocation(line: 0, scope: !1708, inlinedAt: !1793)
!1793 = !DILocation(line: 0, scope: !1794, inlinedAt: !1795)
!1794 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1795 = !DILocation(line: 105, scope: !1613, inlinedAt: !1614)
!1796 = !DILocation(line: 114, scope: !1797, inlinedAt: !1798)
!1797 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !264, file: !264, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1798 = !DILocation(line: 106, scope: !1613, inlinedAt: !1614)
!1799 = !DILocation(line: 38, scope: !1601, inlinedAt: !1800)
!1800 = !DILocation(line: 0, scope: !1708, inlinedAt: !1801)
!1801 = !DILocation(line: 0, scope: !1802, inlinedAt: !1803)
!1802 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !246, file: !246, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1803 = !DILocation(line: 88, scope: !1804, inlinedAt: !1805)
!1804 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !264, file: !264, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1805 = !DILocation(line: 88, scope: !1804, inlinedAt: !1806)
!1806 = !DILocation(line: 88, scope: !1804, inlinedAt: !1798)
!1807 = !DILocation(line: 107, scope: !1613, inlinedAt: !1614)
!1808 = !DILocation(line: 38, scope: !1601, inlinedAt: !1809)
!1809 = !DILocation(line: 32, scope: !1603, inlinedAt: !1810)
!1810 = !DILocation(line: 32, scope: !1628, inlinedAt: !1811)
!1811 = !DILocation(line: 101, scope: !1630, inlinedAt: !1812)
!1812 = !DILocation(line: 138, scope: !1632, inlinedAt: !1813)
!1813 = !DILocation(line: 333, scope: !1611, inlinedAt: !1814)
!1814 = !DILocation(line: 117, scope: !1599)
!1815 = !DILocation(line: 88, scope: !1634, inlinedAt: !1813)
!1816 = !DILocation(line: 87, scope: !1616, inlinedAt: !1813)
!1817 = !DILocation(line: 38, scope: !1601, inlinedAt: !1818)
!1818 = !DILocation(line: 32, scope: !1603, inlinedAt: !1819)
!1819 = !DILocation(line: 32, scope: !1628, inlinedAt: !1820)
!1820 = !DILocation(line: 101, scope: !1655, inlinedAt: !1821)
!1821 = !DILocation(line: 138, scope: !1632, inlinedAt: !1822)
!1822 = !DILocation(line: 334, scope: !1611, inlinedAt: !1814)
!1823 = !DILocation(line: 88, scope: !1634, inlinedAt: !1822)
!1824 = !DILocation(line: 87, scope: !1616, inlinedAt: !1822)
!1825 = !DILocation(line: 38, scope: !1601, inlinedAt: !1826)
!1826 = !DILocation(line: 32, scope: !1603, inlinedAt: !1827)
!1827 = !DILocation(line: 32, scope: !1628, inlinedAt: !1828)
!1828 = !DILocation(line: 101, scope: !1678, inlinedAt: !1829)
!1829 = !DILocation(line: 138, scope: !1632, inlinedAt: !1830)
!1830 = !DILocation(line: 335, scope: !1611, inlinedAt: !1814)
!1831 = !DILocation(line: 88, scope: !1634, inlinedAt: !1830)
!1832 = !DILocation(line: 87, scope: !1616, inlinedAt: !1830)
!1833 = !DILocation(line: 38, scope: !1601, inlinedAt: !1834)
!1834 = !DILocation(line: 32, scope: !1603, inlinedAt: !1835)
!1835 = !DILocation(line: 32, scope: !1628, inlinedAt: !1836)
!1836 = !DILocation(line: 108, scope: !1686, inlinedAt: !1837)
!1837 = !DILocation(line: 146, scope: !1688, inlinedAt: !1838)
!1838 = !DILocation(line: 336, scope: !1611, inlinedAt: !1814)
!1839 = !DILocation(line: 761, scope: !1691, inlinedAt: !1840)
!1840 = !DILocation(line: 787, scope: !1693, inlinedAt: !1838)
!1841 = !DILocation(line: 38, scope: !1601, inlinedAt: !1842)
!1842 = !DILocation(line: 32, scope: !1603, inlinedAt: !1843)
!1843 = !DILocation(line: 32, scope: !1628, inlinedAt: !1844)
!1844 = !DILocation(line: 108, scope: !1698, inlinedAt: !1837)
!1845 = !DILocation(line: 86, scope: !1700, inlinedAt: !1846)
!1846 = !DILocation(line: 1068, scope: !1700, inlinedAt: !1847)
!1847 = !DILocation(line: 327, scope: !1703, inlinedAt: !1838)
!1848 = !DILocation(line: 88, scope: !1634, inlinedAt: !1847)
!1849 = !DILocation(line: 87, scope: !1616, inlinedAt: !1847)
!1850 = !DILocation(line: 39, scope: !1712, inlinedAt: !1851)
!1851 = !DILocation(line: 339, scope: !1611, inlinedAt: !1814)
!1852 = !DILocation(line: 44, scope: !1712, inlinedAt: !1851)
!1853 = !DILocation(line: 35, scope: !1719, inlinedAt: !1854)
!1854 = !DILocation(line: 155, scope: !1721, inlinedAt: !1852)
!1855 = !DILocation(line: 38, scope: !466, inlinedAt: !1856)
!1856 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1857)
!1857 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1858)
!1858 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1859)
!1859 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1860)
!1860 = distinct !DILocation(line: 44, scope: !1712, inlinedAt: !1851)
!1861 = !DILocation(line: 146, scope: !477, inlinedAt: !1862)
!1862 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1859)
!1863 = !DILocation(line: 52, scope: !480, inlinedAt: !1864)
!1864 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1860)
!1865 = !DILocation(line: 93, scope: !474, inlinedAt: !1860)
!1866 = !DILocation(line: 521, scope: !1734, inlinedAt: !1852)
!1867 = !DILocation(line: 38, scope: !466, inlinedAt: !1868)
!1868 = distinct !DILocation(line: 0, scope: !468, inlinedAt: !1869)
!1869 = distinct !DILocation(line: 0, scope: !470, inlinedAt: !1870)
!1870 = distinct !DILocation(line: 11, scope: !472, inlinedAt: !1871)
!1871 = distinct !DILocation(line: 90, scope: !474, inlinedAt: !1872)
!1872 = distinct !DILocation(line: 44, scope: !1712, inlinedAt: !1851)
!1873 = !DILocation(line: 146, scope: !477, inlinedAt: !1874)
!1874 = distinct !DILocation(line: 146, scope: !477, inlinedAt: !1871)
!1875 = !DILocation(line: 52, scope: !480, inlinedAt: !1876)
!1876 = distinct !DILocation(line: 92, scope: !474, inlinedAt: !1872)
!1877 = !DILocation(line: 93, scope: !474, inlinedAt: !1872)
!1878 = !DILocation(line: 351, scope: !1611, inlinedAt: !1814)
!1879 = !DILocation(line: 121, scope: !1599)
!1880 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2888", scope: null, file: !146, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !76, retainedNodes: !137)
!1881 = !DILocation(line: 787, scope: !1880)
