; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@_j_const1 = private unnamed_addr addrspace(1) constant i32 1

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #0

; Function Attrs: readnone
declare { i64, i64, i64, i64, i64, i64, i32, i32 } @julia.gpu.state_getter() local_unnamed_addr #1

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:363 within `f`
define amdgpu_kernel void @_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE({ [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #2 !dbg !9 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %0, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, align 8
  br label %top

top:                                              ; preds = %conversion
  %3 = alloca { i64, i64, i64, i64, i64, i64, i32, i32 }, align 8, addrspace(5)
  %4 = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %4 to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -13
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 14
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:364 within `f`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
   br label %L2, !dbg !12

L2:                                               ; preds = %top
; │┌ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
; ││┌ @ abstractarray.jl:382 within `eachindex`
; │││┌ @ abstractarray.jl:133 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `size`
; ││││││┌ @ Base.jl:37 within `getproperty`
         %7 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 0, !dbg !16
; │││││└└
; │││││┌ @ tuple.jl:273 within `map`
; ││││││┌ @ tuple.jl:29 within `getindex`
         %8 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %7, i32 0, i32 0, !dbg !31
; ││││││└
; ││││││┌ @ range.jl:459 within `oneto`
; │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
; ││││││││┌ @ promotion.jl:510 within `max`
; │││││││││┌ @ int.jl:83 within `<`
            %9 = load i64, i64 addrspace(11)* %8, align 8, !dbg !36, !alias.scope !48, !noalias !51
            %10 = icmp slt i64 %9, 0, !dbg !36
; │││││││││└
; │││││││││┌ @ essentials.jl:575 within `ifelse`
            %11 = zext i1 %10 to i8, !dbg !56
            %12 = trunc i8 %11 to i1, !dbg !56
            %13 = xor i1 %12, true, !dbg !56
            %14 = load i64, i64 addrspace(11)* %8, align 8, !dbg !56, !alias.scope !48, !noalias !51
            %15 = select i1 %13, i64 %14, i64 0, !dbg !56
; ││└└└└└└└└
; ││┌ @ abstractarray.jl:768 within `checkindex`
; │││┌ @ int.jl:488 within `<=`
      %16 = icmp sle i64 2, %15, !dbg !59
; │││└
; │││┌ @ bool.jl:38 within `&`
      %17 = and i1 true, %16, !dbg !63
; ││└└
; ││ @ abstractarray.jl:709 within `checkbounds`
    %18 = zext i1 %17 to i8, !dbg !30
    %19 = trunc i8 %18 to i1, !dbg !30
    %20 = xor i1 %19, true, !dbg !30
    br i1 %20, label %L10, label %L9, !dbg !30

L9:                                               ; preds = %L2
    br label %L16, !dbg !30

L10:                                              ; preds = %L2
; ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:56 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │││││┌ @ none within `kernel_state`
; ││││││┌ @ none within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
         %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32 } @julia.gpu.state_getter(), !dbg !66
         store { i64, i64, i64, i64, i64, i64, i32, i32 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32 } addrspace(5)* %3, align 8, !dbg !66
; │││││└└
; │││││┌ @ Base.jl:37 within `getproperty`
        %21 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32 }, { i64, i64, i64, i64, i64, i64, i32, i32 } addrspace(5)* %3, i32 0, i32 0, !dbg !82
; ││││└└
; ││││┌ @ pointer.jl:126 within `unsafe_store!` @ pointer.jl:126
       %22 = bitcast i64 addrspace(5)* %21 to i32* addrspace(5)*, !dbg !83
       %23 = load i32*, i32* addrspace(5)* %22, align 8, !dbg !83, !tbaa !87, !alias.scope !91, !noalias !92
       %24 = getelementptr inbounds i32, i32* %23, i64 0, !dbg !83
       %25 = load i32, i32 addrspace(1)* @_j_const1, align 1, !dbg !83, !tbaa !93, !alias.scope !97, !noalias !98
       store i32 %25, i32* %24, align 1, !dbg !83, !tbaa !99, !alias.scope !97, !noalias !98
; ││││└
; ││││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl:58 within `signal_exception`
; ││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
       call void @llvm.amdgcn.endpgm(), !dbg !100
; │││└└
; │││ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl:9 within `#throw_boundserror`
; │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:1 within `trap`
      unreachable, !dbg !104

L16:                                              ; preds = %L9
; ││└└
; ││ @ abstractarray.jl:710 within `checkbounds`
    br label %L17, !dbg !107

L17:                                              ; preds = %L16
    br label %L18, !dbg !107

L18:                                              ; preds = %L17
; │└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
; ││┌ @ Base.jl:37 within `getproperty`
     %26 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 1, !dbg !108
; │└└
; │┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `pointerset`
; │││┌ @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl:40
      %27 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %26, align 8, !dbg !112, !alias.scope !48, !noalias !51
      %28 = bitcast i8 addrspace(1)* %27 to i32 addrspace(1)*, !dbg !112
      %29 = getelementptr inbounds i32, i32 addrspace(1)* %28, i64 1, !dbg !112
      store i32 1, i32 addrspace(1)* %29, align 4, !dbg !112, !tbaa !120
; │└└└
; │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
   br label %L22, !dbg !123

L22:                                              ; preds = %L18
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:365 within `f`
  ret void, !dbg !124
}

attributes #0 = { cold noreturn nounwind }
attributes #1 = { readnone }
attributes #2 = { "frame-pointer"="all" "probe-stack"="inline-asm" }

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
!8 = !{void ({ [1 x i64], i8 addrspace(1)*, i64 })* @_Z1f14ROCDeviceArrayI5Int32Li1ELi1EE}
!9 = distinct !DISubprogram(name: "f", linkageName: "julia_f_1613", scope: null, file: !5, line: 363, type: !10, scopeLine: 363, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!10 = !DISubroutineType(types: !11)
!11 = !{}
!12 = !DILocation(line: 88, scope: !13, inlinedAt: !15)
!13 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !14, file: !14, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!14 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!15 = !DILocation(line: 364, scope: !9)
!16 = !DILocation(line: 37, scope: !17, inlinedAt: !19)
!17 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !18, file: !18, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!18 = !DIFile(filename: "Base.jl", directory: ".")
!19 = !DILocation(line: 68, scope: !20, inlinedAt: !21)
!20 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !14, file: !14, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!21 = !DILocation(line: 98, scope: !22, inlinedAt: !24)
!22 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!23 = !DIFile(filename: "abstractarray.jl", directory: ".")
!24 = !DILocation(line: 133, scope: !25, inlinedAt: !26)
!25 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!26 = !DILocation(line: 382, scope: !27, inlinedAt: !28)
!27 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!28 = !DILocation(line: 694, scope: !29, inlinedAt: !30)
!29 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!30 = !DILocation(line: 709, scope: !29, inlinedAt: !12)
!31 = !DILocation(line: 29, scope: !32, inlinedAt: !34)
!32 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !33, file: !33, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!33 = !DIFile(filename: "tuple.jl", directory: ".")
!34 = !DILocation(line: 273, scope: !35, inlinedAt: !21)
!35 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !33, file: !33, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!36 = !DILocation(line: 83, scope: !37, inlinedAt: !39)
!37 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !38, file: !38, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!38 = !DIFile(filename: "int.jl", directory: ".")
!39 = !DILocation(line: 510, scope: !40, inlinedAt: !42)
!40 = distinct !DISubprogram(name: "max;", linkageName: "max", scope: !41, file: !41, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!41 = !DIFile(filename: "promotion.jl", directory: ".")
!42 = !DILocation(line: 444, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "OneTo;", linkageName: "OneTo", scope: !44, file: !44, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!44 = !DIFile(filename: "range.jl", directory: ".")
!45 = !DILocation(line: 457, scope: !43, inlinedAt: !46)
!46 = !DILocation(line: 459, scope: !47, inlinedAt: !34)
!47 = distinct !DISubprogram(name: "oneto;", linkageName: "oneto", scope: !44, file: !44, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!48 = !{!49}
!49 = !{!"jnoalias_const", !50}
!50 = !{!"jnoalias"}
!51 = !{!52, !53, !54, !55}
!52 = !{!"jnoalias_gcframe", !50}
!53 = !{!"jnoalias_stack", !50}
!54 = !{!"jnoalias_data", !50}
!55 = !{!"jnoalias_typemd", !50}
!56 = !DILocation(line: 575, scope: !57, inlinedAt: !39)
!57 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !58, file: !58, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!58 = !DIFile(filename: "essentials.jl", directory: ".")
!59 = !DILocation(line: 488, scope: !60, inlinedAt: !61)
!60 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !38, file: !38, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!61 = !DILocation(line: 768, scope: !62, inlinedAt: !28)
!62 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !23, file: !23, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!63 = !DILocation(line: 38, scope: !64, inlinedAt: !61)
!64 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !65, file: !65, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!65 = !DIFile(filename: "bool.jl", directory: ".")
!66 = !DILocation(line: 40, scope: !67, inlinedAt: !69)
!67 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !68, file: !68, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!68 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/base.jl", directory: ".")
!69 = !DILocation(line: 0, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !71, file: !71, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!71 = !DIFile(filename: "none", directory: ".")
!72 = !DILocation(line: 0, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !71, file: !71, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!74 = !DILocation(line: 11, scope: !75, inlinedAt: !77)
!75 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !76, file: !76, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!76 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!77 = !DILocation(line: 56, scope: !78, inlinedAt: !79)
!78 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !76, file: !76, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!79 = !DILocation(line: 8, scope: !80, inlinedAt: !30)
!80 = distinct !DISubprogram(name: "#throw_boundserror;", linkageName: "#throw_boundserror", scope: !81, file: !81, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!81 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!82 = !DILocation(line: 37, scope: !17, inlinedAt: !74)
!83 = !DILocation(line: 126, scope: !84, inlinedAt: !86)
!84 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !85, file: !85, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!85 = !DIFile(filename: "pointer.jl", directory: ".")
!86 = !DILocation(line: 126, scope: !84, inlinedAt: !77)
!87 = !{!88, !88, i64 0}
!88 = !{!"jtbaa_stack", !89, i64 0}
!89 = !{!"jtbaa", !90, i64 0}
!90 = !{!"jtbaa"}
!91 = !{!53}
!92 = !{!52, !54, !55, !49}
!93 = !{!94, !94, i64 0}
!94 = !{!"jtbaa_immut", !95, i64 0}
!95 = !{!"jtbaa_value", !96, i64 0}
!96 = !{!"jtbaa_data", !89, i64 0}
!97 = !{!54}
!98 = !{!52, !53, !55, !49}
!99 = !{!96, !96, i64 0}
!100 = !DILocation(line: 52, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !102, file: !102, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!102 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!103 = !DILocation(line: 58, scope: !78, inlinedAt: !79)
!104 = !DILocation(line: 1, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "trap;", linkageName: "trap", scope: !102, file: !102, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!106 = !DILocation(line: 9, scope: !80, inlinedAt: !30)
!107 = !DILocation(line: 710, scope: !29, inlinedAt: !12)
!108 = !DILocation(line: 37, scope: !17, inlinedAt: !109)
!109 = !DILocation(line: 63, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !14, file: !14, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!111 = !DILocation(line: 90, scope: !13, inlinedAt: !15)
!112 = !DILocation(line: 40, scope: !67, inlinedAt: !113)
!113 = !DILocation(line: 46, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !115, file: !115, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!115 = !DIFile(filename: "/home/pxl-th/.julia/packages/LLVM/5aiiG/src/interop/pointer.jl", directory: ".")
!116 = !DILocation(line: 46, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !115, file: !115, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!118 = !DILocation(line: 88, scope: !119, inlinedAt: !111)
!119 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !115, file: !115, type: !10, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !11)
!120 = !{!121, !121, i64 0, i64 0}
!121 = !{!"custom_tbaa_addrspace(1)", !122, i64 0}
!122 = !{!"custom_tbaa"}
!123 = !DILocation(line: 91, scope: !13, inlinedAt: !15)
!124 = !DILocation(line: 365, scope: !9)
