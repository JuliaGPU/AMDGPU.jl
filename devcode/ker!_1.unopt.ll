; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@jl_nothing = external local_unnamed_addr addrspace(1) constant {}*
@0 = private unnamed_addr constant [12 x i8] c"BoundsError\00", align 1
@1 = private unnamed_addr constant [27 x i8] c"Out-of-bounds array access\00", align 1
@exception = private unnamed_addr addrspace(1) constant [10 x i8] c"exception\00", align 1
@_j_const_1 = private unnamed_addr addrspace(1) constant i32 1, align 4

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #0

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:35 within `_throw_boundserror`
; Function Attrs: alwaysinline noinline noreturn
define internal fastcc void @julia__throw_boundserror_12110() unnamed_addr #1 !dbg !46 {
top:
  %0 = alloca [5 x i64], align 8, addrspace(5)
  %1 = alloca [3 x i32], align 4, addrspace(5)
  %2 = alloca [3 x i32], align 4, addrspace(5)
  %3 = alloca [3 x i32], align 4, addrspace(5)
  %4 = alloca [3 x i32], align 4, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %5 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %5, i64 -14
  %6 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %6, i64 15
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:133 within `macro expansion`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %7 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !50
     %8 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %7, i64 0, !dbg !50
     %9 = addrspacecast {}* inttoptr (i64 129158417955584 to {}*) to {} addrspace(10)*, !dbg !50
     %10 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %9, 0, !dbg !50
     %11 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !50
     %12 = insertvalue [2 x {} addrspace(10)*] %10, {} addrspace(10)* %11, 1, !dbg !50
     %13 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !50
     %14 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %13, i64 0, !dbg !50
     %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !50
     store [5 x i64] %state.i, [5 x i64] addrspace(5)* %0, align 8, !dbg !50
; │└└
; │┌ @ Base.jl:49 within `getproperty`
    %15 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !62
    %16 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %15, i64 0, !dbg !62
    %17 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !62
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:134 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:29 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %18 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !65
       %19 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %18, i64 0, !dbg !65
       %20 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !65
       %21 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %20, i64 0, !dbg !65
       %22 = load i64, i64 addrspace(5)* %17, align 8, !dbg !65, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %23 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !68
      %24 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %23, i64 0, !dbg !68
      %25 = inttoptr i64 %22 to i8*, !dbg !68
      %26 = getelementptr i8, i8* %25, i64 4, !dbg !68
      %27 = ptrtoint i8* %26 to i64, !dbg !68
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %28 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !88
         %29 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %28, i64 0, !dbg !88
; │││└└└└
; │││┌ @ essentials.jl:730 within `reinterpret`
      %30 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !95
      %31 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %30, i64 0, !dbg !95
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `llvm_atomic_cas`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:37 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %32 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !97
      %33 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %32, i64 0, !dbg !97
      %34 = addrspacecast {}* inttoptr (i64 129166948894528 to {}*) to {} addrspace(10)*, !dbg !97
      %35 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %34, 0, !dbg !97
      %36 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !97
      %37 = insertvalue [2 x {} addrspace(10)*] %35, {} addrspace(10)* %36, 1, !dbg !97
      %38 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !97
      %39 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %38, i64 0, !dbg !97
      %40 = bitcast i8* %26 to i32*, !dbg !97
      %41 = cmpxchg i32* %40, i32 0, i32 1 acq_rel acquire, align 4, !dbg !97
      %42 = extractvalue { i32, i1 } %41, 0, !dbg !97
; ││└└
; ││┌ @ promotion.jl:639 within `==`
     %43 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !103
     %44 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %43, i64 0, !dbg !103
     %45 = icmp eq i32 %42, 0, !dbg !103
; ││└
    %46 = xor i1 %45, true, !dbg !73
    br i1 %46, label %L46, label %L12, !dbg !73

L12:                                              ; preds = %top
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:114 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %47 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !106
        %48 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %47, i64 0, !dbg !106
        %49 = addrspacecast {}* inttoptr (i64 129166957703296 to {}*) to {} addrspace(10)*, !dbg !106
        %50 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %49, 0, !dbg !106
        %51 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !106
        %52 = insertvalue [2 x {} addrspace(10)*] %50, {} addrspace(10)* %51, 1, !dbg !106
        %53 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !106
        %54 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %53, i64 0, !dbg !106
        %55 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !106, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %56 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !118
       %57 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %56, i64 0, !dbg !118
       %58 = add i32 %55, 1, !dbg !118
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %59 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !122
        %60 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %59, i64 0, !dbg !122
        %61 = addrspacecast {}* inttoptr (i64 129166957703792 to {}*) to {} addrspace(10)*, !dbg !122
        %62 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %61, 0, !dbg !122
        %63 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !122
        %64 = insertvalue [2 x {} addrspace(10)*] %62, {} addrspace(10)* %63, 1, !dbg !122
        %65 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !122
        %66 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %65, i64 0, !dbg !122
        %67 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !122, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %68 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !127
       %69 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %68, i64 0, !dbg !127
       %70 = add i32 %67, 1, !dbg !127
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %71 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !129
        %72 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %71, i64 0, !dbg !129
        %73 = addrspacecast {}* inttoptr (i64 129166957704288 to {}*) to {} addrspace(10)*, !dbg !129
        %74 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %73, 0, !dbg !129
        %75 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !129
        %76 = insertvalue [2 x {} addrspace(10)*] %74, {} addrspace(10)* %75, 1, !dbg !129
        %77 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !129
        %78 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %77, i64 0, !dbg !129
        %79 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !129, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %80 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !134
       %81 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %80, i64 0, !dbg !134
       %82 = add i32 %79, 1, !dbg !134
; │││└└
; │││┌ @ boot.jl:727 within `NamedTuple`
      %83 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 0, !dbg !136
      store i32 %58, i32 addrspace(5)* %83, align 4, !dbg !136, !tbaa !76, !alias.scope !80, !noalias !83
      %84 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 1, !dbg !136
      store i32 %70, i32 addrspace(5)* %84, align 4, !dbg !136, !tbaa !76, !alias.scope !80, !noalias !83
      %85 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 2, !dbg !136
      store i32 %82, i32 addrspace(5)* %85, align 4, !dbg !136, !tbaa !76, !alias.scope !80, !noalias !83
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:72 within `setproperty!`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %86 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !138
       %87 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %86, i64 0, !dbg !138
       %88 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !138
       %89 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %88, i64 0, !dbg !138
       %90 = load i64, i64 addrspace(5)* %17, align 8, !dbg !138, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %91 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !139
      %92 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %91, i64 0, !dbg !139
      %93 = inttoptr i64 %90 to i8*, !dbg !139
      %94 = getelementptr i8, i8* %93, i64 8, !dbg !139
      %95 = ptrtoint i8* %94 to i64, !dbg !139
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %96 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !142
         %97 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %96, i64 0, !dbg !142
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %98 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !145
      %99 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %98, i64 0, !dbg !145
; │││└
; │││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
      %100 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !146
      %101 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %100, i64 0, !dbg !146
      %102 = getelementptr inbounds i8, i8* %94, i64 0, !dbg !146
      %103 = bitcast [3 x i32] addrspace(5)* %1 to i8 addrspace(5)*, !dbg !146
      call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %102, i8 addrspace(5)* align 4 %103, i64 12, i1 false), !dbg !146
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:115 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %104 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !149
        %105 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %104, i64 0, !dbg !149
        %106 = addrspacecast {}* inttoptr (i64 129166957706272 to {}*) to {} addrspace(10)*, !dbg !149
        %107 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %106, 0, !dbg !149
        %108 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !149
        %109 = insertvalue [2 x {} addrspace(10)*] %107, {} addrspace(10)* %108, 1, !dbg !149
        %110 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !149
        %111 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %110, i64 0, !dbg !149
        %112 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !149, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %113 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !158
       %114 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %113, i64 0, !dbg !158
       %115 = add i32 %112, 1, !dbg !158
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %116 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !160
        %117 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %116, i64 0, !dbg !160
        %118 = addrspacecast {}* inttoptr (i64 129166957706768 to {}*) to {} addrspace(10)*, !dbg !160
        %119 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %118, 0, !dbg !160
        %120 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !160
        %121 = insertvalue [2 x {} addrspace(10)*] %119, {} addrspace(10)* %120, 1, !dbg !160
        %122 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !160
        %123 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %122, i64 0, !dbg !160
        %124 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !160, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %125 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !165
       %126 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %125, i64 0, !dbg !165
       %127 = add i32 %124, 1, !dbg !165
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %128 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !167
        %129 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %128, i64 0, !dbg !167
        %130 = addrspacecast {}* inttoptr (i64 129166972486144 to {}*) to {} addrspace(10)*, !dbg !167
        %131 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %130, 0, !dbg !167
        %132 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !167
        %133 = insertvalue [2 x {} addrspace(10)*] %131, {} addrspace(10)* %132, 1, !dbg !167
        %134 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !167
        %135 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %134, i64 0, !dbg !167
        %136 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !167, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %137 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !172
       %138 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %137, i64 0, !dbg !172
       %139 = add i32 %136, 1, !dbg !172
; │││└└
; │││┌ @ boot.jl:727 within `NamedTuple`
      %140 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 0, !dbg !174
      store i32 %115, i32 addrspace(5)* %140, align 4, !dbg !174, !tbaa !76, !alias.scope !80, !noalias !83
      %141 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 1, !dbg !174
      store i32 %127, i32 addrspace(5)* %141, align 4, !dbg !174, !tbaa !76, !alias.scope !80, !noalias !83
      %142 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 2, !dbg !174
      store i32 %139, i32 addrspace(5)* %142, align 4, !dbg !174, !tbaa !76, !alias.scope !80, !noalias !83
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:75 within `setproperty!`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %143 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !175
       %144 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %143, i64 0, !dbg !175
       %145 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !175
       %146 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %145, i64 0, !dbg !175
       %147 = load i64, i64 addrspace(5)* %17, align 8, !dbg !175, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %148 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !176
      %149 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %148, i64 0, !dbg !176
      %150 = inttoptr i64 %147 to i8*, !dbg !176
      %151 = getelementptr i8, i8* %150, i64 20, !dbg !176
      %152 = ptrtoint i8* %151 to i64, !dbg !176
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %153 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !178
         %154 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %153, i64 0, !dbg !178
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %155 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !181
      %156 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %155, i64 0, !dbg !181
; │││└
; │││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
      %157 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !182
      %158 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %157, i64 0, !dbg !182
      %159 = getelementptr inbounds i8, i8* %151, i64 0, !dbg !182
      %160 = bitcast [3 x i32] addrspace(5)* %2 to i8 addrspace(5)*, !dbg !182
      call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %159, i8 addrspace(5)* align 4 %160, i64 12, i1 false), !dbg !182
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:116 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
      %161 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !184
      %162 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %161, i64 0, !dbg !184
      fence syncscope("workgroup") seq_cst, !dbg !184
; │││└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
     call void @llvm.amdgcn.s.barrier(), !dbg !190
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
      %163 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !191
      %164 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %163, i64 0, !dbg !191
      fence syncscope("workgroup") seq_cst, !dbg !191
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:117 within `lock_output!`
    br label %L131, !dbg !193

L46:                                              ; preds = %top
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:118 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:27 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %165 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !194
       %166 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %165, i64 0, !dbg !194
       %167 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !194
       %168 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %167, i64 0, !dbg !194
       %169 = load i64, i64 addrspace(5)* %17, align 8, !dbg !194, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %170 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !195
      %171 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %170, i64 0, !dbg !195
      %172 = inttoptr i64 %169 to i8*, !dbg !195
      %173 = getelementptr i8, i8* %172, i64 4, !dbg !195
      %174 = ptrtoint i8* %173 to i64, !dbg !195
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %175 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !198
         %176 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %175, i64 0, !dbg !198
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %177 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !201
      %178 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %177, i64 0, !dbg !201
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %179 = bitcast {}* inttoptr (i64 129166849026880 to {}*) to {} addrspace(10)**, !dbg !202
      %180 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %179, i64 0, !dbg !202
      %181 = bitcast i8* %173 to i32*, !dbg !202
      %182 = getelementptr inbounds i32, i32* %181, i64 0, !dbg !202
      %183 = load i32, i32* %182, align 1, !dbg !202, !tbaa !205, !alias.scope !207, !noalias !208
; ││└└
; ││┌ @ promotion.jl:639 within `==`
     %184 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !209
     %185 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %184, i64 0, !dbg !209
     %186 = icmp eq i32 %183, 1, !dbg !209
; ││└
    %187 = xor i1 %186, true, !dbg !197
    br i1 %187, label %L130, label %L53, !dbg !197

L53:                                              ; preds = %L46
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:32 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %188 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !210
       %189 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %188, i64 0, !dbg !210
       %190 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !210
       %191 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %190, i64 0, !dbg !210
       %192 = load i64, i64 addrspace(5)* %17, align 8, !dbg !210, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %193 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !211
      %194 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %193, i64 0, !dbg !211
      %195 = inttoptr i64 %192 to i8*, !dbg !211
      %196 = getelementptr i8, i8* %195, i64 8, !dbg !211
      %197 = ptrtoint i8* %196 to i64, !dbg !211
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %198 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !213
         %199 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %198, i64 0, !dbg !213
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %200 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !216
      %201 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %200, i64 0, !dbg !216
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %202 = bitcast {}* inttoptr (i64 129166849026880 to {}*) to {} addrspace(10)**, !dbg !217
      %203 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %202, i64 0, !dbg !217
      %204 = bitcast i8* %196 to [3 x i32]*, !dbg !217
      %205 = getelementptr inbounds [3 x i32], [3 x i32]* %204, i64 0, !dbg !217
      %206 = bitcast [3 x i32] addrspace(5)* %3 to i8 addrspace(5)*, !dbg !217
      %207 = bitcast [3 x i32]* %205 to i8*, !dbg !217
      call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %206, i8* align 1 %207, i64 12, i1 false), !dbg !217, !tbaa !219, !alias.scope !220, !noalias !221
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %208 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !222
        %209 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %208, i64 0, !dbg !222
        %210 = addrspacecast {}* inttoptr (i64 129166957703296 to {}*) to {} addrspace(10)*, !dbg !222
        %211 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %210, 0, !dbg !222
        %212 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !222
        %213 = insertvalue [2 x {} addrspace(10)*] %211, {} addrspace(10)* %212, 1, !dbg !222
        %214 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !222
        %215 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %214, i64 0, !dbg !222
        %216 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !222, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %217 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !227
       %218 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %217, i64 0, !dbg !227
       %219 = add i32 %216, 1, !dbg !227
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %220 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !229
        %221 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %220, i64 0, !dbg !229
        %222 = addrspacecast {}* inttoptr (i64 129166957703792 to {}*) to {} addrspace(10)*, !dbg !229
        %223 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %222, 0, !dbg !229
        %224 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !229
        %225 = insertvalue [2 x {} addrspace(10)*] %223, {} addrspace(10)* %224, 1, !dbg !229
        %226 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !229
        %227 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %226, i64 0, !dbg !229
        %228 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !229, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %229 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !233
       %230 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %229, i64 0, !dbg !233
       %231 = add i32 %228, 1, !dbg !233
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %232 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !235
        %233 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %232, i64 0, !dbg !235
        %234 = addrspacecast {}* inttoptr (i64 129166957704288 to {}*) to {} addrspace(10)*, !dbg !235
        %235 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %234, 0, !dbg !235
        %236 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !235
        %237 = insertvalue [2 x {} addrspace(10)*] %235, {} addrspace(10)* %236, 1, !dbg !235
        %238 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !235
        %239 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %238, i64 0, !dbg !235
        %240 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !235, !range !117
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %241 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !239
       %242 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %241, i64 0, !dbg !239
       %243 = add i32 %240, 1, !dbg !239
; ││└└└
; ││┌ @ namedtuple.jl:244 within `==`
; │││┌ @ namedtuple.jl:197 within `Tuple`
      %244 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %245 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %244, i64 0, !dbg !241
      %246 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 0, !dbg !241
      %247 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %248 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %247, i64 0, !dbg !241
      %249 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 1, !dbg !241
      %250 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %251 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %250, i64 0, !dbg !241
      %252 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 2, !dbg !241
; │││└
; │││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││┌ @ tuple.jl:551 within `_eq`
; ││││┌ @ promotion.jl:639 within `==`
       %253 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !246
       %254 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %253, i64 0, !dbg !246
       %255 = load i32, i32 addrspace(5)* %246, align 4, !dbg !246, !tbaa !76, !alias.scope !80, !noalias !83
       %256 = icmp eq i32 %255, %219, !dbg !246
; ││││└
; ││││ @ tuple.jl:552 within `_eq`
      %257 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !252
      %258 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %257, i64 0, !dbg !252
      %259 = zext i1 %256 to i8, !dbg !252
      %260 = icmp eq i8 %259, 0, !dbg !252
      %261 = xor i1 %260, true, !dbg !252
      br i1 %261, label %L74, label %L73, !dbg !252

L73:                                              ; preds = %L53
; ││││ @ tuple.jl:553 within `_eq`
      br label %L87, !dbg !253

L74:                                              ; preds = %L53
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %262 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !254
       %263 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %262, i64 0, !dbg !254
       %264 = load i32, i32 addrspace(5)* %249, align 4, !dbg !254, !tbaa !76, !alias.scope !80, !noalias !83
       %265 = icmp eq i32 %264, %231, !dbg !254
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
      %266 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !257
      %267 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %266, i64 0, !dbg !257
      %268 = zext i1 %265 to i8, !dbg !257
      %269 = icmp eq i8 %268, 0, !dbg !257
      %270 = xor i1 %269, true, !dbg !257
      br i1 %270, label %L78, label %L77, !dbg !257

L77:                                              ; preds = %L74
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
      br label %L85, !dbg !258

L78:                                              ; preds = %L74
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %271 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !259
       %272 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %271, i64 0, !dbg !259
       %273 = load i32, i32 addrspace(5)* %252, align 4, !dbg !259, !tbaa !76, !alias.scope !80, !noalias !83
       %274 = icmp eq i32 %273, %243, !dbg !259
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
      %275 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !262
      %276 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %275, i64 0, !dbg !262
      %277 = zext i1 %274 to i8, !dbg !262
      %278 = icmp eq i8 %277, 0, !dbg !262
      %279 = xor i1 %278, true, !dbg !262
      br i1 %279, label %L82, label %L81, !dbg !262

L81:                                              ; preds = %L78
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
      br label %L83, !dbg !263

L82:                                              ; preds = %L78
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
      br label %L83, !dbg !264

L83:                                              ; preds = %L82, %L81
      %value_phi16 = phi i8 [ 0, %L81 ], [ 1, %L82 ]
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
      br label %L85, !dbg !261

L85:                                              ; preds = %L83, %L77
      %value_phi15 = phi i8 [ 0, %L77 ], [ %value_phi16, %L83 ]
; ││││ @ tuple.jl:557 within `_eq`
      br label %L87, !dbg !256

L87:                                              ; preds = %L85, %L73
      %value_phi11 = phi i8 [ 0, %L73 ], [ %value_phi15, %L85 ]
; │││└
     br label %L89, !dbg !250

L89:                                              ; preds = %L87
     br label %L90, !dbg !250

L90:                                              ; preds = %L89
; ││└
    %280 = trunc i8 %value_phi11 to i1, !dbg !197
    %281 = xor i1 %280, true, !dbg !197
    br i1 %281, label %L130, label %L91, !dbg !197

L91:                                              ; preds = %L90
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:35 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %282 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !265
       %283 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %282, i64 0, !dbg !265
       %284 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !265
       %285 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %284, i64 0, !dbg !265
       %286 = load i64, i64 addrspace(5)* %17, align 8, !dbg !265, !tbaa !76, !alias.scope !80, !noalias !83
; ││││└
      %287 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !266
      %288 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %287, i64 0, !dbg !266
      %289 = inttoptr i64 %286 to i8*, !dbg !266
      %290 = getelementptr i8, i8* %289, i64 20, !dbg !266
      %291 = ptrtoint i8* %290 to i64, !dbg !266
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %292 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !268
         %293 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %292, i64 0, !dbg !268
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %294 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !271
      %295 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %294, i64 0, !dbg !271
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %296 = bitcast {}* inttoptr (i64 129166849026880 to {}*) to {} addrspace(10)**, !dbg !272
      %297 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %296, i64 0, !dbg !272
      %298 = bitcast i8* %290 to [3 x i32]*, !dbg !272
      %299 = getelementptr inbounds [3 x i32], [3 x i32]* %298, i64 0, !dbg !272
      %300 = bitcast [3 x i32] addrspace(5)* %4 to i8 addrspace(5)*, !dbg !272
      %301 = bitcast [3 x i32]* %299 to i8*, !dbg !272
      call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %300, i8* align 1 %301, i64 12, i1 false), !dbg !272, !tbaa !219, !alias.scope !220, !noalias !221
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %302 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !274
        %303 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %302, i64 0, !dbg !274
        %304 = addrspacecast {}* inttoptr (i64 129166957706272 to {}*) to {} addrspace(10)*, !dbg !274
        %305 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %304, 0, !dbg !274
        %306 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !274
        %307 = insertvalue [2 x {} addrspace(10)*] %305, {} addrspace(10)* %306, 1, !dbg !274
        %308 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !274
        %309 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %308, i64 0, !dbg !274
        %310 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !274, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %311 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !279
       %312 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %311, i64 0, !dbg !279
       %313 = add i32 %310, 1, !dbg !279
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %314 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !281
        %315 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %314, i64 0, !dbg !281
        %316 = addrspacecast {}* inttoptr (i64 129166957706768 to {}*) to {} addrspace(10)*, !dbg !281
        %317 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %316, 0, !dbg !281
        %318 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !281
        %319 = insertvalue [2 x {} addrspace(10)*] %317, {} addrspace(10)* %318, 1, !dbg !281
        %320 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !281
        %321 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %320, i64 0, !dbg !281
        %322 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !281, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %323 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !285
       %324 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %323, i64 0, !dbg !285
       %325 = add i32 %322, 1, !dbg !285
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %326 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !287
        %327 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %326, i64 0, !dbg !287
        %328 = addrspacecast {}* inttoptr (i64 129166972486144 to {}*) to {} addrspace(10)*, !dbg !287
        %329 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %328, 0, !dbg !287
        %330 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !287
        %331 = insertvalue [2 x {} addrspace(10)*] %329, {} addrspace(10)* %330, 1, !dbg !287
        %332 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !287
        %333 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %332, i64 0, !dbg !287
        %334 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !287, !range !157
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %335 = bitcast {}* inttoptr (i64 129166849032928 to {}*) to {} addrspace(10)**, !dbg !291
       %336 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %335, i64 0, !dbg !291
       %337 = add i32 %334, 1, !dbg !291
; ││└└└
; ││┌ @ namedtuple.jl:244 within `==`
; │││┌ @ namedtuple.jl:197 within `Tuple`
      %338 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %339 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %338, i64 0, !dbg !241
      %340 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 0, !dbg !241
      %341 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %342 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %341, i64 0, !dbg !241
      %343 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 1, !dbg !241
      %344 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !241
      %345 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %344, i64 0, !dbg !241
      %346 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 2, !dbg !241
; │││└
; │││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││┌ @ tuple.jl:551 within `_eq`
; ││││┌ @ promotion.jl:639 within `==`
       %347 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !246
       %348 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %347, i64 0, !dbg !246
       %349 = load i32, i32 addrspace(5)* %340, align 4, !dbg !246, !tbaa !76, !alias.scope !80, !noalias !83
       %350 = icmp eq i32 %349, %313, !dbg !246
; ││││└
; ││││ @ tuple.jl:552 within `_eq`
      %351 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !252
      %352 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %351, i64 0, !dbg !252
      %353 = zext i1 %350 to i8, !dbg !252
      %354 = icmp eq i8 %353, 0, !dbg !252
      %355 = xor i1 %354, true, !dbg !252
      br i1 %355, label %L112, label %L111, !dbg !252

L111:                                             ; preds = %L91
; ││││ @ tuple.jl:553 within `_eq`
      br label %L125, !dbg !253

L112:                                             ; preds = %L91
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %356 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !254
       %357 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %356, i64 0, !dbg !254
       %358 = load i32, i32 addrspace(5)* %343, align 4, !dbg !254, !tbaa !76, !alias.scope !80, !noalias !83
       %359 = icmp eq i32 %358, %325, !dbg !254
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
      %360 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !257
      %361 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %360, i64 0, !dbg !257
      %362 = zext i1 %359 to i8, !dbg !257
      %363 = icmp eq i8 %362, 0, !dbg !257
      %364 = xor i1 %363, true, !dbg !257
      br i1 %364, label %L116, label %L115, !dbg !257

L115:                                             ; preds = %L112
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
      br label %L123, !dbg !258

L116:                                             ; preds = %L112
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %365 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !259
       %366 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %365, i64 0, !dbg !259
       %367 = load i32, i32 addrspace(5)* %346, align 4, !dbg !259, !tbaa !76, !alias.scope !80, !noalias !83
       %368 = icmp eq i32 %367, %337, !dbg !259
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
      %369 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !262
      %370 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %369, i64 0, !dbg !262
      %371 = zext i1 %368 to i8, !dbg !262
      %372 = icmp eq i8 %371, 0, !dbg !262
      %373 = xor i1 %372, true, !dbg !262
      br i1 %373, label %L120, label %L119, !dbg !262

L119:                                             ; preds = %L116
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
      br label %L121, !dbg !263

L120:                                             ; preds = %L116
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
      br label %L121, !dbg !264

L121:                                             ; preds = %L120, %L119
      %value_phi14 = phi i8 [ 0, %L119 ], [ 1, %L120 ]
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
      br label %L123, !dbg !261

L123:                                             ; preds = %L121, %L115
      %value_phi13 = phi i8 [ 0, %L115 ], [ %value_phi14, %L121 ]
; ││││ @ tuple.jl:557 within `_eq`
      br label %L125, !dbg !256

L125:                                             ; preds = %L123, %L111
      %value_phi12 = phi i8 [ 0, %L111 ], [ %value_phi13, %L123 ]
; │││└
     br label %L127, !dbg !250

L127:                                             ; preds = %L125
     br label %L128, !dbg !250

L128:                                             ; preds = %L127
; ││└
    %374 = trunc i8 %value_phi12 to i1, !dbg !197
    %375 = xor i1 %374, true, !dbg !197
    br i1 %375, label %L130, label %L129, !dbg !197

L129:                                             ; preds = %L128
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:124 within `lock_output!`
    br label %L131, !dbg !293

L130:                                             ; preds = %L128, %L90, %L46
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:127 within `lock_output!`
    br label %L131, !dbg !294

L131:                                             ; preds = %L130, %L129, %L12
    %value_phi = phi i8 [ 1, %L12 ], [ 1, %L129 ], [ 0, %L130 ]
; │└
   %376 = trunc i8 %value_phi to i1, !dbg !75
   %377 = xor i1 %376, true, !dbg !75
   br i1 %377, label %L287, label %L133, !dbg !75

L133:                                             ; preds = %L131
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:135 within `macro expansion`
; │┌ @ none within `alloc_string`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %378 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !295
     %379 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %378, i64 0, !dbg !295
     %380 = addrspacecast {}* inttoptr (i64 129166955008720 to {}*) to {} addrspace(10)*, !dbg !295
     %381 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %380, 0, !dbg !295
     %382 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !295
     %383 = insertvalue [2 x {} addrspace(10)*] %381, {} addrspace(10)* %382, 1, !dbg !295
     %384 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !295
     %385 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %384, i64 0, !dbg !295
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:136 within `macro expansion`
; │┌ @ essentials.jl:730 within `reinterpret`
    %386 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !300
    %387 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %386, i64 0, !dbg !300
    %388 = ptrtoint i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([12 x i8], [12 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*) to i64, !dbg !300
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:66 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %389 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !302
     %390 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %389, i64 0, !dbg !302
; ││└
    br label %L142, !dbg !304

L142:                                             ; preds = %L133
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:68 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %391 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !305
     %392 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %391, i64 0, !dbg !305
; ││└
    br label %L151, !dbg !306

L151:                                             ; preds = %L142
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:70 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %393 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !307
     %394 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %393, i64 0, !dbg !307
; ││└
    br label %L159, !dbg !308

L159:                                             ; preds = %L151
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:73 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %395 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !309
     %396 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %395, i64 0, !dbg !309
; ││└
    br label %L167, !dbg !310

L167:                                             ; preds = %L159
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:76 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %397 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !311
     %398 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %397, i64 0, !dbg !311
; ││└
    br label %L169, !dbg !312

L169:                                             ; preds = %L167
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:80 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %399 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !313
      %400 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %399, i64 0, !dbg !313
      %401 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !313
      %402 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %401, i64 0, !dbg !313
      %403 = load i64, i64 addrspace(5)* %17, align 8, !dbg !313, !tbaa !76, !alias.scope !80, !noalias !83
; │││└
     %404 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !314
     %405 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %404, i64 0, !dbg !314
     %406 = inttoptr i64 %403 to i8*, !dbg !314
     %407 = getelementptr i8, i8* %406, i64 32, !dbg !314
     %408 = ptrtoint i8* %407 to i64, !dbg !314
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %409 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !316
        %410 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %409, i64 0, !dbg !316
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %411 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !319
     %412 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %411, i64 0, !dbg !319
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %413 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !320
     %414 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %413, i64 0, !dbg !320
     %415 = bitcast i8* %407 to i64*, !dbg !320
     %416 = getelementptr inbounds i64, i64* %415, i64 0, !dbg !320
     store i64 %388, i64* %416, align 1, !dbg !320, !tbaa !205, !alias.scope !207, !noalias !208
     br label %L203, !dbg !320

L203:                                             ; preds = %L169
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:137 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/strings.jl:22 within `string_length`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/strings.jl:22 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %417 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !322
     %418 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %417, i64 0, !dbg !322
     %419 = addrspacecast {}* inttoptr (i64 129166962306896 to {}*) to {} addrspace(10)*, !dbg !322
     %420 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %419, 0, !dbg !322
     %421 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !322
     %422 = insertvalue [2 x {} addrspace(10)*] %420, {} addrspace(10)* %421, 1, !dbg !322
     %423 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !322
     %424 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %423, i64 0, !dbg !322
     %425 = addrspacecast i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([12 x i8], [12 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*) to i8 addrspace(1)**, !dbg !322
     %426 = bitcast i8 addrspace(1)** %425 to i8*, !dbg !322
     br label %check.i17, !dbg !322

check.i17:                                        ; preds = %check.i17, %L203
     %427 = phi i64 [ 0, %L203 ], [ %428, %check.i17 ], !dbg !322
     %428 = add i64 %427, 1, !dbg !322
     %429 = getelementptr i8, i8* %426, i64 %427, !dbg !322
     %430 = load i8, i8* %429, align 1, !dbg !322
     %431 = icmp eq i8 %430, 0, !dbg !322
     br i1 %431, label %julia__throw_boundserror_12110u12140.exit, label %check.i17, !dbg !322

julia__throw_boundserror_12110u12140.exit:        ; preds = %check.i17
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:92 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %432 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !329
      %433 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %432, i64 0, !dbg !329
      %434 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !329
      %435 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %434, i64 0, !dbg !329
      %436 = load i64, i64 addrspace(5)* %17, align 8, !dbg !329, !tbaa !76, !alias.scope !80, !noalias !83
; │││└
     %437 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !330
     %438 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %437, i64 0, !dbg !330
     %439 = inttoptr i64 %436 to i8*, !dbg !330
     %440 = getelementptr i8, i8* %439, i64 48, !dbg !330
     %441 = ptrtoint i8* %440 to i64, !dbg !330
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %442 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !332
        %443 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %442, i64 0, !dbg !332
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %444 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !335
     %445 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %444, i64 0, !dbg !335
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %446 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !336
     %447 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %446, i64 0, !dbg !336
     %448 = bitcast i8* %440 to i64*, !dbg !336
     %449 = getelementptr inbounds i64, i64* %448, i64 0, !dbg !336
     store i64 %427, i64* %449, align 1, !dbg !336, !tbaa !205, !alias.scope !207, !noalias !208
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:139 within `macro expansion`
; │┌ @ none within `alloc_string`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %450 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !338
     %451 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %450, i64 0, !dbg !338
     %452 = addrspacecast {}* inttoptr (i64 129166955009120 to {}*) to {} addrspace(10)*, !dbg !338
     %453 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %452, 0, !dbg !338
     %454 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !338
     %455 = insertvalue [2 x {} addrspace(10)*] %453, {} addrspace(10)* %454, 1, !dbg !338
     %456 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !338
     %457 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %456, i64 0, !dbg !338
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:140 within `macro expansion`
; │┌ @ essentials.jl:730 within `reinterpret`
    %458 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !342
    %459 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %458, i64 0, !dbg !342
    %460 = ptrtoint i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([27 x i8], [27 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*) to i64, !dbg !342
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:66 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %461 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !344
     %462 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %461, i64 0, !dbg !344
; ││└
    br label %L219, !dbg !345

L219:                                             ; preds = %julia__throw_boundserror_12110u12140.exit
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:68 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %463 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !346
     %464 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %463, i64 0, !dbg !346
; ││└
    br label %L228, !dbg !347

L228:                                             ; preds = %L219
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:70 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %465 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !348
     %466 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %465, i64 0, !dbg !348
; ││└
    br label %L236, !dbg !349

L236:                                             ; preds = %L228
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:73 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %467 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !350
     %468 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %467, i64 0, !dbg !350
; ││└
    br label %L244, !dbg !351

L244:                                             ; preds = %L236
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:76 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %469 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !352
     %470 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %469, i64 0, !dbg !352
; ││└
    br label %L252, !dbg !353

L252:                                             ; preds = %L244
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:81 within `setproperty!`
; ││┌ @ Base.jl:207 within `==`
     %471 = bitcast {}* inttoptr (i64 129166826185136 to {}*) to {} addrspace(10)**, !dbg !354
     %472 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %471, i64 0, !dbg !354
; ││└
    br label %L254, !dbg !355

L254:                                             ; preds = %L252
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:86 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %473 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !356
      %474 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %473, i64 0, !dbg !356
      %475 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !356
      %476 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %475, i64 0, !dbg !356
      %477 = load i64, i64 addrspace(5)* %17, align 8, !dbg !356, !tbaa !76, !alias.scope !80, !noalias !83
; │││└
     %478 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !357
     %479 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %478, i64 0, !dbg !357
     %480 = inttoptr i64 %477 to i8*, !dbg !357
     %481 = getelementptr i8, i8* %480, i64 40, !dbg !357
     %482 = ptrtoint i8* %481 to i64, !dbg !357
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %483 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !359
        %484 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %483, i64 0, !dbg !359
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %485 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !362
     %486 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %485, i64 0, !dbg !362
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %487 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !363
     %488 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %487, i64 0, !dbg !363
     %489 = bitcast i8* %481 to i64*, !dbg !363
     %490 = getelementptr inbounds i64, i64* %489, i64 0, !dbg !363
     store i64 %460, i64* %490, align 1, !dbg !363, !tbaa !205, !alias.scope !207, !noalias !208
     br label %L280, !dbg !363

L280:                                             ; preds = %L254
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:141 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/strings.jl:22 within `string_length`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/strings.jl:22 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %491 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !365
     %492 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %491, i64 0, !dbg !365
     %493 = addrspacecast {}* inttoptr (i64 129166962306896 to {}*) to {} addrspace(10)*, !dbg !365
     %494 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %493, 0, !dbg !365
     %495 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !365
     %496 = insertvalue [2 x {} addrspace(10)*] %494, {} addrspace(10)* %495, 1, !dbg !365
     %497 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !365
     %498 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %497, i64 0, !dbg !365
     %499 = addrspacecast i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([27 x i8], [27 x i8]* @1, i32 0, i32 0) to i8 addrspace(1)*) to i8 addrspace(1)**, !dbg !365
     %500 = bitcast i8 addrspace(1)** %499 to i8*, !dbg !365
     br label %check.i, !dbg !365

check.i:                                          ; preds = %check.i, %L280
     %501 = phi i64 [ 0, %L280 ], [ %502, %check.i ], !dbg !365
     %502 = add i64 %501, 1, !dbg !365
     %503 = getelementptr i8, i8* %500, i64 %501, !dbg !365
     %504 = load i8, i8* %503, align 1, !dbg !365
     %505 = icmp eq i8 %504, 0, !dbg !365
     br i1 %505, label %julia__throw_boundserror_12110u12143.exit, label %check.i, !dbg !365

julia__throw_boundserror_12110u12143.exit:        ; preds = %check.i
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:99 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %506 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !369
      %507 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %506, i64 0, !dbg !369
      %508 = bitcast {}* inttoptr (i64 129166809243792 to {}*) to {} addrspace(10)**, !dbg !369
      %509 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %508, i64 0, !dbg !369
      %510 = load i64, i64 addrspace(5)* %17, align 8, !dbg !369, !tbaa !76, !alias.scope !80, !noalias !83
; │││└
     %511 = bitcast {}* inttoptr (i64 129166849032144 to {}*) to {} addrspace(10)**, !dbg !370
     %512 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %511, i64 0, !dbg !370
     %513 = inttoptr i64 %510 to i8*, !dbg !370
     %514 = getelementptr i8, i8* %513, i64 56, !dbg !370
     %515 = ptrtoint i8* %514 to i64, !dbg !370
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %516 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !372
        %517 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %516, i64 0, !dbg !372
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %518 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !375
     %519 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %518, i64 0, !dbg !375
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %520 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !376
     %521 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %520, i64 0, !dbg !376
     %522 = bitcast i8* %514 to i64*, !dbg !376
     %523 = getelementptr inbounds i64, i64* %522, i64 0, !dbg !376
     store i64 %501, i64* %523, align 1, !dbg !376, !tbaa !205, !alias.scope !207, !noalias !208
     br label %L287, !dbg !376

L287:                                             ; preds = %julia__throw_boundserror_12110u12143.exit, %L131
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:144 within `macro expansion`
   %524 = bitcast {}* inttoptr (i64 129166831250624 to {}*) to {} addrspace(10)**, !dbg !378
   %525 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %524, i64 0, !dbg !378
   %526 = bitcast {}* inttoptr (i64 129166805867440 to {}*) to {} addrspace(10)**, !dbg !378
   %527 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %526, i64 0, !dbg !378
   %528 = load {}*, {}* addrspace(1)* @jl_nothing, align 8, !dbg !378, !tbaa !379, !invariant.load !49, !alias.scope !381, !noalias !382, !nonnull !49
   call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8] addrspace(1)* @exception to i64)), !dbg !378
   call fastcc void @gpu_signal_exception(), !dbg !378
   call void @llvm.trap(), !dbg !378
   unreachable, !dbg !378
; └
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0i8.p5i8.i64(i8* noalias nocapture writeonly, i8 addrspace(5)* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: memory(none)
declare [5 x i64] @julia.gpu.state_getter() local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.y() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.z() #5

;  @ /home/pxlth/.julia/dev/t.jl:3 within `ker!`
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE({ [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #6 !dbg !383 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %0, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, align 8
  br label %top

top:                                              ; preds = %conversion
  %pgcstack = call {}*** @julia.get_pgcstack()
  %3 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %3, i64 -14
  %4 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %4, i64 15
;  @ /home/pxlth/.julia/dev/t.jl:4 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `#setindex!`
   br label %L3, !dbg !385

L3:                                               ; preds = %top
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:389 within `eachindex`
; │││┌ @ abstractarray.jl:137 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %5 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !389
         %6 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %5, i64 0, !dbg !389
         %7 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 0, !dbg !389
; │││││└└
; │││││┌ @ tuple.jl:355 within `map`
; ││││││┌ @ tuple.jl:31 within `getindex`
         %8 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !403
         %9 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %8, i64 0, !dbg !403
         %10 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %7, i32 0, i32 0, !dbg !403
; ││└└└└└
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ essentials.jl:668 within `unsigned`
; ││││┌ @ essentials.jl:730 within `reinterpret`
       %11 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !407
       %12 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %11, i64 0, !dbg !407
       %13 = load i64, i64 addrspace(11)* %10, align 8, !dbg !407, !alias.scope !381, !noalias !382
; │││└└
; │││┌ @ int.jl:513 within `<`
      %14 = bitcast {}* inttoptr (i64 129166849030800 to {}*) to {} addrspace(10)**, !dbg !413
      %15 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %14, i64 0, !dbg !413
      %16 = icmp ult i64 -1, %13, !dbg !413
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    %17 = xor i1 %16, true, !dbg !402
    br i1 %17, label %L10, label %L9, !dbg !402

L9:                                               ; preds = %L3
    br label %L12, !dbg !402

L10:                                              ; preds = %L3
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:36 within `#throw_boundserror`
     %18 = bitcast {}* inttoptr (i64 129163071466704 to {}*) to {} addrspace(10)**, !dbg !415
     %19 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %18, i64 0, !dbg !415
     call fastcc void @julia__throw_boundserror_12110() #9, !dbg !415
     unreachable, !dbg !415

L12:                                              ; preds = %L9
; ││└
    br label %L13, !dbg !402

L13:                                              ; preds = %L12
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#setindex!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
; │││┌ @ Base.jl:49 within `getproperty`
      %20 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !417
      %21 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %20, i64 0, !dbg !417
      %22 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 1, !dbg !417
; │└└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %23 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !423
      %24 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %23, i64 0, !dbg !423
      %25 = addrspacecast {}* inttoptr (i64 129166958909760 to {}*) to {} addrspace(10)*, !dbg !423
      %26 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %25, 0, !dbg !423
      %27 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !423
      %28 = insertvalue [2 x {} addrspace(10)*] %26, {} addrspace(10)* %27, 1, !dbg !423
      %29 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !423
      %30 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %29, i64 0, !dbg !423
      %31 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %22, align 8, !dbg !423, !alias.scope !381, !noalias !382
      %32 = bitcast i8 addrspace(1)* %31 to i64 addrspace(1)*, !dbg !423
      %33 = getelementptr inbounds i64, i64 addrspace(1)* %32, i64 -1, !dbg !423
      store i64 1, i64 addrspace(1)* %33, align 8, !dbg !423, !tbaa !432
; │└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#setindex!`
   br label %L17, !dbg !435

L17:                                              ; preds = %L13
; └
;  @ /home/pxlth/.julia/dev/t.jl:5 within `ker!`
  ret void, !dbg !436
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:150 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception(i64 zeroext %0) unnamed_addr #7 !dbg !437 {
top:
  %pgcstack = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -14
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 15
  ret void, !dbg !438
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:112 within `signal_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #7 !dbg !439 {
top:
  %0 = alloca [5 x i64], align 8, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -14
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 15
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
    %3 = bitcast {}* inttoptr (i64 129166817681536 to {}*) to {} addrspace(10)**, !dbg !440
    %4 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %3, i64 0, !dbg !440
    %5 = addrspacecast {}* inttoptr (i64 129158417955584 to {}*) to {} addrspace(10)*, !dbg !440
    %6 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %5, 0, !dbg !440
    %7 = addrspacecast {}* inttoptr (i64 129163213313584 to {}*) to {} addrspace(10)*, !dbg !440
    %8 = insertvalue [2 x {} addrspace(10)*] %6, {} addrspace(10)* %7, 1, !dbg !440
    %9 = bitcast {}* inttoptr (i64 129166814196176 to {}*) to {} addrspace(10)**, !dbg !440
    %10 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %9, i64 0, !dbg !440
    %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !440
    store [5 x i64] %state.i, [5 x i64] addrspace(5)* %0, align 8, !dbg !440
; └└
; ┌ @ Base.jl:49 within `getproperty`
   %11 = bitcast {}* inttoptr (i64 129166805418960 to {}*) to {} addrspace(10)**, !dbg !447
   %12 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %11, i64 0, !dbg !447
   %13 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !447
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:114 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:67 within `setproperty!`
; │┌ @ pointer.jl:30 within `convert`
    %14 = bitcast {}* inttoptr (i64 129166840752880 to {}*) to {} addrspace(10)**, !dbg !449
    %15 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %14, i64 0, !dbg !449
    %16 = load i64, i64 addrspace(5)* %13, align 8, !dbg !449, !tbaa !76, !alias.scope !80, !noalias !83
; │└
; │┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
    %17 = bitcast {}* inttoptr (i64 129166849026768 to {}*) to {} addrspace(10)**, !dbg !454
    %18 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %17, i64 0, !dbg !454
    %19 = inttoptr i64 %16 to i8*, !dbg !454
    %20 = getelementptr inbounds i8, i8* %19, i64 0, !dbg !454
    %21 = bitcast i8* %20 to i32*, !dbg !454
    %22 = load i32, i32 addrspace(1)* @_j_const_1, align 4, !dbg !454, !tbaa !457, !alias.scope !207, !noalias !208
    store i32 %22, i32* %21, align 1, !dbg !454
; └└
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:127 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
   call void @llvm.amdgcn.endpgm(), !dbg !460
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:128 within `signal_exception`
  unreachable, !dbg !464
}

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #8

attributes #0 = { cold noreturn nounwind }
attributes #1 = { alwaysinline noinline noreturn }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { convergent nocallback nofree nounwind willreturn }
attributes #4 = { memory(none) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #7 = { alwaysinline }
attributes #8 = { cold nocallback nofree noreturn nounwind }
attributes #9 = { noreturn }

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
!45 = !{void ({ [1 x i64], i8 addrspace(1)*, i64 })* @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!46 = distinct !DISubprogram(name: "_throw_boundserror", linkageName: "julia__throw_boundserror_12110", scope: null, file: !47, line: 35, type: !48, scopeLine: 35, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!47 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!48 = !DISubroutineType(types: !49)
!49 = !{}
!50 = !DILocation(line: 39, scope: !51, inlinedAt: !53)
!51 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !52, file: !52, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!52 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!53 = !DILocation(line: 0, scope: !54, inlinedAt: !56)
!54 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!55 = !DIFile(filename: "none", directory: ".")
!56 = !DILocation(line: 0, scope: !57, inlinedAt: !58)
!57 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!58 = !DILocation(line: 133, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!60 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!61 = !DILocation(line: 35, scope: !46)
!62 = !DILocation(line: 49, scope: !63, inlinedAt: !58)
!63 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !64, file: !64, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!64 = !DIFile(filename: "Base.jl", directory: ".")
!65 = !DILocation(line: 903, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !67, file: !67, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!67 = !DIFile(filename: "boot.jl", directory: ".")
!68 = !DILocation(line: 316, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!70 = !DIFile(filename: "pointer.jl", directory: ".")
!71 = !DILocation(line: 29, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!73 = !DILocation(line: 112, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!75 = !DILocation(line: 134, scope: !59, inlinedAt: !61)
!76 = !{!77, !77, i64 0}
!77 = !{!"jtbaa_stack", !78, i64 0}
!78 = !{!"jtbaa", !79, i64 0}
!79 = !{!"jtbaa"}
!80 = !{!81}
!81 = !{!"jnoalias_stack", !82}
!82 = !{!"jnoalias"}
!83 = !{!84, !85, !86, !87}
!84 = !{!"jnoalias_gcframe", !82}
!85 = !{!"jnoalias_data", !82}
!86 = !{!"jnoalias_typemd", !82}
!87 = !{!"jnoalias_const", !82}
!88 = !DILocation(line: 908, scope: !89, inlinedAt: !90)
!89 = distinct !DISubprogram(name: "Ptr;", linkageName: "Ptr", scope: !67, file: !67, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!90 = !DILocation(line: 26, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!92 = !DILocation(line: 666, scope: !93, inlinedAt: !68)
!93 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!94 = !DIFile(filename: "essentials.jl", directory: ".")
!95 = !DILocation(line: 730, scope: !96, inlinedAt: !71)
!96 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!97 = !DILocation(line: 39, scope: !51, inlinedAt: !98)
!98 = !DILocation(line: 37, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !100, file: !100, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!100 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!101 = !DILocation(line: 37, scope: !102, inlinedAt: !73)
!102 = distinct !DISubprogram(name: "llvm_atomic_cas;", linkageName: "llvm_atomic_cas", scope: !100, file: !100, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!103 = !DILocation(line: 639, scope: !104, inlinedAt: !73)
!104 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !105, file: !105, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!105 = !DIFile(filename: "promotion.jl", directory: ".")
!106 = !DILocation(line: 39, scope: !51, inlinedAt: !107)
!107 = !DILocation(line: 3, scope: !108, inlinedAt: !110)
!108 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!109 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!110 = !DILocation(line: 3, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!112 = !DILocation(line: 87, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!114 = !DILocation(line: 122, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!116 = !DILocation(line: 114, scope: !74, inlinedAt: !75)
!117 = !{i32 0, i32 1023}
!118 = !DILocation(line: 87, scope: !119, inlinedAt: !121)
!119 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !120, file: !120, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!120 = !DIFile(filename: "int.jl", directory: ".")
!121 = !DILocation(line: 1013, scope: !119, inlinedAt: !112)
!122 = !DILocation(line: 39, scope: !51, inlinedAt: !123)
!123 = !DILocation(line: 3, scope: !108, inlinedAt: !124)
!124 = !DILocation(line: 3, scope: !111, inlinedAt: !125)
!125 = !DILocation(line: 87, scope: !126, inlinedAt: !114)
!126 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!127 = !DILocation(line: 87, scope: !119, inlinedAt: !128)
!128 = !DILocation(line: 1013, scope: !119, inlinedAt: !125)
!129 = !DILocation(line: 39, scope: !51, inlinedAt: !130)
!130 = !DILocation(line: 3, scope: !108, inlinedAt: !131)
!131 = !DILocation(line: 3, scope: !111, inlinedAt: !132)
!132 = !DILocation(line: 87, scope: !133, inlinedAt: !114)
!133 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!134 = !DILocation(line: 87, scope: !119, inlinedAt: !135)
!135 = !DILocation(line: 1013, scope: !119, inlinedAt: !132)
!136 = !DILocation(line: 727, scope: !137, inlinedAt: !114)
!137 = distinct !DISubprogram(name: "NamedTuple;", linkageName: "NamedTuple", scope: !67, file: !67, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!138 = !DILocation(line: 903, scope: !66, inlinedAt: !139)
!139 = !DILocation(line: 316, scope: !69, inlinedAt: !140)
!140 = !DILocation(line: 72, scope: !141, inlinedAt: !116)
!141 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!142 = !DILocation(line: 908, scope: !89, inlinedAt: !143)
!143 = !DILocation(line: 26, scope: !91, inlinedAt: !144)
!144 = !DILocation(line: 666, scope: !93, inlinedAt: !139)
!145 = !DILocation(line: 30, scope: !91, inlinedAt: !140)
!146 = !DILocation(line: 180, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!148 = !DILocation(line: 180, scope: !147, inlinedAt: !140)
!149 = !DILocation(line: 39, scope: !51, inlinedAt: !150)
!150 = !DILocation(line: 3, scope: !108, inlinedAt: !151)
!151 = !DILocation(line: 3, scope: !111, inlinedAt: !152)
!152 = !DILocation(line: 93, scope: !153, inlinedAt: !154)
!153 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!154 = !DILocation(line: 130, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!156 = !DILocation(line: 115, scope: !74, inlinedAt: !75)
!157 = !{i32 0, i32 -2}
!158 = !DILocation(line: 87, scope: !119, inlinedAt: !159)
!159 = !DILocation(line: 1013, scope: !119, inlinedAt: !152)
!160 = !DILocation(line: 39, scope: !51, inlinedAt: !161)
!161 = !DILocation(line: 3, scope: !108, inlinedAt: !162)
!162 = !DILocation(line: 3, scope: !111, inlinedAt: !163)
!163 = !DILocation(line: 93, scope: !164, inlinedAt: !154)
!164 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!165 = !DILocation(line: 87, scope: !119, inlinedAt: !166)
!166 = !DILocation(line: 1013, scope: !119, inlinedAt: !163)
!167 = !DILocation(line: 39, scope: !51, inlinedAt: !168)
!168 = !DILocation(line: 3, scope: !108, inlinedAt: !169)
!169 = !DILocation(line: 3, scope: !111, inlinedAt: !170)
!170 = !DILocation(line: 93, scope: !171, inlinedAt: !154)
!171 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !109, file: !109, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!172 = !DILocation(line: 87, scope: !119, inlinedAt: !173)
!173 = !DILocation(line: 1013, scope: !119, inlinedAt: !170)
!174 = !DILocation(line: 727, scope: !137, inlinedAt: !154)
!175 = !DILocation(line: 903, scope: !66, inlinedAt: !176)
!176 = !DILocation(line: 316, scope: !69, inlinedAt: !177)
!177 = !DILocation(line: 75, scope: !141, inlinedAt: !156)
!178 = !DILocation(line: 908, scope: !89, inlinedAt: !179)
!179 = !DILocation(line: 26, scope: !91, inlinedAt: !180)
!180 = !DILocation(line: 666, scope: !93, inlinedAt: !176)
!181 = !DILocation(line: 30, scope: !91, inlinedAt: !177)
!182 = !DILocation(line: 180, scope: !147, inlinedAt: !183)
!183 = !DILocation(line: 180, scope: !147, inlinedAt: !177)
!184 = !DILocation(line: 5, scope: !185, inlinedAt: !187)
!185 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !186, file: !186, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!186 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!187 = !DILocation(line: 27, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !186, file: !186, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!189 = !DILocation(line: 116, scope: !74, inlinedAt: !75)
!190 = !DILocation(line: 28, scope: !188, inlinedAt: !189)
!191 = !DILocation(line: 5, scope: !185, inlinedAt: !192)
!192 = !DILocation(line: 29, scope: !188, inlinedAt: !189)
!193 = !DILocation(line: 117, scope: !74, inlinedAt: !75)
!194 = !DILocation(line: 903, scope: !66, inlinedAt: !195)
!195 = !DILocation(line: 316, scope: !69, inlinedAt: !196)
!196 = !DILocation(line: 27, scope: !72, inlinedAt: !197)
!197 = !DILocation(line: 118, scope: !74, inlinedAt: !75)
!198 = !DILocation(line: 908, scope: !89, inlinedAt: !199)
!199 = !DILocation(line: 26, scope: !91, inlinedAt: !200)
!200 = !DILocation(line: 666, scope: !93, inlinedAt: !195)
!201 = !DILocation(line: 30, scope: !91, inlinedAt: !196)
!202 = !DILocation(line: 153, scope: !203, inlinedAt: !204)
!203 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!204 = !DILocation(line: 153, scope: !203, inlinedAt: !196)
!205 = !{!206, !206, i64 0}
!206 = !{!"jtbaa_data", !78, i64 0}
!207 = !{!85}
!208 = !{!84, !81, !86, !87}
!209 = !DILocation(line: 639, scope: !104, inlinedAt: !197)
!210 = !DILocation(line: 903, scope: !66, inlinedAt: !211)
!211 = !DILocation(line: 316, scope: !69, inlinedAt: !212)
!212 = !DILocation(line: 32, scope: !72, inlinedAt: !197)
!213 = !DILocation(line: 908, scope: !89, inlinedAt: !214)
!214 = !DILocation(line: 26, scope: !91, inlinedAt: !215)
!215 = !DILocation(line: 666, scope: !93, inlinedAt: !211)
!216 = !DILocation(line: 30, scope: !91, inlinedAt: !212)
!217 = !DILocation(line: 153, scope: !203, inlinedAt: !218)
!218 = !DILocation(line: 153, scope: !203, inlinedAt: !212)
!219 = !{!78, !78, i64 0}
!220 = !{!85, !81}
!221 = !{!84, !86, !87}
!222 = !DILocation(line: 39, scope: !51, inlinedAt: !223)
!223 = !DILocation(line: 3, scope: !108, inlinedAt: !224)
!224 = !DILocation(line: 3, scope: !111, inlinedAt: !225)
!225 = !DILocation(line: 87, scope: !113, inlinedAt: !226)
!226 = !DILocation(line: 122, scope: !115, inlinedAt: !197)
!227 = !DILocation(line: 87, scope: !119, inlinedAt: !228)
!228 = !DILocation(line: 1013, scope: !119, inlinedAt: !225)
!229 = !DILocation(line: 39, scope: !51, inlinedAt: !230)
!230 = !DILocation(line: 3, scope: !108, inlinedAt: !231)
!231 = !DILocation(line: 3, scope: !111, inlinedAt: !232)
!232 = !DILocation(line: 87, scope: !126, inlinedAt: !226)
!233 = !DILocation(line: 87, scope: !119, inlinedAt: !234)
!234 = !DILocation(line: 1013, scope: !119, inlinedAt: !232)
!235 = !DILocation(line: 39, scope: !51, inlinedAt: !236)
!236 = !DILocation(line: 3, scope: !108, inlinedAt: !237)
!237 = !DILocation(line: 3, scope: !111, inlinedAt: !238)
!238 = !DILocation(line: 87, scope: !133, inlinedAt: !226)
!239 = !DILocation(line: 87, scope: !119, inlinedAt: !240)
!240 = !DILocation(line: 1013, scope: !119, inlinedAt: !238)
!241 = !DILocation(line: 197, scope: !242, inlinedAt: !244)
!242 = distinct !DISubprogram(name: "Tuple;", linkageName: "Tuple", scope: !243, file: !243, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!243 = !DIFile(filename: "namedtuple.jl", directory: ".")
!244 = !DILocation(line: 244, scope: !245, inlinedAt: !197)
!245 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !243, file: !243, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!246 = !DILocation(line: 639, scope: !104, inlinedAt: !247)
!247 = !DILocation(line: 551, scope: !248, inlinedAt: !250)
!248 = distinct !DISubprogram(name: "_eq;", linkageName: "_eq", scope: !249, file: !249, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!249 = !DIFile(filename: "tuple.jl", directory: ".")
!250 = !DILocation(line: 547, scope: !251, inlinedAt: !244)
!251 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !249, file: !249, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!252 = !DILocation(line: 552, scope: !248, inlinedAt: !250)
!253 = !DILocation(line: 553, scope: !248, inlinedAt: !250)
!254 = !DILocation(line: 639, scope: !104, inlinedAt: !255)
!255 = !DILocation(line: 551, scope: !248, inlinedAt: !256)
!256 = !DILocation(line: 557, scope: !248, inlinedAt: !250)
!257 = !DILocation(line: 552, scope: !248, inlinedAt: !256)
!258 = !DILocation(line: 553, scope: !248, inlinedAt: !256)
!259 = !DILocation(line: 639, scope: !104, inlinedAt: !260)
!260 = !DILocation(line: 551, scope: !248, inlinedAt: !261)
!261 = !DILocation(line: 557, scope: !248, inlinedAt: !256)
!262 = !DILocation(line: 552, scope: !248, inlinedAt: !261)
!263 = !DILocation(line: 553, scope: !248, inlinedAt: !261)
!264 = !DILocation(line: 557, scope: !248, inlinedAt: !261)
!265 = !DILocation(line: 903, scope: !66, inlinedAt: !266)
!266 = !DILocation(line: 316, scope: !69, inlinedAt: !267)
!267 = !DILocation(line: 35, scope: !72, inlinedAt: !197)
!268 = !DILocation(line: 908, scope: !89, inlinedAt: !269)
!269 = !DILocation(line: 26, scope: !91, inlinedAt: !270)
!270 = !DILocation(line: 666, scope: !93, inlinedAt: !266)
!271 = !DILocation(line: 30, scope: !91, inlinedAt: !267)
!272 = !DILocation(line: 153, scope: !203, inlinedAt: !273)
!273 = !DILocation(line: 153, scope: !203, inlinedAt: !267)
!274 = !DILocation(line: 39, scope: !51, inlinedAt: !275)
!275 = !DILocation(line: 3, scope: !108, inlinedAt: !276)
!276 = !DILocation(line: 3, scope: !111, inlinedAt: !277)
!277 = !DILocation(line: 93, scope: !153, inlinedAt: !278)
!278 = !DILocation(line: 130, scope: !155, inlinedAt: !197)
!279 = !DILocation(line: 87, scope: !119, inlinedAt: !280)
!280 = !DILocation(line: 1013, scope: !119, inlinedAt: !277)
!281 = !DILocation(line: 39, scope: !51, inlinedAt: !282)
!282 = !DILocation(line: 3, scope: !108, inlinedAt: !283)
!283 = !DILocation(line: 3, scope: !111, inlinedAt: !284)
!284 = !DILocation(line: 93, scope: !164, inlinedAt: !278)
!285 = !DILocation(line: 87, scope: !119, inlinedAt: !286)
!286 = !DILocation(line: 1013, scope: !119, inlinedAt: !284)
!287 = !DILocation(line: 39, scope: !51, inlinedAt: !288)
!288 = !DILocation(line: 3, scope: !108, inlinedAt: !289)
!289 = !DILocation(line: 3, scope: !111, inlinedAt: !290)
!290 = !DILocation(line: 93, scope: !171, inlinedAt: !278)
!291 = !DILocation(line: 87, scope: !119, inlinedAt: !292)
!292 = !DILocation(line: 1013, scope: !119, inlinedAt: !290)
!293 = !DILocation(line: 124, scope: !74, inlinedAt: !75)
!294 = !DILocation(line: 127, scope: !74, inlinedAt: !75)
!295 = !DILocation(line: 39, scope: !51, inlinedAt: !296)
!296 = !DILocation(line: 0, scope: !54, inlinedAt: !297)
!297 = !DILocation(line: 0, scope: !298, inlinedAt: !299)
!298 = distinct !DISubprogram(name: "alloc_string;", linkageName: "alloc_string", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!299 = !DILocation(line: 135, scope: !59, inlinedAt: !61)
!300 = !DILocation(line: 730, scope: !96, inlinedAt: !301)
!301 = !DILocation(line: 136, scope: !59, inlinedAt: !61)
!302 = !DILocation(line: 207, scope: !303, inlinedAt: !304)
!303 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !64, file: !64, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!304 = !DILocation(line: 66, scope: !141, inlinedAt: !301)
!305 = !DILocation(line: 207, scope: !303, inlinedAt: !306)
!306 = !DILocation(line: 68, scope: !141, inlinedAt: !301)
!307 = !DILocation(line: 207, scope: !303, inlinedAt: !308)
!308 = !DILocation(line: 70, scope: !141, inlinedAt: !301)
!309 = !DILocation(line: 207, scope: !303, inlinedAt: !310)
!310 = !DILocation(line: 73, scope: !141, inlinedAt: !301)
!311 = !DILocation(line: 207, scope: !303, inlinedAt: !312)
!312 = !DILocation(line: 76, scope: !141, inlinedAt: !301)
!313 = !DILocation(line: 903, scope: !66, inlinedAt: !314)
!314 = !DILocation(line: 316, scope: !69, inlinedAt: !315)
!315 = !DILocation(line: 80, scope: !141, inlinedAt: !301)
!316 = !DILocation(line: 908, scope: !89, inlinedAt: !317)
!317 = !DILocation(line: 26, scope: !91, inlinedAt: !318)
!318 = !DILocation(line: 666, scope: !93, inlinedAt: !314)
!319 = !DILocation(line: 30, scope: !91, inlinedAt: !315)
!320 = !DILocation(line: 180, scope: !147, inlinedAt: !321)
!321 = !DILocation(line: 180, scope: !147, inlinedAt: !315)
!322 = !DILocation(line: 39, scope: !51, inlinedAt: !323)
!323 = !DILocation(line: 22, scope: !324, inlinedAt: !326)
!324 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !325, file: !325, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!325 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/strings.jl", directory: ".")
!326 = !DILocation(line: 22, scope: !327, inlinedAt: !328)
!327 = distinct !DISubprogram(name: "string_length;", linkageName: "string_length", scope: !325, file: !325, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !49)
!328 = !DILocation(line: 137, scope: !59, inlinedAt: !61)
!329 = !DILocation(line: 903, scope: !66, inlinedAt: !330)
!330 = !DILocation(line: 316, scope: !69, inlinedAt: !331)
!331 = !DILocation(line: 92, scope: !141, inlinedAt: !328)
!332 = !DILocation(line: 908, scope: !89, inlinedAt: !333)
!333 = !DILocation(line: 26, scope: !91, inlinedAt: !334)
!334 = !DILocation(line: 666, scope: !93, inlinedAt: !330)
!335 = !DILocation(line: 30, scope: !91, inlinedAt: !331)
!336 = !DILocation(line: 180, scope: !147, inlinedAt: !337)
!337 = !DILocation(line: 180, scope: !147, inlinedAt: !331)
!338 = !DILocation(line: 39, scope: !51, inlinedAt: !339)
!339 = !DILocation(line: 0, scope: !54, inlinedAt: !340)
!340 = !DILocation(line: 0, scope: !298, inlinedAt: !341)
!341 = !DILocation(line: 139, scope: !59, inlinedAt: !61)
!342 = !DILocation(line: 730, scope: !96, inlinedAt: !343)
!343 = !DILocation(line: 140, scope: !59, inlinedAt: !61)
!344 = !DILocation(line: 207, scope: !303, inlinedAt: !345)
!345 = !DILocation(line: 66, scope: !141, inlinedAt: !343)
!346 = !DILocation(line: 207, scope: !303, inlinedAt: !347)
!347 = !DILocation(line: 68, scope: !141, inlinedAt: !343)
!348 = !DILocation(line: 207, scope: !303, inlinedAt: !349)
!349 = !DILocation(line: 70, scope: !141, inlinedAt: !343)
!350 = !DILocation(line: 207, scope: !303, inlinedAt: !351)
!351 = !DILocation(line: 73, scope: !141, inlinedAt: !343)
!352 = !DILocation(line: 207, scope: !303, inlinedAt: !353)
!353 = !DILocation(line: 76, scope: !141, inlinedAt: !343)
!354 = !DILocation(line: 207, scope: !303, inlinedAt: !355)
!355 = !DILocation(line: 81, scope: !141, inlinedAt: !343)
!356 = !DILocation(line: 903, scope: !66, inlinedAt: !357)
!357 = !DILocation(line: 316, scope: !69, inlinedAt: !358)
!358 = !DILocation(line: 86, scope: !141, inlinedAt: !343)
!359 = !DILocation(line: 908, scope: !89, inlinedAt: !360)
!360 = !DILocation(line: 26, scope: !91, inlinedAt: !361)
!361 = !DILocation(line: 666, scope: !93, inlinedAt: !357)
!362 = !DILocation(line: 30, scope: !91, inlinedAt: !358)
!363 = !DILocation(line: 180, scope: !147, inlinedAt: !364)
!364 = !DILocation(line: 180, scope: !147, inlinedAt: !358)
!365 = !DILocation(line: 39, scope: !51, inlinedAt: !366)
!366 = !DILocation(line: 22, scope: !324, inlinedAt: !367)
!367 = !DILocation(line: 22, scope: !327, inlinedAt: !368)
!368 = !DILocation(line: 141, scope: !59, inlinedAt: !61)
!369 = !DILocation(line: 903, scope: !66, inlinedAt: !370)
!370 = !DILocation(line: 316, scope: !69, inlinedAt: !371)
!371 = !DILocation(line: 99, scope: !141, inlinedAt: !368)
!372 = !DILocation(line: 908, scope: !89, inlinedAt: !373)
!373 = !DILocation(line: 26, scope: !91, inlinedAt: !374)
!374 = !DILocation(line: 666, scope: !93, inlinedAt: !370)
!375 = !DILocation(line: 30, scope: !91, inlinedAt: !371)
!376 = !DILocation(line: 180, scope: !147, inlinedAt: !377)
!377 = !DILocation(line: 180, scope: !147, inlinedAt: !371)
!378 = !DILocation(line: 144, scope: !59, inlinedAt: !61)
!379 = !{!380, !380, i64 0, i64 1}
!380 = !{!"jtbaa_const", !78, i64 0}
!381 = !{!87}
!382 = !{!84, !81, !85, !86}
!383 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_12098", scope: null, file: !384, line: 3, type: !48, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!384 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!385 = !DILocation(line: 85, scope: !386, inlinedAt: !388)
!386 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !387, file: !387, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!387 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!388 = !DILocation(line: 4, scope: !383)
!389 = !DILocation(line: 49, scope: !390, inlinedAt: !391)
!390 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !64, file: !64, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!391 = !DILocation(line: 67, scope: !392, inlinedAt: !393)
!392 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !387, file: !387, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!393 = !DILocation(line: 98, scope: !394, inlinedAt: !396)
!394 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !395, file: !395, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!395 = !DIFile(filename: "abstractarray.jl", directory: ".")
!396 = !DILocation(line: 137, scope: !397, inlinedAt: !398)
!397 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !395, file: !395, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!398 = !DILocation(line: 389, scope: !399, inlinedAt: !400)
!399 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !395, file: !395, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!400 = !DILocation(line: 689, scope: !401, inlinedAt: !402)
!401 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !395, file: !395, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!402 = !DILocation(line: 699, scope: !401, inlinedAt: !385)
!403 = !DILocation(line: 31, scope: !404, inlinedAt: !405)
!404 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !249, file: !249, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!405 = !DILocation(line: 355, scope: !406, inlinedAt: !393)
!406 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !249, file: !249, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!407 = !DILocation(line: 730, scope: !408, inlinedAt: !409)
!408 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!409 = !DILocation(line: 668, scope: !410, inlinedAt: !411)
!410 = distinct !DISubprogram(name: "unsigned;", linkageName: "unsigned", scope: !94, file: !94, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!411 = !DILocation(line: 754, scope: !412, inlinedAt: !400)
!412 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !395, file: !395, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!413 = !DILocation(line: 513, scope: !414, inlinedAt: !411)
!414 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !120, file: !120, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!415 = !DILocation(line: 36, scope: !416, inlinedAt: !402)
!416 = distinct !DISubprogram(name: "#throw_boundserror;", linkageName: "#throw_boundserror", scope: !47, file: !47, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!417 = !DILocation(line: 49, scope: !390, inlinedAt: !418)
!418 = !DILocation(line: 64, scope: !419, inlinedAt: !420)
!419 = distinct !DISubprogram(name: "unsafe_convert;", linkageName: "unsafe_convert", scope: !387, file: !387, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!420 = !DILocation(line: 59, scope: !421, inlinedAt: !422)
!421 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !387, file: !387, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!422 = !DILocation(line: 86, scope: !386, inlinedAt: !388)
!423 = !DILocation(line: 39, scope: !424, inlinedAt: !425)
!424 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !52, file: !52, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!425 = !DILocation(line: 0, scope: !426, inlinedAt: !427)
!426 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!427 = !DILocation(line: 0, scope: !428, inlinedAt: !429)
!428 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!429 = !DILocation(line: 88, scope: !430, inlinedAt: !422)
!430 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !431, file: !431, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !49)
!431 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!432 = !{!433, !433, i64 0, i64 0}
!433 = !{!"custom_tbaa_addrspace(1)", !434, i64 0}
!434 = !{!"custom_tbaa"}
!435 = !DILocation(line: 87, scope: !386, inlinedAt: !388)
!436 = !DILocation(line: 5, scope: !383)
!437 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_14869", scope: null, file: !100, line: 150, type: !48, scopeLine: 150, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !17, retainedNodes: !49)
!438 = !DILocation(line: 150, scope: !437)
!439 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14946", scope: null, file: !100, line: 112, type: !48, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!440 = !DILocation(line: 39, scope: !441, inlinedAt: !442)
!441 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !52, file: !52, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!442 = !DILocation(line: 0, scope: !443, inlinedAt: !444)
!443 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!444 = !DILocation(line: 0, scope: !445, inlinedAt: !446)
!445 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !55, file: !55, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!446 = !DILocation(line: 113, scope: !439)
!447 = !DILocation(line: 49, scope: !448, inlinedAt: !446)
!448 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !64, file: !64, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!449 = !DILocation(line: 30, scope: !450, inlinedAt: !451)
!450 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!451 = !DILocation(line: 67, scope: !452, inlinedAt: !453)
!452 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !60, file: !60, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!453 = !DILocation(line: 114, scope: !439)
!454 = !DILocation(line: 180, scope: !455, inlinedAt: !456)
!455 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !70, file: !70, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!456 = !DILocation(line: 180, scope: !455, inlinedAt: !451)
!457 = !{!458, !458, i64 0}
!458 = !{!"jtbaa_immut", !459, i64 0}
!459 = !{!"jtbaa_value", !206, i64 0}
!460 = !DILocation(line: 6, scope: !461, inlinedAt: !463)
!461 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !462, file: !462, type: !48, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !25, retainedNodes: !49)
!462 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!463 = !DILocation(line: 127, scope: !439)
!464 = !DILocation(line: 128, scope: !439)
