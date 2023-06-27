; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #0

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:363 within `f`
define amdgpu_kernel void @_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE({ i64, i64, i64, i64, i64, i64, i32, i32 } %state, { [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #1 !dbg !9 {
conversion:
  %.fca.0.0.extract = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %0, 0, 0
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:364 within `f`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
; │┌ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %1 = icmp slt i64 %.fca.0.0.extract, 2, !dbg !12
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    br i1 %1, label %L10, label %L18, !dbg !20

L10:                                              ; preds = %conversion
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:56 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
         %state.i.fca.0.extract = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32 } %state, 0, !dbg !25
; ││││└└└
; ││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
       %2 = inttoptr i64 %state.i.fca.0.extract to i32*, !dbg !41
       store i32 1, i32* %2, align 1, !dbg !41, !tbaa !45, !alias.scope !49, !noalias !52
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:58 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !57
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
      unreachable, !dbg !61

L18:                                              ; preds = %conversion
      %.fca.1.extract = extractvalue { [1 x i64], i8 addrspace(1)*, i64 } %0, 1
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
      %3 = getelementptr inbounds i8, i8 addrspace(1)* %.fca.1.extract, i64 4, !dbg !64
      %4 = bitcast i8 addrspace(1)* %3 to i32 addrspace(1)*, !dbg !64
      store i32 1, i32 addrspace(1)* %4, align 4, !dbg !64, !tbaa !73
; └└└└
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:365 within `f`
  ret void, !dbg !76
}

attributes #0 = { cold noreturn nounwind }
attributes #1 = { "frame-pointer"="all" "probe-stack"="inline-asm" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4}
!opencl.ocl.version = !{!6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6}
!llvm.ident = !{!7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7}
!julia.kernel = !{!8}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl", directory: ".")
!6 = !{i32 2, i32 0}
!7 = !{!"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"}
!8 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32 }, { [1 x i64], i8 addrspace(1)*, i64 })* @_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE}
!9 = distinct !DISubprogram(name: "f", linkageName: "julia_f_2099", scope: null, file: !5, line: 363, type: !10, scopeLine: 363, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!10 = !DISubroutineType(types: !11)
!11 = !{}
!12 = !DILocation(line: 488, scope: !13, inlinedAt: !15)
!13 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !14, file: !14, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!14 = !DIFile(filename: "int.jl", directory: ".")
!15 = !DILocation(line: 768, scope: !16, inlinedAt: !18)
!16 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !17, file: !17, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!17 = !DIFile(filename: "abstractarray.jl", directory: ".")
!18 = !DILocation(line: 694, scope: !19, inlinedAt: !20)
!19 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !17, file: !17, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!20 = !DILocation(line: 709, scope: !19, inlinedAt: !21)
!21 = !DILocation(line: 88, scope: !22, inlinedAt: !24)
!22 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!23 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!24 = !DILocation(line: 364, scope: !9)
!25 = !DILocation(line: 40, scope: !26, inlinedAt: !28)
!26 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !27, file: !27, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!27 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl", directory: ".")
!28 = !DILocation(line: 0, scope: !29, inlinedAt: !31)
!29 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !30, file: !30, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!30 = !DIFile(filename: "none", directory: ".")
!31 = !DILocation(line: 0, scope: !32, inlinedAt: !33)
!32 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !30, file: !30, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!33 = !DILocation(line: 11, scope: !34, inlinedAt: !36)
!34 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !35, file: !35, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!35 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!36 = !DILocation(line: 56, scope: !37, inlinedAt: !38)
!37 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !35, file: !35, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!38 = !DILocation(line: 8, scope: !39, inlinedAt: !20)
!39 = distinct !DISubprogram(name: "#throw_boundserror;", linkageName: "#throw_boundserror", scope: !40, file: !40, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!40 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!41 = !DILocation(line: 126, scope: !42, inlinedAt: !44)
!42 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !43, file: !43, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!43 = !DIFile(filename: "pointer.jl", directory: ".")
!44 = !DILocation(line: 126, scope: !42, inlinedAt: !36)
!45 = !{!46, !46, i64 0}
!46 = !{!"jtbaa_data", !47, i64 0}
!47 = !{!"jtbaa", !48, i64 0}
!48 = !{!"jtbaa"}
!49 = !{!50}
!50 = !{!"jnoalias_data", !51}
!51 = !{!"jnoalias"}
!52 = !{!53, !54, !55, !56}
!53 = !{!"jnoalias_gcframe", !51}
!54 = !{!"jnoalias_stack", !51}
!55 = !{!"jnoalias_typemd", !51}
!56 = !{!"jnoalias_const", !51}
!57 = !DILocation(line: 52, scope: !58, inlinedAt: !60)
!58 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !59, file: !59, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!59 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!60 = !DILocation(line: 58, scope: !37, inlinedAt: !38)
!61 = !DILocation(line: 1, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !59, file: !59, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!63 = !DILocation(line: 9, scope: !39, inlinedAt: !20)
!64 = !DILocation(line: 40, scope: !26, inlinedAt: !65)
!65 = !DILocation(line: 46, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !67, file: !67, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!67 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl", directory: ".")
!68 = !DILocation(line: 46, scope: !69, inlinedAt: !70)
!69 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !67, file: !67, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!70 = !DILocation(line: 88, scope: !71, inlinedAt: !72)
!71 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !67, file: !67, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!72 = !DILocation(line: 90, scope: !22, inlinedAt: !24)
!73 = !{!74, !74, i64 0, i64 0}
!74 = !{!"custom_tbaa_addrspace(1)", !75, i64 0}
!75 = !{!"custom_tbaa"}
!76 = !DILocation(line: 365, scope: !9)
