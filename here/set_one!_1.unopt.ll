; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@exception.20 = private unnamed_addr constant [31 x i8] c"julia__throw_inexacterror_1716\00", align 1
@di_func.21 = private unnamed_addr constant [19 x i8] c"checked_trunc_sint\00", align 1
@di_func.23 = private unnamed_addr constant [8 x i8] c"toInt32\00", align 1
@di_func.25 = private unnamed_addr constant [6 x i8] c"Int32\00", align 1
@di_file.26 = private unnamed_addr constant [10 x i8] c"./boot.jl\00", align 1
@di_func.27 = private unnamed_addr constant [8 x i8] c"convert\00", align 1
@di_file.28 = private unnamed_addr constant [12 x i8] c"./number.jl\00", align 1
@di_func.29 = private unnamed_addr constant [14 x i8] c"unsafe_store!\00", align 1
@di_file.30 = private unnamed_addr constant [63 x i8] c"/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl\00", align 1
@di_func.38 = private unnamed_addr constant [11 x i8] c"#setindex!\00", align 1
@exception.42 = private unnamed_addr constant [30 x i8] c"julia__throw_boundserror_1680\00", align 1
@di_func.43 = private unnamed_addr constant [12 x i8] c"checkbounds\00", align 1
@di_file.44 = private unnamed_addr constant [19 x i8] c"./abstractarray.jl\00", align 1
@di_func.45 = private unnamed_addr constant [10 x i8] c"#getindex\00", align 1
@di_file.46 = private unnamed_addr constant [55 x i8] c"/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl\00", align 1
@di_func.47 = private unnamed_addr constant [9 x i8] c"set_one!\00", align 1
@di_file.48 = private unnamed_addr constant [45 x i8] c"/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl\00", align 1
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 10300, align 4
@_j_const1.1 = private unnamed_addr addrspace(1) constant i64 1
@0 = private unnamed_addr constant [61 x i8] c"ERROR: a %s was thrown during kernel execution.\0AStacktrace:\0A\00", align 1
@_j_const1.3 = private unnamed_addr addrspace(1) constant i64 1
@_j_const1.8 = private unnamed_addr addrspace(1) constant i64 1
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@1 = private unnamed_addr constant [42 x i8] c"Device-to-host string conversion failed.\0A\00", align 1
@2 = private unnamed_addr constant [19 x i8] c" [%i] %s at %s:%i\0A\00", align 1

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #1

; Function Attrs: readnone
declare [5 x i64] @julia.gpu.state_getter() local_unnamed_addr #2

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #3

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #4

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #5

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #6

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #5

;  @ boot.jl:652 within `checked_trunc_sint`
define internal fastcc i32 @julia_checked_trunc_sint_1713(i64 signext %0) unnamed_addr #7 !dbg !64 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
  %x = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %x, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %x, metadata !77, metadata !DIExpression()), !dbg !78
;  @ boot.jl:654 within `checked_trunc_sint`
  %4 = trunc i64 %0 to i32, !dbg !79
;  @ boot.jl:655 within `checked_trunc_sint`
  %5 = sext i32 %4 to i64, !dbg !80
;  @ boot.jl:656 within `checked_trunc_sint`
  %6 = icmp eq i64 %0, %5, !dbg !81
  %7 = zext i1 %6 to i8, !dbg !81
  %8 = trunc i8 %7 to i1, !dbg !81
  %9 = xor i1 %8, true, !dbg !81
  br i1 %9, label %L7, label %L5, !dbg !81

L5:                                               ; preds = %top
;  @ boot.jl:657 within `checked_trunc_sint`
  ret i32 %4, !dbg !82

L7:                                               ; preds = %top
;  @ boot.jl:656 within `checked_trunc_sint`
  call fastcc void @gpu_report_exception_name(i64 ptrtoint ([31 x i8]* @exception.20 to i64)), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 1, i64 ptrtoint ([19 x i8]* @di_func.21 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 656), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 2, i64 ptrtoint ([8 x i8]* @di_func.23 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 693), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 3, i64 ptrtoint ([6 x i8]* @di_func.25 to i64), i64 ptrtoint ([10 x i8]* @di_file.26 to i64), i32 783), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 4, i64 ptrtoint ([8 x i8]* @di_func.27 to i64), i64 ptrtoint ([12 x i8]* @di_file.28 to i64), i32 7), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 5, i64 ptrtoint ([14 x i8]* @di_func.29 to i64), i64 ptrtoint ([63 x i8]* @di_file.30 to i64), i32 88), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 6, i64 ptrtoint ([11 x i8]* @di_func.38 to i64), i64 ptrtoint ([55 x i8]* @di_file.46 to i64), i32 95), !dbg !81
  call fastcc void @gpu_report_exception_frame(i32 7, i64 ptrtoint ([9 x i8]* @di_func.47 to i64), i64 ptrtoint ([45 x i8]* @di_file.48 to i64), i32 368), !dbg !81
  call fastcc void @gpu_signal_exception(), !dbg !81
  call void @llvm.trap(), !dbg !81
  unreachable, !dbg !81
}

;  @ boot.jl:693 within `toInt32`
define internal fastcc i32 @julia_toInt32_1710(i64 signext %0) unnamed_addr #7 !dbg !83 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
  %x = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %x, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %x, metadata !89, metadata !DIExpression()), !dbg !90
  %4 = call fastcc i32 @julia_checked_trunc_sint_1713(i64 signext %0) #7, !dbg !90
  ret i32 %4, !dbg !90
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #4

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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !91
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !97
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
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !98
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !91
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %63, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !97
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %63

24:                                               ; preds = %3
  %25 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !99
  %26 = icmp sgt i32 %25, 8999
  br i1 %26, label %27, label %31

27:                                               ; preds = %24
  %28 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %29 = bitcast %1 addrspace(1)* %28 to i64 addrspace(1)* addrspace(1)*
  %30 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %29, align 8, !tbaa !100
  store atomic i64 %1, i64 addrspace(1)* %30 syncscope("one-as") release, align 8
  br label %63

31:                                               ; preds = %24
  %32 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 7, i32 0
  %33 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %32, align 16, !tbaa !100
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
  %43 = load volatile i64, i64 addrspace(1)* %42, align 16, !tbaa !101
  %44 = icmp ugt i64 %41, %43
  br i1 %44, label %45, label %62

45:                                               ; preds = %40
  store atomic i64 %41, i64 addrspace(1)* %42 syncscope("one-as") monotonic, align 16
  %46 = icmp slt i32 %25, 8000
  br i1 %46, label %47, label %56

47:                                               ; preds = %45
  %48 = trunc i64 %41 to i32
  %49 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 0, i32 4
  %50 = load i32, i32 addrspace(1)* %49, align 8, !tbaa !106
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
  %61 = load i32 addrspace(1)*, i32 addrspace(1)* addrspace(1)* %60, align 8, !tbaa !100
  store volatile i32 %58, i32 addrspace(1)* %61, align 4, !tbaa !99
  br label %62

62:                                               ; preds = %56, %40
  store atomic i32 0, i32 addrspace(1)* %34 syncscope("one-as") release, align 4
  br label %63

63:                                               ; preds = %62, %27, %17, %13
  ret void
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:78 within `report_exception_name`
define internal fastcc void @gpu_report_exception_name(i64 zeroext %0) unnamed_addr #7 !dbg !107 {
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
  %ex = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %ex, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %ex, metadata !115, metadata !DIExpression()), !dbg !116
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:79 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %23 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !117
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %24 = addrspacecast i8 addrspace(1)* %23 to i8 addrspace(1)**, !dbg !124
     %25 = bitcast i8 addrspace(1)** %24 to i8*, !dbg !124
     br label %check.i, !dbg !124

check.i:                                          ; preds = %check.i, %top
     %26 = phi i64 [ 0, %top ], [ %27, %check.i ], !dbg !124
     %27 = add i64 %26, 1, !dbg !124
     %28 = getelementptr i8, i8* %25, i64 %26, !dbg !124
     %29 = load i8, i8* %28, align 1, !dbg !124
     %30 = icmp eq i8 %29, 0, !dbg !124
     br i1 %30, label %julia_report_exception_name_2256u2258.exit, label %check.i, !dbg !124

julia_report_exception_name_2256u2258.exit:       ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ int.jl:1042 within `+` @ int.jl:87
    %31 = add i64 %26, 1, !dbg !133
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i2 = call [5 x i64] @julia.gpu.state_getter(), !dbg !138
       store [5 x i64] %state.i2, [5 x i64] addrspace(5)* %1, align 8, !dbg !138
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %32 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %1, i32 0, i32 3, !dbg !147
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %33 = load i64, i64 addrspace(5)* %32, align 8, !dbg !150, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %34 = inttoptr i64 %33 to { i64, i8 addrspace(1)*, i64 }*, !dbg !165
     %35 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %34, i64 0, !dbg !165
     %36 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2 to i8 addrspace(5)*, !dbg !165
     %37 = bitcast { i64, i8 addrspace(1)*, i64 }* %35 to i8*, !dbg !165
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %36, i8* %37, i64 24, i1 false), !dbg !165, !tbaa !168, !alias.scope !169, !noalias !170
     %38 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, align 8, !dbg !165
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %39 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !171, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %40 = add i32 %39, 1, !dbg !191
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %41 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !193, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %42 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !198, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %43 = zext i32 %40 to i64, !dbg !203
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %44 = icmp eq i64 %43, 1, !dbg !222
         %45 = zext i1 %44 to i8, !dbg !222
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %46 = trunc i8 %45 to i1, !dbg !223
          %47 = and i1 true, %46, !dbg !223
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %48 = xor i1 %47, true, !dbg !226
; │││││└└
       %49 = zext i1 %48 to i8, !dbg !181
       %50 = trunc i8 %49 to i1, !dbg !181
       %51 = xor i1 %50, true, !dbg !181
       br i1 %51, label %L23, label %L22, !dbg !181

L22:                                              ; preds = %julia_report_exception_name_2256u2258.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L45, !dbg !228

L23:                                              ; preds = %julia_report_exception_name_2256u2258.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ Base.jl:37 within `getproperty`
        %52 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !229
; │││││└
       br label %L25, !dbg !230

L25:                                              ; preds = %L41, %L23
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %53 = load i64, i64 addrspace(5)* %52, align 8, !dbg !231, !tbaa !153, !alias.scope !157, !noalias !160
         %54 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %53, i64 0, i64 1, i32 4), !dbg !231
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %55 = icmp eq i64 %54, 0, !dbg !236
         %56 = zext i1 %55 to i8, !dbg !236
; ││││││└
        %57 = trunc i8 %56 to i1, !dbg !237
        %58 = xor i1 %57, true, !dbg !237
        br i1 %58, label %L29, label %L28, !dbg !237

L28:                                              ; preds = %L25
        br label %L43, !dbg !237

L29:                                              ; preds = %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %59 = icmp eq i64 %54, 5, !dbg !238
         %60 = zext i1 %59 to i8, !dbg !238
; ││││││└
        %61 = trunc i8 %60 to i1, !dbg !239
        %62 = xor i1 %61, true, !dbg !239
        br i1 %62, label %L33, label %L32, !dbg !239

L32:                                              ; preds = %L29
        br label %L36, !dbg !239

L33:                                              ; preds = %L29
; ││││││┌ @ promotion.jl:499 within `==`
         %63 = icmp eq i64 %54, 6, !dbg !238
         %64 = zext i1 %63 to i8, !dbg !238
; ││││││└
        %65 = trunc i8 %64 to i1, !dbg !239
        %66 = xor i1 %65, true, !dbg !239
        br i1 %66, label %L41, label %L36, !dbg !239

L36:                                              ; preds = %L33, %L32
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i6 = call [5 x i64] @julia.gpu.state_getter(), !dbg !240
            store [5 x i64] %state.i6, [5 x i64] addrspace(5)* %19, align 8, !dbg !240
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %67 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %19, i32 0, i32 0, !dbg !248
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %68 = load i64, i64 addrspace(5)* %67, align 8, !dbg !249, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %69 = inttoptr i64 %68 to i64*, !dbg !250
          %70 = getelementptr inbounds i64, i64* %69, i64 0, !dbg !250
          %71 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !250, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %71, i64* %70, align 1, !dbg !250, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L41, !dbg !250

L41:                                              ; preds = %L36, %L33
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !261
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !264

L43:                                              ; preds = %L28
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L44, !dbg !235

L44:                                              ; preds = %L43
        br label %L45, !dbg !235

L45:                                              ; preds = %L44, %L22
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !265
; │││││└
; │││││ @ none within `macro expansion`
       br label %L47, !dbg !183

L47:                                              ; preds = %L45
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %72 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !269, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %73 = add i32 %72, 1, !dbg !279
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %74 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !281, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %75 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !285, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %76 = zext i32 %73 to i64, !dbg !289
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %77 = icmp eq i64 %76, 1, !dbg !297
         %78 = zext i1 %77 to i8, !dbg !297
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %79 = trunc i8 %78 to i1, !dbg !298
          %80 = and i1 true, %79, !dbg !298
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %81 = xor i1 %80, true, !dbg !299
; │││││└└
       %82 = zext i1 %81 to i8, !dbg !274
       %83 = trunc i8 %82 to i1, !dbg !274
       %84 = xor i1 %83, true, !dbg !274
       br i1 %84, label %L60, label %L59, !dbg !274

L59:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L70, !dbg !300

L60:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ Base.jl:37 within `getproperty`
        %85 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 1, !dbg !301
; │││││└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %86 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %85, align 8, !dbg !303, !tbaa !153, !alias.scope !157, !noalias !160
          %87 = ptrtoint i8 addrspace(1)* %86 to i64, !dbg !303
; ││││││└└
        %88 = addrspacecast i8 addrspace(1)* %86 to i8*, !dbg !307
        %89 = getelementptr i8, i8* %88, i64 1, !dbg !307
        %90 = ptrtoint i8* %89 to i64, !dbg !307
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %91 = addrspacecast i8* %89 to i8 addrspace(1)*, !dbg !309
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %92 = ptrtoint i8 addrspace(1)* %91 to i64, !dbg !314
; ││││││└└
        %93 = addrspacecast i8 addrspace(1)* %91 to i8*, !dbg !316
        %94 = getelementptr i8, i8* %93, i64 -1, !dbg !316
        %95 = ptrtoint i8* %94 to i64, !dbg !316
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %96 = addrspacecast i8* %94 to i8 addrspace(1)*, !dbg !318
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %97 = bitcast i8 addrspace(1)* %96 to i64 addrspace(1)*, !dbg !321
          store i64 %31, i64 addrspace(1)* %97, align 1, !dbg !321, !tbaa !330
          br label %L70, !dbg !321

L70:                                              ; preds = %L60, %L59
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !333
; │││││└
; │││││ @ none within `macro expansion`
       br label %L72, !dbg !275

L72:                                              ; preds = %L70
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L73, !dbg !335

L73:                                              ; preds = %L72
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:169
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52 within `alloc_local` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          br label %L75, !dbg !340

L75:                                              ; preds = %L73
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %98 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !350, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %99 = add i32 %98, 1, !dbg !356
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %100 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !358, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %101 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !362, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %102 = zext i32 %99 to i64, !dbg !366
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %103 = icmp eq i64 %102, 1, !dbg !374
         %104 = zext i1 %103 to i8, !dbg !374
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %105 = trunc i8 %104 to i1, !dbg !375
          %106 = and i1 true, %105, !dbg !375
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %107 = xor i1 %106, true, !dbg !376
; │││││└└
       %108 = zext i1 %107 to i8, !dbg !355
       %109 = trunc i8 %108 to i1, !dbg !355
       %110 = xor i1 %109, true, !dbg !355
       br i1 %110, label %L89, label %L88, !dbg !355

L88:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L152, !dbg !377

L89:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ Base.jl:37 within `getproperty`
        %111 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !378
        br label %L90, !dbg !378

L90:                                              ; preds = %L106, %L89
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %112 = load i64, i64 addrspace(5)* %111, align 8, !dbg !380, !tbaa !153, !alias.scope !157, !noalias !160
         %113 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %112, i64 1, i64 2, i32 4), !dbg !380
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %114 = icmp eq i64 %113, 1, !dbg !383
         %115 = zext i1 %114 to i8, !dbg !383
; ││││││└
        %116 = trunc i8 %115 to i1, !dbg !384
        %117 = xor i1 %116, true, !dbg !384
        br i1 %117, label %L94, label %L93, !dbg !384

L93:                                              ; preds = %L90
        br label %L108, !dbg !384

L94:                                              ; preds = %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %118 = icmp eq i64 %113, 5, !dbg !385
         %119 = zext i1 %118 to i8, !dbg !385
; ││││││└
        %120 = trunc i8 %119 to i1, !dbg !386
        %121 = xor i1 %120, true, !dbg !386
        br i1 %121, label %L98, label %L97, !dbg !386

L97:                                              ; preds = %L94
        br label %L101, !dbg !386

L98:                                              ; preds = %L94
; ││││││┌ @ promotion.jl:499 within `==`
         %122 = icmp eq i64 %113, 6, !dbg !385
         %123 = zext i1 %122 to i8, !dbg !385
; ││││││└
        %124 = trunc i8 %123 to i1, !dbg !386
        %125 = xor i1 %124, true, !dbg !386
        br i1 %125, label %L106, label %L101, !dbg !386

L101:                                             ; preds = %L98, %L97
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i14 = call [5 x i64] @julia.gpu.state_getter(), !dbg !387
            store [5 x i64] %state.i14, [5 x i64] addrspace(5)* %18, align 8, !dbg !387
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %126 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %18, i32 0, i32 0, !dbg !393
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %127 = load i64, i64 addrspace(5)* %126, align 8, !dbg !394, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %128 = inttoptr i64 %127 to i64*, !dbg !395
          %129 = getelementptr inbounds i64, i64* %128, i64 0, !dbg !395
          %130 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !395, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %130, i64* %129, align 1, !dbg !395, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L106, !dbg !395

L106:                                             ; preds = %L101, %L98
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !398
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !400

L108:                                             ; preds = %L93
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L109, !dbg !382

L109:                                             ; preds = %L108
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ Base.jl:37 within `getproperty`
        %131 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !401
        br label %L110, !dbg !401

L110:                                             ; preds = %L126, %L109
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %132 = load i64, i64 addrspace(5)* %131, align 8, !dbg !403, !tbaa !153, !alias.scope !157, !noalias !160
         %133 = call fastcc i64 @__ockl_hsa_signal_load(i64 %132, i32 2), !dbg !403
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││││┌ @ promotion.jl:499 within `==`
         %134 = icmp eq i64 %133, 4, !dbg !408
         %135 = zext i1 %134 to i8, !dbg !408
; ││││││└
        %136 = trunc i8 %135 to i1, !dbg !409
        %137 = xor i1 %136, true, !dbg !409
        br i1 %137, label %L114, label %L113, !dbg !409

L113:                                             ; preds = %L110
        br label %L128, !dbg !409

L114:                                             ; preds = %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││││┌ @ promotion.jl:499 within `==`
         %138 = icmp eq i64 %133, 5, !dbg !410
         %139 = zext i1 %138 to i8, !dbg !410
; ││││││└
        %140 = trunc i8 %139 to i1, !dbg !411
        %141 = xor i1 %140, true, !dbg !411
        br i1 %141, label %L118, label %L117, !dbg !411

L117:                                             ; preds = %L114
        br label %L121, !dbg !411

L118:                                             ; preds = %L114
; ││││││┌ @ promotion.jl:499 within `==`
         %142 = icmp eq i64 %133, 6, !dbg !410
         %143 = zext i1 %142 to i8, !dbg !410
; ││││││└
        %144 = trunc i8 %143 to i1, !dbg !411
        %145 = xor i1 %144, true, !dbg !411
        br i1 %145, label %L126, label %L121, !dbg !411

L121:                                             ; preds = %L118, %L117
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i15 = call [5 x i64] @julia.gpu.state_getter(), !dbg !412
            store [5 x i64] %state.i15, [5 x i64] addrspace(5)* %17, align 8, !dbg !412
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %146 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %17, i32 0, i32 0, !dbg !418
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %147 = load i64, i64 addrspace(5)* %146, align 8, !dbg !419, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %148 = inttoptr i64 %147 to i64*, !dbg !420
          %149 = getelementptr inbounds i64, i64* %148, i64 0, !dbg !420
          %150 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !420, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %150, i64* %149, align 1, !dbg !420, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L126, !dbg !420

L126:                                             ; preds = %L121, %L118
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !423
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !425

L128:                                             ; preds = %L113
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
        br label %L129, !dbg !407

L129:                                             ; preds = %L128
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:178
       br label %L130, !dbg !426

L130:                                             ; preds = %L129
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:179
; │││││┌ @ Base.jl:37 within `getproperty`
        %151 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 1, !dbg !427
; │││││└
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %152 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %151, align 8, !dbg !429, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %153 = bitcast i8 addrspace(1)* %152 to i8 addrspace(1)* addrspace(1)*, !dbg !430
          %154 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %153, align 1, !dbg !430, !tbaa !330
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %155 = ptrtoint i8 addrspace(1)* %154 to i64, !dbg !439
; │││││└└
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %156 = icmp eq i64 %155, 0, !dbg !442
        %157 = zext i1 %156 to i8, !dbg !442
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %158 = trunc i8 %157 to i1, !dbg !444
         %159 = and i1 true, %158, !dbg !444
; │││││└└
       %160 = zext i1 %159 to i8, !dbg !441
       %161 = trunc i8 %160 to i1, !dbg !441
       %162 = xor i1 %161, true, !dbg !441
       br i1 %162, label %L146, label %L138, !dbg !441

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ Base.jl:37 within `getproperty`
        %163 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !445
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %164 = load i64, i64 addrspace(5)* %163, align 8, !dbg !447, !tbaa !153, !alias.scope !157, !noalias !160
        %165 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %164, i64 5, i32 3), !dbg !447
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i13 = call [5 x i64] @julia.gpu.state_getter(), !dbg !450
           store [5 x i64] %state.i13, [5 x i64] addrspace(5)* %16, align 8, !dbg !450
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %166 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %16, i32 0, i32 0, !dbg !456
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %167 = load i64, i64 addrspace(5)* %166, align 8, !dbg !457, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %168 = inttoptr i64 %167 to i64*, !dbg !458
         %169 = getelementptr inbounds i64, i64* %168, i64 0, !dbg !458
         %170 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !458, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %170, i64* %169, align 1, !dbg !458, !tbaa !260, !alias.scope !258, !noalias !259
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !461
        unreachable, !dbg !461

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %171 = bitcast i8 addrspace(1)* %154 to i64 addrspace(1)*, !dbg !465
          %172 = load i64, i64 addrspace(1)* %171, align 1, !dbg !465, !tbaa !330
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %173 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !472
          store i64 %172, i64 addrspace(3)* %173, align 1, !dbg !472, !tbaa !478
          br label %L150, !dbg !472

L150:                                             ; preds = %L146
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ Base.jl:37 within `getproperty`
        %174 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !480
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %175 = load i64, i64 addrspace(5)* %174, align 8, !dbg !482, !tbaa !153, !alias.scope !157, !noalias !160
        %176 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %175, i64 0, i32 3), !dbg !482
        br label %L152, !dbg !482

L152:                                             ; preds = %L150, %L88
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !484
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %177 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !486
          %178 = load i64, i64 addrspace(3)* %177, align 1, !dbg !486, !tbaa !478
; │││││└└└
       br label %L156, !dbg !492

L156:                                             ; preds = %L152
; │││└└
     br label %L157, !dbg !339

L157:                                             ; preds = %L156
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
     br label %L158, !dbg !188

L158:                                             ; preds = %L157
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:6 within `malloc`
    br label %L160, !dbg !493

L160:                                             ; preds = %L158
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %179 = inttoptr i64 %178 to i8 addrspace(1)*, !dbg !494
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %180 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !495
; │└
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %181 = icmp eq i64 %180, 0, !dbg !497
    %182 = zext i1 %181 to i8, !dbg !497
; ││ @ int.jl:492 within `==`
; ││┌ @ bool.jl:38 within `&`
     %183 = trunc i8 %182 to i1, !dbg !499
     %184 = and i1 true, %183, !dbg !499
; │└└
   %185 = zext i1 %184 to i8, !dbg !496
   %186 = trunc i8 %185 to i1, !dbg !496
   %187 = xor i1 %186, true, !dbg !496
   br i1 %187, label %L222, label %L165, !dbg !496

L165:                                             ; preds = %L160
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i12 = call [5 x i64] @julia.gpu.state_getter(), !dbg !500
       store [5 x i64] %state.i12, [5 x i64] addrspace(5)* %3, align 8, !dbg !500
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %188 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !509
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %189 = load i64, i64 addrspace(5)* %188, align 8, !dbg !510, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %190 = inttoptr i64 %189 to { i64, i8 addrspace(1)*, i64 }*, !dbg !511
     %191 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %190, i64 0, !dbg !511
     %192 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to i8 addrspace(5)*, !dbg !511
     %193 = bitcast { i64, i8 addrspace(1)*, i64 }* %191 to i8*, !dbg !511
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %192, i8* %193, i64 24, i1 false), !dbg !511, !tbaa !168, !alias.scope !169, !noalias !170
     %194 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, align 8, !dbg !511
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %195 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !514, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %196 = add i32 %195, 1, !dbg !524
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %197 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !526, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %198 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !530, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %199 = zext i32 %196 to i64, !dbg !534
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %200 = icmp eq i64 %199, 1, !dbg !542
        %201 = zext i1 %200 to i8, !dbg !542
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %202 = trunc i8 %201 to i1, !dbg !543
         %203 = and i1 true, %202, !dbg !543
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %204 = xor i1 %203, true, !dbg !544
; ││││└└
      %205 = zext i1 %204 to i8, !dbg !519
      %206 = trunc i8 %205 to i1, !dbg !519
      %207 = xor i1 %206, true, !dbg !519
      br i1 %207, label %L183, label %L182, !dbg !519

L182:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L205, !dbg !545

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %208 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 0, !dbg !546
; ││││└
      br label %L185, !dbg !547

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %209 = load i64, i64 addrspace(5)* %208, align 8, !dbg !548, !tbaa !153, !alias.scope !157, !noalias !160
        %210 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %209, i64 0, i64 1, i32 4), !dbg !548
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %211 = icmp eq i64 %210, 0, !dbg !551
        %212 = zext i1 %211 to i8, !dbg !551
; │││││└
       %213 = trunc i8 %212 to i1, !dbg !552
       %214 = xor i1 %213, true, !dbg !552
       br i1 %214, label %L189, label %L188, !dbg !552

L188:                                             ; preds = %L185
       br label %L203, !dbg !552

L189:                                             ; preds = %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %215 = icmp eq i64 %210, 5, !dbg !553
        %216 = zext i1 %215 to i8, !dbg !553
; │││││└
       %217 = trunc i8 %216 to i1, !dbg !554
       %218 = xor i1 %217, true, !dbg !554
       br i1 %218, label %L193, label %L192, !dbg !554

L192:                                             ; preds = %L189
       br label %L196, !dbg !554

L193:                                             ; preds = %L189
; │││││┌ @ promotion.jl:499 within `==`
        %219 = icmp eq i64 %210, 6, !dbg !553
        %220 = zext i1 %219 to i8, !dbg !553
; │││││└
       %221 = trunc i8 %220 to i1, !dbg !554
       %222 = xor i1 %221, true, !dbg !554
       br i1 %222, label %L201, label %L196, !dbg !554

L196:                                             ; preds = %L193, %L192
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i11 = call [5 x i64] @julia.gpu.state_getter(), !dbg !555
           store [5 x i64] %state.i11, [5 x i64] addrspace(5)* %15, align 8, !dbg !555
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %223 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %15, i32 0, i32 0, !dbg !561
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %224 = load i64, i64 addrspace(5)* %223, align 8, !dbg !562, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %225 = inttoptr i64 %224 to i64*, !dbg !563
         %226 = getelementptr inbounds i64, i64* %225, i64 0, !dbg !563
         %227 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !563, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %227, i64* %226, align 1, !dbg !563, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L201, !dbg !563

L201:                                             ; preds = %L196, %L193
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !566
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !568

L203:                                             ; preds = %L188
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L204, !dbg !550

L204:                                             ; preds = %L203
       br label %L205, !dbg !550

L205:                                             ; preds = %L204, %L182
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !569
; ││││└
; ││││ @ none within `macro expansion`
      br label %L207, !dbg !520

L207:                                             ; preds = %L205
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
     br label %L208, !dbg !522

L208:                                             ; preds = %L207
; ││└
; ││┌ @ Base.jl:37 within `getproperty`
     %228 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !571
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %229 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %228, align 8, !dbg !572, !tbaa !153, !alias.scope !157, !noalias !160
       %230 = ptrtoint i8 addrspace(1)* %229 to i64, !dbg !572
; │││└└
     %231 = addrspacecast i8 addrspace(1)* %229 to i8*, !dbg !574
     %232 = getelementptr i8, i8* %231, i64 0, !dbg !574
     %233 = ptrtoint i8* %232 to i64, !dbg !574
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %234 = addrspacecast i8* %232 to i8 addrspace(1)*, !dbg !575
; ││└└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %234, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !578
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %235 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !571
; ││└
; ││┌ @ essentials.jl:513 within `reinterpret`
     %236 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %235, align 8, !dbg !582, !tbaa !153, !alias.scope !157, !noalias !160
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %237 = getelementptr inbounds i8, i8 addrspace(1)* %236, i64 41, !dbg !583
       store i8 0, i8 addrspace(1)* %237, align 1, !dbg !583, !tbaa !330
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %238 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %4 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !588
     call fastcc void @julia_hostcall_device_trigger_and_return__2324({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %238) #7, !dbg !588
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !335

L222:                                             ; preds = %L160
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %179, i8 addrspace(1)* %23, i64 %26, i1 false), !dbg !590
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %239 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !594
; ││└└
    %240 = addrspacecast i8 addrspace(1)* %179 to i8*, !dbg !596
    %241 = getelementptr i8, i8* %240, i64 %26, !dbg !596
    %242 = ptrtoint i8* %241 to i64, !dbg !596
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %243 = addrspacecast i8* %241 to i8 addrspace(1)*, !dbg !598
; │└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %243, align 1, !dbg !601, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:60 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %244 = ptrtoint i8 addrspace(1)* %179 to i64, !dbg !607
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !335

L231:                                             ; preds = %L222, %L208
       %value_phi1 = phi i64 [ 0, %L208 ], [ %244, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:80 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:187 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i10 = call [5 x i64] @julia.gpu.state_getter(), !dbg !609
      store [5 x i64] %state.i10, [5 x i64] addrspace(5)* %5, align 8, !dbg !609
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %245 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %5, i32 0, i32 2, !dbg !616
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %246 = load i64, i64 addrspace(5)* %245, align 8, !dbg !617, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %247 = inttoptr i64 %246 to { i64, i8 addrspace(1)*, i64 }*, !dbg !618
    %248 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %247, i64 0, !dbg !618
    %249 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6 to i8 addrspace(5)*, !dbg !618
    %250 = bitcast { i64, i8 addrspace(1)*, i64 }* %248 to i8*, !dbg !618
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %249, i8* %250, i64 24, i1 false), !dbg !618, !tbaa !168, !alias.scope !169, !noalias !170
    %251 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, align 8, !dbg !618
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:188 within `macro expansion`
; │┌ @ Base.jl:37 within `getproperty`
    %252 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 1, !dbg !620
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %253 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %252, align 8, !dbg !622, !tbaa !153, !alias.scope !157, !noalias !160
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:193 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %254 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !623, !range !190
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %255 = add i32 %254, 1, !dbg !633
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %256 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !635, !range !190
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %257 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !639, !range !190
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %258 = zext i32 %255 to i64, !dbg !643
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %259 = icmp eq i64 %258, 1, !dbg !651
       %260 = zext i1 %259 to i8, !dbg !651
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %261 = trunc i8 %260 to i1, !dbg !652
        %262 = and i1 true, %261, !dbg !652
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %263 = xor i1 %262, true, !dbg !653
; │││└└
     %264 = zext i1 %263 to i8, !dbg !628
     %265 = trunc i8 %264 to i1, !dbg !628
     %266 = xor i1 %265, true, !dbg !628
     br i1 %266, label %L254, label %L253, !dbg !628

L253:                                             ; preds = %L231
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L276, !dbg !654

L254:                                             ; preds = %L231
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ Base.jl:37 within `getproperty`
      %267 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !655
; │││└
     br label %L256, !dbg !656

L256:                                             ; preds = %L272, %L254
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %268 = load i64, i64 addrspace(5)* %267, align 8, !dbg !657, !tbaa !153, !alias.scope !157, !noalias !160
       %269 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %268, i64 0, i64 1, i32 4), !dbg !657
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %270 = icmp eq i64 %269, 0, !dbg !660
       %271 = zext i1 %270 to i8, !dbg !660
; ││││└
      %272 = trunc i8 %271 to i1, !dbg !661
      %273 = xor i1 %272, true, !dbg !661
      br i1 %273, label %L260, label %L259, !dbg !661

L259:                                             ; preds = %L256
      br label %L274, !dbg !661

L260:                                             ; preds = %L256
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %274 = icmp eq i64 %269, 5, !dbg !662
       %275 = zext i1 %274 to i8, !dbg !662
; ││││└
      %276 = trunc i8 %275 to i1, !dbg !663
      %277 = xor i1 %276, true, !dbg !663
      br i1 %277, label %L264, label %L263, !dbg !663

L263:                                             ; preds = %L260
      br label %L267, !dbg !663

L264:                                             ; preds = %L260
; ││││┌ @ promotion.jl:499 within `==`
       %278 = icmp eq i64 %269, 6, !dbg !662
       %279 = zext i1 %278 to i8, !dbg !662
; ││││└
      %280 = trunc i8 %279 to i1, !dbg !663
      %281 = xor i1 %280, true, !dbg !663
      br i1 %281, label %L272, label %L267, !dbg !663

L267:                                             ; preds = %L264, %L263
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i9 = call [5 x i64] @julia.gpu.state_getter(), !dbg !664
          store [5 x i64] %state.i9, [5 x i64] addrspace(5)* %14, align 8, !dbg !664
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %282 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %14, i32 0, i32 0, !dbg !670
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %283 = load i64, i64 addrspace(5)* %282, align 8, !dbg !671, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %284 = inttoptr i64 %283 to i64*, !dbg !672
        %285 = getelementptr inbounds i64, i64* %284, i64 0, !dbg !672
        %286 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !672, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %286, i64* %285, align 1, !dbg !672, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L272, !dbg !672

L272:                                             ; preds = %L267, %L264
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !675
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L256, !dbg !677

L274:                                             ; preds = %L259
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L275, !dbg !659

L275:                                             ; preds = %L274
      br label %L276, !dbg !659

L276:                                             ; preds = %L275, %L253
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !678
; │││└
; │││ @ none within `macro expansion`
     br label %L278, !dbg !629

L278:                                             ; preds = %L276
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
    br label %L279, !dbg !631

L279:                                             ; preds = %L278
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %287 = bitcast i8 addrspace(1)* %253 to i64 addrspace(1)*, !dbg !680
      store i64 1, i64 addrspace(1)* %287, align 1, !dbg !680, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:196 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %288 = ptrtoint i8 addrspace(1)* %253 to i64, !dbg !687
; ││└└
    %289 = addrspacecast i8 addrspace(1)* %253 to i8*, !dbg !689
    %290 = getelementptr i8, i8* %289, i64 8, !dbg !689
    %291 = ptrtoint i8* %290 to i64, !dbg !689
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %292 = addrspacecast i8* %290 to i8 addrspace(1)*, !dbg !691
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:153 within `_rocprintf_fmt`
; ││┌ @ essentials.jl:513 within `reinterpret`
     %293 = ptrtoint i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([61 x i8], [61 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*) to i64, !dbg !694
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %294 = bitcast i8 addrspace(1)* %292 to i64 addrspace(1)*, !dbg !698
       store i64 %293, i64 addrspace(1)* %294, align 1, !dbg !698, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %295 = ptrtoint i8 addrspace(1)* %292 to i64, !dbg !704
; │││└└
     %296 = addrspacecast i8 addrspace(1)* %292 to i8*, !dbg !706
     %297 = getelementptr i8, i8* %296, i64 8, !dbg !706
     %298 = ptrtoint i8* %297 to i64, !dbg !706
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %299 = addrspacecast i8* %297 to i8 addrspace(1)*, !dbg !708
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %300 = bitcast i8 addrspace(1)* %299 to i64 addrspace(1)*, !dbg !711
       store i64 60, i64 addrspace(1)* %300, align 1, !dbg !711, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %301 = ptrtoint i8 addrspace(1)* %299 to i64, !dbg !718
; │││└└
     %302 = addrspacecast i8 addrspace(1)* %299 to i8*, !dbg !720
     %303 = getelementptr i8, i8* %302, i64 8, !dbg !720
     %304 = ptrtoint i8* %303 to i64, !dbg !720
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %305 = addrspacecast i8* %303 to i8 addrspace(1)*, !dbg !722
; │└└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %306 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !725, !range !190
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %307 = add i32 %306, 1, !dbg !732
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %308 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !734, !range !190
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %309 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !738, !range !190
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %310 = zext i32 %307 to i64, !dbg !742
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %311 = icmp eq i64 %310, 1, !dbg !750
     %312 = zext i1 %311 to i8, !dbg !750
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %313 = trunc i8 %312 to i1, !dbg !751
      %314 = and i1 true, %313, !dbg !751
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %315 = xor i1 %314, true, !dbg !752
; │└└
   %316 = zext i1 %315 to i8, !dbg !730
   %317 = trunc i8 %316 to i1, !dbg !730
   %318 = xor i1 %317, true, !dbg !730
   br i1 %318, label %L308, label %L307, !dbg !730

L307:                                             ; preds = %L279
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L321, !dbg !753

L308:                                             ; preds = %L279
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %319 = bitcast i8 addrspace(1)* %305 to i64 addrspace(1)*, !dbg !754
       store i64 140431490556000, i64 addrspace(1)* %319, align 1, !dbg !754, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %320 = ptrtoint i8 addrspace(1)* %305 to i64, !dbg !763
; │││└└
     %321 = addrspacecast i8 addrspace(1)* %305 to i8*, !dbg !765
     %322 = getelementptr i8, i8* %321, i64 8, !dbg !765
     %323 = ptrtoint i8* %322 to i64, !dbg !765
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %324 = addrspacecast i8* %322 to i8 addrspace(1)*, !dbg !767
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %325 = bitcast i8 addrspace(1)* %324 to i64 addrspace(1)*, !dbg !770
       store i64 %value_phi1, i64 addrspace(1)* %325, align 1, !dbg !770, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %326 = ptrtoint i8 addrspace(1)* %324 to i64, !dbg !777
; │││└└
     %327 = addrspacecast i8 addrspace(1)* %324 to i8*, !dbg !779
     %328 = getelementptr i8, i8* %327, i64 8, !dbg !779
     %329 = ptrtoint i8* %328 to i64, !dbg !779
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %330 = addrspacecast i8* %328 to i8 addrspace(1)*, !dbg !781
; │└└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %331 = bitcast i8 addrspace(1)* %330 to i64 addrspace(1)*, !dbg !784
      store i64 0, i64 addrspace(1)* %331, align 1, !dbg !784, !tbaa !330
      br label %L321, !dbg !784

L321:                                             ; preds = %L308, %L307
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !790
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %332 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !792, !range !190
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %333 = add i32 %332, 1, !dbg !801
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %334 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !803, !range !190
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %335 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !807, !range !190
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %336 = zext i32 %333 to i64, !dbg !811
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %337 = icmp eq i64 %336, 1, !dbg !819
       %338 = zext i1 %337 to i8, !dbg !819
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %339 = trunc i8 %338 to i1, !dbg !820
        %340 = and i1 true, %339, !dbg !820
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %341 = xor i1 %340, true, !dbg !821
; │││└└
     %342 = zext i1 %341 to i8, !dbg !797
     %343 = trunc i8 %342 to i1, !dbg !797
     %344 = xor i1 %343, true, !dbg !797
     br i1 %344, label %L335, label %L334, !dbg !797

L334:                                             ; preds = %L321
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L377, !dbg !822

L335:                                             ; preds = %L321
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ Base.jl:37 within `getproperty`
      %345 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !823
      br label %L336, !dbg !823

L336:                                             ; preds = %L352, %L335
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %346 = load i64, i64 addrspace(5)* %345, align 8, !dbg !825, !tbaa !153, !alias.scope !157, !noalias !160
       %347 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %346, i64 1, i64 2, i32 4), !dbg !825
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %348 = icmp eq i64 %347, 1, !dbg !828
       %349 = zext i1 %348 to i8, !dbg !828
; ││││└
      %350 = trunc i8 %349 to i1, !dbg !829
      %351 = xor i1 %350, true, !dbg !829
      br i1 %351, label %L340, label %L339, !dbg !829

L339:                                             ; preds = %L336
      br label %L354, !dbg !829

L340:                                             ; preds = %L336
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %352 = icmp eq i64 %347, 5, !dbg !830
       %353 = zext i1 %352 to i8, !dbg !830
; ││││└
      %354 = trunc i8 %353 to i1, !dbg !831
      %355 = xor i1 %354, true, !dbg !831
      br i1 %355, label %L344, label %L343, !dbg !831

L343:                                             ; preds = %L340
      br label %L347, !dbg !831

L344:                                             ; preds = %L340
; ││││┌ @ promotion.jl:499 within `==`
       %356 = icmp eq i64 %347, 6, !dbg !830
       %357 = zext i1 %356 to i8, !dbg !830
; ││││└
      %358 = trunc i8 %357 to i1, !dbg !831
      %359 = xor i1 %358, true, !dbg !831
      br i1 %359, label %L352, label %L347, !dbg !831

L347:                                             ; preds = %L344, %L343
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i8 = call [5 x i64] @julia.gpu.state_getter(), !dbg !832
          store [5 x i64] %state.i8, [5 x i64] addrspace(5)* %13, align 8, !dbg !832
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %360 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %13, i32 0, i32 0, !dbg !838
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %361 = load i64, i64 addrspace(5)* %360, align 8, !dbg !839, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %362 = inttoptr i64 %361 to i64*, !dbg !840
        %363 = getelementptr inbounds i64, i64* %362, i64 0, !dbg !840
        %364 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !840, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %364, i64* %363, align 1, !dbg !840, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L352, !dbg !840

L352:                                             ; preds = %L347, %L344
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !843
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L336, !dbg !845

L354:                                             ; preds = %L339
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L355, !dbg !827

L355:                                             ; preds = %L354
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ Base.jl:37 within `getproperty`
      %365 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !846
      br label %L356, !dbg !846

L356:                                             ; preds = %L372, %L355
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %366 = load i64, i64 addrspace(5)* %365, align 8, !dbg !848, !tbaa !153, !alias.scope !157, !noalias !160
       %367 = call fastcc i64 @__ockl_hsa_signal_load(i64 %366, i32 2), !dbg !848
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:499 within `==`
       %368 = icmp eq i64 %367, 4, !dbg !851
       %369 = zext i1 %368 to i8, !dbg !851
; ││││└
      %370 = trunc i8 %369 to i1, !dbg !852
      %371 = xor i1 %370, true, !dbg !852
      br i1 %371, label %L360, label %L359, !dbg !852

L359:                                             ; preds = %L356
      br label %L374, !dbg !852

L360:                                             ; preds = %L356
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││┌ @ promotion.jl:499 within `==`
       %372 = icmp eq i64 %367, 5, !dbg !853
       %373 = zext i1 %372 to i8, !dbg !853
; ││││└
      %374 = trunc i8 %373 to i1, !dbg !854
      %375 = xor i1 %374, true, !dbg !854
      br i1 %375, label %L364, label %L363, !dbg !854

L363:                                             ; preds = %L360
      br label %L367, !dbg !854

L364:                                             ; preds = %L360
; ││││┌ @ promotion.jl:499 within `==`
       %376 = icmp eq i64 %367, 6, !dbg !853
       %377 = zext i1 %376 to i8, !dbg !853
; ││││└
      %378 = trunc i8 %377 to i1, !dbg !854
      %379 = xor i1 %378, true, !dbg !854
      br i1 %379, label %L372, label %L367, !dbg !854

L367:                                             ; preds = %L364, %L363
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i7 = call [5 x i64] @julia.gpu.state_getter(), !dbg !855
          store [5 x i64] %state.i7, [5 x i64] addrspace(5)* %12, align 8, !dbg !855
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %380 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %12, i32 0, i32 0, !dbg !861
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %381 = load i64, i64 addrspace(5)* %380, align 8, !dbg !862, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %382 = inttoptr i64 %381 to i64*, !dbg !863
        %383 = getelementptr inbounds i64, i64* %382, i64 0, !dbg !863
        %384 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !863, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %384, i64* %383, align 1, !dbg !863, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L372, !dbg !863

L372:                                             ; preds = %L367, %L364
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !866
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L356, !dbg !868

L374:                                             ; preds = %L359
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
      br label %L375, !dbg !850

L375:                                             ; preds = %L374
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ Base.jl:37 within `getproperty`
      %385 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %6, i32 0, i32 0, !dbg !869
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %386 = load i64, i64 addrspace(5)* %385, align 8, !dbg !871, !tbaa !153, !alias.scope !157, !noalias !160
      %387 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %386, i64 0, i32 3), !dbg !871
      br label %L377, !dbg !871

L377:                                             ; preds = %L375, %L334
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !873
; │││└
; │││ @ none within `macro expansion`
     br label %L379, !dbg !798

L379:                                             ; preds = %L377
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
    br label %L380, !dbg !800

L380:                                             ; preds = %L379
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:84 within `report_exception_name`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i5 = call [5 x i64] @julia.gpu.state_getter(), !dbg !875
      store [5 x i64] %state.i5, [5 x i64] addrspace(5)* %7, align 8, !dbg !875
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %388 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %7, i32 0, i32 4, !dbg !883
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %389 = load i64, i64 addrspace(5)* %388, align 8, !dbg !884, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %390 = inttoptr i64 %389 to { i64, i8 addrspace(1)*, i64 }*, !dbg !885
    %391 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %390, i64 0, !dbg !885
    %392 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8 to i8 addrspace(5)*, !dbg !885
    %393 = bitcast { i64, i8 addrspace(1)*, i64 }* %391 to i8*, !dbg !885
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %392, i8* %393, i64 24, i1 false), !dbg !885, !tbaa !168, !alias.scope !169, !noalias !170
    %394 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, align 8, !dbg !885
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %395 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !887, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %396 = add i32 %395, 1, !dbg !898
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %397 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !900, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %398 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !904, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %399 = zext i32 %396 to i64, !dbg !908
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %400 = icmp eq i64 %399, 1, !dbg !916
        %401 = zext i1 %400 to i8, !dbg !916
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %402 = trunc i8 %401 to i1, !dbg !917
         %403 = and i1 true, %402, !dbg !917
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %404 = xor i1 %403, true, !dbg !918
; ││││└└
      %405 = zext i1 %404 to i8, !dbg !892
      %406 = trunc i8 %405 to i1, !dbg !892
      %407 = xor i1 %406, true, !dbg !892
      br i1 %407, label %L399, label %L398, !dbg !892

L398:                                             ; preds = %L380
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L421, !dbg !919

L399:                                             ; preds = %L380
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %408 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !920
; ││││└
      br label %L401, !dbg !921

L401:                                             ; preds = %L417, %L399
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %409 = load i64, i64 addrspace(5)* %408, align 8, !dbg !922, !tbaa !153, !alias.scope !157, !noalias !160
        %410 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %409, i64 0, i64 1, i32 4), !dbg !922
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %411 = icmp eq i64 %410, 0, !dbg !925
        %412 = zext i1 %411 to i8, !dbg !925
; │││││└
       %413 = trunc i8 %412 to i1, !dbg !926
       %414 = xor i1 %413, true, !dbg !926
       br i1 %414, label %L405, label %L404, !dbg !926

L404:                                             ; preds = %L401
       br label %L419, !dbg !926

L405:                                             ; preds = %L401
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %415 = icmp eq i64 %410, 5, !dbg !927
        %416 = zext i1 %415 to i8, !dbg !927
; │││││└
       %417 = trunc i8 %416 to i1, !dbg !928
       %418 = xor i1 %417, true, !dbg !928
       br i1 %418, label %L409, label %L408, !dbg !928

L408:                                             ; preds = %L405
       br label %L412, !dbg !928

L409:                                             ; preds = %L405
; │││││┌ @ promotion.jl:499 within `==`
        %419 = icmp eq i64 %410, 6, !dbg !927
        %420 = zext i1 %419 to i8, !dbg !927
; │││││└
       %421 = trunc i8 %420 to i1, !dbg !928
       %422 = xor i1 %421, true, !dbg !928
       br i1 %422, label %L417, label %L412, !dbg !928

L412:                                             ; preds = %L409, %L408
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i4 = call [5 x i64] @julia.gpu.state_getter(), !dbg !929
           store [5 x i64] %state.i4, [5 x i64] addrspace(5)* %11, align 8, !dbg !929
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %423 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %11, i32 0, i32 0, !dbg !935
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %424 = load i64, i64 addrspace(5)* %423, align 8, !dbg !936, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %425 = inttoptr i64 %424 to i64*, !dbg !937
         %426 = getelementptr inbounds i64, i64* %425, i64 0, !dbg !937
         %427 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !937, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %427, i64* %426, align 1, !dbg !937, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L417, !dbg !937

L417:                                             ; preds = %L412, %L409
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !940
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L401, !dbg !942

L419:                                             ; preds = %L404
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L420, !dbg !924

L420:                                             ; preds = %L419
       br label %L421, !dbg !924

L421:                                             ; preds = %L420, %L398
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !943
; ││││└
; ││││ @ none within `macro expansion`
      br label %L423, !dbg !893

L423:                                             ; preds = %L421
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %428 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !945, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %429 = add i32 %428, 1, !dbg !954
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %430 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !956, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %431 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !960, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %432 = zext i32 %429 to i64, !dbg !964
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %433 = icmp eq i64 %432, 1, !dbg !972
        %434 = zext i1 %433 to i8, !dbg !972
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %435 = trunc i8 %434 to i1, !dbg !973
         %436 = and i1 true, %435, !dbg !973
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %437 = xor i1 %436, true, !dbg !974
; ││││└└
      %438 = zext i1 %437 to i8, !dbg !950
      %439 = trunc i8 %438 to i1, !dbg !950
      %440 = xor i1 %439, true, !dbg !950
      br i1 %440, label %L436, label %L435, !dbg !950

L435:                                             ; preds = %L423
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L446, !dbg !975

L436:                                             ; preds = %L423
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ Base.jl:37 within `getproperty`
       %441 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 1, !dbg !976
; ││││└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %442 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %441, align 8, !dbg !978, !tbaa !153, !alias.scope !157, !noalias !160
         %443 = ptrtoint i8 addrspace(1)* %442 to i64, !dbg !978
; │││││└└
       %444 = addrspacecast i8 addrspace(1)* %442 to i8*, !dbg !980
       %445 = getelementptr i8, i8* %444, i64 1, !dbg !980
       %446 = ptrtoint i8* %445 to i64, !dbg !980
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %447 = addrspacecast i8* %445 to i8 addrspace(1)*, !dbg !981
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %448 = ptrtoint i8 addrspace(1)* %447 to i64, !dbg !984
; │││││└└
       %449 = addrspacecast i8 addrspace(1)* %447 to i8*, !dbg !986
       %450 = getelementptr i8, i8* %449, i64 -1, !dbg !986
       %451 = ptrtoint i8* %450 to i64, !dbg !986
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %452 = addrspacecast i8* %450 to i8 addrspace(1)*, !dbg !987
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %453 = bitcast i8 addrspace(1)* %452 to i64 addrspace(1)*, !dbg !990
         store i64 %value_phi1, i64 addrspace(1)* %453, align 1, !dbg !990, !tbaa !330
         br label %L446, !dbg !990

L446:                                             ; preds = %L436, %L435
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !996
; ││││└
; ││││ @ none within `macro expansion`
      br label %L448, !dbg !951

L448:                                             ; preds = %L446
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %454 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !998, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %455 = add i32 %454, 1, !dbg !1007
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %456 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1009, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %457 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1013, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %458 = zext i32 %455 to i64, !dbg !1017
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %459 = icmp eq i64 %458, 1, !dbg !1025
        %460 = zext i1 %459 to i8, !dbg !1025
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %461 = trunc i8 %460 to i1, !dbg !1026
         %462 = and i1 true, %461, !dbg !1026
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %463 = xor i1 %462, true, !dbg !1027
; ││││└└
      %464 = zext i1 %463 to i8, !dbg !1003
      %465 = trunc i8 %464 to i1, !dbg !1003
      %466 = xor i1 %465, true, !dbg !1003
      br i1 %466, label %L461, label %L460, !dbg !1003

L460:                                             ; preds = %L448
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L503, !dbg !1028

L461:                                             ; preds = %L448
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ Base.jl:37 within `getproperty`
       %467 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1029
       br label %L462, !dbg !1029

L462:                                             ; preds = %L478, %L461
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %468 = load i64, i64 addrspace(5)* %467, align 8, !dbg !1031, !tbaa !153, !alias.scope !157, !noalias !160
        %469 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %468, i64 1, i64 2, i32 4), !dbg !1031
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %470 = icmp eq i64 %469, 1, !dbg !1034
        %471 = zext i1 %470 to i8, !dbg !1034
; │││││└
       %472 = trunc i8 %471 to i1, !dbg !1035
       %473 = xor i1 %472, true, !dbg !1035
       br i1 %473, label %L466, label %L465, !dbg !1035

L465:                                             ; preds = %L462
       br label %L480, !dbg !1035

L466:                                             ; preds = %L462
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %474 = icmp eq i64 %469, 5, !dbg !1036
        %475 = zext i1 %474 to i8, !dbg !1036
; │││││└
       %476 = trunc i8 %475 to i1, !dbg !1037
       %477 = xor i1 %476, true, !dbg !1037
       br i1 %477, label %L470, label %L469, !dbg !1037

L469:                                             ; preds = %L466
       br label %L473, !dbg !1037

L470:                                             ; preds = %L466
; │││││┌ @ promotion.jl:499 within `==`
        %478 = icmp eq i64 %469, 6, !dbg !1036
        %479 = zext i1 %478 to i8, !dbg !1036
; │││││└
       %480 = trunc i8 %479 to i1, !dbg !1037
       %481 = xor i1 %480, true, !dbg !1037
       br i1 %481, label %L478, label %L473, !dbg !1037

L473:                                             ; preds = %L470, %L469
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i3 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1038
           store [5 x i64] %state.i3, [5 x i64] addrspace(5)* %10, align 8, !dbg !1038
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %482 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %10, i32 0, i32 0, !dbg !1044
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %483 = load i64, i64 addrspace(5)* %482, align 8, !dbg !1045, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %484 = inttoptr i64 %483 to i64*, !dbg !1046
         %485 = getelementptr inbounds i64, i64* %484, i64 0, !dbg !1046
         %486 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !1046, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %486, i64* %485, align 1, !dbg !1046, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L478, !dbg !1046

L478:                                             ; preds = %L473, %L470
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1049
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L462, !dbg !1051

L480:                                             ; preds = %L465
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L481, !dbg !1033

L481:                                             ; preds = %L480
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ Base.jl:37 within `getproperty`
       %487 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1052
       br label %L482, !dbg !1052

L482:                                             ; preds = %L498, %L481
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %488 = load i64, i64 addrspace(5)* %487, align 8, !dbg !1054, !tbaa !153, !alias.scope !157, !noalias !160
        %489 = call fastcc i64 @__ockl_hsa_signal_load(i64 %488, i32 2), !dbg !1054
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:499 within `==`
        %490 = icmp eq i64 %489, 4, !dbg !1057
        %491 = zext i1 %490 to i8, !dbg !1057
; │││││└
       %492 = trunc i8 %491 to i1, !dbg !1058
       %493 = xor i1 %492, true, !dbg !1058
       br i1 %493, label %L486, label %L485, !dbg !1058

L485:                                             ; preds = %L482
       br label %L500, !dbg !1058

L486:                                             ; preds = %L482
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; │││││┌ @ promotion.jl:499 within `==`
        %494 = icmp eq i64 %489, 5, !dbg !1059
        %495 = zext i1 %494 to i8, !dbg !1059
; │││││└
       %496 = trunc i8 %495 to i1, !dbg !1060
       %497 = xor i1 %496, true, !dbg !1060
       br i1 %497, label %L490, label %L489, !dbg !1060

L489:                                             ; preds = %L486
       br label %L493, !dbg !1060

L490:                                             ; preds = %L486
; │││││┌ @ promotion.jl:499 within `==`
        %498 = icmp eq i64 %489, 6, !dbg !1059
        %499 = zext i1 %498 to i8, !dbg !1059
; │││││└
       %500 = trunc i8 %499 to i1, !dbg !1060
       %501 = xor i1 %500, true, !dbg !1060
       br i1 %501, label %L498, label %L493, !dbg !1060

L493:                                             ; preds = %L490, %L489
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !1061
           store [5 x i64] %state.i, [5 x i64] addrspace(5)* %9, align 8, !dbg !1061
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %502 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %9, i32 0, i32 0, !dbg !1067
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %503 = load i64, i64 addrspace(5)* %502, align 8, !dbg !1068, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %504 = inttoptr i64 %503 to i64*, !dbg !1069
         %505 = getelementptr inbounds i64, i64* %504, i64 0, !dbg !1069
         %506 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !1069, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %506, i64* %505, align 1, !dbg !1069, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L498, !dbg !1069

L498:                                             ; preds = %L493, %L490
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1072
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L482, !dbg !1074

L500:                                             ; preds = %L485
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
       br label %L501, !dbg !1056

L501:                                             ; preds = %L500
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ Base.jl:37 within `getproperty`
       %507 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %8, i32 0, i32 0, !dbg !1075
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       %508 = load i64, i64 addrspace(5)* %507, align 8, !dbg !1077, !tbaa !153, !alias.scope !157, !noalias !160
       %509 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %508, i64 0, i32 3), !dbg !1077
       br label %L503, !dbg !1077

L503:                                             ; preds = %L501, %L460
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1079
; ││││└
; ││││ @ none within `macro expansion`
      br label %L505, !dbg !1004

L505:                                             ; preds = %L503
; ││└└
    br label %L506, !dbg !1006

L506:                                             ; preds = %L505
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
    br label %L507, !dbg !896

L507:                                             ; preds = %L506
; │└
   br label %L508, !dbg !897

L508:                                             ; preds = %L507
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:85 within `report_exception_name`
  ret void, !dbg !1081
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:88 within `report_exception_frame`
define internal fastcc void @gpu_report_exception_frame(i32 signext %0, i64 zeroext %1, i64 zeroext %2, i32 signext %3) unnamed_addr #7 !dbg !1082 {
top:
  %4 = alloca [5 x i64], align 8, addrspace(5)
  %5 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %6 = alloca [5 x i64], align 8, addrspace(5)
  %7 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %8 = alloca [5 x i64], align 8, addrspace(5)
  %9 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %10 = alloca [5 x i64], align 8, addrspace(5)
  %11 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %12 = alloca [5 x i64], align 8, addrspace(5)
  %13 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %14 = alloca [5 x i64], align 8, addrspace(5)
  %15 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %16 = alloca [5 x i64], align 8, addrspace(5)
  %17 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %18 = alloca [5 x i64], align 8, addrspace(5)
  %19 = alloca [5 x i64], align 8, addrspace(5)
  %20 = alloca [5 x i64], align 8, addrspace(5)
  %21 = alloca [5 x i64], align 8, addrspace(5)
  %22 = alloca [5 x i64], align 8, addrspace(5)
  %23 = alloca [5 x i64], align 8, addrspace(5)
  %24 = alloca [5 x i64], align 8, addrspace(5)
  %25 = alloca [5 x i64], align 8, addrspace(5)
  %26 = alloca [5 x i64], align 8, addrspace(5)
  %27 = alloca [5 x i64], align 8, addrspace(5)
  %28 = alloca [5 x i64], align 8, addrspace(5)
  %29 = alloca [5 x i64], align 8, addrspace(5)
  %30 = alloca [5 x i64], align 8, addrspace(5)
  %31 = alloca [5 x i64], align 8, addrspace(5)
  %32 = alloca [5 x i64], align 8, addrspace(5)
  %33 = alloca [5 x i64], align 8, addrspace(5)
  %34 = alloca [5 x i64], align 8, addrspace(5)
  %35 = alloca [5 x i64], align 8, addrspace(5)
  %36 = alloca [5 x i64], align 8, addrspace(5)
  %37 = call {}*** @julia.get_pgcstack()
  %38 = bitcast {}*** %37 to {}**
  %current_task = getelementptr inbounds {}*, {}** %38, i64 -13
  %39 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %39, i64 14
  %idx = alloca i32, align 4, addrspace(5)
  store i32 %0, i32 addrspace(5)* %idx, align 4
  call void @llvm.dbg.declare(metadata i32 addrspace(5)* %idx, metadata !1088, metadata !DIExpression()), !dbg !1092
  %func = alloca i64, align 8, addrspace(5)
  store i64 %1, i64 addrspace(5)* %func, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %func, metadata !1089, metadata !DIExpression()), !dbg !1092
  %file = alloca i64, align 8, addrspace(5)
  store i64 %2, i64 addrspace(5)* %file, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %file, metadata !1090, metadata !DIExpression()), !dbg !1092
  %line = alloca i32, align 4, addrspace(5)
  store i32 %3, i32 addrspace(5)* %line, align 4
  call void @llvm.dbg.declare(metadata i32 addrspace(5)* %line, metadata !1091, metadata !DIExpression()), !dbg !1092
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:91 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %40 = inttoptr i64 %1 to i8 addrspace(1)*, !dbg !1093
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %41 = addrspacecast i8 addrspace(1)* %40 to i8 addrspace(1)**, !dbg !1098
     %42 = bitcast i8 addrspace(1)** %41 to i8*, !dbg !1098
     br label %check.i, !dbg !1098

check.i:                                          ; preds = %check.i, %top
     %43 = phi i64 [ 0, %top ], [ %44, %check.i ], !dbg !1098
     %44 = add i64 %43, 1, !dbg !1098
     %45 = getelementptr i8, i8* %42, i64 %43, !dbg !1098
     %46 = load i8, i8* %45, align 1, !dbg !1098
     %47 = icmp eq i8 %46, 0, !dbg !1098
     br i1 %47, label %julia_report_exception_frame_2432u2434.exit, label %check.i, !dbg !1098

julia_report_exception_frame_2432u2434.exit:      ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ int.jl:1042 within `+` @ int.jl:87
    %48 = add i64 %43, 1, !dbg !1105
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i4 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1109
       store [5 x i64] %state.i4, [5 x i64] addrspace(5)* %4, align 8, !dbg !1109
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %49 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %4, i32 0, i32 3, !dbg !1118
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %50 = load i64, i64 addrspace(5)* %49, align 8, !dbg !1120, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %51 = inttoptr i64 %50 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1122
     %52 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %51, i64 0, !dbg !1122
     %53 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5 to i8 addrspace(5)*, !dbg !1122
     %54 = bitcast { i64, i8 addrspace(1)*, i64 }* %52 to i8*, !dbg !1122
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %53, i8* %54, i64 24, i1 false), !dbg !1122, !tbaa !168, !alias.scope !169, !noalias !170
     %55 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, align 8, !dbg !1122
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %56 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1125, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %57 = add i32 %56, 1, !dbg !1143
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %58 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1145, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %59 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1150, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %60 = zext i32 %57 to i64, !dbg !1155
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %61 = icmp eq i64 %60, 1, !dbg !1171
         %62 = zext i1 %61 to i8, !dbg !1171
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %63 = trunc i8 %62 to i1, !dbg !1172
          %64 = and i1 true, %63, !dbg !1172
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %65 = xor i1 %64, true, !dbg !1174
; │││││└└
       %66 = zext i1 %65 to i8, !dbg !1134
       %67 = trunc i8 %66 to i1, !dbg !1134
       %68 = xor i1 %67, true, !dbg !1134
       br i1 %68, label %L23, label %L22, !dbg !1134

L22:                                              ; preds = %julia_report_exception_frame_2432u2434.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L45, !dbg !1176

L23:                                              ; preds = %julia_report_exception_frame_2432u2434.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ Base.jl:37 within `getproperty`
        %69 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1177
; │││││└
       br label %L25, !dbg !1178

L25:                                              ; preds = %L41, %L23
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %70 = load i64, i64 addrspace(5)* %69, align 8, !dbg !1179, !tbaa !153, !alias.scope !157, !noalias !160
         %71 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %70, i64 0, i64 1, i32 4), !dbg !1179
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %72 = icmp eq i64 %71, 0, !dbg !1184
         %73 = zext i1 %72 to i8, !dbg !1184
; ││││││└
        %74 = trunc i8 %73 to i1, !dbg !1185
        %75 = xor i1 %74, true, !dbg !1185
        br i1 %75, label %L29, label %L28, !dbg !1185

L28:                                              ; preds = %L25
        br label %L43, !dbg !1185

L29:                                              ; preds = %L25
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %76 = icmp eq i64 %71, 5, !dbg !1186
         %77 = zext i1 %76 to i8, !dbg !1186
; ││││││└
        %78 = trunc i8 %77 to i1, !dbg !1187
        %79 = xor i1 %78, true, !dbg !1187
        br i1 %79, label %L33, label %L32, !dbg !1187

L32:                                              ; preds = %L29
        br label %L36, !dbg !1187

L33:                                              ; preds = %L29
; ││││││┌ @ promotion.jl:499 within `==`
         %80 = icmp eq i64 %71, 6, !dbg !1186
         %81 = zext i1 %80 to i8, !dbg !1186
; ││││││└
        %82 = trunc i8 %81 to i1, !dbg !1187
        %83 = xor i1 %82, true, !dbg !1187
        br i1 %83, label %L41, label %L36, !dbg !1187

L36:                                              ; preds = %L33, %L32
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i8 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1188
            store [5 x i64] %state.i8, [5 x i64] addrspace(5)* %36, align 8, !dbg !1188
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %84 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %36, i32 0, i32 0, !dbg !1196
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %85 = load i64, i64 addrspace(5)* %84, align 8, !dbg !1197, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %86 = inttoptr i64 %85 to i64*, !dbg !1198
          %87 = getelementptr inbounds i64, i64* %86, i64 0, !dbg !1198
          %88 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1198, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %88, i64* %87, align 1, !dbg !1198, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L41, !dbg !1198

L41:                                              ; preds = %L36, %L33
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1202
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L25, !dbg !1205

L43:                                              ; preds = %L28
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L44, !dbg !1183

L44:                                              ; preds = %L43
        br label %L45, !dbg !1183

L45:                                              ; preds = %L44, %L22
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1206
; │││││└
; │││││ @ none within `macro expansion`
       br label %L47, !dbg !1136

L47:                                              ; preds = %L45
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %89 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1209, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %90 = add i32 %89, 1, !dbg !1219
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %91 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1221, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %92 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1225, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %93 = zext i32 %90 to i64, !dbg !1229
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %94 = icmp eq i64 %93, 1, !dbg !1237
         %95 = zext i1 %94 to i8, !dbg !1237
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %96 = trunc i8 %95 to i1, !dbg !1238
          %97 = and i1 true, %96, !dbg !1238
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %98 = xor i1 %97, true, !dbg !1239
; │││││└└
       %99 = zext i1 %98 to i8, !dbg !1214
       %100 = trunc i8 %99 to i1, !dbg !1214
       %101 = xor i1 %100, true, !dbg !1214
       br i1 %101, label %L60, label %L59, !dbg !1214

L59:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L70, !dbg !1240

L60:                                              ; preds = %L47
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ Base.jl:37 within `getproperty`
        %102 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 1, !dbg !1241
; │││││└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %103 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %102, align 8, !dbg !1243, !tbaa !153, !alias.scope !157, !noalias !160
          %104 = ptrtoint i8 addrspace(1)* %103 to i64, !dbg !1243
; ││││││└└
        %105 = addrspacecast i8 addrspace(1)* %103 to i8*, !dbg !1246
        %106 = getelementptr i8, i8* %105, i64 1, !dbg !1246
        %107 = ptrtoint i8* %106 to i64, !dbg !1246
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %108 = addrspacecast i8* %106 to i8 addrspace(1)*, !dbg !1248
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %109 = ptrtoint i8 addrspace(1)* %108 to i64, !dbg !1253
; ││││││└└
        %110 = addrspacecast i8 addrspace(1)* %108 to i8*, !dbg !1255
        %111 = getelementptr i8, i8* %110, i64 -1, !dbg !1255
        %112 = ptrtoint i8* %111 to i64, !dbg !1255
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %113 = addrspacecast i8* %111 to i8 addrspace(1)*, !dbg !1257
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %114 = bitcast i8 addrspace(1)* %113 to i64 addrspace(1)*, !dbg !1260
          store i64 %48, i64 addrspace(1)* %114, align 1, !dbg !1260, !tbaa !330
          br label %L70, !dbg !1260

L70:                                              ; preds = %L60, %L59
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1269
; │││││└
; │││││ @ none within `macro expansion`
       br label %L72, !dbg !1215

L72:                                              ; preds = %L70
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L73, !dbg !1271

L73:                                              ; preds = %L72
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:169
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52 within `alloc_local` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:52
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          br label %L75, !dbg !1276

L75:                                              ; preds = %L73
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %115 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1285, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %116 = add i32 %115, 1, !dbg !1291
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %117 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1293, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %118 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1297, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %119 = zext i32 %116 to i64, !dbg !1301
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %120 = icmp eq i64 %119, 1, !dbg !1309
         %121 = zext i1 %120 to i8, !dbg !1309
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %122 = trunc i8 %121 to i1, !dbg !1310
          %123 = and i1 true, %122, !dbg !1310
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %124 = xor i1 %123, true, !dbg !1311
; │││││└└
       %125 = zext i1 %124 to i8, !dbg !1290
       %126 = trunc i8 %125 to i1, !dbg !1290
       %127 = xor i1 %126, true, !dbg !1290
       br i1 %127, label %L89, label %L88, !dbg !1290

L88:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L152, !dbg !1312

L89:                                              ; preds = %L75
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ Base.jl:37 within `getproperty`
        %128 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1313
        br label %L90, !dbg !1313

L90:                                              ; preds = %L106, %L89
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %129 = load i64, i64 addrspace(5)* %128, align 8, !dbg !1315, !tbaa !153, !alias.scope !157, !noalias !160
         %130 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %129, i64 1, i64 2, i32 4), !dbg !1315
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %131 = icmp eq i64 %130, 1, !dbg !1318
         %132 = zext i1 %131 to i8, !dbg !1318
; ││││││└
        %133 = trunc i8 %132 to i1, !dbg !1319
        %134 = xor i1 %133, true, !dbg !1319
        br i1 %134, label %L94, label %L93, !dbg !1319

L93:                                              ; preds = %L90
        br label %L108, !dbg !1319

L94:                                              ; preds = %L90
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %135 = icmp eq i64 %130, 5, !dbg !1320
         %136 = zext i1 %135 to i8, !dbg !1320
; ││││││└
        %137 = trunc i8 %136 to i1, !dbg !1321
        %138 = xor i1 %137, true, !dbg !1321
        br i1 %138, label %L98, label %L97, !dbg !1321

L97:                                              ; preds = %L94
        br label %L101, !dbg !1321

L98:                                              ; preds = %L94
; ││││││┌ @ promotion.jl:499 within `==`
         %139 = icmp eq i64 %130, 6, !dbg !1320
         %140 = zext i1 %139 to i8, !dbg !1320
; ││││││└
        %141 = trunc i8 %140 to i1, !dbg !1321
        %142 = xor i1 %141, true, !dbg !1321
        br i1 %142, label %L106, label %L101, !dbg !1321

L101:                                             ; preds = %L98, %L97
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i17 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1322
            store [5 x i64] %state.i17, [5 x i64] addrspace(5)* %35, align 8, !dbg !1322
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %143 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %35, i32 0, i32 0, !dbg !1328
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %144 = load i64, i64 addrspace(5)* %143, align 8, !dbg !1329, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %145 = inttoptr i64 %144 to i64*, !dbg !1330
          %146 = getelementptr inbounds i64, i64* %145, i64 0, !dbg !1330
          %147 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1330, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %147, i64* %146, align 1, !dbg !1330, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L106, !dbg !1330

L106:                                             ; preds = %L101, %L98
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1333
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L90, !dbg !1335

L108:                                             ; preds = %L93
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L109, !dbg !1317

L109:                                             ; preds = %L108
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ Base.jl:37 within `getproperty`
        %148 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1336
        br label %L110, !dbg !1336

L110:                                             ; preds = %L126, %L109
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %149 = load i64, i64 addrspace(5)* %148, align 8, !dbg !1338, !tbaa !153, !alias.scope !157, !noalias !160
         %150 = call fastcc i64 @__ockl_hsa_signal_load(i64 %149, i32 2), !dbg !1338
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││││┌ @ promotion.jl:499 within `==`
         %151 = icmp eq i64 %150, 4, !dbg !1343
         %152 = zext i1 %151 to i8, !dbg !1343
; ││││││└
        %153 = trunc i8 %152 to i1, !dbg !1344
        %154 = xor i1 %153, true, !dbg !1344
        br i1 %154, label %L114, label %L113, !dbg !1344

L113:                                             ; preds = %L110
        br label %L128, !dbg !1344

L114:                                             ; preds = %L110
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││││┌ @ promotion.jl:499 within `==`
         %155 = icmp eq i64 %150, 5, !dbg !1345
         %156 = zext i1 %155 to i8, !dbg !1345
; ││││││└
        %157 = trunc i8 %156 to i1, !dbg !1346
        %158 = xor i1 %157, true, !dbg !1346
        br i1 %158, label %L118, label %L117, !dbg !1346

L117:                                             ; preds = %L114
        br label %L121, !dbg !1346

L118:                                             ; preds = %L114
; ││││││┌ @ promotion.jl:499 within `==`
         %159 = icmp eq i64 %150, 6, !dbg !1345
         %160 = zext i1 %159 to i8, !dbg !1345
; ││││││└
        %161 = trunc i8 %160 to i1, !dbg !1346
        %162 = xor i1 %161, true, !dbg !1346
        br i1 %162, label %L126, label %L121, !dbg !1346

L121:                                             ; preds = %L118, %L117
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i18 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1347
            store [5 x i64] %state.i18, [5 x i64] addrspace(5)* %34, align 8, !dbg !1347
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %163 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %34, i32 0, i32 0, !dbg !1353
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %164 = load i64, i64 addrspace(5)* %163, align 8, !dbg !1354, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %165 = inttoptr i64 %164 to i64*, !dbg !1355
          %166 = getelementptr inbounds i64, i64* %165, i64 0, !dbg !1355
          %167 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1355, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %167, i64* %166, align 1, !dbg !1355, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L126, !dbg !1355

L126:                                             ; preds = %L121, %L118
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1358
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L110, !dbg !1360

L128:                                             ; preds = %L113
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
        br label %L129, !dbg !1342

L129:                                             ; preds = %L128
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:178
       br label %L130, !dbg !1361

L130:                                             ; preds = %L129
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:179
; │││││┌ @ Base.jl:37 within `getproperty`
        %168 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 1, !dbg !1362
; │││││└
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %169 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %168, align 8, !dbg !1364, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %170 = bitcast i8 addrspace(1)* %169 to i8 addrspace(1)* addrspace(1)*, !dbg !1365
          %171 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %170, align 1, !dbg !1365, !tbaa !330
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %172 = ptrtoint i8 addrspace(1)* %171 to i64, !dbg !1374
; │││││└└
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %173 = icmp eq i64 %172, 0, !dbg !1377
        %174 = zext i1 %173 to i8, !dbg !1377
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %175 = trunc i8 %174 to i1, !dbg !1379
         %176 = and i1 true, %175, !dbg !1379
; │││││└└
       %177 = zext i1 %176 to i8, !dbg !1376
       %178 = trunc i8 %177 to i1, !dbg !1376
       %179 = xor i1 %178, true, !dbg !1376
       br i1 %179, label %L146, label %L138, !dbg !1376

L138:                                             ; preds = %L130
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ Base.jl:37 within `getproperty`
        %180 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1380
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %181 = load i64, i64 addrspace(5)* %180, align 8, !dbg !1382, !tbaa !153, !alias.scope !157, !noalias !160
        %182 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %181, i64 5, i32 3), !dbg !1382
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i19 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1385
           store [5 x i64] %state.i19, [5 x i64] addrspace(5)* %33, align 8, !dbg !1385
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %183 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %33, i32 0, i32 0, !dbg !1391
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %184 = load i64, i64 addrspace(5)* %183, align 8, !dbg !1392, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %185 = inttoptr i64 %184 to i64*, !dbg !1393
         %186 = getelementptr inbounds i64, i64* %185, i64 0, !dbg !1393
         %187 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1393, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %187, i64* %186, align 1, !dbg !1393, !tbaa !260, !alias.scope !258, !noalias !259
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !1396
        unreachable, !dbg !1396

L146:                                             ; preds = %L130
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %188 = bitcast i8 addrspace(1)* %171 to i64 addrspace(1)*, !dbg !1399
          %189 = load i64, i64 addrspace(1)* %188, align 1, !dbg !1399, !tbaa !330
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %190 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1406
          store i64 %189, i64 addrspace(3)* %190, align 1, !dbg !1406, !tbaa !478
          br label %L150, !dbg !1406

L150:                                             ; preds = %L146
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ Base.jl:37 within `getproperty`
        %191 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1412
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %192 = load i64, i64 addrspace(5)* %191, align 8, !dbg !1414, !tbaa !153, !alias.scope !157, !noalias !160
        %193 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %192, i64 0, i32 3), !dbg !1414
        br label %L152, !dbg !1414

L152:                                             ; preds = %L150, %L88
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1416
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %194 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1418
          %195 = load i64, i64 addrspace(3)* %194, align 1, !dbg !1418, !tbaa !478
; │││││└└└
       br label %L156, !dbg !1424

L156:                                             ; preds = %L152
; │││└└
     br label %L157, !dbg !1275

L157:                                             ; preds = %L156
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
     br label %L158, !dbg !1141

L158:                                             ; preds = %L157
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:6 within `malloc`
    br label %L160, !dbg !1425

L160:                                             ; preds = %L158
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %196 = inttoptr i64 %195 to i8 addrspace(1)*, !dbg !1426
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %197 = ptrtoint i8 addrspace(1)* %196 to i64, !dbg !1427
; │└
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %198 = icmp eq i64 %197, 0, !dbg !1429
    %199 = zext i1 %198 to i8, !dbg !1429
; ││ @ int.jl:492 within `==`
; ││┌ @ bool.jl:38 within `&`
     %200 = trunc i8 %199 to i1, !dbg !1431
     %201 = and i1 true, %200, !dbg !1431
; │└└
   %202 = zext i1 %201 to i8, !dbg !1428
   %203 = trunc i8 %202 to i1, !dbg !1428
   %204 = xor i1 %203, true, !dbg !1428
   br i1 %204, label %L222, label %L165, !dbg !1428

L165:                                             ; preds = %L160
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i23 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1432
       store [5 x i64] %state.i23, [5 x i64] addrspace(5)* %6, align 8, !dbg !1432
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %205 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %6, i32 0, i32 1, !dbg !1440
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %206 = load i64, i64 addrspace(5)* %205, align 8, !dbg !1441, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %207 = inttoptr i64 %206 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1442
     %208 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %207, i64 0, !dbg !1442
     %209 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7 to i8 addrspace(5)*, !dbg !1442
     %210 = bitcast { i64, i8 addrspace(1)*, i64 }* %208 to i8*, !dbg !1442
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %209, i8* %210, i64 24, i1 false), !dbg !1442, !tbaa !168, !alias.scope !169, !noalias !170
     %211 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7, align 8, !dbg !1442
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %212 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1445, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %213 = add i32 %212, 1, !dbg !1455
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %214 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1457, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %215 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1461, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %216 = zext i32 %213 to i64, !dbg !1465
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %217 = icmp eq i64 %216, 1, !dbg !1473
        %218 = zext i1 %217 to i8, !dbg !1473
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %219 = trunc i8 %218 to i1, !dbg !1474
         %220 = and i1 true, %219, !dbg !1474
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %221 = xor i1 %220, true, !dbg !1475
; ││││└└
      %222 = zext i1 %221 to i8, !dbg !1450
      %223 = trunc i8 %222 to i1, !dbg !1450
      %224 = xor i1 %223, true, !dbg !1450
      br i1 %224, label %L183, label %L182, !dbg !1450

L182:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L205, !dbg !1476

L183:                                             ; preds = %L165
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %225 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7, i32 0, i32 0, !dbg !1477
; ││││└
      br label %L185, !dbg !1478

L185:                                             ; preds = %L201, %L183
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %226 = load i64, i64 addrspace(5)* %225, align 8, !dbg !1479, !tbaa !153, !alias.scope !157, !noalias !160
        %227 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %226, i64 0, i64 1, i32 4), !dbg !1479
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %228 = icmp eq i64 %227, 0, !dbg !1482
        %229 = zext i1 %228 to i8, !dbg !1482
; │││││└
       %230 = trunc i8 %229 to i1, !dbg !1483
       %231 = xor i1 %230, true, !dbg !1483
       br i1 %231, label %L189, label %L188, !dbg !1483

L188:                                             ; preds = %L185
       br label %L203, !dbg !1483

L189:                                             ; preds = %L185
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %232 = icmp eq i64 %227, 5, !dbg !1484
        %233 = zext i1 %232 to i8, !dbg !1484
; │││││└
       %234 = trunc i8 %233 to i1, !dbg !1485
       %235 = xor i1 %234, true, !dbg !1485
       br i1 %235, label %L193, label %L192, !dbg !1485

L192:                                             ; preds = %L189
       br label %L196, !dbg !1485

L193:                                             ; preds = %L189
; │││││┌ @ promotion.jl:499 within `==`
        %236 = icmp eq i64 %227, 6, !dbg !1484
        %237 = zext i1 %236 to i8, !dbg !1484
; │││││└
       %238 = trunc i8 %237 to i1, !dbg !1485
       %239 = xor i1 %238, true, !dbg !1485
       br i1 %239, label %L201, label %L196, !dbg !1485

L196:                                             ; preds = %L193, %L192
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i27 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1486
           store [5 x i64] %state.i27, [5 x i64] addrspace(5)* %32, align 8, !dbg !1486
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %240 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %32, i32 0, i32 0, !dbg !1492
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %241 = load i64, i64 addrspace(5)* %240, align 8, !dbg !1493, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %242 = inttoptr i64 %241 to i64*, !dbg !1494
         %243 = getelementptr inbounds i64, i64* %242, i64 0, !dbg !1494
         %244 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1494, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %244, i64* %243, align 1, !dbg !1494, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L201, !dbg !1494

L201:                                             ; preds = %L196, %L193
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1497
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L185, !dbg !1499

L203:                                             ; preds = %L188
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L204, !dbg !1481

L204:                                             ; preds = %L203
       br label %L205, !dbg !1481

L205:                                             ; preds = %L204, %L182
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1500
; ││││└
; ││││ @ none within `macro expansion`
      br label %L207, !dbg !1451

L207:                                             ; preds = %L205
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
     br label %L208, !dbg !1453

L208:                                             ; preds = %L207
; ││└
; ││┌ @ Base.jl:37 within `getproperty`
     %245 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7, i32 0, i32 1, !dbg !1502
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %246 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %245, align 8, !dbg !1503, !tbaa !153, !alias.scope !157, !noalias !160
       %247 = ptrtoint i8 addrspace(1)* %246 to i64, !dbg !1503
; │││└└
     %248 = addrspacecast i8 addrspace(1)* %246 to i8*, !dbg !1505
     %249 = getelementptr i8, i8* %248, i64 0, !dbg !1505
     %250 = ptrtoint i8* %249 to i64, !dbg !1505
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %251 = addrspacecast i8* %249 to i8 addrspace(1)*, !dbg !1506
; ││└└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %251, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !1509
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %252 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7, i32 0, i32 1, !dbg !1502
; ││└
; ││┌ @ essentials.jl:513 within `reinterpret`
     %253 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %252, align 8, !dbg !1513, !tbaa !153, !alias.scope !157, !noalias !160
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %254 = getelementptr inbounds i8, i8 addrspace(1)* %253, i64 41, !dbg !1514
       store i8 0, i8 addrspace(1)* %254, align 1, !dbg !1514, !tbaa !330
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %255 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %7 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !1519
     call fastcc void @julia_hostcall_device_trigger_and_return__2551({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %255) #7, !dbg !1519
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !1271

L222:                                             ; preds = %L160
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %196, i8 addrspace(1)* %40, i64 %43, i1 false), !dbg !1521
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %256 = ptrtoint i8 addrspace(1)* %196 to i64, !dbg !1525
; ││└└
    %257 = addrspacecast i8 addrspace(1)* %196 to i8*, !dbg !1527
    %258 = getelementptr i8, i8* %257, i64 %43, !dbg !1527
    %259 = ptrtoint i8* %258 to i64, !dbg !1527
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %260 = addrspacecast i8* %258 to i8 addrspace(1)*, !dbg !1529
; │└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %260, align 1, !dbg !1532, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:60 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %261 = ptrtoint i8 addrspace(1)* %196 to i64, !dbg !1538
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L231, !dbg !1271

L231:                                             ; preds = %L222, %L208
       %value_phi1 = phi i64 [ 0, %L208 ], [ %261, %L222 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:46 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %262 = inttoptr i64 %2 to i8 addrspace(1)*, !dbg !1540
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:47 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     %263 = addrspacecast i8 addrspace(1)* %262 to i8 addrspace(1)**, !dbg !1543
     %264 = bitcast i8 addrspace(1)** %263 to i8*, !dbg !1543
     br label %check.i29, !dbg !1543

check.i29:                                        ; preds = %check.i29, %L231
     %265 = phi i64 [ 0, %L231 ], [ %266, %check.i29 ], !dbg !1543
     %266 = add i64 %265, 1, !dbg !1543
     %267 = getelementptr i8, i8* %264, i64 %265, !dbg !1543
     %268 = load i8, i8* %267, align 1, !dbg !1543
     %269 = icmp eq i8 %268, 0, !dbg !1543
     br i1 %269, label %julia_report_exception_frame_2432u2455.exit, label %check.i29, !dbg !1543

julia_report_exception_frame_2432u2455.exit:      ; preds = %check.i29
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ int.jl:1042 within `+` @ int.jl:87
    %270 = add i64 %265, 1, !dbg !1547
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:23 within `malloc_hc`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i28 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1550
       store [5 x i64] %state.i28, [5 x i64] addrspace(5)* %8, align 8, !dbg !1550
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %271 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %8, i32 0, i32 3, !dbg !1555
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %272 = load i64, i64 addrspace(5)* %271, align 8, !dbg !1556, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %273 = inttoptr i64 %272 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1557
     %274 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %273, i64 0, !dbg !1557
     %275 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9 to i8 addrspace(5)*, !dbg !1557
     %276 = bitcast { i64, i8 addrspace(1)*, i64 }* %274 to i8*, !dbg !1557
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %275, i8* %276, i64 24, i1 false), !dbg !1557, !tbaa !168, !alias.scope !169, !noalias !170
     %277 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, align 8, !dbg !1557
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; │││┌ @ none within `hostcall_device_lock!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %278 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1559, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %279 = add i32 %278, 1, !dbg !1570
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %280 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1572, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %281 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1576, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %282 = zext i32 %279 to i64, !dbg !1580
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %283 = icmp eq i64 %282, 1, !dbg !1588
         %284 = zext i1 %283 to i8, !dbg !1588
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %285 = trunc i8 %284 to i1, !dbg !1589
          %286 = and i1 true, %285, !dbg !1589
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %287 = xor i1 %286, true, !dbg !1590
; │││││└└
       %288 = zext i1 %287 to i8, !dbg !1564
       %289 = trunc i8 %288 to i1, !dbg !1564
       %290 = xor i1 %289, true, !dbg !1564
       br i1 %290, label %L254, label %L253, !dbg !1564

L253:                                             ; preds = %julia_report_exception_frame_2432u2455.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L276, !dbg !1591

L254:                                             ; preds = %julia_report_exception_frame_2432u2455.exit
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││││┌ @ Base.jl:37 within `getproperty`
        %291 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 0, !dbg !1592
; │││││└
       br label %L256, !dbg !1593

L256:                                             ; preds = %L272, %L254
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %292 = load i64, i64 addrspace(5)* %291, align 8, !dbg !1594, !tbaa !153, !alias.scope !157, !noalias !160
         %293 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %292, i64 0, i64 1, i32 4), !dbg !1594
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %294 = icmp eq i64 %293, 0, !dbg !1597
         %295 = zext i1 %294 to i8, !dbg !1597
; ││││││└
        %296 = trunc i8 %295 to i1, !dbg !1598
        %297 = xor i1 %296, true, !dbg !1598
        br i1 %297, label %L260, label %L259, !dbg !1598

L259:                                             ; preds = %L256
        br label %L274, !dbg !1598

L260:                                             ; preds = %L256
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %298 = icmp eq i64 %293, 5, !dbg !1599
         %299 = zext i1 %298 to i8, !dbg !1599
; ││││││└
        %300 = trunc i8 %299 to i1, !dbg !1600
        %301 = xor i1 %300, true, !dbg !1600
        br i1 %301, label %L264, label %L263, !dbg !1600

L263:                                             ; preds = %L260
        br label %L267, !dbg !1600

L264:                                             ; preds = %L260
; ││││││┌ @ promotion.jl:499 within `==`
         %302 = icmp eq i64 %293, 6, !dbg !1599
         %303 = zext i1 %302 to i8, !dbg !1599
; ││││││└
        %304 = trunc i8 %303 to i1, !dbg !1600
        %305 = xor i1 %304, true, !dbg !1600
        br i1 %305, label %L272, label %L267, !dbg !1600

L267:                                             ; preds = %L264, %L263
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i26 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1601
            store [5 x i64] %state.i26, [5 x i64] addrspace(5)* %31, align 8, !dbg !1601
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %306 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %31, i32 0, i32 0, !dbg !1607
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %307 = load i64, i64 addrspace(5)* %306, align 8, !dbg !1608, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %308 = inttoptr i64 %307 to i64*, !dbg !1609
          %309 = getelementptr inbounds i64, i64* %308, i64 0, !dbg !1609
          %310 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1609, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %310, i64* %309, align 1, !dbg !1609, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L272, !dbg !1609

L272:                                             ; preds = %L267, %L264
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1612
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L256, !dbg !1614

L274:                                             ; preds = %L259
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L275, !dbg !1596

L275:                                             ; preds = %L274
        br label %L276, !dbg !1596

L276:                                             ; preds = %L275, %L253
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1615
; │││││└
; │││││ @ none within `macro expansion`
       br label %L278, !dbg !1565

L278:                                             ; preds = %L276
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; │││┌ @ none within `hostcall_device_write_args!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %311 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1617, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %312 = add i32 %311, 1, !dbg !1626
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %313 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1628, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %314 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1632, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %315 = zext i32 %312 to i64, !dbg !1636
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %316 = icmp eq i64 %315, 1, !dbg !1644
         %317 = zext i1 %316 to i8, !dbg !1644
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %318 = trunc i8 %317 to i1, !dbg !1645
          %319 = and i1 true, %318, !dbg !1645
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %320 = xor i1 %319, true, !dbg !1646
; │││││└└
       %321 = zext i1 %320 to i8, !dbg !1622
       %322 = trunc i8 %321 to i1, !dbg !1622
       %323 = xor i1 %322, true, !dbg !1622
       br i1 %323, label %L291, label %L290, !dbg !1622

L290:                                             ; preds = %L278
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L301, !dbg !1647

L291:                                             ; preds = %L278
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; │││││┌ @ Base.jl:37 within `getproperty`
        %324 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 1, !dbg !1648
; │││││└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %325 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %324, align 8, !dbg !1650, !tbaa !153, !alias.scope !157, !noalias !160
          %326 = ptrtoint i8 addrspace(1)* %325 to i64, !dbg !1650
; ││││││└└
        %327 = addrspacecast i8 addrspace(1)* %325 to i8*, !dbg !1652
        %328 = getelementptr i8, i8* %327, i64 1, !dbg !1652
        %329 = ptrtoint i8* %328 to i64, !dbg !1652
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %330 = addrspacecast i8* %328 to i8 addrspace(1)*, !dbg !1653
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %331 = ptrtoint i8 addrspace(1)* %330 to i64, !dbg !1656
; ││││││└└
        %332 = addrspacecast i8 addrspace(1)* %330 to i8*, !dbg !1658
        %333 = getelementptr i8, i8* %332, i64 -1, !dbg !1658
        %334 = ptrtoint i8* %333 to i64, !dbg !1658
; ││││││┌ @ essentials.jl:471 within `oftype`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││││││┌ @ essentials.jl:513 within `reinterpret`
           %335 = addrspacecast i8* %333 to i8 addrspace(1)*, !dbg !1659
; │││││└└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %336 = bitcast i8 addrspace(1)* %335 to i64 addrspace(1)*, !dbg !1662
          store i64 %270, i64 addrspace(1)* %336, align 1, !dbg !1662, !tbaa !330
          br label %L301, !dbg !1662

L301:                                             ; preds = %L291, %L290
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1668
; │││││└
; │││││ @ none within `macro expansion`
       br label %L303, !dbg !1623

L303:                                             ; preds = %L301
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L304, !dbg !1670

L304:                                             ; preds = %L303
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:91 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L306, !dbg !1271

L306:                                             ; preds = %L304
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %337 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1674, !range !190
; │││││││└└
; │││││││┌ @ int.jl:1042 within `+` @ int.jl:87
          %338 = add i32 %337, 1, !dbg !1680
; ││││││└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %339 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1682, !range !190
; ││││││└└└
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %340 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1686, !range !190
; │││││└└└└
; │││││┌ @ operators.jl:269 within `!=`
; ││││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││││┌ @ promotion.jl:381 within `promote`
; ││││││││┌ @ promotion.jl:358 within `_promote`
; │││││││││┌ @ number.jl:7 within `convert`
; ││││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││││┌ @ boot.jl:763 within `toUInt64`
              %341 = zext i32 %338 to i64, !dbg !1690
; │││││││└└└└└
; │││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
         %342 = icmp eq i64 %341, 1, !dbg !1698
         %343 = zext i1 %342 to i8, !dbg !1698
; │││││││ @ int.jl:492 within `==`
; │││││││┌ @ bool.jl:38 within `&`
          %344 = trunc i8 %343 to i1, !dbg !1699
          %345 = and i1 true, %344, !dbg !1699
; ││││││└└
; ││││││┌ @ bool.jl:35 within `!`
         %346 = xor i1 %345, true, !dbg !1700
; │││││└└
       %347 = zext i1 %346 to i8, !dbg !1679
       %348 = trunc i8 %347 to i1, !dbg !1679
       %349 = xor i1 %348, true, !dbg !1679
       br i1 %349, label %L320, label %L319, !dbg !1679

L319:                                             ; preds = %L306
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
       br label %L383, !dbg !1701

L320:                                             ; preds = %L306
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││││┌ @ Base.jl:37 within `getproperty`
        %350 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 0, !dbg !1702
        br label %L321, !dbg !1702

L321:                                             ; preds = %L337, %L320
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
         %351 = load i64, i64 addrspace(5)* %350, align 8, !dbg !1704, !tbaa !153, !alias.scope !157, !noalias !160
         %352 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %351, i64 1, i64 2, i32 4), !dbg !1704
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││││┌ @ promotion.jl:499 within `==`
         %353 = icmp eq i64 %352, 1, !dbg !1707
         %354 = zext i1 %353 to i8, !dbg !1707
; ││││││└
        %355 = trunc i8 %354 to i1, !dbg !1708
        %356 = xor i1 %355, true, !dbg !1708
        br i1 %356, label %L325, label %L324, !dbg !1708

L324:                                             ; preds = %L321
        br label %L339, !dbg !1708

L325:                                             ; preds = %L321
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││││┌ @ promotion.jl:499 within `==`
         %357 = icmp eq i64 %352, 5, !dbg !1709
         %358 = zext i1 %357 to i8, !dbg !1709
; ││││││└
        %359 = trunc i8 %358 to i1, !dbg !1710
        %360 = xor i1 %359, true, !dbg !1710
        br i1 %360, label %L329, label %L328, !dbg !1710

L328:                                             ; preds = %L325
        br label %L332, !dbg !1710

L329:                                             ; preds = %L325
; ││││││┌ @ promotion.jl:499 within `==`
         %361 = icmp eq i64 %352, 6, !dbg !1709
         %362 = zext i1 %361 to i8, !dbg !1709
; ││││││└
        %363 = trunc i8 %362 to i1, !dbg !1710
        %364 = xor i1 %363, true, !dbg !1710
        br i1 %364, label %L337, label %L332, !dbg !1710

L332:                                             ; preds = %L329, %L328
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i25 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1711
            store [5 x i64] %state.i25, [5 x i64] addrspace(5)* %30, align 8, !dbg !1711
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %365 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %30, i32 0, i32 0, !dbg !1717
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %366 = load i64, i64 addrspace(5)* %365, align 8, !dbg !1718, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %367 = inttoptr i64 %366 to i64*, !dbg !1719
          %368 = getelementptr inbounds i64, i64* %367, i64 0, !dbg !1719
          %369 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1719, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %369, i64* %368, align 1, !dbg !1719, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L337, !dbg !1719

L337:                                             ; preds = %L332, %L329
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1722
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
        br label %L321, !dbg !1724

L339:                                             ; preds = %L324
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
        br label %L340, !dbg !1706

L340:                                             ; preds = %L339
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││││┌ @ Base.jl:37 within `getproperty`
        %370 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 0, !dbg !1725
        br label %L341, !dbg !1725

L341:                                             ; preds = %L357, %L340
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
         %371 = load i64, i64 addrspace(5)* %370, align 8, !dbg !1727, !tbaa !153, !alias.scope !157, !noalias !160
         %372 = call fastcc i64 @__ockl_hsa_signal_load(i64 %371, i32 2), !dbg !1727
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││││┌ @ promotion.jl:499 within `==`
         %373 = icmp eq i64 %372, 4, !dbg !1730
         %374 = zext i1 %373 to i8, !dbg !1730
; ││││││└
        %375 = trunc i8 %374 to i1, !dbg !1731
        %376 = xor i1 %375, true, !dbg !1731
        br i1 %376, label %L345, label %L344, !dbg !1731

L344:                                             ; preds = %L341
        br label %L359, !dbg !1731

L345:                                             ; preds = %L341
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││││┌ @ promotion.jl:499 within `==`
         %377 = icmp eq i64 %372, 5, !dbg !1732
         %378 = zext i1 %377 to i8, !dbg !1732
; ││││││└
        %379 = trunc i8 %378 to i1, !dbg !1733
        %380 = xor i1 %379, true, !dbg !1733
        br i1 %380, label %L349, label %L348, !dbg !1733

L348:                                             ; preds = %L345
        br label %L352, !dbg !1733

L349:                                             ; preds = %L345
; ││││││┌ @ promotion.jl:499 within `==`
         %381 = icmp eq i64 %372, 6, !dbg !1732
         %382 = zext i1 %381 to i8, !dbg !1732
; ││││││└
        %383 = trunc i8 %382 to i1, !dbg !1733
        %384 = xor i1 %383, true, !dbg !1733
        br i1 %384, label %L357, label %L352, !dbg !1733

L352:                                             ; preds = %L349, %L348
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││┌ @ none within `kernel_state`
; │││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
            %state.i24 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1734
            store [5 x i64] %state.i24, [5 x i64] addrspace(5)* %29, align 8, !dbg !1734
; ││││││││└└
; ││││││││┌ @ Base.jl:37 within `getproperty`
           %385 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %29, i32 0, i32 0, !dbg !1740
; ││││││││└
; ││││││││┌ @ pointer.jl:30 within `convert`
           %386 = load i64, i64 addrspace(5)* %385, align 8, !dbg !1741, !tbaa !153, !alias.scope !157, !noalias !160
; │││││││└└
; │││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
          %387 = inttoptr i64 %386 to i64*, !dbg !1742
          %388 = getelementptr inbounds i64, i64* %387, i64 0, !dbg !1742
          %389 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1742, !tbaa !254, !alias.scope !258, !noalias !259
          store i64 %389, i64* %388, align 1, !dbg !1742, !tbaa !260, !alias.scope !258, !noalias !259
          br label %L357, !dbg !1742

L357:                                             ; preds = %L352, %L349
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
         call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1745
; ││││││└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
        br label %L341, !dbg !1747

L359:                                             ; preds = %L344
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
        br label %L360, !dbg !1729

L360:                                             ; preds = %L359
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:178
       br label %L361, !dbg !1748

L361:                                             ; preds = %L360
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:179
; │││││┌ @ Base.jl:37 within `getproperty`
        %390 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 1, !dbg !1749
; │││││└
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %391 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %390, align 8, !dbg !1751, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:180
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %392 = bitcast i8 addrspace(1)* %391 to i8 addrspace(1)* addrspace(1)*, !dbg !1752
          %393 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %392, align 1, !dbg !1752, !tbaa !330
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:181
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %394 = ptrtoint i8 addrspace(1)* %393 to i64, !dbg !1759
; │││││└└
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:499
        %395 = icmp eq i64 %394, 0, !dbg !1762
        %396 = zext i1 %395 to i8, !dbg !1762
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %397 = trunc i8 %396 to i1, !dbg !1764
         %398 = and i1 true, %397, !dbg !1764
; │││││└└
       %399 = zext i1 %398 to i8, !dbg !1761
       %400 = trunc i8 %399 to i1, !dbg !1761
       %401 = xor i1 %400, true, !dbg !1761
       br i1 %401, label %L377, label %L369, !dbg !1761

L369:                                             ; preds = %L361
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:182
; │││││┌ @ Base.jl:37 within `getproperty`
        %402 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 0, !dbg !1765
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %403 = load i64, i64 addrspace(5)* %402, align 8, !dbg !1767, !tbaa !153, !alias.scope !157, !noalias !160
        %404 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %403, i64 5, i32 3), !dbg !1767
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:183
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i22 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1769
           store [5 x i64] %state.i22, [5 x i64] addrspace(5)* %28, align 8, !dbg !1769
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %405 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %28, i32 0, i32 0, !dbg !1775
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %406 = load i64, i64 addrspace(5)* %405, align 8, !dbg !1776, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %407 = inttoptr i64 %406 to i64*, !dbg !1777
         %408 = getelementptr inbounds i64, i64* %407, i64 0, !dbg !1777
         %409 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1777, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %409, i64* %408, align 1, !dbg !1777, !tbaa !260, !alias.scope !258, !noalias !259
; │││││└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:184
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
        call void @llvm.trap(), !dbg !1780
        unreachable, !dbg !1780

L377:                                             ; preds = %L361
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:186
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %410 = bitcast i8 addrspace(1)* %393 to i64 addrspace(1)*, !dbg !1782
          %411 = load i64, i64 addrspace(1)* %410, align 1, !dbg !1782, !tbaa !330
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %412 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1789
          store i64 %411, i64 addrspace(3)* %412, align 1, !dbg !1789, !tbaa !478
          br label %L381, !dbg !1789

L381:                                             ; preds = %L377
; │││││└└└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││││┌ @ Base.jl:37 within `getproperty`
        %413 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %9, i32 0, i32 0, !dbg !1795
; │││││└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
        %414 = load i64, i64 addrspace(5)* %413, align 8, !dbg !1797, !tbaa !153, !alias.scope !157, !noalias !160
        %415 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %414, i64 0, i32 3), !dbg !1797
        br label %L383, !dbg !1797

L383:                                             ; preds = %L381, %L319
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !1799
; │││││└
; │││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:191
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %416 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1801
          %417 = load i64, i64 addrspace(3)* %416, align 1, !dbg !1801, !tbaa !478
; │││││└└└
       br label %L387, !dbg !1807

L387:                                             ; preds = %L383
; │││└└
     br label %L388, !dbg !1673

L388:                                             ; preds = %L387
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
     br label %L389, !dbg !1568

L389:                                             ; preds = %L388
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:6 within `malloc`
    br label %L391, !dbg !1808

L391:                                             ; preds = %L389
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %418 = inttoptr i64 %417 to i8 addrspace(1)*, !dbg !1809
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:52 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %419 = ptrtoint i8 addrspace(1)* %418 to i64, !dbg !1810
; │└
; │┌ @ int.jl:492 within `==` @ promotion.jl:499
    %420 = icmp eq i64 %419, 0, !dbg !1812
    %421 = zext i1 %420 to i8, !dbg !1812
; ││ @ int.jl:492 within `==`
; ││┌ @ bool.jl:38 within `&`
     %422 = trunc i8 %421 to i1, !dbg !1814
     %423 = and i1 true, %422, !dbg !1814
; │└└
   %424 = zext i1 %423 to i8, !dbg !1811
   %425 = trunc i8 %424 to i1, !dbg !1811
   %426 = xor i1 %425, true, !dbg !1811
   br i1 %426, label %L453, label %L396, !dbg !1811

L396:                                             ; preds = %L391
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:53 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `output_context`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %state.i21 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1815
       store [5 x i64] %state.i21, [5 x i64] addrspace(5)* %10, align 8, !dbg !1815
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %427 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %10, i32 0, i32 1, !dbg !1821
; │││└
; │││┌ @ pointer.jl:30 within `convert`
      %428 = load i64, i64 addrspace(5)* %427, align 8, !dbg !1822, !tbaa !153, !alias.scope !157, !noalias !160
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; ││┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
     %429 = inttoptr i64 %428 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1823
     %430 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %429, i64 0, !dbg !1823
     %431 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11 to i8 addrspace(5)*, !dbg !1823
     %432 = bitcast { i64, i8 addrspace(1)*, i64 }* %430 to i8*, !dbg !1823
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %431, i8* %432, i64 24, i1 false), !dbg !1823, !tbaa !168, !alias.scope !169, !noalias !170
     %433 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11, align 8, !dbg !1823
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %434 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1826, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %435 = add i32 %434, 1, !dbg !1835
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %436 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1837, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %437 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1841, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %438 = zext i32 %435 to i64, !dbg !1845
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %439 = icmp eq i64 %438, 1, !dbg !1853
        %440 = zext i1 %439 to i8, !dbg !1853
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %441 = trunc i8 %440 to i1, !dbg !1854
         %442 = and i1 true, %441, !dbg !1854
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %443 = xor i1 %442, true, !dbg !1855
; ││││└└
      %444 = zext i1 %443 to i8, !dbg !1831
      %445 = trunc i8 %444 to i1, !dbg !1831
      %446 = xor i1 %445, true, !dbg !1831
      br i1 %446, label %L414, label %L413, !dbg !1831

L413:                                             ; preds = %L396
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L436, !dbg !1856

L414:                                             ; preds = %L396
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %447 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11, i32 0, i32 0, !dbg !1857
; ││││└
      br label %L416, !dbg !1858

L416:                                             ; preds = %L432, %L414
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %448 = load i64, i64 addrspace(5)* %447, align 8, !dbg !1859, !tbaa !153, !alias.scope !157, !noalias !160
        %449 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %448, i64 0, i64 1, i32 4), !dbg !1859
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %450 = icmp eq i64 %449, 0, !dbg !1862
        %451 = zext i1 %450 to i8, !dbg !1862
; │││││└
       %452 = trunc i8 %451 to i1, !dbg !1863
       %453 = xor i1 %452, true, !dbg !1863
       br i1 %453, label %L420, label %L419, !dbg !1863

L419:                                             ; preds = %L416
       br label %L434, !dbg !1863

L420:                                             ; preds = %L416
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %454 = icmp eq i64 %449, 5, !dbg !1864
        %455 = zext i1 %454 to i8, !dbg !1864
; │││││└
       %456 = trunc i8 %455 to i1, !dbg !1865
       %457 = xor i1 %456, true, !dbg !1865
       br i1 %457, label %L424, label %L423, !dbg !1865

L423:                                             ; preds = %L420
       br label %L427, !dbg !1865

L424:                                             ; preds = %L420
; │││││┌ @ promotion.jl:499 within `==`
        %458 = icmp eq i64 %449, 6, !dbg !1864
        %459 = zext i1 %458 to i8, !dbg !1864
; │││││└
       %460 = trunc i8 %459 to i1, !dbg !1865
       %461 = xor i1 %460, true, !dbg !1865
       br i1 %461, label %L432, label %L427, !dbg !1865

L427:                                             ; preds = %L424, %L423
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i20 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1866
           store [5 x i64] %state.i20, [5 x i64] addrspace(5)* %27, align 8, !dbg !1866
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %462 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %27, i32 0, i32 0, !dbg !1872
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %463 = load i64, i64 addrspace(5)* %462, align 8, !dbg !1873, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %464 = inttoptr i64 %463 to i64*, !dbg !1874
         %465 = getelementptr inbounds i64, i64* %464, i64 0, !dbg !1874
         %466 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1874, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %466, i64* %465, align 1, !dbg !1874, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L432, !dbg !1874

L432:                                             ; preds = %L427, %L424
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1877
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L416, !dbg !1879

L434:                                             ; preds = %L419
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L435, !dbg !1861

L435:                                             ; preds = %L434
       br label %L436, !dbg !1861

L436:                                             ; preds = %L435, %L413
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !1880
; ││││└
; ││││ @ none within `macro expansion`
      br label %L438, !dbg !1832

L438:                                             ; preds = %L436
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
     br label %L439, !dbg !1834

L439:                                             ; preds = %L438
; ││└
; ││┌ @ Base.jl:37 within `getproperty`
     %467 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11, i32 0, i32 1, !dbg !1882
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %468 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %467, align 8, !dbg !1883, !tbaa !153, !alias.scope !157, !noalias !160
       %469 = ptrtoint i8 addrspace(1)* %468 to i64, !dbg !1883
; │││└└
     %470 = addrspacecast i8 addrspace(1)* %468 to i8*, !dbg !1885
     %471 = getelementptr i8, i8* %470, i64 0, !dbg !1885
     %472 = ptrtoint i8* %471 to i64, !dbg !1885
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %473 = addrspacecast i8* %471 to i8 addrspace(1)*, !dbg !1886
; ││└└└└
; ││┌ @ none within `memcpy!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %473, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([42 x i8], [42 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*), i64 41, i1 false), !dbg !1889
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %474 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11, i32 0, i32 1, !dbg !1882
; ││└
; ││┌ @ essentials.jl:513 within `reinterpret`
     %475 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %474, align 8, !dbg !1892, !tbaa !153, !alias.scope !157, !noalias !160
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %476 = getelementptr inbounds i8, i8 addrspace(1)* %475, i64 41, !dbg !1893
       store i8 0, i8 addrspace(1)* %476, align 1, !dbg !1893, !tbaa !330
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
     %477 = addrspacecast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %11 to { i64, i8 addrspace(1)*, i64 } addrspace(11)*, !dbg !1898
     call fastcc void @julia_hostcall_device_trigger_and_return__2551({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %477) #7, !dbg !1898
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L462, !dbg !1670

L453:                                             ; preds = %L391
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:57 within `device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %418, i8 addrspace(1)* %262, i64 %265, i1 false), !dbg !1899
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:59 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %478 = ptrtoint i8 addrspace(1)* %418 to i64, !dbg !1903
; ││└└
    %479 = addrspacecast i8 addrspace(1)* %418 to i8*, !dbg !1905
    %480 = getelementptr i8, i8* %479, i64 %265, !dbg !1905
    %481 = ptrtoint i8* %480 to i64, !dbg !1905
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %482 = addrspacecast i8* %480 to i8 addrspace(1)*, !dbg !1907
; │└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      store i8 0, i8 addrspace(1)* %482, align 1, !dbg !1910, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:60 within `device_string_to_host`
; │┌ @ essentials.jl:513 within `reinterpret`
    %483 = ptrtoint i8 addrspace(1)* %418 to i64, !dbg !1916
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:50 within `device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:5 within `malloc`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; │││┌ @ none within `hostcall_device_trigger_and_return!`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:168
       br label %L462, !dbg !1670

L462:                                             ; preds = %L453, %L439
       %value_phi3 = phi i64 [ 0, %L439 ], [ %483, %L453 ]
; └└└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:187 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:19 within `printf_output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i16 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1918
      store [5 x i64] %state.i16, [5 x i64] addrspace(5)* %12, align 8, !dbg !1918
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %484 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %12, i32 0, i32 2, !dbg !1925
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %485 = load i64, i64 addrspace(5)* %484, align 8, !dbg !1926, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %486 = inttoptr i64 %485 to { i64, i8 addrspace(1)*, i64 }*, !dbg !1927
    %487 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %486, i64 0, !dbg !1927
    %488 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13 to i8 addrspace(5)*, !dbg !1927
    %489 = bitcast { i64, i8 addrspace(1)*, i64 }* %487 to i8*, !dbg !1927
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %488, i8* %489, i64 24, i1 false), !dbg !1927, !tbaa !168, !alias.scope !169, !noalias !170
    %490 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, align 8, !dbg !1927
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:188 within `macro expansion`
; │┌ @ Base.jl:37 within `getproperty`
    %491 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, i32 0, i32 1, !dbg !1929
; │└
; │┌ @ essentials.jl:513 within `reinterpret`
    %492 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %491, align 8, !dbg !1931, !tbaa !153, !alias.scope !157, !noalias !160
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:193 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %493 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1932, !range !190
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %494 = add i32 %493, 1, !dbg !1942
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %495 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1944, !range !190
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %496 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1948, !range !190
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %497 = zext i32 %494 to i64, !dbg !1952
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %498 = icmp eq i64 %497, 1, !dbg !1960
       %499 = zext i1 %498 to i8, !dbg !1960
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %500 = trunc i8 %499 to i1, !dbg !1961
        %501 = and i1 true, %500, !dbg !1961
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %502 = xor i1 %501, true, !dbg !1962
; │││└└
     %503 = zext i1 %502 to i8, !dbg !1937
     %504 = trunc i8 %503 to i1, !dbg !1937
     %505 = xor i1 %504, true, !dbg !1937
     br i1 %505, label %L485, label %L484, !dbg !1937

L484:                                             ; preds = %L462
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L507, !dbg !1963

L485:                                             ; preds = %L462
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; │││┌ @ Base.jl:37 within `getproperty`
      %506 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, i32 0, i32 0, !dbg !1964
; │││└
     br label %L487, !dbg !1965

L487:                                             ; preds = %L503, %L485
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %507 = load i64, i64 addrspace(5)* %506, align 8, !dbg !1966, !tbaa !153, !alias.scope !157, !noalias !160
       %508 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %507, i64 0, i64 1, i32 4), !dbg !1966
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %509 = icmp eq i64 %508, 0, !dbg !1969
       %510 = zext i1 %509 to i8, !dbg !1969
; ││││└
      %511 = trunc i8 %510 to i1, !dbg !1970
      %512 = xor i1 %511, true, !dbg !1970
      br i1 %512, label %L491, label %L490, !dbg !1970

L490:                                             ; preds = %L487
      br label %L505, !dbg !1970

L491:                                             ; preds = %L487
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %513 = icmp eq i64 %508, 5, !dbg !1971
       %514 = zext i1 %513 to i8, !dbg !1971
; ││││└
      %515 = trunc i8 %514 to i1, !dbg !1972
      %516 = xor i1 %515, true, !dbg !1972
      br i1 %516, label %L495, label %L494, !dbg !1972

L494:                                             ; preds = %L491
      br label %L498, !dbg !1972

L495:                                             ; preds = %L491
; ││││┌ @ promotion.jl:499 within `==`
       %517 = icmp eq i64 %508, 6, !dbg !1971
       %518 = zext i1 %517 to i8, !dbg !1971
; ││││└
      %519 = trunc i8 %518 to i1, !dbg !1972
      %520 = xor i1 %519, true, !dbg !1972
      br i1 %520, label %L503, label %L498, !dbg !1972

L498:                                             ; preds = %L495, %L494
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i15 = call [5 x i64] @julia.gpu.state_getter(), !dbg !1973
          store [5 x i64] %state.i15, [5 x i64] addrspace(5)* %26, align 8, !dbg !1973
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %521 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %26, i32 0, i32 0, !dbg !1979
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %522 = load i64, i64 addrspace(5)* %521, align 8, !dbg !1980, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %523 = inttoptr i64 %522 to i64*, !dbg !1981
        %524 = getelementptr inbounds i64, i64* %523, i64 0, !dbg !1981
        %525 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !1981, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %525, i64* %524, align 1, !dbg !1981, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L503, !dbg !1981

L503:                                             ; preds = %L498, %L495
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1984
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L487, !dbg !1986

L505:                                             ; preds = %L490
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L506, !dbg !1968

L506:                                             ; preds = %L505
      br label %L507, !dbg !1968

L507:                                             ; preds = %L506, %L484
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1987
; │││└
; │││ @ none within `macro expansion`
     br label %L509, !dbg !1938

L509:                                             ; preds = %L507
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:115 within `hostcall_device_lock!`
    br label %L510, !dbg !1940

L510:                                             ; preds = %L509
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:195 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %526 = bitcast i8 addrspace(1)* %492 to i64 addrspace(1)*, !dbg !1989
      store i64 1, i64 addrspace(1)* %526, align 1, !dbg !1989, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:196 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:513 within `reinterpret`
      %527 = ptrtoint i8 addrspace(1)* %492 to i64, !dbg !1996
; ││└└
    %528 = addrspacecast i8 addrspace(1)* %492 to i8*, !dbg !1998
    %529 = getelementptr i8, i8* %528, i64 8, !dbg !1998
    %530 = ptrtoint i8* %529 to i64, !dbg !1998
; ││┌ @ essentials.jl:471 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %531 = addrspacecast i8* %529 to i8 addrspace(1)*, !dbg !2000
; │└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:198 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:153 within `_rocprintf_fmt`
; ││┌ @ essentials.jl:513 within `reinterpret`
     %532 = ptrtoint i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([19 x i8], [19 x i8]* @2, i32 0, i32 0) to i8 addrspace(1)*) to i64, !dbg !2003
; ││└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %533 = bitcast i8 addrspace(1)* %531 to i64 addrspace(1)*, !dbg !2007
       store i64 %532, i64 addrspace(1)* %533, align 1, !dbg !2007, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:154 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %534 = ptrtoint i8 addrspace(1)* %531 to i64, !dbg !2013
; │││└└
     %535 = addrspacecast i8 addrspace(1)* %531 to i8*, !dbg !2015
     %536 = getelementptr i8, i8* %535, i64 8, !dbg !2015
     %537 = ptrtoint i8* %536 to i64, !dbg !2015
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %538 = addrspacecast i8* %536 to i8 addrspace(1)*, !dbg !2017
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:155 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %539 = bitcast i8 addrspace(1)* %538 to i64 addrspace(1)*, !dbg !2020
       store i64 18, i64 addrspace(1)* %539, align 1, !dbg !2020, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:156 within `_rocprintf_fmt`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %540 = ptrtoint i8 addrspace(1)* %538 to i64, !dbg !2027
; │││└└
     %541 = addrspacecast i8 addrspace(1)* %538 to i8*, !dbg !2029
     %542 = getelementptr i8, i8* %541, i64 8, !dbg !2029
     %543 = ptrtoint i8* %542 to i64, !dbg !2029
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %544 = addrspacecast i8* %542 to i8 addrspace(1)*, !dbg !2031
; │└└└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %545 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2034, !range !190
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %546 = add i32 %545, 1, !dbg !2041
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %547 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2043, !range !190
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %548 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2047, !range !190
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %549 = zext i32 %546 to i64, !dbg !2051
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %550 = icmp eq i64 %549, 1, !dbg !2059
     %551 = zext i1 %550 to i8, !dbg !2059
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %552 = trunc i8 %551 to i1, !dbg !2060
      %553 = and i1 true, %552, !dbg !2060
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %554 = xor i1 %553, true, !dbg !2061
; │└└
   %555 = zext i1 %554 to i8, !dbg !2039
   %556 = trunc i8 %555 to i1, !dbg !2039
   %557 = xor i1 %556, true, !dbg !2039
   br i1 %557, label %L539, label %L538, !dbg !2039

L538:                                             ; preds = %L510
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L585, !dbg !2062

L539:                                             ; preds = %L510
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:107
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %558 = bitcast i8 addrspace(1)* %544 to i64 addrspace(1)*, !dbg !2063
       store i64 140431575652736, i64 addrspace(1)* %558, align 1, !dbg !2063, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %559 = ptrtoint i8 addrspace(1)* %544 to i64, !dbg !2072
; │││└└
     %560 = addrspacecast i8 addrspace(1)* %544 to i8*, !dbg !2074
     %561 = getelementptr i8, i8* %560, i64 8, !dbg !2074
     %562 = ptrtoint i8* %561 to i64, !dbg !2074
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %563 = addrspacecast i8* %561 to i8 addrspace(1)*, !dbg !2076
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %564 = bitcast i8 addrspace(1)* %563 to i32 addrspace(1)*, !dbg !2079
       store i32 %0, i32 addrspace(1)* %564, align 1, !dbg !2079, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %565 = ptrtoint i8 addrspace(1)* %563 to i64, !dbg !2086
; │││└└
     %566 = addrspacecast i8 addrspace(1)* %563 to i8*, !dbg !2088
     %567 = getelementptr i8, i8* %566, i64 4, !dbg !2088
     %568 = ptrtoint i8* %567 to i64, !dbg !2088
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %569 = addrspacecast i8* %567 to i8 addrspace(1)*, !dbg !2090
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %570 = bitcast i8 addrspace(1)* %569 to i64 addrspace(1)*, !dbg !2063
       store i64 140431490556000, i64 addrspace(1)* %570, align 1, !dbg !2063, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %571 = ptrtoint i8 addrspace(1)* %569 to i64, !dbg !2072
; │││└└
     %572 = addrspacecast i8 addrspace(1)* %569 to i8*, !dbg !2074
     %573 = getelementptr i8, i8* %572, i64 8, !dbg !2074
     %574 = ptrtoint i8* %573 to i64, !dbg !2074
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %575 = addrspacecast i8* %573 to i8 addrspace(1)*, !dbg !2076
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %576 = bitcast i8 addrspace(1)* %575 to i64 addrspace(1)*, !dbg !2079
       store i64 %value_phi1, i64 addrspace(1)* %576, align 1, !dbg !2079, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %577 = ptrtoint i8 addrspace(1)* %575 to i64, !dbg !2086
; │││└└
     %578 = addrspacecast i8 addrspace(1)* %575 to i8*, !dbg !2088
     %579 = getelementptr i8, i8* %578, i64 8, !dbg !2088
     %580 = ptrtoint i8* %579 to i64, !dbg !2088
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %581 = addrspacecast i8* %579 to i8 addrspace(1)*, !dbg !2090
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %582 = bitcast i8 addrspace(1)* %581 to i64 addrspace(1)*, !dbg !2063
       store i64 140431490556000, i64 addrspace(1)* %582, align 1, !dbg !2063, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %583 = ptrtoint i8 addrspace(1)* %581 to i64, !dbg !2072
; │││└└
     %584 = addrspacecast i8 addrspace(1)* %581 to i8*, !dbg !2074
     %585 = getelementptr i8, i8* %584, i64 8, !dbg !2074
     %586 = ptrtoint i8* %585 to i64, !dbg !2074
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %587 = addrspacecast i8* %585 to i8 addrspace(1)*, !dbg !2076
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %588 = bitcast i8 addrspace(1)* %587 to i64 addrspace(1)*, !dbg !2079
       store i64 %value_phi3, i64 addrspace(1)* %588, align 1, !dbg !2079, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %589 = ptrtoint i8 addrspace(1)* %587 to i64, !dbg !2086
; │││└└
     %590 = addrspacecast i8 addrspace(1)* %587 to i8*, !dbg !2088
     %591 = getelementptr i8, i8* %590, i64 8, !dbg !2088
     %592 = ptrtoint i8* %591 to i64, !dbg !2088
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %593 = addrspacecast i8* %591 to i8 addrspace(1)*, !dbg !2090
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:166 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %594 = bitcast i8 addrspace(1)* %593 to i64 addrspace(1)*, !dbg !2063
       store i64 140431575652736, i64 addrspace(1)* %594, align 1, !dbg !2063, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:167 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %595 = ptrtoint i8 addrspace(1)* %593 to i64, !dbg !2072
; │││└└
     %596 = addrspacecast i8 addrspace(1)* %593 to i8*, !dbg !2074
     %597 = getelementptr i8, i8* %596, i64 8, !dbg !2074
     %598 = ptrtoint i8* %597 to i64, !dbg !2074
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %599 = addrspacecast i8* %597 to i8 addrspace(1)*, !dbg !2076
; ││└└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:169 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %600 = bitcast i8 addrspace(1)* %599 to i32 addrspace(1)*, !dbg !2079
       store i32 %3, i32 addrspace(1)* %600, align 1, !dbg !2079, !tbaa !330
; ││└└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:170 within `_rocprintf_arg`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:513 within `reinterpret`
       %601 = ptrtoint i8 addrspace(1)* %599 to i64, !dbg !2086
; │││└└
     %602 = addrspacecast i8 addrspace(1)* %599 to i8*, !dbg !2088
     %603 = getelementptr i8, i8* %602, i64 4, !dbg !2088
     %604 = ptrtoint i8* %603 to i64, !dbg !2088
; │││┌ @ essentials.jl:471 within `oftype`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││┌ @ essentials.jl:513 within `reinterpret`
        %605 = addrspacecast i8* %603 to i8 addrspace(1)*, !dbg !2090
; │└└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %606 = bitcast i8 addrspace(1)* %605 to i64 addrspace(1)*, !dbg !2093
      store i64 0, i64 addrspace(1)* %606, align 1, !dbg !2093, !tbaa !330
      br label %L585, !dbg !2093

L585:                                             ; preds = %L539, %L538
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !2099
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:201 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %607 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2101, !range !190
; │││││└└
; │││││┌ @ int.jl:1042 within `+` @ int.jl:87
        %608 = add i32 %607, 1, !dbg !2110
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %609 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2112, !range !190
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %610 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2116, !range !190
; │││└└└└
; │││┌ @ operators.jl:269 within `!=`
; ││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││││┌ @ promotion.jl:381 within `promote`
; ││││││┌ @ promotion.jl:358 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:789 within `UInt64`
; │││││││││┌ @ boot.jl:763 within `toUInt64`
            %611 = zext i32 %608 to i64, !dbg !2120
; │││││└└└└└
; │││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
       %612 = icmp eq i64 %611, 1, !dbg !2128
       %613 = zext i1 %612 to i8, !dbg !2128
; │││││ @ int.jl:492 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %614 = trunc i8 %613 to i1, !dbg !2129
        %615 = and i1 true, %614, !dbg !2129
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %616 = xor i1 %615, true, !dbg !2130
; │││└└
     %617 = zext i1 %616 to i8, !dbg !2106
     %618 = trunc i8 %617 to i1, !dbg !2106
     %619 = xor i1 %618, true, !dbg !2106
     br i1 %619, label %L599, label %L598, !dbg !2106

L598:                                             ; preds = %L585
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
     br label %L641, !dbg !2131

L599:                                             ; preds = %L585
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │││┌ @ Base.jl:37 within `getproperty`
      %620 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, i32 0, i32 0, !dbg !2132
      br label %L600, !dbg !2132

L600:                                             ; preds = %L616, %L599
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %621 = load i64, i64 addrspace(5)* %620, align 8, !dbg !2134, !tbaa !153, !alias.scope !157, !noalias !160
       %622 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %621, i64 1, i64 2, i32 4), !dbg !2134
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:499 within `==`
       %623 = icmp eq i64 %622, 1, !dbg !2137
       %624 = zext i1 %623 to i8, !dbg !2137
; ││││└
      %625 = trunc i8 %624 to i1, !dbg !2138
      %626 = xor i1 %625, true, !dbg !2138
      br i1 %626, label %L604, label %L603, !dbg !2138

L603:                                             ; preds = %L600
      br label %L618, !dbg !2138

L604:                                             ; preds = %L600
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:499 within `==`
       %627 = icmp eq i64 %622, 5, !dbg !2139
       %628 = zext i1 %627 to i8, !dbg !2139
; ││││└
      %629 = trunc i8 %628 to i1, !dbg !2140
      %630 = xor i1 %629, true, !dbg !2140
      br i1 %630, label %L608, label %L607, !dbg !2140

L607:                                             ; preds = %L604
      br label %L611, !dbg !2140

L608:                                             ; preds = %L604
; ││││┌ @ promotion.jl:499 within `==`
       %631 = icmp eq i64 %622, 6, !dbg !2139
       %632 = zext i1 %631 to i8, !dbg !2139
; ││││└
      %633 = trunc i8 %632 to i1, !dbg !2140
      %634 = xor i1 %633, true, !dbg !2140
      br i1 %634, label %L616, label %L611, !dbg !2140

L611:                                             ; preds = %L608, %L607
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i14 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2141
          store [5 x i64] %state.i14, [5 x i64] addrspace(5)* %25, align 8, !dbg !2141
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %635 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %25, i32 0, i32 0, !dbg !2147
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %636 = load i64, i64 addrspace(5)* %635, align 8, !dbg !2148, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %637 = inttoptr i64 %636 to i64*, !dbg !2149
        %638 = getelementptr inbounds i64, i64* %637, i64 0, !dbg !2149
        %639 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2149, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %639, i64* %638, align 1, !dbg !2149, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L616, !dbg !2149

L616:                                             ; preds = %L611, %L608
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2152
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L600, !dbg !2154

L618:                                             ; preds = %L603
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L619, !dbg !2136

L619:                                             ; preds = %L618
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │││┌ @ Base.jl:37 within `getproperty`
      %640 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, i32 0, i32 0, !dbg !2155
      br label %L620, !dbg !2155

L620:                                             ; preds = %L636, %L619
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %641 = load i64, i64 addrspace(5)* %640, align 8, !dbg !2157, !tbaa !153, !alias.scope !157, !noalias !160
       %642 = call fastcc i64 @__ockl_hsa_signal_load(i64 %641, i32 2), !dbg !2157
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:499 within `==`
       %643 = icmp eq i64 %642, 4, !dbg !2160
       %644 = zext i1 %643 to i8, !dbg !2160
; ││││└
      %645 = trunc i8 %644 to i1, !dbg !2161
      %646 = xor i1 %645, true, !dbg !2161
      br i1 %646, label %L624, label %L623, !dbg !2161

L623:                                             ; preds = %L620
      br label %L638, !dbg !2161

L624:                                             ; preds = %L620
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││┌ @ promotion.jl:499 within `==`
       %647 = icmp eq i64 %642, 5, !dbg !2162
       %648 = zext i1 %647 to i8, !dbg !2162
; ││││└
      %649 = trunc i8 %648 to i1, !dbg !2163
      %650 = xor i1 %649, true, !dbg !2163
      br i1 %650, label %L628, label %L627, !dbg !2163

L627:                                             ; preds = %L624
      br label %L631, !dbg !2163

L628:                                             ; preds = %L624
; ││││┌ @ promotion.jl:499 within `==`
       %651 = icmp eq i64 %642, 6, !dbg !2162
       %652 = zext i1 %651 to i8, !dbg !2162
; ││││└
      %653 = trunc i8 %652 to i1, !dbg !2163
      %654 = xor i1 %653, true, !dbg !2163
      br i1 %654, label %L636, label %L631, !dbg !2163

L631:                                             ; preds = %L628, %L627
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %state.i13 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2164
          store [5 x i64] %state.i13, [5 x i64] addrspace(5)* %24, align 8, !dbg !2164
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %655 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %24, i32 0, i32 0, !dbg !2170
; ││││││└
; ││││││┌ @ pointer.jl:30 within `convert`
         %656 = load i64, i64 addrspace(5)* %655, align 8, !dbg !2171, !tbaa !153, !alias.scope !157, !noalias !160
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
        %657 = inttoptr i64 %656 to i64*, !dbg !2172
        %658 = getelementptr inbounds i64, i64* %657, i64 0, !dbg !2172
        %659 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2172, !tbaa !254, !alias.scope !258, !noalias !259
        store i64 %659, i64* %658, align 1, !dbg !2172, !tbaa !260, !alias.scope !258, !noalias !259
        br label %L636, !dbg !2172

L636:                                             ; preds = %L631, %L628
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2175
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L620, !dbg !2177

L638:                                             ; preds = %L623
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
      br label %L639, !dbg !2159

L639:                                             ; preds = %L638
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │││┌ @ Base.jl:37 within `getproperty`
      %660 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %13, i32 0, i32 0, !dbg !2178
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %661 = load i64, i64 addrspace(5)* %660, align 8, !dbg !2180, !tbaa !153, !alias.scope !157, !noalias !160
      %662 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %661, i64 0, i32 3), !dbg !2180
      br label %L641, !dbg !2180

L641:                                             ; preds = %L639, %L598
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !2182
; │││└
; │││ @ none within `macro expansion`
     br label %L643, !dbg !2107

L643:                                             ; preds = %L641
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:158 within `hostcall_device_trigger_and_return!`
    br label %L644, !dbg !2109

L644:                                             ; preds = %L643
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:94 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i12 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2184
      store [5 x i64] %state.i12, [5 x i64] addrspace(5)* %14, align 8, !dbg !2184
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %663 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %14, i32 0, i32 4, !dbg !2192
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %664 = load i64, i64 addrspace(5)* %663, align 8, !dbg !2193, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %665 = inttoptr i64 %664 to { i64, i8 addrspace(1)*, i64 }*, !dbg !2194
    %666 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %665, i64 0, !dbg !2194
    %667 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15 to i8 addrspace(5)*, !dbg !2194
    %668 = bitcast { i64, i8 addrspace(1)*, i64 }* %666 to i8*, !dbg !2194
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %667, i8* %668, i64 24, i1 false), !dbg !2194, !tbaa !168, !alias.scope !169, !noalias !170
    %669 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, align 8, !dbg !2194
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %670 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2196, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %671 = add i32 %670, 1, !dbg !2207
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %672 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2209, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %673 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2213, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %674 = zext i32 %671 to i64, !dbg !2217
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %675 = icmp eq i64 %674, 1, !dbg !2225
        %676 = zext i1 %675 to i8, !dbg !2225
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %677 = trunc i8 %676 to i1, !dbg !2226
         %678 = and i1 true, %677, !dbg !2226
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %679 = xor i1 %678, true, !dbg !2227
; ││││└└
      %680 = zext i1 %679 to i8, !dbg !2201
      %681 = trunc i8 %680 to i1, !dbg !2201
      %682 = xor i1 %681, true, !dbg !2201
      br i1 %682, label %L663, label %L662, !dbg !2201

L662:                                             ; preds = %L644
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L685, !dbg !2228

L663:                                             ; preds = %L644
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %683 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, i32 0, i32 0, !dbg !2229
; ││││└
      br label %L665, !dbg !2230

L665:                                             ; preds = %L681, %L663
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %684 = load i64, i64 addrspace(5)* %683, align 8, !dbg !2231, !tbaa !153, !alias.scope !157, !noalias !160
        %685 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %684, i64 0, i64 1, i32 4), !dbg !2231
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %686 = icmp eq i64 %685, 0, !dbg !2234
        %687 = zext i1 %686 to i8, !dbg !2234
; │││││└
       %688 = trunc i8 %687 to i1, !dbg !2235
       %689 = xor i1 %688, true, !dbg !2235
       br i1 %689, label %L669, label %L668, !dbg !2235

L668:                                             ; preds = %L665
       br label %L683, !dbg !2235

L669:                                             ; preds = %L665
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %690 = icmp eq i64 %685, 5, !dbg !2236
        %691 = zext i1 %690 to i8, !dbg !2236
; │││││└
       %692 = trunc i8 %691 to i1, !dbg !2237
       %693 = xor i1 %692, true, !dbg !2237
       br i1 %693, label %L673, label %L672, !dbg !2237

L672:                                             ; preds = %L669
       br label %L676, !dbg !2237

L673:                                             ; preds = %L669
; │││││┌ @ promotion.jl:499 within `==`
        %694 = icmp eq i64 %685, 6, !dbg !2236
        %695 = zext i1 %694 to i8, !dbg !2236
; │││││└
       %696 = trunc i8 %695 to i1, !dbg !2237
       %697 = xor i1 %696, true, !dbg !2237
       br i1 %697, label %L681, label %L676, !dbg !2237

L676:                                             ; preds = %L673, %L672
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i11 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2238
           store [5 x i64] %state.i11, [5 x i64] addrspace(5)* %23, align 8, !dbg !2238
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %698 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %23, i32 0, i32 0, !dbg !2244
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %699 = load i64, i64 addrspace(5)* %698, align 8, !dbg !2245, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %700 = inttoptr i64 %699 to i64*, !dbg !2246
         %701 = getelementptr inbounds i64, i64* %700, i64 0, !dbg !2246
         %702 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2246, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %702, i64* %701, align 1, !dbg !2246, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L681, !dbg !2246

L681:                                             ; preds = %L676, %L673
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2249
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L665, !dbg !2251

L683:                                             ; preds = %L668
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L684, !dbg !2233

L684:                                             ; preds = %L683
       br label %L685, !dbg !2233

L685:                                             ; preds = %L684, %L662
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2252
; ││││└
; ││││ @ none within `macro expansion`
      br label %L687, !dbg !2202

L687:                                             ; preds = %L685
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %703 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2254, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %704 = add i32 %703, 1, !dbg !2263
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %705 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2265, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %706 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2269, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %707 = zext i32 %704 to i64, !dbg !2273
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %708 = icmp eq i64 %707, 1, !dbg !2281
        %709 = zext i1 %708 to i8, !dbg !2281
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %710 = trunc i8 %709 to i1, !dbg !2282
         %711 = and i1 true, %710, !dbg !2282
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %712 = xor i1 %711, true, !dbg !2283
; ││││└└
      %713 = zext i1 %712 to i8, !dbg !2259
      %714 = trunc i8 %713 to i1, !dbg !2259
      %715 = xor i1 %714, true, !dbg !2259
      br i1 %715, label %L700, label %L699, !dbg !2259

L699:                                             ; preds = %L687
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L710, !dbg !2284

L700:                                             ; preds = %L687
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ Base.jl:37 within `getproperty`
       %716 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, i32 0, i32 1, !dbg !2285
; ││││└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %717 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %716, align 8, !dbg !2287, !tbaa !153, !alias.scope !157, !noalias !160
         %718 = ptrtoint i8 addrspace(1)* %717 to i64, !dbg !2287
; │││││└└
       %719 = addrspacecast i8 addrspace(1)* %717 to i8*, !dbg !2289
       %720 = getelementptr i8, i8* %719, i64 1, !dbg !2289
       %721 = ptrtoint i8* %720 to i64, !dbg !2289
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %722 = addrspacecast i8* %720 to i8 addrspace(1)*, !dbg !2290
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %723 = ptrtoint i8 addrspace(1)* %722 to i64, !dbg !2293
; │││││└└
       %724 = addrspacecast i8 addrspace(1)* %722 to i8*, !dbg !2295
       %725 = getelementptr i8, i8* %724, i64 -1, !dbg !2295
       %726 = ptrtoint i8* %725 to i64, !dbg !2295
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %727 = addrspacecast i8* %725 to i8 addrspace(1)*, !dbg !2296
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %728 = bitcast i8 addrspace(1)* %727 to i64 addrspace(1)*, !dbg !2299
         store i64 %value_phi1, i64 addrspace(1)* %728, align 1, !dbg !2299, !tbaa !330
         br label %L710, !dbg !2299

L710:                                             ; preds = %L700, %L699
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2305
; ││││└
; ││││ @ none within `macro expansion`
      br label %L712, !dbg !2260

L712:                                             ; preds = %L710
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %729 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2307, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %730 = add i32 %729, 1, !dbg !2316
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %731 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2318, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %732 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2322, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %733 = zext i32 %730 to i64, !dbg !2326
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %734 = icmp eq i64 %733, 1, !dbg !2334
        %735 = zext i1 %734 to i8, !dbg !2334
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %736 = trunc i8 %735 to i1, !dbg !2335
         %737 = and i1 true, %736, !dbg !2335
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %738 = xor i1 %737, true, !dbg !2336
; ││││└└
      %739 = zext i1 %738 to i8, !dbg !2312
      %740 = trunc i8 %739 to i1, !dbg !2312
      %741 = xor i1 %740, true, !dbg !2312
      br i1 %741, label %L725, label %L724, !dbg !2312

L724:                                             ; preds = %L712
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L767, !dbg !2337

L725:                                             ; preds = %L712
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ Base.jl:37 within `getproperty`
       %742 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, i32 0, i32 0, !dbg !2338
       br label %L726, !dbg !2338

L726:                                             ; preds = %L742, %L725
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %743 = load i64, i64 addrspace(5)* %742, align 8, !dbg !2340, !tbaa !153, !alias.scope !157, !noalias !160
        %744 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %743, i64 1, i64 2, i32 4), !dbg !2340
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %745 = icmp eq i64 %744, 1, !dbg !2343
        %746 = zext i1 %745 to i8, !dbg !2343
; │││││└
       %747 = trunc i8 %746 to i1, !dbg !2344
       %748 = xor i1 %747, true, !dbg !2344
       br i1 %748, label %L730, label %L729, !dbg !2344

L729:                                             ; preds = %L726
       br label %L744, !dbg !2344

L730:                                             ; preds = %L726
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %749 = icmp eq i64 %744, 5, !dbg !2345
        %750 = zext i1 %749 to i8, !dbg !2345
; │││││└
       %751 = trunc i8 %750 to i1, !dbg !2346
       %752 = xor i1 %751, true, !dbg !2346
       br i1 %752, label %L734, label %L733, !dbg !2346

L733:                                             ; preds = %L730
       br label %L737, !dbg !2346

L734:                                             ; preds = %L730
; │││││┌ @ promotion.jl:499 within `==`
        %753 = icmp eq i64 %744, 6, !dbg !2345
        %754 = zext i1 %753 to i8, !dbg !2345
; │││││└
       %755 = trunc i8 %754 to i1, !dbg !2346
       %756 = xor i1 %755, true, !dbg !2346
       br i1 %756, label %L742, label %L737, !dbg !2346

L737:                                             ; preds = %L734, %L733
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i10 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2347
           store [5 x i64] %state.i10, [5 x i64] addrspace(5)* %22, align 8, !dbg !2347
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %757 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %22, i32 0, i32 0, !dbg !2353
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %758 = load i64, i64 addrspace(5)* %757, align 8, !dbg !2354, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %759 = inttoptr i64 %758 to i64*, !dbg !2355
         %760 = getelementptr inbounds i64, i64* %759, i64 0, !dbg !2355
         %761 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2355, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %761, i64* %760, align 1, !dbg !2355, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L742, !dbg !2355

L742:                                             ; preds = %L737, %L734
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2358
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L726, !dbg !2360

L744:                                             ; preds = %L729
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L745, !dbg !2342

L745:                                             ; preds = %L744
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ Base.jl:37 within `getproperty`
       %762 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, i32 0, i32 0, !dbg !2361
       br label %L746, !dbg !2361

L746:                                             ; preds = %L762, %L745
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %763 = load i64, i64 addrspace(5)* %762, align 8, !dbg !2363, !tbaa !153, !alias.scope !157, !noalias !160
        %764 = call fastcc i64 @__ockl_hsa_signal_load(i64 %763, i32 2), !dbg !2363
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:499 within `==`
        %765 = icmp eq i64 %764, 4, !dbg !2366
        %766 = zext i1 %765 to i8, !dbg !2366
; │││││└
       %767 = trunc i8 %766 to i1, !dbg !2367
       %768 = xor i1 %767, true, !dbg !2367
       br i1 %768, label %L750, label %L749, !dbg !2367

L749:                                             ; preds = %L746
       br label %L764, !dbg !2367

L750:                                             ; preds = %L746
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; │││││┌ @ promotion.jl:499 within `==`
        %769 = icmp eq i64 %764, 5, !dbg !2368
        %770 = zext i1 %769 to i8, !dbg !2368
; │││││└
       %771 = trunc i8 %770 to i1, !dbg !2369
       %772 = xor i1 %771, true, !dbg !2369
       br i1 %772, label %L754, label %L753, !dbg !2369

L753:                                             ; preds = %L750
       br label %L757, !dbg !2369

L754:                                             ; preds = %L750
; │││││┌ @ promotion.jl:499 within `==`
        %773 = icmp eq i64 %764, 6, !dbg !2368
        %774 = zext i1 %773 to i8, !dbg !2368
; │││││└
       %775 = trunc i8 %774 to i1, !dbg !2369
       %776 = xor i1 %775, true, !dbg !2369
       br i1 %776, label %L762, label %L757, !dbg !2369

L757:                                             ; preds = %L754, %L753
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i9 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2370
           store [5 x i64] %state.i9, [5 x i64] addrspace(5)* %21, align 8, !dbg !2370
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %777 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %21, i32 0, i32 0, !dbg !2376
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %778 = load i64, i64 addrspace(5)* %777, align 8, !dbg !2377, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %779 = inttoptr i64 %778 to i64*, !dbg !2378
         %780 = getelementptr inbounds i64, i64* %779, i64 0, !dbg !2378
         %781 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2378, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %781, i64* %780, align 1, !dbg !2378, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L762, !dbg !2378

L762:                                             ; preds = %L757, %L754
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2381
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L746, !dbg !2383

L764:                                             ; preds = %L749
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
       br label %L765, !dbg !2365

L765:                                             ; preds = %L764
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ Base.jl:37 within `getproperty`
       %782 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %15, i32 0, i32 0, !dbg !2384
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       %783 = load i64, i64 addrspace(5)* %782, align 8, !dbg !2386, !tbaa !153, !alias.scope !157, !noalias !160
       %784 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %783, i64 0, i32 3), !dbg !2386
       br label %L767, !dbg !2386

L767:                                             ; preds = %L765, %L724
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2388
; ││││└
; ││││ @ none within `macro expansion`
      br label %L769, !dbg !2313

L769:                                             ; preds = %L767
; ││└└
    br label %L770, !dbg !2315

L770:                                             ; preds = %L769
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
    br label %L771, !dbg !2205

L771:                                             ; preds = %L770
; │└
   br label %L772, !dbg !2206

L772:                                             ; preds = %L771
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:95 within `report_exception_frame`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:10 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `free_hc`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i7 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2390
      store [5 x i64] %state.i7, [5 x i64] addrspace(5)* %16, align 8, !dbg !2390
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %785 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %16, i32 0, i32 4, !dbg !2396
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %786 = load i64, i64 addrspace(5)* %785, align 8, !dbg !2397, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │┌ @ pointer.jl:111 within `unsafe_load` @ pointer.jl:111
    %787 = inttoptr i64 %786 to { i64, i8 addrspace(1)*, i64 }*, !dbg !2398
    %788 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %787, i64 0, !dbg !2398
    %789 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17 to i8 addrspace(5)*, !dbg !2398
    %790 = bitcast { i64, i8 addrspace(1)*, i64 }* %788 to i8*, !dbg !2398
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %789, i8* %790, i64 24, i1 false), !dbg !2398, !tbaa !168, !alias.scope !169, !noalias !170
    %791 = load { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, align 8, !dbg !2398
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `free`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:71
; ││┌ @ none within `hostcall_device_lock!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %792 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2400, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %793 = add i32 %792, 1, !dbg !2411
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %794 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2413, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %795 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2417, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %796 = zext i32 %793 to i64, !dbg !2421
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %797 = icmp eq i64 %796, 1, !dbg !2429
        %798 = zext i1 %797 to i8, !dbg !2429
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %799 = trunc i8 %798 to i1, !dbg !2430
         %800 = and i1 true, %799, !dbg !2430
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %801 = xor i1 %800, true, !dbg !2431
; ││││└└
      %802 = zext i1 %801 to i8, !dbg !2405
      %803 = trunc i8 %802 to i1, !dbg !2405
      %804 = xor i1 %803, true, !dbg !2405
      br i1 %804, label %L791, label %L790, !dbg !2405

L790:                                             ; preds = %L772
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L813, !dbg !2432

L791:                                             ; preds = %L772
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:124
; ││││┌ @ Base.jl:37 within `getproperty`
       %805 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, i32 0, i32 0, !dbg !2433
; ││││└
      br label %L793, !dbg !2434

L793:                                             ; preds = %L809, %L791
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %806 = load i64, i64 addrspace(5)* %805, align 8, !dbg !2435, !tbaa !153, !alias.scope !157, !noalias !160
        %807 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %806, i64 0, i64 1, i32 4), !dbg !2435
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %808 = icmp eq i64 %807, 0, !dbg !2438
        %809 = zext i1 %808 to i8, !dbg !2438
; │││││└
       %810 = trunc i8 %809 to i1, !dbg !2439
       %811 = xor i1 %810, true, !dbg !2439
       br i1 %811, label %L797, label %L796, !dbg !2439

L796:                                             ; preds = %L793
       br label %L811, !dbg !2439

L797:                                             ; preds = %L793
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %812 = icmp eq i64 %807, 5, !dbg !2440
        %813 = zext i1 %812 to i8, !dbg !2440
; │││││└
       %814 = trunc i8 %813 to i1, !dbg !2441
       %815 = xor i1 %814, true, !dbg !2441
       br i1 %815, label %L801, label %L800, !dbg !2441

L800:                                             ; preds = %L797
       br label %L804, !dbg !2441

L801:                                             ; preds = %L797
; │││││┌ @ promotion.jl:499 within `==`
        %816 = icmp eq i64 %807, 6, !dbg !2440
        %817 = zext i1 %816 to i8, !dbg !2440
; │││││└
       %818 = trunc i8 %817 to i1, !dbg !2441
       %819 = xor i1 %818, true, !dbg !2441
       br i1 %819, label %L809, label %L804, !dbg !2441

L804:                                             ; preds = %L801, %L800
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i6 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2442
           store [5 x i64] %state.i6, [5 x i64] addrspace(5)* %20, align 8, !dbg !2442
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %820 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %20, i32 0, i32 0, !dbg !2448
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %821 = load i64, i64 addrspace(5)* %820, align 8, !dbg !2449, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %822 = inttoptr i64 %821 to i64*, !dbg !2450
         %823 = getelementptr inbounds i64, i64* %822, i64 0, !dbg !2450
         %824 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2450, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %824, i64* %823, align 1, !dbg !2450, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L809, !dbg !2450

L809:                                             ; preds = %L804, %L801
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2453
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L793, !dbg !2455

L811:                                             ; preds = %L796
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L812, !dbg !2437

L812:                                             ; preds = %L811
       br label %L813, !dbg !2437

L813:                                             ; preds = %L812, %L790
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2456
; ││││└
; ││││ @ none within `macro expansion`
      br label %L815, !dbg !2406

L815:                                             ; preds = %L813
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:72
; ││┌ @ none within `hostcall_device_write_args!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %825 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2458, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %826 = add i32 %825, 1, !dbg !2467
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %827 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2469, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %828 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2473, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %829 = zext i32 %826 to i64, !dbg !2477
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %830 = icmp eq i64 %829, 1, !dbg !2485
        %831 = zext i1 %830 to i8, !dbg !2485
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %832 = trunc i8 %831 to i1, !dbg !2486
         %833 = and i1 true, %832, !dbg !2486
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %834 = xor i1 %833, true, !dbg !2487
; ││││└└
      %835 = zext i1 %834 to i8, !dbg !2463
      %836 = trunc i8 %835 to i1, !dbg !2463
      %837 = xor i1 %836, true, !dbg !2463
      br i1 %837, label %L828, label %L827, !dbg !2463

L827:                                             ; preds = %L815
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L838, !dbg !2488

L828:                                             ; preds = %L815
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:152
; ││││┌ @ Base.jl:37 within `getproperty`
       %838 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, i32 0, i32 1, !dbg !2489
; ││││└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:114 within `+`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %839 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %838, align 8, !dbg !2491, !tbaa !153, !alias.scope !157, !noalias !160
         %840 = ptrtoint i8 addrspace(1)* %839 to i64, !dbg !2491
; │││││└└
       %841 = addrspacecast i8 addrspace(1)* %839 to i8*, !dbg !2493
       %842 = getelementptr i8, i8* %841, i64 1, !dbg !2493
       %843 = ptrtoint i8* %842 to i64, !dbg !2493
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %844 = addrspacecast i8* %842 to i8 addrspace(1)*, !dbg !2494
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:115 within `-`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:100 within `UInt64`
; ││││││┌ @ essentials.jl:513 within `reinterpret`
         %845 = ptrtoint i8 addrspace(1)* %844 to i64, !dbg !2497
; │││││└└
       %846 = addrspacecast i8 addrspace(1)* %844 to i8*, !dbg !2499
       %847 = getelementptr i8, i8* %846, i64 -1, !dbg !2499
       %848 = ptrtoint i8* %847 to i64, !dbg !2499
; │││││┌ @ essentials.jl:471 within `oftype`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:102 within `convert`
; │││││││┌ @ essentials.jl:513 within `reinterpret`
          %849 = addrspacecast i8* %847 to i8 addrspace(1)*, !dbg !2500
; ││││└└└└
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
         %850 = bitcast i8 addrspace(1)* %849 to i64 addrspace(1)*, !dbg !2503
         store i64 %value_phi3, i64 addrspace(1)* %850, align 1, !dbg !2503, !tbaa !330
         br label %L838, !dbg !2503

L838:                                             ; preds = %L828, %L827
; ││││└└└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2509
; ││││└
; ││││ @ none within `macro expansion`
      br label %L840, !dbg !2464

L840:                                             ; preds = %L838
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:73
; ││┌ @ none within `hostcall_device_trigger_and_return!`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %851 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2511, !range !190
; ││││││└└
; ││││││┌ @ int.jl:1042 within `+` @ int.jl:87
         %852 = add i32 %851, 1, !dbg !2520
; │││││└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %853 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2522, !range !190
; │││││└└└
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
          %854 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2526, !range !190
; ││││└└└└
; ││││┌ @ operators.jl:269 within `!=`
; │││││┌ @ int.jl:492 within `==` @ promotion.jl:449
; ││││││┌ @ promotion.jl:381 within `promote`
; │││││││┌ @ promotion.jl:358 within `_promote`
; ││││││││┌ @ number.jl:7 within `convert`
; │││││││││┌ @ boot.jl:789 within `UInt64`
; ││││││││││┌ @ boot.jl:763 within `toUInt64`
             %855 = zext i32 %852 to i64, !dbg !2530
; ││││││└└└└└
; ││││││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
        %856 = icmp eq i64 %855, 1, !dbg !2538
        %857 = zext i1 %856 to i8, !dbg !2538
; ││││││ @ int.jl:492 within `==`
; ││││││┌ @ bool.jl:38 within `&`
         %858 = trunc i8 %857 to i1, !dbg !2539
         %859 = and i1 true, %858, !dbg !2539
; │││││└└
; │││││┌ @ bool.jl:35 within `!`
        %860 = xor i1 %859, true, !dbg !2540
; ││││└└
      %861 = zext i1 %860 to i8, !dbg !2516
      %862 = trunc i8 %861 to i1, !dbg !2516
      %863 = xor i1 %862, true, !dbg !2516
      br i1 %863, label %L853, label %L852, !dbg !2516

L852:                                             ; preds = %L840
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
      br label %L895, !dbg !2541

L853:                                             ; preds = %L840
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; ││││┌ @ Base.jl:37 within `getproperty`
       %864 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, i32 0, i32 0, !dbg !2542
       br label %L854, !dbg !2542

L854:                                             ; preds = %L870, %L853
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
        %865 = load i64, i64 addrspace(5)* %864, align 8, !dbg !2544, !tbaa !153, !alias.scope !157, !noalias !160
        %866 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %865, i64 1, i64 2, i32 4), !dbg !2544
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; │││││┌ @ promotion.jl:499 within `==`
        %867 = icmp eq i64 %866, 1, !dbg !2547
        %868 = zext i1 %867 to i8, !dbg !2547
; │││││└
       %869 = trunc i8 %868 to i1, !dbg !2548
       %870 = xor i1 %869, true, !dbg !2548
       br i1 %870, label %L858, label %L857, !dbg !2548

L857:                                             ; preds = %L854
       br label %L872, !dbg !2548

L858:                                             ; preds = %L854
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; │││││┌ @ promotion.jl:499 within `==`
        %871 = icmp eq i64 %866, 5, !dbg !2549
        %872 = zext i1 %871 to i8, !dbg !2549
; │││││└
       %873 = trunc i8 %872 to i1, !dbg !2550
       %874 = xor i1 %873, true, !dbg !2550
       br i1 %874, label %L862, label %L861, !dbg !2550

L861:                                             ; preds = %L858
       br label %L865, !dbg !2550

L862:                                             ; preds = %L858
; │││││┌ @ promotion.jl:499 within `==`
        %875 = icmp eq i64 %866, 6, !dbg !2549
        %876 = zext i1 %875 to i8, !dbg !2549
; │││││└
       %877 = trunc i8 %876 to i1, !dbg !2550
       %878 = xor i1 %877, true, !dbg !2550
       br i1 %878, label %L870, label %L865, !dbg !2550

L865:                                             ; preds = %L862, %L861
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i5 = call [5 x i64] @julia.gpu.state_getter(), !dbg !2551
           store [5 x i64] %state.i5, [5 x i64] addrspace(5)* %19, align 8, !dbg !2551
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %879 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %19, i32 0, i32 0, !dbg !2557
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %880 = load i64, i64 addrspace(5)* %879, align 8, !dbg !2558, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %881 = inttoptr i64 %880 to i64*, !dbg !2559
         %882 = getelementptr inbounds i64, i64* %881, i64 0, !dbg !2559
         %883 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2559, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %883, i64* %882, align 1, !dbg !2559, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L870, !dbg !2559

L870:                                             ; preds = %L865, %L862
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2562
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
       br label %L854, !dbg !2564

L872:                                             ; preds = %L857
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
       br label %L873, !dbg !2546

L873:                                             ; preds = %L872
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; ││││┌ @ Base.jl:37 within `getproperty`
       %884 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, i32 0, i32 0, !dbg !2565
       br label %L874, !dbg !2565

L874:                                             ; preds = %L890, %L873
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
        %885 = load i64, i64 addrspace(5)* %884, align 8, !dbg !2567, !tbaa !153, !alias.scope !157, !noalias !160
        %886 = call fastcc i64 @__ockl_hsa_signal_load(i64 %885, i32 2), !dbg !2567
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; │││││┌ @ promotion.jl:499 within `==`
        %887 = icmp eq i64 %886, 4, !dbg !2570
        %888 = zext i1 %887 to i8, !dbg !2570
; │││││└
       %889 = trunc i8 %888 to i1, !dbg !2571
       %890 = xor i1 %889, true, !dbg !2571
       br i1 %890, label %L878, label %L877, !dbg !2571

L877:                                             ; preds = %L874
       br label %L892, !dbg !2571

L878:                                             ; preds = %L874
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; │││││┌ @ promotion.jl:499 within `==`
        %891 = icmp eq i64 %886, 5, !dbg !2572
        %892 = zext i1 %891 to i8, !dbg !2572
; │││││└
       %893 = trunc i8 %892 to i1, !dbg !2573
       %894 = xor i1 %893, true, !dbg !2573
       br i1 %894, label %L882, label %L881, !dbg !2573

L881:                                             ; preds = %L878
       br label %L885, !dbg !2573

L882:                                             ; preds = %L878
; │││││┌ @ promotion.jl:499 within `==`
        %895 = icmp eq i64 %886, 6, !dbg !2572
        %896 = zext i1 %895 to i8, !dbg !2572
; │││││└
       %897 = trunc i8 %896 to i1, !dbg !2573
       %898 = xor i1 %897, true, !dbg !2573
       br i1 %898, label %L890, label %L885, !dbg !2573

L885:                                             ; preds = %L882, %L881
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││││┌ @ none within `kernel_state`
; ││││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
           %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2574
           store [5 x i64] %state.i, [5 x i64] addrspace(5)* %18, align 8, !dbg !2574
; │││││││└└
; │││││││┌ @ Base.jl:37 within `getproperty`
          %899 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %18, i32 0, i32 0, !dbg !2580
; │││││││└
; │││││││┌ @ pointer.jl:30 within `convert`
          %900 = load i64, i64 addrspace(5)* %899, align 8, !dbg !2581, !tbaa !153, !alias.scope !157, !noalias !160
; ││││││└└
; ││││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ││││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
         %901 = inttoptr i64 %900 to i64*, !dbg !2582
         %902 = getelementptr inbounds i64, i64* %901, i64 0, !dbg !2582
         %903 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2582, !tbaa !254, !alias.scope !258, !noalias !259
         store i64 %903, i64* %902, align 1, !dbg !2582, !tbaa !260, !alias.scope !258, !noalias !259
         br label %L890, !dbg !2582

L890:                                             ; preds = %L885, %L882
; │││││└└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
        call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2585
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
       br label %L874, !dbg !2587

L892:                                             ; preds = %L877
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
       br label %L893, !dbg !2569

L893:                                             ; preds = %L892
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; ││││┌ @ Base.jl:37 within `getproperty`
       %904 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %17, i32 0, i32 0, !dbg !2588
; ││││└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
       %905 = load i64, i64 addrspace(5)* %904, align 8, !dbg !2590, !tbaa !153, !alias.scope !157, !noalias !160
       %906 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %905, i64 0, i32 3), !dbg !2590
       br label %L895, !dbg !2590

L895:                                             ; preds = %L893, %L852
; ││││└
; ││││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !2592
; ││││└
; ││││ @ none within `macro expansion`
      br label %L897, !dbg !2517

L897:                                             ; preds = %L895
; ││└└
    br label %L898, !dbg !2519

L898:                                             ; preds = %L897
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:65 within `hostcall!`
    br label %L899, !dbg !2409

L899:                                             ; preds = %L898
; │└
   br label %L900, !dbg !2410

L900:                                             ; preds = %L899
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:96 within `report_exception_frame`
  ret void, !dbg !2594
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:30 within `signal_exception`
define internal fastcc void @gpu_signal_exception() unnamed_addr #7 !dbg !2595 {
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
     %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2601
     store [5 x i64] %state.i, [5 x i64] addrspace(5)* %0, align 8, !dbg !2601
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %4 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !2610
; │└
; │┌ @ pointer.jl:30 within `convert`
    %5 = load i64, i64 addrspace(5)* %4, align 8, !dbg !2612, !tbaa !153, !alias.scope !157, !noalias !160
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; ┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
   %6 = inttoptr i64 %5 to i64*, !dbg !2614
   %7 = getelementptr inbounds i64, i64* %6, i64 0, !dbg !2614
   %8 = load i64, i64 addrspace(1)* @_j_const1.3, align 1, !dbg !2614, !tbaa !254, !alias.scope !258, !noalias !259
   store i64 %8, i64* %7, align 1, !dbg !2614, !tbaa !260, !alias.scope !258, !noalias !259
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:40 within `signal_exception`
  ret void, !dbg !2618
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2551({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #7 !dbg !2619 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
  call void @llvm.dbg.declare(metadata { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, metadata !2630, metadata !DIExpression(DW_OP_deref)), !dbg !2631
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %4 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2632, !range !190
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %5 = add i32 %4, 1, !dbg !2646
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %6 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2649, !range !190
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %7 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2654, !range !190
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %8 = zext i32 %5 to i64, !dbg !2659
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %9 = icmp eq i64 %8, 1, !dbg !2675
     %10 = zext i1 %9 to i8, !dbg !2675
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %11 = trunc i8 %10 to i1, !dbg !2676
      %12 = and i1 true, %11, !dbg !2676
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %13 = xor i1 %12, true, !dbg !2678
; │└└
   %14 = zext i1 %13 to i8, !dbg !2642
   %15 = trunc i8 %14 to i1, !dbg !2642
   %16 = xor i1 %15, true, !dbg !2642
   br i1 %16, label %L15, label %L14, !dbg !2642

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L21, !dbg !2680

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %17 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2681
; │└
   %18 = load i64, i64 addrspace(11)* %17, align 8, !dbg !2683, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
   call fastcc void @julia_hostcall_device_signal_wait_cas__2561(i64 zeroext %18, i64 signext 1, i64 signext 2) #7, !dbg !2683
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │┌ @ Base.jl:37 within `getproperty`
    %19 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2688
; │└
   %20 = load i64, i64 addrspace(11)* %19, align 8, !dbg !2689, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
   call fastcc void @julia_hostcall_device_signal_wait_2558(i64 zeroext %20, i64 signext 4) #7, !dbg !2689
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ Base.jl:37 within `getproperty`
    %21 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2690
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    %22 = load i64, i64 addrspace(11)* %21, align 8, !dbg !2692, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
    %23 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %22, i64 0, i32 3) [ "jl_roots"(i64 addrspace(11)* %21) ], !dbg !2692
    br label %L21, !dbg !2692

L21:                                              ; preds = %L15, %L14
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !2695
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !2644
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2561(i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #7 !dbg !2698 {
top:
  %3 = alloca [5 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -13
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 14
  %signal_handle = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %signal_handle, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %signal_handle, metadata !2704, metadata !DIExpression()), !dbg !2707
  %expected = alloca i64, align 8, addrspace(5)
  store i64 %1, i64 addrspace(5)* %expected, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %expected, metadata !2705, metadata !DIExpression()), !dbg !2707
  %value = alloca i64, align 8, addrspace(5)
  store i64 %2, i64 addrspace(5)* %value, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %value, metadata !2706, metadata !DIExpression()), !dbg !2707
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %7 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !2708
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %8 = icmp eq i64 %7, %1, !dbg !2713
   %9 = zext i1 %8 to i8, !dbg !2713
; └
  %10 = trunc i8 %9 to i1, !dbg !2715
  %11 = xor i1 %10, true, !dbg !2715
  br i1 %11, label %L6, label %L5, !dbg !2715

L5:                                               ; preds = %L2
  br label %L20, !dbg !2715

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ┌ @ promotion.jl:499 within `==`
   %12 = icmp eq i64 %7, 5, !dbg !2716
   %13 = zext i1 %12 to i8, !dbg !2716
; └
  %14 = trunc i8 %13 to i1, !dbg !2717
  %15 = xor i1 %14, true, !dbg !2717
  br i1 %15, label %L10, label %L9, !dbg !2717

L9:                                               ; preds = %L6
  br label %L13, !dbg !2717

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %16 = icmp eq i64 %7, 6, !dbg !2716
   %17 = zext i1 %16 to i8, !dbg !2716
; └
  %18 = trunc i8 %17 to i1, !dbg !2717
  %19 = xor i1 %18, true, !dbg !2717
  br i1 %19, label %L18, label %L13, !dbg !2717

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2718
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %3, align 8, !dbg !2718
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %20 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !2729
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %21 = load i64, i64 addrspace(5)* %20, align 8, !dbg !2731, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %22 = inttoptr i64 %21 to i64*, !dbg !2733
    %23 = getelementptr inbounds i64, i64* %22, i64 0, !dbg !2733
    %24 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2733, !tbaa !254, !alias.scope !258, !noalias !259
    store i64 %24, i64* %23, align 1, !dbg !2733, !tbaa !260, !alias.scope !258, !noalias !259
    br label %L18, !dbg !2733

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2737
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !2740

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !2712
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2558(i64 zeroext %0, i64 signext %1) unnamed_addr #7 !dbg !2741 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -13
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 14
  %signal_handle = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %signal_handle, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %signal_handle, metadata !2747, metadata !DIExpression()), !dbg !2749
  %value = alloca i64, align 8, addrspace(5)
  store i64 %1, i64 addrspace(5)* %value, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %value, metadata !2748, metadata !DIExpression()), !dbg !2749
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !2750
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %7 = icmp eq i64 %6, %1, !dbg !2755
   %8 = zext i1 %7 to i8, !dbg !2755
; └
  %9 = trunc i8 %8 to i1, !dbg !2757
  %10 = xor i1 %9, true, !dbg !2757
  br i1 %10, label %L6, label %L5, !dbg !2757

L5:                                               ; preds = %L2
  br label %L20, !dbg !2757

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ┌ @ promotion.jl:499 within `==`
   %11 = icmp eq i64 %6, 5, !dbg !2758
   %12 = zext i1 %11 to i8, !dbg !2758
; └
  %13 = trunc i8 %12 to i1, !dbg !2759
  %14 = xor i1 %13, true, !dbg !2759
  br i1 %14, label %L10, label %L9, !dbg !2759

L9:                                               ; preds = %L6
  br label %L13, !dbg !2759

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %15 = icmp eq i64 %6, 6, !dbg !2758
   %16 = zext i1 %15 to i8, !dbg !2758
; └
  %17 = trunc i8 %16 to i1, !dbg !2759
  %18 = xor i1 %17, true, !dbg !2759
  br i1 %18, label %L18, label %L13, !dbg !2759

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2760
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !2760
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %19 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !2771
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %20 = load i64, i64 addrspace(5)* %19, align 8, !dbg !2773, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %21 = inttoptr i64 %20 to i64*, !dbg !2775
    %22 = getelementptr inbounds i64, i64* %21, i64 0, !dbg !2775
    %23 = load i64, i64 addrspace(1)* @_j_const1.8, align 1, !dbg !2775, !tbaa !254, !alias.scope !258, !noalias !259
    store i64 %23, i64* %22, align 1, !dbg !2775, !tbaa !260, !alias.scope !258, !noalias !259
    br label %L18, !dbg !2775

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2779
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
  br label %L2, !dbg !2782

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !2754
}

;  @ none within `hostcall_device_trigger_and_return!`
define internal fastcc void @julia_hostcall_device_trigger_and_return__2324({ i64, i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0) unnamed_addr #7 !dbg !2783 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -13
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 14
  call void @llvm.dbg.declare(metadata { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, metadata !2786, metadata !DIExpression(DW_OP_deref)), !dbg !2787
; ┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:92
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %4 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2788, !range !190
; │││└└
; │││┌ @ int.jl:1042 within `+` @ int.jl:87
      %5 = add i32 %4, 1, !dbg !2802
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %6 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2805, !range !190
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
       %7 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2810, !range !190
; │└└└└
; │┌ @ operators.jl:269 within `!=`
; ││┌ @ int.jl:492 within `==` @ promotion.jl:449
; │││┌ @ promotion.jl:381 within `promote`
; ││││┌ @ promotion.jl:358 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:789 within `UInt64`
; │││││││┌ @ boot.jl:763 within `toUInt64`
          %8 = zext i32 %5 to i64, !dbg !2815
; │││└└└└└
; │││ @ int.jl:492 within `==` @ promotion.jl:449 @ promotion.jl:499
     %9 = icmp eq i64 %8, 1, !dbg !2831
     %10 = zext i1 %9 to i8, !dbg !2831
; │││ @ int.jl:492 within `==`
; │││┌ @ bool.jl:38 within `&`
      %11 = trunc i8 %10 to i1, !dbg !2832
      %12 = and i1 true, %11, !dbg !2832
; ││└└
; ││┌ @ bool.jl:35 within `!`
     %13 = xor i1 %12, true, !dbg !2834
; │└└
   %14 = zext i1 %13 to i8, !dbg !2798
   %15 = trunc i8 %14 to i1, !dbg !2798
   %16 = xor i1 %15, true, !dbg !2798
   br i1 %16, label %L15, label %L14, !dbg !2798

L14:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:93
   br label %L21, !dbg !2836

L15:                                              ; preds = %top
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:174
; │┌ @ Base.jl:37 within `getproperty`
    %17 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2837
; │└
   %18 = load i64, i64 addrspace(11)* %17, align 8, !dbg !2839, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
   call fastcc void @julia_hostcall_device_signal_wait_cas__2334(i64 zeroext %18, i64 signext 1, i64 signext 2) #7, !dbg !2839
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:176
; │┌ @ Base.jl:37 within `getproperty`
    %19 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2840
; │└
   %20 = load i64, i64 addrspace(11)* %19, align 8, !dbg !2841, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
   call fastcc void @julia_hostcall_device_signal_wait_2331(i64 zeroext %20, i64 signext 4) #7, !dbg !2841
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:188
; │┌ @ Base.jl:37 within `getproperty`
    %21 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(11)* %0, i32 0, i32 0, !dbg !2842
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
    %22 = load i64, i64 addrspace(11)* %21, align 8, !dbg !2844, !tbaa !2684, !invariant.load !69, !alias.scope !2686, !noalias !2687
    %23 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %22, i64 0, i32 3) [ "jl_roots"(i64 addrspace(11)* %21) ], !dbg !2844
    br label %L21, !dbg !2844

L21:                                              ; preds = %L15, %L14
; │└
; │ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall.jl:109
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !2847
; │└
; │ @ none within `macro expansion`
   ret void, !dbg !2800
; └
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:32 within `hostcall_device_signal_wait_cas!`
define internal fastcc void @julia_hostcall_device_signal_wait_cas__2334(i64 zeroext %0, i64 signext %1, i64 signext %2) unnamed_addr #7 !dbg !2850 {
top:
  %3 = alloca [5 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -13
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 14
  %signal_handle = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %signal_handle, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %signal_handle, metadata !2853, metadata !DIExpression()), !dbg !2856
  %expected = alloca i64, align 8, addrspace(5)
  store i64 %1, i64 addrspace(5)* %expected, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %expected, metadata !2854, metadata !DIExpression()), !dbg !2856
  %value = alloca i64, align 8, addrspace(5)
  store i64 %2, i64 addrspace(5)* %value, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %value, metadata !2855, metadata !DIExpression()), !dbg !2856
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
   %7 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 %1, i64 %2, i32 4), !dbg !2857
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ┌ @ promotion.jl:499 within `==`
   %8 = icmp eq i64 %7, %1, !dbg !2862
   %9 = zext i1 %8 to i8, !dbg !2862
; └
  %10 = trunc i8 %9 to i1, !dbg !2864
  %11 = xor i1 %10, true, !dbg !2864
  br i1 %11, label %L6, label %L5, !dbg !2864

L5:                                               ; preds = %L2
  br label %L20, !dbg !2864

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ┌ @ promotion.jl:499 within `==`
   %12 = icmp eq i64 %7, 5, !dbg !2865
   %13 = zext i1 %12 to i8, !dbg !2865
; └
  %14 = trunc i8 %13 to i1, !dbg !2866
  %15 = xor i1 %14, true, !dbg !2866
  br i1 %15, label %L10, label %L9, !dbg !2866

L9:                                               ; preds = %L6
  br label %L13, !dbg !2866

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %16 = icmp eq i64 %7, 6, !dbg !2865
   %17 = zext i1 %16 to i8, !dbg !2865
; └
  %18 = trunc i8 %17 to i1, !dbg !2866
  %19 = xor i1 %18, true, !dbg !2866
  br i1 %19, label %L18, label %L13, !dbg !2866

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2867
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %3, align 8, !dbg !2867
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %20 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !2878
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %21 = load i64, i64 addrspace(5)* %20, align 8, !dbg !2880, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %22 = inttoptr i64 %21 to i64*, !dbg !2882
    %23 = getelementptr inbounds i64, i64* %22, i64 0, !dbg !2882
    %24 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !2882, !tbaa !254, !alias.scope !258, !noalias !259
    store i64 %24, i64* %23, align 1, !dbg !2882, !tbaa !260, !alias.scope !258, !noalias !259
    br label %L18, !dbg !2882

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2886
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
  br label %L2, !dbg !2889

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
  ret void, !dbg !2861
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:57 within `hostcall_device_signal_wait`
define internal fastcc void @julia_hostcall_device_signal_wait_2331(i64 zeroext %0, i64 signext %1) unnamed_addr #7 !dbg !2890 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -13
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 14
  %signal_handle = alloca i64, align 8, addrspace(5)
  store i64 %0, i64 addrspace(5)* %signal_handle, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %signal_handle, metadata !2893, metadata !DIExpression()), !dbg !2895
  %value = alloca i64, align 8, addrspace(5)
  store i64 %1, i64 addrspace(5)* %value, align 8
  call void @llvm.dbg.declare(metadata i64 addrspace(5)* %value, metadata !2894, metadata !DIExpression()), !dbg !2895
  br label %L2

L2:                                               ; preds = %L18, %top
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
   %6 = call fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 2), !dbg !2896
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ┌ @ promotion.jl:499 within `==`
   %7 = icmp eq i64 %6, %1, !dbg !2901
   %8 = zext i1 %7 to i8, !dbg !2901
; └
  %9 = trunc i8 %8 to i1, !dbg !2903
  %10 = xor i1 %9, true, !dbg !2903
  br i1 %10, label %L6, label %L5, !dbg !2903

L5:                                               ; preds = %L2
  br label %L20, !dbg !2903

L6:                                               ; preds = %L2
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ┌ @ promotion.jl:499 within `==`
   %11 = icmp eq i64 %6, 5, !dbg !2904
   %12 = zext i1 %11 to i8, !dbg !2904
; └
  %13 = trunc i8 %12 to i1, !dbg !2905
  %14 = xor i1 %13, true, !dbg !2905
  br i1 %14, label %L10, label %L9, !dbg !2905

L9:                                               ; preds = %L6
  br label %L13, !dbg !2905

L10:                                              ; preds = %L6
; ┌ @ promotion.jl:499 within `==`
   %15 = icmp eq i64 %6, 6, !dbg !2904
   %16 = zext i1 %15 to i8, !dbg !2904
; └
  %17 = trunc i8 %16 to i1, !dbg !2905
  %18 = xor i1 %17, true, !dbg !2905
  br i1 %18, label %L18, label %L13, !dbg !2905

L13:                                              ; preds = %L10, %L9
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `signal_exception`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !2906
      store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !2906
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %19 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !2917
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %20 = load i64, i64 addrspace(5)* %19, align 8, !dbg !2919, !tbaa !153, !alias.scope !157, !noalias !160
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `signal_exception`
; │┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
    %21 = inttoptr i64 %20 to i64*, !dbg !2921
    %22 = getelementptr inbounds i64, i64* %21, i64 0, !dbg !2921
    %23 = load i64, i64 addrspace(1)* @_j_const1.1, align 1, !dbg !2921, !tbaa !254, !alias.scope !258, !noalias !259
    store i64 %23, i64* %22, align 1, !dbg !2921, !tbaa !260, !alias.scope !258, !noalias !259
    br label %L18, !dbg !2921

L18:                                              ; preds = %L13, %L10
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
   call void @llvm.amdgcn.s.sleep(i32 5), !dbg !2925
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
  br label %L2, !dbg !2928

L20:                                              ; preds = %L5
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
  ret void, !dbg !2900
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:366 within `set_one!`
define amdgpu_kernel void @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE({ [1 x i64], i8 addrspace(1)* } %0) local_unnamed_addr #7 !dbg !2929 {
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
  call void @llvm.dbg.declare(metadata { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, metadata !2939, metadata !DIExpression(DW_OP_deref)), !dbg !2940
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:367 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %8 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !2941, !range !190
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %9 = add i32 %8, 1, !dbg !2952
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %10 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !2955, !range !190
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %11 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !2960, !range !190
; └└└└
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:132 within `workgroupIdx`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %12 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !2965, !range !2972
; ││└└
; ││┌ @ int.jl:1042 within `+` @ int.jl:87
     %13 = add i32 %12, 1, !dbg !2973
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !2975, !range !2972
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %15 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !2980, !range !2972
; └└└└
; ┌ @ int.jl:1040 within `-`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %16 = zext i32 %13 to i64, !dbg !2985
; │└└└└
; │ @ int.jl:1042 within `-` @ int.jl:86
   %17 = sub i64 %16, 1, !dbg !2995
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:140 within `workgroupDim`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_x`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %18 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !2997
      %19 = getelementptr inbounds i8, i8 addrspace(4)* %18, i64 4, !dbg !2997
      %20 = bitcast i8 addrspace(4)* %19 to i16 addrspace(4)*, !dbg !2997
      %21 = load i16, i16 addrspace(4)* %20, align 2, !dbg !2997, !range !3005
      %22 = zext i16 %21 to i32, !dbg !2997
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_y`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %23 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !3006
      %24 = getelementptr inbounds i8, i8 addrspace(4)* %23, i64 6, !dbg !3006
      %25 = bitcast i8 addrspace(4)* %24 to i16 addrspace(4)*, !dbg !3006
      %26 = load i16, i16 addrspace(4)* %25, align 2, !dbg !3006, !range !3005
      %27 = zext i16 %26 to i32, !dbg !3006
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_z`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
      %28 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !3011
      %29 = getelementptr inbounds i8, i8 addrspace(4)* %28, i64 8, !dbg !3011
      %30 = bitcast i8 addrspace(4)* %29 to i16 addrspace(4)*, !dbg !3011
      %31 = load i16, i16 addrspace(4)* %30, align 2, !dbg !3011, !range !3005
      %32 = zext i16 %31 to i32, !dbg !3011
; └└└└
; ┌ @ int.jl:1040 within `*`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %33 = zext i32 %22 to i64, !dbg !3016
; │└└└└
; │ @ int.jl:1042 within `*` @ int.jl:88
   %34 = mul i64 %17, %33, !dbg !3022
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:525 within `rem`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:784 within `Int64`
; ││││┌ @ boot.jl:708 within `toInt64`
       %35 = zext i32 %9 to i64, !dbg !3024
; │└└└└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %36 = add i64 %35, %34, !dbg !3029
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:368 within `set_one!`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#getindex`
   br label %L28, !dbg !3031

L28:                                              ; preds = %top
; │┌ @ abstractarray.jl:707 within `checkbounds`
    %37 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !3035
    store i64 %36, i64 addrspace(5)* %37, align 8, !dbg !3035, !tbaa !153, !alias.scope !157, !noalias !160
; ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %38 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 0, !dbg !3038
; │││││└└
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ tuple.jl:29 within `getindex`
         %39 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %38, i32 0, i32 0, !dbg !3050
; ││││││└
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %40 = load i64, i64 addrspace(11)* %39, align 8, !dbg !3055, !alias.scope !2686, !noalias !2687
            %41 = icmp slt i64 %40, 0, !dbg !3055
; │││││││││└
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %42 = zext i1 %41 to i8, !dbg !3065
            %43 = trunc i8 %42 to i1, !dbg !3065
            %44 = xor i1 %43, true, !dbg !3065
            %45 = load i64, i64 addrspace(11)* %39, align 8, !dbg !3065, !alias.scope !2686, !noalias !2687
            %46 = select i1 %44, i64 %45, i64 0, !dbg !3065
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %47 = icmp sle i64 1, %36, !dbg !3067
      %48 = icmp sle i64 %36, %46, !dbg !3067
; │││└
; │││┌ @ bool.jl:38 within `&`
      %49 = and i1 %47, %48, !dbg !3071
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    %50 = zext i1 %49 to i8, !dbg !3049
    %51 = trunc i8 %50 to i1, !dbg !3049
    %52 = xor i1 %51, true, !dbg !3049
    br i1 %52, label %L38, label %L37, !dbg !3049

L37:                                              ; preds = %L28
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L40, !dbg !3073

L38:                                              ; preds = %L28
; ││ @ abstractarray.jl:709 within `checkbounds`
    call fastcc void @gpu_report_exception_name(i64 ptrtoint ([30 x i8]* @exception.42 to i64)), !dbg !3049
    call fastcc void @gpu_report_exception_frame(i32 1, i64 ptrtoint ([12 x i8]* @di_func.43 to i64), i64 ptrtoint ([19 x i8]* @di_file.44 to i64), i32 709), !dbg !3049
    call fastcc void @gpu_report_exception_frame(i32 2, i64 ptrtoint ([10 x i8]* @di_func.45 to i64), i64 ptrtoint ([55 x i8]* @di_file.46 to i64), i32 87), !dbg !3049
    call fastcc void @gpu_report_exception_frame(i32 3, i64 ptrtoint ([9 x i8]* @di_func.47 to i64), i64 ptrtoint ([45 x i8]* @di_file.48 to i64), i32 368), !dbg !3049
    call fastcc void @gpu_signal_exception(), !dbg !3049
    call void @llvm.trap(), !dbg !3049
    unreachable, !dbg !3049

L40:                                              ; preds = %L37
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L41, !dbg !3073

L41:                                              ; preds = %L40
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:89 within `#getindex`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %53 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 1, !dbg !3074
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
; ││││┌ @ int.jl:86 within `-`
       %54 = sub i64 %36, 1, !dbg !3078
; ││││└
      %55 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %53, align 8, !dbg !3079, !alias.scope !2686, !noalias !2687
      %56 = bitcast i8 addrspace(1)* %55 to i32 addrspace(1)*, !dbg !3079
      %57 = getelementptr inbounds i32, i32 addrspace(1)* %56, i64 %54, !dbg !3079
      %58 = load i32, i32 addrspace(1)* %57, align 4, !dbg !3079, !tbaa !330
; │└└└
   br label %L46, !dbg !3077

L46:                                              ; preds = %L41
; └
; ┌ @ int.jl:1040 within `+`
; │┌ @ int.jl:523 within `rem`
    %59 = sext i32 %58 to i64, !dbg !3086
; │└
; │ @ int.jl:1042 within `+` @ int.jl:87
   %60 = add i64 %59, 3, !dbg !3088
; └
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
   br label %L49, !dbg !3090

L49:                                              ; preds = %L46
; │┌ @ abstractarray.jl:707 within `checkbounds`
    %61 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %4, i32 0, i32 0, !dbg !3092
    store i64 %36, i64 addrspace(5)* %61, align 8, !dbg !3092, !tbaa !153, !alias.scope !157, !noalias !160
; ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %62 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 0, !dbg !3093
; │││││└└
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ tuple.jl:29 within `getindex`
         %63 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %62, i32 0, i32 0, !dbg !3100
; ││││││└
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %64 = load i64, i64 addrspace(11)* %63, align 8, !dbg !3102, !alias.scope !2686, !noalias !2687
            %65 = icmp slt i64 %64, 0, !dbg !3102
; │││││││││└
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %66 = zext i1 %65 to i8, !dbg !3107
            %67 = trunc i8 %66 to i1, !dbg !3107
            %68 = xor i1 %67, true, !dbg !3107
            %69 = load i64, i64 addrspace(11)* %63, align 8, !dbg !3107, !alias.scope !2686, !noalias !2687
            %70 = select i1 %68, i64 %69, i64 0, !dbg !3107
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %71 = icmp sle i64 1, %36, !dbg !3108
      %72 = icmp sle i64 %36, %70, !dbg !3108
; │││└
; │││┌ @ bool.jl:38 within `&`
      %73 = and i1 %71, %72, !dbg !3110
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    %74 = zext i1 %73 to i8, !dbg !3099
    %75 = trunc i8 %74 to i1, !dbg !3099
    %76 = xor i1 %75, true, !dbg !3099
    br i1 %76, label %L59, label %L58, !dbg !3099

L58:                                              ; preds = %L49
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L61, !dbg !3111

L59:                                              ; preds = %L49
; ││ @ abstractarray.jl:709 within `checkbounds`
    call fastcc void @gpu_report_exception_name(i64 ptrtoint ([30 x i8]* @exception.42 to i64)), !dbg !3099
    call fastcc void @gpu_report_exception_frame(i32 1, i64 ptrtoint ([12 x i8]* @di_func.43 to i64), i64 ptrtoint ([19 x i8]* @di_file.44 to i64), i32 709), !dbg !3099
    call fastcc void @gpu_report_exception_frame(i32 2, i64 ptrtoint ([11 x i8]* @di_func.38 to i64), i64 ptrtoint ([55 x i8]* @di_file.46 to i64), i32 93), !dbg !3099
    call fastcc void @gpu_report_exception_frame(i32 3, i64 ptrtoint ([9 x i8]* @di_func.47 to i64), i64 ptrtoint ([45 x i8]* @di_file.48 to i64), i32 368), !dbg !3099
    call fastcc void @gpu_signal_exception(), !dbg !3099
    call void @llvm.trap(), !dbg !3099
    unreachable, !dbg !3099

L61:                                              ; preds = %L58
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L62, !dbg !3111

L62:                                              ; preds = %L61
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:95 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %77 = getelementptr inbounds { [1 x i64], i8 addrspace(1)* }, { [1 x i64], i8 addrspace(1)* } addrspace(11)* %2, i32 0, i32 1, !dbg !3112
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:783 within `Int32`
      %78 = call fastcc i32 @julia_toInt32_1710(i64 signext %60) #7, !dbg !3115
; ││└└
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
; ││││┌ @ int.jl:86 within `-`
       %79 = sub i64 %36, 1, !dbg !3120
; ││││└
      %80 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %77, align 8, !dbg !3121, !alias.scope !2686, !noalias !2687
      %81 = bitcast i8 addrspace(1)* %80 to i32 addrspace(1)*, !dbg !3121
      %82 = getelementptr inbounds i32, i32 addrspace(1)* %81, i64 %79, !dbg !3121
      store i32 %78, i32 addrspace(1)* %82, align 4, !dbg !3121, !tbaa !330
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:96 within `#setindex!`
   br label %L68, !dbg !3125

L68:                                              ; preds = %L62
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `set_one!`
  ret void, !dbg !3126
}

attributes #0 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #1 = { nounwind willreturn }
attributes #2 = { readnone }
attributes #3 = { convergent nounwind willreturn }
attributes #4 = { nounwind readnone speculatable willreturn }
attributes #5 = { argmemonly nofree nounwind willreturn }
attributes #6 = { cold noreturn nounwind }
attributes #7 = { "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #8 = { alwaysinline convergent nounwind readnone willreturn }
attributes #9 = { alwaysinline nounwind }
attributes #10 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #11 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }

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
!63 = !{void ({ [1 x i64], i8 addrspace(1)* })* @_Z8set_one_14ROCDeviceArrayI5Int32Li1ELi1EE}
!64 = distinct !DISubprogram(name: "checked_trunc_sint", linkageName: "julia_checked_trunc_sint_1713", scope: null, file: !13, line: 652, type: !65, scopeLine: 652, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !75)
!65 = !DISubroutineType(types: !66)
!66 = !{!67, !68, !70, !74}
!67 = !DIBasicType(name: "Int32", size: 32, encoding: DW_ATE_unsigned)
!68 = !DICompositeType(tag: DW_TAG_structure_type, name: "#checked_trunc_sint", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140431516274752")
!69 = !{}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64, align: 64)
!71 = !DICompositeType(tag: DW_TAG_structure_type, name: "jl_value_t", file: !72, line: 71, align: 64, elements: !73)
!72 = !DIFile(filename: "julia.h", directory: "")
!73 = !{!70}
!74 = !DIBasicType(name: "Int64", size: 64, encoding: DW_ATE_unsigned)
!75 = !{!76, !77}
!76 = !DILocalVariable(name: "#self#", arg: 1, scope: !64, file: !13, line: 652, type: !68)
!77 = !DILocalVariable(name: "x", arg: 3, scope: !64, file: !13, line: 652, type: !74)
!78 = !DILocation(line: 652, scope: !64)
!79 = !DILocation(line: 654, scope: !64)
!80 = !DILocation(line: 655, scope: !64)
!81 = !DILocation(line: 656, scope: !64)
!82 = !DILocation(line: 657, scope: !64)
!83 = distinct !DISubprogram(name: "toInt32", linkageName: "julia_toInt32_1710", scope: null, file: !13, line: 693, type: !84, scopeLine: 693, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !87)
!84 = !DISubroutineType(types: !85)
!85 = !{!67, !86, !74}
!86 = !DICompositeType(tag: DW_TAG_structure_type, name: "#toInt32", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140431516044848")
!87 = !{!88, !89}
!88 = !DILocalVariable(name: "#self#", arg: 1, scope: !83, file: !13, line: 693, type: !86)
!89 = !DILocalVariable(name: "x", arg: 2, scope: !83, file: !13, line: 693, type: !74)
!90 = !DILocation(line: 693, scope: !83)
!91 = !{!92, !93, i64 16}
!92 = !{!"amd_signal_s", !93, i64 0, !94, i64 8, !93, i64 16, !96, i64 24, !96, i64 28, !93, i64 32, !93, i64 40, !94, i64 48, !94, i64 56}
!93 = !{!"long", !94, i64 0}
!94 = !{!"omnipotent char", !95, i64 0}
!95 = !{!"Simple C/C++ TBAA"}
!96 = !{!"int", !94, i64 0}
!97 = !{!92, !96, i64 24}
!98 = !{!92, !93, i64 0}
!99 = !{!96, !96, i64 0}
!100 = !{!94, !94, i64 0}
!101 = !{!102, !93, i64 80}
!102 = !{!"amd_queue_s", !103, i64 0, !94, i64 40, !93, i64 56, !96, i64 64, !96, i64 68, !96, i64 72, !96, i64 76, !93, i64 80, !96, i64 88, !94, i64 92, !93, i64 128, !96, i64 136, !96, i64 140, !94, i64 144, !93, i64 160, !93, i64 168, !96, i64 176, !96, i64 180, !94, i64 184, !105, i64 192, !94, i64 200}
!103 = !{!"hsa_queue_s", !94, i64 0, !96, i64 4, !104, i64 8, !105, i64 16, !96, i64 24, !96, i64 28, !93, i64 32}
!104 = !{!"any pointer", !94, i64 0}
!105 = !{!"hsa_signal_s", !93, i64 0}
!106 = !{!102, !96, i64 24}
!107 = distinct !DISubprogram(name: "report_exception_name", linkageName: "julia_report_exception_name_2256", scope: null, file: !28, line: 78, type: !108, scopeLine: 78, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !113)
!108 = !DISubroutineType(types: !109)
!109 = !{!110, !111, !112}
!110 = !DICompositeType(tag: DW_TAG_structure_type, name: "Nothing", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140431575658144")
!111 = !DICompositeType(tag: DW_TAG_structure_type, name: "#report_exception_name", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927647184")
!112 = !DIBasicType(name: "Ptr", size: 64, encoding: DW_ATE_unsigned)
!113 = !{!114, !115}
!114 = !DILocalVariable(name: "#self#", arg: 1, scope: !107, file: !28, line: 78, type: !111)
!115 = !DILocalVariable(name: "ex", arg: 2, scope: !107, file: !28, line: 78, type: !112)
!116 = !DILocation(line: 78, scope: !107)
!117 = !DILocation(line: 513, scope: !118, inlinedAt: !121)
!118 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !119, file: !119, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!119 = !DIFile(filename: "essentials.jl", directory: ".")
!120 = !DISubroutineType(types: !69)
!121 = !DILocation(line: 46, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!123 = !DILocation(line: 79, scope: !107)
!124 = !DILocation(line: 40, scope: !125, inlinedAt: !127)
!125 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!126 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl", directory: ".")
!127 = !DILocation(line: 3, scope: !128, inlinedAt: !130)
!128 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !129, file: !129, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!129 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!130 = !DILocation(line: 3, scope: !131, inlinedAt: !132)
!131 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !129, file: !129, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!132 = !DILocation(line: 47, scope: !122, inlinedAt: !123)
!133 = !DILocation(line: 87, scope: !134, inlinedAt: !136)
!134 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!135 = !DIFile(filename: "int.jl", directory: ".")
!136 = !DILocation(line: 1042, scope: !134, inlinedAt: !137)
!137 = !DILocation(line: 50, scope: !122, inlinedAt: !123)
!138 = !DILocation(line: 40, scope: !125, inlinedAt: !139)
!139 = !DILocation(line: 0, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!141 = !DILocation(line: 0, scope: !142, inlinedAt: !143)
!142 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!143 = !DILocation(line: 23, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!145 = !DILocation(line: 4, scope: !146, inlinedAt: !137)
!146 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!147 = !DILocation(line: 37, scope: !148, inlinedAt: !143)
!148 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!149 = !DIFile(filename: "Base.jl", directory: ".")
!150 = !DILocation(line: 30, scope: !151, inlinedAt: !143)
!151 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!152 = !DIFile(filename: "pointer.jl", directory: ".")
!153 = !{!154, !154, i64 0}
!154 = !{!"jtbaa_stack", !155, i64 0}
!155 = !{!"jtbaa", !156, i64 0}
!156 = !{!"jtbaa"}
!157 = !{!158}
!158 = !{!"jnoalias_stack", !159}
!159 = !{!"jnoalias"}
!160 = !{!161, !162, !163, !164}
!161 = !{!"jnoalias_gcframe", !159}
!162 = !{!"jnoalias_data", !159}
!163 = !{!"jnoalias_typemd", !159}
!164 = !{!"jnoalias_const", !159}
!165 = !DILocation(line: 111, scope: !166, inlinedAt: !167)
!166 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!167 = !DILocation(line: 111, scope: !166, inlinedAt: !145)
!168 = !{!155, !155, i64 0}
!169 = !{!162, !158}
!170 = !{!161, !163, !164}
!171 = !DILocation(line: 40, scope: !125, inlinedAt: !172)
!172 = !DILocation(line: 3, scope: !173, inlinedAt: !175)
!173 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!174 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!175 = !DILocation(line: 3, scope: !176, inlinedAt: !177)
!176 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!177 = !DILocation(line: 89, scope: !178, inlinedAt: !179)
!178 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!179 = !DILocation(line: 124, scope: !180, inlinedAt: !181)
!180 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!181 = !DILocation(line: 92, scope: !182, inlinedAt: !183)
!182 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!183 = !DILocation(line: 0, scope: !140, inlinedAt: !184)
!184 = !DILocation(line: 0, scope: !185, inlinedAt: !186)
!185 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!186 = !DILocation(line: 71, scope: !187, inlinedAt: !188)
!187 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!188 = !DILocation(line: 65, scope: !187, inlinedAt: !189)
!189 = !DILocation(line: 5, scope: !146, inlinedAt: !137)
!190 = !{i32 0, i32 1023}
!191 = !DILocation(line: 87, scope: !134, inlinedAt: !192)
!192 = !DILocation(line: 1042, scope: !134, inlinedAt: !177)
!193 = !DILocation(line: 40, scope: !125, inlinedAt: !194)
!194 = !DILocation(line: 3, scope: !173, inlinedAt: !195)
!195 = !DILocation(line: 3, scope: !176, inlinedAt: !196)
!196 = !DILocation(line: 89, scope: !197, inlinedAt: !179)
!197 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!198 = !DILocation(line: 40, scope: !125, inlinedAt: !199)
!199 = !DILocation(line: 3, scope: !173, inlinedAt: !200)
!200 = !DILocation(line: 3, scope: !176, inlinedAt: !201)
!201 = !DILocation(line: 89, scope: !202, inlinedAt: !179)
!202 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!203 = !DILocation(line: 763, scope: !204, inlinedAt: !205)
!204 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!205 = !DILocation(line: 789, scope: !206, inlinedAt: !207)
!206 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!207 = !DILocation(line: 7, scope: !208, inlinedAt: !210)
!208 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !209, file: !209, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!209 = !DIFile(filename: "number.jl", directory: ".")
!210 = !DILocation(line: 358, scope: !211, inlinedAt: !213)
!211 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!212 = !DIFile(filename: "promotion.jl", directory: ".")
!213 = !DILocation(line: 381, scope: !214, inlinedAt: !215)
!214 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!215 = !DILocation(line: 449, scope: !216, inlinedAt: !217)
!216 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!217 = !DILocation(line: 492, scope: !218, inlinedAt: !219)
!218 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!219 = !DILocation(line: 269, scope: !220, inlinedAt: !181)
!220 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !221, file: !221, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!221 = !DIFile(filename: "operators.jl", directory: ".")
!222 = !DILocation(line: 499, scope: !216, inlinedAt: !215)
!223 = !DILocation(line: 38, scope: !224, inlinedAt: !217)
!224 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!225 = !DIFile(filename: "bool.jl", directory: ".")
!226 = !DILocation(line: 35, scope: !227, inlinedAt: !219)
!227 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!228 = !DILocation(line: 93, scope: !182, inlinedAt: !183)
!229 = !DILocation(line: 37, scope: !148, inlinedAt: !230)
!230 = !DILocation(line: 124, scope: !182, inlinedAt: !183)
!231 = !DILocation(line: 27, scope: !232, inlinedAt: !233)
!232 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!233 = !DILocation(line: 37, scope: !234, inlinedAt: !235)
!234 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!235 = !DILocation(line: 36, scope: !234, inlinedAt: !230)
!236 = !DILocation(line: 499, scope: !216, inlinedAt: !237)
!237 = !DILocation(line: 38, scope: !234, inlinedAt: !235)
!238 = !DILocation(line: 499, scope: !216, inlinedAt: !239)
!239 = !DILocation(line: 40, scope: !234, inlinedAt: !235)
!240 = !DILocation(line: 40, scope: !125, inlinedAt: !241)
!241 = !DILocation(line: 0, scope: !140, inlinedAt: !242)
!242 = !DILocation(line: 0, scope: !142, inlinedAt: !243)
!243 = !DILocation(line: 11, scope: !244, inlinedAt: !245)
!244 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!245 = !DILocation(line: 31, scope: !246, inlinedAt: !247)
!246 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!247 = !DILocation(line: 41, scope: !234, inlinedAt: !235)
!248 = !DILocation(line: 37, scope: !148, inlinedAt: !243)
!249 = !DILocation(line: 30, scope: !151, inlinedAt: !243)
!250 = !DILocation(line: 126, scope: !251, inlinedAt: !252)
!251 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!252 = !DILocation(line: 126, scope: !251, inlinedAt: !253)
!253 = !DILocation(line: 33, scope: !246, inlinedAt: !247)
!254 = !{!255, !255, i64 0}
!255 = !{!"jtbaa_immut", !256, i64 0}
!256 = !{!"jtbaa_value", !257, i64 0}
!257 = !{!"jtbaa_data", !155, i64 0}
!258 = !{!162}
!259 = !{!161, !158, !163, !164}
!260 = !{!257, !257, i64 0}
!261 = !DILocation(line: 108, scope: !262, inlinedAt: !263)
!262 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!263 = !DILocation(line: 46, scope: !234, inlinedAt: !235)
!264 = !DILocation(line: 47, scope: !234, inlinedAt: !235)
!265 = !DILocation(line: 6, scope: !266, inlinedAt: !268)
!266 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !267, file: !267, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!267 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!268 = !DILocation(line: 109, scope: !182, inlinedAt: !183)
!269 = !DILocation(line: 40, scope: !125, inlinedAt: !270)
!270 = !DILocation(line: 3, scope: !173, inlinedAt: !271)
!271 = !DILocation(line: 3, scope: !176, inlinedAt: !272)
!272 = !DILocation(line: 89, scope: !178, inlinedAt: !273)
!273 = !DILocation(line: 124, scope: !180, inlinedAt: !274)
!274 = !DILocation(line: 92, scope: !182, inlinedAt: !275)
!275 = !DILocation(line: 0, scope: !140, inlinedAt: !276)
!276 = !DILocation(line: 0, scope: !277, inlinedAt: !278)
!277 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!278 = !DILocation(line: 72, scope: !187, inlinedAt: !188)
!279 = !DILocation(line: 87, scope: !134, inlinedAt: !280)
!280 = !DILocation(line: 1042, scope: !134, inlinedAt: !272)
!281 = !DILocation(line: 40, scope: !125, inlinedAt: !282)
!282 = !DILocation(line: 3, scope: !173, inlinedAt: !283)
!283 = !DILocation(line: 3, scope: !176, inlinedAt: !284)
!284 = !DILocation(line: 89, scope: !197, inlinedAt: !273)
!285 = !DILocation(line: 40, scope: !125, inlinedAt: !286)
!286 = !DILocation(line: 3, scope: !173, inlinedAt: !287)
!287 = !DILocation(line: 3, scope: !176, inlinedAt: !288)
!288 = !DILocation(line: 89, scope: !202, inlinedAt: !273)
!289 = !DILocation(line: 763, scope: !204, inlinedAt: !290)
!290 = !DILocation(line: 789, scope: !206, inlinedAt: !291)
!291 = !DILocation(line: 7, scope: !208, inlinedAt: !292)
!292 = !DILocation(line: 358, scope: !211, inlinedAt: !293)
!293 = !DILocation(line: 381, scope: !214, inlinedAt: !294)
!294 = !DILocation(line: 449, scope: !216, inlinedAt: !295)
!295 = !DILocation(line: 492, scope: !218, inlinedAt: !296)
!296 = !DILocation(line: 269, scope: !220, inlinedAt: !274)
!297 = !DILocation(line: 499, scope: !216, inlinedAt: !294)
!298 = !DILocation(line: 38, scope: !224, inlinedAt: !295)
!299 = !DILocation(line: 35, scope: !227, inlinedAt: !296)
!300 = !DILocation(line: 93, scope: !182, inlinedAt: !275)
!301 = !DILocation(line: 37, scope: !148, inlinedAt: !302)
!302 = !DILocation(line: 152, scope: !182, inlinedAt: !275)
!303 = !DILocation(line: 513, scope: !118, inlinedAt: !304)
!304 = !DILocation(line: 100, scope: !305, inlinedAt: !307)
!305 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!306 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl", directory: ".")
!307 = !DILocation(line: 114, scope: !308, inlinedAt: !302)
!308 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!309 = !DILocation(line: 513, scope: !118, inlinedAt: !310)
!310 = !DILocation(line: 102, scope: !311, inlinedAt: !312)
!311 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!312 = !DILocation(line: 471, scope: !313, inlinedAt: !307)
!313 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !119, file: !119, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!314 = !DILocation(line: 513, scope: !118, inlinedAt: !315)
!315 = !DILocation(line: 100, scope: !305, inlinedAt: !316)
!316 = !DILocation(line: 115, scope: !317, inlinedAt: !302)
!317 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!318 = !DILocation(line: 513, scope: !118, inlinedAt: !319)
!319 = !DILocation(line: 102, scope: !311, inlinedAt: !320)
!320 = !DILocation(line: 471, scope: !313, inlinedAt: !316)
!321 = !DILocation(line: 40, scope: !125, inlinedAt: !322)
!322 = !DILocation(line: 46, scope: !323, inlinedAt: !324)
!323 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!324 = !DILocation(line: 46, scope: !325, inlinedAt: !326)
!325 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!326 = !DILocation(line: 88, scope: !327, inlinedAt: !328)
!327 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!328 = !DILocation(line: 88, scope: !327, inlinedAt: !329)
!329 = !DILocation(line: 88, scope: !327, inlinedAt: !302)
!330 = !{!331, !331, i64 0, i64 0}
!331 = !{!"custom_tbaa_addrspace(1)", !332, i64 0}
!332 = !{!"custom_tbaa"}
!333 = !DILocation(line: 6, scope: !266, inlinedAt: !334)
!334 = !DILocation(line: 109, scope: !182, inlinedAt: !275)
!335 = !DILocation(line: 168, scope: !182, inlinedAt: !336)
!336 = !DILocation(line: 0, scope: !140, inlinedAt: !337)
!337 = !DILocation(line: 0, scope: !338, inlinedAt: !339)
!338 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!339 = !DILocation(line: 73, scope: !187, inlinedAt: !188)
!340 = !DILocation(line: 40, scope: !125, inlinedAt: !341)
!341 = !DILocation(line: 2, scope: !342, inlinedAt: !344)
!342 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!343 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!344 = !DILocation(line: 2, scope: !345, inlinedAt: !346)
!345 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!346 = !DILocation(line: 52, scope: !347, inlinedAt: !348)
!347 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!348 = !DILocation(line: 52, scope: !347, inlinedAt: !349)
!349 = !DILocation(line: 169, scope: !182, inlinedAt: !336)
!350 = !DILocation(line: 40, scope: !125, inlinedAt: !351)
!351 = !DILocation(line: 3, scope: !173, inlinedAt: !352)
!352 = !DILocation(line: 3, scope: !176, inlinedAt: !353)
!353 = !DILocation(line: 89, scope: !178, inlinedAt: !354)
!354 = !DILocation(line: 124, scope: !180, inlinedAt: !355)
!355 = !DILocation(line: 92, scope: !182, inlinedAt: !336)
!356 = !DILocation(line: 87, scope: !134, inlinedAt: !357)
!357 = !DILocation(line: 1042, scope: !134, inlinedAt: !353)
!358 = !DILocation(line: 40, scope: !125, inlinedAt: !359)
!359 = !DILocation(line: 3, scope: !173, inlinedAt: !360)
!360 = !DILocation(line: 3, scope: !176, inlinedAt: !361)
!361 = !DILocation(line: 89, scope: !197, inlinedAt: !354)
!362 = !DILocation(line: 40, scope: !125, inlinedAt: !363)
!363 = !DILocation(line: 3, scope: !173, inlinedAt: !364)
!364 = !DILocation(line: 3, scope: !176, inlinedAt: !365)
!365 = !DILocation(line: 89, scope: !202, inlinedAt: !354)
!366 = !DILocation(line: 763, scope: !204, inlinedAt: !367)
!367 = !DILocation(line: 789, scope: !206, inlinedAt: !368)
!368 = !DILocation(line: 7, scope: !208, inlinedAt: !369)
!369 = !DILocation(line: 358, scope: !211, inlinedAt: !370)
!370 = !DILocation(line: 381, scope: !214, inlinedAt: !371)
!371 = !DILocation(line: 449, scope: !216, inlinedAt: !372)
!372 = !DILocation(line: 492, scope: !218, inlinedAt: !373)
!373 = !DILocation(line: 269, scope: !220, inlinedAt: !355)
!374 = !DILocation(line: 499, scope: !216, inlinedAt: !371)
!375 = !DILocation(line: 38, scope: !224, inlinedAt: !372)
!376 = !DILocation(line: 35, scope: !227, inlinedAt: !373)
!377 = !DILocation(line: 93, scope: !182, inlinedAt: !336)
!378 = !DILocation(line: 37, scope: !148, inlinedAt: !379)
!379 = !DILocation(line: 174, scope: !182, inlinedAt: !336)
!380 = !DILocation(line: 27, scope: !232, inlinedAt: !381)
!381 = !DILocation(line: 37, scope: !234, inlinedAt: !382)
!382 = !DILocation(line: 36, scope: !234, inlinedAt: !379)
!383 = !DILocation(line: 499, scope: !216, inlinedAt: !384)
!384 = !DILocation(line: 38, scope: !234, inlinedAt: !382)
!385 = !DILocation(line: 499, scope: !216, inlinedAt: !386)
!386 = !DILocation(line: 40, scope: !234, inlinedAt: !382)
!387 = !DILocation(line: 40, scope: !125, inlinedAt: !388)
!388 = !DILocation(line: 0, scope: !140, inlinedAt: !389)
!389 = !DILocation(line: 0, scope: !142, inlinedAt: !390)
!390 = !DILocation(line: 11, scope: !244, inlinedAt: !391)
!391 = !DILocation(line: 31, scope: !246, inlinedAt: !392)
!392 = !DILocation(line: 41, scope: !234, inlinedAt: !382)
!393 = !DILocation(line: 37, scope: !148, inlinedAt: !390)
!394 = !DILocation(line: 30, scope: !151, inlinedAt: !390)
!395 = !DILocation(line: 126, scope: !251, inlinedAt: !396)
!396 = !DILocation(line: 126, scope: !251, inlinedAt: !397)
!397 = !DILocation(line: 33, scope: !246, inlinedAt: !392)
!398 = !DILocation(line: 108, scope: !262, inlinedAt: !399)
!399 = !DILocation(line: 46, scope: !234, inlinedAt: !382)
!400 = !DILocation(line: 47, scope: !234, inlinedAt: !382)
!401 = !DILocation(line: 37, scope: !148, inlinedAt: !402)
!402 = !DILocation(line: 176, scope: !182, inlinedAt: !336)
!403 = !DILocation(line: 12, scope: !404, inlinedAt: !405)
!404 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!405 = !DILocation(line: 61, scope: !406, inlinedAt: !407)
!406 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!407 = !DILocation(line: 60, scope: !406, inlinedAt: !402)
!408 = !DILocation(line: 499, scope: !216, inlinedAt: !409)
!409 = !DILocation(line: 62, scope: !406, inlinedAt: !407)
!410 = !DILocation(line: 499, scope: !216, inlinedAt: !411)
!411 = !DILocation(line: 64, scope: !406, inlinedAt: !407)
!412 = !DILocation(line: 40, scope: !125, inlinedAt: !413)
!413 = !DILocation(line: 0, scope: !140, inlinedAt: !414)
!414 = !DILocation(line: 0, scope: !142, inlinedAt: !415)
!415 = !DILocation(line: 11, scope: !244, inlinedAt: !416)
!416 = !DILocation(line: 31, scope: !246, inlinedAt: !417)
!417 = !DILocation(line: 65, scope: !406, inlinedAt: !407)
!418 = !DILocation(line: 37, scope: !148, inlinedAt: !415)
!419 = !DILocation(line: 30, scope: !151, inlinedAt: !415)
!420 = !DILocation(line: 126, scope: !251, inlinedAt: !421)
!421 = !DILocation(line: 126, scope: !251, inlinedAt: !422)
!422 = !DILocation(line: 33, scope: !246, inlinedAt: !417)
!423 = !DILocation(line: 108, scope: !262, inlinedAt: !424)
!424 = !DILocation(line: 70, scope: !406, inlinedAt: !407)
!425 = !DILocation(line: 71, scope: !406, inlinedAt: !407)
!426 = !DILocation(line: 178, scope: !182, inlinedAt: !336)
!427 = !DILocation(line: 37, scope: !148, inlinedAt: !428)
!428 = !DILocation(line: 179, scope: !182, inlinedAt: !336)
!429 = !DILocation(line: 513, scope: !118, inlinedAt: !428)
!430 = !DILocation(line: 40, scope: !125, inlinedAt: !431)
!431 = !DILocation(line: 9, scope: !323, inlinedAt: !432)
!432 = !DILocation(line: 9, scope: !433, inlinedAt: !434)
!433 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!434 = !DILocation(line: 85, scope: !435, inlinedAt: !436)
!435 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!436 = !DILocation(line: 85, scope: !435, inlinedAt: !437)
!437 = !DILocation(line: 85, scope: !435, inlinedAt: !438)
!438 = !DILocation(line: 180, scope: !182, inlinedAt: !336)
!439 = !DILocation(line: 513, scope: !118, inlinedAt: !440)
!440 = !DILocation(line: 100, scope: !305, inlinedAt: !441)
!441 = !DILocation(line: 181, scope: !182, inlinedAt: !336)
!442 = !DILocation(line: 499, scope: !216, inlinedAt: !443)
!443 = !DILocation(line: 492, scope: !218, inlinedAt: !441)
!444 = !DILocation(line: 38, scope: !224, inlinedAt: !443)
!445 = !DILocation(line: 37, scope: !148, inlinedAt: !446)
!446 = !DILocation(line: 182, scope: !182, inlinedAt: !336)
!447 = !DILocation(line: 19, scope: !448, inlinedAt: !449)
!448 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!449 = !DILocation(line: 19, scope: !448, inlinedAt: !446)
!450 = !DILocation(line: 40, scope: !125, inlinedAt: !451)
!451 = !DILocation(line: 0, scope: !140, inlinedAt: !452)
!452 = !DILocation(line: 0, scope: !142, inlinedAt: !453)
!453 = !DILocation(line: 11, scope: !244, inlinedAt: !454)
!454 = !DILocation(line: 31, scope: !246, inlinedAt: !455)
!455 = !DILocation(line: 183, scope: !182, inlinedAt: !336)
!456 = !DILocation(line: 37, scope: !148, inlinedAt: !453)
!457 = !DILocation(line: 30, scope: !151, inlinedAt: !453)
!458 = !DILocation(line: 126, scope: !251, inlinedAt: !459)
!459 = !DILocation(line: 126, scope: !251, inlinedAt: !460)
!460 = !DILocation(line: 33, scope: !246, inlinedAt: !455)
!461 = !DILocation(line: 1, scope: !462, inlinedAt: !464)
!462 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !463, file: !463, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!463 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!464 = !DILocation(line: 184, scope: !182, inlinedAt: !336)
!465 = !DILocation(line: 40, scope: !125, inlinedAt: !466)
!466 = !DILocation(line: 9, scope: !323, inlinedAt: !467)
!467 = !DILocation(line: 9, scope: !433, inlinedAt: !468)
!468 = !DILocation(line: 85, scope: !435, inlinedAt: !469)
!469 = !DILocation(line: 85, scope: !435, inlinedAt: !470)
!470 = !DILocation(line: 85, scope: !435, inlinedAt: !471)
!471 = !DILocation(line: 186, scope: !182, inlinedAt: !336)
!472 = !DILocation(line: 40, scope: !125, inlinedAt: !473)
!473 = !DILocation(line: 46, scope: !323, inlinedAt: !474)
!474 = !DILocation(line: 46, scope: !325, inlinedAt: !475)
!475 = !DILocation(line: 88, scope: !327, inlinedAt: !476)
!476 = !DILocation(line: 88, scope: !327, inlinedAt: !477)
!477 = !DILocation(line: 88, scope: !327, inlinedAt: !471)
!478 = !{!479, !479, i64 0, i64 0}
!479 = !{!"custom_tbaa_addrspace(3)", !332, i64 0}
!480 = !DILocation(line: 37, scope: !148, inlinedAt: !481)
!481 = !DILocation(line: 188, scope: !182, inlinedAt: !336)
!482 = !DILocation(line: 19, scope: !448, inlinedAt: !483)
!483 = !DILocation(line: 19, scope: !448, inlinedAt: !481)
!484 = !DILocation(line: 6, scope: !266, inlinedAt: !485)
!485 = !DILocation(line: 109, scope: !182, inlinedAt: !336)
!486 = !DILocation(line: 40, scope: !125, inlinedAt: !487)
!487 = !DILocation(line: 9, scope: !323, inlinedAt: !488)
!488 = !DILocation(line: 9, scope: !433, inlinedAt: !489)
!489 = !DILocation(line: 85, scope: !435, inlinedAt: !490)
!490 = !DILocation(line: 85, scope: !435, inlinedAt: !491)
!491 = !DILocation(line: 85, scope: !435, inlinedAt: !492)
!492 = !DILocation(line: 191, scope: !182, inlinedAt: !336)
!493 = !DILocation(line: 6, scope: !146, inlinedAt: !137)
!494 = !DILocation(line: 513, scope: !118, inlinedAt: !137)
!495 = !DILocation(line: 513, scope: !118, inlinedAt: !496)
!496 = !DILocation(line: 52, scope: !122, inlinedAt: !123)
!497 = !DILocation(line: 499, scope: !216, inlinedAt: !498)
!498 = !DILocation(line: 492, scope: !218, inlinedAt: !496)
!499 = !DILocation(line: 38, scope: !224, inlinedAt: !498)
!500 = !DILocation(line: 40, scope: !125, inlinedAt: !501)
!501 = !DILocation(line: 0, scope: !140, inlinedAt: !502)
!502 = !DILocation(line: 0, scope: !142, inlinedAt: !503)
!503 = !DILocation(line: 15, scope: !504, inlinedAt: !505)
!504 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!505 = !DILocation(line: 69, scope: !506, inlinedAt: !508)
!506 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!507 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!508 = !DILocation(line: 53, scope: !122, inlinedAt: !123)
!509 = !DILocation(line: 37, scope: !148, inlinedAt: !503)
!510 = !DILocation(line: 30, scope: !151, inlinedAt: !503)
!511 = !DILocation(line: 111, scope: !166, inlinedAt: !512)
!512 = !DILocation(line: 111, scope: !166, inlinedAt: !513)
!513 = !DILocation(line: 70, scope: !506, inlinedAt: !508)
!514 = !DILocation(line: 40, scope: !125, inlinedAt: !515)
!515 = !DILocation(line: 3, scope: !173, inlinedAt: !516)
!516 = !DILocation(line: 3, scope: !176, inlinedAt: !517)
!517 = !DILocation(line: 89, scope: !178, inlinedAt: !518)
!518 = !DILocation(line: 124, scope: !180, inlinedAt: !519)
!519 = !DILocation(line: 92, scope: !182, inlinedAt: !520)
!520 = !DILocation(line: 0, scope: !140, inlinedAt: !521)
!521 = !DILocation(line: 0, scope: !185, inlinedAt: !522)
!522 = !DILocation(line: 115, scope: !523, inlinedAt: !513)
!523 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!524 = !DILocation(line: 87, scope: !134, inlinedAt: !525)
!525 = !DILocation(line: 1042, scope: !134, inlinedAt: !517)
!526 = !DILocation(line: 40, scope: !125, inlinedAt: !527)
!527 = !DILocation(line: 3, scope: !173, inlinedAt: !528)
!528 = !DILocation(line: 3, scope: !176, inlinedAt: !529)
!529 = !DILocation(line: 89, scope: !197, inlinedAt: !518)
!530 = !DILocation(line: 40, scope: !125, inlinedAt: !531)
!531 = !DILocation(line: 3, scope: !173, inlinedAt: !532)
!532 = !DILocation(line: 3, scope: !176, inlinedAt: !533)
!533 = !DILocation(line: 89, scope: !202, inlinedAt: !518)
!534 = !DILocation(line: 763, scope: !204, inlinedAt: !535)
!535 = !DILocation(line: 789, scope: !206, inlinedAt: !536)
!536 = !DILocation(line: 7, scope: !208, inlinedAt: !537)
!537 = !DILocation(line: 358, scope: !211, inlinedAt: !538)
!538 = !DILocation(line: 381, scope: !214, inlinedAt: !539)
!539 = !DILocation(line: 449, scope: !216, inlinedAt: !540)
!540 = !DILocation(line: 492, scope: !218, inlinedAt: !541)
!541 = !DILocation(line: 269, scope: !220, inlinedAt: !519)
!542 = !DILocation(line: 499, scope: !216, inlinedAt: !539)
!543 = !DILocation(line: 38, scope: !224, inlinedAt: !540)
!544 = !DILocation(line: 35, scope: !227, inlinedAt: !541)
!545 = !DILocation(line: 93, scope: !182, inlinedAt: !520)
!546 = !DILocation(line: 37, scope: !148, inlinedAt: !547)
!547 = !DILocation(line: 124, scope: !182, inlinedAt: !520)
!548 = !DILocation(line: 27, scope: !232, inlinedAt: !549)
!549 = !DILocation(line: 37, scope: !234, inlinedAt: !550)
!550 = !DILocation(line: 36, scope: !234, inlinedAt: !547)
!551 = !DILocation(line: 499, scope: !216, inlinedAt: !552)
!552 = !DILocation(line: 38, scope: !234, inlinedAt: !550)
!553 = !DILocation(line: 499, scope: !216, inlinedAt: !554)
!554 = !DILocation(line: 40, scope: !234, inlinedAt: !550)
!555 = !DILocation(line: 40, scope: !125, inlinedAt: !556)
!556 = !DILocation(line: 0, scope: !140, inlinedAt: !557)
!557 = !DILocation(line: 0, scope: !142, inlinedAt: !558)
!558 = !DILocation(line: 11, scope: !244, inlinedAt: !559)
!559 = !DILocation(line: 31, scope: !246, inlinedAt: !560)
!560 = !DILocation(line: 41, scope: !234, inlinedAt: !550)
!561 = !DILocation(line: 37, scope: !148, inlinedAt: !558)
!562 = !DILocation(line: 30, scope: !151, inlinedAt: !558)
!563 = !DILocation(line: 126, scope: !251, inlinedAt: !564)
!564 = !DILocation(line: 126, scope: !251, inlinedAt: !565)
!565 = !DILocation(line: 33, scope: !246, inlinedAt: !560)
!566 = !DILocation(line: 108, scope: !262, inlinedAt: !567)
!567 = !DILocation(line: 46, scope: !234, inlinedAt: !550)
!568 = !DILocation(line: 47, scope: !234, inlinedAt: !550)
!569 = !DILocation(line: 6, scope: !266, inlinedAt: !570)
!570 = !DILocation(line: 109, scope: !182, inlinedAt: !520)
!571 = !DILocation(line: 37, scope: !148, inlinedAt: !513)
!572 = !DILocation(line: 513, scope: !118, inlinedAt: !573)
!573 = !DILocation(line: 100, scope: !305, inlinedAt: !574)
!574 = !DILocation(line: 114, scope: !308, inlinedAt: !513)
!575 = !DILocation(line: 513, scope: !118, inlinedAt: !576)
!576 = !DILocation(line: 102, scope: !311, inlinedAt: !577)
!577 = !DILocation(line: 471, scope: !313, inlinedAt: !574)
!578 = !DILocation(line: 40, scope: !125, inlinedAt: !579)
!579 = !DILocation(line: 0, scope: !140, inlinedAt: !580)
!580 = !DILocation(line: 0, scope: !581, inlinedAt: !513)
!581 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!582 = !DILocation(line: 513, scope: !118, inlinedAt: !513)
!583 = !DILocation(line: 40, scope: !125, inlinedAt: !584)
!584 = !DILocation(line: 46, scope: !323, inlinedAt: !585)
!585 = !DILocation(line: 46, scope: !325, inlinedAt: !586)
!586 = !DILocation(line: 88, scope: !327, inlinedAt: !587)
!587 = !DILocation(line: 88, scope: !327, inlinedAt: !513)
!588 = !DILocation(line: 158, scope: !589, inlinedAt: !513)
!589 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!590 = !DILocation(line: 40, scope: !125, inlinedAt: !591)
!591 = !DILocation(line: 0, scope: !140, inlinedAt: !592)
!592 = !DILocation(line: 0, scope: !581, inlinedAt: !593)
!593 = !DILocation(line: 57, scope: !122, inlinedAt: !123)
!594 = !DILocation(line: 513, scope: !118, inlinedAt: !595)
!595 = !DILocation(line: 100, scope: !305, inlinedAt: !596)
!596 = !DILocation(line: 114, scope: !308, inlinedAt: !597)
!597 = !DILocation(line: 59, scope: !122, inlinedAt: !123)
!598 = !DILocation(line: 513, scope: !118, inlinedAt: !599)
!599 = !DILocation(line: 102, scope: !311, inlinedAt: !600)
!600 = !DILocation(line: 471, scope: !313, inlinedAt: !596)
!601 = !DILocation(line: 40, scope: !125, inlinedAt: !602)
!602 = !DILocation(line: 46, scope: !323, inlinedAt: !603)
!603 = !DILocation(line: 46, scope: !325, inlinedAt: !604)
!604 = !DILocation(line: 88, scope: !327, inlinedAt: !605)
!605 = !DILocation(line: 88, scope: !327, inlinedAt: !606)
!606 = !DILocation(line: 88, scope: !327, inlinedAt: !597)
!607 = !DILocation(line: 513, scope: !118, inlinedAt: !608)
!608 = !DILocation(line: 60, scope: !122, inlinedAt: !123)
!609 = !DILocation(line: 40, scope: !125, inlinedAt: !610)
!610 = !DILocation(line: 0, scope: !140, inlinedAt: !611)
!611 = !DILocation(line: 0, scope: !142, inlinedAt: !612)
!612 = !DILocation(line: 19, scope: !613, inlinedAt: !614)
!613 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!614 = !DILocation(line: 187, scope: !506, inlinedAt: !615)
!615 = !DILocation(line: 80, scope: !107)
!616 = !DILocation(line: 37, scope: !148, inlinedAt: !612)
!617 = !DILocation(line: 30, scope: !151, inlinedAt: !612)
!618 = !DILocation(line: 111, scope: !166, inlinedAt: !619)
!619 = !DILocation(line: 111, scope: !166, inlinedAt: !614)
!620 = !DILocation(line: 37, scope: !148, inlinedAt: !621)
!621 = !DILocation(line: 188, scope: !506, inlinedAt: !615)
!622 = !DILocation(line: 513, scope: !118, inlinedAt: !621)
!623 = !DILocation(line: 40, scope: !125, inlinedAt: !624)
!624 = !DILocation(line: 3, scope: !173, inlinedAt: !625)
!625 = !DILocation(line: 3, scope: !176, inlinedAt: !626)
!626 = !DILocation(line: 89, scope: !178, inlinedAt: !627)
!627 = !DILocation(line: 124, scope: !180, inlinedAt: !628)
!628 = !DILocation(line: 92, scope: !182, inlinedAt: !629)
!629 = !DILocation(line: 0, scope: !140, inlinedAt: !630)
!630 = !DILocation(line: 0, scope: !185, inlinedAt: !631)
!631 = !DILocation(line: 115, scope: !523, inlinedAt: !632)
!632 = !DILocation(line: 193, scope: !506, inlinedAt: !615)
!633 = !DILocation(line: 87, scope: !134, inlinedAt: !634)
!634 = !DILocation(line: 1042, scope: !134, inlinedAt: !626)
!635 = !DILocation(line: 40, scope: !125, inlinedAt: !636)
!636 = !DILocation(line: 3, scope: !173, inlinedAt: !637)
!637 = !DILocation(line: 3, scope: !176, inlinedAt: !638)
!638 = !DILocation(line: 89, scope: !197, inlinedAt: !627)
!639 = !DILocation(line: 40, scope: !125, inlinedAt: !640)
!640 = !DILocation(line: 3, scope: !173, inlinedAt: !641)
!641 = !DILocation(line: 3, scope: !176, inlinedAt: !642)
!642 = !DILocation(line: 89, scope: !202, inlinedAt: !627)
!643 = !DILocation(line: 763, scope: !204, inlinedAt: !644)
!644 = !DILocation(line: 789, scope: !206, inlinedAt: !645)
!645 = !DILocation(line: 7, scope: !208, inlinedAt: !646)
!646 = !DILocation(line: 358, scope: !211, inlinedAt: !647)
!647 = !DILocation(line: 381, scope: !214, inlinedAt: !648)
!648 = !DILocation(line: 449, scope: !216, inlinedAt: !649)
!649 = !DILocation(line: 492, scope: !218, inlinedAt: !650)
!650 = !DILocation(line: 269, scope: !220, inlinedAt: !628)
!651 = !DILocation(line: 499, scope: !216, inlinedAt: !648)
!652 = !DILocation(line: 38, scope: !224, inlinedAt: !649)
!653 = !DILocation(line: 35, scope: !227, inlinedAt: !650)
!654 = !DILocation(line: 93, scope: !182, inlinedAt: !629)
!655 = !DILocation(line: 37, scope: !148, inlinedAt: !656)
!656 = !DILocation(line: 124, scope: !182, inlinedAt: !629)
!657 = !DILocation(line: 27, scope: !232, inlinedAt: !658)
!658 = !DILocation(line: 37, scope: !234, inlinedAt: !659)
!659 = !DILocation(line: 36, scope: !234, inlinedAt: !656)
!660 = !DILocation(line: 499, scope: !216, inlinedAt: !661)
!661 = !DILocation(line: 38, scope: !234, inlinedAt: !659)
!662 = !DILocation(line: 499, scope: !216, inlinedAt: !663)
!663 = !DILocation(line: 40, scope: !234, inlinedAt: !659)
!664 = !DILocation(line: 40, scope: !125, inlinedAt: !665)
!665 = !DILocation(line: 0, scope: !140, inlinedAt: !666)
!666 = !DILocation(line: 0, scope: !142, inlinedAt: !667)
!667 = !DILocation(line: 11, scope: !244, inlinedAt: !668)
!668 = !DILocation(line: 31, scope: !246, inlinedAt: !669)
!669 = !DILocation(line: 41, scope: !234, inlinedAt: !659)
!670 = !DILocation(line: 37, scope: !148, inlinedAt: !667)
!671 = !DILocation(line: 30, scope: !151, inlinedAt: !667)
!672 = !DILocation(line: 126, scope: !251, inlinedAt: !673)
!673 = !DILocation(line: 126, scope: !251, inlinedAt: !674)
!674 = !DILocation(line: 33, scope: !246, inlinedAt: !669)
!675 = !DILocation(line: 108, scope: !262, inlinedAt: !676)
!676 = !DILocation(line: 46, scope: !234, inlinedAt: !659)
!677 = !DILocation(line: 47, scope: !234, inlinedAt: !659)
!678 = !DILocation(line: 6, scope: !266, inlinedAt: !679)
!679 = !DILocation(line: 109, scope: !182, inlinedAt: !629)
!680 = !DILocation(line: 40, scope: !125, inlinedAt: !681)
!681 = !DILocation(line: 46, scope: !323, inlinedAt: !682)
!682 = !DILocation(line: 46, scope: !325, inlinedAt: !683)
!683 = !DILocation(line: 88, scope: !327, inlinedAt: !684)
!684 = !DILocation(line: 88, scope: !327, inlinedAt: !685)
!685 = !DILocation(line: 88, scope: !327, inlinedAt: !686)
!686 = !DILocation(line: 195, scope: !506, inlinedAt: !615)
!687 = !DILocation(line: 513, scope: !118, inlinedAt: !688)
!688 = !DILocation(line: 100, scope: !305, inlinedAt: !689)
!689 = !DILocation(line: 114, scope: !308, inlinedAt: !690)
!690 = !DILocation(line: 196, scope: !506, inlinedAt: !615)
!691 = !DILocation(line: 513, scope: !118, inlinedAt: !692)
!692 = !DILocation(line: 102, scope: !311, inlinedAt: !693)
!693 = !DILocation(line: 471, scope: !313, inlinedAt: !689)
!694 = !DILocation(line: 513, scope: !118, inlinedAt: !695)
!695 = !DILocation(line: 153, scope: !696, inlinedAt: !697)
!696 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!697 = !DILocation(line: 198, scope: !506, inlinedAt: !615)
!698 = !DILocation(line: 40, scope: !125, inlinedAt: !699)
!699 = !DILocation(line: 46, scope: !323, inlinedAt: !700)
!700 = !DILocation(line: 46, scope: !325, inlinedAt: !701)
!701 = !DILocation(line: 88, scope: !327, inlinedAt: !702)
!702 = !DILocation(line: 88, scope: !327, inlinedAt: !703)
!703 = !DILocation(line: 88, scope: !327, inlinedAt: !695)
!704 = !DILocation(line: 513, scope: !118, inlinedAt: !705)
!705 = !DILocation(line: 100, scope: !305, inlinedAt: !706)
!706 = !DILocation(line: 114, scope: !308, inlinedAt: !707)
!707 = !DILocation(line: 154, scope: !696, inlinedAt: !697)
!708 = !DILocation(line: 513, scope: !118, inlinedAt: !709)
!709 = !DILocation(line: 102, scope: !311, inlinedAt: !710)
!710 = !DILocation(line: 471, scope: !313, inlinedAt: !706)
!711 = !DILocation(line: 40, scope: !125, inlinedAt: !712)
!712 = !DILocation(line: 46, scope: !323, inlinedAt: !713)
!713 = !DILocation(line: 46, scope: !325, inlinedAt: !714)
!714 = !DILocation(line: 88, scope: !327, inlinedAt: !715)
!715 = !DILocation(line: 88, scope: !327, inlinedAt: !716)
!716 = !DILocation(line: 88, scope: !327, inlinedAt: !717)
!717 = !DILocation(line: 155, scope: !696, inlinedAt: !697)
!718 = !DILocation(line: 513, scope: !118, inlinedAt: !719)
!719 = !DILocation(line: 100, scope: !305, inlinedAt: !720)
!720 = !DILocation(line: 114, scope: !308, inlinedAt: !721)
!721 = !DILocation(line: 156, scope: !696, inlinedAt: !697)
!722 = !DILocation(line: 513, scope: !118, inlinedAt: !723)
!723 = !DILocation(line: 102, scope: !311, inlinedAt: !724)
!724 = !DILocation(line: 471, scope: !313, inlinedAt: !720)
!725 = !DILocation(line: 40, scope: !125, inlinedAt: !726)
!726 = !DILocation(line: 3, scope: !173, inlinedAt: !727)
!727 = !DILocation(line: 3, scope: !176, inlinedAt: !728)
!728 = !DILocation(line: 89, scope: !178, inlinedAt: !729)
!729 = !DILocation(line: 124, scope: !180, inlinedAt: !730)
!730 = !DILocation(line: 92, scope: !182, inlinedAt: !731)
!731 = !DILocation(line: 201, scope: !506, inlinedAt: !615)
!732 = !DILocation(line: 87, scope: !134, inlinedAt: !733)
!733 = !DILocation(line: 1042, scope: !134, inlinedAt: !728)
!734 = !DILocation(line: 40, scope: !125, inlinedAt: !735)
!735 = !DILocation(line: 3, scope: !173, inlinedAt: !736)
!736 = !DILocation(line: 3, scope: !176, inlinedAt: !737)
!737 = !DILocation(line: 89, scope: !197, inlinedAt: !729)
!738 = !DILocation(line: 40, scope: !125, inlinedAt: !739)
!739 = !DILocation(line: 3, scope: !173, inlinedAt: !740)
!740 = !DILocation(line: 3, scope: !176, inlinedAt: !741)
!741 = !DILocation(line: 89, scope: !202, inlinedAt: !729)
!742 = !DILocation(line: 763, scope: !204, inlinedAt: !743)
!743 = !DILocation(line: 789, scope: !206, inlinedAt: !744)
!744 = !DILocation(line: 7, scope: !208, inlinedAt: !745)
!745 = !DILocation(line: 358, scope: !211, inlinedAt: !746)
!746 = !DILocation(line: 381, scope: !214, inlinedAt: !747)
!747 = !DILocation(line: 449, scope: !216, inlinedAt: !748)
!748 = !DILocation(line: 492, scope: !218, inlinedAt: !749)
!749 = !DILocation(line: 269, scope: !220, inlinedAt: !730)
!750 = !DILocation(line: 499, scope: !216, inlinedAt: !747)
!751 = !DILocation(line: 38, scope: !224, inlinedAt: !748)
!752 = !DILocation(line: 35, scope: !227, inlinedAt: !749)
!753 = !DILocation(line: 93, scope: !182, inlinedAt: !731)
!754 = !DILocation(line: 40, scope: !125, inlinedAt: !755)
!755 = !DILocation(line: 46, scope: !323, inlinedAt: !756)
!756 = !DILocation(line: 46, scope: !325, inlinedAt: !757)
!757 = !DILocation(line: 88, scope: !327, inlinedAt: !758)
!758 = !DILocation(line: 88, scope: !327, inlinedAt: !759)
!759 = !DILocation(line: 88, scope: !327, inlinedAt: !760)
!760 = !DILocation(line: 166, scope: !761, inlinedAt: !762)
!761 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!762 = !DILocation(line: 107, scope: !182, inlinedAt: !731)
!763 = !DILocation(line: 513, scope: !118, inlinedAt: !764)
!764 = !DILocation(line: 100, scope: !305, inlinedAt: !765)
!765 = !DILocation(line: 114, scope: !308, inlinedAt: !766)
!766 = !DILocation(line: 167, scope: !761, inlinedAt: !762)
!767 = !DILocation(line: 513, scope: !118, inlinedAt: !768)
!768 = !DILocation(line: 102, scope: !311, inlinedAt: !769)
!769 = !DILocation(line: 471, scope: !313, inlinedAt: !765)
!770 = !DILocation(line: 40, scope: !125, inlinedAt: !771)
!771 = !DILocation(line: 46, scope: !323, inlinedAt: !772)
!772 = !DILocation(line: 46, scope: !325, inlinedAt: !773)
!773 = !DILocation(line: 88, scope: !327, inlinedAt: !774)
!774 = !DILocation(line: 88, scope: !327, inlinedAt: !775)
!775 = !DILocation(line: 88, scope: !327, inlinedAt: !776)
!776 = !DILocation(line: 169, scope: !761, inlinedAt: !762)
!777 = !DILocation(line: 513, scope: !118, inlinedAt: !778)
!778 = !DILocation(line: 100, scope: !305, inlinedAt: !779)
!779 = !DILocation(line: 114, scope: !308, inlinedAt: !780)
!780 = !DILocation(line: 170, scope: !761, inlinedAt: !762)
!781 = !DILocation(line: 513, scope: !118, inlinedAt: !782)
!782 = !DILocation(line: 102, scope: !311, inlinedAt: !783)
!783 = !DILocation(line: 471, scope: !313, inlinedAt: !779)
!784 = !DILocation(line: 40, scope: !125, inlinedAt: !785)
!785 = !DILocation(line: 46, scope: !323, inlinedAt: !786)
!786 = !DILocation(line: 46, scope: !325, inlinedAt: !787)
!787 = !DILocation(line: 88, scope: !327, inlinedAt: !788)
!788 = !DILocation(line: 88, scope: !327, inlinedAt: !789)
!789 = !DILocation(line: 88, scope: !327, inlinedAt: !762)
!790 = !DILocation(line: 6, scope: !266, inlinedAt: !791)
!791 = !DILocation(line: 109, scope: !182, inlinedAt: !731)
!792 = !DILocation(line: 40, scope: !125, inlinedAt: !793)
!793 = !DILocation(line: 3, scope: !173, inlinedAt: !794)
!794 = !DILocation(line: 3, scope: !176, inlinedAt: !795)
!795 = !DILocation(line: 89, scope: !178, inlinedAt: !796)
!796 = !DILocation(line: 124, scope: !180, inlinedAt: !797)
!797 = !DILocation(line: 92, scope: !182, inlinedAt: !798)
!798 = !DILocation(line: 0, scope: !140, inlinedAt: !799)
!799 = !DILocation(line: 0, scope: !338, inlinedAt: !800)
!800 = !DILocation(line: 158, scope: !589, inlinedAt: !731)
!801 = !DILocation(line: 87, scope: !134, inlinedAt: !802)
!802 = !DILocation(line: 1042, scope: !134, inlinedAt: !795)
!803 = !DILocation(line: 40, scope: !125, inlinedAt: !804)
!804 = !DILocation(line: 3, scope: !173, inlinedAt: !805)
!805 = !DILocation(line: 3, scope: !176, inlinedAt: !806)
!806 = !DILocation(line: 89, scope: !197, inlinedAt: !796)
!807 = !DILocation(line: 40, scope: !125, inlinedAt: !808)
!808 = !DILocation(line: 3, scope: !173, inlinedAt: !809)
!809 = !DILocation(line: 3, scope: !176, inlinedAt: !810)
!810 = !DILocation(line: 89, scope: !202, inlinedAt: !796)
!811 = !DILocation(line: 763, scope: !204, inlinedAt: !812)
!812 = !DILocation(line: 789, scope: !206, inlinedAt: !813)
!813 = !DILocation(line: 7, scope: !208, inlinedAt: !814)
!814 = !DILocation(line: 358, scope: !211, inlinedAt: !815)
!815 = !DILocation(line: 381, scope: !214, inlinedAt: !816)
!816 = !DILocation(line: 449, scope: !216, inlinedAt: !817)
!817 = !DILocation(line: 492, scope: !218, inlinedAt: !818)
!818 = !DILocation(line: 269, scope: !220, inlinedAt: !797)
!819 = !DILocation(line: 499, scope: !216, inlinedAt: !816)
!820 = !DILocation(line: 38, scope: !224, inlinedAt: !817)
!821 = !DILocation(line: 35, scope: !227, inlinedAt: !818)
!822 = !DILocation(line: 93, scope: !182, inlinedAt: !798)
!823 = !DILocation(line: 37, scope: !148, inlinedAt: !824)
!824 = !DILocation(line: 174, scope: !182, inlinedAt: !798)
!825 = !DILocation(line: 27, scope: !232, inlinedAt: !826)
!826 = !DILocation(line: 37, scope: !234, inlinedAt: !827)
!827 = !DILocation(line: 36, scope: !234, inlinedAt: !824)
!828 = !DILocation(line: 499, scope: !216, inlinedAt: !829)
!829 = !DILocation(line: 38, scope: !234, inlinedAt: !827)
!830 = !DILocation(line: 499, scope: !216, inlinedAt: !831)
!831 = !DILocation(line: 40, scope: !234, inlinedAt: !827)
!832 = !DILocation(line: 40, scope: !125, inlinedAt: !833)
!833 = !DILocation(line: 0, scope: !140, inlinedAt: !834)
!834 = !DILocation(line: 0, scope: !142, inlinedAt: !835)
!835 = !DILocation(line: 11, scope: !244, inlinedAt: !836)
!836 = !DILocation(line: 31, scope: !246, inlinedAt: !837)
!837 = !DILocation(line: 41, scope: !234, inlinedAt: !827)
!838 = !DILocation(line: 37, scope: !148, inlinedAt: !835)
!839 = !DILocation(line: 30, scope: !151, inlinedAt: !835)
!840 = !DILocation(line: 126, scope: !251, inlinedAt: !841)
!841 = !DILocation(line: 126, scope: !251, inlinedAt: !842)
!842 = !DILocation(line: 33, scope: !246, inlinedAt: !837)
!843 = !DILocation(line: 108, scope: !262, inlinedAt: !844)
!844 = !DILocation(line: 46, scope: !234, inlinedAt: !827)
!845 = !DILocation(line: 47, scope: !234, inlinedAt: !827)
!846 = !DILocation(line: 37, scope: !148, inlinedAt: !847)
!847 = !DILocation(line: 176, scope: !182, inlinedAt: !798)
!848 = !DILocation(line: 12, scope: !404, inlinedAt: !849)
!849 = !DILocation(line: 61, scope: !406, inlinedAt: !850)
!850 = !DILocation(line: 60, scope: !406, inlinedAt: !847)
!851 = !DILocation(line: 499, scope: !216, inlinedAt: !852)
!852 = !DILocation(line: 62, scope: !406, inlinedAt: !850)
!853 = !DILocation(line: 499, scope: !216, inlinedAt: !854)
!854 = !DILocation(line: 64, scope: !406, inlinedAt: !850)
!855 = !DILocation(line: 40, scope: !125, inlinedAt: !856)
!856 = !DILocation(line: 0, scope: !140, inlinedAt: !857)
!857 = !DILocation(line: 0, scope: !142, inlinedAt: !858)
!858 = !DILocation(line: 11, scope: !244, inlinedAt: !859)
!859 = !DILocation(line: 31, scope: !246, inlinedAt: !860)
!860 = !DILocation(line: 65, scope: !406, inlinedAt: !850)
!861 = !DILocation(line: 37, scope: !148, inlinedAt: !858)
!862 = !DILocation(line: 30, scope: !151, inlinedAt: !858)
!863 = !DILocation(line: 126, scope: !251, inlinedAt: !864)
!864 = !DILocation(line: 126, scope: !251, inlinedAt: !865)
!865 = !DILocation(line: 33, scope: !246, inlinedAt: !860)
!866 = !DILocation(line: 108, scope: !262, inlinedAt: !867)
!867 = !DILocation(line: 70, scope: !406, inlinedAt: !850)
!868 = !DILocation(line: 71, scope: !406, inlinedAt: !850)
!869 = !DILocation(line: 37, scope: !148, inlinedAt: !870)
!870 = !DILocation(line: 188, scope: !182, inlinedAt: !798)
!871 = !DILocation(line: 19, scope: !448, inlinedAt: !872)
!872 = !DILocation(line: 19, scope: !448, inlinedAt: !870)
!873 = !DILocation(line: 6, scope: !266, inlinedAt: !874)
!874 = !DILocation(line: 109, scope: !182, inlinedAt: !798)
!875 = !DILocation(line: 40, scope: !125, inlinedAt: !876)
!876 = !DILocation(line: 0, scope: !140, inlinedAt: !877)
!877 = !DILocation(line: 0, scope: !142, inlinedAt: !878)
!878 = !DILocation(line: 27, scope: !879, inlinedAt: !880)
!879 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!880 = !DILocation(line: 10, scope: !881, inlinedAt: !882)
!881 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !69)
!882 = !DILocation(line: 84, scope: !107)
!883 = !DILocation(line: 37, scope: !148, inlinedAt: !878)
!884 = !DILocation(line: 30, scope: !151, inlinedAt: !878)
!885 = !DILocation(line: 111, scope: !166, inlinedAt: !886)
!886 = !DILocation(line: 111, scope: !166, inlinedAt: !880)
!887 = !DILocation(line: 40, scope: !125, inlinedAt: !888)
!888 = !DILocation(line: 3, scope: !173, inlinedAt: !889)
!889 = !DILocation(line: 3, scope: !176, inlinedAt: !890)
!890 = !DILocation(line: 89, scope: !178, inlinedAt: !891)
!891 = !DILocation(line: 124, scope: !180, inlinedAt: !892)
!892 = !DILocation(line: 92, scope: !182, inlinedAt: !893)
!893 = !DILocation(line: 0, scope: !140, inlinedAt: !894)
!894 = !DILocation(line: 0, scope: !185, inlinedAt: !895)
!895 = !DILocation(line: 71, scope: !187, inlinedAt: !896)
!896 = !DILocation(line: 65, scope: !187, inlinedAt: !897)
!897 = !DILocation(line: 11, scope: !881, inlinedAt: !882)
!898 = !DILocation(line: 87, scope: !134, inlinedAt: !899)
!899 = !DILocation(line: 1042, scope: !134, inlinedAt: !890)
!900 = !DILocation(line: 40, scope: !125, inlinedAt: !901)
!901 = !DILocation(line: 3, scope: !173, inlinedAt: !902)
!902 = !DILocation(line: 3, scope: !176, inlinedAt: !903)
!903 = !DILocation(line: 89, scope: !197, inlinedAt: !891)
!904 = !DILocation(line: 40, scope: !125, inlinedAt: !905)
!905 = !DILocation(line: 3, scope: !173, inlinedAt: !906)
!906 = !DILocation(line: 3, scope: !176, inlinedAt: !907)
!907 = !DILocation(line: 89, scope: !202, inlinedAt: !891)
!908 = !DILocation(line: 763, scope: !204, inlinedAt: !909)
!909 = !DILocation(line: 789, scope: !206, inlinedAt: !910)
!910 = !DILocation(line: 7, scope: !208, inlinedAt: !911)
!911 = !DILocation(line: 358, scope: !211, inlinedAt: !912)
!912 = !DILocation(line: 381, scope: !214, inlinedAt: !913)
!913 = !DILocation(line: 449, scope: !216, inlinedAt: !914)
!914 = !DILocation(line: 492, scope: !218, inlinedAt: !915)
!915 = !DILocation(line: 269, scope: !220, inlinedAt: !892)
!916 = !DILocation(line: 499, scope: !216, inlinedAt: !913)
!917 = !DILocation(line: 38, scope: !224, inlinedAt: !914)
!918 = !DILocation(line: 35, scope: !227, inlinedAt: !915)
!919 = !DILocation(line: 93, scope: !182, inlinedAt: !893)
!920 = !DILocation(line: 37, scope: !148, inlinedAt: !921)
!921 = !DILocation(line: 124, scope: !182, inlinedAt: !893)
!922 = !DILocation(line: 27, scope: !232, inlinedAt: !923)
!923 = !DILocation(line: 37, scope: !234, inlinedAt: !924)
!924 = !DILocation(line: 36, scope: !234, inlinedAt: !921)
!925 = !DILocation(line: 499, scope: !216, inlinedAt: !926)
!926 = !DILocation(line: 38, scope: !234, inlinedAt: !924)
!927 = !DILocation(line: 499, scope: !216, inlinedAt: !928)
!928 = !DILocation(line: 40, scope: !234, inlinedAt: !924)
!929 = !DILocation(line: 40, scope: !125, inlinedAt: !930)
!930 = !DILocation(line: 0, scope: !140, inlinedAt: !931)
!931 = !DILocation(line: 0, scope: !142, inlinedAt: !932)
!932 = !DILocation(line: 11, scope: !244, inlinedAt: !933)
!933 = !DILocation(line: 31, scope: !246, inlinedAt: !934)
!934 = !DILocation(line: 41, scope: !234, inlinedAt: !924)
!935 = !DILocation(line: 37, scope: !148, inlinedAt: !932)
!936 = !DILocation(line: 30, scope: !151, inlinedAt: !932)
!937 = !DILocation(line: 126, scope: !251, inlinedAt: !938)
!938 = !DILocation(line: 126, scope: !251, inlinedAt: !939)
!939 = !DILocation(line: 33, scope: !246, inlinedAt: !934)
!940 = !DILocation(line: 108, scope: !262, inlinedAt: !941)
!941 = !DILocation(line: 46, scope: !234, inlinedAt: !924)
!942 = !DILocation(line: 47, scope: !234, inlinedAt: !924)
!943 = !DILocation(line: 6, scope: !266, inlinedAt: !944)
!944 = !DILocation(line: 109, scope: !182, inlinedAt: !893)
!945 = !DILocation(line: 40, scope: !125, inlinedAt: !946)
!946 = !DILocation(line: 3, scope: !173, inlinedAt: !947)
!947 = !DILocation(line: 3, scope: !176, inlinedAt: !948)
!948 = !DILocation(line: 89, scope: !178, inlinedAt: !949)
!949 = !DILocation(line: 124, scope: !180, inlinedAt: !950)
!950 = !DILocation(line: 92, scope: !182, inlinedAt: !951)
!951 = !DILocation(line: 0, scope: !140, inlinedAt: !952)
!952 = !DILocation(line: 0, scope: !277, inlinedAt: !953)
!953 = !DILocation(line: 72, scope: !187, inlinedAt: !896)
!954 = !DILocation(line: 87, scope: !134, inlinedAt: !955)
!955 = !DILocation(line: 1042, scope: !134, inlinedAt: !948)
!956 = !DILocation(line: 40, scope: !125, inlinedAt: !957)
!957 = !DILocation(line: 3, scope: !173, inlinedAt: !958)
!958 = !DILocation(line: 3, scope: !176, inlinedAt: !959)
!959 = !DILocation(line: 89, scope: !197, inlinedAt: !949)
!960 = !DILocation(line: 40, scope: !125, inlinedAt: !961)
!961 = !DILocation(line: 3, scope: !173, inlinedAt: !962)
!962 = !DILocation(line: 3, scope: !176, inlinedAt: !963)
!963 = !DILocation(line: 89, scope: !202, inlinedAt: !949)
!964 = !DILocation(line: 763, scope: !204, inlinedAt: !965)
!965 = !DILocation(line: 789, scope: !206, inlinedAt: !966)
!966 = !DILocation(line: 7, scope: !208, inlinedAt: !967)
!967 = !DILocation(line: 358, scope: !211, inlinedAt: !968)
!968 = !DILocation(line: 381, scope: !214, inlinedAt: !969)
!969 = !DILocation(line: 449, scope: !216, inlinedAt: !970)
!970 = !DILocation(line: 492, scope: !218, inlinedAt: !971)
!971 = !DILocation(line: 269, scope: !220, inlinedAt: !950)
!972 = !DILocation(line: 499, scope: !216, inlinedAt: !969)
!973 = !DILocation(line: 38, scope: !224, inlinedAt: !970)
!974 = !DILocation(line: 35, scope: !227, inlinedAt: !971)
!975 = !DILocation(line: 93, scope: !182, inlinedAt: !951)
!976 = !DILocation(line: 37, scope: !148, inlinedAt: !977)
!977 = !DILocation(line: 152, scope: !182, inlinedAt: !951)
!978 = !DILocation(line: 513, scope: !118, inlinedAt: !979)
!979 = !DILocation(line: 100, scope: !305, inlinedAt: !980)
!980 = !DILocation(line: 114, scope: !308, inlinedAt: !977)
!981 = !DILocation(line: 513, scope: !118, inlinedAt: !982)
!982 = !DILocation(line: 102, scope: !311, inlinedAt: !983)
!983 = !DILocation(line: 471, scope: !313, inlinedAt: !980)
!984 = !DILocation(line: 513, scope: !118, inlinedAt: !985)
!985 = !DILocation(line: 100, scope: !305, inlinedAt: !986)
!986 = !DILocation(line: 115, scope: !317, inlinedAt: !977)
!987 = !DILocation(line: 513, scope: !118, inlinedAt: !988)
!988 = !DILocation(line: 102, scope: !311, inlinedAt: !989)
!989 = !DILocation(line: 471, scope: !313, inlinedAt: !986)
!990 = !DILocation(line: 40, scope: !125, inlinedAt: !991)
!991 = !DILocation(line: 46, scope: !323, inlinedAt: !992)
!992 = !DILocation(line: 46, scope: !325, inlinedAt: !993)
!993 = !DILocation(line: 88, scope: !327, inlinedAt: !994)
!994 = !DILocation(line: 88, scope: !327, inlinedAt: !995)
!995 = !DILocation(line: 88, scope: !327, inlinedAt: !977)
!996 = !DILocation(line: 6, scope: !266, inlinedAt: !997)
!997 = !DILocation(line: 109, scope: !182, inlinedAt: !951)
!998 = !DILocation(line: 40, scope: !125, inlinedAt: !999)
!999 = !DILocation(line: 3, scope: !173, inlinedAt: !1000)
!1000 = !DILocation(line: 3, scope: !176, inlinedAt: !1001)
!1001 = !DILocation(line: 89, scope: !178, inlinedAt: !1002)
!1002 = !DILocation(line: 124, scope: !180, inlinedAt: !1003)
!1003 = !DILocation(line: 92, scope: !182, inlinedAt: !1004)
!1004 = !DILocation(line: 0, scope: !140, inlinedAt: !1005)
!1005 = !DILocation(line: 0, scope: !338, inlinedAt: !1006)
!1006 = !DILocation(line: 73, scope: !187, inlinedAt: !896)
!1007 = !DILocation(line: 87, scope: !134, inlinedAt: !1008)
!1008 = !DILocation(line: 1042, scope: !134, inlinedAt: !1001)
!1009 = !DILocation(line: 40, scope: !125, inlinedAt: !1010)
!1010 = !DILocation(line: 3, scope: !173, inlinedAt: !1011)
!1011 = !DILocation(line: 3, scope: !176, inlinedAt: !1012)
!1012 = !DILocation(line: 89, scope: !197, inlinedAt: !1002)
!1013 = !DILocation(line: 40, scope: !125, inlinedAt: !1014)
!1014 = !DILocation(line: 3, scope: !173, inlinedAt: !1015)
!1015 = !DILocation(line: 3, scope: !176, inlinedAt: !1016)
!1016 = !DILocation(line: 89, scope: !202, inlinedAt: !1002)
!1017 = !DILocation(line: 763, scope: !204, inlinedAt: !1018)
!1018 = !DILocation(line: 789, scope: !206, inlinedAt: !1019)
!1019 = !DILocation(line: 7, scope: !208, inlinedAt: !1020)
!1020 = !DILocation(line: 358, scope: !211, inlinedAt: !1021)
!1021 = !DILocation(line: 381, scope: !214, inlinedAt: !1022)
!1022 = !DILocation(line: 449, scope: !216, inlinedAt: !1023)
!1023 = !DILocation(line: 492, scope: !218, inlinedAt: !1024)
!1024 = !DILocation(line: 269, scope: !220, inlinedAt: !1003)
!1025 = !DILocation(line: 499, scope: !216, inlinedAt: !1022)
!1026 = !DILocation(line: 38, scope: !224, inlinedAt: !1023)
!1027 = !DILocation(line: 35, scope: !227, inlinedAt: !1024)
!1028 = !DILocation(line: 93, scope: !182, inlinedAt: !1004)
!1029 = !DILocation(line: 37, scope: !148, inlinedAt: !1030)
!1030 = !DILocation(line: 174, scope: !182, inlinedAt: !1004)
!1031 = !DILocation(line: 27, scope: !232, inlinedAt: !1032)
!1032 = !DILocation(line: 37, scope: !234, inlinedAt: !1033)
!1033 = !DILocation(line: 36, scope: !234, inlinedAt: !1030)
!1034 = !DILocation(line: 499, scope: !216, inlinedAt: !1035)
!1035 = !DILocation(line: 38, scope: !234, inlinedAt: !1033)
!1036 = !DILocation(line: 499, scope: !216, inlinedAt: !1037)
!1037 = !DILocation(line: 40, scope: !234, inlinedAt: !1033)
!1038 = !DILocation(line: 40, scope: !125, inlinedAt: !1039)
!1039 = !DILocation(line: 0, scope: !140, inlinedAt: !1040)
!1040 = !DILocation(line: 0, scope: !142, inlinedAt: !1041)
!1041 = !DILocation(line: 11, scope: !244, inlinedAt: !1042)
!1042 = !DILocation(line: 31, scope: !246, inlinedAt: !1043)
!1043 = !DILocation(line: 41, scope: !234, inlinedAt: !1033)
!1044 = !DILocation(line: 37, scope: !148, inlinedAt: !1041)
!1045 = !DILocation(line: 30, scope: !151, inlinedAt: !1041)
!1046 = !DILocation(line: 126, scope: !251, inlinedAt: !1047)
!1047 = !DILocation(line: 126, scope: !251, inlinedAt: !1048)
!1048 = !DILocation(line: 33, scope: !246, inlinedAt: !1043)
!1049 = !DILocation(line: 108, scope: !262, inlinedAt: !1050)
!1050 = !DILocation(line: 46, scope: !234, inlinedAt: !1033)
!1051 = !DILocation(line: 47, scope: !234, inlinedAt: !1033)
!1052 = !DILocation(line: 37, scope: !148, inlinedAt: !1053)
!1053 = !DILocation(line: 176, scope: !182, inlinedAt: !1004)
!1054 = !DILocation(line: 12, scope: !404, inlinedAt: !1055)
!1055 = !DILocation(line: 61, scope: !406, inlinedAt: !1056)
!1056 = !DILocation(line: 60, scope: !406, inlinedAt: !1053)
!1057 = !DILocation(line: 499, scope: !216, inlinedAt: !1058)
!1058 = !DILocation(line: 62, scope: !406, inlinedAt: !1056)
!1059 = !DILocation(line: 499, scope: !216, inlinedAt: !1060)
!1060 = !DILocation(line: 64, scope: !406, inlinedAt: !1056)
!1061 = !DILocation(line: 40, scope: !125, inlinedAt: !1062)
!1062 = !DILocation(line: 0, scope: !140, inlinedAt: !1063)
!1063 = !DILocation(line: 0, scope: !142, inlinedAt: !1064)
!1064 = !DILocation(line: 11, scope: !244, inlinedAt: !1065)
!1065 = !DILocation(line: 31, scope: !246, inlinedAt: !1066)
!1066 = !DILocation(line: 65, scope: !406, inlinedAt: !1056)
!1067 = !DILocation(line: 37, scope: !148, inlinedAt: !1064)
!1068 = !DILocation(line: 30, scope: !151, inlinedAt: !1064)
!1069 = !DILocation(line: 126, scope: !251, inlinedAt: !1070)
!1070 = !DILocation(line: 126, scope: !251, inlinedAt: !1071)
!1071 = !DILocation(line: 33, scope: !246, inlinedAt: !1066)
!1072 = !DILocation(line: 108, scope: !262, inlinedAt: !1073)
!1073 = !DILocation(line: 70, scope: !406, inlinedAt: !1056)
!1074 = !DILocation(line: 71, scope: !406, inlinedAt: !1056)
!1075 = !DILocation(line: 37, scope: !148, inlinedAt: !1076)
!1076 = !DILocation(line: 188, scope: !182, inlinedAt: !1004)
!1077 = !DILocation(line: 19, scope: !448, inlinedAt: !1078)
!1078 = !DILocation(line: 19, scope: !448, inlinedAt: !1076)
!1079 = !DILocation(line: 6, scope: !266, inlinedAt: !1080)
!1080 = !DILocation(line: 109, scope: !182, inlinedAt: !1004)
!1081 = !DILocation(line: 85, scope: !107)
!1082 = distinct !DISubprogram(name: "report_exception_frame", linkageName: "julia_report_exception_frame_2432", scope: null, file: !28, line: 88, type: !1083, scopeLine: 88, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !1086)
!1083 = !DISubroutineType(types: !1084)
!1084 = !{!110, !1085, !67, !112, !112, !67}
!1085 = !DICompositeType(tag: DW_TAG_structure_type, name: "#report_exception_frame", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927534816")
!1086 = !{!1087, !1088, !1089, !1090, !1091}
!1087 = !DILocalVariable(name: "#self#", arg: 1, scope: !1082, file: !28, line: 88, type: !1085)
!1088 = !DILocalVariable(name: "idx", arg: 2, scope: !1082, file: !28, line: 88, type: !67)
!1089 = !DILocalVariable(name: "func", arg: 3, scope: !1082, file: !28, line: 88, type: !112)
!1090 = !DILocalVariable(name: "file", arg: 4, scope: !1082, file: !28, line: 88, type: !112)
!1091 = !DILocalVariable(name: "line", arg: 5, scope: !1082, file: !28, line: 88, type: !67)
!1092 = !DILocation(line: 88, scope: !1082)
!1093 = !DILocation(line: 513, scope: !1094, inlinedAt: !1095)
!1094 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !119, file: !119, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1095 = !DILocation(line: 46, scope: !1096, inlinedAt: !1097)
!1096 = distinct !DISubprogram(name: "device_string_to_host;", linkageName: "device_string_to_host", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1097 = !DILocation(line: 91, scope: !1082)
!1098 = !DILocation(line: 40, scope: !1099, inlinedAt: !1100)
!1099 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1100 = !DILocation(line: 3, scope: !1101, inlinedAt: !1102)
!1101 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !129, file: !129, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1102 = !DILocation(line: 3, scope: !1103, inlinedAt: !1104)
!1103 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !129, file: !129, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1104 = !DILocation(line: 47, scope: !1096, inlinedAt: !1097)
!1105 = !DILocation(line: 87, scope: !1106, inlinedAt: !1107)
!1106 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1107 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1108)
!1108 = !DILocation(line: 50, scope: !1096, inlinedAt: !1097)
!1109 = !DILocation(line: 40, scope: !1099, inlinedAt: !1110)
!1110 = !DILocation(line: 0, scope: !1111, inlinedAt: !1112)
!1111 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1112 = !DILocation(line: 0, scope: !1113, inlinedAt: !1114)
!1113 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1114 = !DILocation(line: 23, scope: !1115, inlinedAt: !1116)
!1115 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1116 = !DILocation(line: 4, scope: !1117, inlinedAt: !1108)
!1117 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !56, file: !56, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1118 = !DILocation(line: 37, scope: !1119, inlinedAt: !1114)
!1119 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1120 = !DILocation(line: 30, scope: !1121, inlinedAt: !1114)
!1121 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1122 = !DILocation(line: 111, scope: !1123, inlinedAt: !1124)
!1123 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1124 = !DILocation(line: 111, scope: !1123, inlinedAt: !1116)
!1125 = !DILocation(line: 40, scope: !1099, inlinedAt: !1126)
!1126 = !DILocation(line: 3, scope: !1127, inlinedAt: !1128)
!1127 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1128 = !DILocation(line: 3, scope: !1129, inlinedAt: !1130)
!1129 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1130 = !DILocation(line: 89, scope: !1131, inlinedAt: !1132)
!1131 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1132 = !DILocation(line: 124, scope: !1133, inlinedAt: !1134)
!1133 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1134 = !DILocation(line: 92, scope: !1135, inlinedAt: !1136)
!1135 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1136 = !DILocation(line: 0, scope: !1111, inlinedAt: !1137)
!1137 = !DILocation(line: 0, scope: !1138, inlinedAt: !1139)
!1138 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1139 = !DILocation(line: 71, scope: !1140, inlinedAt: !1141)
!1140 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1141 = !DILocation(line: 65, scope: !1140, inlinedAt: !1142)
!1142 = !DILocation(line: 5, scope: !1117, inlinedAt: !1108)
!1143 = !DILocation(line: 87, scope: !1106, inlinedAt: !1144)
!1144 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1130)
!1145 = !DILocation(line: 40, scope: !1099, inlinedAt: !1146)
!1146 = !DILocation(line: 3, scope: !1127, inlinedAt: !1147)
!1147 = !DILocation(line: 3, scope: !1129, inlinedAt: !1148)
!1148 = !DILocation(line: 89, scope: !1149, inlinedAt: !1132)
!1149 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1150 = !DILocation(line: 40, scope: !1099, inlinedAt: !1151)
!1151 = !DILocation(line: 3, scope: !1127, inlinedAt: !1152)
!1152 = !DILocation(line: 3, scope: !1129, inlinedAt: !1153)
!1153 = !DILocation(line: 89, scope: !1154, inlinedAt: !1132)
!1154 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1155 = !DILocation(line: 763, scope: !1156, inlinedAt: !1157)
!1156 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1157 = !DILocation(line: 789, scope: !1158, inlinedAt: !1159)
!1158 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1159 = !DILocation(line: 7, scope: !1160, inlinedAt: !1161)
!1160 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !209, file: !209, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1161 = !DILocation(line: 358, scope: !1162, inlinedAt: !1163)
!1162 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1163 = !DILocation(line: 381, scope: !1164, inlinedAt: !1165)
!1164 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1165 = !DILocation(line: 449, scope: !1166, inlinedAt: !1167)
!1166 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1167 = !DILocation(line: 492, scope: !1168, inlinedAt: !1169)
!1168 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1169 = !DILocation(line: 269, scope: !1170, inlinedAt: !1134)
!1170 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !221, file: !221, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1171 = !DILocation(line: 499, scope: !1166, inlinedAt: !1165)
!1172 = !DILocation(line: 38, scope: !1173, inlinedAt: !1167)
!1173 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1174 = !DILocation(line: 35, scope: !1175, inlinedAt: !1169)
!1175 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1176 = !DILocation(line: 93, scope: !1135, inlinedAt: !1136)
!1177 = !DILocation(line: 37, scope: !1119, inlinedAt: !1178)
!1178 = !DILocation(line: 124, scope: !1135, inlinedAt: !1136)
!1179 = !DILocation(line: 27, scope: !1180, inlinedAt: !1181)
!1180 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1181 = !DILocation(line: 37, scope: !1182, inlinedAt: !1183)
!1182 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1183 = !DILocation(line: 36, scope: !1182, inlinedAt: !1178)
!1184 = !DILocation(line: 499, scope: !1166, inlinedAt: !1185)
!1185 = !DILocation(line: 38, scope: !1182, inlinedAt: !1183)
!1186 = !DILocation(line: 499, scope: !1166, inlinedAt: !1187)
!1187 = !DILocation(line: 40, scope: !1182, inlinedAt: !1183)
!1188 = !DILocation(line: 40, scope: !1099, inlinedAt: !1189)
!1189 = !DILocation(line: 0, scope: !1111, inlinedAt: !1190)
!1190 = !DILocation(line: 0, scope: !1113, inlinedAt: !1191)
!1191 = !DILocation(line: 11, scope: !1192, inlinedAt: !1193)
!1192 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1193 = !DILocation(line: 31, scope: !1194, inlinedAt: !1195)
!1194 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1195 = !DILocation(line: 41, scope: !1182, inlinedAt: !1183)
!1196 = !DILocation(line: 37, scope: !1119, inlinedAt: !1191)
!1197 = !DILocation(line: 30, scope: !1121, inlinedAt: !1191)
!1198 = !DILocation(line: 126, scope: !1199, inlinedAt: !1200)
!1199 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1200 = !DILocation(line: 126, scope: !1199, inlinedAt: !1201)
!1201 = !DILocation(line: 33, scope: !1194, inlinedAt: !1195)
!1202 = !DILocation(line: 108, scope: !1203, inlinedAt: !1204)
!1203 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1204 = !DILocation(line: 46, scope: !1182, inlinedAt: !1183)
!1205 = !DILocation(line: 47, scope: !1182, inlinedAt: !1183)
!1206 = !DILocation(line: 6, scope: !1207, inlinedAt: !1208)
!1207 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !267, file: !267, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1208 = !DILocation(line: 109, scope: !1135, inlinedAt: !1136)
!1209 = !DILocation(line: 40, scope: !1099, inlinedAt: !1210)
!1210 = !DILocation(line: 3, scope: !1127, inlinedAt: !1211)
!1211 = !DILocation(line: 3, scope: !1129, inlinedAt: !1212)
!1212 = !DILocation(line: 89, scope: !1131, inlinedAt: !1213)
!1213 = !DILocation(line: 124, scope: !1133, inlinedAt: !1214)
!1214 = !DILocation(line: 92, scope: !1135, inlinedAt: !1215)
!1215 = !DILocation(line: 0, scope: !1111, inlinedAt: !1216)
!1216 = !DILocation(line: 0, scope: !1217, inlinedAt: !1218)
!1217 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1218 = !DILocation(line: 72, scope: !1140, inlinedAt: !1141)
!1219 = !DILocation(line: 87, scope: !1106, inlinedAt: !1220)
!1220 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1212)
!1221 = !DILocation(line: 40, scope: !1099, inlinedAt: !1222)
!1222 = !DILocation(line: 3, scope: !1127, inlinedAt: !1223)
!1223 = !DILocation(line: 3, scope: !1129, inlinedAt: !1224)
!1224 = !DILocation(line: 89, scope: !1149, inlinedAt: !1213)
!1225 = !DILocation(line: 40, scope: !1099, inlinedAt: !1226)
!1226 = !DILocation(line: 3, scope: !1127, inlinedAt: !1227)
!1227 = !DILocation(line: 3, scope: !1129, inlinedAt: !1228)
!1228 = !DILocation(line: 89, scope: !1154, inlinedAt: !1213)
!1229 = !DILocation(line: 763, scope: !1156, inlinedAt: !1230)
!1230 = !DILocation(line: 789, scope: !1158, inlinedAt: !1231)
!1231 = !DILocation(line: 7, scope: !1160, inlinedAt: !1232)
!1232 = !DILocation(line: 358, scope: !1162, inlinedAt: !1233)
!1233 = !DILocation(line: 381, scope: !1164, inlinedAt: !1234)
!1234 = !DILocation(line: 449, scope: !1166, inlinedAt: !1235)
!1235 = !DILocation(line: 492, scope: !1168, inlinedAt: !1236)
!1236 = !DILocation(line: 269, scope: !1170, inlinedAt: !1214)
!1237 = !DILocation(line: 499, scope: !1166, inlinedAt: !1234)
!1238 = !DILocation(line: 38, scope: !1173, inlinedAt: !1235)
!1239 = !DILocation(line: 35, scope: !1175, inlinedAt: !1236)
!1240 = !DILocation(line: 93, scope: !1135, inlinedAt: !1215)
!1241 = !DILocation(line: 37, scope: !1119, inlinedAt: !1242)
!1242 = !DILocation(line: 152, scope: !1135, inlinedAt: !1215)
!1243 = !DILocation(line: 513, scope: !1094, inlinedAt: !1244)
!1244 = !DILocation(line: 100, scope: !1245, inlinedAt: !1246)
!1245 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1246 = !DILocation(line: 114, scope: !1247, inlinedAt: !1242)
!1247 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1248 = !DILocation(line: 513, scope: !1094, inlinedAt: !1249)
!1249 = !DILocation(line: 102, scope: !1250, inlinedAt: !1251)
!1250 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1251 = !DILocation(line: 471, scope: !1252, inlinedAt: !1246)
!1252 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !119, file: !119, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1253 = !DILocation(line: 513, scope: !1094, inlinedAt: !1254)
!1254 = !DILocation(line: 100, scope: !1245, inlinedAt: !1255)
!1255 = !DILocation(line: 115, scope: !1256, inlinedAt: !1242)
!1256 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1257 = !DILocation(line: 513, scope: !1094, inlinedAt: !1258)
!1258 = !DILocation(line: 102, scope: !1250, inlinedAt: !1259)
!1259 = !DILocation(line: 471, scope: !1252, inlinedAt: !1255)
!1260 = !DILocation(line: 40, scope: !1099, inlinedAt: !1261)
!1261 = !DILocation(line: 46, scope: !1262, inlinedAt: !1263)
!1262 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1263 = !DILocation(line: 46, scope: !1264, inlinedAt: !1265)
!1264 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1265 = !DILocation(line: 88, scope: !1266, inlinedAt: !1267)
!1266 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1267 = !DILocation(line: 88, scope: !1266, inlinedAt: !1268)
!1268 = !DILocation(line: 88, scope: !1266, inlinedAt: !1242)
!1269 = !DILocation(line: 6, scope: !1207, inlinedAt: !1270)
!1270 = !DILocation(line: 109, scope: !1135, inlinedAt: !1215)
!1271 = !DILocation(line: 168, scope: !1135, inlinedAt: !1272)
!1272 = !DILocation(line: 0, scope: !1111, inlinedAt: !1273)
!1273 = !DILocation(line: 0, scope: !1274, inlinedAt: !1275)
!1274 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1275 = !DILocation(line: 73, scope: !1140, inlinedAt: !1141)
!1276 = !DILocation(line: 40, scope: !1099, inlinedAt: !1277)
!1277 = !DILocation(line: 2, scope: !1278, inlinedAt: !1279)
!1278 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1279 = !DILocation(line: 2, scope: !1280, inlinedAt: !1281)
!1280 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1281 = !DILocation(line: 52, scope: !1282, inlinedAt: !1283)
!1282 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !343, file: !343, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1283 = !DILocation(line: 52, scope: !1282, inlinedAt: !1284)
!1284 = !DILocation(line: 169, scope: !1135, inlinedAt: !1272)
!1285 = !DILocation(line: 40, scope: !1099, inlinedAt: !1286)
!1286 = !DILocation(line: 3, scope: !1127, inlinedAt: !1287)
!1287 = !DILocation(line: 3, scope: !1129, inlinedAt: !1288)
!1288 = !DILocation(line: 89, scope: !1131, inlinedAt: !1289)
!1289 = !DILocation(line: 124, scope: !1133, inlinedAt: !1290)
!1290 = !DILocation(line: 92, scope: !1135, inlinedAt: !1272)
!1291 = !DILocation(line: 87, scope: !1106, inlinedAt: !1292)
!1292 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1288)
!1293 = !DILocation(line: 40, scope: !1099, inlinedAt: !1294)
!1294 = !DILocation(line: 3, scope: !1127, inlinedAt: !1295)
!1295 = !DILocation(line: 3, scope: !1129, inlinedAt: !1296)
!1296 = !DILocation(line: 89, scope: !1149, inlinedAt: !1289)
!1297 = !DILocation(line: 40, scope: !1099, inlinedAt: !1298)
!1298 = !DILocation(line: 3, scope: !1127, inlinedAt: !1299)
!1299 = !DILocation(line: 3, scope: !1129, inlinedAt: !1300)
!1300 = !DILocation(line: 89, scope: !1154, inlinedAt: !1289)
!1301 = !DILocation(line: 763, scope: !1156, inlinedAt: !1302)
!1302 = !DILocation(line: 789, scope: !1158, inlinedAt: !1303)
!1303 = !DILocation(line: 7, scope: !1160, inlinedAt: !1304)
!1304 = !DILocation(line: 358, scope: !1162, inlinedAt: !1305)
!1305 = !DILocation(line: 381, scope: !1164, inlinedAt: !1306)
!1306 = !DILocation(line: 449, scope: !1166, inlinedAt: !1307)
!1307 = !DILocation(line: 492, scope: !1168, inlinedAt: !1308)
!1308 = !DILocation(line: 269, scope: !1170, inlinedAt: !1290)
!1309 = !DILocation(line: 499, scope: !1166, inlinedAt: !1306)
!1310 = !DILocation(line: 38, scope: !1173, inlinedAt: !1307)
!1311 = !DILocation(line: 35, scope: !1175, inlinedAt: !1308)
!1312 = !DILocation(line: 93, scope: !1135, inlinedAt: !1272)
!1313 = !DILocation(line: 37, scope: !1119, inlinedAt: !1314)
!1314 = !DILocation(line: 174, scope: !1135, inlinedAt: !1272)
!1315 = !DILocation(line: 27, scope: !1180, inlinedAt: !1316)
!1316 = !DILocation(line: 37, scope: !1182, inlinedAt: !1317)
!1317 = !DILocation(line: 36, scope: !1182, inlinedAt: !1314)
!1318 = !DILocation(line: 499, scope: !1166, inlinedAt: !1319)
!1319 = !DILocation(line: 38, scope: !1182, inlinedAt: !1317)
!1320 = !DILocation(line: 499, scope: !1166, inlinedAt: !1321)
!1321 = !DILocation(line: 40, scope: !1182, inlinedAt: !1317)
!1322 = !DILocation(line: 40, scope: !1099, inlinedAt: !1323)
!1323 = !DILocation(line: 0, scope: !1111, inlinedAt: !1324)
!1324 = !DILocation(line: 0, scope: !1113, inlinedAt: !1325)
!1325 = !DILocation(line: 11, scope: !1192, inlinedAt: !1326)
!1326 = !DILocation(line: 31, scope: !1194, inlinedAt: !1327)
!1327 = !DILocation(line: 41, scope: !1182, inlinedAt: !1317)
!1328 = !DILocation(line: 37, scope: !1119, inlinedAt: !1325)
!1329 = !DILocation(line: 30, scope: !1121, inlinedAt: !1325)
!1330 = !DILocation(line: 126, scope: !1199, inlinedAt: !1331)
!1331 = !DILocation(line: 126, scope: !1199, inlinedAt: !1332)
!1332 = !DILocation(line: 33, scope: !1194, inlinedAt: !1327)
!1333 = !DILocation(line: 108, scope: !1203, inlinedAt: !1334)
!1334 = !DILocation(line: 46, scope: !1182, inlinedAt: !1317)
!1335 = !DILocation(line: 47, scope: !1182, inlinedAt: !1317)
!1336 = !DILocation(line: 37, scope: !1119, inlinedAt: !1337)
!1337 = !DILocation(line: 176, scope: !1135, inlinedAt: !1272)
!1338 = !DILocation(line: 12, scope: !1339, inlinedAt: !1340)
!1339 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1340 = !DILocation(line: 61, scope: !1341, inlinedAt: !1342)
!1341 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1342 = !DILocation(line: 60, scope: !1341, inlinedAt: !1337)
!1343 = !DILocation(line: 499, scope: !1166, inlinedAt: !1344)
!1344 = !DILocation(line: 62, scope: !1341, inlinedAt: !1342)
!1345 = !DILocation(line: 499, scope: !1166, inlinedAt: !1346)
!1346 = !DILocation(line: 64, scope: !1341, inlinedAt: !1342)
!1347 = !DILocation(line: 40, scope: !1099, inlinedAt: !1348)
!1348 = !DILocation(line: 0, scope: !1111, inlinedAt: !1349)
!1349 = !DILocation(line: 0, scope: !1113, inlinedAt: !1350)
!1350 = !DILocation(line: 11, scope: !1192, inlinedAt: !1351)
!1351 = !DILocation(line: 31, scope: !1194, inlinedAt: !1352)
!1352 = !DILocation(line: 65, scope: !1341, inlinedAt: !1342)
!1353 = !DILocation(line: 37, scope: !1119, inlinedAt: !1350)
!1354 = !DILocation(line: 30, scope: !1121, inlinedAt: !1350)
!1355 = !DILocation(line: 126, scope: !1199, inlinedAt: !1356)
!1356 = !DILocation(line: 126, scope: !1199, inlinedAt: !1357)
!1357 = !DILocation(line: 33, scope: !1194, inlinedAt: !1352)
!1358 = !DILocation(line: 108, scope: !1203, inlinedAt: !1359)
!1359 = !DILocation(line: 70, scope: !1341, inlinedAt: !1342)
!1360 = !DILocation(line: 71, scope: !1341, inlinedAt: !1342)
!1361 = !DILocation(line: 178, scope: !1135, inlinedAt: !1272)
!1362 = !DILocation(line: 37, scope: !1119, inlinedAt: !1363)
!1363 = !DILocation(line: 179, scope: !1135, inlinedAt: !1272)
!1364 = !DILocation(line: 513, scope: !1094, inlinedAt: !1363)
!1365 = !DILocation(line: 40, scope: !1099, inlinedAt: !1366)
!1366 = !DILocation(line: 9, scope: !1262, inlinedAt: !1367)
!1367 = !DILocation(line: 9, scope: !1368, inlinedAt: !1369)
!1368 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1369 = !DILocation(line: 85, scope: !1370, inlinedAt: !1371)
!1370 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1371 = !DILocation(line: 85, scope: !1370, inlinedAt: !1372)
!1372 = !DILocation(line: 85, scope: !1370, inlinedAt: !1373)
!1373 = !DILocation(line: 180, scope: !1135, inlinedAt: !1272)
!1374 = !DILocation(line: 513, scope: !1094, inlinedAt: !1375)
!1375 = !DILocation(line: 100, scope: !1245, inlinedAt: !1376)
!1376 = !DILocation(line: 181, scope: !1135, inlinedAt: !1272)
!1377 = !DILocation(line: 499, scope: !1166, inlinedAt: !1378)
!1378 = !DILocation(line: 492, scope: !1168, inlinedAt: !1376)
!1379 = !DILocation(line: 38, scope: !1173, inlinedAt: !1378)
!1380 = !DILocation(line: 37, scope: !1119, inlinedAt: !1381)
!1381 = !DILocation(line: 182, scope: !1135, inlinedAt: !1272)
!1382 = !DILocation(line: 19, scope: !1383, inlinedAt: !1384)
!1383 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1384 = !DILocation(line: 19, scope: !1383, inlinedAt: !1381)
!1385 = !DILocation(line: 40, scope: !1099, inlinedAt: !1386)
!1386 = !DILocation(line: 0, scope: !1111, inlinedAt: !1387)
!1387 = !DILocation(line: 0, scope: !1113, inlinedAt: !1388)
!1388 = !DILocation(line: 11, scope: !1192, inlinedAt: !1389)
!1389 = !DILocation(line: 31, scope: !1194, inlinedAt: !1390)
!1390 = !DILocation(line: 183, scope: !1135, inlinedAt: !1272)
!1391 = !DILocation(line: 37, scope: !1119, inlinedAt: !1388)
!1392 = !DILocation(line: 30, scope: !1121, inlinedAt: !1388)
!1393 = !DILocation(line: 126, scope: !1199, inlinedAt: !1394)
!1394 = !DILocation(line: 126, scope: !1199, inlinedAt: !1395)
!1395 = !DILocation(line: 33, scope: !1194, inlinedAt: !1390)
!1396 = !DILocation(line: 1, scope: !1397, inlinedAt: !1398)
!1397 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !463, file: !463, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1398 = !DILocation(line: 184, scope: !1135, inlinedAt: !1272)
!1399 = !DILocation(line: 40, scope: !1099, inlinedAt: !1400)
!1400 = !DILocation(line: 9, scope: !1262, inlinedAt: !1401)
!1401 = !DILocation(line: 9, scope: !1368, inlinedAt: !1402)
!1402 = !DILocation(line: 85, scope: !1370, inlinedAt: !1403)
!1403 = !DILocation(line: 85, scope: !1370, inlinedAt: !1404)
!1404 = !DILocation(line: 85, scope: !1370, inlinedAt: !1405)
!1405 = !DILocation(line: 186, scope: !1135, inlinedAt: !1272)
!1406 = !DILocation(line: 40, scope: !1099, inlinedAt: !1407)
!1407 = !DILocation(line: 46, scope: !1262, inlinedAt: !1408)
!1408 = !DILocation(line: 46, scope: !1264, inlinedAt: !1409)
!1409 = !DILocation(line: 88, scope: !1266, inlinedAt: !1410)
!1410 = !DILocation(line: 88, scope: !1266, inlinedAt: !1411)
!1411 = !DILocation(line: 88, scope: !1266, inlinedAt: !1405)
!1412 = !DILocation(line: 37, scope: !1119, inlinedAt: !1413)
!1413 = !DILocation(line: 188, scope: !1135, inlinedAt: !1272)
!1414 = !DILocation(line: 19, scope: !1383, inlinedAt: !1415)
!1415 = !DILocation(line: 19, scope: !1383, inlinedAt: !1413)
!1416 = !DILocation(line: 6, scope: !1207, inlinedAt: !1417)
!1417 = !DILocation(line: 109, scope: !1135, inlinedAt: !1272)
!1418 = !DILocation(line: 40, scope: !1099, inlinedAt: !1419)
!1419 = !DILocation(line: 9, scope: !1262, inlinedAt: !1420)
!1420 = !DILocation(line: 9, scope: !1368, inlinedAt: !1421)
!1421 = !DILocation(line: 85, scope: !1370, inlinedAt: !1422)
!1422 = !DILocation(line: 85, scope: !1370, inlinedAt: !1423)
!1423 = !DILocation(line: 85, scope: !1370, inlinedAt: !1424)
!1424 = !DILocation(line: 191, scope: !1135, inlinedAt: !1272)
!1425 = !DILocation(line: 6, scope: !1117, inlinedAt: !1108)
!1426 = !DILocation(line: 513, scope: !1094, inlinedAt: !1108)
!1427 = !DILocation(line: 513, scope: !1094, inlinedAt: !1428)
!1428 = !DILocation(line: 52, scope: !1096, inlinedAt: !1097)
!1429 = !DILocation(line: 499, scope: !1166, inlinedAt: !1430)
!1430 = !DILocation(line: 492, scope: !1168, inlinedAt: !1428)
!1431 = !DILocation(line: 38, scope: !1173, inlinedAt: !1430)
!1432 = !DILocation(line: 40, scope: !1099, inlinedAt: !1433)
!1433 = !DILocation(line: 0, scope: !1111, inlinedAt: !1434)
!1434 = !DILocation(line: 0, scope: !1113, inlinedAt: !1435)
!1435 = !DILocation(line: 15, scope: !1436, inlinedAt: !1437)
!1436 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1437 = !DILocation(line: 69, scope: !1438, inlinedAt: !1439)
!1438 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1439 = !DILocation(line: 53, scope: !1096, inlinedAt: !1097)
!1440 = !DILocation(line: 37, scope: !1119, inlinedAt: !1435)
!1441 = !DILocation(line: 30, scope: !1121, inlinedAt: !1435)
!1442 = !DILocation(line: 111, scope: !1123, inlinedAt: !1443)
!1443 = !DILocation(line: 111, scope: !1123, inlinedAt: !1444)
!1444 = !DILocation(line: 70, scope: !1438, inlinedAt: !1439)
!1445 = !DILocation(line: 40, scope: !1099, inlinedAt: !1446)
!1446 = !DILocation(line: 3, scope: !1127, inlinedAt: !1447)
!1447 = !DILocation(line: 3, scope: !1129, inlinedAt: !1448)
!1448 = !DILocation(line: 89, scope: !1131, inlinedAt: !1449)
!1449 = !DILocation(line: 124, scope: !1133, inlinedAt: !1450)
!1450 = !DILocation(line: 92, scope: !1135, inlinedAt: !1451)
!1451 = !DILocation(line: 0, scope: !1111, inlinedAt: !1452)
!1452 = !DILocation(line: 0, scope: !1138, inlinedAt: !1453)
!1453 = !DILocation(line: 115, scope: !1454, inlinedAt: !1444)
!1454 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1455 = !DILocation(line: 87, scope: !1106, inlinedAt: !1456)
!1456 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1448)
!1457 = !DILocation(line: 40, scope: !1099, inlinedAt: !1458)
!1458 = !DILocation(line: 3, scope: !1127, inlinedAt: !1459)
!1459 = !DILocation(line: 3, scope: !1129, inlinedAt: !1460)
!1460 = !DILocation(line: 89, scope: !1149, inlinedAt: !1449)
!1461 = !DILocation(line: 40, scope: !1099, inlinedAt: !1462)
!1462 = !DILocation(line: 3, scope: !1127, inlinedAt: !1463)
!1463 = !DILocation(line: 3, scope: !1129, inlinedAt: !1464)
!1464 = !DILocation(line: 89, scope: !1154, inlinedAt: !1449)
!1465 = !DILocation(line: 763, scope: !1156, inlinedAt: !1466)
!1466 = !DILocation(line: 789, scope: !1158, inlinedAt: !1467)
!1467 = !DILocation(line: 7, scope: !1160, inlinedAt: !1468)
!1468 = !DILocation(line: 358, scope: !1162, inlinedAt: !1469)
!1469 = !DILocation(line: 381, scope: !1164, inlinedAt: !1470)
!1470 = !DILocation(line: 449, scope: !1166, inlinedAt: !1471)
!1471 = !DILocation(line: 492, scope: !1168, inlinedAt: !1472)
!1472 = !DILocation(line: 269, scope: !1170, inlinedAt: !1450)
!1473 = !DILocation(line: 499, scope: !1166, inlinedAt: !1470)
!1474 = !DILocation(line: 38, scope: !1173, inlinedAt: !1471)
!1475 = !DILocation(line: 35, scope: !1175, inlinedAt: !1472)
!1476 = !DILocation(line: 93, scope: !1135, inlinedAt: !1451)
!1477 = !DILocation(line: 37, scope: !1119, inlinedAt: !1478)
!1478 = !DILocation(line: 124, scope: !1135, inlinedAt: !1451)
!1479 = !DILocation(line: 27, scope: !1180, inlinedAt: !1480)
!1480 = !DILocation(line: 37, scope: !1182, inlinedAt: !1481)
!1481 = !DILocation(line: 36, scope: !1182, inlinedAt: !1478)
!1482 = !DILocation(line: 499, scope: !1166, inlinedAt: !1483)
!1483 = !DILocation(line: 38, scope: !1182, inlinedAt: !1481)
!1484 = !DILocation(line: 499, scope: !1166, inlinedAt: !1485)
!1485 = !DILocation(line: 40, scope: !1182, inlinedAt: !1481)
!1486 = !DILocation(line: 40, scope: !1099, inlinedAt: !1487)
!1487 = !DILocation(line: 0, scope: !1111, inlinedAt: !1488)
!1488 = !DILocation(line: 0, scope: !1113, inlinedAt: !1489)
!1489 = !DILocation(line: 11, scope: !1192, inlinedAt: !1490)
!1490 = !DILocation(line: 31, scope: !1194, inlinedAt: !1491)
!1491 = !DILocation(line: 41, scope: !1182, inlinedAt: !1481)
!1492 = !DILocation(line: 37, scope: !1119, inlinedAt: !1489)
!1493 = !DILocation(line: 30, scope: !1121, inlinedAt: !1489)
!1494 = !DILocation(line: 126, scope: !1199, inlinedAt: !1495)
!1495 = !DILocation(line: 126, scope: !1199, inlinedAt: !1496)
!1496 = !DILocation(line: 33, scope: !1194, inlinedAt: !1491)
!1497 = !DILocation(line: 108, scope: !1203, inlinedAt: !1498)
!1498 = !DILocation(line: 46, scope: !1182, inlinedAt: !1481)
!1499 = !DILocation(line: 47, scope: !1182, inlinedAt: !1481)
!1500 = !DILocation(line: 6, scope: !1207, inlinedAt: !1501)
!1501 = !DILocation(line: 109, scope: !1135, inlinedAt: !1451)
!1502 = !DILocation(line: 37, scope: !1119, inlinedAt: !1444)
!1503 = !DILocation(line: 513, scope: !1094, inlinedAt: !1504)
!1504 = !DILocation(line: 100, scope: !1245, inlinedAt: !1505)
!1505 = !DILocation(line: 114, scope: !1247, inlinedAt: !1444)
!1506 = !DILocation(line: 513, scope: !1094, inlinedAt: !1507)
!1507 = !DILocation(line: 102, scope: !1250, inlinedAt: !1508)
!1508 = !DILocation(line: 471, scope: !1252, inlinedAt: !1505)
!1509 = !DILocation(line: 40, scope: !1099, inlinedAt: !1510)
!1510 = !DILocation(line: 0, scope: !1111, inlinedAt: !1511)
!1511 = !DILocation(line: 0, scope: !1512, inlinedAt: !1444)
!1512 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1513 = !DILocation(line: 513, scope: !1094, inlinedAt: !1444)
!1514 = !DILocation(line: 40, scope: !1099, inlinedAt: !1515)
!1515 = !DILocation(line: 46, scope: !1262, inlinedAt: !1516)
!1516 = !DILocation(line: 46, scope: !1264, inlinedAt: !1517)
!1517 = !DILocation(line: 88, scope: !1266, inlinedAt: !1518)
!1518 = !DILocation(line: 88, scope: !1266, inlinedAt: !1444)
!1519 = !DILocation(line: 158, scope: !1520, inlinedAt: !1444)
!1520 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1521 = !DILocation(line: 40, scope: !1099, inlinedAt: !1522)
!1522 = !DILocation(line: 0, scope: !1111, inlinedAt: !1523)
!1523 = !DILocation(line: 0, scope: !1512, inlinedAt: !1524)
!1524 = !DILocation(line: 57, scope: !1096, inlinedAt: !1097)
!1525 = !DILocation(line: 513, scope: !1094, inlinedAt: !1526)
!1526 = !DILocation(line: 100, scope: !1245, inlinedAt: !1527)
!1527 = !DILocation(line: 114, scope: !1247, inlinedAt: !1528)
!1528 = !DILocation(line: 59, scope: !1096, inlinedAt: !1097)
!1529 = !DILocation(line: 513, scope: !1094, inlinedAt: !1530)
!1530 = !DILocation(line: 102, scope: !1250, inlinedAt: !1531)
!1531 = !DILocation(line: 471, scope: !1252, inlinedAt: !1527)
!1532 = !DILocation(line: 40, scope: !1099, inlinedAt: !1533)
!1533 = !DILocation(line: 46, scope: !1262, inlinedAt: !1534)
!1534 = !DILocation(line: 46, scope: !1264, inlinedAt: !1535)
!1535 = !DILocation(line: 88, scope: !1266, inlinedAt: !1536)
!1536 = !DILocation(line: 88, scope: !1266, inlinedAt: !1537)
!1537 = !DILocation(line: 88, scope: !1266, inlinedAt: !1528)
!1538 = !DILocation(line: 513, scope: !1094, inlinedAt: !1539)
!1539 = !DILocation(line: 60, scope: !1096, inlinedAt: !1097)
!1540 = !DILocation(line: 513, scope: !1094, inlinedAt: !1541)
!1541 = !DILocation(line: 46, scope: !1096, inlinedAt: !1542)
!1542 = !DILocation(line: 92, scope: !1082)
!1543 = !DILocation(line: 40, scope: !1099, inlinedAt: !1544)
!1544 = !DILocation(line: 3, scope: !1101, inlinedAt: !1545)
!1545 = !DILocation(line: 3, scope: !1103, inlinedAt: !1546)
!1546 = !DILocation(line: 47, scope: !1096, inlinedAt: !1542)
!1547 = !DILocation(line: 87, scope: !1106, inlinedAt: !1548)
!1548 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1549)
!1549 = !DILocation(line: 50, scope: !1096, inlinedAt: !1542)
!1550 = !DILocation(line: 40, scope: !1099, inlinedAt: !1551)
!1551 = !DILocation(line: 0, scope: !1111, inlinedAt: !1552)
!1552 = !DILocation(line: 0, scope: !1113, inlinedAt: !1553)
!1553 = !DILocation(line: 23, scope: !1115, inlinedAt: !1554)
!1554 = !DILocation(line: 4, scope: !1117, inlinedAt: !1549)
!1555 = !DILocation(line: 37, scope: !1119, inlinedAt: !1553)
!1556 = !DILocation(line: 30, scope: !1121, inlinedAt: !1553)
!1557 = !DILocation(line: 111, scope: !1123, inlinedAt: !1558)
!1558 = !DILocation(line: 111, scope: !1123, inlinedAt: !1554)
!1559 = !DILocation(line: 40, scope: !1099, inlinedAt: !1560)
!1560 = !DILocation(line: 3, scope: !1127, inlinedAt: !1561)
!1561 = !DILocation(line: 3, scope: !1129, inlinedAt: !1562)
!1562 = !DILocation(line: 89, scope: !1131, inlinedAt: !1563)
!1563 = !DILocation(line: 124, scope: !1133, inlinedAt: !1564)
!1564 = !DILocation(line: 92, scope: !1135, inlinedAt: !1565)
!1565 = !DILocation(line: 0, scope: !1111, inlinedAt: !1566)
!1566 = !DILocation(line: 0, scope: !1138, inlinedAt: !1567)
!1567 = !DILocation(line: 71, scope: !1140, inlinedAt: !1568)
!1568 = !DILocation(line: 65, scope: !1140, inlinedAt: !1569)
!1569 = !DILocation(line: 5, scope: !1117, inlinedAt: !1549)
!1570 = !DILocation(line: 87, scope: !1106, inlinedAt: !1571)
!1571 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1562)
!1572 = !DILocation(line: 40, scope: !1099, inlinedAt: !1573)
!1573 = !DILocation(line: 3, scope: !1127, inlinedAt: !1574)
!1574 = !DILocation(line: 3, scope: !1129, inlinedAt: !1575)
!1575 = !DILocation(line: 89, scope: !1149, inlinedAt: !1563)
!1576 = !DILocation(line: 40, scope: !1099, inlinedAt: !1577)
!1577 = !DILocation(line: 3, scope: !1127, inlinedAt: !1578)
!1578 = !DILocation(line: 3, scope: !1129, inlinedAt: !1579)
!1579 = !DILocation(line: 89, scope: !1154, inlinedAt: !1563)
!1580 = !DILocation(line: 763, scope: !1156, inlinedAt: !1581)
!1581 = !DILocation(line: 789, scope: !1158, inlinedAt: !1582)
!1582 = !DILocation(line: 7, scope: !1160, inlinedAt: !1583)
!1583 = !DILocation(line: 358, scope: !1162, inlinedAt: !1584)
!1584 = !DILocation(line: 381, scope: !1164, inlinedAt: !1585)
!1585 = !DILocation(line: 449, scope: !1166, inlinedAt: !1586)
!1586 = !DILocation(line: 492, scope: !1168, inlinedAt: !1587)
!1587 = !DILocation(line: 269, scope: !1170, inlinedAt: !1564)
!1588 = !DILocation(line: 499, scope: !1166, inlinedAt: !1585)
!1589 = !DILocation(line: 38, scope: !1173, inlinedAt: !1586)
!1590 = !DILocation(line: 35, scope: !1175, inlinedAt: !1587)
!1591 = !DILocation(line: 93, scope: !1135, inlinedAt: !1565)
!1592 = !DILocation(line: 37, scope: !1119, inlinedAt: !1593)
!1593 = !DILocation(line: 124, scope: !1135, inlinedAt: !1565)
!1594 = !DILocation(line: 27, scope: !1180, inlinedAt: !1595)
!1595 = !DILocation(line: 37, scope: !1182, inlinedAt: !1596)
!1596 = !DILocation(line: 36, scope: !1182, inlinedAt: !1593)
!1597 = !DILocation(line: 499, scope: !1166, inlinedAt: !1598)
!1598 = !DILocation(line: 38, scope: !1182, inlinedAt: !1596)
!1599 = !DILocation(line: 499, scope: !1166, inlinedAt: !1600)
!1600 = !DILocation(line: 40, scope: !1182, inlinedAt: !1596)
!1601 = !DILocation(line: 40, scope: !1099, inlinedAt: !1602)
!1602 = !DILocation(line: 0, scope: !1111, inlinedAt: !1603)
!1603 = !DILocation(line: 0, scope: !1113, inlinedAt: !1604)
!1604 = !DILocation(line: 11, scope: !1192, inlinedAt: !1605)
!1605 = !DILocation(line: 31, scope: !1194, inlinedAt: !1606)
!1606 = !DILocation(line: 41, scope: !1182, inlinedAt: !1596)
!1607 = !DILocation(line: 37, scope: !1119, inlinedAt: !1604)
!1608 = !DILocation(line: 30, scope: !1121, inlinedAt: !1604)
!1609 = !DILocation(line: 126, scope: !1199, inlinedAt: !1610)
!1610 = !DILocation(line: 126, scope: !1199, inlinedAt: !1611)
!1611 = !DILocation(line: 33, scope: !1194, inlinedAt: !1606)
!1612 = !DILocation(line: 108, scope: !1203, inlinedAt: !1613)
!1613 = !DILocation(line: 46, scope: !1182, inlinedAt: !1596)
!1614 = !DILocation(line: 47, scope: !1182, inlinedAt: !1596)
!1615 = !DILocation(line: 6, scope: !1207, inlinedAt: !1616)
!1616 = !DILocation(line: 109, scope: !1135, inlinedAt: !1565)
!1617 = !DILocation(line: 40, scope: !1099, inlinedAt: !1618)
!1618 = !DILocation(line: 3, scope: !1127, inlinedAt: !1619)
!1619 = !DILocation(line: 3, scope: !1129, inlinedAt: !1620)
!1620 = !DILocation(line: 89, scope: !1131, inlinedAt: !1621)
!1621 = !DILocation(line: 124, scope: !1133, inlinedAt: !1622)
!1622 = !DILocation(line: 92, scope: !1135, inlinedAt: !1623)
!1623 = !DILocation(line: 0, scope: !1111, inlinedAt: !1624)
!1624 = !DILocation(line: 0, scope: !1217, inlinedAt: !1625)
!1625 = !DILocation(line: 72, scope: !1140, inlinedAt: !1568)
!1626 = !DILocation(line: 87, scope: !1106, inlinedAt: !1627)
!1627 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1620)
!1628 = !DILocation(line: 40, scope: !1099, inlinedAt: !1629)
!1629 = !DILocation(line: 3, scope: !1127, inlinedAt: !1630)
!1630 = !DILocation(line: 3, scope: !1129, inlinedAt: !1631)
!1631 = !DILocation(line: 89, scope: !1149, inlinedAt: !1621)
!1632 = !DILocation(line: 40, scope: !1099, inlinedAt: !1633)
!1633 = !DILocation(line: 3, scope: !1127, inlinedAt: !1634)
!1634 = !DILocation(line: 3, scope: !1129, inlinedAt: !1635)
!1635 = !DILocation(line: 89, scope: !1154, inlinedAt: !1621)
!1636 = !DILocation(line: 763, scope: !1156, inlinedAt: !1637)
!1637 = !DILocation(line: 789, scope: !1158, inlinedAt: !1638)
!1638 = !DILocation(line: 7, scope: !1160, inlinedAt: !1639)
!1639 = !DILocation(line: 358, scope: !1162, inlinedAt: !1640)
!1640 = !DILocation(line: 381, scope: !1164, inlinedAt: !1641)
!1641 = !DILocation(line: 449, scope: !1166, inlinedAt: !1642)
!1642 = !DILocation(line: 492, scope: !1168, inlinedAt: !1643)
!1643 = !DILocation(line: 269, scope: !1170, inlinedAt: !1622)
!1644 = !DILocation(line: 499, scope: !1166, inlinedAt: !1641)
!1645 = !DILocation(line: 38, scope: !1173, inlinedAt: !1642)
!1646 = !DILocation(line: 35, scope: !1175, inlinedAt: !1643)
!1647 = !DILocation(line: 93, scope: !1135, inlinedAt: !1623)
!1648 = !DILocation(line: 37, scope: !1119, inlinedAt: !1649)
!1649 = !DILocation(line: 152, scope: !1135, inlinedAt: !1623)
!1650 = !DILocation(line: 513, scope: !1094, inlinedAt: !1651)
!1651 = !DILocation(line: 100, scope: !1245, inlinedAt: !1652)
!1652 = !DILocation(line: 114, scope: !1247, inlinedAt: !1649)
!1653 = !DILocation(line: 513, scope: !1094, inlinedAt: !1654)
!1654 = !DILocation(line: 102, scope: !1250, inlinedAt: !1655)
!1655 = !DILocation(line: 471, scope: !1252, inlinedAt: !1652)
!1656 = !DILocation(line: 513, scope: !1094, inlinedAt: !1657)
!1657 = !DILocation(line: 100, scope: !1245, inlinedAt: !1658)
!1658 = !DILocation(line: 115, scope: !1256, inlinedAt: !1649)
!1659 = !DILocation(line: 513, scope: !1094, inlinedAt: !1660)
!1660 = !DILocation(line: 102, scope: !1250, inlinedAt: !1661)
!1661 = !DILocation(line: 471, scope: !1252, inlinedAt: !1658)
!1662 = !DILocation(line: 40, scope: !1099, inlinedAt: !1663)
!1663 = !DILocation(line: 46, scope: !1262, inlinedAt: !1664)
!1664 = !DILocation(line: 46, scope: !1264, inlinedAt: !1665)
!1665 = !DILocation(line: 88, scope: !1266, inlinedAt: !1666)
!1666 = !DILocation(line: 88, scope: !1266, inlinedAt: !1667)
!1667 = !DILocation(line: 88, scope: !1266, inlinedAt: !1649)
!1668 = !DILocation(line: 6, scope: !1207, inlinedAt: !1669)
!1669 = !DILocation(line: 109, scope: !1135, inlinedAt: !1623)
!1670 = !DILocation(line: 168, scope: !1135, inlinedAt: !1671)
!1671 = !DILocation(line: 0, scope: !1111, inlinedAt: !1672)
!1672 = !DILocation(line: 0, scope: !1274, inlinedAt: !1673)
!1673 = !DILocation(line: 73, scope: !1140, inlinedAt: !1568)
!1674 = !DILocation(line: 40, scope: !1099, inlinedAt: !1675)
!1675 = !DILocation(line: 3, scope: !1127, inlinedAt: !1676)
!1676 = !DILocation(line: 3, scope: !1129, inlinedAt: !1677)
!1677 = !DILocation(line: 89, scope: !1131, inlinedAt: !1678)
!1678 = !DILocation(line: 124, scope: !1133, inlinedAt: !1679)
!1679 = !DILocation(line: 92, scope: !1135, inlinedAt: !1671)
!1680 = !DILocation(line: 87, scope: !1106, inlinedAt: !1681)
!1681 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1677)
!1682 = !DILocation(line: 40, scope: !1099, inlinedAt: !1683)
!1683 = !DILocation(line: 3, scope: !1127, inlinedAt: !1684)
!1684 = !DILocation(line: 3, scope: !1129, inlinedAt: !1685)
!1685 = !DILocation(line: 89, scope: !1149, inlinedAt: !1678)
!1686 = !DILocation(line: 40, scope: !1099, inlinedAt: !1687)
!1687 = !DILocation(line: 3, scope: !1127, inlinedAt: !1688)
!1688 = !DILocation(line: 3, scope: !1129, inlinedAt: !1689)
!1689 = !DILocation(line: 89, scope: !1154, inlinedAt: !1678)
!1690 = !DILocation(line: 763, scope: !1156, inlinedAt: !1691)
!1691 = !DILocation(line: 789, scope: !1158, inlinedAt: !1692)
!1692 = !DILocation(line: 7, scope: !1160, inlinedAt: !1693)
!1693 = !DILocation(line: 358, scope: !1162, inlinedAt: !1694)
!1694 = !DILocation(line: 381, scope: !1164, inlinedAt: !1695)
!1695 = !DILocation(line: 449, scope: !1166, inlinedAt: !1696)
!1696 = !DILocation(line: 492, scope: !1168, inlinedAt: !1697)
!1697 = !DILocation(line: 269, scope: !1170, inlinedAt: !1679)
!1698 = !DILocation(line: 499, scope: !1166, inlinedAt: !1695)
!1699 = !DILocation(line: 38, scope: !1173, inlinedAt: !1696)
!1700 = !DILocation(line: 35, scope: !1175, inlinedAt: !1697)
!1701 = !DILocation(line: 93, scope: !1135, inlinedAt: !1671)
!1702 = !DILocation(line: 37, scope: !1119, inlinedAt: !1703)
!1703 = !DILocation(line: 174, scope: !1135, inlinedAt: !1671)
!1704 = !DILocation(line: 27, scope: !1180, inlinedAt: !1705)
!1705 = !DILocation(line: 37, scope: !1182, inlinedAt: !1706)
!1706 = !DILocation(line: 36, scope: !1182, inlinedAt: !1703)
!1707 = !DILocation(line: 499, scope: !1166, inlinedAt: !1708)
!1708 = !DILocation(line: 38, scope: !1182, inlinedAt: !1706)
!1709 = !DILocation(line: 499, scope: !1166, inlinedAt: !1710)
!1710 = !DILocation(line: 40, scope: !1182, inlinedAt: !1706)
!1711 = !DILocation(line: 40, scope: !1099, inlinedAt: !1712)
!1712 = !DILocation(line: 0, scope: !1111, inlinedAt: !1713)
!1713 = !DILocation(line: 0, scope: !1113, inlinedAt: !1714)
!1714 = !DILocation(line: 11, scope: !1192, inlinedAt: !1715)
!1715 = !DILocation(line: 31, scope: !1194, inlinedAt: !1716)
!1716 = !DILocation(line: 41, scope: !1182, inlinedAt: !1706)
!1717 = !DILocation(line: 37, scope: !1119, inlinedAt: !1714)
!1718 = !DILocation(line: 30, scope: !1121, inlinedAt: !1714)
!1719 = !DILocation(line: 126, scope: !1199, inlinedAt: !1720)
!1720 = !DILocation(line: 126, scope: !1199, inlinedAt: !1721)
!1721 = !DILocation(line: 33, scope: !1194, inlinedAt: !1716)
!1722 = !DILocation(line: 108, scope: !1203, inlinedAt: !1723)
!1723 = !DILocation(line: 46, scope: !1182, inlinedAt: !1706)
!1724 = !DILocation(line: 47, scope: !1182, inlinedAt: !1706)
!1725 = !DILocation(line: 37, scope: !1119, inlinedAt: !1726)
!1726 = !DILocation(line: 176, scope: !1135, inlinedAt: !1671)
!1727 = !DILocation(line: 12, scope: !1339, inlinedAt: !1728)
!1728 = !DILocation(line: 61, scope: !1341, inlinedAt: !1729)
!1729 = !DILocation(line: 60, scope: !1341, inlinedAt: !1726)
!1730 = !DILocation(line: 499, scope: !1166, inlinedAt: !1731)
!1731 = !DILocation(line: 62, scope: !1341, inlinedAt: !1729)
!1732 = !DILocation(line: 499, scope: !1166, inlinedAt: !1733)
!1733 = !DILocation(line: 64, scope: !1341, inlinedAt: !1729)
!1734 = !DILocation(line: 40, scope: !1099, inlinedAt: !1735)
!1735 = !DILocation(line: 0, scope: !1111, inlinedAt: !1736)
!1736 = !DILocation(line: 0, scope: !1113, inlinedAt: !1737)
!1737 = !DILocation(line: 11, scope: !1192, inlinedAt: !1738)
!1738 = !DILocation(line: 31, scope: !1194, inlinedAt: !1739)
!1739 = !DILocation(line: 65, scope: !1341, inlinedAt: !1729)
!1740 = !DILocation(line: 37, scope: !1119, inlinedAt: !1737)
!1741 = !DILocation(line: 30, scope: !1121, inlinedAt: !1737)
!1742 = !DILocation(line: 126, scope: !1199, inlinedAt: !1743)
!1743 = !DILocation(line: 126, scope: !1199, inlinedAt: !1744)
!1744 = !DILocation(line: 33, scope: !1194, inlinedAt: !1739)
!1745 = !DILocation(line: 108, scope: !1203, inlinedAt: !1746)
!1746 = !DILocation(line: 70, scope: !1341, inlinedAt: !1729)
!1747 = !DILocation(line: 71, scope: !1341, inlinedAt: !1729)
!1748 = !DILocation(line: 178, scope: !1135, inlinedAt: !1671)
!1749 = !DILocation(line: 37, scope: !1119, inlinedAt: !1750)
!1750 = !DILocation(line: 179, scope: !1135, inlinedAt: !1671)
!1751 = !DILocation(line: 513, scope: !1094, inlinedAt: !1750)
!1752 = !DILocation(line: 40, scope: !1099, inlinedAt: !1753)
!1753 = !DILocation(line: 9, scope: !1262, inlinedAt: !1754)
!1754 = !DILocation(line: 9, scope: !1368, inlinedAt: !1755)
!1755 = !DILocation(line: 85, scope: !1370, inlinedAt: !1756)
!1756 = !DILocation(line: 85, scope: !1370, inlinedAt: !1757)
!1757 = !DILocation(line: 85, scope: !1370, inlinedAt: !1758)
!1758 = !DILocation(line: 180, scope: !1135, inlinedAt: !1671)
!1759 = !DILocation(line: 513, scope: !1094, inlinedAt: !1760)
!1760 = !DILocation(line: 100, scope: !1245, inlinedAt: !1761)
!1761 = !DILocation(line: 181, scope: !1135, inlinedAt: !1671)
!1762 = !DILocation(line: 499, scope: !1166, inlinedAt: !1763)
!1763 = !DILocation(line: 492, scope: !1168, inlinedAt: !1761)
!1764 = !DILocation(line: 38, scope: !1173, inlinedAt: !1763)
!1765 = !DILocation(line: 37, scope: !1119, inlinedAt: !1766)
!1766 = !DILocation(line: 182, scope: !1135, inlinedAt: !1671)
!1767 = !DILocation(line: 19, scope: !1383, inlinedAt: !1768)
!1768 = !DILocation(line: 19, scope: !1383, inlinedAt: !1766)
!1769 = !DILocation(line: 40, scope: !1099, inlinedAt: !1770)
!1770 = !DILocation(line: 0, scope: !1111, inlinedAt: !1771)
!1771 = !DILocation(line: 0, scope: !1113, inlinedAt: !1772)
!1772 = !DILocation(line: 11, scope: !1192, inlinedAt: !1773)
!1773 = !DILocation(line: 31, scope: !1194, inlinedAt: !1774)
!1774 = !DILocation(line: 183, scope: !1135, inlinedAt: !1671)
!1775 = !DILocation(line: 37, scope: !1119, inlinedAt: !1772)
!1776 = !DILocation(line: 30, scope: !1121, inlinedAt: !1772)
!1777 = !DILocation(line: 126, scope: !1199, inlinedAt: !1778)
!1778 = !DILocation(line: 126, scope: !1199, inlinedAt: !1779)
!1779 = !DILocation(line: 33, scope: !1194, inlinedAt: !1774)
!1780 = !DILocation(line: 1, scope: !1397, inlinedAt: !1781)
!1781 = !DILocation(line: 184, scope: !1135, inlinedAt: !1671)
!1782 = !DILocation(line: 40, scope: !1099, inlinedAt: !1783)
!1783 = !DILocation(line: 9, scope: !1262, inlinedAt: !1784)
!1784 = !DILocation(line: 9, scope: !1368, inlinedAt: !1785)
!1785 = !DILocation(line: 85, scope: !1370, inlinedAt: !1786)
!1786 = !DILocation(line: 85, scope: !1370, inlinedAt: !1787)
!1787 = !DILocation(line: 85, scope: !1370, inlinedAt: !1788)
!1788 = !DILocation(line: 186, scope: !1135, inlinedAt: !1671)
!1789 = !DILocation(line: 40, scope: !1099, inlinedAt: !1790)
!1790 = !DILocation(line: 46, scope: !1262, inlinedAt: !1791)
!1791 = !DILocation(line: 46, scope: !1264, inlinedAt: !1792)
!1792 = !DILocation(line: 88, scope: !1266, inlinedAt: !1793)
!1793 = !DILocation(line: 88, scope: !1266, inlinedAt: !1794)
!1794 = !DILocation(line: 88, scope: !1266, inlinedAt: !1788)
!1795 = !DILocation(line: 37, scope: !1119, inlinedAt: !1796)
!1796 = !DILocation(line: 188, scope: !1135, inlinedAt: !1671)
!1797 = !DILocation(line: 19, scope: !1383, inlinedAt: !1798)
!1798 = !DILocation(line: 19, scope: !1383, inlinedAt: !1796)
!1799 = !DILocation(line: 6, scope: !1207, inlinedAt: !1800)
!1800 = !DILocation(line: 109, scope: !1135, inlinedAt: !1671)
!1801 = !DILocation(line: 40, scope: !1099, inlinedAt: !1802)
!1802 = !DILocation(line: 9, scope: !1262, inlinedAt: !1803)
!1803 = !DILocation(line: 9, scope: !1368, inlinedAt: !1804)
!1804 = !DILocation(line: 85, scope: !1370, inlinedAt: !1805)
!1805 = !DILocation(line: 85, scope: !1370, inlinedAt: !1806)
!1806 = !DILocation(line: 85, scope: !1370, inlinedAt: !1807)
!1807 = !DILocation(line: 191, scope: !1135, inlinedAt: !1671)
!1808 = !DILocation(line: 6, scope: !1117, inlinedAt: !1549)
!1809 = !DILocation(line: 513, scope: !1094, inlinedAt: !1549)
!1810 = !DILocation(line: 513, scope: !1094, inlinedAt: !1811)
!1811 = !DILocation(line: 52, scope: !1096, inlinedAt: !1542)
!1812 = !DILocation(line: 499, scope: !1166, inlinedAt: !1813)
!1813 = !DILocation(line: 492, scope: !1168, inlinedAt: !1811)
!1814 = !DILocation(line: 38, scope: !1173, inlinedAt: !1813)
!1815 = !DILocation(line: 40, scope: !1099, inlinedAt: !1816)
!1816 = !DILocation(line: 0, scope: !1111, inlinedAt: !1817)
!1817 = !DILocation(line: 0, scope: !1113, inlinedAt: !1818)
!1818 = !DILocation(line: 15, scope: !1436, inlinedAt: !1819)
!1819 = !DILocation(line: 69, scope: !1438, inlinedAt: !1820)
!1820 = !DILocation(line: 53, scope: !1096, inlinedAt: !1542)
!1821 = !DILocation(line: 37, scope: !1119, inlinedAt: !1818)
!1822 = !DILocation(line: 30, scope: !1121, inlinedAt: !1818)
!1823 = !DILocation(line: 111, scope: !1123, inlinedAt: !1824)
!1824 = !DILocation(line: 111, scope: !1123, inlinedAt: !1825)
!1825 = !DILocation(line: 70, scope: !1438, inlinedAt: !1820)
!1826 = !DILocation(line: 40, scope: !1099, inlinedAt: !1827)
!1827 = !DILocation(line: 3, scope: !1127, inlinedAt: !1828)
!1828 = !DILocation(line: 3, scope: !1129, inlinedAt: !1829)
!1829 = !DILocation(line: 89, scope: !1131, inlinedAt: !1830)
!1830 = !DILocation(line: 124, scope: !1133, inlinedAt: !1831)
!1831 = !DILocation(line: 92, scope: !1135, inlinedAt: !1832)
!1832 = !DILocation(line: 0, scope: !1111, inlinedAt: !1833)
!1833 = !DILocation(line: 0, scope: !1138, inlinedAt: !1834)
!1834 = !DILocation(line: 115, scope: !1454, inlinedAt: !1825)
!1835 = !DILocation(line: 87, scope: !1106, inlinedAt: !1836)
!1836 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1829)
!1837 = !DILocation(line: 40, scope: !1099, inlinedAt: !1838)
!1838 = !DILocation(line: 3, scope: !1127, inlinedAt: !1839)
!1839 = !DILocation(line: 3, scope: !1129, inlinedAt: !1840)
!1840 = !DILocation(line: 89, scope: !1149, inlinedAt: !1830)
!1841 = !DILocation(line: 40, scope: !1099, inlinedAt: !1842)
!1842 = !DILocation(line: 3, scope: !1127, inlinedAt: !1843)
!1843 = !DILocation(line: 3, scope: !1129, inlinedAt: !1844)
!1844 = !DILocation(line: 89, scope: !1154, inlinedAt: !1830)
!1845 = !DILocation(line: 763, scope: !1156, inlinedAt: !1846)
!1846 = !DILocation(line: 789, scope: !1158, inlinedAt: !1847)
!1847 = !DILocation(line: 7, scope: !1160, inlinedAt: !1848)
!1848 = !DILocation(line: 358, scope: !1162, inlinedAt: !1849)
!1849 = !DILocation(line: 381, scope: !1164, inlinedAt: !1850)
!1850 = !DILocation(line: 449, scope: !1166, inlinedAt: !1851)
!1851 = !DILocation(line: 492, scope: !1168, inlinedAt: !1852)
!1852 = !DILocation(line: 269, scope: !1170, inlinedAt: !1831)
!1853 = !DILocation(line: 499, scope: !1166, inlinedAt: !1850)
!1854 = !DILocation(line: 38, scope: !1173, inlinedAt: !1851)
!1855 = !DILocation(line: 35, scope: !1175, inlinedAt: !1852)
!1856 = !DILocation(line: 93, scope: !1135, inlinedAt: !1832)
!1857 = !DILocation(line: 37, scope: !1119, inlinedAt: !1858)
!1858 = !DILocation(line: 124, scope: !1135, inlinedAt: !1832)
!1859 = !DILocation(line: 27, scope: !1180, inlinedAt: !1860)
!1860 = !DILocation(line: 37, scope: !1182, inlinedAt: !1861)
!1861 = !DILocation(line: 36, scope: !1182, inlinedAt: !1858)
!1862 = !DILocation(line: 499, scope: !1166, inlinedAt: !1863)
!1863 = !DILocation(line: 38, scope: !1182, inlinedAt: !1861)
!1864 = !DILocation(line: 499, scope: !1166, inlinedAt: !1865)
!1865 = !DILocation(line: 40, scope: !1182, inlinedAt: !1861)
!1866 = !DILocation(line: 40, scope: !1099, inlinedAt: !1867)
!1867 = !DILocation(line: 0, scope: !1111, inlinedAt: !1868)
!1868 = !DILocation(line: 0, scope: !1113, inlinedAt: !1869)
!1869 = !DILocation(line: 11, scope: !1192, inlinedAt: !1870)
!1870 = !DILocation(line: 31, scope: !1194, inlinedAt: !1871)
!1871 = !DILocation(line: 41, scope: !1182, inlinedAt: !1861)
!1872 = !DILocation(line: 37, scope: !1119, inlinedAt: !1869)
!1873 = !DILocation(line: 30, scope: !1121, inlinedAt: !1869)
!1874 = !DILocation(line: 126, scope: !1199, inlinedAt: !1875)
!1875 = !DILocation(line: 126, scope: !1199, inlinedAt: !1876)
!1876 = !DILocation(line: 33, scope: !1194, inlinedAt: !1871)
!1877 = !DILocation(line: 108, scope: !1203, inlinedAt: !1878)
!1878 = !DILocation(line: 46, scope: !1182, inlinedAt: !1861)
!1879 = !DILocation(line: 47, scope: !1182, inlinedAt: !1861)
!1880 = !DILocation(line: 6, scope: !1207, inlinedAt: !1881)
!1881 = !DILocation(line: 109, scope: !1135, inlinedAt: !1832)
!1882 = !DILocation(line: 37, scope: !1119, inlinedAt: !1825)
!1883 = !DILocation(line: 513, scope: !1094, inlinedAt: !1884)
!1884 = !DILocation(line: 100, scope: !1245, inlinedAt: !1885)
!1885 = !DILocation(line: 114, scope: !1247, inlinedAt: !1825)
!1886 = !DILocation(line: 513, scope: !1094, inlinedAt: !1887)
!1887 = !DILocation(line: 102, scope: !1250, inlinedAt: !1888)
!1888 = !DILocation(line: 471, scope: !1252, inlinedAt: !1885)
!1889 = !DILocation(line: 40, scope: !1099, inlinedAt: !1890)
!1890 = !DILocation(line: 0, scope: !1111, inlinedAt: !1891)
!1891 = !DILocation(line: 0, scope: !1512, inlinedAt: !1825)
!1892 = !DILocation(line: 513, scope: !1094, inlinedAt: !1825)
!1893 = !DILocation(line: 40, scope: !1099, inlinedAt: !1894)
!1894 = !DILocation(line: 46, scope: !1262, inlinedAt: !1895)
!1895 = !DILocation(line: 46, scope: !1264, inlinedAt: !1896)
!1896 = !DILocation(line: 88, scope: !1266, inlinedAt: !1897)
!1897 = !DILocation(line: 88, scope: !1266, inlinedAt: !1825)
!1898 = !DILocation(line: 158, scope: !1520, inlinedAt: !1825)
!1899 = !DILocation(line: 40, scope: !1099, inlinedAt: !1900)
!1900 = !DILocation(line: 0, scope: !1111, inlinedAt: !1901)
!1901 = !DILocation(line: 0, scope: !1512, inlinedAt: !1902)
!1902 = !DILocation(line: 57, scope: !1096, inlinedAt: !1542)
!1903 = !DILocation(line: 513, scope: !1094, inlinedAt: !1904)
!1904 = !DILocation(line: 100, scope: !1245, inlinedAt: !1905)
!1905 = !DILocation(line: 114, scope: !1247, inlinedAt: !1906)
!1906 = !DILocation(line: 59, scope: !1096, inlinedAt: !1542)
!1907 = !DILocation(line: 513, scope: !1094, inlinedAt: !1908)
!1908 = !DILocation(line: 102, scope: !1250, inlinedAt: !1909)
!1909 = !DILocation(line: 471, scope: !1252, inlinedAt: !1905)
!1910 = !DILocation(line: 40, scope: !1099, inlinedAt: !1911)
!1911 = !DILocation(line: 46, scope: !1262, inlinedAt: !1912)
!1912 = !DILocation(line: 46, scope: !1264, inlinedAt: !1913)
!1913 = !DILocation(line: 88, scope: !1266, inlinedAt: !1914)
!1914 = !DILocation(line: 88, scope: !1266, inlinedAt: !1915)
!1915 = !DILocation(line: 88, scope: !1266, inlinedAt: !1906)
!1916 = !DILocation(line: 513, scope: !1094, inlinedAt: !1917)
!1917 = !DILocation(line: 60, scope: !1096, inlinedAt: !1542)
!1918 = !DILocation(line: 40, scope: !1099, inlinedAt: !1919)
!1919 = !DILocation(line: 0, scope: !1111, inlinedAt: !1920)
!1920 = !DILocation(line: 0, scope: !1113, inlinedAt: !1921)
!1921 = !DILocation(line: 19, scope: !1922, inlinedAt: !1923)
!1922 = distinct !DISubprogram(name: "printf_output_context;", linkageName: "printf_output_context", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!1923 = !DILocation(line: 187, scope: !1438, inlinedAt: !1924)
!1924 = !DILocation(line: 93, scope: !1082)
!1925 = !DILocation(line: 37, scope: !1119, inlinedAt: !1921)
!1926 = !DILocation(line: 30, scope: !1121, inlinedAt: !1921)
!1927 = !DILocation(line: 111, scope: !1123, inlinedAt: !1928)
!1928 = !DILocation(line: 111, scope: !1123, inlinedAt: !1923)
!1929 = !DILocation(line: 37, scope: !1119, inlinedAt: !1930)
!1930 = !DILocation(line: 188, scope: !1438, inlinedAt: !1924)
!1931 = !DILocation(line: 513, scope: !1094, inlinedAt: !1930)
!1932 = !DILocation(line: 40, scope: !1099, inlinedAt: !1933)
!1933 = !DILocation(line: 3, scope: !1127, inlinedAt: !1934)
!1934 = !DILocation(line: 3, scope: !1129, inlinedAt: !1935)
!1935 = !DILocation(line: 89, scope: !1131, inlinedAt: !1936)
!1936 = !DILocation(line: 124, scope: !1133, inlinedAt: !1937)
!1937 = !DILocation(line: 92, scope: !1135, inlinedAt: !1938)
!1938 = !DILocation(line: 0, scope: !1111, inlinedAt: !1939)
!1939 = !DILocation(line: 0, scope: !1138, inlinedAt: !1940)
!1940 = !DILocation(line: 115, scope: !1454, inlinedAt: !1941)
!1941 = !DILocation(line: 193, scope: !1438, inlinedAt: !1924)
!1942 = !DILocation(line: 87, scope: !1106, inlinedAt: !1943)
!1943 = !DILocation(line: 1042, scope: !1106, inlinedAt: !1935)
!1944 = !DILocation(line: 40, scope: !1099, inlinedAt: !1945)
!1945 = !DILocation(line: 3, scope: !1127, inlinedAt: !1946)
!1946 = !DILocation(line: 3, scope: !1129, inlinedAt: !1947)
!1947 = !DILocation(line: 89, scope: !1149, inlinedAt: !1936)
!1948 = !DILocation(line: 40, scope: !1099, inlinedAt: !1949)
!1949 = !DILocation(line: 3, scope: !1127, inlinedAt: !1950)
!1950 = !DILocation(line: 3, scope: !1129, inlinedAt: !1951)
!1951 = !DILocation(line: 89, scope: !1154, inlinedAt: !1936)
!1952 = !DILocation(line: 763, scope: !1156, inlinedAt: !1953)
!1953 = !DILocation(line: 789, scope: !1158, inlinedAt: !1954)
!1954 = !DILocation(line: 7, scope: !1160, inlinedAt: !1955)
!1955 = !DILocation(line: 358, scope: !1162, inlinedAt: !1956)
!1956 = !DILocation(line: 381, scope: !1164, inlinedAt: !1957)
!1957 = !DILocation(line: 449, scope: !1166, inlinedAt: !1958)
!1958 = !DILocation(line: 492, scope: !1168, inlinedAt: !1959)
!1959 = !DILocation(line: 269, scope: !1170, inlinedAt: !1937)
!1960 = !DILocation(line: 499, scope: !1166, inlinedAt: !1957)
!1961 = !DILocation(line: 38, scope: !1173, inlinedAt: !1958)
!1962 = !DILocation(line: 35, scope: !1175, inlinedAt: !1959)
!1963 = !DILocation(line: 93, scope: !1135, inlinedAt: !1938)
!1964 = !DILocation(line: 37, scope: !1119, inlinedAt: !1965)
!1965 = !DILocation(line: 124, scope: !1135, inlinedAt: !1938)
!1966 = !DILocation(line: 27, scope: !1180, inlinedAt: !1967)
!1967 = !DILocation(line: 37, scope: !1182, inlinedAt: !1968)
!1968 = !DILocation(line: 36, scope: !1182, inlinedAt: !1965)
!1969 = !DILocation(line: 499, scope: !1166, inlinedAt: !1970)
!1970 = !DILocation(line: 38, scope: !1182, inlinedAt: !1968)
!1971 = !DILocation(line: 499, scope: !1166, inlinedAt: !1972)
!1972 = !DILocation(line: 40, scope: !1182, inlinedAt: !1968)
!1973 = !DILocation(line: 40, scope: !1099, inlinedAt: !1974)
!1974 = !DILocation(line: 0, scope: !1111, inlinedAt: !1975)
!1975 = !DILocation(line: 0, scope: !1113, inlinedAt: !1976)
!1976 = !DILocation(line: 11, scope: !1192, inlinedAt: !1977)
!1977 = !DILocation(line: 31, scope: !1194, inlinedAt: !1978)
!1978 = !DILocation(line: 41, scope: !1182, inlinedAt: !1968)
!1979 = !DILocation(line: 37, scope: !1119, inlinedAt: !1976)
!1980 = !DILocation(line: 30, scope: !1121, inlinedAt: !1976)
!1981 = !DILocation(line: 126, scope: !1199, inlinedAt: !1982)
!1982 = !DILocation(line: 126, scope: !1199, inlinedAt: !1983)
!1983 = !DILocation(line: 33, scope: !1194, inlinedAt: !1978)
!1984 = !DILocation(line: 108, scope: !1203, inlinedAt: !1985)
!1985 = !DILocation(line: 46, scope: !1182, inlinedAt: !1968)
!1986 = !DILocation(line: 47, scope: !1182, inlinedAt: !1968)
!1987 = !DILocation(line: 6, scope: !1207, inlinedAt: !1988)
!1988 = !DILocation(line: 109, scope: !1135, inlinedAt: !1938)
!1989 = !DILocation(line: 40, scope: !1099, inlinedAt: !1990)
!1990 = !DILocation(line: 46, scope: !1262, inlinedAt: !1991)
!1991 = !DILocation(line: 46, scope: !1264, inlinedAt: !1992)
!1992 = !DILocation(line: 88, scope: !1266, inlinedAt: !1993)
!1993 = !DILocation(line: 88, scope: !1266, inlinedAt: !1994)
!1994 = !DILocation(line: 88, scope: !1266, inlinedAt: !1995)
!1995 = !DILocation(line: 195, scope: !1438, inlinedAt: !1924)
!1996 = !DILocation(line: 513, scope: !1094, inlinedAt: !1997)
!1997 = !DILocation(line: 100, scope: !1245, inlinedAt: !1998)
!1998 = !DILocation(line: 114, scope: !1247, inlinedAt: !1999)
!1999 = !DILocation(line: 196, scope: !1438, inlinedAt: !1924)
!2000 = !DILocation(line: 513, scope: !1094, inlinedAt: !2001)
!2001 = !DILocation(line: 102, scope: !1250, inlinedAt: !2002)
!2002 = !DILocation(line: 471, scope: !1252, inlinedAt: !1998)
!2003 = !DILocation(line: 513, scope: !1094, inlinedAt: !2004)
!2004 = !DILocation(line: 153, scope: !2005, inlinedAt: !2006)
!2005 = distinct !DISubprogram(name: "_rocprintf_fmt;", linkageName: "_rocprintf_fmt", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!2006 = !DILocation(line: 198, scope: !1438, inlinedAt: !1924)
!2007 = !DILocation(line: 40, scope: !1099, inlinedAt: !2008)
!2008 = !DILocation(line: 46, scope: !1262, inlinedAt: !2009)
!2009 = !DILocation(line: 46, scope: !1264, inlinedAt: !2010)
!2010 = !DILocation(line: 88, scope: !1266, inlinedAt: !2011)
!2011 = !DILocation(line: 88, scope: !1266, inlinedAt: !2012)
!2012 = !DILocation(line: 88, scope: !1266, inlinedAt: !2004)
!2013 = !DILocation(line: 513, scope: !1094, inlinedAt: !2014)
!2014 = !DILocation(line: 100, scope: !1245, inlinedAt: !2015)
!2015 = !DILocation(line: 114, scope: !1247, inlinedAt: !2016)
!2016 = !DILocation(line: 154, scope: !2005, inlinedAt: !2006)
!2017 = !DILocation(line: 513, scope: !1094, inlinedAt: !2018)
!2018 = !DILocation(line: 102, scope: !1250, inlinedAt: !2019)
!2019 = !DILocation(line: 471, scope: !1252, inlinedAt: !2015)
!2020 = !DILocation(line: 40, scope: !1099, inlinedAt: !2021)
!2021 = !DILocation(line: 46, scope: !1262, inlinedAt: !2022)
!2022 = !DILocation(line: 46, scope: !1264, inlinedAt: !2023)
!2023 = !DILocation(line: 88, scope: !1266, inlinedAt: !2024)
!2024 = !DILocation(line: 88, scope: !1266, inlinedAt: !2025)
!2025 = !DILocation(line: 88, scope: !1266, inlinedAt: !2026)
!2026 = !DILocation(line: 155, scope: !2005, inlinedAt: !2006)
!2027 = !DILocation(line: 513, scope: !1094, inlinedAt: !2028)
!2028 = !DILocation(line: 100, scope: !1245, inlinedAt: !2029)
!2029 = !DILocation(line: 114, scope: !1247, inlinedAt: !2030)
!2030 = !DILocation(line: 156, scope: !2005, inlinedAt: !2006)
!2031 = !DILocation(line: 513, scope: !1094, inlinedAt: !2032)
!2032 = !DILocation(line: 102, scope: !1250, inlinedAt: !2033)
!2033 = !DILocation(line: 471, scope: !1252, inlinedAt: !2029)
!2034 = !DILocation(line: 40, scope: !1099, inlinedAt: !2035)
!2035 = !DILocation(line: 3, scope: !1127, inlinedAt: !2036)
!2036 = !DILocation(line: 3, scope: !1129, inlinedAt: !2037)
!2037 = !DILocation(line: 89, scope: !1131, inlinedAt: !2038)
!2038 = !DILocation(line: 124, scope: !1133, inlinedAt: !2039)
!2039 = !DILocation(line: 92, scope: !1135, inlinedAt: !2040)
!2040 = !DILocation(line: 201, scope: !1438, inlinedAt: !1924)
!2041 = !DILocation(line: 87, scope: !1106, inlinedAt: !2042)
!2042 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2037)
!2043 = !DILocation(line: 40, scope: !1099, inlinedAt: !2044)
!2044 = !DILocation(line: 3, scope: !1127, inlinedAt: !2045)
!2045 = !DILocation(line: 3, scope: !1129, inlinedAt: !2046)
!2046 = !DILocation(line: 89, scope: !1149, inlinedAt: !2038)
!2047 = !DILocation(line: 40, scope: !1099, inlinedAt: !2048)
!2048 = !DILocation(line: 3, scope: !1127, inlinedAt: !2049)
!2049 = !DILocation(line: 3, scope: !1129, inlinedAt: !2050)
!2050 = !DILocation(line: 89, scope: !1154, inlinedAt: !2038)
!2051 = !DILocation(line: 763, scope: !1156, inlinedAt: !2052)
!2052 = !DILocation(line: 789, scope: !1158, inlinedAt: !2053)
!2053 = !DILocation(line: 7, scope: !1160, inlinedAt: !2054)
!2054 = !DILocation(line: 358, scope: !1162, inlinedAt: !2055)
!2055 = !DILocation(line: 381, scope: !1164, inlinedAt: !2056)
!2056 = !DILocation(line: 449, scope: !1166, inlinedAt: !2057)
!2057 = !DILocation(line: 492, scope: !1168, inlinedAt: !2058)
!2058 = !DILocation(line: 269, scope: !1170, inlinedAt: !2039)
!2059 = !DILocation(line: 499, scope: !1166, inlinedAt: !2056)
!2060 = !DILocation(line: 38, scope: !1173, inlinedAt: !2057)
!2061 = !DILocation(line: 35, scope: !1175, inlinedAt: !2058)
!2062 = !DILocation(line: 93, scope: !1135, inlinedAt: !2040)
!2063 = !DILocation(line: 40, scope: !1099, inlinedAt: !2064)
!2064 = !DILocation(line: 46, scope: !1262, inlinedAt: !2065)
!2065 = !DILocation(line: 46, scope: !1264, inlinedAt: !2066)
!2066 = !DILocation(line: 88, scope: !1266, inlinedAt: !2067)
!2067 = !DILocation(line: 88, scope: !1266, inlinedAt: !2068)
!2068 = !DILocation(line: 88, scope: !1266, inlinedAt: !2069)
!2069 = !DILocation(line: 166, scope: !2070, inlinedAt: !2071)
!2070 = distinct !DISubprogram(name: "_rocprintf_arg;", linkageName: "_rocprintf_arg", scope: !507, file: !507, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!2071 = !DILocation(line: 107, scope: !1135, inlinedAt: !2040)
!2072 = !DILocation(line: 513, scope: !1094, inlinedAt: !2073)
!2073 = !DILocation(line: 100, scope: !1245, inlinedAt: !2074)
!2074 = !DILocation(line: 114, scope: !1247, inlinedAt: !2075)
!2075 = !DILocation(line: 167, scope: !2070, inlinedAt: !2071)
!2076 = !DILocation(line: 513, scope: !1094, inlinedAt: !2077)
!2077 = !DILocation(line: 102, scope: !1250, inlinedAt: !2078)
!2078 = !DILocation(line: 471, scope: !1252, inlinedAt: !2074)
!2079 = !DILocation(line: 40, scope: !1099, inlinedAt: !2080)
!2080 = !DILocation(line: 46, scope: !1262, inlinedAt: !2081)
!2081 = !DILocation(line: 46, scope: !1264, inlinedAt: !2082)
!2082 = !DILocation(line: 88, scope: !1266, inlinedAt: !2083)
!2083 = !DILocation(line: 88, scope: !1266, inlinedAt: !2084)
!2084 = !DILocation(line: 88, scope: !1266, inlinedAt: !2085)
!2085 = !DILocation(line: 169, scope: !2070, inlinedAt: !2071)
!2086 = !DILocation(line: 513, scope: !1094, inlinedAt: !2087)
!2087 = !DILocation(line: 100, scope: !1245, inlinedAt: !2088)
!2088 = !DILocation(line: 114, scope: !1247, inlinedAt: !2089)
!2089 = !DILocation(line: 170, scope: !2070, inlinedAt: !2071)
!2090 = !DILocation(line: 513, scope: !1094, inlinedAt: !2091)
!2091 = !DILocation(line: 102, scope: !1250, inlinedAt: !2092)
!2092 = !DILocation(line: 471, scope: !1252, inlinedAt: !2088)
!2093 = !DILocation(line: 40, scope: !1099, inlinedAt: !2094)
!2094 = !DILocation(line: 46, scope: !1262, inlinedAt: !2095)
!2095 = !DILocation(line: 46, scope: !1264, inlinedAt: !2096)
!2096 = !DILocation(line: 88, scope: !1266, inlinedAt: !2097)
!2097 = !DILocation(line: 88, scope: !1266, inlinedAt: !2098)
!2098 = !DILocation(line: 88, scope: !1266, inlinedAt: !2071)
!2099 = !DILocation(line: 6, scope: !1207, inlinedAt: !2100)
!2100 = !DILocation(line: 109, scope: !1135, inlinedAt: !2040)
!2101 = !DILocation(line: 40, scope: !1099, inlinedAt: !2102)
!2102 = !DILocation(line: 3, scope: !1127, inlinedAt: !2103)
!2103 = !DILocation(line: 3, scope: !1129, inlinedAt: !2104)
!2104 = !DILocation(line: 89, scope: !1131, inlinedAt: !2105)
!2105 = !DILocation(line: 124, scope: !1133, inlinedAt: !2106)
!2106 = !DILocation(line: 92, scope: !1135, inlinedAt: !2107)
!2107 = !DILocation(line: 0, scope: !1111, inlinedAt: !2108)
!2108 = !DILocation(line: 0, scope: !1274, inlinedAt: !2109)
!2109 = !DILocation(line: 158, scope: !1520, inlinedAt: !2040)
!2110 = !DILocation(line: 87, scope: !1106, inlinedAt: !2111)
!2111 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2104)
!2112 = !DILocation(line: 40, scope: !1099, inlinedAt: !2113)
!2113 = !DILocation(line: 3, scope: !1127, inlinedAt: !2114)
!2114 = !DILocation(line: 3, scope: !1129, inlinedAt: !2115)
!2115 = !DILocation(line: 89, scope: !1149, inlinedAt: !2105)
!2116 = !DILocation(line: 40, scope: !1099, inlinedAt: !2117)
!2117 = !DILocation(line: 3, scope: !1127, inlinedAt: !2118)
!2118 = !DILocation(line: 3, scope: !1129, inlinedAt: !2119)
!2119 = !DILocation(line: 89, scope: !1154, inlinedAt: !2105)
!2120 = !DILocation(line: 763, scope: !1156, inlinedAt: !2121)
!2121 = !DILocation(line: 789, scope: !1158, inlinedAt: !2122)
!2122 = !DILocation(line: 7, scope: !1160, inlinedAt: !2123)
!2123 = !DILocation(line: 358, scope: !1162, inlinedAt: !2124)
!2124 = !DILocation(line: 381, scope: !1164, inlinedAt: !2125)
!2125 = !DILocation(line: 449, scope: !1166, inlinedAt: !2126)
!2126 = !DILocation(line: 492, scope: !1168, inlinedAt: !2127)
!2127 = !DILocation(line: 269, scope: !1170, inlinedAt: !2106)
!2128 = !DILocation(line: 499, scope: !1166, inlinedAt: !2125)
!2129 = !DILocation(line: 38, scope: !1173, inlinedAt: !2126)
!2130 = !DILocation(line: 35, scope: !1175, inlinedAt: !2127)
!2131 = !DILocation(line: 93, scope: !1135, inlinedAt: !2107)
!2132 = !DILocation(line: 37, scope: !1119, inlinedAt: !2133)
!2133 = !DILocation(line: 174, scope: !1135, inlinedAt: !2107)
!2134 = !DILocation(line: 27, scope: !1180, inlinedAt: !2135)
!2135 = !DILocation(line: 37, scope: !1182, inlinedAt: !2136)
!2136 = !DILocation(line: 36, scope: !1182, inlinedAt: !2133)
!2137 = !DILocation(line: 499, scope: !1166, inlinedAt: !2138)
!2138 = !DILocation(line: 38, scope: !1182, inlinedAt: !2136)
!2139 = !DILocation(line: 499, scope: !1166, inlinedAt: !2140)
!2140 = !DILocation(line: 40, scope: !1182, inlinedAt: !2136)
!2141 = !DILocation(line: 40, scope: !1099, inlinedAt: !2142)
!2142 = !DILocation(line: 0, scope: !1111, inlinedAt: !2143)
!2143 = !DILocation(line: 0, scope: !1113, inlinedAt: !2144)
!2144 = !DILocation(line: 11, scope: !1192, inlinedAt: !2145)
!2145 = !DILocation(line: 31, scope: !1194, inlinedAt: !2146)
!2146 = !DILocation(line: 41, scope: !1182, inlinedAt: !2136)
!2147 = !DILocation(line: 37, scope: !1119, inlinedAt: !2144)
!2148 = !DILocation(line: 30, scope: !1121, inlinedAt: !2144)
!2149 = !DILocation(line: 126, scope: !1199, inlinedAt: !2150)
!2150 = !DILocation(line: 126, scope: !1199, inlinedAt: !2151)
!2151 = !DILocation(line: 33, scope: !1194, inlinedAt: !2146)
!2152 = !DILocation(line: 108, scope: !1203, inlinedAt: !2153)
!2153 = !DILocation(line: 46, scope: !1182, inlinedAt: !2136)
!2154 = !DILocation(line: 47, scope: !1182, inlinedAt: !2136)
!2155 = !DILocation(line: 37, scope: !1119, inlinedAt: !2156)
!2156 = !DILocation(line: 176, scope: !1135, inlinedAt: !2107)
!2157 = !DILocation(line: 12, scope: !1339, inlinedAt: !2158)
!2158 = !DILocation(line: 61, scope: !1341, inlinedAt: !2159)
!2159 = !DILocation(line: 60, scope: !1341, inlinedAt: !2156)
!2160 = !DILocation(line: 499, scope: !1166, inlinedAt: !2161)
!2161 = !DILocation(line: 62, scope: !1341, inlinedAt: !2159)
!2162 = !DILocation(line: 499, scope: !1166, inlinedAt: !2163)
!2163 = !DILocation(line: 64, scope: !1341, inlinedAt: !2159)
!2164 = !DILocation(line: 40, scope: !1099, inlinedAt: !2165)
!2165 = !DILocation(line: 0, scope: !1111, inlinedAt: !2166)
!2166 = !DILocation(line: 0, scope: !1113, inlinedAt: !2167)
!2167 = !DILocation(line: 11, scope: !1192, inlinedAt: !2168)
!2168 = !DILocation(line: 31, scope: !1194, inlinedAt: !2169)
!2169 = !DILocation(line: 65, scope: !1341, inlinedAt: !2159)
!2170 = !DILocation(line: 37, scope: !1119, inlinedAt: !2167)
!2171 = !DILocation(line: 30, scope: !1121, inlinedAt: !2167)
!2172 = !DILocation(line: 126, scope: !1199, inlinedAt: !2173)
!2173 = !DILocation(line: 126, scope: !1199, inlinedAt: !2174)
!2174 = !DILocation(line: 33, scope: !1194, inlinedAt: !2169)
!2175 = !DILocation(line: 108, scope: !1203, inlinedAt: !2176)
!2176 = !DILocation(line: 70, scope: !1341, inlinedAt: !2159)
!2177 = !DILocation(line: 71, scope: !1341, inlinedAt: !2159)
!2178 = !DILocation(line: 37, scope: !1119, inlinedAt: !2179)
!2179 = !DILocation(line: 188, scope: !1135, inlinedAt: !2107)
!2180 = !DILocation(line: 19, scope: !1383, inlinedAt: !2181)
!2181 = !DILocation(line: 19, scope: !1383, inlinedAt: !2179)
!2182 = !DILocation(line: 6, scope: !1207, inlinedAt: !2183)
!2183 = !DILocation(line: 109, scope: !1135, inlinedAt: !2107)
!2184 = !DILocation(line: 40, scope: !1099, inlinedAt: !2185)
!2185 = !DILocation(line: 0, scope: !1111, inlinedAt: !2186)
!2186 = !DILocation(line: 0, scope: !1113, inlinedAt: !2187)
!2187 = !DILocation(line: 27, scope: !2188, inlinedAt: !2189)
!2188 = distinct !DISubprogram(name: "free_hc;", linkageName: "free_hc", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!2189 = !DILocation(line: 10, scope: !2190, inlinedAt: !2191)
!2190 = distinct !DISubprogram(name: "free;", linkageName: "free", scope: !56, file: !56, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !60, retainedNodes: !69)
!2191 = !DILocation(line: 94, scope: !1082)
!2192 = !DILocation(line: 37, scope: !1119, inlinedAt: !2187)
!2193 = !DILocation(line: 30, scope: !1121, inlinedAt: !2187)
!2194 = !DILocation(line: 111, scope: !1123, inlinedAt: !2195)
!2195 = !DILocation(line: 111, scope: !1123, inlinedAt: !2189)
!2196 = !DILocation(line: 40, scope: !1099, inlinedAt: !2197)
!2197 = !DILocation(line: 3, scope: !1127, inlinedAt: !2198)
!2198 = !DILocation(line: 3, scope: !1129, inlinedAt: !2199)
!2199 = !DILocation(line: 89, scope: !1131, inlinedAt: !2200)
!2200 = !DILocation(line: 124, scope: !1133, inlinedAt: !2201)
!2201 = !DILocation(line: 92, scope: !1135, inlinedAt: !2202)
!2202 = !DILocation(line: 0, scope: !1111, inlinedAt: !2203)
!2203 = !DILocation(line: 0, scope: !1138, inlinedAt: !2204)
!2204 = !DILocation(line: 71, scope: !1140, inlinedAt: !2205)
!2205 = !DILocation(line: 65, scope: !1140, inlinedAt: !2206)
!2206 = !DILocation(line: 11, scope: !2190, inlinedAt: !2191)
!2207 = !DILocation(line: 87, scope: !1106, inlinedAt: !2208)
!2208 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2199)
!2209 = !DILocation(line: 40, scope: !1099, inlinedAt: !2210)
!2210 = !DILocation(line: 3, scope: !1127, inlinedAt: !2211)
!2211 = !DILocation(line: 3, scope: !1129, inlinedAt: !2212)
!2212 = !DILocation(line: 89, scope: !1149, inlinedAt: !2200)
!2213 = !DILocation(line: 40, scope: !1099, inlinedAt: !2214)
!2214 = !DILocation(line: 3, scope: !1127, inlinedAt: !2215)
!2215 = !DILocation(line: 3, scope: !1129, inlinedAt: !2216)
!2216 = !DILocation(line: 89, scope: !1154, inlinedAt: !2200)
!2217 = !DILocation(line: 763, scope: !1156, inlinedAt: !2218)
!2218 = !DILocation(line: 789, scope: !1158, inlinedAt: !2219)
!2219 = !DILocation(line: 7, scope: !1160, inlinedAt: !2220)
!2220 = !DILocation(line: 358, scope: !1162, inlinedAt: !2221)
!2221 = !DILocation(line: 381, scope: !1164, inlinedAt: !2222)
!2222 = !DILocation(line: 449, scope: !1166, inlinedAt: !2223)
!2223 = !DILocation(line: 492, scope: !1168, inlinedAt: !2224)
!2224 = !DILocation(line: 269, scope: !1170, inlinedAt: !2201)
!2225 = !DILocation(line: 499, scope: !1166, inlinedAt: !2222)
!2226 = !DILocation(line: 38, scope: !1173, inlinedAt: !2223)
!2227 = !DILocation(line: 35, scope: !1175, inlinedAt: !2224)
!2228 = !DILocation(line: 93, scope: !1135, inlinedAt: !2202)
!2229 = !DILocation(line: 37, scope: !1119, inlinedAt: !2230)
!2230 = !DILocation(line: 124, scope: !1135, inlinedAt: !2202)
!2231 = !DILocation(line: 27, scope: !1180, inlinedAt: !2232)
!2232 = !DILocation(line: 37, scope: !1182, inlinedAt: !2233)
!2233 = !DILocation(line: 36, scope: !1182, inlinedAt: !2230)
!2234 = !DILocation(line: 499, scope: !1166, inlinedAt: !2235)
!2235 = !DILocation(line: 38, scope: !1182, inlinedAt: !2233)
!2236 = !DILocation(line: 499, scope: !1166, inlinedAt: !2237)
!2237 = !DILocation(line: 40, scope: !1182, inlinedAt: !2233)
!2238 = !DILocation(line: 40, scope: !1099, inlinedAt: !2239)
!2239 = !DILocation(line: 0, scope: !1111, inlinedAt: !2240)
!2240 = !DILocation(line: 0, scope: !1113, inlinedAt: !2241)
!2241 = !DILocation(line: 11, scope: !1192, inlinedAt: !2242)
!2242 = !DILocation(line: 31, scope: !1194, inlinedAt: !2243)
!2243 = !DILocation(line: 41, scope: !1182, inlinedAt: !2233)
!2244 = !DILocation(line: 37, scope: !1119, inlinedAt: !2241)
!2245 = !DILocation(line: 30, scope: !1121, inlinedAt: !2241)
!2246 = !DILocation(line: 126, scope: !1199, inlinedAt: !2247)
!2247 = !DILocation(line: 126, scope: !1199, inlinedAt: !2248)
!2248 = !DILocation(line: 33, scope: !1194, inlinedAt: !2243)
!2249 = !DILocation(line: 108, scope: !1203, inlinedAt: !2250)
!2250 = !DILocation(line: 46, scope: !1182, inlinedAt: !2233)
!2251 = !DILocation(line: 47, scope: !1182, inlinedAt: !2233)
!2252 = !DILocation(line: 6, scope: !1207, inlinedAt: !2253)
!2253 = !DILocation(line: 109, scope: !1135, inlinedAt: !2202)
!2254 = !DILocation(line: 40, scope: !1099, inlinedAt: !2255)
!2255 = !DILocation(line: 3, scope: !1127, inlinedAt: !2256)
!2256 = !DILocation(line: 3, scope: !1129, inlinedAt: !2257)
!2257 = !DILocation(line: 89, scope: !1131, inlinedAt: !2258)
!2258 = !DILocation(line: 124, scope: !1133, inlinedAt: !2259)
!2259 = !DILocation(line: 92, scope: !1135, inlinedAt: !2260)
!2260 = !DILocation(line: 0, scope: !1111, inlinedAt: !2261)
!2261 = !DILocation(line: 0, scope: !1217, inlinedAt: !2262)
!2262 = !DILocation(line: 72, scope: !1140, inlinedAt: !2205)
!2263 = !DILocation(line: 87, scope: !1106, inlinedAt: !2264)
!2264 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2257)
!2265 = !DILocation(line: 40, scope: !1099, inlinedAt: !2266)
!2266 = !DILocation(line: 3, scope: !1127, inlinedAt: !2267)
!2267 = !DILocation(line: 3, scope: !1129, inlinedAt: !2268)
!2268 = !DILocation(line: 89, scope: !1149, inlinedAt: !2258)
!2269 = !DILocation(line: 40, scope: !1099, inlinedAt: !2270)
!2270 = !DILocation(line: 3, scope: !1127, inlinedAt: !2271)
!2271 = !DILocation(line: 3, scope: !1129, inlinedAt: !2272)
!2272 = !DILocation(line: 89, scope: !1154, inlinedAt: !2258)
!2273 = !DILocation(line: 763, scope: !1156, inlinedAt: !2274)
!2274 = !DILocation(line: 789, scope: !1158, inlinedAt: !2275)
!2275 = !DILocation(line: 7, scope: !1160, inlinedAt: !2276)
!2276 = !DILocation(line: 358, scope: !1162, inlinedAt: !2277)
!2277 = !DILocation(line: 381, scope: !1164, inlinedAt: !2278)
!2278 = !DILocation(line: 449, scope: !1166, inlinedAt: !2279)
!2279 = !DILocation(line: 492, scope: !1168, inlinedAt: !2280)
!2280 = !DILocation(line: 269, scope: !1170, inlinedAt: !2259)
!2281 = !DILocation(line: 499, scope: !1166, inlinedAt: !2278)
!2282 = !DILocation(line: 38, scope: !1173, inlinedAt: !2279)
!2283 = !DILocation(line: 35, scope: !1175, inlinedAt: !2280)
!2284 = !DILocation(line: 93, scope: !1135, inlinedAt: !2260)
!2285 = !DILocation(line: 37, scope: !1119, inlinedAt: !2286)
!2286 = !DILocation(line: 152, scope: !1135, inlinedAt: !2260)
!2287 = !DILocation(line: 513, scope: !1094, inlinedAt: !2288)
!2288 = !DILocation(line: 100, scope: !1245, inlinedAt: !2289)
!2289 = !DILocation(line: 114, scope: !1247, inlinedAt: !2286)
!2290 = !DILocation(line: 513, scope: !1094, inlinedAt: !2291)
!2291 = !DILocation(line: 102, scope: !1250, inlinedAt: !2292)
!2292 = !DILocation(line: 471, scope: !1252, inlinedAt: !2289)
!2293 = !DILocation(line: 513, scope: !1094, inlinedAt: !2294)
!2294 = !DILocation(line: 100, scope: !1245, inlinedAt: !2295)
!2295 = !DILocation(line: 115, scope: !1256, inlinedAt: !2286)
!2296 = !DILocation(line: 513, scope: !1094, inlinedAt: !2297)
!2297 = !DILocation(line: 102, scope: !1250, inlinedAt: !2298)
!2298 = !DILocation(line: 471, scope: !1252, inlinedAt: !2295)
!2299 = !DILocation(line: 40, scope: !1099, inlinedAt: !2300)
!2300 = !DILocation(line: 46, scope: !1262, inlinedAt: !2301)
!2301 = !DILocation(line: 46, scope: !1264, inlinedAt: !2302)
!2302 = !DILocation(line: 88, scope: !1266, inlinedAt: !2303)
!2303 = !DILocation(line: 88, scope: !1266, inlinedAt: !2304)
!2304 = !DILocation(line: 88, scope: !1266, inlinedAt: !2286)
!2305 = !DILocation(line: 6, scope: !1207, inlinedAt: !2306)
!2306 = !DILocation(line: 109, scope: !1135, inlinedAt: !2260)
!2307 = !DILocation(line: 40, scope: !1099, inlinedAt: !2308)
!2308 = !DILocation(line: 3, scope: !1127, inlinedAt: !2309)
!2309 = !DILocation(line: 3, scope: !1129, inlinedAt: !2310)
!2310 = !DILocation(line: 89, scope: !1131, inlinedAt: !2311)
!2311 = !DILocation(line: 124, scope: !1133, inlinedAt: !2312)
!2312 = !DILocation(line: 92, scope: !1135, inlinedAt: !2313)
!2313 = !DILocation(line: 0, scope: !1111, inlinedAt: !2314)
!2314 = !DILocation(line: 0, scope: !1274, inlinedAt: !2315)
!2315 = !DILocation(line: 73, scope: !1140, inlinedAt: !2205)
!2316 = !DILocation(line: 87, scope: !1106, inlinedAt: !2317)
!2317 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2310)
!2318 = !DILocation(line: 40, scope: !1099, inlinedAt: !2319)
!2319 = !DILocation(line: 3, scope: !1127, inlinedAt: !2320)
!2320 = !DILocation(line: 3, scope: !1129, inlinedAt: !2321)
!2321 = !DILocation(line: 89, scope: !1149, inlinedAt: !2311)
!2322 = !DILocation(line: 40, scope: !1099, inlinedAt: !2323)
!2323 = !DILocation(line: 3, scope: !1127, inlinedAt: !2324)
!2324 = !DILocation(line: 3, scope: !1129, inlinedAt: !2325)
!2325 = !DILocation(line: 89, scope: !1154, inlinedAt: !2311)
!2326 = !DILocation(line: 763, scope: !1156, inlinedAt: !2327)
!2327 = !DILocation(line: 789, scope: !1158, inlinedAt: !2328)
!2328 = !DILocation(line: 7, scope: !1160, inlinedAt: !2329)
!2329 = !DILocation(line: 358, scope: !1162, inlinedAt: !2330)
!2330 = !DILocation(line: 381, scope: !1164, inlinedAt: !2331)
!2331 = !DILocation(line: 449, scope: !1166, inlinedAt: !2332)
!2332 = !DILocation(line: 492, scope: !1168, inlinedAt: !2333)
!2333 = !DILocation(line: 269, scope: !1170, inlinedAt: !2312)
!2334 = !DILocation(line: 499, scope: !1166, inlinedAt: !2331)
!2335 = !DILocation(line: 38, scope: !1173, inlinedAt: !2332)
!2336 = !DILocation(line: 35, scope: !1175, inlinedAt: !2333)
!2337 = !DILocation(line: 93, scope: !1135, inlinedAt: !2313)
!2338 = !DILocation(line: 37, scope: !1119, inlinedAt: !2339)
!2339 = !DILocation(line: 174, scope: !1135, inlinedAt: !2313)
!2340 = !DILocation(line: 27, scope: !1180, inlinedAt: !2341)
!2341 = !DILocation(line: 37, scope: !1182, inlinedAt: !2342)
!2342 = !DILocation(line: 36, scope: !1182, inlinedAt: !2339)
!2343 = !DILocation(line: 499, scope: !1166, inlinedAt: !2344)
!2344 = !DILocation(line: 38, scope: !1182, inlinedAt: !2342)
!2345 = !DILocation(line: 499, scope: !1166, inlinedAt: !2346)
!2346 = !DILocation(line: 40, scope: !1182, inlinedAt: !2342)
!2347 = !DILocation(line: 40, scope: !1099, inlinedAt: !2348)
!2348 = !DILocation(line: 0, scope: !1111, inlinedAt: !2349)
!2349 = !DILocation(line: 0, scope: !1113, inlinedAt: !2350)
!2350 = !DILocation(line: 11, scope: !1192, inlinedAt: !2351)
!2351 = !DILocation(line: 31, scope: !1194, inlinedAt: !2352)
!2352 = !DILocation(line: 41, scope: !1182, inlinedAt: !2342)
!2353 = !DILocation(line: 37, scope: !1119, inlinedAt: !2350)
!2354 = !DILocation(line: 30, scope: !1121, inlinedAt: !2350)
!2355 = !DILocation(line: 126, scope: !1199, inlinedAt: !2356)
!2356 = !DILocation(line: 126, scope: !1199, inlinedAt: !2357)
!2357 = !DILocation(line: 33, scope: !1194, inlinedAt: !2352)
!2358 = !DILocation(line: 108, scope: !1203, inlinedAt: !2359)
!2359 = !DILocation(line: 46, scope: !1182, inlinedAt: !2342)
!2360 = !DILocation(line: 47, scope: !1182, inlinedAt: !2342)
!2361 = !DILocation(line: 37, scope: !1119, inlinedAt: !2362)
!2362 = !DILocation(line: 176, scope: !1135, inlinedAt: !2313)
!2363 = !DILocation(line: 12, scope: !1339, inlinedAt: !2364)
!2364 = !DILocation(line: 61, scope: !1341, inlinedAt: !2365)
!2365 = !DILocation(line: 60, scope: !1341, inlinedAt: !2362)
!2366 = !DILocation(line: 499, scope: !1166, inlinedAt: !2367)
!2367 = !DILocation(line: 62, scope: !1341, inlinedAt: !2365)
!2368 = !DILocation(line: 499, scope: !1166, inlinedAt: !2369)
!2369 = !DILocation(line: 64, scope: !1341, inlinedAt: !2365)
!2370 = !DILocation(line: 40, scope: !1099, inlinedAt: !2371)
!2371 = !DILocation(line: 0, scope: !1111, inlinedAt: !2372)
!2372 = !DILocation(line: 0, scope: !1113, inlinedAt: !2373)
!2373 = !DILocation(line: 11, scope: !1192, inlinedAt: !2374)
!2374 = !DILocation(line: 31, scope: !1194, inlinedAt: !2375)
!2375 = !DILocation(line: 65, scope: !1341, inlinedAt: !2365)
!2376 = !DILocation(line: 37, scope: !1119, inlinedAt: !2373)
!2377 = !DILocation(line: 30, scope: !1121, inlinedAt: !2373)
!2378 = !DILocation(line: 126, scope: !1199, inlinedAt: !2379)
!2379 = !DILocation(line: 126, scope: !1199, inlinedAt: !2380)
!2380 = !DILocation(line: 33, scope: !1194, inlinedAt: !2375)
!2381 = !DILocation(line: 108, scope: !1203, inlinedAt: !2382)
!2382 = !DILocation(line: 70, scope: !1341, inlinedAt: !2365)
!2383 = !DILocation(line: 71, scope: !1341, inlinedAt: !2365)
!2384 = !DILocation(line: 37, scope: !1119, inlinedAt: !2385)
!2385 = !DILocation(line: 188, scope: !1135, inlinedAt: !2313)
!2386 = !DILocation(line: 19, scope: !1383, inlinedAt: !2387)
!2387 = !DILocation(line: 19, scope: !1383, inlinedAt: !2385)
!2388 = !DILocation(line: 6, scope: !1207, inlinedAt: !2389)
!2389 = !DILocation(line: 109, scope: !1135, inlinedAt: !2313)
!2390 = !DILocation(line: 40, scope: !1099, inlinedAt: !2391)
!2391 = !DILocation(line: 0, scope: !1111, inlinedAt: !2392)
!2392 = !DILocation(line: 0, scope: !1113, inlinedAt: !2393)
!2393 = !DILocation(line: 27, scope: !2188, inlinedAt: !2394)
!2394 = !DILocation(line: 10, scope: !2190, inlinedAt: !2395)
!2395 = !DILocation(line: 95, scope: !1082)
!2396 = !DILocation(line: 37, scope: !1119, inlinedAt: !2393)
!2397 = !DILocation(line: 30, scope: !1121, inlinedAt: !2393)
!2398 = !DILocation(line: 111, scope: !1123, inlinedAt: !2399)
!2399 = !DILocation(line: 111, scope: !1123, inlinedAt: !2394)
!2400 = !DILocation(line: 40, scope: !1099, inlinedAt: !2401)
!2401 = !DILocation(line: 3, scope: !1127, inlinedAt: !2402)
!2402 = !DILocation(line: 3, scope: !1129, inlinedAt: !2403)
!2403 = !DILocation(line: 89, scope: !1131, inlinedAt: !2404)
!2404 = !DILocation(line: 124, scope: !1133, inlinedAt: !2405)
!2405 = !DILocation(line: 92, scope: !1135, inlinedAt: !2406)
!2406 = !DILocation(line: 0, scope: !1111, inlinedAt: !2407)
!2407 = !DILocation(line: 0, scope: !1138, inlinedAt: !2408)
!2408 = !DILocation(line: 71, scope: !1140, inlinedAt: !2409)
!2409 = !DILocation(line: 65, scope: !1140, inlinedAt: !2410)
!2410 = !DILocation(line: 11, scope: !2190, inlinedAt: !2395)
!2411 = !DILocation(line: 87, scope: !1106, inlinedAt: !2412)
!2412 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2403)
!2413 = !DILocation(line: 40, scope: !1099, inlinedAt: !2414)
!2414 = !DILocation(line: 3, scope: !1127, inlinedAt: !2415)
!2415 = !DILocation(line: 3, scope: !1129, inlinedAt: !2416)
!2416 = !DILocation(line: 89, scope: !1149, inlinedAt: !2404)
!2417 = !DILocation(line: 40, scope: !1099, inlinedAt: !2418)
!2418 = !DILocation(line: 3, scope: !1127, inlinedAt: !2419)
!2419 = !DILocation(line: 3, scope: !1129, inlinedAt: !2420)
!2420 = !DILocation(line: 89, scope: !1154, inlinedAt: !2404)
!2421 = !DILocation(line: 763, scope: !1156, inlinedAt: !2422)
!2422 = !DILocation(line: 789, scope: !1158, inlinedAt: !2423)
!2423 = !DILocation(line: 7, scope: !1160, inlinedAt: !2424)
!2424 = !DILocation(line: 358, scope: !1162, inlinedAt: !2425)
!2425 = !DILocation(line: 381, scope: !1164, inlinedAt: !2426)
!2426 = !DILocation(line: 449, scope: !1166, inlinedAt: !2427)
!2427 = !DILocation(line: 492, scope: !1168, inlinedAt: !2428)
!2428 = !DILocation(line: 269, scope: !1170, inlinedAt: !2405)
!2429 = !DILocation(line: 499, scope: !1166, inlinedAt: !2426)
!2430 = !DILocation(line: 38, scope: !1173, inlinedAt: !2427)
!2431 = !DILocation(line: 35, scope: !1175, inlinedAt: !2428)
!2432 = !DILocation(line: 93, scope: !1135, inlinedAt: !2406)
!2433 = !DILocation(line: 37, scope: !1119, inlinedAt: !2434)
!2434 = !DILocation(line: 124, scope: !1135, inlinedAt: !2406)
!2435 = !DILocation(line: 27, scope: !1180, inlinedAt: !2436)
!2436 = !DILocation(line: 37, scope: !1182, inlinedAt: !2437)
!2437 = !DILocation(line: 36, scope: !1182, inlinedAt: !2434)
!2438 = !DILocation(line: 499, scope: !1166, inlinedAt: !2439)
!2439 = !DILocation(line: 38, scope: !1182, inlinedAt: !2437)
!2440 = !DILocation(line: 499, scope: !1166, inlinedAt: !2441)
!2441 = !DILocation(line: 40, scope: !1182, inlinedAt: !2437)
!2442 = !DILocation(line: 40, scope: !1099, inlinedAt: !2443)
!2443 = !DILocation(line: 0, scope: !1111, inlinedAt: !2444)
!2444 = !DILocation(line: 0, scope: !1113, inlinedAt: !2445)
!2445 = !DILocation(line: 11, scope: !1192, inlinedAt: !2446)
!2446 = !DILocation(line: 31, scope: !1194, inlinedAt: !2447)
!2447 = !DILocation(line: 41, scope: !1182, inlinedAt: !2437)
!2448 = !DILocation(line: 37, scope: !1119, inlinedAt: !2445)
!2449 = !DILocation(line: 30, scope: !1121, inlinedAt: !2445)
!2450 = !DILocation(line: 126, scope: !1199, inlinedAt: !2451)
!2451 = !DILocation(line: 126, scope: !1199, inlinedAt: !2452)
!2452 = !DILocation(line: 33, scope: !1194, inlinedAt: !2447)
!2453 = !DILocation(line: 108, scope: !1203, inlinedAt: !2454)
!2454 = !DILocation(line: 46, scope: !1182, inlinedAt: !2437)
!2455 = !DILocation(line: 47, scope: !1182, inlinedAt: !2437)
!2456 = !DILocation(line: 6, scope: !1207, inlinedAt: !2457)
!2457 = !DILocation(line: 109, scope: !1135, inlinedAt: !2406)
!2458 = !DILocation(line: 40, scope: !1099, inlinedAt: !2459)
!2459 = !DILocation(line: 3, scope: !1127, inlinedAt: !2460)
!2460 = !DILocation(line: 3, scope: !1129, inlinedAt: !2461)
!2461 = !DILocation(line: 89, scope: !1131, inlinedAt: !2462)
!2462 = !DILocation(line: 124, scope: !1133, inlinedAt: !2463)
!2463 = !DILocation(line: 92, scope: !1135, inlinedAt: !2464)
!2464 = !DILocation(line: 0, scope: !1111, inlinedAt: !2465)
!2465 = !DILocation(line: 0, scope: !1217, inlinedAt: !2466)
!2466 = !DILocation(line: 72, scope: !1140, inlinedAt: !2409)
!2467 = !DILocation(line: 87, scope: !1106, inlinedAt: !2468)
!2468 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2461)
!2469 = !DILocation(line: 40, scope: !1099, inlinedAt: !2470)
!2470 = !DILocation(line: 3, scope: !1127, inlinedAt: !2471)
!2471 = !DILocation(line: 3, scope: !1129, inlinedAt: !2472)
!2472 = !DILocation(line: 89, scope: !1149, inlinedAt: !2462)
!2473 = !DILocation(line: 40, scope: !1099, inlinedAt: !2474)
!2474 = !DILocation(line: 3, scope: !1127, inlinedAt: !2475)
!2475 = !DILocation(line: 3, scope: !1129, inlinedAt: !2476)
!2476 = !DILocation(line: 89, scope: !1154, inlinedAt: !2462)
!2477 = !DILocation(line: 763, scope: !1156, inlinedAt: !2478)
!2478 = !DILocation(line: 789, scope: !1158, inlinedAt: !2479)
!2479 = !DILocation(line: 7, scope: !1160, inlinedAt: !2480)
!2480 = !DILocation(line: 358, scope: !1162, inlinedAt: !2481)
!2481 = !DILocation(line: 381, scope: !1164, inlinedAt: !2482)
!2482 = !DILocation(line: 449, scope: !1166, inlinedAt: !2483)
!2483 = !DILocation(line: 492, scope: !1168, inlinedAt: !2484)
!2484 = !DILocation(line: 269, scope: !1170, inlinedAt: !2463)
!2485 = !DILocation(line: 499, scope: !1166, inlinedAt: !2482)
!2486 = !DILocation(line: 38, scope: !1173, inlinedAt: !2483)
!2487 = !DILocation(line: 35, scope: !1175, inlinedAt: !2484)
!2488 = !DILocation(line: 93, scope: !1135, inlinedAt: !2464)
!2489 = !DILocation(line: 37, scope: !1119, inlinedAt: !2490)
!2490 = !DILocation(line: 152, scope: !1135, inlinedAt: !2464)
!2491 = !DILocation(line: 513, scope: !1094, inlinedAt: !2492)
!2492 = !DILocation(line: 100, scope: !1245, inlinedAt: !2493)
!2493 = !DILocation(line: 114, scope: !1247, inlinedAt: !2490)
!2494 = !DILocation(line: 513, scope: !1094, inlinedAt: !2495)
!2495 = !DILocation(line: 102, scope: !1250, inlinedAt: !2496)
!2496 = !DILocation(line: 471, scope: !1252, inlinedAt: !2493)
!2497 = !DILocation(line: 513, scope: !1094, inlinedAt: !2498)
!2498 = !DILocation(line: 100, scope: !1245, inlinedAt: !2499)
!2499 = !DILocation(line: 115, scope: !1256, inlinedAt: !2490)
!2500 = !DILocation(line: 513, scope: !1094, inlinedAt: !2501)
!2501 = !DILocation(line: 102, scope: !1250, inlinedAt: !2502)
!2502 = !DILocation(line: 471, scope: !1252, inlinedAt: !2499)
!2503 = !DILocation(line: 40, scope: !1099, inlinedAt: !2504)
!2504 = !DILocation(line: 46, scope: !1262, inlinedAt: !2505)
!2505 = !DILocation(line: 46, scope: !1264, inlinedAt: !2506)
!2506 = !DILocation(line: 88, scope: !1266, inlinedAt: !2507)
!2507 = !DILocation(line: 88, scope: !1266, inlinedAt: !2508)
!2508 = !DILocation(line: 88, scope: !1266, inlinedAt: !2490)
!2509 = !DILocation(line: 6, scope: !1207, inlinedAt: !2510)
!2510 = !DILocation(line: 109, scope: !1135, inlinedAt: !2464)
!2511 = !DILocation(line: 40, scope: !1099, inlinedAt: !2512)
!2512 = !DILocation(line: 3, scope: !1127, inlinedAt: !2513)
!2513 = !DILocation(line: 3, scope: !1129, inlinedAt: !2514)
!2514 = !DILocation(line: 89, scope: !1131, inlinedAt: !2515)
!2515 = !DILocation(line: 124, scope: !1133, inlinedAt: !2516)
!2516 = !DILocation(line: 92, scope: !1135, inlinedAt: !2517)
!2517 = !DILocation(line: 0, scope: !1111, inlinedAt: !2518)
!2518 = !DILocation(line: 0, scope: !1274, inlinedAt: !2519)
!2519 = !DILocation(line: 73, scope: !1140, inlinedAt: !2409)
!2520 = !DILocation(line: 87, scope: !1106, inlinedAt: !2521)
!2521 = !DILocation(line: 1042, scope: !1106, inlinedAt: !2514)
!2522 = !DILocation(line: 40, scope: !1099, inlinedAt: !2523)
!2523 = !DILocation(line: 3, scope: !1127, inlinedAt: !2524)
!2524 = !DILocation(line: 3, scope: !1129, inlinedAt: !2525)
!2525 = !DILocation(line: 89, scope: !1149, inlinedAt: !2515)
!2526 = !DILocation(line: 40, scope: !1099, inlinedAt: !2527)
!2527 = !DILocation(line: 3, scope: !1127, inlinedAt: !2528)
!2528 = !DILocation(line: 3, scope: !1129, inlinedAt: !2529)
!2529 = !DILocation(line: 89, scope: !1154, inlinedAt: !2515)
!2530 = !DILocation(line: 763, scope: !1156, inlinedAt: !2531)
!2531 = !DILocation(line: 789, scope: !1158, inlinedAt: !2532)
!2532 = !DILocation(line: 7, scope: !1160, inlinedAt: !2533)
!2533 = !DILocation(line: 358, scope: !1162, inlinedAt: !2534)
!2534 = !DILocation(line: 381, scope: !1164, inlinedAt: !2535)
!2535 = !DILocation(line: 449, scope: !1166, inlinedAt: !2536)
!2536 = !DILocation(line: 492, scope: !1168, inlinedAt: !2537)
!2537 = !DILocation(line: 269, scope: !1170, inlinedAt: !2516)
!2538 = !DILocation(line: 499, scope: !1166, inlinedAt: !2535)
!2539 = !DILocation(line: 38, scope: !1173, inlinedAt: !2536)
!2540 = !DILocation(line: 35, scope: !1175, inlinedAt: !2537)
!2541 = !DILocation(line: 93, scope: !1135, inlinedAt: !2517)
!2542 = !DILocation(line: 37, scope: !1119, inlinedAt: !2543)
!2543 = !DILocation(line: 174, scope: !1135, inlinedAt: !2517)
!2544 = !DILocation(line: 27, scope: !1180, inlinedAt: !2545)
!2545 = !DILocation(line: 37, scope: !1182, inlinedAt: !2546)
!2546 = !DILocation(line: 36, scope: !1182, inlinedAt: !2543)
!2547 = !DILocation(line: 499, scope: !1166, inlinedAt: !2548)
!2548 = !DILocation(line: 38, scope: !1182, inlinedAt: !2546)
!2549 = !DILocation(line: 499, scope: !1166, inlinedAt: !2550)
!2550 = !DILocation(line: 40, scope: !1182, inlinedAt: !2546)
!2551 = !DILocation(line: 40, scope: !1099, inlinedAt: !2552)
!2552 = !DILocation(line: 0, scope: !1111, inlinedAt: !2553)
!2553 = !DILocation(line: 0, scope: !1113, inlinedAt: !2554)
!2554 = !DILocation(line: 11, scope: !1192, inlinedAt: !2555)
!2555 = !DILocation(line: 31, scope: !1194, inlinedAt: !2556)
!2556 = !DILocation(line: 41, scope: !1182, inlinedAt: !2546)
!2557 = !DILocation(line: 37, scope: !1119, inlinedAt: !2554)
!2558 = !DILocation(line: 30, scope: !1121, inlinedAt: !2554)
!2559 = !DILocation(line: 126, scope: !1199, inlinedAt: !2560)
!2560 = !DILocation(line: 126, scope: !1199, inlinedAt: !2561)
!2561 = !DILocation(line: 33, scope: !1194, inlinedAt: !2556)
!2562 = !DILocation(line: 108, scope: !1203, inlinedAt: !2563)
!2563 = !DILocation(line: 46, scope: !1182, inlinedAt: !2546)
!2564 = !DILocation(line: 47, scope: !1182, inlinedAt: !2546)
!2565 = !DILocation(line: 37, scope: !1119, inlinedAt: !2566)
!2566 = !DILocation(line: 176, scope: !1135, inlinedAt: !2517)
!2567 = !DILocation(line: 12, scope: !1339, inlinedAt: !2568)
!2568 = !DILocation(line: 61, scope: !1341, inlinedAt: !2569)
!2569 = !DILocation(line: 60, scope: !1341, inlinedAt: !2566)
!2570 = !DILocation(line: 499, scope: !1166, inlinedAt: !2571)
!2571 = !DILocation(line: 62, scope: !1341, inlinedAt: !2569)
!2572 = !DILocation(line: 499, scope: !1166, inlinedAt: !2573)
!2573 = !DILocation(line: 64, scope: !1341, inlinedAt: !2569)
!2574 = !DILocation(line: 40, scope: !1099, inlinedAt: !2575)
!2575 = !DILocation(line: 0, scope: !1111, inlinedAt: !2576)
!2576 = !DILocation(line: 0, scope: !1113, inlinedAt: !2577)
!2577 = !DILocation(line: 11, scope: !1192, inlinedAt: !2578)
!2578 = !DILocation(line: 31, scope: !1194, inlinedAt: !2579)
!2579 = !DILocation(line: 65, scope: !1341, inlinedAt: !2569)
!2580 = !DILocation(line: 37, scope: !1119, inlinedAt: !2577)
!2581 = !DILocation(line: 30, scope: !1121, inlinedAt: !2577)
!2582 = !DILocation(line: 126, scope: !1199, inlinedAt: !2583)
!2583 = !DILocation(line: 126, scope: !1199, inlinedAt: !2584)
!2584 = !DILocation(line: 33, scope: !1194, inlinedAt: !2579)
!2585 = !DILocation(line: 108, scope: !1203, inlinedAt: !2586)
!2586 = !DILocation(line: 70, scope: !1341, inlinedAt: !2569)
!2587 = !DILocation(line: 71, scope: !1341, inlinedAt: !2569)
!2588 = !DILocation(line: 37, scope: !1119, inlinedAt: !2589)
!2589 = !DILocation(line: 188, scope: !1135, inlinedAt: !2517)
!2590 = !DILocation(line: 19, scope: !1383, inlinedAt: !2591)
!2591 = !DILocation(line: 19, scope: !1383, inlinedAt: !2589)
!2592 = !DILocation(line: 6, scope: !1207, inlinedAt: !2593)
!2593 = !DILocation(line: 109, scope: !1135, inlinedAt: !2517)
!2594 = !DILocation(line: 96, scope: !1082)
!2595 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2367", scope: null, file: !28, line: 30, type: !2596, scopeLine: 30, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !2599)
!2596 = !DISubroutineType(types: !2597)
!2597 = !{!110, !2598}
!2598 = !DICompositeType(tag: DW_TAG_structure_type, name: "#signal_exception", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927429648")
!2599 = !{!2600}
!2600 = !DILocalVariable(name: "#self#", arg: 1, scope: !2595, file: !28, line: 30, type: !2598)
!2601 = !DILocation(line: 40, scope: !2602, inlinedAt: !2603)
!2602 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2603 = !DILocation(line: 0, scope: !2604, inlinedAt: !2605)
!2604 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2605 = !DILocation(line: 0, scope: !2606, inlinedAt: !2607)
!2606 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2607 = !DILocation(line: 11, scope: !2608, inlinedAt: !2609)
!2608 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2609 = !DILocation(line: 31, scope: !2595)
!2610 = !DILocation(line: 37, scope: !2611, inlinedAt: !2607)
!2611 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2612 = !DILocation(line: 30, scope: !2613, inlinedAt: !2607)
!2613 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2614 = !DILocation(line: 126, scope: !2615, inlinedAt: !2616)
!2615 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !69)
!2616 = !DILocation(line: 126, scope: !2615, inlinedAt: !2617)
!2617 = !DILocation(line: 33, scope: !2595)
!2618 = !DILocation(line: 40, scope: !2595)
!2619 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2551", scope: null, file: !7, type: !2620, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !2628)
!2620 = !DISubroutineType(types: !2621)
!2621 = !{!110, !2622, !2623, !2624}
!2622 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_trigger_and_return!", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428924587424")
!2623 = !DICompositeType(tag: DW_TAG_structure_type, name: "Val", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140424296109840")
!2624 = !DICompositeType(tag: DW_TAG_structure_type, name: "HostCall", size: 192, align: 64, elements: !2625, runtimeLang: DW_LANG_Julia, identifier: "140428927658912")
!2625 = !{!2626, !2627, !2626}
!2626 = !DIBasicType(name: "UInt64", size: 64, encoding: DW_ATE_unsigned)
!2627 = !DIBasicType(name: "LLVMPtr", size: 64, encoding: DW_ATE_unsigned)
!2628 = !{!2629, !2630}
!2629 = !DILocalVariable(name: "#self#", arg: 1, scope: !2619, file: !7, type: !2622)
!2630 = !DILocalVariable(name: "hc", arg: 3, scope: !2619, file: !7, type: !2624)
!2631 = !DILocation(line: 0, scope: !2619)
!2632 = !DILocation(line: 40, scope: !2633, inlinedAt: !2634)
!2633 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2634 = !DILocation(line: 3, scope: !2635, inlinedAt: !2636)
!2635 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2636 = !DILocation(line: 3, scope: !2637, inlinedAt: !2638)
!2637 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2638 = !DILocation(line: 89, scope: !2639, inlinedAt: !2640)
!2639 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2640 = !DILocation(line: 124, scope: !2641, inlinedAt: !2642)
!2641 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2642 = !DILocation(line: 92, scope: !2643, inlinedAt: !2644)
!2643 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2644 = !DILocation(line: 0, scope: !2645, inlinedAt: !2631)
!2645 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2646 = !DILocation(line: 87, scope: !2647, inlinedAt: !2648)
!2647 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2648 = !DILocation(line: 1042, scope: !2647, inlinedAt: !2638)
!2649 = !DILocation(line: 40, scope: !2633, inlinedAt: !2650)
!2650 = !DILocation(line: 3, scope: !2635, inlinedAt: !2651)
!2651 = !DILocation(line: 3, scope: !2637, inlinedAt: !2652)
!2652 = !DILocation(line: 89, scope: !2653, inlinedAt: !2640)
!2653 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2654 = !DILocation(line: 40, scope: !2633, inlinedAt: !2655)
!2655 = !DILocation(line: 3, scope: !2635, inlinedAt: !2656)
!2656 = !DILocation(line: 3, scope: !2637, inlinedAt: !2657)
!2657 = !DILocation(line: 89, scope: !2658, inlinedAt: !2640)
!2658 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2659 = !DILocation(line: 763, scope: !2660, inlinedAt: !2661)
!2660 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2661 = !DILocation(line: 789, scope: !2662, inlinedAt: !2663)
!2662 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2663 = !DILocation(line: 7, scope: !2664, inlinedAt: !2665)
!2664 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !209, file: !209, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2665 = !DILocation(line: 358, scope: !2666, inlinedAt: !2667)
!2666 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2667 = !DILocation(line: 381, scope: !2668, inlinedAt: !2669)
!2668 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2669 = !DILocation(line: 449, scope: !2670, inlinedAt: !2671)
!2670 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2671 = !DILocation(line: 492, scope: !2672, inlinedAt: !2673)
!2672 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2673 = !DILocation(line: 269, scope: !2674, inlinedAt: !2642)
!2674 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !221, file: !221, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2675 = !DILocation(line: 499, scope: !2670, inlinedAt: !2669)
!2676 = !DILocation(line: 38, scope: !2677, inlinedAt: !2671)
!2677 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2678 = !DILocation(line: 35, scope: !2679, inlinedAt: !2673)
!2679 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2680 = !DILocation(line: 93, scope: !2643, inlinedAt: !2644)
!2681 = !DILocation(line: 37, scope: !2682, inlinedAt: !2683)
!2682 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2683 = !DILocation(line: 174, scope: !2643, inlinedAt: !2644)
!2684 = !{!2685, !2685, i64 0, i64 1}
!2685 = !{!"jtbaa_const", !155, i64 0}
!2686 = !{!164}
!2687 = !{!161, !158, !162, !163}
!2688 = !DILocation(line: 37, scope: !2682, inlinedAt: !2689)
!2689 = !DILocation(line: 176, scope: !2643, inlinedAt: !2644)
!2690 = !DILocation(line: 37, scope: !2682, inlinedAt: !2691)
!2691 = !DILocation(line: 188, scope: !2643, inlinedAt: !2644)
!2692 = !DILocation(line: 19, scope: !2693, inlinedAt: !2694)
!2693 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2694 = !DILocation(line: 19, scope: !2693, inlinedAt: !2691)
!2695 = !DILocation(line: 6, scope: !2696, inlinedAt: !2697)
!2696 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !267, file: !267, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !58, retainedNodes: !69)
!2697 = !DILocation(line: 109, scope: !2643, inlinedAt: !2644)
!2698 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2561", scope: null, file: !5, line: 32, type: !2699, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !2702)
!2699 = !DISubroutineType(types: !2700)
!2700 = !{!110, !2701, !2626, !74, !74}
!2701 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_signal_wait_cas!", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927475520")
!2702 = !{!2703, !2704, !2705, !2706}
!2703 = !DILocalVariable(name: "#self#", arg: 1, scope: !2698, file: !5, line: 32, type: !2701)
!2704 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !2698, file: !5, line: 32, type: !2626)
!2705 = !DILocalVariable(name: "expected", arg: 3, scope: !2698, file: !5, line: 32, type: !74)
!2706 = !DILocalVariable(name: "value", arg: 4, scope: !2698, file: !5, line: 32, type: !74)
!2707 = !DILocation(line: 32, scope: !2698)
!2708 = !DILocation(line: 27, scope: !2709, inlinedAt: !2710)
!2709 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2710 = !DILocation(line: 37, scope: !2711, inlinedAt: !2712)
!2711 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2712 = !DILocation(line: 36, scope: !2698)
!2713 = !DILocation(line: 499, scope: !2714, inlinedAt: !2715)
!2714 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2715 = !DILocation(line: 38, scope: !2711, inlinedAt: !2712)
!2716 = !DILocation(line: 499, scope: !2714, inlinedAt: !2717)
!2717 = !DILocation(line: 40, scope: !2711, inlinedAt: !2712)
!2718 = !DILocation(line: 40, scope: !2719, inlinedAt: !2720)
!2719 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2720 = !DILocation(line: 0, scope: !2721, inlinedAt: !2722)
!2721 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2722 = !DILocation(line: 0, scope: !2723, inlinedAt: !2724)
!2723 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2724 = !DILocation(line: 11, scope: !2725, inlinedAt: !2726)
!2725 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2726 = !DILocation(line: 31, scope: !2727, inlinedAt: !2728)
!2727 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2728 = !DILocation(line: 41, scope: !2711, inlinedAt: !2712)
!2729 = !DILocation(line: 37, scope: !2730, inlinedAt: !2724)
!2730 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2731 = !DILocation(line: 30, scope: !2732, inlinedAt: !2724)
!2732 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2733 = !DILocation(line: 126, scope: !2734, inlinedAt: !2735)
!2734 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2735 = !DILocation(line: 126, scope: !2734, inlinedAt: !2736)
!2736 = !DILocation(line: 33, scope: !2727, inlinedAt: !2728)
!2737 = !DILocation(line: 108, scope: !2738, inlinedAt: !2739)
!2738 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !59, retainedNodes: !69)
!2739 = !DILocation(line: 46, scope: !2711, inlinedAt: !2712)
!2740 = !DILocation(line: 47, scope: !2711, inlinedAt: !2712)
!2741 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2558", scope: null, file: !5, line: 57, type: !2742, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !2745)
!2742 = !DISubroutineType(types: !2743)
!2743 = !{!110, !2744, !2626, !74}
!2744 = !DICompositeType(tag: DW_TAG_structure_type, name: "#hostcall_device_signal_wait", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927453632")
!2745 = !{!2746, !2747, !2748}
!2746 = !DILocalVariable(name: "#self#", arg: 1, scope: !2741, file: !5, line: 57, type: !2744)
!2747 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !2741, file: !5, line: 57, type: !2626)
!2748 = !DILocalVariable(name: "value", arg: 3, scope: !2741, file: !5, line: 57, type: !74)
!2749 = !DILocation(line: 57, scope: !2741)
!2750 = !DILocation(line: 12, scope: !2751, inlinedAt: !2752)
!2751 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2752 = !DILocation(line: 61, scope: !2753, inlinedAt: !2754)
!2753 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2754 = !DILocation(line: 60, scope: !2741)
!2755 = !DILocation(line: 499, scope: !2756, inlinedAt: !2757)
!2756 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2757 = !DILocation(line: 62, scope: !2753, inlinedAt: !2754)
!2758 = !DILocation(line: 499, scope: !2756, inlinedAt: !2759)
!2759 = !DILocation(line: 64, scope: !2753, inlinedAt: !2754)
!2760 = !DILocation(line: 40, scope: !2761, inlinedAt: !2762)
!2761 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2762 = !DILocation(line: 0, scope: !2763, inlinedAt: !2764)
!2763 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2764 = !DILocation(line: 0, scope: !2765, inlinedAt: !2766)
!2765 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2766 = !DILocation(line: 11, scope: !2767, inlinedAt: !2768)
!2767 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2768 = !DILocation(line: 31, scope: !2769, inlinedAt: !2770)
!2769 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2770 = !DILocation(line: 65, scope: !2753, inlinedAt: !2754)
!2771 = !DILocation(line: 37, scope: !2772, inlinedAt: !2766)
!2772 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2773 = !DILocation(line: 30, scope: !2774, inlinedAt: !2766)
!2774 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2775 = !DILocation(line: 126, scope: !2776, inlinedAt: !2777)
!2776 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2777 = !DILocation(line: 126, scope: !2776, inlinedAt: !2778)
!2778 = !DILocation(line: 33, scope: !2769, inlinedAt: !2770)
!2779 = !DILocation(line: 108, scope: !2780, inlinedAt: !2781)
!2780 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !57, retainedNodes: !69)
!2781 = !DILocation(line: 70, scope: !2753, inlinedAt: !2754)
!2782 = !DILocation(line: 71, scope: !2753, inlinedAt: !2754)
!2783 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!", linkageName: "julia_hostcall_device_trigger_and_return!_2324", scope: null, file: !7, type: !2620, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !2784)
!2784 = !{!2785, !2786}
!2785 = !DILocalVariable(name: "#self#", arg: 1, scope: !2783, file: !7, type: !2622)
!2786 = !DILocalVariable(name: "hc", arg: 3, scope: !2783, file: !7, type: !2624)
!2787 = !DILocation(line: 0, scope: !2783)
!2788 = !DILocation(line: 40, scope: !2789, inlinedAt: !2790)
!2789 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2790 = !DILocation(line: 3, scope: !2791, inlinedAt: !2792)
!2791 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2792 = !DILocation(line: 3, scope: !2793, inlinedAt: !2794)
!2793 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2794 = !DILocation(line: 89, scope: !2795, inlinedAt: !2796)
!2795 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2796 = !DILocation(line: 124, scope: !2797, inlinedAt: !2798)
!2797 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2798 = !DILocation(line: 92, scope: !2799, inlinedAt: !2800)
!2799 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !9, file: !9, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2800 = !DILocation(line: 0, scope: !2801, inlinedAt: !2787)
!2801 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2802 = !DILocation(line: 87, scope: !2803, inlinedAt: !2804)
!2803 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2804 = !DILocation(line: 1042, scope: !2803, inlinedAt: !2794)
!2805 = !DILocation(line: 40, scope: !2789, inlinedAt: !2806)
!2806 = !DILocation(line: 3, scope: !2791, inlinedAt: !2807)
!2807 = !DILocation(line: 3, scope: !2793, inlinedAt: !2808)
!2808 = !DILocation(line: 89, scope: !2809, inlinedAt: !2796)
!2809 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2810 = !DILocation(line: 40, scope: !2789, inlinedAt: !2811)
!2811 = !DILocation(line: 3, scope: !2791, inlinedAt: !2812)
!2812 = !DILocation(line: 3, scope: !2793, inlinedAt: !2813)
!2813 = !DILocation(line: 89, scope: !2814, inlinedAt: !2796)
!2814 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2815 = !DILocation(line: 763, scope: !2816, inlinedAt: !2817)
!2816 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2817 = !DILocation(line: 789, scope: !2818, inlinedAt: !2819)
!2818 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2819 = !DILocation(line: 7, scope: !2820, inlinedAt: !2821)
!2820 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !209, file: !209, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2821 = !DILocation(line: 358, scope: !2822, inlinedAt: !2823)
!2822 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2823 = !DILocation(line: 381, scope: !2824, inlinedAt: !2825)
!2824 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2825 = !DILocation(line: 449, scope: !2826, inlinedAt: !2827)
!2826 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2827 = !DILocation(line: 492, scope: !2828, inlinedAt: !2829)
!2828 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2829 = !DILocation(line: 269, scope: !2830, inlinedAt: !2798)
!2830 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !221, file: !221, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2831 = !DILocation(line: 499, scope: !2826, inlinedAt: !2825)
!2832 = !DILocation(line: 38, scope: !2833, inlinedAt: !2827)
!2833 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2834 = !DILocation(line: 35, scope: !2835, inlinedAt: !2829)
!2835 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2836 = !DILocation(line: 93, scope: !2799, inlinedAt: !2800)
!2837 = !DILocation(line: 37, scope: !2838, inlinedAt: !2839)
!2838 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2839 = !DILocation(line: 174, scope: !2799, inlinedAt: !2800)
!2840 = !DILocation(line: 37, scope: !2838, inlinedAt: !2841)
!2841 = !DILocation(line: 176, scope: !2799, inlinedAt: !2800)
!2842 = !DILocation(line: 37, scope: !2838, inlinedAt: !2843)
!2843 = !DILocation(line: 188, scope: !2799, inlinedAt: !2800)
!2844 = !DILocation(line: 19, scope: !2845, inlinedAt: !2846)
!2845 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2846 = !DILocation(line: 19, scope: !2845, inlinedAt: !2843)
!2847 = !DILocation(line: 6, scope: !2848, inlinedAt: !2849)
!2848 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !267, file: !267, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !69)
!2849 = !DILocation(line: 109, scope: !2799, inlinedAt: !2800)
!2850 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!", linkageName: "julia_hostcall_device_signal_wait_cas!_2334", scope: null, file: !5, line: 32, type: !2699, scopeLine: 32, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !2851)
!2851 = !{!2852, !2853, !2854, !2855}
!2852 = !DILocalVariable(name: "#self#", arg: 1, scope: !2850, file: !5, line: 32, type: !2701)
!2853 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !2850, file: !5, line: 32, type: !2626)
!2854 = !DILocalVariable(name: "expected", arg: 3, scope: !2850, file: !5, line: 32, type: !74)
!2855 = !DILocalVariable(name: "value", arg: 4, scope: !2850, file: !5, line: 32, type: !74)
!2856 = !DILocation(line: 32, scope: !2850)
!2857 = !DILocation(line: 27, scope: !2858, inlinedAt: !2859)
!2858 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2859 = !DILocation(line: 37, scope: !2860, inlinedAt: !2861)
!2860 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2861 = !DILocation(line: 36, scope: !2850)
!2862 = !DILocation(line: 499, scope: !2863, inlinedAt: !2864)
!2863 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2864 = !DILocation(line: 38, scope: !2860, inlinedAt: !2861)
!2865 = !DILocation(line: 499, scope: !2863, inlinedAt: !2866)
!2866 = !DILocation(line: 40, scope: !2860, inlinedAt: !2861)
!2867 = !DILocation(line: 40, scope: !2868, inlinedAt: !2869)
!2868 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2869 = !DILocation(line: 0, scope: !2870, inlinedAt: !2871)
!2870 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2871 = !DILocation(line: 0, scope: !2872, inlinedAt: !2873)
!2872 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2873 = !DILocation(line: 11, scope: !2874, inlinedAt: !2875)
!2874 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2875 = !DILocation(line: 31, scope: !2876, inlinedAt: !2877)
!2876 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2877 = !DILocation(line: 41, scope: !2860, inlinedAt: !2861)
!2878 = !DILocation(line: 37, scope: !2879, inlinedAt: !2873)
!2879 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2880 = !DILocation(line: 30, scope: !2881, inlinedAt: !2873)
!2881 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2882 = !DILocation(line: 126, scope: !2883, inlinedAt: !2884)
!2883 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2884 = !DILocation(line: 126, scope: !2883, inlinedAt: !2885)
!2885 = !DILocation(line: 33, scope: !2876, inlinedAt: !2877)
!2886 = !DILocation(line: 108, scope: !2887, inlinedAt: !2888)
!2887 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !69)
!2888 = !DILocation(line: 46, scope: !2860, inlinedAt: !2861)
!2889 = !DILocation(line: 47, scope: !2860, inlinedAt: !2861)
!2890 = distinct !DISubprogram(name: "hostcall_device_signal_wait", linkageName: "julia_hostcall_device_signal_wait_2331", scope: null, file: !5, line: 57, type: !2742, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !2891)
!2891 = !{!2892, !2893, !2894}
!2892 = !DILocalVariable(name: "#self#", arg: 1, scope: !2890, file: !5, line: 57, type: !2744)
!2893 = !DILocalVariable(name: "signal_handle", arg: 2, scope: !2890, file: !5, line: 57, type: !2626)
!2894 = !DILocalVariable(name: "value", arg: 3, scope: !2890, file: !5, line: 57, type: !74)
!2895 = !DILocation(line: 57, scope: !2890)
!2896 = !DILocation(line: 12, scope: !2897, inlinedAt: !2898)
!2897 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2898 = !DILocation(line: 61, scope: !2899, inlinedAt: !2900)
!2899 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2900 = !DILocation(line: 60, scope: !2890)
!2901 = !DILocation(line: 499, scope: !2902, inlinedAt: !2903)
!2902 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2903 = !DILocation(line: 62, scope: !2899, inlinedAt: !2900)
!2904 = !DILocation(line: 499, scope: !2902, inlinedAt: !2905)
!2905 = !DILocation(line: 64, scope: !2899, inlinedAt: !2900)
!2906 = !DILocation(line: 40, scope: !2907, inlinedAt: !2908)
!2907 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2908 = !DILocation(line: 0, scope: !2909, inlinedAt: !2910)
!2909 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2910 = !DILocation(line: 0, scope: !2911, inlinedAt: !2912)
!2911 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !7, file: !7, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2912 = !DILocation(line: 11, scope: !2913, inlinedAt: !2914)
!2913 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2914 = !DILocation(line: 31, scope: !2915, inlinedAt: !2916)
!2915 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !28, file: !28, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2916 = !DILocation(line: 65, scope: !2899, inlinedAt: !2900)
!2917 = !DILocation(line: 37, scope: !2918, inlinedAt: !2912)
!2918 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2919 = !DILocation(line: 30, scope: !2920, inlinedAt: !2912)
!2920 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2921 = !DILocation(line: 126, scope: !2922, inlinedAt: !2923)
!2922 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !152, file: !152, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2923 = !DILocation(line: 126, scope: !2922, inlinedAt: !2924)
!2924 = !DILocation(line: 33, scope: !2915, inlinedAt: !2916)
!2925 = !DILocation(line: 108, scope: !2926, inlinedAt: !2927)
!2926 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !5, file: !5, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !69)
!2927 = !DILocation(line: 70, scope: !2899, inlinedAt: !2900)
!2928 = !DILocation(line: 71, scope: !2899, inlinedAt: !2900)
!2929 = distinct !DISubprogram(name: "set_one!", linkageName: "julia_set_one!_1665", scope: null, file: !19, line: 366, type: !2930, scopeLine: 366, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !2937)
!2930 = !DISubroutineType(types: !2931)
!2931 = !{!110, !2932, !2933}
!2932 = !DICompositeType(tag: DW_TAG_structure_type, name: "#set_one!", align: 8, elements: !69, runtimeLang: DW_LANG_Julia, identifier: "140428927180048")
!2933 = !DICompositeType(tag: DW_TAG_structure_type, name: "ROCDeviceArray", size: 128, align: 64, elements: !2934, runtimeLang: DW_LANG_Julia, identifier: "140431678545744")
!2934 = !{!2935, !2627}
!2935 = !DICompositeType(tag: DW_TAG_structure_type, name: "Tuple", size: 64, align: 64, elements: !2936, runtimeLang: DW_LANG_Julia, identifier: "140431554812112")
!2936 = !{!74}
!2937 = !{!2938, !2939}
!2938 = !DILocalVariable(name: "#self#", arg: 1, scope: !2929, file: !19, line: 366, type: !2932)
!2939 = !DILocalVariable(name: "x", arg: 2, scope: !2929, file: !19, line: 366, type: !2933)
!2940 = !DILocation(line: 366, scope: !2929)
!2941 = !DILocation(line: 40, scope: !2942, inlinedAt: !2943)
!2942 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !126, file: !126, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2943 = !DILocation(line: 3, scope: !2944, inlinedAt: !2945)
!2944 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2945 = !DILocation(line: 3, scope: !2946, inlinedAt: !2947)
!2946 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2947 = !DILocation(line: 89, scope: !2948, inlinedAt: !2949)
!2948 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2949 = !DILocation(line: 124, scope: !2950, inlinedAt: !2951)
!2950 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2951 = !DILocation(line: 367, scope: !2929)
!2952 = !DILocation(line: 87, scope: !2953, inlinedAt: !2954)
!2953 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2954 = !DILocation(line: 1042, scope: !2953, inlinedAt: !2947)
!2955 = !DILocation(line: 40, scope: !2942, inlinedAt: !2956)
!2956 = !DILocation(line: 3, scope: !2944, inlinedAt: !2957)
!2957 = !DILocation(line: 3, scope: !2946, inlinedAt: !2958)
!2958 = !DILocation(line: 89, scope: !2959, inlinedAt: !2949)
!2959 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2960 = !DILocation(line: 40, scope: !2942, inlinedAt: !2961)
!2961 = !DILocation(line: 3, scope: !2944, inlinedAt: !2962)
!2962 = !DILocation(line: 3, scope: !2946, inlinedAt: !2963)
!2963 = !DILocation(line: 89, scope: !2964, inlinedAt: !2949)
!2964 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2965 = !DILocation(line: 40, scope: !2942, inlinedAt: !2966)
!2966 = !DILocation(line: 3, scope: !2944, inlinedAt: !2967)
!2967 = !DILocation(line: 3, scope: !2946, inlinedAt: !2968)
!2968 = !DILocation(line: 95, scope: !2969, inlinedAt: !2970)
!2969 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2970 = !DILocation(line: 132, scope: !2971, inlinedAt: !2951)
!2971 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2972 = !{i32 0, i32 -2}
!2973 = !DILocation(line: 87, scope: !2953, inlinedAt: !2974)
!2974 = !DILocation(line: 1042, scope: !2953, inlinedAt: !2968)
!2975 = !DILocation(line: 40, scope: !2942, inlinedAt: !2976)
!2976 = !DILocation(line: 3, scope: !2944, inlinedAt: !2977)
!2977 = !DILocation(line: 3, scope: !2946, inlinedAt: !2978)
!2978 = !DILocation(line: 95, scope: !2979, inlinedAt: !2970)
!2979 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2980 = !DILocation(line: 40, scope: !2942, inlinedAt: !2981)
!2981 = !DILocation(line: 3, scope: !2944, inlinedAt: !2982)
!2982 = !DILocation(line: 3, scope: !2946, inlinedAt: !2983)
!2983 = !DILocation(line: 95, scope: !2984, inlinedAt: !2970)
!2984 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2985 = !DILocation(line: 708, scope: !2986, inlinedAt: !2987)
!2986 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2987 = !DILocation(line: 784, scope: !2988, inlinedAt: !2989)
!2988 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2989 = !DILocation(line: 7, scope: !2990, inlinedAt: !2991)
!2990 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !209, file: !209, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2991 = !DILocation(line: 525, scope: !2992, inlinedAt: !2993)
!2992 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2993 = !DILocation(line: 1040, scope: !2994, inlinedAt: !2951)
!2994 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!2995 = !DILocation(line: 86, scope: !2994, inlinedAt: !2996)
!2996 = !DILocation(line: 1042, scope: !2994, inlinedAt: !2951)
!2997 = !DILocation(line: 40, scope: !2942, inlinedAt: !2998)
!2998 = !DILocation(line: 33, scope: !2944, inlinedAt: !2999)
!2999 = !DILocation(line: 33, scope: !3000, inlinedAt: !3001)
!3000 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3001 = !DILocation(line: 103, scope: !3002, inlinedAt: !3003)
!3002 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3003 = !DILocation(line: 140, scope: !3004, inlinedAt: !2951)
!3004 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3005 = !{i16 0, i16 1023}
!3006 = !DILocation(line: 40, scope: !2942, inlinedAt: !3007)
!3007 = !DILocation(line: 33, scope: !2944, inlinedAt: !3008)
!3008 = !DILocation(line: 33, scope: !3000, inlinedAt: !3009)
!3009 = !DILocation(line: 103, scope: !3010, inlinedAt: !3003)
!3010 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3011 = !DILocation(line: 40, scope: !2942, inlinedAt: !3012)
!3012 = !DILocation(line: 33, scope: !2944, inlinedAt: !3013)
!3013 = !DILocation(line: 33, scope: !3000, inlinedAt: !3014)
!3014 = !DILocation(line: 103, scope: !3015, inlinedAt: !3003)
!3015 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !174, file: !174, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3016 = !DILocation(line: 708, scope: !2986, inlinedAt: !3017)
!3017 = !DILocation(line: 784, scope: !2988, inlinedAt: !3018)
!3018 = !DILocation(line: 7, scope: !2990, inlinedAt: !3019)
!3019 = !DILocation(line: 525, scope: !2992, inlinedAt: !3020)
!3020 = !DILocation(line: 1040, scope: !3021, inlinedAt: !2951)
!3021 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3022 = !DILocation(line: 88, scope: !3021, inlinedAt: !3023)
!3023 = !DILocation(line: 1042, scope: !3021, inlinedAt: !2951)
!3024 = !DILocation(line: 708, scope: !2986, inlinedAt: !3025)
!3025 = !DILocation(line: 784, scope: !2988, inlinedAt: !3026)
!3026 = !DILocation(line: 7, scope: !2990, inlinedAt: !3027)
!3027 = !DILocation(line: 525, scope: !2992, inlinedAt: !3028)
!3028 = !DILocation(line: 1040, scope: !2953, inlinedAt: !2951)
!3029 = !DILocation(line: 87, scope: !2953, inlinedAt: !3030)
!3030 = !DILocation(line: 1042, scope: !2953, inlinedAt: !2951)
!3031 = !DILocation(line: 87, scope: !3032, inlinedAt: !3034)
!3032 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !3033, file: !3033, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3033 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!3034 = !DILocation(line: 368, scope: !2929)
!3035 = !DILocation(line: 707, scope: !3036, inlinedAt: !3031)
!3036 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !3037, file: !3037, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3037 = !DIFile(filename: "abstractarray.jl", directory: ".")
!3038 = !DILocation(line: 37, scope: !3039, inlinedAt: !3040)
!3039 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !149, file: !149, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3040 = !DILocation(line: 73, scope: !3041, inlinedAt: !3042)
!3041 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !3033, file: !3033, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3042 = !DILocation(line: 98, scope: !3043, inlinedAt: !3044)
!3043 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !3037, file: !3037, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3044 = !DILocation(line: 133, scope: !3045, inlinedAt: !3046)
!3045 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !3037, file: !3037, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3046 = !DILocation(line: 382, scope: !3047, inlinedAt: !3048)
!3047 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !3037, file: !3037, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3048 = !DILocation(line: 694, scope: !3036, inlinedAt: !3049)
!3049 = !DILocation(line: 709, scope: !3036, inlinedAt: !3031)
!3050 = !DILocation(line: 29, scope: !3051, inlinedAt: !3053)
!3051 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !3052, file: !3052, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3052 = !DIFile(filename: "tuple.jl", directory: ".")
!3053 = !DILocation(line: 273, scope: !3054, inlinedAt: !3042)
!3054 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !3052, file: !3052, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3055 = !DILocation(line: 83, scope: !3056, inlinedAt: !3057)
!3056 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3057 = !DILocation(line: 510, scope: !3058, inlinedAt: !3059)
!3058 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !212, file: !212, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3059 = !DILocation(line: 444, scope: !3060, inlinedAt: !3062)
!3060 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !3061, file: !3061, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3061 = !DIFile(filename: "range.jl", directory: ".")
!3062 = !DILocation(line: 457, scope: !3060, inlinedAt: !3063)
!3063 = !DILocation(line: 459, scope: !3064, inlinedAt: !3053)
!3064 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !3061, file: !3061, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3065 = !DILocation(line: 575, scope: !3066, inlinedAt: !3057)
!3066 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !119, file: !119, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3067 = !DILocation(line: 488, scope: !3068, inlinedAt: !3069)
!3068 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !135, file: !135, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3069 = !DILocation(line: 768, scope: !3070, inlinedAt: !3048)
!3070 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !3037, file: !3037, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3071 = !DILocation(line: 38, scope: !3072, inlinedAt: !3069)
!3072 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !225, file: !225, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3073 = !DILocation(line: 710, scope: !3036, inlinedAt: !3031)
!3074 = !DILocation(line: 37, scope: !3039, inlinedAt: !3075)
!3075 = !DILocation(line: 68, scope: !3076, inlinedAt: !3077)
!3076 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !3033, file: !3033, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3077 = !DILocation(line: 89, scope: !3032, inlinedAt: !3034)
!3078 = !DILocation(line: 86, scope: !2994, inlinedAt: !3079)
!3079 = !DILocation(line: 40, scope: !2942, inlinedAt: !3080)
!3080 = !DILocation(line: 9, scope: !3081, inlinedAt: !3082)
!3081 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3082 = !DILocation(line: 9, scope: !3083, inlinedAt: !3084)
!3083 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3084 = !DILocation(line: 85, scope: !3085, inlinedAt: !3077)
!3085 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3086 = !DILocation(line: 523, scope: !2992, inlinedAt: !3087)
!3087 = !DILocation(line: 1040, scope: !2953, inlinedAt: !3034)
!3088 = !DILocation(line: 87, scope: !2953, inlinedAt: !3089)
!3089 = !DILocation(line: 1042, scope: !2953, inlinedAt: !3034)
!3090 = !DILocation(line: 93, scope: !3091, inlinedAt: !3034)
!3091 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !3033, file: !3033, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3092 = !DILocation(line: 707, scope: !3036, inlinedAt: !3090)
!3093 = !DILocation(line: 37, scope: !3039, inlinedAt: !3094)
!3094 = !DILocation(line: 73, scope: !3041, inlinedAt: !3095)
!3095 = !DILocation(line: 98, scope: !3043, inlinedAt: !3096)
!3096 = !DILocation(line: 133, scope: !3045, inlinedAt: !3097)
!3097 = !DILocation(line: 382, scope: !3047, inlinedAt: !3098)
!3098 = !DILocation(line: 694, scope: !3036, inlinedAt: !3099)
!3099 = !DILocation(line: 709, scope: !3036, inlinedAt: !3090)
!3100 = !DILocation(line: 29, scope: !3051, inlinedAt: !3101)
!3101 = !DILocation(line: 273, scope: !3054, inlinedAt: !3095)
!3102 = !DILocation(line: 83, scope: !3056, inlinedAt: !3103)
!3103 = !DILocation(line: 510, scope: !3058, inlinedAt: !3104)
!3104 = !DILocation(line: 444, scope: !3060, inlinedAt: !3105)
!3105 = !DILocation(line: 457, scope: !3060, inlinedAt: !3106)
!3106 = !DILocation(line: 459, scope: !3064, inlinedAt: !3101)
!3107 = !DILocation(line: 575, scope: !3066, inlinedAt: !3103)
!3108 = !DILocation(line: 488, scope: !3068, inlinedAt: !3109)
!3109 = !DILocation(line: 768, scope: !3070, inlinedAt: !3098)
!3110 = !DILocation(line: 38, scope: !3072, inlinedAt: !3109)
!3111 = !DILocation(line: 710, scope: !3036, inlinedAt: !3090)
!3112 = !DILocation(line: 37, scope: !3039, inlinedAt: !3113)
!3113 = !DILocation(line: 68, scope: !3076, inlinedAt: !3114)
!3114 = !DILocation(line: 95, scope: !3091, inlinedAt: !3034)
!3115 = !DILocation(line: 783, scope: !3116, inlinedAt: !3117)
!3116 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !13, file: !13, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3117 = !DILocation(line: 7, scope: !2990, inlinedAt: !3118)
!3118 = !DILocation(line: 88, scope: !3119, inlinedAt: !3114)
!3119 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3120 = !DILocation(line: 86, scope: !2994, inlinedAt: !3121)
!3121 = !DILocation(line: 40, scope: !2942, inlinedAt: !3122)
!3122 = !DILocation(line: 46, scope: !3081, inlinedAt: !3123)
!3123 = !DILocation(line: 46, scope: !3124, inlinedAt: !3118)
!3124 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !306, file: !306, type: !120, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !69)
!3125 = !DILocation(line: 96, scope: !3091, inlinedAt: !3034)
!3126 = !DILocation(line: 369, scope: !2929)
