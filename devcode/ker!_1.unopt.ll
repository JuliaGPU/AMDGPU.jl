; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@_j_const_3 = private unnamed_addr addrspace(1) constant i64 39, align 8
@jl_nothing = external local_unnamed_addr addrspace(1) constant {}*
@0 = private unnamed_addr constant [40 x i8] c"BoundsError: Out-of-bounds array access\00", align 1
@_j_const_1 = private unnamed_addr addrspace(1) constant i64 0, align 8
@_j_const_2 = private unnamed_addr addrspace(1) constant [1 x i64] [i64 1], align 8
@exception = private unnamed_addr addrspace(1) constant [10 x i8] c"exception\00", align 1
@_j_const_1.6 = private unnamed_addr addrspace(1) constant i32 1, align 4

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:35 within `#throw_boundserror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_boundserror_11700({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0, [1 x i64] addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(8) %1) unnamed_addr #0 !dbg !39 {
top:
  %2 = alloca [5 x i64], align 8, addrspace(5)
  %3 = alloca [3 x i32], align 4, addrspace(5)
  %4 = alloca [3 x i32], align 4, addrspace(5)
  %5 = alloca [3 x i32], align 4, addrspace(5)
  %6 = alloca [3 x i32], align 4, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %7 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %7, i64 -14
  %8 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %8, i64 15
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:106 within `macro expansion`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %9 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !43
     %10 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %9, i64 0, !dbg !43
     %11 = addrspacecast {}* inttoptr (i64 136191117260096 to {}*) to {} addrspace(10)*, !dbg !43
     %12 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %11, 0, !dbg !43
     %13 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !43
     %14 = insertvalue [2 x {} addrspace(10)*] %12, {} addrspace(10)* %13, 1, !dbg !43
     %15 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !43
     %16 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %15, i64 0, !dbg !43
     %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !43
     store [5 x i64] %state.i, [5 x i64] addrspace(5)* %2, align 8, !dbg !43
; │└└
; │┌ @ Base.jl:49 within `getproperty`
    %17 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !55
    %18 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %17, i64 0, !dbg !55
    %19 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %2, i32 0, i32 0, !dbg !55
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:107 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:27 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %20 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !58
       %21 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %20, i64 0, !dbg !58
       %22 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !58
       %23 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %22, i64 0, !dbg !58
       %24 = load i64, i64 addrspace(5)* %19, align 8, !dbg !58, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %25 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !61
      %26 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %25, i64 0, !dbg !61
      %27 = inttoptr i64 %24 to i8*, !dbg !61
      %28 = getelementptr i8, i8* %27, i64 4, !dbg !61
      %29 = ptrtoint i8* %28 to i64, !dbg !61
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %30 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !81
         %31 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %30, i64 0, !dbg !81
; │││└└└└
; │││┌ @ essentials.jl:730 within `reinterpret`
      %32 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !88
      %33 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %32, i64 0, !dbg !88
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `llvm_atomic_cas`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %34 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !90
      %35 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %34, i64 0, !dbg !90
      %36 = addrspacecast {}* inttoptr (i64 136191098789808 to {}*) to {} addrspace(10)*, !dbg !90
      %37 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %36, 0, !dbg !90
      %38 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !90
      %39 = insertvalue [2 x {} addrspace(10)*] %37, {} addrspace(10)* %38, 1, !dbg !90
      %40 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !90
      %41 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %40, i64 0, !dbg !90
      %42 = bitcast i8* %28 to i32*, !dbg !90
      %43 = cmpxchg i32* %42, i32 0, i32 1 acq_rel acquire, align 4, !dbg !90
      %44 = extractvalue { i32, i1 } %43, 0, !dbg !90
; ││└└
; ││┌ @ promotion.jl:639 within `==`
     %45 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !96
     %46 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %45, i64 0, !dbg !96
     %47 = icmp eq i32 %44, 0, !dbg !96
; ││└
    %48 = xor i1 %47, true, !dbg !66
    br i1 %48, label %L46, label %L12, !dbg !66

L12:                                              ; preds = %top
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %49 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !99
        %50 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %49, i64 0, !dbg !99
        %51 = addrspacecast {}* inttoptr (i64 136191106427568 to {}*) to {} addrspace(10)*, !dbg !99
        %52 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %51, 0, !dbg !99
        %53 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !99
        %54 = insertvalue [2 x {} addrspace(10)*] %52, {} addrspace(10)* %53, 1, !dbg !99
        %55 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !99
        %56 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %55, i64 0, !dbg !99
        %57 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !99, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %58 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !111
       %59 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %58, i64 0, !dbg !111
       %60 = add i32 %57, 1, !dbg !111
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %61 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !115
        %62 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %61, i64 0, !dbg !115
        %63 = addrspacecast {}* inttoptr (i64 136191106428064 to {}*) to {} addrspace(10)*, !dbg !115
        %64 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %63, 0, !dbg !115
        %65 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !115
        %66 = insertvalue [2 x {} addrspace(10)*] %64, {} addrspace(10)* %65, 1, !dbg !115
        %67 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !115
        %68 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %67, i64 0, !dbg !115
        %69 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !115, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %70 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !120
       %71 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %70, i64 0, !dbg !120
       %72 = add i32 %69, 1, !dbg !120
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %73 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !122
        %74 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %73, i64 0, !dbg !122
        %75 = addrspacecast {}* inttoptr (i64 136191106428560 to {}*) to {} addrspace(10)*, !dbg !122
        %76 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %75, 0, !dbg !122
        %77 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !122
        %78 = insertvalue [2 x {} addrspace(10)*] %76, {} addrspace(10)* %77, 1, !dbg !122
        %79 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !122
        %80 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %79, i64 0, !dbg !122
        %81 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !122, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %82 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !127
       %83 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %82, i64 0, !dbg !127
       %84 = add i32 %81, 1, !dbg !127
; │││└└
; │││┌ @ boot.jl:727 within `NamedTuple`
      %85 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 0, !dbg !129
      store i32 %60, i32 addrspace(5)* %85, align 4, !dbg !129, !tbaa !69, !alias.scope !73, !noalias !76
      %86 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 1, !dbg !129
      store i32 %72, i32 addrspace(5)* %86, align 4, !dbg !129, !tbaa !69, !alias.scope !73, !noalias !76
      %87 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 2, !dbg !129
      store i32 %84, i32 addrspace(5)* %87, align 4, !dbg !129, !tbaa !69, !alias.scope !73, !noalias !76
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %88 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !131
       %89 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %88, i64 0, !dbg !131
       %90 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !131
       %91 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %90, i64 0, !dbg !131
       %92 = load i64, i64 addrspace(5)* %19, align 8, !dbg !131, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %93 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !132
      %94 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %93, i64 0, !dbg !132
      %95 = inttoptr i64 %92 to i8*, !dbg !132
      %96 = getelementptr i8, i8* %95, i64 8, !dbg !132
      %97 = ptrtoint i8* %96 to i64, !dbg !132
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %98 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !135
         %99 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %98, i64 0, !dbg !135
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %100 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !138
      %101 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %100, i64 0, !dbg !138
; │││└
; │││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
      %102 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !139
      %103 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %102, i64 0, !dbg !139
      %104 = getelementptr inbounds i8, i8* %96, i64 0, !dbg !139
      %105 = bitcast [3 x i32] addrspace(5)* %3 to i8 addrspace(5)*, !dbg !139
      call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %104, i8 addrspace(5)* align 4 %105, i64 12, i1 false), !dbg !139
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %106 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !142
        %107 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %106, i64 0, !dbg !142
        %108 = addrspacecast {}* inttoptr (i64 136191106429056 to {}*) to {} addrspace(10)*, !dbg !142
        %109 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %108, 0, !dbg !142
        %110 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !142
        %111 = insertvalue [2 x {} addrspace(10)*] %109, {} addrspace(10)* %110, 1, !dbg !142
        %112 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !142
        %113 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %112, i64 0, !dbg !142
        %114 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !142, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %115 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !151
       %116 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %115, i64 0, !dbg !151
       %117 = add i32 %114, 1, !dbg !151
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %118 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !153
        %119 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %118, i64 0, !dbg !153
        %120 = addrspacecast {}* inttoptr (i64 136182494462464 to {}*) to {} addrspace(10)*, !dbg !153
        %121 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %120, 0, !dbg !153
        %122 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !153
        %123 = insertvalue [2 x {} addrspace(10)*] %121, {} addrspace(10)* %122, 1, !dbg !153
        %124 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !153
        %125 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %124, i64 0, !dbg !153
        %126 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !153, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %127 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !158
       %128 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %127, i64 0, !dbg !158
       %129 = add i32 %126, 1, !dbg !158
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %130 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !160
        %131 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %130, i64 0, !dbg !160
        %132 = addrspacecast {}* inttoptr (i64 136182494462960 to {}*) to {} addrspace(10)*, !dbg !160
        %133 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %132, 0, !dbg !160
        %134 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !160
        %135 = insertvalue [2 x {} addrspace(10)*] %133, {} addrspace(10)* %134, 1, !dbg !160
        %136 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !160
        %137 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %136, i64 0, !dbg !160
        %138 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !160, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %139 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !165
       %140 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %139, i64 0, !dbg !165
       %141 = add i32 %138, 1, !dbg !165
; │││└└
; │││┌ @ boot.jl:727 within `NamedTuple`
      %142 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 0, !dbg !167
      store i32 %117, i32 addrspace(5)* %142, align 4, !dbg !167, !tbaa !69, !alias.scope !73, !noalias !76
      %143 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 1, !dbg !167
      store i32 %129, i32 addrspace(5)* %143, align 4, !dbg !167, !tbaa !69, !alias.scope !73, !noalias !76
      %144 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 2, !dbg !167
      store i32 %141, i32 addrspace(5)* %144, align 4, !dbg !167, !tbaa !69, !alias.scope !73, !noalias !76
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %145 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !168
       %146 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %145, i64 0, !dbg !168
       %147 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !168
       %148 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %147, i64 0, !dbg !168
       %149 = load i64, i64 addrspace(5)* %19, align 8, !dbg !168, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %150 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !169
      %151 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %150, i64 0, !dbg !169
      %152 = inttoptr i64 %149 to i8*, !dbg !169
      %153 = getelementptr i8, i8* %152, i64 20, !dbg !169
      %154 = ptrtoint i8* %153 to i64, !dbg !169
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %155 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !171
         %156 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %155, i64 0, !dbg !171
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %157 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !174
      %158 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %157, i64 0, !dbg !174
; │││└
; │││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
      %159 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !175
      %160 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %159, i64 0, !dbg !175
      %161 = getelementptr inbounds i8, i8* %153, i64 0, !dbg !175
      %162 = bitcast [3 x i32] addrspace(5)* %4 to i8 addrspace(5)*, !dbg !175
      call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %161, i8 addrspace(5)* align 4 %162, i64 12, i1 false), !dbg !175
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
      %163 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !177
      %164 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %163, i64 0, !dbg !177
      fence syncscope("workgroup") seq_cst, !dbg !177
; │││└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
     call void @llvm.amdgcn.s.barrier(), !dbg !183
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
      %165 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !184
      %166 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %165, i64 0, !dbg !184
      fence syncscope("workgroup") seq_cst, !dbg !184
; ││└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
    br label %L131, !dbg !186

L46:                                              ; preds = %top
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:91 within `lock_output!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:25 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %167 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !187
       %168 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %167, i64 0, !dbg !187
       %169 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !187
       %170 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %169, i64 0, !dbg !187
       %171 = load i64, i64 addrspace(5)* %19, align 8, !dbg !187, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %172 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !188
      %173 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %172, i64 0, !dbg !188
      %174 = inttoptr i64 %171 to i8*, !dbg !188
      %175 = getelementptr i8, i8* %174, i64 4, !dbg !188
      %176 = ptrtoint i8* %175 to i64, !dbg !188
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %177 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !191
         %178 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %177, i64 0, !dbg !191
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %179 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !194
      %180 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %179, i64 0, !dbg !194
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %181 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !195
      %182 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %181, i64 0, !dbg !195
      %183 = bitcast i8* %175 to i32*, !dbg !195
      %184 = getelementptr inbounds i32, i32* %183, i64 0, !dbg !195
      %185 = load i32, i32* %184, align 1, !dbg !195, !tbaa !198, !alias.scope !200, !noalias !201
; ││└└
; ││┌ @ promotion.jl:639 within `==`
     %186 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !202
     %187 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %186, i64 0, !dbg !202
     %188 = icmp eq i32 %185, 1, !dbg !202
; ││└
    %189 = xor i1 %188, true, !dbg !190
    br i1 %189, label %L130, label %L53, !dbg !190

L53:                                              ; preds = %L46
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %190 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !203
       %191 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %190, i64 0, !dbg !203
       %192 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !203
       %193 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %192, i64 0, !dbg !203
       %194 = load i64, i64 addrspace(5)* %19, align 8, !dbg !203, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %195 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !204
      %196 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %195, i64 0, !dbg !204
      %197 = inttoptr i64 %194 to i8*, !dbg !204
      %198 = getelementptr i8, i8* %197, i64 8, !dbg !204
      %199 = ptrtoint i8* %198 to i64, !dbg !204
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %200 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !206
         %201 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %200, i64 0, !dbg !206
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %202 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !209
      %203 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %202, i64 0, !dbg !209
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %204 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !210
      %205 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %204, i64 0, !dbg !210
      %206 = bitcast i8* %198 to [3 x i32]*, !dbg !210
      %207 = getelementptr inbounds [3 x i32], [3 x i32]* %206, i64 0, !dbg !210
      %208 = bitcast [3 x i32] addrspace(5)* %5 to i8 addrspace(5)*, !dbg !210
      %209 = bitcast [3 x i32]* %207 to i8*, !dbg !210
      call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %208, i8* align 1 %209, i64 12, i1 false), !dbg !210, !tbaa !212, !alias.scope !213, !noalias !214
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %210 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !215
        %211 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %210, i64 0, !dbg !215
        %212 = addrspacecast {}* inttoptr (i64 136191106427568 to {}*) to {} addrspace(10)*, !dbg !215
        %213 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %212, 0, !dbg !215
        %214 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !215
        %215 = insertvalue [2 x {} addrspace(10)*] %213, {} addrspace(10)* %214, 1, !dbg !215
        %216 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !215
        %217 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %216, i64 0, !dbg !215
        %218 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !215, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %219 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !220
       %220 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %219, i64 0, !dbg !220
       %221 = add i32 %218, 1, !dbg !220
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %222 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !222
        %223 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %222, i64 0, !dbg !222
        %224 = addrspacecast {}* inttoptr (i64 136191106428064 to {}*) to {} addrspace(10)*, !dbg !222
        %225 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %224, 0, !dbg !222
        %226 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !222
        %227 = insertvalue [2 x {} addrspace(10)*] %225, {} addrspace(10)* %226, 1, !dbg !222
        %228 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !222
        %229 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %228, i64 0, !dbg !222
        %230 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !222, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %231 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !226
       %232 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %231, i64 0, !dbg !226
       %233 = add i32 %230, 1, !dbg !226
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %234 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !228
        %235 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %234, i64 0, !dbg !228
        %236 = addrspacecast {}* inttoptr (i64 136191106428560 to {}*) to {} addrspace(10)*, !dbg !228
        %237 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %236, 0, !dbg !228
        %238 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !228
        %239 = insertvalue [2 x {} addrspace(10)*] %237, {} addrspace(10)* %238, 1, !dbg !228
        %240 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !228
        %241 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %240, i64 0, !dbg !228
        %242 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !228, !range !110
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %243 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !232
       %244 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %243, i64 0, !dbg !232
       %245 = add i32 %242, 1, !dbg !232
; ││└└└
; ││┌ @ namedtuple.jl:244 within `==`
; │││┌ @ namedtuple.jl:197 within `Tuple`
      %246 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %247 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %246, i64 0, !dbg !234
      %248 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %5, i32 0, i32 0, !dbg !234
      %249 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %250 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %249, i64 0, !dbg !234
      %251 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %5, i32 0, i32 1, !dbg !234
      %252 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %253 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %252, i64 0, !dbg !234
      %254 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %5, i32 0, i32 2, !dbg !234
; │││└
; │││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││┌ @ tuple.jl:551 within `_eq`
; ││││┌ @ promotion.jl:639 within `==`
       %255 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !239
       %256 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %255, i64 0, !dbg !239
       %257 = load i32, i32 addrspace(5)* %248, align 4, !dbg !239, !tbaa !69, !alias.scope !73, !noalias !76
       %258 = icmp eq i32 %257, %221, !dbg !239
; ││││└
; ││││ @ tuple.jl:552 within `_eq`
      %259 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !245
      %260 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %259, i64 0, !dbg !245
      %261 = zext i1 %258 to i8, !dbg !245
      %262 = icmp eq i8 %261, 0, !dbg !245
      %263 = xor i1 %262, true, !dbg !245
      br i1 %263, label %L74, label %L73, !dbg !245

L73:                                              ; preds = %L53
; ││││ @ tuple.jl:553 within `_eq`
      br label %L87, !dbg !246

L74:                                              ; preds = %L53
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %264 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !247
       %265 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %264, i64 0, !dbg !247
       %266 = load i32, i32 addrspace(5)* %251, align 4, !dbg !247, !tbaa !69, !alias.scope !73, !noalias !76
       %267 = icmp eq i32 %266, %233, !dbg !247
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
      %268 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !250
      %269 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %268, i64 0, !dbg !250
      %270 = zext i1 %267 to i8, !dbg !250
      %271 = icmp eq i8 %270, 0, !dbg !250
      %272 = xor i1 %271, true, !dbg !250
      br i1 %272, label %L78, label %L77, !dbg !250

L77:                                              ; preds = %L74
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
      br label %L85, !dbg !251

L78:                                              ; preds = %L74
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %273 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !252
       %274 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %273, i64 0, !dbg !252
       %275 = load i32, i32 addrspace(5)* %254, align 4, !dbg !252, !tbaa !69, !alias.scope !73, !noalias !76
       %276 = icmp eq i32 %275, %245, !dbg !252
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
      %277 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !255
      %278 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %277, i64 0, !dbg !255
      %279 = zext i1 %276 to i8, !dbg !255
      %280 = icmp eq i8 %279, 0, !dbg !255
      %281 = xor i1 %280, true, !dbg !255
      br i1 %281, label %L82, label %L81, !dbg !255

L81:                                              ; preds = %L78
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
      br label %L83, !dbg !256

L82:                                              ; preds = %L78
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
      br label %L83, !dbg !257

L83:                                              ; preds = %L82, %L81
      %value_phi6 = phi i8 [ 0, %L81 ], [ 1, %L82 ]
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
      br label %L85, !dbg !254

L85:                                              ; preds = %L83, %L77
      %value_phi5 = phi i8 [ 0, %L77 ], [ %value_phi6, %L83 ]
; ││││ @ tuple.jl:557 within `_eq`
      br label %L87, !dbg !249

L87:                                              ; preds = %L85, %L73
      %value_phi1 = phi i8 [ 0, %L73 ], [ %value_phi5, %L85 ]
; │││└
     br label %L89, !dbg !243

L89:                                              ; preds = %L87
     br label %L90, !dbg !243

L90:                                              ; preds = %L89
; ││└
    %282 = trunc i8 %value_phi1 to i1, !dbg !190
    %283 = xor i1 %282, true, !dbg !190
    br i1 %283, label %L130, label %L91, !dbg !190

L91:                                              ; preds = %L90
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; │││┌ @ pointer.jl:316 within `+`
; ││││┌ @ boot.jl:903 within `UInt64`
       %284 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !258
       %285 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %284, i64 0, !dbg !258
       %286 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !258
       %287 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %286, i64 0, !dbg !258
       %288 = load i64, i64 addrspace(5)* %19, align 8, !dbg !258, !tbaa !69, !alias.scope !73, !noalias !76
; ││││└
      %289 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !259
      %290 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %289, i64 0, !dbg !259
      %291 = inttoptr i64 %288 to i8*, !dbg !259
      %292 = getelementptr i8, i8* %291, i64 20, !dbg !259
      %293 = ptrtoint i8* %292 to i64, !dbg !259
; ││││┌ @ essentials.jl:666 within `oftype`
; │││││┌ @ pointer.jl:26 within `convert`
; ││││││┌ @ boot.jl:908 within `Ptr`
         %294 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !261
         %295 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %294, i64 0, !dbg !261
; │││└└└└
; │││┌ @ pointer.jl:30 within `convert`
      %296 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !264
      %297 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %296, i64 0, !dbg !264
; │││└
; │││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
      %298 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !265
      %299 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %298, i64 0, !dbg !265
      %300 = bitcast i8* %292 to [3 x i32]*, !dbg !265
      %301 = getelementptr inbounds [3 x i32], [3 x i32]* %300, i64 0, !dbg !265
      %302 = bitcast [3 x i32] addrspace(5)* %6 to i8 addrspace(5)*, !dbg !265
      %303 = bitcast [3 x i32]* %301 to i8*, !dbg !265
      call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %302, i8* align 1 %303, i64 12, i1 false), !dbg !265, !tbaa !212, !alias.scope !213, !noalias !214
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %304 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !267
        %305 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %304, i64 0, !dbg !267
        %306 = addrspacecast {}* inttoptr (i64 136191106429056 to {}*) to {} addrspace(10)*, !dbg !267
        %307 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %306, 0, !dbg !267
        %308 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !267
        %309 = insertvalue [2 x {} addrspace(10)*] %307, {} addrspace(10)* %308, 1, !dbg !267
        %310 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !267
        %311 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %310, i64 0, !dbg !267
        %312 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !267, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %313 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !272
       %314 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %313, i64 0, !dbg !272
       %315 = add i32 %312, 1, !dbg !272
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %316 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !274
        %317 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %316, i64 0, !dbg !274
        %318 = addrspacecast {}* inttoptr (i64 136182494462464 to {}*) to {} addrspace(10)*, !dbg !274
        %319 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %318, 0, !dbg !274
        %320 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !274
        %321 = insertvalue [2 x {} addrspace(10)*] %319, {} addrspace(10)* %320, 1, !dbg !274
        %322 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !274
        %323 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %322, i64 0, !dbg !274
        %324 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !274, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %325 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !278
       %326 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %325, i64 0, !dbg !278
       %327 = add i32 %324, 1, !dbg !278
; │││└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
        %328 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !280
        %329 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %328, i64 0, !dbg !280
        %330 = addrspacecast {}* inttoptr (i64 136182494462960 to {}*) to {} addrspace(10)*, !dbg !280
        %331 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %330, 0, !dbg !280
        %332 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !280
        %333 = insertvalue [2 x {} addrspace(10)*] %331, {} addrspace(10)* %332, 1, !dbg !280
        %334 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !280
        %335 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %334, i64 0, !dbg !280
        %336 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !280, !range !150
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %337 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !284
       %338 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %337, i64 0, !dbg !284
       %339 = add i32 %336, 1, !dbg !284
; ││└└└
; ││┌ @ namedtuple.jl:244 within `==`
; │││┌ @ namedtuple.jl:197 within `Tuple`
      %340 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %341 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %340, i64 0, !dbg !234
      %342 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %6, i32 0, i32 0, !dbg !234
      %343 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %344 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %343, i64 0, !dbg !234
      %345 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %6, i32 0, i32 1, !dbg !234
      %346 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !234
      %347 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %346, i64 0, !dbg !234
      %348 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %6, i32 0, i32 2, !dbg !234
; │││└
; │││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; │││┌ @ tuple.jl:551 within `_eq`
; ││││┌ @ promotion.jl:639 within `==`
       %349 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !239
       %350 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %349, i64 0, !dbg !239
       %351 = load i32, i32 addrspace(5)* %342, align 4, !dbg !239, !tbaa !69, !alias.scope !73, !noalias !76
       %352 = icmp eq i32 %351, %315, !dbg !239
; ││││└
; ││││ @ tuple.jl:552 within `_eq`
      %353 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !245
      %354 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %353, i64 0, !dbg !245
      %355 = zext i1 %352 to i8, !dbg !245
      %356 = icmp eq i8 %355, 0, !dbg !245
      %357 = xor i1 %356, true, !dbg !245
      br i1 %357, label %L112, label %L111, !dbg !245

L111:                                             ; preds = %L91
; ││││ @ tuple.jl:553 within `_eq`
      br label %L125, !dbg !246

L112:                                             ; preds = %L91
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %358 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !247
       %359 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %358, i64 0, !dbg !247
       %360 = load i32, i32 addrspace(5)* %345, align 4, !dbg !247, !tbaa !69, !alias.scope !73, !noalias !76
       %361 = icmp eq i32 %360, %327, !dbg !247
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
      %362 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !250
      %363 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %362, i64 0, !dbg !250
      %364 = zext i1 %361 to i8, !dbg !250
      %365 = icmp eq i8 %364, 0, !dbg !250
      %366 = xor i1 %365, true, !dbg !250
      br i1 %366, label %L116, label %L115, !dbg !250

L115:                                             ; preds = %L112
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
      br label %L123, !dbg !251

L116:                                             ; preds = %L112
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; ││││┌ @ promotion.jl:639 within `==`
       %367 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !252
       %368 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %367, i64 0, !dbg !252
       %369 = load i32, i32 addrspace(5)* %348, align 4, !dbg !252, !tbaa !69, !alias.scope !73, !noalias !76
       %370 = icmp eq i32 %369, %339, !dbg !252
; ││││└
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
      %371 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !255
      %372 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %371, i64 0, !dbg !255
      %373 = zext i1 %370 to i8, !dbg !255
      %374 = icmp eq i8 %373, 0, !dbg !255
      %375 = xor i1 %374, true, !dbg !255
      br i1 %375, label %L120, label %L119, !dbg !255

L119:                                             ; preds = %L116
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
      br label %L121, !dbg !256

L120:                                             ; preds = %L116
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
      br label %L121, !dbg !257

L121:                                             ; preds = %L120, %L119
      %value_phi4 = phi i8 [ 0, %L119 ], [ 1, %L120 ]
; ││││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
      br label %L123, !dbg !254

L123:                                             ; preds = %L121, %L115
      %value_phi3 = phi i8 [ 0, %L115 ], [ %value_phi4, %L121 ]
; ││││ @ tuple.jl:557 within `_eq`
      br label %L125, !dbg !249

L125:                                             ; preds = %L123, %L111
      %value_phi2 = phi i8 [ 0, %L111 ], [ %value_phi3, %L123 ]
; │││└
     br label %L127, !dbg !243

L127:                                             ; preds = %L125
     br label %L128, !dbg !243

L128:                                             ; preds = %L127
; ││└
    %376 = trunc i8 %value_phi2 to i1, !dbg !190
    %377 = xor i1 %376, true, !dbg !190
    br i1 %377, label %L130, label %L129, !dbg !190

L129:                                             ; preds = %L128
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:97 within `lock_output!`
    br label %L131, !dbg !286

L130:                                             ; preds = %L128, %L90, %L46
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:100 within `lock_output!`
    br label %L131, !dbg !287

L131:                                             ; preds = %L130, %L129, %L12
    %value_phi = phi i8 [ 1, %L12 ], [ 1, %L129 ], [ 0, %L130 ]
; │└
   %378 = trunc i8 %value_phi to i1, !dbg !68
   %379 = xor i1 %378, true, !dbg !68
   br i1 %379, label %L145, label %L133, !dbg !68

L133:                                             ; preds = %L131
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:108 within `macro expansion`
; │┌ @ none within `alloc_string`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %380 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !288
     %381 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %380, i64 0, !dbg !288
     %382 = addrspacecast {}* inttoptr (i64 136191120271888 to {}*) to {} addrspace(10)*, !dbg !288
     %383 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %382, 0, !dbg !288
     %384 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !288
     %385 = insertvalue [2 x {} addrspace(10)*] %383, {} addrspace(10)* %384, 1, !dbg !288
     %386 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !288
     %387 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %386, i64 0, !dbg !288
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:109 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:65 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %388 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !293
      %389 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %388, i64 0, !dbg !293
      %390 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !293
      %391 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %390, i64 0, !dbg !293
      %392 = load i64, i64 addrspace(5)* %19, align 8, !dbg !293, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %393 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !294
     %394 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %393, i64 0, !dbg !294
     %395 = inttoptr i64 %392 to i8*, !dbg !294
     %396 = getelementptr i8, i8* %395, i64 32, !dbg !294
     %397 = ptrtoint i8* %396 to i64, !dbg !294
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %398 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !297
        %399 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %398, i64 0, !dbg !297
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %400 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !300
     %401 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %400, i64 0, !dbg !300
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %402 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !301
     %403 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %402, i64 0, !dbg !301
     %404 = bitcast i8* %396 to i8 addrspace(1)**, !dbg !301
     %405 = getelementptr inbounds i8 addrspace(1)*, i8 addrspace(1)** %404, i64 0, !dbg !301
     store i8 addrspace(1)* addrspacecast (i8* getelementptr inbounds ([40 x i8], [40 x i8]* @0, i32 0, i32 0) to i8 addrspace(1)*), i8 addrspace(1)** %405, align 1, !dbg !301, !tbaa !198, !alias.scope !200, !noalias !201
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:110 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:71 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %406 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !303
      %407 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %406, i64 0, !dbg !303
      %408 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !303
      %409 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %408, i64 0, !dbg !303
      %410 = load i64, i64 addrspace(5)* %19, align 8, !dbg !303, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %411 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !304
     %412 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %411, i64 0, !dbg !304
     %413 = inttoptr i64 %410 to i8*, !dbg !304
     %414 = getelementptr i8, i8* %413, i64 40, !dbg !304
     %415 = ptrtoint i8* %414 to i64, !dbg !304
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %416 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !307
        %417 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %416, i64 0, !dbg !307
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %418 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !310
     %419 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %418, i64 0, !dbg !310
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %420 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !311
     %421 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %420, i64 0, !dbg !311
     %422 = getelementptr inbounds i8, i8* %414, i64 0, !dbg !311
     %423 = bitcast i8* %422 to i64*, !dbg !311
     %424 = load i64, i64 addrspace(1)* @_j_const_3, align 8, !dbg !311, !tbaa !313, !alias.scope !200, !noalias !201
     store i64 %424, i64* %423, align 1, !dbg !311
     br label %L145, !dbg !311

L145:                                             ; preds = %L133, %L131
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:112 within `macro expansion`
   %425 = bitcast {}* inttoptr (i64 136190977633472 to {}*) to {} addrspace(10)**, !dbg !316
   %426 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %425, i64 0, !dbg !316
   %427 = bitcast {}* inttoptr (i64 136190952250288 to {}*) to {} addrspace(10)**, !dbg !316
   %428 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %427, i64 0, !dbg !316
   %429 = load {}*, {}* addrspace(1)* @jl_nothing, align 8, !dbg !316, !tbaa !317, !invariant.load !42, !alias.scope !319, !noalias !320, !nonnull !42
   call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8] addrspace(1)* @exception to i64)), !dbg !316
   call fastcc void @gpu_signal_exception(), !dbg !316
   call void @llvm.trap(), !dbg !316
   unreachable, !dbg !316
; └
}

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0i8.p5i8.i64(i8* noalias nocapture writeonly, i8 addrspace(5)* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #2

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

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
define amdgpu_kernel void @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE({ [1 x i64], i8 addrspace(1)*, i64 } %0) local_unnamed_addr #6 !dbg !321 {
conversion:
  %1 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %2 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %1 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %0, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, align 8
  br label %top

top:                                              ; preds = %conversion
  %3 = alloca [1 x i64], align 8, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %4 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %4, i64 -14
  %5 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %5, i64 15
;  @ /home/pxlth/.julia/dev/t.jl:6 within `ker!`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:80 within `#getindex`
   br label %L3, !dbg !323

L3:                                               ; preds = %top
; │┌ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:389 within `eachindex`
; │││┌ @ abstractarray.jl:137 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %6 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !327
         %7 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %6, i64 0, !dbg !327
         %8 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 0, !dbg !327
; │││││└└
; │││││┌ @ tuple.jl:355 within `map`
; ││││││┌ @ tuple.jl:31 within `getindex`
         %9 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !341
         %10 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %9, i64 0, !dbg !341
         %11 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %8, i32 0, i32 0, !dbg !341
; ││└└└└└
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ essentials.jl:668 within `unsigned`
; ││││┌ @ essentials.jl:730 within `reinterpret`
       %12 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !345
       %13 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %12, i64 0, !dbg !345
       %14 = load i64, i64 addrspace(11)* %11, align 8, !dbg !345, !alias.scope !319, !noalias !320
; │││└└
; │││┌ @ int.jl:513 within `<`
      %15 = bitcast {}* inttoptr (i64 136190995413648 to {}*) to {} addrspace(10)**, !dbg !351
      %16 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %15, i64 0, !dbg !351
      %17 = icmp ult i64 0, %14, !dbg !351
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    %18 = xor i1 %17, true, !dbg !340
    br i1 %18, label %L10, label %L9, !dbg !340

L9:                                               ; preds = %L3
    br label %L12, !dbg !340

L10:                                              ; preds = %L3
    %19 = bitcast {}* inttoptr (i64 136191006289440 to {}*) to {} addrspace(10)**, !dbg !340
    %20 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %19, i64 0, !dbg !340
    call fastcc void @julia__throw_boundserror_11700({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %2, [1 x i64] addrspace(11)* nocapture readonly addrspacecast ([1 x i64] addrspace(1)* @_j_const_2 to [1 x i64] addrspace(11)*)) #9, !dbg !340
    unreachable, !dbg !340

L12:                                              ; preds = %L9
    br label %L13, !dbg !340

L13:                                              ; preds = %L12
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:81 within `#getindex`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
; │││┌ @ Base.jl:49 within `getproperty`
      %21 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !353
      %22 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %21, i64 0, !dbg !353
      %23 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 1, !dbg !353
; │└└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:85 within `unsafe_load`
; ││┌ @ none within `pointerref`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %24 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !359
      %25 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %24, i64 0, !dbg !359
      %26 = addrspacecast {}* inttoptr (i64 136191131833200 to {}*) to {} addrspace(10)*, !dbg !359
      %27 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %26, 0, !dbg !359
      %28 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !359
      %29 = insertvalue [2 x {} addrspace(10)*] %27, {} addrspace(10)* %28, 1, !dbg !359
      %30 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !359
      %31 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %30, i64 0, !dbg !359
      %32 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %23, align 8, !dbg !359, !alias.scope !319, !noalias !320
      %33 = bitcast i8 addrspace(1)* %32 to i64 addrspace(1)*, !dbg !359
      %34 = load i64, i64 addrspace(1)* %33, align 8, !dbg !359, !tbaa !368
      br label %L17, !dbg !359

L17:                                              ; preds = %L13
; └└└└
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:85 within `#setindex!`
   br label %L19, !dbg !371

L19:                                              ; preds = %L17
; │┌ @ abstractarray.jl:697 within `checkbounds`
    %35 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !373
    %36 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %35, i64 0, !dbg !373
    %37 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %3, i32 0, i32 0, !dbg !373
    %38 = load i64, i64 addrspace(1)* @_j_const_1, align 8, !dbg !373, !tbaa !313, !alias.scope !200, !noalias !201
    store i64 %38, i64 addrspace(5)* %37, align 8, !dbg !373, !tbaa !69, !alias.scope !73, !noalias !76
; ││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; ││┌ @ abstractarray.jl:389 within `eachindex`
; │││┌ @ abstractarray.jl:137 within `axes1`
; ││││┌ @ abstractarray.jl:98 within `axes`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:67 within `size`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %39 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !374
         %40 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %39, i64 0, !dbg !374
         %41 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 0, !dbg !374
; │││││└└
; │││││┌ @ tuple.jl:355 within `map`
; ││││││┌ @ tuple.jl:31 within `getindex`
         %42 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !381
         %43 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %42, i64 0, !dbg !381
         %44 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %41, i32 0, i32 0, !dbg !381
; ││└└└└└
; ││┌ @ abstractarray.jl:754 within `checkindex`
; │││┌ @ int.jl:86 within `-`
      %45 = bitcast {}* inttoptr (i64 136190995415664 to {}*) to {} addrspace(10)**, !dbg !383
      %46 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %45, i64 0, !dbg !383
; │││└
; │││┌ @ essentials.jl:668 within `unsigned`
; ││││┌ @ essentials.jl:730 within `reinterpret`
       %47 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !386
       %48 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %47, i64 0, !dbg !386
       %49 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !386
       %50 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %49, i64 0, !dbg !386
       %51 = load i64, i64 addrspace(11)* %44, align 8, !dbg !386, !alias.scope !319, !noalias !320
; │││└└
; │││┌ @ int.jl:513 within `<`
      %52 = bitcast {}* inttoptr (i64 136190995413648 to {}*) to {} addrspace(10)**, !dbg !388
      %53 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %52, i64 0, !dbg !388
      %54 = icmp ult i64 -1, %51, !dbg !388
; ││└└
; ││ @ abstractarray.jl:699 within `checkbounds`
    %55 = xor i1 %54, true, !dbg !380
    br i1 %55, label %L29, label %L28, !dbg !380

L28:                                              ; preds = %L19
    br label %L31, !dbg !380

L29:                                              ; preds = %L19
    %56 = bitcast {}* inttoptr (i64 136191006289440 to {}*) to {} addrspace(10)**, !dbg !380
    %57 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %56, i64 0, !dbg !380
    %58 = addrspacecast [1 x i64] addrspace(5)* %3 to [1 x i64] addrspace(11)*, !dbg !380
    call fastcc void @julia__throw_boundserror_11700({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %2, [1 x i64] addrspace(11)* nocapture readonly %58) #9, !dbg !380
    unreachable, !dbg !380

L31:                                              ; preds = %L28
    br label %L32, !dbg !380

L32:                                              ; preds = %L31
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#setindex!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 within `pointer`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `unsafe_convert`
; │││┌ @ Base.jl:49 within `getproperty`
      %59 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !389
      %60 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %59, i64 0, !dbg !389
      %61 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %2, i32 0, i32 1, !dbg !389
; │└└└
; │┌ @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl:88 within `unsafe_store!`
; ││┌ @ none within `pointerset`
; │││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
      %62 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !393
      %63 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %62, i64 0, !dbg !393
      %64 = addrspacecast {}* inttoptr (i64 136182490744288 to {}*) to {} addrspace(10)*, !dbg !393
      %65 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %64, 0, !dbg !393
      %66 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !393
      %67 = insertvalue [2 x {} addrspace(10)*] %65, {} addrspace(10)* %66, 1, !dbg !393
; ││││┌ @ int.jl:86 within `-`
       %68 = bitcast {}* inttoptr (i64 136190995415664 to {}*) to {} addrspace(10)**, !dbg !399
       %69 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %68, i64 0, !dbg !399
; ││││└
      %70 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !393
      %71 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %70, i64 0, !dbg !393
      %72 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %61, align 8, !dbg !393, !alias.scope !319, !noalias !320
      %73 = bitcast i8 addrspace(1)* %72 to i64 addrspace(1)*, !dbg !393
      %74 = getelementptr inbounds i64, i64 addrspace(1)* %73, i64 -1, !dbg !393
      store i64 %34, i64 addrspace(1)* %74, align 8, !dbg !393, !tbaa !368
; │└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#setindex!`
   br label %L37, !dbg !400

L37:                                              ; preds = %L32
; └
;  @ /home/pxlth/.julia/dev/t.jl:7 within `ker!`
  ret void, !dbg !401
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:91 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception(i64 zeroext %0) unnamed_addr #7 !dbg !402 {
top:
  %pgcstack = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -14
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 15
  ret void, !dbg !403
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:78 within `signal_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #7 !dbg !404 {
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
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:79 within `signal_exception`
; ┌ @ none within `kernel_state`
; │┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
    %7 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !405
    %8 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %7, i64 0, !dbg !405
    %9 = addrspacecast {}* inttoptr (i64 136191117260096 to {}*) to {} addrspace(10)*, !dbg !405
    %10 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %9, 0, !dbg !405
    %11 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !405
    %12 = insertvalue [2 x {} addrspace(10)*] %10, {} addrspace(10)* %11, 1, !dbg !405
    %13 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !405
    %14 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %13, i64 0, !dbg !405
    %state.i = call [5 x i64] @julia.gpu.state_getter(), !dbg !405
    store [5 x i64] %state.i, [5 x i64] addrspace(5)* %0, align 8, !dbg !405
; └└
; ┌ @ Base.jl:49 within `getproperty`
   %15 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !412
   %16 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %15, i64 0, !dbg !412
   %17 = getelementptr inbounds [5 x i64], [5 x i64] addrspace(5)* %0, i32 0, i32 0, !dbg !412
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:80 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:52 within `setproperty!`
; │┌ @ pointer.jl:30 within `convert`
    %18 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !414
    %19 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %18, i64 0, !dbg !414
    %20 = load i64, i64 addrspace(5)* %17, align 8, !dbg !414, !tbaa !69, !alias.scope !73, !noalias !76
; │└
; │┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
    %21 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !419
    %22 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %21, i64 0, !dbg !419
    %23 = inttoptr i64 %20 to i8*, !dbg !419
    %24 = getelementptr inbounds i8, i8* %23, i64 0, !dbg !419
    %25 = bitcast i8* %24 to i32*, !dbg !419
    %26 = load i32, i32 addrspace(1)* @_j_const_1.6, align 4, !dbg !419, !tbaa !313, !alias.scope !200, !noalias !201
    store i32 %26, i32* %25, align 1, !dbg !419
; └└
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:82 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:85 within `lock_output!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:27 within `getproperty`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %27 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !422
      %28 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %27, i64 0, !dbg !422
      %29 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !422
      %30 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %29, i64 0, !dbg !422
      %31 = load i64, i64 addrspace(5)* %17, align 8, !dbg !422, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %32 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !424
     %33 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %32, i64 0, !dbg !424
     %34 = inttoptr i64 %31 to i8*, !dbg !424
     %35 = getelementptr i8, i8* %34, i64 4, !dbg !424
     %36 = ptrtoint i8* %35 to i64, !dbg !424
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %37 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !431
        %38 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %37, i64 0, !dbg !431
; ││└└└└
; ││┌ @ essentials.jl:730 within `reinterpret`
     %39 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !436
     %40 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %39, i64 0, !dbg !436
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `llvm_atomic_cas`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:10 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
     %41 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !438
     %42 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %41, i64 0, !dbg !438
     %43 = addrspacecast {}* inttoptr (i64 136191098789808 to {}*) to {} addrspace(10)*, !dbg !438
     %44 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %43, 0, !dbg !438
     %45 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !438
     %46 = insertvalue [2 x {} addrspace(10)*] %44, {} addrspace(10)* %45, 1, !dbg !438
     %47 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !438
     %48 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %47, i64 0, !dbg !438
     %49 = bitcast i8* %35 to i32*, !dbg !438
     %50 = cmpxchg i32* %49, i32 0, i32 1 acq_rel acquire, align 4, !dbg !438
     %51 = extractvalue { i32, i1 } %50, 0, !dbg !438
; │└└
; │┌ @ promotion.jl:639 within `==`
    %52 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !443
    %53 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %52, i64 0, !dbg !443
    %54 = icmp eq i32 %51, 0, !dbg !443
; │└
   %55 = xor i1 %54, true, !dbg !428
   br i1 %55, label %L48, label %L14, !dbg !428

L14:                                              ; preds = %top
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:87 within `lock_output!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %56 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !445
       %57 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %56, i64 0, !dbg !445
       %58 = addrspacecast {}* inttoptr (i64 136191106427568 to {}*) to {} addrspace(10)*, !dbg !445
       %59 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %58, 0, !dbg !445
       %60 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !445
       %61 = insertvalue [2 x {} addrspace(10)*] %59, {} addrspace(10)* %60, 1, !dbg !445
       %62 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !445
       %63 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %62, i64 0, !dbg !445
       %64 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !445, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %65 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !455
      %66 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %65, i64 0, !dbg !455
      %67 = add i32 %64, 1, !dbg !455
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %68 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !458
       %69 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %68, i64 0, !dbg !458
       %70 = addrspacecast {}* inttoptr (i64 136191106428064 to {}*) to {} addrspace(10)*, !dbg !458
       %71 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %70, 0, !dbg !458
       %72 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !458
       %73 = insertvalue [2 x {} addrspace(10)*] %71, {} addrspace(10)* %72, 1, !dbg !458
       %74 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !458
       %75 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %74, i64 0, !dbg !458
       %76 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !458, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %77 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !463
      %78 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %77, i64 0, !dbg !463
      %79 = add i32 %76, 1, !dbg !463
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %80 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !465
       %81 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %80, i64 0, !dbg !465
       %82 = addrspacecast {}* inttoptr (i64 136191106428560 to {}*) to {} addrspace(10)*, !dbg !465
       %83 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %82, 0, !dbg !465
       %84 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !465
       %85 = insertvalue [2 x {} addrspace(10)*] %83, {} addrspace(10)* %84, 1, !dbg !465
       %86 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !465
       %87 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %86, i64 0, !dbg !465
       %88 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !465, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %89 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !470
      %90 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %89, i64 0, !dbg !470
      %91 = add i32 %88, 1, !dbg !470
; ││└└
; ││┌ @ boot.jl:727 within `NamedTuple`
     %92 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 0, !dbg !472
     store i32 %67, i32 addrspace(5)* %92, align 4, !dbg !472, !tbaa !69, !alias.scope !73, !noalias !76
     %93 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 1, !dbg !472
     store i32 %79, i32 addrspace(5)* %93, align 4, !dbg !472, !tbaa !69, !alias.scope !73, !noalias !76
     %94 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %1, i32 0, i32 2, !dbg !472
     store i32 %91, i32 addrspace(5)* %94, align 4, !dbg !472, !tbaa !69, !alias.scope !73, !noalias !76
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:57 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %95 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !474
      %96 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %95, i64 0, !dbg !474
      %97 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !474
      %98 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %97, i64 0, !dbg !474
      %99 = load i64, i64 addrspace(5)* %17, align 8, !dbg !474, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %100 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !475
     %101 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %100, i64 0, !dbg !475
     %102 = inttoptr i64 %99 to i8*, !dbg !475
     %103 = getelementptr i8, i8* %102, i64 8, !dbg !475
     %104 = ptrtoint i8* %103 to i64, !dbg !475
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %105 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !477
        %106 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %105, i64 0, !dbg !477
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %107 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !480
     %108 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %107, i64 0, !dbg !480
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %109 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !481
     %110 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %109, i64 0, !dbg !481
     %111 = getelementptr inbounds i8, i8* %103, i64 0, !dbg !481
     %112 = bitcast [3 x i32] addrspace(5)* %1 to i8 addrspace(5)*, !dbg !481
     call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %111, i8 addrspace(5)* align 4 %112, i64 12, i1 false), !dbg !481
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:88 within `lock_output!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %113 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !483
       %114 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %113, i64 0, !dbg !483
       %115 = addrspacecast {}* inttoptr (i64 136191106429056 to {}*) to {} addrspace(10)*, !dbg !483
       %116 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %115, 0, !dbg !483
       %117 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !483
       %118 = insertvalue [2 x {} addrspace(10)*] %116, {} addrspace(10)* %117, 1, !dbg !483
       %119 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !483
       %120 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %119, i64 0, !dbg !483
       %121 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !483, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %122 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !491
      %123 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %122, i64 0, !dbg !491
      %124 = add i32 %121, 1, !dbg !491
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %125 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !493
       %126 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %125, i64 0, !dbg !493
       %127 = addrspacecast {}* inttoptr (i64 136182494462464 to {}*) to {} addrspace(10)*, !dbg !493
       %128 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %127, 0, !dbg !493
       %129 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !493
       %130 = insertvalue [2 x {} addrspace(10)*] %128, {} addrspace(10)* %129, 1, !dbg !493
       %131 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !493
       %132 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %131, i64 0, !dbg !493
       %133 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !493, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %134 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !498
      %135 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %134, i64 0, !dbg !498
      %136 = add i32 %133, 1, !dbg !498
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %137 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !500
       %138 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %137, i64 0, !dbg !500
       %139 = addrspacecast {}* inttoptr (i64 136182494462960 to {}*) to {} addrspace(10)*, !dbg !500
       %140 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %139, 0, !dbg !500
       %141 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !500
       %142 = insertvalue [2 x {} addrspace(10)*] %140, {} addrspace(10)* %141, 1, !dbg !500
       %143 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !500
       %144 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %143, i64 0, !dbg !500
       %145 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !500, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %146 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !505
      %147 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %146, i64 0, !dbg !505
      %148 = add i32 %145, 1, !dbg !505
; ││└└
; ││┌ @ boot.jl:727 within `NamedTuple`
     %149 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 0, !dbg !507
     store i32 %124, i32 addrspace(5)* %149, align 4, !dbg !507, !tbaa !69, !alias.scope !73, !noalias !76
     %150 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 1, !dbg !507
     store i32 %136, i32 addrspace(5)* %150, align 4, !dbg !507, !tbaa !69, !alias.scope !73, !noalias !76
     %151 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %2, i32 0, i32 2, !dbg !507
     store i32 %148, i32 addrspace(5)* %151, align 4, !dbg !507, !tbaa !69, !alias.scope !73, !noalias !76
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:60 within `setproperty!`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %152 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !508
      %153 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %152, i64 0, !dbg !508
      %154 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !508
      %155 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %154, i64 0, !dbg !508
      %156 = load i64, i64 addrspace(5)* %17, align 8, !dbg !508, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %157 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !509
     %158 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %157, i64 0, !dbg !509
     %159 = inttoptr i64 %156 to i8*, !dbg !509
     %160 = getelementptr i8, i8* %159, i64 20, !dbg !509
     %161 = ptrtoint i8* %160 to i64, !dbg !509
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %162 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !511
        %163 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %162, i64 0, !dbg !511
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %164 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !514
     %165 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %164, i64 0, !dbg !514
; ││└
; ││┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
     %166 = bitcast {}* inttoptr (i64 136190995409616 to {}*) to {} addrspace(10)**, !dbg !515
     %167 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %166, i64 0, !dbg !515
     %168 = getelementptr inbounds i8, i8* %160, i64 0, !dbg !515
     %169 = bitcast [3 x i32] addrspace(5)* %2 to i8 addrspace(5)*, !dbg !515
     call void @llvm.memcpy.p0i8.p5i8.i64(i8* align 1 %168, i8 addrspace(5)* align 4 %169, i64 12, i1 false), !dbg !515
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:89 within `lock_output!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:27 within `sync_workgroup`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
     %170 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !517
     %171 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %170, i64 0, !dbg !517
     fence syncscope("workgroup") seq_cst, !dbg !517
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:28 within `sync_workgroup`
    call void @llvm.amdgcn.s.barrier(), !dbg !522
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:29 within `sync_workgroup`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:5 within `fence`
     %172 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !523
     %173 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %172, i64 0, !dbg !523
     fence syncscope("workgroup") seq_cst, !dbg !523
; │└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:90 within `lock_output!`
   br label %L133, !dbg !525

L48:                                              ; preds = %top
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:91 within `lock_output!`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:25 within `getproperty`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %174 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !526
      %175 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %174, i64 0, !dbg !526
      %176 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !526
      %177 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %176, i64 0, !dbg !526
      %178 = load i64, i64 addrspace(5)* %17, align 8, !dbg !526, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %179 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !527
     %180 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %179, i64 0, !dbg !527
     %181 = inttoptr i64 %178 to i8*, !dbg !527
     %182 = getelementptr i8, i8* %181, i64 4, !dbg !527
     %183 = ptrtoint i8* %182 to i64, !dbg !527
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %184 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !530
        %185 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %184, i64 0, !dbg !530
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %186 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !533
     %187 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %186, i64 0, !dbg !533
; ││└
; ││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
     %188 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !534
     %189 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %188, i64 0, !dbg !534
     %190 = bitcast i8* %182 to i32*, !dbg !534
     %191 = getelementptr inbounds i32, i32* %190, i64 0, !dbg !534
     %192 = load i32, i32* %191, align 1, !dbg !534, !tbaa !198, !alias.scope !200, !noalias !201
; │└└
; │┌ @ promotion.jl:639 within `==`
    %193 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !537
    %194 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %193, i64 0, !dbg !537
    %195 = icmp eq i32 %192, 1, !dbg !537
; │└
   %196 = xor i1 %195, true, !dbg !529
   br i1 %196, label %L132, label %L55, !dbg !529

L55:                                              ; preds = %L48
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:30 within `getproperty`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %197 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !538
      %198 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %197, i64 0, !dbg !538
      %199 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !538
      %200 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %199, i64 0, !dbg !538
      %201 = load i64, i64 addrspace(5)* %17, align 8, !dbg !538, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %202 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !539
     %203 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %202, i64 0, !dbg !539
     %204 = inttoptr i64 %201 to i8*, !dbg !539
     %205 = getelementptr i8, i8* %204, i64 8, !dbg !539
     %206 = ptrtoint i8* %205 to i64, !dbg !539
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %207 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !541
        %208 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %207, i64 0, !dbg !541
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %209 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !544
     %210 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %209, i64 0, !dbg !544
; ││└
; ││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
     %211 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !545
     %212 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %211, i64 0, !dbg !545
     %213 = bitcast i8* %205 to [3 x i32]*, !dbg !545
     %214 = getelementptr inbounds [3 x i32], [3 x i32]* %213, i64 0, !dbg !545
     %215 = bitcast [3 x i32] addrspace(5)* %3 to i8 addrspace(5)*, !dbg !545
     %216 = bitcast [3 x i32]* %214 to i8*, !dbg !545
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %215, i8* align 1 %216, i64 12, i1 false), !dbg !545, !tbaa !212, !alias.scope !213, !noalias !214
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:122 within `workitemIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %217 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !547
       %218 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %217, i64 0, !dbg !547
       %219 = addrspacecast {}* inttoptr (i64 136191106427568 to {}*) to {} addrspace(10)*, !dbg !547
       %220 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %219, 0, !dbg !547
       %221 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !547
       %222 = insertvalue [2 x {} addrspace(10)*] %220, {} addrspace(10)* %221, 1, !dbg !547
       %223 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !547
       %224 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %223, i64 0, !dbg !547
       %225 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !547, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %226 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !552
      %227 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %226, i64 0, !dbg !552
      %228 = add i32 %225, 1, !dbg !552
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %229 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !554
       %230 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %229, i64 0, !dbg !554
       %231 = addrspacecast {}* inttoptr (i64 136191106428064 to {}*) to {} addrspace(10)*, !dbg !554
       %232 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %231, 0, !dbg !554
       %233 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !554
       %234 = insertvalue [2 x {} addrspace(10)*] %232, {} addrspace(10)* %233, 1, !dbg !554
       %235 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !554
       %236 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %235, i64 0, !dbg !554
       %237 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !554, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %238 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !558
      %239 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %238, i64 0, !dbg !558
      %240 = add i32 %237, 1, !dbg !558
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %241 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !560
       %242 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %241, i64 0, !dbg !560
       %243 = addrspacecast {}* inttoptr (i64 136191106428560 to {}*) to {} addrspace(10)*, !dbg !560
       %244 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %243, 0, !dbg !560
       %245 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !560
       %246 = insertvalue [2 x {} addrspace(10)*] %244, {} addrspace(10)* %245, 1, !dbg !560
       %247 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !560
       %248 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %247, i64 0, !dbg !560
       %249 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !560, !range !110
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %250 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !564
      %251 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %250, i64 0, !dbg !564
      %252 = add i32 %249, 1, !dbg !564
; │└└└
; │┌ @ namedtuple.jl:244 within `==`
; ││┌ @ namedtuple.jl:197 within `Tuple`
     %253 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %254 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %253, i64 0, !dbg !566
     %255 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 0, !dbg !566
     %256 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %257 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %256, i64 0, !dbg !566
     %258 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 1, !dbg !566
     %259 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %260 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %259, i64 0, !dbg !566
     %261 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %3, i32 0, i32 2, !dbg !566
; ││└
; ││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││┌ @ tuple.jl:551 within `_eq`
; │││┌ @ promotion.jl:639 within `==`
      %262 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !570
      %263 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %262, i64 0, !dbg !570
      %264 = load i32, i32 addrspace(5)* %255, align 4, !dbg !570, !tbaa !69, !alias.scope !73, !noalias !76
      %265 = icmp eq i32 %264, %228, !dbg !570
; │││└
; │││ @ tuple.jl:552 within `_eq`
     %266 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !575
     %267 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %266, i64 0, !dbg !575
     %268 = zext i1 %265 to i8, !dbg !575
     %269 = icmp eq i8 %268, 0, !dbg !575
     %270 = xor i1 %269, true, !dbg !575
     br i1 %270, label %L76, label %L75, !dbg !575

L75:                                              ; preds = %L55
; │││ @ tuple.jl:553 within `_eq`
     br label %L89, !dbg !576

L76:                                              ; preds = %L55
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││┌ @ promotion.jl:639 within `==`
      %271 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !577
      %272 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %271, i64 0, !dbg !577
      %273 = load i32, i32 addrspace(5)* %258, align 4, !dbg !577, !tbaa !69, !alias.scope !73, !noalias !76
      %274 = icmp eq i32 %273, %240, !dbg !577
; │││└
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
     %275 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !580
     %276 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %275, i64 0, !dbg !580
     %277 = zext i1 %274 to i8, !dbg !580
     %278 = icmp eq i8 %277, 0, !dbg !580
     %279 = xor i1 %278, true, !dbg !580
     br i1 %279, label %L80, label %L79, !dbg !580

L79:                                              ; preds = %L76
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
     br label %L87, !dbg !581

L80:                                              ; preds = %L76
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; │││┌ @ promotion.jl:639 within `==`
      %280 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !582
      %281 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %280, i64 0, !dbg !582
      %282 = load i32, i32 addrspace(5)* %261, align 4, !dbg !582, !tbaa !69, !alias.scope !73, !noalias !76
      %283 = icmp eq i32 %282, %252, !dbg !582
; │││└
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
     %284 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !585
     %285 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %284, i64 0, !dbg !585
     %286 = zext i1 %283 to i8, !dbg !585
     %287 = icmp eq i8 %286, 0, !dbg !585
     %288 = xor i1 %287, true, !dbg !585
     br i1 %288, label %L84, label %L83, !dbg !585

L83:                                              ; preds = %L80
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
     br label %L85, !dbg !586

L84:                                              ; preds = %L80
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
     br label %L85, !dbg !587

L85:                                              ; preds = %L84, %L83
     %value_phi5 = phi i8 [ 0, %L83 ], [ 1, %L84 ]
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
     br label %L87, !dbg !584

L87:                                              ; preds = %L85, %L79
     %value_phi4 = phi i8 [ 0, %L79 ], [ %value_phi5, %L85 ]
; │││ @ tuple.jl:557 within `_eq`
     br label %L89, !dbg !579

L89:                                              ; preds = %L87, %L75
     %value_phi = phi i8 [ 0, %L75 ], [ %value_phi4, %L87 ]
; ││└
    br label %L91, !dbg !573

L91:                                              ; preds = %L89
    br label %L92, !dbg !573

L92:                                              ; preds = %L91
; │└
   %289 = trunc i8 %value_phi to i1, !dbg !529
   %290 = xor i1 %289, true, !dbg !529
   br i1 %290, label %L132, label %L93, !dbg !529

L93:                                              ; preds = %L92
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:33 within `getproperty`
; ││┌ @ pointer.jl:316 within `+`
; │││┌ @ boot.jl:903 within `UInt64`
      %291 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !588
      %292 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %291, i64 0, !dbg !588
      %293 = bitcast {}* inttoptr (i64 136190955626640 to {}*) to {} addrspace(10)**, !dbg !588
      %294 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %293, i64 0, !dbg !588
      %295 = load i64, i64 addrspace(5)* %17, align 8, !dbg !588, !tbaa !69, !alias.scope !73, !noalias !76
; │││└
     %296 = bitcast {}* inttoptr (i64 136190995414992 to {}*) to {} addrspace(10)**, !dbg !589
     %297 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %296, i64 0, !dbg !589
     %298 = inttoptr i64 %295 to i8*, !dbg !589
     %299 = getelementptr i8, i8* %298, i64 20, !dbg !589
     %300 = ptrtoint i8* %299 to i64, !dbg !589
; │││┌ @ essentials.jl:666 within `oftype`
; ││││┌ @ pointer.jl:26 within `convert`
; │││││┌ @ boot.jl:908 within `Ptr`
        %301 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !591
        %302 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %301, i64 0, !dbg !591
; ││└└└└
; ││┌ @ pointer.jl:30 within `convert`
     %303 = bitcast {}* inttoptr (i64 136190987135728 to {}*) to {} addrspace(10)**, !dbg !594
     %304 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %303, i64 0, !dbg !594
; ││└
; ││┌ @ pointer.jl:153 within `unsafe_load` @ pointer.jl:153
     %305 = bitcast {}* inttoptr (i64 136190995409728 to {}*) to {} addrspace(10)**, !dbg !595
     %306 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %305, i64 0, !dbg !595
     %307 = bitcast i8* %299 to [3 x i32]*, !dbg !595
     %308 = getelementptr inbounds [3 x i32], [3 x i32]* %307, i64 0, !dbg !595
     %309 = bitcast [3 x i32] addrspace(5)* %4 to i8 addrspace(5)*, !dbg !595
     %310 = bitcast [3 x i32]* %308 to i8*, !dbg !595
     call void @llvm.memcpy.p5i8.p0i8.i64(i8 addrspace(5)* align 4 %309, i8* align 1 %310, i64 12, i1 false), !dbg !595, !tbaa !212, !alias.scope !213, !noalias !214
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:130 within `workgroupIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %311 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !597
       %312 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %311, i64 0, !dbg !597
       %313 = addrspacecast {}* inttoptr (i64 136191106429056 to {}*) to {} addrspace(10)*, !dbg !597
       %314 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %313, 0, !dbg !597
       %315 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !597
       %316 = insertvalue [2 x {} addrspace(10)*] %314, {} addrspace(10)* %315, 1, !dbg !597
       %317 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !597
       %318 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %317, i64 0, !dbg !597
       %319 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !597, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %320 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !602
      %321 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %320, i64 0, !dbg !602
      %322 = add i32 %319, 1, !dbg !602
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %323 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !604
       %324 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %323, i64 0, !dbg !604
       %325 = addrspacecast {}* inttoptr (i64 136182494462464 to {}*) to {} addrspace(10)*, !dbg !604
       %326 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %325, 0, !dbg !604
       %327 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !604
       %328 = insertvalue [2 x {} addrspace(10)*] %326, {} addrspace(10)* %327, 1, !dbg !604
       %329 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !604
       %330 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %329, i64 0, !dbg !604
       %331 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !604, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %332 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !608
      %333 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %332, i64 0, !dbg !608
      %334 = add i32 %331, 1, !dbg !608
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl:39
       %335 = bitcast {}* inttoptr (i64 136190964064384 to {}*) to {} addrspace(10)**, !dbg !610
       %336 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %335, i64 0, !dbg !610
       %337 = addrspacecast {}* inttoptr (i64 136182494462960 to {}*) to {} addrspace(10)*, !dbg !610
       %338 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %337, 0, !dbg !610
       %339 = addrspacecast {}* inttoptr (i64 136187430999600 to {}*) to {} addrspace(10)*, !dbg !610
       %340 = insertvalue [2 x {} addrspace(10)*] %338, {} addrspace(10)* %339, 1, !dbg !610
       %341 = bitcast {}* inttoptr (i64 136190960579024 to {}*) to {} addrspace(10)**, !dbg !610
       %342 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %341, i64 0, !dbg !610
       %343 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !610, !range !150
; │││└└
; │││┌ @ int.jl:1013 within `+` @ int.jl:87
      %344 = bitcast {}* inttoptr (i64 136190995415776 to {}*) to {} addrspace(10)**, !dbg !614
      %345 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %344, i64 0, !dbg !614
      %346 = add i32 %343, 1, !dbg !614
; │└└└
; │┌ @ namedtuple.jl:244 within `==`
; ││┌ @ namedtuple.jl:197 within `Tuple`
     %347 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %348 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %347, i64 0, !dbg !566
     %349 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 0, !dbg !566
     %350 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %351 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %350, i64 0, !dbg !566
     %352 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 1, !dbg !566
     %353 = bitcast {}* inttoptr (i64 136190951801808 to {}*) to {} addrspace(10)**, !dbg !566
     %354 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %353, i64 0, !dbg !566
     %355 = getelementptr inbounds [3 x i32], [3 x i32] addrspace(5)* %4, i32 0, i32 2, !dbg !566
; ││└
; ││ @ namedtuple.jl:244 within `==` @ tuple.jl:547
; ││┌ @ tuple.jl:551 within `_eq`
; │││┌ @ promotion.jl:639 within `==`
      %356 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !570
      %357 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %356, i64 0, !dbg !570
      %358 = load i32, i32 addrspace(5)* %349, align 4, !dbg !570, !tbaa !69, !alias.scope !73, !noalias !76
      %359 = icmp eq i32 %358, %322, !dbg !570
; │││└
; │││ @ tuple.jl:552 within `_eq`
     %360 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !575
     %361 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %360, i64 0, !dbg !575
     %362 = zext i1 %359 to i8, !dbg !575
     %363 = icmp eq i8 %362, 0, !dbg !575
     %364 = xor i1 %363, true, !dbg !575
     br i1 %364, label %L114, label %L113, !dbg !575

L113:                                             ; preds = %L93
; │││ @ tuple.jl:553 within `_eq`
     br label %L127, !dbg !576

L114:                                             ; preds = %L93
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:551
; │││┌ @ promotion.jl:639 within `==`
      %365 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !577
      %366 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %365, i64 0, !dbg !577
      %367 = load i32, i32 addrspace(5)* %352, align 4, !dbg !577, !tbaa !69, !alias.scope !73, !noalias !76
      %368 = icmp eq i32 %367, %334, !dbg !577
; │││└
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:552
     %369 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !580
     %370 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %369, i64 0, !dbg !580
     %371 = zext i1 %368 to i8, !dbg !580
     %372 = icmp eq i8 %371, 0, !dbg !580
     %373 = xor i1 %372, true, !dbg !580
     br i1 %373, label %L118, label %L117, !dbg !580

L117:                                             ; preds = %L114
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:553
     br label %L125, !dbg !581

L118:                                             ; preds = %L114
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:551
; │││┌ @ promotion.jl:639 within `==`
      %374 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !582
      %375 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %374, i64 0, !dbg !582
      %376 = load i32, i32 addrspace(5)* %355, align 4, !dbg !582, !tbaa !69, !alias.scope !73, !noalias !76
      %377 = icmp eq i32 %376, %346, !dbg !582
; │││└
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:552
     %378 = bitcast {}* inttoptr (i64 136190972567984 to {}*) to {} addrspace(10)**, !dbg !585
     %379 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %378, i64 0, !dbg !585
     %380 = zext i1 %377 to i8, !dbg !585
     %381 = icmp eq i8 %380, 0, !dbg !585
     %382 = xor i1 %381, true, !dbg !585
     br i1 %382, label %L122, label %L121, !dbg !585

L121:                                             ; preds = %L118
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:553
     br label %L123, !dbg !586

L122:                                             ; preds = %L118
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557 @ tuple.jl:557
     br label %L123, !dbg !587

L123:                                             ; preds = %L122, %L121
     %value_phi3 = phi i8 [ 0, %L121 ], [ 1, %L122 ]
; │││ @ tuple.jl:557 within `_eq` @ tuple.jl:557
     br label %L125, !dbg !584

L125:                                             ; preds = %L123, %L117
     %value_phi2 = phi i8 [ 0, %L117 ], [ %value_phi3, %L123 ]
; │││ @ tuple.jl:557 within `_eq`
     br label %L127, !dbg !579

L127:                                             ; preds = %L125, %L113
     %value_phi1 = phi i8 [ 0, %L113 ], [ %value_phi2, %L125 ]
; ││└
    br label %L129, !dbg !573

L129:                                             ; preds = %L127
    br label %L130, !dbg !573

L130:                                             ; preds = %L129
; │└
   %383 = trunc i8 %value_phi1 to i1, !dbg !529
   %384 = xor i1 %383, true, !dbg !529
   br i1 %384, label %L132, label %L131, !dbg !529

L131:                                             ; preds = %L130
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:97 within `lock_output!`
   br label %L133, !dbg !616

L132:                                             ; preds = %L130, %L92, %L48
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl:100 within `lock_output!`
   br label %L133, !dbg !617

L133:                                             ; preds = %L132, %L131, %L14
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:83 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:6 within `endpgm`
   call void @llvm.amdgcn.endpgm(), !dbg !618
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:84 within `signal_exception`
  unreachable, !dbg !622
}

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #8

attributes #0 = { alwaysinline noreturn }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { convergent nocallback nofree nounwind willreturn }
attributes #3 = { cold noreturn nounwind }
attributes #4 = { memory(none) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #7 = { alwaysinline }
attributes #8 = { cold nocallback nofree noreturn nounwind }
attributes #9 = { noreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35}
!opencl.ocl.version = !{!36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36, !36}
!llvm.ident = !{!37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37, !37}
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
!38 = !{void ({ [1 x i64], i8 addrspace(1)*, i64 })* @_Z4ker_14ROCDeviceArrayI5Int64Li1ELi1EE}
!39 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_11700", scope: null, file: !40, line: 35, type: !41, scopeLine: 35, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!40 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!41 = !DISubroutineType(types: !42)
!42 = !{}
!43 = !DILocation(line: 39, scope: !44, inlinedAt: !46)
!44 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!45 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/base.jl", directory: ".")
!46 = !DILocation(line: 0, scope: !47, inlinedAt: !49)
!47 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!48 = !DIFile(filename: "none", directory: ".")
!49 = !DILocation(line: 0, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!51 = !DILocation(line: 106, scope: !52, inlinedAt: !54)
!52 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!53 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/exceptions.jl", directory: ".")
!54 = !DILocation(line: 35, scope: !39)
!55 = !DILocation(line: 49, scope: !56, inlinedAt: !51)
!56 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !57, file: !57, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!57 = !DIFile(filename: "Base.jl", directory: ".")
!58 = !DILocation(line: 903, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!60 = !DIFile(filename: "boot.jl", directory: ".")
!61 = !DILocation(line: 316, scope: !62, inlinedAt: !64)
!62 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!63 = !DIFile(filename: "pointer.jl", directory: ".")
!64 = !DILocation(line: 27, scope: !65, inlinedAt: !66)
!65 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!66 = !DILocation(line: 85, scope: !67, inlinedAt: !68)
!67 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!68 = !DILocation(line: 107, scope: !52, inlinedAt: !54)
!69 = !{!70, !70, i64 0}
!70 = !{!"jtbaa_stack", !71, i64 0}
!71 = !{!"jtbaa", !72, i64 0}
!72 = !{!"jtbaa"}
!73 = !{!74}
!74 = !{!"jnoalias_stack", !75}
!75 = !{!"jnoalias"}
!76 = !{!77, !78, !79, !80}
!77 = !{!"jnoalias_gcframe", !75}
!78 = !{!"jnoalias_data", !75}
!79 = !{!"jnoalias_typemd", !75}
!80 = !{!"jnoalias_const", !75}
!81 = !DILocation(line: 908, scope: !82, inlinedAt: !83)
!82 = distinct !DISubprogram(name: "Ptr;", linkageName: "Ptr", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!83 = !DILocation(line: 26, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!85 = !DILocation(line: 666, scope: !86, inlinedAt: !61)
!86 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!87 = !DIFile(filename: "essentials.jl", directory: ".")
!88 = !DILocation(line: 730, scope: !89, inlinedAt: !64)
!89 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!90 = !DILocation(line: 39, scope: !44, inlinedAt: !91)
!91 = !DILocation(line: 10, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !93, file: !93, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!93 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!94 = !DILocation(line: 10, scope: !95, inlinedAt: !66)
!95 = distinct !DISubprogram(name: "llvm_atomic_cas;", linkageName: "llvm_atomic_cas", scope: !93, file: !93, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!96 = !DILocation(line: 639, scope: !97, inlinedAt: !66)
!97 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!98 = !DIFile(filename: "promotion.jl", directory: ".")
!99 = !DILocation(line: 39, scope: !44, inlinedAt: !100)
!100 = !DILocation(line: 3, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!102 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!103 = !DILocation(line: 3, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!105 = !DILocation(line: 87, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!107 = !DILocation(line: 122, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!109 = !DILocation(line: 87, scope: !67, inlinedAt: !68)
!110 = !{i32 0, i32 1023}
!111 = !DILocation(line: 87, scope: !112, inlinedAt: !114)
!112 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !113, file: !113, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!113 = !DIFile(filename: "int.jl", directory: ".")
!114 = !DILocation(line: 1013, scope: !112, inlinedAt: !105)
!115 = !DILocation(line: 39, scope: !44, inlinedAt: !116)
!116 = !DILocation(line: 3, scope: !101, inlinedAt: !117)
!117 = !DILocation(line: 3, scope: !104, inlinedAt: !118)
!118 = !DILocation(line: 87, scope: !119, inlinedAt: !107)
!119 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!120 = !DILocation(line: 87, scope: !112, inlinedAt: !121)
!121 = !DILocation(line: 1013, scope: !112, inlinedAt: !118)
!122 = !DILocation(line: 39, scope: !44, inlinedAt: !123)
!123 = !DILocation(line: 3, scope: !101, inlinedAt: !124)
!124 = !DILocation(line: 3, scope: !104, inlinedAt: !125)
!125 = !DILocation(line: 87, scope: !126, inlinedAt: !107)
!126 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!127 = !DILocation(line: 87, scope: !112, inlinedAt: !128)
!128 = !DILocation(line: 1013, scope: !112, inlinedAt: !125)
!129 = !DILocation(line: 727, scope: !130, inlinedAt: !107)
!130 = distinct !DISubprogram(name: "NamedTuple;", linkageName: "NamedTuple", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!131 = !DILocation(line: 903, scope: !59, inlinedAt: !132)
!132 = !DILocation(line: 316, scope: !62, inlinedAt: !133)
!133 = !DILocation(line: 57, scope: !134, inlinedAt: !109)
!134 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!135 = !DILocation(line: 908, scope: !82, inlinedAt: !136)
!136 = !DILocation(line: 26, scope: !84, inlinedAt: !137)
!137 = !DILocation(line: 666, scope: !86, inlinedAt: !132)
!138 = !DILocation(line: 30, scope: !84, inlinedAt: !133)
!139 = !DILocation(line: 180, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!141 = !DILocation(line: 180, scope: !140, inlinedAt: !133)
!142 = !DILocation(line: 39, scope: !44, inlinedAt: !143)
!143 = !DILocation(line: 3, scope: !101, inlinedAt: !144)
!144 = !DILocation(line: 3, scope: !104, inlinedAt: !145)
!145 = !DILocation(line: 93, scope: !146, inlinedAt: !147)
!146 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!147 = !DILocation(line: 130, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!149 = !DILocation(line: 88, scope: !67, inlinedAt: !68)
!150 = !{i32 0, i32 -2}
!151 = !DILocation(line: 87, scope: !112, inlinedAt: !152)
!152 = !DILocation(line: 1013, scope: !112, inlinedAt: !145)
!153 = !DILocation(line: 39, scope: !44, inlinedAt: !154)
!154 = !DILocation(line: 3, scope: !101, inlinedAt: !155)
!155 = !DILocation(line: 3, scope: !104, inlinedAt: !156)
!156 = !DILocation(line: 93, scope: !157, inlinedAt: !147)
!157 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!158 = !DILocation(line: 87, scope: !112, inlinedAt: !159)
!159 = !DILocation(line: 1013, scope: !112, inlinedAt: !156)
!160 = !DILocation(line: 39, scope: !44, inlinedAt: !161)
!161 = !DILocation(line: 3, scope: !101, inlinedAt: !162)
!162 = !DILocation(line: 3, scope: !104, inlinedAt: !163)
!163 = !DILocation(line: 93, scope: !164, inlinedAt: !147)
!164 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!165 = !DILocation(line: 87, scope: !112, inlinedAt: !166)
!166 = !DILocation(line: 1013, scope: !112, inlinedAt: !163)
!167 = !DILocation(line: 727, scope: !130, inlinedAt: !147)
!168 = !DILocation(line: 903, scope: !59, inlinedAt: !169)
!169 = !DILocation(line: 316, scope: !62, inlinedAt: !170)
!170 = !DILocation(line: 60, scope: !134, inlinedAt: !149)
!171 = !DILocation(line: 908, scope: !82, inlinedAt: !172)
!172 = !DILocation(line: 26, scope: !84, inlinedAt: !173)
!173 = !DILocation(line: 666, scope: !86, inlinedAt: !169)
!174 = !DILocation(line: 30, scope: !84, inlinedAt: !170)
!175 = !DILocation(line: 180, scope: !140, inlinedAt: !176)
!176 = !DILocation(line: 180, scope: !140, inlinedAt: !170)
!177 = !DILocation(line: 5, scope: !178, inlinedAt: !180)
!178 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !179, file: !179, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!179 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!180 = !DILocation(line: 27, scope: !181, inlinedAt: !182)
!181 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !179, file: !179, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!182 = !DILocation(line: 89, scope: !67, inlinedAt: !68)
!183 = !DILocation(line: 28, scope: !181, inlinedAt: !182)
!184 = !DILocation(line: 5, scope: !178, inlinedAt: !185)
!185 = !DILocation(line: 29, scope: !181, inlinedAt: !182)
!186 = !DILocation(line: 90, scope: !67, inlinedAt: !68)
!187 = !DILocation(line: 903, scope: !59, inlinedAt: !188)
!188 = !DILocation(line: 316, scope: !62, inlinedAt: !189)
!189 = !DILocation(line: 25, scope: !65, inlinedAt: !190)
!190 = !DILocation(line: 91, scope: !67, inlinedAt: !68)
!191 = !DILocation(line: 908, scope: !82, inlinedAt: !192)
!192 = !DILocation(line: 26, scope: !84, inlinedAt: !193)
!193 = !DILocation(line: 666, scope: !86, inlinedAt: !188)
!194 = !DILocation(line: 30, scope: !84, inlinedAt: !189)
!195 = !DILocation(line: 153, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!197 = !DILocation(line: 153, scope: !196, inlinedAt: !189)
!198 = !{!199, !199, i64 0}
!199 = !{!"jtbaa_data", !71, i64 0}
!200 = !{!78}
!201 = !{!77, !74, !79, !80}
!202 = !DILocation(line: 639, scope: !97, inlinedAt: !190)
!203 = !DILocation(line: 903, scope: !59, inlinedAt: !204)
!204 = !DILocation(line: 316, scope: !62, inlinedAt: !205)
!205 = !DILocation(line: 30, scope: !65, inlinedAt: !190)
!206 = !DILocation(line: 908, scope: !82, inlinedAt: !207)
!207 = !DILocation(line: 26, scope: !84, inlinedAt: !208)
!208 = !DILocation(line: 666, scope: !86, inlinedAt: !204)
!209 = !DILocation(line: 30, scope: !84, inlinedAt: !205)
!210 = !DILocation(line: 153, scope: !196, inlinedAt: !211)
!211 = !DILocation(line: 153, scope: !196, inlinedAt: !205)
!212 = !{!71, !71, i64 0}
!213 = !{!78, !74}
!214 = !{!77, !79, !80}
!215 = !DILocation(line: 39, scope: !44, inlinedAt: !216)
!216 = !DILocation(line: 3, scope: !101, inlinedAt: !217)
!217 = !DILocation(line: 3, scope: !104, inlinedAt: !218)
!218 = !DILocation(line: 87, scope: !106, inlinedAt: !219)
!219 = !DILocation(line: 122, scope: !108, inlinedAt: !190)
!220 = !DILocation(line: 87, scope: !112, inlinedAt: !221)
!221 = !DILocation(line: 1013, scope: !112, inlinedAt: !218)
!222 = !DILocation(line: 39, scope: !44, inlinedAt: !223)
!223 = !DILocation(line: 3, scope: !101, inlinedAt: !224)
!224 = !DILocation(line: 3, scope: !104, inlinedAt: !225)
!225 = !DILocation(line: 87, scope: !119, inlinedAt: !219)
!226 = !DILocation(line: 87, scope: !112, inlinedAt: !227)
!227 = !DILocation(line: 1013, scope: !112, inlinedAt: !225)
!228 = !DILocation(line: 39, scope: !44, inlinedAt: !229)
!229 = !DILocation(line: 3, scope: !101, inlinedAt: !230)
!230 = !DILocation(line: 3, scope: !104, inlinedAt: !231)
!231 = !DILocation(line: 87, scope: !126, inlinedAt: !219)
!232 = !DILocation(line: 87, scope: !112, inlinedAt: !233)
!233 = !DILocation(line: 1013, scope: !112, inlinedAt: !231)
!234 = !DILocation(line: 197, scope: !235, inlinedAt: !237)
!235 = distinct !DISubprogram(name: "Tuple;", linkageName: "Tuple", scope: !236, file: !236, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!236 = !DIFile(filename: "namedtuple.jl", directory: ".")
!237 = !DILocation(line: 244, scope: !238, inlinedAt: !190)
!238 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !236, file: !236, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!239 = !DILocation(line: 639, scope: !97, inlinedAt: !240)
!240 = !DILocation(line: 551, scope: !241, inlinedAt: !243)
!241 = distinct !DISubprogram(name: "_eq;", linkageName: "_eq", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!242 = !DIFile(filename: "tuple.jl", directory: ".")
!243 = !DILocation(line: 547, scope: !244, inlinedAt: !237)
!244 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!245 = !DILocation(line: 552, scope: !241, inlinedAt: !243)
!246 = !DILocation(line: 553, scope: !241, inlinedAt: !243)
!247 = !DILocation(line: 639, scope: !97, inlinedAt: !248)
!248 = !DILocation(line: 551, scope: !241, inlinedAt: !249)
!249 = !DILocation(line: 557, scope: !241, inlinedAt: !243)
!250 = !DILocation(line: 552, scope: !241, inlinedAt: !249)
!251 = !DILocation(line: 553, scope: !241, inlinedAt: !249)
!252 = !DILocation(line: 639, scope: !97, inlinedAt: !253)
!253 = !DILocation(line: 551, scope: !241, inlinedAt: !254)
!254 = !DILocation(line: 557, scope: !241, inlinedAt: !249)
!255 = !DILocation(line: 552, scope: !241, inlinedAt: !254)
!256 = !DILocation(line: 553, scope: !241, inlinedAt: !254)
!257 = !DILocation(line: 557, scope: !241, inlinedAt: !254)
!258 = !DILocation(line: 903, scope: !59, inlinedAt: !259)
!259 = !DILocation(line: 316, scope: !62, inlinedAt: !260)
!260 = !DILocation(line: 33, scope: !65, inlinedAt: !190)
!261 = !DILocation(line: 908, scope: !82, inlinedAt: !262)
!262 = !DILocation(line: 26, scope: !84, inlinedAt: !263)
!263 = !DILocation(line: 666, scope: !86, inlinedAt: !259)
!264 = !DILocation(line: 30, scope: !84, inlinedAt: !260)
!265 = !DILocation(line: 153, scope: !196, inlinedAt: !266)
!266 = !DILocation(line: 153, scope: !196, inlinedAt: !260)
!267 = !DILocation(line: 39, scope: !44, inlinedAt: !268)
!268 = !DILocation(line: 3, scope: !101, inlinedAt: !269)
!269 = !DILocation(line: 3, scope: !104, inlinedAt: !270)
!270 = !DILocation(line: 93, scope: !146, inlinedAt: !271)
!271 = !DILocation(line: 130, scope: !148, inlinedAt: !190)
!272 = !DILocation(line: 87, scope: !112, inlinedAt: !273)
!273 = !DILocation(line: 1013, scope: !112, inlinedAt: !270)
!274 = !DILocation(line: 39, scope: !44, inlinedAt: !275)
!275 = !DILocation(line: 3, scope: !101, inlinedAt: !276)
!276 = !DILocation(line: 3, scope: !104, inlinedAt: !277)
!277 = !DILocation(line: 93, scope: !157, inlinedAt: !271)
!278 = !DILocation(line: 87, scope: !112, inlinedAt: !279)
!279 = !DILocation(line: 1013, scope: !112, inlinedAt: !277)
!280 = !DILocation(line: 39, scope: !44, inlinedAt: !281)
!281 = !DILocation(line: 3, scope: !101, inlinedAt: !282)
!282 = !DILocation(line: 3, scope: !104, inlinedAt: !283)
!283 = !DILocation(line: 93, scope: !164, inlinedAt: !271)
!284 = !DILocation(line: 87, scope: !112, inlinedAt: !285)
!285 = !DILocation(line: 1013, scope: !112, inlinedAt: !283)
!286 = !DILocation(line: 97, scope: !67, inlinedAt: !68)
!287 = !DILocation(line: 100, scope: !67, inlinedAt: !68)
!288 = !DILocation(line: 39, scope: !44, inlinedAt: !289)
!289 = !DILocation(line: 0, scope: !47, inlinedAt: !290)
!290 = !DILocation(line: 0, scope: !291, inlinedAt: !292)
!291 = distinct !DISubprogram(name: "alloc_string;", linkageName: "alloc_string", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !42)
!292 = !DILocation(line: 108, scope: !52, inlinedAt: !54)
!293 = !DILocation(line: 903, scope: !59, inlinedAt: !294)
!294 = !DILocation(line: 316, scope: !62, inlinedAt: !295)
!295 = !DILocation(line: 65, scope: !134, inlinedAt: !296)
!296 = !DILocation(line: 109, scope: !52, inlinedAt: !54)
!297 = !DILocation(line: 908, scope: !82, inlinedAt: !298)
!298 = !DILocation(line: 26, scope: !84, inlinedAt: !299)
!299 = !DILocation(line: 666, scope: !86, inlinedAt: !294)
!300 = !DILocation(line: 30, scope: !84, inlinedAt: !295)
!301 = !DILocation(line: 180, scope: !140, inlinedAt: !302)
!302 = !DILocation(line: 180, scope: !140, inlinedAt: !295)
!303 = !DILocation(line: 903, scope: !59, inlinedAt: !304)
!304 = !DILocation(line: 316, scope: !62, inlinedAt: !305)
!305 = !DILocation(line: 71, scope: !134, inlinedAt: !306)
!306 = !DILocation(line: 110, scope: !52, inlinedAt: !54)
!307 = !DILocation(line: 908, scope: !82, inlinedAt: !308)
!308 = !DILocation(line: 26, scope: !84, inlinedAt: !309)
!309 = !DILocation(line: 666, scope: !86, inlinedAt: !304)
!310 = !DILocation(line: 30, scope: !84, inlinedAt: !305)
!311 = !DILocation(line: 180, scope: !140, inlinedAt: !312)
!312 = !DILocation(line: 180, scope: !140, inlinedAt: !305)
!313 = !{!314, !314, i64 0}
!314 = !{!"jtbaa_immut", !315, i64 0}
!315 = !{!"jtbaa_value", !199, i64 0}
!316 = !DILocation(line: 112, scope: !52, inlinedAt: !54)
!317 = !{!318, !318, i64 0, i64 1}
!318 = !{!"jtbaa_const", !71, i64 0}
!319 = !{!80}
!320 = !{!77, !74, !78, !79}
!321 = distinct !DISubprogram(name: "ker!", linkageName: "julia_ker!_11685", scope: null, file: !322, line: 3, type: !41, scopeLine: 3, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!322 = !DIFile(filename: "/home/pxlth/.julia/dev/t.jl", directory: ".")
!323 = !DILocation(line: 80, scope: !324, inlinedAt: !326)
!324 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!325 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!326 = !DILocation(line: 6, scope: !321)
!327 = !DILocation(line: 49, scope: !328, inlinedAt: !329)
!328 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !57, file: !57, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!329 = !DILocation(line: 67, scope: !330, inlinedAt: !331)
!330 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!331 = !DILocation(line: 98, scope: !332, inlinedAt: !334)
!332 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !333, file: !333, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!333 = !DIFile(filename: "abstractarray.jl", directory: ".")
!334 = !DILocation(line: 137, scope: !335, inlinedAt: !336)
!335 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !333, file: !333, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!336 = !DILocation(line: 389, scope: !337, inlinedAt: !338)
!337 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !333, file: !333, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!338 = !DILocation(line: 689, scope: !339, inlinedAt: !340)
!339 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !333, file: !333, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!340 = !DILocation(line: 699, scope: !339, inlinedAt: !323)
!341 = !DILocation(line: 31, scope: !342, inlinedAt: !343)
!342 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!343 = !DILocation(line: 355, scope: !344, inlinedAt: !331)
!344 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!345 = !DILocation(line: 730, scope: !346, inlinedAt: !347)
!346 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!347 = !DILocation(line: 668, scope: !348, inlinedAt: !349)
!348 = distinct !DISubprogram(name: "unsigned;", linkageName: "unsigned", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!349 = !DILocation(line: 754, scope: !350, inlinedAt: !338)
!350 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !333, file: !333, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!351 = !DILocation(line: 513, scope: !352, inlinedAt: !349)
!352 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !113, file: !113, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!353 = !DILocation(line: 49, scope: !328, inlinedAt: !354)
!354 = !DILocation(line: 64, scope: !355, inlinedAt: !356)
!355 = distinct !DISubprogram(name: "unsafe_convert;", linkageName: "unsafe_convert", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!356 = !DILocation(line: 59, scope: !357, inlinedAt: !358)
!357 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!358 = !DILocation(line: 81, scope: !324, inlinedAt: !326)
!359 = !DILocation(line: 39, scope: !360, inlinedAt: !361)
!360 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!361 = !DILocation(line: 0, scope: !362, inlinedAt: !363)
!362 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!363 = !DILocation(line: 0, scope: !364, inlinedAt: !365)
!364 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!365 = !DILocation(line: 85, scope: !366, inlinedAt: !358)
!366 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !367, file: !367, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!367 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/UFrs4/src/interop/pointer.jl", directory: ".")
!368 = !{!369, !369, i64 0, i64 0}
!369 = !{!"custom_tbaa_addrspace(1)", !370, i64 0}
!370 = !{!"custom_tbaa"}
!371 = !DILocation(line: 85, scope: !372, inlinedAt: !326)
!372 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !325, file: !325, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!373 = !DILocation(line: 697, scope: !339, inlinedAt: !371)
!374 = !DILocation(line: 49, scope: !328, inlinedAt: !375)
!375 = !DILocation(line: 67, scope: !330, inlinedAt: !376)
!376 = !DILocation(line: 98, scope: !332, inlinedAt: !377)
!377 = !DILocation(line: 137, scope: !335, inlinedAt: !378)
!378 = !DILocation(line: 389, scope: !337, inlinedAt: !379)
!379 = !DILocation(line: 689, scope: !339, inlinedAt: !380)
!380 = !DILocation(line: 699, scope: !339, inlinedAt: !371)
!381 = !DILocation(line: 31, scope: !342, inlinedAt: !382)
!382 = !DILocation(line: 355, scope: !344, inlinedAt: !376)
!383 = !DILocation(line: 86, scope: !384, inlinedAt: !385)
!384 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !113, file: !113, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!385 = !DILocation(line: 754, scope: !350, inlinedAt: !379)
!386 = !DILocation(line: 730, scope: !346, inlinedAt: !387)
!387 = !DILocation(line: 668, scope: !348, inlinedAt: !385)
!388 = !DILocation(line: 513, scope: !352, inlinedAt: !385)
!389 = !DILocation(line: 49, scope: !328, inlinedAt: !390)
!390 = !DILocation(line: 64, scope: !355, inlinedAt: !391)
!391 = !DILocation(line: 59, scope: !357, inlinedAt: !392)
!392 = !DILocation(line: 86, scope: !372, inlinedAt: !326)
!393 = !DILocation(line: 39, scope: !360, inlinedAt: !394)
!394 = !DILocation(line: 0, scope: !362, inlinedAt: !395)
!395 = !DILocation(line: 0, scope: !396, inlinedAt: !397)
!396 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!397 = !DILocation(line: 88, scope: !398, inlinedAt: !392)
!398 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !367, file: !367, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !42)
!399 = !DILocation(line: 86, scope: !384, inlinedAt: !393)
!400 = !DILocation(line: 87, scope: !372, inlinedAt: !326)
!401 = !DILocation(line: 7, scope: !321)
!402 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_14549", scope: null, file: !93, line: 91, type: !41, scopeLine: 91, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !10, retainedNodes: !42)
!403 = !DILocation(line: 91, scope: !402)
!404 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_14626", scope: null, file: !93, line: 78, type: !41, scopeLine: 78, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!405 = !DILocation(line: 39, scope: !406, inlinedAt: !407)
!406 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !45, file: !45, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!407 = !DILocation(line: 0, scope: !408, inlinedAt: !409)
!408 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!409 = !DILocation(line: 0, scope: !410, inlinedAt: !411)
!410 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !48, file: !48, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!411 = !DILocation(line: 79, scope: !404)
!412 = !DILocation(line: 49, scope: !413, inlinedAt: !411)
!413 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !57, file: !57, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!414 = !DILocation(line: 30, scope: !415, inlinedAt: !416)
!415 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!416 = !DILocation(line: 52, scope: !417, inlinedAt: !418)
!417 = distinct !DISubprogram(name: "setproperty!;", linkageName: "setproperty!", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!418 = !DILocation(line: 80, scope: !404)
!419 = !DILocation(line: 180, scope: !420, inlinedAt: !421)
!420 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!421 = !DILocation(line: 180, scope: !420, inlinedAt: !416)
!422 = !DILocation(line: 903, scope: !423, inlinedAt: !424)
!423 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!424 = !DILocation(line: 316, scope: !425, inlinedAt: !426)
!425 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!426 = !DILocation(line: 27, scope: !427, inlinedAt: !428)
!427 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!428 = !DILocation(line: 85, scope: !429, inlinedAt: !430)
!429 = distinct !DISubprogram(name: "lock_output!;", linkageName: "lock_output!", scope: !53, file: !53, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!430 = !DILocation(line: 82, scope: !404)
!431 = !DILocation(line: 908, scope: !432, inlinedAt: !433)
!432 = distinct !DISubprogram(name: "Ptr;", linkageName: "Ptr", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!433 = !DILocation(line: 26, scope: !415, inlinedAt: !434)
!434 = !DILocation(line: 666, scope: !435, inlinedAt: !424)
!435 = distinct !DISubprogram(name: "oftype;", linkageName: "oftype", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!436 = !DILocation(line: 730, scope: !437, inlinedAt: !426)
!437 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !87, file: !87, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!438 = !DILocation(line: 39, scope: !406, inlinedAt: !439)
!439 = !DILocation(line: 10, scope: !440, inlinedAt: !441)
!440 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !93, file: !93, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!441 = !DILocation(line: 10, scope: !442, inlinedAt: !428)
!442 = distinct !DISubprogram(name: "llvm_atomic_cas;", linkageName: "llvm_atomic_cas", scope: !93, file: !93, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!443 = !DILocation(line: 639, scope: !444, inlinedAt: !428)
!444 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !98, file: !98, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!445 = !DILocation(line: 39, scope: !406, inlinedAt: !446)
!446 = !DILocation(line: 3, scope: !447, inlinedAt: !448)
!447 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!448 = !DILocation(line: 3, scope: !449, inlinedAt: !450)
!449 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!450 = !DILocation(line: 87, scope: !451, inlinedAt: !452)
!451 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!452 = !DILocation(line: 122, scope: !453, inlinedAt: !454)
!453 = distinct !DISubprogram(name: "workitemIdx;", linkageName: "workitemIdx", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!454 = !DILocation(line: 87, scope: !429, inlinedAt: !430)
!455 = !DILocation(line: 87, scope: !456, inlinedAt: !457)
!456 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !113, file: !113, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!457 = !DILocation(line: 1013, scope: !456, inlinedAt: !450)
!458 = !DILocation(line: 39, scope: !406, inlinedAt: !459)
!459 = !DILocation(line: 3, scope: !447, inlinedAt: !460)
!460 = !DILocation(line: 3, scope: !449, inlinedAt: !461)
!461 = !DILocation(line: 87, scope: !462, inlinedAt: !452)
!462 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!463 = !DILocation(line: 87, scope: !456, inlinedAt: !464)
!464 = !DILocation(line: 1013, scope: !456, inlinedAt: !461)
!465 = !DILocation(line: 39, scope: !406, inlinedAt: !466)
!466 = !DILocation(line: 3, scope: !447, inlinedAt: !467)
!467 = !DILocation(line: 3, scope: !449, inlinedAt: !468)
!468 = !DILocation(line: 87, scope: !469, inlinedAt: !452)
!469 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!470 = !DILocation(line: 87, scope: !456, inlinedAt: !471)
!471 = !DILocation(line: 1013, scope: !456, inlinedAt: !468)
!472 = !DILocation(line: 727, scope: !473, inlinedAt: !452)
!473 = distinct !DISubprogram(name: "NamedTuple;", linkageName: "NamedTuple", scope: !60, file: !60, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!474 = !DILocation(line: 903, scope: !423, inlinedAt: !475)
!475 = !DILocation(line: 316, scope: !425, inlinedAt: !476)
!476 = !DILocation(line: 57, scope: !417, inlinedAt: !454)
!477 = !DILocation(line: 908, scope: !432, inlinedAt: !478)
!478 = !DILocation(line: 26, scope: !415, inlinedAt: !479)
!479 = !DILocation(line: 666, scope: !435, inlinedAt: !475)
!480 = !DILocation(line: 30, scope: !415, inlinedAt: !476)
!481 = !DILocation(line: 180, scope: !420, inlinedAt: !482)
!482 = !DILocation(line: 180, scope: !420, inlinedAt: !476)
!483 = !DILocation(line: 39, scope: !406, inlinedAt: !484)
!484 = !DILocation(line: 3, scope: !447, inlinedAt: !485)
!485 = !DILocation(line: 3, scope: !449, inlinedAt: !486)
!486 = !DILocation(line: 93, scope: !487, inlinedAt: !488)
!487 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!488 = !DILocation(line: 130, scope: !489, inlinedAt: !490)
!489 = distinct !DISubprogram(name: "workgroupIdx;", linkageName: "workgroupIdx", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!490 = !DILocation(line: 88, scope: !429, inlinedAt: !430)
!491 = !DILocation(line: 87, scope: !456, inlinedAt: !492)
!492 = !DILocation(line: 1013, scope: !456, inlinedAt: !486)
!493 = !DILocation(line: 39, scope: !406, inlinedAt: !494)
!494 = !DILocation(line: 3, scope: !447, inlinedAt: !495)
!495 = !DILocation(line: 3, scope: !449, inlinedAt: !496)
!496 = !DILocation(line: 93, scope: !497, inlinedAt: !488)
!497 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!498 = !DILocation(line: 87, scope: !456, inlinedAt: !499)
!499 = !DILocation(line: 1013, scope: !456, inlinedAt: !496)
!500 = !DILocation(line: 39, scope: !406, inlinedAt: !501)
!501 = !DILocation(line: 3, scope: !447, inlinedAt: !502)
!502 = !DILocation(line: 3, scope: !449, inlinedAt: !503)
!503 = !DILocation(line: 93, scope: !504, inlinedAt: !488)
!504 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !102, file: !102, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!505 = !DILocation(line: 87, scope: !456, inlinedAt: !506)
!506 = !DILocation(line: 1013, scope: !456, inlinedAt: !503)
!507 = !DILocation(line: 727, scope: !473, inlinedAt: !488)
!508 = !DILocation(line: 903, scope: !423, inlinedAt: !509)
!509 = !DILocation(line: 316, scope: !425, inlinedAt: !510)
!510 = !DILocation(line: 60, scope: !417, inlinedAt: !490)
!511 = !DILocation(line: 908, scope: !432, inlinedAt: !512)
!512 = !DILocation(line: 26, scope: !415, inlinedAt: !513)
!513 = !DILocation(line: 666, scope: !435, inlinedAt: !509)
!514 = !DILocation(line: 30, scope: !415, inlinedAt: !510)
!515 = !DILocation(line: 180, scope: !420, inlinedAt: !516)
!516 = !DILocation(line: 180, scope: !420, inlinedAt: !510)
!517 = !DILocation(line: 5, scope: !518, inlinedAt: !519)
!518 = distinct !DISubprogram(name: "fence;", linkageName: "fence", scope: !179, file: !179, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!519 = !DILocation(line: 27, scope: !520, inlinedAt: !521)
!520 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !179, file: !179, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!521 = !DILocation(line: 89, scope: !429, inlinedAt: !430)
!522 = !DILocation(line: 28, scope: !520, inlinedAt: !521)
!523 = !DILocation(line: 5, scope: !518, inlinedAt: !524)
!524 = !DILocation(line: 29, scope: !520, inlinedAt: !521)
!525 = !DILocation(line: 90, scope: !429, inlinedAt: !430)
!526 = !DILocation(line: 903, scope: !423, inlinedAt: !527)
!527 = !DILocation(line: 316, scope: !425, inlinedAt: !528)
!528 = !DILocation(line: 25, scope: !427, inlinedAt: !529)
!529 = !DILocation(line: 91, scope: !429, inlinedAt: !430)
!530 = !DILocation(line: 908, scope: !432, inlinedAt: !531)
!531 = !DILocation(line: 26, scope: !415, inlinedAt: !532)
!532 = !DILocation(line: 666, scope: !435, inlinedAt: !527)
!533 = !DILocation(line: 30, scope: !415, inlinedAt: !528)
!534 = !DILocation(line: 153, scope: !535, inlinedAt: !536)
!535 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !63, file: !63, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!536 = !DILocation(line: 153, scope: !535, inlinedAt: !528)
!537 = !DILocation(line: 639, scope: !444, inlinedAt: !529)
!538 = !DILocation(line: 903, scope: !423, inlinedAt: !539)
!539 = !DILocation(line: 316, scope: !425, inlinedAt: !540)
!540 = !DILocation(line: 30, scope: !427, inlinedAt: !529)
!541 = !DILocation(line: 908, scope: !432, inlinedAt: !542)
!542 = !DILocation(line: 26, scope: !415, inlinedAt: !543)
!543 = !DILocation(line: 666, scope: !435, inlinedAt: !539)
!544 = !DILocation(line: 30, scope: !415, inlinedAt: !540)
!545 = !DILocation(line: 153, scope: !535, inlinedAt: !546)
!546 = !DILocation(line: 153, scope: !535, inlinedAt: !540)
!547 = !DILocation(line: 39, scope: !406, inlinedAt: !548)
!548 = !DILocation(line: 3, scope: !447, inlinedAt: !549)
!549 = !DILocation(line: 3, scope: !449, inlinedAt: !550)
!550 = !DILocation(line: 87, scope: !451, inlinedAt: !551)
!551 = !DILocation(line: 122, scope: !453, inlinedAt: !529)
!552 = !DILocation(line: 87, scope: !456, inlinedAt: !553)
!553 = !DILocation(line: 1013, scope: !456, inlinedAt: !550)
!554 = !DILocation(line: 39, scope: !406, inlinedAt: !555)
!555 = !DILocation(line: 3, scope: !447, inlinedAt: !556)
!556 = !DILocation(line: 3, scope: !449, inlinedAt: !557)
!557 = !DILocation(line: 87, scope: !462, inlinedAt: !551)
!558 = !DILocation(line: 87, scope: !456, inlinedAt: !559)
!559 = !DILocation(line: 1013, scope: !456, inlinedAt: !557)
!560 = !DILocation(line: 39, scope: !406, inlinedAt: !561)
!561 = !DILocation(line: 3, scope: !447, inlinedAt: !562)
!562 = !DILocation(line: 3, scope: !449, inlinedAt: !563)
!563 = !DILocation(line: 87, scope: !469, inlinedAt: !551)
!564 = !DILocation(line: 87, scope: !456, inlinedAt: !565)
!565 = !DILocation(line: 1013, scope: !456, inlinedAt: !563)
!566 = !DILocation(line: 197, scope: !567, inlinedAt: !568)
!567 = distinct !DISubprogram(name: "Tuple;", linkageName: "Tuple", scope: !236, file: !236, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!568 = !DILocation(line: 244, scope: !569, inlinedAt: !529)
!569 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !236, file: !236, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!570 = !DILocation(line: 639, scope: !444, inlinedAt: !571)
!571 = !DILocation(line: 551, scope: !572, inlinedAt: !573)
!572 = distinct !DISubprogram(name: "_eq;", linkageName: "_eq", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!573 = !DILocation(line: 547, scope: !574, inlinedAt: !568)
!574 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !242, file: !242, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!575 = !DILocation(line: 552, scope: !572, inlinedAt: !573)
!576 = !DILocation(line: 553, scope: !572, inlinedAt: !573)
!577 = !DILocation(line: 639, scope: !444, inlinedAt: !578)
!578 = !DILocation(line: 551, scope: !572, inlinedAt: !579)
!579 = !DILocation(line: 557, scope: !572, inlinedAt: !573)
!580 = !DILocation(line: 552, scope: !572, inlinedAt: !579)
!581 = !DILocation(line: 553, scope: !572, inlinedAt: !579)
!582 = !DILocation(line: 639, scope: !444, inlinedAt: !583)
!583 = !DILocation(line: 551, scope: !572, inlinedAt: !584)
!584 = !DILocation(line: 557, scope: !572, inlinedAt: !579)
!585 = !DILocation(line: 552, scope: !572, inlinedAt: !584)
!586 = !DILocation(line: 553, scope: !572, inlinedAt: !584)
!587 = !DILocation(line: 557, scope: !572, inlinedAt: !584)
!588 = !DILocation(line: 903, scope: !423, inlinedAt: !589)
!589 = !DILocation(line: 316, scope: !425, inlinedAt: !590)
!590 = !DILocation(line: 33, scope: !427, inlinedAt: !529)
!591 = !DILocation(line: 908, scope: !432, inlinedAt: !592)
!592 = !DILocation(line: 26, scope: !415, inlinedAt: !593)
!593 = !DILocation(line: 666, scope: !435, inlinedAt: !589)
!594 = !DILocation(line: 30, scope: !415, inlinedAt: !590)
!595 = !DILocation(line: 153, scope: !535, inlinedAt: !596)
!596 = !DILocation(line: 153, scope: !535, inlinedAt: !590)
!597 = !DILocation(line: 39, scope: !406, inlinedAt: !598)
!598 = !DILocation(line: 3, scope: !447, inlinedAt: !599)
!599 = !DILocation(line: 3, scope: !449, inlinedAt: !600)
!600 = !DILocation(line: 93, scope: !487, inlinedAt: !601)
!601 = !DILocation(line: 130, scope: !489, inlinedAt: !529)
!602 = !DILocation(line: 87, scope: !456, inlinedAt: !603)
!603 = !DILocation(line: 1013, scope: !456, inlinedAt: !600)
!604 = !DILocation(line: 39, scope: !406, inlinedAt: !605)
!605 = !DILocation(line: 3, scope: !447, inlinedAt: !606)
!606 = !DILocation(line: 3, scope: !449, inlinedAt: !607)
!607 = !DILocation(line: 93, scope: !497, inlinedAt: !601)
!608 = !DILocation(line: 87, scope: !456, inlinedAt: !609)
!609 = !DILocation(line: 1013, scope: !456, inlinedAt: !607)
!610 = !DILocation(line: 39, scope: !406, inlinedAt: !611)
!611 = !DILocation(line: 3, scope: !447, inlinedAt: !612)
!612 = !DILocation(line: 3, scope: !449, inlinedAt: !613)
!613 = !DILocation(line: 93, scope: !504, inlinedAt: !601)
!614 = !DILocation(line: 87, scope: !456, inlinedAt: !615)
!615 = !DILocation(line: 1013, scope: !456, inlinedAt: !613)
!616 = !DILocation(line: 97, scope: !429, inlinedAt: !430)
!617 = !DILocation(line: 100, scope: !429, inlinedAt: !430)
!618 = !DILocation(line: 6, scope: !619, inlinedAt: !621)
!619 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !620, file: !620, type: !41, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !18, retainedNodes: !42)
!620 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!621 = !DILocation(line: 83, scope: !404)
!622 = !DILocation(line: 84, scope: !404)
