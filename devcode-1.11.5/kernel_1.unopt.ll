; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i64, %1, i64, i32, i32, i64, i64, %2, [2 x i32] }
%1 = type { i64 }
%2 = type { %3 addrspace(1)* }
%3 = type { %4, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %1, [14 x i32] }
%4 = type { i32, i32, i8 addrspace(1)*, %1, i32, i32, i64 }

@_j_const_1 = private unnamed_addr addrspace(1) constant i32 1, align 4
@alloc_special___print_hostcall = external local_unnamed_addr addrspace(3) global [1 x i64], align 32
@0 = private unnamed_addr constant [13 x i8] c"Hello World!\00", align 1
@__oclc_ISA_version = internal unnamed_addr addrspace(4) constant i32 11000, align 4

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #1

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #3

; Function Attrs: memory(none)
declare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #5

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* noalias nocapture writeonly, i8 addrspace(1)* noalias nocapture readonly, i64, i1 immarg) #0

;  @ /home/pxlth/.julia/dev/AMDGPU/t.jl:3 within `kernel`
define amdgpu_kernel void @_Z6kernel() local_unnamed_addr #6 !dbg !9 {
conversion:
  br label %top

top:                                              ; preds = %conversion
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %1 = alloca { i64, i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %3 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %4 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:69 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:71 within `output_context`
; ││┌ @ none within `kernel_state`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %7 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !13
      %8 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %7, i64 0, !dbg !13
      %9 = addrspacecast {}* inttoptr (i64 139904877752720 to {}*) to {} addrspace(10)*, !dbg !13
      %10 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %9, 0, !dbg !13
      %11 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !13
      %12 = insertvalue [2 x {} addrspace(10)*] %10, {} addrspace(10)* %11, 1, !dbg !13
      %13 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !13
      %14 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %13, i64 0, !dbg !13
      %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !13
      store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8, !dbg !13
; ││└└
; ││┌ @ Base.jl:49 within `getproperty`
     %15 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !28
     %16 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %15, i64 0, !dbg !28
     %17 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 10, !dbg !28
; ││└
; ││┌ @ pointer.jl:30 within `convert`
     %18 = bitcast {}* inttoptr (i64 139913249483504 to {}*) to {} addrspace(10)**, !dbg !31
     %19 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %18, i64 0, !dbg !31
     %20 = load i64, i64 addrspace(5)* %17, align 8, !dbg !31, !tbaa !34, !alias.scope !38, !noalias !41
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:73 within `output_context`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54 within `alloc_local` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:54
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %21 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !46
       %22 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %21, i64 0, !dbg !46
       %23 = addrspacecast {}* inttoptr (i64 139904906339728 to {}*) to {} addrspace(10)*, !dbg !46
       %24 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %23, 0, !dbg !46
       %25 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !46
       %26 = insertvalue [2 x {} addrspace(10)*] %24, {} addrspace(10)* %25, 1, !dbg !46
       %27 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !46
       %28 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %27, i64 0, !dbg !46
; ││└└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:74 within `output_context`
; ││┌ @ essentials.jl:730 within `reinterpret`
     %29 = bitcast {}* inttoptr (i64 139913249483504 to {}*) to {} addrspace(10)**, !dbg !56
     %30 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %29, i64 0, !dbg !56
; ││└
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %31 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !60
       %32 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %31, i64 0, !dbg !60
       %33 = addrspacecast {}* inttoptr (i64 139913360154384 to {}*) to {} addrspace(10)*, !dbg !60
       %34 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %33, 0, !dbg !60
       %35 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !60
       %36 = insertvalue [2 x {} addrspace(10)*] %34, {} addrspace(10)* %35, 1, !dbg !60
       %37 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !60
       %38 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %37, i64 0, !dbg !60
       store i64 %20, i64 addrspace(3)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(3)* @alloc_special___print_hostcall, i32 0, i32 0), align 1, !dbg !60, !tbaa !69
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl:70 within `macro expansion`
; │┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
    %39 = bitcast {}* inttoptr (i64 139913257757504 to {}*) to {} addrspace(10)**, !dbg !72
    %40 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %39, i64 0, !dbg !72
    %41 = inttoptr i64 %20 to { i64, i8 addrspace(1)*, i64 }*, !dbg !72
    %42 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 }* %41, i64 0, !dbg !72
    %43 = bitcast { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1 to i8 addrspace(5)*, !dbg !72
    %44 = bitcast { i64, i8 addrspace(1)*, i64 }* %42 to i8*, !dbg !72
    call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 8 %43, i8* align 1 %44, i64 24, i1 false), !dbg !72, !tbaa !76, !alias.scope !77, !noalias !78
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:53 within `hostcall_device_lock!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %45 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !79
         %46 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %45, i64 0, !dbg !79
         %47 = addrspacecast {}* inttoptr (i64 139913404229328 to {}*) to {} addrspace(10)*, !dbg !79
         %48 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %47, 0, !dbg !79
         %49 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !79
         %50 = insertvalue [2 x {} addrspace(10)*] %48, {} addrspace(10)* %49, 1, !dbg !79
         %51 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !79
         %52 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %51, i64 0, !dbg !79
         %53 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !79, !range !97
; │││││└└
; │││││┌ @ int.jl:1013 within `+` @ int.jl:87
        %54 = bitcast {}* inttoptr (i64 139913257763552 to {}*) to {} addrspace(10)**, !dbg !98
        %55 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %54, i64 0, !dbg !98
        %56 = add i32 %53, 1, !dbg !98
; ││││└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %57 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !102
         %58 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %57, i64 0, !dbg !102
         %59 = addrspacecast {}* inttoptr (i64 139913404231808 to {}*) to {} addrspace(10)*, !dbg !102
         %60 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %59, 0, !dbg !102
         %61 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !102
         %62 = insertvalue [2 x {} addrspace(10)*] %60, {} addrspace(10)* %61, 1, !dbg !102
         %63 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !102
         %64 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %63, i64 0, !dbg !102
         %65 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !102, !range !97
; ││││└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %66 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !107
         %67 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %66, i64 0, !dbg !107
         %68 = addrspacecast {}* inttoptr (i64 139913404232304 to {}*) to {} addrspace(10)*, !dbg !107
         %69 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %68, 0, !dbg !107
         %70 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !107
         %71 = insertvalue [2 x {} addrspace(10)*] %69, {} addrspace(10)* %70, 1, !dbg !107
         %72 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !107
         %73 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %72, i64 0, !dbg !107
         %74 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !107, !range !97
; │││└└└└
; │││┌ @ operators.jl:277 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:483
; │││││┌ @ promotion.jl:400 within `promote`
; ││││││┌ @ promotion.jl:375 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:897 within `UInt64`
; │││││││││┌ @ boot.jl:871 within `toUInt64`
            %75 = bitcast {}* inttoptr (i64 139913257759184 to {}*) to {} addrspace(10)**, !dbg !112
            %76 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %75, i64 0, !dbg !112
            %77 = bitcast {}* inttoptr (i64 139913214436992 to {}*) to {} addrspace(10)**, !dbg !112
            %78 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %77, i64 0, !dbg !112
            %79 = zext i32 %56 to i64, !dbg !112
; │││││└└└└└
; │││││ @ int.jl:518 within `==` @ promotion.jl:483 @ promotion.jl:639
       %80 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !132
       %81 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %80, i64 0, !dbg !132
       %82 = icmp eq i64 %79, 1, !dbg !132
; │││││ @ int.jl:518 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %83 = bitcast {}* inttoptr (i64 139913257760528 to {}*) to {} addrspace(10)**, !dbg !133
        %84 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %83, i64 0, !dbg !133
        %85 = and i1 true, %82, !dbg !133
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %86 = bitcast {}* inttoptr (i64 139913257760192 to {}*) to {} addrspace(10)**, !dbg !136
       %87 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %86, i64 0, !dbg !136
       %88 = xor i1 %85, true, !dbg !136
; │││└└
     %89 = xor i1 %88, true, !dbg !89
     br i1 %89, label %L24, label %L23, !dbg !89

L23:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L46, !dbg !138

L24:                                              ; preds = %top
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:62
; │││┌ @ Base.jl:49 within `getproperty`
      %90 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !139
      %91 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %90, i64 0, !dbg !139
      %92 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !139
; │││└
     %93 = bitcast {}* inttoptr (i64 139909482422000 to {}*) to {} addrspace(10)**, !dbg !140
     %94 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %93, i64 0, !dbg !140
     br label %L26, !dbg !140

L26:                                              ; preds = %L42, %L24
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %95 = load i64, i64 addrspace(5)* %92, align 8, !dbg !141, !tbaa !34, !alias.scope !38, !noalias !41
       %96 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %95, i64 0, i64 1, i32 4), !dbg !141
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:639 within `==`
       %97 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !147
       %98 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %97, i64 0, !dbg !147
       %99 = icmp eq i64 %96, 0, !dbg !147
; ││││└
      %100 = xor i1 %99, true, !dbg !148
      br i1 %100, label %L30, label %L29, !dbg !148

L29:                                              ; preds = %L26
      br label %L44, !dbg !148

L30:                                              ; preds = %L26
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
      %101 = bitcast {}* inttoptr (i64 139909482421520 to {}*) to {} addrspace(10)**, !dbg !149
      %102 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %101, i64 0, !dbg !149
; ││││┌ @ promotion.jl:639 within `==`
       %103 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !150
       %104 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %103, i64 0, !dbg !150
       %105 = icmp eq i64 %96, 5, !dbg !150
; ││││└
      %106 = xor i1 %105, true, !dbg !149
      br i1 %106, label %L34, label %L33, !dbg !149

L33:                                              ; preds = %L30
      br label %L37, !dbg !149

L34:                                              ; preds = %L30
      %107 = bitcast {}* inttoptr (i64 139909482421424 to {}*) to {} addrspace(10)**, !dbg !149
      %108 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %107, i64 0, !dbg !149
; ││││┌ @ promotion.jl:639 within `==`
       %109 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !150
       %110 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %109, i64 0, !dbg !150
       %111 = icmp eq i64 %96, 6, !dbg !150
; ││││└
      %112 = xor i1 %111, true, !dbg !149
      br i1 %112, label %L42, label %L37, !dbg !149

L37:                                              ; preds = %L34, %L33
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %113 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !151
          %114 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %113, i64 0, !dbg !151
          %115 = addrspacecast {}* inttoptr (i64 139904877752720 to {}*) to {} addrspace(10)*, !dbg !151
          %116 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %115, 0, !dbg !151
          %117 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !151
          %118 = insertvalue [2 x {} addrspace(10)*] %116, {} addrspace(10)* %117, 1, !dbg !151
          %119 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !151
          %120 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %119, i64 0, !dbg !151
          %state.i3 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !151
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i3, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, align 8, !dbg !151
; ││││││└└
; ││││││┌ @ Base.jl:49 within `getproperty`
         %121 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !159
         %122 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %121, i64 0, !dbg !159
         %123 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %4, i32 0, i32 0, !dbg !159
; │││││└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %124 = bitcast {}* inttoptr (i64 139913257757392 to {}*) to {} addrspace(10)**, !dbg !160
        %125 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %124, i64 0, !dbg !160
        %126 = bitcast i64 addrspace(5)* %123 to i8* addrspace(5)*, !dbg !160
        %127 = load i8*, i8* addrspace(5)* %126, align 8, !dbg !160, !tbaa !34, !alias.scope !38, !noalias !41
        %128 = getelementptr inbounds i8, i8* %127, i64 0, !dbg !160
        %129 = bitcast i8* %128 to i32*, !dbg !160
        %130 = load i32, i32 addrspace(1)* @_j_const_1, align 4, !dbg !160, !tbaa !163, !alias.scope !167, !noalias !168
        store i32 %130, i32* %129, align 1, !dbg !160
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !169
        unreachable, !dbg !169

L42:                                              ; preds = %L34
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !173
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L26, !dbg !176

L44:                                              ; preds = %L29
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L45, !dbg !148

L45:                                              ; preds = %L44
      br label %L46, !dbg !148

L46:                                              ; preds = %L45, %L23
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       %131 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !177
       %132 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %131, i64 0, !dbg !177
       fence syncscope("workgroup") seq_cst, !dbg !177
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !183
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       %133 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !184
       %134 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %133, i64 0, !dbg !184
       fence syncscope("workgroup") seq_cst, !dbg !184
; │││└└
; │││ @ none within `macro expansion`
     br label %L50, !dbg !92

L50:                                              ; preds = %L46
     br label %L51, !dbg !92

L51:                                              ; preds = %L50
; │└└
; │┌ @ none within `alloc_string`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %135 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !186
     %136 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %135, i64 0, !dbg !186
     %137 = addrspacecast {}* inttoptr (i64 139904906344528 to {}*) to {} addrspace(10)*, !dbg !186
     %138 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %137, 0, !dbg !186
     %139 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !186
     %140 = insertvalue [2 x {} addrspace(10)*] %138, {} addrspace(10)* %139, 1, !dbg !186
     %141 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !186
     %142 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %141, i64 0, !dbg !186
; │└└
; │┌ @ Base.jl:49 within `getproperty`
    %143 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !190
    %144 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %143, i64 0, !dbg !190
    %145 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !190
; │└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:147 within `+`
; ││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `add_ptr`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:114 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %146 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !191
      %147 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %146, i64 0, !dbg !191
      %148 = addrspacecast {}* inttoptr (i64 139913356713408 to {}*) to {} addrspace(10)*, !dbg !191
      %149 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %148, 0, !dbg !191
      %150 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !191
      %151 = insertvalue [2 x {} addrspace(10)*] %149, {} addrspace(10)* %150, 1, !dbg !191
      %152 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !191
      %153 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %152, i64 0, !dbg !191
      %154 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %145, align 8, !dbg !191, !tbaa !34, !alias.scope !38, !noalias !41
; │└└└
; │┌ @ none within `memcpy!`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %155 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !198
     %156 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %155, i64 0, !dbg !198
     %157 = addrspacecast {}* inttoptr (i64 139913410759984 to {}*) to {} addrspace(10)*, !dbg !198
     %158 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %157, 0, !dbg !198
     %159 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !198
     %160 = insertvalue [2 x {} addrspace(10)*] %158, {} addrspace(10)* %159, 1, !dbg !198
     %161 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !198
     %162 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %161, i64 0, !dbg !198
     call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %154, i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([13 x i8], [13 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*), i64 12, i1 false), !dbg !198
; │└└
; │┌ @ Base.jl:49 within `getproperty`
    %163 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !190
    %164 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %163, i64 0, !dbg !190
    %165 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 1, !dbg !190
; │└
; │┌ @ essentials.jl:730 within `reinterpret`
    %166 = bitcast {}* inttoptr (i64 139913249483504 to {}*) to {} addrspace(10)**, !dbg !202
    %167 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %166, i64 0, !dbg !202
    %168 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(5)* %165, align 8, !dbg !202, !tbaa !34, !alias.scope !38, !noalias !41
; │└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %169 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !203
      %170 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %169, i64 0, !dbg !203
      %171 = addrspacecast {}* inttoptr (i64 139904859701712 to {}*) to {} addrspace(10)*, !dbg !203
      %172 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %171, 0, !dbg !203
      %173 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !203
      %174 = insertvalue [2 x {} addrspace(10)*] %172, {} addrspace(10)* %173, 1, !dbg !203
      %175 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !203
      %176 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %175, i64 0, !dbg !203
      %177 = getelementptr inbounds i8, i8 addrspace(1)* %168, i64 12, !dbg !203
      store i8 0, i8 addrspace(1)* %177, align 1, !dbg !203, !tbaa !208
; │└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:97 within `hostcall_device_trigger_and_return!` @ none:0
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:30
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %178 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !210
         %179 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %178, i64 0, !dbg !210
         %180 = addrspacecast {}* inttoptr (i64 139913404229328 to {}*) to {} addrspace(10)*, !dbg !210
         %181 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %180, 0, !dbg !210
         %182 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !210
         %183 = insertvalue [2 x {} addrspace(10)*] %181, {} addrspace(10)* %182, 1, !dbg !210
         %184 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !210
         %185 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %184, i64 0, !dbg !210
         %186 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !210, !range !97
; │││││└└
; │││││┌ @ int.jl:1013 within `+` @ int.jl:87
        %187 = bitcast {}* inttoptr (i64 139913257763552 to {}*) to {} addrspace(10)**, !dbg !221
        %188 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %187, i64 0, !dbg !221
        %189 = add i32 %186, 1, !dbg !221
; ││││└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %190 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !223
         %191 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %190, i64 0, !dbg !223
         %192 = addrspacecast {}* inttoptr (i64 139913404231808 to {}*) to {} addrspace(10)*, !dbg !223
         %193 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %192, 0, !dbg !223
         %194 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !223
         %195 = insertvalue [2 x {} addrspace(10)*] %193, {} addrspace(10)* %194, 1, !dbg !223
         %196 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !223
         %197 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %196, i64 0, !dbg !223
         %198 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !223, !range !97
; ││││└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
         %199 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !227
         %200 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %199, i64 0, !dbg !227
         %201 = addrspacecast {}* inttoptr (i64 139913404232304 to {}*) to {} addrspace(10)*, !dbg !227
         %202 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %201, 0, !dbg !227
         %203 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !227
         %204 = insertvalue [2 x {} addrspace(10)*] %202, {} addrspace(10)* %203, 1, !dbg !227
         %205 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !227
         %206 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %205, i64 0, !dbg !227
         %207 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !227, !range !97
; │││└└└└
; │││┌ @ operators.jl:277 within `!=`
; ││││┌ @ int.jl:518 within `==` @ promotion.jl:483
; │││││┌ @ promotion.jl:400 within `promote`
; ││││││┌ @ promotion.jl:375 within `_promote`
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:897 within `UInt64`
; │││││││││┌ @ boot.jl:871 within `toUInt64`
            %208 = bitcast {}* inttoptr (i64 139913257759184 to {}*) to {} addrspace(10)**, !dbg !231
            %209 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %208, i64 0, !dbg !231
            %210 = bitcast {}* inttoptr (i64 139913214436992 to {}*) to {} addrspace(10)**, !dbg !231
            %211 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %210, i64 0, !dbg !231
            %212 = zext i32 %189 to i64, !dbg !231
; │││││└└└└└
; │││││ @ int.jl:518 within `==` @ promotion.jl:483 @ promotion.jl:639
       %213 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !239
       %214 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %213, i64 0, !dbg !239
       %215 = icmp eq i64 %212, 1, !dbg !239
; │││││ @ int.jl:518 within `==`
; │││││┌ @ bool.jl:38 within `&`
        %216 = bitcast {}* inttoptr (i64 139913257760528 to {}*) to {} addrspace(10)**, !dbg !240
        %217 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %216, i64 0, !dbg !240
        %218 = and i1 true, %215, !dbg !240
; ││││└└
; ││││┌ @ bool.jl:35 within `!`
       %219 = bitcast {}* inttoptr (i64 139913257760192 to {}*) to {} addrspace(10)**, !dbg !241
       %220 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %219, i64 0, !dbg !241
       %221 = xor i1 %218, true, !dbg !241
; │││└└
     %222 = xor i1 %221, true, !dbg !215
     br i1 %222, label %L75, label %L74, !dbg !215

L74:                                              ; preds = %L51
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:31
     br label %L117, !dbg !242

L75:                                              ; preds = %L51
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:113
; │││┌ @ Base.jl:49 within `getproperty`
      %223 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !243
      %224 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %223, i64 0, !dbg !243
      %225 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !243
      br label %L76, !dbg !243

L76:                                              ; preds = %L92, %L75
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:37
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:27 within `device_signal_cas!`
       %226 = load i64, i64 addrspace(5)* %225, align 8, !dbg !245, !tbaa !34, !alias.scope !38, !noalias !41
       %227 = call fastcc i64 @__ockl_hsa_signal_cas(i64 %226, i64 1, i64 2, i32 4), !dbg !245
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
; ││││┌ @ promotion.jl:639 within `==`
       %228 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !248
       %229 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %228, i64 0, !dbg !248
       %230 = icmp eq i64 %227, 1, !dbg !248
; ││││└
      %231 = xor i1 %230, true, !dbg !249
      br i1 %231, label %L80, label %L79, !dbg !249

L79:                                              ; preds = %L76
      br label %L94, !dbg !249

L80:                                              ; preds = %L76
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:40
      %232 = bitcast {}* inttoptr (i64 139909482421520 to {}*) to {} addrspace(10)**, !dbg !250
      %233 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %232, i64 0, !dbg !250
; ││││┌ @ promotion.jl:639 within `==`
       %234 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !251
       %235 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %234, i64 0, !dbg !251
       %236 = icmp eq i64 %227, 5, !dbg !251
; ││││└
      %237 = xor i1 %236, true, !dbg !250
      br i1 %237, label %L84, label %L83, !dbg !250

L83:                                              ; preds = %L80
      br label %L87, !dbg !250

L84:                                              ; preds = %L80
      %238 = bitcast {}* inttoptr (i64 139909482421424 to {}*) to {} addrspace(10)**, !dbg !250
      %239 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %238, i64 0, !dbg !250
; ││││┌ @ promotion.jl:639 within `==`
       %240 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !251
       %241 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %240, i64 0, !dbg !251
       %242 = icmp eq i64 %227, 6, !dbg !251
; ││││└
      %243 = xor i1 %242, true, !dbg !250
      br i1 %243, label %L92, label %L87, !dbg !250

L87:                                              ; preds = %L84, %L83
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:41
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %244 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !252
          %245 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %244, i64 0, !dbg !252
          %246 = addrspacecast {}* inttoptr (i64 139904877752720 to {}*) to {} addrspace(10)*, !dbg !252
          %247 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %246, 0, !dbg !252
          %248 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !252
          %249 = insertvalue [2 x {} addrspace(10)*] %247, {} addrspace(10)* %248, 1, !dbg !252
          %250 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !252
          %251 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %250, i64 0, !dbg !252
          %state.i2 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !252
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i2, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, align 8, !dbg !252
; ││││││└└
; ││││││┌ @ Base.jl:49 within `getproperty`
         %252 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !258
         %253 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %252, i64 0, !dbg !258
         %254 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %3, i32 0, i32 0, !dbg !258
; │││││└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %255 = bitcast {}* inttoptr (i64 139913257757392 to {}*) to {} addrspace(10)**, !dbg !259
        %256 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %255, i64 0, !dbg !259
        %257 = bitcast i64 addrspace(5)* %254 to i8* addrspace(5)*, !dbg !259
        %258 = load i8*, i8* addrspace(5)* %257, align 8, !dbg !259, !tbaa !34, !alias.scope !38, !noalias !41
        %259 = getelementptr inbounds i8, i8* %258, i64 0, !dbg !259
        %260 = bitcast i8* %259 to i32*, !dbg !259
        %261 = load i32, i32 addrspace(1)* @_j_const_1, align 4, !dbg !259, !tbaa !163, !alias.scope !167, !noalias !168
        store i32 %261, i32* %260, align 1, !dbg !259
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !261
        unreachable, !dbg !261

L92:                                              ; preds = %L84
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:46
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !263
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:47
      br label %L76, !dbg !265

L94:                                              ; preds = %L79
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:36 within `hostcall_device_signal_wait_cas!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:38
      br label %L95, !dbg !249

L95:                                              ; preds = %L94
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:116
; │││┌ @ Base.jl:49 within `getproperty`
      %262 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !266
      %263 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %262, i64 0, !dbg !266
      %264 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !266
      br label %L96, !dbg !266

L96:                                              ; preds = %L112, %L95
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:61
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:12 within `device_signal_load`
       %265 = load i64, i64 addrspace(5)* %264, align 8, !dbg !268, !tbaa !34, !alias.scope !38, !noalias !41
       %266 = call fastcc i64 @__ockl_hsa_signal_load(i64 %265, i32 2), !dbg !268
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
; ││││┌ @ promotion.jl:639 within `==`
       %267 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !273
       %268 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %267, i64 0, !dbg !273
       %269 = icmp eq i64 %266, 4, !dbg !273
; ││││└
      %270 = xor i1 %269, true, !dbg !274
      br i1 %270, label %L100, label %L99, !dbg !274

L99:                                              ; preds = %L96
      br label %L114, !dbg !274

L100:                                             ; preds = %L96
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:64
      %271 = bitcast {}* inttoptr (i64 139909482421520 to {}*) to {} addrspace(10)**, !dbg !275
      %272 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %271, i64 0, !dbg !275
; ││││┌ @ promotion.jl:639 within `==`
       %273 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !276
       %274 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %273, i64 0, !dbg !276
       %275 = icmp eq i64 %266, 5, !dbg !276
; ││││└
      %276 = xor i1 %275, true, !dbg !275
      br i1 %276, label %L104, label %L103, !dbg !275

L103:                                             ; preds = %L100
      br label %L107, !dbg !275

L104:                                             ; preds = %L100
      %277 = bitcast {}* inttoptr (i64 139909482421424 to {}*) to {} addrspace(10)**, !dbg !275
      %278 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %277, i64 0, !dbg !275
; ││││┌ @ promotion.jl:639 within `==`
       %279 = bitcast {}* inttoptr (i64 139913234915760 to {}*) to {} addrspace(10)**, !dbg !276
       %280 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %279, i64 0, !dbg !276
       %281 = icmp eq i64 %266, 6, !dbg !276
; ││││└
      %282 = xor i1 %281, true, !dbg !275
      br i1 %282, label %L112, label %L107, !dbg !275

L107:                                             ; preds = %L104, %L103
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:65
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; ││││││┌ @ none within `kernel_state`
; │││││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
          %283 = bitcast {}* inttoptr (i64 139913226412160 to {}*) to {} addrspace(10)**, !dbg !277
          %284 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %283, i64 0, !dbg !277
          %285 = addrspacecast {}* inttoptr (i64 139904877752720 to {}*) to {} addrspace(10)*, !dbg !277
          %286 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %285, 0, !dbg !277
          %287 = addrspacecast {}* inttoptr (i64 139909720244112 to {}*) to {} addrspace(10)*, !dbg !277
          %288 = insertvalue [2 x {} addrspace(10)*] %286, {} addrspace(10)* %287, 1, !dbg !277
          %289 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !277
          %290 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %289, i64 0, !dbg !277
          %state.i1 = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !277
          store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i1, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, align 8, !dbg !277
; ││││││└└
; ││││││┌ @ Base.jl:49 within `getproperty`
         %291 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !283
         %292 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %291, i64 0, !dbg !283
         %293 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %2, i32 0, i32 0, !dbg !283
; │││││└└
; │││││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
        %294 = bitcast {}* inttoptr (i64 139913257757392 to {}*) to {} addrspace(10)**, !dbg !284
        %295 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %294, i64 0, !dbg !284
        %296 = bitcast i64 addrspace(5)* %293 to i8* addrspace(5)*, !dbg !284
        %297 = load i8*, i8* addrspace(5)* %296, align 8, !dbg !284, !tbaa !34, !alias.scope !38, !noalias !41
        %298 = getelementptr inbounds i8, i8* %297, i64 0, !dbg !284
        %299 = bitcast i8* %298 to i32*, !dbg !284
        %300 = load i32, i32 addrspace(1)* @_j_const_1, align 4, !dbg !284, !tbaa !163, !alias.scope !167, !noalias !168
        store i32 %300, i32* %299, align 1, !dbg !284
; │││││└
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
        call void @llvm.amdgcn.endpgm(), !dbg !286
        unreachable, !dbg !286

L112:                                             ; preds = %L104
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:70
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:108 within `device_sleep`
       call void @llvm.amdgcn.s.sleep(i32 5), !dbg !288
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:71
      br label %L96, !dbg !290

L114:                                             ; preds = %L99
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:60 within `hostcall_device_signal_wait` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:62
      br label %L115, !dbg !274

L115:                                             ; preds = %L114
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:128
; │││┌ @ Base.jl:49 within `getproperty`
      %301 = bitcast {}* inttoptr (i64 139913214149584 to {}*) to {} addrspace(10)**, !dbg !291
      %302 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %301, i64 0, !dbg !291
      %303 = getelementptr inbounds { i64, i8 addrspace(1)*, i64 }, { i64, i8 addrspace(1)*, i64 } addrspace(5)* %1, i32 0, i32 0, !dbg !291
; │││└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19 within `device_signal_store!` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl:19
      %304 = load i64, i64 addrspace(5)* %303, align 8, !dbg !293, !tbaa !34, !alias.scope !38, !noalias !41
      %305 = call i64 bitcast (void (i64, i64, i32)* @__ockl_hsa_signal_store to i64 (i64, i64, i32)*)(i64 %304, i64 0, i32 3), !dbg !293
      br label %L117, !dbg !293

L117:                                             ; preds = %L115, %L74
; │││└
; │││ @ none within `macro expansion` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl:47
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       %306 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !296
       %307 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %306, i64 0, !dbg !296
       fence syncscope("workgroup") seq_cst, !dbg !296
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
      call void @llvm.amdgcn.s.barrier(), !dbg !299
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
       %308 = bitcast {}* inttoptr (i64 139913222926800 to {}*) to {} addrspace(10)**, !dbg !300
       %309 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %308, i64 0, !dbg !300
       fence syncscope("workgroup") seq_cst, !dbg !300
; │││└└
; │││ @ none within `macro expansion`
     br label %L121, !dbg !216

L121:                                             ; preds = %L117
     br label %L122, !dbg !216

L122:                                             ; preds = %L121
     %310 = bitcast {}* inttoptr (i64 139913214598064 to {}*) to {} addrspace(10)**, !dbg !216
     %311 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %310, i64 0, !dbg !216
     ret void, !dbg !216
; └└└
}

; Function Attrs: alwaysinline convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.readfirstlane(i32) #7

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #8

; Function Attrs: mustprogress nofree norecurse nounwind willreturn
define internal fastcc i64 @__ockl_hsa_signal_load(i64 %0, i32 noundef %1) unnamed_addr #9 {
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
  %22 = load i64, i64 addrspace(1)* %21, align 16, !tbaa !302
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %31, label %24

24:                                               ; preds = %20
  %25 = inttoptr i64 %22 to i64 addrspace(1)*
  %26 = getelementptr inbounds %0, %0 addrspace(1)* %5, i64 0, i32 3
  %27 = load i32, i32 addrspace(1)* %26, align 8, !tbaa !308
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

; Function Attrs: convergent norecurse nounwind
define internal void @__ockl_hsa_signal_store(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #10 {
  %4 = inttoptr i64 %0 to %0 addrspace(1)*
  %5 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 0
  %6 = load i64, i64 addrspace(1)* %5, align 64, !tbaa !309
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
  %15 = load i64, i64 addrspace(1)* %14, align 16, !tbaa !302
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %63, label %17

17:                                               ; preds = %13
  %18 = inttoptr i64 %15 to i64 addrspace(1)*
  %19 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 3
  %20 = load i32, i32 addrspace(1)* %19, align 8, !tbaa !308
  %21 = zext i32 %20 to i64
  store atomic i64 %21, i64 addrspace(1)* %18 syncscope("one-as") release, align 8
  %22 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %20)
  %23 = and i32 %22, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %23)
  br label %63

24:                                               ; preds = %3
  %25 = load i32, i32 addrspace(4)* @__oclc_ISA_version, align 4, !tbaa !310
  %26 = icmp sgt i32 %25, 8999
  br i1 %26, label %27, label %31

27:                                               ; preds = %24
  %28 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 1
  %29 = bitcast %1 addrspace(1)* %28 to i64 addrspace(1)* addrspace(1)*
  %30 = load i64 addrspace(1)*, i64 addrspace(1)* addrspace(1)* %29, align 8, !tbaa !311
  store atomic i64 %1, i64 addrspace(1)* %30 syncscope("one-as") release, align 8
  br label %63

31:                                               ; preds = %24
  %32 = getelementptr inbounds %0, %0 addrspace(1)* %4, i64 0, i32 7, i32 0
  %33 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %32, align 16, !tbaa !311
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
  %43 = load volatile i64, i64 addrspace(1)* %42, align 16, !tbaa !312
  %44 = icmp ugt i64 %41, %43
  br i1 %44, label %45, label %62

45:                                               ; preds = %40
  store atomic i64 %41, i64 addrspace(1)* %42 syncscope("one-as") monotonic, align 16
  %46 = icmp slt i32 %25, 8000
  br i1 %46, label %47, label %56

47:                                               ; preds = %45
  %48 = trunc i64 %41 to i32
  %49 = getelementptr inbounds %3, %3 addrspace(1)* %33, i64 0, i32 0, i32 4
  %50 = load i32, i32 addrspace(1)* %49, align 8, !tbaa !317
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
  %61 = load i32 addrspace(1)*, i32 addrspace(1)* addrspace(1)* %60, align 8, !tbaa !311
  store volatile i32 %58, i32 addrspace(1)* %61, align 4, !tbaa !310
  br label %62

62:                                               ; preds = %56, %40
  store atomic i32 0, i32 addrspace(1)* %34 syncscope("one-as") release, align 4
  br label %63

63:                                               ; preds = %62, %27, %17, %13
  ret void
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { convergent nocallback nofree nounwind willreturn }
attributes #2 = { cold nocallback nofree noreturn nounwind }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { memory(none) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #7 = { alwaysinline convergent nocallback nofree nounwind willreturn memory(none) }
attributes #8 = { alwaysinline nounwind }
attributes #9 = { mustprogress nofree norecurse nounwind willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }

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
!7 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!8 = !{void ()* @_Z6kernel}
!9 = distinct !DISubprogram(name: "kernel", linkageName: "julia_kernel_12000", scope: null, file: !10, line: 3, type: !11, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!10 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!11 = !DISubroutineType(types: !12)
!12 = !{}
!13 = !DILocation(line: 39, scope: !14, inlinedAt: !16)
!14 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !15, file: !15, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!15 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!16 = !DILocation(line: 0, scope: !17, inlinedAt: !19)
!17 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!18 = !DIFile(filename: "none", directory: ".")
!19 = !DILocation(line: 0, scope: !20, inlinedAt: !21)
!20 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!21 = !DILocation(line: 71, scope: !22, inlinedAt: !24)
!22 = distinct !DISubprogram(name: "output_context;", linkageName: "output_context", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!23 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!24 = !DILocation(line: 69, scope: !25, inlinedAt: !27)
!25 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !26, file: !26, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!26 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/output.jl", directory: ".")
!27 = !DILocation(line: 3, scope: !9)
!28 = !DILocation(line: 49, scope: !29, inlinedAt: !21)
!29 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !30, file: !30, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!30 = !DIFile(filename: "Base.jl", directory: ".")
!31 = !DILocation(line: 30, scope: !32, inlinedAt: !21)
!32 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
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
!48 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!49 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!50 = !DILocation(line: 2, scope: !51, inlinedAt: !52)
!51 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!52 = !DILocation(line: 54, scope: !53, inlinedAt: !54)
!53 = distinct !DISubprogram(name: "alloc_local;", linkageName: "alloc_local", scope: !49, file: !49, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!54 = !DILocation(line: 54, scope: !53, inlinedAt: !55)
!55 = !DILocation(line: 73, scope: !22, inlinedAt: !24)
!56 = !DILocation(line: 730, scope: !57, inlinedAt: !59)
!57 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !58, file: !58, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!58 = !DIFile(filename: "essentials.jl", directory: ".")
!59 = !DILocation(line: 74, scope: !22, inlinedAt: !24)
!60 = !DILocation(line: 39, scope: !14, inlinedAt: !61)
!61 = !DILocation(line: 0, scope: !17, inlinedAt: !62)
!62 = !DILocation(line: 0, scope: !63, inlinedAt: !64)
!63 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!64 = !DILocation(line: 88, scope: !65, inlinedAt: !67)
!65 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!66 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!67 = !DILocation(line: 88, scope: !65, inlinedAt: !68)
!68 = !DILocation(line: 88, scope: !65, inlinedAt: !59)
!69 = !{!70, !70, i64 0, i64 0}
!70 = !{!"custom_tbaa_addrspace(3)", !71, i64 0}
!71 = !{!"custom_tbaa"}
!72 = !DILocation(line: 153, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!74 = !DILocation(line: 153, scope: !73, inlinedAt: !75)
!75 = !DILocation(line: 70, scope: !25, inlinedAt: !27)
!76 = !{!36, !36, i64 0}
!77 = !{!43, !39}
!78 = !{!42, !44, !45}
!79 = !DILocation(line: 39, scope: !14, inlinedAt: !80)
!80 = !DILocation(line: 3, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!82 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!83 = !DILocation(line: 3, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!85 = !DILocation(line: 87, scope: !86, inlinedAt: !87)
!86 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!87 = !DILocation(line: 122, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!89 = !DILocation(line: 30, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!91 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_utils.jl", directory: ".")
!92 = !DILocation(line: 0, scope: !17, inlinedAt: !93)
!93 = !DILocation(line: 0, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!95 = !DILocation(line: 53, scope: !96, inlinedAt: !75)
!96 = distinct !DISubprogram(name: "hostcall_device_lock!;", linkageName: "hostcall_device_lock!", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!97 = !{i32 0, i32 1023}
!98 = !DILocation(line: 87, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !100, file: !100, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!100 = !DIFile(filename: "int.jl", directory: ".")
!101 = !DILocation(line: 1013, scope: !99, inlinedAt: !85)
!102 = !DILocation(line: 39, scope: !14, inlinedAt: !103)
!103 = !DILocation(line: 3, scope: !81, inlinedAt: !104)
!104 = !DILocation(line: 3, scope: !84, inlinedAt: !105)
!105 = !DILocation(line: 87, scope: !106, inlinedAt: !87)
!106 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!107 = !DILocation(line: 39, scope: !14, inlinedAt: !108)
!108 = !DILocation(line: 3, scope: !81, inlinedAt: !109)
!109 = !DILocation(line: 3, scope: !84, inlinedAt: !110)
!110 = !DILocation(line: 87, scope: !111, inlinedAt: !87)
!111 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !82, file: !82, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!112 = !DILocation(line: 871, scope: !113, inlinedAt: !115)
!113 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !114, file: !114, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!114 = !DIFile(filename: "boot.jl", directory: ".")
!115 = !DILocation(line: 897, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !114, file: !114, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!117 = !DILocation(line: 7, scope: !118, inlinedAt: !120)
!118 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !119, file: !119, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!119 = !DIFile(filename: "number.jl", directory: ".")
!120 = !DILocation(line: 375, scope: !121, inlinedAt: !123)
!121 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!122 = !DIFile(filename: "promotion.jl", directory: ".")
!123 = !DILocation(line: 400, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!125 = !DILocation(line: 483, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !122, file: !122, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!127 = !DILocation(line: 518, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !100, file: !100, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!129 = !DILocation(line: 277, scope: !130, inlinedAt: !89)
!130 = distinct !DISubprogram(name: "!=;", linkageName: "!=", scope: !131, file: !131, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!131 = !DIFile(filename: "operators.jl", directory: ".")
!132 = !DILocation(line: 639, scope: !126, inlinedAt: !125)
!133 = !DILocation(line: 38, scope: !134, inlinedAt: !127)
!134 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !135, file: !135, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!135 = !DIFile(filename: "bool.jl", directory: ".")
!136 = !DILocation(line: 35, scope: !137, inlinedAt: !129)
!137 = distinct !DISubprogram(name: "!;", linkageName: "!", scope: !135, file: !135, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!138 = !DILocation(line: 31, scope: !90, inlinedAt: !92)
!139 = !DILocation(line: 49, scope: !29, inlinedAt: !140)
!140 = !DILocation(line: 62, scope: !90, inlinedAt: !92)
!141 = !DILocation(line: 27, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "device_signal_cas!;", linkageName: "device_signal_cas!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!143 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/hostcall_signal_helpers.jl", directory: ".")
!144 = !DILocation(line: 37, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "hostcall_device_signal_wait_cas!;", linkageName: "hostcall_device_signal_wait_cas!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!146 = !DILocation(line: 36, scope: !145, inlinedAt: !140)
!147 = !DILocation(line: 639, scope: !126, inlinedAt: !148)
!148 = !DILocation(line: 38, scope: !145, inlinedAt: !146)
!149 = !DILocation(line: 40, scope: !145, inlinedAt: !146)
!150 = !DILocation(line: 639, scope: !126, inlinedAt: !149)
!151 = !DILocation(line: 39, scope: !14, inlinedAt: !152)
!152 = !DILocation(line: 0, scope: !17, inlinedAt: !153)
!153 = !DILocation(line: 0, scope: !20, inlinedAt: !154)
!154 = !DILocation(line: 11, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!156 = !DILocation(line: 113, scope: !157, inlinedAt: !158)
!157 = distinct !DISubprogram(name: "signal_exception;", linkageName: "signal_exception", scope: !23, file: !23, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!158 = !DILocation(line: 41, scope: !145, inlinedAt: !146)
!159 = !DILocation(line: 49, scope: !29, inlinedAt: !154)
!160 = !DILocation(line: 180, scope: !161, inlinedAt: !162)
!161 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !33, file: !33, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!162 = !DILocation(line: 180, scope: !161, inlinedAt: !156)
!163 = !{!164, !164, i64 0}
!164 = !{!"jtbaa_immut", !165, i64 0}
!165 = !{!"jtbaa_value", !166, i64 0}
!166 = !{!"jtbaa_data", !36, i64 0}
!167 = !{!43}
!168 = !{!42, !39, !44, !45}
!169 = !DILocation(line: 6, scope: !170, inlinedAt: !172)
!170 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !171, file: !171, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!171 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!172 = !DILocation(line: 115, scope: !157, inlinedAt: !158)
!173 = !DILocation(line: 108, scope: !174, inlinedAt: !175)
!174 = distinct !DISubprogram(name: "device_sleep;", linkageName: "device_sleep", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!175 = !DILocation(line: 46, scope: !145, inlinedAt: !146)
!176 = !DILocation(line: 47, scope: !145, inlinedAt: !146)
!177 = !DILocation(line: 5, scope: !178, inlinedAt: !180)
!178 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !179, file: !179, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!179 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!180 = !DILocation(line: 27, scope: !181, inlinedAt: !182)
!181 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !179, file: !179, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!182 = !DILocation(line: 47, scope: !90, inlinedAt: !92)
!183 = !DILocation(line: 28, scope: !181, inlinedAt: !182)
!184 = !DILocation(line: 5, scope: !178, inlinedAt: !185)
!185 = !DILocation(line: 29, scope: !181, inlinedAt: !182)
!186 = !DILocation(line: 39, scope: !14, inlinedAt: !187)
!187 = !DILocation(line: 0, scope: !17, inlinedAt: !188)
!188 = !DILocation(line: 0, scope: !189, inlinedAt: !75)
!189 = distinct !DISubprogram(name: "alloc_string;", linkageName: "alloc_string", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!190 = !DILocation(line: 49, scope: !29, inlinedAt: !75)
!191 = !DILocation(line: 39, scope: !14, inlinedAt: !192)
!192 = !DILocation(line: 114, scope: !193, inlinedAt: !194)
!193 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!194 = !DILocation(line: 114, scope: !195, inlinedAt: !196)
!195 = distinct !DISubprogram(name: "add_ptr;", linkageName: "add_ptr", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!196 = !DILocation(line: 147, scope: !197, inlinedAt: !75)
!197 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !66, file: !66, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!198 = !DILocation(line: 39, scope: !14, inlinedAt: !199)
!199 = !DILocation(line: 0, scope: !17, inlinedAt: !200)
!200 = !DILocation(line: 0, scope: !201, inlinedAt: !75)
!201 = distinct !DISubprogram(name: "memcpy!;", linkageName: "memcpy!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!202 = !DILocation(line: 730, scope: !57, inlinedAt: !75)
!203 = !DILocation(line: 39, scope: !14, inlinedAt: !204)
!204 = !DILocation(line: 0, scope: !17, inlinedAt: !205)
!205 = !DILocation(line: 0, scope: !63, inlinedAt: !206)
!206 = !DILocation(line: 88, scope: !65, inlinedAt: !207)
!207 = !DILocation(line: 88, scope: !65, inlinedAt: !75)
!208 = !{!209, !209, i64 0, i64 0}
!209 = !{!"custom_tbaa_addrspace(1)", !71, i64 0}
!210 = !DILocation(line: 39, scope: !14, inlinedAt: !211)
!211 = !DILocation(line: 3, scope: !81, inlinedAt: !212)
!212 = !DILocation(line: 3, scope: !84, inlinedAt: !213)
!213 = !DILocation(line: 87, scope: !86, inlinedAt: !214)
!214 = !DILocation(line: 122, scope: !88, inlinedAt: !215)
!215 = !DILocation(line: 30, scope: !90, inlinedAt: !216)
!216 = !DILocation(line: 0, scope: !17, inlinedAt: !217)
!217 = !DILocation(line: 0, scope: !218, inlinedAt: !219)
!218 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !18, file: !18, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!219 = !DILocation(line: 97, scope: !220, inlinedAt: !75)
!220 = distinct !DISubprogram(name: "hostcall_device_trigger_and_return!;", linkageName: "hostcall_device_trigger_and_return!", scope: !91, file: !91, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!221 = !DILocation(line: 87, scope: !99, inlinedAt: !222)
!222 = !DILocation(line: 1013, scope: !99, inlinedAt: !213)
!223 = !DILocation(line: 39, scope: !14, inlinedAt: !224)
!224 = !DILocation(line: 3, scope: !81, inlinedAt: !225)
!225 = !DILocation(line: 3, scope: !84, inlinedAt: !226)
!226 = !DILocation(line: 87, scope: !106, inlinedAt: !214)
!227 = !DILocation(line: 39, scope: !14, inlinedAt: !228)
!228 = !DILocation(line: 3, scope: !81, inlinedAt: !229)
!229 = !DILocation(line: 3, scope: !84, inlinedAt: !230)
!230 = !DILocation(line: 87, scope: !111, inlinedAt: !214)
!231 = !DILocation(line: 871, scope: !113, inlinedAt: !232)
!232 = !DILocation(line: 897, scope: !116, inlinedAt: !233)
!233 = !DILocation(line: 7, scope: !118, inlinedAt: !234)
!234 = !DILocation(line: 375, scope: !121, inlinedAt: !235)
!235 = !DILocation(line: 400, scope: !124, inlinedAt: !236)
!236 = !DILocation(line: 483, scope: !126, inlinedAt: !237)
!237 = !DILocation(line: 518, scope: !128, inlinedAt: !238)
!238 = !DILocation(line: 277, scope: !130, inlinedAt: !215)
!239 = !DILocation(line: 639, scope: !126, inlinedAt: !236)
!240 = !DILocation(line: 38, scope: !134, inlinedAt: !237)
!241 = !DILocation(line: 35, scope: !137, inlinedAt: !238)
!242 = !DILocation(line: 31, scope: !90, inlinedAt: !216)
!243 = !DILocation(line: 49, scope: !29, inlinedAt: !244)
!244 = !DILocation(line: 113, scope: !90, inlinedAt: !216)
!245 = !DILocation(line: 27, scope: !142, inlinedAt: !246)
!246 = !DILocation(line: 37, scope: !145, inlinedAt: !247)
!247 = !DILocation(line: 36, scope: !145, inlinedAt: !244)
!248 = !DILocation(line: 639, scope: !126, inlinedAt: !249)
!249 = !DILocation(line: 38, scope: !145, inlinedAt: !247)
!250 = !DILocation(line: 40, scope: !145, inlinedAt: !247)
!251 = !DILocation(line: 639, scope: !126, inlinedAt: !250)
!252 = !DILocation(line: 39, scope: !14, inlinedAt: !253)
!253 = !DILocation(line: 0, scope: !17, inlinedAt: !254)
!254 = !DILocation(line: 0, scope: !20, inlinedAt: !255)
!255 = !DILocation(line: 11, scope: !155, inlinedAt: !256)
!256 = !DILocation(line: 113, scope: !157, inlinedAt: !257)
!257 = !DILocation(line: 41, scope: !145, inlinedAt: !247)
!258 = !DILocation(line: 49, scope: !29, inlinedAt: !255)
!259 = !DILocation(line: 180, scope: !161, inlinedAt: !260)
!260 = !DILocation(line: 180, scope: !161, inlinedAt: !256)
!261 = !DILocation(line: 6, scope: !170, inlinedAt: !262)
!262 = !DILocation(line: 115, scope: !157, inlinedAt: !257)
!263 = !DILocation(line: 108, scope: !174, inlinedAt: !264)
!264 = !DILocation(line: 46, scope: !145, inlinedAt: !247)
!265 = !DILocation(line: 47, scope: !145, inlinedAt: !247)
!266 = !DILocation(line: 49, scope: !29, inlinedAt: !267)
!267 = !DILocation(line: 116, scope: !90, inlinedAt: !216)
!268 = !DILocation(line: 12, scope: !269, inlinedAt: !270)
!269 = distinct !DISubprogram(name: "device_signal_load;", linkageName: "device_signal_load", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!270 = !DILocation(line: 61, scope: !271, inlinedAt: !272)
!271 = distinct !DISubprogram(name: "hostcall_device_signal_wait;", linkageName: "hostcall_device_signal_wait", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!272 = !DILocation(line: 60, scope: !271, inlinedAt: !267)
!273 = !DILocation(line: 639, scope: !126, inlinedAt: !274)
!274 = !DILocation(line: 62, scope: !271, inlinedAt: !272)
!275 = !DILocation(line: 64, scope: !271, inlinedAt: !272)
!276 = !DILocation(line: 639, scope: !126, inlinedAt: !275)
!277 = !DILocation(line: 39, scope: !14, inlinedAt: !278)
!278 = !DILocation(line: 0, scope: !17, inlinedAt: !279)
!279 = !DILocation(line: 0, scope: !20, inlinedAt: !280)
!280 = !DILocation(line: 11, scope: !155, inlinedAt: !281)
!281 = !DILocation(line: 113, scope: !157, inlinedAt: !282)
!282 = !DILocation(line: 65, scope: !271, inlinedAt: !272)
!283 = !DILocation(line: 49, scope: !29, inlinedAt: !280)
!284 = !DILocation(line: 180, scope: !161, inlinedAt: !285)
!285 = !DILocation(line: 180, scope: !161, inlinedAt: !281)
!286 = !DILocation(line: 6, scope: !170, inlinedAt: !287)
!287 = !DILocation(line: 115, scope: !157, inlinedAt: !282)
!288 = !DILocation(line: 108, scope: !174, inlinedAt: !289)
!289 = !DILocation(line: 70, scope: !271, inlinedAt: !272)
!290 = !DILocation(line: 71, scope: !271, inlinedAt: !272)
!291 = !DILocation(line: 49, scope: !29, inlinedAt: !292)
!292 = !DILocation(line: 128, scope: !90, inlinedAt: !216)
!293 = !DILocation(line: 19, scope: !294, inlinedAt: !295)
!294 = distinct !DISubprogram(name: "device_signal_store!;", linkageName: "device_signal_store!", scope: !143, file: !143, type: !11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !12)
!295 = !DILocation(line: 19, scope: !294, inlinedAt: !292)
!296 = !DILocation(line: 5, scope: !178, inlinedAt: !297)
!297 = !DILocation(line: 27, scope: !181, inlinedAt: !298)
!298 = !DILocation(line: 47, scope: !90, inlinedAt: !216)
!299 = !DILocation(line: 28, scope: !181, inlinedAt: !298)
!300 = !DILocation(line: 5, scope: !178, inlinedAt: !301)
!301 = !DILocation(line: 29, scope: !181, inlinedAt: !298)
!302 = !{!303, !304, i64 16}
!303 = !{!"amd_signal_s", !304, i64 0, !305, i64 8, !304, i64 16, !307, i64 24, !307, i64 28, !304, i64 32, !304, i64 40, !305, i64 48, !305, i64 56}
!304 = !{!"long", !305, i64 0}
!305 = !{!"omnipotent char", !306, i64 0}
!306 = !{!"Simple C/C++ TBAA"}
!307 = !{!"int", !305, i64 0}
!308 = !{!303, !307, i64 24}
!309 = !{!303, !304, i64 0}
!310 = !{!307, !307, i64 0}
!311 = !{!305, !305, i64 0}
!312 = !{!313, !304, i64 80}
!313 = !{!"amd_queue_s", !314, i64 0, !305, i64 40, !304, i64 56, !307, i64 64, !307, i64 68, !307, i64 72, !307, i64 76, !304, i64 80, !307, i64 88, !305, i64 92, !304, i64 128, !307, i64 136, !307, i64 140, !305, i64 144, !304, i64 160, !304, i64 168, !307, i64 176, !307, i64 180, !305, i64 184, !316, i64 192, !305, i64 200}
!314 = !{!"hsa_queue_s", !305, i64 0, !307, i64 4, !315, i64 8, !316, i64 16, !307, i64 24, !307, i64 28, !304, i64 32}
!315 = !{!"any pointer", !305, i64 0}
!316 = !{!"hsa_signal_s", !304, i64 0}
!317 = !{!313, !307, i64 24}
