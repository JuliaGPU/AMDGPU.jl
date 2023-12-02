; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@_j_const1 = private unnamed_addr addrspace(1) constant [1 x i64] zeroinitializer, align 8
@exception.6.12 = private unnamed_addr constant [10 x i8] c"exception\00", align 1
@_j_const1.11 = private unnamed_addr addrspace(1) constant i32 1, align 4
@_j_const1.3 = private unnamed_addr addrspace(1) constant i32 1, align 4
@alloc_special___malloc_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@alloc_special_hostcall_return = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 10300, align 4

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #0

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:44 within `#throw_boundserror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_boundserror_4790({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0, [1 x i64] addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(8) %1) unnamed_addr #1 !dbg !134 {
top:
  %2 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %3 = alloca { i64, i8 }, align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_boundserror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %7 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !138, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %8 = add i32 %7, 1, !dbg !155
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %9 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !159, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %10 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !164, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %11 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !169, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %12 = add i32 %11, 1, !dbg !177
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %13 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !179, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %14 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !184, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %15 = sub i32 %12, 1, !dbg !189
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %16 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !191
       %17 = getelementptr inbounds i8, i8 addrspace(4)* %16, i64 4, !dbg !191
       %18 = bitcast i8 addrspace(4)* %17 to i16 addrspace(4)*, !dbg !191
       %19 = load i16, i16 addrspace(4)* %18, align 2, !dbg !191, !range !199
       %20 = zext i16 %19 to i32, !dbg !191
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %21 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !200
       %22 = getelementptr inbounds i8, i8 addrspace(4)* %21, i64 6, !dbg !200
       %23 = bitcast i8 addrspace(4)* %22 to i16 addrspace(4)*, !dbg !200
       %24 = load i16, i16 addrspace(4)* %23, align 2, !dbg !200, !range !199
       %25 = zext i16 %24 to i32, !dbg !200
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %26 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !205
       %27 = getelementptr inbounds i8, i8 addrspace(4)* %26, i64 8, !dbg !205
       %28 = bitcast i8 addrspace(4)* %27 to i16 addrspace(4)*, !dbg !205
       %29 = load i16, i16 addrspace(4)* %28, align 2, !dbg !205, !range !199
       %30 = zext i16 %29 to i32, !dbg !205
; │└└└└
; │┌ @ int.jl:88 within `*`
    %31 = mul i32 %15, %20, !dbg !210
; │└
; │┌ @ int.jl:87 within `+`
    %32 = add i32 %8, %31, !dbg !212
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %33 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !213, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %34 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !219, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %35 = add i32 %34, 1, !dbg !223
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %36 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !225, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %37 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !229, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %38 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !234, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %39 = add i32 %38, 1, !dbg !238
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %40 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !240, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %41 = sub i32 %39, 1, !dbg !244
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %42 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !245
       %43 = getelementptr inbounds i8, i8 addrspace(4)* %42, i64 4, !dbg !245
       %44 = bitcast i8 addrspace(4)* %43 to i16 addrspace(4)*, !dbg !245
       %45 = load i16, i16 addrspace(4)* %44, align 2, !dbg !245, !range !199
       %46 = zext i16 %45 to i32, !dbg !245
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %47 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !250
       %48 = getelementptr inbounds i8, i8 addrspace(4)* %47, i64 6, !dbg !250
       %49 = bitcast i8 addrspace(4)* %48 to i16 addrspace(4)*, !dbg !250
       %50 = load i16, i16 addrspace(4)* %49, align 2, !dbg !250, !range !199
       %51 = zext i16 %50 to i32, !dbg !250
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %52 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !254
       %53 = getelementptr inbounds i8, i8 addrspace(4)* %52, i64 8, !dbg !254
       %54 = bitcast i8 addrspace(4)* %53 to i16 addrspace(4)*, !dbg !254
       %55 = load i16, i16 addrspace(4)* %54, align 2, !dbg !254, !range !199
       %56 = zext i16 %55 to i32, !dbg !254
; │└└└└
; │┌ @ int.jl:88 within `*`
    %57 = mul i32 %41, %51, !dbg !258
; │└
; │┌ @ int.jl:87 within `+`
    %58 = add i32 %35, %57, !dbg !259
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %59 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !260, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %60 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !266, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %61 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !270, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %62 = add i32 %61, 1, !dbg !274
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %63 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !276, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %64 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !281, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %65 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !285, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %66 = add i32 %65, 1, !dbg !289
; │└└└
; │┌ @ int.jl:86 within `-`
    %67 = sub i32 %66, 1, !dbg !291
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %68 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !292
       %69 = getelementptr inbounds i8, i8 addrspace(4)* %68, i64 4, !dbg !292
       %70 = bitcast i8 addrspace(4)* %69 to i16 addrspace(4)*, !dbg !292
       %71 = load i16, i16 addrspace(4)* %70, align 2, !dbg !292, !range !199
       %72 = zext i16 %71 to i32, !dbg !292
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %73 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !297
       %74 = getelementptr inbounds i8, i8 addrspace(4)* %73, i64 6, !dbg !297
       %75 = bitcast i8 addrspace(4)* %74 to i16 addrspace(4)*, !dbg !297
       %76 = load i16, i16 addrspace(4)* %75, align 2, !dbg !297, !range !199
       %77 = zext i16 %76 to i32, !dbg !297
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %78 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !301
       %79 = getelementptr inbounds i8, i8 addrspace(4)* %78, i64 8, !dbg !301
       %80 = bitcast i8 addrspace(4)* %79 to i16 addrspace(4)*, !dbg !301
       %81 = load i16, i16 addrspace(4)* %80, align 2, !dbg !301, !range !199
       %82 = zext i16 %81 to i32, !dbg !301
; │└└└└
; │┌ @ int.jl:88 within `*`
    %83 = mul i32 %67, %82, !dbg !305
; │└
; │┌ @ int.jl:87 within `+`
    %84 = add i32 %62, %83, !dbg !306
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %85 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !307
       %86 = getelementptr inbounds i8, i8 addrspace(4)* %85, i64 12, !dbg !307
       %87 = bitcast i8 addrspace(4)* %86 to i32 addrspace(4)*, !dbg !307
       %88 = load i32, i32 addrspace(4)* %87, align 4, !dbg !307, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %89 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !315
       %90 = getelementptr inbounds i8, i8 addrspace(4)* %89, i64 16, !dbg !315
       %91 = bitcast i8 addrspace(4)* %90 to i32 addrspace(4)*, !dbg !315
       %92 = load i32, i32 addrspace(4)* %91, align 4, !dbg !315, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %93 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !320
       %94 = getelementptr inbounds i8, i8 addrspace(4)* %93, i64 20, !dbg !320
       %95 = bitcast i8 addrspace(4)* %94 to i32 addrspace(4)*, !dbg !320
       %96 = load i32, i32 addrspace(4)* %95, align 4, !dbg !320, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %97 = zext i32 %88 to i64, !dbg !325
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %98 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !307
       %99 = getelementptr inbounds i8, i8 addrspace(4)* %98, i64 12, !dbg !307
       %100 = bitcast i8 addrspace(4)* %99 to i32 addrspace(4)*, !dbg !307
       %101 = load i32, i32 addrspace(4)* %100, align 4, !dbg !307, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %102 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !315
       %103 = getelementptr inbounds i8, i8 addrspace(4)* %102, i64 16, !dbg !315
       %104 = bitcast i8 addrspace(4)* %103 to i32 addrspace(4)*, !dbg !315
       %105 = load i32, i32 addrspace(4)* %104, align 4, !dbg !315, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %106 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !320
       %107 = getelementptr inbounds i8, i8 addrspace(4)* %106, i64 20, !dbg !320
       %108 = bitcast i8 addrspace(4)* %107 to i32 addrspace(4)*, !dbg !320
       %109 = load i32, i32 addrspace(4)* %108, align 4, !dbg !320, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %110 = zext i32 %105 to i64, !dbg !325
     %111 = zext i32 %32 to i64, !dbg !325
     %112 = zext i32 %58 to i64, !dbg !325
     %113 = zext i32 %84 to i64, !dbg !325
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %114 = sub i64 %112, 1, !dbg !330
     %115 = sub i64 %113, 1, !dbg !330
; ││└
; ││┌ @ int.jl:88 within `*`
     %116 = mul i64 %115, %110, !dbg !334
; ││└
; ││┌ @ int.jl:87 within `+`
     %117 = add i64 %114, %116, !dbg !335
; ││└
; ││┌ @ int.jl:88 within `*`
     %118 = mul i64 %97, %117, !dbg !334
; ││└
; ││┌ @ int.jl:87 within `+`
     %119 = add i64 %111, %118, !dbg !335
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !336
      store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, align 8, !dbg !336
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %120 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, i32 0, i32 1, !dbg !346
; ││└
; ││┌ @ essentials.jl:576 within `reinterpret`
     %bitcast = load i64, i64 addrspace(5)* %120, align 8, !dbg !349, !tbaa !352, !alias.scope !356, !noalias !359
     %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !349
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
    call fastcc void @julia_llvm_atomic_cas_4923({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %3, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %119), !dbg !364
    %121 = addrspacecast { i64, i8 } addrspace(5)* %3 to { i64, i8 } addrspace(11)*, !dbg !364
    %122 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4920({ i64, i8 } addrspace(11)* nocapture readonly %121, i64 signext 1), !dbg !364
    %123 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %122, i64 0), !dbg !364
    %124 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %122, i64 1), !dbg !364
    %125 = addrspacecast { i64, i8 } addrspace(5)* %3 to { i64, i8 } addrspace(11)*, !dbg !364
    %126 = bitcast {} addrspace(10)* %124 to i64 addrspace(10)*, !dbg !364
    %unbox = load i64, i64 addrspace(10)* %126, align 8, !dbg !364, !tbaa !365, !alias.scope !368, !noalias !369
    %127 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4918({ i64, i8 } addrspace(11)* nocapture readonly %125, i64 signext 2, i64 signext %unbox), !dbg !364
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
    %128 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %123), !dbg !370
    %129 = addrspacecast {} addrspace(10)* %128 to {} addrspace(11)*, !dbg !370
    %130 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %129) #3, !dbg !370
    %typeof = ptrtoint {}* %130 to i64, !dbg !370
    %exactly_isa = icmp eq i64 %typeof, 192, !dbg !370
    %131 = zext i1 %exactly_isa to i8, !dbg !370
    %132 = trunc i8 %131 to i1, !dbg !370
    %133 = xor i1 %132, true, !dbg !370
    br i1 %133, label %L108, label %L105, !dbg !370

L105:                                             ; preds = %top
; ││┌ @ bool.jl:155 within `iszero`
; │││┌ @ bool.jl:35 within `!`
      %134 = bitcast {} addrspace(10)* %123 to i8 addrspace(10)*, !dbg !371
      %unbox1 = load i8, i8 addrspace(10)* %134, align 1, !dbg !371, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
      %135 = trunc i8 %unbox1 to i1, !dbg !371
      %136 = xor i1 %135, true, !dbg !371
      %137 = zext i1 %136 to i8
; ││└└
    br label %L115, !dbg !370

L108:                                             ; preds = %top
    %138 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %123), !dbg !370
    %139 = addrspacecast {} addrspace(10)* %138 to {} addrspace(11)*, !dbg !370
    %140 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %139) #3, !dbg !370
    %typeof12 = ptrtoint {}* %140 to i64, !dbg !370
    %exactly_isa13 = icmp eq i64 %typeof12, 320, !dbg !370
    %141 = zext i1 %exactly_isa13 to i8, !dbg !370
    %142 = trunc i8 %141 to i1, !dbg !370
    %143 = xor i1 %142, true, !dbg !370
    br i1 %143, label %L113, label %L110, !dbg !370

L110:                                             ; preds = %L108
    %144 = bitcast {} addrspace(10)* %123 to i64 addrspace(10)*, !dbg !370
    %unbox14 = load i64, i64 addrspace(10)* %144, align 8, !dbg !370, !tbaa !365, !alias.scope !368, !noalias !369
    %145 = call fastcc i8 @julia_iszero_4832(i64 zeroext %unbox14), !dbg !370
    br label %L115, !dbg !370

L113:                                             ; preds = %L108
    call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !370
    call fastcc void @gpu_signal_exception(), !dbg !370
    call void @llvm.trap(), !dbg !370
    unreachable, !dbg !370

L115:                                             ; preds = %L110, %L105
    %value_phi = phi i8 [ %137, %L105 ], [ %145, %L110 ]
    %146 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %123), !dbg !370
    %147 = addrspacecast {} addrspace(10)* %146 to {} addrspace(11)*, !dbg !370
    %148 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %147) #3, !dbg !370
    %typeof2 = ptrtoint {}* %148 to i64, !dbg !370
    %exactly_isa3 = icmp eq i64 %typeof2, 192, !dbg !370
    %149 = zext i1 %exactly_isa3 to i8, !dbg !370
    %150 = trunc i8 %149 to i1, !dbg !370
    %151 = xor i1 %150, true, !dbg !370
    br i1 %151, label %L122, label %L119, !dbg !370

L119:                                             ; preds = %L115
    %152 = bitcast {} addrspace(10)* %123 to i8 addrspace(10)*, !dbg !370
    %unbox4 = load i8, i8 addrspace(10)* %152, align 1, !dbg !370, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
    %153 = call fastcc i8 @julia____4901(i64 zeroext %119, i8 zeroext %unbox4), !dbg !370
    br label %L129, !dbg !370

L122:                                             ; preds = %L115
    %154 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %123), !dbg !370
    %155 = addrspacecast {} addrspace(10)* %154 to {} addrspace(11)*, !dbg !370
    %156 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %155) #3, !dbg !370
    %typeof7 = ptrtoint {}* %156 to i64, !dbg !370
    %exactly_isa8 = icmp eq i64 %typeof7, 320, !dbg !370
    %157 = zext i1 %exactly_isa8 to i8, !dbg !370
    %158 = trunc i8 %157 to i1, !dbg !370
    %159 = xor i1 %158, true, !dbg !370
    br i1 %159, label %L127, label %L124, !dbg !370

L124:                                             ; preds = %L122
; ││┌ @ promotion.jl:521 within `==`
     %160 = bitcast {} addrspace(10)* %123 to i64 addrspace(10)*, !dbg !377
     %unbox9 = load i64, i64 addrspace(10)* %160, align 8, !dbg !377, !tbaa !365, !alias.scope !368, !noalias !369
     %161 = icmp eq i64 %119, %unbox9, !dbg !377
     %162 = zext i1 %161 to i8, !dbg !377
; ││└
    br label %L129, !dbg !370

L127:                                             ; preds = %L122
    call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !370
    call fastcc void @gpu_signal_exception(), !dbg !370
    call void @llvm.trap(), !dbg !370
    unreachable, !dbg !370

L129:                                             ; preds = %L124, %L119
    %value_phi5 = phi i8 [ %153, %L119 ], [ %162, %L124 ]
; ││┌ @ essentials.jl:642 within `ifelse`
     %163 = trunc i8 %value_phi to i1, !dbg !380
     %ifelse_cond = xor i1 %163, true, !dbg !380
     %164 = select i1 %ifelse_cond, i8 %value_phi5, i8 1, !dbg !380
; ││└
    br label %L132, !dbg !370

L132:                                             ; preds = %L129
; │└
   %165 = trunc i8 %164 to i1, !dbg !345
   %166 = xor i1 %165, true, !dbg !345
   br i1 %166, label %L135, label %L133, !dbg !345

L133:                                             ; preds = %L132
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__4890() #8, !dbg !382
   unreachable, !dbg !382

L135:                                             ; preds = %L132
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !383
  call fastcc void @gpu_signal_exception(), !dbg !383
  call void @llvm.trap(), !dbg !383
  unreachable, !dbg !383
}

declare nonnull {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)*, i64) local_unnamed_addr

; Function Attrs: norecurse nounwind readnone
declare nonnull {} addrspace(10)* @julia.typeof({} addrspace(10)*) local_unnamed_addr #2

; Function Attrs: nounwind readnone
declare nonnull {}* @julia.pointer_from_objref({} addrspace(11)*) local_unnamed_addr #3

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #4

; Function Attrs: nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #4

; Function Attrs: readnone
declare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() local_unnamed_addr #5

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:40 within `#throw_inexacterror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_inexacterror_4853({} addrspace(10)* noundef nonnull %0, i64 signext %1) unnamed_addr #1 !dbg !384 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %5 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !385, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %6 = add i32 %5, 1, !dbg !398
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %7 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !401, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %8 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !406, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %9 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !411, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %10 = add i32 %9, 1, !dbg !418
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %11 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !420, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %12 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !425, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %13 = sub i32 %10, 1, !dbg !430
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %14 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !432
       %15 = getelementptr inbounds i8, i8 addrspace(4)* %14, i64 4, !dbg !432
       %16 = bitcast i8 addrspace(4)* %15 to i16 addrspace(4)*, !dbg !432
       %17 = load i16, i16 addrspace(4)* %16, align 2, !dbg !432, !range !199
       %18 = zext i16 %17 to i32, !dbg !432
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %19 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !440
       %20 = getelementptr inbounds i8, i8 addrspace(4)* %19, i64 6, !dbg !440
       %21 = bitcast i8 addrspace(4)* %20 to i16 addrspace(4)*, !dbg !440
       %22 = load i16, i16 addrspace(4)* %21, align 2, !dbg !440, !range !199
       %23 = zext i16 %22 to i32, !dbg !440
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %24 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !445
       %25 = getelementptr inbounds i8, i8 addrspace(4)* %24, i64 8, !dbg !445
       %26 = bitcast i8 addrspace(4)* %25 to i16 addrspace(4)*, !dbg !445
       %27 = load i16, i16 addrspace(4)* %26, align 2, !dbg !445, !range !199
       %28 = zext i16 %27 to i32, !dbg !445
; │└└└└
; │┌ @ int.jl:88 within `*`
    %29 = mul i32 %13, %18, !dbg !450
; │└
; │┌ @ int.jl:87 within `+`
    %30 = add i32 %6, %29, !dbg !452
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %31 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !453, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %32 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !459, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %33 = add i32 %32, 1, !dbg !463
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %34 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !465, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %35 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !469, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %36 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !474, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %37 = add i32 %36, 1, !dbg !478
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %38 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !480, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %39 = sub i32 %37, 1, !dbg !484
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %40 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !485
       %41 = getelementptr inbounds i8, i8 addrspace(4)* %40, i64 4, !dbg !485
       %42 = bitcast i8 addrspace(4)* %41 to i16 addrspace(4)*, !dbg !485
       %43 = load i16, i16 addrspace(4)* %42, align 2, !dbg !485, !range !199
       %44 = zext i16 %43 to i32, !dbg !485
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %45 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !490
       %46 = getelementptr inbounds i8, i8 addrspace(4)* %45, i64 6, !dbg !490
       %47 = bitcast i8 addrspace(4)* %46 to i16 addrspace(4)*, !dbg !490
       %48 = load i16, i16 addrspace(4)* %47, align 2, !dbg !490, !range !199
       %49 = zext i16 %48 to i32, !dbg !490
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %50 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !494
       %51 = getelementptr inbounds i8, i8 addrspace(4)* %50, i64 8, !dbg !494
       %52 = bitcast i8 addrspace(4)* %51 to i16 addrspace(4)*, !dbg !494
       %53 = load i16, i16 addrspace(4)* %52, align 2, !dbg !494, !range !199
       %54 = zext i16 %53 to i32, !dbg !494
; │└└└└
; │┌ @ int.jl:88 within `*`
    %55 = mul i32 %39, %49, !dbg !498
; │└
; │┌ @ int.jl:87 within `+`
    %56 = add i32 %33, %55, !dbg !499
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %57 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !500, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %58 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !506, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %59 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !510, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %60 = add i32 %59, 1, !dbg !514
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %61 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !516, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %62 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !521, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %63 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !525, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %64 = add i32 %63, 1, !dbg !529
; │└└└
; │┌ @ int.jl:86 within `-`
    %65 = sub i32 %64, 1, !dbg !531
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %66 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !532
       %67 = getelementptr inbounds i8, i8 addrspace(4)* %66, i64 4, !dbg !532
       %68 = bitcast i8 addrspace(4)* %67 to i16 addrspace(4)*, !dbg !532
       %69 = load i16, i16 addrspace(4)* %68, align 2, !dbg !532, !range !199
       %70 = zext i16 %69 to i32, !dbg !532
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %71 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !537
       %72 = getelementptr inbounds i8, i8 addrspace(4)* %71, i64 6, !dbg !537
       %73 = bitcast i8 addrspace(4)* %72 to i16 addrspace(4)*, !dbg !537
       %74 = load i16, i16 addrspace(4)* %73, align 2, !dbg !537, !range !199
       %75 = zext i16 %74 to i32, !dbg !537
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %76 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !541
       %77 = getelementptr inbounds i8, i8 addrspace(4)* %76, i64 8, !dbg !541
       %78 = bitcast i8 addrspace(4)* %77 to i16 addrspace(4)*, !dbg !541
       %79 = load i16, i16 addrspace(4)* %78, align 2, !dbg !541, !range !199
       %80 = zext i16 %79 to i32, !dbg !541
; │└└└└
; │┌ @ int.jl:88 within `*`
    %81 = mul i32 %65, %80, !dbg !545
; │└
; │┌ @ int.jl:87 within `+`
    %82 = add i32 %60, %81, !dbg !546
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %83 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !547
       %84 = getelementptr inbounds i8, i8 addrspace(4)* %83, i64 12, !dbg !547
       %85 = bitcast i8 addrspace(4)* %84 to i32 addrspace(4)*, !dbg !547
       %86 = load i32, i32 addrspace(4)* %85, align 4, !dbg !547, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %87 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !555
       %88 = getelementptr inbounds i8, i8 addrspace(4)* %87, i64 16, !dbg !555
       %89 = bitcast i8 addrspace(4)* %88 to i32 addrspace(4)*, !dbg !555
       %90 = load i32, i32 addrspace(4)* %89, align 4, !dbg !555, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %91 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !560
       %92 = getelementptr inbounds i8, i8 addrspace(4)* %91, i64 20, !dbg !560
       %93 = bitcast i8 addrspace(4)* %92 to i32 addrspace(4)*, !dbg !560
       %94 = load i32, i32 addrspace(4)* %93, align 4, !dbg !560, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %95 = zext i32 %86 to i64, !dbg !565
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %96 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !547
       %97 = getelementptr inbounds i8, i8 addrspace(4)* %96, i64 12, !dbg !547
       %98 = bitcast i8 addrspace(4)* %97 to i32 addrspace(4)*, !dbg !547
       %99 = load i32, i32 addrspace(4)* %98, align 4, !dbg !547, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %100 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !555
       %101 = getelementptr inbounds i8, i8 addrspace(4)* %100, i64 16, !dbg !555
       %102 = bitcast i8 addrspace(4)* %101 to i32 addrspace(4)*, !dbg !555
       %103 = load i32, i32 addrspace(4)* %102, align 4, !dbg !555, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %104 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !560
       %105 = getelementptr inbounds i8, i8 addrspace(4)* %104, i64 20, !dbg !560
       %106 = bitcast i8 addrspace(4)* %105 to i32 addrspace(4)*, !dbg !560
       %107 = load i32, i32 addrspace(4)* %106, align 4, !dbg !560, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %108 = zext i32 %103 to i64, !dbg !565
     %109 = zext i32 %30 to i64, !dbg !565
     %110 = zext i32 %56 to i64, !dbg !565
     %111 = zext i32 %82 to i64, !dbg !565
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %112 = sub i64 %110, 1, !dbg !569
     %113 = sub i64 %111, 1, !dbg !569
; ││└
; ││┌ @ int.jl:88 within `*`
     %114 = mul i64 %113, %108, !dbg !573
; ││└
; ││┌ @ int.jl:87 within `+`
     %115 = add i64 %112, %114, !dbg !574
; ││└
; ││┌ @ int.jl:88 within `*`
     %116 = mul i64 %95, %115, !dbg !573
; ││└
; ││┌ @ int.jl:87 within `+`
     %117 = add i64 %109, %116, !dbg !574
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
   %118 = call fastcc i8 @julia_gate__4893(i64 zeroext %117), !dbg !575
   %119 = trunc i8 %118 to i1, !dbg !575
   %120 = xor i1 %119, true, !dbg !575
   br i1 %120, label %L97, label %L95, !dbg !575

L95:                                              ; preds = %top
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__4890() #8, !dbg !576
   unreachable, !dbg !576

L97:                                              ; preds = %top
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !577
  call fastcc void @gpu_signal_exception(), !dbg !577
  call void @llvm.trap(), !dbg !577
  unreachable, !dbg !577
}

;  @ boot.jl:644 within `check_top_bit`
define internal fastcc i64 @julia_check_top_bit_4850(i64 signext %0) unnamed_addr !dbg !578 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ boot.jl:646 within `check_top_bit`
; ┌ @ boot.jl:636 within `is_top_bit_set`
   %4 = lshr i64 %0, 63, !dbg !579
   %5 = select i1 false, i64 0, i64 %4, !dbg !579
   %6 = trunc i64 %5 to i8, !dbg !579
   %7 = icmp eq i8 %6, 1, !dbg !579
; └
  %8 = zext i1 %7 to i8, !dbg !581
  %9 = trunc i8 %8 to i1, !dbg !581
  %10 = xor i1 %9, true, !dbg !581
  br i1 %10, label %L7, label %L5, !dbg !581

L5:                                               ; preds = %top
  call fastcc void @julia__throw_inexacterror_4853({} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714842730016 to {}*) to {} addrspace(10)*), i64 signext %0) #8, !dbg !581
  unreachable, !dbg !581

L7:                                               ; preds = %top
;  @ boot.jl:647 within `check_top_bit`
  ret i64 %0, !dbg !582
}

;  @ boot.jl:757 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_4847(i64 signext %0) unnamed_addr !dbg !583 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_check_top_bit_4850(i64 signext %0), !dbg !584
  ret i64 %4, !dbg !584
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_4844(i64 signext %0) unnamed_addr !dbg !585 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_toUInt64_4847(i64 signext %0), !dbg !586
  ret i64 %4, !dbg !586
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `gate!`
define internal fastcc i8 @julia_gate__4893(i64 zeroext %0) unnamed_addr !dbg !587 {
top:
  %1 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %2 = alloca { i64, i8 }, align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !588
    store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, align 8, !dbg !588
; └└
; ┌ @ Base.jl:37 within `getproperty`
   %6 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !595
; └
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast = load i64, i64 addrspace(5)* %6, align 8, !dbg !597, !tbaa !352, !alias.scope !356, !noalias !359
   %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !597
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
  call fastcc void @julia_llvm_atomic_cas_4923({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %2, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %0), !dbg !599
  %7 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !599
  %8 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4920({ i64, i8 } addrspace(11)* nocapture readonly %7, i64 signext 1), !dbg !599
  %9 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %8, i64 0), !dbg !599
  %10 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %8, i64 1), !dbg !599
  %11 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !599
  %12 = bitcast {} addrspace(10)* %10 to i64 addrspace(10)*, !dbg !599
  %unbox = load i64, i64 addrspace(10)* %12, align 8, !dbg !599, !tbaa !365, !alias.scope !368, !noalias !369
  %13 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4918({ i64, i8 } addrspace(11)* nocapture readonly %11, i64 signext 2, i64 signext %unbox), !dbg !599
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
  %14 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !600
  %15 = addrspacecast {} addrspace(10)* %14 to {} addrspace(11)*, !dbg !600
  %16 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %15) #3, !dbg !600
  %typeof = ptrtoint {}* %16 to i64, !dbg !600
  %exactly_isa = icmp eq i64 %typeof, 192, !dbg !600
  %17 = zext i1 %exactly_isa to i8, !dbg !600
  %18 = trunc i8 %17 to i1, !dbg !600
  %19 = xor i1 %18, true, !dbg !600
  br i1 %19, label %L16, label %L13, !dbg !600

L13:                                              ; preds = %top
; ┌ @ bool.jl:155 within `iszero`
; │┌ @ bool.jl:35 within `!`
    %20 = bitcast {} addrspace(10)* %9 to i8 addrspace(10)*, !dbg !601
    %unbox1 = load i8, i8 addrspace(10)* %20, align 1, !dbg !601, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
    %21 = trunc i8 %unbox1 to i1, !dbg !601
    %22 = xor i1 %21, true, !dbg !601
    %23 = zext i1 %22 to i8
; └└
  br label %L23, !dbg !600

L16:                                              ; preds = %top
  %24 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !600
  %25 = addrspacecast {} addrspace(10)* %24 to {} addrspace(11)*, !dbg !600
  %26 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %25) #3, !dbg !600
  %typeof9 = ptrtoint {}* %26 to i64, !dbg !600
  %exactly_isa10 = icmp eq i64 %typeof9, 320, !dbg !600
  %27 = zext i1 %exactly_isa10 to i8, !dbg !600
  %28 = trunc i8 %27 to i1, !dbg !600
  %29 = xor i1 %28, true, !dbg !600
  br i1 %29, label %L21, label %L18, !dbg !600

L18:                                              ; preds = %L16
  %30 = bitcast {} addrspace(10)* %9 to i64 addrspace(10)*, !dbg !600
  %unbox11 = load i64, i64 addrspace(10)* %30, align 8, !dbg !600, !tbaa !365, !alias.scope !368, !noalias !369
  %31 = call fastcc i8 @julia_iszero_4832(i64 zeroext %unbox11), !dbg !600
  br label %L23, !dbg !600

L21:                                              ; preds = %L16
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !600
  call fastcc void @gpu_signal_exception(), !dbg !600
  call void @llvm.trap(), !dbg !600
  unreachable, !dbg !600

L23:                                              ; preds = %L18, %L13
  %value_phi = phi i8 [ %23, %L13 ], [ %31, %L18 ]
  %32 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !600
  %33 = addrspacecast {} addrspace(10)* %32 to {} addrspace(11)*, !dbg !600
  %34 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %33) #3, !dbg !600
  %typeof2 = ptrtoint {}* %34 to i64, !dbg !600
  %exactly_isa3 = icmp eq i64 %typeof2, 192, !dbg !600
  %35 = zext i1 %exactly_isa3 to i8, !dbg !600
  %36 = trunc i8 %35 to i1, !dbg !600
  %37 = xor i1 %36, true, !dbg !600
  br i1 %37, label %L30, label %L27, !dbg !600

L27:                                              ; preds = %L23
  %38 = bitcast {} addrspace(10)* %9 to i8 addrspace(10)*, !dbg !600
  %unbox4 = load i8, i8 addrspace(10)* %38, align 1, !dbg !600, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
  %39 = call fastcc i8 @julia____4901(i64 zeroext %0, i8 zeroext %unbox4), !dbg !600
  br label %L37, !dbg !600

L30:                                              ; preds = %L23
  %40 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !600
  %41 = addrspacecast {} addrspace(10)* %40 to {} addrspace(11)*, !dbg !600
  %42 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %41) #3, !dbg !600
  %typeof6 = ptrtoint {}* %42 to i64, !dbg !600
  %exactly_isa7 = icmp eq i64 %typeof6, 320, !dbg !600
  %43 = zext i1 %exactly_isa7 to i8, !dbg !600
  %44 = trunc i8 %43 to i1, !dbg !600
  %45 = xor i1 %44, true, !dbg !600
  br i1 %45, label %L35, label %L32, !dbg !600

L32:                                              ; preds = %L30
; ┌ @ promotion.jl:521 within `==`
   %46 = bitcast {} addrspace(10)* %9 to i64 addrspace(10)*, !dbg !605
   %unbox8 = load i64, i64 addrspace(10)* %46, align 8, !dbg !605, !tbaa !365, !alias.scope !368, !noalias !369
   %47 = icmp eq i64 %0, %unbox8, !dbg !605
   %48 = zext i1 %47 to i8, !dbg !605
; └
  br label %L37, !dbg !600

L35:                                              ; preds = %L30
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !600
  call fastcc void @gpu_signal_exception(), !dbg !600
  call void @llvm.trap(), !dbg !600
  unreachable, !dbg !600

L37:                                              ; preds = %L32, %L27
  %value_phi5 = phi i8 [ %39, %L27 ], [ %48, %L32 ]
; ┌ @ essentials.jl:642 within `ifelse`
   %49 = trunc i8 %value_phi to i1, !dbg !607
   %ifelse_cond = xor i1 %49, true, !dbg !607
   %50 = select i1 %ifelse_cond, i8 %value_phi5, i8 1, !dbg !607
; └
  ret i8 %50, !dbg !600
}

;  @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:385 within `llvm_atomic_cas`
define internal fastcc void @julia_llvm_atomic_cas_4923({ i64, i8 } addrspace(5)* noalias nocapture noundef nonnull sret({ i64, i8 }) align 8 dereferenceable(16) %0, i8 addrspace(1)* %1, i64 zeroext %2, i64 zeroext %3) unnamed_addr !dbg !609 {
top:
  %newstruct2 = alloca { i64, i8 }, align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
; ┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:458 within `macro expansion`
; │┌ @ refpointer.jl:138 within `Ref`
; ││┌ @ refvalue.jl:7 within `RefValue`
     %7 = bitcast {}*** %4 to {}**, !dbg !611
     %current_task1 = getelementptr inbounds {}*, {}** %7, i64 -14, !dbg !611
     %newstruct = call noalias nonnull dereferenceable(1) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 1, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711468522128 to {}*) to {} addrspace(10)*)) #6, !dbg !611
     %8 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !611
; │└└
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:459 within `macro expansion`
   %9 = call token (...) @llvm.julia.gc_preserve_begin({} addrspace(10)* %newstruct), !dbg !620
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:460 within `macro expansion`
; │┌ @ pointer.jl:270 within `pointer_from_objref`
    %10 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !621
    %11 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %10) #3, !dbg !621
; │└
; │┌ @ boot.jl:798 within `Ptr`
    %bitcast_coercion = ptrtoint {}* %11 to i64, !dbg !625
; │└
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
   %12 = bitcast i8 addrspace(1)* %1 to i64 addrspace(1)*, !dbg !627
   %13 = inttoptr i64 %bitcast_coercion to i8*, !dbg !627
   %14 = cmpxchg i64 addrspace(1)* %12, i64 %2, i64 %3 acq_rel acquire, align 8, !dbg !627
   %15 = extractvalue { i64, i1 } %14, 0, !dbg !627
   %16 = extractvalue { i64, i1 } %14, 1, !dbg !627
   %17 = zext i1 %16 to i8, !dbg !627
   store i8 %17, i8* %13, align 1, !dbg !627
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion`
   call void @llvm.julia.gc_preserve_end(token %9), !dbg !629
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:463 within `macro expansion`
; │┌ @ refvalue.jl:59 within `getindex`
; ││┌ @ Base.jl:37 within `getproperty`
     %18 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !630
     %19 = bitcast {} addrspace(11)* %18 to i8 addrspace(11)*, !dbg !630
     %20 = load i8, i8 addrspace(11)* %19, align 1, !dbg !630, !tbaa !635, !alias.scope !368, !noalias !369
; │└└
; │┌ @ operators.jl:276 within `!=`
; ││┌ @ promotion.jl:521 within `==`
     %21 = icmp eq i8 %20, 0, !dbg !637
     %22 = zext i1 %21 to i8, !dbg !637
; ││└
; ││┌ @ bool.jl:35 within `!`
     %23 = trunc i8 %22 to i1, !dbg !642
     %24 = xor i1 %23, true, !dbg !642
; │└└
; │┌ @ boot.jl:620 within `NamedTuple`
    %25 = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %newstruct2, i32 0, i32 0, !dbg !644
    store i64 %15, i64 addrspace(5)* %25, align 8, !dbg !644, !tbaa !352, !alias.scope !356, !noalias !359
    %26 = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %newstruct2, i32 0, i32 1, !dbg !644
    %27 = zext i1 %24 to i8, !dbg !644
    store i8 %27, i8 addrspace(5)* %26, align 8, !dbg !644, !tbaa !352, !alias.scope !356, !noalias !359
; │└
   %28 = bitcast { i64, i8 } addrspace(5)* %0 to i8 addrspace(5)*, !dbg !634
   %29 = bitcast { i64, i8 } addrspace(5)* %newstruct2 to i8 addrspace(5)*, !dbg !634
   call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %28, i8 addrspace(5)* %29, i64 16, i1 false), !dbg !634
   ret void, !dbg !634
; └
}

; Function Attrs: allockind("alloc,uninitialized,aligned") allocsize(1)
declare noalias nonnull {} addrspace(10)* @julia.gc_alloc_obj({}**, i64, {} addrspace(10)*) local_unnamed_addr #6

declare token @llvm.julia.gc_preserve_begin(...)

declare void @llvm.julia.gc_preserve_end(token)

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8 addrspace(5)* noalias nocapture readonly, i64, i1 immarg) #7

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_4841(i64 signext %0) unnamed_addr !dbg !646 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_UInt64_4844(i64 signext %0), !dbg !648
  ret i64 %4, !dbg !648
}

;  @ essentials.jl:517 within `oftype`
define internal fastcc i64 @julia_oftype_4838(i64 zeroext %0, i64 signext %1) unnamed_addr !dbg !649 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
  %5 = call fastcc i64 @julia_convert_4841(i64 signext %1), !dbg !650
  ret i64 %5, !dbg !650
}

;  @ number.jl:308 within `zero`
define internal fastcc i64 @julia_zero_4835(i64 zeroext %0) unnamed_addr !dbg !651 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_oftype_4838(i64 zeroext %0, i64 signext 0), !dbg !652
  ret i64 %4, !dbg !652
}

;  @ number.jl:42 within `iszero`
define internal fastcc i8 @julia_iszero_4832(i64 zeroext %0) unnamed_addr !dbg !653 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_zero_4835(i64 zeroext %0), !dbg !654
; ┌ @ promotion.jl:521 within `==`
   %5 = icmp eq i64 %0, %4, !dbg !655
   %6 = zext i1 %5 to i8, !dbg !655
; └
  ret i8 %6, !dbg !654
}

;  @ boot.jl:764 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_4916(i8 zeroext %0) unnamed_addr !dbg !657 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = trunc i8 %0 to i1, !dbg !658
  %5 = zext i1 %4 to i64, !dbg !658
  %6 = and i64 %5, 1, !dbg !658
  ret i64 %6, !dbg !658
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_4913(i8 zeroext %0) unnamed_addr !dbg !659 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_toUInt64_4916(i8 zeroext %0), !dbg !660
  ret i64 %4, !dbg !660
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_4910(i8 zeroext %0) unnamed_addr !dbg !661 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_UInt64_4913(i8 zeroext %0), !dbg !662
  ret i64 %4, !dbg !662
}

;  @ promotion.jl:367 within `_promote`
define internal fastcc void @julia__promote_4907([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !663 {
top:
  %newstruct = alloca [2 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ promotion.jl:370 within `_promote`
  %6 = call fastcc i64 @julia_convert_4910(i8 zeroext %2), !dbg !664
  %7 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 0, !dbg !664
  store i64 %1, i64 addrspace(5)* %7, align 8, !dbg !664, !tbaa !352, !alias.scope !356, !noalias !359
  %8 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 1, !dbg !664
  store i64 %6, i64 addrspace(5)* %8, align 8, !dbg !664, !tbaa !352, !alias.scope !356, !noalias !359
  %9 = bitcast [2 x i64] addrspace(5)* %0 to i8 addrspace(5)*, !dbg !664
  %10 = bitcast [2 x i64] addrspace(5)* %newstruct to i8 addrspace(5)*, !dbg !664
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %9, i8 addrspace(5)* %10, i64 16, i1 false), !dbg !664
  ret void, !dbg !664
}

;  @ promotion.jl:391 within `promote`
define internal fastcc void @julia_promote_4904([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !665 {
top:
  %3 = alloca [2 x i64], align 8, addrspace(5)
  %newstruct = alloca [2 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
;  @ promotion.jl:393 within `promote`
  call fastcc void @julia__promote_4907([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %3, i64 zeroext %1, i8 zeroext %2), !dbg !666
; ┌ @ tuple.jl:92 within `indexed_iterate` @ tuple.jl:92
   %memcpy_refined_src = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !667
; │ @ tuple.jl:92 within `indexed_iterate`
   %memcpy_refined_src1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !670
; └
;  @ promotion.jl:395 within `promote`
  %memcpy_refined_dst = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 0, !dbg !671
  %7 = load i64, i64 addrspace(5)* %memcpy_refined_src, align 8, !dbg !671, !tbaa !352, !alias.scope !356, !noalias !359
  store i64 %7, i64 addrspace(5)* %memcpy_refined_dst, align 8, !dbg !671, !tbaa !352, !alias.scope !356, !noalias !359
  %memcpy_refined_dst2 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 1, !dbg !671
  %8 = load i64, i64 addrspace(5)* %memcpy_refined_src1, align 8, !dbg !671, !tbaa !352, !alias.scope !356, !noalias !359
  store i64 %8, i64 addrspace(5)* %memcpy_refined_dst2, align 8, !dbg !671, !tbaa !352, !alias.scope !356, !noalias !359
  %9 = bitcast [2 x i64] addrspace(5)* %0 to i8 addrspace(5)*, !dbg !671
  %10 = bitcast [2 x i64] addrspace(5)* %newstruct to i8 addrspace(5)*, !dbg !671
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %9, i8 addrspace(5)* %10, i64 16, i1 false), !dbg !671
  ret void, !dbg !671
}

;  @ promotion.jl:461 within `==`
define internal fastcc i8 @julia____4901(i64 zeroext %0, i8 zeroext %1) unnamed_addr !dbg !672 {
top:
  %2 = alloca [2 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
  call fastcc void @julia_promote_4904([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %2, i64 zeroext %0, i8 zeroext %1), !dbg !673
  %6 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !673
  %7 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !673
;  @ promotion.jl:461 within `==` @ promotion.jl:521
  %unbox = load i64, i64 addrspace(5)* %6, align 8, !dbg !674, !tbaa !352, !alias.scope !356, !noalias !359
  %unbox1 = load i64, i64 addrspace(5)* %7, align 8, !dbg !674, !tbaa !352, !alias.scope !356, !noalias !359
  %8 = icmp eq i64 %unbox, %unbox1, !dbg !674
  %9 = zext i1 %8 to i8, !dbg !674
;  @ promotion.jl:461 within `==`
  ret i8 %9, !dbg !673
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:13 within `err_buffer!`
; Function Attrs: noreturn
define internal fastcc void @julia_err_buffer__4890() unnamed_addr #8 !dbg !676 {
top:
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:14 within `err_buffer!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !677
    store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8, !dbg !677
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `err_buffer!`
; ┌ @ Base.jl:37 within `getproperty`
   %4 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 2, !dbg !684
; └
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast = load i64, i64 addrspace(5)* %4, align 8, !dbg !687, !tbaa !352, !alias.scope !356, !noalias !359
   %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !687
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:16 within `err_buffer!`
  %5 = bitcast {}*** %1 to {}**, !dbg !689
  %current_task1 = getelementptr inbounds {}*, {}** %5, i64 -14, !dbg !689
  %box = call noalias nonnull dereferenceable(8) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 8, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711466702416 to {}*) to {} addrspace(10)*)) #6, !dbg !689
  %6 = bitcast {} addrspace(10)* %box to i8 addrspace(1)* addrspace(10)*, !dbg !689
  store i8 addrspace(1)* %bitcast_coercion, i8 addrspace(1)* addrspace(10)* %6, align 8, !dbg !689, !tbaa !690, !alias.scope !368, !noalias !369
  %7 = call nonnull {} addrspace(10)* ({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)*, {} addrspace(10)*, ...) @julia.call({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)* @ijl_apply_generic, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140712826536560 to {}*) to {} addrspace(10)*), {} addrspace(10)* %box, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714619133632 to {}*) to {} addrspace(10)*), {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714841350448 to {}*) to {} addrspace(10)*), {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711540654808 to {}*) to {} addrspace(10)*)), !dbg !689
  call void @llvm.trap(), !dbg !689
  unreachable, !dbg !689
}

declare nonnull {} addrspace(10)* @ijl_apply_generic({} addrspace(10)*, {} addrspace(10)** noalias nocapture noundef readonly, i32)

declare nonnull {} addrspace(10)* @julia.call({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)*, {} addrspace(10)*, ...) local_unnamed_addr

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4918({ i64, i8 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1, i64 signext %2) unnamed_addr !dbg !692 {
top:
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
  %6 = sub i64 %1, 1, !dbg !694
  %7 = bitcast {}*** %3 to {}**, !dbg !694
  %current_task1 = getelementptr inbounds {}*, {}** %7, i64 -14, !dbg !694
  %box = call noalias nonnull dereferenceable(16) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 16, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711467825360 to {}*) to {} addrspace(10)*)) #6, !dbg !694
  %8 = bitcast {} addrspace(10)* %box to i8 addrspace(10)*, !dbg !694
  %9 = bitcast { i64, i8 } addrspace(11)* %0 to i8 addrspace(11)*, !dbg !694
  call void @llvm.memcpy.p10i8.p11i8.i64(i8 addrspace(10)* align 8 %8, i8 addrspace(11)* %9, i64 16, i1 false), !dbg !694, !tbaa !695, !alias.scope !696, !noalias !697
  %10 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %box, i64 %6), !dbg !694
; ┌ @ int.jl:87 within `+`
   %11 = add i64 %1, 1, !dbg !698
; └
  %12 = call fastcc nonnull {} addrspace(10)* @ijl_box_int64(i64 signext %11), !dbg !694
  %13 = call nonnull {} addrspace(10)* ({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)*, {} addrspace(10)*, ...) @julia.call({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)* @jl_f_tuple, {} addrspace(10)* null, {} addrspace(10)* %10, {} addrspace(10)* %12), !dbg !694
  ret {} addrspace(10)* %13, !dbg !694
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p10i8.p11i8.i64(i8 addrspace(10)* noalias nocapture writeonly, i8 addrspace(11)* noalias nocapture readonly, i64, i1 immarg) #7

declare nonnull {} addrspace(10)* @jl_f_tuple({} addrspace(10)*, {} addrspace(10)** noalias nocapture noundef readonly, i32)

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4920({ i64, i8 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !700 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
  %5 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_4918({ i64, i8 } addrspace(11)* nocapture readonly %0, i64 signext %1, i64 signext 1), !dbg !701
  ret {} addrspace(10)* %5, !dbg !701
}

;  @ REPL[2]:1 within `ker`
define amdgpu_kernel void @_Z3ker14ROCDeviceArrayI5Int64Li1ELi1EE({ [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr !dbg !702 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %0, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, align 8
  br label %top

top:                                              ; preds = %conversion
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ REPL[2]:2 within `ker`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
   br label %L2, !dbg !704

L2:                                               ; preds = %top
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:684
; ││┌ @ abstractarray.jl:386 within `eachindex`
; │││┌ @ abstractarray.jl:134 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %6 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 0, !dbg !708
; │││││└└
; │││││┌ @ tuple.jl:291 within `map`
; ││││││┌ @ tuple.jl:31 within `getindex`
         %7 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %6, i32 0, i32 0, !dbg !722
; ││││││└
; ││││││┌ @ range.jl:469 within `oneto`
; │││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
; ││││││││┌ @ promotion.jl:532 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %unbox = load i64, i64 addrspace(11)* %7, align 8, !dbg !726, !alias.scope !736, !noalias !737
            %8 = icmp slt i64 %unbox, 0, !dbg !726
; │││││││││└
; │││││││││┌ @ essentials.jl:642 within `ifelse`
            %9 = zext i1 %8 to i8, !dbg !738
            %10 = trunc i8 %9 to i1, !dbg !738
            %ifelse_cond = xor i1 %10, true, !dbg !738
            %unbox1 = load i64, i64 addrspace(11)* %7, align 8, !dbg !738, !alias.scope !736, !noalias !737
            %11 = select i1 %ifelse_cond, i64 %unbox1, i64 0, !dbg !738
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:760 within `checkindex`
; │││┌ @ int.jl:513 within `<`
      %12 = icmp ult i64 -1, %11, !dbg !740
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    %13 = zext i1 %12 to i8, !dbg !721
    %14 = trunc i8 %13 to i1, !dbg !721
    %15 = xor i1 %14, true, !dbg !721
    br i1 %15, label %L10, label %L9, !dbg !721

L9:                                               ; preds = %L2
; ││ @ abstractarray.jl:700 within `checkbounds`
    br label %L12, !dbg !743

L10:                                              ; preds = %L2
; ││ @ abstractarray.jl:699 within `checkbounds`
    call fastcc void @julia__throw_boundserror_4790({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %2, [1 x i64] addrspace(11)* nocapture readonly addrspacecast ([1 x i64] addrspace(1)* @_j_const1 to [1 x i64] addrspace(11)*)) #8, !dbg !721
    unreachable, !dbg !721

L12:                                              ; preds = %L9
; ││ @ abstractarray.jl:700 within `checkbounds`
    br label %L13, !dbg !743

L13:                                              ; preds = %L12
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %16 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 1, !dbg !744
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %unbox2 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %16, align 8, !dbg !748, !alias.scope !736, !noalias !737
      %17 = bitcast i8 addrspace(1)* %unbox2 to i64 addrspace(1)*, !dbg !748
      %18 = getelementptr inbounds i64, i64 addrspace(1)* %17, i64 -1, !dbg !748
      store i64 1, i64 addrspace(1)* %18, align 8, !dbg !748, !tbaa !757
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
   br label %L17, !dbg !760

L17:                                              ; preds = %L13
; └
;  @ REPL[2]:3 within `ker`
  ret void, !dbg !761
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception(i64 zeroext %0) unnamed_addr #9 !dbg !762 {
top:
  %1 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %2 = alloca { i64, i8 }, align 8, addrspace(5)
  %3 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %4 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %5 = alloca { i64, i8 }, align 8, addrspace(5)
  %6 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %7 = call {}*** @julia.get_pgcstack()
  %8 = bitcast {}*** %7 to {}**
  %current_task = getelementptr inbounds {}*, {}** %8, i64 -14
  %9 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %9, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:98 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %10 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !763, !range !154
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %11 = add i32 %10, 1, !dbg !778
; │││└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %12 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !781, !range !154
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %13 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !786, !range !154
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %14 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !791, !range !176
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %15 = add i32 %14, 1, !dbg !798
; │││└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %16 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !800, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %17 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !805, !range !176
; ││└└└└
; ││┌ @ int.jl:86 within `-`
     %18 = sub i32 %15, 1, !dbg !810
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %19 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !812
        %20 = getelementptr inbounds i8, i8 addrspace(4)* %19, i64 4, !dbg !812
        %21 = bitcast i8 addrspace(4)* %20 to i16 addrspace(4)*, !dbg !812
        %22 = load i16, i16 addrspace(4)* %21, align 2, !dbg !812, !range !199
        %23 = zext i16 %22 to i32, !dbg !812
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %24 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !820
        %25 = getelementptr inbounds i8, i8 addrspace(4)* %24, i64 6, !dbg !820
        %26 = bitcast i8 addrspace(4)* %25 to i16 addrspace(4)*, !dbg !820
        %27 = load i16, i16 addrspace(4)* %26, align 2, !dbg !820, !range !199
        %28 = zext i16 %27 to i32, !dbg !820
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %29 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !825
        %30 = getelementptr inbounds i8, i8 addrspace(4)* %29, i64 8, !dbg !825
        %31 = bitcast i8 addrspace(4)* %30 to i16 addrspace(4)*, !dbg !825
        %32 = load i16, i16 addrspace(4)* %31, align 2, !dbg !825, !range !199
        %33 = zext i16 %32 to i32, !dbg !825
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %34 = mul i32 %18, %23, !dbg !830
; ││└
; ││┌ @ int.jl:87 within `+`
     %35 = add i32 %11, %34, !dbg !832
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %36 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !833, !range !154
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %37 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !839, !range !154
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %38 = add i32 %37, 1, !dbg !843
; │││└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %39 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !845, !range !154
; ││└└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %40 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !849, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %41 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !854, !range !176
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %42 = add i32 %41, 1, !dbg !858
; │││└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %43 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !860, !range !176
; ││└└└└
; ││┌ @ int.jl:86 within `-`
     %44 = sub i32 %42, 1, !dbg !864
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %45 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !865
        %46 = getelementptr inbounds i8, i8 addrspace(4)* %45, i64 4, !dbg !865
        %47 = bitcast i8 addrspace(4)* %46 to i16 addrspace(4)*, !dbg !865
        %48 = load i16, i16 addrspace(4)* %47, align 2, !dbg !865, !range !199
        %49 = zext i16 %48 to i32, !dbg !865
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %50 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !870
        %51 = getelementptr inbounds i8, i8 addrspace(4)* %50, i64 6, !dbg !870
        %52 = bitcast i8 addrspace(4)* %51 to i16 addrspace(4)*, !dbg !870
        %53 = load i16, i16 addrspace(4)* %52, align 2, !dbg !870, !range !199
        %54 = zext i16 %53 to i32, !dbg !870
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %55 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !874
        %56 = getelementptr inbounds i8, i8 addrspace(4)* %55, i64 8, !dbg !874
        %57 = bitcast i8 addrspace(4)* %56 to i16 addrspace(4)*, !dbg !874
        %58 = load i16, i16 addrspace(4)* %57, align 2, !dbg !874, !range !199
        %59 = zext i16 %58 to i32, !dbg !874
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %60 = mul i32 %44, %54, !dbg !878
; ││└
; ││┌ @ int.jl:87 within `+`
     %61 = add i32 %38, %60, !dbg !879
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %62 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !880, !range !154
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %63 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !886, !range !154
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %64 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !890, !range !154
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %65 = add i32 %64, 1, !dbg !894
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %66 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !896, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %67 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !901, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %68 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !905, !range !176
; ││││└└
; ││││┌ @ int.jl:1068 within `+` @ int.jl:87
       %69 = add i32 %68, 1, !dbg !909
; ││└└└
; ││┌ @ int.jl:86 within `-`
     %70 = sub i32 %69, 1, !dbg !911
; ││└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %71 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !912
        %72 = getelementptr inbounds i8, i8 addrspace(4)* %71, i64 4, !dbg !912
        %73 = bitcast i8 addrspace(4)* %72 to i16 addrspace(4)*, !dbg !912
        %74 = load i16, i16 addrspace(4)* %73, align 2, !dbg !912, !range !199
        %75 = zext i16 %74 to i32, !dbg !912
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %76 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !917
        %77 = getelementptr inbounds i8, i8 addrspace(4)* %76, i64 6, !dbg !917
        %78 = bitcast i8 addrspace(4)* %77 to i16 addrspace(4)*, !dbg !917
        %79 = load i16, i16 addrspace(4)* %78, align 2, !dbg !917, !range !199
        %80 = zext i16 %79 to i32, !dbg !917
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %81 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !921
        %82 = getelementptr inbounds i8, i8 addrspace(4)* %81, i64 8, !dbg !921
        %83 = bitcast i8 addrspace(4)* %82 to i16 addrspace(4)*, !dbg !921
        %84 = load i16, i16 addrspace(4)* %83, align 2, !dbg !921, !range !199
        %85 = zext i16 %84 to i32, !dbg !921
; ││└└└└
; ││┌ @ int.jl:88 within `*`
     %86 = mul i32 %70, %85, !dbg !925
; ││└
; ││┌ @ int.jl:87 within `+`
     %87 = add i32 %65, %86, !dbg !926
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %88 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !927
        %89 = getelementptr inbounds i8, i8 addrspace(4)* %88, i64 12, !dbg !927
        %90 = bitcast i8 addrspace(4)* %89 to i32 addrspace(4)*, !dbg !927
        %91 = load i32, i32 addrspace(4)* %90, align 4, !dbg !927, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %92 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !935
        %93 = getelementptr inbounds i8, i8 addrspace(4)* %92, i64 16, !dbg !935
        %94 = bitcast i8 addrspace(4)* %93 to i32 addrspace(4)*, !dbg !935
        %95 = load i32, i32 addrspace(4)* %94, align 4, !dbg !935, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %96 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !940
        %97 = getelementptr inbounds i8, i8 addrspace(4)* %96, i64 20, !dbg !940
        %98 = bitcast i8 addrspace(4)* %97 to i32 addrspace(4)*, !dbg !940
        %99 = load i32, i32 addrspace(4)* %98, align 4, !dbg !940, !range !176
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %100 = zext i32 %91 to i64, !dbg !945
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %101 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !927
        %102 = getelementptr inbounds i8, i8 addrspace(4)* %101, i64 12, !dbg !927
        %103 = bitcast i8 addrspace(4)* %102 to i32 addrspace(4)*, !dbg !927
        %104 = load i32, i32 addrspace(4)* %103, align 4, !dbg !927, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %105 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !935
        %106 = getelementptr inbounds i8, i8 addrspace(4)* %105, i64 16, !dbg !935
        %107 = bitcast i8 addrspace(4)* %106 to i32 addrspace(4)*, !dbg !935
        %108 = load i32, i32 addrspace(4)* %107, align 4, !dbg !935, !range !176
; │││└└└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %109 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !940
        %110 = getelementptr inbounds i8, i8 addrspace(4)* %109, i64 20, !dbg !940
        %111 = bitcast i8 addrspace(4)* %110 to i32 addrspace(4)*, !dbg !940
        %112 = load i32, i32 addrspace(4)* %111, align 4, !dbg !940, !range !176
; ││└└└└
; ││┌ @ boot.jl:787 within `UInt64`
; │││┌ @ boot.jl:761 within `toUInt64`
      %113 = zext i32 %108 to i64, !dbg !945
      %114 = zext i32 %35 to i64, !dbg !945
      %115 = zext i32 %61 to i64, !dbg !945
      %116 = zext i32 %87 to i64, !dbg !945
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; │││┌ @ int.jl:1068 within `-` @ int.jl:86
      %117 = sub i64 %115, 1, !dbg !949
      %118 = sub i64 %116, 1, !dbg !949
; │││└
; │││┌ @ int.jl:88 within `*`
      %119 = mul i64 %118, %113, !dbg !953
; │││└
; │││┌ @ int.jl:87 within `+`
      %120 = add i64 %117, %119, !dbg !954
; │││└
; │││┌ @ int.jl:88 within `*`
      %121 = mul i64 %100, %120, !dbg !953
; │││└
; │││┌ @ int.jl:87 within `+`
      %122 = add i64 %114, %121, !dbg !954
; ││└└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i50 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !955
       store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i50, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, align 8, !dbg !955
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %123 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !963
; │││└
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast = load i64, i64 addrspace(5)* %123, align 8, !dbg !965, !tbaa !352, !alias.scope !356, !noalias !359
      %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !965
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
     call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %2, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %122), !dbg !967
     %124 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !967
     %125 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2625({ i64, i8 } addrspace(11)* nocapture readonly %124, i64 signext 1), !dbg !967
     %126 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %125, i64 0), !dbg !967
     %127 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %125, i64 1), !dbg !967
     %128 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !967
     %129 = bitcast {} addrspace(10)* %127 to i64 addrspace(10)*, !dbg !967
     %unbox = load i64, i64 addrspace(10)* %129, align 8, !dbg !967, !tbaa !365, !alias.scope !368, !noalias !369
     %130 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2623({ i64, i8 } addrspace(11)* nocapture readonly %128, i64 signext 2, i64 signext %unbox), !dbg !967
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
     %131 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %126), !dbg !968
     %132 = addrspacecast {} addrspace(10)* %131 to {} addrspace(11)*, !dbg !968
     %133 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %132) #3, !dbg !968
     %typeof = ptrtoint {}* %133 to i64, !dbg !968
     %exactly_isa = icmp eq i64 %typeof, 192, !dbg !968
     %134 = zext i1 %exactly_isa to i8, !dbg !968
     %135 = trunc i8 %134 to i1, !dbg !968
     %136 = xor i1 %135, true, !dbg !968
     br i1 %136, label %L108, label %L105, !dbg !968

L105:                                             ; preds = %top
; │││┌ @ bool.jl:155 within `iszero`
; ││││┌ @ bool.jl:35 within `!`
       %137 = bitcast {} addrspace(10)* %126 to i8 addrspace(10)*, !dbg !969
       %unbox1 = load i8, i8 addrspace(10)* %137, align 1, !dbg !969, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
       %138 = trunc i8 %unbox1 to i1, !dbg !969
       %139 = xor i1 %138, true, !dbg !969
       %140 = zext i1 %139 to i8
; │││└└
     br label %L115, !dbg !968

L108:                                             ; preds = %top
     %141 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %126), !dbg !968
     %142 = addrspacecast {} addrspace(10)* %141 to {} addrspace(11)*, !dbg !968
     %143 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %142) #3, !dbg !968
     %typeof43 = ptrtoint {}* %143 to i64, !dbg !968
     %exactly_isa44 = icmp eq i64 %typeof43, 320, !dbg !968
     %144 = zext i1 %exactly_isa44 to i8, !dbg !968
     %145 = trunc i8 %144 to i1, !dbg !968
     %146 = xor i1 %145, true, !dbg !968
     br i1 %146, label %L113, label %L110, !dbg !968

L110:                                             ; preds = %L108
     %147 = bitcast {} addrspace(10)* %126 to i64 addrspace(10)*, !dbg !968
     %unbox45 = load i64, i64 addrspace(10)* %147, align 8, !dbg !968, !tbaa !365, !alias.scope !368, !noalias !369
     %148 = call fastcc i8 @julia_iszero_2537(i64 zeroext %unbox45), !dbg !968
     br label %L115, !dbg !968

L113:                                             ; preds = %L108
     call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !968
     call fastcc void @gpu_signal_exception(), !dbg !968
     call void @llvm.trap(), !dbg !968
     unreachable, !dbg !968

L115:                                             ; preds = %L110, %L105
     %value_phi = phi i8 [ %140, %L105 ], [ %148, %L110 ]
     %149 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %126), !dbg !968
     %150 = addrspacecast {} addrspace(10)* %149 to {} addrspace(11)*, !dbg !968
     %151 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %150) #3, !dbg !968
     %typeof2 = ptrtoint {}* %151 to i64, !dbg !968
     %exactly_isa3 = icmp eq i64 %typeof2, 192, !dbg !968
     %152 = zext i1 %exactly_isa3 to i8, !dbg !968
     %153 = trunc i8 %152 to i1, !dbg !968
     %154 = xor i1 %153, true, !dbg !968
     br i1 %154, label %L122, label %L119, !dbg !968

L119:                                             ; preds = %L115
     %155 = bitcast {} addrspace(10)* %126 to i8 addrspace(10)*, !dbg !968
     %unbox4 = load i8, i8 addrspace(10)* %155, align 1, !dbg !968, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
     %156 = call fastcc i8 @julia____2606(i64 zeroext %122, i8 zeroext %unbox4), !dbg !968
     br label %L129, !dbg !968

L122:                                             ; preds = %L115
     %157 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %126), !dbg !968
     %158 = addrspacecast {} addrspace(10)* %157 to {} addrspace(11)*, !dbg !968
     %159 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %158) #3, !dbg !968
     %typeof38 = ptrtoint {}* %159 to i64, !dbg !968
     %exactly_isa39 = icmp eq i64 %typeof38, 320, !dbg !968
     %160 = zext i1 %exactly_isa39 to i8, !dbg !968
     %161 = trunc i8 %160 to i1, !dbg !968
     %162 = xor i1 %161, true, !dbg !968
     br i1 %162, label %L127, label %L124, !dbg !968

L124:                                             ; preds = %L122
; │││┌ @ promotion.jl:521 within `==`
      %163 = bitcast {} addrspace(10)* %126 to i64 addrspace(10)*, !dbg !973
      %unbox40 = load i64, i64 addrspace(10)* %163, align 8, !dbg !973, !tbaa !365, !alias.scope !368, !noalias !369
      %164 = icmp eq i64 %122, %unbox40, !dbg !973
      %165 = zext i1 %164 to i8, !dbg !973
; │││└
     br label %L129, !dbg !968

L127:                                             ; preds = %L122
     call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !968
     call fastcc void @gpu_signal_exception(), !dbg !968
     call void @llvm.trap(), !dbg !968
     unreachable, !dbg !968

L129:                                             ; preds = %L124, %L119
     %value_phi5 = phi i8 [ %156, %L119 ], [ %165, %L124 ]
; │││┌ @ essentials.jl:642 within `ifelse`
      %166 = trunc i8 %value_phi to i1, !dbg !975
      %ifelse_cond = xor i1 %166, true, !dbg !975
      %167 = select i1 %ifelse_cond, i8 %value_phi5, i8 1, !dbg !975
; │││└
     br label %L132, !dbg !968

L132:                                             ; preds = %L129
; ││└
    %168 = trunc i8 %167 to i1, !dbg !962
    %169 = xor i1 %168, true, !dbg !962
    br i1 %169, label %L132.L151_crit_edge, label %L133, !dbg !962

L132.L151_crit_edge:                              ; preds = %L132
    br label %L151, !dbg !962

L133:                                             ; preds = %L132
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:340 within `macro expansion`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:26 within `err_str_buffer!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i49 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !977
       store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i49, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, align 8, !dbg !977
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:27 within `err_str_buffer!`
; │││┌ @ Base.jl:37 within `getproperty`
      %170 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, i32 0, i32 3, !dbg !983
; │││└
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast6 = load i64, i64 addrspace(5)* %170, align 8, !dbg !985, !tbaa !352, !alias.scope !356, !noalias !359
      %bitcast_coercion7 = inttoptr i64 %bitcast6 to i8 addrspace(1)*, !dbg !985
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:28 within `err_str_buffer!`
; │││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:294 within `atomic_pointermodify` @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:359
; ││││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:255 within `llvm_atomic_op`
; │││││┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:255 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %171 = bitcast i8 addrspace(1)* %bitcast_coercion7 to i32 addrspace(1)*, !dbg !986
        %172 = atomicrmw add i32 addrspace(1)* %171, i32 1 acq_rel, align 4, !dbg !986
; │││└└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:31 within `err_str_buffer!`
; │││┌ @ Base.jl:37 within `getproperty`
      %173 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, i32 0, i32 7, !dbg !995
; │││└
; │││┌ @ operators.jl:378 within `>`
; ││││┌ @ int.jl:83 within `<`
       %unbox8 = load i32, i32 addrspace(5)* %173, align 4, !dbg !997, !tbaa !352, !alias.scope !356, !noalias !359
       %174 = icmp slt i32 %unbox8, %172, !dbg !997
; │││└└
     %175 = zext i1 %174 to i8, !dbg !996
     %176 = trunc i8 %175 to i1, !dbg !996
     %177 = xor i1 %176, true, !dbg !996
     br i1 %177, label %L143, label %L142, !dbg !996

L142:                                             ; preds = %L133
     br label %L150, !dbg !996

L143:                                             ; preds = %L133
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:33 within `err_str_buffer!`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %state.i48 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1001
       store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i48, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %6, align 8, !dbg !1001
; │││└└
; │││┌ @ Base.jl:37 within `getproperty`
      %178 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %6, i32 0, i32 5, !dbg !1005
; │││└
; │││┌ @ pointer.jl:119 within `unsafe_load`
; ││││┌ @ boot.jl:782 within `Int64`
; │││││┌ @ boot.jl:701 within `toInt64`
        %179 = sext i32 %172 to i64, !dbg !1006
; ││││└└
      %pointerref_idx = sub i64 %179, 1, !dbg !1010
      %180 = bitcast i64 addrspace(5)* %178 to i64* addrspace(5)*, !dbg !1010
      %unbox36 = load i64*, i64* addrspace(5)* %180, align 8, !dbg !1010, !tbaa !352, !alias.scope !356, !noalias !359
      %181 = getelementptr inbounds i64, i64* %unbox36, i64 %pointerref_idx, !dbg !1010
      %pointerref = load i64, i64* %181, align 1, !dbg !1010, !tbaa !1012, !alias.scope !368, !noalias !369
; │││└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:34 within `err_str_buffer!`
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast_coercion37 = inttoptr i64 %pointerref to i8 addrspace(1)*, !dbg !1013
; │││└
     br label %L150, !dbg !1014

L150:                                             ; preds = %L143, %L142
     %value_phi9 = phi i8 addrspace(1)* [ null, %L142 ], [ %bitcast_coercion37, %L143 ]
; ││└
    br label %L151, !dbg !982

L151:                                             ; preds = %L150, %L132.L151_crit_edge
    %value_phi10 = phi i8 addrspace(1)* [ %value_phi9, %L150 ], [ null, %L132.L151_crit_edge ]
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:99 within `err_device_string_to_host`
; │┌ @ essentials.jl:576 within `reinterpret`
    %bitcast_coercion11 = ptrtoint i8 addrspace(1)* %value_phi10 to i64, !dbg !1015
; │└
; │┌ @ int.jl:518 within `==` @ promotion.jl:521
    %182 = icmp eq i64 %bitcast_coercion11, 0, !dbg !1017
    %183 = zext i1 %182 to i8, !dbg !1017
; ││ @ int.jl:518 within `==`
; ││┌ @ bool.jl:38 within `&`
     %184 = trunc i8 %183 to i1, !dbg !1020
     %185 = and i1 true, %184, !dbg !1020
; │└└
   %186 = zext i1 %185 to i8, !dbg !1016
   %187 = trunc i8 %186 to i1, !dbg !1016
   %188 = xor i1 %187, true, !dbg !1016
   br i1 %188, label %L157, label %L156, !dbg !1016

L156:                                             ; preds = %L151
   br label %L168, !dbg !1016

L157:                                             ; preds = %L151
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:101 within `err_device_string_to_host`
; │┌ @ essentials.jl:576 within `reinterpret`
    %bitcast_coercion33 = inttoptr i64 %0 to i8 addrspace(1)*, !dbg !1022
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:102 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `string_length`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     %189 = addrspacecast i8 addrspace(1)* %bitcast_coercion33 to i8 addrspace(1)**, !dbg !1024
     %190 = bitcast i8 addrspace(1)** %189 to i8*, !dbg !1024
     br label %check.i, !dbg !1024

check.i:                                          ; preds = %check.i, %L157
     %191 = phi i64 [ 0, %L157 ], [ %192, %check.i ], !dbg !1024
     %192 = add i64 %191, 1, !dbg !1024
     %193 = getelementptr i8, i8* %190, i64 %191, !dbg !1024
     %194 = load i8, i8* %193, align 1, !dbg !1024
     %195 = icmp eq i8 %194, 0, !dbg !1024
     br i1 %195, label %julia_report_exception_2455u2533.exit, label %check.i, !dbg !1024

julia_report_exception_2455u2533.exit:            ; preds = %check.i
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:105 within `err_device_string_to_host`
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %value_phi10, i8 addrspace(1)* %bitcast_coercion33, i64 %191, i1 false), !dbg !1031
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:106 within `err_device_string_to_host`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:114 within `+`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:100 within `UInt64`
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast_coercion34 = ptrtoint i8 addrspace(1)* %value_phi10 to i64, !dbg !1036
; ││└└
    %196 = addrspacecast i8 addrspace(1)* %value_phi10 to i8*, !dbg !1039
    %197 = getelementptr i8, i8* %196, i64 %191, !dbg !1039
    %198 = ptrtoint i8* %197 to i64, !dbg !1039
; ││┌ @ essentials.jl:517 within `oftype`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:102 within `convert`
; ││││┌ @ essentials.jl:576 within `reinterpret`
       %bitcast_coercion35 = addrspacecast i8* %197 to i8 addrspace(1)*, !dbg !1042
; │└└└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      store i8 0, i8 addrspace(1)* %bitcast_coercion35, align 1, !dbg !1047, !tbaa !757
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:107 within `err_device_string_to_host`
   br label %L168, !dbg !1055

L168:                                             ; preds = %julia_report_exception_2455u2533.exit, %L156
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:117 within `report_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %199 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1056, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %200 = add i32 %199, 1, !dbg !1063
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %201 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1065, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %202 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1069, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %203 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1073, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %204 = add i32 %203, 1, !dbg !1078
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %205 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1080, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %206 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1084, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %207 = sub i32 %204, 1, !dbg !1088
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %208 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1089
       %209 = getelementptr inbounds i8, i8 addrspace(4)* %208, i64 4, !dbg !1089
       %210 = bitcast i8 addrspace(4)* %209 to i16 addrspace(4)*, !dbg !1089
       %211 = load i16, i16 addrspace(4)* %210, align 2, !dbg !1089, !range !199
       %212 = zext i16 %211 to i32, !dbg !1089
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %213 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1094
       %214 = getelementptr inbounds i8, i8 addrspace(4)* %213, i64 6, !dbg !1094
       %215 = bitcast i8 addrspace(4)* %214 to i16 addrspace(4)*, !dbg !1094
       %216 = load i16, i16 addrspace(4)* %215, align 2, !dbg !1094, !range !199
       %217 = zext i16 %216 to i32, !dbg !1094
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %218 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1098
       %219 = getelementptr inbounds i8, i8 addrspace(4)* %218, i64 8, !dbg !1098
       %220 = bitcast i8 addrspace(4)* %219 to i16 addrspace(4)*, !dbg !1098
       %221 = load i16, i16 addrspace(4)* %220, align 2, !dbg !1098, !range !199
       %222 = zext i16 %221 to i32, !dbg !1098
; │└└└└
; │┌ @ int.jl:88 within `*`
    %223 = mul i32 %207, %212, !dbg !1102
; │└
; │┌ @ int.jl:87 within `+`
    %224 = add i32 %200, %223, !dbg !1103
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %225 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1104, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %226 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1110, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %227 = add i32 %226, 1, !dbg !1114
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %228 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1116, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %229 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1120, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %230 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1125, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %231 = add i32 %230, 1, !dbg !1129
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %232 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1131, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %233 = sub i32 %231, 1, !dbg !1135
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %234 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1136
       %235 = getelementptr inbounds i8, i8 addrspace(4)* %234, i64 4, !dbg !1136
       %236 = bitcast i8 addrspace(4)* %235 to i16 addrspace(4)*, !dbg !1136
       %237 = load i16, i16 addrspace(4)* %236, align 2, !dbg !1136, !range !199
       %238 = zext i16 %237 to i32, !dbg !1136
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %239 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1141
       %240 = getelementptr inbounds i8, i8 addrspace(4)* %239, i64 6, !dbg !1141
       %241 = bitcast i8 addrspace(4)* %240 to i16 addrspace(4)*, !dbg !1141
       %242 = load i16, i16 addrspace(4)* %241, align 2, !dbg !1141, !range !199
       %243 = zext i16 %242 to i32, !dbg !1141
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %244 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1145
       %245 = getelementptr inbounds i8, i8 addrspace(4)* %244, i64 8, !dbg !1145
       %246 = bitcast i8 addrspace(4)* %245 to i16 addrspace(4)*, !dbg !1145
       %247 = load i16, i16 addrspace(4)* %246, align 2, !dbg !1145, !range !199
       %248 = zext i16 %247 to i32, !dbg !1145
; │└└└└
; │┌ @ int.jl:88 within `*`
    %249 = mul i32 %233, %243, !dbg !1149
; │└
; │┌ @ int.jl:87 within `+`
    %250 = add i32 %227, %249, !dbg !1150
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %251 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1151, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %252 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1157, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %253 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1161, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %254 = add i32 %253, 1, !dbg !1165
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %255 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1167, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %256 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1172, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %257 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1176, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %258 = add i32 %257, 1, !dbg !1180
; │└└└
; │┌ @ int.jl:86 within `-`
    %259 = sub i32 %258, 1, !dbg !1182
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %260 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1183
       %261 = getelementptr inbounds i8, i8 addrspace(4)* %260, i64 4, !dbg !1183
       %262 = bitcast i8 addrspace(4)* %261 to i16 addrspace(4)*, !dbg !1183
       %263 = load i16, i16 addrspace(4)* %262, align 2, !dbg !1183, !range !199
       %264 = zext i16 %263 to i32, !dbg !1183
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %265 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1188
       %266 = getelementptr inbounds i8, i8 addrspace(4)* %265, i64 6, !dbg !1188
       %267 = bitcast i8 addrspace(4)* %266 to i16 addrspace(4)*, !dbg !1188
       %268 = load i16, i16 addrspace(4)* %267, align 2, !dbg !1188, !range !199
       %269 = zext i16 %268 to i32, !dbg !1188
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %270 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1192
       %271 = getelementptr inbounds i8, i8 addrspace(4)* %270, i64 8, !dbg !1192
       %272 = bitcast i8 addrspace(4)* %271 to i16 addrspace(4)*, !dbg !1192
       %273 = load i16, i16 addrspace(4)* %272, align 2, !dbg !1192, !range !199
       %274 = zext i16 %273 to i32, !dbg !1192
; │└└└└
; │┌ @ int.jl:88 within `*`
    %275 = mul i32 %259, %274, !dbg !1196
; │└
; │┌ @ int.jl:87 within `+`
    %276 = add i32 %254, %275, !dbg !1197
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %277 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1198
       %278 = getelementptr inbounds i8, i8 addrspace(4)* %277, i64 12, !dbg !1198
       %279 = bitcast i8 addrspace(4)* %278 to i32 addrspace(4)*, !dbg !1198
       %280 = load i32, i32 addrspace(4)* %279, align 4, !dbg !1198, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %281 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1204
       %282 = getelementptr inbounds i8, i8 addrspace(4)* %281, i64 16, !dbg !1204
       %283 = bitcast i8 addrspace(4)* %282 to i32 addrspace(4)*, !dbg !1204
       %284 = load i32, i32 addrspace(4)* %283, align 4, !dbg !1204, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %285 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1208
       %286 = getelementptr inbounds i8, i8 addrspace(4)* %285, i64 20, !dbg !1208
       %287 = bitcast i8 addrspace(4)* %286 to i32 addrspace(4)*, !dbg !1208
       %288 = load i32, i32 addrspace(4)* %287, align 4, !dbg !1208, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %289 = zext i32 %280 to i64, !dbg !1212
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %290 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1198
       %291 = getelementptr inbounds i8, i8 addrspace(4)* %290, i64 12, !dbg !1198
       %292 = bitcast i8 addrspace(4)* %291 to i32 addrspace(4)*, !dbg !1198
       %293 = load i32, i32 addrspace(4)* %292, align 4, !dbg !1198, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %294 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1204
       %295 = getelementptr inbounds i8, i8 addrspace(4)* %294, i64 16, !dbg !1204
       %296 = bitcast i8 addrspace(4)* %295 to i32 addrspace(4)*, !dbg !1204
       %297 = load i32, i32 addrspace(4)* %296, align 4, !dbg !1204, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %298 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1208
       %299 = getelementptr inbounds i8, i8 addrspace(4)* %298, i64 20, !dbg !1208
       %300 = bitcast i8 addrspace(4)* %299 to i32 addrspace(4)*, !dbg !1208
       %301 = load i32, i32 addrspace(4)* %300, align 4, !dbg !1208, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %302 = zext i32 %297 to i64, !dbg !1212
     %303 = zext i32 %224 to i64, !dbg !1212
     %304 = zext i32 %250 to i64, !dbg !1212
     %305 = zext i32 %276 to i64, !dbg !1212
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %306 = sub i64 %304, 1, !dbg !1214
     %307 = sub i64 %305, 1, !dbg !1214
; ││└
; ││┌ @ int.jl:88 within `*`
     %308 = mul i64 %307, %302, !dbg !1217
; ││└
; ││┌ @ int.jl:87 within `+`
     %309 = add i64 %306, %308, !dbg !1218
; ││└
; ││┌ @ int.jl:88 within `*`
     %310 = mul i64 %289, %309, !dbg !1217
; ││└
; ││┌ @ int.jl:87 within `+`
     %311 = add i64 %303, %310, !dbg !1218
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1219
      store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, align 8, !dbg !1219
; ││└└
; ││┌ @ Base.jl:37 within `getproperty`
     %312 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, i32 0, i32 1, !dbg !1224
; ││└
; ││┌ @ essentials.jl:576 within `reinterpret`
     %bitcast12 = load i64, i64 addrspace(5)* %312, align 8, !dbg !1225, !tbaa !352, !alias.scope !356, !noalias !359
     %bitcast_coercion13 = inttoptr i64 %bitcast12 to i8 addrspace(1)*, !dbg !1225
; ││└
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
    call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %5, i8 addrspace(1)* %bitcast_coercion13, i64 zeroext 0, i64 zeroext %311), !dbg !1226
    %313 = addrspacecast { i64, i8 } addrspace(5)* %5 to { i64, i8 } addrspace(11)*, !dbg !1226
    %314 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2625({ i64, i8 } addrspace(11)* nocapture readonly %313, i64 signext 1), !dbg !1226
    %315 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %314, i64 0), !dbg !1226
    %316 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %314, i64 1), !dbg !1226
    %317 = addrspacecast { i64, i8 } addrspace(5)* %5 to { i64, i8 } addrspace(11)*, !dbg !1226
    %318 = bitcast {} addrspace(10)* %316 to i64 addrspace(10)*, !dbg !1226
    %unbox14 = load i64, i64 addrspace(10)* %318, align 8, !dbg !1226, !tbaa !365, !alias.scope !368, !noalias !369
    %319 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2623({ i64, i8 } addrspace(11)* nocapture readonly %317, i64 signext 2, i64 signext %unbox14), !dbg !1226
; ││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
    %320 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %315), !dbg !1227
    %321 = addrspacecast {} addrspace(10)* %320 to {} addrspace(11)*, !dbg !1227
    %322 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %321) #3, !dbg !1227
    %typeof15 = ptrtoint {}* %322 to i64, !dbg !1227
    %exactly_isa16 = icmp eq i64 %typeof15, 192, !dbg !1227
    %323 = zext i1 %exactly_isa16 to i8, !dbg !1227
    %324 = trunc i8 %323 to i1, !dbg !1227
    %325 = xor i1 %324, true, !dbg !1227
    br i1 %325, label %L275, label %L272, !dbg !1227

L272:                                             ; preds = %L168
; ││┌ @ bool.jl:155 within `iszero`
; │││┌ @ bool.jl:35 within `!`
      %326 = bitcast {} addrspace(10)* %315 to i8 addrspace(10)*, !dbg !1228
      %unbox17 = load i8, i8 addrspace(10)* %326, align 1, !dbg !1228, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
      %327 = trunc i8 %unbox17 to i1, !dbg !1228
      %328 = xor i1 %327, true, !dbg !1228
      %329 = zext i1 %328 to i8
; ││└└
    br label %L282, !dbg !1227

L275:                                             ; preds = %L168
    %330 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %315), !dbg !1227
    %331 = addrspacecast {} addrspace(10)* %330 to {} addrspace(11)*, !dbg !1227
    %332 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %331) #3, !dbg !1227
    %typeof28 = ptrtoint {}* %332 to i64, !dbg !1227
    %exactly_isa29 = icmp eq i64 %typeof28, 320, !dbg !1227
    %333 = zext i1 %exactly_isa29 to i8, !dbg !1227
    %334 = trunc i8 %333 to i1, !dbg !1227
    %335 = xor i1 %334, true, !dbg !1227
    br i1 %335, label %L280, label %L277, !dbg !1227

L277:                                             ; preds = %L275
    %336 = bitcast {} addrspace(10)* %315 to i64 addrspace(10)*, !dbg !1227
    %unbox30 = load i64, i64 addrspace(10)* %336, align 8, !dbg !1227, !tbaa !365, !alias.scope !368, !noalias !369
    %337 = call fastcc i8 @julia_iszero_2537(i64 zeroext %unbox30), !dbg !1227
    br label %L282, !dbg !1227

L280:                                             ; preds = %L275
    call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !1227
    call fastcc void @gpu_signal_exception(), !dbg !1227
    call void @llvm.trap(), !dbg !1227
    unreachable, !dbg !1227

L282:                                             ; preds = %L277, %L272
    %value_phi18 = phi i8 [ %329, %L272 ], [ %337, %L277 ]
    %338 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %315), !dbg !1227
    %339 = addrspacecast {} addrspace(10)* %338 to {} addrspace(11)*, !dbg !1227
    %340 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %339) #3, !dbg !1227
    %typeof19 = ptrtoint {}* %340 to i64, !dbg !1227
    %exactly_isa20 = icmp eq i64 %typeof19, 192, !dbg !1227
    %341 = zext i1 %exactly_isa20 to i8, !dbg !1227
    %342 = trunc i8 %341 to i1, !dbg !1227
    %343 = xor i1 %342, true, !dbg !1227
    br i1 %343, label %L289, label %L286, !dbg !1227

L286:                                             ; preds = %L282
    %344 = bitcast {} addrspace(10)* %315 to i8 addrspace(10)*, !dbg !1227
    %unbox21 = load i8, i8 addrspace(10)* %344, align 1, !dbg !1227, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
    %345 = call fastcc i8 @julia____2606(i64 zeroext %311, i8 zeroext %unbox21), !dbg !1227
    br label %L296, !dbg !1227

L289:                                             ; preds = %L282
    %346 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %315), !dbg !1227
    %347 = addrspacecast {} addrspace(10)* %346 to {} addrspace(11)*, !dbg !1227
    %348 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %347) #3, !dbg !1227
    %typeof24 = ptrtoint {}* %348 to i64, !dbg !1227
    %exactly_isa25 = icmp eq i64 %typeof24, 320, !dbg !1227
    %349 = zext i1 %exactly_isa25 to i8, !dbg !1227
    %350 = trunc i8 %349 to i1, !dbg !1227
    %351 = xor i1 %350, true, !dbg !1227
    br i1 %351, label %L294, label %L291, !dbg !1227

L291:                                             ; preds = %L289
; ││┌ @ promotion.jl:521 within `==`
     %352 = bitcast {} addrspace(10)* %315 to i64 addrspace(10)*, !dbg !1230
     %unbox26 = load i64, i64 addrspace(10)* %352, align 8, !dbg !1230, !tbaa !365, !alias.scope !368, !noalias !369
     %353 = icmp eq i64 %311, %unbox26, !dbg !1230
     %354 = zext i1 %353 to i8, !dbg !1230
; ││└
    br label %L296, !dbg !1227

L294:                                             ; preds = %L289
    call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !1227
    call fastcc void @gpu_signal_exception(), !dbg !1227
    call void @llvm.trap(), !dbg !1227
    unreachable, !dbg !1227

L296:                                             ; preds = %L291, %L286
    %value_phi22 = phi i8 [ %345, %L286 ], [ %354, %L291 ]
; ││┌ @ essentials.jl:642 within `ifelse`
     %355 = trunc i8 %value_phi18 to i1, !dbg !1231
     %ifelse_cond23 = xor i1 %355, true, !dbg !1231
     %356 = select i1 %ifelse_cond23, i8 %value_phi22, i8 1, !dbg !1231
; ││└
    br label %L299, !dbg !1227

L299:                                             ; preds = %L296
; │└
   %357 = trunc i8 %356 to i1, !dbg !1223
   %358 = xor i1 %357, true, !dbg !1223
   br i1 %358, label %L302, label %L300, !dbg !1223

L300:                                             ; preds = %L299
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__2595() #8, !dbg !1232
   unreachable, !dbg !1232

L302:                                             ; preds = %L299
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:121 within `report_exception`
  ret void, !dbg !1233
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:89 within `signal_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #9 !dbg !1234 {
top:
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1235
     store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8, !dbg !1235
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %4 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 0, !dbg !1244
; └└
; ┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
   %5 = bitcast i64 addrspace(5)* %4 to i8* addrspace(5)*, !dbg !1246
   %unbox = load i8*, i8* addrspace(5)* %5, align 8, !dbg !1246, !tbaa !352, !alias.scope !356, !noalias !359
   %pointerset_ptr = getelementptr inbounds i8, i8* %unbox, i64 0, !dbg !1246
   %memcpy_refined_dst = bitcast i8* %pointerset_ptr to i32*, !dbg !1246
   %6 = load i32, i32 addrspace(1)* @_j_const1.11, align 1, !dbg !1246, !tbaa !690, !alias.scope !368, !noalias !369
   store i32 %6, i32* %memcpy_refined_dst, align 1, !dbg !1246
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
   call void @llvm.amdgcn.endpgm(), !dbg !1249
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:93 within `signal_exception`
  unreachable, !dbg !1253
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:11 within `malloc`
; Function Attrs: alwaysinline
define internal fastcc i64 @gpu_malloc(i64 zeroext %0) unnamed_addr #9 !dbg !1254 {
top:
  %1 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %pointerref = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %3 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %4 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %5 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %6 = call {}*** @julia.get_pgcstack()
  %7 = bitcast {}*** %6 to {}**
  %current_task = getelementptr inbounds {}*, {}** %7, i64 -14
  %8 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %8, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:12 within `malloc`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:66 within `malloc_hc`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
     %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1256
     store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, align 8, !dbg !1256
; │└└
; │┌ @ Base.jl:37 within `getproperty`
    %9 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, i32 0, i32 8, !dbg !1265
; │└
; │┌ @ pointer.jl:30 within `convert`
    %bitcast = load i64, i64 addrspace(5)* %9, align 8, !dbg !1267, !tbaa !352, !alias.scope !356, !noalias !359
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:75 within `malloc_hc`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      store i64 %bitcast, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special___malloc_hostcall, i32 0, i32 0), align 1, !dbg !1269, !tbaa !1278
; └└└└
; ┌ @ pointer.jl:119 within `unsafe_load` @ pointer.jl:119
   %coercion = inttoptr i64 %bitcast to { i64, i8 addrspace(1)*, i64 }*, !dbg !1280
   %10 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %coercion, i64 0, !dbg !1280
   %11 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref to i8 addrspace(5)*, !dbg !1280
   %12 = bitcast { i64, i8 addrspace(1)*, i64 }* %10 to i8*, !dbg !1280
   call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 1 %11, i8* %12, i64 24, i1 false), !dbg !1280, !tbaa !695, !alias.scope !1283, !noalias !1284
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:13 within `malloc`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:9
; │┌ @ none within `hostcall_device_lock!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %13 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1285, !range !154
; │││││└└
; │││││┌ @ int.jl:1068 within `+` @ int.jl:87
        %14 = add i32 %13, 1, !dbg !1304
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %15 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1307, !range !154
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %16 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1312, !range !154
; │││└└└└
; │││┌ @ operators.jl:276 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:461
; │││││┌ @ promotion.jl:393 within `promote`
; ││││││┌ @ promotion.jl:370 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:787 within `UInt64`
; │││││││││┌ @ boot.jl:761 within `toUInt64`
            %17 = zext i32 %14 to i64, !dbg !1317
; │││││└└└└└
; │││││ @ int.jl:518 within `==` @ promotion.jl:461 @ promotion.jl:521
       %18 = icmp eq i64 %17, 1, !dbg !1333
       %19 = zext i1 %18 to i8, !dbg !1333
; │││││ @ int.jl:518 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %20 = trunc i8 %19 to i1, !dbg !1334
        %21 = and i1 true, %20, !dbg !1334
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %22 = xor i1 %21, true, !dbg !1336
; │││└└
     %23 = zext i1 %22 to i8, !dbg !1294
     %24 = trunc i8 %23 to i1, !dbg !1294
     %25 = xor i1 %24, true, !dbg !1294
     br i1 %25, label %L24, label %L23, !dbg !1294

L23:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L46, !dbg !1338

L24:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; │││┌ @ Base.jl:37 within `getproperty`
      %26 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 0, !dbg !1339
; │││└
     br label %L26, !dbg !1340

L26:                                              ; preds = %L42, %L24
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %unbox17 = load i64, i64 addrspace(5)* %26, align 8, !dbg !1341, !tbaa !352, !alias.scope !356, !noalias !359
       %27 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %unbox17, i64 0, i64 1, i32 4), !dbg !1341
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:521 within `==`
       %28 = icmp eq i64 %27, 0, !dbg !1347
       %29 = zext i1 %28 to i8, !dbg !1347
; ││││└
      %30 = trunc i8 %29 to i1, !dbg !1348
      %31 = xor i1 %30, true, !dbg !1348
      br i1 %31, label %L30, label %L29, !dbg !1348

L29:                                              ; preds = %L26
      br label %L44, !dbg !1348

L30:                                              ; preds = %L26
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:521 within `==`
       %32 = icmp eq i64 %27, 5, !dbg !1349
       %33 = zext i1 %32 to i8, !dbg !1349
; ││││└
      %34 = trunc i8 %33 to i1, !dbg !1350
      %35 = xor i1 %34, true, !dbg !1350
      br i1 %35, label %L34, label %L33, !dbg !1350

L33:                                              ; preds = %L30
      br label %L37, !dbg !1350

L34:                                              ; preds = %L30
; ││││┌ @ promotion.jl:521 within `==`
       %36 = icmp eq i64 %27, 6, !dbg !1349
       %37 = zext i1 %36 to i8, !dbg !1349
; ││││└
      %38 = trunc i8 %37 to i1, !dbg !1350
      %39 = xor i1 %38, true, !dbg !1350
      br i1 %39, label %L42, label %L37, !dbg !1350

L37:                                              ; preds = %L34, %L33
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %state.i24 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1351
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i24, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %5, align 8, !dbg !1351
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %40 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %5, i32 0, i32 0, !dbg !1359
; │││││└└
; │││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
        %41 = bitcast i64 addrspace(5)* %40 to i8* addrspace(5)*, !dbg !1360
        %unbox18 = load i8*, i8* addrspace(5)* %41, align 8, !dbg !1360, !tbaa !352, !alias.scope !356, !noalias !359
        %pointerset_ptr19 = getelementptr inbounds i8, i8* %unbox18, i64 0, !dbg !1360
        %memcpy_refined_dst20 = bitcast i8* %pointerset_ptr19 to i32*, !dbg !1360
        %42 = load i32, i32 addrspace(1)* @_j_const1.3, align 1, !dbg !1360, !tbaa !690, !alias.scope !368, !noalias !369
        store i32 %42, i32* %memcpy_refined_dst20, align 1, !dbg !1360
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !1363
        unreachable, !dbg !1363

L42:                                              ; preds = %L34
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1366
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L26, !dbg !1369

L44:                                              ; preds = %L29
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L45, !dbg !1346

L45:                                              ; preds = %L44
      br label %L46, !dbg !1346

L46:                                              ; preds = %L45, %L23
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1370
; │││└
; │││ @ none within `macro expansion`
     br label %L48, !dbg !1297

L48:                                              ; preds = %L46
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:10
; │┌ @ none within `hostcall_device_write_args!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %43 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1374, !range !154
; │││││└└
; │││││┌ @ int.jl:1068 within `+` @ int.jl:87
        %44 = add i32 %43, 1, !dbg !1384
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %45 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1386, !range !154
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %46 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1390, !range !154
; │││└└└└
; │││┌ @ operators.jl:276 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:461
; │││││┌ @ promotion.jl:393 within `promote`
; ││││││┌ @ promotion.jl:370 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:787 within `UInt64`
; │││││││││┌ @ boot.jl:761 within `toUInt64`
            %47 = zext i32 %44 to i64, !dbg !1394
; │││││└└└└└
; │││││ @ int.jl:518 within `==` @ promotion.jl:461 @ promotion.jl:521
       %48 = icmp eq i64 %47, 1, !dbg !1402
       %49 = zext i1 %48 to i8, !dbg !1402
; │││││ @ int.jl:518 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %50 = trunc i8 %49 to i1, !dbg !1403
        %51 = and i1 true, %50, !dbg !1403
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %52 = xor i1 %51, true, !dbg !1404
; │││└└
     %53 = zext i1 %52 to i8, !dbg !1379
     %54 = trunc i8 %53 to i1, !dbg !1379
     %55 = xor i1 %54, true, !dbg !1379
     br i1 %55, label %L61, label %L60, !dbg !1379

L60:                                              ; preds = %L48
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L71, !dbg !1405

L61:                                              ; preds = %L48
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:91
; │││┌ @ Base.jl:37 within `getproperty`
      %56 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 1, !dbg !1406
; │││└
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:114 within `+`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:100 within `UInt64`
; │││││┌ @ essentials.jl:576 within `reinterpret`
        %bitcast12 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %56, align 8, !dbg !1408, !tbaa !352, !alias.scope !356, !noalias !359
        %bitcast_coercion13 = ptrtoint i8 addrspace(1)* %bitcast12 to i64, !dbg !1408
; ││││└└
      %57 = addrspacecast i8 addrspace(1)* %bitcast12 to i8*, !dbg !1412
      %58 = getelementptr i8, i8* %57, i64 1, !dbg !1412
      %59 = ptrtoint i8* %58 to i64, !dbg !1412
; ││││┌ @ essentials.jl:517 within `oftype`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:102 within `convert`
; ││││││┌ @ essentials.jl:576 within `reinterpret`
         %bitcast_coercion14 = addrspacecast i8* %58 to i8 addrspace(1)*, !dbg !1414
; │││└└└└
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:115 within `-`
; ││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:100 within `UInt64`
; │││││┌ @ essentials.jl:576 within `reinterpret`
        %bitcast_coercion15 = ptrtoint i8 addrspace(1)* %bitcast_coercion14 to i64, !dbg !1419
; ││││└└
      %60 = addrspacecast i8 addrspace(1)* %bitcast_coercion14 to i8*, !dbg !1421
      %61 = getelementptr i8, i8* %60, i64 -1, !dbg !1421
      %62 = ptrtoint i8* %61 to i64, !dbg !1421
; ││││┌ @ essentials.jl:517 within `oftype`
; │││││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:102 within `convert`
; ││││││┌ @ essentials.jl:576 within `reinterpret`
         %bitcast_coercion16 = addrspacecast i8* %61 to i8 addrspace(1)*, !dbg !1423
; │││└└└└
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; ││││┌ @ none within `pointerset`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %63 = bitcast i8 addrspace(1)* %bitcast_coercion16 to i64 addrspace(1)*, !dbg !1426
        store i64 %0, i64 addrspace(1)* %63, align 1, !dbg !1426, !tbaa !757
        br label %L71, !dbg !1426

L71:                                              ; preds = %L61, %L60
; │││└└└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1432
; │││└
; │││ @ none within `macro expansion`
     br label %L73, !dbg !1380

L73:                                              ; preds = %L71
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:11
; │┌ @ none within `hostcall_device_trigger_and_return!`
; ││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:107
     br label %L74, !dbg !1434

L74:                                              ; preds = %L73
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:108
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:55 within `alloc_local` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:55
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        br label %L76, !dbg !1439

L76:                                              ; preds = %L74
; │││└└└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %64 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1449, !range !154
; │││││└└
; │││││┌ @ int.jl:1068 within `+` @ int.jl:87
        %65 = add i32 %64, 1, !dbg !1455
; ││││└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %66 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1457, !range !154
; ││││└└└
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %67 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1461, !range !154
; │││└└└└
; │││┌ @ operators.jl:276 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:461
; │││││┌ @ promotion.jl:393 within `promote`
; ││││││┌ @ promotion.jl:370 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:787 within `UInt64`
; │││││││││┌ @ boot.jl:761 within `toUInt64`
            %68 = zext i32 %65 to i64, !dbg !1465
; │││││└└└└└
; │││││ @ int.jl:518 within `==` @ promotion.jl:461 @ promotion.jl:521
       %69 = icmp eq i64 %68, 1, !dbg !1473
       %70 = zext i1 %69 to i8, !dbg !1473
; │││││ @ int.jl:518 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %71 = trunc i8 %70 to i1, !dbg !1474
        %72 = and i1 true, %71, !dbg !1474
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %73 = xor i1 %72, true, !dbg !1475
; │││└└
     %74 = zext i1 %73 to i8, !dbg !1454
     %75 = trunc i8 %74 to i1, !dbg !1454
     %76 = xor i1 %75, true, !dbg !1454
     br i1 %76, label %L90, label %L89, !dbg !1454

L89:                                              ; preds = %L76
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L153, !dbg !1476

L90:                                              ; preds = %L76
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ Base.jl:37 within `getproperty`
      %77 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 0, !dbg !1477
      br label %L91, !dbg !1477

L91:                                              ; preds = %L107, %L90
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %unbox = load i64, i64 addrspace(5)* %77, align 8, !dbg !1479, !tbaa !352, !alias.scope !356, !noalias !359
       %78 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %unbox, i64 1, i64 2, i32 4), !dbg !1479
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:521 within `==`
       %79 = icmp eq i64 %78, 1, !dbg !1482
       %80 = zext i1 %79 to i8, !dbg !1482
; ││││└
      %81 = trunc i8 %80 to i1, !dbg !1483
      %82 = xor i1 %81, true, !dbg !1483
      br i1 %82, label %L95, label %L94, !dbg !1483

L94:                                              ; preds = %L91
      br label %L109, !dbg !1483

L95:                                              ; preds = %L91
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:521 within `==`
       %83 = icmp eq i64 %78, 5, !dbg !1484
       %84 = zext i1 %83 to i8, !dbg !1484
; ││││└
      %85 = trunc i8 %84 to i1, !dbg !1485
      %86 = xor i1 %85, true, !dbg !1485
      br i1 %86, label %L99, label %L98, !dbg !1485

L98:                                              ; preds = %L95
      br label %L102, !dbg !1485

L99:                                              ; preds = %L95
; ││││┌ @ promotion.jl:521 within `==`
       %87 = icmp eq i64 %78, 6, !dbg !1484
       %88 = zext i1 %87 to i8, !dbg !1484
; ││││└
      %89 = trunc i8 %88 to i1, !dbg !1485
      %90 = xor i1 %89, true, !dbg !1485
      br i1 %90, label %L107, label %L102, !dbg !1485

L102:                                             ; preds = %L99, %L98
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %state.i23 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1486
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i23, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, align 8, !dbg !1486
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %91 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, i32 0, i32 0, !dbg !1492
; │││││└└
; │││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
        %92 = bitcast i64 addrspace(5)* %91 to i8* addrspace(5)*, !dbg !1493
        %unbox9 = load i8*, i8* addrspace(5)* %92, align 8, !dbg !1493, !tbaa !352, !alias.scope !356, !noalias !359
        %pointerset_ptr10 = getelementptr inbounds i8, i8* %unbox9, i64 0, !dbg !1493
        %memcpy_refined_dst11 = bitcast i8* %pointerset_ptr10 to i32*, !dbg !1493
        %93 = load i32, i32 addrspace(1)* @_j_const1.3, align 1, !dbg !1493, !tbaa !690, !alias.scope !368, !noalias !369
        store i32 %93, i32* %memcpy_refined_dst11, align 1, !dbg !1493
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !1495
        unreachable, !dbg !1495

L107:                                             ; preds = %L99
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1497
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L91, !dbg !1499

L109:                                             ; preds = %L94
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!`
      br label %L110, !dbg !1481

L110:                                             ; preds = %L109
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ Base.jl:37 within `getproperty`
      %94 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 0, !dbg !1500
      br label %L111, !dbg !1500

L111:                                             ; preds = %L127, %L110
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %unbox1 = load i64, i64 addrspace(5)* %94, align 8, !dbg !1502, !tbaa !352, !alias.scope !356, !noalias !359
       %95 = call fastcc i64 @__ockl_hsa_signal_load(i64 %unbox1, i32 2), !dbg !1502
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:521 within `==`
       %96 = icmp eq i64 %95, 4, !dbg !1507
       %97 = zext i1 %96 to i8, !dbg !1507
; ││││└
      %98 = trunc i8 %97 to i1, !dbg !1508
      %99 = xor i1 %98, true, !dbg !1508
      br i1 %99, label %L115, label %L114, !dbg !1508

L114:                                             ; preds = %L111
      br label %L129, !dbg !1508

L115:                                             ; preds = %L111
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││┌ @ promotion.jl:521 within `==`
       %100 = icmp eq i64 %95, 5, !dbg !1509
       %101 = zext i1 %100 to i8, !dbg !1509
; ││││└
      %102 = trunc i8 %101 to i1, !dbg !1510
      %103 = xor i1 %102, true, !dbg !1510
      br i1 %103, label %L119, label %L118, !dbg !1510

L118:                                             ; preds = %L115
      br label %L122, !dbg !1510

L119:                                             ; preds = %L115
; ││││┌ @ promotion.jl:521 within `==`
       %104 = icmp eq i64 %95, 6, !dbg !1509
       %105 = zext i1 %104 to i8, !dbg !1509
; ││││└
      %106 = trunc i8 %105 to i1, !dbg !1510
      %107 = xor i1 %106, true, !dbg !1510
      br i1 %107, label %L127, label %L122, !dbg !1510

L122:                                             ; preds = %L119, %L118
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
          %state.i22 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1511
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i22, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, align 8, !dbg !1511
; ││││││└└
; ││││││┌ @ Base.jl:37 within `getproperty`
         %108 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, i32 0, i32 0, !dbg !1517
; │││││└└
; │││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
        %109 = bitcast i64 addrspace(5)* %108 to i8* addrspace(5)*, !dbg !1518
        %unbox6 = load i8*, i8* addrspace(5)* %109, align 8, !dbg !1518, !tbaa !352, !alias.scope !356, !noalias !359
        %pointerset_ptr7 = getelementptr inbounds i8, i8* %unbox6, i64 0, !dbg !1518
        %memcpy_refined_dst8 = bitcast i8* %pointerset_ptr7 to i32*, !dbg !1518
        %110 = load i32, i32 addrspace(1)* @_j_const1.3, align 1, !dbg !1518, !tbaa !690, !alias.scope !368, !noalias !369
        store i32 %110, i32* %memcpy_refined_dst8, align 1, !dbg !1518
; │││││└
; │││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !1520
        unreachable, !dbg !1520

L127:                                             ; preds = %L119
; ││││└└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !1522
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L111, !dbg !1524

L129:                                             ; preds = %L114
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait`
      br label %L130, !dbg !1506

L130:                                             ; preds = %L129
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:118
     br label %L131, !dbg !1525

L131:                                             ; preds = %L130
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:119
; │││┌ @ Base.jl:37 within `getproperty`
      %111 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 1, !dbg !1526
; │││└
; │││┌ @ essentials.jl:576 within `reinterpret`
      %bitcast2 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %111, align 8, !dbg !1528, !tbaa !352, !alias.scope !356, !noalias !359
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:120
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %112 = bitcast i8 addrspace(1)* %bitcast2 to i8 addrspace(1)* addrspace(1)*, !dbg !1529
        %113 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %112, align 1, !dbg !1529, !tbaa !757
; │││└└└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:121
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:100 within `UInt64`
; ││││┌ @ essentials.jl:576 within `reinterpret`
       %bitcast_coercion = ptrtoint i8 addrspace(1)* %113 to i64, !dbg !1538
; │││└└
; │││┌ @ int.jl:518 within `==` @ promotion.jl:521
      %114 = icmp eq i64 %bitcast_coercion, 0, !dbg !1541
      %115 = zext i1 %114 to i8, !dbg !1541
; ││││ @ int.jl:518 within `==`
; ││││┌ @ bool.jl:38 within `&`
       %116 = trunc i8 %115 to i1, !dbg !1543
       %117 = and i1 true, %116, !dbg !1543
; │││└└
     %118 = zext i1 %117 to i8, !dbg !1540
     %119 = trunc i8 %118 to i1, !dbg !1540
     %120 = xor i1 %119, true, !dbg !1540
     br i1 %120, label %L147, label %L139, !dbg !1540

L139:                                             ; preds = %L131
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:122
; │││┌ @ Base.jl:37 within `getproperty`
      %121 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 0, !dbg !1544
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %unbox3 = load i64, i64 addrspace(5)* %121, align 8, !dbg !1546, !tbaa !352, !alias.scope !356, !noalias !359
      %122 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %unbox3, i64 5, i32 3), !dbg !1546
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:123
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:90 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
         %state.i21 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1549
         store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i21, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, align 8, !dbg !1549
; │││││└└
; │││││┌ @ Base.jl:37 within `getproperty`
        %123 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !1555
; ││││└└
; ││││┌ @ pointer.jl:146 within `unsafe_store!` @ pointer.jl:146
       %124 = bitcast i64 addrspace(5)* %123 to i8* addrspace(5)*, !dbg !1556
       %unbox4 = load i8*, i8* addrspace(5)* %124, align 8, !dbg !1556, !tbaa !352, !alias.scope !356, !noalias !359
       %pointerset_ptr = getelementptr inbounds i8, i8* %unbox4, i64 0, !dbg !1556
       %memcpy_refined_dst = bitcast i8* %pointerset_ptr to i32*, !dbg !1556
       %125 = load i32, i32 addrspace(1)* @_j_const1.3, align 1, !dbg !1556, !tbaa !690, !alias.scope !368, !noalias !369
       store i32 %125, i32* %memcpy_refined_dst, align 1, !dbg !1556
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:92 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !1558
; │││└└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:124
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
      unreachable, !dbg !1560

L147:                                             ; preds = %L131
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:126
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %126 = bitcast i8 addrspace(1)* %113 to i64 addrspace(1)*, !dbg !1563
        %127 = load i64, i64 addrspace(1)* %126, align 1, !dbg !1563, !tbaa !757
; │││└└└
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:88
; ││││┌ @ none within `pointerset`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %128 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1570
        store i64 %127, i64 addrspace(3)* %128, align 1, !dbg !1570, !tbaa !1278
        br label %L151, !dbg !1570

L151:                                             ; preds = %L147
; │││└└└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; │││┌ @ Base.jl:37 within `getproperty`
      %129 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %pointerref, i32 0, i32 0, !dbg !1576
; │││└
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %unbox5 = load i64, i64 addrspace(5)* %129, align 8, !dbg !1578, !tbaa !352, !alias.scope !356, !noalias !359
      %130 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %unbox5, i64 0, i32 3), !dbg !1578
      br label %L153, !dbg !1578

L153:                                             ; preds = %L151, %L89
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !1580
; │││└
; │││ @ none within `macro expansion` @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:131
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 within `unsafe_load` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85 @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl:85
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
        %131 = bitcast i8 addrspace(3)* bitcast ([1 x i64] addrspace(3)* @alloc_special_hostcall_return to i8 addrspace(3)*) to i64 addrspace(3)*, !dbg !1582
        %132 = load i64, i64 addrspace(3)* %131, align 1, !dbg !1582, !tbaa !1278
; │││└└└
     br label %L157, !dbg !1588

L157:                                             ; preds = %L153
; │└└
   br label %L158, !dbg !1438

L158:                                             ; preds = %L157
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:3 within `hostcall!`
   br label %L159, !dbg !1302

L159:                                             ; preds = %L158
; └
  ret i64 %132, !dbg !1303
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: convergent norecurse nounwind
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #10 {
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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !1589
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !1595
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
declare void @llvm.amdgcn.s.sleep(i32 immarg) #11

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #12

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #13 {
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
define internal void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #10 {
  %4 = inttoptr i64 %0 to %0 addrspace(1)*
  %5 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 0
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !1596
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !1589
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %63, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !1595
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %63

24:                                               ; preds = %3
  %25 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !1597
  %26 = icmp sgt i32 %25, 8999
  br i1 %26, label %27, label %31

27:                                               ; preds = %24
  %28 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %29 = bitcast %1 addrspace(1)* %28 to i64 addrspace(1)* addrspace(1)*
  %30 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %29, align 8, !tbaa !1598
  store atomic i64 %1, i64 addrspace(1)* %30 syncscope("one-as") release, align 8
  br label %63

31:                                               ; preds = %24
  %32 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 7, i32 0
  %33 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %32, align 16, !tbaa !1598
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
  %43 = load volatile i64, i64 addrspace(1)* %42, align 16, !tbaa !1599
  %44 = icmp ugt i64 %41, %43
  br i1 %44, label %45, label %62

45:                                               ; preds = %40
  store atomic i64 %41, i64 addrspace(1)* %42 syncscope("one-as") monotonic, align 16
  %46 = icmp slt i32 %25, 8000
  br i1 %46, label %47, label %56

47:                                               ; preds = %45
  %48 = trunc i64 %41 to i32
  %49 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 0, i32 4
  %50 = load i32, i32 addrspace(1)* %49, align 8, !tbaa !1604
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
  %61 = load i32 addrspace(1)*, i32 addrspace(1)* addrspace(1)* %60, align 8, !tbaa !1598
  store volatile i32 %58, i32 addrspace(1)* %61, align 4, !tbaa !1597
  br label %62

62:                                               ; preds = %56, %40
  store atomic i32 0, i32 addrspace(1)* %34 syncscope("one-as") release, align 4
  br label %63

63:                                               ; preds = %62, %27, %17, %13
  ret void
}

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #14

; Function Attrs: nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #15

;  @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:385 within `llvm_atomic_cas`
define internal fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef nonnull sret({ i64, i8 }) align 8 dereferenceable(16) %0, i8 addrspace(1)* %1, i64 zeroext %2, i64 zeroext %3) unnamed_addr !dbg !1605 {
top:
  %newstruct2 = alloca { i64, i8 }, align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
; ┌ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:458 within `macro expansion`
; │┌ @ refpointer.jl:138 within `Ref`
; ││┌ @ refvalue.jl:7 within `RefValue`
     %7 = bitcast {}*** %4 to {}**, !dbg !1606
     %current_task1 = getelementptr inbounds {}*, {}** %7, i64 -14, !dbg !1606
     %newstruct = call noalias nonnull dereferenceable(1) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 1, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711468522128 to {}*) to {} addrspace(10)*)) #6, !dbg !1606
     %8 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !1606
; │└└
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:459 within `macro expansion`
   %9 = call token (...) @llvm.julia.gc_preserve_begin({} addrspace(10)* %newstruct), !dbg !1613
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:460 within `macro expansion`
; │┌ @ pointer.jl:270 within `pointer_from_objref`
    %10 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !1614
    %11 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %10) #3, !dbg !1614
; │└
; │┌ @ boot.jl:798 within `Ptr`
    %bitcast_coercion = ptrtoint {}* %11 to i64, !dbg !1617
; │└
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
   %12 = bitcast i8 addrspace(1)* %1 to i64 addrspace(1)*, !dbg !1619
   %13 = inttoptr i64 %bitcast_coercion to i8*, !dbg !1619
   %14 = cmpxchg i64 addrspace(1)* %12, i64 %2, i64 %3 acq_rel acquire, align 8, !dbg !1619
   %15 = extractvalue { i64, i1 } %14, 0, !dbg !1619
   %16 = extractvalue { i64, i1 } %14, 1, !dbg !1619
   %17 = zext i1 %16 to i8, !dbg !1619
   store i8 %17, i8* %13, align 1, !dbg !1619
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:461 within `macro expansion`
   call void @llvm.julia.gc_preserve_end(token %9), !dbg !1621
; │ @ /home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl:463 within `macro expansion`
; │┌ @ refvalue.jl:59 within `getindex`
; ││┌ @ Base.jl:37 within `getproperty`
     %18 = addrspacecast {} addrspace(10)* %newstruct to {} addrspace(11)*, !dbg !1622
     %19 = bitcast {} addrspace(11)* %18 to i8 addrspace(11)*, !dbg !1622
     %20 = load i8, i8 addrspace(11)* %19, align 1, !dbg !1622, !tbaa !635, !alias.scope !368, !noalias !369
; │└└
; │┌ @ operators.jl:276 within `!=`
; ││┌ @ promotion.jl:521 within `==`
     %21 = icmp eq i8 %20, 0, !dbg !1627
     %22 = zext i1 %21 to i8, !dbg !1627
; ││└
; ││┌ @ bool.jl:35 within `!`
     %23 = trunc i8 %22 to i1, !dbg !1631
     %24 = xor i1 %23, true, !dbg !1631
; │└└
; │┌ @ boot.jl:620 within `NamedTuple`
    %25 = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %newstruct2, i32 0, i32 0, !dbg !1633
    store i64 %15, i64 addrspace(5)* %25, align 8, !dbg !1633, !tbaa !352, !alias.scope !356, !noalias !359
    %26 = getelementptr inbounds { i64, i8 }, { i64, i8 } addrspace(5)* %newstruct2, i32 0, i32 1, !dbg !1633
    %27 = zext i1 %24 to i8, !dbg !1633
    store i8 %27, i8 addrspace(5)* %26, align 8, !dbg !1633, !tbaa !352, !alias.scope !356, !noalias !359
; │└
   %28 = bitcast { i64, i8 } addrspace(5)* %0 to i8 addrspace(5)*, !dbg !1626
   %29 = bitcast { i64, i8 } addrspace(5)* %newstruct2 to i8 addrspace(5)*, !dbg !1626
   call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %28, i8 addrspace(5)* %29, i64 16, i1 false), !dbg !1626
   ret void, !dbg !1626
; └
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2625({ i64, i8 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1) unnamed_addr !dbg !1635 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
  %5 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2623({ i64, i8 } addrspace(11)* nocapture readonly %0, i64 signext %1, i64 signext 1), !dbg !1636
  ret {} addrspace(10)* %5, !dbg !1636
}

;  @ namedtuple.jl:175 within `indexed_iterate`
define internal fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2623({ i64, i8 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(16) %0, i64 signext %1, i64 signext %2) unnamed_addr !dbg !1637 {
top:
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
  %6 = sub i64 %1, 1, !dbg !1638
  %7 = bitcast {}*** %3 to {}**, !dbg !1638
  %current_task1 = getelementptr inbounds {}*, {}** %7, i64 -14, !dbg !1638
  %box = call noalias nonnull dereferenceable(16) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 16, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711467825360 to {}*) to {} addrspace(10)*)) #6, !dbg !1638
  %8 = bitcast {} addrspace(10)* %box to i8 addrspace(10)*, !dbg !1638
  %9 = bitcast { i64, i8 } addrspace(11)* %0 to i8 addrspace(11)*, !dbg !1638
  call void @llvm.memcpy.p10i8.p11i8.i64(i8 addrspace(10)* align 8 %8, i8 addrspace(11)* %9, i64 16, i1 false), !dbg !1638, !tbaa !695, !alias.scope !696, !noalias !697
  %10 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %box, i64 %6), !dbg !1638
; ┌ @ int.jl:87 within `+`
   %11 = add i64 %1, 1, !dbg !1639
; └
  %12 = call fastcc nonnull {} addrspace(10)* @ijl_box_int64(i64 signext %11), !dbg !1638
  %13 = call nonnull {} addrspace(10)* ({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)*, {} addrspace(10)*, ...) @julia.call({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)* @jl_f_tuple, {} addrspace(10)* null, {} addrspace(10)* %10, {} addrspace(10)* %12), !dbg !1638
  ret {} addrspace(10)* %13, !dbg !1638
}

;  @ number.jl:42 within `iszero`
define internal fastcc i8 @julia_iszero_2537(i64 zeroext %0) unnamed_addr !dbg !1641 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_zero_2540(i64 zeroext %0), !dbg !1642
; ┌ @ promotion.jl:521 within `==`
   %5 = icmp eq i64 %0, %4, !dbg !1643
   %6 = zext i1 %5 to i8, !dbg !1643
; └
  ret i8 %6, !dbg !1642
}

;  @ promotion.jl:461 within `==`
define internal fastcc i8 @julia____2606(i64 zeroext %0, i8 zeroext %1) unnamed_addr !dbg !1645 {
top:
  %2 = alloca [2 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
  call fastcc void @julia_promote_2609([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %2, i64 zeroext %0, i8 zeroext %1), !dbg !1646
  %6 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !1646
  %7 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %2, i32 0, i32 1, !dbg !1646
;  @ promotion.jl:461 within `==` @ promotion.jl:521
  %unbox = load i64, i64 addrspace(5)* %6, align 8, !dbg !1647, !tbaa !352, !alias.scope !356, !noalias !359
  %unbox1 = load i64, i64 addrspace(5)* %7, align 8, !dbg !1647, !tbaa !352, !alias.scope !356, !noalias !359
  %8 = icmp eq i64 %unbox, %unbox1, !dbg !1647
  %9 = zext i1 %8 to i8, !dbg !1647
;  @ promotion.jl:461 within `==`
  ret i8 %9, !dbg !1646
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #7

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:13 within `err_buffer!`
; Function Attrs: noreturn
define internal fastcc void @julia_err_buffer__2595() unnamed_addr #8 !dbg !1649 {
top:
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:14 within `err_buffer!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1650
    store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8, !dbg !1650
; └└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:15 within `err_buffer!`
; ┌ @ Base.jl:37 within `getproperty`
   %4 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 2, !dbg !1657
; └
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast = load i64, i64 addrspace(5)* %4, align 8, !dbg !1660, !tbaa !352, !alias.scope !356, !noalias !359
   %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !1660
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:16 within `err_buffer!`
  %5 = bitcast {}*** %1 to {}**, !dbg !1662
  %current_task1 = getelementptr inbounds {}*, {}** %5, i64 -14, !dbg !1662
  %box = call noalias nonnull dereferenceable(8) {} addrspace(10)* @julia.gc_alloc_obj({}** %current_task1, i64 8, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711466702416 to {}*) to {} addrspace(10)*)) #6, !dbg !1662
  %6 = bitcast {} addrspace(10)* %box to i8 addrspace(1)* addrspace(10)*, !dbg !1662
  store i8 addrspace(1)* %bitcast_coercion, i8 addrspace(1)* addrspace(10)* %6, align 8, !dbg !1662, !tbaa !690, !alias.scope !368, !noalias !369
  %7 = call nonnull {} addrspace(10)* ({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)*, {} addrspace(10)*, ...) @julia.call({} addrspace(10)* ({} addrspace(10)*, {} addrspace(10)**, i32)* @ijl_apply_generic, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140712826536560 to {}*) to {} addrspace(10)*), {} addrspace(10)* %box, {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714619133632 to {}*) to {} addrspace(10)*), {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714841350448 to {}*) to {} addrspace(10)*), {} addrspace(10)* addrspacecast ({}* inttoptr (i64 140711540654808 to {}*) to {} addrspace(10)*)), !dbg !1662
  call void @llvm.trap(), !dbg !1662
  unreachable, !dbg !1662
}

;  @ promotion.jl:391 within `promote`
define internal fastcc void @julia_promote_2609([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !1663 {
top:
  %3 = alloca [2 x i64], align 8, addrspace(5)
  %newstruct = alloca [2 x i64], align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
;  @ promotion.jl:393 within `promote`
  call fastcc void @julia__promote_2612([2 x i64] addrspace(5)* noalias nocapture noundef sret([2 x i64]) %3, i64 zeroext %1, i8 zeroext %2), !dbg !1664
; ┌ @ tuple.jl:92 within `indexed_iterate` @ tuple.jl:92
   %memcpy_refined_src = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !1665
; │ @ tuple.jl:92 within `indexed_iterate`
   %memcpy_refined_src1 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %3, i32 0, i32 1, !dbg !1667
; └
;  @ promotion.jl:395 within `promote`
  %memcpy_refined_dst = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 0, !dbg !1668
  %7 = load i64, i64 addrspace(5)* %memcpy_refined_src, align 8, !dbg !1668, !tbaa !352, !alias.scope !356, !noalias !359
  store i64 %7, i64 addrspace(5)* %memcpy_refined_dst, align 8, !dbg !1668, !tbaa !352, !alias.scope !356, !noalias !359
  %memcpy_refined_dst2 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 1, !dbg !1668
  %8 = load i64, i64 addrspace(5)* %memcpy_refined_src1, align 8, !dbg !1668, !tbaa !352, !alias.scope !356, !noalias !359
  store i64 %8, i64 addrspace(5)* %memcpy_refined_dst2, align 8, !dbg !1668, !tbaa !352, !alias.scope !356, !noalias !359
  %9 = bitcast [2 x i64] addrspace(5)* %0 to i8 addrspace(5)*, !dbg !1668
  %10 = bitcast [2 x i64] addrspace(5)* %newstruct to i8 addrspace(5)*, !dbg !1668
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %9, i8 addrspace(5)* %10, i64 16, i1 false), !dbg !1668
  ret void, !dbg !1668
}

;  @ promotion.jl:367 within `_promote`
define internal fastcc void @julia__promote_2612([2 x i64] addrspace(5)* noalias nocapture noundef nonnull sret([2 x i64]) align 8 dereferenceable(16) %0, i64 zeroext %1, i8 zeroext %2) unnamed_addr !dbg !1669 {
top:
  %newstruct = alloca [2 x i64], align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ promotion.jl:370 within `_promote`
  %6 = call fastcc i64 @julia_convert_2615(i8 zeroext %2), !dbg !1670
  %7 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 0, !dbg !1670
  store i64 %1, i64 addrspace(5)* %7, align 8, !dbg !1670, !tbaa !352, !alias.scope !356, !noalias !359
  %8 = getelementptr inbounds [2 x i64], [2 x i64] addrspace(5)* %newstruct, i32 0, i32 1, !dbg !1670
  store i64 %6, i64 addrspace(5)* %8, align 8, !dbg !1670, !tbaa !352, !alias.scope !356, !noalias !359
  %9 = bitcast [2 x i64] addrspace(5)* %0 to i8 addrspace(5)*, !dbg !1670
  %10 = bitcast [2 x i64] addrspace(5)* %newstruct to i8 addrspace(5)*, !dbg !1670
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 8 %9, i8 addrspace(5)* %10, i64 16, i1 false), !dbg !1670
  ret void, !dbg !1670
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2615(i8 zeroext %0) unnamed_addr !dbg !1671 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_UInt64_2618(i8 zeroext %0), !dbg !1672
  ret i64 %4, !dbg !1672
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2618(i8 zeroext %0) unnamed_addr !dbg !1673 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_toUInt64_2621(i8 zeroext %0), !dbg !1674
  ret i64 %4, !dbg !1674
}

;  @ boot.jl:764 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2621(i8 zeroext %0) unnamed_addr !dbg !1675 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = trunc i8 %0 to i1, !dbg !1676
  %5 = zext i1 %4 to i64, !dbg !1676
  %6 = and i64 %5, 1, !dbg !1676
  ret i64 %6, !dbg !1676
}

;  @ number.jl:308 within `zero`
define internal fastcc i64 @julia_zero_2540(i64 zeroext %0) unnamed_addr !dbg !1677 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_oftype_2543(i64 zeroext %0, i64 signext 0), !dbg !1678
  ret i64 %4, !dbg !1678
}

;  @ essentials.jl:517 within `oftype`
define internal fastcc i64 @julia_oftype_2543(i64 zeroext %0, i64 signext %1) unnamed_addr !dbg !1679 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
  %5 = call fastcc i64 @julia_convert_2546(i64 signext %1), !dbg !1680
  ret i64 %5, !dbg !1680
}

;  @ number.jl:7 within `convert`
define internal fastcc i64 @julia_convert_2546(i64 signext %0) unnamed_addr !dbg !1681 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_UInt64_2549(i64 signext %0), !dbg !1682
  ret i64 %4, !dbg !1682
}

;  @ boot.jl:787 within `UInt64`
define internal fastcc i64 @julia_UInt64_2549(i64 signext %0) unnamed_addr !dbg !1683 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_toUInt64_2552(i64 signext %0), !dbg !1684
  ret i64 %4, !dbg !1684
}

;  @ boot.jl:757 within `toUInt64`
define internal fastcc i64 @julia_toUInt64_2552(i64 signext %0) unnamed_addr !dbg !1685 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %4 = call fastcc i64 @julia_check_top_bit_2555(i64 signext %0), !dbg !1686
  ret i64 %4, !dbg !1686
}

;  @ boot.jl:644 within `check_top_bit`
define internal fastcc i64 @julia_check_top_bit_2555(i64 signext %0) unnamed_addr !dbg !1687 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ boot.jl:646 within `check_top_bit`
; ┌ @ boot.jl:636 within `is_top_bit_set`
   %4 = lshr i64 %0, 63, !dbg !1688
   %5 = select i1 false, i64 0, i64 %4, !dbg !1688
   %6 = trunc i64 %5 to i8, !dbg !1688
   %7 = icmp eq i8 %6, 1, !dbg !1688
; └
  %8 = zext i1 %7 to i8, !dbg !1690
  %9 = trunc i8 %8 to i1, !dbg !1690
  %10 = xor i1 %9, true, !dbg !1690
  br i1 %10, label %L7, label %L5, !dbg !1690

L5:                                               ; preds = %top
  call fastcc void @julia__throw_inexacterror_2558({} addrspace(10)* addrspacecast ({}* inttoptr (i64 140714842730016 to {}*) to {} addrspace(10)*), i64 signext %0) #8, !dbg !1690
  unreachable, !dbg !1690

L7:                                               ; preds = %top
;  @ boot.jl:647 within `check_top_bit`
  ret i64 %0, !dbg !1691
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:40 within `#throw_inexacterror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_inexacterror_2558({} addrspace(10)* noundef nonnull %0, i64 signext %1) unnamed_addr #1 !dbg !1692 {
top:
  %2 = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %2 to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:7 within `#throw_inexacterror`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:333 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %5 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1693, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %6 = add i32 %5, 1, !dbg !1706
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %7 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1709, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %8 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1714, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %9 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1719, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %10 = add i32 %9, 1, !dbg !1726
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %11 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1728, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %12 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1733, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %13 = sub i32 %10, 1, !dbg !1738
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %14 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1740
       %15 = getelementptr inbounds i8, i8 addrspace(4)* %14, i64 4, !dbg !1740
       %16 = bitcast i8 addrspace(4)* %15 to i16 addrspace(4)*, !dbg !1740
       %17 = load i16, i16 addrspace(4)* %16, align 2, !dbg !1740, !range !199
       %18 = zext i16 %17 to i32, !dbg !1740
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %19 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1748
       %20 = getelementptr inbounds i8, i8 addrspace(4)* %19, i64 6, !dbg !1748
       %21 = bitcast i8 addrspace(4)* %20 to i16 addrspace(4)*, !dbg !1748
       %22 = load i16, i16 addrspace(4)* %21, align 2, !dbg !1748, !range !199
       %23 = zext i16 %22 to i32, !dbg !1748
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %24 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1753
       %25 = getelementptr inbounds i8, i8 addrspace(4)* %24, i64 8, !dbg !1753
       %26 = bitcast i8 addrspace(4)* %25 to i16 addrspace(4)*, !dbg !1753
       %27 = load i16, i16 addrspace(4)* %26, align 2, !dbg !1753, !range !199
       %28 = zext i16 %27 to i32, !dbg !1753
; │└└└└
; │┌ @ int.jl:88 within `*`
    %29 = mul i32 %13, %18, !dbg !1758
; │└
; │┌ @ int.jl:87 within `+`
    %30 = add i32 %6, %29, !dbg !1760
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:334 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %31 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1761, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %32 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1767, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %33 = add i32 %32, 1, !dbg !1771
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %34 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1773, !range !154
; │└└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %35 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1777, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %36 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1782, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %37 = add i32 %36, 1, !dbg !1786
; ││└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %38 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1788, !range !176
; │└└└└
; │┌ @ int.jl:86 within `-`
    %39 = sub i32 %37, 1, !dbg !1792
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %40 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1793
       %41 = getelementptr inbounds i8, i8 addrspace(4)* %40, i64 4, !dbg !1793
       %42 = bitcast i8 addrspace(4)* %41 to i16 addrspace(4)*, !dbg !1793
       %43 = load i16, i16 addrspace(4)* %42, align 2, !dbg !1793, !range !199
       %44 = zext i16 %43 to i32, !dbg !1793
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %45 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1798
       %46 = getelementptr inbounds i8, i8 addrspace(4)* %45, i64 6, !dbg !1798
       %47 = bitcast i8 addrspace(4)* %46 to i16 addrspace(4)*, !dbg !1798
       %48 = load i16, i16 addrspace(4)* %47, align 2, !dbg !1798, !range !199
       %49 = zext i16 %48 to i32, !dbg !1798
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %50 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1802
       %51 = getelementptr inbounds i8, i8 addrspace(4)* %50, i64 8, !dbg !1802
       %52 = bitcast i8 addrspace(4)* %51 to i16 addrspace(4)*, !dbg !1802
       %53 = load i16, i16 addrspace(4)* %52, align 2, !dbg !1802, !range !199
       %54 = zext i16 %53 to i32, !dbg !1802
; │└└└└
; │┌ @ int.jl:88 within `*`
    %55 = mul i32 %39, %49, !dbg !1806
; │└
; │┌ @ int.jl:87 within `+`
    %56 = add i32 %33, %55, !dbg !1807
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:335 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %57 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !1808, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %58 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !1814, !range !154
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %59 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !1818, !range !154
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %60 = add i32 %59, 1, !dbg !1822
; │└└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %61 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !1824, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %62 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !1829, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %63 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !1833, !range !176
; │││└└
; │││┌ @ int.jl:1068 within `+` @ int.jl:87
      %64 = add i32 %63, 1, !dbg !1837
; │└└└
; │┌ @ int.jl:86 within `-`
    %65 = sub i32 %64, 1, !dbg !1839
; │└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:138 within `workgroupDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %66 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1840
       %67 = getelementptr inbounds i8, i8 addrspace(4)* %66, i64 4, !dbg !1840
       %68 = bitcast i8 addrspace(4)* %67 to i16 addrspace(4)*, !dbg !1840
       %69 = load i16, i16 addrspace(4)* %68, align 2, !dbg !1840, !range !199
       %70 = zext i16 %69 to i32, !dbg !1840
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %71 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1845
       %72 = getelementptr inbounds i8, i8 addrspace(4)* %71, i64 6, !dbg !1845
       %73 = bitcast i8 addrspace(4)* %72 to i16 addrspace(4)*, !dbg !1845
       %74 = load i16, i16 addrspace(4)* %73, align 2, !dbg !1845, !range !199
       %75 = zext i16 %74 to i32, !dbg !1845
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:101 within `workgroupDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %76 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1849
       %77 = getelementptr inbounds i8, i8 addrspace(4)* %76, i64 8, !dbg !1849
       %78 = bitcast i8 addrspace(4)* %77 to i16 addrspace(4)*, !dbg !1849
       %79 = load i16, i16 addrspace(4)* %78, align 2, !dbg !1849, !range !199
       %80 = zext i16 %79 to i32, !dbg !1849
; │└└└└
; │┌ @ int.jl:88 within `*`
    %81 = mul i32 %65, %80, !dbg !1853
; │└
; │┌ @ int.jl:87 within `+`
    %82 = add i32 %60, %81, !dbg !1854
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:336 within `macro expansion`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %83 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1855
       %84 = getelementptr inbounds i8, i8 addrspace(4)* %83, i64 12, !dbg !1855
       %85 = bitcast i8 addrspace(4)* %84 to i32 addrspace(4)*, !dbg !1855
       %86 = load i32, i32 addrspace(4)* %85, align 4, !dbg !1855, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %87 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1863
       %88 = getelementptr inbounds i8, i8 addrspace(4)* %87, i64 16, !dbg !1863
       %89 = bitcast i8 addrspace(4)* %88 to i32 addrspace(4)*, !dbg !1863
       %90 = load i32, i32 addrspace(4)* %89, align 4, !dbg !1863, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %91 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1868
       %92 = getelementptr inbounds i8, i8 addrspace(4)* %91, i64 20, !dbg !1868
       %93 = bitcast i8 addrspace(4)* %92 to i32 addrspace(4)*, !dbg !1868
       %94 = load i32, i32 addrspace(4)* %93, align 4, !dbg !1868, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %95 = zext i32 %86 to i64, !dbg !1873
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:146 within `gridItemDim`
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_x`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %96 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1855
       %97 = getelementptr inbounds i8, i8 addrspace(4)* %96, i64 12, !dbg !1855
       %98 = bitcast i8 addrspace(4)* %97 to i32 addrspace(4)*, !dbg !1855
       %99 = load i32, i32 addrspace(4)* %98, align 4, !dbg !1855, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_y`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %100 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1863
       %101 = getelementptr inbounds i8, i8 addrspace(4)* %100, i64 16, !dbg !1863
       %102 = bitcast i8 addrspace(4)* %101 to i32 addrspace(4)*, !dbg !1863
       %103 = load i32, i32 addrspace(4)* %102, align 4, !dbg !1863, !range !176
; ││└└└
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:108 within `gridItemDim_z`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `_dim`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:32 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
       %104 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr(), !dbg !1868
       %105 = getelementptr inbounds i8, i8 addrspace(4)* %104, i64 20, !dbg !1868
       %106 = bitcast i8 addrspace(4)* %105 to i32 addrspace(4)*, !dbg !1868
       %107 = load i32, i32 addrspace(4)* %106, align 4, !dbg !1868, !range !176
; │└└└└
; │┌ @ boot.jl:787 within `UInt64`
; ││┌ @ boot.jl:761 within `toUInt64`
     %108 = zext i32 %103 to i64, !dbg !1873
     %109 = zext i32 %30 to i64, !dbg !1873
     %110 = zext i32 %56 to i64, !dbg !1873
     %111 = zext i32 %82 to i64, !dbg !1873
; │└└
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:327 within `_to_linear`
; ││┌ @ int.jl:1068 within `-` @ int.jl:86
     %112 = sub i64 %110, 1, !dbg !1877
     %113 = sub i64 %111, 1, !dbg !1877
; ││└
; ││┌ @ int.jl:88 within `*`
     %114 = mul i64 %113, %108, !dbg !1881
; ││└
; ││┌ @ int.jl:87 within `+`
     %115 = add i64 %112, %114, !dbg !1882
; ││└
; ││┌ @ int.jl:88 within `*`
     %116 = mul i64 %95, %115, !dbg !1881
; ││└
; ││┌ @ int.jl:87 within `+`
     %117 = add i64 %109, %116, !dbg !1882
; │└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:339 within `macro expansion`
   %118 = call fastcc i8 @julia_gate__2598(i64 zeroext %117), !dbg !1883
   %119 = trunc i8 %118 to i1, !dbg !1883
   %120 = xor i1 %119, true, !dbg !1883
   br i1 %120, label %L97, label %L95, !dbg !1883

L95:                                              ; preds = %top
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl:351 within `macro expansion`
   call fastcc void @julia_err_buffer__2595() #8, !dbg !1884
   unreachable, !dbg !1884

L97:                                              ; preds = %top
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !1885
  call fastcc void @gpu_signal_exception(), !dbg !1885
  call void @llvm.trap(), !dbg !1885
  unreachable, !dbg !1885
}

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `gate!`
define internal fastcc i8 @julia_gate__2598(i64 zeroext %0) unnamed_addr !dbg !1886 {
top:
  %1 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %2 = alloca { i64, i8 }, align 8, addrspace(5)
  %3 = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %3 to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:38 within `gate!`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
    %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !1887
    store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, align 8, !dbg !1887
; └└
; ┌ @ Base.jl:37 within `getproperty`
   %6 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !1894
; └
; ┌ @ essentials.jl:576 within `reinterpret`
   %bitcast = load i64, i64 addrspace(5)* %6, align 8, !dbg !1896, !tbaa !352, !alias.scope !356, !noalias !359
   %bitcast_coercion = inttoptr i64 %bitcast to i8 addrspace(1)*, !dbg !1896
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:39 within `gate!`
  call fastcc void @julia_llvm_atomic_cas_2628({ i64, i8 } addrspace(5)* noalias nocapture noundef sret({ i64, i8 }) %2, i8 addrspace(1)* %bitcast_coercion, i64 zeroext 0, i64 zeroext %0), !dbg !1898
  %7 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !1898
  %8 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2625({ i64, i8 } addrspace(11)* nocapture readonly %7, i64 signext 1), !dbg !1898
  %9 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %8, i64 0), !dbg !1898
  %10 = call {} addrspace(10)* @ijl_get_nth_field_checked({} addrspace(10)* %8, i64 1), !dbg !1898
  %11 = addrspacecast { i64, i8 } addrspace(5)* %2 to { i64, i8 } addrspace(11)*, !dbg !1898
  %12 = bitcast {} addrspace(10)* %10 to i64 addrspace(10)*, !dbg !1898
  %unbox = load i64, i64 addrspace(10)* %12, align 8, !dbg !1898, !tbaa !365, !alias.scope !368, !noalias !369
  %13 = call fastcc nonnull {} addrspace(10)* @julia_indexed_iterate_2623({ i64, i8 } addrspace(11)* nocapture readonly %11, i64 signext 2, i64 signext %unbox), !dbg !1898
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:44 within `gate!`
  %14 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !1899
  %15 = addrspacecast {} addrspace(10)* %14 to {} addrspace(11)*, !dbg !1899
  %16 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %15) #3, !dbg !1899
  %typeof = ptrtoint {}* %16 to i64, !dbg !1899
  %exactly_isa = icmp eq i64 %typeof, 192, !dbg !1899
  %17 = zext i1 %exactly_isa to i8, !dbg !1899
  %18 = trunc i8 %17 to i1, !dbg !1899
  %19 = xor i1 %18, true, !dbg !1899
  br i1 %19, label %L16, label %L13, !dbg !1899

L13:                                              ; preds = %top
; ┌ @ bool.jl:155 within `iszero`
; │┌ @ bool.jl:35 within `!`
    %20 = bitcast {} addrspace(10)* %9 to i8 addrspace(10)*, !dbg !1900
    %unbox1 = load i8, i8 addrspace(10)* %20, align 1, !dbg !1900, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
    %21 = trunc i8 %unbox1 to i1, !dbg !1900
    %22 = xor i1 %21, true, !dbg !1900
    %23 = zext i1 %22 to i8
; └└
  br label %L23, !dbg !1899

L16:                                              ; preds = %top
  %24 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !1899
  %25 = addrspacecast {} addrspace(10)* %24 to {} addrspace(11)*, !dbg !1899
  %26 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %25) #3, !dbg !1899
  %typeof9 = ptrtoint {}* %26 to i64, !dbg !1899
  %exactly_isa10 = icmp eq i64 %typeof9, 320, !dbg !1899
  %27 = zext i1 %exactly_isa10 to i8, !dbg !1899
  %28 = trunc i8 %27 to i1, !dbg !1899
  %29 = xor i1 %28, true, !dbg !1899
  br i1 %29, label %L21, label %L18, !dbg !1899

L18:                                              ; preds = %L16
  %30 = bitcast {} addrspace(10)* %9 to i64 addrspace(10)*, !dbg !1899
  %unbox11 = load i64, i64 addrspace(10)* %30, align 8, !dbg !1899, !tbaa !365, !alias.scope !368, !noalias !369
  %31 = call fastcc i8 @julia_iszero_2537(i64 zeroext %unbox11), !dbg !1899
  br label %L23, !dbg !1899

L21:                                              ; preds = %L16
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !1899
  call fastcc void @gpu_signal_exception(), !dbg !1899
  call void @llvm.trap(), !dbg !1899
  unreachable, !dbg !1899

L23:                                              ; preds = %L18, %L13
  %value_phi = phi i8 [ %23, %L13 ], [ %31, %L18 ]
  %32 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !1899
  %33 = addrspacecast {} addrspace(10)* %32 to {} addrspace(11)*, !dbg !1899
  %34 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %33) #3, !dbg !1899
  %typeof2 = ptrtoint {}* %34 to i64, !dbg !1899
  %exactly_isa3 = icmp eq i64 %typeof2, 192, !dbg !1899
  %35 = zext i1 %exactly_isa3 to i8, !dbg !1899
  %36 = trunc i8 %35 to i1, !dbg !1899
  %37 = xor i1 %36, true, !dbg !1899
  br i1 %37, label %L30, label %L27, !dbg !1899

L27:                                              ; preds = %L23
  %38 = bitcast {} addrspace(10)* %9 to i8 addrspace(10)*, !dbg !1899
  %unbox4 = load i8, i8 addrspace(10)* %38, align 1, !dbg !1899, !tbaa !365, !range !376, !alias.scope !368, !noalias !369
  %39 = call fastcc i8 @julia____2606(i64 zeroext %0, i8 zeroext %unbox4), !dbg !1899
  br label %L37, !dbg !1899

L30:                                              ; preds = %L23
  %40 = call {} addrspace(10)* @julia.typeof({} addrspace(10)* %9), !dbg !1899
  %41 = addrspacecast {} addrspace(10)* %40 to {} addrspace(11)*, !dbg !1899
  %42 = call nonnull {}* @julia.pointer_from_objref({} addrspace(11)* %41) #3, !dbg !1899
  %typeof6 = ptrtoint {}* %42 to i64, !dbg !1899
  %exactly_isa7 = icmp eq i64 %typeof6, 320, !dbg !1899
  %43 = zext i1 %exactly_isa7 to i8, !dbg !1899
  %44 = trunc i8 %43 to i1, !dbg !1899
  %45 = xor i1 %44, true, !dbg !1899
  br i1 %45, label %L35, label %L32, !dbg !1899

L32:                                              ; preds = %L30
; ┌ @ promotion.jl:521 within `==`
   %46 = bitcast {} addrspace(10)* %9 to i64 addrspace(10)*, !dbg !1904
   %unbox8 = load i64, i64 addrspace(10)* %46, align 8, !dbg !1904, !tbaa !365, !alias.scope !368, !noalias !369
   %47 = icmp eq i64 %0, %unbox8, !dbg !1904
   %48 = zext i1 %47 to i8, !dbg !1904
; └
  br label %L37, !dbg !1899

L35:                                              ; preds = %L30
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.6.12 to i64)), !dbg !1899
  call fastcc void @gpu_signal_exception(), !dbg !1899
  call void @llvm.trap(), !dbg !1899
  unreachable, !dbg !1899

L37:                                              ; preds = %L32, %L27
  %value_phi5 = phi i8 [ %39, %L27 ], [ %48, %L32 ]
; ┌ @ essentials.jl:642 within `ifelse`
   %49 = trunc i8 %value_phi to i1, !dbg !1906
   %ifelse_cond = xor i1 %49, true, !dbg !1906
   %50 = select i1 %ifelse_cond, i8 %value_phi5, i8 1, !dbg !1906
; └
  ret i8 %50, !dbg !1899
}

;  @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:212 within `box_int64`
define internal fastcc nonnull {} addrspace(10)* @ijl_box_int64(i64 signext %0) unnamed_addr !dbg !1908 {
top:
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
; ┌ @ none within `box`
; │┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:183
; ││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:88 within `malloc`
     %4 = call fastcc i64 @gpu_malloc(i64 16), !dbg !1910
; ││└
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:187
; ││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:141 within `type_tag`
; │││┌ @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:141 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl:38
      %5 = load i64, i64* bitcast ({} addrspace(10)* ()* @jl_int64_type to i64*), align 4, !dbg !1919
; ││└└
; ││┌ @ int.jl:1068 within `|` @ int.jl:372
     %6 = or i64 %5, 3, !dbg !1925
; ││└
    %coercion = inttoptr i64 %4 to i64*, !dbg !1924
    %7 = getelementptr inbounds i64, i64* %coercion, i64 0, !dbg !1924
    store i64 %6, i64* %7, align 8, !dbg !1924, !tbaa !1012, !alias.scope !368, !noalias !369
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:190
; ││┌ @ pointer.jl:282 within `+`
     %8 = inttoptr i64 %4 to i8*, !dbg !1928
     %9 = getelementptr i8, i8* %8, i64 8, !dbg !1928
     %10 = ptrtoint i8* %9 to i64, !dbg !1928
; ││└
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:191
    %coercion1 = bitcast i8* %9 to i64*, !dbg !1931
    %11 = getelementptr inbounds i64, i64* %coercion1, i64 0, !dbg !1931
    store i64 %0, i64* %11, align 8, !dbg !1931, !tbaa !1012, !alias.scope !368, !noalias !369
; ││ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl:193
; ││┌ @ pointer.jl:253 within `unsafe_pointer_to_objref`
     %12 = bitcast i8* %9 to {}*, !dbg !1932
     %13 = addrspacecast {}* %12 to {} addrspace(10)*, !dbg !1932
; └└└
  ret {} addrspace(10)* %13, !dbg !1918
}

declare {} addrspace(10)* @jl_int64_type() local_unnamed_addr

attributes #0 = { cold noreturn nounwind }
attributes #1 = { alwaysinline noreturn }
attributes #2 = { norecurse nounwind readnone }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind readnone speculatable willreturn }
attributes #5 = { readnone }
attributes #6 = { allockind("alloc,uninitialized,aligned") allocsize(1) }
attributes #7 = { argmemonly nocallback nofree nounwind willreturn }
attributes #8 = { noreturn }
attributes #9 = { alwaysinline }
attributes #10 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #11 = { nounwind willreturn }
attributes #12 = { convergent nounwind willreturn }
attributes #13 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #14 = { convergent nounwind readnone willreturn }
attributes #15 = { nounwind }

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
!133 = !{void ({ [1 x i64], i8 addrspace(1)*, i64 })* @_Z3ker14ROCDeviceArrayI5Int64Li1ELi1EE}
!134 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_4790", scope: null, file: !135, line: 44, type: !136, scopeLine: 44, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!135 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!136 = !DISubroutineType(types: !137)
!137 = !{}
!138 = !DILocation(line: 38, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!140 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/base.jl", directory: ".")
!141 = !DILocation(line: 3, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!143 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!144 = !DILocation(line: 3, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!146 = !DILocation(line: 87, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!148 = !DILocation(line: 122, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!150 = !DILocation(line: 333, scope: !151, inlinedAt: !153)
!151 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!152 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!153 = !DILocation(line: 7, scope: !134)
!154 = !{i32 0, i32 1023}
!155 = !DILocation(line: 87, scope: !156, inlinedAt: !158)
!156 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!157 = !DIFile(filename: "int.jl", directory: ".")
!158 = !DILocation(line: 1068, scope: !156, inlinedAt: !146)
!159 = !DILocation(line: 38, scope: !139, inlinedAt: !160)
!160 = !DILocation(line: 3, scope: !142, inlinedAt: !161)
!161 = !DILocation(line: 3, scope: !145, inlinedAt: !162)
!162 = !DILocation(line: 87, scope: !163, inlinedAt: !148)
!163 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!164 = !DILocation(line: 38, scope: !139, inlinedAt: !165)
!165 = !DILocation(line: 3, scope: !142, inlinedAt: !166)
!166 = !DILocation(line: 3, scope: !145, inlinedAt: !167)
!167 = !DILocation(line: 87, scope: !168, inlinedAt: !148)
!168 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!169 = !DILocation(line: 38, scope: !139, inlinedAt: !170)
!170 = !DILocation(line: 3, scope: !142, inlinedAt: !171)
!171 = !DILocation(line: 3, scope: !145, inlinedAt: !172)
!172 = !DILocation(line: 93, scope: !173, inlinedAt: !174)
!173 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!174 = !DILocation(line: 130, scope: !175, inlinedAt: !150)
!175 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!176 = !{i32 0, i32 -2}
!177 = !DILocation(line: 87, scope: !156, inlinedAt: !178)
!178 = !DILocation(line: 1068, scope: !156, inlinedAt: !172)
!179 = !DILocation(line: 38, scope: !139, inlinedAt: !180)
!180 = !DILocation(line: 3, scope: !142, inlinedAt: !181)
!181 = !DILocation(line: 3, scope: !145, inlinedAt: !182)
!182 = !DILocation(line: 93, scope: !183, inlinedAt: !174)
!183 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!184 = !DILocation(line: 38, scope: !139, inlinedAt: !185)
!185 = !DILocation(line: 3, scope: !142, inlinedAt: !186)
!186 = !DILocation(line: 3, scope: !145, inlinedAt: !187)
!187 = !DILocation(line: 93, scope: !188, inlinedAt: !174)
!188 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!189 = !DILocation(line: 86, scope: !190, inlinedAt: !150)
!190 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!191 = !DILocation(line: 38, scope: !139, inlinedAt: !192)
!192 = !DILocation(line: 32, scope: !142, inlinedAt: !193)
!193 = !DILocation(line: 32, scope: !194, inlinedAt: !195)
!194 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!195 = !DILocation(line: 101, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!197 = !DILocation(line: 138, scope: !198, inlinedAt: !150)
!198 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!199 = !{i16 0, i16 1023}
!200 = !DILocation(line: 38, scope: !139, inlinedAt: !201)
!201 = !DILocation(line: 32, scope: !142, inlinedAt: !202)
!202 = !DILocation(line: 32, scope: !194, inlinedAt: !203)
!203 = !DILocation(line: 101, scope: !204, inlinedAt: !197)
!204 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!205 = !DILocation(line: 38, scope: !139, inlinedAt: !206)
!206 = !DILocation(line: 32, scope: !142, inlinedAt: !207)
!207 = !DILocation(line: 32, scope: !194, inlinedAt: !208)
!208 = !DILocation(line: 101, scope: !209, inlinedAt: !197)
!209 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!210 = !DILocation(line: 88, scope: !211, inlinedAt: !150)
!211 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!212 = !DILocation(line: 87, scope: !156, inlinedAt: !150)
!213 = !DILocation(line: 38, scope: !139, inlinedAt: !214)
!214 = !DILocation(line: 3, scope: !142, inlinedAt: !215)
!215 = !DILocation(line: 3, scope: !145, inlinedAt: !216)
!216 = !DILocation(line: 87, scope: !147, inlinedAt: !217)
!217 = !DILocation(line: 122, scope: !149, inlinedAt: !218)
!218 = !DILocation(line: 334, scope: !151, inlinedAt: !153)
!219 = !DILocation(line: 38, scope: !139, inlinedAt: !220)
!220 = !DILocation(line: 3, scope: !142, inlinedAt: !221)
!221 = !DILocation(line: 3, scope: !145, inlinedAt: !222)
!222 = !DILocation(line: 87, scope: !163, inlinedAt: !217)
!223 = !DILocation(line: 87, scope: !156, inlinedAt: !224)
!224 = !DILocation(line: 1068, scope: !156, inlinedAt: !222)
!225 = !DILocation(line: 38, scope: !139, inlinedAt: !226)
!226 = !DILocation(line: 3, scope: !142, inlinedAt: !227)
!227 = !DILocation(line: 3, scope: !145, inlinedAt: !228)
!228 = !DILocation(line: 87, scope: !168, inlinedAt: !217)
!229 = !DILocation(line: 38, scope: !139, inlinedAt: !230)
!230 = !DILocation(line: 3, scope: !142, inlinedAt: !231)
!231 = !DILocation(line: 3, scope: !145, inlinedAt: !232)
!232 = !DILocation(line: 93, scope: !173, inlinedAt: !233)
!233 = !DILocation(line: 130, scope: !175, inlinedAt: !218)
!234 = !DILocation(line: 38, scope: !139, inlinedAt: !235)
!235 = !DILocation(line: 3, scope: !142, inlinedAt: !236)
!236 = !DILocation(line: 3, scope: !145, inlinedAt: !237)
!237 = !DILocation(line: 93, scope: !183, inlinedAt: !233)
!238 = !DILocation(line: 87, scope: !156, inlinedAt: !239)
!239 = !DILocation(line: 1068, scope: !156, inlinedAt: !237)
!240 = !DILocation(line: 38, scope: !139, inlinedAt: !241)
!241 = !DILocation(line: 3, scope: !142, inlinedAt: !242)
!242 = !DILocation(line: 3, scope: !145, inlinedAt: !243)
!243 = !DILocation(line: 93, scope: !188, inlinedAt: !233)
!244 = !DILocation(line: 86, scope: !190, inlinedAt: !218)
!245 = !DILocation(line: 38, scope: !139, inlinedAt: !246)
!246 = !DILocation(line: 32, scope: !142, inlinedAt: !247)
!247 = !DILocation(line: 32, scope: !194, inlinedAt: !248)
!248 = !DILocation(line: 101, scope: !196, inlinedAt: !249)
!249 = !DILocation(line: 138, scope: !198, inlinedAt: !218)
!250 = !DILocation(line: 38, scope: !139, inlinedAt: !251)
!251 = !DILocation(line: 32, scope: !142, inlinedAt: !252)
!252 = !DILocation(line: 32, scope: !194, inlinedAt: !253)
!253 = !DILocation(line: 101, scope: !204, inlinedAt: !249)
!254 = !DILocation(line: 38, scope: !139, inlinedAt: !255)
!255 = !DILocation(line: 32, scope: !142, inlinedAt: !256)
!256 = !DILocation(line: 32, scope: !194, inlinedAt: !257)
!257 = !DILocation(line: 101, scope: !209, inlinedAt: !249)
!258 = !DILocation(line: 88, scope: !211, inlinedAt: !218)
!259 = !DILocation(line: 87, scope: !156, inlinedAt: !218)
!260 = !DILocation(line: 38, scope: !139, inlinedAt: !261)
!261 = !DILocation(line: 3, scope: !142, inlinedAt: !262)
!262 = !DILocation(line: 3, scope: !145, inlinedAt: !263)
!263 = !DILocation(line: 87, scope: !147, inlinedAt: !264)
!264 = !DILocation(line: 122, scope: !149, inlinedAt: !265)
!265 = !DILocation(line: 335, scope: !151, inlinedAt: !153)
!266 = !DILocation(line: 38, scope: !139, inlinedAt: !267)
!267 = !DILocation(line: 3, scope: !142, inlinedAt: !268)
!268 = !DILocation(line: 3, scope: !145, inlinedAt: !269)
!269 = !DILocation(line: 87, scope: !163, inlinedAt: !264)
!270 = !DILocation(line: 38, scope: !139, inlinedAt: !271)
!271 = !DILocation(line: 3, scope: !142, inlinedAt: !272)
!272 = !DILocation(line: 3, scope: !145, inlinedAt: !273)
!273 = !DILocation(line: 87, scope: !168, inlinedAt: !264)
!274 = !DILocation(line: 87, scope: !156, inlinedAt: !275)
!275 = !DILocation(line: 1068, scope: !156, inlinedAt: !273)
!276 = !DILocation(line: 38, scope: !139, inlinedAt: !277)
!277 = !DILocation(line: 3, scope: !142, inlinedAt: !278)
!278 = !DILocation(line: 3, scope: !145, inlinedAt: !279)
!279 = !DILocation(line: 93, scope: !173, inlinedAt: !280)
!280 = !DILocation(line: 130, scope: !175, inlinedAt: !265)
!281 = !DILocation(line: 38, scope: !139, inlinedAt: !282)
!282 = !DILocation(line: 3, scope: !142, inlinedAt: !283)
!283 = !DILocation(line: 3, scope: !145, inlinedAt: !284)
!284 = !DILocation(line: 93, scope: !183, inlinedAt: !280)
!285 = !DILocation(line: 38, scope: !139, inlinedAt: !286)
!286 = !DILocation(line: 3, scope: !142, inlinedAt: !287)
!287 = !DILocation(line: 3, scope: !145, inlinedAt: !288)
!288 = !DILocation(line: 93, scope: !188, inlinedAt: !280)
!289 = !DILocation(line: 87, scope: !156, inlinedAt: !290)
!290 = !DILocation(line: 1068, scope: !156, inlinedAt: !288)
!291 = !DILocation(line: 86, scope: !190, inlinedAt: !265)
!292 = !DILocation(line: 38, scope: !139, inlinedAt: !293)
!293 = !DILocation(line: 32, scope: !142, inlinedAt: !294)
!294 = !DILocation(line: 32, scope: !194, inlinedAt: !295)
!295 = !DILocation(line: 101, scope: !196, inlinedAt: !296)
!296 = !DILocation(line: 138, scope: !198, inlinedAt: !265)
!297 = !DILocation(line: 38, scope: !139, inlinedAt: !298)
!298 = !DILocation(line: 32, scope: !142, inlinedAt: !299)
!299 = !DILocation(line: 32, scope: !194, inlinedAt: !300)
!300 = !DILocation(line: 101, scope: !204, inlinedAt: !296)
!301 = !DILocation(line: 38, scope: !139, inlinedAt: !302)
!302 = !DILocation(line: 32, scope: !142, inlinedAt: !303)
!303 = !DILocation(line: 32, scope: !194, inlinedAt: !304)
!304 = !DILocation(line: 101, scope: !209, inlinedAt: !296)
!305 = !DILocation(line: 88, scope: !211, inlinedAt: !265)
!306 = !DILocation(line: 87, scope: !156, inlinedAt: !265)
!307 = !DILocation(line: 38, scope: !139, inlinedAt: !308)
!308 = !DILocation(line: 32, scope: !142, inlinedAt: !309)
!309 = !DILocation(line: 32, scope: !194, inlinedAt: !310)
!310 = !DILocation(line: 108, scope: !311, inlinedAt: !312)
!311 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!312 = !DILocation(line: 146, scope: !313, inlinedAt: !314)
!313 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!314 = !DILocation(line: 336, scope: !151, inlinedAt: !153)
!315 = !DILocation(line: 38, scope: !139, inlinedAt: !316)
!316 = !DILocation(line: 32, scope: !142, inlinedAt: !317)
!317 = !DILocation(line: 32, scope: !194, inlinedAt: !318)
!318 = !DILocation(line: 108, scope: !319, inlinedAt: !312)
!319 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!320 = !DILocation(line: 38, scope: !139, inlinedAt: !321)
!321 = !DILocation(line: 32, scope: !142, inlinedAt: !322)
!322 = !DILocation(line: 32, scope: !194, inlinedAt: !323)
!323 = !DILocation(line: 108, scope: !324, inlinedAt: !312)
!324 = distinct !DISubprogram(name: "gridItemDim_z;", linkageName: "gridItemDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!325 = !DILocation(line: 761, scope: !326, inlinedAt: !328)
!326 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!327 = !DIFile(filename: "boot.jl", directory: ".")
!328 = !DILocation(line: 787, scope: !329, inlinedAt: !314)
!329 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!330 = !DILocation(line: 86, scope: !190, inlinedAt: !331)
!331 = !DILocation(line: 1068, scope: !190, inlinedAt: !332)
!332 = !DILocation(line: 327, scope: !333, inlinedAt: !314)
!333 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!334 = !DILocation(line: 88, scope: !211, inlinedAt: !332)
!335 = !DILocation(line: 87, scope: !156, inlinedAt: !332)
!336 = !DILocation(line: 38, scope: !139, inlinedAt: !337)
!337 = !DILocation(line: 0, scope: !338, inlinedAt: !340)
!338 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!339 = !DIFile(filename: "none", directory: ".")
!340 = !DILocation(line: 0, scope: !341, inlinedAt: !342)
!341 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!342 = !DILocation(line: 38, scope: !343, inlinedAt: !345)
!343 = distinct !DISubprogram(name: "gate!;", linkageName: "gate!", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!344 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!345 = !DILocation(line: 339, scope: !151, inlinedAt: !153)
!346 = !DILocation(line: 37, scope: !347, inlinedAt: !342)
!347 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!348 = !DIFile(filename: "Base.jl", directory: ".")
!349 = !DILocation(line: 576, scope: !350, inlinedAt: !342)
!350 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!351 = !DIFile(filename: "essentials.jl", directory: ".")
!352 = !{!353, !353, i64 0}
!353 = !{!"jtbaa_stack", !354, i64 0}
!354 = !{!"jtbaa", !355, i64 0}
!355 = !{!"jtbaa"}
!356 = !{!357}
!357 = !{!"jnoalias_stack", !358}
!358 = !{!"jnoalias"}
!359 = !{!360, !361, !362, !363}
!360 = !{!"jnoalias_gcframe", !358}
!361 = !{!"jnoalias_data", !358}
!362 = !{!"jnoalias_typemd", !358}
!363 = !{!"jnoalias_const", !358}
!364 = !DILocation(line: 39, scope: !343, inlinedAt: !345)
!365 = !{!366, !366, i64 0}
!366 = !{!"jtbaa_value", !367, i64 0}
!367 = !{!"jtbaa_data", !354, i64 0}
!368 = !{!361}
!369 = !{!360, !357, !362, !363}
!370 = !DILocation(line: 44, scope: !343, inlinedAt: !345)
!371 = !DILocation(line: 35, scope: !372, inlinedAt: !374)
!372 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!373 = !DIFile(filename: "bool.jl", directory: ".")
!374 = !DILocation(line: 155, scope: !375, inlinedAt: !370)
!375 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!376 = !{i8 0, i8 2}
!377 = !DILocation(line: 521, scope: !378, inlinedAt: !370)
!378 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!379 = !DIFile(filename: "promotion.jl", directory: ".")
!380 = !DILocation(line: 642, scope: !381, inlinedAt: !370)
!381 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !137)
!382 = !DILocation(line: 351, scope: !151, inlinedAt: !153)
!383 = !DILocation(line: 8, scope: !134)
!384 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_4853", scope: null, file: !135, line: 40, type: !136, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!385 = !DILocation(line: 38, scope: !386, inlinedAt: !387)
!386 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!387 = !DILocation(line: 3, scope: !388, inlinedAt: !389)
!388 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!389 = !DILocation(line: 3, scope: !390, inlinedAt: !391)
!390 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!391 = !DILocation(line: 87, scope: !392, inlinedAt: !393)
!392 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!393 = !DILocation(line: 122, scope: !394, inlinedAt: !395)
!394 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!395 = !DILocation(line: 333, scope: !396, inlinedAt: !397)
!396 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!397 = !DILocation(line: 7, scope: !384)
!398 = !DILocation(line: 87, scope: !399, inlinedAt: !400)
!399 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!400 = !DILocation(line: 1068, scope: !399, inlinedAt: !391)
!401 = !DILocation(line: 38, scope: !386, inlinedAt: !402)
!402 = !DILocation(line: 3, scope: !388, inlinedAt: !403)
!403 = !DILocation(line: 3, scope: !390, inlinedAt: !404)
!404 = !DILocation(line: 87, scope: !405, inlinedAt: !393)
!405 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!406 = !DILocation(line: 38, scope: !386, inlinedAt: !407)
!407 = !DILocation(line: 3, scope: !388, inlinedAt: !408)
!408 = !DILocation(line: 3, scope: !390, inlinedAt: !409)
!409 = !DILocation(line: 87, scope: !410, inlinedAt: !393)
!410 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!411 = !DILocation(line: 38, scope: !386, inlinedAt: !412)
!412 = !DILocation(line: 3, scope: !388, inlinedAt: !413)
!413 = !DILocation(line: 3, scope: !390, inlinedAt: !414)
!414 = !DILocation(line: 93, scope: !415, inlinedAt: !416)
!415 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!416 = !DILocation(line: 130, scope: !417, inlinedAt: !395)
!417 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!418 = !DILocation(line: 87, scope: !399, inlinedAt: !419)
!419 = !DILocation(line: 1068, scope: !399, inlinedAt: !414)
!420 = !DILocation(line: 38, scope: !386, inlinedAt: !421)
!421 = !DILocation(line: 3, scope: !388, inlinedAt: !422)
!422 = !DILocation(line: 3, scope: !390, inlinedAt: !423)
!423 = !DILocation(line: 93, scope: !424, inlinedAt: !416)
!424 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!425 = !DILocation(line: 38, scope: !386, inlinedAt: !426)
!426 = !DILocation(line: 3, scope: !388, inlinedAt: !427)
!427 = !DILocation(line: 3, scope: !390, inlinedAt: !428)
!428 = !DILocation(line: 93, scope: !429, inlinedAt: !416)
!429 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!430 = !DILocation(line: 86, scope: !431, inlinedAt: !395)
!431 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!432 = !DILocation(line: 38, scope: !386, inlinedAt: !433)
!433 = !DILocation(line: 32, scope: !388, inlinedAt: !434)
!434 = !DILocation(line: 32, scope: !435, inlinedAt: !436)
!435 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!436 = !DILocation(line: 101, scope: !437, inlinedAt: !438)
!437 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!438 = !DILocation(line: 138, scope: !439, inlinedAt: !395)
!439 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!440 = !DILocation(line: 38, scope: !386, inlinedAt: !441)
!441 = !DILocation(line: 32, scope: !388, inlinedAt: !442)
!442 = !DILocation(line: 32, scope: !435, inlinedAt: !443)
!443 = !DILocation(line: 101, scope: !444, inlinedAt: !438)
!444 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!445 = !DILocation(line: 38, scope: !386, inlinedAt: !446)
!446 = !DILocation(line: 32, scope: !388, inlinedAt: !447)
!447 = !DILocation(line: 32, scope: !435, inlinedAt: !448)
!448 = !DILocation(line: 101, scope: !449, inlinedAt: !438)
!449 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!450 = !DILocation(line: 88, scope: !451, inlinedAt: !395)
!451 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!452 = !DILocation(line: 87, scope: !399, inlinedAt: !395)
!453 = !DILocation(line: 38, scope: !386, inlinedAt: !454)
!454 = !DILocation(line: 3, scope: !388, inlinedAt: !455)
!455 = !DILocation(line: 3, scope: !390, inlinedAt: !456)
!456 = !DILocation(line: 87, scope: !392, inlinedAt: !457)
!457 = !DILocation(line: 122, scope: !394, inlinedAt: !458)
!458 = !DILocation(line: 334, scope: !396, inlinedAt: !397)
!459 = !DILocation(line: 38, scope: !386, inlinedAt: !460)
!460 = !DILocation(line: 3, scope: !388, inlinedAt: !461)
!461 = !DILocation(line: 3, scope: !390, inlinedAt: !462)
!462 = !DILocation(line: 87, scope: !405, inlinedAt: !457)
!463 = !DILocation(line: 87, scope: !399, inlinedAt: !464)
!464 = !DILocation(line: 1068, scope: !399, inlinedAt: !462)
!465 = !DILocation(line: 38, scope: !386, inlinedAt: !466)
!466 = !DILocation(line: 3, scope: !388, inlinedAt: !467)
!467 = !DILocation(line: 3, scope: !390, inlinedAt: !468)
!468 = !DILocation(line: 87, scope: !410, inlinedAt: !457)
!469 = !DILocation(line: 38, scope: !386, inlinedAt: !470)
!470 = !DILocation(line: 3, scope: !388, inlinedAt: !471)
!471 = !DILocation(line: 3, scope: !390, inlinedAt: !472)
!472 = !DILocation(line: 93, scope: !415, inlinedAt: !473)
!473 = !DILocation(line: 130, scope: !417, inlinedAt: !458)
!474 = !DILocation(line: 38, scope: !386, inlinedAt: !475)
!475 = !DILocation(line: 3, scope: !388, inlinedAt: !476)
!476 = !DILocation(line: 3, scope: !390, inlinedAt: !477)
!477 = !DILocation(line: 93, scope: !424, inlinedAt: !473)
!478 = !DILocation(line: 87, scope: !399, inlinedAt: !479)
!479 = !DILocation(line: 1068, scope: !399, inlinedAt: !477)
!480 = !DILocation(line: 38, scope: !386, inlinedAt: !481)
!481 = !DILocation(line: 3, scope: !388, inlinedAt: !482)
!482 = !DILocation(line: 3, scope: !390, inlinedAt: !483)
!483 = !DILocation(line: 93, scope: !429, inlinedAt: !473)
!484 = !DILocation(line: 86, scope: !431, inlinedAt: !458)
!485 = !DILocation(line: 38, scope: !386, inlinedAt: !486)
!486 = !DILocation(line: 32, scope: !388, inlinedAt: !487)
!487 = !DILocation(line: 32, scope: !435, inlinedAt: !488)
!488 = !DILocation(line: 101, scope: !437, inlinedAt: !489)
!489 = !DILocation(line: 138, scope: !439, inlinedAt: !458)
!490 = !DILocation(line: 38, scope: !386, inlinedAt: !491)
!491 = !DILocation(line: 32, scope: !388, inlinedAt: !492)
!492 = !DILocation(line: 32, scope: !435, inlinedAt: !493)
!493 = !DILocation(line: 101, scope: !444, inlinedAt: !489)
!494 = !DILocation(line: 38, scope: !386, inlinedAt: !495)
!495 = !DILocation(line: 32, scope: !388, inlinedAt: !496)
!496 = !DILocation(line: 32, scope: !435, inlinedAt: !497)
!497 = !DILocation(line: 101, scope: !449, inlinedAt: !489)
!498 = !DILocation(line: 88, scope: !451, inlinedAt: !458)
!499 = !DILocation(line: 87, scope: !399, inlinedAt: !458)
!500 = !DILocation(line: 38, scope: !386, inlinedAt: !501)
!501 = !DILocation(line: 3, scope: !388, inlinedAt: !502)
!502 = !DILocation(line: 3, scope: !390, inlinedAt: !503)
!503 = !DILocation(line: 87, scope: !392, inlinedAt: !504)
!504 = !DILocation(line: 122, scope: !394, inlinedAt: !505)
!505 = !DILocation(line: 335, scope: !396, inlinedAt: !397)
!506 = !DILocation(line: 38, scope: !386, inlinedAt: !507)
!507 = !DILocation(line: 3, scope: !388, inlinedAt: !508)
!508 = !DILocation(line: 3, scope: !390, inlinedAt: !509)
!509 = !DILocation(line: 87, scope: !405, inlinedAt: !504)
!510 = !DILocation(line: 38, scope: !386, inlinedAt: !511)
!511 = !DILocation(line: 3, scope: !388, inlinedAt: !512)
!512 = !DILocation(line: 3, scope: !390, inlinedAt: !513)
!513 = !DILocation(line: 87, scope: !410, inlinedAt: !504)
!514 = !DILocation(line: 87, scope: !399, inlinedAt: !515)
!515 = !DILocation(line: 1068, scope: !399, inlinedAt: !513)
!516 = !DILocation(line: 38, scope: !386, inlinedAt: !517)
!517 = !DILocation(line: 3, scope: !388, inlinedAt: !518)
!518 = !DILocation(line: 3, scope: !390, inlinedAt: !519)
!519 = !DILocation(line: 93, scope: !415, inlinedAt: !520)
!520 = !DILocation(line: 130, scope: !417, inlinedAt: !505)
!521 = !DILocation(line: 38, scope: !386, inlinedAt: !522)
!522 = !DILocation(line: 3, scope: !388, inlinedAt: !523)
!523 = !DILocation(line: 3, scope: !390, inlinedAt: !524)
!524 = !DILocation(line: 93, scope: !424, inlinedAt: !520)
!525 = !DILocation(line: 38, scope: !386, inlinedAt: !526)
!526 = !DILocation(line: 3, scope: !388, inlinedAt: !527)
!527 = !DILocation(line: 3, scope: !390, inlinedAt: !528)
!528 = !DILocation(line: 93, scope: !429, inlinedAt: !520)
!529 = !DILocation(line: 87, scope: !399, inlinedAt: !530)
!530 = !DILocation(line: 1068, scope: !399, inlinedAt: !528)
!531 = !DILocation(line: 86, scope: !431, inlinedAt: !505)
!532 = !DILocation(line: 38, scope: !386, inlinedAt: !533)
!533 = !DILocation(line: 32, scope: !388, inlinedAt: !534)
!534 = !DILocation(line: 32, scope: !435, inlinedAt: !535)
!535 = !DILocation(line: 101, scope: !437, inlinedAt: !536)
!536 = !DILocation(line: 138, scope: !439, inlinedAt: !505)
!537 = !DILocation(line: 38, scope: !386, inlinedAt: !538)
!538 = !DILocation(line: 32, scope: !388, inlinedAt: !539)
!539 = !DILocation(line: 32, scope: !435, inlinedAt: !540)
!540 = !DILocation(line: 101, scope: !444, inlinedAt: !536)
!541 = !DILocation(line: 38, scope: !386, inlinedAt: !542)
!542 = !DILocation(line: 32, scope: !388, inlinedAt: !543)
!543 = !DILocation(line: 32, scope: !435, inlinedAt: !544)
!544 = !DILocation(line: 101, scope: !449, inlinedAt: !536)
!545 = !DILocation(line: 88, scope: !451, inlinedAt: !505)
!546 = !DILocation(line: 87, scope: !399, inlinedAt: !505)
!547 = !DILocation(line: 38, scope: !386, inlinedAt: !548)
!548 = !DILocation(line: 32, scope: !388, inlinedAt: !549)
!549 = !DILocation(line: 32, scope: !435, inlinedAt: !550)
!550 = !DILocation(line: 108, scope: !551, inlinedAt: !552)
!551 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!552 = !DILocation(line: 146, scope: !553, inlinedAt: !554)
!553 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!554 = !DILocation(line: 336, scope: !396, inlinedAt: !397)
!555 = !DILocation(line: 38, scope: !386, inlinedAt: !556)
!556 = !DILocation(line: 32, scope: !388, inlinedAt: !557)
!557 = !DILocation(line: 32, scope: !435, inlinedAt: !558)
!558 = !DILocation(line: 108, scope: !559, inlinedAt: !552)
!559 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!560 = !DILocation(line: 38, scope: !386, inlinedAt: !561)
!561 = !DILocation(line: 32, scope: !388, inlinedAt: !562)
!562 = !DILocation(line: 32, scope: !435, inlinedAt: !563)
!563 = !DILocation(line: 108, scope: !564, inlinedAt: !552)
!564 = distinct !DISubprogram(name: "gridItemDim_z;", linkageName: "gridItemDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!565 = !DILocation(line: 761, scope: !566, inlinedAt: !567)
!566 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!567 = !DILocation(line: 787, scope: !568, inlinedAt: !554)
!568 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!569 = !DILocation(line: 86, scope: !431, inlinedAt: !570)
!570 = !DILocation(line: 1068, scope: !431, inlinedAt: !571)
!571 = !DILocation(line: 327, scope: !572, inlinedAt: !554)
!572 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !7, retainedNodes: !137)
!573 = !DILocation(line: 88, scope: !451, inlinedAt: !571)
!574 = !DILocation(line: 87, scope: !399, inlinedAt: !571)
!575 = !DILocation(line: 339, scope: !396, inlinedAt: !397)
!576 = !DILocation(line: 351, scope: !396, inlinedAt: !397)
!577 = !DILocation(line: 8, scope: !384)
!578 = distinct !DISubprogram(name: "check_top_bit", linkageName: "julia_check_top_bit_4850", scope: null, file: !327, line: 644, type: !136, scopeLine: 644, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !137)
!579 = !DILocation(line: 636, scope: !580, inlinedAt: !581)
!580 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !137)
!581 = !DILocation(line: 646, scope: !578)
!582 = !DILocation(line: 647, scope: !578)
!583 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_4847", scope: null, file: !327, line: 757, type: !136, scopeLine: 757, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !137)
!584 = !DILocation(line: 757, scope: !583)
!585 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_4844", scope: null, file: !327, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !137)
!586 = !DILocation(line: 787, scope: !585)
!587 = distinct !DISubprogram(name: "gate!", linkageName: "julia_gate!_4893", scope: null, file: !344, line: 37, type: !136, scopeLine: 37, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!588 = !DILocation(line: 38, scope: !589, inlinedAt: !590)
!589 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!590 = !DILocation(line: 0, scope: !591, inlinedAt: !592)
!591 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!592 = !DILocation(line: 0, scope: !593, inlinedAt: !594)
!593 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!594 = !DILocation(line: 38, scope: !587)
!595 = !DILocation(line: 37, scope: !596, inlinedAt: !594)
!596 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!597 = !DILocation(line: 576, scope: !598, inlinedAt: !594)
!598 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!599 = !DILocation(line: 39, scope: !587)
!600 = !DILocation(line: 44, scope: !587)
!601 = !DILocation(line: 35, scope: !602, inlinedAt: !603)
!602 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!603 = !DILocation(line: 155, scope: !604, inlinedAt: !600)
!604 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!605 = !DILocation(line: 521, scope: !606, inlinedAt: !600)
!606 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!607 = !DILocation(line: 642, scope: !608, inlinedAt: !600)
!608 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !137)
!609 = distinct !DISubprogram(name: "llvm_atomic_cas", linkageName: "julia_llvm_atomic_cas_4923", scope: null, file: !610, line: 385, type: !136, scopeLine: 385, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!610 = !DIFile(filename: "/home/pxl-th/.julia/packages/UnsafeAtomicsLLVM/6HZfV/src/atomics.jl", directory: ".")
!611 = !DILocation(line: 7, scope: !612, inlinedAt: !614)
!612 = distinct !DISubprogram(name: "RefValue;", linkageName: "RefValue", scope: !613, file: !613, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!613 = !DIFile(filename: "refvalue.jl", directory: ".")
!614 = !DILocation(line: 138, scope: !615, inlinedAt: !617)
!615 = distinct !DISubprogram(name: "Ref;", linkageName: "Ref", scope: !616, file: !616, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!616 = !DIFile(filename: "refpointer.jl", directory: ".")
!617 = !DILocation(line: 458, scope: !618, inlinedAt: !619)
!618 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !610, file: !610, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!619 = !DILocation(line: 385, scope: !609)
!620 = !DILocation(line: 459, scope: !618, inlinedAt: !619)
!621 = !DILocation(line: 270, scope: !622, inlinedAt: !624)
!622 = distinct !DISubprogram(name: "pointer_from_objref;", linkageName: "pointer_from_objref", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!623 = !DIFile(filename: "pointer.jl", directory: ".")
!624 = !DILocation(line: 460, scope: !618, inlinedAt: !619)
!625 = !DILocation(line: 798, scope: !626, inlinedAt: !624)
!626 = distinct !DISubprogram(name: "Ptr;", linkageName: "Ptr", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!627 = !DILocation(line: 38, scope: !628, inlinedAt: !629)
!628 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!629 = !DILocation(line: 461, scope: !618, inlinedAt: !619)
!630 = !DILocation(line: 37, scope: !631, inlinedAt: !632)
!631 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!632 = !DILocation(line: 59, scope: !633, inlinedAt: !634)
!633 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !613, file: !613, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!634 = !DILocation(line: 463, scope: !618, inlinedAt: !619)
!635 = !{!636, !636, i64 0}
!636 = !{!"jtbaa_mutab", !366, i64 0}
!637 = !DILocation(line: 521, scope: !638, inlinedAt: !639)
!638 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!639 = !DILocation(line: 276, scope: !640, inlinedAt: !634)
!640 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !641, file: !641, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!641 = !DIFile(filename: "operators.jl", directory: ".")
!642 = !DILocation(line: 35, scope: !643, inlinedAt: !639)
!643 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!644 = !DILocation(line: 620, scope: !645, inlinedAt: !634)
!645 = distinct !DISubprogram(name: "NamedTuple;", linkageName: "NamedTuple", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !12, retainedNodes: !137)
!646 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_4841", scope: null, file: !647, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !13, retainedNodes: !137)
!647 = !DIFile(filename: "number.jl", directory: ".")
!648 = !DILocation(line: 7, scope: !646)
!649 = distinct !DISubprogram(name: "oftype", linkageName: "julia_oftype_4838", scope: null, file: !351, line: 517, type: !136, scopeLine: 517, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !137)
!650 = !DILocation(line: 517, scope: !649)
!651 = distinct !DISubprogram(name: "zero", linkageName: "julia_zero_4835", scope: null, file: !647, line: 308, type: !136, scopeLine: 308, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !137)
!652 = !DILocation(line: 308, scope: !651)
!653 = distinct !DISubprogram(name: "iszero", linkageName: "julia_iszero_4832", scope: null, file: !647, line: 42, type: !136, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !137)
!654 = !DILocation(line: 42, scope: !653)
!655 = !DILocation(line: 521, scope: !656, inlinedAt: !654)
!656 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !16, retainedNodes: !137)
!657 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_4916", scope: null, file: !327, line: 764, type: !136, scopeLine: 764, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !137)
!658 = !DILocation(line: 764, scope: !657)
!659 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_4913", scope: null, file: !327, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !137)
!660 = !DILocation(line: 787, scope: !659)
!661 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_4910", scope: null, file: !647, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !19, retainedNodes: !137)
!662 = !DILocation(line: 7, scope: !661)
!663 = distinct !DISubprogram(name: "_promote", linkageName: "julia__promote_4907", scope: null, file: !379, line: 367, type: !136, scopeLine: 367, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !137)
!664 = !DILocation(line: 370, scope: !663)
!665 = distinct !DISubprogram(name: "promote", linkageName: "julia_promote_4904", scope: null, file: !379, line: 391, type: !136, scopeLine: 391, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !21, retainedNodes: !137)
!666 = !DILocation(line: 393, scope: !665)
!667 = !DILocation(line: 92, scope: !668, inlinedAt: !670)
!668 = distinct !DISubprogram(name: "indexed_iterate;", linkageName: "indexed_iterate", scope: !669, file: !669, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !21, retainedNodes: !137)
!669 = !DIFile(filename: "tuple.jl", directory: ".")
!670 = !DILocation(line: 92, scope: !668, inlinedAt: !666)
!671 = !DILocation(line: 395, scope: !665)
!672 = distinct !DISubprogram(name: "==", linkageName: "julia_==_4901", scope: null, file: !379, line: 461, type: !136, scopeLine: 461, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !22, retainedNodes: !137)
!673 = !DILocation(line: 461, scope: !672)
!674 = !DILocation(line: 521, scope: !675, inlinedAt: !673)
!675 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !22, retainedNodes: !137)
!676 = distinct !DISubprogram(name: "err_buffer!", linkageName: "julia_err_buffer!_4890", scope: null, file: !344, line: 13, type: !136, scopeLine: 13, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!677 = !DILocation(line: 38, scope: !678, inlinedAt: !679)
!678 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!679 = !DILocation(line: 0, scope: !680, inlinedAt: !681)
!680 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!681 = !DILocation(line: 0, scope: !682, inlinedAt: !683)
!682 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!683 = !DILocation(line: 14, scope: !676)
!684 = !DILocation(line: 37, scope: !685, inlinedAt: !686)
!685 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!686 = !DILocation(line: 15, scope: !676)
!687 = !DILocation(line: 576, scope: !688, inlinedAt: !686)
!688 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !137)
!689 = !DILocation(line: 16, scope: !676)
!690 = !{!691, !691, i64 0}
!691 = !{!"jtbaa_immut", !366, i64 0}
!692 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_4918", scope: null, file: !693, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !137)
!693 = !DIFile(filename: "namedtuple.jl", directory: ".")
!694 = !DILocation(line: 175, scope: !692)
!695 = !{!354, !354, i64 0}
!696 = !{!363, !361}
!697 = !{!360, !357, !362}
!698 = !DILocation(line: 87, scope: !699, inlinedAt: !694)
!699 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !24, retainedNodes: !137)
!700 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_4920", scope: null, file: !693, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !137)
!701 = !DILocation(line: 175, scope: !700)
!702 = distinct !DISubprogram(name: "ker", linkageName: "julia_ker_4786", scope: null, file: !703, line: 1, type: !136, scopeLine: 1, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!703 = !DIFile(filename: "REPL[2]", directory: ".")
!704 = !DILocation(line: 88, scope: !705, inlinedAt: !707)
!705 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !706, file: !706, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!706 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!707 = !DILocation(line: 2, scope: !702)
!708 = !DILocation(line: 37, scope: !709, inlinedAt: !710)
!709 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!710 = !DILocation(line: 68, scope: !711, inlinedAt: !712)
!711 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !706, file: !706, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!712 = !DILocation(line: 98, scope: !713, inlinedAt: !715)
!713 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !714, file: !714, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!714 = !DIFile(filename: "abstractarray.jl", directory: ".")
!715 = !DILocation(line: 134, scope: !716, inlinedAt: !717)
!716 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !714, file: !714, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!717 = !DILocation(line: 386, scope: !718, inlinedAt: !719)
!718 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !714, file: !714, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!719 = !DILocation(line: 684, scope: !720, inlinedAt: !721)
!720 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !714, file: !714, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!721 = !DILocation(line: 699, scope: !720, inlinedAt: !704)
!722 = !DILocation(line: 31, scope: !723, inlinedAt: !724)
!723 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !669, file: !669, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!724 = !DILocation(line: 291, scope: !725, inlinedAt: !712)
!725 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !669, file: !669, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!726 = !DILocation(line: 83, scope: !727, inlinedAt: !728)
!727 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!728 = !DILocation(line: 532, scope: !729, inlinedAt: !730)
!729 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!730 = !DILocation(line: 454, scope: !731, inlinedAt: !733)
!731 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !732, file: !732, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!732 = !DIFile(filename: "range.jl", directory: ".")
!733 = !DILocation(line: 467, scope: !731, inlinedAt: !734)
!734 = !DILocation(line: 469, scope: !735, inlinedAt: !724)
!735 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !732, file: !732, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!736 = !{!363}
!737 = !{!360, !357, !361, !362}
!738 = !DILocation(line: 642, scope: !739, inlinedAt: !728)
!739 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!740 = !DILocation(line: 513, scope: !727, inlinedAt: !741)
!741 = !DILocation(line: 760, scope: !742, inlinedAt: !719)
!742 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !714, file: !714, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!743 = !DILocation(line: 700, scope: !720, inlinedAt: !704)
!744 = !DILocation(line: 37, scope: !709, inlinedAt: !745)
!745 = !DILocation(line: 63, scope: !746, inlinedAt: !747)
!746 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !706, file: !706, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!747 = !DILocation(line: 90, scope: !705, inlinedAt: !707)
!748 = !DILocation(line: 38, scope: !749, inlinedAt: !750)
!749 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!750 = !DILocation(line: 0, scope: !751, inlinedAt: !752)
!751 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!752 = !DILocation(line: 0, scope: !753, inlinedAt: !754)
!753 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!754 = !DILocation(line: 88, scope: !755, inlinedAt: !747)
!755 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !137)
!756 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/vIbji/src/interop/pointer.jl", directory: ".")
!757 = !{!758, !758, i64 0, i64 0}
!758 = !{!"custom_tbaa_addrspace(1)", !759, i64 0}
!759 = !{!"custom_tbaa"}
!760 = !DILocation(line: 91, scope: !705, inlinedAt: !707)
!761 = !DILocation(line: 3, scope: !702)
!762 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_2455", scope: null, file: !344, line: 115, type: !136, scopeLine: 115, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!763 = !DILocation(line: 38, scope: !764, inlinedAt: !765)
!764 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!765 = !DILocation(line: 3, scope: !766, inlinedAt: !767)
!766 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!767 = !DILocation(line: 3, scope: !768, inlinedAt: !769)
!768 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!769 = !DILocation(line: 87, scope: !770, inlinedAt: !771)
!770 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!771 = !DILocation(line: 122, scope: !772, inlinedAt: !773)
!772 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!773 = !DILocation(line: 333, scope: !774, inlinedAt: !775)
!774 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!775 = !DILocation(line: 98, scope: !776, inlinedAt: !777)
!776 = distinct !DISubprogram(name: "err_device_string_to_host;", linkageName: "err_device_string_to_host", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!777 = !DILocation(line: 116, scope: !762)
!778 = !DILocation(line: 87, scope: !779, inlinedAt: !780)
!779 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!780 = !DILocation(line: 1068, scope: !779, inlinedAt: !769)
!781 = !DILocation(line: 38, scope: !764, inlinedAt: !782)
!782 = !DILocation(line: 3, scope: !766, inlinedAt: !783)
!783 = !DILocation(line: 3, scope: !768, inlinedAt: !784)
!784 = !DILocation(line: 87, scope: !785, inlinedAt: !771)
!785 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!786 = !DILocation(line: 38, scope: !764, inlinedAt: !787)
!787 = !DILocation(line: 3, scope: !766, inlinedAt: !788)
!788 = !DILocation(line: 3, scope: !768, inlinedAt: !789)
!789 = !DILocation(line: 87, scope: !790, inlinedAt: !771)
!790 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!791 = !DILocation(line: 38, scope: !764, inlinedAt: !792)
!792 = !DILocation(line: 3, scope: !766, inlinedAt: !793)
!793 = !DILocation(line: 3, scope: !768, inlinedAt: !794)
!794 = !DILocation(line: 93, scope: !795, inlinedAt: !796)
!795 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!796 = !DILocation(line: 130, scope: !797, inlinedAt: !773)
!797 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!798 = !DILocation(line: 87, scope: !779, inlinedAt: !799)
!799 = !DILocation(line: 1068, scope: !779, inlinedAt: !794)
!800 = !DILocation(line: 38, scope: !764, inlinedAt: !801)
!801 = !DILocation(line: 3, scope: !766, inlinedAt: !802)
!802 = !DILocation(line: 3, scope: !768, inlinedAt: !803)
!803 = !DILocation(line: 93, scope: !804, inlinedAt: !796)
!804 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!805 = !DILocation(line: 38, scope: !764, inlinedAt: !806)
!806 = !DILocation(line: 3, scope: !766, inlinedAt: !807)
!807 = !DILocation(line: 3, scope: !768, inlinedAt: !808)
!808 = !DILocation(line: 93, scope: !809, inlinedAt: !796)
!809 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!810 = !DILocation(line: 86, scope: !811, inlinedAt: !773)
!811 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!812 = !DILocation(line: 38, scope: !764, inlinedAt: !813)
!813 = !DILocation(line: 32, scope: !766, inlinedAt: !814)
!814 = !DILocation(line: 32, scope: !815, inlinedAt: !816)
!815 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!816 = !DILocation(line: 101, scope: !817, inlinedAt: !818)
!817 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!818 = !DILocation(line: 138, scope: !819, inlinedAt: !773)
!819 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!820 = !DILocation(line: 38, scope: !764, inlinedAt: !821)
!821 = !DILocation(line: 32, scope: !766, inlinedAt: !822)
!822 = !DILocation(line: 32, scope: !815, inlinedAt: !823)
!823 = !DILocation(line: 101, scope: !824, inlinedAt: !818)
!824 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!825 = !DILocation(line: 38, scope: !764, inlinedAt: !826)
!826 = !DILocation(line: 32, scope: !766, inlinedAt: !827)
!827 = !DILocation(line: 32, scope: !815, inlinedAt: !828)
!828 = !DILocation(line: 101, scope: !829, inlinedAt: !818)
!829 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!830 = !DILocation(line: 88, scope: !831, inlinedAt: !773)
!831 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!832 = !DILocation(line: 87, scope: !779, inlinedAt: !773)
!833 = !DILocation(line: 38, scope: !764, inlinedAt: !834)
!834 = !DILocation(line: 3, scope: !766, inlinedAt: !835)
!835 = !DILocation(line: 3, scope: !768, inlinedAt: !836)
!836 = !DILocation(line: 87, scope: !770, inlinedAt: !837)
!837 = !DILocation(line: 122, scope: !772, inlinedAt: !838)
!838 = !DILocation(line: 334, scope: !774, inlinedAt: !775)
!839 = !DILocation(line: 38, scope: !764, inlinedAt: !840)
!840 = !DILocation(line: 3, scope: !766, inlinedAt: !841)
!841 = !DILocation(line: 3, scope: !768, inlinedAt: !842)
!842 = !DILocation(line: 87, scope: !785, inlinedAt: !837)
!843 = !DILocation(line: 87, scope: !779, inlinedAt: !844)
!844 = !DILocation(line: 1068, scope: !779, inlinedAt: !842)
!845 = !DILocation(line: 38, scope: !764, inlinedAt: !846)
!846 = !DILocation(line: 3, scope: !766, inlinedAt: !847)
!847 = !DILocation(line: 3, scope: !768, inlinedAt: !848)
!848 = !DILocation(line: 87, scope: !790, inlinedAt: !837)
!849 = !DILocation(line: 38, scope: !764, inlinedAt: !850)
!850 = !DILocation(line: 3, scope: !766, inlinedAt: !851)
!851 = !DILocation(line: 3, scope: !768, inlinedAt: !852)
!852 = !DILocation(line: 93, scope: !795, inlinedAt: !853)
!853 = !DILocation(line: 130, scope: !797, inlinedAt: !838)
!854 = !DILocation(line: 38, scope: !764, inlinedAt: !855)
!855 = !DILocation(line: 3, scope: !766, inlinedAt: !856)
!856 = !DILocation(line: 3, scope: !768, inlinedAt: !857)
!857 = !DILocation(line: 93, scope: !804, inlinedAt: !853)
!858 = !DILocation(line: 87, scope: !779, inlinedAt: !859)
!859 = !DILocation(line: 1068, scope: !779, inlinedAt: !857)
!860 = !DILocation(line: 38, scope: !764, inlinedAt: !861)
!861 = !DILocation(line: 3, scope: !766, inlinedAt: !862)
!862 = !DILocation(line: 3, scope: !768, inlinedAt: !863)
!863 = !DILocation(line: 93, scope: !809, inlinedAt: !853)
!864 = !DILocation(line: 86, scope: !811, inlinedAt: !838)
!865 = !DILocation(line: 38, scope: !764, inlinedAt: !866)
!866 = !DILocation(line: 32, scope: !766, inlinedAt: !867)
!867 = !DILocation(line: 32, scope: !815, inlinedAt: !868)
!868 = !DILocation(line: 101, scope: !817, inlinedAt: !869)
!869 = !DILocation(line: 138, scope: !819, inlinedAt: !838)
!870 = !DILocation(line: 38, scope: !764, inlinedAt: !871)
!871 = !DILocation(line: 32, scope: !766, inlinedAt: !872)
!872 = !DILocation(line: 32, scope: !815, inlinedAt: !873)
!873 = !DILocation(line: 101, scope: !824, inlinedAt: !869)
!874 = !DILocation(line: 38, scope: !764, inlinedAt: !875)
!875 = !DILocation(line: 32, scope: !766, inlinedAt: !876)
!876 = !DILocation(line: 32, scope: !815, inlinedAt: !877)
!877 = !DILocation(line: 101, scope: !829, inlinedAt: !869)
!878 = !DILocation(line: 88, scope: !831, inlinedAt: !838)
!879 = !DILocation(line: 87, scope: !779, inlinedAt: !838)
!880 = !DILocation(line: 38, scope: !764, inlinedAt: !881)
!881 = !DILocation(line: 3, scope: !766, inlinedAt: !882)
!882 = !DILocation(line: 3, scope: !768, inlinedAt: !883)
!883 = !DILocation(line: 87, scope: !770, inlinedAt: !884)
!884 = !DILocation(line: 122, scope: !772, inlinedAt: !885)
!885 = !DILocation(line: 335, scope: !774, inlinedAt: !775)
!886 = !DILocation(line: 38, scope: !764, inlinedAt: !887)
!887 = !DILocation(line: 3, scope: !766, inlinedAt: !888)
!888 = !DILocation(line: 3, scope: !768, inlinedAt: !889)
!889 = !DILocation(line: 87, scope: !785, inlinedAt: !884)
!890 = !DILocation(line: 38, scope: !764, inlinedAt: !891)
!891 = !DILocation(line: 3, scope: !766, inlinedAt: !892)
!892 = !DILocation(line: 3, scope: !768, inlinedAt: !893)
!893 = !DILocation(line: 87, scope: !790, inlinedAt: !884)
!894 = !DILocation(line: 87, scope: !779, inlinedAt: !895)
!895 = !DILocation(line: 1068, scope: !779, inlinedAt: !893)
!896 = !DILocation(line: 38, scope: !764, inlinedAt: !897)
!897 = !DILocation(line: 3, scope: !766, inlinedAt: !898)
!898 = !DILocation(line: 3, scope: !768, inlinedAt: !899)
!899 = !DILocation(line: 93, scope: !795, inlinedAt: !900)
!900 = !DILocation(line: 130, scope: !797, inlinedAt: !885)
!901 = !DILocation(line: 38, scope: !764, inlinedAt: !902)
!902 = !DILocation(line: 3, scope: !766, inlinedAt: !903)
!903 = !DILocation(line: 3, scope: !768, inlinedAt: !904)
!904 = !DILocation(line: 93, scope: !804, inlinedAt: !900)
!905 = !DILocation(line: 38, scope: !764, inlinedAt: !906)
!906 = !DILocation(line: 3, scope: !766, inlinedAt: !907)
!907 = !DILocation(line: 3, scope: !768, inlinedAt: !908)
!908 = !DILocation(line: 93, scope: !809, inlinedAt: !900)
!909 = !DILocation(line: 87, scope: !779, inlinedAt: !910)
!910 = !DILocation(line: 1068, scope: !779, inlinedAt: !908)
!911 = !DILocation(line: 86, scope: !811, inlinedAt: !885)
!912 = !DILocation(line: 38, scope: !764, inlinedAt: !913)
!913 = !DILocation(line: 32, scope: !766, inlinedAt: !914)
!914 = !DILocation(line: 32, scope: !815, inlinedAt: !915)
!915 = !DILocation(line: 101, scope: !817, inlinedAt: !916)
!916 = !DILocation(line: 138, scope: !819, inlinedAt: !885)
!917 = !DILocation(line: 38, scope: !764, inlinedAt: !918)
!918 = !DILocation(line: 32, scope: !766, inlinedAt: !919)
!919 = !DILocation(line: 32, scope: !815, inlinedAt: !920)
!920 = !DILocation(line: 101, scope: !824, inlinedAt: !916)
!921 = !DILocation(line: 38, scope: !764, inlinedAt: !922)
!922 = !DILocation(line: 32, scope: !766, inlinedAt: !923)
!923 = !DILocation(line: 32, scope: !815, inlinedAt: !924)
!924 = !DILocation(line: 101, scope: !829, inlinedAt: !916)
!925 = !DILocation(line: 88, scope: !831, inlinedAt: !885)
!926 = !DILocation(line: 87, scope: !779, inlinedAt: !885)
!927 = !DILocation(line: 38, scope: !764, inlinedAt: !928)
!928 = !DILocation(line: 32, scope: !766, inlinedAt: !929)
!929 = !DILocation(line: 32, scope: !815, inlinedAt: !930)
!930 = !DILocation(line: 108, scope: !931, inlinedAt: !932)
!931 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!932 = !DILocation(line: 146, scope: !933, inlinedAt: !934)
!933 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!934 = !DILocation(line: 336, scope: !774, inlinedAt: !775)
!935 = !DILocation(line: 38, scope: !764, inlinedAt: !936)
!936 = !DILocation(line: 32, scope: !766, inlinedAt: !937)
!937 = !DILocation(line: 32, scope: !815, inlinedAt: !938)
!938 = !DILocation(line: 108, scope: !939, inlinedAt: !932)
!939 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!940 = !DILocation(line: 38, scope: !764, inlinedAt: !941)
!941 = !DILocation(line: 32, scope: !766, inlinedAt: !942)
!942 = !DILocation(line: 32, scope: !815, inlinedAt: !943)
!943 = !DILocation(line: 108, scope: !944, inlinedAt: !932)
!944 = distinct !DISubprogram(name: "gridItemDim_z;", linkageName: "gridItemDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!945 = !DILocation(line: 761, scope: !946, inlinedAt: !947)
!946 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!947 = !DILocation(line: 787, scope: !948, inlinedAt: !934)
!948 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!949 = !DILocation(line: 86, scope: !811, inlinedAt: !950)
!950 = !DILocation(line: 1068, scope: !811, inlinedAt: !951)
!951 = !DILocation(line: 327, scope: !952, inlinedAt: !934)
!952 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!953 = !DILocation(line: 88, scope: !831, inlinedAt: !951)
!954 = !DILocation(line: 87, scope: !779, inlinedAt: !951)
!955 = !DILocation(line: 38, scope: !764, inlinedAt: !956)
!956 = !DILocation(line: 0, scope: !957, inlinedAt: !958)
!957 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!958 = !DILocation(line: 0, scope: !959, inlinedAt: !960)
!959 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!960 = !DILocation(line: 38, scope: !961, inlinedAt: !962)
!961 = distinct !DISubprogram(name: "gate!;", linkageName: "gate!", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!962 = !DILocation(line: 339, scope: !774, inlinedAt: !775)
!963 = !DILocation(line: 37, scope: !964, inlinedAt: !960)
!964 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!965 = !DILocation(line: 576, scope: !966, inlinedAt: !960)
!966 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!967 = !DILocation(line: 39, scope: !961, inlinedAt: !962)
!968 = !DILocation(line: 44, scope: !961, inlinedAt: !962)
!969 = !DILocation(line: 35, scope: !970, inlinedAt: !971)
!970 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!971 = !DILocation(line: 155, scope: !972, inlinedAt: !968)
!972 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!973 = !DILocation(line: 521, scope: !974, inlinedAt: !968)
!974 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!975 = !DILocation(line: 642, scope: !976, inlinedAt: !968)
!976 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!977 = !DILocation(line: 38, scope: !764, inlinedAt: !978)
!978 = !DILocation(line: 0, scope: !957, inlinedAt: !979)
!979 = !DILocation(line: 0, scope: !959, inlinedAt: !980)
!980 = !DILocation(line: 26, scope: !981, inlinedAt: !982)
!981 = distinct !DISubprogram(name: "err_str_buffer!;", linkageName: "err_str_buffer!", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!982 = !DILocation(line: 340, scope: !774, inlinedAt: !775)
!983 = !DILocation(line: 37, scope: !964, inlinedAt: !984)
!984 = !DILocation(line: 27, scope: !981, inlinedAt: !982)
!985 = !DILocation(line: 576, scope: !966, inlinedAt: !984)
!986 = !DILocation(line: 38, scope: !764, inlinedAt: !987)
!987 = !DILocation(line: 255, scope: !988, inlinedAt: !989)
!988 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !610, file: !610, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!989 = !DILocation(line: 255, scope: !990, inlinedAt: !991)
!990 = distinct !DISubprogram(name: "llvm_atomic_op;", linkageName: "llvm_atomic_op", scope: !610, file: !610, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!991 = !DILocation(line: 359, scope: !992, inlinedAt: !993)
!992 = distinct !DISubprogram(name: "atomic_pointermodify;", linkageName: "atomic_pointermodify", scope: !610, file: !610, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!993 = !DILocation(line: 294, scope: !992, inlinedAt: !994)
!994 = !DILocation(line: 28, scope: !981, inlinedAt: !982)
!995 = !DILocation(line: 37, scope: !964, inlinedAt: !996)
!996 = !DILocation(line: 31, scope: !981, inlinedAt: !982)
!997 = !DILocation(line: 83, scope: !998, inlinedAt: !999)
!998 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!999 = !DILocation(line: 378, scope: !1000, inlinedAt: !996)
!1000 = distinct !DISubprogram(name: ">;", linkageName: ">", scope: !641, file: !641, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1001 = !DILocation(line: 38, scope: !764, inlinedAt: !1002)
!1002 = !DILocation(line: 0, scope: !957, inlinedAt: !1003)
!1003 = !DILocation(line: 0, scope: !959, inlinedAt: !1004)
!1004 = !DILocation(line: 33, scope: !981, inlinedAt: !982)
!1005 = !DILocation(line: 37, scope: !964, inlinedAt: !1004)
!1006 = !DILocation(line: 701, scope: !1007, inlinedAt: !1008)
!1007 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1008 = !DILocation(line: 782, scope: !1009, inlinedAt: !1010)
!1009 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1010 = !DILocation(line: 119, scope: !1011, inlinedAt: !1004)
!1011 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1012 = !{!367, !367, i64 0}
!1013 = !DILocation(line: 576, scope: !966, inlinedAt: !1014)
!1014 = !DILocation(line: 34, scope: !981, inlinedAt: !982)
!1015 = !DILocation(line: 576, scope: !966, inlinedAt: !1016)
!1016 = !DILocation(line: 99, scope: !776, inlinedAt: !777)
!1017 = !DILocation(line: 521, scope: !974, inlinedAt: !1018)
!1018 = !DILocation(line: 518, scope: !1019, inlinedAt: !1016)
!1019 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1020 = !DILocation(line: 38, scope: !1021, inlinedAt: !1018)
!1021 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1022 = !DILocation(line: 576, scope: !966, inlinedAt: !1023)
!1023 = !DILocation(line: 101, scope: !776, inlinedAt: !777)
!1024 = !DILocation(line: 38, scope: !764, inlinedAt: !1025)
!1025 = !DILocation(line: 3, scope: !1026, inlinedAt: !1028)
!1026 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !1027, file: !1027, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1027 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!1028 = !DILocation(line: 3, scope: !1029, inlinedAt: !1030)
!1029 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !1027, file: !1027, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1030 = !DILocation(line: 102, scope: !776, inlinedAt: !777)
!1031 = !DILocation(line: 38, scope: !764, inlinedAt: !1032)
!1032 = !DILocation(line: 0, scope: !957, inlinedAt: !1033)
!1033 = !DILocation(line: 0, scope: !1034, inlinedAt: !1035)
!1034 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1035 = !DILocation(line: 105, scope: !776, inlinedAt: !777)
!1036 = !DILocation(line: 576, scope: !966, inlinedAt: !1037)
!1037 = !DILocation(line: 100, scope: !1038, inlinedAt: !1039)
!1038 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1039 = !DILocation(line: 114, scope: !1040, inlinedAt: !1041)
!1040 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1041 = !DILocation(line: 106, scope: !776, inlinedAt: !777)
!1042 = !DILocation(line: 576, scope: !966, inlinedAt: !1043)
!1043 = !DILocation(line: 102, scope: !1044, inlinedAt: !1045)
!1044 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1045 = !DILocation(line: 517, scope: !1046, inlinedAt: !1039)
!1046 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1047 = !DILocation(line: 38, scope: !764, inlinedAt: !1048)
!1048 = !DILocation(line: 0, scope: !957, inlinedAt: !1049)
!1049 = !DILocation(line: 0, scope: !1050, inlinedAt: !1051)
!1050 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1051 = !DILocation(line: 88, scope: !1052, inlinedAt: !1053)
!1052 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !48, retainedNodes: !137)
!1053 = !DILocation(line: 88, scope: !1052, inlinedAt: !1054)
!1054 = !DILocation(line: 88, scope: !1052, inlinedAt: !1041)
!1055 = !DILocation(line: 107, scope: !776, inlinedAt: !777)
!1056 = !DILocation(line: 38, scope: !764, inlinedAt: !1057)
!1057 = !DILocation(line: 3, scope: !766, inlinedAt: !1058)
!1058 = !DILocation(line: 3, scope: !768, inlinedAt: !1059)
!1059 = !DILocation(line: 87, scope: !770, inlinedAt: !1060)
!1060 = !DILocation(line: 122, scope: !772, inlinedAt: !1061)
!1061 = !DILocation(line: 333, scope: !774, inlinedAt: !1062)
!1062 = !DILocation(line: 117, scope: !762)
!1063 = !DILocation(line: 87, scope: !779, inlinedAt: !1064)
!1064 = !DILocation(line: 1068, scope: !779, inlinedAt: !1059)
!1065 = !DILocation(line: 38, scope: !764, inlinedAt: !1066)
!1066 = !DILocation(line: 3, scope: !766, inlinedAt: !1067)
!1067 = !DILocation(line: 3, scope: !768, inlinedAt: !1068)
!1068 = !DILocation(line: 87, scope: !785, inlinedAt: !1060)
!1069 = !DILocation(line: 38, scope: !764, inlinedAt: !1070)
!1070 = !DILocation(line: 3, scope: !766, inlinedAt: !1071)
!1071 = !DILocation(line: 3, scope: !768, inlinedAt: !1072)
!1072 = !DILocation(line: 87, scope: !790, inlinedAt: !1060)
!1073 = !DILocation(line: 38, scope: !764, inlinedAt: !1074)
!1074 = !DILocation(line: 3, scope: !766, inlinedAt: !1075)
!1075 = !DILocation(line: 3, scope: !768, inlinedAt: !1076)
!1076 = !DILocation(line: 93, scope: !795, inlinedAt: !1077)
!1077 = !DILocation(line: 130, scope: !797, inlinedAt: !1061)
!1078 = !DILocation(line: 87, scope: !779, inlinedAt: !1079)
!1079 = !DILocation(line: 1068, scope: !779, inlinedAt: !1076)
!1080 = !DILocation(line: 38, scope: !764, inlinedAt: !1081)
!1081 = !DILocation(line: 3, scope: !766, inlinedAt: !1082)
!1082 = !DILocation(line: 3, scope: !768, inlinedAt: !1083)
!1083 = !DILocation(line: 93, scope: !804, inlinedAt: !1077)
!1084 = !DILocation(line: 38, scope: !764, inlinedAt: !1085)
!1085 = !DILocation(line: 3, scope: !766, inlinedAt: !1086)
!1086 = !DILocation(line: 3, scope: !768, inlinedAt: !1087)
!1087 = !DILocation(line: 93, scope: !809, inlinedAt: !1077)
!1088 = !DILocation(line: 86, scope: !811, inlinedAt: !1061)
!1089 = !DILocation(line: 38, scope: !764, inlinedAt: !1090)
!1090 = !DILocation(line: 32, scope: !766, inlinedAt: !1091)
!1091 = !DILocation(line: 32, scope: !815, inlinedAt: !1092)
!1092 = !DILocation(line: 101, scope: !817, inlinedAt: !1093)
!1093 = !DILocation(line: 138, scope: !819, inlinedAt: !1061)
!1094 = !DILocation(line: 38, scope: !764, inlinedAt: !1095)
!1095 = !DILocation(line: 32, scope: !766, inlinedAt: !1096)
!1096 = !DILocation(line: 32, scope: !815, inlinedAt: !1097)
!1097 = !DILocation(line: 101, scope: !824, inlinedAt: !1093)
!1098 = !DILocation(line: 38, scope: !764, inlinedAt: !1099)
!1099 = !DILocation(line: 32, scope: !766, inlinedAt: !1100)
!1100 = !DILocation(line: 32, scope: !815, inlinedAt: !1101)
!1101 = !DILocation(line: 101, scope: !829, inlinedAt: !1093)
!1102 = !DILocation(line: 88, scope: !831, inlinedAt: !1061)
!1103 = !DILocation(line: 87, scope: !779, inlinedAt: !1061)
!1104 = !DILocation(line: 38, scope: !764, inlinedAt: !1105)
!1105 = !DILocation(line: 3, scope: !766, inlinedAt: !1106)
!1106 = !DILocation(line: 3, scope: !768, inlinedAt: !1107)
!1107 = !DILocation(line: 87, scope: !770, inlinedAt: !1108)
!1108 = !DILocation(line: 122, scope: !772, inlinedAt: !1109)
!1109 = !DILocation(line: 334, scope: !774, inlinedAt: !1062)
!1110 = !DILocation(line: 38, scope: !764, inlinedAt: !1111)
!1111 = !DILocation(line: 3, scope: !766, inlinedAt: !1112)
!1112 = !DILocation(line: 3, scope: !768, inlinedAt: !1113)
!1113 = !DILocation(line: 87, scope: !785, inlinedAt: !1108)
!1114 = !DILocation(line: 87, scope: !779, inlinedAt: !1115)
!1115 = !DILocation(line: 1068, scope: !779, inlinedAt: !1113)
!1116 = !DILocation(line: 38, scope: !764, inlinedAt: !1117)
!1117 = !DILocation(line: 3, scope: !766, inlinedAt: !1118)
!1118 = !DILocation(line: 3, scope: !768, inlinedAt: !1119)
!1119 = !DILocation(line: 87, scope: !790, inlinedAt: !1108)
!1120 = !DILocation(line: 38, scope: !764, inlinedAt: !1121)
!1121 = !DILocation(line: 3, scope: !766, inlinedAt: !1122)
!1122 = !DILocation(line: 3, scope: !768, inlinedAt: !1123)
!1123 = !DILocation(line: 93, scope: !795, inlinedAt: !1124)
!1124 = !DILocation(line: 130, scope: !797, inlinedAt: !1109)
!1125 = !DILocation(line: 38, scope: !764, inlinedAt: !1126)
!1126 = !DILocation(line: 3, scope: !766, inlinedAt: !1127)
!1127 = !DILocation(line: 3, scope: !768, inlinedAt: !1128)
!1128 = !DILocation(line: 93, scope: !804, inlinedAt: !1124)
!1129 = !DILocation(line: 87, scope: !779, inlinedAt: !1130)
!1130 = !DILocation(line: 1068, scope: !779, inlinedAt: !1128)
!1131 = !DILocation(line: 38, scope: !764, inlinedAt: !1132)
!1132 = !DILocation(line: 3, scope: !766, inlinedAt: !1133)
!1133 = !DILocation(line: 3, scope: !768, inlinedAt: !1134)
!1134 = !DILocation(line: 93, scope: !809, inlinedAt: !1124)
!1135 = !DILocation(line: 86, scope: !811, inlinedAt: !1109)
!1136 = !DILocation(line: 38, scope: !764, inlinedAt: !1137)
!1137 = !DILocation(line: 32, scope: !766, inlinedAt: !1138)
!1138 = !DILocation(line: 32, scope: !815, inlinedAt: !1139)
!1139 = !DILocation(line: 101, scope: !817, inlinedAt: !1140)
!1140 = !DILocation(line: 138, scope: !819, inlinedAt: !1109)
!1141 = !DILocation(line: 38, scope: !764, inlinedAt: !1142)
!1142 = !DILocation(line: 32, scope: !766, inlinedAt: !1143)
!1143 = !DILocation(line: 32, scope: !815, inlinedAt: !1144)
!1144 = !DILocation(line: 101, scope: !824, inlinedAt: !1140)
!1145 = !DILocation(line: 38, scope: !764, inlinedAt: !1146)
!1146 = !DILocation(line: 32, scope: !766, inlinedAt: !1147)
!1147 = !DILocation(line: 32, scope: !815, inlinedAt: !1148)
!1148 = !DILocation(line: 101, scope: !829, inlinedAt: !1140)
!1149 = !DILocation(line: 88, scope: !831, inlinedAt: !1109)
!1150 = !DILocation(line: 87, scope: !779, inlinedAt: !1109)
!1151 = !DILocation(line: 38, scope: !764, inlinedAt: !1152)
!1152 = !DILocation(line: 3, scope: !766, inlinedAt: !1153)
!1153 = !DILocation(line: 3, scope: !768, inlinedAt: !1154)
!1154 = !DILocation(line: 87, scope: !770, inlinedAt: !1155)
!1155 = !DILocation(line: 122, scope: !772, inlinedAt: !1156)
!1156 = !DILocation(line: 335, scope: !774, inlinedAt: !1062)
!1157 = !DILocation(line: 38, scope: !764, inlinedAt: !1158)
!1158 = !DILocation(line: 3, scope: !766, inlinedAt: !1159)
!1159 = !DILocation(line: 3, scope: !768, inlinedAt: !1160)
!1160 = !DILocation(line: 87, scope: !785, inlinedAt: !1155)
!1161 = !DILocation(line: 38, scope: !764, inlinedAt: !1162)
!1162 = !DILocation(line: 3, scope: !766, inlinedAt: !1163)
!1163 = !DILocation(line: 3, scope: !768, inlinedAt: !1164)
!1164 = !DILocation(line: 87, scope: !790, inlinedAt: !1155)
!1165 = !DILocation(line: 87, scope: !779, inlinedAt: !1166)
!1166 = !DILocation(line: 1068, scope: !779, inlinedAt: !1164)
!1167 = !DILocation(line: 38, scope: !764, inlinedAt: !1168)
!1168 = !DILocation(line: 3, scope: !766, inlinedAt: !1169)
!1169 = !DILocation(line: 3, scope: !768, inlinedAt: !1170)
!1170 = !DILocation(line: 93, scope: !795, inlinedAt: !1171)
!1171 = !DILocation(line: 130, scope: !797, inlinedAt: !1156)
!1172 = !DILocation(line: 38, scope: !764, inlinedAt: !1173)
!1173 = !DILocation(line: 3, scope: !766, inlinedAt: !1174)
!1174 = !DILocation(line: 3, scope: !768, inlinedAt: !1175)
!1175 = !DILocation(line: 93, scope: !804, inlinedAt: !1171)
!1176 = !DILocation(line: 38, scope: !764, inlinedAt: !1177)
!1177 = !DILocation(line: 3, scope: !766, inlinedAt: !1178)
!1178 = !DILocation(line: 3, scope: !768, inlinedAt: !1179)
!1179 = !DILocation(line: 93, scope: !809, inlinedAt: !1171)
!1180 = !DILocation(line: 87, scope: !779, inlinedAt: !1181)
!1181 = !DILocation(line: 1068, scope: !779, inlinedAt: !1179)
!1182 = !DILocation(line: 86, scope: !811, inlinedAt: !1156)
!1183 = !DILocation(line: 38, scope: !764, inlinedAt: !1184)
!1184 = !DILocation(line: 32, scope: !766, inlinedAt: !1185)
!1185 = !DILocation(line: 32, scope: !815, inlinedAt: !1186)
!1186 = !DILocation(line: 101, scope: !817, inlinedAt: !1187)
!1187 = !DILocation(line: 138, scope: !819, inlinedAt: !1156)
!1188 = !DILocation(line: 38, scope: !764, inlinedAt: !1189)
!1189 = !DILocation(line: 32, scope: !766, inlinedAt: !1190)
!1190 = !DILocation(line: 32, scope: !815, inlinedAt: !1191)
!1191 = !DILocation(line: 101, scope: !824, inlinedAt: !1187)
!1192 = !DILocation(line: 38, scope: !764, inlinedAt: !1193)
!1193 = !DILocation(line: 32, scope: !766, inlinedAt: !1194)
!1194 = !DILocation(line: 32, scope: !815, inlinedAt: !1195)
!1195 = !DILocation(line: 101, scope: !829, inlinedAt: !1187)
!1196 = !DILocation(line: 88, scope: !831, inlinedAt: !1156)
!1197 = !DILocation(line: 87, scope: !779, inlinedAt: !1156)
!1198 = !DILocation(line: 38, scope: !764, inlinedAt: !1199)
!1199 = !DILocation(line: 32, scope: !766, inlinedAt: !1200)
!1200 = !DILocation(line: 32, scope: !815, inlinedAt: !1201)
!1201 = !DILocation(line: 108, scope: !931, inlinedAt: !1202)
!1202 = !DILocation(line: 146, scope: !933, inlinedAt: !1203)
!1203 = !DILocation(line: 336, scope: !774, inlinedAt: !1062)
!1204 = !DILocation(line: 38, scope: !764, inlinedAt: !1205)
!1205 = !DILocation(line: 32, scope: !766, inlinedAt: !1206)
!1206 = !DILocation(line: 32, scope: !815, inlinedAt: !1207)
!1207 = !DILocation(line: 108, scope: !939, inlinedAt: !1202)
!1208 = !DILocation(line: 38, scope: !764, inlinedAt: !1209)
!1209 = !DILocation(line: 32, scope: !766, inlinedAt: !1210)
!1210 = !DILocation(line: 32, scope: !815, inlinedAt: !1211)
!1211 = !DILocation(line: 108, scope: !944, inlinedAt: !1202)
!1212 = !DILocation(line: 761, scope: !946, inlinedAt: !1213)
!1213 = !DILocation(line: 787, scope: !948, inlinedAt: !1203)
!1214 = !DILocation(line: 86, scope: !811, inlinedAt: !1215)
!1215 = !DILocation(line: 1068, scope: !811, inlinedAt: !1216)
!1216 = !DILocation(line: 327, scope: !952, inlinedAt: !1203)
!1217 = !DILocation(line: 88, scope: !831, inlinedAt: !1216)
!1218 = !DILocation(line: 87, scope: !779, inlinedAt: !1216)
!1219 = !DILocation(line: 38, scope: !764, inlinedAt: !1220)
!1220 = !DILocation(line: 0, scope: !957, inlinedAt: !1221)
!1221 = !DILocation(line: 0, scope: !959, inlinedAt: !1222)
!1222 = !DILocation(line: 38, scope: !961, inlinedAt: !1223)
!1223 = !DILocation(line: 339, scope: !774, inlinedAt: !1062)
!1224 = !DILocation(line: 37, scope: !964, inlinedAt: !1222)
!1225 = !DILocation(line: 576, scope: !966, inlinedAt: !1222)
!1226 = !DILocation(line: 39, scope: !961, inlinedAt: !1223)
!1227 = !DILocation(line: 44, scope: !961, inlinedAt: !1223)
!1228 = !DILocation(line: 35, scope: !970, inlinedAt: !1229)
!1229 = !DILocation(line: 155, scope: !972, inlinedAt: !1227)
!1230 = !DILocation(line: 521, scope: !974, inlinedAt: !1227)
!1231 = !DILocation(line: 642, scope: !976, inlinedAt: !1227)
!1232 = !DILocation(line: 351, scope: !774, inlinedAt: !1062)
!1233 = !DILocation(line: 121, scope: !762)
!1234 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_2976", scope: null, file: !344, line: 89, type: !136, scopeLine: 89, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1235 = !DILocation(line: 38, scope: !1236, inlinedAt: !1237)
!1236 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1237 = !DILocation(line: 0, scope: !1238, inlinedAt: !1239)
!1238 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1239 = !DILocation(line: 0, scope: !1240, inlinedAt: !1241)
!1240 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1241 = !DILocation(line: 11, scope: !1242, inlinedAt: !1243)
!1242 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1243 = !DILocation(line: 90, scope: !1234)
!1244 = !DILocation(line: 37, scope: !1245, inlinedAt: !1241)
!1245 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1246 = !DILocation(line: 146, scope: !1247, inlinedAt: !1248)
!1247 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1248 = !DILocation(line: 146, scope: !1247, inlinedAt: !1243)
!1249 = !DILocation(line: 52, scope: !1250, inlinedAt: !1252)
!1250 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !1251, file: !1251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !94, retainedNodes: !137)
!1251 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!1252 = !DILocation(line: 92, scope: !1234)
!1253 = !DILocation(line: 93, scope: !1234)
!1254 = distinct !DISubprogram(name: "malloc", linkageName: "julia_malloc_3127", scope: null, file: !1255, line: 11, type: !136, scopeLine: 11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1255 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!1256 = !DILocation(line: 38, scope: !1257, inlinedAt: !1258)
!1257 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1258 = !DILocation(line: 0, scope: !1259, inlinedAt: !1260)
!1259 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1260 = !DILocation(line: 0, scope: !1261, inlinedAt: !1262)
!1261 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1262 = !DILocation(line: 66, scope: !1263, inlinedAt: !1264)
!1263 = distinct !DISubprogram(name: "malloc_hc;", linkageName: "malloc_hc", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1264 = !DILocation(line: 12, scope: !1254)
!1265 = !DILocation(line: 37, scope: !1266, inlinedAt: !1262)
!1266 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1267 = !DILocation(line: 30, scope: !1268, inlinedAt: !1262)
!1268 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1269 = !DILocation(line: 38, scope: !1257, inlinedAt: !1270)
!1270 = !DILocation(line: 0, scope: !1259, inlinedAt: !1271)
!1271 = !DILocation(line: 0, scope: !1272, inlinedAt: !1273)
!1272 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1273 = !DILocation(line: 88, scope: !1274, inlinedAt: !1275)
!1274 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1275 = !DILocation(line: 88, scope: !1274, inlinedAt: !1276)
!1276 = !DILocation(line: 88, scope: !1274, inlinedAt: !1277)
!1277 = !DILocation(line: 75, scope: !1263, inlinedAt: !1264)
!1278 = !{!1279, !1279, i64 0, i64 0}
!1279 = !{!"custom_tbaa_addrspace(3)", !759, i64 0}
!1280 = !DILocation(line: 119, scope: !1281, inlinedAt: !1282)
!1281 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1282 = !DILocation(line: 119, scope: !1281, inlinedAt: !1264)
!1283 = !{!361, !357}
!1284 = !{!360, !362, !363}
!1285 = !DILocation(line: 38, scope: !1257, inlinedAt: !1286)
!1286 = !DILocation(line: 3, scope: !1287, inlinedAt: !1288)
!1287 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1288 = !DILocation(line: 3, scope: !1289, inlinedAt: !1290)
!1289 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1290 = !DILocation(line: 87, scope: !1291, inlinedAt: !1292)
!1291 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1292 = !DILocation(line: 122, scope: !1293, inlinedAt: !1294)
!1293 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1294 = !DILocation(line: 30, scope: !1295, inlinedAt: !1297)
!1295 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !1296, file: !1296, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1296 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!1297 = !DILocation(line: 0, scope: !1259, inlinedAt: !1298)
!1298 = !DILocation(line: 0, scope: !1299, inlinedAt: !1300)
!1299 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1300 = !DILocation(line: 9, scope: !1301, inlinedAt: !1302)
!1301 = distinct !DISubprogram(name: "hostcall!;", linkageName: "hostcall!", scope: !1296, file: !1296, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1302 = !DILocation(line: 3, scope: !1301, inlinedAt: !1303)
!1303 = !DILocation(line: 13, scope: !1254)
!1304 = !DILocation(line: 87, scope: !1305, inlinedAt: !1306)
!1305 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1306 = !DILocation(line: 1068, scope: !1305, inlinedAt: !1290)
!1307 = !DILocation(line: 38, scope: !1257, inlinedAt: !1308)
!1308 = !DILocation(line: 3, scope: !1287, inlinedAt: !1309)
!1309 = !DILocation(line: 3, scope: !1289, inlinedAt: !1310)
!1310 = !DILocation(line: 87, scope: !1311, inlinedAt: !1292)
!1311 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1312 = !DILocation(line: 38, scope: !1257, inlinedAt: !1313)
!1313 = !DILocation(line: 3, scope: !1287, inlinedAt: !1314)
!1314 = !DILocation(line: 3, scope: !1289, inlinedAt: !1315)
!1315 = !DILocation(line: 87, scope: !1316, inlinedAt: !1292)
!1316 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1317 = !DILocation(line: 761, scope: !1318, inlinedAt: !1319)
!1318 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1319 = !DILocation(line: 787, scope: !1320, inlinedAt: !1321)
!1320 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1321 = !DILocation(line: 7, scope: !1322, inlinedAt: !1323)
!1322 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !647, file: !647, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1323 = !DILocation(line: 370, scope: !1324, inlinedAt: !1325)
!1324 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1325 = !DILocation(line: 393, scope: !1326, inlinedAt: !1327)
!1326 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1327 = !DILocation(line: 461, scope: !1328, inlinedAt: !1329)
!1328 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1329 = !DILocation(line: 518, scope: !1330, inlinedAt: !1331)
!1330 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1331 = !DILocation(line: 276, scope: !1332, inlinedAt: !1294)
!1332 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !641, file: !641, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1333 = !DILocation(line: 521, scope: !1328, inlinedAt: !1327)
!1334 = !DILocation(line: 38, scope: !1335, inlinedAt: !1329)
!1335 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1336 = !DILocation(line: 35, scope: !1337, inlinedAt: !1331)
!1337 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1338 = !DILocation(line: 31, scope: !1295, inlinedAt: !1297)
!1339 = !DILocation(line: 37, scope: !1266, inlinedAt: !1340)
!1340 = !DILocation(line: 62, scope: !1295, inlinedAt: !1297)
!1341 = !DILocation(line: 27, scope: !1342, inlinedAt: !1344)
!1342 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1343 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!1344 = !DILocation(line: 37, scope: !1345, inlinedAt: !1346)
!1345 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1346 = !DILocation(line: 36, scope: !1345, inlinedAt: !1340)
!1347 = !DILocation(line: 521, scope: !1328, inlinedAt: !1348)
!1348 = !DILocation(line: 38, scope: !1345, inlinedAt: !1346)
!1349 = !DILocation(line: 521, scope: !1328, inlinedAt: !1350)
!1350 = !DILocation(line: 40, scope: !1345, inlinedAt: !1346)
!1351 = !DILocation(line: 38, scope: !1257, inlinedAt: !1352)
!1352 = !DILocation(line: 0, scope: !1259, inlinedAt: !1353)
!1353 = !DILocation(line: 0, scope: !1261, inlinedAt: !1354)
!1354 = !DILocation(line: 11, scope: !1355, inlinedAt: !1356)
!1355 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1356 = !DILocation(line: 90, scope: !1357, inlinedAt: !1358)
!1357 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !344, file: !344, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1358 = !DILocation(line: 41, scope: !1345, inlinedAt: !1346)
!1359 = !DILocation(line: 37, scope: !1266, inlinedAt: !1354)
!1360 = !DILocation(line: 146, scope: !1361, inlinedAt: !1362)
!1361 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1362 = !DILocation(line: 146, scope: !1361, inlinedAt: !1356)
!1363 = !DILocation(line: 52, scope: !1364, inlinedAt: !1365)
!1364 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !1251, file: !1251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1365 = !DILocation(line: 92, scope: !1357, inlinedAt: !1358)
!1366 = !DILocation(line: 108, scope: !1367, inlinedAt: !1368)
!1367 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1368 = !DILocation(line: 46, scope: !1345, inlinedAt: !1346)
!1369 = !DILocation(line: 47, scope: !1345, inlinedAt: !1346)
!1370 = !DILocation(line: 6, scope: !1371, inlinedAt: !1373)
!1371 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !1372, file: !1372, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1372 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!1373 = !DILocation(line: 47, scope: !1295, inlinedAt: !1297)
!1374 = !DILocation(line: 38, scope: !1257, inlinedAt: !1375)
!1375 = !DILocation(line: 3, scope: !1287, inlinedAt: !1376)
!1376 = !DILocation(line: 3, scope: !1289, inlinedAt: !1377)
!1377 = !DILocation(line: 87, scope: !1291, inlinedAt: !1378)
!1378 = !DILocation(line: 122, scope: !1293, inlinedAt: !1379)
!1379 = !DILocation(line: 30, scope: !1295, inlinedAt: !1380)
!1380 = !DILocation(line: 0, scope: !1259, inlinedAt: !1381)
!1381 = !DILocation(line: 0, scope: !1382, inlinedAt: !1383)
!1382 = distinct !DISubprogram(name: "hostcall_device_write_args!;", linkageName: "hostcall_device_write_args!", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1383 = !DILocation(line: 10, scope: !1301, inlinedAt: !1302)
!1384 = !DILocation(line: 87, scope: !1305, inlinedAt: !1385)
!1385 = !DILocation(line: 1068, scope: !1305, inlinedAt: !1377)
!1386 = !DILocation(line: 38, scope: !1257, inlinedAt: !1387)
!1387 = !DILocation(line: 3, scope: !1287, inlinedAt: !1388)
!1388 = !DILocation(line: 3, scope: !1289, inlinedAt: !1389)
!1389 = !DILocation(line: 87, scope: !1311, inlinedAt: !1378)
!1390 = !DILocation(line: 38, scope: !1257, inlinedAt: !1391)
!1391 = !DILocation(line: 3, scope: !1287, inlinedAt: !1392)
!1392 = !DILocation(line: 3, scope: !1289, inlinedAt: !1393)
!1393 = !DILocation(line: 87, scope: !1316, inlinedAt: !1378)
!1394 = !DILocation(line: 761, scope: !1318, inlinedAt: !1395)
!1395 = !DILocation(line: 787, scope: !1320, inlinedAt: !1396)
!1396 = !DILocation(line: 7, scope: !1322, inlinedAt: !1397)
!1397 = !DILocation(line: 370, scope: !1324, inlinedAt: !1398)
!1398 = !DILocation(line: 393, scope: !1326, inlinedAt: !1399)
!1399 = !DILocation(line: 461, scope: !1328, inlinedAt: !1400)
!1400 = !DILocation(line: 518, scope: !1330, inlinedAt: !1401)
!1401 = !DILocation(line: 276, scope: !1332, inlinedAt: !1379)
!1402 = !DILocation(line: 521, scope: !1328, inlinedAt: !1399)
!1403 = !DILocation(line: 38, scope: !1335, inlinedAt: !1400)
!1404 = !DILocation(line: 35, scope: !1337, inlinedAt: !1401)
!1405 = !DILocation(line: 31, scope: !1295, inlinedAt: !1380)
!1406 = !DILocation(line: 37, scope: !1266, inlinedAt: !1407)
!1407 = !DILocation(line: 91, scope: !1295, inlinedAt: !1380)
!1408 = !DILocation(line: 576, scope: !1409, inlinedAt: !1410)
!1409 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1410 = !DILocation(line: 100, scope: !1411, inlinedAt: !1412)
!1411 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1412 = !DILocation(line: 114, scope: !1413, inlinedAt: !1407)
!1413 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1414 = !DILocation(line: 576, scope: !1409, inlinedAt: !1415)
!1415 = !DILocation(line: 102, scope: !1416, inlinedAt: !1417)
!1416 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1417 = !DILocation(line: 517, scope: !1418, inlinedAt: !1412)
!1418 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1419 = !DILocation(line: 576, scope: !1409, inlinedAt: !1420)
!1420 = !DILocation(line: 100, scope: !1411, inlinedAt: !1421)
!1421 = !DILocation(line: 115, scope: !1422, inlinedAt: !1407)
!1422 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1423 = !DILocation(line: 576, scope: !1409, inlinedAt: !1424)
!1424 = !DILocation(line: 102, scope: !1416, inlinedAt: !1425)
!1425 = !DILocation(line: 517, scope: !1418, inlinedAt: !1421)
!1426 = !DILocation(line: 38, scope: !1257, inlinedAt: !1427)
!1427 = !DILocation(line: 0, scope: !1259, inlinedAt: !1428)
!1428 = !DILocation(line: 0, scope: !1272, inlinedAt: !1429)
!1429 = !DILocation(line: 88, scope: !1274, inlinedAt: !1430)
!1430 = !DILocation(line: 88, scope: !1274, inlinedAt: !1431)
!1431 = !DILocation(line: 88, scope: !1274, inlinedAt: !1407)
!1432 = !DILocation(line: 6, scope: !1371, inlinedAt: !1433)
!1433 = !DILocation(line: 47, scope: !1295, inlinedAt: !1380)
!1434 = !DILocation(line: 107, scope: !1295, inlinedAt: !1435)
!1435 = !DILocation(line: 0, scope: !1259, inlinedAt: !1436)
!1436 = !DILocation(line: 0, scope: !1437, inlinedAt: !1438)
!1437 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1438 = !DILocation(line: 11, scope: !1301, inlinedAt: !1302)
!1439 = !DILocation(line: 38, scope: !1257, inlinedAt: !1440)
!1440 = !DILocation(line: 2, scope: !1441, inlinedAt: !1443)
!1441 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !1442, file: !1442, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1442 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!1443 = !DILocation(line: 2, scope: !1444, inlinedAt: !1445)
!1444 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !1442, file: !1442, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1445 = !DILocation(line: 55, scope: !1446, inlinedAt: !1447)
!1446 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !1442, file: !1442, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1447 = !DILocation(line: 55, scope: !1446, inlinedAt: !1448)
!1448 = !DILocation(line: 108, scope: !1295, inlinedAt: !1435)
!1449 = !DILocation(line: 38, scope: !1257, inlinedAt: !1450)
!1450 = !DILocation(line: 3, scope: !1287, inlinedAt: !1451)
!1451 = !DILocation(line: 3, scope: !1289, inlinedAt: !1452)
!1452 = !DILocation(line: 87, scope: !1291, inlinedAt: !1453)
!1453 = !DILocation(line: 122, scope: !1293, inlinedAt: !1454)
!1454 = !DILocation(line: 30, scope: !1295, inlinedAt: !1435)
!1455 = !DILocation(line: 87, scope: !1305, inlinedAt: !1456)
!1456 = !DILocation(line: 1068, scope: !1305, inlinedAt: !1452)
!1457 = !DILocation(line: 38, scope: !1257, inlinedAt: !1458)
!1458 = !DILocation(line: 3, scope: !1287, inlinedAt: !1459)
!1459 = !DILocation(line: 3, scope: !1289, inlinedAt: !1460)
!1460 = !DILocation(line: 87, scope: !1311, inlinedAt: !1453)
!1461 = !DILocation(line: 38, scope: !1257, inlinedAt: !1462)
!1462 = !DILocation(line: 3, scope: !1287, inlinedAt: !1463)
!1463 = !DILocation(line: 3, scope: !1289, inlinedAt: !1464)
!1464 = !DILocation(line: 87, scope: !1316, inlinedAt: !1453)
!1465 = !DILocation(line: 761, scope: !1318, inlinedAt: !1466)
!1466 = !DILocation(line: 787, scope: !1320, inlinedAt: !1467)
!1467 = !DILocation(line: 7, scope: !1322, inlinedAt: !1468)
!1468 = !DILocation(line: 370, scope: !1324, inlinedAt: !1469)
!1469 = !DILocation(line: 393, scope: !1326, inlinedAt: !1470)
!1470 = !DILocation(line: 461, scope: !1328, inlinedAt: !1471)
!1471 = !DILocation(line: 518, scope: !1330, inlinedAt: !1472)
!1472 = !DILocation(line: 276, scope: !1332, inlinedAt: !1454)
!1473 = !DILocation(line: 521, scope: !1328, inlinedAt: !1470)
!1474 = !DILocation(line: 38, scope: !1335, inlinedAt: !1471)
!1475 = !DILocation(line: 35, scope: !1337, inlinedAt: !1472)
!1476 = !DILocation(line: 31, scope: !1295, inlinedAt: !1435)
!1477 = !DILocation(line: 37, scope: !1266, inlinedAt: !1478)
!1478 = !DILocation(line: 113, scope: !1295, inlinedAt: !1435)
!1479 = !DILocation(line: 27, scope: !1342, inlinedAt: !1480)
!1480 = !DILocation(line: 37, scope: !1345, inlinedAt: !1481)
!1481 = !DILocation(line: 36, scope: !1345, inlinedAt: !1478)
!1482 = !DILocation(line: 521, scope: !1328, inlinedAt: !1483)
!1483 = !DILocation(line: 38, scope: !1345, inlinedAt: !1481)
!1484 = !DILocation(line: 521, scope: !1328, inlinedAt: !1485)
!1485 = !DILocation(line: 40, scope: !1345, inlinedAt: !1481)
!1486 = !DILocation(line: 38, scope: !1257, inlinedAt: !1487)
!1487 = !DILocation(line: 0, scope: !1259, inlinedAt: !1488)
!1488 = !DILocation(line: 0, scope: !1261, inlinedAt: !1489)
!1489 = !DILocation(line: 11, scope: !1355, inlinedAt: !1490)
!1490 = !DILocation(line: 90, scope: !1357, inlinedAt: !1491)
!1491 = !DILocation(line: 41, scope: !1345, inlinedAt: !1481)
!1492 = !DILocation(line: 37, scope: !1266, inlinedAt: !1489)
!1493 = !DILocation(line: 146, scope: !1361, inlinedAt: !1494)
!1494 = !DILocation(line: 146, scope: !1361, inlinedAt: !1490)
!1495 = !DILocation(line: 52, scope: !1364, inlinedAt: !1496)
!1496 = !DILocation(line: 92, scope: !1357, inlinedAt: !1491)
!1497 = !DILocation(line: 108, scope: !1367, inlinedAt: !1498)
!1498 = !DILocation(line: 46, scope: !1345, inlinedAt: !1481)
!1499 = !DILocation(line: 47, scope: !1345, inlinedAt: !1481)
!1500 = !DILocation(line: 37, scope: !1266, inlinedAt: !1501)
!1501 = !DILocation(line: 116, scope: !1295, inlinedAt: !1435)
!1502 = !DILocation(line: 12, scope: !1503, inlinedAt: !1504)
!1503 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1504 = !DILocation(line: 61, scope: !1505, inlinedAt: !1506)
!1505 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1506 = !DILocation(line: 60, scope: !1505, inlinedAt: !1501)
!1507 = !DILocation(line: 521, scope: !1328, inlinedAt: !1508)
!1508 = !DILocation(line: 62, scope: !1505, inlinedAt: !1506)
!1509 = !DILocation(line: 521, scope: !1328, inlinedAt: !1510)
!1510 = !DILocation(line: 64, scope: !1505, inlinedAt: !1506)
!1511 = !DILocation(line: 38, scope: !1257, inlinedAt: !1512)
!1512 = !DILocation(line: 0, scope: !1259, inlinedAt: !1513)
!1513 = !DILocation(line: 0, scope: !1261, inlinedAt: !1514)
!1514 = !DILocation(line: 11, scope: !1355, inlinedAt: !1515)
!1515 = !DILocation(line: 90, scope: !1357, inlinedAt: !1516)
!1516 = !DILocation(line: 65, scope: !1505, inlinedAt: !1506)
!1517 = !DILocation(line: 37, scope: !1266, inlinedAt: !1514)
!1518 = !DILocation(line: 146, scope: !1361, inlinedAt: !1519)
!1519 = !DILocation(line: 146, scope: !1361, inlinedAt: !1515)
!1520 = !DILocation(line: 52, scope: !1364, inlinedAt: !1521)
!1521 = !DILocation(line: 92, scope: !1357, inlinedAt: !1516)
!1522 = !DILocation(line: 108, scope: !1367, inlinedAt: !1523)
!1523 = !DILocation(line: 70, scope: !1505, inlinedAt: !1506)
!1524 = !DILocation(line: 71, scope: !1505, inlinedAt: !1506)
!1525 = !DILocation(line: 118, scope: !1295, inlinedAt: !1435)
!1526 = !DILocation(line: 37, scope: !1266, inlinedAt: !1527)
!1527 = !DILocation(line: 119, scope: !1295, inlinedAt: !1435)
!1528 = !DILocation(line: 576, scope: !1409, inlinedAt: !1527)
!1529 = !DILocation(line: 38, scope: !1257, inlinedAt: !1530)
!1530 = !DILocation(line: 0, scope: !1259, inlinedAt: !1531)
!1531 = !DILocation(line: 0, scope: !1532, inlinedAt: !1533)
!1532 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1533 = !DILocation(line: 85, scope: !1534, inlinedAt: !1535)
!1534 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !756, file: !756, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1535 = !DILocation(line: 85, scope: !1534, inlinedAt: !1536)
!1536 = !DILocation(line: 85, scope: !1534, inlinedAt: !1537)
!1537 = !DILocation(line: 120, scope: !1295, inlinedAt: !1435)
!1538 = !DILocation(line: 576, scope: !1409, inlinedAt: !1539)
!1539 = !DILocation(line: 100, scope: !1411, inlinedAt: !1540)
!1540 = !DILocation(line: 121, scope: !1295, inlinedAt: !1435)
!1541 = !DILocation(line: 521, scope: !1328, inlinedAt: !1542)
!1542 = !DILocation(line: 518, scope: !1330, inlinedAt: !1540)
!1543 = !DILocation(line: 38, scope: !1335, inlinedAt: !1542)
!1544 = !DILocation(line: 37, scope: !1266, inlinedAt: !1545)
!1545 = !DILocation(line: 122, scope: !1295, inlinedAt: !1435)
!1546 = !DILocation(line: 19, scope: !1547, inlinedAt: !1548)
!1547 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !1343, file: !1343, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1548 = !DILocation(line: 19, scope: !1547, inlinedAt: !1545)
!1549 = !DILocation(line: 38, scope: !1257, inlinedAt: !1550)
!1550 = !DILocation(line: 0, scope: !1259, inlinedAt: !1551)
!1551 = !DILocation(line: 0, scope: !1261, inlinedAt: !1552)
!1552 = !DILocation(line: 11, scope: !1355, inlinedAt: !1553)
!1553 = !DILocation(line: 90, scope: !1357, inlinedAt: !1554)
!1554 = !DILocation(line: 123, scope: !1295, inlinedAt: !1435)
!1555 = !DILocation(line: 37, scope: !1266, inlinedAt: !1552)
!1556 = !DILocation(line: 146, scope: !1361, inlinedAt: !1557)
!1557 = !DILocation(line: 146, scope: !1361, inlinedAt: !1553)
!1558 = !DILocation(line: 52, scope: !1364, inlinedAt: !1559)
!1559 = !DILocation(line: 92, scope: !1357, inlinedAt: !1554)
!1560 = !DILocation(line: 1, scope: !1561, inlinedAt: !1562)
!1561 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !1251, file: !1251, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !110, retainedNodes: !137)
!1562 = !DILocation(line: 124, scope: !1295, inlinedAt: !1435)
!1563 = !DILocation(line: 38, scope: !1257, inlinedAt: !1564)
!1564 = !DILocation(line: 0, scope: !1259, inlinedAt: !1565)
!1565 = !DILocation(line: 0, scope: !1532, inlinedAt: !1566)
!1566 = !DILocation(line: 85, scope: !1534, inlinedAt: !1567)
!1567 = !DILocation(line: 85, scope: !1534, inlinedAt: !1568)
!1568 = !DILocation(line: 85, scope: !1534, inlinedAt: !1569)
!1569 = !DILocation(line: 126, scope: !1295, inlinedAt: !1435)
!1570 = !DILocation(line: 38, scope: !1257, inlinedAt: !1571)
!1571 = !DILocation(line: 0, scope: !1259, inlinedAt: !1572)
!1572 = !DILocation(line: 0, scope: !1272, inlinedAt: !1573)
!1573 = !DILocation(line: 88, scope: !1274, inlinedAt: !1574)
!1574 = !DILocation(line: 88, scope: !1274, inlinedAt: !1575)
!1575 = !DILocation(line: 88, scope: !1274, inlinedAt: !1569)
!1576 = !DILocation(line: 37, scope: !1266, inlinedAt: !1577)
!1577 = !DILocation(line: 128, scope: !1295, inlinedAt: !1435)
!1578 = !DILocation(line: 19, scope: !1547, inlinedAt: !1579)
!1579 = !DILocation(line: 19, scope: !1547, inlinedAt: !1577)
!1580 = !DILocation(line: 6, scope: !1371, inlinedAt: !1581)
!1581 = !DILocation(line: 47, scope: !1295, inlinedAt: !1435)
!1582 = !DILocation(line: 38, scope: !1257, inlinedAt: !1583)
!1583 = !DILocation(line: 0, scope: !1259, inlinedAt: !1584)
!1584 = !DILocation(line: 0, scope: !1532, inlinedAt: !1585)
!1585 = !DILocation(line: 85, scope: !1534, inlinedAt: !1586)
!1586 = !DILocation(line: 85, scope: !1534, inlinedAt: !1587)
!1587 = !DILocation(line: 85, scope: !1534, inlinedAt: !1588)
!1588 = !DILocation(line: 131, scope: !1295, inlinedAt: !1435)
!1589 = !{!1590, !1591, i64 16}
!1590 = !{!"amd_signal_s", !1591, i64 0, !1592, i64 8, !1591, i64 16, !1594, i64 24, !1594, i64 28, !1591, i64 32, !1591, i64 40, !1592, i64 48, !1592, i64 56}
!1591 = !{!"long", !1592, i64 0}
!1592 = !{!"omnipotent char", !1593, i64 0}
!1593 = !{!"Simple C/C++ TBAA"}
!1594 = !{!"int", !1592, i64 0}
!1595 = !{!1590, !1594, i64 24}
!1596 = !{!1590, !1591, i64 0}
!1597 = !{!1594, !1594, i64 0}
!1598 = !{!1592, !1592, i64 0}
!1599 = !{!1600, !1591, i64 80}
!1600 = !{!"amd_queue_s", !1601, i64 0, !1592, i64 40, !1591, i64 56, !1594, i64 64, !1594, i64 68, !1594, i64 72, !1594, i64 76, !1591, i64 80, !1594, i64 88, !1592, i64 92, !1591, i64 128, !1594, i64 136, !1594, i64 140, !1592, i64 144, !1591, i64 160, !1591, i64 168, !1594, i64 176, !1594, i64 180, !1592, i64 184, !1603, i64 192, !1592, i64 200}
!1601 = !{!"hsa_queue_s", !1592, i64 0, !1594, i64 4, !1602, i64 8, !1603, i64 16, !1594, i64 24, !1594, i64 28, !1591, i64 32}
!1602 = !{!"any pointer", !1592, i64 0}
!1603 = !{!"hsa_signal_s", !1591, i64 0}
!1604 = !{!1600, !1594, i64 24}
!1605 = distinct !DISubprogram(name: "llvm_atomic_cas", linkageName: "julia_llvm_atomic_cas_2628", scope: null, file: !610, line: 385, type: !136, scopeLine: 385, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1606 = !DILocation(line: 7, scope: !1607, inlinedAt: !1608)
!1607 = distinct !DISubprogram(name: "RefValue;", linkageName: "RefValue", scope: !613, file: !613, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1608 = !DILocation(line: 138, scope: !1609, inlinedAt: !1610)
!1609 = distinct !DISubprogram(name: "Ref;", linkageName: "Ref", scope: !616, file: !616, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1610 = !DILocation(line: 458, scope: !1611, inlinedAt: !1612)
!1611 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !610, file: !610, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1612 = !DILocation(line: 385, scope: !1605)
!1613 = !DILocation(line: 459, scope: !1611, inlinedAt: !1612)
!1614 = !DILocation(line: 270, scope: !1615, inlinedAt: !1616)
!1615 = distinct !DISubprogram(name: "pointer_from_objref;", linkageName: "pointer_from_objref", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1616 = !DILocation(line: 460, scope: !1611, inlinedAt: !1612)
!1617 = !DILocation(line: 798, scope: !1618, inlinedAt: !1616)
!1618 = distinct !DISubprogram(name: "Ptr;", linkageName: "Ptr", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1619 = !DILocation(line: 38, scope: !1620, inlinedAt: !1621)
!1620 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1621 = !DILocation(line: 461, scope: !1611, inlinedAt: !1612)
!1622 = !DILocation(line: 37, scope: !1623, inlinedAt: !1624)
!1623 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1624 = !DILocation(line: 59, scope: !1625, inlinedAt: !1626)
!1625 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !613, file: !613, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1626 = !DILocation(line: 463, scope: !1611, inlinedAt: !1612)
!1627 = !DILocation(line: 521, scope: !1628, inlinedAt: !1629)
!1628 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1629 = !DILocation(line: 276, scope: !1630, inlinedAt: !1626)
!1630 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !641, file: !641, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1631 = !DILocation(line: 35, scope: !1632, inlinedAt: !1629)
!1632 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1633 = !DILocation(line: 620, scope: !1634, inlinedAt: !1626)
!1634 = distinct !DISubprogram(name: "NamedTuple;", linkageName: "NamedTuple", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34, retainedNodes: !137)
!1635 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2625", scope: null, file: !693, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !47, retainedNodes: !137)
!1636 = !DILocation(line: 175, scope: !1635)
!1637 = distinct !DISubprogram(name: "indexed_iterate", linkageName: "julia_indexed_iterate_2623", scope: null, file: !693, line: 175, type: !136, scopeLine: 175, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !46, retainedNodes: !137)
!1638 = !DILocation(line: 175, scope: !1637)
!1639 = !DILocation(line: 87, scope: !1640, inlinedAt: !1638)
!1640 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !46, retainedNodes: !137)
!1641 = distinct !DISubprogram(name: "iszero", linkageName: "julia_iszero_2537", scope: null, file: !647, line: 42, type: !136, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !38, retainedNodes: !137)
!1642 = !DILocation(line: 42, scope: !1641)
!1643 = !DILocation(line: 521, scope: !1644, inlinedAt: !1642)
!1644 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !38, retainedNodes: !137)
!1645 = distinct !DISubprogram(name: "==", linkageName: "julia_==_2606", scope: null, file: !379, line: 461, type: !136, scopeLine: 461, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !44, retainedNodes: !137)
!1646 = !DILocation(line: 461, scope: !1645)
!1647 = !DILocation(line: 521, scope: !1648, inlinedAt: !1646)
!1648 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !44, retainedNodes: !137)
!1649 = distinct !DISubprogram(name: "err_buffer!", linkageName: "julia_err_buffer!_2595", scope: null, file: !344, line: 13, type: !136, scopeLine: 13, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1650 = !DILocation(line: 38, scope: !1651, inlinedAt: !1652)
!1651 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1652 = !DILocation(line: 0, scope: !1653, inlinedAt: !1654)
!1653 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1654 = !DILocation(line: 0, scope: !1655, inlinedAt: !1656)
!1655 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1656 = !DILocation(line: 14, scope: !1649)
!1657 = !DILocation(line: 37, scope: !1658, inlinedAt: !1659)
!1658 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1659 = !DILocation(line: 15, scope: !1649)
!1660 = !DILocation(line: 576, scope: !1661, inlinedAt: !1659)
!1661 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !45, retainedNodes: !137)
!1662 = !DILocation(line: 16, scope: !1649)
!1663 = distinct !DISubprogram(name: "promote", linkageName: "julia_promote_2609", scope: null, file: !379, line: 391, type: !136, scopeLine: 391, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !43, retainedNodes: !137)
!1664 = !DILocation(line: 393, scope: !1663)
!1665 = !DILocation(line: 92, scope: !1666, inlinedAt: !1667)
!1666 = distinct !DISubprogram(name: "indexed_iterate;", linkageName: "indexed_iterate", scope: !669, file: !669, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !43, retainedNodes: !137)
!1667 = !DILocation(line: 92, scope: !1666, inlinedAt: !1664)
!1668 = !DILocation(line: 395, scope: !1663)
!1669 = distinct !DISubprogram(name: "_promote", linkageName: "julia__promote_2612", scope: null, file: !379, line: 367, type: !136, scopeLine: 367, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !42, retainedNodes: !137)
!1670 = !DILocation(line: 370, scope: !1669)
!1671 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2615", scope: null, file: !647, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !41, retainedNodes: !137)
!1672 = !DILocation(line: 7, scope: !1671)
!1673 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2618", scope: null, file: !327, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !40, retainedNodes: !137)
!1674 = !DILocation(line: 787, scope: !1673)
!1675 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2621", scope: null, file: !327, line: 764, type: !136, scopeLine: 764, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !39, retainedNodes: !137)
!1676 = !DILocation(line: 764, scope: !1675)
!1677 = distinct !DISubprogram(name: "zero", linkageName: "julia_zero_2540", scope: null, file: !647, line: 308, type: !136, scopeLine: 308, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !37, retainedNodes: !137)
!1678 = !DILocation(line: 308, scope: !1677)
!1679 = distinct !DISubprogram(name: "oftype", linkageName: "julia_oftype_2543", scope: null, file: !351, line: 517, type: !136, scopeLine: 517, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !36, retainedNodes: !137)
!1680 = !DILocation(line: 517, scope: !1679)
!1681 = distinct !DISubprogram(name: "convert", linkageName: "julia_convert_2546", scope: null, file: !647, line: 7, type: !136, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !35, retainedNodes: !137)
!1682 = !DILocation(line: 7, scope: !1681)
!1683 = distinct !DISubprogram(name: "UInt64", linkageName: "julia_UInt64_2549", scope: null, file: !327, line: 787, type: !136, scopeLine: 787, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !32, retainedNodes: !137)
!1684 = !DILocation(line: 787, scope: !1683)
!1685 = distinct !DISubprogram(name: "toUInt64", linkageName: "julia_toUInt64_2552", scope: null, file: !327, line: 757, type: !136, scopeLine: 757, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !31, retainedNodes: !137)
!1686 = !DILocation(line: 757, scope: !1685)
!1687 = distinct !DISubprogram(name: "check_top_bit", linkageName: "julia_check_top_bit_2555", scope: null, file: !327, line: 644, type: !136, scopeLine: 644, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !30, retainedNodes: !137)
!1688 = !DILocation(line: 636, scope: !1689, inlinedAt: !1690)
!1689 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !30, retainedNodes: !137)
!1690 = !DILocation(line: 646, scope: !1687)
!1691 = !DILocation(line: 647, scope: !1687)
!1692 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_2558", scope: null, file: !135, line: 40, type: !136, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1693 = !DILocation(line: 38, scope: !1694, inlinedAt: !1695)
!1694 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1695 = !DILocation(line: 3, scope: !1696, inlinedAt: !1697)
!1696 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1697 = !DILocation(line: 3, scope: !1698, inlinedAt: !1699)
!1698 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1699 = !DILocation(line: 87, scope: !1700, inlinedAt: !1701)
!1700 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1701 = !DILocation(line: 122, scope: !1702, inlinedAt: !1703)
!1702 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1703 = !DILocation(line: 333, scope: !1704, inlinedAt: !1705)
!1704 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1705 = !DILocation(line: 7, scope: !1692)
!1706 = !DILocation(line: 87, scope: !1707, inlinedAt: !1708)
!1707 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1708 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1699)
!1709 = !DILocation(line: 38, scope: !1694, inlinedAt: !1710)
!1710 = !DILocation(line: 3, scope: !1696, inlinedAt: !1711)
!1711 = !DILocation(line: 3, scope: !1698, inlinedAt: !1712)
!1712 = !DILocation(line: 87, scope: !1713, inlinedAt: !1701)
!1713 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1714 = !DILocation(line: 38, scope: !1694, inlinedAt: !1715)
!1715 = !DILocation(line: 3, scope: !1696, inlinedAt: !1716)
!1716 = !DILocation(line: 3, scope: !1698, inlinedAt: !1717)
!1717 = !DILocation(line: 87, scope: !1718, inlinedAt: !1701)
!1718 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1719 = !DILocation(line: 38, scope: !1694, inlinedAt: !1720)
!1720 = !DILocation(line: 3, scope: !1696, inlinedAt: !1721)
!1721 = !DILocation(line: 3, scope: !1698, inlinedAt: !1722)
!1722 = !DILocation(line: 93, scope: !1723, inlinedAt: !1724)
!1723 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1724 = !DILocation(line: 130, scope: !1725, inlinedAt: !1703)
!1725 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1726 = !DILocation(line: 87, scope: !1707, inlinedAt: !1727)
!1727 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1722)
!1728 = !DILocation(line: 38, scope: !1694, inlinedAt: !1729)
!1729 = !DILocation(line: 3, scope: !1696, inlinedAt: !1730)
!1730 = !DILocation(line: 3, scope: !1698, inlinedAt: !1731)
!1731 = !DILocation(line: 93, scope: !1732, inlinedAt: !1724)
!1732 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1733 = !DILocation(line: 38, scope: !1694, inlinedAt: !1734)
!1734 = !DILocation(line: 3, scope: !1696, inlinedAt: !1735)
!1735 = !DILocation(line: 3, scope: !1698, inlinedAt: !1736)
!1736 = !DILocation(line: 93, scope: !1737, inlinedAt: !1724)
!1737 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1738 = !DILocation(line: 86, scope: !1739, inlinedAt: !1703)
!1739 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1740 = !DILocation(line: 38, scope: !1694, inlinedAt: !1741)
!1741 = !DILocation(line: 32, scope: !1696, inlinedAt: !1742)
!1742 = !DILocation(line: 32, scope: !1743, inlinedAt: !1744)
!1743 = distinct !DISubprogram(name: "_dim;", linkageName: "_dim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1744 = !DILocation(line: 101, scope: !1745, inlinedAt: !1746)
!1745 = distinct !DISubprogram(name: "workgroupDim_x;", linkageName: "workgroupDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1746 = !DILocation(line: 138, scope: !1747, inlinedAt: !1703)
!1747 = distinct !DISubprogram(name: "workgroupDim;", linkageName: "workgroupDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1748 = !DILocation(line: 38, scope: !1694, inlinedAt: !1749)
!1749 = !DILocation(line: 32, scope: !1696, inlinedAt: !1750)
!1750 = !DILocation(line: 32, scope: !1743, inlinedAt: !1751)
!1751 = !DILocation(line: 101, scope: !1752, inlinedAt: !1746)
!1752 = distinct !DISubprogram(name: "workgroupDim_y;", linkageName: "workgroupDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1753 = !DILocation(line: 38, scope: !1694, inlinedAt: !1754)
!1754 = !DILocation(line: 32, scope: !1696, inlinedAt: !1755)
!1755 = !DILocation(line: 32, scope: !1743, inlinedAt: !1756)
!1756 = !DILocation(line: 101, scope: !1757, inlinedAt: !1746)
!1757 = distinct !DISubprogram(name: "workgroupDim_z;", linkageName: "workgroupDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1758 = !DILocation(line: 88, scope: !1759, inlinedAt: !1703)
!1759 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1760 = !DILocation(line: 87, scope: !1707, inlinedAt: !1703)
!1761 = !DILocation(line: 38, scope: !1694, inlinedAt: !1762)
!1762 = !DILocation(line: 3, scope: !1696, inlinedAt: !1763)
!1763 = !DILocation(line: 3, scope: !1698, inlinedAt: !1764)
!1764 = !DILocation(line: 87, scope: !1700, inlinedAt: !1765)
!1765 = !DILocation(line: 122, scope: !1702, inlinedAt: !1766)
!1766 = !DILocation(line: 334, scope: !1704, inlinedAt: !1705)
!1767 = !DILocation(line: 38, scope: !1694, inlinedAt: !1768)
!1768 = !DILocation(line: 3, scope: !1696, inlinedAt: !1769)
!1769 = !DILocation(line: 3, scope: !1698, inlinedAt: !1770)
!1770 = !DILocation(line: 87, scope: !1713, inlinedAt: !1765)
!1771 = !DILocation(line: 87, scope: !1707, inlinedAt: !1772)
!1772 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1770)
!1773 = !DILocation(line: 38, scope: !1694, inlinedAt: !1774)
!1774 = !DILocation(line: 3, scope: !1696, inlinedAt: !1775)
!1775 = !DILocation(line: 3, scope: !1698, inlinedAt: !1776)
!1776 = !DILocation(line: 87, scope: !1718, inlinedAt: !1765)
!1777 = !DILocation(line: 38, scope: !1694, inlinedAt: !1778)
!1778 = !DILocation(line: 3, scope: !1696, inlinedAt: !1779)
!1779 = !DILocation(line: 3, scope: !1698, inlinedAt: !1780)
!1780 = !DILocation(line: 93, scope: !1723, inlinedAt: !1781)
!1781 = !DILocation(line: 130, scope: !1725, inlinedAt: !1766)
!1782 = !DILocation(line: 38, scope: !1694, inlinedAt: !1783)
!1783 = !DILocation(line: 3, scope: !1696, inlinedAt: !1784)
!1784 = !DILocation(line: 3, scope: !1698, inlinedAt: !1785)
!1785 = !DILocation(line: 93, scope: !1732, inlinedAt: !1781)
!1786 = !DILocation(line: 87, scope: !1707, inlinedAt: !1787)
!1787 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1785)
!1788 = !DILocation(line: 38, scope: !1694, inlinedAt: !1789)
!1789 = !DILocation(line: 3, scope: !1696, inlinedAt: !1790)
!1790 = !DILocation(line: 3, scope: !1698, inlinedAt: !1791)
!1791 = !DILocation(line: 93, scope: !1737, inlinedAt: !1781)
!1792 = !DILocation(line: 86, scope: !1739, inlinedAt: !1766)
!1793 = !DILocation(line: 38, scope: !1694, inlinedAt: !1794)
!1794 = !DILocation(line: 32, scope: !1696, inlinedAt: !1795)
!1795 = !DILocation(line: 32, scope: !1743, inlinedAt: !1796)
!1796 = !DILocation(line: 101, scope: !1745, inlinedAt: !1797)
!1797 = !DILocation(line: 138, scope: !1747, inlinedAt: !1766)
!1798 = !DILocation(line: 38, scope: !1694, inlinedAt: !1799)
!1799 = !DILocation(line: 32, scope: !1696, inlinedAt: !1800)
!1800 = !DILocation(line: 32, scope: !1743, inlinedAt: !1801)
!1801 = !DILocation(line: 101, scope: !1752, inlinedAt: !1797)
!1802 = !DILocation(line: 38, scope: !1694, inlinedAt: !1803)
!1803 = !DILocation(line: 32, scope: !1696, inlinedAt: !1804)
!1804 = !DILocation(line: 32, scope: !1743, inlinedAt: !1805)
!1805 = !DILocation(line: 101, scope: !1757, inlinedAt: !1797)
!1806 = !DILocation(line: 88, scope: !1759, inlinedAt: !1766)
!1807 = !DILocation(line: 87, scope: !1707, inlinedAt: !1766)
!1808 = !DILocation(line: 38, scope: !1694, inlinedAt: !1809)
!1809 = !DILocation(line: 3, scope: !1696, inlinedAt: !1810)
!1810 = !DILocation(line: 3, scope: !1698, inlinedAt: !1811)
!1811 = !DILocation(line: 87, scope: !1700, inlinedAt: !1812)
!1812 = !DILocation(line: 122, scope: !1702, inlinedAt: !1813)
!1813 = !DILocation(line: 335, scope: !1704, inlinedAt: !1705)
!1814 = !DILocation(line: 38, scope: !1694, inlinedAt: !1815)
!1815 = !DILocation(line: 3, scope: !1696, inlinedAt: !1816)
!1816 = !DILocation(line: 3, scope: !1698, inlinedAt: !1817)
!1817 = !DILocation(line: 87, scope: !1713, inlinedAt: !1812)
!1818 = !DILocation(line: 38, scope: !1694, inlinedAt: !1819)
!1819 = !DILocation(line: 3, scope: !1696, inlinedAt: !1820)
!1820 = !DILocation(line: 3, scope: !1698, inlinedAt: !1821)
!1821 = !DILocation(line: 87, scope: !1718, inlinedAt: !1812)
!1822 = !DILocation(line: 87, scope: !1707, inlinedAt: !1823)
!1823 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1821)
!1824 = !DILocation(line: 38, scope: !1694, inlinedAt: !1825)
!1825 = !DILocation(line: 3, scope: !1696, inlinedAt: !1826)
!1826 = !DILocation(line: 3, scope: !1698, inlinedAt: !1827)
!1827 = !DILocation(line: 93, scope: !1723, inlinedAt: !1828)
!1828 = !DILocation(line: 130, scope: !1725, inlinedAt: !1813)
!1829 = !DILocation(line: 38, scope: !1694, inlinedAt: !1830)
!1830 = !DILocation(line: 3, scope: !1696, inlinedAt: !1831)
!1831 = !DILocation(line: 3, scope: !1698, inlinedAt: !1832)
!1832 = !DILocation(line: 93, scope: !1732, inlinedAt: !1828)
!1833 = !DILocation(line: 38, scope: !1694, inlinedAt: !1834)
!1834 = !DILocation(line: 3, scope: !1696, inlinedAt: !1835)
!1835 = !DILocation(line: 3, scope: !1698, inlinedAt: !1836)
!1836 = !DILocation(line: 93, scope: !1737, inlinedAt: !1828)
!1837 = !DILocation(line: 87, scope: !1707, inlinedAt: !1838)
!1838 = !DILocation(line: 1068, scope: !1707, inlinedAt: !1836)
!1839 = !DILocation(line: 86, scope: !1739, inlinedAt: !1813)
!1840 = !DILocation(line: 38, scope: !1694, inlinedAt: !1841)
!1841 = !DILocation(line: 32, scope: !1696, inlinedAt: !1842)
!1842 = !DILocation(line: 32, scope: !1743, inlinedAt: !1843)
!1843 = !DILocation(line: 101, scope: !1745, inlinedAt: !1844)
!1844 = !DILocation(line: 138, scope: !1747, inlinedAt: !1813)
!1845 = !DILocation(line: 38, scope: !1694, inlinedAt: !1846)
!1846 = !DILocation(line: 32, scope: !1696, inlinedAt: !1847)
!1847 = !DILocation(line: 32, scope: !1743, inlinedAt: !1848)
!1848 = !DILocation(line: 101, scope: !1752, inlinedAt: !1844)
!1849 = !DILocation(line: 38, scope: !1694, inlinedAt: !1850)
!1850 = !DILocation(line: 32, scope: !1696, inlinedAt: !1851)
!1851 = !DILocation(line: 32, scope: !1743, inlinedAt: !1852)
!1852 = !DILocation(line: 101, scope: !1757, inlinedAt: !1844)
!1853 = !DILocation(line: 88, scope: !1759, inlinedAt: !1813)
!1854 = !DILocation(line: 87, scope: !1707, inlinedAt: !1813)
!1855 = !DILocation(line: 38, scope: !1694, inlinedAt: !1856)
!1856 = !DILocation(line: 32, scope: !1696, inlinedAt: !1857)
!1857 = !DILocation(line: 32, scope: !1743, inlinedAt: !1858)
!1858 = !DILocation(line: 108, scope: !1859, inlinedAt: !1860)
!1859 = distinct !DISubprogram(name: "gridItemDim_x;", linkageName: "gridItemDim_x", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1860 = !DILocation(line: 146, scope: !1861, inlinedAt: !1862)
!1861 = distinct !DISubprogram(name: "gridItemDim;", linkageName: "gridItemDim", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1862 = !DILocation(line: 336, scope: !1704, inlinedAt: !1705)
!1863 = !DILocation(line: 38, scope: !1694, inlinedAt: !1864)
!1864 = !DILocation(line: 32, scope: !1696, inlinedAt: !1865)
!1865 = !DILocation(line: 32, scope: !1743, inlinedAt: !1866)
!1866 = !DILocation(line: 108, scope: !1867, inlinedAt: !1860)
!1867 = distinct !DISubprogram(name: "gridItemDim_y;", linkageName: "gridItemDim_y", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1868 = !DILocation(line: 38, scope: !1694, inlinedAt: !1869)
!1869 = !DILocation(line: 32, scope: !1696, inlinedAt: !1870)
!1870 = !DILocation(line: 32, scope: !1743, inlinedAt: !1871)
!1871 = !DILocation(line: 108, scope: !1872, inlinedAt: !1860)
!1872 = distinct !DISubprogram(name: "gridItemDim_z;", linkageName: "gridItemDim_z", scope: !143, file: !143, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1873 = !DILocation(line: 761, scope: !1874, inlinedAt: !1875)
!1874 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1875 = !DILocation(line: 787, scope: !1876, inlinedAt: !1862)
!1876 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !327, file: !327, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1877 = !DILocation(line: 86, scope: !1739, inlinedAt: !1878)
!1878 = !DILocation(line: 1068, scope: !1739, inlinedAt: !1879)
!1879 = !DILocation(line: 327, scope: !1880, inlinedAt: !1862)
!1880 = distinct !DISubprogram(name: "_to_linear;", linkageName: "_to_linear", scope: !152, file: !152, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !29, retainedNodes: !137)
!1881 = !DILocation(line: 88, scope: !1759, inlinedAt: !1879)
!1882 = !DILocation(line: 87, scope: !1707, inlinedAt: !1879)
!1883 = !DILocation(line: 339, scope: !1704, inlinedAt: !1705)
!1884 = !DILocation(line: 351, scope: !1704, inlinedAt: !1705)
!1885 = !DILocation(line: 8, scope: !1692)
!1886 = distinct !DISubprogram(name: "gate!", linkageName: "julia_gate!_2598", scope: null, file: !344, line: 37, type: !136, scopeLine: 37, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1887 = !DILocation(line: 38, scope: !1888, inlinedAt: !1889)
!1888 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1889 = !DILocation(line: 0, scope: !1890, inlinedAt: !1891)
!1890 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1891 = !DILocation(line: 0, scope: !1892, inlinedAt: !1893)
!1892 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1893 = !DILocation(line: 38, scope: !1886)
!1894 = !DILocation(line: 37, scope: !1895, inlinedAt: !1893)
!1895 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !348, file: !348, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1896 = !DILocation(line: 576, scope: !1897, inlinedAt: !1893)
!1897 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1898 = !DILocation(line: 39, scope: !1886)
!1899 = !DILocation(line: 44, scope: !1886)
!1900 = !DILocation(line: 35, scope: !1901, inlinedAt: !1902)
!1901 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1902 = !DILocation(line: 155, scope: !1903, inlinedAt: !1899)
!1903 = distinct !DISubprogram(name: "iszero;", linkageName: "iszero", scope: !373, file: !373, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1904 = !DILocation(line: 521, scope: !1905, inlinedAt: !1899)
!1905 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !379, file: !379, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1906 = !DILocation(line: 642, scope: !1907, inlinedAt: !1899)
!1907 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !351, file: !351, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !33, retainedNodes: !137)
!1908 = distinct !DISubprogram(name: "box_int64", linkageName: "julia_box_int64_3002", scope: null, file: !1909, line: 212, type: !136, scopeLine: 212, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1909 = !DIFile(filename: "/home/pxl-th/.julia/packages/GPUCompiler/U36Ed/src/runtime.jl", directory: ".")
!1910 = !DILocation(line: 88, scope: !1911, inlinedAt: !1912)
!1911 = distinct !DISubprogram(name: "malloc;", linkageName: "malloc", scope: !1909, file: !1909, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1912 = !DILocation(line: 183, scope: !1913, inlinedAt: !1914)
!1913 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !1909, file: !1909, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1914 = !DILocation(line: 0, scope: !1915, inlinedAt: !1916)
!1915 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1916 = !DILocation(line: 0, scope: !1917, inlinedAt: !1918)
!1917 = distinct !DISubprogram(name: "box;", linkageName: "box", scope: !339, file: !339, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1918 = !DILocation(line: 212, scope: !1908)
!1919 = !DILocation(line: 38, scope: !1920, inlinedAt: !1921)
!1920 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !140, file: !140, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1921 = !DILocation(line: 141, scope: !1913, inlinedAt: !1922)
!1922 = !DILocation(line: 141, scope: !1923, inlinedAt: !1924)
!1923 = distinct !DISubprogram(name: "type_tag;", linkageName: "type_tag", scope: !1909, file: !1909, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1924 = !DILocation(line: 187, scope: !1913, inlinedAt: !1914)
!1925 = !DILocation(line: 372, scope: !1926, inlinedAt: !1927)
!1926 = distinct !DISubprogram(name: "|;", linkageName: "|", scope: !157, file: !157, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1927 = !DILocation(line: 1068, scope: !1926, inlinedAt: !1924)
!1928 = !DILocation(line: 282, scope: !1929, inlinedAt: !1930)
!1929 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1930 = !DILocation(line: 190, scope: !1913, inlinedAt: !1914)
!1931 = !DILocation(line: 191, scope: !1913, inlinedAt: !1914)
!1932 = !DILocation(line: 253, scope: !1933, inlinedAt: !1934)
!1933 = distinct !DISubprogram(name: "unsafe_pointer_to_objref;", linkageName: "unsafe_pointer_to_objref", scope: !623, file: !623, type: !136, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !99, retainedNodes: !137)
!1934 = !DILocation(line: 193, scope: !1913, inlinedAt: !1914)
