; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@0 = private unnamed_addr constant [40 x i8] c"BoundsError: Out-of-bounds array access\00", align 1

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.x() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.y() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.z() #1

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #2

;  @ /home/pxlth/.julia/dev/t.jl:3 within `ker!`
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE([5 x i64] %state, { [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #3 !dbg !39 {
conversion:
  %.fca.0.0.extract = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %0, 0, 0
;  @ /home/pxlth/.julia/dev/t.jl:6 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:80 within `#getindex`
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ int.jl:513 within `<`
      %.not = icmp eq i64 %.fca.0.0.extract, 0, !dbg !43
; └└└└
  %state.i.fca.0.extract.i3 = extractvalue [5 x i64] %state, 0, !dbg !55
  %1 = inttoptr i64 %state.i.fca.0.extract.i3 to i8*, !dbg !55
  %2 = getelementptr i8, i8* %1, i64 4, !dbg !55
  %3 = bitcast i8* %2 to i32*, !dbg !55
  %4 = cmpxchg i32* %3, i32 0, i32 1 acq_rel acquire, align 4, !dbg !55
  %5 = extractvalue { i32, i1 } %4, 1, !dbg !55
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:80 within `#getindex`
; │┌ @ abstractarray.jl:699 within `checkbounds`
    br i1 %.not, label %L10, label %L29, !dbg !51

L10:                                              ; preds = %conversion
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:35 within `#throw_boundserror`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:107 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
       br i1 %5, label %L12.i20, label %L46.i21, !dbg !56

L12.i20:                                          ; preds = %L10
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %6 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !65, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %7 = add nuw nsw i32 %6, 1, !dbg !79
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %8 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !82, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %9 = add nuw nsw i32 %8, 1, !dbg !87
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %10 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !89, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %11 = add nuw nsw i32 %10, 1, !dbg !94
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %.sroa.018.0..sroa_idx.i8 = getelementptr inbounds i8, i8* %1, i64 8, !dbg !96
         %.sroa.018.0..sroa_cast.i9 = bitcast i8* %.sroa.018.0..sroa_idx.i8 to i32*, !dbg !96
         store i32 %7, i32* %.sroa.018.0..sroa_cast.i9, align 1, !dbg !96
         %.sroa.219.0..sroa_idx.i10 = getelementptr inbounds i8, i8* %1, i64 12, !dbg !96
         %.sroa.219.0..sroa_cast.i11 = bitcast i8* %.sroa.219.0..sroa_idx.i10 to i32*, !dbg !96
         store i32 %9, i32* %.sroa.219.0..sroa_cast.i11, align 1, !dbg !96
         %.sroa.320.0..sroa_idx.i12 = getelementptr inbounds i8, i8* %1, i64 16, !dbg !96
         %.sroa.320.0..sroa_cast.i13 = bitcast i8* %.sroa.320.0..sroa_idx.i12 to i32*, !dbg !96
         store i32 %11, i32* %.sroa.320.0..sroa_cast.i13, align 1, !dbg !96
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %12 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !102, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %13 = add nuw i32 %12, 1, !dbg !111
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !113, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %15 = add nuw i32 %14, 1, !dbg !118
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %16 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !120, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %17 = add nuw i32 %16, 1, !dbg !125
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %.sroa.015.0..sroa_idx.i14 = getelementptr inbounds i8, i8* %1, i64 20, !dbg !127
         %.sroa.015.0..sroa_cast.i15 = bitcast i8* %.sroa.015.0..sroa_idx.i14 to i32*, !dbg !127
         store i32 %13, i32* %.sroa.015.0..sroa_cast.i15, align 1, !dbg !127
         %.sroa.216.0..sroa_idx.i16 = getelementptr inbounds i8, i8* %1, i64 24, !dbg !127
         %.sroa.216.0..sroa_cast.i17 = bitcast i8* %.sroa.216.0..sroa_idx.i16 to i32*, !dbg !127
         store i32 %15, i32* %.sroa.216.0..sroa_cast.i17, align 1, !dbg !127
         %.sroa.317.0..sroa_idx.i18 = getelementptr inbounds i8, i8* %1, i64 28, !dbg !127
         %.sroa.317.0..sroa_cast.i19 = bitcast i8* %.sroa.317.0..sroa_idx.i18 to i32*, !dbg !127
         store i32 %17, i32* %.sroa.317.0..sroa_cast.i19, align 1, !dbg !127
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
         fence syncscope("workgroup") seq_cst, !dbg !130
; ││││││└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !136
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
         fence syncscope("workgroup") seq_cst, !dbg !137
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
       br label %L133.i49.critedge, !dbg !139

L46.i21:                                          ; preds = %L10
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:91 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:25 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %18 = load i32, i32* %3, align 1, !dbg !140, !tbaa !146, !alias.scope !150, !noalias !153
; │││││└└
; │││││┌ @ promotion.jl:639 within `==`
        %.not130 = icmp eq i32 %18, 1, !dbg !158
; │││││└
       br i1 %.not130, label %L53.i28, label %L145.i50, !dbg !161

L53.i28:                                          ; preds = %L46.i21
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:316 within `+`
         %19 = getelementptr i8, i8* %1, i64 8, !dbg !162
; ││││││└
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.010.0..sroa_idx.i22 = bitcast i8* %19 to i32*, !dbg !165
         %.sroa.010.0.copyload.i23 = load i32, i32* %.sroa.010.0..sroa_idx.i22, align 1, !dbg !165, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %20 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !170, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %21 = add nuw nsw i32 %20, 1, !dbg !175
; │││││└└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:551 within `_eq`
; │││││││┌ @ promotion.jl:639 within `==`
          %.not131 = icmp eq i32 %.sroa.010.0.copyload.i23, %21, !dbg !177
; │││││││└
; │││││││ @ tuple.jl:552 within `_eq`
         br i1 %.not131, label %L74.i29, label %L145.i50, !dbg !186

L74.i29:                                          ; preds = %L53.i28
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %22 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !187, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %23 = add nuw nsw i32 %22, 1, !dbg !191
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.313.0..sroa_idx14.i26 = getelementptr i8, i8* %1, i64 16, !dbg !165
         %24 = bitcast i8* %.sroa.313.0..sroa_idx14.i26 to i32*, !dbg !165
         %.sroa.313.0.copyload.i27 = load i32, i32* %24, align 1, !dbg !165, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %25 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !193, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %26 = add nuw nsw i32 %25, 1, !dbg !197
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.211.0..sroa_idx12.i24 = getelementptr i8, i8* %1, i64 12, !dbg !165
         %27 = bitcast i8* %.sroa.211.0..sroa_idx12.i24 to i32*, !dbg !165
         %.sroa.211.0.copyload.i25 = load i32, i32* %27, align 1, !dbg !165, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││││││┌ @ promotion.jl:639 within `==`
          %.not134 = icmp ne i32 %.sroa.211.0.copyload.i25, %26, !dbg !199
          %28 = icmp ne i32 %.sroa.313.0.copyload.i27, %23
; │││││││└
; │││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
         %spec.select = select i1 %.not134, i1 true, i1 %28, !dbg !202
; │││││└└
       br i1 %spec.select, label %L145.i50, label %L91.i40, !dbg !161

L91.i40:                                          ; preds = %L74.i29
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:316 within `+`
         %29 = getelementptr i8, i8* %1, i64 20, !dbg !203
; ││││││└
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.0.0..sroa_idx.i34 = bitcast i8* %29 to i32*, !dbg !205
         %.sroa.0.0.copyload.i35 = load i32, i32* %.sroa.0.0..sroa_idx.i34, align 1, !dbg !205, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %30 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !207, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %31 = add nuw i32 %30, 1, !dbg !212
; │││││└└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:551 within `_eq`
; │││││││┌ @ promotion.jl:639 within `==`
          %.not132 = icmp eq i32 %.sroa.0.0.copyload.i35, %31, !dbg !177
; │││││││└
; │││││││ @ tuple.jl:552 within `_eq`
         br i1 %.not132, label %L112.i41, label %L145.i50, !dbg !186

L112.i41:                                         ; preds = %L91.i40
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %32 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !214, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %33 = add nuw i32 %32, 1, !dbg !218
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.3.0..sroa_idx9.i38 = getelementptr i8, i8* %1, i64 28, !dbg !205
         %34 = bitcast i8* %.sroa.3.0..sroa_idx9.i38 to i32*, !dbg !205
         %.sroa.3.0.copyload.i39 = load i32, i32* %34, align 1, !dbg !205, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %35 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !220, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %36 = add nuw i32 %35, 1, !dbg !224
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.2.0..sroa_idx8.i36 = getelementptr i8, i8* %1, i64 24, !dbg !205
         %37 = bitcast i8* %.sroa.2.0..sroa_idx8.i36 to i32*, !dbg !205
         %.sroa.2.0.copyload.i37 = load i32, i32* %37, align 1, !dbg !205, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││││││┌ @ promotion.jl:639 within `==`
          %.not133 = icmp ne i32 %.sroa.2.0.copyload.i37, %36, !dbg !199
          %38 = icmp ne i32 %.sroa.3.0.copyload.i39, %33
; │││││││└
; │││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
         %spec.select135 = select i1 %.not133, i1 true, i1 %38, !dbg !202
; │││││└└
       br i1 %spec.select135, label %L145.i50, label %L133.i49.critedge, !dbg !161

L133.i49.critedge:                                ; preds = %L112.i41, %L12.i20
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:109 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:65 within `setproperty!`
; │││││┌ @ pointer.jl:316 within `+`
        %39 = getelementptr i8, i8* %1, i64 32, !dbg !226
; │││││└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %40 = bitcast i8* %39 to i8 addrspace(1)**, !dbg !229
        store i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([40 x i8], [40 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*), i8 addrspace(1)** %40, align 1, !dbg !229, !tbaa !146, !alias.scope !150, !noalias !153
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:110 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:71 within `setproperty!`
; │││││┌ @ pointer.jl:316 within `+`
        %41 = getelementptr i8, i8* %1, i64 40, !dbg !231
; │││││└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %42 = bitcast i8* %41 to i64*, !dbg !234
        store i64 39, i64* %42, align 1, !dbg !234
        br label %L145.i50, !dbg !234

L145.i50:                                         ; preds = %L133.i49.critedge, %L112.i41, %L91.i40, %L74.i29, %L53.i28, %L46.i21
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:80 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:52 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %43 = inttoptr i64 %state.i.fca.0.extract.i3 to i32*, !dbg !236
         store i32 1, i32* %43, align 1, !dbg !236
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:82 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `llvm_atomic_cas`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %44 = cmpxchg i32* %3, i32 0, i32 1 acq_rel acquire, align 4, !dbg !245
; ││││││└└
; ││││││┌ @ promotion.jl:639 within `==`
         %45 = extractvalue { i32, i1 } %44, 1, !dbg !254
; ││││││└
        br i1 %45, label %L14.i, label %L133.i67, !dbg !256

L14.i:                                            ; preds = %L145.i50
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %46 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !257, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %47 = add nuw nsw i32 %46, 1, !dbg !267
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %48 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !270, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %49 = add nuw nsw i32 %48, 1, !dbg !275
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %50 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !277, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %51 = add nuw nsw i32 %50, 1, !dbg !282
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.012.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 8, !dbg !284
          %.sroa.012.0..sroa_cast.i = bitcast i8* %.sroa.012.0..sroa_idx.i to i32*, !dbg !284
          store i32 %47, i32* %.sroa.012.0..sroa_cast.i, align 1, !dbg !284
          %.sroa.213.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 12, !dbg !284
          %.sroa.213.0..sroa_cast.i = bitcast i8* %.sroa.213.0..sroa_idx.i to i32*, !dbg !284
          store i32 %49, i32* %.sroa.213.0..sroa_cast.i, align 1, !dbg !284
          %.sroa.314.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 16, !dbg !284
          %.sroa.314.0..sroa_cast.i = bitcast i8* %.sroa.314.0..sroa_idx.i to i32*, !dbg !284
          store i32 %51, i32* %.sroa.314.0..sroa_cast.i, align 1, !dbg !284
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %52 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !287, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %53 = add nuw i32 %52, 1, !dbg !295
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %54 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !297, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %55 = add nuw i32 %54, 1, !dbg !302
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %56 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !304, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %57 = add nuw i32 %56, 1, !dbg !309
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.09.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 20, !dbg !311
          %.sroa.09.0..sroa_cast.i = bitcast i8* %.sroa.09.0..sroa_idx.i to i32*, !dbg !311
          store i32 %53, i32* %.sroa.09.0..sroa_cast.i, align 1, !dbg !311
          %.sroa.210.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 24, !dbg !311
          %.sroa.210.0..sroa_cast.i = bitcast i8* %.sroa.210.0..sroa_idx.i to i32*, !dbg !311
          store i32 %55, i32* %.sroa.210.0..sroa_cast.i, align 1, !dbg !311
          %.sroa.311.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 28, !dbg !311
          %.sroa.311.0..sroa_cast.i = bitcast i8* %.sroa.311.0..sroa_idx.i to i32*, !dbg !311
          store i32 %57, i32* %.sroa.311.0..sroa_cast.i, align 1, !dbg !311
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !314
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !319
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !320
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
        br label %L133.i67, !dbg !322

L133.i67:                                         ; preds = %L14.i, %L145.i50
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:83 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !323
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:84 within `signal_exception`
       unreachable, !dbg !327

L29:                                              ; preds = %conversion
; └└└└└
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `#setindex!`
; │┌ @ abstractarray.jl:699 within `checkbounds`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:35 within `#throw_boundserror`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:107 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
       br i1 %5, label %L12.i, label %L46.i, !dbg !328

L12.i:                                            ; preds = %L29
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %58 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !334, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %59 = add nuw nsw i32 %58, 1, !dbg !340
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %60 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !342, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %61 = add nuw nsw i32 %60, 1, !dbg !346
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %62 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !348, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %63 = add nuw nsw i32 %62, 1, !dbg !352
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %.sroa.018.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 8, !dbg !354
         %.sroa.018.0..sroa_cast.i = bitcast i8* %.sroa.018.0..sroa_idx.i to i32*, !dbg !354
         store i32 %59, i32* %.sroa.018.0..sroa_cast.i, align 1, !dbg !354
         %.sroa.219.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 12, !dbg !354
         %.sroa.219.0..sroa_cast.i = bitcast i8* %.sroa.219.0..sroa_idx.i to i32*, !dbg !354
         store i32 %61, i32* %.sroa.219.0..sroa_cast.i, align 1, !dbg !354
         %.sroa.320.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 16, !dbg !354
         %.sroa.320.0..sroa_cast.i = bitcast i8* %.sroa.320.0..sroa_idx.i to i32*, !dbg !354
         store i32 %63, i32* %.sroa.320.0..sroa_cast.i, align 1, !dbg !354
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %64 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !357, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %65 = add nuw i32 %64, 1, !dbg !363
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %66 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !365, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %67 = add nuw i32 %66, 1, !dbg !369
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %68 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !371, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %69 = add nuw i32 %68, 1, !dbg !375
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %.sroa.015.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 20, !dbg !377
         %.sroa.015.0..sroa_cast.i = bitcast i8* %.sroa.015.0..sroa_idx.i to i32*, !dbg !377
         store i32 %65, i32* %.sroa.015.0..sroa_cast.i, align 1, !dbg !377
         %.sroa.216.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 24, !dbg !377
         %.sroa.216.0..sroa_cast.i = bitcast i8* %.sroa.216.0..sroa_idx.i to i32*, !dbg !377
         store i32 %67, i32* %.sroa.216.0..sroa_cast.i, align 1, !dbg !377
         %.sroa.317.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 28, !dbg !377
         %.sroa.317.0..sroa_cast.i = bitcast i8* %.sroa.317.0..sroa_idx.i to i32*, !dbg !377
         store i32 %69, i32* %.sroa.317.0..sroa_cast.i, align 1, !dbg !377
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
         fence syncscope("workgroup") seq_cst, !dbg !380
; ││││││└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
        call void @llvm.amdgcn.s.barrier(), !dbg !383
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
         fence syncscope("workgroup") seq_cst, !dbg !384
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
       br label %L133.i.critedge, !dbg !386

L46.i:                                            ; preds = %L29
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:91 within `lock_output!`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:25 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %70 = load i32, i32* %3, align 1, !dbg !387, !tbaa !146, !alias.scope !150, !noalias !153
; │││││└└
; │││││┌ @ promotion.jl:639 within `==`
        %.not120 = icmp eq i32 %70, 1, !dbg !391
; │││││└
       br i1 %.not120, label %L53.i, label %L145.i, !dbg !392

L53.i:                                            ; preds = %L46.i
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:316 within `+`
         %71 = getelementptr i8, i8* %1, i64 8, !dbg !393
; ││││││└
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.010.0..sroa_idx.i = bitcast i8* %71 to i32*, !dbg !395
         %.sroa.010.0.copyload.i = load i32, i32* %.sroa.010.0..sroa_idx.i, align 1, !dbg !395, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %72 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !397, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %73 = add nuw nsw i32 %72, 1, !dbg !402
; │││││└└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:551 within `_eq`
; │││││││┌ @ promotion.jl:639 within `==`
          %.not121 = icmp eq i32 %.sroa.010.0.copyload.i, %73, !dbg !404
; │││││││└
; │││││││ @ tuple.jl:552 within `_eq`
         br i1 %.not121, label %L74.i, label %L145.i, !dbg !408

L74.i:                                            ; preds = %L53.i
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %74 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !409, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %75 = add nuw nsw i32 %74, 1, !dbg !413
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.313.0..sroa_idx14.i = getelementptr i8, i8* %1, i64 16, !dbg !395
         %76 = bitcast i8* %.sroa.313.0..sroa_idx14.i to i32*, !dbg !395
         %.sroa.313.0.copyload.i = load i32, i32* %76, align 1, !dbg !395, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %77 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !415, !range !78
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %78 = add nuw nsw i32 %77, 1, !dbg !419
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.211.0..sroa_idx12.i = getelementptr i8, i8* %1, i64 12, !dbg !395
         %79 = bitcast i8* %.sroa.211.0..sroa_idx12.i to i32*, !dbg !395
         %.sroa.211.0.copyload.i = load i32, i32* %79, align 1, !dbg !395, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││││││┌ @ promotion.jl:639 within `==`
          %.not124 = icmp ne i32 %.sroa.211.0.copyload.i, %78, !dbg !421
          %80 = icmp ne i32 %.sroa.313.0.copyload.i, %75
; │││││││└
; │││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
         %spec.select138 = select i1 %.not124, i1 true, i1 %80, !dbg !424
; │││││└└
       br i1 %spec.select138, label %L145.i, label %L91.i, !dbg !392

L91.i:                                            ; preds = %L74.i
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:316 within `+`
         %81 = getelementptr i8, i8* %1, i64 20, !dbg !425
; ││││││└
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.0.0..sroa_idx.i = bitcast i8* %81 to i32*, !dbg !427
         %.sroa.0.0.copyload.i = load i32, i32* %.sroa.0.0..sroa_idx.i, align 1, !dbg !427, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %82 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !429, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %83 = add nuw i32 %82, 1, !dbg !434
; │││││└└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:551 within `_eq`
; │││││││┌ @ promotion.jl:639 within `==`
          %.not122 = icmp eq i32 %.sroa.0.0.copyload.i, %83, !dbg !404
; │││││││└
; │││││││ @ tuple.jl:552 within `_eq`
         br i1 %.not122, label %L112.i, label %L145.i, !dbg !408

L112.i:                                           ; preds = %L91.i
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %84 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !436, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %85 = add nuw i32 %84, 1, !dbg !440
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.3.0..sroa_idx9.i = getelementptr i8, i8* %1, i64 28, !dbg !427
         %86 = bitcast i8* %.sroa.3.0..sroa_idx9.i to i32*, !dbg !427
         %.sroa.3.0.copyload.i = load i32, i32* %86, align 1, !dbg !427, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
           %87 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !442, !range !110
; │││││││└└
; │││││││┌ @ int.jl:1013 within `+` @ int.jl:87
          %88 = add nuw i32 %87, 1, !dbg !446
; │││││└└└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
         %.sroa.2.0..sroa_idx8.i = getelementptr i8, i8* %1, i64 24, !dbg !427
         %89 = bitcast i8* %.sroa.2.0..sroa_idx8.i to i32*, !dbg !427
         %.sroa.2.0.copyload.i = load i32, i32* %89, align 1, !dbg !427, !tbaa !167, !alias.scope !168, !noalias !169
; │││││└└
; │││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││││││┌ @ promotion.jl:639 within `==`
          %.not123 = icmp ne i32 %.sroa.2.0.copyload.i, %88, !dbg !421
          %90 = icmp ne i32 %.sroa.3.0.copyload.i, %85
; │││││││└
; │││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
         %spec.select139 = select i1 %.not123, i1 true, i1 %90, !dbg !424
; │││││└└
       br i1 %spec.select139, label %L145.i, label %L133.i.critedge, !dbg !392

L133.i.critedge:                                  ; preds = %L112.i, %L12.i
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:109 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:65 within `setproperty!`
; │││││┌ @ pointer.jl:316 within `+`
        %91 = getelementptr i8, i8* %1, i64 32, !dbg !448
; │││││└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %92 = bitcast i8* %91 to i8 addrspace(1)**, !dbg !451
        store i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([40 x i8], [40 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*), i8 addrspace(1)** %92, align 1, !dbg !451, !tbaa !146, !alias.scope !150, !noalias !153
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:110 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:71 within `setproperty!`
; │││││┌ @ pointer.jl:316 within `+`
        %93 = getelementptr i8, i8* %1, i64 40, !dbg !453
; │││││└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %94 = bitcast i8* %93 to i64*, !dbg !456
        store i64 39, i64* %94, align 1, !dbg !456
        br label %L145.i, !dbg !456

L145.i:                                           ; preds = %L133.i.critedge, %L112.i, %L91.i, %L74.i, %L53.i, %L46.i
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112 within `macro expansion`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:80 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:52 within `setproperty!`
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %95 = inttoptr i64 %state.i.fca.0.extract.i3 to i32*, !dbg !458
         store i32 1, i32* %95, align 1, !dbg !458
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:82 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `llvm_atomic_cas`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %96 = cmpxchg i32* %3, i32 0, i32 1 acq_rel acquire, align 4, !dbg !463
; ││││││└└
; ││││││┌ @ promotion.jl:639 within `==`
         %97 = extractvalue { i32, i1 } %96, 1, !dbg !468
; ││││││└
        br i1 %97, label %L14.i87, label %L133.i110, !dbg !469

L14.i87:                                          ; preds = %L145.i
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %98 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !470, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %99 = add nuw nsw i32 %98, 1, !dbg !476
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %100 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !478, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %101 = add nuw nsw i32 %100, 1, !dbg !482
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %102 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !484, !range !78
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %103 = add nuw nsw i32 %102, 1, !dbg !488
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.012.0..sroa_idx.i75 = getelementptr inbounds i8, i8* %1, i64 8, !dbg !490
          %.sroa.012.0..sroa_cast.i76 = bitcast i8* %.sroa.012.0..sroa_idx.i75 to i32*, !dbg !490
          store i32 %99, i32* %.sroa.012.0..sroa_cast.i76, align 1, !dbg !490
          %.sroa.213.0..sroa_idx.i77 = getelementptr inbounds i8, i8* %1, i64 12, !dbg !490
          %.sroa.213.0..sroa_cast.i78 = bitcast i8* %.sroa.213.0..sroa_idx.i77 to i32*, !dbg !490
          store i32 %101, i32* %.sroa.213.0..sroa_cast.i78, align 1, !dbg !490
          %.sroa.314.0..sroa_idx.i79 = getelementptr inbounds i8, i8* %1, i64 16, !dbg !490
          %.sroa.314.0..sroa_cast.i80 = bitcast i8* %.sroa.314.0..sroa_idx.i79 to i32*, !dbg !490
          store i32 %103, i32* %.sroa.314.0..sroa_cast.i80, align 1, !dbg !490
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %104 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !493, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %105 = add nuw i32 %104, 1, !dbg !499
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %106 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !501, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %107 = add nuw i32 %106, 1, !dbg !505
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %108 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !507, !range !110
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %109 = add nuw i32 %108, 1, !dbg !511
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.09.0..sroa_idx.i81 = getelementptr inbounds i8, i8* %1, i64 20, !dbg !513
          %.sroa.09.0..sroa_cast.i82 = bitcast i8* %.sroa.09.0..sroa_idx.i81 to i32*, !dbg !513
          store i32 %105, i32* %.sroa.09.0..sroa_cast.i82, align 1, !dbg !513
          %.sroa.210.0..sroa_idx.i83 = getelementptr inbounds i8, i8* %1, i64 24, !dbg !513
          %.sroa.210.0..sroa_cast.i84 = bitcast i8* %.sroa.210.0..sroa_idx.i83 to i32*, !dbg !513
          store i32 %107, i32* %.sroa.210.0..sroa_cast.i84, align 1, !dbg !513
          %.sroa.311.0..sroa_idx.i85 = getelementptr inbounds i8, i8* %1, i64 28, !dbg !513
          %.sroa.311.0..sroa_cast.i86 = bitcast i8* %.sroa.311.0..sroa_idx.i85 to i32*, !dbg !513
          store i32 %109, i32* %.sroa.311.0..sroa_cast.i86, align 1, !dbg !513
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !516
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !519
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !520
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
        br label %L133.i110, !dbg !522

L133.i110:                                        ; preds = %L14.i87, %L145.i
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:83 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !523
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:84 within `signal_exception`
       unreachable, !dbg !525
; └└└└└
}

attributes #0 = { convergent nocallback nofree nounwind willreturn }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { cold nocallback nofree noreturn nounwind }
attributes #3 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35}
!opencl.ocl.version = !{!36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36}
!llvm.ident = !{!37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37}
!julia.kernel = !{!38}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 0}
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
!36 = !{i32 2, i32 0}
!37 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!38 = !{void ([5 x i64], { [1 x i64], i8 addrspace(1)*, i64 })* @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!39 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_15806", scope: null, file: !40, line: 3, type: !41, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!40 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!41 = !DISubroutineType(types: !42)
!42 = !{}
!43 = !DILocation(line: 513, scope: !44, inlinedAt: !46)
!44 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!45 = !DIFile(filename: "int.jl", directory: ".")
!46 = !DILocation(line: 754, scope: !47, inlinedAt: !49)
!47 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!48 = !DIFile(filename: "abstractarray.jl", directory: ".")
!49 = !DILocation(line: 689, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!51 = !DILocation(line: 699, scope: !50, inlinedAt: !52)
!52 = !DILocation(line: 80, scope: !53, inlinedAt: !55)
!53 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !54, file: !54, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!54 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!55 = !DILocation(line: 6, scope: !39)
!56 = !DILocation(line: 85, scope: !57, inlinedAt: !59)
!57 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!58 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!59 = distinct !DILocation(line: 107, scope: !60, inlinedAt: !61)
!60 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!61 = distinct !DILocation(line: 35, scope: !62, inlinedAt: !64)
!62 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_15821", scope: null, file: !63, line: 35, type: !41, scopeLine: 35, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!63 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!64 = distinct !DILocation(line: 699, scope: !50, inlinedAt: !52)
!65 = !DILocation(line: 39, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !67, file: !67, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!67 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!68 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!70 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!71 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!73 = distinct !DILocation(line: 87, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!75 = distinct !DILocation(line: 122, scope: !76, inlinedAt: !77)
!76 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!77 = distinct !DILocation(line: 87, scope: !57, inlinedAt: !59)
!78 = !{i32 0, i32 1023}
!79 = !DILocation(line: 87, scope: !80, inlinedAt: !81)
!80 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!81 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !73)
!82 = !DILocation(line: 39, scope: !66, inlinedAt: !83)
!83 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !84)
!84 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !85)
!85 = distinct !DILocation(line: 87, scope: !86, inlinedAt: !75)
!86 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!87 = !DILocation(line: 87, scope: !80, inlinedAt: !88)
!88 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !85)
!89 = !DILocation(line: 39, scope: !66, inlinedAt: !90)
!90 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !91)
!91 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !92)
!92 = distinct !DILocation(line: 87, scope: !93, inlinedAt: !75)
!93 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!94 = !DILocation(line: 87, scope: !80, inlinedAt: !95)
!95 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !92)
!96 = !DILocation(line: 180, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!98 = !DIFile(filename: "pointer.jl", directory: ".")
!99 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !100)
!100 = distinct !DILocation(line: 57, scope: !101, inlinedAt: !77)
!101 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!102 = !DILocation(line: 39, scope: !66, inlinedAt: !103)
!103 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !104)
!104 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !105)
!105 = distinct !DILocation(line: 93, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!107 = distinct !DILocation(line: 130, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!109 = distinct !DILocation(line: 88, scope: !57, inlinedAt: !59)
!110 = !{i32 0, i32 -2}
!111 = !DILocation(line: 87, scope: !80, inlinedAt: !112)
!112 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !105)
!113 = !DILocation(line: 39, scope: !66, inlinedAt: !114)
!114 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !115)
!115 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !116)
!116 = distinct !DILocation(line: 93, scope: !117, inlinedAt: !107)
!117 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!118 = !DILocation(line: 87, scope: !80, inlinedAt: !119)
!119 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !116)
!120 = !DILocation(line: 39, scope: !66, inlinedAt: !121)
!121 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !122)
!122 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !123)
!123 = distinct !DILocation(line: 93, scope: !124, inlinedAt: !107)
!124 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!125 = !DILocation(line: 87, scope: !80, inlinedAt: !126)
!126 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !123)
!127 = !DILocation(line: 180, scope: !97, inlinedAt: !128)
!128 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !129)
!129 = distinct !DILocation(line: 60, scope: !101, inlinedAt: !109)
!130 = !DILocation(line: 5, scope: !131, inlinedAt: !133)
!131 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !132, file: !132, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!132 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!133 = distinct !DILocation(line: 27, scope: !134, inlinedAt: !135)
!134 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !132, file: !132, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!135 = distinct !DILocation(line: 89, scope: !57, inlinedAt: !59)
!136 = !DILocation(line: 28, scope: !134, inlinedAt: !135)
!137 = !DILocation(line: 5, scope: !131, inlinedAt: !138)
!138 = distinct !DILocation(line: 29, scope: !134, inlinedAt: !135)
!139 = !DILocation(line: 90, scope: !57, inlinedAt: !59)
!140 = !DILocation(line: 153, scope: !141, inlinedAt: !142)
!141 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!142 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !143)
!143 = distinct !DILocation(line: 25, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!145 = distinct !DILocation(line: 91, scope: !57, inlinedAt: !59)
!146 = !{!147, !147, i64 0}
!147 = !{!"jtbaa_data", !148, i64 0}
!148 = !{!"jtbaa", !149, i64 0}
!149 = !{!"jtbaa"}
!150 = !{!151}
!151 = !{!"jnoalias_data", !152}
!152 = !{!"jnoalias"}
!153 = !{!154, !155, !156, !157}
!154 = !{!"jnoalias_gcframe", !152}
!155 = !{!"jnoalias_stack", !152}
!156 = !{!"jnoalias_typemd", !152}
!157 = !{!"jnoalias_const", !152}
!158 = !DILocation(line: 639, scope: !159, inlinedAt: !145)
!159 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !160, file: !160, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!160 = !DIFile(filename: "promotion.jl", directory: ".")
!161 = !DILocation(line: 91, scope: !57, inlinedAt: !59)
!162 = !DILocation(line: 316, scope: !163, inlinedAt: !164)
!163 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!164 = distinct !DILocation(line: 30, scope: !144, inlinedAt: !145)
!165 = !DILocation(line: 153, scope: !141, inlinedAt: !166)
!166 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !164)
!167 = !{!148, !148, i64 0}
!168 = !{!151, !155}
!169 = !{!154, !156, !157}
!170 = !DILocation(line: 39, scope: !66, inlinedAt: !171)
!171 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !172)
!172 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !173)
!173 = distinct !DILocation(line: 87, scope: !74, inlinedAt: !174)
!174 = distinct !DILocation(line: 122, scope: !76, inlinedAt: !145)
!175 = !DILocation(line: 87, scope: !80, inlinedAt: !176)
!176 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !173)
!177 = !DILocation(line: 639, scope: !159, inlinedAt: !178)
!178 = distinct !DILocation(line: 551, scope: !179, inlinedAt: !181)
!179 = distinct !DISubprogram(name: "_eq;", linkageName: "_eq", scope: !180, file: !180, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!180 = !DIFile(filename: "tuple.jl", directory: ".")
!181 = distinct !DILocation(line: 547, scope: !182, inlinedAt: !183)
!182 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !180, file: !180, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!183 = distinct !DILocation(line: 244, scope: !184, inlinedAt: !145)
!184 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !185, file: !185, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!185 = !DIFile(filename: "namedtuple.jl", directory: ".")
!186 = !DILocation(line: 552, scope: !179, inlinedAt: !181)
!187 = !DILocation(line: 39, scope: !66, inlinedAt: !188)
!188 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !189)
!189 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !190)
!190 = distinct !DILocation(line: 87, scope: !93, inlinedAt: !174)
!191 = !DILocation(line: 87, scope: !80, inlinedAt: !192)
!192 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !190)
!193 = !DILocation(line: 39, scope: !66, inlinedAt: !194)
!194 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !195)
!195 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !196)
!196 = distinct !DILocation(line: 87, scope: !86, inlinedAt: !174)
!197 = !DILocation(line: 87, scope: !80, inlinedAt: !198)
!198 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !196)
!199 = !DILocation(line: 639, scope: !159, inlinedAt: !200)
!200 = distinct !DILocation(line: 551, scope: !179, inlinedAt: !201)
!201 = distinct !DILocation(line: 557, scope: !179, inlinedAt: !181)
!202 = !DILocation(line: 552, scope: !179, inlinedAt: !201)
!203 = !DILocation(line: 316, scope: !163, inlinedAt: !204)
!204 = distinct !DILocation(line: 33, scope: !144, inlinedAt: !145)
!205 = !DILocation(line: 153, scope: !141, inlinedAt: !206)
!206 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !204)
!207 = !DILocation(line: 39, scope: !66, inlinedAt: !208)
!208 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !209)
!209 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !210)
!210 = distinct !DILocation(line: 93, scope: !106, inlinedAt: !211)
!211 = distinct !DILocation(line: 130, scope: !108, inlinedAt: !145)
!212 = !DILocation(line: 87, scope: !80, inlinedAt: !213)
!213 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !210)
!214 = !DILocation(line: 39, scope: !66, inlinedAt: !215)
!215 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !216)
!216 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !217)
!217 = distinct !DILocation(line: 93, scope: !124, inlinedAt: !211)
!218 = !DILocation(line: 87, scope: !80, inlinedAt: !219)
!219 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !217)
!220 = !DILocation(line: 39, scope: !66, inlinedAt: !221)
!221 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !222)
!222 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !223)
!223 = distinct !DILocation(line: 93, scope: !117, inlinedAt: !211)
!224 = !DILocation(line: 87, scope: !80, inlinedAt: !225)
!225 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !223)
!226 = !DILocation(line: 316, scope: !163, inlinedAt: !227)
!227 = distinct !DILocation(line: 65, scope: !101, inlinedAt: !228)
!228 = distinct !DILocation(line: 109, scope: !60, inlinedAt: !61)
!229 = !DILocation(line: 180, scope: !97, inlinedAt: !230)
!230 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !227)
!231 = !DILocation(line: 316, scope: !163, inlinedAt: !232)
!232 = distinct !DILocation(line: 71, scope: !101, inlinedAt: !233)
!233 = distinct !DILocation(line: 110, scope: !60, inlinedAt: !61)
!234 = !DILocation(line: 180, scope: !97, inlinedAt: !235)
!235 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !232)
!236 = !DILocation(line: 180, scope: !237, inlinedAt: !238)
!237 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!238 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !239)
!239 = distinct !DILocation(line: 52, scope: !240, inlinedAt: !241)
!240 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!241 = distinct !DILocation(line: 80, scope: !242, inlinedAt: !244)
!242 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14626", scope: null, file: !243, line: 78, type: !41, scopeLine: 78, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!243 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!244 = distinct !DILocation(line: 112, scope: !60, inlinedAt: !61)
!245 = !DILocation(line: 39, scope: !246, inlinedAt: !247)
!246 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !67, file: !67, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!247 = distinct !DILocation(line: 10, scope: !248, inlinedAt: !249)
!248 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !243, file: !243, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!249 = distinct !DILocation(line: 10, scope: !250, inlinedAt: !251)
!250 = distinct !DISubprogram(name: "llvm_atomic_cas;", linkageName: "llvm_atomic_cas", scope: !243, file: !243, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!251 = distinct !DILocation(line: 85, scope: !252, inlinedAt: !253)
!252 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !58, file: !58, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!253 = distinct !DILocation(line: 82, scope: !242, inlinedAt: !244)
!254 = !DILocation(line: 639, scope: !255, inlinedAt: !251)
!255 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !160, file: !160, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!256 = !DILocation(line: 85, scope: !252, inlinedAt: !253)
!257 = !DILocation(line: 39, scope: !246, inlinedAt: !258)
!258 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !260)
!259 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!260 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !262)
!261 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!262 = distinct !DILocation(line: 87, scope: !263, inlinedAt: !264)
!263 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!264 = distinct !DILocation(line: 122, scope: !265, inlinedAt: !266)
!265 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!266 = distinct !DILocation(line: 87, scope: !252, inlinedAt: !253)
!267 = !DILocation(line: 87, scope: !268, inlinedAt: !269)
!268 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!269 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !262)
!270 = !DILocation(line: 39, scope: !246, inlinedAt: !271)
!271 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !272)
!272 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !273)
!273 = distinct !DILocation(line: 87, scope: !274, inlinedAt: !264)
!274 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!275 = !DILocation(line: 87, scope: !268, inlinedAt: !276)
!276 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !273)
!277 = !DILocation(line: 39, scope: !246, inlinedAt: !278)
!278 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !279)
!279 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !280)
!280 = distinct !DILocation(line: 87, scope: !281, inlinedAt: !264)
!281 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!282 = !DILocation(line: 87, scope: !268, inlinedAt: !283)
!283 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !280)
!284 = !DILocation(line: 180, scope: !237, inlinedAt: !285)
!285 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !286)
!286 = distinct !DILocation(line: 57, scope: !240, inlinedAt: !266)
!287 = !DILocation(line: 39, scope: !246, inlinedAt: !288)
!288 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !289)
!289 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !290)
!290 = distinct !DILocation(line: 93, scope: !291, inlinedAt: !292)
!291 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!292 = distinct !DILocation(line: 130, scope: !293, inlinedAt: !294)
!293 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!294 = distinct !DILocation(line: 88, scope: !252, inlinedAt: !253)
!295 = !DILocation(line: 87, scope: !268, inlinedAt: !296)
!296 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !290)
!297 = !DILocation(line: 39, scope: !246, inlinedAt: !298)
!298 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !299)
!299 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !300)
!300 = distinct !DILocation(line: 93, scope: !301, inlinedAt: !292)
!301 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!302 = !DILocation(line: 87, scope: !268, inlinedAt: !303)
!303 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !300)
!304 = !DILocation(line: 39, scope: !246, inlinedAt: !305)
!305 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !306)
!306 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !307)
!307 = distinct !DILocation(line: 93, scope: !308, inlinedAt: !292)
!308 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !70, file: !70, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!309 = !DILocation(line: 87, scope: !268, inlinedAt: !310)
!310 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !307)
!311 = !DILocation(line: 180, scope: !237, inlinedAt: !312)
!312 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !313)
!313 = distinct !DILocation(line: 60, scope: !240, inlinedAt: !294)
!314 = !DILocation(line: 5, scope: !315, inlinedAt: !316)
!315 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !132, file: !132, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!316 = distinct !DILocation(line: 27, scope: !317, inlinedAt: !318)
!317 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !132, file: !132, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!318 = distinct !DILocation(line: 89, scope: !252, inlinedAt: !253)
!319 = !DILocation(line: 28, scope: !317, inlinedAt: !318)
!320 = !DILocation(line: 5, scope: !315, inlinedAt: !321)
!321 = distinct !DILocation(line: 29, scope: !317, inlinedAt: !318)
!322 = !DILocation(line: 90, scope: !252, inlinedAt: !253)
!323 = !DILocation(line: 6, scope: !324, inlinedAt: !326)
!324 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!325 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!326 = distinct !DILocation(line: 83, scope: !242, inlinedAt: !244)
!327 = !DILocation(line: 84, scope: !242, inlinedAt: !244)
!328 = !DILocation(line: 85, scope: !57, inlinedAt: !329)
!329 = distinct !DILocation(line: 107, scope: !60, inlinedAt: !330)
!330 = distinct !DILocation(line: 35, scope: !62, inlinedAt: !331)
!331 = distinct !DILocation(line: 699, scope: !50, inlinedAt: !332)
!332 = !DILocation(line: 85, scope: !333, inlinedAt: !55)
!333 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !54, file: !54, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!334 = !DILocation(line: 39, scope: !66, inlinedAt: !335)
!335 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !336)
!336 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !337)
!337 = distinct !DILocation(line: 87, scope: !74, inlinedAt: !338)
!338 = distinct !DILocation(line: 122, scope: !76, inlinedAt: !339)
!339 = distinct !DILocation(line: 87, scope: !57, inlinedAt: !329)
!340 = !DILocation(line: 87, scope: !80, inlinedAt: !341)
!341 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !337)
!342 = !DILocation(line: 39, scope: !66, inlinedAt: !343)
!343 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !344)
!344 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !345)
!345 = distinct !DILocation(line: 87, scope: !86, inlinedAt: !338)
!346 = !DILocation(line: 87, scope: !80, inlinedAt: !347)
!347 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !345)
!348 = !DILocation(line: 39, scope: !66, inlinedAt: !349)
!349 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !350)
!350 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !351)
!351 = distinct !DILocation(line: 87, scope: !93, inlinedAt: !338)
!352 = !DILocation(line: 87, scope: !80, inlinedAt: !353)
!353 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !351)
!354 = !DILocation(line: 180, scope: !97, inlinedAt: !355)
!355 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !356)
!356 = distinct !DILocation(line: 57, scope: !101, inlinedAt: !339)
!357 = !DILocation(line: 39, scope: !66, inlinedAt: !358)
!358 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !359)
!359 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !360)
!360 = distinct !DILocation(line: 93, scope: !106, inlinedAt: !361)
!361 = distinct !DILocation(line: 130, scope: !108, inlinedAt: !362)
!362 = distinct !DILocation(line: 88, scope: !57, inlinedAt: !329)
!363 = !DILocation(line: 87, scope: !80, inlinedAt: !364)
!364 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !360)
!365 = !DILocation(line: 39, scope: !66, inlinedAt: !366)
!366 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !367)
!367 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !368)
!368 = distinct !DILocation(line: 93, scope: !117, inlinedAt: !361)
!369 = !DILocation(line: 87, scope: !80, inlinedAt: !370)
!370 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !368)
!371 = !DILocation(line: 39, scope: !66, inlinedAt: !372)
!372 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !373)
!373 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !374)
!374 = distinct !DILocation(line: 93, scope: !124, inlinedAt: !361)
!375 = !DILocation(line: 87, scope: !80, inlinedAt: !376)
!376 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !374)
!377 = !DILocation(line: 180, scope: !97, inlinedAt: !378)
!378 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !379)
!379 = distinct !DILocation(line: 60, scope: !101, inlinedAt: !362)
!380 = !DILocation(line: 5, scope: !131, inlinedAt: !381)
!381 = distinct !DILocation(line: 27, scope: !134, inlinedAt: !382)
!382 = distinct !DILocation(line: 89, scope: !57, inlinedAt: !329)
!383 = !DILocation(line: 28, scope: !134, inlinedAt: !382)
!384 = !DILocation(line: 5, scope: !131, inlinedAt: !385)
!385 = distinct !DILocation(line: 29, scope: !134, inlinedAt: !382)
!386 = !DILocation(line: 90, scope: !57, inlinedAt: !329)
!387 = !DILocation(line: 153, scope: !141, inlinedAt: !388)
!388 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !389)
!389 = distinct !DILocation(line: 25, scope: !144, inlinedAt: !390)
!390 = distinct !DILocation(line: 91, scope: !57, inlinedAt: !329)
!391 = !DILocation(line: 639, scope: !159, inlinedAt: !390)
!392 = !DILocation(line: 91, scope: !57, inlinedAt: !329)
!393 = !DILocation(line: 316, scope: !163, inlinedAt: !394)
!394 = distinct !DILocation(line: 30, scope: !144, inlinedAt: !390)
!395 = !DILocation(line: 153, scope: !141, inlinedAt: !396)
!396 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !394)
!397 = !DILocation(line: 39, scope: !66, inlinedAt: !398)
!398 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !399)
!399 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !400)
!400 = distinct !DILocation(line: 87, scope: !74, inlinedAt: !401)
!401 = distinct !DILocation(line: 122, scope: !76, inlinedAt: !390)
!402 = !DILocation(line: 87, scope: !80, inlinedAt: !403)
!403 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !400)
!404 = !DILocation(line: 639, scope: !159, inlinedAt: !405)
!405 = distinct !DILocation(line: 551, scope: !179, inlinedAt: !406)
!406 = distinct !DILocation(line: 547, scope: !182, inlinedAt: !407)
!407 = distinct !DILocation(line: 244, scope: !184, inlinedAt: !390)
!408 = !DILocation(line: 552, scope: !179, inlinedAt: !406)
!409 = !DILocation(line: 39, scope: !66, inlinedAt: !410)
!410 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !411)
!411 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !412)
!412 = distinct !DILocation(line: 87, scope: !93, inlinedAt: !401)
!413 = !DILocation(line: 87, scope: !80, inlinedAt: !414)
!414 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !412)
!415 = !DILocation(line: 39, scope: !66, inlinedAt: !416)
!416 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !417)
!417 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !418)
!418 = distinct !DILocation(line: 87, scope: !86, inlinedAt: !401)
!419 = !DILocation(line: 87, scope: !80, inlinedAt: !420)
!420 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !418)
!421 = !DILocation(line: 639, scope: !159, inlinedAt: !422)
!422 = distinct !DILocation(line: 551, scope: !179, inlinedAt: !423)
!423 = distinct !DILocation(line: 557, scope: !179, inlinedAt: !406)
!424 = !DILocation(line: 552, scope: !179, inlinedAt: !423)
!425 = !DILocation(line: 316, scope: !163, inlinedAt: !426)
!426 = distinct !DILocation(line: 33, scope: !144, inlinedAt: !390)
!427 = !DILocation(line: 153, scope: !141, inlinedAt: !428)
!428 = distinct !DILocation(line: 153, scope: !141, inlinedAt: !426)
!429 = !DILocation(line: 39, scope: !66, inlinedAt: !430)
!430 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !431)
!431 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !432)
!432 = distinct !DILocation(line: 93, scope: !106, inlinedAt: !433)
!433 = distinct !DILocation(line: 130, scope: !108, inlinedAt: !390)
!434 = !DILocation(line: 87, scope: !80, inlinedAt: !435)
!435 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !432)
!436 = !DILocation(line: 39, scope: !66, inlinedAt: !437)
!437 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !438)
!438 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !439)
!439 = distinct !DILocation(line: 93, scope: !124, inlinedAt: !433)
!440 = !DILocation(line: 87, scope: !80, inlinedAt: !441)
!441 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !439)
!442 = !DILocation(line: 39, scope: !66, inlinedAt: !443)
!443 = distinct !DILocation(line: 3, scope: !69, inlinedAt: !444)
!444 = distinct !DILocation(line: 3, scope: !72, inlinedAt: !445)
!445 = distinct !DILocation(line: 93, scope: !117, inlinedAt: !433)
!446 = !DILocation(line: 87, scope: !80, inlinedAt: !447)
!447 = distinct !DILocation(line: 1013, scope: !80, inlinedAt: !445)
!448 = !DILocation(line: 316, scope: !163, inlinedAt: !449)
!449 = distinct !DILocation(line: 65, scope: !101, inlinedAt: !450)
!450 = distinct !DILocation(line: 109, scope: !60, inlinedAt: !330)
!451 = !DILocation(line: 180, scope: !97, inlinedAt: !452)
!452 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !449)
!453 = !DILocation(line: 316, scope: !163, inlinedAt: !454)
!454 = distinct !DILocation(line: 71, scope: !101, inlinedAt: !455)
!455 = distinct !DILocation(line: 110, scope: !60, inlinedAt: !330)
!456 = !DILocation(line: 180, scope: !97, inlinedAt: !457)
!457 = distinct !DILocation(line: 180, scope: !97, inlinedAt: !454)
!458 = !DILocation(line: 180, scope: !237, inlinedAt: !459)
!459 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !460)
!460 = distinct !DILocation(line: 52, scope: !240, inlinedAt: !461)
!461 = distinct !DILocation(line: 80, scope: !242, inlinedAt: !462)
!462 = distinct !DILocation(line: 112, scope: !60, inlinedAt: !330)
!463 = !DILocation(line: 39, scope: !246, inlinedAt: !464)
!464 = distinct !DILocation(line: 10, scope: !248, inlinedAt: !465)
!465 = distinct !DILocation(line: 10, scope: !250, inlinedAt: !466)
!466 = distinct !DILocation(line: 85, scope: !252, inlinedAt: !467)
!467 = distinct !DILocation(line: 82, scope: !242, inlinedAt: !462)
!468 = !DILocation(line: 639, scope: !255, inlinedAt: !466)
!469 = !DILocation(line: 85, scope: !252, inlinedAt: !467)
!470 = !DILocation(line: 39, scope: !246, inlinedAt: !471)
!471 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !472)
!472 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !473)
!473 = distinct !DILocation(line: 87, scope: !263, inlinedAt: !474)
!474 = distinct !DILocation(line: 122, scope: !265, inlinedAt: !475)
!475 = distinct !DILocation(line: 87, scope: !252, inlinedAt: !467)
!476 = !DILocation(line: 87, scope: !268, inlinedAt: !477)
!477 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !473)
!478 = !DILocation(line: 39, scope: !246, inlinedAt: !479)
!479 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !480)
!480 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !481)
!481 = distinct !DILocation(line: 87, scope: !274, inlinedAt: !474)
!482 = !DILocation(line: 87, scope: !268, inlinedAt: !483)
!483 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !481)
!484 = !DILocation(line: 39, scope: !246, inlinedAt: !485)
!485 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !486)
!486 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !487)
!487 = distinct !DILocation(line: 87, scope: !281, inlinedAt: !474)
!488 = !DILocation(line: 87, scope: !268, inlinedAt: !489)
!489 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !487)
!490 = !DILocation(line: 180, scope: !237, inlinedAt: !491)
!491 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !492)
!492 = distinct !DILocation(line: 57, scope: !240, inlinedAt: !475)
!493 = !DILocation(line: 39, scope: !246, inlinedAt: !494)
!494 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !495)
!495 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !496)
!496 = distinct !DILocation(line: 93, scope: !291, inlinedAt: !497)
!497 = distinct !DILocation(line: 130, scope: !293, inlinedAt: !498)
!498 = distinct !DILocation(line: 88, scope: !252, inlinedAt: !467)
!499 = !DILocation(line: 87, scope: !268, inlinedAt: !500)
!500 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !496)
!501 = !DILocation(line: 39, scope: !246, inlinedAt: !502)
!502 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !503)
!503 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !504)
!504 = distinct !DILocation(line: 93, scope: !301, inlinedAt: !497)
!505 = !DILocation(line: 87, scope: !268, inlinedAt: !506)
!506 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !504)
!507 = !DILocation(line: 39, scope: !246, inlinedAt: !508)
!508 = distinct !DILocation(line: 3, scope: !259, inlinedAt: !509)
!509 = distinct !DILocation(line: 3, scope: !261, inlinedAt: !510)
!510 = distinct !DILocation(line: 93, scope: !308, inlinedAt: !497)
!511 = !DILocation(line: 87, scope: !268, inlinedAt: !512)
!512 = distinct !DILocation(line: 1013, scope: !268, inlinedAt: !510)
!513 = !DILocation(line: 180, scope: !237, inlinedAt: !514)
!514 = distinct !DILocation(line: 180, scope: !237, inlinedAt: !515)
!515 = distinct !DILocation(line: 60, scope: !240, inlinedAt: !498)
!516 = !DILocation(line: 5, scope: !315, inlinedAt: !517)
!517 = distinct !DILocation(line: 27, scope: !317, inlinedAt: !518)
!518 = distinct !DILocation(line: 89, scope: !252, inlinedAt: !467)
!519 = !DILocation(line: 28, scope: !317, inlinedAt: !518)
!520 = !DILocation(line: 5, scope: !315, inlinedAt: !521)
!521 = distinct !DILocation(line: 29, scope: !317, inlinedAt: !518)
!522 = !DILocation(line: 90, scope: !252, inlinedAt: !467)
!523 = !DILocation(line: 6, scope: !324, inlinedAt: !524)
!524 = distinct !DILocation(line: 83, scope: !242, inlinedAt: !462)
!525 = !DILocation(line: 84, scope: !242, inlinedAt: !462)
