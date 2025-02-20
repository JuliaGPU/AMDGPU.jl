; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@"alloc_special_##static_shmem#231" = external local_unnamed_addr addrspace(3) global [32 x [2 x float]], align 32

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.wavefrontsize() #0

; Function Attrs: convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.ds.bpermute(i32, i32) #1

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #3

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(read)
declare i32 @llvm.read_register.i32(metadata) #4

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #5

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #6

;  @ none within `gpu_groupreduce_1!`
define amdgpu_kernel void @_Z18gpu_groupreduce_1_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILi1E5TupleI5OneToI5Int64EEE7NDRangeILi1ES0_10StaticSizeI6_256__ES8_vEE14ROCDeviceArrayI7Float32Li1ELi1EESG_1_SF_({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } %0, { [1 x i64], i8 addrspace(1)*, i64 } %1, { [1 x i64], i8 addrspace(1)*, i64 } %2, float %3) local_unnamed_addr #7 !dbg !44 {
conversion:
  %.fca.0.0.0.0.extract = extractvalue { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } %0, 0, 0, 0, 0
  %.fca.1.0.0.0.0.extract = extractvalue { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } %0, 1, 0, 0, 0, 0
  %.fca.0.0.extract41 = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %1, 0, 0
  %.fca.1.extract43 = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %1, 1
  %.fca.0.0.extract = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %2, 0, 0
  %.fca.1.extract39 = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %2, 1
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:96
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:141 within `#__validindex`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %4 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !48, !range !69
; │└└└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %5 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !70, !range !79
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %6 = add nuw nsw i32 %5, 1, !dbg !80
; │└└└└
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:119 within `expand`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
; │││┌ @ ntuple.jl:48 within `ntuple`
; ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
; │││││┌ @ operators.jl:379 within `>`
; ││││││┌ @ int.jl:83 within `<`
         %7 = icmp sgt i64 %.fca.1.0.0.0.0.extract, 0, !dbg !84
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
        call void @llvm.assume(i1 %7), !dbg !99
; ││└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
; ││┌ @ abstractarray.jl:1312 within `getindex`
; │││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
; ││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:892 within `Int64`
; │││││││┌ @ boot.jl:816 within `toInt64`
          %8 = zext i32 %6 to i64, !dbg !101
; ││└└└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand` @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:75
; ││┌ @ ntuple.jl:48 within `ntuple`
; │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:79 within `#1`
; ││││┌ @ int.jl:86 within `-`
       %9 = zext i32 %4 to i64, !dbg !120
; ││││└
; ││││┌ @ int.jl:88 within `*`
       %10 = shl nuw nsw i64 %9, 8, !dbg !126
; ││││└
; ││││┌ @ int.jl:87 within `+`
       %11 = add nuw nsw i64 %10, %8, !dbg !128
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:142 within `#__validindex`
; │┌ @ multidimensional.jl:477 within `in`
; ││┌ @ tuple.jl:382 within `map`
; │││┌ @ range.jl:1426 within `in`
; ││││┌ @ int.jl:514 within `<=`
       %.not = icmp sgt i64 %11, %.fca.0.0.0.0.extract, !dbg !129
; └└└└└
  br i1 %.not, label %L550, label %L110, !dbg !65

L110:                                             ; preds = %conversion
  %.fca.2.extract = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %2, 2
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:16 within `macro expansion`
; │┌ @ operators.jl:379 within `>`
; ││┌ @ int.jl:83 within `<`
     %.not223 = icmp slt i64 %.fca.2.extract, %11, !dbg !141
; │└└
   br i1 %.not223, label %L256, label %L237, !dbg !143

L237:                                             ; preds = %L110
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
; ││┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; │││┌ @ abstractarray.jl:754 within `checkindex`
; ││││┌ @ int.jl:86 within `-`
       %12 = add nsw i64 %11, -1, !dbg !147
; ││││└
; ││││┌ @ int.jl:513 within `<`
       %.not252 = icmp ult i64 %12, %.fca.0.0.extract, !dbg !156
; │││└└
; │││ @ abstractarray.jl:699 within `checkbounds`
     br i1 %.not252, label %L250, label %L247, !dbg !152

L247:                                             ; preds = %L237
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
          %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !157
; │││││└└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %13 = inttoptr i64 %state.i.fca.0.extract.i to i32*, !dbg !172
        store i32 1, i32* %13, align 1, !dbg !172
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !176
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
       unreachable, !dbg !180

L250:                                             ; preds = %L237
; ││└└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
; │││┌ @ none within `pointerref`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
       %14 = bitcast i8 addrspace(1)* %.fca.1.extract39 to float addrspace(1)*, !dbg !181
       %15 = getelementptr inbounds float, float addrspace(1)* %14, i64 %12, !dbg !181
       %16 = load float, float addrspace(1)* %15, align 4, !dbg !181, !tbaa !190
       br label %L256, !dbg !181

L256:                                             ; preds = %L250, %L110
       %value_phi = phi float [ %16, %L250 ], [ %3, %L110 ]
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:88 within `__warp_groupreduce`
; ││┌ @ int.jl:298 within `rem`
     %17 = and i32 %5, 31, !dbg !193
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:89 within `__warp_groupreduce`
; ││┌ @ int.jl:297 within `div`
     %18 = lshr i32 %5, 5, !dbg !199
     %19 = call i32 @llvm.amdgcn.wavefrontsize()
     %20 = add i32 %19, -1
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %21 = call i32 @llvm.read_register.i32(metadata !202) #8, !dbg !203
          %22 = call i32 @llvm.amdgcn.mbcnt.lo(i32 %21, i32 0), !dbg !203
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %.not225 = icmp sgt i32 %22, -1, !dbg !221
; │││││││││││└
             br i1 %.not225, label %L306, label %L292, !dbg !223

L292:                                             ; preds = %L256
; │││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
; ││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││││││││┌ @ none within `kernel_state`
; │││││││││││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
                  %state.i.fca.0.extract.i95 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !230
; │││││││││││││└└└
; │││││││││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
                %23 = inttoptr i64 %state.i.fca.0.extract.i95 to i32*, !dbg !238
                store i32 1, i32* %23, align 1, !dbg !238
; │││││││││││││└
; │││││││││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
                call void @llvm.amdgcn.endpgm(), !dbg !240
; │││││││││││││└
; │││││││││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
               unreachable, !dbg !242

L306:                                             ; preds = %L256
; │││││└└└└└└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %24 = bitcast float %value_phi to i32, !dbg !243
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `&` @ int.jl:347
          %25 = and i32 %22, %20, !dbg !246
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %26 = add nuw i32 %25, 16, !dbg !250
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not227 = icmp ugt i32 %19, %26, !dbg !251
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %27 = select i1 %.not227, i32 16, i32 0, !dbg !254
          %28 = add nuw i32 %27, %22, !dbg !254
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %29 = shl i32 %28, 2, !dbg !256
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %30 = call i32 @llvm.amdgcn.ds.bpermute(i32 %29, i32 %24), !dbg !259
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %31 = bitcast i32 %30 to float, !dbg !243
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %32 = fadd float %value_phi, %31, !dbg !261
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %33 = bitcast float %32 to i32, !dbg !243
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %34 = add nuw i32 %25, 8, !dbg !250
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not227.1 = icmp ugt i32 %19, %34, !dbg !251
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %35 = select i1 %.not227.1, i32 8, i32 0, !dbg !254
          %36 = add nuw i32 %35, %22, !dbg !254
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %37 = shl i32 %36, 2, !dbg !256
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %38 = call i32 @llvm.amdgcn.ds.bpermute(i32 %37, i32 %33), !dbg !259
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %39 = bitcast i32 %38 to float, !dbg !243
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %40 = fadd float %32, %39, !dbg !261
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %41 = bitcast float %40 to i32, !dbg !243
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %42 = add nuw i32 %25, 4, !dbg !250
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not227.2 = icmp ugt i32 %19, %42, !dbg !251
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %43 = select i1 %.not227.2, i32 4, i32 0, !dbg !254
          %44 = add nuw i32 %43, %22, !dbg !254
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %45 = shl i32 %44, 2, !dbg !256
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %46 = call i32 @llvm.amdgcn.ds.bpermute(i32 %45, i32 %41), !dbg !259
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %47 = bitcast i32 %46 to float, !dbg !243
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %48 = fadd float %40, %47, !dbg !261
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %49 = bitcast float %48 to i32, !dbg !243
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %50 = add nuw i32 %25, 2, !dbg !250
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not227.3 = icmp ugt i32 %19, %50, !dbg !251
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %51 = select i1 %.not227.3, i32 2, i32 0, !dbg !254
          %52 = add nuw i32 %51, %22, !dbg !254
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %53 = shl i32 %52, 2, !dbg !256
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %54 = call i32 @llvm.amdgcn.ds.bpermute(i32 %53, i32 %49), !dbg !259
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %55 = bitcast i32 %54 to float, !dbg !243
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %56 = fadd float %48, %55, !dbg !261
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %57 = bitcast float %56 to i32, !dbg !243
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %58 = add nuw i32 %25, 1, !dbg !250
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not227.4 = icmp ugt i32 %19, %58, !dbg !251
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %59 = zext i1 %.not227.4 to i32, !dbg !254
          %60 = add nuw i32 %22, %59, !dbg !254
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %61 = shl i32 %60, 2, !dbg !256
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %62 = call i32 @llvm.amdgcn.ds.bpermute(i32 %61, i32 %57), !dbg !259
; ││└└└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:93 within `__warp_groupreduce`
; ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
     %.not231 = icmp eq i32 %17, 0, !dbg !266
; ││└
    br i1 %.not231, label %L389, label %L395, !dbg !270

L389:                                             ; preds = %L306
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %63 = bitcast i32 %62 to float, !dbg !243
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %64 = fadd float %56, %63, !dbg !261
; ││└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:93 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
; ││││┌ @ none within `pointerset`
; │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %.repack = getelementptr inbounds [32 x [2 x float]], [32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231", i32 0, i32 %18, i32 0, !dbg !271
        store float %64, float addrspace(3)* %.repack, align 8, !dbg !271, !tbaa !279
        %.repack232 = getelementptr inbounds [32 x [2 x float]], [32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231", i32 0, i32 %18, i32 1, !dbg !271
        store float %64, float addrspace(3)* %.repack232, align 4, !dbg !271, !tbaa !279
; │││└└└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
     br label %L395, !dbg !281

L395:                                             ; preds = %L389, %L306
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:94 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl:290 within `macro expansion`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:162 within `#__synchronize`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !282
; ││└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:97 within `__warp_groupreduce`
; ││┌ @ int.jl:520 within `<` @ promotion.jl:484 @ int.jl:513
     %65 = icmp ugt i32 %5, 7, !dbg !291
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
    br i1 %65, label %guard_pass41, label %guard_pass37, !dbg !296

L422:                                             ; preds = %guard_pass41, %guard_pass37
    %.sroa.6.0437 = phi i32 [ %134, %guard_pass41 ], [ %.unpack235439, %guard_pass37 ]
    %.sroa.0426.0 = phi i32 [ %134, %guard_pass41 ], [ %.unpack438, %guard_pass37 ]
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
     %66 = icmp ugt i32 %5, 31, !dbg !297
; ││└
    %67 = bitcast i32 %.sroa.0426.0 to float, !dbg !299
    %68 = bitcast i32 %.sroa.6.0437 to float, !dbg !299
    br i1 %66, label %L522, label %guard_exit46, !dbg !299

L438:                                             ; preds = %guard_exit46
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
; ││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││││││││││┌ @ none within `kernel_state`
; │││││││││││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
                  %state.i.fca.0.extract.i155 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !300
; │││││││││││││└└└
; │││││││││││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
                %69 = inttoptr i64 %state.i.fca.0.extract.i155 to i32*, !dbg !318
                store i32 1, i32* %69, align 1, !dbg !318
; │││││││││││││└
; │││││││││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││││││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
                call void @llvm.amdgcn.endpgm(), !dbg !320
; │││││││││││││└
; │││││││││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
               unreachable, !dbg !322

L452:                                             ; preds = %guard_exit46
; │││││││└└└└└└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `&` @ int.jl:347
          %70 = and i32 %136, %20, !dbg !323
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %71 = add nuw i32 %70, 16, !dbg !326
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not243 = icmp ugt i32 %19, %71, !dbg !327
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %72 = select i1 %.not243, i32 16, i32 0, !dbg !329
          %73 = add nuw i32 %72, %136, !dbg !329
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %74 = shl i32 %73, 2, !dbg !330
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %75 = call i32 @llvm.amdgcn.ds.bpermute(i32 %74, i32 %.sroa.0426.0), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %76 = bitcast i32 %75 to float, !dbg !333
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %77 = call i32 @llvm.amdgcn.ds.bpermute(i32 %74, i32 %.sroa.6.0437), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %78 = bitcast i32 %77 to float, !dbg !333
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %79 = fadd float %76, %67, !dbg !334
      %80 = fadd float %78, %68, !dbg !334
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %81 = bitcast float %79 to i32, !dbg !336
       %82 = bitcast float %80 to i32, !dbg !336
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %83 = add nuw i32 %70, 8, !dbg !326
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not243.1 = icmp ugt i32 %19, %83, !dbg !327
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %84 = select i1 %.not243.1, i32 8, i32 0, !dbg !329
          %85 = add nuw i32 %84, %136, !dbg !329
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %86 = shl i32 %85, 2, !dbg !330
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %87 = call i32 @llvm.amdgcn.ds.bpermute(i32 %86, i32 %81), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %88 = bitcast i32 %87 to float, !dbg !333
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %89 = call i32 @llvm.amdgcn.ds.bpermute(i32 %86, i32 %82), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %90 = bitcast i32 %89 to float, !dbg !333
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %91 = fadd float %79, %88, !dbg !334
      %92 = fadd float %80, %90, !dbg !334
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %93 = bitcast float %91 to i32, !dbg !336
       %94 = bitcast float %92 to i32, !dbg !336
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %95 = add nuw i32 %70, 4, !dbg !326
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not243.2 = icmp ugt i32 %19, %95, !dbg !327
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %96 = select i1 %.not243.2, i32 4, i32 0, !dbg !329
          %97 = add nuw i32 %96, %136, !dbg !329
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %98 = shl i32 %97, 2, !dbg !330
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %99 = call i32 @llvm.amdgcn.ds.bpermute(i32 %98, i32 %93), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %100 = bitcast i32 %99 to float, !dbg !333
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %101 = call i32 @llvm.amdgcn.ds.bpermute(i32 %98, i32 %94), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %102 = bitcast i32 %101 to float, !dbg !333
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %103 = fadd float %91, %100, !dbg !334
      %104 = fadd float %92, %102, !dbg !334
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %105 = bitcast float %103 to i32, !dbg !336
       %106 = bitcast float %104 to i32, !dbg !336
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %107 = add nuw i32 %70, 2, !dbg !326
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not243.3 = icmp ugt i32 %19, %107, !dbg !327
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %108 = select i1 %.not243.3, i32 2, i32 0, !dbg !329
          %109 = add nuw i32 %108, %136, !dbg !329
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %110 = shl i32 %109, 2, !dbg !330
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %111 = call i32 @llvm.amdgcn.ds.bpermute(i32 %110, i32 %105), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %112 = bitcast i32 %111 to float, !dbg !333
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %113 = call i32 @llvm.amdgcn.ds.bpermute(i32 %110, i32 %106), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %114 = bitcast i32 %113 to float, !dbg !333
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %115 = fadd float %103, %112, !dbg !334
      %116 = fadd float %104, %114, !dbg !334
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %117 = bitcast float %115 to i32, !dbg !336
       %118 = bitcast float %116 to i32, !dbg !336
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:87 within `+`
          %119 = add nuw i32 %70, 1, !dbg !326
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %.not243.4 = icmp ugt i32 %19, %119, !dbg !327
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %120 = zext i1 %.not243.4 to i32, !dbg !329
          %121 = add nuw i32 %136, %120, !dbg !329
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %122 = shl i32 %121, 2, !dbg !330
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %123 = call i32 @llvm.amdgcn.ds.bpermute(i32 %122, i32 %117), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %124 = bitcast i32 %123 to float, !dbg !333
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %125 = call i32 @llvm.amdgcn.ds.bpermute(i32 %122, i32 %118), !dbg !332
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %126 = bitcast i32 %125 to float, !dbg !333
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %127 = fadd float %115, %124, !dbg !334
      %128 = fadd float %116, %126, !dbg !334
      br label %L522

L522:                                             ; preds = %L452, %L422
      %.sroa.6.0 = phi float [ %128, %L452 ], [ %68, %L422 ]
      %.sroa.05.0 = phi float [ %127, %L452 ], [ %67, %L422 ]
; │└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:21 within `macro expansion`
; │┌ @ promotion.jl:639 within `==`
    %.not248 = icmp eq i64 %11, 1, !dbg !338
; │└
   br i1 %.not248, label %L526, label %L550, !dbg !339

L526:                                             ; preds = %L522
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; ││┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; │││┌ @ abstractarray.jl:754 within `checkindex`
; ││││┌ @ int.jl:513 within `<`
       %.not249 = icmp eq i64 %.fca.0.0.extract41, 0, !dbg !340
; │││└└
; │││ @ abstractarray.jl:699 within `checkbounds`
     br i1 %.not249, label %L541, label %L544, !dbg !343

L541:                                             ; preds = %L526
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
          %state.i.fca.0.extract.i80 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0, !dbg !345
; │││││└└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %129 = inttoptr i64 %state.i.fca.0.extract.i80 to i32*, !dbg !352
        store i32 1, i32* %129, align 1, !dbg !352
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !354
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
       unreachable, !dbg !356

L544:                                             ; preds = %L526
; │└└└└
; │┌ @ float.jl:491 within `+`
    %130 = fadd float %.sroa.6.0, %.sroa.05.0, !dbg !357
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
       %131 = bitcast i8 addrspace(1)* %.fca.1.extract43 to float addrspace(1)*, !dbg !358
       store float %130, float addrspace(1)* %131, align 4, !dbg !358, !tbaa !190
; ││└└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
    br label %L550, !dbg !363

L550:                                             ; preds = %L544, %L522, %conversion
; └└
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:99
  ret void, !dbg !364

guard_pass37:                                     ; preds = %L395
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %.elt234 = getelementptr inbounds [32 x [2 x float]], [32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231", i32 0, i32 %17, i32 1, !dbg !365
        %132 = bitcast float addrspace(3)* %.elt234 to i32 addrspace(3)*, !dbg !365
        %.unpack235439 = load i32, i32 addrspace(3)* %132, align 4, !dbg !365, !tbaa !279
        %.elt = getelementptr inbounds [32 x [2 x float]], [32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231", i32 0, i32 %17, i32 0, !dbg !365
        %133 = bitcast float addrspace(3)* %.elt to i32 addrspace(3)*, !dbg !365
        %.unpack438 = load i32, i32 addrspace(3)* %133, align 8, !dbg !365, !tbaa !279
        br label %L422

guard_pass41:                                     ; preds = %L395
; └└└└└└
;  @ none within `gpu_groupreduce_1!`
  %134 = bitcast float %3 to i32, !dbg !68
  br label %L422

guard_exit46:                                     ; preds = %L422
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %135 = call i32 @llvm.read_register.i32(metadata !202) #8, !dbg !370
          %136 = call i32 @llvm.amdgcn.mbcnt.lo(i32 %135, i32 0), !dbg !370
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %.not241 = icmp sgt i32 %136, -1, !dbg !371
; │││││││││││└
             br i1 %.not241, label %L452, label %L438, !dbg !372
; └└└└└└└└└└└
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { convergent nocallback nofree nounwind willreturn memory(none) }
attributes #2 = { convergent nocallback nofree nounwind willreturn }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #4 = { alwaysinline nocallback nofree nosync nounwind willreturn memory(read) }
attributes #5 = { alwaysinline nocallback nofree nosync nounwind willreturn memory(none) }
attributes #6 = { cold nocallback nofree noreturn nounwind }
attributes #7 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #8 = { convergent }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40}
!opencl.ocl.version = !{!41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41, !41}
!llvm.ident = !{!42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42, !42}
!julia.kernel = !{!43}

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
!41 = !{i32 2, i32 0}
!42 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!43 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 }, float)* @_Z18gpu_groupreduce_1_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILi1E5TupleI5OneToI5Int64EEE7NDRangeILi1ES0_10StaticSizeI6_256__ES8_vEE14ROCDeviceArrayI7Float32Li1ELi1EESG_1_SF_}
!44 = distinct !DISubprogram(name: "gpu_groupreduce_1!", linkageName: "julia_gpu_groupreduce_1!_15079", scope: null, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!45 = !DIFile(filename: "none", directory: ".")
!46 = !DISubroutineType(types: !47)
!47 = !{}
!48 = !DILocation(line: 39, scope: !49, inlinedAt: !51)
!49 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !50, file: !50, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!50 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl", directory: ".")
!51 = !DILocation(line: 3, scope: !52, inlinedAt: !54)
!52 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!53 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!54 = !DILocation(line: 3, scope: !55, inlinedAt: !56)
!55 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!56 = !DILocation(line: 93, scope: !57, inlinedAt: !58)
!57 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!58 = !DILocation(line: 95, scope: !59, inlinedAt: !60)
!59 = distinct !DISubprogram(name: "blockIdx_x;", linkageName: "blockIdx_x", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!60 = !DILocation(line: 172, scope: !61, inlinedAt: !62)
!61 = distinct !DISubprogram(name: "blockIdx;", linkageName: "blockIdx", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!62 = !DILocation(line: 141, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "#__validindex;", linkageName: "#__validindex", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!64 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl", directory: ".")
!65 = !DILocation(line: 96, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "gpu_groupreduce_1!;", linkageName: "gpu_groupreduce_1!", scope: !67, file: !67, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!67 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl", directory: ".")
!68 = !DILocation(line: 0, scope: !44)
!69 = !{i32 0, i32 -2}
!70 = !DILocation(line: 39, scope: !49, inlinedAt: !71)
!71 = !DILocation(line: 3, scope: !52, inlinedAt: !72)
!72 = !DILocation(line: 3, scope: !55, inlinedAt: !73)
!73 = !DILocation(line: 87, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!75 = !DILocation(line: 89, scope: !76, inlinedAt: !77)
!76 = distinct !DISubprogram(name: "threadIdx_x;", linkageName: "threadIdx_x", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!77 = !DILocation(line: 164, scope: !78, inlinedAt: !62)
!78 = distinct !DISubprogram(name: "threadIdx;", linkageName: "threadIdx", scope: !53, file: !53, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!79 = !{i32 0, i32 1023}
!80 = !DILocation(line: 87, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!82 = !DIFile(filename: "int.jl", directory: ".")
!83 = !DILocation(line: 1013, scope: !81, inlinedAt: !73)
!84 = !DILocation(line: 83, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!86 = !DILocation(line: 379, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: ">;", linkageName: ">", scope: !88, file: !88, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!88 = !DIFile(filename: "operators.jl", directory: ".")
!89 = !DILocation(line: 111, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "#3;", linkageName: "#3", scope: !91, file: !91, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!91 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl", directory: ".")
!92 = !DILocation(line: 48, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "ntuple;", linkageName: "ntuple", scope: !94, file: !94, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!94 = !DIFile(filename: "ntuple.jl", directory: ".")
!95 = !DILocation(line: 108, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "assume_nonzero;", linkageName: "assume_nonzero", scope: !91, file: !91, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!97 = !DILocation(line: 119, scope: !98, inlinedAt: !62)
!98 = distinct !DISubprogram(name: "expand;", linkageName: "expand", scope: !91, file: !91, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!99 = !DILocation(line: 91, scope: !100, inlinedAt: !89)
!100 = distinct !DISubprogram(name: "assume;", linkageName: "assume", scope: !91, file: !91, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!101 = !DILocation(line: 816, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!103 = !DIFile(filename: "boot.jl", directory: ".")
!104 = !DILocation(line: 892, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!106 = !DILocation(line: 7, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !108, file: !108, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!108 = !DIFile(filename: "number.jl", directory: ".")
!109 = !DILocation(line: 307, scope: !110, inlinedAt: !112)
!110 = distinct !DISubprogram(name: "to_index;", linkageName: "to_index", scope: !111, file: !111, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!111 = !DIFile(filename: "indices.jl", directory: ".")
!112 = !DILocation(line: 292, scope: !110, inlinedAt: !113)
!113 = !DILocation(line: 368, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "to_indices;", linkageName: "to_indices", scope: !111, file: !111, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!115 = !DILocation(line: 365, scope: !114, inlinedAt: !116)
!116 = !DILocation(line: 1312, scope: !117, inlinedAt: !119)
!117 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !118, file: !118, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!118 = !DIFile(filename: "abstractarray.jl", directory: ".")
!119 = !DILocation(line: 121, scope: !98, inlinedAt: !62)
!120 = !DILocation(line: 86, scope: !121, inlinedAt: !122)
!121 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!122 = !DILocation(line: 79, scope: !123, inlinedAt: !124)
!123 = distinct !DISubprogram(name: "#1;", linkageName: "#1", scope: !91, file: !91, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!124 = !DILocation(line: 48, scope: !93, inlinedAt: !125)
!125 = !DILocation(line: 75, scope: !98, inlinedAt: !119)
!126 = !DILocation(line: 88, scope: !127, inlinedAt: !122)
!127 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!128 = !DILocation(line: 87, scope: !81, inlinedAt: !122)
!129 = !DILocation(line: 514, scope: !130, inlinedAt: !131)
!130 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!131 = !DILocation(line: 1426, scope: !132, inlinedAt: !134)
!132 = distinct !DISubprogram(name: "in;", linkageName: "in", scope: !133, file: !133, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!133 = !DIFile(filename: "range.jl", directory: ".")
!134 = !DILocation(line: 382, scope: !135, inlinedAt: !137)
!135 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !136, file: !136, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!136 = !DIFile(filename: "tuple.jl", directory: ".")
!137 = !DILocation(line: 477, scope: !138, inlinedAt: !140)
!138 = distinct !DISubprogram(name: "in;", linkageName: "in", scope: !139, file: !139, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!139 = !DIFile(filename: "multidimensional.jl", directory: ".")
!140 = !DILocation(line: 142, scope: !63, inlinedAt: !65)
!141 = !DILocation(line: 83, scope: !85, inlinedAt: !142)
!142 = !DILocation(line: 379, scope: !87, inlinedAt: !143)
!143 = !DILocation(line: 16, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !145, file: !145, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!145 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!146 = !DILocation(line: 97, scope: !66, inlinedAt: !68)
!147 = !DILocation(line: 86, scope: !121, inlinedAt: !148)
!148 = !DILocation(line: 754, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !118, file: !118, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!150 = !DILocation(line: 689, scope: !151, inlinedAt: !152)
!151 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !118, file: !118, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!152 = !DILocation(line: 699, scope: !151, inlinedAt: !153)
!153 = !DILocation(line: 84, scope: !154, inlinedAt: !143)
!154 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !155, file: !155, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!155 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!156 = !DILocation(line: 513, scope: !85, inlinedAt: !148)
!157 = !DILocation(line: 39, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !50, file: !50, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!159 = distinct !DILocation(line: 0, scope: !160, inlinedAt: !161)
!160 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!161 = distinct !DILocation(line: 0, scope: !162, inlinedAt: !163)
!162 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!163 = distinct !DILocation(line: 11, scope: !164, inlinedAt: !166)
!164 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !165, file: !165, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!165 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!166 = distinct !DILocation(line: 113, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_15842", scope: null, file: !165, line: 112, type: !46, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!168 = distinct !DILocation(line: 8, scope: !169, inlinedAt: !171)
!169 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_15166", scope: null, file: !170, line: 44, type: !46, scopeLine: 44, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !47)
!170 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!171 = distinct !DILocation(line: 699, scope: !151, inlinedAt: !153)
!172 = !DILocation(line: 180, scope: !173, inlinedAt: !175)
!173 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !174, file: !174, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!174 = !DIFile(filename: "pointer.jl", directory: ".")
!175 = distinct !DILocation(line: 180, scope: !173, inlinedAt: !166)
!176 = !DILocation(line: 52, scope: !177, inlinedAt: !179)
!177 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !178, file: !178, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!178 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!179 = distinct !DILocation(line: 115, scope: !167, inlinedAt: !168)
!180 = !DILocation(line: 116, scope: !167, inlinedAt: !168)
!181 = !DILocation(line: 39, scope: !49, inlinedAt: !182)
!182 = !DILocation(line: 0, scope: !183, inlinedAt: !184)
!183 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!184 = !DILocation(line: 0, scope: !185, inlinedAt: !186)
!185 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!186 = !DILocation(line: 85, scope: !187, inlinedAt: !189)
!187 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !188, file: !188, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!188 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl", directory: ".")
!189 = !DILocation(line: 86, scope: !154, inlinedAt: !143)
!190 = !{!191, !191, i64 0, i64 0}
!191 = !{!"custom_tbaa_addrspace(1)", !192, i64 0}
!192 = !{!"custom_tbaa"}
!193 = !DILocation(line: 298, scope: !194, inlinedAt: !195)
!194 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!195 = !DILocation(line: 88, scope: !196, inlinedAt: !198)
!196 = distinct !DISubprogram(name: "__warp_groupreduce;", linkageName: "__warp_groupreduce", scope: !197, file: !197, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!197 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl", directory: ".")
!198 = !DILocation(line: 19, scope: !144, inlinedAt: !146)
!199 = !DILocation(line: 297, scope: !200, inlinedAt: !201)
!200 = distinct !DISubprogram(name: "div;", linkageName: "div", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!201 = !DILocation(line: 89, scope: !196, inlinedAt: !198)
!202 = !{!"exec_lo"}
!203 = !DILocation(line: 106, scope: !204, inlinedAt: !206)
!204 = distinct !DISubprogram(name: "activelane;", linkageName: "activelane", scope: !205, file: !205, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!205 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl", directory: ".")
!206 = !DILocation(line: 249, scope: !207, inlinedAt: !208)
!207 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !205, file: !205, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!208 = !DILocation(line: 361, scope: !209, inlinedAt: !210)
!209 = distinct !DISubprogram(name: "#19;", linkageName: "#19", scope: !205, file: !205, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!210 = !DILocation(line: 228, scope: !211, inlinedAt: !212)
!211 = distinct !DISubprogram(name: "_shfl;", linkageName: "_shfl", scope: !205, file: !205, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!212 = !DILocation(line: 360, scope: !207, inlinedAt: !213)
!213 = !DILocation(line: 360, scope: !207, inlinedAt: !214)
!214 = !DILocation(line: 174, scope: !215, inlinedAt: !216)
!215 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!216 = !DILocation(line: 12, scope: !217, inlinedAt: !218)
!217 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !145, file: !145, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!218 = !DILocation(line: 78, scope: !219, inlinedAt: !220)
!219 = distinct !DISubprogram(name: "__warp_reduce;", linkageName: "__warp_reduce", scope: !197, file: !197, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!220 = !DILocation(line: 92, scope: !196, inlinedAt: !198)
!221 = !DILocation(line: 741, scope: !222, inlinedAt: !223)
!222 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!223 = !DILocation(line: 756, scope: !224, inlinedAt: !225)
!224 = distinct !DISubprogram(name: "check_sign_bit;", linkageName: "check_sign_bit", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!225 = !DILocation(line: 805, scope: !226, inlinedAt: !227)
!226 = distinct !DISubprogram(name: "toInt32;", linkageName: "toInt32", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!227 = !DILocation(line: 891, scope: !228, inlinedAt: !229)
!228 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !103, file: !103, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!229 = !DILocation(line: 7, scope: !107, inlinedAt: !206)
!230 = !DILocation(line: 39, scope: !158, inlinedAt: !231)
!231 = distinct !DILocation(line: 0, scope: !160, inlinedAt: !232)
!232 = distinct !DILocation(line: 0, scope: !162, inlinedAt: !233)
!233 = distinct !DILocation(line: 11, scope: !164, inlinedAt: !234)
!234 = distinct !DILocation(line: 113, scope: !167, inlinedAt: !235)
!235 = distinct !DILocation(line: 8, scope: !236, inlinedAt: !237)
!236 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_15168", scope: null, file: !170, line: 40, type: !46, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !47)
!237 = distinct !DILocation(line: 756, scope: !224, inlinedAt: !225)
!238 = !DILocation(line: 180, scope: !173, inlinedAt: !239)
!239 = distinct !DILocation(line: 180, scope: !173, inlinedAt: !234)
!240 = !DILocation(line: 52, scope: !177, inlinedAt: !241)
!241 = distinct !DILocation(line: 115, scope: !167, inlinedAt: !235)
!242 = !DILocation(line: 116, scope: !167, inlinedAt: !235)
!243 = !DILocation(line: 730, scope: !244, inlinedAt: !210)
!244 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !245, file: !245, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!245 = !DIFile(filename: "essentials.jl", directory: ".")
!246 = !DILocation(line: 347, scope: !247, inlinedAt: !248)
!247 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!248 = !DILocation(line: 1013, scope: !247, inlinedAt: !249)
!249 = !DILocation(line: 251, scope: !207, inlinedAt: !208)
!250 = !DILocation(line: 87, scope: !81, inlinedAt: !249)
!251 = !DILocation(line: 515, scope: !130, inlinedAt: !252)
!252 = !DILocation(line: 426, scope: !253, inlinedAt: !249)
!253 = distinct !DISubprogram(name: ">=;", linkageName: ">=", scope: !88, file: !88, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!254 = !DILocation(line: 796, scope: !255, inlinedAt: !249)
!255 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !245, file: !245, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!256 = !DILocation(line: 529, scope: !257, inlinedAt: !258)
!257 = distinct !DISubprogram(name: "<<;", linkageName: "<<", scope: !82, file: !82, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!258 = !DILocation(line: 252, scope: !207, inlinedAt: !208)
!259 = !DILocation(line: 178, scope: !260, inlinedAt: !258)
!260 = distinct !DISubprogram(name: "bpermute;", linkageName: "bpermute", scope: !205, file: !205, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!261 = !DILocation(line: 491, scope: !262, inlinedAt: !264)
!262 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !263, file: !263, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!263 = !DIFile(filename: "float.jl", directory: ".")
!264 = !DILocation(line: 10, scope: !265, inlinedAt: !218)
!265 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !145, file: !145, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!266 = !DILocation(line: 639, scope: !267, inlinedAt: !269)
!267 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !268, file: !268, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!268 = !DIFile(filename: "promotion.jl", directory: ".")
!269 = !DILocation(line: 483, scope: !267, inlinedAt: !270)
!270 = !DILocation(line: 93, scope: !196, inlinedAt: !198)
!271 = !DILocation(line: 39, scope: !49, inlinedAt: !272)
!272 = !DILocation(line: 0, scope: !183, inlinedAt: !273)
!273 = !DILocation(line: 0, scope: !274, inlinedAt: !275)
!274 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!275 = !DILocation(line: 88, scope: !276, inlinedAt: !277)
!276 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !188, file: !188, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!277 = !DILocation(line: 92, scope: !278, inlinedAt: !270)
!278 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !155, file: !155, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!279 = !{!280, !280, i64 0, i64 0}
!280 = !{!"custom_tbaa_addrspace(3)", !192, i64 0}
!281 = !DILocation(line: 93, scope: !278, inlinedAt: !270)
!282 = !DILocation(line: 6, scope: !283, inlinedAt: !285)
!283 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !284, file: !284, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!284 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!285 = !DILocation(line: 162, scope: !286, inlinedAt: !287)
!286 = distinct !DISubprogram(name: "#__synchronize;", linkageName: "#__synchronize", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!287 = !DILocation(line: 290, scope: !288, inlinedAt: !290)
!288 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !289, file: !289, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!289 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl", directory: ".")
!290 = !DILocation(line: 94, scope: !196, inlinedAt: !198)
!291 = !DILocation(line: 513, scope: !85, inlinedAt: !292)
!292 = !DILocation(line: 484, scope: !293, inlinedAt: !294)
!293 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !268, file: !268, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!294 = !DILocation(line: 520, scope: !85, inlinedAt: !295)
!295 = !DILocation(line: 97, scope: !196, inlinedAt: !198)
!296 = !DILocation(line: 98, scope: !196, inlinedAt: !198)
!297 = !DILocation(line: 639, scope: !267, inlinedAt: !298)
!298 = !DILocation(line: 483, scope: !267, inlinedAt: !299)
!299 = !DILocation(line: 99, scope: !196, inlinedAt: !198)
!300 = !DILocation(line: 39, scope: !158, inlinedAt: !301)
!301 = distinct !DILocation(line: 0, scope: !160, inlinedAt: !302)
!302 = distinct !DILocation(line: 0, scope: !162, inlinedAt: !303)
!303 = distinct !DILocation(line: 11, scope: !164, inlinedAt: !304)
!304 = distinct !DILocation(line: 113, scope: !167, inlinedAt: !305)
!305 = distinct !DILocation(line: 8, scope: !236, inlinedAt: !306)
!306 = distinct !DILocation(line: 756, scope: !224, inlinedAt: !307)
!307 = !DILocation(line: 805, scope: !226, inlinedAt: !308)
!308 = !DILocation(line: 891, scope: !228, inlinedAt: !309)
!309 = !DILocation(line: 7, scope: !107, inlinedAt: !310)
!310 = !DILocation(line: 249, scope: !207, inlinedAt: !311)
!311 = !DILocation(line: 361, scope: !209, inlinedAt: !312)
!312 = !DILocation(line: 228, scope: !211, inlinedAt: !313)
!313 = !DILocation(line: 360, scope: !207, inlinedAt: !314)
!314 = !DILocation(line: 360, scope: !207, inlinedAt: !315)
!315 = !DILocation(line: 174, scope: !215, inlinedAt: !316)
!316 = !DILocation(line: 12, scope: !217, inlinedAt: !317)
!317 = !DILocation(line: 78, scope: !219, inlinedAt: !299)
!318 = !DILocation(line: 180, scope: !173, inlinedAt: !319)
!319 = distinct !DILocation(line: 180, scope: !173, inlinedAt: !304)
!320 = !DILocation(line: 52, scope: !177, inlinedAt: !321)
!321 = distinct !DILocation(line: 115, scope: !167, inlinedAt: !305)
!322 = !DILocation(line: 116, scope: !167, inlinedAt: !305)
!323 = !DILocation(line: 347, scope: !247, inlinedAt: !324)
!324 = !DILocation(line: 1013, scope: !247, inlinedAt: !325)
!325 = !DILocation(line: 251, scope: !207, inlinedAt: !311)
!326 = !DILocation(line: 87, scope: !81, inlinedAt: !325)
!327 = !DILocation(line: 515, scope: !130, inlinedAt: !328)
!328 = !DILocation(line: 426, scope: !253, inlinedAt: !325)
!329 = !DILocation(line: 796, scope: !255, inlinedAt: !325)
!330 = !DILocation(line: 529, scope: !257, inlinedAt: !331)
!331 = !DILocation(line: 252, scope: !207, inlinedAt: !311)
!332 = !DILocation(line: 178, scope: !260, inlinedAt: !331)
!333 = !DILocation(line: 730, scope: !244, inlinedAt: !312)
!334 = !DILocation(line: 491, scope: !262, inlinedAt: !335)
!335 = !DILocation(line: 10, scope: !265, inlinedAt: !317)
!336 = !DILocation(line: 7, scope: !337, inlinedAt: !335)
!337 = distinct !DISubprogram(name: "A;", linkageName: "A", scope: !145, file: !145, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!338 = !DILocation(line: 639, scope: !267, inlinedAt: !339)
!339 = !DILocation(line: 21, scope: !144, inlinedAt: !146)
!340 = !DILocation(line: 513, scope: !85, inlinedAt: !341)
!341 = !DILocation(line: 754, scope: !149, inlinedAt: !342)
!342 = !DILocation(line: 689, scope: !151, inlinedAt: !343)
!343 = !DILocation(line: 699, scope: !151, inlinedAt: !344)
!344 = !DILocation(line: 90, scope: !278, inlinedAt: !339)
!345 = !DILocation(line: 39, scope: !158, inlinedAt: !346)
!346 = distinct !DILocation(line: 0, scope: !160, inlinedAt: !347)
!347 = distinct !DILocation(line: 0, scope: !162, inlinedAt: !348)
!348 = distinct !DILocation(line: 11, scope: !164, inlinedAt: !349)
!349 = distinct !DILocation(line: 113, scope: !167, inlinedAt: !350)
!350 = distinct !DILocation(line: 8, scope: !169, inlinedAt: !351)
!351 = distinct !DILocation(line: 699, scope: !151, inlinedAt: !344)
!352 = !DILocation(line: 180, scope: !173, inlinedAt: !353)
!353 = distinct !DILocation(line: 180, scope: !173, inlinedAt: !349)
!354 = !DILocation(line: 52, scope: !177, inlinedAt: !355)
!355 = distinct !DILocation(line: 115, scope: !167, inlinedAt: !350)
!356 = !DILocation(line: 116, scope: !167, inlinedAt: !350)
!357 = !DILocation(line: 491, scope: !262, inlinedAt: !339)
!358 = !DILocation(line: 39, scope: !49, inlinedAt: !359)
!359 = !DILocation(line: 0, scope: !183, inlinedAt: !360)
!360 = !DILocation(line: 0, scope: !274, inlinedAt: !361)
!361 = !DILocation(line: 88, scope: !276, inlinedAt: !362)
!362 = !DILocation(line: 92, scope: !278, inlinedAt: !339)
!363 = !DILocation(line: 93, scope: !278, inlinedAt: !339)
!364 = !DILocation(line: 99, scope: !66, inlinedAt: !68)
!365 = !DILocation(line: 39, scope: !49, inlinedAt: !366)
!366 = !DILocation(line: 0, scope: !183, inlinedAt: !367)
!367 = !DILocation(line: 0, scope: !185, inlinedAt: !368)
!368 = !DILocation(line: 85, scope: !187, inlinedAt: !369)
!369 = !DILocation(line: 86, scope: !154, inlinedAt: !296)
!370 = !DILocation(line: 106, scope: !204, inlinedAt: !310)
!371 = !DILocation(line: 741, scope: !222, inlinedAt: !372)
!372 = !DILocation(line: 756, scope: !224, inlinedAt: !307)
