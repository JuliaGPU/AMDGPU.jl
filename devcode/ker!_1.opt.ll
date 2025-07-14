; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@0 = private unnamed_addr constant [12 x i8] c"BoundsError\00", align 1
@1 = private unnamed_addr constant [27 x i8] c"Out-of-bounds array access\00", align 1

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
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE([5 x i64] %state, { [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #3 !dbg !46 {
conversion:
;  @ /home/pxlth/.julia/dev/t.jl:4 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `#setindex!`
; │┌ @ abstractarray.jl:699 within `checkbounds`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:36 within `#throw_boundserror`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:35 within `_throw_boundserror`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:133 within `macro expansion`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %state.i.fca.0.extract.i = extractvalue [5 x i64] %state, 0, !dbg !50
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:134 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:29 within `getproperty`
; │││││││┌ @ pointer.jl:316 within `+`
          %1 = inttoptr i64 %state.i.fca.0.extract.i to i8*, !dbg !73
          %2 = getelementptr i8, i8* %1, i64 4, !dbg !73
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `llvm_atomic_cas`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %3 = bitcast i8* %2 to i32*, !dbg !81
          %4 = cmpxchg i32* %3, i32 0, i32 1 acq_rel acquire, align 4, !dbg !81
; ││││││└└
; ││││││┌ @ promotion.jl:639 within `==`
         %5 = extractvalue { i32, i1 } %4, 1, !dbg !87
; ││││││└
        br i1 %5, label %L12.i, label %L46.i, !dbg !90

L12.i:                                            ; preds = %conversion
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:114 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %6 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !91, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %7 = add nuw nsw i32 %6, 1, !dbg !103
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %8 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !107, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %9 = add nuw nsw i32 %8, 1, !dbg !112
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %10 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !114, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %11 = add nuw nsw i32 %10, 1, !dbg !119
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:72 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.029.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 8, !dbg !121
          %.sroa.029.0..sroa_cast.i = bitcast i8* %.sroa.029.0..sroa_idx.i to i32*, !dbg !121
          store i32 %7, i32* %.sroa.029.0..sroa_cast.i, align 1, !dbg !121
          %.sroa.230.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 12, !dbg !121
          %.sroa.230.0..sroa_cast.i = bitcast i8* %.sroa.230.0..sroa_idx.i to i32*, !dbg !121
          store i32 %9, i32* %.sroa.230.0..sroa_cast.i, align 1, !dbg !121
          %.sroa.331.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 16, !dbg !121
          %.sroa.331.0..sroa_cast.i = bitcast i8* %.sroa.331.0..sroa_idx.i to i32*, !dbg !121
          store i32 %11, i32* %.sroa.331.0..sroa_cast.i, align 1, !dbg !121
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:115 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %12 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !126, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %13 = add nuw i32 %12, 1, !dbg !135
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %14 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !137, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %15 = add nuw i32 %14, 1, !dbg !142
; │││││││└└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %16 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !144, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %17 = add nuw i32 %16, 1, !dbg !149
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:75 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %.sroa.026.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 20, !dbg !151
          %.sroa.026.0..sroa_cast.i = bitcast i8* %.sroa.026.0..sroa_idx.i to i32*, !dbg !151
          store i32 %13, i32* %.sroa.026.0..sroa_cast.i, align 1, !dbg !151
          %.sroa.227.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 24, !dbg !151
          %.sroa.227.0..sroa_cast.i = bitcast i8* %.sroa.227.0..sroa_idx.i to i32*, !dbg !151
          store i32 %15, i32* %.sroa.227.0..sroa_cast.i, align 1, !dbg !151
          %.sroa.328.0..sroa_idx.i = getelementptr inbounds i8, i8* %1, i64 28, !dbg !151
          %.sroa.328.0..sroa_cast.i = bitcast i8* %.sroa.328.0..sroa_idx.i to i32*, !dbg !151
          store i32 %17, i32* %.sroa.328.0..sroa_cast.i, align 1, !dbg !151
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:116 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !154
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
         call void @llvm.amdgcn.s.barrier(), !dbg !160
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
          fence syncscope("workgroup") seq_cst, !dbg !161
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:117 within `lock_output!`
        br label %L133.i.critedge, !dbg !163

L46.i:                                            ; preds = %conversion
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:118 within `lock_output!`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:27 within `getproperty`
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %18 = load i32, i32* %3, align 1, !dbg !164, !tbaa !169, !alias.scope !173, !noalias !176
; ││││││└└
; ││││││┌ @ promotion.jl:639 within `==`
         %.not = icmp eq i32 %18, 1, !dbg !181
; ││││││└
        br i1 %.not, label %L53.i, label %L287.i, !dbg !182

L53.i:                                            ; preds = %L46.i
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:32 within `getproperty`
; │││││││┌ @ pointer.jl:316 within `+`
          %19 = getelementptr i8, i8* %1, i64 8, !dbg !183
; │││││││└
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.021.0..sroa_idx.i = bitcast i8* %19 to i32*, !dbg !185
          %.sroa.021.0.copyload.i = load i32, i32* %.sroa.021.0..sroa_idx.i, align 1, !dbg !185, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %20 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !190, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %21 = add nuw nsw i32 %20, 1, !dbg !195
; ││││││└└└
; ││││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││││││┌ @ tuple.jl:551 within `_eq`
; ││││││││┌ @ promotion.jl:639 within `==`
           %.not9 = icmp eq i32 %.sroa.021.0.copyload.i, %21, !dbg !197
; ││││││││└
; ││││││││ @ tuple.jl:552 within `_eq`
          br i1 %.not9, label %L74.i, label %L287.i, !dbg !206

L74.i:                                            ; preds = %L53.i
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %22 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !207, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %23 = add nuw nsw i32 %22, 1, !dbg !211
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:32 within `getproperty`
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.324.0..sroa_idx25.i = getelementptr i8, i8* %1, i64 16, !dbg !185
          %24 = bitcast i8* %.sroa.324.0..sroa_idx25.i to i32*, !dbg !185
          %.sroa.324.0.copyload.i = load i32, i32* %24, align 1, !dbg !185, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %25 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !213, !range !102
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %26 = add nuw nsw i32 %25, 1, !dbg !217
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:32 within `getproperty`
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.222.0..sroa_idx23.i = getelementptr i8, i8* %1, i64 12, !dbg !185
          %27 = bitcast i8* %.sroa.222.0..sroa_idx23.i to i32*, !dbg !185
          %.sroa.222.0.copyload.i = load i32, i32* %27, align 1, !dbg !185, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││││││┌ @ promotion.jl:639 within `==`
           %.not12 = icmp ne i32 %.sroa.222.0.copyload.i, %26, !dbg !219
           %28 = icmp ne i32 %.sroa.324.0.copyload.i, %23
; ││││││││└
; ││││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
          %spec.select = select i1 %.not12, i1 true, i1 %28, !dbg !222
; ││││││└└
        br i1 %spec.select, label %L287.i, label %L91.i, !dbg !182

L91.i:                                            ; preds = %L74.i
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:35 within `getproperty`
; │││││││┌ @ pointer.jl:316 within `+`
          %29 = getelementptr i8, i8* %1, i64 20, !dbg !223
; │││││││└
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.0.0..sroa_idx.i = bitcast i8* %29 to i32*, !dbg !225
          %.sroa.0.0.copyload.i = load i32, i32* %.sroa.0.0..sroa_idx.i, align 1, !dbg !225, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %30 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !227, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %31 = add nuw i32 %30, 1, !dbg !232
; ││││││└└└
; ││││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││││││┌ @ tuple.jl:551 within `_eq`
; ││││││││┌ @ promotion.jl:639 within `==`
           %.not10 = icmp eq i32 %.sroa.0.0.copyload.i, %31, !dbg !197
; ││││││││└
; ││││││││ @ tuple.jl:552 within `_eq`
          br i1 %.not10, label %L112.i, label %L287.i, !dbg !206

L112.i:                                           ; preds = %L91.i
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %32 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !234, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %33 = add nuw i32 %32, 1, !dbg !238
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:35 within `getproperty`
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.3.0..sroa_idx20.i = getelementptr i8, i8* %1, i64 28, !dbg !225
          %34 = bitcast i8* %.sroa.3.0..sroa_idx20.i to i32*, !dbg !225
          %.sroa.3.0.copyload.i = load i32, i32* %34, align 1, !dbg !225, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
            %35 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !240, !range !134
; ││││││││└└
; ││││││││┌ @ int.jl:1013 within `+` @ int.jl:87
           %36 = add nuw i32 %35, 1, !dbg !244
; ││││││└└└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:35 within `getproperty`
; │││││││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
          %.sroa.2.0..sroa_idx19.i = getelementptr i8, i8* %1, i64 24, !dbg !225
          %37 = bitcast i8* %.sroa.2.0..sroa_idx19.i to i32*, !dbg !225
          %.sroa.2.0.copyload.i = load i32, i32* %37, align 1, !dbg !225, !tbaa !187, !alias.scope !188, !noalias !189
; ││││││└└
; ││││││┌ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││││││┌ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││││││┌ @ promotion.jl:639 within `==`
           %.not11 = icmp ne i32 %.sroa.2.0.copyload.i, %36, !dbg !219
           %38 = icmp ne i32 %.sroa.3.0.copyload.i, %33
; ││││││││└
; ││││││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
          %spec.select14 = select i1 %.not11, i1 true, i1 %38, !dbg !222
; ││││││└└
        br i1 %spec.select14, label %L287.i, label %L133.i.critedge, !dbg !182

L133.i.critedge:                                  ; preds = %L112.i, %L12.i
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:136 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:80 within `setproperty!`
; ││││││┌ @ pointer.jl:316 within `+`
         %39 = getelementptr i8, i8* %1, i64 32, !dbg !246
; ││││││└
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %40 = bitcast i8* %39 to i64*, !dbg !249
         store i64 ptrtoint (i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([12 x i8], [12 x i8]* @0, i64 0, i64 0) to i8 addrspace(1)*) to i64), i64* %40, align 1, !dbg !249, !tbaa !169, !alias.scope !173, !noalias !176
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:137 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:92 within `setproperty!`
; ││││││┌ @ pointer.jl:316 within `+`
         %41 = getelementptr i8, i8* %1, i64 48, !dbg !251
; ││││││└
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %42 = bitcast i8* %41 to i64*, !dbg !254
         store i64 11, i64* %42, align 1, !dbg !254, !tbaa !169, !alias.scope !173, !noalias !176
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:140 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:86 within `setproperty!`
; ││││││┌ @ pointer.jl:316 within `+`
         %43 = getelementptr i8, i8* %1, i64 40, !dbg !256
; ││││││└
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %44 = bitcast i8* %43 to i64*, !dbg !259
         store i64 ptrtoint (i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([27 x i8], [27 x i8]* @1, i64 0, i64 0) to i8 addrspace(1)*) to i64), i64* %44, align 1, !dbg !259, !tbaa !169, !alias.scope !173, !noalias !176
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:141 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:99 within `setproperty!`
; ││││││┌ @ pointer.jl:316 within `+`
         %45 = getelementptr i8, i8* %1, i64 56, !dbg !261
; ││││││└
; ││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
         %46 = bitcast i8* %45 to i64*, !dbg !264
         store i64 26, i64* %46, align 1, !dbg !264, !tbaa !169, !alias.scope !173, !noalias !176
         br label %L287.i, !dbg !264

L287.i:                                           ; preds = %L133.i.critedge, %L112.i, %L91.i, %L74.i, %L53.i, %L46.i
; │││││└└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:144 within `macro expansion`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:114 within `signal_exception`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:67 within `setproperty!`
; │││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
          %47 = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !266
          store i32 1, i32* %47, align 1, !dbg !266
; ││││││└└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:127 within `signal_exception`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
         call void @llvm.amdgcn.endpgm(), !dbg !274
; ││││││└
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:128 within `signal_exception`
        unreachable, !dbg !278
; └└└└└└
}

attributes #0 = { convergent nocallback nofree nounwind willreturn }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { cold nocallback nofree noreturn nounwind }
attributes #3 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!opencl.ocl.version = !{!43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43, !43}
!llvm.ident = !{!44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44, !44}
!julia.kernel = !{!45}

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
!36 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!37 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!38 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!39 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!40 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!41 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!42 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!43 = !{i32 2, i32 0}
!44 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!45 = !{void ([5 x i64], { [1 x i64], i8 addrspace(1)*, i64 })* @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!46 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_16323", scope: null, file: !47, line: 3, type: !48, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!47 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!48 = !DISubroutineType(types: !49)
!49 = !{}
!50 = !DILocation(line: 39, scope: !51, inlinedAt: !53)
!51 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !52, file: !52, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!52 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!53 = distinct !DILocation(line: 0, scope: !54, inlinedAt: !56)
!54 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!55 = !DIFile(filename: "none", directory: ".")
!56 = distinct !DILocation(line: 0, scope: !57, inlinedAt: !58)
!57 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!58 = distinct !DILocation(line: 133, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!60 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!61 = distinct !DILocation(line: 35, scope: !62, inlinedAt: !64)
!62 = distinct !DISubprogram(name: "_throw_boundserror", linkageName: "julia__throw_boundserror_16335", scope: null, file: !63, line: 35, type: !48, scopeLine: 35, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!63 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!64 = distinct !DILocation(line: 36, scope: !65, inlinedAt: !66)
!65 = distinct !DISubprogram(name: "#throw_boundserror;", linkageName: "#throw_boundserror", scope: !63, file: !63, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!66 = !DILocation(line: 699, scope: !67, inlinedAt: !69)
!67 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !68, file: !68, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!68 = !DIFile(filename: "abstractarray.jl", directory: ".")
!69 = !DILocation(line: 85, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !71, file: !71, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!71 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!72 = !DILocation(line: 4, scope: !46)
!73 = !DILocation(line: 316, scope: !74, inlinedAt: !76)
!74 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !75, file: !75, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!75 = !DIFile(filename: "pointer.jl", directory: ".")
!76 = distinct !DILocation(line: 29, scope: !77, inlinedAt: !78)
!77 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!78 = distinct !DILocation(line: 112, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!80 = distinct !DILocation(line: 134, scope: !59, inlinedAt: !61)
!81 = !DILocation(line: 39, scope: !51, inlinedAt: !82)
!82 = distinct !DILocation(line: 37, scope: !83, inlinedAt: !85)
!83 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !84, file: !84, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!84 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!85 = distinct !DILocation(line: 37, scope: !86, inlinedAt: !78)
!86 = distinct !DISubprogram(name: "llvm_atomic_cas;", linkageName: "llvm_atomic_cas", scope: !84, file: !84, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!87 = !DILocation(line: 639, scope: !88, inlinedAt: !78)
!88 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !89, file: !89, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!89 = !DIFile(filename: "promotion.jl", directory: ".")
!90 = !DILocation(line: 112, scope: !79, inlinedAt: !80)
!91 = !DILocation(line: 39, scope: !51, inlinedAt: !92)
!92 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!94 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!95 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!97 = distinct !DILocation(line: 87, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!99 = distinct !DILocation(line: 122, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!101 = distinct !DILocation(line: 114, scope: !79, inlinedAt: !80)
!102 = !{i32 0, i32 1023}
!103 = !DILocation(line: 87, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !105, file: !105, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!105 = !DIFile(filename: "int.jl", directory: ".")
!106 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !97)
!107 = !DILocation(line: 39, scope: !51, inlinedAt: !108)
!108 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !109)
!109 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !110)
!110 = distinct !DILocation(line: 87, scope: !111, inlinedAt: !99)
!111 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!112 = !DILocation(line: 87, scope: !104, inlinedAt: !113)
!113 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !110)
!114 = !DILocation(line: 39, scope: !51, inlinedAt: !115)
!115 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !116)
!116 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !117)
!117 = distinct !DILocation(line: 87, scope: !118, inlinedAt: !99)
!118 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!119 = !DILocation(line: 87, scope: !104, inlinedAt: !120)
!120 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !117)
!121 = !DILocation(line: 180, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !75, file: !75, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!123 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !124)
!124 = distinct !DILocation(line: 72, scope: !125, inlinedAt: !101)
!125 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!126 = !DILocation(line: 39, scope: !51, inlinedAt: !127)
!127 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !128)
!128 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !129)
!129 = distinct !DILocation(line: 93, scope: !130, inlinedAt: !131)
!130 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!131 = distinct !DILocation(line: 130, scope: !132, inlinedAt: !133)
!132 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!133 = distinct !DILocation(line: 115, scope: !79, inlinedAt: !80)
!134 = !{i32 0, i32 -2}
!135 = !DILocation(line: 87, scope: !104, inlinedAt: !136)
!136 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !129)
!137 = !DILocation(line: 39, scope: !51, inlinedAt: !138)
!138 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !139)
!139 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !140)
!140 = distinct !DILocation(line: 93, scope: !141, inlinedAt: !131)
!141 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!142 = !DILocation(line: 87, scope: !104, inlinedAt: !143)
!143 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !140)
!144 = !DILocation(line: 39, scope: !51, inlinedAt: !145)
!145 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !146)
!146 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !147)
!147 = distinct !DILocation(line: 93, scope: !148, inlinedAt: !131)
!148 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!149 = !DILocation(line: 87, scope: !104, inlinedAt: !150)
!150 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !147)
!151 = !DILocation(line: 180, scope: !122, inlinedAt: !152)
!152 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !153)
!153 = distinct !DILocation(line: 75, scope: !125, inlinedAt: !133)
!154 = !DILocation(line: 5, scope: !155, inlinedAt: !157)
!155 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !156, file: !156, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!156 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!157 = distinct !DILocation(line: 27, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !156, file: !156, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!159 = distinct !DILocation(line: 116, scope: !79, inlinedAt: !80)
!160 = !DILocation(line: 28, scope: !158, inlinedAt: !159)
!161 = !DILocation(line: 5, scope: !155, inlinedAt: !162)
!162 = distinct !DILocation(line: 29, scope: !158, inlinedAt: !159)
!163 = !DILocation(line: 117, scope: !79, inlinedAt: !80)
!164 = !DILocation(line: 153, scope: !165, inlinedAt: !166)
!165 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !75, file: !75, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!166 = distinct !DILocation(line: 153, scope: !165, inlinedAt: !167)
!167 = distinct !DILocation(line: 27, scope: !77, inlinedAt: !168)
!168 = distinct !DILocation(line: 118, scope: !79, inlinedAt: !80)
!169 = !{!170, !170, i64 0}
!170 = !{!"jtbaa_data", !171, i64 0}
!171 = !{!"jtbaa", !172, i64 0}
!172 = !{!"jtbaa"}
!173 = !{!174}
!174 = !{!"jnoalias_data", !175}
!175 = !{!"jnoalias"}
!176 = !{!177, !178, !179, !180}
!177 = !{!"jnoalias_gcframe", !175}
!178 = !{!"jnoalias_stack", !175}
!179 = !{!"jnoalias_typemd", !175}
!180 = !{!"jnoalias_const", !175}
!181 = !DILocation(line: 639, scope: !88, inlinedAt: !168)
!182 = !DILocation(line: 118, scope: !79, inlinedAt: !80)
!183 = !DILocation(line: 316, scope: !74, inlinedAt: !184)
!184 = distinct !DILocation(line: 32, scope: !77, inlinedAt: !168)
!185 = !DILocation(line: 153, scope: !165, inlinedAt: !186)
!186 = distinct !DILocation(line: 153, scope: !165, inlinedAt: !184)
!187 = !{!171, !171, i64 0}
!188 = !{!174, !178}
!189 = !{!177, !179, !180}
!190 = !DILocation(line: 39, scope: !51, inlinedAt: !191)
!191 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !192)
!192 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !193)
!193 = distinct !DILocation(line: 87, scope: !98, inlinedAt: !194)
!194 = distinct !DILocation(line: 122, scope: !100, inlinedAt: !168)
!195 = !DILocation(line: 87, scope: !104, inlinedAt: !196)
!196 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !193)
!197 = !DILocation(line: 639, scope: !88, inlinedAt: !198)
!198 = distinct !DILocation(line: 551, scope: !199, inlinedAt: !201)
!199 = distinct !DISubprogram(name: "_eq;", linkageName: "_eq", scope: !200, file: !200, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!200 = !DIFile(filename: "tuple.jl", directory: ".")
!201 = distinct !DILocation(line: 547, scope: !202, inlinedAt: !203)
!202 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !200, file: !200, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!203 = distinct !DILocation(line: 244, scope: !204, inlinedAt: !168)
!204 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !205, file: !205, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!205 = !DIFile(filename: "namedtuple.jl", directory: ".")
!206 = !DILocation(line: 552, scope: !199, inlinedAt: !201)
!207 = !DILocation(line: 39, scope: !51, inlinedAt: !208)
!208 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !209)
!209 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !210)
!210 = distinct !DILocation(line: 87, scope: !118, inlinedAt: !194)
!211 = !DILocation(line: 87, scope: !104, inlinedAt: !212)
!212 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !210)
!213 = !DILocation(line: 39, scope: !51, inlinedAt: !214)
!214 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !215)
!215 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !216)
!216 = distinct !DILocation(line: 87, scope: !111, inlinedAt: !194)
!217 = !DILocation(line: 87, scope: !104, inlinedAt: !218)
!218 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !216)
!219 = !DILocation(line: 639, scope: !88, inlinedAt: !220)
!220 = distinct !DILocation(line: 551, scope: !199, inlinedAt: !221)
!221 = distinct !DILocation(line: 557, scope: !199, inlinedAt: !201)
!222 = !DILocation(line: 552, scope: !199, inlinedAt: !221)
!223 = !DILocation(line: 316, scope: !74, inlinedAt: !224)
!224 = distinct !DILocation(line: 35, scope: !77, inlinedAt: !168)
!225 = !DILocation(line: 153, scope: !165, inlinedAt: !226)
!226 = distinct !DILocation(line: 153, scope: !165, inlinedAt: !224)
!227 = !DILocation(line: 39, scope: !51, inlinedAt: !228)
!228 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !229)
!229 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !230)
!230 = distinct !DILocation(line: 93, scope: !130, inlinedAt: !231)
!231 = distinct !DILocation(line: 130, scope: !132, inlinedAt: !168)
!232 = !DILocation(line: 87, scope: !104, inlinedAt: !233)
!233 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !230)
!234 = !DILocation(line: 39, scope: !51, inlinedAt: !235)
!235 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !236)
!236 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !237)
!237 = distinct !DILocation(line: 93, scope: !148, inlinedAt: !231)
!238 = !DILocation(line: 87, scope: !104, inlinedAt: !239)
!239 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !237)
!240 = !DILocation(line: 39, scope: !51, inlinedAt: !241)
!241 = distinct !DILocation(line: 3, scope: !93, inlinedAt: !242)
!242 = distinct !DILocation(line: 3, scope: !96, inlinedAt: !243)
!243 = distinct !DILocation(line: 93, scope: !141, inlinedAt: !231)
!244 = !DILocation(line: 87, scope: !104, inlinedAt: !245)
!245 = distinct !DILocation(line: 1013, scope: !104, inlinedAt: !243)
!246 = !DILocation(line: 316, scope: !74, inlinedAt: !247)
!247 = distinct !DILocation(line: 80, scope: !125, inlinedAt: !248)
!248 = distinct !DILocation(line: 136, scope: !59, inlinedAt: !61)
!249 = !DILocation(line: 180, scope: !122, inlinedAt: !250)
!250 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !247)
!251 = !DILocation(line: 316, scope: !74, inlinedAt: !252)
!252 = distinct !DILocation(line: 92, scope: !125, inlinedAt: !253)
!253 = distinct !DILocation(line: 137, scope: !59, inlinedAt: !61)
!254 = !DILocation(line: 180, scope: !122, inlinedAt: !255)
!255 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !252)
!256 = !DILocation(line: 316, scope: !74, inlinedAt: !257)
!257 = distinct !DILocation(line: 86, scope: !125, inlinedAt: !258)
!258 = distinct !DILocation(line: 140, scope: !59, inlinedAt: !61)
!259 = !DILocation(line: 180, scope: !122, inlinedAt: !260)
!260 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !257)
!261 = !DILocation(line: 316, scope: !74, inlinedAt: !262)
!262 = distinct !DILocation(line: 99, scope: !125, inlinedAt: !263)
!263 = distinct !DILocation(line: 141, scope: !59, inlinedAt: !61)
!264 = !DILocation(line: 180, scope: !122, inlinedAt: !265)
!265 = distinct !DILocation(line: 180, scope: !122, inlinedAt: !262)
!266 = !DILocation(line: 180, scope: !267, inlinedAt: !268)
!267 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !75, file: !75, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!268 = distinct !DILocation(line: 180, scope: !267, inlinedAt: !269)
!269 = distinct !DILocation(line: 67, scope: !270, inlinedAt: !271)
!270 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!271 = distinct !DILocation(line: 114, scope: !272, inlinedAt: !273)
!272 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14946", scope: null, file: !84, line: 112, type: !48, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!273 = distinct !DILocation(line: 144, scope: !59, inlinedAt: !61)
!274 = !DILocation(line: 6, scope: !275, inlinedAt: !277)
!275 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !276, file: !276, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!276 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!277 = distinct !DILocation(line: 127, scope: !272, inlinedAt: !273)
!278 = !DILocation(line: 128, scope: !272, inlinedAt: !273)
