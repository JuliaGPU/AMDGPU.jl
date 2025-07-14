; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@exception.5 = private unnamed_addr addrspace(1) constant [30 x i8] c"julia_throw_boundserror_13080\00", align 1
@_j_const_1.11 = private unnamed_addr addrspace(1) constant i32 1, align 4

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #0

; Function Attrs: memory(none)
declare [5 x ptr] @julia.gpu.state_getter() local_unnamed_addr #1

;  @ /home/pxlth/.julia/dev/t.jl:3 within `ker!`
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE({ [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray") local_unnamed_addr #2 !dbg !70 {
conversion:
  %0 = alloca { [1 x i64], ptr addrspace(1), i64 }, align 8, addrspace(5)
  %1 = addrspacecast ptr addrspace(5) %0 to ptr addrspace(11)
  store { [1 x i64], ptr addrspace(1), i64 } %"x::ROCDeviceArray", ptr addrspace(11) %1, align 8
  br label %top

top:                                              ; preds = %conversion
;  @ /home/pxlth/.julia/dev/t.jl:4 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `setindex!`
   br label %L3, !dbg !74

L3:                                               ; preds = %top
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ essentials.jl:668 within `unsigned`
; ││││┌ @ essentials.jl:733 within `reinterpret`
       %bitcast = load i64, ptr addrspace(11) %1, align 8, !dbg !78, !alias.scope !89, !noalias !92
; │││└└
; │││┌ @ int.jl:519 within `<`
      %2 = icmp ult i64 -1, %bitcast, !dbg !97
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    %3 = xor i1 %2, true, !dbg !88
    br i1 %3, label %L10, label %L9, !dbg !88

L9:                                               ; preds = %L3
    br label %L12, !dbg !88

L10:                                              ; preds = %L3
    call fastcc void @gpu_report_exception(ptr addrspacecast (ptr addrspace(1) @exception.5 to ptr)), !dbg !88
    call fastcc void @gpu_signal_exception(), !dbg !88
    call void @llvm.trap(), !dbg !88
    unreachable, !dbg !88

L12:                                              ; preds = %L9
    br label %L13, !dbg !88

L13:                                              ; preds = %L12
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `setindex!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
; │││┌ @ Base_compiler.jl:54 within `getproperty`
      %"x::ROCDeviceArray.ptr_ptr" = getelementptr inbounds i8, ptr addrspace(11) %1, i32 8, !dbg !100
; │└└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %4 = addrspacecast ptr inttoptr (i64 135300581509776 to ptr) to ptr addrspace(10), !dbg !108
      %5 = addrspacecast ptr inttoptr (i64 135296773089968 to ptr) to ptr addrspace(10), !dbg !108
      %"x::ROCDeviceArray.ptr_ptr.unbox" = load ptr addrspace(1), ptr addrspace(11) %"x::ROCDeviceArray.ptr_ptr", align 8, !dbg !108, !alias.scope !89, !noalias !92
      %6 = getelementptr inbounds i64, ptr addrspace(1) %"x::ROCDeviceArray.ptr_ptr.unbox", i64 -1, !dbg !108
      store i64 1, ptr addrspace(1) %6, align 8, !dbg !108, !tbaa !119
; │└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `setindex!`
   br label %L17, !dbg !122

L17:                                              ; preds = %L13
; └
;  @ /home/pxlth/.julia/dev/t.jl:5 within `ker!`
  ret void, !dbg !123
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:150 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception(ptr %0) unnamed_addr #3 !dbg !124 {
top:
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl within `report_exception`
  ret void, !dbg !126
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:112 within `signal_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #3 !dbg !127 {
top:
  %0 = alloca [5 x ptr], align 8, addrspace(5)
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
    %1 = addrspacecast ptr inttoptr (i64 135300586841456 to ptr) to ptr addrspace(10), !dbg !128
    %2 = addrspacecast ptr inttoptr (i64 135296773089968 to ptr) to ptr addrspace(10), !dbg !128
    %state.i = call [5 x ptr] @julia.gpu.state_getter(), !dbg !128
    store [5 x ptr] %state.i, ptr addrspace(5) %0, align 8, !dbg !128
; └└
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:114 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:65 within `setproperty!`
; │┌ @ pointer.jl:30 within `convert`
    %bitcast = load ptr, ptr addrspace(5) %0, align 8, !dbg !135, !tbaa !142, !alias.scope !146, !noalias !147
; │└
; │┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
    %pointerset_ptr = getelementptr inbounds i8, ptr %bitcast, i64 0, !dbg !148
    call void @llvm.memcpy.p0.p1.i64(ptr align 1 %pointerset_ptr, ptr addrspace(1) align 4 @_j_const_1.11, i64 4, i1 false), !dbg !148
; └└
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:127 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
   call void @llvm.amdgcn.endpgm(), !dbg !151
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:128 within `signal_exception`
  unreachable, !dbg !155
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p1.i64(ptr noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: cold convergent nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #5

attributes #0 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #1 = { memory(none) }
attributes #2 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #3 = { alwaysinline }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { cold convergent nocallback nofree noreturn nounwind }

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
!70 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_13074", scope: null, file: !71, line: 3, type: !72, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!71 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!72 = !DISubroutineType(types: !73)
!73 = !{}
!74 = !DILocation(line: 85, scope: !75, inlinedAt: !77)
!75 = distinct !DISubprogram(name: "setindex!;", linkageName: "setindex!", scope: !76, file: !76, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!76 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!77 = !DILocation(line: 4, scope: !70)
!78 = !DILocation(line: 733, scope: !79, inlinedAt: !81)
!79 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !80, file: !80, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!80 = !DIFile(filename: "essentials.jl", directory: ".")
!81 = !DILocation(line: 668, scope: !82, inlinedAt: !83)
!82 = distinct !DISubprogram(name: "unsigned;", linkageName: "unsigned", scope: !80, file: !80, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!83 = !DILocation(line: 754, scope: !84, inlinedAt: !86)
!84 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !85, file: !85, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!85 = !DIFile(filename: "abstractarray.jl", directory: ".")
!86 = !DILocation(line: 689, scope: !87, inlinedAt: !88)
!87 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !85, file: !85, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!88 = !DILocation(line: 699, scope: !87, inlinedAt: !74)
!89 = !{!90}
!90 = !{!"jnoalias_const", !91}
!91 = !{!"jnoalias"}
!92 = !{!93, !94, !95, !96}
!93 = !{!"jnoalias_gcframe", !91}
!94 = !{!"jnoalias_stack", !91}
!95 = !{!"jnoalias_data", !91}
!96 = !{!"jnoalias_typemd", !91}
!97 = !DILocation(line: 519, scope: !98, inlinedAt: !83)
!98 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !99, file: !99, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!99 = !DIFile(filename: "int.jl", directory: ".")
!100 = !DILocation(line: 54, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !102, file: !102, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!102 = !DIFile(filename: "Base_compiler.jl", directory: ".")
!103 = !DILocation(line: 64, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "unsafe_convert;", linkageName: "unsafe_convert", scope: !76, file: !76, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!105 = !DILocation(line: 59, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !76, file: !76, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!107 = !DILocation(line: 86, scope: !75, inlinedAt: !77)
!108 = !DILocation(line: 39, scope: !109, inlinedAt: !111)
!109 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !110, file: !110, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!110 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!111 = !DILocation(line: 0, scope: !112, inlinedAt: !114)
!112 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !113, file: !113, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!113 = !DIFile(filename: "none", directory: ".")
!114 = !DILocation(line: 0, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !113, file: !113, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!116 = !DILocation(line: 88, scope: !117, inlinedAt: !107)
!117 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !118, file: !118, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !34)
!118 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!119 = !{!120, !120, i64 0, i64 0}
!120 = !{!"custom_tbaa_addrspace(1)", !121, i64 0}
!121 = !{!"custom_tbaa"}
!122 = !DILocation(line: 87, scope: !75, inlinedAt: !77)
!123 = !DILocation(line: 5, scope: !70)
!124 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_14693", scope: null, file: !125, line: 150, type: !72, scopeLine: 150, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !41)
!125 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!126 = !DILocation(line: 4294967295, scope: !124)
!127 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14742", scope: null, file: !125, line: 112, type: !72, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!128 = !DILocation(line: 39, scope: !129, inlinedAt: !130)
!129 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !110, file: !110, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!130 = !DILocation(line: 0, scope: !131, inlinedAt: !132)
!131 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !113, file: !113, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!132 = !DILocation(line: 0, scope: !133, inlinedAt: !134)
!133 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !113, file: !113, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!134 = !DILocation(line: 113, scope: !127)
!135 = !DILocation(line: 30, scope: !136, inlinedAt: !138)
!136 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !137, file: !137, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!137 = !DIFile(filename: "pointer.jl", directory: ".")
!138 = !DILocation(line: 65, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !140, file: !140, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!140 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!141 = !DILocation(line: 114, scope: !127)
!142 = !{!143, !143, i64 0}
!143 = !{!"jtbaa_stack", !144, i64 0}
!144 = !{!"jtbaa", !145, i64 0}
!145 = !{!"jtbaa"}
!146 = !{!94}
!147 = !{!93, !95, !96, !90}
!148 = !DILocation(line: 178, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !137, file: !137, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!150 = !DILocation(line: 178, scope: !149, inlinedAt: !138)
!151 = !DILocation(line: 6, scope: !152, inlinedAt: !154)
!152 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !153, file: !153, type: !72, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !49)
!153 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!154 = !DILocation(line: 127, scope: !127)
!155 = !DILocation(line: 128, scope: !127)
