; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: cold convergent nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #0

;  @ /home/pxlth/.julia/dev/t.jl:3 within `ker!`
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE([5 x ptr] %state, { [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray") local_unnamed_addr #1 !dbg !70 {
conversion:
;  @ /home/pxlth/.julia/dev/t.jl:4 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `setindex!`
; │┌ @ abstractarray.jl:699 within `checkbounds`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││┌ @ none within `kernel_state`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %state.i.fca.0.extract.i = extractvalue [5 x ptr] %state, 0, !dbg !74
; │││└└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:114 within `signal_exception`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:65 within `setproperty!`
; ││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
       store i32 1, ptr %state.i.fca.0.extract.i, align 1, !dbg !92
; │││└└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:127 within `signal_exception`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
      call void @llvm.amdgcn.endpgm(), !dbg !100
; │││└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:128 within `signal_exception`
     unreachable, !dbg !104
; └└└
}

attributes #0 = { cold convergent nocallback nofree noreturn nounwind }
attributes #1 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59, !60, !61, !62, !63, !64, !65, !66}
!opencl.ocl.version = !{!67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67, !67}
!llvm.ident = !{!68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68, !68}
!julia.kernel = !{!69}

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
!67 = !{i32 2, i32 0}
!68 = !{!"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"}
!69 = !{ptr @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!70 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_15506", scope: null, file: !71, line: 3, type: !72, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!71 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!72 = !DISubroutineType(types: !73)
!73 = !{}
!74 = !DILocation(line: 39, scope: !75, inlinedAt: !77)
!75 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !76, file: !76, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!76 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!77 = distinct !DILocation(line: 0, scope: !78, inlinedAt: !80)
!78 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !79, file: !79, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!79 = !DIFile(filename: "none", directory: ".")
!80 = distinct !DILocation(line: 0, scope: !81, inlinedAt: !82)
!81 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !79, file: !79, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!82 = distinct !DILocation(line: 113, scope: !83, inlinedAt: !85)
!83 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14742", scope: null, file: !84, line: 112, type: !72, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!84 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!85 = distinct !DILocation(line: 699, scope: !86, inlinedAt: !88)
!86 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !87, file: !87, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!87 = !DIFile(filename: "abstractarray.jl", directory: ".")
!88 = !DILocation(line: 85, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !90, file: !90, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!90 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!91 = !DILocation(line: 4, scope: !70)
!92 = !DILocation(line: 178, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !94, file: !94, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!94 = !DIFile(filename: "pointer.jl", directory: ".")
!95 = distinct !DILocation(line: 178, scope: !93, inlinedAt: !96)
!96 = distinct !DILocation(line: 65, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !98, file: !98, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!98 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!99 = distinct !DILocation(line: 114, scope: !83, inlinedAt: !85)
!100 = !DILocation(line: 6, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !102, file: !102, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!102 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!103 = distinct !DILocation(line: 127, scope: !83, inlinedAt: !85)
!104 = !DILocation(line: 128, scope: !83, inlinedAt: !85)
