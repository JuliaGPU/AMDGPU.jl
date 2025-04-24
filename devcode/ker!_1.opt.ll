; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@__scratch_lds = internal addrspace(3) global [32 x i64] undef, align 8

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr() #0

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #1

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #0

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #0

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #0

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #2

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.y() #0

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.update.dpp.i32(i32, i32, i32 immarg, i32 immarg, i32 immarg, i1 immarg) #3

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.permlanex16(i32, i32, i32, i32, i1 immarg, i1 immarg) #3

; Function Attrs: alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.z() #0

; Function Attrs: cold convergent nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #4

;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `ker!`
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE({ ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, { [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray") local_unnamed_addr #5 !dbg !39 {
conversion:
  %"x::ROCDeviceArray.fca.0.0.extract" = extractvalue { [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray", 0, 0
;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:4 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:43 within `sync_workgroup_or`
   %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !43
   %1 = call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr(), !dbg !43
   %2 = getelementptr inbounds i8, ptr addrspace(4) %1, i64 8, !dbg !43
   %3 = load i32, ptr addrspace(4) %2, align 4, !dbg !43, !tbaa !47
   %4 = icmp ult i32 %0, %3, !dbg !43
   %5 = select i1 %4, i64 16, i64 22, !dbg !43
   %6 = getelementptr inbounds i8, ptr addrspace(4) %1, i64 %5, !dbg !43
   %7 = load i16, ptr addrspace(4) %6, align 2, !dbg !43, !tbaa !51
   %8 = zext i16 %7 to i32, !dbg !43
   %9 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !43
   %10 = getelementptr inbounds i8, ptr addrspace(4) %1, i64 4, !dbg !43
   %11 = load i32, ptr addrspace(4) %10, align 4, !dbg !43, !tbaa !47
   %12 = icmp ult i32 %9, %11, !dbg !43
   %13 = select i1 %12, i64 14, i64 20, !dbg !43
   %14 = getelementptr inbounds i8, ptr addrspace(4) %1, i64 %13, !dbg !43
   %15 = load i16, ptr addrspace(4) %14, align 2, !dbg !43, !tbaa !51
   %16 = zext i16 %15 to i32, !dbg !43
   %17 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !43
   %18 = load i32, ptr addrspace(4) %1, align 4, !dbg !43, !tbaa !47
   %19 = icmp ult i32 %17, %18, !dbg !43
   %20 = select i1 %19, i64 12, i64 18, !dbg !43
   %21 = getelementptr inbounds i8, ptr addrspace(4) %1, i64 %20, !dbg !43
   %22 = load i16, ptr addrspace(4) %21, align 2, !dbg !43, !tbaa !51
   %23 = zext i16 %22 to i32, !dbg !43
   %24 = shl nuw nsw i32 %16, 8, !dbg !43
   %25 = mul i32 %24, %23, !dbg !43
   %26 = ashr exact i32 %25, 8, !dbg !43
   %27 = mul nsw i32 %26, %8, !dbg !43
   %28 = add i32 %27, 31, !dbg !43
   %29 = call i32 @llvm.amdgcn.update.dpp.i32(i32 undef, i32 0, i32 257, i32 15, i32 15, i1 true), !dbg !43
   %30 = call i32 @llvm.amdgcn.update.dpp.i32(i32 undef, i32 %29, i32 258, i32 15, i32 15, i1 true), !dbg !43
   %31 = or i32 %30, %29, !dbg !43
   %32 = call i32 @llvm.amdgcn.update.dpp.i32(i32 undef, i32 %31, i32 260, i32 15, i32 15, i1 true), !dbg !43
   %33 = or i32 %31, %32, !dbg !43
   %34 = call i32 @llvm.amdgcn.update.dpp.i32(i32 undef, i32 %33, i32 264, i32 15, i32 15, i1 true), !dbg !43
   %35 = or i32 %33, %34, !dbg !43
   %36 = call i32 @llvm.amdgcn.update.dpp.i32(i32 undef, i32 %35, i32 336, i32 15, i32 15, i1 true), !dbg !43
   %37 = call i32 @llvm.amdgcn.permlanex16(i32 undef, i32 %36, i32 0, i32 0, i1 false, i1 true), !dbg !43
   %38 = or i32 %37, %36, !dbg !43
   %.mask = and i32 %28, -32, !dbg !43
   %39 = icmp eq i32 %.mask, 32, !dbg !43
   br i1 %39, label %__ockl_wgred_or_i32.exit, label %40, !dbg !43

40:                                               ; preds = %conversion
   %41 = call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0), !dbg !43
   %42 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !43, !range !53
   %43 = mul nuw nsw i32 %42, %16, !dbg !43
   %44 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !43, !range !53
   %45 = add nuw nsw i32 %43, %44, !dbg !43
   %46 = mul i32 %45, %23, !dbg !43
   %47 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !43, !range !53
   %48 = add i32 %46, %47, !dbg !43
   %49 = lshr i32 %48, 5, !dbg !43
   %50 = icmp eq i32 %41, 0, !dbg !43
   %51 = or i32 %49, %41, !dbg !43
   %52 = icmp eq i32 %51, 0, !dbg !43
   br i1 %52, label %53, label %54, !dbg !43

53:                                               ; preds = %40
   store atomic i32 %38, ptr addrspace(3) @__scratch_lds syncscope("workgroup-one-as") monotonic, align 4, !dbg !43
   br label %54, !dbg !43

54:                                               ; preds = %53, %40
   fence syncscope("workgroup") release, !dbg !43
   call void @llvm.amdgcn.s.barrier(), !dbg !43
   fence syncscope("workgroup") acquire, !dbg !43
   %55 = icmp ugt i32 %48, 31, !dbg !43
   %56 = and i1 %50, %55, !dbg !43
   br i1 %56, label %57, label %59, !dbg !43

57:                                               ; preds = %54
   %58 = atomicrmw or ptr addrspace(3) @__scratch_lds, i32 %38 syncscope("workgroup-one-as") monotonic, align 4, !dbg !43
   br label %59, !dbg !43

59:                                               ; preds = %57, %54
   fence syncscope("workgroup") release, !dbg !43
   call void @llvm.amdgcn.s.barrier(), !dbg !43
   fence syncscope("workgroup") acquire, !dbg !43
   %60 = load atomic i32, ptr addrspace(3) @__scratch_lds syncscope("workgroup-one-as") monotonic, align 4, !dbg !43
   fence syncscope("workgroup") release, !dbg !43
   call void @llvm.amdgcn.s.barrier(), !dbg !43
   fence syncscope("workgroup") acquire, !dbg !43
   br label %__ockl_wgred_or_i32.exit, !dbg !43

__ockl_wgred_or_i32.exit:                         ; preds = %59, %conversion
   %61 = phi i32 [ %60, %59 ], [ %38, %conversion ], !dbg !43
; └
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ int.jl:519 within `<`
      %.not = icmp eq i64 %"x::ROCDeviceArray.fca.0.0.extract", 0, !dbg !54
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    br i1 %.not, label %L14, label %L17, !dbg !62

L14:                                              ; preds = %__ockl_wgred_or_i32.exit
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %state.i.fca.0.extract.i = extractvalue { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state, 0, !dbg !66
; ││││└└└
; ││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
       store i32 1, ptr %state.i.fca.0.extract.i, align 1, !dbg !83
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !87
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
      unreachable, !dbg !91

L17:                                              ; preds = %__ockl_wgred_or_i32.exit
      %"x::ROCDeviceArray.fca.1.extract" = extractvalue { [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray", 1
; │└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; │┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ number.jl:7 within `convert`
; │││┌ @ boot.jl:957 within `Int64`
; ││││┌ @ boot.jl:876 within `toInt64`
       %62 = sext i32 %61 to i64, !dbg !92
; ││└└└
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
      store i64 %62, ptr addrspace(1) %"x::ROCDeviceArray.fca.1.extract", align 8, !dbg !104, !tbaa !110
; └└└└
;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:5 within `ker!`
  ret void, !dbg !113
}

attributes #0 = { alwaysinline nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { alwaysinline nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { alwaysinline convergent nocallback nofree nounwind willreturn }
attributes #3 = { alwaysinline convergent nocallback nofree nounwind willreturn memory(none) }
attributes #4 = { cold convergent nocallback nofree noreturn nounwind }
attributes #5 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35}
!opencl.ocl.version = !{!36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36}
!llvm.ident = !{!37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37}
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
!38 = !{ptr @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!39 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_15348", scope: null, file: !40, line: 3, type: !41, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!40 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!41 = !DISubroutineType(types: !42)
!42 = !{}
!43 = !DILocation(line: 43, scope: !44, inlinedAt: !46)
!44 = distinct !DISubprogram(name: "sync_workgroup_or;", linkageName: "sync_workgroup_or", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!45 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!46 = !DILocation(line: 4, scope: !39)
!47 = !{!48, !48, i64 0}
!48 = !{!"int", !49, i64 0}
!49 = !{!"omnipotent char", !50, i64 0}
!50 = !{!"Simple C/C++ TBAA"}
!51 = !{!52, !52, i64 0}
!52 = !{!"short", !49, i64 0}
!53 = !{i32 0, i32 1024}
!54 = !DILocation(line: 519, scope: !55, inlinedAt: !57)
!55 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !56, file: !56, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!56 = !DIFile(filename: "int.jl", directory: ".")
!57 = !DILocation(line: 754, scope: !58, inlinedAt: !60)
!58 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !59, file: !59, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!59 = !DIFile(filename: "abstractarray.jl", directory: ".")
!60 = !DILocation(line: 689, scope: !61, inlinedAt: !62)
!61 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !59, file: !59, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!62 = !DILocation(line: 699, scope: !61, inlinedAt: !63)
!63 = !DILocation(line: 88, scope: !64, inlinedAt: !46)
!64 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !65, file: !65, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!65 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!66 = !DILocation(line: 39, scope: !67, inlinedAt: !69)
!67 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !68, file: !68, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!68 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl", directory: ".")
!69 = distinct !DILocation(line: 0, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !71, file: !71, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!71 = !DIFile(filename: "none", directory: ".")
!72 = distinct !DILocation(line: 0, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !71, file: !71, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!74 = distinct !DILocation(line: 11, scope: !75, inlinedAt: !77)
!75 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !76, file: !76, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!76 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!77 = distinct !DILocation(line: 113, scope: !78, inlinedAt: !79)
!78 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_13546", scope: null, file: !76, line: 112, type: !41, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!79 = distinct !DILocation(line: 8, scope: !80, inlinedAt: !82)
!80 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_15354", scope: null, file: !81, line: 44, type: !41, scopeLine: 44, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!81 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!82 = distinct !DILocation(line: 699, scope: !61, inlinedAt: !63)
!83 = !DILocation(line: 180, scope: !84, inlinedAt: !86)
!84 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !85, file: !85, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!85 = !DIFile(filename: "pointer.jl", directory: ".")
!86 = distinct !DILocation(line: 180, scope: !84, inlinedAt: !77)
!87 = !DILocation(line: 52, scope: !88, inlinedAt: !90)
!88 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !89, file: !89, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18)
!89 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!90 = distinct !DILocation(line: 115, scope: !78, inlinedAt: !79)
!91 = !DILocation(line: 116, scope: !78, inlinedAt: !79)
!92 = !DILocation(line: 876, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !94, file: !94, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!94 = !DIFile(filename: "boot.jl", directory: ".")
!95 = !DILocation(line: 957, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !94, file: !94, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!97 = !DILocation(line: 7, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !99, file: !99, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!99 = !DIFile(filename: "number.jl", directory: ".")
!100 = !DILocation(line: 88, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!102 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl", directory: ".")
!103 = !DILocation(line: 90, scope: !64, inlinedAt: !46)
!104 = !DILocation(line: 39, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !68, file: !68, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!106 = !DILocation(line: 0, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !71, file: !71, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!108 = !DILocation(line: 0, scope: !109, inlinedAt: !100)
!109 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !71, file: !71, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6)
!110 = !{!111, !111, i64 0, i64 0}
!111 = !{!"custom_tbaa_addrspace(1)", !112, i64 0}
!112 = !{!"custom_tbaa"}
!113 = !DILocation(line: 5, scope: !39)
