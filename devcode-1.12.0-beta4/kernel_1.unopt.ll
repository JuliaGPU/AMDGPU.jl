; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { ptr addrspace(1) }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, ptr addrspace(1), %1, i32, i32, i64 }

@_j_const_1 = private unnamed_addr addrspace(1) constant i32 1, align 4
@alloc_special___print_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@0 = private unnamed_addr constant [13 x i8] c"Hello World!\00", align 1
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 11000, align 4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5.p0.i64(ptr addrspace(5) noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p1.i64(ptr noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: cold convergent nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #3

; Function Attrs: memory(none)
declare { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter() local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #5

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(1) noalias nocapture readonly, i64, i1 immarg) #0

;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
define amdgpu_kernel void @_Z6kernel() local_unnamed_addr #6 !dbg !9 {
conversion:
  br label %top

top:                                              ; preds = %conversion
  %0 = alloca { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr }, align 8, addrspace(5)
  %pointerref = alloca [3 x i64], align 8, addrspace(5)
  %1 = alloca { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr }, align 8, addrspace(5)
  %2 = alloca { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr }, align 8, addrspace(5)
  %3 = alloca { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr }, align 8, addrspace(5)
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %4 = addrspacecast ptr inttoptr (i64 128273636453072 to ptr) to ptr addrspace(10), !dbg !13
      %5 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !13
      %state.i = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter(), !dbg !13
      store { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state.i, ptr addrspace(5) %0, align 8, !dbg !13
; ││└└
; ││┌ @ Base_compiler.jl:54 within `getproperty`
     %.output_context_ptr = getelementptr inbounds i8, ptr addrspace(5) %0, i32 72, !dbg !28
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %bitcast = load ptr, ptr addrspace(5) %.output_context_ptr, align 8, !dbg !31, !tbaa !34, !alias.scope !38, !noalias !41
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:73 within `output_context`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54 within `alloc_local` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %6 = addrspacecast ptr inttoptr (i64 128273751635424 to ptr) to ptr addrspace(10), !dbg !46
       %7 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !46
; ││└└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
; ││┌ @ essentials.jl:733 within `reinterpret`
     %bitcast_coercion = ptrtoint ptr %bitcast to i64, !dbg !56
; ││└
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %8 = addrspacecast ptr inttoptr (i64 128273641691280 to ptr) to ptr addrspace(10), !dbg !60
       %9 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !60
       store i64 %bitcast_coercion, ptr addrspace(3) @alloc_special___print_hostcall, align 1, !dbg !60, !tbaa !69
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; │┌ @ pointer.jl:151 within `unsafe_load` @ pointer.jl:151
    %10 = getelementptr inbounds { i64, ptr addrspace(1), i64 }, ptr %bitcast, i64 0, !dbg !72
    call void @llvm.memcpy.p5.p0.i64(ptr addrspace(5) align 8 %pointerref, ptr align 1 %10, i64 24, i1 false), !dbg !72, !tbaa !76, !alias.scope !77, !noalias !78
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %11 = addrspacecast ptr inttoptr (i64 128273701417088 to ptr) to ptr addrspace(10), !dbg !79
         %12 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !79
         %13 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !79, !range !97
; │││││└└
; │││││┌ @ int.jl:863 within `+` @ int.jl:87
        %14 = add i32 %13, 1, !dbg !98
; ││││└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %15 = addrspacecast ptr inttoptr (i64 128273701418576 to ptr) to ptr addrspace(10), !dbg !102
         %16 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !102
         %17 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !102, !range !97
; ││││└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %18 = addrspacecast ptr inttoptr (i64 128273701419072 to ptr) to ptr addrspace(10), !dbg !107
         %19 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !107
         %20 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !107, !range !97
; │││└└└└
; │││┌ @ operators.jl:321 within `!=`
; ││││┌ @ int.jl:524 within `==` @ promotion.jl:487
; │││││┌ @ promotion.jl:404 within `promote`
; ││││││┌ @ promotion.jl:379 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:962 within `UInt64`
; │││││││││┌ @ boot.jl:936 within `toUInt64`
            %21 = zext i32 %14 to i64, !dbg !112
; │││││└└└└└
; │││││ @ int.jl:524 within `==` @ promotion.jl:487 @ promotion.jl:637
       %22 = icmp eq i64 %21, 1, !dbg !132
; │││││ @ int.jl:524 within `==`
; │││││┌ @ bool.jl:40 within `&`
        %23 = and i1 true, %22, !dbg !133
; ││││└└
; ││││┌ @ bool.jl:37 within `!`
       %24 = xor i1 %23, true, !dbg !136
; │││└└
     %25 = xor i1 %24, true, !dbg !89
     br i1 %25, label %L24, label %L23, !dbg !89

L23:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L43, !dbg !138

L24:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; │││┌ @ Base_compiler.jl:54 within `getproperty`
      br label %L25, !dbg !139

L25:                                              ; preds = %L39, %L24
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %pointerref.unbox23 = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !141, !tbaa !34, !alias.scope !38, !noalias !41
       %26 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.unbox23, i64 0, i64 1, i32 4) [ "jl_roots"(ptr addrspace(5) %pointerref) ], !dbg !141
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:637 within `==`
       %27 = icmp eq i64 %26, 0, !dbg !147
; ││││└
      %28 = xor i1 %27, true, !dbg !148
      br i1 %28, label %L29, label %L28, !dbg !148

L28:                                              ; preds = %L25
      br label %L41, !dbg !148

L29:                                              ; preds = %L25
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:637 within `==`
       %29 = icmp eq i64 %26, 5, !dbg !149
; ││││└
      %30 = xor i1 %29, true, !dbg !150
      br i1 %30, label %L32, label %L31, !dbg !150

L31:                                              ; preds = %L29
      br label %L34, !dbg !150

L32:                                              ; preds = %L29
; ││││┌ @ promotion.jl:637 within `==`
       %31 = icmp eq i64 %26, 6, !dbg !149
; ││││└
      %32 = xor i1 %31, true, !dbg !150
      br i1 %32, label %L39, label %L34, !dbg !150

L34:                                              ; preds = %L32, %L31
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %33 = addrspacecast ptr inttoptr (i64 128273636453072 to ptr) to ptr addrspace(10), !dbg !151
          %34 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !151
          %state.i30 = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter(), !dbg !151
          store { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state.i30, ptr addrspace(5) %3, align 8, !dbg !151
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        %.unbox26 = load ptr, ptr addrspace(5) %3, align 8, !dbg !159, !tbaa !34, !alias.scope !38, !noalias !41
        %pointerset_ptr27 = getelementptr inbounds i8, ptr %.unbox26, i64 0, !dbg !159
        call void @llvm.memcpy.p0.p1.i64(ptr align 1 %pointerset_ptr27, ptr addrspace(1) align 4 @_j_const_1, i64 4, i1 false), !dbg !159
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !162
        unreachable, !dbg !162

L39:                                              ; preds = %L32
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !166
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L25, !dbg !169

L41:                                              ; preds = %L28
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L42, !dbg !148

L42:                                              ; preds = %L41
      br label %L43, !dbg !148

L43:                                              ; preds = %L42, %L23
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !170
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !176
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !177
       br label %L47, !dbg !177

L47:                                              ; preds = %L43
       br label %L48, !dbg !177

L48:                                              ; preds = %L47
; │└└└└
; │┌ @ none within `alloc_string`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %35 = addrspacecast ptr inttoptr (i64 128279496943808 to ptr) to ptr addrspace(10), !dbg !179
     %36 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !179
; │└└
; │┌ @ Base_compiler.jl:54 within `getproperty`
    %pointerref.buf_ptr_ptr = getelementptr inbounds i8, ptr addrspace(5) %pointerref, i32 8, !dbg !183
; │└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:147 within `+`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `add_ptr`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %37 = addrspacecast ptr inttoptr (i64 128273671256032 to ptr) to ptr addrspace(10), !dbg !184
      %38 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !184
      %pointerref.buf_ptr_ptr.unbox = load ptr addrspace(1), ptr addrspace(5) %pointerref.buf_ptr_ptr, align 8, !dbg !184, !tbaa !34, !alias.scope !38, !noalias !41
; │└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %39 = addrspacecast ptr inttoptr (i64 128273704892880 to ptr) to ptr addrspace(10), !dbg !191
     %40 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !191
     call void @llvm.memcpy.p1.p1.i64(ptr addrspace(1) %pointerref.buf_ptr_ptr.unbox, ptr addrspace(1) addrspacecast (ptr @0 to ptr addrspace(1)), i64 12, i1 false), !dbg !191
; │└└
; │┌ @ Base_compiler.jl:54 within `getproperty`
    %pointerref.buf_ptr_ptr7 = getelementptr inbounds i8, ptr addrspace(5) %pointerref, i32 8, !dbg !183
; │└
; │┌ @ essentials.jl:733 within `reinterpret`
    %bitcast8 = load ptr addrspace(1), ptr addrspace(5) %pointerref.buf_ptr_ptr7, align 8, !dbg !195, !tbaa !34, !alias.scope !38, !noalias !41
; │└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %41 = addrspacecast ptr inttoptr (i64 128273688438864 to ptr) to ptr addrspace(10), !dbg !196
      %42 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !196
      %43 = getelementptr inbounds i8, ptr addrspace(1) %bitcast8, i64 12, !dbg !196
      store i8 0, ptr addrspace(1) %43, align 1, !dbg !196, !tbaa !201
; │└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %44 = addrspacecast ptr inttoptr (i64 128273701417088 to ptr) to ptr addrspace(10), !dbg !203
         %45 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !203
         %46 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !203, !range !97
; │││││└└
; │││││┌ @ int.jl:863 within `+` @ int.jl:87
        %47 = add i32 %46, 1, !dbg !214
; ││││└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %48 = addrspacecast ptr inttoptr (i64 128273701418576 to ptr) to ptr addrspace(10), !dbg !216
         %49 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !216
         %50 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !216, !range !97
; ││││└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %51 = addrspacecast ptr inttoptr (i64 128273701419072 to ptr) to ptr addrspace(10), !dbg !220
         %52 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !220
         %53 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !220, !range !97
; │││└└└└
; │││┌ @ operators.jl:321 within `!=`
; ││││┌ @ int.jl:524 within `==` @ promotion.jl:487
; │││││┌ @ promotion.jl:404 within `promote`
; ││││││┌ @ promotion.jl:379 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:962 within `UInt64`
; │││││││││┌ @ boot.jl:936 within `toUInt64`
            %54 = zext i32 %47 to i64, !dbg !224
; │││││└└└└└
; │││││ @ int.jl:524 within `==` @ promotion.jl:487 @ promotion.jl:637
       %55 = icmp eq i64 %54, 1, !dbg !232
; │││││ @ int.jl:524 within `==`
; │││││┌ @ bool.jl:40 within `&`
        %56 = and i1 true, %55, !dbg !233
; ││││└└
; ││││┌ @ bool.jl:37 within `!`
       %57 = xor i1 %56, true, !dbg !234
; │││└└
     %58 = xor i1 %57, true, !dbg !208
     br i1 %58, label %L72, label %L71, !dbg !208

L71:                                              ; preds = %L48
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L110, !dbg !235

L72:                                              ; preds = %L48
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ Base_compiler.jl:54 within `getproperty`
      br label %L73, !dbg !236

L73:                                              ; preds = %L87, %L72
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %pointerref.unbox = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !238, !tbaa !34, !alias.scope !38, !noalias !41
       %59 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %pointerref.unbox, i64 1, i64 2, i32 4) [ "jl_roots"(ptr addrspace(5) %pointerref) ], !dbg !238
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:637 within `==`
       %60 = icmp eq i64 %59, 1, !dbg !241
; ││││└
      %61 = xor i1 %60, true, !dbg !242
      br i1 %61, label %L77, label %L76, !dbg !242

L76:                                              ; preds = %L73
      br label %L89, !dbg !242

L77:                                              ; preds = %L73
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
; ││││┌ @ promotion.jl:637 within `==`
       %62 = icmp eq i64 %59, 5, !dbg !243
; ││││└
      %63 = xor i1 %62, true, !dbg !244
      br i1 %63, label %L80, label %L79, !dbg !244

L79:                                              ; preds = %L77
      br label %L82, !dbg !244

L80:                                              ; preds = %L77
; ││││┌ @ promotion.jl:637 within `==`
       %64 = icmp eq i64 %59, 6, !dbg !243
; ││││└
      %65 = xor i1 %64, true, !dbg !244
      br i1 %65, label %L87, label %L82, !dbg !244

L82:                                              ; preds = %L80, %L79
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %66 = addrspacecast ptr inttoptr (i64 128273636453072 to ptr) to ptr addrspace(10), !dbg !245
          %67 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !245
          %state.i29 = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter(), !dbg !245
          store { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state.i29, ptr addrspace(5) %2, align 8, !dbg !245
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        %.unbox21 = load ptr, ptr addrspace(5) %2, align 8, !dbg !251, !tbaa !34, !alias.scope !38, !noalias !41
        %pointerset_ptr22 = getelementptr inbounds i8, ptr %.unbox21, i64 0, !dbg !251
        call void @llvm.memcpy.p0.p1.i64(ptr align 1 %pointerset_ptr22, ptr addrspace(1) align 4 @_j_const_1, i64 4, i1 false), !dbg !251
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !253
        unreachable, !dbg !253

L87:                                              ; preds = %L80
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !255
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L73, !dbg !257

L89:                                              ; preds = %L76
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L90, !dbg !242

L90:                                              ; preds = %L89
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ Base_compiler.jl:54 within `getproperty`
      br label %L91, !dbg !258

L91:                                              ; preds = %L105, %L90
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %pointerref.unbox15 = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !260, !tbaa !34, !alias.scope !38, !noalias !41
       %68 = call fastcc i64 @__ockl_hsa_signal_load(i64 %pointerref.unbox15, i32 2) [ "jl_roots"(ptr addrspace(5) %pointerref) ], !dbg !260
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:637 within `==`
       %69 = icmp eq i64 %68, 4, !dbg !265
; ││││└
      %70 = xor i1 %69, true, !dbg !266
      br i1 %70, label %L95, label %L94, !dbg !266

L94:                                              ; preds = %L91
      br label %L107, !dbg !266

L95:                                              ; preds = %L91
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
; ││││┌ @ promotion.jl:637 within `==`
       %71 = icmp eq i64 %68, 5, !dbg !267
; ││││└
      %72 = xor i1 %71, true, !dbg !268
      br i1 %72, label %L98, label %L97, !dbg !268

L97:                                              ; preds = %L95
      br label %L100, !dbg !268

L98:                                              ; preds = %L95
; ││││┌ @ promotion.jl:637 within `==`
       %73 = icmp eq i64 %68, 6, !dbg !267
; ││││└
      %74 = xor i1 %73, true, !dbg !268
      br i1 %74, label %L105, label %L100, !dbg !268

L100:                                             ; preds = %L98, %L97
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %75 = addrspacecast ptr inttoptr (i64 128273636453072 to ptr) to ptr addrspace(10), !dbg !269
          %76 = addrspacecast ptr inttoptr (i64 128279034028128 to ptr) to ptr addrspace(10), !dbg !269
          %state.i28 = call { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } @julia.gpu.state_getter(), !dbg !269
          store { ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, ptr, ptr, ptr, ptr } %state.i28, ptr addrspace(5) %1, align 8, !dbg !269
; │││││└└└
; │││││┌ @ pointer.jl:178 within `unsafe_store!` @ pointer.jl:178
        %.unbox = load ptr, ptr addrspace(5) %1, align 8, !dbg !275, !tbaa !34, !alias.scope !38, !noalias !41
        %pointerset_ptr = getelementptr inbounds i8, ptr %.unbox, i64 0, !dbg !275
        call void @llvm.memcpy.p0.p1.i64(ptr align 1 %pointerset_ptr, ptr addrspace(1) align 4 @_j_const_1, i64 4, i1 false), !dbg !275
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !277
        unreachable, !dbg !277

L105:                                             ; preds = %L98
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !279
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L91, !dbg !281

L107:                                             ; preds = %L94
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
      br label %L108, !dbg !266

L108:                                             ; preds = %L107
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %pointerref.unbox16 = load i64, ptr addrspace(5) %pointerref, align 8, !dbg !282, !tbaa !34, !alias.scope !38, !noalias !41
      %77 = call i64 @__ockl_hsa_signal_store(i64 %pointerref.unbox16, i64 0, i32 3) [ "jl_roots"(ptr addrspace(5) %pointerref) ], !dbg !282
      br label %L110, !dbg !282

L110:                                             ; preds = %L108, %L71
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !286
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !289
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       fence syncscope("workgroup") seq_cst, !dbg !290
       br label %L114, !dbg !290

L114:                                             ; preds = %L110
       br label %L115, !dbg !290

L115:                                             ; preds = %L114
       ret void, !dbg !290
; └└└└└
}

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.readfirstlane(i32) #7

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #8

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #9 {
  %3 = inttoptr i64 %0 to ptr addrspace(1)
  %4 = getelementptr inbounds %0, ptr addrspace(1) %3, i64 0, i32 1
  switch i32 %1, label %5 [
    i32 1, label %7
    i32 2, label %7
    i32 5, label %9
  ]

5:                                                ; preds = %2
  %6 = load atomic i64, ptr addrspace(1) %4 syncscope("one-as") monotonic, align 8
  br label %11

7:                                                ; preds = %2, %2
  %8 = load atomic i64, ptr addrspace(1) %4 syncscope("one-as") acquire, align 8
  br label %11

9:                                                ; preds = %2
  %10 = load atomic i64, ptr addrspace(1) %4 seq_cst, align 8
  br label %11

11:                                               ; preds = %9, %7, %5
  %12 = phi i64 [ %6, %5 ], [ %10, %9 ], [ %8, %7 ]
  ret i64 %12
}

; Function Attrs: convergent norecurse nounwind
define internal fastcc i64 @__ockl_hsa_signal_cas(i64 %0, i64 noundef %1, i64 noundef %2, i32 noundef %3) unnamed_addr #10 {
  %5 = inttoptr i64 %0 to ptr addrspace(1)
  %6 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 1
  switch i32 %3, label %7 [
    i32 1, label %9
    i32 2, label %9
    i32 3, label %11
    i32 4, label %13
    i32 5, label %15
  ]

7:                                                ; preds = %4
  %8 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") monotonic monotonic, align 8
  br label %17

9:                                                ; preds = %4, %4
  %10 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") acquire monotonic, align 8
  br label %17

11:                                               ; preds = %4
  %12 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") release monotonic, align 8
  br label %17

13:                                               ; preds = %4
  %14 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 syncscope("one-as") acq_rel monotonic, align 8
  br label %17

15:                                               ; preds = %4
  %16 = cmpxchg ptr addrspace(1) %6, i64 %1, i64 %2 seq_cst monotonic, align 8
  br label %17

17:                                               ; preds = %15, %13, %11, %9, %7
  %18 = phi { i64, i1 } [ %8, %7 ], [ %16, %15 ], [ %14, %13 ], [ %12, %11 ], [ %10, %9 ]
  %19 = extractvalue { i64, i1 } %18, 1
  br i1 %19, label %20, label %31

20:                                               ; preds = %17
  %21 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 2
  %22 = load i64, ptr addrspace(1) %21, align 16, !tbaa !292
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to ptr addrspace(1)
  %26 = getelementptr inbounds %0, ptr addrspace(1) %5, i64 0, i32 3
  %27 = load i32, ptr addrspace(1) %26, align 8, !tbaa !298
  %28 = zext i32 %27 to i64
  store atomic i64 %28, ptr addrspace(1) %25 syncscope("one-as") release, align 8
  %29 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %27)
  %30 = and i32 %29, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %30)
  br label %31

31:                                               ; preds = %24, %20, %17
  %32 = extractvalue { i64, i1 } %18, 0
  ret i64 %32
}

; Function Attrs: convergent norecurse nounwind
define internal void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #10 {
  %4 = inttoptr i64 %0 to ptr addrspace(1)
  %5 = load i64, ptr addrspace(1) %4, align 64, !tbaa !299
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %7, label %23

7:                                                ; preds = %3
  %8 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 1
  switch i32 %2, label %9 [
    i32 3, label %10
    i32 5, label %11
  ]

9:                                                ; preds = %7
  store atomic i64 %1, ptr addrspace(1) %8 syncscope("one-as") monotonic, align 8
  br label %12

10:                                               ; preds = %7
  store atomic i64 %1, ptr addrspace(1) %8 syncscope("one-as") release, align 8
  br label %12

11:                                               ; preds = %7
  store atomic i64 %1, ptr addrspace(1) %8 seq_cst, align 8
  br label %12

12:                                               ; preds = %11, %10, %9
  %13 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 2
  %14 = load i64, ptr addrspace(1) %13, align 16, !tbaa !292
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %60, label %16

16:                                               ; preds = %12
  %17 = inttoptr i64 %14 to ptr addrspace(1)
  %18 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 3
  %19 = load i32, ptr addrspace(1) %18, align 8, !tbaa !298
  %20 = zext i32 %19 to i64
  store atomic i64 %20, ptr addrspace(1) %17 syncscope("one-as") release, align 8
  %21 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %19)
  %22 = and i32 %21, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %22)
  br label %60

23:                                               ; preds = %3
  %24 = load i32, ptr addrspace(4) @__oclc_ISA_version, align 4, !tbaa !300
  %25 = icmp sgt i32 %24, 8999
  br i1 %25, label %26, label %29

26:                                               ; preds = %23
  %27 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 1
  %28 = load ptr addrspace(1), ptr addrspace(1) %27, align 8, !tbaa !301
  store atomic i64 %1, ptr addrspace(1) %28 syncscope("one-as") release, align 8
  br label %60

29:                                               ; preds = %23
  %30 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 7
  %31 = load ptr addrspace(1), ptr addrspace(1) %30, align 16, !tbaa !301
  %32 = getelementptr inbounds %3, ptr addrspace(1) %31, i64 0, i32 8
  %33 = cmpxchg ptr addrspace(1) %32, i32 0, i32 1 syncscope("one-as") acquire monotonic, align 4
  %34 = extractvalue { i32, i1 } %33, 1
  br i1 %34, label %38, label %35

35:                                               ; preds = %35, %29
  tail call void @llvm.amdgcn.s.sleep(i32 1)
  %36 = cmpxchg ptr addrspace(1) %32, i32 0, i32 1 syncscope("one-as") acquire monotonic, align 4
  %37 = extractvalue { i32, i1 } %36, 1
  br i1 %37, label %38, label %35

38:                                               ; preds = %35, %29
  %39 = add nsw i64 %1, 1
  %40 = getelementptr inbounds %3, ptr addrspace(1) %31, i64 0, i32 7
  %41 = load volatile i64, ptr addrspace(1) %40, align 16, !tbaa !302
  %42 = icmp ugt i64 %39, %41
  br i1 %42, label %43, label %59

43:                                               ; preds = %38
  store atomic i64 %39, ptr addrspace(1) %40 syncscope("one-as") monotonic, align 16
  %44 = icmp slt i32 %24, 8000
  br i1 %44, label %45, label %54

45:                                               ; preds = %43
  %46 = trunc i64 %39 to i32
  %47 = getelementptr inbounds %4, ptr addrspace(1) %31, i64 0, i32 4
  %48 = load i32, ptr addrspace(1) %47, align 8, !tbaa !307
  %49 = shl i32 %48, 1
  %50 = add i32 %49, 268435455
  %51 = and i32 %50, %46
  %52 = shl i32 %51, 4
  %53 = zext i32 %52 to i64
  br label %54

54:                                               ; preds = %45, %43
  %55 = phi i64 [ %53, %45 ], [ %39, %43 ]
  %56 = trunc i64 %55 to i32
  %57 = getelementptr inbounds %0, ptr addrspace(1) %4, i64 0, i32 1
  %58 = load ptr addrspace(1), ptr addrspace(1) %57, align 8, !tbaa !301
  store volatile i32 %56, ptr addrspace(1) %58, align 4, !tbaa !300
  br label %59

59:                                               ; preds = %54, %38
  store atomic i32 0, ptr addrspace(1) %32 syncscope("one-as") release, align 4
  br label %60

60:                                               ; preds = %59, %26, %16, %12
  ret void
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { convergent nocallback nofree nounwind willreturn }
attributes #2 = { cold convergent nocallback nofree noreturn nounwind }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { memory(none) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #7 = { alwaysinline convergent nocallback nofree nounwind willreturn memory(none) }
attributes #8 = { alwaysinline nounwind }
attributes #9 = { mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none) "denormal-fp-math"="dynamic,dynamic" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { convergent norecurse nounwind "denormal-fp-math"="dynamic,dynamic" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4}
!opencl.ocl.version = !{!6, !6, !6, !6, !6, !6, !6, !6, !6}
!llvm.ident = !{!7, !7, !7, !7, !7, !7, !7, !7, !7}
!julia.kernel = !{!8}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 0}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "julia", directory: ".")
!6 = !{i32 2, i32 0}
!7 = !{!"clang version 18.1.8 (Fedora 18.1.8-5.fc41)"}
!8 = !{ptr @_Z6kernel}
!9 = distinct !DISubprogram(name: "kernel", linkageName: "julia_kernel_11301", scope: null, file: !10, line: 3, type: !11, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!10 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!11 = !DISubroutineType(types: !12)
!12 = !{}
!13 = !DILocation(line: 39, scope: !14, inlinedAt: !16)
!14 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !15, file: !15, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!15 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!16 = !DILocation(line: 0, scope: !17, inlinedAt: !19)
!17 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!18 = !DIFile(filename: "none", directory: ".")
!19 = !DILocation(line: 0, scope: !20, inlinedAt: !21)
!20 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!21 = !DILocation(line: 71, scope: !22, inlinedAt: !24)
!22 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!23 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!24 = !DILocation(line: 69, scope: !25, inlinedAt: !27)
!25 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !26, file: !26, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!26 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!27 = !DILocation(line: 3, scope: !9)
!28 = !DILocation(line: 54, scope: !29, inlinedAt: !21)
!29 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !30, file: !30, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!30 = !DIFile(filename: "Base_compiler.jl", directory: ".")
!31 = !DILocation(line: 30, scope: !32, inlinedAt: !21)
!32 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!33 = !DIFile(filename: "pointer.jl", directory: ".")
!34 = !{!35, !35, i64 0}
!35 = !{!"jtbaa_stack", !36, i64 0}
!36 = !{!"jtbaa", !37, i64 0}
!37 = !{!"jtbaa"}
!38 = !{!39}
!39 = !{!"jnoalias_stack", !40}
!40 = !{!"jnoalias"}
!41 = !{!42, !43, !44, !45}
!42 = !{!"jnoalias_gcframe", !40}
!43 = !{!"jnoalias_data", !40}
!44 = !{!"jnoalias_typemd", !40}
!45 = !{!"jnoalias_const", !40}
!46 = !DILocation(line: 39, scope: !14, inlinedAt: !47)
!47 = !DILocation(line: 2, scope: !48, inlinedAt: !50)
!48 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!49 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!50 = !DILocation(line: 2, scope: !51, inlinedAt: !52)
!51 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!52 = !DILocation(line: 54, scope: !53, inlinedAt: !54)
!53 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!54 = !DILocation(line: 54, scope: !53, inlinedAt: !55)
!55 = !DILocation(line: 73, scope: !22, inlinedAt: !24)
!56 = !DILocation(line: 733, scope: !57, inlinedAt: !59)
!57 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !58, file: !58, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!58 = !DIFile(filename: "essentials.jl", directory: ".")
!59 = !DILocation(line: 74, scope: !22, inlinedAt: !24)
!60 = !DILocation(line: 39, scope: !14, inlinedAt: !61)
!61 = !DILocation(line: 0, scope: !17, inlinedAt: !62)
!62 = !DILocation(line: 0, scope: !63, inlinedAt: !64)
!63 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!64 = !DILocation(line: 88, scope: !65, inlinedAt: !67)
!65 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!66 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!67 = !DILocation(line: 88, scope: !65, inlinedAt: !68)
!68 = !DILocation(line: 88, scope: !65, inlinedAt: !59)
!69 = !{!70, !70, i64 0, i64 0}
!70 = !{!"custom_tbaa_addrspace(3)", !71, i64 0}
!71 = !{!"custom_tbaa"}
!72 = !DILocation(line: 151, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!74 = !DILocation(line: 151, scope: !73, inlinedAt: !75)
!75 = !DILocation(line: 70, scope: !25, inlinedAt: !27)
!76 = !{!36, !36, i64 0}
!77 = !{!43, !39}
!78 = !{!42, !44, !45}
!79 = !DILocation(line: 39, scope: !14, inlinedAt: !80)
!80 = !DILocation(line: 3, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!82 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!83 = !DILocation(line: 3, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!85 = !DILocation(line: 87, scope: !86, inlinedAt: !87)
!86 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!87 = !DILocation(line: 122, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!89 = !DILocation(line: 30, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!91 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!92 = !DILocation(line: 0, scope: !17, inlinedAt: !93)
!93 = !DILocation(line: 0, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!95 = !DILocation(line: 53, scope: !96, inlinedAt: !75)
!96 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!97 = !{i32 0, i32 1023}
!98 = !DILocation(line: 87, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !100, file: !100, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!100 = !DIFile(filename: "int.jl", directory: ".")
!101 = !DILocation(line: 863, scope: !99, inlinedAt: !85)
!102 = !DILocation(line: 39, scope: !14, inlinedAt: !103)
!103 = !DILocation(line: 3, scope: !81, inlinedAt: !104)
!104 = !DILocation(line: 3, scope: !84, inlinedAt: !105)
!105 = !DILocation(line: 87, scope: !106, inlinedAt: !87)
!106 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!107 = !DILocation(line: 39, scope: !14, inlinedAt: !108)
!108 = !DILocation(line: 3, scope: !81, inlinedAt: !109)
!109 = !DILocation(line: 3, scope: !84, inlinedAt: !110)
!110 = !DILocation(line: 87, scope: !111, inlinedAt: !87)
!111 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!112 = !DILocation(line: 936, scope: !113, inlinedAt: !115)
!113 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !114, file: !114, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!114 = !DIFile(filename: "boot.jl", directory: ".")
!115 = !DILocation(line: 962, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !114, file: !114, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!117 = !DILocation(line: 7, scope: !118, inlinedAt: !120)
!118 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !119, file: !119, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!119 = !DIFile(filename: "number.jl", directory: ".")
!120 = !DILocation(line: 379, scope: !121, inlinedAt: !123)
!121 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!122 = !DIFile(filename: "promotion.jl", directory: ".")
!123 = !DILocation(line: 404, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!125 = !DILocation(line: 487, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!127 = !DILocation(line: 524, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !100, file: !100, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!129 = !DILocation(line: 321, scope: !130, inlinedAt: !89)
!130 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !131, file: !131, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!131 = !DIFile(filename: "operators.jl", directory: ".")
!132 = !DILocation(line: 637, scope: !126, inlinedAt: !125)
!133 = !DILocation(line: 40, scope: !134, inlinedAt: !127)
!134 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !135, file: !135, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!135 = !DIFile(filename: "bool.jl", directory: ".")
!136 = !DILocation(line: 37, scope: !137, inlinedAt: !129)
!137 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !135, file: !135, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!138 = !DILocation(line: 31, scope: !90, inlinedAt: !92)
!139 = !DILocation(line: 54, scope: !29, inlinedAt: !140)
!140 = !DILocation(line: 62, scope: !90, inlinedAt: !92)
!141 = !DILocation(line: 27, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!143 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!144 = !DILocation(line: 37, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!146 = !DILocation(line: 36, scope: !145, inlinedAt: !140)
!147 = !DILocation(line: 637, scope: !126, inlinedAt: !148)
!148 = !DILocation(line: 38, scope: !145, inlinedAt: !146)
!149 = !DILocation(line: 637, scope: !126, inlinedAt: !150)
!150 = !DILocation(line: 40, scope: !145, inlinedAt: !146)
!151 = !DILocation(line: 39, scope: !14, inlinedAt: !152)
!152 = !DILocation(line: 0, scope: !17, inlinedAt: !153)
!153 = !DILocation(line: 0, scope: !20, inlinedAt: !154)
!154 = !DILocation(line: 11, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!156 = !DILocation(line: 113, scope: !157, inlinedAt: !158)
!157 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!158 = !DILocation(line: 41, scope: !145, inlinedAt: !146)
!159 = !DILocation(line: 178, scope: !160, inlinedAt: !161)
!160 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!161 = !DILocation(line: 178, scope: !160, inlinedAt: !156)
!162 = !DILocation(line: 6, scope: !163, inlinedAt: !165)
!163 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !164, file: !164, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!164 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!165 = !DILocation(line: 115, scope: !157, inlinedAt: !158)
!166 = !DILocation(line: 108, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!168 = !DILocation(line: 46, scope: !145, inlinedAt: !146)
!169 = !DILocation(line: 47, scope: !145, inlinedAt: !146)
!170 = !DILocation(line: 5, scope: !171, inlinedAt: !173)
!171 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !172, file: !172, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!172 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!173 = !DILocation(line: 27, scope: !174, inlinedAt: !175)
!174 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !172, file: !172, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!175 = !DILocation(line: 47, scope: !90, inlinedAt: !92)
!176 = !DILocation(line: 28, scope: !174, inlinedAt: !175)
!177 = !DILocation(line: 5, scope: !171, inlinedAt: !178)
!178 = !DILocation(line: 29, scope: !174, inlinedAt: !175)
!179 = !DILocation(line: 39, scope: !14, inlinedAt: !180)
!180 = !DILocation(line: 0, scope: !17, inlinedAt: !181)
!181 = !DILocation(line: 0, scope: !182, inlinedAt: !75)
!182 = distinct !DISubprogram(name: "alloc_string;", linkageName: "alloc_string", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!183 = !DILocation(line: 54, scope: !29, inlinedAt: !75)
!184 = !DILocation(line: 39, scope: !14, inlinedAt: !185)
!185 = !DILocation(line: 114, scope: !186, inlinedAt: !187)
!186 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!187 = !DILocation(line: 114, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "add_ptr;", linkageName: "add_ptr", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!189 = !DILocation(line: 147, scope: !190, inlinedAt: !75)
!190 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!191 = !DILocation(line: 39, scope: !14, inlinedAt: !192)
!192 = !DILocation(line: 0, scope: !17, inlinedAt: !193)
!193 = !DILocation(line: 0, scope: !194, inlinedAt: !75)
!194 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!195 = !DILocation(line: 733, scope: !57, inlinedAt: !75)
!196 = !DILocation(line: 39, scope: !14, inlinedAt: !197)
!197 = !DILocation(line: 0, scope: !17, inlinedAt: !198)
!198 = !DILocation(line: 0, scope: !63, inlinedAt: !199)
!199 = !DILocation(line: 88, scope: !65, inlinedAt: !200)
!200 = !DILocation(line: 88, scope: !65, inlinedAt: !75)
!201 = !{!202, !202, i64 0, i64 0}
!202 = !{!"custom_tbaa_addrspace(1)", !71, i64 0}
!203 = !DILocation(line: 39, scope: !14, inlinedAt: !204)
!204 = !DILocation(line: 3, scope: !81, inlinedAt: !205)
!205 = !DILocation(line: 3, scope: !84, inlinedAt: !206)
!206 = !DILocation(line: 87, scope: !86, inlinedAt: !207)
!207 = !DILocation(line: 122, scope: !88, inlinedAt: !208)
!208 = !DILocation(line: 30, scope: !90, inlinedAt: !209)
!209 = !DILocation(line: 0, scope: !17, inlinedAt: !210)
!210 = !DILocation(line: 0, scope: !211, inlinedAt: !212)
!211 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!212 = !DILocation(line: 97, scope: !213, inlinedAt: !75)
!213 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!214 = !DILocation(line: 87, scope: !99, inlinedAt: !215)
!215 = !DILocation(line: 863, scope: !99, inlinedAt: !206)
!216 = !DILocation(line: 39, scope: !14, inlinedAt: !217)
!217 = !DILocation(line: 3, scope: !81, inlinedAt: !218)
!218 = !DILocation(line: 3, scope: !84, inlinedAt: !219)
!219 = !DILocation(line: 87, scope: !106, inlinedAt: !207)
!220 = !DILocation(line: 39, scope: !14, inlinedAt: !221)
!221 = !DILocation(line: 3, scope: !81, inlinedAt: !222)
!222 = !DILocation(line: 3, scope: !84, inlinedAt: !223)
!223 = !DILocation(line: 87, scope: !111, inlinedAt: !207)
!224 = !DILocation(line: 936, scope: !113, inlinedAt: !225)
!225 = !DILocation(line: 962, scope: !116, inlinedAt: !226)
!226 = !DILocation(line: 7, scope: !118, inlinedAt: !227)
!227 = !DILocation(line: 379, scope: !121, inlinedAt: !228)
!228 = !DILocation(line: 404, scope: !124, inlinedAt: !229)
!229 = !DILocation(line: 487, scope: !126, inlinedAt: !230)
!230 = !DILocation(line: 524, scope: !128, inlinedAt: !231)
!231 = !DILocation(line: 321, scope: !130, inlinedAt: !208)
!232 = !DILocation(line: 637, scope: !126, inlinedAt: !229)
!233 = !DILocation(line: 40, scope: !134, inlinedAt: !230)
!234 = !DILocation(line: 37, scope: !137, inlinedAt: !231)
!235 = !DILocation(line: 31, scope: !90, inlinedAt: !209)
!236 = !DILocation(line: 54, scope: !29, inlinedAt: !237)
!237 = !DILocation(line: 113, scope: !90, inlinedAt: !209)
!238 = !DILocation(line: 27, scope: !142, inlinedAt: !239)
!239 = !DILocation(line: 37, scope: !145, inlinedAt: !240)
!240 = !DILocation(line: 36, scope: !145, inlinedAt: !237)
!241 = !DILocation(line: 637, scope: !126, inlinedAt: !242)
!242 = !DILocation(line: 38, scope: !145, inlinedAt: !240)
!243 = !DILocation(line: 637, scope: !126, inlinedAt: !244)
!244 = !DILocation(line: 40, scope: !145, inlinedAt: !240)
!245 = !DILocation(line: 39, scope: !14, inlinedAt: !246)
!246 = !DILocation(line: 0, scope: !17, inlinedAt: !247)
!247 = !DILocation(line: 0, scope: !20, inlinedAt: !248)
!248 = !DILocation(line: 11, scope: !155, inlinedAt: !249)
!249 = !DILocation(line: 113, scope: !157, inlinedAt: !250)
!250 = !DILocation(line: 41, scope: !145, inlinedAt: !240)
!251 = !DILocation(line: 178, scope: !160, inlinedAt: !252)
!252 = !DILocation(line: 178, scope: !160, inlinedAt: !249)
!253 = !DILocation(line: 6, scope: !163, inlinedAt: !254)
!254 = !DILocation(line: 115, scope: !157, inlinedAt: !250)
!255 = !DILocation(line: 108, scope: !167, inlinedAt: !256)
!256 = !DILocation(line: 46, scope: !145, inlinedAt: !240)
!257 = !DILocation(line: 47, scope: !145, inlinedAt: !240)
!258 = !DILocation(line: 54, scope: !29, inlinedAt: !259)
!259 = !DILocation(line: 116, scope: !90, inlinedAt: !209)
!260 = !DILocation(line: 12, scope: !261, inlinedAt: !262)
!261 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!262 = !DILocation(line: 61, scope: !263, inlinedAt: !264)
!263 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!264 = !DILocation(line: 60, scope: !263, inlinedAt: !259)
!265 = !DILocation(line: 637, scope: !126, inlinedAt: !266)
!266 = !DILocation(line: 62, scope: !263, inlinedAt: !264)
!267 = !DILocation(line: 637, scope: !126, inlinedAt: !268)
!268 = !DILocation(line: 64, scope: !263, inlinedAt: !264)
!269 = !DILocation(line: 39, scope: !14, inlinedAt: !270)
!270 = !DILocation(line: 0, scope: !17, inlinedAt: !271)
!271 = !DILocation(line: 0, scope: !20, inlinedAt: !272)
!272 = !DILocation(line: 11, scope: !155, inlinedAt: !273)
!273 = !DILocation(line: 113, scope: !157, inlinedAt: !274)
!274 = !DILocation(line: 65, scope: !263, inlinedAt: !264)
!275 = !DILocation(line: 178, scope: !160, inlinedAt: !276)
!276 = !DILocation(line: 178, scope: !160, inlinedAt: !273)
!277 = !DILocation(line: 6, scope: !163, inlinedAt: !278)
!278 = !DILocation(line: 115, scope: !157, inlinedAt: !274)
!279 = !DILocation(line: 108, scope: !167, inlinedAt: !280)
!280 = !DILocation(line: 70, scope: !263, inlinedAt: !264)
!281 = !DILocation(line: 71, scope: !263, inlinedAt: !264)
!282 = !DILocation(line: 19, scope: !283, inlinedAt: !284)
!283 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!284 = !DILocation(line: 19, scope: !283, inlinedAt: !285)
!285 = !DILocation(line: 128, scope: !90, inlinedAt: !209)
!286 = !DILocation(line: 5, scope: !171, inlinedAt: !287)
!287 = !DILocation(line: 27, scope: !174, inlinedAt: !288)
!288 = !DILocation(line: 47, scope: !90, inlinedAt: !209)
!289 = !DILocation(line: 28, scope: !174, inlinedAt: !288)
!290 = !DILocation(line: 5, scope: !171, inlinedAt: !291)
!291 = !DILocation(line: 29, scope: !174, inlinedAt: !288)
!292 = !{!293, !294, i64 16}
!293 = !{!"amd_signal_s", !294, i64 0, !295, i64 8, !294, i64 16, !297, i64 24, !297, i64 28, !294, i64 32, !294, i64 40, !295, i64 48, !295, i64 56}
!294 = !{!"long", !295, i64 0}
!295 = !{!"omnipotent char", !296, i64 0}
!296 = !{!"Simple C/C++ TBAA"}
!297 = !{!"int", !295, i64 0}
!298 = !{!293, !297, i64 24}
!299 = !{!293, !294, i64 0}
!300 = !{!297, !297, i64 0}
!301 = !{!295, !295, i64 0}
!302 = !{!303, !294, i64 80}
!303 = !{!"amd_queue_s", !304, i64 0, !295, i64 40, !294, i64 56, !297, i64 64, !297, i64 68, !297, i64 72, !297, i64 76, !294, i64 80, !297, i64 88, !295, i64 92, !294, i64 128, !297, i64 136, !297, i64 140, !295, i64 144, !294, i64 160, !294, i64 168, !297, i64 176, !297, i64 180, !295, i64 184, !306, i64 192, !295, i64 200}
!304 = !{!"hsa_queue_s", !297, i64 0, !297, i64 4, !305, i64 8, !306, i64 16, !297, i64 24, !297, i64 28, !294, i64 32}
!305 = !{!"any pointer", !295, i64 0}
!306 = !{!"hsa_signal_s", !294, i64 0}
!307 = !{!303, !297, i64 24}
