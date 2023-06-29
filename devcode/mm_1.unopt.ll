; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { [16 x %1], [16 x %1], [16 x %1], [16 x %2], [16 x %2], [16 x [256 x %3]], i64, i64, [14 x i64], i64 }
%1 = type { i32, [15 x i64] }
%2 = type { i64, [15 x i64] }
%3 = type { i64, i64, i32 }
%4 = type { i32, i32, i32, i32, i32, i32, i32, i32 }
%5 = type { %6 addrspace(1)*, %7 addrspace(1)*, %8, i64, i64, i64 }
%6 = type { i64, i64, i32, i32 }
%7 = type { [64 x [8 x i64]] }
%8 = type { i64 }
%9 = type { i64, %8, i64, i32, i32, i64, i64, %10, [2 x i32] }
%10 = type { %11 addrspace(1)* }
%11 = type { %12, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %8, [14 x i32] }
%12 = type { i32, i32, i8 addrspace(1)*, %8, i32, i32, i64 }
%13 = type { i32, i32, i32, i32, [524284 x i32] }

@0 = internal addrspace(1) global %0 zeroinitializer, align 8
@1 = internal unnamed_addr addrspace(4) constant [16 x %4] [%4 { i32 130054, i32 129546, i32 110114, i32 16288, i32 6, i32 256, i32 0, i32 4195 }, %4 { i32 86927, i32 86758, i32 73744, i32 10904, i32 399, i32 512, i32 0, i32 2804 }, %4 { i32 65280, i32 64770, i32 55054, i32 8192, i32 0, i32 128, i32 0, i32 2107 }, %4 { i32 43576, i32 43406, i32 36895, i32 5504, i32 56, i32 256, i32 0, i32 1405 }, %4 { i32 32703, i32 32193, i32 27364, i32 4160, i32 63, i32 64, i32 0, i32 1054 }, %4 { i32 21816, i32 21646, i32 18399, i32 2816, i32 56, i32 128, i32 0, i32 703 }, %4 { i32 16367, i32 15856, i32 13477, i32 2176, i32 15, i32 32, i32 32768, i32 527 }, %4 { i32 10915, i32 10745, i32 9133, i32 1472, i32 35, i32 64, i32 0, i32 352 }, %4 { i32 8187, i32 7676, i32 6524, i32 1280, i32 11, i32 16, i32 134219776, i32 265 }, %4 { i32 5459, i32 5289, i32 4495, i32 896, i32 19, i32 32, i32 524288, i32 176 }, %4 { i32 4094, i32 3583, i32 3045, i32 1024, i32 6, i32 8, i32 1077952576, i32 133 }, %4 { i32 2730, i32 2560, i32 2176, i32 512, i32 10, i32 16, i32 67109888, i32 89 }, %4 { i32 2047, i32 1536, i32 1305, i32 1024, i32 3, i32 4, i32 -2004318072, i32 66 }, %4 { i32 1365, i32 1195, i32 1015, i32 512, i32 5, i32 8, i32 538976288, i32 44 }, %4 { i32 1023, i32 512, i32 435, i32 2048, i32 1, i32 2, i32 -1431655766, i32 34 }, %4 { i32 682, i32 512, i32 435, i32 2048, i32 2, i32 4, i32 1145324612, i32 35 }], align 4
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 10300, align 4
@__oclc_ABI_version = internal unnamed_addr addrspace(4) constant i32 500, align 4
@__oclc_wavefrontsize64 = internal unnamed_addr addrspace(4) constant i8 1, align 1

declare {}*** @julia.get_pgcstack() local_unnamed_addr

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `mm`
define amdgpu_kernel void @_Z2mm() local_unnamed_addr #0 !dbg !9 {
conversion:
  br label %top

top:                                              ; preds = %conversion
  %0 = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %0 to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -13
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:370 within `mm`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `#dm_alloc`
   %3 = call i64 bitcast (i8 addrspace(1)* (i64)* @__ockl_dm_alloc to i64 (i64)*)(i64 128), !dbg !12
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:372 within `mm`
  ret void, !dbg !16
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc i64 @__ockl_devmem_request(i64 noundef %0, i64 noundef %1) unnamed_addr #1 {
  %3 = tail call fastcc <2 x i64> @__ockl_hostcall_preview(i32 noundef 3, i64 noundef %0, i64 noundef %1, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #22
  %4 = extractelement <2 x i64> %3, i64 0
  ret i64 %4
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc <2 x i64> @__ockl_hostcall_preview(i32 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3, i64 noundef %4, i64 noundef %5, i64 noundef %6, i64 noundef %7, i64 noundef %8) unnamed_addr #1 {
  %10 = load i32, i32 addrspace(4)* @__oclc_ABI_version, align 4, !tbaa !17
  %11 = icmp slt i32 %10, 500
  %12 = tail call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %13 = select i1 %11, i64 24, i64 80
  %14 = getelementptr inbounds i8, i8 addrspace(4)* %12, i64 %13
  %15 = bitcast i8 addrspace(4)* %14 to i64 addrspace(4)*
  %16 = load i64, i64 addrspace(4)* %15, align 8, !tbaa !21
  %17 = inttoptr i64 %16 to i8 addrspace(1)*
  %18 = addrspacecast i8 addrspace(1)* %17 to i8*
  %19 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %18, i32 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3, i64 noundef %4, i64 noundef %5, i64 noundef %6, i64 noundef %7, i64 noundef %8) #22
  ret <2 x i64> %19
}

; Function Attrs: alwaysinline nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr() #2

; Function Attrs: convergent noinline norecurse nounwind optnone
define internal fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %0, i32 noundef %1, i64 noundef %2, i64 noundef %3, i64 noundef %4, i64 noundef %5, i64 noundef %6, i64 noundef %7, i64 noundef %8, i64 noundef %9) unnamed_addr #3 {
  %11 = alloca i8*, align 8, addrspace(5)
  %12 = alloca i32, align 4, addrspace(5)
  %13 = alloca i64, align 8, addrspace(5)
  %14 = alloca i64, align 8, addrspace(5)
  %15 = alloca i64, align 8, addrspace(5)
  %16 = alloca i64, align 8, addrspace(5)
  %17 = alloca i64, align 8, addrspace(5)
  %18 = alloca i64, align 8, addrspace(5)
  %19 = alloca i64, align 8, addrspace(5)
  %20 = alloca i64, align 8, addrspace(5)
  %21 = alloca i32, align 4, addrspace(5)
  %22 = alloca i32, align 4, addrspace(5)
  %23 = alloca %5 addrspace(1)*, align 8, addrspace(5)
  %24 = alloca i64, align 8, addrspace(5)
  %25 = alloca %6 addrspace(1)*, align 8, addrspace(5)
  %26 = alloca %7 addrspace(1)*, align 8, addrspace(5)
  %27 = alloca <2 x i64>, align 16, addrspace(5)
  store i8* %0, i8* addrspace(5)* %11, align 8, !tbaa !23
  store i32 %1, i32 addrspace(5)* %12, align 4, !tbaa !17
  store i64 %2, i64 addrspace(5)* %13, align 8, !tbaa !21
  store i64 %3, i64 addrspace(5)* %14, align 8, !tbaa !21
  store i64 %4, i64 addrspace(5)* %15, align 8, !tbaa !21
  store i64 %5, i64 addrspace(5)* %16, align 8, !tbaa !21
  store i64 %6, i64 addrspace(5)* %17, align 8, !tbaa !21
  store i64 %7, i64 addrspace(5)* %18, align 8, !tbaa !21
  store i64 %8, i64 addrspace(5)* %19, align 8, !tbaa !21
  store i64 %9, i64 addrspace(5)* %20, align 8, !tbaa !21
  %28 = bitcast i32 addrspace(5)* %21 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 4, i8 addrspace(5)* %28) #23
  %29 = call fastcc i32 @__ockl_lane_u32() #24
  store i32 %29, i32 addrspace(5)* %21, align 4, !tbaa !17
  %30 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %31 = call fastcc i32 @2(i32 noundef %30) #24
  store i32 %31, i32 addrspace(5)* %21, align 4, !tbaa !17
  %32 = bitcast i32 addrspace(5)* %22 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 4, i8 addrspace(5)* %32) #23
  %33 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %34 = call i32 @llvm.amdgcn.readfirstlane(i32 %33)
  store i32 %34, i32 addrspace(5)* %22, align 4, !tbaa !17
  %35 = bitcast %5 addrspace(1)* addrspace(5)* %23 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %35) #23
  %36 = load i8*, i8* addrspace(5)* %11, align 8, !tbaa !23
  %37 = addrspacecast i8* %36 to %5 addrspace(1)*
  store %5 addrspace(1)* %37, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %38 = bitcast i64 addrspace(5)* %24 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %38) #23
  %39 = load %5 addrspace(1)*, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %40 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %41 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !17
  %42 = call fastcc i64 @3(%5 addrspace(1)* noundef %39, i32 noundef %40, i32 noundef %41) #24
  store i64 %42, i64 addrspace(5)* %24, align 8, !tbaa !21
  %43 = bitcast %6 addrspace(1)* addrspace(5)* %25 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %43) #23
  %44 = load %5 addrspace(1)*, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %45 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !21
  %46 = getelementptr %5, %5 addrspace(1)* %44, i64 0, i32 0
  %47 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(1)* %46, align 8, !tbaa !25
  %48 = getelementptr %5, %5 addrspace(1)* %44, i64 0, i32 5
  %49 = load i64, i64 addrspace(1)* %48, align 8, !tbaa !28
  %50 = call fastcc %6 addrspace(1)* @4(%6 addrspace(1)* %47, i64 %49, i64 noundef %45) #24
  store %6 addrspace(1)* %50, %6 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !23
  %51 = bitcast %7 addrspace(1)* addrspace(5)* %26 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %51) #23
  %52 = load %5 addrspace(1)*, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %53 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !21
  %54 = getelementptr %5, %5 addrspace(1)* %52, i64 0, i32 1
  %55 = load %7 addrspace(1)*, %7 addrspace(1)* addrspace(1)* %54, align 8, !tbaa !29
  %56 = getelementptr %5, %5 addrspace(1)* %52, i64 0, i32 5
  %57 = load i64, i64 addrspace(1)* %56, align 8, !tbaa !28
  %58 = call fastcc %7 addrspace(1)* @5(%7 addrspace(1)* %55, i64 %57, i64 noundef %53) #24
  store %7 addrspace(1)* %58, %7 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !23
  %59 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !23
  %60 = load %7 addrspace(1)*, %7 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !23
  %61 = load i32, i32 addrspace(5)* %12, align 4, !tbaa !17
  %62 = load i64, i64 addrspace(5)* %13, align 8, !tbaa !21
  %63 = load i64, i64 addrspace(5)* %14, align 8, !tbaa !21
  %64 = load i64, i64 addrspace(5)* %15, align 8, !tbaa !21
  %65 = load i64, i64 addrspace(5)* %16, align 8, !tbaa !21
  %66 = load i64, i64 addrspace(5)* %17, align 8, !tbaa !21
  %67 = load i64, i64 addrspace(5)* %18, align 8, !tbaa !21
  %68 = load i64, i64 addrspace(5)* %19, align 8, !tbaa !21
  %69 = load i64, i64 addrspace(5)* %20, align 8, !tbaa !21
  %70 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %71 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !17
  call fastcc void @6(%6 addrspace(1)* noundef %59, %7 addrspace(1)* noundef %60, i32 noundef %61, i64 noundef %62, i64 noundef %63, i64 noundef %64, i64 noundef %65, i64 noundef %66, i64 noundef %67, i64 noundef %68, i64 noundef %69, i32 noundef %70, i32 noundef %71) #24
  %72 = load %5 addrspace(1)*, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %73 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !21
  %74 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %75 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !17
  call fastcc void @7(%5 addrspace(1)* noundef %72, i64 noundef %73, i32 noundef %74, i32 noundef %75) #24
  %76 = bitcast <2 x i64> addrspace(5)* %27 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 16, i8 addrspace(5)* %76) #23
  %77 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !23
  %78 = load %7 addrspace(1)*, %7 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !23
  %79 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %80 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !17
  %81 = call fastcc <2 x i64> @8(%6 addrspace(1)* noundef %77, %7 addrspace(1)* noundef %78, i32 noundef %79, i32 noundef %80) #24
  store <2 x i64> %81, <2 x i64> addrspace(5)* %27, align 16, !tbaa !30
  %82 = load %5 addrspace(1)*, %5 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !23
  %83 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !21
  %84 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !17
  %85 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !17
  call fastcc void @9(%5 addrspace(1)* noundef %82, i64 noundef %83, i32 noundef %84, i32 noundef %85) #24
  %86 = load <2 x i64>, <2 x i64> addrspace(5)* %27, align 16, !tbaa !30
  %87 = bitcast <2 x i64> addrspace(5)* %27 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 16, i8 addrspace(5)* %87) #23
  %88 = bitcast %7 addrspace(1)* addrspace(5)* %26 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %88) #23
  %89 = bitcast %6 addrspace(1)* addrspace(5)* %25 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %89) #23
  %90 = bitcast i64 addrspace(5)* %24 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %90) #23
  %91 = bitcast %5 addrspace(1)* addrspace(5)* %23 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %91) #23
  %92 = bitcast i32 addrspace(5)* %22 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 4, i8 addrspace(5)* %92) #23
  %93 = bitcast i32 addrspace(5)* %21 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 4, i8 addrspace(5)* %93) #23
  ret <2 x i64> %86
}

; Function Attrs: alwaysinline argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #4

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn
define internal fastcc i32 @__ockl_lane_u32() unnamed_addr #5 {
  %1 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1, !tbaa !31, !range !33
  %2 = icmp eq i8 %1, 0
  %3 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0)
  br i1 %2, label %6, label %4

4:                                                ; preds = %0
  %5 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %3)
  br label %6

6:                                                ; preds = %4, %0
  %7 = phi i32 [ %5, %4 ], [ %3, %0 ]
  ret i32 %7
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc i32 @2(i32 noundef %0) unnamed_addr #6 {
  %2 = tail call i32 asm sideeffect "; ockl readfirstlane hoisting hack $0", "=v,0"(i32 %0) #22, !srcloc !34
  ret i32 %2
}

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #7

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc i64 @3(%5 addrspace(1)* nocapture noundef %0, i32 noundef %1, i32 noundef %2) unnamed_addr #6 {
  %4 = icmp eq i32 %1, %2
  br i1 %4, label %5, label %30

5:                                                ; preds = %3
  %6 = getelementptr inbounds %5, %5 addrspace(1)* %0, i64 0, i32 3
  %7 = load atomic i64, i64 addrspace(1)* %6 syncscope("one-as") acquire, align 8
  %8 = getelementptr %5, %5 addrspace(1)* %0, i64 0, i32 0
  %9 = getelementptr %5, %5 addrspace(1)* %0, i64 0, i32 5
  %10 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(1)* %8, align 8, !tbaa !25
  %11 = load i64, i64 addrspace(1)* %9, align 8, !tbaa !28
  %12 = and i64 %11, %7
  %13 = getelementptr inbounds %6, %6 addrspace(1)* %10, i64 %12, i32 0
  %14 = load atomic i64, i64 addrspace(1)* %13 syncscope("one-as") monotonic, align 8
  %15 = cmpxchg i64 addrspace(1)* %6, i64 %7, i64 %14 syncscope("one-as") acquire monotonic, align 8
  %16 = extractvalue { i64, i1 } %15, 1
  br i1 %16, label %27, label %17

17:                                               ; preds = %17, %5
  %18 = phi { i64, i1 } [ %25, %17 ], [ %15, %5 ]
  %19 = extractvalue { i64, i1 } %18, 0
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  %20 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(1)* %8, align 8, !tbaa !25
  %21 = load i64, i64 addrspace(1)* %9, align 8, !tbaa !28
  %22 = and i64 %21, %19
  %23 = getelementptr inbounds %6, %6 addrspace(1)* %20, i64 %22, i32 0
  %24 = load atomic i64, i64 addrspace(1)* %23 syncscope("one-as") monotonic, align 8
  %25 = cmpxchg i64 addrspace(1)* %6, i64 %19, i64 %24 syncscope("one-as") acquire monotonic, align 8
  %26 = extractvalue { i64, i1 } %25, 1
  br i1 %26, label %27, label %17

27:                                               ; preds = %17, %5
  %28 = phi { i64, i1 } [ %15, %5 ], [ %25, %17 ]
  %29 = extractvalue { i64, i1 } %28, 0
  br label %30

30:                                               ; preds = %27, %3
  %31 = phi i64 [ %29, %27 ], [ 0, %3 ]
  %32 = trunc i64 %31 to i32
  %33 = lshr i64 %31, 32
  %34 = trunc i64 %33 to i32
  %35 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %32)
  %36 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %34)
  %37 = zext i32 %36 to i64
  %38 = shl nuw i64 %37, 32
  %39 = zext i32 %35 to i64
  %40 = or i64 %38, %39
  ret i64 %40
}

; Function Attrs: alwaysinline argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn
define internal fastcc %6 addrspace(1)* @4(%6 addrspace(1)* %0, i64 %1, i64 noundef %2) unnamed_addr #8 {
  %4 = and i64 %2, %1
  %5 = getelementptr inbounds %6, %6 addrspace(1)* %0, i64 %4
  ret %6 addrspace(1)* %5
}

; Function Attrs: alwaysinline argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn
define internal fastcc %7 addrspace(1)* @5(%7 addrspace(1)* %0, i64 %1, i64 noundef %2) unnamed_addr #8 {
  %4 = and i64 %2, %1
  %5 = getelementptr inbounds %7, %7 addrspace(1)* %0, i64 %4
  ret %7 addrspace(1)* %5
}

; Function Attrs: alwaysinline convergent mustprogress nofree norecurse nounwind willreturn
define internal fastcc void @6(%6 addrspace(1)* nocapture noundef writeonly %0, %7 addrspace(1)* nocapture noundef writeonly %1, i32 noundef %2, i64 noundef %3, i64 noundef %4, i64 noundef %5, i64 noundef %6, i64 noundef %7, i64 noundef %8, i64 noundef %9, i64 noundef %10, i32 noundef %11, i32 noundef %12) unnamed_addr #9 {
  %14 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %15 = icmp eq i32 %11, %12
  br i1 %15, label %16, label %20

16:                                               ; preds = %13
  %17 = getelementptr inbounds %6, %6 addrspace(1)* %0, i64 0, i32 3
  %18 = getelementptr inbounds %6, %6 addrspace(1)* %0, i64 0, i32 1
  %19 = getelementptr inbounds %6, %6 addrspace(1)* %0, i64 0, i32 2
  store i32 %2, i32 addrspace(1)* %19, align 8, !tbaa !36
  store i64 %14, i64 addrspace(1)* %18, align 8, !tbaa !38
  store i32 1, i32 addrspace(1)* %17, align 4, !tbaa !39
  br label %20

20:                                               ; preds = %16, %13
  %21 = zext i32 %11 to i64
  %22 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 0
  store i64 %3, i64 addrspace(1)* %22, align 8, !tbaa !21
  %23 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 1
  store i64 %4, i64 addrspace(1)* %23, align 8, !tbaa !21
  %24 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 2
  store i64 %5, i64 addrspace(1)* %24, align 8, !tbaa !21
  %25 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 3
  store i64 %6, i64 addrspace(1)* %25, align 8, !tbaa !21
  %26 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 4
  store i64 %7, i64 addrspace(1)* %26, align 8, !tbaa !21
  %27 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 5
  store i64 %8, i64 addrspace(1)* %27, align 8, !tbaa !21
  %28 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 6
  store i64 %9, i64 addrspace(1)* %28, align 8, !tbaa !21
  %29 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %21, i64 7
  store i64 %10, i64 addrspace(1)* %29, align 8, !tbaa !21
  ret void
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc void @7(%5 addrspace(1)* nocapture noundef %0, i64 noundef %1, i32 noundef %2, i32 noundef %3) unnamed_addr #6 {
  %5 = icmp eq i32 %2, %3
  br i1 %5, label %6, label %25

6:                                                ; preds = %4
  %7 = getelementptr inbounds %5, %5 addrspace(1)* %0, i64 0, i32 4
  %8 = load atomic i64, i64 addrspace(1)* %7 syncscope("one-as") monotonic, align 8
  %9 = getelementptr %5, %5 addrspace(1)* %0, i64 0, i32 0
  %10 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(1)* %9, align 8, !tbaa !25
  %11 = getelementptr %5, %5 addrspace(1)* %0, i64 0, i32 5
  %12 = load i64, i64 addrspace(1)* %11, align 8, !tbaa !28
  %13 = and i64 %12, %1
  %14 = getelementptr inbounds %6, %6 addrspace(1)* %10, i64 %13, i32 0
  store i64 %8, i64 addrspace(1)* %14, align 8, !tbaa !40
  %15 = cmpxchg i64 addrspace(1)* %7, i64 %8, i64 %1 syncscope("one-as") release monotonic, align 8
  %16 = extractvalue { i64, i1 } %15, 1
  br i1 %16, label %22, label %17

17:                                               ; preds = %17, %6
  %18 = phi { i64, i1 } [ %20, %17 ], [ %15, %6 ]
  %19 = extractvalue { i64, i1 } %18, 0
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  store i64 %19, i64 addrspace(1)* %14, align 8, !tbaa !40
  %20 = cmpxchg i64 addrspace(1)* %7, i64 %19, i64 %1 syncscope("one-as") release monotonic, align 8
  %21 = extractvalue { i64, i1 } %20, 1
  br i1 %21, label %22, label %17

22:                                               ; preds = %17, %6
  %23 = getelementptr inbounds %5, %5 addrspace(1)* %0, i64 0, i32 2, i32 0
  %24 = load i64, i64 addrspace(1)* %23, align 8
  tail call fastcc void @__ockl_hsa_signal_add(i64 %24, i64 noundef 1, i32 noundef 3) #22
  br label %25

25:                                               ; preds = %22, %4
  ret void
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc <2 x i64> @8(%6 addrspace(1)* nocapture noundef readonly %0, %7 addrspace(1)* nocapture noundef readonly %1, i32 noundef %2, i32 noundef %3) unnamed_addr #1 {
  %5 = icmp eq i32 %2, %3
  %6 = getelementptr inbounds %6, %6 addrspace(1)* %0, i64 0, i32 3
  br label %7

7:                                                ; preds = %15, %4
  br i1 %5, label %8, label %11

8:                                                ; preds = %7
  %9 = load atomic i32, i32 addrspace(1)* %6 syncscope("one-as") acquire, align 4
  %10 = and i32 %9, 1
  br label %11

11:                                               ; preds = %8, %7
  %12 = phi i32 [ %10, %8 ], [ 1, %7 ]
  %13 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %12)
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %16, label %15

15:                                               ; preds = %11
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  br label %7

16:                                               ; preds = %11
  %17 = zext i32 %2 to i64
  %18 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %17, i64 0
  %19 = getelementptr inbounds %7, %7 addrspace(1)* %1, i64 0, i32 0, i64 %17, i64 1
  %20 = load i64, i64 addrspace(1)* %18, align 8, !tbaa !21
  %21 = load i64, i64 addrspace(1)* %19, align 8, !tbaa !21
  %22 = insertelement <2 x i64> undef, i64 %20, i64 0
  %23 = insertelement <2 x i64> %22, i64 %21, i64 1
  ret <2 x i64> %23
}

; Function Attrs: alwaysinline norecurse nounwind
define internal fastcc void @9(%5 addrspace(1)* nocapture noundef %0, i64 noundef %1, i32 noundef %2, i32 noundef %3) unnamed_addr #10 {
  %5 = icmp eq i32 %2, %3
  br i1 %5, label %6, label %26

6:                                                ; preds = %4
  %7 = getelementptr inbounds %5, %5 addrspace(1)* %0, i64 0, i32 5
  %8 = load i64, i64 addrspace(1)* %7, align 8, !tbaa !28
  %9 = add i64 %8, 1
  %10 = add i64 %9, %1
  %11 = icmp eq i64 %10, 0
  %12 = select i1 %11, i64 %9, i64 %10
  %13 = getelementptr inbounds %5, %5 addrspace(1)* %0, i64 0, i32 3
  %14 = load atomic i64, i64 addrspace(1)* %13 syncscope("one-as") monotonic, align 8
  %15 = getelementptr %5, %5 addrspace(1)* %0, i64 0, i32 0
  %16 = load %6 addrspace(1)*, %6 addrspace(1)* addrspace(1)* %15, align 8, !tbaa !25
  %17 = and i64 %12, %8
  %18 = getelementptr inbounds %6, %6 addrspace(1)* %16, i64 %17, i32 0
  store i64 %14, i64 addrspace(1)* %18, align 8, !tbaa !40
  %19 = cmpxchg i64 addrspace(1)* %13, i64 %14, i64 %12 syncscope("one-as") release monotonic, align 8
  %20 = extractvalue { i64, i1 } %19, 1
  br i1 %20, label %26, label %21

21:                                               ; preds = %21, %6
  %22 = phi { i64, i1 } [ %24, %21 ], [ %19, %6 ]
  %23 = extractvalue { i64, i1 } %22, 0
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  store i64 %23, i64 addrspace(1)* %18, align 8, !tbaa !40
  %24 = cmpxchg i64 addrspace(1)* %13, i64 %23, i64 %12 syncscope("one-as") release monotonic, align 8
  %25 = extractvalue { i64, i1 } %24, 1
  br i1 %25, label %26, label %21

26:                                               ; preds = %21, %6, %4
  ret void
}

; Function Attrs: alwaysinline argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #4

; Function Attrs: alwaysinline nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #11

; Function Attrs: convergent norecurse nounwind
define internal fastcc void @__ockl_hsa_signal_add(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #12 {
  %4 = inttoptr i64 %0 to %9 addrspace(1)*
  %5 = getelementptr inbounds %9, %9 addrspace(1)* %4, i64 0, i32 1, i32 0
  switch i32 %2, label %6 [
    i32 1, label %8
    i32 2, label %8
    i32 3, label %10
    i32 4, label %12
    i32 5, label %14
  ]

6:                                                ; preds = %3
  %7 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") monotonic, align 8
  br label %16

8:                                                ; preds = %3, %3
  %9 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") acquire, align 8
  br label %16

10:                                               ; preds = %3
  %11 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") release, align 8
  br label %16

12:                                               ; preds = %3
  %13 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") acq_rel, align 8
  br label %16

14:                                               ; preds = %3
  %15 = atomicrmw add i64 addrspace(1)* %5, i64 %1 seq_cst, align 8
  br label %16

16:                                               ; preds = %14, %12, %10, %8, %6
  %17 = getelementptr inbounds %9, %9 addrspace(1)* %4, i64 0, i32 2
  %18 = load i64, i64 addrspace(1)* %17, align 16, !tbaa !41
  %19 = icmp eq i64 %18, 0
  br i1 %19, label %27, label %20

20:                                               ; preds = %16
  %21 = inttoptr i64 %18 to i64 addrspace(1)*
  %22 = getelementptr inbounds %9, %9 addrspace(1)* %4, i64 0, i32 3
  %23 = load i32, i32 addrspace(1)* %22, align 8, !tbaa !43
  %24 = zext i32 %23 to i64
  store atomic i64 %24, i64 addrspace(1)* %21 syncscope("one-as") release, align 8
  %25 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %23)
  %26 = and i32 %25, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %26)
  br label %27

27:                                               ; preds = %20, %16
  ret void
}

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #13

; Function Attrs: alwaysinline nounwind readonly
declare i64 @llvm.read_register.i64(metadata) #14

; Function Attrs: alwaysinline nounwind readnone willreturn
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #15

; Function Attrs: alwaysinline nounwind readnone willreturn
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32) #15

; Function Attrs: convergent noinline norecurse nounwind
define internal i8 addrspace(1)* @__ockl_dm_alloc(i64 noundef %0) unnamed_addr #16 {
  %2 = icmp eq i64 %0, 0
  br i1 %2, label %1215, label %3

3:                                                ; preds = %1
  %4 = icmp ugt i64 %0, 3072
  br i1 %4, label %5, label %38

5:                                                ; preds = %3
  %6 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef 0, i64 noundef %0) #22
  %7 = icmp eq i64 %6, 0
  br i1 %7, label %36, label %8

8:                                                ; preds = %5
  %9 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %10 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1, !tbaa !31, !range !33
  %11 = icmp eq i8 %10, 0
  br i1 %11, label %16, label %12

12:                                               ; preds = %8
  %13 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %14 = tail call i64 @llvm.ctpop.i64(i64 %13), !range !44
  %15 = trunc i64 %14 to i32
  br label %19

16:                                               ; preds = %8
  %17 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %18 = tail call i32 @llvm.ctpop.i32(i32 %17), !range !46
  br label %19

19:                                               ; preds = %16, %12
  %20 = phi i32 [ %15, %12 ], [ %18, %16 ]
  %21 = icmp eq i32 %9, 0
  br i1 %21, label %22, label %36

22:                                               ; preds = %19
  %23 = load i32, i32 addrspace(4)* @__oclc_ABI_version, align 4, !tbaa !17
  %24 = icmp slt i32 %23, 500
  br i1 %24, label %31, label %25

25:                                               ; preds = %22
  %26 = tail call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %27 = getelementptr inbounds i8, i8 addrspace(4)* %26, i64 96
  %28 = bitcast i8 addrspace(4)* %27 to i64 addrspace(4)*
  %29 = load i64, i64 addrspace(4)* %28, align 8, !tbaa !21
  %30 = inttoptr i64 %29 to %0 addrspace(1)*
  br label %31

31:                                               ; preds = %25, %22
  %32 = phi %0 addrspace(1)* [ %30, %25 ], [ @0, %22 ]
  %33 = getelementptr inbounds %0, %0 addrspace(1)* %32, i64 0, i32 9
  %34 = zext i32 %20 to i64
  %35 = atomicrmw add i64 addrspace(1)* %33, i64 %34 syncscope("agent-one-as") monotonic, align 8
  br label %36

36:                                               ; preds = %31, %19, %5
  %37 = inttoptr i64 %6 to i8 addrspace(1)*
  br label %1215

38:                                               ; preds = %3
  %39 = trunc i64 %0 to i32
  %40 = tail call i32 @llvm.umax.i32(i32 %39, i32 16)
  %41 = tail call fastcc i32 @__ockl_clz_u32(i32 noundef %40) #25
  %42 = sub i32 31, %41
  %43 = and i32 %42, 31
  %44 = shl nuw i32 1, %43
  %45 = mul i32 %41, -2
  %46 = add i32 %45, 54
  %47 = icmp ugt i32 %40, %44
  %48 = zext i1 %47 to i32
  %49 = or i32 %46, %48
  %50 = lshr i32 %44, 1
  %51 = or i32 %50, %44
  %52 = icmp ugt i32 %40, %51
  %53 = zext i1 %52 to i32
  %54 = add i32 %49, %53
  %55 = load i32, i32 addrspace(4)* @__oclc_ABI_version, align 4, !tbaa !17
  %56 = icmp slt i32 %55, 500
  br i1 %56, label %63, label %57

57:                                               ; preds = %38
  %58 = tail call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %59 = getelementptr inbounds i8, i8 addrspace(4)* %58, i64 96
  %60 = bitcast i8 addrspace(4)* %59 to i64 addrspace(4)*
  %61 = load i64, i64 addrspace(4)* %60, align 8, !tbaa !21
  %62 = inttoptr i64 %61 to %0 addrspace(1)*
  br label %63

63:                                               ; preds = %57, %38
  %64 = phi %0 addrspace(1)* [ %62, %57 ], [ @0, %38 ]
  %65 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1
  %66 = icmp eq i8 %65, 0
  %67 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 6
  %68 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 7
  %69 = zext i32 %54 to i64
  %70 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 1, i64 %69, i32 0
  %71 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 0, i64 %69, i32 0
  %72 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %69, i32 2
  %73 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 2, i64 %69, i32 0
  %74 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 4, i64 %69, i32 0
  %75 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 3, i64 %69, i32 0
  %76 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %69, i32 5
  %77 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %69, i32 0
  %78 = lshr i64 191, %69
  %79 = and i64 %78, 1
  %80 = icmp eq i64 %79, 0
  %81 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %69, i32 4
  %82 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %69, i32 6
  %83 = icmp eq i32 %54, 2
  %84 = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 %54, i64 0
  br label %85

85:                                               ; preds = %1211, %63
  %86 = phi i32 [ 1, %63 ], [ %1212, %1211 ]
  %87 = phi i8 addrspace(1)* [ null, %63 ], [ %1213, %1211 ]
  %88 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %86) #22, !srcloc !47
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %1211, label %90

90:                                               ; preds = %85
  %91 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %54)
  %92 = icmp eq i32 %91, %54
  br i1 %92, label %93, label %1211

93:                                               ; preds = %1206, %90
  %94 = phi i32 [ %1207, %1206 ], [ %88, %90 ]
  %95 = phi i32 [ %1208, %1206 ], [ 1, %90 ]
  %96 = phi i8 addrspace(1)* [ %1209, %1206 ], [ %87, %90 ]
  %97 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %95) #22, !srcloc !47
  %98 = icmp eq i32 %97, 0
  br i1 %98, label %1206, label %99

99:                                               ; preds = %93
  %100 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %101 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %100) #22, !srcloc !48
  %102 = icmp eq i32 %101, 0
  br i1 %102, label %103, label %105

103:                                              ; preds = %99
  %104 = load atomic i32, i32 addrspace(1)* %70 syncscope("agent-one-as") monotonic, align 8
  br label %105

105:                                              ; preds = %103, %99
  %106 = phi i32 [ %104, %103 ], [ 0, %99 ]
  %107 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %106)
  %108 = icmp ult i32 %107, 65792
  %109 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br i1 %108, label %110, label %532

110:                                              ; preds = %105
  br i1 %66, label %115, label %111

111:                                              ; preds = %110
  %112 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %113 = tail call i64 @llvm.ctpop.i64(i64 %112), !range !44
  %114 = trunc i64 %113 to i32
  br label %118

115:                                              ; preds = %110
  %116 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %117 = tail call i32 @llvm.ctpop.i32(i32 %116), !range !46
  br label %118

118:                                              ; preds = %115, %111
  %119 = phi i32 [ %114, %111 ], [ %117, %115 ]
  br label %120

120:                                              ; preds = %529, %118
  %121 = phi i32 [ %109, %118 ], [ %124, %529 ]
  %122 = phi i32 [ %107, %118 ], [ %530, %529 ]
  %123 = phi %3 addrspace(1)* [ undef, %118 ], [ %531, %529 ]
  %124 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %121) #22, !srcloc !48
  %125 = icmp eq i32 %122, 0
  br i1 %125, label %204, label %126

126:                                              ; preds = %120
  %127 = icmp eq i32 %124, 0
  br i1 %127, label %128, label %130

128:                                              ; preds = %126
  %129 = load atomic i32, i32 addrspace(1)* %71 syncscope("agent-one-as") monotonic, align 8
  br label %130

130:                                              ; preds = %128, %126
  %131 = phi i32 [ %129, %128 ], [ 0, %126 ]
  %132 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %131)
  %133 = add i32 %132, %124
  %134 = urem i32 %133, %122
  %135 = load i32, i32 addrspace(4)* %72, align 4, !tbaa !49
  br label %136

136:                                              ; preds = %202, %130
  %137 = phi i32 [ %134, %130 ], [ %199, %202 ]
  %138 = phi i32 [ %122, %130 ], [ %200, %202 ]
  %139 = phi %3 addrspace(1)* [ %123, %130 ], [ %201, %202 ]
  %140 = icmp ugt i32 %137, 255
  br i1 %140, label %141, label %151

141:                                              ; preds = %136
  %142 = add i32 %137, -256
  %143 = lshr i32 %142, 8
  %144 = zext i32 %143 to i64
  %145 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %144, i32 0
  %146 = load atomic i64, i64 addrspace(1)* %145 syncscope("agent-one-as") monotonic, align 8
  %147 = inttoptr i64 %146 to %3 addrspace(1)*
  %148 = and i32 %137, 255
  %149 = zext i32 %148 to i64
  %150 = getelementptr inbounds %3, %3 addrspace(1)* %147, i64 %149
  br label %154

151:                                              ; preds = %136
  %152 = zext i32 %137 to i64
  %153 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %152
  br label %154

154:                                              ; preds = %151, %141
  %155 = phi %3 addrspace(1)* [ %150, %141 ], [ %153, %151 ]
  %156 = getelementptr inbounds %3, %3 addrspace(1)* %155, i64 0, i32 2
  %157 = load atomic i32, i32 addrspace(1)* %156 syncscope("agent-one-as") monotonic, align 8
  br i1 %66, label %164, label %158

158:                                              ; preds = %154
  %159 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %157, i32 %135, i32 36)
  %160 = icmp eq i64 %159, 0
  br i1 %160, label %173, label %161

161:                                              ; preds = %158
  %162 = tail call fastcc i64 @__ockl_ctz_u64(i64 noundef %159) #25
  %163 = trunc i64 %162 to i32
  br label %169

164:                                              ; preds = %154
  %165 = tail call i32 @llvm.amdgcn.icmp.i32.i32(i32 %157, i32 %135, i32 36)
  %166 = icmp eq i32 %165, 0
  br i1 %166, label %173, label %167

167:                                              ; preds = %164
  %168 = tail call fastcc i32 @__ockl_ctz_u32(i32 noundef %165) #25
  br label %169

169:                                              ; preds = %167, %161
  %170 = phi i32 [ %168, %167 ], [ %163, %161 ]
  %171 = shl i32 %170, 2
  %172 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %171, i32 %137)
  br label %173

173:                                              ; preds = %169, %164, %158
  %174 = phi i32 [ -1, %158 ], [ -1, %164 ], [ %172, %169 ]
  %175 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %174)
  %176 = icmp eq i32 %175, -1
  br i1 %176, label %192, label %177

177:                                              ; preds = %173
  %178 = icmp ugt i32 %175, 255
  br i1 %178, label %179, label %189

179:                                              ; preds = %177
  %180 = add i32 %175, -256
  %181 = lshr i32 %180, 8
  %182 = zext i32 %181 to i64
  %183 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %182, i32 0
  %184 = load atomic i64, i64 addrspace(1)* %183 syncscope("agent-one-as") monotonic, align 8
  %185 = inttoptr i64 %184 to %3 addrspace(1)*
  %186 = and i32 %175, 255
  %187 = zext i32 %186 to i64
  %188 = getelementptr inbounds %3, %3 addrspace(1)* %185, i64 %187
  br label %198

189:                                              ; preds = %177
  %190 = zext i32 %175 to i64
  %191 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %190
  br label %198

192:                                              ; preds = %173
  %193 = add i32 %137, %119
  %194 = urem i32 %193, %122
  br i1 %127, label %195, label %196

195:                                              ; preds = %192
  store atomic i32 %194, i32 addrspace(1)* %71 syncscope("agent-one-as") monotonic, align 8
  br label %196

196:                                              ; preds = %195, %192
  %197 = sub i32 %138, %119
  br label %198

198:                                              ; preds = %196, %189, %179
  %199 = phi i32 [ %194, %196 ], [ %137, %179 ], [ %137, %189 ]
  %200 = phi i32 [ %197, %196 ], [ %138, %179 ], [ %138, %189 ]
  %201 = phi %3 addrspace(1)* [ %139, %196 ], [ %188, %179 ], [ %191, %189 ]
  br i1 %176, label %202, label %1086

202:                                              ; preds = %198
  %203 = icmp sgt i32 %200, 0
  br i1 %203, label %136, label %204

204:                                              ; preds = %202, %120
  %205 = phi %3 addrspace(1)* [ %123, %120 ], [ %201, %202 ]
  %206 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br label %207

207:                                              ; preds = %505, %204
  %208 = phi i32 [ %206, %204 ], [ %507, %505 ]
  %209 = phi %3 addrspace(1)* [ undef, %204 ], [ %508, %505 ]
  %210 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %208) #22, !srcloc !48
  %211 = icmp eq i32 %210, 0
  br i1 %211, label %212, label %214

212:                                              ; preds = %207
  %213 = load atomic i32, i32 addrspace(1)* %70 syncscope("agent-one-as") monotonic, align 8
  br label %214

214:                                              ; preds = %212, %207
  %215 = phi i32 [ %213, %212 ], [ 0, %207 ]
  %216 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %215)
  %217 = icmp eq i32 %216, 65792
  br i1 %217, label %505, label %218

218:                                              ; preds = %214
  br i1 %211, label %219, label %224

219:                                              ; preds = %218
  %220 = cmpxchg i32 addrspace(1)* %73, i32 0, i32 256 syncscope("agent-one-as") monotonic monotonic, align 4
  %221 = extractvalue { i32, i1 } %220, 1
  %222 = extractvalue { i32, i1 } %220, 0
  %223 = select i1 %221, i32 256, i32 %222
  br label %224

224:                                              ; preds = %219, %218
  %225 = phi i32 [ %223, %219 ], [ 0, %218 ]
  %226 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %225)
  %227 = icmp eq i32 %216, %226
  br i1 %227, label %228, label %335

228:                                              ; preds = %224
  %229 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %230 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %229) #22, !srcloc !48
  %231 = icmp eq i32 %230, 0
  br i1 %231, label %232, label %234

232:                                              ; preds = %228
  %233 = load atomic i32, i32 addrspace(1)* %73 syncscope("agent-one-as") monotonic, align 8
  br label %234

234:                                              ; preds = %232, %228
  %235 = phi i32 [ %233, %232 ], [ 0, %228 ]
  %236 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %235)
  %237 = icmp eq i32 %236, 65792
  br i1 %237, label %316, label %238

238:                                              ; preds = %234
  br i1 %231, label %239, label %248

239:                                              ; preds = %238
  %240 = load atomic i64, i64 addrspace(1)* %74 syncscope("agent-one-as") monotonic, align 8
  %241 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %242 = sub i64 %241, %240
  %243 = icmp ugt i64 %242, 29999
  br i1 %243, label %244, label %248

244:                                              ; preds = %239
  %245 = cmpxchg i64 addrspace(1)* %74, i64 %240, i64 %241 syncscope("agent-one-as") monotonic monotonic, align 8
  %246 = extractvalue { i64, i1 } %245, 1
  %247 = select i1 %246, i32 2, i32 1
  br label %248

248:                                              ; preds = %244, %239, %238
  %249 = phi i32 [ 1, %238 ], [ 1, %239 ], [ %247, %244 ]
  %250 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %249)
  %251 = icmp eq i32 %250, 1
  br i1 %251, label %316, label %252

252:                                              ; preds = %248
  br i1 %231, label %253, label %255

253:                                              ; preds = %252
  %254 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef 0, i64 noundef 6144) #22
  br label %255

255:                                              ; preds = %253, %252
  %256 = phi i64 [ %254, %253 ], [ 0, %252 ]
  %257 = trunc i64 %256 to i32
  %258 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %257)
  %259 = insertelement <2 x i32> undef, i32 %258, i64 0
  %260 = lshr i64 %256, 32
  %261 = trunc i64 %260 to i32
  %262 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %261)
  %263 = insertelement <2 x i32> %259, i32 %262, i64 1
  %264 = bitcast <2 x i32> %263 to i64
  %265 = icmp eq i64 %264, 0
  br i1 %265, label %316, label %266

266:                                              ; preds = %255
  %267 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br i1 %66, label %272, label %268

268:                                              ; preds = %266
  %269 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %270 = tail call i64 @llvm.ctpop.i64(i64 %269), !range !44
  %271 = trunc i64 %270 to i32
  br label %275

272:                                              ; preds = %266
  %273 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %274 = tail call i32 @llvm.ctpop.i32(i32 %273), !range !46
  br label %275

275:                                              ; preds = %272, %268
  %276 = phi i32 [ %271, %268 ], [ %274, %272 ]
  %277 = inttoptr i64 %264 to i64 addrspace(1)*
  %278 = icmp ult i32 %267, 768
  br i1 %278, label %279, label %285

279:                                              ; preds = %279, %275
  %280 = phi i32 [ %283, %279 ], [ %267, %275 ]
  %281 = zext i32 %280 to i64
  %282 = getelementptr inbounds i64, i64 addrspace(1)* %277, i64 %281
  store i64 0, i64 addrspace(1)* %282, align 8, !tbaa !21
  %283 = add i32 %280, %276
  %284 = icmp ult i32 %283, 768
  br i1 %284, label %279, label %285

285:                                              ; preds = %279, %275
  br label %286

286:                                              ; preds = %315, %285
  %287 = phi i32 [ %313, %315 ], [ %250, %285 ]
  %288 = phi i32 [ %296, %315 ], [ %236, %285 ]
  %289 = phi i32 [ %290, %315 ], [ %230, %285 ]
  %290 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %289) #22, !srcloc !48
  %291 = icmp eq i32 %290, 0
  br i1 %291, label %292, label %294

292:                                              ; preds = %286
  %293 = load atomic i32, i32 addrspace(1)* %73 syncscope("agent-one-as") monotonic, align 8
  br label %294

294:                                              ; preds = %292, %286
  %295 = phi i32 [ %293, %292 ], [ %288, %286 ]
  %296 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %295)
  %297 = icmp eq i32 %296, 65792
  br i1 %297, label %298, label %301

298:                                              ; preds = %294
  br i1 %291, label %299, label %316

299:                                              ; preds = %298
  %300 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef %264, i64 noundef 0) #22
  br label %316

301:                                              ; preds = %294
  br i1 %291, label %302, label %311

302:                                              ; preds = %301
  %303 = add i32 %296, -256
  %304 = lshr i32 %303, 8
  %305 = zext i32 %304 to i64
  %306 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %305, i32 0
  %307 = cmpxchg i64 addrspace(1)* %306, i64 0, i64 %264 syncscope("agent-one-as") monotonic monotonic, align 8
  %308 = extractvalue { i64, i1 } %307, 1
  br i1 %308, label %309, label %311

309:                                              ; preds = %302
  %310 = atomicrmw add i32 addrspace(1)* %73, i32 256 syncscope("agent-one-as") release, align 4
  br label %311

311:                                              ; preds = %309, %302, %301
  %312 = phi i32 [ %287, %301 ], [ 0, %309 ], [ %287, %302 ]
  %313 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %312)
  %314 = icmp eq i32 %313, 0
  br i1 %314, label %316, label %315

315:                                              ; preds = %311
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %286

316:                                              ; preds = %311, %299, %298, %255, %248, %234
  %317 = phi i32 [ 2, %234 ], [ 1, %248 ], [ %250, %255 ], [ %287, %299 ], [ %287, %298 ], [ 0, %311 ]
  %318 = icmp eq i32 %317, 0
  br i1 %318, label %333, label %319

319:                                              ; preds = %316
  %320 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %321 = icmp eq i32 %320, 0
  br i1 %321, label %322, label %330

322:                                              ; preds = %319
  %323 = load atomic i64, i64 addrspace(1)* %74 syncscope("agent-one-as") monotonic, align 8
  %324 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %325 = sub i64 %324, %323
  %326 = icmp ult i64 %325, 30000
  br i1 %326, label %327, label %330

327:                                              ; preds = %322
  %328 = trunc i64 %325 to i32
  %329 = sub nuw nsw i32 30000, %328
  tail call fastcc void @__ockl_rtcwait_u32(i32 noundef %329) #22
  br label %330

330:                                              ; preds = %327, %322, %319
  %331 = icmp eq i32 %317, 2
  %332 = select i1 %331, %3 addrspace(1)* null, %3 addrspace(1)* inttoptr (i64 1 to %3 addrspace(1)*)
  br label %333

333:                                              ; preds = %330, %316
  %334 = phi %3 addrspace(1)* [ %332, %330 ], [ %209, %316 ]
  br i1 %318, label %335, label %505

335:                                              ; preds = %333, %224
  %336 = phi %3 addrspace(1)* [ %334, %333 ], [ %209, %224 ]
  br i1 %211, label %337, label %346

337:                                              ; preds = %335
  %338 = load atomic i64, i64 addrspace(1)* %75 syncscope("agent-one-as") monotonic, align 8
  %339 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %340 = sub i64 %339, %338
  %341 = icmp ugt i64 %340, 19999
  br i1 %341, label %342, label %346

342:                                              ; preds = %337
  %343 = cmpxchg i64 addrspace(1)* %75, i64 %338, i64 %339 syncscope("agent-one-as") monotonic monotonic, align 8
  %344 = extractvalue { i64, i1 } %343, 1
  %345 = select i1 %344, i8 addrspace(1)* null, i8 addrspace(1)* inttoptr (i64 1 to i8 addrspace(1)*)
  br label %346

346:                                              ; preds = %342, %337, %335
  %347 = phi i8 addrspace(1)* [ inttoptr (i64 1 to i8 addrspace(1)*), %335 ], [ inttoptr (i64 1 to i8 addrspace(1)*), %337 ], [ %345, %342 ]
  %348 = ptrtoint i8 addrspace(1)* %347 to i64
  %349 = trunc i64 %348 to i32
  %350 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %349)
  %351 = insertelement <2 x i32> undef, i32 %350, i64 0
  %352 = lshr i64 %348, 32
  %353 = trunc i64 %352 to i32
  %354 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %353)
  %355 = insertelement <2 x i32> %351, i32 %354, i64 1
  %356 = bitcast <2 x i32> %355 to i64
  %357 = icmp eq i64 %356, 0
  br i1 %357, label %360, label %358

358:                                              ; preds = %346
  %359 = inttoptr i64 %356 to %3 addrspace(1)*
  br label %505

360:                                              ; preds = %346
  br i1 %211, label %361, label %370

361:                                              ; preds = %360
  %362 = load atomic i64, i64 addrspace(1)* %67 syncscope("agent-one-as") monotonic, align 8
  %363 = load i64, i64 addrspace(1)* %68, align 8, !tbaa !51
  %364 = icmp ult i64 %362, %363
  br i1 %364, label %365, label %368

365:                                              ; preds = %361
  %366 = atomicrmw add i64 addrspace(1)* %67, i64 2097152 syncscope("agent-one-as") monotonic, align 8
  %367 = icmp ult i64 %366, %363
  br i1 %367, label %370, label %368

368:                                              ; preds = %365, %361
  %369 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef 0, i64 noundef 2097152) #22
  br label %370

370:                                              ; preds = %368, %365, %360
  %371 = phi i64 [ 0, %360 ], [ %369, %368 ], [ %366, %365 ]
  %372 = trunc i64 %371 to i32
  %373 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %372)
  %374 = insertelement <2 x i32> undef, i32 %373, i64 0
  %375 = lshr i64 %371, 32
  %376 = trunc i64 %375 to i32
  %377 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %376)
  %378 = insertelement <2 x i32> %374, i32 %377, i64 1
  %379 = bitcast <2 x i32> %378 to i64
  %380 = icmp eq i64 %379, 0
  br i1 %380, label %505, label %381

381:                                              ; preds = %370
  %382 = inttoptr i64 %379 to %13 addrspace(1)*
  %383 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %384 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %383) #22, !srcloc !48
  br i1 %66, label %389, label %385

385:                                              ; preds = %381
  %386 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %387 = tail call i64 @llvm.ctpop.i64(i64 %386), !range !44
  %388 = trunc i64 %387 to i32
  br label %392

389:                                              ; preds = %381
  %390 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %391 = tail call i32 @llvm.ctpop.i32(i32 %390), !range !46
  br label %392

392:                                              ; preds = %389, %385
  %393 = phi i32 [ %388, %385 ], [ %391, %389 ]
  %394 = load i32, i32 addrspace(4)* %76, align 4, !tbaa !53
  %395 = load i32, i32 addrspace(4)* %77, align 4, !tbaa !54
  %396 = add i32 %395, 31
  %397 = lshr i32 %396, 5
  br i1 %80, label %421, label %398

398:                                              ; preds = %392
  %399 = icmp ult i32 %384, %397
  br i1 %399, label %406, label %400

400:                                              ; preds = %406, %398
  %401 = mul i32 %394, %393
  %402 = load i32, i32 addrspace(4)* %81, align 4, !tbaa !55
  %403 = mul i32 %394, %384
  %404 = add i32 %402, %403
  %405 = icmp ult i32 %404, %395
  br i1 %405, label %412, label %430

406:                                              ; preds = %406, %398
  %407 = phi i32 [ %410, %406 ], [ %384, %398 ]
  %408 = zext i32 %407 to i64
  %409 = getelementptr inbounds %13, %13 addrspace(1)* %382, i64 0, i32 4, i64 %408
  store i32 0, i32 addrspace(1)* %409, align 4, !tbaa !17
  %410 = add i32 %407, %393
  %411 = icmp ult i32 %410, %397
  br i1 %411, label %406, label %400

412:                                              ; preds = %412, %400
  %413 = phi i32 [ %419, %412 ], [ %404, %400 ]
  %414 = and i32 %413, 31
  %415 = shl nuw i32 1, %414
  %416 = lshr i32 %413, 5
  %417 = zext i32 %416 to i64
  %418 = getelementptr inbounds %13, %13 addrspace(1)* %382, i64 0, i32 4, i64 %417
  store i32 %415, i32 addrspace(1)* %418, align 4, !tbaa !17
  %419 = add i32 %413, %401
  %420 = icmp ult i32 %419, %395
  br i1 %420, label %412, label %430

421:                                              ; preds = %392
  %422 = load i32, i32 addrspace(4)* %82, align 4, !tbaa !56
  %423 = icmp ult i32 %384, %397
  br i1 %423, label %424, label %430

424:                                              ; preds = %424, %421
  %425 = phi i32 [ %428, %424 ], [ %384, %421 ]
  %426 = zext i32 %425 to i64
  %427 = getelementptr inbounds %13, %13 addrspace(1)* %382, i64 0, i32 4, i64 %426
  store i32 %422, i32 addrspace(1)* %427, align 4, !tbaa !17
  %428 = add i32 %425, %393
  %429 = icmp ult i32 %428, %397
  br i1 %429, label %424, label %430

430:                                              ; preds = %424, %421, %412, %400
  %431 = icmp eq i32 %384, 0
  br i1 %431, label %432, label %443

432:                                              ; preds = %430
  br i1 %83, label %441, label %433

433:                                              ; preds = %432
  %434 = and i32 %395, 31
  %435 = shl nsw i32 -1, %434
  %436 = add nsw i32 %397, -1
  %437 = zext i32 %436 to i64
  %438 = getelementptr inbounds %13, %13 addrspace(1)* %382, i64 0, i32 4, i64 %437
  %439 = load i32, i32 addrspace(1)* %438, align 4, !tbaa !17
  %440 = or i32 %439, %435
  store i32 %440, i32 addrspace(1)* %438, align 4, !tbaa !17
  br label %441

441:                                              ; preds = %433, %432
  %442 = inttoptr i64 %379 to <4 x i32> addrspace(1)*
  store <4 x i32> %84, <4 x i32> addrspace(1)* %442, align 16, !tbaa !30
  br label %443

443:                                              ; preds = %441, %430
  %444 = getelementptr inbounds %13, %13 addrspace(1)* %382, i64 0, i32 1
  br label %445

445:                                              ; preds = %504, %443
  %446 = phi i32 [ %226, %443 ], [ %462, %504 ]
  %447 = phi i32 [ %216, %443 ], [ %455, %504 ]
  %448 = phi i32 [ %210, %443 ], [ %449, %504 ]
  %449 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %448) #22, !srcloc !48
  %450 = icmp eq i32 %449, 0
  br i1 %450, label %451, label %453

451:                                              ; preds = %445
  %452 = load atomic i32, i32 addrspace(1)* %70 syncscope("agent-one-as") monotonic, align 8
  br label %453

453:                                              ; preds = %451, %445
  %454 = phi i32 [ %452, %451 ], [ %447, %445 ]
  %455 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %454)
  %456 = icmp eq i32 %455, 65792
  br i1 %456, label %505, label %457

457:                                              ; preds = %453
  br i1 %450, label %458, label %460

458:                                              ; preds = %457
  %459 = load atomic i32, i32 addrspace(1)* %73 syncscope("agent-one-as") monotonic, align 8
  br label %460

460:                                              ; preds = %458, %457
  %461 = phi i32 [ %459, %458 ], [ %446, %457 ]
  %462 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %461)
  %463 = icmp eq i32 %455, %462
  br i1 %463, label %464, label %467

464:                                              ; preds = %460
  br i1 %450, label %465, label %505

465:                                              ; preds = %464
  %466 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef %379, i64 noundef 0) #22
  br label %505

467:                                              ; preds = %460
  br i1 %450, label %468, label %490

468:                                              ; preds = %467
  %469 = icmp ugt i32 %455, 255
  br i1 %469, label %470, label %480

470:                                              ; preds = %468
  %471 = add i32 %455, -256
  %472 = lshr i32 %471, 8
  %473 = zext i32 %472 to i64
  %474 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %473, i32 0
  %475 = load atomic i64, i64 addrspace(1)* %474 syncscope("agent-one-as") monotonic, align 8
  %476 = inttoptr i64 %475 to %3 addrspace(1)*
  %477 = and i32 %455, 255
  %478 = zext i32 %477 to i64
  %479 = getelementptr inbounds %3, %3 addrspace(1)* %476, i64 %478
  br label %483

480:                                              ; preds = %468
  %481 = zext i32 %455 to i64
  %482 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %69, i64 %481
  br label %483

483:                                              ; preds = %480, %470
  %484 = phi %3 addrspace(1)* [ %479, %470 ], [ %482, %480 ]
  store i32 %455, i32 addrspace(1)* %444, align 4, !tbaa !57
  %485 = getelementptr inbounds %3, %3 addrspace(1)* %484, i64 0, i32 1
  %486 = cmpxchg i64 addrspace(1)* %485, i64 0, i64 %379 syncscope("agent-one-as") monotonic monotonic, align 8
  %487 = extractvalue { i64, i1 } %486, 1
  br i1 %487, label %488, label %490

488:                                              ; preds = %483
  %489 = atomicrmw add i32 addrspace(1)* %70, i32 1 syncscope("agent-one-as") release, align 4
  br label %490

490:                                              ; preds = %488, %483, %467
  %491 = phi %3 addrspace(1)* [ null, %467 ], [ %484, %488 ], [ null, %483 ]
  %492 = ptrtoint %3 addrspace(1)* %491 to i64
  %493 = trunc i64 %492 to i32
  %494 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %493)
  %495 = insertelement <2 x i32> undef, i32 %494, i64 0
  %496 = lshr i64 %492, 32
  %497 = trunc i64 %496 to i32
  %498 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %497)
  %499 = insertelement <2 x i32> %495, i32 %498, i64 1
  %500 = bitcast <2 x i32> %499 to i64
  %501 = icmp eq i64 %500, 0
  br i1 %501, label %504, label %502

502:                                              ; preds = %490
  %503 = inttoptr i64 %500 to %3 addrspace(1)*
  br label %505

504:                                              ; preds = %490
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %445

505:                                              ; preds = %502, %465, %464, %453, %370, %358, %333, %214
  %506 = phi i1 [ false, %358 ], [ true, %465 ], [ true, %464 ], [ false, %370 ], [ false, %502 ], [ false, %214 ], [ false, %333 ], [ false, %453 ]
  %507 = phi i32 [ %210, %358 ], [ 0, %465 ], [ %449, %464 ], [ %210, %370 ], [ %449, %502 ], [ %210, %214 ], [ %210, %333 ], [ %449, %453 ]
  %508 = phi %3 addrspace(1)* [ %359, %358 ], [ %336, %465 ], [ %336, %464 ], [ null, %370 ], [ %503, %502 ], [ null, %214 ], [ %334, %333 ], [ null, %453 ]
  br i1 %506, label %207, label %509

509:                                              ; preds = %505
  %510 = icmp eq %3 addrspace(1)* %508, inttoptr (i64 1 to %3 addrspace(1)*)
  br i1 %510, label %511, label %529

511:                                              ; preds = %509
  %512 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %513 = icmp eq i32 %512, 0
  br i1 %513, label %514, label %522

514:                                              ; preds = %511
  %515 = load atomic i64, i64 addrspace(1)* %75 syncscope("agent-one-as") monotonic, align 8
  %516 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %517 = sub i64 %516, %515
  %518 = icmp ult i64 %517, 20000
  br i1 %518, label %519, label %522

519:                                              ; preds = %514
  %520 = trunc i64 %517 to i32
  %521 = sub nuw nsw i32 20000, %520
  tail call fastcc void @__ockl_rtcwait_u32(i32 noundef %521) #22
  br label %522

522:                                              ; preds = %519, %514, %511
  %523 = icmp eq i32 %124, 0
  br i1 %523, label %524, label %526

524:                                              ; preds = %522
  %525 = load atomic i32, i32 addrspace(1)* %70 syncscope("agent-one-as") monotonic, align 8
  br label %526

526:                                              ; preds = %524, %522
  %527 = phi i32 [ %525, %524 ], [ %122, %522 ]
  %528 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %527)
  br label %529

529:                                              ; preds = %526, %509
  %530 = phi i32 [ %528, %526 ], [ %122, %509 ]
  %531 = phi %3 addrspace(1)* [ %205, %526 ], [ %508, %509 ]
  br i1 %510, label %120, label %1086

532:                                              ; preds = %105
  br i1 %66, label %537, label %533

533:                                              ; preds = %532
  %534 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %535 = tail call i64 @llvm.ctpop.i64(i64 %534), !range !44
  %536 = trunc i64 %535 to i32
  br label %540

537:                                              ; preds = %532
  %538 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %539 = tail call i32 @llvm.ctpop.i32(i32 %538), !range !46
  br label %540

540:                                              ; preds = %537, %533
  %541 = phi i32 [ %536, %533 ], [ %539, %537 ]
  br label %542

542:                                              ; preds = %1082, %540
  %543 = phi i32 [ %54, %540 ], [ %1084, %1082 ]
  %544 = phi i32 [ %109, %540 ], [ %546, %1082 ]
  %545 = phi %3 addrspace(1)* [ undef, %540 ], [ %1085, %1082 ]
  %546 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %544) #22, !srcloc !48
  %547 = zext i32 %543 to i64
  %548 = icmp eq i32 %546, 0
  br i1 %548, label %549, label %552

549:                                              ; preds = %542
  %550 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 0, i64 %547, i32 0
  %551 = load atomic i32, i32 addrspace(1)* %550 syncscope("agent-one-as") monotonic, align 8
  br label %552

552:                                              ; preds = %549, %542
  %553 = phi i32 [ %551, %549 ], [ 0, %542 ]
  %554 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %553)
  %555 = add i32 %554, %546
  %556 = urem i32 %555, 65792
  %557 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %547, i32 1
  %558 = load i32, i32 addrspace(4)* %557, align 4, !tbaa !59
  %559 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 0, i64 %547, i32 0
  br label %560

560:                                              ; preds = %626, %552
  %561 = phi i32 [ %556, %552 ], [ %623, %626 ]
  %562 = phi i32 [ 65792, %552 ], [ %624, %626 ]
  %563 = phi %3 addrspace(1)* [ %545, %552 ], [ %625, %626 ]
  %564 = icmp ugt i32 %561, 255
  br i1 %564, label %565, label %575

565:                                              ; preds = %560
  %566 = add i32 %561, -256
  %567 = lshr i32 %566, 8
  %568 = zext i32 %567 to i64
  %569 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %547, i64 %568, i32 0
  %570 = load atomic i64, i64 addrspace(1)* %569 syncscope("agent-one-as") monotonic, align 8
  %571 = inttoptr i64 %570 to %3 addrspace(1)*
  %572 = and i32 %561, 255
  %573 = zext i32 %572 to i64
  %574 = getelementptr inbounds %3, %3 addrspace(1)* %571, i64 %573
  br label %578

575:                                              ; preds = %560
  %576 = zext i32 %561 to i64
  %577 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %547, i64 %576
  br label %578

578:                                              ; preds = %575, %565
  %579 = phi %3 addrspace(1)* [ %574, %565 ], [ %577, %575 ]
  %580 = getelementptr inbounds %3, %3 addrspace(1)* %579, i64 0, i32 2
  %581 = load atomic i32, i32 addrspace(1)* %580 syncscope("agent-one-as") monotonic, align 8
  br i1 %66, label %588, label %582

582:                                              ; preds = %578
  %583 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %581, i32 %558, i32 36)
  %584 = icmp eq i64 %583, 0
  br i1 %584, label %597, label %585

585:                                              ; preds = %582
  %586 = tail call fastcc i64 @__ockl_ctz_u64(i64 noundef %583) #25
  %587 = trunc i64 %586 to i32
  br label %593

588:                                              ; preds = %578
  %589 = tail call i32 @llvm.amdgcn.icmp.i32.i32(i32 %581, i32 %558, i32 36)
  %590 = icmp eq i32 %589, 0
  br i1 %590, label %597, label %591

591:                                              ; preds = %588
  %592 = tail call fastcc i32 @__ockl_ctz_u32(i32 noundef %589) #25
  br label %593

593:                                              ; preds = %591, %585
  %594 = phi i32 [ %592, %591 ], [ %587, %585 ]
  %595 = shl i32 %594, 2
  %596 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %595, i32 %561)
  br label %597

597:                                              ; preds = %593, %588, %582
  %598 = phi i32 [ -1, %582 ], [ -1, %588 ], [ %596, %593 ]
  %599 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %598)
  %600 = icmp eq i32 %599, -1
  br i1 %600, label %616, label %601

601:                                              ; preds = %597
  %602 = icmp ugt i32 %599, 255
  br i1 %602, label %603, label %613

603:                                              ; preds = %601
  %604 = add i32 %599, -256
  %605 = lshr i32 %604, 8
  %606 = zext i32 %605 to i64
  %607 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %547, i64 %606, i32 0
  %608 = load atomic i64, i64 addrspace(1)* %607 syncscope("agent-one-as") monotonic, align 8
  %609 = inttoptr i64 %608 to %3 addrspace(1)*
  %610 = and i32 %599, 255
  %611 = zext i32 %610 to i64
  %612 = getelementptr inbounds %3, %3 addrspace(1)* %609, i64 %611
  br label %622

613:                                              ; preds = %601
  %614 = zext i32 %599 to i64
  %615 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %547, i64 %614
  br label %622

616:                                              ; preds = %597
  %617 = add i32 %561, %541
  %618 = urem i32 %617, 65792
  br i1 %548, label %619, label %620

619:                                              ; preds = %616
  store atomic i32 %618, i32 addrspace(1)* %559 syncscope("agent-one-as") monotonic, align 8
  br label %620

620:                                              ; preds = %619, %616
  %621 = sub i32 %562, %541
  br label %622

622:                                              ; preds = %620, %613, %603
  %623 = phi i32 [ %618, %620 ], [ %561, %603 ], [ %561, %613 ]
  %624 = phi i32 [ %621, %620 ], [ %562, %603 ], [ %562, %613 ]
  %625 = phi %3 addrspace(1)* [ %563, %620 ], [ %612, %603 ], [ %615, %613 ]
  br i1 %600, label %626, label %1082

626:                                              ; preds = %622
  %627 = icmp sgt i32 %624, 0
  br i1 %627, label %560, label %628

628:                                              ; preds = %626
  %629 = add i32 %543, 2
  %630 = and i32 %629, -2
  %631 = icmp ne i32 %543, %54
  %632 = icmp ugt i32 %630, 15
  %633 = select i1 %631, i1 true, i1 %632
  br i1 %633, label %1082, label %634

634:                                              ; preds = %628
  br i1 %548, label %635, label %639

635:                                              ; preds = %634
  %636 = zext i32 %630 to i64
  %637 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 1, i64 %636, i32 0
  %638 = load atomic i32, i32 addrspace(1)* %637 syncscope("agent-one-as") monotonic, align 8
  br label %639

639:                                              ; preds = %635, %634
  %640 = phi i32 [ %638, %635 ], [ 0, %634 ]
  %641 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %640)
  %642 = icmp ult i32 %641, 65792
  br i1 %642, label %643, label %1082

643:                                              ; preds = %639
  %644 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br i1 %66, label %649, label %645

645:                                              ; preds = %643
  %646 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %647 = tail call i64 @llvm.ctpop.i64(i64 %646), !range !44
  %648 = trunc i64 %647 to i32
  br label %652

649:                                              ; preds = %643
  %650 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %651 = tail call i32 @llvm.ctpop.i32(i32 %650), !range !46
  br label %652

652:                                              ; preds = %649, %645
  %653 = phi i32 [ %648, %645 ], [ %651, %649 ]
  %654 = zext i32 %630 to i64
  %655 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 0, i64 %654, i32 0
  %656 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %654, i32 2
  %657 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 1, i64 %654, i32 0
  %658 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 2, i64 %654, i32 0
  %659 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 4, i64 %654, i32 0
  %660 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 3, i64 %654, i32 0
  %661 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %654, i32 5
  %662 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %654, i32 0
  %663 = lshr i64 191, %654
  %664 = and i64 %663, 1
  %665 = icmp eq i64 %664, 0
  %666 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %654, i32 4
  %667 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %654, i32 6
  %668 = icmp eq i32 %630, 2
  %669 = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 %630, i64 0
  br label %670

670:                                              ; preds = %1079, %652
  %671 = phi i32 [ %644, %652 ], [ %674, %1079 ]
  %672 = phi i32 [ %641, %652 ], [ %1080, %1079 ]
  %673 = phi %3 addrspace(1)* [ undef, %652 ], [ %1081, %1079 ]
  %674 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %671) #22, !srcloc !48
  %675 = icmp eq i32 %672, 0
  br i1 %675, label %754, label %676

676:                                              ; preds = %670
  %677 = icmp eq i32 %674, 0
  br i1 %677, label %678, label %680

678:                                              ; preds = %676
  %679 = load atomic i32, i32 addrspace(1)* %655 syncscope("agent-one-as") monotonic, align 8
  br label %680

680:                                              ; preds = %678, %676
  %681 = phi i32 [ %679, %678 ], [ 0, %676 ]
  %682 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %681)
  %683 = add i32 %682, %674
  %684 = urem i32 %683, %672
  %685 = load i32, i32 addrspace(4)* %656, align 4, !tbaa !49
  br label %686

686:                                              ; preds = %752, %680
  %687 = phi i32 [ %684, %680 ], [ %749, %752 ]
  %688 = phi i32 [ %672, %680 ], [ %750, %752 ]
  %689 = phi %3 addrspace(1)* [ %673, %680 ], [ %751, %752 ]
  %690 = icmp ugt i32 %687, 255
  br i1 %690, label %691, label %701

691:                                              ; preds = %686
  %692 = add i32 %687, -256
  %693 = lshr i32 %692, 8
  %694 = zext i32 %693 to i64
  %695 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %694, i32 0
  %696 = load atomic i64, i64 addrspace(1)* %695 syncscope("agent-one-as") monotonic, align 8
  %697 = inttoptr i64 %696 to %3 addrspace(1)*
  %698 = and i32 %687, 255
  %699 = zext i32 %698 to i64
  %700 = getelementptr inbounds %3, %3 addrspace(1)* %697, i64 %699
  br label %704

701:                                              ; preds = %686
  %702 = zext i32 %687 to i64
  %703 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %702
  br label %704

704:                                              ; preds = %701, %691
  %705 = phi %3 addrspace(1)* [ %700, %691 ], [ %703, %701 ]
  %706 = getelementptr inbounds %3, %3 addrspace(1)* %705, i64 0, i32 2
  %707 = load atomic i32, i32 addrspace(1)* %706 syncscope("agent-one-as") monotonic, align 8
  br i1 %66, label %714, label %708

708:                                              ; preds = %704
  %709 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %707, i32 %685, i32 36)
  %710 = icmp eq i64 %709, 0
  br i1 %710, label %723, label %711

711:                                              ; preds = %708
  %712 = tail call fastcc i64 @__ockl_ctz_u64(i64 noundef %709) #25
  %713 = trunc i64 %712 to i32
  br label %719

714:                                              ; preds = %704
  %715 = tail call i32 @llvm.amdgcn.icmp.i32.i32(i32 %707, i32 %685, i32 36)
  %716 = icmp eq i32 %715, 0
  br i1 %716, label %723, label %717

717:                                              ; preds = %714
  %718 = tail call fastcc i32 @__ockl_ctz_u32(i32 noundef %715) #25
  br label %719

719:                                              ; preds = %717, %711
  %720 = phi i32 [ %718, %717 ], [ %713, %711 ]
  %721 = shl i32 %720, 2
  %722 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %721, i32 %687)
  br label %723

723:                                              ; preds = %719, %714, %708
  %724 = phi i32 [ -1, %708 ], [ -1, %714 ], [ %722, %719 ]
  %725 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %724)
  %726 = icmp eq i32 %725, -1
  br i1 %726, label %742, label %727

727:                                              ; preds = %723
  %728 = icmp ugt i32 %725, 255
  br i1 %728, label %729, label %739

729:                                              ; preds = %727
  %730 = add i32 %725, -256
  %731 = lshr i32 %730, 8
  %732 = zext i32 %731 to i64
  %733 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %732, i32 0
  %734 = load atomic i64, i64 addrspace(1)* %733 syncscope("agent-one-as") monotonic, align 8
  %735 = inttoptr i64 %734 to %3 addrspace(1)*
  %736 = and i32 %725, 255
  %737 = zext i32 %736 to i64
  %738 = getelementptr inbounds %3, %3 addrspace(1)* %735, i64 %737
  br label %748

739:                                              ; preds = %727
  %740 = zext i32 %725 to i64
  %741 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %740
  br label %748

742:                                              ; preds = %723
  %743 = add i32 %687, %653
  %744 = urem i32 %743, %672
  br i1 %677, label %745, label %746

745:                                              ; preds = %742
  store atomic i32 %744, i32 addrspace(1)* %655 syncscope("agent-one-as") monotonic, align 8
  br label %746

746:                                              ; preds = %745, %742
  %747 = sub i32 %688, %653
  br label %748

748:                                              ; preds = %746, %739, %729
  %749 = phi i32 [ %744, %746 ], [ %687, %729 ], [ %687, %739 ]
  %750 = phi i32 [ %747, %746 ], [ %688, %729 ], [ %688, %739 ]
  %751 = phi %3 addrspace(1)* [ %689, %746 ], [ %738, %729 ], [ %741, %739 ]
  br i1 %726, label %752, label %1082

752:                                              ; preds = %748
  %753 = icmp sgt i32 %750, 0
  br i1 %753, label %686, label %754

754:                                              ; preds = %752, %670
  %755 = phi %3 addrspace(1)* [ %673, %670 ], [ %751, %752 ]
  %756 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br label %757

757:                                              ; preds = %1055, %754
  %758 = phi i32 [ %756, %754 ], [ %1057, %1055 ]
  %759 = phi %3 addrspace(1)* [ undef, %754 ], [ %1058, %1055 ]
  %760 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %758) #22, !srcloc !48
  %761 = icmp eq i32 %760, 0
  br i1 %761, label %762, label %764

762:                                              ; preds = %757
  %763 = load atomic i32, i32 addrspace(1)* %657 syncscope("agent-one-as") monotonic, align 8
  br label %764

764:                                              ; preds = %762, %757
  %765 = phi i32 [ %763, %762 ], [ 0, %757 ]
  %766 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %765)
  %767 = icmp eq i32 %766, 65792
  br i1 %767, label %1055, label %768

768:                                              ; preds = %764
  br i1 %761, label %769, label %774

769:                                              ; preds = %768
  %770 = cmpxchg i32 addrspace(1)* %658, i32 0, i32 256 syncscope("agent-one-as") monotonic monotonic, align 4
  %771 = extractvalue { i32, i1 } %770, 1
  %772 = extractvalue { i32, i1 } %770, 0
  %773 = select i1 %771, i32 256, i32 %772
  br label %774

774:                                              ; preds = %769, %768
  %775 = phi i32 [ %773, %769 ], [ 0, %768 ]
  %776 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %775)
  %777 = icmp eq i32 %766, %776
  br i1 %777, label %778, label %885

778:                                              ; preds = %774
  %779 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %780 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %779) #22, !srcloc !48
  %781 = icmp eq i32 %780, 0
  br i1 %781, label %782, label %784

782:                                              ; preds = %778
  %783 = load atomic i32, i32 addrspace(1)* %658 syncscope("agent-one-as") monotonic, align 8
  br label %784

784:                                              ; preds = %782, %778
  %785 = phi i32 [ %783, %782 ], [ 0, %778 ]
  %786 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %785)
  %787 = icmp eq i32 %786, 65792
  br i1 %787, label %866, label %788

788:                                              ; preds = %784
  br i1 %781, label %789, label %798

789:                                              ; preds = %788
  %790 = load atomic i64, i64 addrspace(1)* %659 syncscope("agent-one-as") monotonic, align 8
  %791 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %792 = sub i64 %791, %790
  %793 = icmp ugt i64 %792, 29999
  br i1 %793, label %794, label %798

794:                                              ; preds = %789
  %795 = cmpxchg i64 addrspace(1)* %659, i64 %790, i64 %791 syncscope("agent-one-as") monotonic monotonic, align 8
  %796 = extractvalue { i64, i1 } %795, 1
  %797 = select i1 %796, i32 2, i32 1
  br label %798

798:                                              ; preds = %794, %789, %788
  %799 = phi i32 [ 1, %788 ], [ 1, %789 ], [ %797, %794 ]
  %800 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %799)
  %801 = icmp eq i32 %800, 1
  br i1 %801, label %866, label %802

802:                                              ; preds = %798
  br i1 %781, label %803, label %805

803:                                              ; preds = %802
  %804 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef 0, i64 noundef 6144) #22
  br label %805

805:                                              ; preds = %803, %802
  %806 = phi i64 [ %804, %803 ], [ 0, %802 ]
  %807 = trunc i64 %806 to i32
  %808 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %807)
  %809 = insertelement <2 x i32> undef, i32 %808, i64 0
  %810 = lshr i64 %806, 32
  %811 = trunc i64 %810 to i32
  %812 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %811)
  %813 = insertelement <2 x i32> %809, i32 %812, i64 1
  %814 = bitcast <2 x i32> %813 to i64
  %815 = icmp eq i64 %814, 0
  br i1 %815, label %866, label %816

816:                                              ; preds = %805
  %817 = tail call fastcc i32 @__ockl_activelane_u32() #22
  br i1 %66, label %822, label %818

818:                                              ; preds = %816
  %819 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %820 = tail call i64 @llvm.ctpop.i64(i64 %819), !range !44
  %821 = trunc i64 %820 to i32
  br label %825

822:                                              ; preds = %816
  %823 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %824 = tail call i32 @llvm.ctpop.i32(i32 %823), !range !46
  br label %825

825:                                              ; preds = %822, %818
  %826 = phi i32 [ %821, %818 ], [ %824, %822 ]
  %827 = inttoptr i64 %814 to i64 addrspace(1)*
  %828 = icmp ult i32 %817, 768
  br i1 %828, label %829, label %835

829:                                              ; preds = %829, %825
  %830 = phi i32 [ %833, %829 ], [ %817, %825 ]
  %831 = zext i32 %830 to i64
  %832 = getelementptr inbounds i64, i64 addrspace(1)* %827, i64 %831
  store i64 0, i64 addrspace(1)* %832, align 8, !tbaa !21
  %833 = add i32 %830, %826
  %834 = icmp ult i32 %833, 768
  br i1 %834, label %829, label %835

835:                                              ; preds = %829, %825
  br label %836

836:                                              ; preds = %865, %835
  %837 = phi i32 [ %863, %865 ], [ %800, %835 ]
  %838 = phi i32 [ %846, %865 ], [ %786, %835 ]
  %839 = phi i32 [ %840, %865 ], [ %780, %835 ]
  %840 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %839) #22, !srcloc !48
  %841 = icmp eq i32 %840, 0
  br i1 %841, label %842, label %844

842:                                              ; preds = %836
  %843 = load atomic i32, i32 addrspace(1)* %658 syncscope("agent-one-as") monotonic, align 8
  br label %844

844:                                              ; preds = %842, %836
  %845 = phi i32 [ %843, %842 ], [ %838, %836 ]
  %846 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %845)
  %847 = icmp eq i32 %846, 65792
  br i1 %847, label %848, label %851

848:                                              ; preds = %844
  br i1 %841, label %849, label %866

849:                                              ; preds = %848
  %850 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef %814, i64 noundef 0) #22
  br label %866

851:                                              ; preds = %844
  br i1 %841, label %852, label %861

852:                                              ; preds = %851
  %853 = add i32 %846, -256
  %854 = lshr i32 %853, 8
  %855 = zext i32 %854 to i64
  %856 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %855, i32 0
  %857 = cmpxchg i64 addrspace(1)* %856, i64 0, i64 %814 syncscope("agent-one-as") monotonic monotonic, align 8
  %858 = extractvalue { i64, i1 } %857, 1
  br i1 %858, label %859, label %861

859:                                              ; preds = %852
  %860 = atomicrmw add i32 addrspace(1)* %658, i32 256 syncscope("agent-one-as") release, align 4
  br label %861

861:                                              ; preds = %859, %852, %851
  %862 = phi i32 [ %837, %851 ], [ 0, %859 ], [ %837, %852 ]
  %863 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %862)
  %864 = icmp eq i32 %863, 0
  br i1 %864, label %866, label %865

865:                                              ; preds = %861
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %836

866:                                              ; preds = %861, %849, %848, %805, %798, %784
  %867 = phi i32 [ 2, %784 ], [ 1, %798 ], [ %800, %805 ], [ %837, %849 ], [ %837, %848 ], [ 0, %861 ]
  %868 = icmp eq i32 %867, 0
  br i1 %868, label %883, label %869

869:                                              ; preds = %866
  %870 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %871 = icmp eq i32 %870, 0
  br i1 %871, label %872, label %880

872:                                              ; preds = %869
  %873 = load atomic i64, i64 addrspace(1)* %659 syncscope("agent-one-as") monotonic, align 8
  %874 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %875 = sub i64 %874, %873
  %876 = icmp ult i64 %875, 30000
  br i1 %876, label %877, label %880

877:                                              ; preds = %872
  %878 = trunc i64 %875 to i32
  %879 = sub nuw nsw i32 30000, %878
  tail call fastcc void @__ockl_rtcwait_u32(i32 noundef %879) #22
  br label %880

880:                                              ; preds = %877, %872, %869
  %881 = icmp eq i32 %867, 2
  %882 = select i1 %881, %3 addrspace(1)* null, %3 addrspace(1)* inttoptr (i64 1 to %3 addrspace(1)*)
  br label %883

883:                                              ; preds = %880, %866
  %884 = phi %3 addrspace(1)* [ %882, %880 ], [ %759, %866 ]
  br i1 %868, label %885, label %1055

885:                                              ; preds = %883, %774
  %886 = phi %3 addrspace(1)* [ %884, %883 ], [ %759, %774 ]
  br i1 %761, label %887, label %896

887:                                              ; preds = %885
  %888 = load atomic i64, i64 addrspace(1)* %660 syncscope("agent-one-as") monotonic, align 8
  %889 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %890 = sub i64 %889, %888
  %891 = icmp ugt i64 %890, 19999
  br i1 %891, label %892, label %896

892:                                              ; preds = %887
  %893 = cmpxchg i64 addrspace(1)* %660, i64 %888, i64 %889 syncscope("agent-one-as") monotonic monotonic, align 8
  %894 = extractvalue { i64, i1 } %893, 1
  %895 = select i1 %894, i8 addrspace(1)* null, i8 addrspace(1)* inttoptr (i64 1 to i8 addrspace(1)*)
  br label %896

896:                                              ; preds = %892, %887, %885
  %897 = phi i8 addrspace(1)* [ inttoptr (i64 1 to i8 addrspace(1)*), %885 ], [ inttoptr (i64 1 to i8 addrspace(1)*), %887 ], [ %895, %892 ]
  %898 = ptrtoint i8 addrspace(1)* %897 to i64
  %899 = trunc i64 %898 to i32
  %900 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %899)
  %901 = insertelement <2 x i32> undef, i32 %900, i64 0
  %902 = lshr i64 %898, 32
  %903 = trunc i64 %902 to i32
  %904 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %903)
  %905 = insertelement <2 x i32> %901, i32 %904, i64 1
  %906 = bitcast <2 x i32> %905 to i64
  %907 = icmp eq i64 %906, 0
  br i1 %907, label %910, label %908

908:                                              ; preds = %896
  %909 = inttoptr i64 %906 to %3 addrspace(1)*
  br label %1055

910:                                              ; preds = %896
  br i1 %761, label %911, label %920

911:                                              ; preds = %910
  %912 = load atomic i64, i64 addrspace(1)* %67 syncscope("agent-one-as") monotonic, align 8
  %913 = load i64, i64 addrspace(1)* %68, align 8, !tbaa !51
  %914 = icmp ult i64 %912, %913
  br i1 %914, label %915, label %918

915:                                              ; preds = %911
  %916 = atomicrmw add i64 addrspace(1)* %67, i64 2097152 syncscope("agent-one-as") monotonic, align 8
  %917 = icmp ult i64 %916, %913
  br i1 %917, label %920, label %918

918:                                              ; preds = %915, %911
  %919 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef 0, i64 noundef 2097152) #22
  br label %920

920:                                              ; preds = %918, %915, %910
  %921 = phi i64 [ 0, %910 ], [ %919, %918 ], [ %916, %915 ]
  %922 = trunc i64 %921 to i32
  %923 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %922)
  %924 = insertelement <2 x i32> undef, i32 %923, i64 0
  %925 = lshr i64 %921, 32
  %926 = trunc i64 %925 to i32
  %927 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %926)
  %928 = insertelement <2 x i32> %924, i32 %927, i64 1
  %929 = bitcast <2 x i32> %928 to i64
  %930 = icmp eq i64 %929, 0
  br i1 %930, label %1055, label %931

931:                                              ; preds = %920
  %932 = inttoptr i64 %929 to %13 addrspace(1)*
  %933 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %934 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %933) #22, !srcloc !48
  br i1 %66, label %939, label %935

935:                                              ; preds = %931
  %936 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %937 = tail call i64 @llvm.ctpop.i64(i64 %936), !range !44
  %938 = trunc i64 %937 to i32
  br label %942

939:                                              ; preds = %931
  %940 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %941 = tail call i32 @llvm.ctpop.i32(i32 %940), !range !46
  br label %942

942:                                              ; preds = %939, %935
  %943 = phi i32 [ %938, %935 ], [ %941, %939 ]
  %944 = load i32, i32 addrspace(4)* %661, align 4, !tbaa !53
  %945 = load i32, i32 addrspace(4)* %662, align 4, !tbaa !54
  %946 = add i32 %945, 31
  %947 = lshr i32 %946, 5
  br i1 %665, label %971, label %948

948:                                              ; preds = %942
  %949 = icmp ult i32 %934, %947
  br i1 %949, label %956, label %950

950:                                              ; preds = %956, %948
  %951 = mul i32 %944, %943
  %952 = load i32, i32 addrspace(4)* %666, align 4, !tbaa !55
  %953 = mul i32 %944, %934
  %954 = add i32 %952, %953
  %955 = icmp ult i32 %954, %945
  br i1 %955, label %962, label %980

956:                                              ; preds = %956, %948
  %957 = phi i32 [ %960, %956 ], [ %934, %948 ]
  %958 = zext i32 %957 to i64
  %959 = getelementptr inbounds %13, %13 addrspace(1)* %932, i64 0, i32 4, i64 %958
  store i32 0, i32 addrspace(1)* %959, align 4, !tbaa !17
  %960 = add i32 %957, %943
  %961 = icmp ult i32 %960, %947
  br i1 %961, label %956, label %950

962:                                              ; preds = %962, %950
  %963 = phi i32 [ %969, %962 ], [ %954, %950 ]
  %964 = and i32 %963, 31
  %965 = shl nuw i32 1, %964
  %966 = lshr i32 %963, 5
  %967 = zext i32 %966 to i64
  %968 = getelementptr inbounds %13, %13 addrspace(1)* %932, i64 0, i32 4, i64 %967
  store i32 %965, i32 addrspace(1)* %968, align 4, !tbaa !17
  %969 = add i32 %963, %951
  %970 = icmp ult i32 %969, %945
  br i1 %970, label %962, label %980

971:                                              ; preds = %942
  %972 = load i32, i32 addrspace(4)* %667, align 4, !tbaa !56
  %973 = icmp ult i32 %934, %947
  br i1 %973, label %974, label %980

974:                                              ; preds = %974, %971
  %975 = phi i32 [ %978, %974 ], [ %934, %971 ]
  %976 = zext i32 %975 to i64
  %977 = getelementptr inbounds %13, %13 addrspace(1)* %932, i64 0, i32 4, i64 %976
  store i32 %972, i32 addrspace(1)* %977, align 4, !tbaa !17
  %978 = add i32 %975, %943
  %979 = icmp ult i32 %978, %947
  br i1 %979, label %974, label %980

980:                                              ; preds = %974, %971, %962, %950
  %981 = icmp eq i32 %934, 0
  br i1 %981, label %982, label %993

982:                                              ; preds = %980
  br i1 %668, label %991, label %983

983:                                              ; preds = %982
  %984 = add nsw i32 %947, -1
  %985 = zext i32 %984 to i64
  %986 = getelementptr inbounds %13, %13 addrspace(1)* %932, i64 0, i32 4, i64 %985
  %987 = and i32 %945, 31
  %988 = shl nsw i32 -1, %987
  %989 = load i32, i32 addrspace(1)* %986, align 4, !tbaa !17
  %990 = or i32 %989, %988
  store i32 %990, i32 addrspace(1)* %986, align 4, !tbaa !17
  br label %991

991:                                              ; preds = %983, %982
  %992 = inttoptr i64 %929 to <4 x i32> addrspace(1)*
  store <4 x i32> %669, <4 x i32> addrspace(1)* %992, align 16, !tbaa !30
  br label %993

993:                                              ; preds = %991, %980
  %994 = getelementptr inbounds %13, %13 addrspace(1)* %932, i64 0, i32 1
  br label %995

995:                                              ; preds = %1054, %993
  %996 = phi i32 [ %776, %993 ], [ %1012, %1054 ]
  %997 = phi i32 [ %766, %993 ], [ %1005, %1054 ]
  %998 = phi i32 [ %760, %993 ], [ %999, %1054 ]
  %999 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %998) #22, !srcloc !48
  %1000 = icmp eq i32 %999, 0
  br i1 %1000, label %1001, label %1003

1001:                                             ; preds = %995
  %1002 = load atomic i32, i32 addrspace(1)* %657 syncscope("agent-one-as") monotonic, align 8
  br label %1003

1003:                                             ; preds = %1001, %995
  %1004 = phi i32 [ %1002, %1001 ], [ %997, %995 ]
  %1005 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1004)
  %1006 = icmp eq i32 %1005, 65792
  br i1 %1006, label %1055, label %1007

1007:                                             ; preds = %1003
  br i1 %1000, label %1008, label %1010

1008:                                             ; preds = %1007
  %1009 = load atomic i32, i32 addrspace(1)* %658 syncscope("agent-one-as") monotonic, align 8
  br label %1010

1010:                                             ; preds = %1008, %1007
  %1011 = phi i32 [ %1009, %1008 ], [ %996, %1007 ]
  %1012 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1011)
  %1013 = icmp eq i32 %1005, %1012
  br i1 %1013, label %1014, label %1017

1014:                                             ; preds = %1010
  br i1 %1000, label %1015, label %1055

1015:                                             ; preds = %1014
  %1016 = tail call fastcc i64 @__ockl_devmem_request(i64 noundef %929, i64 noundef 0) #22
  br label %1055

1017:                                             ; preds = %1010
  br i1 %1000, label %1018, label %1040

1018:                                             ; preds = %1017
  %1019 = icmp ugt i32 %1005, 255
  br i1 %1019, label %1020, label %1030

1020:                                             ; preds = %1018
  %1021 = add i32 %1005, -256
  %1022 = lshr i32 %1021, 8
  %1023 = zext i32 %1022 to i64
  %1024 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %1023, i32 0
  %1025 = load atomic i64, i64 addrspace(1)* %1024 syncscope("agent-one-as") monotonic, align 8
  %1026 = inttoptr i64 %1025 to %3 addrspace(1)*
  %1027 = and i32 %1005, 255
  %1028 = zext i32 %1027 to i64
  %1029 = getelementptr inbounds %3, %3 addrspace(1)* %1026, i64 %1028
  br label %1033

1030:                                             ; preds = %1018
  %1031 = zext i32 %1005 to i64
  %1032 = getelementptr inbounds %0, %0 addrspace(1)* %64, i64 0, i32 5, i64 %654, i64 %1031
  br label %1033

1033:                                             ; preds = %1030, %1020
  %1034 = phi %3 addrspace(1)* [ %1029, %1020 ], [ %1032, %1030 ]
  store i32 %1005, i32 addrspace(1)* %994, align 4, !tbaa !57
  %1035 = getelementptr inbounds %3, %3 addrspace(1)* %1034, i64 0, i32 1
  %1036 = cmpxchg i64 addrspace(1)* %1035, i64 0, i64 %929 syncscope("agent-one-as") monotonic monotonic, align 8
  %1037 = extractvalue { i64, i1 } %1036, 1
  br i1 %1037, label %1038, label %1040

1038:                                             ; preds = %1033
  %1039 = atomicrmw add i32 addrspace(1)* %657, i32 1 syncscope("agent-one-as") release, align 4
  br label %1040

1040:                                             ; preds = %1038, %1033, %1017
  %1041 = phi %3 addrspace(1)* [ null, %1017 ], [ %1034, %1038 ], [ null, %1033 ]
  %1042 = ptrtoint %3 addrspace(1)* %1041 to i64
  %1043 = trunc i64 %1042 to i32
  %1044 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1043)
  %1045 = insertelement <2 x i32> undef, i32 %1044, i64 0
  %1046 = lshr i64 %1042, 32
  %1047 = trunc i64 %1046 to i32
  %1048 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1047)
  %1049 = insertelement <2 x i32> %1045, i32 %1048, i64 1
  %1050 = bitcast <2 x i32> %1049 to i64
  %1051 = icmp eq i64 %1050, 0
  br i1 %1051, label %1054, label %1052

1052:                                             ; preds = %1040
  %1053 = inttoptr i64 %1050 to %3 addrspace(1)*
  br label %1055

1054:                                             ; preds = %1040
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %995

1055:                                             ; preds = %1052, %1015, %1014, %1003, %920, %908, %883, %764
  %1056 = phi i1 [ false, %908 ], [ true, %1015 ], [ true, %1014 ], [ false, %920 ], [ false, %1052 ], [ false, %764 ], [ false, %883 ], [ false, %1003 ]
  %1057 = phi i32 [ %760, %908 ], [ 0, %1015 ], [ %999, %1014 ], [ %760, %920 ], [ %999, %1052 ], [ %760, %764 ], [ %760, %883 ], [ %999, %1003 ]
  %1058 = phi %3 addrspace(1)* [ %909, %908 ], [ %886, %1015 ], [ %886, %1014 ], [ null, %920 ], [ %1053, %1052 ], [ null, %764 ], [ %884, %883 ], [ null, %1003 ]
  br i1 %1056, label %757, label %1059

1059:                                             ; preds = %1055
  %1060 = icmp eq %3 addrspace(1)* %1058, inttoptr (i64 1 to %3 addrspace(1)*)
  br i1 %1060, label %1061, label %1079

1061:                                             ; preds = %1059
  %1062 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %1063 = icmp eq i32 %1062, 0
  br i1 %1063, label %1064, label %1072

1064:                                             ; preds = %1061
  %1065 = load atomic i64, i64 addrspace(1)* %660 syncscope("agent-one-as") monotonic, align 8
  %1066 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %1067 = sub i64 %1066, %1065
  %1068 = icmp ult i64 %1067, 20000
  br i1 %1068, label %1069, label %1072

1069:                                             ; preds = %1064
  %1070 = trunc i64 %1067 to i32
  %1071 = sub nuw nsw i32 20000, %1070
  tail call fastcc void @__ockl_rtcwait_u32(i32 noundef %1071) #22
  br label %1072

1072:                                             ; preds = %1069, %1064, %1061
  %1073 = icmp eq i32 %674, 0
  br i1 %1073, label %1074, label %1076

1074:                                             ; preds = %1072
  %1075 = load atomic i32, i32 addrspace(1)* %657 syncscope("agent-one-as") monotonic, align 8
  br label %1076

1076:                                             ; preds = %1074, %1072
  %1077 = phi i32 [ %1075, %1074 ], [ %672, %1072 ]
  %1078 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1077)
  br label %1079

1079:                                             ; preds = %1076, %1059
  %1080 = phi i32 [ %1078, %1076 ], [ %672, %1059 ]
  %1081 = phi %3 addrspace(1)* [ %755, %1076 ], [ %1058, %1059 ]
  br i1 %1060, label %670, label %1082

1082:                                             ; preds = %1079, %748, %639, %628, %622
  %1083 = phi i1 [ false, %628 ], [ true, %639 ], [ false, %748 ], [ false, %1079 ], [ false, %622 ]
  %1084 = phi i32 [ %543, %628 ], [ %630, %639 ], [ %54, %748 ], [ %54, %1079 ], [ %543, %622 ]
  %1085 = phi %3 addrspace(1)* [ null, %628 ], [ %625, %639 ], [ %751, %748 ], [ %1081, %1079 ], [ %625, %622 ]
  br i1 %1083, label %542, label %1086

1086:                                             ; preds = %1082, %529, %198
  %1087 = phi %3 addrspace(1)* [ %201, %198 ], [ %531, %529 ], [ %1085, %1082 ]
  %1088 = ptrtoint %3 addrspace(1)* %1087 to i64
  %1089 = trunc i64 %1088 to i32
  %1090 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1089)
  %1091 = insertelement <2 x i32> undef, i32 %1090, i64 0
  %1092 = lshr i64 %1088, 32
  %1093 = trunc i64 %1092 to i32
  %1094 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1093)
  %1095 = insertelement <2 x i32> %1091, i32 %1094, i64 1
  %1096 = bitcast <2 x i32> %1095 to i64
  %1097 = icmp eq i64 %1096, 0
  br i1 %1097, label %1206, label %1098

1098:                                             ; preds = %1086
  %1099 = inttoptr i64 %1096 to %3 addrspace(1)*
  %1100 = tail call fastcc i32 @__ockl_activelane_u32() #22
  %1101 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %1100) #22, !srcloc !48
  br i1 %66, label %1106, label %1102

1102:                                             ; preds = %1098
  %1103 = tail call i64 @llvm.read_register.i64(metadata !35) #24
  %1104 = tail call i64 @llvm.ctpop.i64(i64 %1103), !range !44
  %1105 = trunc i64 %1104 to i32
  br label %1109

1106:                                             ; preds = %1098
  %1107 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %1108 = tail call i32 @llvm.ctpop.i32(i32 %1107), !range !46
  br label %1109

1109:                                             ; preds = %1106, %1102
  %1110 = phi i32 [ %1105, %1102 ], [ %1108, %1106 ]
  %1111 = getelementptr inbounds %3, %3 addrspace(1)* %1099, i64 0, i32 1
  %1112 = load atomic i64, i64 addrspace(1)* %1111 seq_cst, align 8, !tbaa !60
  %1113 = inttoptr i64 %1112 to %13 addrspace(1)*
  %1114 = getelementptr inbounds %13, %13 addrspace(1)* %1113, i64 0, i32 0
  %1115 = load i32, i32 addrspace(1)* %1114, align 4, !tbaa !62
  %1116 = icmp eq i32 %1101, 0
  br i1 %1116, label %1117, label %1120

1117:                                             ; preds = %1109
  %1118 = getelementptr inbounds %13, %13 addrspace(1)* %1113, i64 0, i32 2
  %1119 = atomicrmw add i32 addrspace(1)* %1118, i32 %1110 syncscope("agent-one-as") monotonic, align 4
  br label %1120

1120:                                             ; preds = %1117, %1109
  %1121 = phi i32 [ %1119, %1117 ], [ 0, %1109 ]
  %1122 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1121)
  %1123 = zext i32 %1115 to i64
  %1124 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %1123, i32 0
  %1125 = load i32, i32 addrspace(4)* %1124, align 4, !tbaa !54
  %1126 = add i32 %1125, 31
  %1127 = lshr i32 %1126, 5
  %1128 = icmp ult i32 %1126, 32
  br i1 %1128, label %1188, label %1129

1129:                                             ; preds = %1120
  %1130 = add i32 %1122, %1101
  %1131 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %1123, i32 7
  %1132 = load i32, i32 addrspace(4)* %1131, align 4, !tbaa !63
  %1133 = mul i32 %1132, %1130
  %1134 = urem i32 %1133, %1125
  %1135 = lshr i32 %1134, 5
  %1136 = inttoptr i64 %1112 to i8 addrspace(1)*
  %1137 = getelementptr inbounds [16 x %4], [16 x %4] addrspace(4)* @1, i64 0, i64 %1123, i32 3
  %1138 = lshr i32 %1115, 1
  %1139 = add nuw i32 %1138, 4
  %1140 = and i32 %1139, 31
  %1141 = shl nuw i32 1, %1140
  %1142 = and i32 %1115, 1
  %1143 = icmp eq i32 %1142, 0
  %1144 = lshr i32 %1141, 1
  %1145 = select i1 %1143, i32 0, i32 %1144
  %1146 = add nuw i32 %1145, %1141
  %1147 = tail call i32 @llvm.umax.i32(i32 %1127, i32 1)
  br label %1148

1148:                                             ; preds = %1180, %1129
  %1149 = phi i32 [ %1135, %1129 ], [ %1183, %1180 ]
  %1150 = phi i8 addrspace(1)* [ null, %1129 ], [ %1182, %1180 ]
  %1151 = phi i32 [ 0, %1129 ], [ %1185, %1180 ]
  %1152 = zext i32 %1149 to i64
  %1153 = getelementptr inbounds %13, %13 addrspace(1)* %1113, i64 0, i32 4, i64 %1152
  %1154 = load atomic i32, i32 addrspace(1)* %1153 syncscope("agent-one-as") monotonic, align 4
  %1155 = icmp eq i32 %1154, -1
  br i1 %1155, label %1176, label %1156

1156:                                             ; preds = %1148
  %1157 = xor i32 %1154, -1
  %1158 = tail call fastcc i32 @__ockl_ctz_u32(i32 noundef %1157) #25
  %1159 = and i32 %1158, 31
  %1160 = shl nuw i32 1, %1159
  %1161 = atomicrmw or i32 addrspace(1)* %1153, i32 %1160 syncscope("agent-one-as") monotonic, align 4
  %1162 = and i32 %1160, %1161
  %1163 = icmp eq i32 %1162, 0
  br i1 %1163, label %1164, label %1173

1164:                                             ; preds = %1156
  %1165 = shl i32 %1149, 5
  %1166 = add i32 %1158, %1165
  %1167 = mul i32 %1166, %1146
  %1168 = zext i32 %1167 to i64
  %1169 = load i32, i32 addrspace(4)* %1137, align 4, !tbaa !64
  %1170 = zext i32 %1169 to i64
  %1171 = getelementptr inbounds i8, i8 addrspace(1)* %1136, i64 %1170
  %1172 = getelementptr inbounds i8, i8 addrspace(1)* %1171, i64 %1168
  br label %1173

1173:                                             ; preds = %1164, %1156
  %1174 = phi i32 [ 2, %1164 ], [ 0, %1156 ]
  %1175 = phi i8 addrspace(1)* [ %1172, %1164 ], [ %1150, %1156 ]
  br i1 %1163, label %1180, label %1176

1176:                                             ; preds = %1173, %1148
  %1177 = phi i8 addrspace(1)* [ %1175, %1173 ], [ %1150, %1148 ]
  %1178 = add i32 %1149, 1
  %1179 = urem i32 %1178, %1127
  br label %1180

1180:                                             ; preds = %1176, %1173
  %1181 = phi i32 [ 0, %1176 ], [ %1174, %1173 ]
  %1182 = phi i8 addrspace(1)* [ %1177, %1176 ], [ %1175, %1173 ]
  %1183 = phi i32 [ %1179, %1176 ], [ %1149, %1173 ]
  %1184 = icmp ne i32 %1181, 0
  %1185 = add nuw nsw i32 %1151, 1
  %1186 = icmp eq i32 %1185, %1147
  %1187 = select i1 %1184, i1 true, i1 %1186
  br i1 %1187, label %1188, label %1148

1188:                                             ; preds = %1180, %1120
  %1189 = phi i8 addrspace(1)* [ null, %1120 ], [ %1182, %1180 ]
  %1190 = ptrtoint i8 addrspace(1)* %1189 to i64
  br i1 %66, label %1195, label %1191

1191:                                             ; preds = %1188
  %1192 = tail call i64 @llvm.amdgcn.icmp.i64.i64(i64 noundef %1190, i64 noundef 0, i32 noundef 33) #25
  %1193 = tail call i64 @llvm.ctpop.i64(i64 %1192), !range !44
  %1194 = trunc i64 %1193 to i32
  br label %1198

1195:                                             ; preds = %1188
  %1196 = tail call i32 @llvm.amdgcn.icmp.i32.i64(i64 noundef %1190, i64 noundef 0, i32 noundef 33) #25
  %1197 = tail call i32 @llvm.ctpop.i32(i32 %1196), !range !46
  br label %1198

1198:                                             ; preds = %1195, %1191
  %1199 = phi i32 [ %1194, %1191 ], [ %1197, %1195 ]
  br i1 %1116, label %1200, label %1203

1200:                                             ; preds = %1198
  %1201 = getelementptr inbounds %3, %3 addrspace(1)* %1099, i64 0, i32 2
  %1202 = atomicrmw add i32 addrspace(1)* %1201, i32 %1199 syncscope("agent-one-as") monotonic, align 4
  br label %1203

1203:                                             ; preds = %1200, %1198
  %1204 = icmp eq i8 addrspace(1)* %1189, null
  br i1 %1204, label %1206, label %1205

1205:                                             ; preds = %1203
  br label %1206

1206:                                             ; preds = %1205, %1203, %1086, %93
  %1207 = phi i32 [ %94, %93 ], [ 0, %1205 ], [ %94, %1203 ], [ 0, %1086 ]
  %1208 = phi i32 [ 0, %93 ], [ 0, %1205 ], [ %97, %1203 ], [ 0, %1086 ]
  %1209 = phi i8 addrspace(1)* [ %96, %93 ], [ %1189, %1205 ], [ null, %1203 ], [ %96, %1086 ]
  %1210 = tail call fastcc zeroext i1 @__ockl_wfany_i32(i32 noundef %1208) #22
  br i1 %1210, label %93, label %1211

1211:                                             ; preds = %1206, %90, %85
  %1212 = phi i32 [ 0, %85 ], [ %88, %90 ], [ %1207, %1206 ]
  %1213 = phi i8 addrspace(1)* [ %87, %85 ], [ %87, %90 ], [ %1209, %1206 ]
  %1214 = tail call fastcc zeroext i1 @__ockl_wfany_i32(i32 noundef %1212) #22
  br i1 %1214, label %85, label %1215

1215:                                             ; preds = %1211, %36, %1
  %1216 = phi i8 addrspace(1)* [ %37, %36 ], [ null, %1 ], [ %1213, %1211 ]
  ret i8 addrspace(1)* %1216
}

; Function Attrs: alwaysinline convergent mustprogress nofree norecurse nounwind readonly willreturn
define internal fastcc i32 @__ockl_activelane_u32() unnamed_addr #17 {
  %1 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1, !tbaa !31, !range !33
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %8, label %3

3:                                                ; preds = %0
  %4 = tail call i32 @llvm.read_register.i32(metadata !65) #24
  %5 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %6 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %5, i32 0)
  %7 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %4, i32 %6)
  br label %11

8:                                                ; preds = %0
  %9 = tail call i32 @llvm.read_register.i32(metadata !45) #24
  %10 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %9, i32 0)
  br label %11

11:                                               ; preds = %8, %3
  %12 = phi i32 [ %7, %3 ], [ %10, %8 ]
  ret i32 %12
}

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #18

; Function Attrs: alwaysinline nounwind readonly
declare i32 @llvm.read_register.i32(metadata) #14

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #18

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umax.i32(i32, i32) #18

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn
define internal fastcc i32 @__ockl_clz_u32(i32 noundef %0) unnamed_addr #19 {
  %2 = tail call i32 @llvm.ctlz.i32(i32 %0, i1 false), !range !46
  ret i32 %2
}

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i64 @llvm.amdgcn.icmp.i64.i32(i32, i32, i32 immarg) #7

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn
define internal fastcc i64 @__ockl_ctz_u64(i64 noundef %0) unnamed_addr #19 {
  %2 = tail call i64 @llvm.cttz.i64(i64 %0, i1 false), !range !44
  ret i64 %2
}

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.icmp.i32.i32(i32, i32, i32 immarg) #7

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn
define internal fastcc i32 @__ockl_ctz_u32(i32 noundef %0) unnamed_addr #19 {
  %2 = tail call i32 @llvm.cttz.i32(i32 %0, i1 false), !range !46
  ret i32 %2
}

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.ds.bpermute(i32, i32) #7

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc i64 @__ockl_steadyctr_u64() unnamed_addr #6 {
  %1 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !17
  %2 = icmp sgt i32 %1, 10999
  br i1 %2, label %3, label %5

3:                                                ; preds = %0
  %4 = tail call fastcc i64 @10()
  br label %7

5:                                                ; preds = %0
  %6 = tail call fastcc i64 @11()
  br label %7

7:                                                ; preds = %5, %3
  %8 = phi i64 [ %4, %3 ], [ %6, %5 ]
  ret i64 %8
}

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc void @__ockl_rtcwait_u32(i32 noundef %0) unnamed_addr #6 {
  %2 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %3 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %0)
  %4 = sext i32 %3 to i64
  %5 = add i64 %2, %4
  %6 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !17
  %7 = icmp sgt i32 %6, 8999
  br i1 %7, label %8, label %31

8:                                                ; preds = %1
  %9 = add i64 %2, 1625
  %10 = icmp ugt i64 %5, %9
  br i1 %10, label %15, label %11

11:                                               ; preds = %15, %8
  %12 = phi i64 [ %2, %8 ], [ %16, %15 ]
  %13 = add i64 %12, 806
  %14 = icmp ugt i64 %5, %13
  br i1 %14, label %23, label %19

15:                                               ; preds = %15, %8
  tail call void @llvm.amdgcn.s.sleep(i32 127)
  %16 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %17 = add i64 %16, 1625
  %18 = icmp ugt i64 %5, %17
  br i1 %18, label %15, label %11

19:                                               ; preds = %23, %11
  %20 = phi i64 [ %12, %11 ], [ %24, %23 ]
  %21 = add i64 %20, 396
  %22 = icmp ugt i64 %5, %21
  br i1 %22, label %27, label %31

23:                                               ; preds = %23, %11
  tail call void @llvm.amdgcn.s.sleep(i32 63)
  %24 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %25 = add i64 %24, 806
  %26 = icmp ugt i64 %5, %25
  br i1 %26, label %23, label %19

27:                                               ; preds = %27, %19
  tail call void @llvm.amdgcn.s.sleep(i32 31)
  %28 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %29 = add i64 %28, 396
  %30 = icmp ugt i64 %5, %29
  br i1 %30, label %27, label %31

31:                                               ; preds = %27, %19, %1
  %32 = phi i64 [ %2, %1 ], [ %20, %19 ], [ %28, %27 ]
  %33 = add i64 %32, 192
  %34 = icmp ugt i64 %5, %33
  br i1 %34, label %39, label %35

35:                                               ; preds = %39, %31
  %36 = phi i64 [ %32, %31 ], [ %40, %39 ]
  %37 = add i64 %36, 89
  %38 = icmp ugt i64 %5, %37
  br i1 %38, label %47, label %43

39:                                               ; preds = %39, %31
  tail call void @llvm.amdgcn.s.sleep(i32 15)
  %40 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %41 = add i64 %40, 192
  %42 = icmp ugt i64 %5, %41
  br i1 %42, label %39, label %35

43:                                               ; preds = %47, %35
  %44 = phi i64 [ %36, %35 ], [ %48, %47 ]
  %45 = add i64 %44, 38
  %46 = icmp ugt i64 %5, %45
  br i1 %46, label %54, label %51

47:                                               ; preds = %47, %35
  tail call void @llvm.amdgcn.s.sleep(i32 7)
  %48 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %49 = add i64 %48, 89
  %50 = icmp ugt i64 %5, %49
  br i1 %50, label %47, label %43

51:                                               ; preds = %54, %43
  %52 = phi i64 [ %44, %43 ], [ %55, %54 ]
  %53 = icmp ugt i64 %5, %52
  br i1 %53, label %58, label %61

54:                                               ; preds = %54, %43
  tail call void @llvm.amdgcn.s.sleep(i32 3)
  %55 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %56 = add i64 %55, 38
  %57 = icmp ugt i64 %5, %56
  br i1 %57, label %54, label %51

58:                                               ; preds = %58, %51
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  %59 = tail call fastcc i64 @__ockl_steadyctr_u64() #22
  %60 = icmp ugt i64 %5, %59
  br i1 %60, label %58, label %61

61:                                               ; preds = %58, %51
  ret void
}

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i64 @llvm.amdgcn.icmp.i64.i64(i64, i64, i32 immarg) #7

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.icmp.i32.i64(i64, i64, i32 immarg) #7

; Function Attrs: alwaysinline convergent norecurse nounwind
define internal fastcc zeroext i1 @__ockl_wfany_i32(i32 noundef %0) unnamed_addr #6 {
  %2 = tail call i32 asm sideeffect "; ockl ballot hoisting hack $0", "=v,0"(i32 %0) #22, !srcloc !66
  %3 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1, !tbaa !31, !range !33
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 noundef %2, i32 noundef 0, i32 noundef 33) #25
  %7 = icmp ne i64 %6, 0
  br label %11

8:                                                ; preds = %1
  %9 = tail call i32 @llvm.amdgcn.icmp.i32.i32(i32 noundef %2, i32 noundef 0, i32 noundef 33) #25
  %10 = icmp ne i32 %9, 0
  br label %11

11:                                               ; preds = %8, %5
  %12 = phi i1 [ %7, %5 ], [ %10, %8 ]
  ret i1 %12
}

; Function Attrs: alwaysinline norecurse nounwind
define internal fastcc i64 @10() unnamed_addr #20 {
  %1 = tail call i64 @llvm.amdgcn.s.sendmsg.rtn.i64(i32 131)
  ret i64 %1
}

; Function Attrs: alwaysinline mustprogress norecurse nounwind willreturn
define internal fastcc i64 @11() unnamed_addr #21 {
  %1 = tail call i64 @llvm.amdgcn.s.memrealtime()
  ret i64 %1
}

; Function Attrs: alwaysinline nounwind willreturn
declare i64 @llvm.amdgcn.s.memrealtime() #11

; Function Attrs: alwaysinline nounwind
declare i64 @llvm.amdgcn.s.sendmsg.rtn.i64(i32 immarg) #13

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.cttz.i32(i32, i1 immarg) #18

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.cttz.i64(i64, i1 immarg) #18

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #18

attributes #0 = { "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #1 = { alwaysinline convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { alwaysinline nounwind readnone speculatable willreturn }
attributes #3 = { convergent noinline norecurse nounwind optnone "frame-pointer"="none" "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #4 = { alwaysinline argmemonly nofree nosync nounwind willreturn }
attributes #5 = { alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { alwaysinline convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #7 = { alwaysinline convergent nounwind readnone willreturn }
attributes #8 = { alwaysinline argmemonly mustprogress nofree norecurse nosync nounwind readonly willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #9 = { alwaysinline convergent mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { alwaysinline norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #11 = { alwaysinline nounwind willreturn }
attributes #12 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #13 = { alwaysinline nounwind }
attributes #14 = { alwaysinline nounwind readonly }
attributes #15 = { alwaysinline nounwind readnone willreturn }
attributes #16 = { convergent noinline norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #17 = { alwaysinline convergent mustprogress nofree norecurse nounwind readonly willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #18 = { alwaysinline nofree nosync nounwind readnone speculatable willreturn }
attributes #19 = { alwaysinline mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #20 = { alwaysinline norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+gfx11-insts" }
attributes #21 = { alwaysinline mustprogress norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+s-memrealtime" }
attributes #22 = { convergent nounwind }
attributes #23 = { nounwind }
attributes #24 = { convergent }
attributes #25 = { convergent nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4}
!opencl.ocl.version = !{!6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6}
!llvm.ident = !{!7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7}
!julia.kernel = !{!8}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl", directory: ".")
!6 = !{i32 2, i32 0}
!7 = !{!"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"}
!8 = !{void ()* @_Z2mm}
!9 = distinct !DISubprogram(name: "mm", linkageName: "julia_mm_1523", scope: null, file: !5, line: 369, type: !10, scopeLine: 369, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!10 = !DISubroutineType(types: !11)
!11 = !{}
!12 = !DILocation(line: 4, scope: !13, inlinedAt: !15)
!13 = distinct !DISubprogram(name: "#dm_alloc;", linkageName: "#dm_alloc", scope: !14, file: !14, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!14 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!15 = !DILocation(line: 370, scope: !9)
!16 = !DILocation(line: 372, scope: !9)
!17 = !{!18, !18, i64 0}
!18 = !{!"int", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C/C++ TBAA"}
!21 = !{!22, !22, i64 0}
!22 = !{!"long", !19, i64 0}
!23 = !{!24, !24, i64 0}
!24 = !{!"any pointer", !19, i64 0}
!25 = !{!26, !24, i64 0}
!26 = !{!"", !24, i64 0, !24, i64 8, !27, i64 16, !22, i64 24, !22, i64 32, !22, i64 40}
!27 = !{!"hsa_signal_s", !22, i64 0}
!28 = !{!26, !22, i64 40}
!29 = !{!26, !24, i64 8}
!30 = !{!19, !19, i64 0}
!31 = !{!32, !32, i64 0}
!32 = !{!"bool", !19, i64 0}
!33 = !{i8 0, i8 2}
!34 = !{i64 2662}
!35 = !{!"exec"}
!36 = !{!37, !18, i64 16}
!37 = !{!"", !22, i64 0, !22, i64 8, !18, i64 16, !18, i64 20}
!38 = !{!37, !22, i64 8}
!39 = !{!37, !18, i64 20}
!40 = !{!37, !22, i64 0}
!41 = !{!42, !22, i64 16}
!42 = !{!"amd_signal_s", !22, i64 0, !19, i64 8, !22, i64 16, !18, i64 24, !18, i64 28, !22, i64 32, !22, i64 40, !19, i64 48, !19, i64 56}
!43 = !{!42, !18, i64 24}
!44 = !{i64 0, i64 65}
!45 = !{!"exec_lo"}
!46 = !{i32 0, i32 33}
!47 = !{i64 7014}
!48 = !{i64 7137}
!49 = !{!50, !18, i64 8}
!50 = !{!"kind_info_s", !18, i64 0, !18, i64 4, !18, i64 8, !18, i64 12, !18, i64 16, !18, i64 20, !18, i64 24, !18, i64 28}
!51 = !{!52, !22, i64 108552}
!52 = !{!"heap_s", !19, i64 0, !19, i64 2048, !19, i64 4096, !19, i64 6144, !19, i64 8192, !19, i64 10240, !19, i64 108544, !22, i64 108552, !19, i64 108560, !19, i64 108672}
!53 = !{!50, !18, i64 20}
!54 = !{!50, !18, i64 0}
!55 = !{!50, !18, i64 16}
!56 = !{!50, !18, i64 24}
!57 = !{!58, !18, i64 4}
!58 = !{!"slab_s", !18, i64 0, !18, i64 4, !19, i64 8, !18, i64 12, !19, i64 16}
!59 = !{!50, !18, i64 4}
!60 = !{!61, !19, i64 8}
!61 = !{!"sdata_s", !19, i64 0, !19, i64 8, !19, i64 16}
!62 = !{!58, !18, i64 0}
!63 = !{!50, !18, i64 28}
!64 = !{!50, !18, i64 12}
!65 = !{!"exec_hi"}
!66 = !{i64 751}
