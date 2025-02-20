; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@jl_nothing = external local_unnamed_addr addrspace(1) constant {}*
@_j_const_1 = private unnamed_addr addrspace(1) constant [1 x i64] [i64 32], align 8
@_j_const_2 = private unnamed_addr addrspace(1) constant i64 32, align 8
@_j_const_3 = private unnamed_addr addrspace(1) constant i64 1, align 8
@"alloc_special_##static_shmem#231" = external addrspace(3) global [32 x [2 x float]], align 32
@exception.5 = private unnamed_addr constant [10 x i8] c"exception\00", align 1
@_j_const_1.19 = private unnamed_addr addrspace(1) constant i32 1, align 4
@__oclc_wavefrontsize64 = internal unnamed_addr addrspace(4) constant i8 0, align 1

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8 addrspace(5)* noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.wavefrontsize() #2

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #3

; Function Attrs: convergent nocallback nofree nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.ds.bpermute(i32, i32) #4

; Function Attrs: convergent nocallback nofree nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.x() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.y() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workgroup.id.z() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.x() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.y() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.amdgcn.workitem.id.z() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #6

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:40 within `#throw_inexacterror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* noundef nonnull %0, i32 zeroext %1) unnamed_addr #7 !dbg !44 {
top:
  %pgcstack = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_inexacterror`
  %4 = bitcast {}* inttoptr (i64 130978849182544 to {}*) to {} addrspace(10)**, !dbg !48
  %5 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %4, i64 0, !dbg !48
  %6 = bitcast {}* inttoptr (i64 130978824301904 to {}*) to {} addrspace(10)**, !dbg !48
  %7 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %6, i64 0, !dbg !48
  %8 = load {}*, {}* addrspace(1)* @jl_nothing, align 8, !dbg !48, !tbaa !49, !invariant.load !47, !alias.scope !53, !noalias !56, !nonnull !47
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.5 to i64)), !dbg !48
  call fastcc void @gpu_signal_exception(), !dbg !48
  call void @llvm.trap(), !dbg !48
  unreachable, !dbg !48
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:44 within `#throw_boundserror`
; Function Attrs: alwaysinline noreturn
define internal fastcc void @julia__throw_boundserror_12219({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(24) %0, [1 x i64] addrspace(11)* nocapture noundef nonnull readonly align 8 dereferenceable(8) %1) unnamed_addr #7 !dbg !61 {
top:
  %pgcstack = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:8 within `#throw_boundserror`
  %4 = bitcast {}* inttoptr (i64 130978849182544 to {}*) to {} addrspace(10)**, !dbg !62
  %5 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %4, i64 0, !dbg !62
  %6 = bitcast {}* inttoptr (i64 130978824301904 to {}*) to {} addrspace(10)**, !dbg !62
  %7 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %6, i64 0, !dbg !62
  %8 = load {}*, {}* addrspace(1)* @jl_nothing, align 8, !dbg !62, !tbaa !49, !invariant.load !47, !alias.scope !53, !noalias !56, !nonnull !47
  call fastcc void @gpu_report_exception(i64 ptrtoint ([10 x i8]* @exception.5 to i64)), !dbg !62
  call fastcc void @gpu_signal_exception(), !dbg !62
  call void @llvm.trap(), !dbg !62
  unreachable, !dbg !62
}

;  @ none within `gpu_groupreduce_1!`
define amdgpu_kernel void @_Z18gpu_groupreduce_1_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILi1E5TupleI5OneToI5Int64EEE7NDRangeILi1ES0_10StaticSizeI6_256__ES8_vEE14ROCDeviceArrayI7Float32Li1ELi1EESG_1_SF_({ [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } %0, { [1 x i64], i8 addrspace(1)*, i64 } %1, { [1 x i64], i8 addrspace(1)*, i64 } %2, float %3) local_unnamed_addr #8 !dbg !63 {
conversion:
  %4 = alloca { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, align 8, addrspace(5)
  %5 = addrspacecast { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(5)* %4 to { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)*
  store { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } %0, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)* %5, align 8
  %6 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %7 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %6 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %1, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %7, align 8
  %8 = alloca { [1 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %9 = addrspacecast { [1 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %8 to { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [1 x i64], i8 addrspace(1)*, i64 } %2, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %9, align 8
  br label %top

top:                                              ; preds = %conversion
  %10 = alloca [1 x i64], align 8, addrspace(5)
  %11 = alloca [1 x i64], align 8, addrspace(5)
  %12 = alloca [1 x i64], align 8, addrspace(5)
  %13 = alloca [1 x i64], align 8, addrspace(5)
  %14 = alloca [1 x i64], align 8, addrspace(5)
  %15 = alloca [1 x i64], align 8, addrspace(5)
  %16 = alloca [1 x i64], align 8, addrspace(5)
  %17 = alloca [1 x i64], align 8, addrspace(5)
  %18 = alloca [1 x [1 x [1 x i64]]], align 8, addrspace(5)
  %19 = alloca [1 x i64], align 8, addrspace(5)
  %20 = alloca [2 x float], align 4, addrspace(5)
  %21 = alloca [2 x float], align 4, addrspace(5)
  %22 = alloca { [1 x i64], i8 addrspace(3)*, i64 }, align 8, addrspace(5)
  %23 = alloca [2 x float], align 4, addrspace(5)
  %24 = alloca [2 x float], align 4, addrspace(5)
  %25 = alloca [2 x float], align 4, addrspace(5)
  %26 = alloca [1 x i32], align 4, addrspace(5)
  %27 = alloca [1 x i32], align 4, addrspace(5)
  %28 = alloca [2 x float], align 4, addrspace(5)
  %29 = alloca [2 x float], align 4, addrspace(5)
  %30 = alloca [2 x float], align 4, addrspace(5)
  %31 = alloca [2 x float], align 4, addrspace(5)
  %32 = alloca [2 x float], align 4, addrspace(5)
  %33 = alloca [2 x float], align 4, addrspace(5)
  %34 = alloca [2 x float], align 4, addrspace(5)
  %35 = alloca [2 x float], align 4, addrspace(5)
  %36 = alloca [1 x i64], align 8, addrspace(5)
  %37 = alloca [1 x i64], align 8, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %38 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %38, i64 -14
  %39 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %39, i64 15
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:96
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:141 within `#__validindex`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:23 within `__iterspace`
; ││┌ @ Base.jl:49 within `getproperty`
     %40 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !65
     %41 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %40, i64 0, !dbg !65
     %42 = getelementptr inbounds { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)* %5, i32 0, i32 1, !dbg !65
; │└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %43 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !78
        %44 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %43, i64 0, !dbg !78
        %45 = addrspacecast {}* inttoptr (i64 130978984494560 to {}*) to {} addrspace(10)*, !dbg !78
        %46 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %45, 0, !dbg !78
        %47 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !78
        %48 = insertvalue [2 x {} addrspace(10)*] %46, {} addrspace(10)* %47, 1, !dbg !78
        %49 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !78
        %50 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %49, i64 0, !dbg !78
        %51 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !78, !range !92
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %52 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !93
       %53 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %52, i64 0, !dbg !93
       %54 = add i32 %51, 1, !dbg !93
; ││└└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %55 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !97
        %56 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %55, i64 0, !dbg !97
        %57 = addrspacecast {}* inttoptr (i64 130978984495056 to {}*) to {} addrspace(10)*, !dbg !97
        %58 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %57, 0, !dbg !97
        %59 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !97
        %60 = insertvalue [2 x {} addrspace(10)*] %58, {} addrspace(10)* %59, 1, !dbg !97
        %61 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !97
        %62 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %61, i64 0, !dbg !97
        %63 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !97, !range !92
; ││└└└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %64 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !104
        %65 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %64, i64 0, !dbg !104
        %66 = addrspacecast {}* inttoptr (i64 130978984496048 to {}*) to {} addrspace(10)*, !dbg !104
        %67 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %66, 0, !dbg !104
        %68 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !104
        %69 = insertvalue [2 x {} addrspace(10)*] %67, {} addrspace(10)* %68, 1, !dbg !104
        %70 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !104
        %71 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %70, i64 0, !dbg !104
        %72 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !104, !range !92
; │└└└└└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %73 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !111
        %74 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %73, i64 0, !dbg !111
        %75 = addrspacecast {}* inttoptr (i64 130978984496544 to {}*) to {} addrspace(10)*, !dbg !111
        %76 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %75, 0, !dbg !111
        %77 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !111
        %78 = insertvalue [2 x {} addrspace(10)*] %76, {} addrspace(10)* %77, 1, !dbg !111
        %79 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !111
        %80 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %79, i64 0, !dbg !111
        %81 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !111, !range !120
; ││││└└
; ││││┌ @ int.jl:1013 within `+` @ int.jl:87
       %82 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !121
       %83 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %82, i64 0, !dbg !121
       %84 = add i32 %81, 1, !dbg !121
; ││└└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %85 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !123
        %86 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %85, i64 0, !dbg !123
        %87 = addrspacecast {}* inttoptr (i64 130978984497040 to {}*) to {} addrspace(10)*, !dbg !123
        %88 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %87, 0, !dbg !123
        %89 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !123
        %90 = insertvalue [2 x {} addrspace(10)*] %88, {} addrspace(10)* %89, 1, !dbg !123
        %91 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !123
        %92 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %91, i64 0, !dbg !123
        %93 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !123, !range !120
; ││└└└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %94 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !130
        %95 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %94, i64 0, !dbg !130
        %96 = addrspacecast {}* inttoptr (i64 130978984497536 to {}*) to {} addrspace(10)*, !dbg !130
        %97 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %96, 0, !dbg !130
        %98 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !130
        %99 = insertvalue [2 x {} addrspace(10)*] %97, {} addrspace(10)* %98, 1, !dbg !130
        %100 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !130
        %101 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %100, i64 0, !dbg !130
        %102 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !130, !range !120
; │└└└└└
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:117 within `expand`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:64 within `blocks`
; │││┌ @ Base.jl:49 within `getproperty`
      %103 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !137
      %104 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %103, i64 0, !dbg !137
      %105 = getelementptr inbounds { [1 x [1 x [1 x i64]]] }, { [1 x [1 x [1 x i64]]] } addrspace(11)* %42, i32 0, i32 0, !dbg !137
; ││└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:119 within `expand`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
; │││┌ @ ntuple.jl:48 within `ntuple`
; ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:110 within `#3`
; │││││┌ @ Base.jl:49 within `getproperty`
        %106 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !143
        %107 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %106, i64 0, !dbg !143
        %108 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %105, i32 0, i32 0, !dbg !143
; │││││└
; │││││┌ @ tuple.jl:31 within `getindex`
        %109 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !152
        %110 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %109, i64 0, !dbg !152
        %111 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %108, i32 0, i32 0, !dbg !152
; │││││└
; │││││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
; │││││┌ @ Base.jl:49 within `getproperty`
        %112 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !155
        %113 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %112, i64 0, !dbg !155
        %114 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %111, i32 0, i32 0, !dbg !155
; │││││└
; │││││┌ @ operators.jl:379 within `>`
; ││││││┌ @ int.jl:83 within `<`
         %115 = bitcast {}* inttoptr (i64 130978868083248 to {}*) to {} addrspace(10)**, !dbg !157
         %116 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %115, i64 0, !dbg !157
         %117 = load i64, i64 addrspace(11)* %114, align 8, !dbg !157, !alias.scope !53, !noalias !56
         %118 = icmp slt i64 0, %117, !dbg !157
; │││││└└
; │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
        %119 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !162
        %120 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %119, i64 0, !dbg !162
        %121 = addrspacecast {}* inttoptr (i64 130978248286352 to {}*) to {} addrspace(10)*, !dbg !162
        %122 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %121, 0, !dbg !162
        %123 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !162
        %124 = insertvalue [2 x {} addrspace(10)*] %122, {} addrspace(10)* %123, 1, !dbg !162
        %125 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !162
        %126 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %125, i64 0, !dbg !162
        %127 = zext i1 %118 to i8, !dbg !162
        call void @llvm.assume(i1 %118), !dbg !162
; ││└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:120 within `expand`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
; │││┌ @ ntuple.jl:48 within `ntuple`
; ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
; │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
        %128 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !164
        %129 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %128, i64 0, !dbg !164
        %130 = addrspacecast {}* inttoptr (i64 130978248286352 to {}*) to {} addrspace(10)*, !dbg !164
        %131 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %130, 0, !dbg !164
        %132 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !164
        %133 = insertvalue [2 x {} addrspace(10)*] %131, {} addrspace(10)* %132, 1, !dbg !164
        %134 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !164
        %135 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %134, i64 0, !dbg !164
        call void @llvm.assume(i1 true), !dbg !164
; ││└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
; ││┌ @ abstractarray.jl:1312 within `getindex`
; │││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
; ││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:892 within `Int64`
; │││││││┌ @ boot.jl:816 within `toInt64`
          %136 = bitcast {}* inttoptr (i64 130978868080896 to {}*) to {} addrspace(10)**, !dbg !169
          %137 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %136, i64 0, !dbg !169
          %138 = bitcast {}* inttoptr (i64 130978827565104 to {}*) to {} addrspace(10)**, !dbg !169
          %139 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %138, i64 0, !dbg !169
          %140 = zext i32 %54 to i64, !dbg !169
; │││└└└└└
; │││┌ @ abstractarray.jl:1358 within `_getindex`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
       br label %L43, !dbg !188

L43:                                              ; preds = %top
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
; │││││┌ @ Base.jl:49 within `getproperty`
        %141 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !192
        %142 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %141, i64 0, !dbg !192
        %143 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %105, i32 0, i32 0, !dbg !192
; │││││└
; │││││┌ @ tuple.jl:382 within `map`
; ││││││┌ @ tuple.jl:31 within `getindex`
         %144 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !194
         %145 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %144, i64 0, !dbg !194
         %146 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %143, i32 0, i32 0, !dbg !194
; ││││││└
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
; │││││││┌ @ array.jl:3076 within `getindex`
; ││││││││┌ @ range.jl:922 within `_getindex`
           br label %L59, !dbg !197

L59:                                              ; preds = %L43
; │││││││││┌ @ abstractarray.jl:699 within `checkbounds`
            br label %L60, !dbg !205

L60:                                              ; preds = %L59
            br label %L61, !dbg !205

L61:                                              ; preds = %L60
            br label %L62, !dbg !205

L62:                                              ; preds = %L61
            br label %L63, !dbg !205

L63:                                              ; preds = %L62
            br label %L64, !dbg !205

L64:                                              ; preds = %L63
            br label %L65, !dbg !205

L65:                                              ; preds = %L64
            br label %L66, !dbg !205

L66:                                              ; preds = %L65
; │││└└└└└└└
; │││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
; ││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:892 within `Int64`
; │││││││┌ @ boot.jl:816 within `toInt64`
          %147 = bitcast {}* inttoptr (i64 130978868080896 to {}*) to {} addrspace(10)**, !dbg !169
          %148 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %147, i64 0, !dbg !169
          %149 = bitcast {}* inttoptr (i64 130978827565104 to {}*) to {} addrspace(10)**, !dbg !169
          %150 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %149, i64 0, !dbg !169
          %151 = zext i32 %84 to i64, !dbg !169
; │││└└└└└
; │││┌ @ abstractarray.jl:1358 within `_getindex`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
       br label %L78, !dbg !188

L78:                                              ; preds = %L66
; │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
; │││││┌ @ tuple.jl:382 within `map`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
; │││││││┌ @ array.jl:3076 within `getindex`
; ││││││││┌ @ range.jl:922 within `_getindex`
           br label %L89, !dbg !197

L89:                                              ; preds = %L78
; │││││││││┌ @ abstractarray.jl:699 within `checkbounds`
            br label %L90, !dbg !205

L90:                                              ; preds = %L89
            br label %L91, !dbg !205

L91:                                              ; preds = %L90
            br label %L92, !dbg !205

L92:                                              ; preds = %L91
            br label %L93, !dbg !205

L93:                                              ; preds = %L92
            br label %L94, !dbg !205

L94:                                              ; preds = %L93
            br label %L95, !dbg !205

L95:                                              ; preds = %L94
            br label %L96, !dbg !205

L96:                                              ; preds = %L95
; ││└└└└└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand` @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:75
; ││┌ @ ntuple.jl:48 within `ntuple`
; │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:79 within `#1`
; ││││┌ @ int.jl:86 within `-`
       %152 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !207
       %153 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %152, i64 0, !dbg !207
       %154 = sub i64 %140, 1, !dbg !207
; ││││└
; ││││┌ @ int.jl:88 within `*`
       %155 = bitcast {}* inttoptr (i64 130978868085040 to {}*) to {} addrspace(10)**, !dbg !213
       %156 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %155, i64 0, !dbg !213
       %157 = mul i64 %154, 256, !dbg !213
; ││││└
; ││││┌ @ int.jl:87 within `+`
       %158 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !215
       %159 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %158, i64 0, !dbg !215
       %160 = add i64 %157, %151, !dbg !215
; ││└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
    br label %L100, !dbg !187

L100:                                             ; preds = %L96
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:142 within `#__validindex`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:28 within `__ndrange`
; ││┌ @ Base.jl:49 within `getproperty`
     %161 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !216
     %162 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %161, i64 0, !dbg !216
     %163 = getelementptr inbounds { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)* %5, i32 0, i32 0, !dbg !216
; │└└
; │┌ @ multidimensional.jl:477 within `in`
; ││┌ @ Base.jl:49 within `getproperty`
     %164 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !220
     %165 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %164, i64 0, !dbg !220
     %166 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %163, i32 0, i32 0, !dbg !220
; ││└
; ││┌ @ tuple.jl:382 within `map`
; │││┌ @ tuple.jl:31 within `getindex`
      %167 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !224
      %168 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %167, i64 0, !dbg !224
      %169 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %166, i32 0, i32 0, !dbg !224
; │││└
; │││┌ @ range.jl:1426 within `in`
; ││││┌ @ int.jl:514 within `<=`
       %170 = bitcast {}* inttoptr (i64 130978868083024 to {}*) to {} addrspace(10)**, !dbg !226
       %171 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %170, i64 0, !dbg !226
       %172 = icmp sle i64 1, %160, !dbg !226
; ││││└
; ││││┌ @ range.jl:846 within `last`
; │││││┌ @ Base.jl:49 within `getproperty`
        %173 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !230
        %174 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %173, i64 0, !dbg !230
        %175 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %169, i32 0, i32 0, !dbg !230
; ││││└└
; ││││┌ @ int.jl:514 within `<=`
       %176 = bitcast {}* inttoptr (i64 130978868083024 to {}*) to {} addrspace(10)**, !dbg !226
       %177 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %176, i64 0, !dbg !226
       %178 = load i64, i64 addrspace(11)* %175, align 8, !dbg !226, !alias.scope !53, !noalias !56
       %179 = icmp sle i64 %160, %178, !dbg !226
; ││││└
; ││││┌ @ bool.jl:38 within `&`
       %180 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !233
       %181 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %180, i64 0, !dbg !233
       %182 = and i1 %172, %179, !dbg !233
; │└└└└
   br label %L109, !dbg !219

L109:                                             ; preds = %L100
; └
  %183 = xor i1 %182, true, !dbg !74
  br i1 %183, label %L550, label %L110, !dbg !74

L110:                                             ; preds = %L109
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:15 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:122 within `#__index_Global_Linear`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:23 within `__iterspace`
; │││┌ @ Base.jl:49 within `getproperty`
      %184 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !236
      %185 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %184, i64 0, !dbg !236
      %186 = getelementptr inbounds { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)* %5, i32 0, i32 1, !dbg !236
; ││└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %187 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !244
         %188 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %187, i64 0, !dbg !244
         %189 = addrspacecast {}* inttoptr (i64 130978984494560 to {}*) to {} addrspace(10)*, !dbg !244
         %190 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %189, 0, !dbg !244
         %191 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !244
         %192 = insertvalue [2 x {} addrspace(10)*] %190, {} addrspace(10)* %191, 1, !dbg !244
         %193 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !244
         %194 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %193, i64 0, !dbg !244
         %195 = call i32 @llvm.amdgcn.workgroup.id.x(), !dbg !244, !range !92
; │││││└└
; │││││┌ @ int.jl:1013 within `+` @ int.jl:87
        %196 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !250
        %197 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %196, i64 0, !dbg !250
        %198 = add i32 %195, 1, !dbg !250
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %199 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !252
         %200 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %199, i64 0, !dbg !252
         %201 = addrspacecast {}* inttoptr (i64 130978984495056 to {}*) to {} addrspace(10)*, !dbg !252
         %202 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %201, 0, !dbg !252
         %203 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !252
         %204 = insertvalue [2 x {} addrspace(10)*] %202, {} addrspace(10)* %203, 1, !dbg !252
         %205 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !252
         %206 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %205, i64 0, !dbg !252
         %207 = call i32 @llvm.amdgcn.workgroup.id.y(), !dbg !252, !range !92
; │││└└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %208 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !257
         %209 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %208, i64 0, !dbg !257
         %210 = addrspacecast {}* inttoptr (i64 130978984496048 to {}*) to {} addrspace(10)*, !dbg !257
         %211 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %210, 0, !dbg !257
         %212 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !257
         %213 = insertvalue [2 x {} addrspace(10)*] %211, {} addrspace(10)* %212, 1, !dbg !257
         %214 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !257
         %215 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %214, i64 0, !dbg !257
         %216 = call i32 @llvm.amdgcn.workgroup.id.z(), !dbg !257, !range !92
; ││└└└└└
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %217 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !262
         %218 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %217, i64 0, !dbg !262
         %219 = addrspacecast {}* inttoptr (i64 130978984496544 to {}*) to {} addrspace(10)*, !dbg !262
         %220 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %219, 0, !dbg !262
         %221 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !262
         %222 = insertvalue [2 x {} addrspace(10)*] %220, {} addrspace(10)* %221, 1, !dbg !262
         %223 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !262
         %224 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %223, i64 0, !dbg !262
         %225 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !262, !range !120
; │││││└└
; │││││┌ @ int.jl:1013 within `+` @ int.jl:87
        %226 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !268
        %227 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %226, i64 0, !dbg !268
        %228 = add i32 %225, 1, !dbg !268
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %229 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !270
         %230 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %229, i64 0, !dbg !270
         %231 = addrspacecast {}* inttoptr (i64 130978984497040 to {}*) to {} addrspace(10)*, !dbg !270
         %232 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %231, 0, !dbg !270
         %233 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !270
         %234 = insertvalue [2 x {} addrspace(10)*] %232, {} addrspace(10)* %233, 1, !dbg !270
         %235 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !270
         %236 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %235, i64 0, !dbg !270
         %237 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !270, !range !120
; │││└└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
         %238 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !275
         %239 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %238, i64 0, !dbg !275
         %240 = addrspacecast {}* inttoptr (i64 130978984497536 to {}*) to {} addrspace(10)*, !dbg !275
         %241 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %240, 0, !dbg !275
         %242 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !275
         %243 = insertvalue [2 x {} addrspace(10)*] %241, {} addrspace(10)* %242, 1, !dbg !275
         %244 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !275
         %245 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %244, i64 0, !dbg !275
         %246 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !275, !range !120
; ││└└└└└
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:117 within `expand`
; │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:64 within `blocks`
; ││││┌ @ Base.jl:49 within `getproperty`
       %247 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !280
       %248 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %247, i64 0, !dbg !280
       %249 = getelementptr inbounds { [1 x [1 x [1 x i64]]] }, { [1 x [1 x [1 x i64]]] } addrspace(11)* %186, i32 0, i32 0, !dbg !280
; │││└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:119 within `expand`
; │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
; ││││┌ @ ntuple.jl:48 within `ntuple`
; │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:110 within `#3`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %250 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !283
         %251 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %250, i64 0, !dbg !283
         %252 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %249, i32 0, i32 0, !dbg !283
; ││││││└
; ││││││┌ @ tuple.jl:31 within `getindex`
         %253 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !288
         %254 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %253, i64 0, !dbg !288
         %255 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %252, i32 0, i32 0, !dbg !288
; ││││││└
; ││││││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %256 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !289
         %257 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %256, i64 0, !dbg !289
         %258 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %255, i32 0, i32 0, !dbg !289
; ││││││└
; ││││││┌ @ operators.jl:379 within `>`
; │││││││┌ @ int.jl:83 within `<`
          %259 = bitcast {}* inttoptr (i64 130978868083248 to {}*) to {} addrspace(10)**, !dbg !291
          %260 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %259, i64 0, !dbg !291
          %261 = load i64, i64 addrspace(11)* %258, align 8, !dbg !291, !alias.scope !53, !noalias !56
          %262 = icmp slt i64 0, %261, !dbg !291
; ││││││└└
; ││││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
         %263 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !293
         %264 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %263, i64 0, !dbg !293
         %265 = addrspacecast {}* inttoptr (i64 130978248286352 to {}*) to {} addrspace(10)*, !dbg !293
         %266 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %265, 0, !dbg !293
         %267 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !293
         %268 = insertvalue [2 x {} addrspace(10)*] %266, {} addrspace(10)* %267, 1, !dbg !293
         %269 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !293
         %270 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %269, i64 0, !dbg !293
         %271 = zext i1 %262 to i8, !dbg !293
         call void @llvm.assume(i1 %262), !dbg !293
; │││└└└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:120 within `expand`
; │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
; ││││┌ @ ntuple.jl:48 within `ntuple`
; │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
; ││││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
         %272 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !294
         %273 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %272, i64 0, !dbg !294
         %274 = addrspacecast {}* inttoptr (i64 130978248286352 to {}*) to {} addrspace(10)*, !dbg !294
         %275 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %274, 0, !dbg !294
         %276 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !294
         %277 = insertvalue [2 x {} addrspace(10)*] %275, {} addrspace(10)* %276, 1, !dbg !294
         %278 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !294
         %279 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %278, i64 0, !dbg !294
         call void @llvm.assume(i1 true), !dbg !294
; │││└└└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
; │││┌ @ abstractarray.jl:1312 within `getindex`
; ││││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
; │││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
; ││││││┌ @ number.jl:7 within `convert`
; │││││││┌ @ boot.jl:892 within `Int64`
; ││││││││┌ @ boot.jl:816 within `toInt64`
           %280 = bitcast {}* inttoptr (i64 130978868080896 to {}*) to {} addrspace(10)**, !dbg !299
           %281 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %280, i64 0, !dbg !299
           %282 = bitcast {}* inttoptr (i64 130978827565104 to {}*) to {} addrspace(10)**, !dbg !299
           %283 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %282, i64 0, !dbg !299
           %284 = zext i32 %198 to i64, !dbg !299
; ││││└└└└└
; ││││┌ @ abstractarray.jl:1358 within `_getindex`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
        br label %L152, !dbg !308

L152:                                             ; preds = %L110
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
; ││││││┌ @ Base.jl:49 within `getproperty`
         %285 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !310
         %286 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %285, i64 0, !dbg !310
         %287 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %249, i32 0, i32 0, !dbg !310
; ││││││└
; ││││││┌ @ tuple.jl:382 within `map`
; │││││││┌ @ tuple.jl:31 within `getindex`
          %288 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !312
          %289 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %288, i64 0, !dbg !312
          %290 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %287, i32 0, i32 0, !dbg !312
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
; ││││││││┌ @ array.jl:3076 within `getindex`
; │││││││││┌ @ range.jl:922 within `_getindex`
            br label %L168, !dbg !314

L168:                                             ; preds = %L152
; ││││││││││┌ @ abstractarray.jl:699 within `checkbounds`
             br label %L169, !dbg !317

L169:                                             ; preds = %L168
             br label %L170, !dbg !317

L170:                                             ; preds = %L169
             br label %L171, !dbg !317

L171:                                             ; preds = %L170
             br label %L172, !dbg !317

L172:                                             ; preds = %L171
             br label %L173, !dbg !317

L173:                                             ; preds = %L172
             br label %L174, !dbg !317

L174:                                             ; preds = %L173
             br label %L175, !dbg !317

L175:                                             ; preds = %L174
; ││││└└└└└└└
; ││││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
; │││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
; ││││││┌ @ number.jl:7 within `convert`
; │││││││┌ @ boot.jl:892 within `Int64`
; ││││││││┌ @ boot.jl:816 within `toInt64`
           %291 = bitcast {}* inttoptr (i64 130978868080896 to {}*) to {} addrspace(10)**, !dbg !299
           %292 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %291, i64 0, !dbg !299
           %293 = bitcast {}* inttoptr (i64 130978827565104 to {}*) to {} addrspace(10)**, !dbg !299
           %294 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %293, i64 0, !dbg !299
           %295 = zext i32 %228 to i64, !dbg !299
; ││││└└└└└
; ││││┌ @ abstractarray.jl:1358 within `_getindex`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
        br label %L187, !dbg !308

L187:                                             ; preds = %L175
; ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
; ││││││┌ @ tuple.jl:382 within `map`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
; ││││││││┌ @ array.jl:3076 within `getindex`
; │││││││││┌ @ range.jl:922 within `_getindex`
            br label %L198, !dbg !314

L198:                                             ; preds = %L187
; ││││││││││┌ @ abstractarray.jl:699 within `checkbounds`
             br label %L199, !dbg !317

L199:                                             ; preds = %L198
             br label %L200, !dbg !317

L200:                                             ; preds = %L199
             br label %L201, !dbg !317

L201:                                             ; preds = %L200
             br label %L202, !dbg !317

L202:                                             ; preds = %L201
             br label %L203, !dbg !317

L203:                                             ; preds = %L202
             br label %L204, !dbg !317

L204:                                             ; preds = %L203
             br label %L205, !dbg !317

L205:                                             ; preds = %L204
; │││└└└└└└└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand` @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:75
; │││┌ @ ntuple.jl:48 within `ntuple`
; ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:79 within `#1`
; │││││┌ @ int.jl:86 within `-`
        %296 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !318
        %297 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %296, i64 0, !dbg !318
        %298 = sub i64 %284, 1, !dbg !318
; │││││└
; │││││┌ @ int.jl:88 within `*`
        %299 = bitcast {}* inttoptr (i64 130978868085040 to {}*) to {} addrspace(10)**, !dbg !322
        %300 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %299, i64 0, !dbg !322
        %301 = mul i64 %298, 256, !dbg !322
; │││││└
; │││││┌ @ int.jl:87 within `+`
        %302 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !323
        %303 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %302, i64 0, !dbg !323
        %304 = add i64 %301, %295, !dbg !323
; │││└└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
     br label %L209, !dbg !307

L209:                                             ; preds = %L205
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:124 within `#__index_Global_Linear`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:28 within `__ndrange`
; │││┌ @ Base.jl:49 within `getproperty`
      %305 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !324
      %306 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %305, i64 0, !dbg !324
      %307 = getelementptr inbounds { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } } addrspace(11)* %5, i32 0, i32 0, !dbg !324
; ││└└
; ││┌ @ multidimensional.jl:582 within `LinearIndices`
; │││┌ @ Base.jl:49 within `getproperty`
      %308 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !327
      %309 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %308, i64 0, !dbg !327
      %310 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %307, i32 0, i32 0, !dbg !327
; │││└
; │││ @ multidimensional.jl:582 within `LinearIndices` @ indices.jl:484
     %311 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(5)* %18, i32 0, i32 0, !dbg !330
     %312 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %310, i32 0, i32 0, !dbg !330
     %313 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %312, i32 0, i32 0, !dbg !330
     %314 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(5)* %311, i32 0, i32 0, !dbg !330
     %315 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %314, i32 0, i32 0, !dbg !330
     %316 = load i64, i64 addrspace(11)* %313, align 8, !dbg !330, !alias.scope !53, !noalias !56
     store i64 %316, i64 addrspace(5)* %315, align 8, !dbg !330, !tbaa !332, !alias.scope !334, !noalias !335
; ││└
; ││┌ @ abstractarray.jl:1312 within `getindex`
; │││┌ @ abstractarray.jl:1336 within `_getindex`
; ││││┌ @ indices.jl:518 within `getindex`
       br label %L227, !dbg !336

L227:                                             ; preds = %L209
; │││││┌ @ abstractarray.jl:699 within `checkbounds`
        br label %L228, !dbg !340

L228:                                             ; preds = %L227
        br label %L229, !dbg !340

L229:                                             ; preds = %L228
        br label %L230, !dbg !340

L230:                                             ; preds = %L229
        br label %L231, !dbg !340

L231:                                             ; preds = %L230
; │└└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:16 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:71 within `length`
; ││┌ @ Base.jl:49 within `getproperty`
     %317 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !341
     %318 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %317, i64 0, !dbg !341
     %319 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %9, i32 0, i32 2, !dbg !341
; │└└
; │┌ @ operators.jl:379 within `>`
; ││┌ @ int.jl:83 within `<`
     %320 = bitcast {}* inttoptr (i64 130978868083248 to {}*) to {} addrspace(10)**, !dbg !346
     %321 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %320, i64 0, !dbg !346
     %322 = load i64, i64 addrspace(11)* %319, align 8, !dbg !346, !alias.scope !53, !noalias !56
     %323 = icmp slt i64 %322, %304, !dbg !346
; │└└
   %324 = xor i1 %323, true, !dbg !345
   br i1 %324, label %L235, label %L234, !dbg !345

L234:                                             ; preds = %L231
   br label %L256, !dbg !345

L235:                                             ; preds = %L231
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
    br label %L237, !dbg !348

L237:                                             ; preds = %L235
; ││┌ @ abstractarray.jl:697 within `checkbounds`
     %325 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !350
     %326 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %325, i64 0, !dbg !350
     %327 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %37, i32 0, i32 0, !dbg !350
     store i64 %304, i64 addrspace(5)* %327, align 8, !dbg !350, !tbaa !332, !alias.scope !334, !noalias !335
; │││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; │││┌ @ abstractarray.jl:389 within `eachindex`
; ││││┌ @ abstractarray.jl:137 within `axes1`
; │││││┌ @ abstractarray.jl:98 within `axes`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `size`
; │││││││┌ @ Base.jl:49 within `getproperty`
          %328 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !351
          %329 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %328, i64 0, !dbg !351
          %330 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %9, i32 0, i32 0, !dbg !351
; ││││││└└
; ││││││┌ @ tuple.jl:355 within `map`
; │││││││┌ @ tuple.jl:31 within `getindex`
          %331 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !362
          %332 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %331, i64 0, !dbg !362
          %333 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %330, i32 0, i32 0, !dbg !362
; │││└└└└└
; │││┌ @ abstractarray.jl:754 within `checkindex`
; ││││┌ @ int.jl:86 within `-`
       %334 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !364
       %335 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %334, i64 0, !dbg !364
       %336 = sub i64 %304, 1, !dbg !364
; ││││└
; ││││┌ @ essentials.jl:668 within `unsigned`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %337 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !367
        %338 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %337, i64 0, !dbg !367
        %339 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !367
        %340 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %339, i64 0, !dbg !367
        %341 = load i64, i64 addrspace(11)* %333, align 8, !dbg !367, !alias.scope !53, !noalias !56
; ││││└└
; ││││┌ @ int.jl:513 within `<`
       %342 = bitcast {}* inttoptr (i64 130978868083136 to {}*) to {} addrspace(10)**, !dbg !372
       %343 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %342, i64 0, !dbg !372
       %344 = icmp ult i64 %336, %341, !dbg !372
; │││└└
; │││ @ abstractarray.jl:699 within `checkbounds`
     %345 = xor i1 %344, true, !dbg !361
     br i1 %345, label %L247, label %L246, !dbg !361

L246:                                             ; preds = %L237
     br label %L249, !dbg !361

L247:                                             ; preds = %L237
     %346 = bitcast {}* inttoptr (i64 130978879164528 to {}*) to {} addrspace(10)**, !dbg !361
     %347 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %346, i64 0, !dbg !361
     %348 = addrspacecast [1 x i64] addrspace(5)* %37 to [1 x i64] addrspace(11)*, !dbg !361
     call fastcc void @julia__throw_boundserror_12219({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %9, [1 x i64] addrspace(11)* nocapture readonly %348) #15, !dbg !361
     unreachable, !dbg !361

L249:                                             ; preds = %L246
     br label %L250, !dbg !361

L250:                                             ; preds = %L249
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `pointer`
; │││┌ @ Base.jl:49 within `getproperty`
      %349 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !373
      %350 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %349, i64 0, !dbg !373
      %351 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %9, i32 0, i32 1, !dbg !373
; ││└└
; ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
; │││┌ @ none within `pointerref`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
       %352 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !377
       %353 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %352, i64 0, !dbg !377
       %354 = addrspacecast {}* inttoptr (i64 130979022722928 to {}*) to {} addrspace(10)*, !dbg !377
       %355 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %354, 0, !dbg !377
       %356 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !377
       %357 = insertvalue [2 x {} addrspace(10)*] %355, {} addrspace(10)* %356, 1, !dbg !377
; │││││┌ @ int.jl:86 within `-`
        %358 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !385
        %359 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %358, i64 0, !dbg !385
        %360 = sub i64 %304, 1, !dbg !385
; │││││└
       %361 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !377
       %362 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %361, i64 0, !dbg !377
       %363 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %351, align 8, !dbg !377, !alias.scope !53, !noalias !56
       %364 = bitcast i8 addrspace(1)* %363 to float addrspace(1)*, !dbg !377
       %365 = getelementptr inbounds float, float addrspace(1)* %364, i64 %360, !dbg !377
       %366 = load float, float addrspace(1)* %365, align 4, !dbg !377, !tbaa !386
       br label %L255, !dbg !377

L255:                                             ; preds = %L250
       br label %L256, !dbg !377

L256:                                             ; preds = %L255, %L234
       %value_phi = phi float [ %3, %L234 ], [ %366, %L255 ]
; │└└└└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:17 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
    %367 = bitcast {}* inttoptr (i64 130979027043232 to {}*) to {} addrspace(10)**, !dbg !389
    %368 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %367, i64 0, !dbg !389
    %369 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %20, i32 0, i32 0, !dbg !389
    store float %value_phi, float addrspace(5)* %369, align 4, !dbg !389, !tbaa !332, !alias.scope !334, !noalias !335
    %370 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %20, i32 0, i32 1, !dbg !389
    store float %value_phi, float addrspace(5)* %370, align 4, !dbg !389, !tbaa !332, !alias.scope !334, !noalias !335
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:18 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
    %371 = bitcast {}* inttoptr (i64 130979027043232 to {}*) to {} addrspace(10)**, !dbg !392
    %372 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %371, i64 0, !dbg !392
    %373 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %21, i32 0, i32 0, !dbg !392
    store float %3, float addrspace(5)* %373, align 4, !dbg !392, !tbaa !332, !alias.scope !334, !noalias !335
    %374 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %21, i32 0, i32 1, !dbg !392
    store float %3, float addrspace(5)* %374, align 4, !dbg !392, !tbaa !332, !alias.scope !334, !noalias !335
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:85 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl:236 within `macro expansion`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:151 within `#SharedMemory`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %375 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !394
        %376 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %375, i64 0, !dbg !394
        %377 = addrspacecast {}* inttoptr (i64 130970505313168 to {}*) to {} addrspace(10)*, !dbg !394
        %378 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %377, 0, !dbg !394
        %379 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !394
        %380 = insertvalue [2 x {} addrspace(10)*] %378, {} addrspace(10)* %379, 1, !dbg !394
        %381 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !394
        %382 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %381, i64 0, !dbg !394
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:152 within `#SharedMemory`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:50 within `ROCDeviceArray` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:36
       %383 = getelementptr inbounds { [1 x i64], i8 addrspace(3)*, i64 }, { [1 x i64], i8 addrspace(3)*, i64 } addrspace(5)* %22, i32 0, i32 0, !dbg !410
       %384 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %383, i32 0, i32 0, !dbg !410
       %385 = load i64, i64 addrspace(1)* getelementptr inbounds ([1 x i64], [1 x i64] addrspace(1)* @_j_const_1, i32 0, i32 0), align 8, !dbg !410, !tbaa !415, !alias.scope !419, !noalias !420
       store i64 %385, i64 addrspace(5)* %384, align 8, !dbg !410, !tbaa !332, !alias.scope !334, !noalias !335
       %386 = getelementptr inbounds { [1 x i64], i8 addrspace(3)*, i64 }, { [1 x i64], i8 addrspace(3)*, i64 } addrspace(5)* %22, i32 0, i32 1, !dbg !410
       store i8 addrspace(3)* bitcast ([32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231" to i8 addrspace(3)*), i8 addrspace(3)* addrspace(5)* %386, align 8, !dbg !410, !tbaa !332, !alias.scope !334, !noalias !335
       %387 = getelementptr inbounds { [1 x i64], i8 addrspace(3)*, i64 }, { [1 x i64], i8 addrspace(3)*, i64 } addrspace(5)* %22, i32 0, i32 2, !dbg !410
       %388 = load i64, i64 addrspace(1)* @_j_const_2, align 8, !dbg !410, !tbaa !415, !alias.scope !419, !noalias !420
       store i64 %388, i64 addrspace(5)* %387, align 8, !dbg !410, !tbaa !332, !alias.scope !334, !noalias !335
; ││└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:87 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:114 within `#__index_Local_Linear`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
          %389 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !421
          %390 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %389, i64 0, !dbg !421
          %391 = addrspacecast {}* inttoptr (i64 130978984496544 to {}*) to {} addrspace(10)*, !dbg !421
          %392 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %391, 0, !dbg !421
          %393 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !421
          %394 = insertvalue [2 x {} addrspace(10)*] %392, {} addrspace(10)* %393, 1, !dbg !421
          %395 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !421
          %396 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %395, i64 0, !dbg !421
          %397 = call i32 @llvm.amdgcn.workitem.id.x(), !dbg !421, !range !120
; ││││││└└
; ││││││┌ @ int.jl:1013 within `+` @ int.jl:87
         %398 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !430
         %399 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %398, i64 0, !dbg !430
         %400 = add i32 %397, 1, !dbg !430
; ││││└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
          %401 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !432
          %402 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %401, i64 0, !dbg !432
          %403 = addrspacecast {}* inttoptr (i64 130978984497040 to {}*) to {} addrspace(10)*, !dbg !432
          %404 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %403, 0, !dbg !432
          %405 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !432
          %406 = insertvalue [2 x {} addrspace(10)*] %404, {} addrspace(10)* %405, 1, !dbg !432
          %407 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !432
          %408 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %407, i64 0, !dbg !432
          %409 = call i32 @llvm.amdgcn.workitem.id.y(), !dbg !432, !range !120
; ││││└└└└
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
          %410 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !437
          %411 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %410, i64 0, !dbg !437
          %412 = addrspacecast {}* inttoptr (i64 130978984497536 to {}*) to {} addrspace(10)*, !dbg !437
          %413 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %412, 0, !dbg !437
          %414 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !437
          %415 = insertvalue [2 x {} addrspace(10)*] %413, {} addrspace(10)* %414, 1, !dbg !437
          %416 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !437
          %417 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %416, i64 0, !dbg !437
          %418 = call i32 @llvm.amdgcn.workitem.id.z(), !dbg !437, !range !120
; ││└└└└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:88 within `__warp_groupreduce`
; ││┌ @ int.jl:1013 within `-` @ int.jl:86
     %419 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !442
     %420 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %419, i64 0, !dbg !442
     %421 = sub i32 %400, 1, !dbg !442
; ││└
    %422 = bitcast {}* inttoptr (i64 130978247410944 to {}*) to {} addrspace(10)**, !dbg !444
    %423 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %422, i64 0, !dbg !444
; ││┌ @ int.jl:298 within `rem`
     %424 = bitcast {}* inttoptr (i64 130978849209184 to {}*) to {} addrspace(10)**, !dbg !445
     %425 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %424, i64 0, !dbg !445
     br label %pass, !dbg !445

L277:                                             ; preds = %guard_exit34, %guard_exit30
     %value_phi3 = phi i32 [ 16, %guard_exit30 ], [ %594, %guard_exit34 ]
     %value_phi4 = phi float [ %value_phi, %guard_exit30 ], [ %583, %guard_exit34 ]
     %value_phi5 = phi float [ %value_phi, %guard_exit30 ], [ %586, %guard_exit34 ]
     %value_phi6 = phi float [ %value_phi, %guard_exit30 ], [ %583, %guard_exit34 ]
     %value_phi7 = phi float [ %value_phi, %guard_exit30 ], [ %586, %guard_exit34 ]
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:77 within `__warp_reduce`
     %426 = bitcast [2 x float] addrspace(5)* %24 to i8 addrspace(5)*, !dbg !447
     %427 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*, !dbg !447
     call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %426, i8 addrspace(5)* align 4 %427, i64 8, i1 false), !dbg !447
     %428 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*, !dbg !447
     call void @llvm.lifetime.end.p5i8(i64 -1, i8 addrspace(5)* %428), !dbg !447
; │││┌ @ operators.jl:379 within `>`
; ││││┌ @ promotion.jl:484 within `<` @ int.jl:513
       %429 = bitcast {}* inttoptr (i64 130978868083136 to {}*) to {} addrspace(10)**, !dbg !450
       %430 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %429, i64 0, !dbg !450
       %431 = icmp ult i32 0, %value_phi3, !dbg !450
; │││└└
     %432 = xor i1 %431, true, !dbg !447
     br i1 %432, label %L371, label %L285, !dbg !447

L285:                                             ; preds = %L277
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
       %433 = call i32 @llvm.amdgcn.wavefrontsize(), !dbg !455
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %434 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !465
        %435 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %434, i64 0, !dbg !465
        %436 = bitcast float %value_phi4 to i32, !dbg !465
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %437 = call fastcc i32 @__ockl_activelane_u32(), !dbg !469
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %438 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !474
              %439 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %438, i64 0, !dbg !474
              %440 = lshr i32 %437, 31, !dbg !474
              %441 = select i1 false, i32 0, i32 %440, !dbg !474
              %442 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !474
              %443 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %442, i64 0, !dbg !474
              %444 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !474
              %445 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %444, i64 0, !dbg !474
              %446 = trunc i32 %441 to i8, !dbg !474
              %447 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !474
              %448 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %447, i64 0, !dbg !474
              %449 = icmp eq i8 %446, 1, !dbg !474
; │││││││││││└
             %450 = xor i1 %449, true, !dbg !476
             br i1 %450, label %L294, label %L292, !dbg !476

L292:                                             ; preds = %L285
             %451 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !476
             %452 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %451, i64 0, !dbg !476
             %453 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !476
             call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %453, i32 zeroext %437) #15, !dbg !476
             unreachable, !dbg !476

L294:                                             ; preds = %L285
             br label %L295, !dbg !476

L295:                                             ; preds = %L294
; ││││││││││└
            %454 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !478
            %455 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %454, i64 0, !dbg !478
            %456 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !478
            %457 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %456, i64 0, !dbg !478
            br label %L297, !dbg !478

L297:                                             ; preds = %L295
            br label %L298, !dbg !478

L298:                                             ; preds = %L297
            br label %L299, !dbg !478

L299:                                             ; preds = %L298
; │││││││└└└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
; │││││││┌ @ boot.jl:891 within `Int32`
; ││││││││┌ @ boot.jl:805 within `toInt32`
; │││││││││┌ @ boot.jl:756 within `check_sign_bit`
; ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
             %458 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !483
             %459 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %458, i64 0, !dbg !483
             %460 = lshr i32 %value_phi3, 31, !dbg !483
             %461 = select i1 false, i32 0, i32 %460, !dbg !483
             %462 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !483
             %463 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %462, i64 0, !dbg !483
             %464 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !483
             %465 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %464, i64 0, !dbg !483
             %466 = trunc i32 %461 to i8, !dbg !483
             %467 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !483
             %468 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %467, i64 0, !dbg !483
             %469 = icmp eq i8 %466, 1, !dbg !483
; ││││││││││└
            %470 = xor i1 %469, true, !dbg !484
            br i1 %470, label %L305, label %L303, !dbg !484

L303:                                             ; preds = %L299
            %471 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !484
            %472 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %471, i64 0, !dbg !484
            %473 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !484
            call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %473, i32 zeroext %value_phi3) #15, !dbg !484
            unreachable, !dbg !484

L305:                                             ; preds = %L299
            br label %L306, !dbg !484

L306:                                             ; preds = %L305
; │││││││││└
           %474 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !485
           %475 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %474, i64 0, !dbg !485
           %476 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !485
           %477 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %476, i64 0, !dbg !485
           br label %L308, !dbg !485

L308:                                             ; preds = %L306
           br label %L309, !dbg !485

L309:                                             ; preds = %L308
; │││││││└└
; │││││││┌ @ int.jl:87 within `+`
          %478 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !488
          %479 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %478, i64 0, !dbg !488
          %480 = add i32 %437, %value_phi3, !dbg !488
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
          %481 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !489
          %482 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %481, i64 0, !dbg !489
          %483 = sub i32 %433, 1, !dbg !489
; │││││││└
; │││││││┌ @ int.jl:1011 within `&`
; ││││││││┌ @ int.jl:554 within `rem`
           %484 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !492
           %485 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %484, i64 0, !dbg !492
; ││││││││└
; ││││││││ @ int.jl:1013 within `&` @ int.jl:347
          %486 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !495
          %487 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %486, i64 0, !dbg !495
          %488 = and i32 %437, %483, !dbg !495
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %489 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !497
          %490 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %489, i64 0, !dbg !497
          %491 = add i32 %488, %value_phi3, !dbg !497
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %492 = bitcast {}* inttoptr (i64 130978868082912 to {}*) to {} addrspace(10)**, !dbg !498
           %493 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %492, i64 0, !dbg !498
           %494 = icmp ule i32 %433, %491, !dbg !498
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %495 = bitcast {}* inttoptr (i64 130978865211680 to {}*) to {} addrspace(10)**, !dbg !501
          %496 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %495, i64 0, !dbg !501
          %497 = xor i1 %494, true, !dbg !501
          %498 = select i1 %497, i32 %480, i32 %437, !dbg !501
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %499 = bitcast {}* inttoptr (i64 130978868081792 to {}*) to {} addrspace(10)**, !dbg !503
          %500 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %499, i64 0, !dbg !503
          %501 = shl i32 %498, 2, !dbg !503
          %502 = select i1 false, i32 0, i32 %501, !dbg !503
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %503 = call i32 @llvm.amdgcn.ds.bpermute(i32 %502, i32 %436), !dbg !506
          br label %L319, !dbg !506

L319:                                             ; preds = %L309
          br label %L320, !dbg !506

L320:                                             ; preds = %L319
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %504 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !465
        %505 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %504, i64 0, !dbg !465
        %506 = bitcast i32 %503 to float, !dbg !465
        br label %L322, !dbg !465

L322:                                             ; preds = %L320
        br label %L323, !dbg !465

L323:                                             ; preds = %L322
        br label %L324, !dbg !465

L324:                                             ; preds = %L323
        br label %L325, !dbg !465

L325:                                             ; preds = %L324
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
       %507 = call i32 @llvm.amdgcn.wavefrontsize(), !dbg !455
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %508 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !465
        %509 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %508, i64 0, !dbg !465
        %510 = bitcast float %value_phi5 to i32, !dbg !465
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %511 = call fastcc i32 @__ockl_activelane_u32(), !dbg !469
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %512 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !474
              %513 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %512, i64 0, !dbg !474
              %514 = lshr i32 %511, 31, !dbg !474
              %515 = select i1 false, i32 0, i32 %514, !dbg !474
              %516 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !474
              %517 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %516, i64 0, !dbg !474
              %518 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !474
              %519 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %518, i64 0, !dbg !474
              %520 = trunc i32 %515 to i8, !dbg !474
              %521 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !474
              %522 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %521, i64 0, !dbg !474
              %523 = icmp eq i8 %520, 1, !dbg !474
; │││││││││││└
             %524 = xor i1 %523, true, !dbg !476
             br i1 %524, label %L334, label %L332, !dbg !476

L332:                                             ; preds = %L325
             %525 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !476
             %526 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %525, i64 0, !dbg !476
             %527 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !476
             call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %527, i32 zeroext %511) #15, !dbg !476
             unreachable, !dbg !476

L334:                                             ; preds = %L325
             br label %L335, !dbg !476

L335:                                             ; preds = %L334
; ││││││││││└
            %528 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !478
            %529 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %528, i64 0, !dbg !478
            %530 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !478
            %531 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %530, i64 0, !dbg !478
            br label %L337, !dbg !478

L337:                                             ; preds = %L335
            br label %L338, !dbg !478

L338:                                             ; preds = %L337
            br label %L339, !dbg !478

L339:                                             ; preds = %L338
; │││││││└└└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
; │││││││┌ @ boot.jl:891 within `Int32`
; ││││││││┌ @ boot.jl:805 within `toInt32`
; │││││││││┌ @ boot.jl:756 within `check_sign_bit`
; ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
             %532 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !483
             %533 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %532, i64 0, !dbg !483
             %534 = lshr i32 %value_phi3, 31, !dbg !483
             %535 = select i1 false, i32 0, i32 %534, !dbg !483
             %536 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !483
             %537 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %536, i64 0, !dbg !483
             %538 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !483
             %539 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %538, i64 0, !dbg !483
             %540 = trunc i32 %535 to i8, !dbg !483
             %541 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !483
             %542 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %541, i64 0, !dbg !483
             %543 = icmp eq i8 %540, 1, !dbg !483
; ││││││││││└
            %544 = xor i1 %543, true, !dbg !484
            br i1 %544, label %L345, label %L343, !dbg !484

L343:                                             ; preds = %L339
            %545 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !484
            %546 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %545, i64 0, !dbg !484
            %547 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !484
            call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %547, i32 zeroext %value_phi3) #15, !dbg !484
            unreachable, !dbg !484

L345:                                             ; preds = %L339
            br label %L346, !dbg !484

L346:                                             ; preds = %L345
; │││││││││└
           %548 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !485
           %549 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %548, i64 0, !dbg !485
           %550 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !485
           %551 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %550, i64 0, !dbg !485
           br label %L348, !dbg !485

L348:                                             ; preds = %L346
           br label %L349, !dbg !485

L349:                                             ; preds = %L348
; │││││││└└
; │││││││┌ @ int.jl:87 within `+`
          %552 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !488
          %553 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %552, i64 0, !dbg !488
          %554 = add i32 %511, %value_phi3, !dbg !488
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
          %555 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !489
          %556 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %555, i64 0, !dbg !489
          %557 = sub i32 %507, 1, !dbg !489
; │││││││└
; │││││││┌ @ int.jl:1011 within `&`
; ││││││││┌ @ int.jl:554 within `rem`
           %558 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !492
           %559 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %558, i64 0, !dbg !492
; ││││││││└
; ││││││││ @ int.jl:1013 within `&` @ int.jl:347
          %560 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !495
          %561 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %560, i64 0, !dbg !495
          %562 = and i32 %511, %557, !dbg !495
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %563 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !497
          %564 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %563, i64 0, !dbg !497
          %565 = add i32 %562, %value_phi3, !dbg !497
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %566 = bitcast {}* inttoptr (i64 130978868082912 to {}*) to {} addrspace(10)**, !dbg !498
           %567 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %566, i64 0, !dbg !498
           %568 = icmp ule i32 %507, %565, !dbg !498
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %569 = bitcast {}* inttoptr (i64 130978865211680 to {}*) to {} addrspace(10)**, !dbg !501
          %570 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %569, i64 0, !dbg !501
          %571 = xor i1 %568, true, !dbg !501
          %572 = select i1 %571, i32 %554, i32 %511, !dbg !501
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %573 = bitcast {}* inttoptr (i64 130978868081792 to {}*) to {} addrspace(10)**, !dbg !503
          %574 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %573, i64 0, !dbg !503
          %575 = shl i32 %572, 2, !dbg !503
          %576 = select i1 false, i32 0, i32 %575, !dbg !503
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %577 = call i32 @llvm.amdgcn.ds.bpermute(i32 %576, i32 %510), !dbg !506
          br label %L359, !dbg !506

L359:                                             ; preds = %L349
          br label %L360, !dbg !506

L360:                                             ; preds = %L359
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %578 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !465
        %579 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %578, i64 0, !dbg !465
        %580 = bitcast i32 %577 to float, !dbg !465
        br label %L362, !dbg !465

L362:                                             ; preds = %L360
        br label %L363, !dbg !465

L363:                                             ; preds = %L362
        br label %L364, !dbg !465

L364:                                             ; preds = %L363
        br label %L365, !dbg !465

L365:                                             ; preds = %L364
        br label %L366, !dbg !465

L366:                                             ; preds = %L365
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %581 = bitcast {}* inttoptr (i64 130978868084144 to {}*) to {} addrspace(10)**, !dbg !508
      %582 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %581, i64 0, !dbg !508
      %583 = fadd float %value_phi6, %506, !dbg !508
      %584 = bitcast {}* inttoptr (i64 130978868084144 to {}*) to {} addrspace(10)**, !dbg !508
      %585 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %584, i64 0, !dbg !508
      %586 = fadd float %value_phi7, %580, !dbg !508
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %587 = bitcast {}* inttoptr (i64 130979027043232 to {}*) to {} addrspace(10)**, !dbg !513
       %588 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %587, i64 0, !dbg !513
       %589 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %25, i32 0, i32 0, !dbg !513
       store float %583, float addrspace(5)* %589, align 4, !dbg !513, !tbaa !332, !alias.scope !334, !noalias !335
       %590 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %25, i32 0, i32 1, !dbg !513
       store float %586, float addrspace(5)* %590, align 4, !dbg !513, !tbaa !332, !alias.scope !334, !noalias !335
; │││└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:79 within `__warp_reduce`
; │││┌ @ int.jl:528 within `>>`
      %591 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !514
      %592 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %591, i64 0, !dbg !514
      %593 = lshr i32 %value_phi3, 1, !dbg !514
      %594 = select i1 false, i32 0, i32 %593, !dbg !514
      %595 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*
; └└└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %595), !dbg !77
  %596 = icmp ne [2 x float] addrspace(5)* %25, null
  br i1 %596, label %guard_pass31, label %guard_exit32

L371:                                             ; preds = %L277
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:81 within `__warp_reduce`
     br label %L372, !dbg !517

L372:                                             ; preds = %L371
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:93 within `__warp_groupreduce`
; ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
     %597 = bitcast {}* inttoptr (i64 130978828513920 to {}*) to {} addrspace(10)**, !dbg !518
     %598 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %597, i64 0, !dbg !518
     %599 = icmp eq i32 %910, 1, !dbg !518
; ││└
    %600 = xor i1 %599, true, !dbg !521
    br i1 %600, label %L394, label %L374, !dbg !521

L374:                                             ; preds = %L372
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
     br label %L389, !dbg !522

L389:                                             ; preds = %L374
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
; ││││┌ @ none within `pointerset`
; │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %601 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !524
        %602 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %601, i64 0, !dbg !524
        %603 = addrspacecast {}* inttoptr (i64 130979024262480 to {}*) to {} addrspace(10)*, !dbg !524
        %604 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %603, 0, !dbg !524
        %605 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !524
        %606 = insertvalue [2 x {} addrspace(10)*] %604, {} addrspace(10)* %605, 1, !dbg !524
; ││││││┌ @ int.jl:86 within `-`
         %607 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !531
         %608 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %607, i64 0, !dbg !531
         %609 = sub i32 %921, 1, !dbg !531
; ││││││└
        %610 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !524
        %611 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %610, i64 0, !dbg !524
        %612 = load [2 x float], [2 x float] addrspace(5)* %24, align 4, !dbg !524, !tbaa !332, !alias.scope !334, !noalias !335
        %613 = bitcast i8 addrspace(3)* bitcast ([32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231" to i8 addrspace(3)*) to [2 x float] addrspace(3)*, !dbg !524
        %614 = getelementptr inbounds [2 x float], [2 x float] addrspace(3)* %613, i32 %609, !dbg !524
        store [2 x float] %612, [2 x float] addrspace(3)* %614, align 4, !dbg !524, !tbaa !532
; │││└└└
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
     br label %L393, !dbg !534

L393:                                             ; preds = %L389
     br label %L395, !dbg !534

L394:                                             ; preds = %L372
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
; │││┌ @ abstractarray.jl:699 within `checkbounds`
      br label %L395, !dbg !535

L395:                                             ; preds = %L394, %L393
; ││└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:94 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl:290 within `macro expansion`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:162 within `#__synchronize`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
       call void @llvm.amdgcn.s.barrier(), !dbg !536
; ││└└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:97 within `__warp_groupreduce`
; ││┌ @ int.jl:1013 within `-` @ int.jl:86
     %615 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !543
     %616 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %615, i64 0, !dbg !543
     %617 = sub i32 %400, 1, !dbg !543
; ││└
; ││┌ @ int.jl:520 within `<` @ promotion.jl:484
; │││┌ @ promotion.jl:400 within `promote`
; ││││┌ @ promotion.jl:375 within `_promote`
; │││││┌ @ number.jl:7 within `convert`
; ││││││┌ @ boot.jl:897 within `UInt64`
; │││││││┌ @ boot.jl:871 within `toUInt64`
          %618 = bitcast {}* inttoptr (i64 130978868080896 to {}*) to {} addrspace(10)**, !dbg !546
          %619 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %618, i64 0, !dbg !546
          %620 = bitcast {}* inttoptr (i64 130978827523696 to {}*) to {} addrspace(10)**, !dbg !546
          %621 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %620, i64 0, !dbg !546
          %622 = zext i32 %617 to i64, !dbg !546
; │││└└└└└
; │││ @ int.jl:520 within `<` @ promotion.jl:484 @ int.jl:513
     %623 = bitcast {}* inttoptr (i64 130978868083136 to {}*) to {} addrspace(10)**, !dbg !557
     %624 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %623, i64 0, !dbg !557
     %625 = icmp ult i64 %622, 8, !dbg !557
; │││ @ int.jl:520 within `<`
; │││┌ @ bool.jl:38 within `&`
      %626 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !558
      %627 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %626, i64 0, !dbg !558
      %628 = and i1 true, %625, !dbg !558
; ││└└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
    %629 = xor i1 %628, true, !dbg !559
    br i1 %629, label %L421, label %L401, !dbg !559

L401:                                             ; preds = %L395
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
     br label %L416, !dbg !560

L416:                                             ; preds = %L401
; │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        %630 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !561
        %631 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %630, i64 0, !dbg !561
        %632 = addrspacecast {}* inttoptr (i64 130978998598000 to {}*) to {} addrspace(10)*, !dbg !561
        %633 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %632, 0, !dbg !561
        %634 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !561
        %635 = insertvalue [2 x {} addrspace(10)*] %633, {} addrspace(10)* %634, 1, !dbg !561
; ││││││┌ @ int.jl:86 within `-`
         %636 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !566
         %637 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %636, i64 0, !dbg !566
         %638 = sub i32 %910, 1, !dbg !566
; ││││││└
        %639 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !561
        %640 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %639, i64 0, !dbg !561
        %641 = bitcast i8 addrspace(3)* bitcast ([32 x [2 x float]] addrspace(3)* @"alloc_special_##static_shmem#231" to i8 addrspace(3)*) to [2 x float] addrspace(3)*, !dbg !561
        %642 = getelementptr inbounds [2 x float], [2 x float] addrspace(3)* %641, i32 %638, !dbg !561
        %643 = load [2 x float], [2 x float] addrspace(3)* %642, align 4, !dbg !561, !tbaa !532
        store [2 x float] %643, [2 x float] addrspace(5)* %28, align 4, !dbg !561
        br label %L420, !dbg !561

L420:                                             ; preds = %L416
        %644 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*
; └└└└└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %644), !dbg !77
  %645 = icmp ne [2 x float] addrspace(5)* %28, null
  br i1 %645, label %guard_pass35, label %guard_exit36

L421:                                             ; preds = %L395
  %646 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %646), !dbg !77
  %647 = icmp ne [2 x float] addrspace(5)* %21, null
  br i1 %647, label %guard_pass39, label %guard_exit40

L422:                                             ; preds = %guard_exit42, %guard_exit38
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
    %648 = bitcast [2 x float] addrspace(5)* %30 to i8 addrspace(5)*, !dbg !559
    %649 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*, !dbg !559
    call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %648, i8 addrspace(5)* align 4 %649, i64 8, i1 false), !dbg !559
    %650 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*, !dbg !559
    call void @llvm.lifetime.end.p5i8(i64 -1, i8 addrspace(5)* %650), !dbg !559
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
     %651 = bitcast {}* inttoptr (i64 130978828513920 to {}*) to {} addrspace(10)**, !dbg !567
     %652 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %651, i64 0, !dbg !567
     %653 = icmp eq i32 %921, 1, !dbg !567
; ││└
    %654 = xor i1 %653, true, !dbg !569
    br i1 %654, label %L422.L522_crit_edge, label %L425, !dbg !569

L422.L522_crit_edge:                              ; preds = %L422
    %655 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*
; └└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %655), !dbg !77
  %656 = icmp ne [2 x float] addrspace(5)* %30, null
  br i1 %656, label %guard_pass55, label %guard_exit56

L425:                                             ; preds = %L422
  %657 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %657), !dbg !77
  %658 = icmp ne [2 x float] addrspace(5)* %30, null
  br i1 %658, label %guard_pass43, label %guard_exit44

L426:                                             ; preds = %guard_exit50, %guard_exit46
  %value_phi11 = phi i32 [ 16, %guard_exit46 ], [ %843, %guard_exit50 ]
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:77 within `__warp_reduce`
     %659 = bitcast [2 x float] addrspace(5)* %32 to i8 addrspace(5)*, !dbg !570
     %660 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*, !dbg !570
     call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %659, i8 addrspace(5)* align 4 %660, i64 8, i1 false), !dbg !570
     %661 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*, !dbg !570
     call void @llvm.lifetime.end.p5i8(i64 -1, i8 addrspace(5)* %661), !dbg !570
; │││┌ @ operators.jl:379 within `>`
; ││││┌ @ promotion.jl:484 within `<` @ int.jl:513
       %662 = bitcast {}* inttoptr (i64 130978868083136 to {}*) to {} addrspace(10)**, !dbg !571
       %663 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %662, i64 0, !dbg !571
       %664 = icmp ult i32 0, %value_phi11, !dbg !571
; │││└└
     %665 = xor i1 %664, true, !dbg !570
     br i1 %665, label %L520, label %L430, !dbg !570

L430:                                             ; preds = %L426
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down`
; ││││┌ @ Base.jl:49 within `getproperty`
       %666 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !574
       %667 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %666, i64 0, !dbg !574
       %668 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %32, i32 0, i32 0, !dbg !574
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
       %669 = call i32 @llvm.amdgcn.wavefrontsize(), !dbg !577
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %670 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !580
        %671 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %670, i64 0, !dbg !580
        %672 = load float, float addrspace(5)* %668, align 4, !dbg !580, !tbaa !332, !alias.scope !334, !noalias !335
        %673 = bitcast float %672 to i32, !dbg !580
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %674 = call fastcc i32 @__ockl_activelane_u32(), !dbg !583
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %675 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !586
              %676 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %675, i64 0, !dbg !586
              %677 = lshr i32 %674, 31, !dbg !586
              %678 = select i1 false, i32 0, i32 %677, !dbg !586
              %679 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !586
              %680 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %679, i64 0, !dbg !586
              %681 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !586
              %682 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %681, i64 0, !dbg !586
              %683 = trunc i32 %678 to i8, !dbg !586
              %684 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !586
              %685 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %684, i64 0, !dbg !586
              %686 = icmp eq i8 %683, 1, !dbg !586
; │││││││││││└
             %687 = xor i1 %686, true, !dbg !587
             br i1 %687, label %L440, label %L438, !dbg !587

L438:                                             ; preds = %L430
             %688 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !587
             %689 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %688, i64 0, !dbg !587
             %690 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !587
             call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %690, i32 zeroext %674) #15, !dbg !587
             unreachable, !dbg !587

L440:                                             ; preds = %L430
             br label %L441, !dbg !587

L441:                                             ; preds = %L440
; ││││││││││└
            %691 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !588
            %692 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %691, i64 0, !dbg !588
            %693 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !588
            %694 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %693, i64 0, !dbg !588
            br label %L443, !dbg !588

L443:                                             ; preds = %L441
            br label %L444, !dbg !588

L444:                                             ; preds = %L443
            br label %L445, !dbg !588

L445:                                             ; preds = %L444
; │││││││└└└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
; │││││││┌ @ boot.jl:891 within `Int32`
; ││││││││┌ @ boot.jl:805 within `toInt32`
; │││││││││┌ @ boot.jl:756 within `check_sign_bit`
; ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
             %695 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !591
             %696 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %695, i64 0, !dbg !591
             %697 = lshr i32 %value_phi11, 31, !dbg !591
             %698 = select i1 false, i32 0, i32 %697, !dbg !591
             %699 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !591
             %700 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %699, i64 0, !dbg !591
             %701 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !591
             %702 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %701, i64 0, !dbg !591
             %703 = trunc i32 %698 to i8, !dbg !591
             %704 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !591
             %705 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %704, i64 0, !dbg !591
             %706 = icmp eq i8 %703, 1, !dbg !591
; ││││││││││└
            %707 = xor i1 %706, true, !dbg !592
            br i1 %707, label %L451, label %L449, !dbg !592

L449:                                             ; preds = %L445
            %708 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !592
            %709 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %708, i64 0, !dbg !592
            %710 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !592
            call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %710, i32 zeroext %value_phi11) #15, !dbg !592
            unreachable, !dbg !592

L451:                                             ; preds = %L445
            br label %L452, !dbg !592

L452:                                             ; preds = %L451
; │││││││││└
           %711 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !593
           %712 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %711, i64 0, !dbg !593
           %713 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !593
           %714 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %713, i64 0, !dbg !593
           br label %L454, !dbg !593

L454:                                             ; preds = %L452
           br label %L455, !dbg !593

L455:                                             ; preds = %L454
; │││││││└└
; │││││││┌ @ int.jl:87 within `+`
          %715 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !596
          %716 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %715, i64 0, !dbg !596
          %717 = add i32 %674, %value_phi11, !dbg !596
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
          %718 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !597
          %719 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %718, i64 0, !dbg !597
          %720 = sub i32 %669, 1, !dbg !597
; │││││││└
; │││││││┌ @ int.jl:1011 within `&`
; ││││││││┌ @ int.jl:554 within `rem`
           %721 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !600
           %722 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %721, i64 0, !dbg !600
; ││││││││└
; ││││││││ @ int.jl:1013 within `&` @ int.jl:347
          %723 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !602
          %724 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %723, i64 0, !dbg !602
          %725 = and i32 %674, %720, !dbg !602
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %726 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !604
          %727 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %726, i64 0, !dbg !604
          %728 = add i32 %725, %value_phi11, !dbg !604
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %729 = bitcast {}* inttoptr (i64 130978868082912 to {}*) to {} addrspace(10)**, !dbg !605
           %730 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %729, i64 0, !dbg !605
           %731 = icmp ule i32 %669, %728, !dbg !605
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %732 = bitcast {}* inttoptr (i64 130978865211680 to {}*) to {} addrspace(10)**, !dbg !607
          %733 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %732, i64 0, !dbg !607
          %734 = xor i1 %731, true, !dbg !607
          %735 = select i1 %734, i32 %717, i32 %674, !dbg !607
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %736 = bitcast {}* inttoptr (i64 130978868081792 to {}*) to {} addrspace(10)**, !dbg !608
          %737 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %736, i64 0, !dbg !608
          %738 = shl i32 %735, 2, !dbg !608
          %739 = select i1 false, i32 0, i32 %738, !dbg !608
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %740 = call i32 @llvm.amdgcn.ds.bpermute(i32 %739, i32 %673), !dbg !610
          br label %L465, !dbg !610

L465:                                             ; preds = %L455
          br label %L466, !dbg !610

L466:                                             ; preds = %L465
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %741 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !580
        %742 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %741, i64 0, !dbg !580
        %743 = bitcast i32 %740 to float, !dbg !580
        br label %L468, !dbg !580

L468:                                             ; preds = %L466
        br label %L469, !dbg !580

L469:                                             ; preds = %L468
        br label %L470, !dbg !580

L470:                                             ; preds = %L469
        br label %L471, !dbg !580

L471:                                             ; preds = %L470
; ││││└└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down`
; ││││┌ @ Base.jl:49 within `getproperty`
       %744 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !574
       %745 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %744, i64 0, !dbg !574
       %746 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %32, i32 0, i32 1, !dbg !574
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
       %747 = call i32 @llvm.amdgcn.wavefrontsize(), !dbg !577
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %748 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !580
        %749 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %748, i64 0, !dbg !580
        %750 = load float, float addrspace(5)* %746, align 4, !dbg !580, !tbaa !332, !alias.scope !334, !noalias !335
        %751 = bitcast float %750 to i32, !dbg !580
; │││││└
; │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
          %752 = call fastcc i32 @__ockl_activelane_u32(), !dbg !583
; │││││││└
; │││││││┌ @ number.jl:7 within `convert`
; ││││││││┌ @ boot.jl:891 within `Int32`
; │││││││││┌ @ boot.jl:805 within `toInt32`
; ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
; │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
              %753 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !586
              %754 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %753, i64 0, !dbg !586
              %755 = lshr i32 %752, 31, !dbg !586
              %756 = select i1 false, i32 0, i32 %755, !dbg !586
              %757 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !586
              %758 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %757, i64 0, !dbg !586
              %759 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !586
              %760 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %759, i64 0, !dbg !586
              %761 = trunc i32 %756 to i8, !dbg !586
              %762 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !586
              %763 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %762, i64 0, !dbg !586
              %764 = icmp eq i8 %761, 1, !dbg !586
; │││││││││││└
             %765 = xor i1 %764, true, !dbg !587
             br i1 %765, label %L481, label %L479, !dbg !587

L479:                                             ; preds = %L471
             %766 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !587
             %767 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %766, i64 0, !dbg !587
             %768 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !587
             call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %768, i32 zeroext %752) #15, !dbg !587
             unreachable, !dbg !587

L481:                                             ; preds = %L471
             br label %L482, !dbg !587

L482:                                             ; preds = %L481
; ││││││││││└
            %769 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !588
            %770 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %769, i64 0, !dbg !588
            %771 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !588
            %772 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %771, i64 0, !dbg !588
            br label %L484, !dbg !588

L484:                                             ; preds = %L482
            br label %L485, !dbg !588

L485:                                             ; preds = %L484
            br label %L486, !dbg !588

L486:                                             ; preds = %L485
; │││││││└└└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
; │││││││┌ @ boot.jl:891 within `Int32`
; ││││││││┌ @ boot.jl:805 within `toInt32`
; │││││││││┌ @ boot.jl:756 within `check_sign_bit`
; ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
             %773 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !591
             %774 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %773, i64 0, !dbg !591
             %775 = lshr i32 %value_phi11, 31, !dbg !591
             %776 = select i1 false, i32 0, i32 %775, !dbg !591
             %777 = bitcast {}* inttoptr (i64 130978868080784 to {}*) to {} addrspace(10)**, !dbg !591
             %778 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %777, i64 0, !dbg !591
             %779 = bitcast {}* inttoptr (i64 130978824366368 to {}*) to {} addrspace(10)**, !dbg !591
             %780 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %779, i64 0, !dbg !591
             %781 = trunc i32 %776 to i8, !dbg !591
             %782 = bitcast {}* inttoptr (i64 130978868083472 to {}*) to {} addrspace(10)**, !dbg !591
             %783 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %782, i64 0, !dbg !591
             %784 = icmp eq i8 %781, 1, !dbg !591
; ││││││││││└
            %785 = xor i1 %784, true, !dbg !592
            br i1 %785, label %L492, label %L490, !dbg !592

L490:                                             ; preds = %L486
            %786 = bitcast {}* inttoptr (i64 130978879294304 to {}*) to {} addrspace(10)**, !dbg !592
            %787 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %786, i64 0, !dbg !592
            %788 = addrspacecast {}* inttoptr (i64 130979031839088 to {}*) to {} addrspace(10)*, !dbg !592
            call fastcc void @julia__throw_inexacterror_12221({} addrspace(10)* %788, i32 zeroext %value_phi11) #15, !dbg !592
            unreachable, !dbg !592

L492:                                             ; preds = %L486
            br label %L493, !dbg !592

L493:                                             ; preds = %L492
; │││││││││└
           %789 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !593
           %790 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %789, i64 0, !dbg !593
           %791 = bitcast {}* inttoptr (i64 130978824477184 to {}*) to {} addrspace(10)**, !dbg !593
           %792 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %791, i64 0, !dbg !593
           br label %L495, !dbg !593

L495:                                             ; preds = %L493
           br label %L496, !dbg !593

L496:                                             ; preds = %L495
; │││││││└└
; │││││││┌ @ int.jl:87 within `+`
          %793 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !596
          %794 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %793, i64 0, !dbg !596
          %795 = add i32 %752, %value_phi11, !dbg !596
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
; │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
          %796 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !597
          %797 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %796, i64 0, !dbg !597
          %798 = sub i32 %747, 1, !dbg !597
; │││││││└
; │││││││┌ @ int.jl:1011 within `&`
; ││││││││┌ @ int.jl:554 within `rem`
           %799 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !600
           %800 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %799, i64 0, !dbg !600
; ││││││││└
; ││││││││ @ int.jl:1013 within `&` @ int.jl:347
          %801 = bitcast {}* inttoptr (i64 130978868082240 to {}*) to {} addrspace(10)**, !dbg !602
          %802 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %801, i64 0, !dbg !602
          %803 = and i32 %752, %798, !dbg !602
; │││││││└
; │││││││┌ @ int.jl:87 within `+`
          %804 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !604
          %805 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %804, i64 0, !dbg !604
          %806 = add i32 %803, %value_phi11, !dbg !604
; │││││││└
; │││││││┌ @ operators.jl:426 within `>=`
; ││││││││┌ @ int.jl:515 within `<=`
           %807 = bitcast {}* inttoptr (i64 130978868082912 to {}*) to {} addrspace(10)**, !dbg !605
           %808 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %807, i64 0, !dbg !605
           %809 = icmp ule i32 %747, %806, !dbg !605
; │││││││└└
; │││││││┌ @ essentials.jl:796 within `ifelse`
          %810 = bitcast {}* inttoptr (i64 130978865211680 to {}*) to {} addrspace(10)**, !dbg !607
          %811 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %810, i64 0, !dbg !607
          %812 = xor i1 %809, true, !dbg !607
          %813 = select i1 %812, i32 %795, i32 %752, !dbg !607
; │││││││└
; │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
; │││││││┌ @ int.jl:529 within `<<`
          %814 = bitcast {}* inttoptr (i64 130978868081792 to {}*) to {} addrspace(10)**, !dbg !608
          %815 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %814, i64 0, !dbg !608
          %816 = shl i32 %813, 2, !dbg !608
          %817 = select i1 false, i32 0, i32 %816, !dbg !608
; │││││││└
; │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
          %818 = call i32 @llvm.amdgcn.ds.bpermute(i32 %817, i32 %751), !dbg !610
          br label %L506, !dbg !610

L506:                                             ; preds = %L496
          br label %L507, !dbg !610

L507:                                             ; preds = %L506
; │││││└└└
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %819 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !580
        %820 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %819, i64 0, !dbg !580
        %821 = bitcast i32 %818 to float, !dbg !580
        br label %L509, !dbg !580

L509:                                             ; preds = %L507
        br label %L510, !dbg !580

L510:                                             ; preds = %L509
        br label %L511, !dbg !580

L511:                                             ; preds = %L510
        br label %L512, !dbg !580

L512:                                             ; preds = %L511
        br label %L513, !dbg !580

L513:                                             ; preds = %L512
; │││└└└
; │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ Base.jl:49 within `getproperty`
       %822 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !611
       %823 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %822, i64 0, !dbg !611
       %824 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %32, i32 0, i32 0, !dbg !611
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %825 = bitcast {}* inttoptr (i64 130978868084144 to {}*) to {} addrspace(10)**, !dbg !613
      %826 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %825, i64 0, !dbg !613
      %827 = load float, float addrspace(5)* %824, align 4, !dbg !613, !tbaa !332, !alias.scope !334, !noalias !335
      %828 = fadd float %827, %743, !dbg !613
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ Base.jl:49 within `getproperty`
       %829 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !611
       %830 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %829, i64 0, !dbg !611
       %831 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %32, i32 0, i32 1, !dbg !611
; ││││└
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
      %832 = bitcast {}* inttoptr (i64 130978868084144 to {}*) to {} addrspace(10)**, !dbg !613
      %833 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %832, i64 0, !dbg !613
      %834 = load float, float addrspace(5)* %831, align 4, !dbg !613, !tbaa !332, !alias.scope !334, !noalias !335
      %835 = fadd float %834, %821, !dbg !613
; ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
; ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
       %836 = bitcast {}* inttoptr (i64 130979027043232 to {}*) to {} addrspace(10)**, !dbg !614
       %837 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %836, i64 0, !dbg !614
       %838 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %33, i32 0, i32 0, !dbg !614
       store float %828, float addrspace(5)* %838, align 4, !dbg !614, !tbaa !332, !alias.scope !334, !noalias !335
       %839 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %33, i32 0, i32 1, !dbg !614
       store float %835, float addrspace(5)* %839, align 4, !dbg !614, !tbaa !332, !alias.scope !334, !noalias !335
; │││└└
; │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:79 within `__warp_reduce`
; │││┌ @ int.jl:528 within `>>`
      %840 = bitcast {}* inttoptr (i64 130978868081680 to {}*) to {} addrspace(10)**, !dbg !615
      %841 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %840, i64 0, !dbg !615
      %842 = lshr i32 %value_phi11, 1, !dbg !615
      %843 = select i1 false, i32 0, i32 %842, !dbg !615
      %844 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*
; └└└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %844), !dbg !77
  %845 = icmp ne [2 x float] addrspace(5)* %33, null
  br i1 %845, label %guard_pass47, label %guard_exit48

L520:                                             ; preds = %L426
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:81 within `__warp_reduce`
     br label %L521, !dbg !617

L521:                                             ; preds = %L520
     %846 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %846), !dbg !77
  %847 = icmp ne [2 x float] addrspace(5)* %32, null
  br i1 %847, label %guard_pass51, label %guard_exit52

L522:                                             ; preds = %guard_exit58, %guard_exit54
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:100 within `__warp_groupreduce`
    %848 = bitcast [2 x float] addrspace(5)* %35 to i8 addrspace(5)*, !dbg !618
    %849 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*, !dbg !618
    call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %848, i8 addrspace(5)* align 4 %849, i64 8, i1 false), !dbg !618
    %850 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*, !dbg !618
    call void @llvm.lifetime.end.p5i8(i64 -1, i8 addrspace(5)* %850), !dbg !618
    br label %L524, !dbg !618

L524:                                             ; preds = %L522
; │└
; │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:21 within `macro expansion`
; │┌ @ promotion.jl:639 within `==`
    %851 = bitcast {}* inttoptr (i64 130978828513920 to {}*) to {} addrspace(10)**, !dbg !619
    %852 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %851, i64 0, !dbg !619
    %853 = icmp eq i64 %304, 1, !dbg !619
; │└
   %854 = xor i1 %853, true, !dbg !620
   br i1 %854, label %L550, label %L526, !dbg !620

L526:                                             ; preds = %L524
; │┌ @ Base.jl:49 within `getproperty`
    %855 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !621
    %856 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %855, i64 0, !dbg !621
    %857 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %35, i32 0, i32 0, !dbg !621
    %858 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !621
    %859 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %858, i64 0, !dbg !621
    %860 = getelementptr inbounds [2 x float], [2 x float] addrspace(5)* %35, i32 0, i32 1, !dbg !621
; │└
; │┌ @ float.jl:491 within `+`
    %861 = bitcast {}* inttoptr (i64 130978868084144 to {}*) to {} addrspace(10)**, !dbg !622
    %862 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %861, i64 0, !dbg !622
    %863 = load float, float addrspace(5)* %857, align 4, !dbg !622, !tbaa !332, !alias.scope !334, !noalias !335
    %864 = load float, float addrspace(5)* %860, align 4, !dbg !622, !tbaa !332, !alias.scope !334, !noalias !335
    %865 = fadd float %863, %864, !dbg !622
; │└
; │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
    br label %L531, !dbg !623

L531:                                             ; preds = %L526
; ││┌ @ abstractarray.jl:697 within `checkbounds`
     %866 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !624
     %867 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %866, i64 0, !dbg !624
     %868 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %36, i32 0, i32 0, !dbg !624
     %869 = load i64, i64 addrspace(1)* @_j_const_3, align 8, !dbg !624, !tbaa !415, !alias.scope !419, !noalias !420
     store i64 %869, i64 addrspace(5)* %868, align 8, !dbg !624, !tbaa !332, !alias.scope !334, !noalias !335
; │││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
; │││┌ @ abstractarray.jl:389 within `eachindex`
; ││││┌ @ abstractarray.jl:137 within `axes1`
; │││││┌ @ abstractarray.jl:98 within `axes`
; ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `size`
; │││││││┌ @ Base.jl:49 within `getproperty`
          %870 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !625
          %871 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %870, i64 0, !dbg !625
          %872 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %7, i32 0, i32 0, !dbg !625
; ││││││└└
; ││││││┌ @ tuple.jl:355 within `map`
; │││││││┌ @ tuple.jl:31 within `getindex`
          %873 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !632
          %874 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %873, i64 0, !dbg !632
          %875 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %872, i32 0, i32 0, !dbg !632
; │││└└└└└
; │││┌ @ abstractarray.jl:754 within `checkindex`
; ││││┌ @ int.jl:86 within `-`
       %876 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !634
       %877 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %876, i64 0, !dbg !634
; ││││└
; ││││┌ @ essentials.jl:668 within `unsigned`
; │││││┌ @ essentials.jl:730 within `reinterpret`
        %878 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !636
        %879 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %878, i64 0, !dbg !636
        %880 = bitcast {}* inttoptr (i64 130978866526128 to {}*) to {} addrspace(10)**, !dbg !636
        %881 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %880, i64 0, !dbg !636
        %882 = load i64, i64 addrspace(11)* %875, align 8, !dbg !636, !alias.scope !53, !noalias !56
; ││││└└
; ││││┌ @ int.jl:513 within `<`
       %883 = bitcast {}* inttoptr (i64 130978868083136 to {}*) to {} addrspace(10)**, !dbg !638
       %884 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %883, i64 0, !dbg !638
       %885 = icmp ult i64 0, %882, !dbg !638
; │││└└
; │││ @ abstractarray.jl:699 within `checkbounds`
     %886 = xor i1 %885, true, !dbg !631
     br i1 %886, label %L541, label %L540, !dbg !631

L540:                                             ; preds = %L531
     br label %L543, !dbg !631

L541:                                             ; preds = %L531
     %887 = bitcast {}* inttoptr (i64 130978879164528 to {}*) to {} addrspace(10)**, !dbg !631
     %888 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %887, i64 0, !dbg !631
     %889 = addrspacecast [1 x i64] addrspace(5)* %36 to [1 x i64] addrspace(11)*, !dbg !631
     call fastcc void @julia__throw_boundserror_12219({ [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* nocapture readonly %7, [1 x i64] addrspace(11)* nocapture readonly %889) #15, !dbg !631
     unreachable, !dbg !631

L543:                                             ; preds = %L540
     br label %L544, !dbg !631

L544:                                             ; preds = %L543
; ││└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `pointer`
; │││┌ @ Base.jl:49 within `getproperty`
      %890 = bitcast {}* inttoptr (i64 130978824534992 to {}*) to {} addrspace(10)**, !dbg !639
      %891 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %890, i64 0, !dbg !639
      %892 = getelementptr inbounds { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %7, i32 0, i32 1, !dbg !639
; ││└└
; ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
; │││┌ @ none within `pointerset`
; ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
       %893 = bitcast {}* inttoptr (i64 130978859328576 to {}*) to {} addrspace(10)**, !dbg !642
       %894 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %893, i64 0, !dbg !642
       %895 = addrspacecast {}* inttoptr (i64 130978998765168 to {}*) to {} addrspace(10)*, !dbg !642
       %896 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %895, 0, !dbg !642
       %897 = addrspacecast {}* inttoptr (i64 130975446474320 to {}*) to {} addrspace(10)*, !dbg !642
       %898 = insertvalue [2 x {} addrspace(10)*] %896, {} addrspace(10)* %897, 1, !dbg !642
; │││││┌ @ int.jl:86 within `-`
        %899 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !646
        %900 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %899, i64 0, !dbg !646
; │││││└
       %901 = bitcast {}* inttoptr (i64 130978858117664 to {}*) to {} addrspace(10)**, !dbg !642
       %902 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %901, i64 0, !dbg !642
       %903 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %892, align 8, !dbg !642, !alias.scope !53, !noalias !56
       %904 = bitcast i8 addrspace(1)* %903 to float addrspace(1)*, !dbg !642
       store float %865, float addrspace(1)* %904, align 4, !dbg !642, !tbaa !386
; ││└└└
; ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
    br label %L549, !dbg !647

L549:                                             ; preds = %L544
    br label %L550, !dbg !647

L550:                                             ; preds = %L549, %L524, %L109
; └└
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:99
  %905 = bitcast {}* inttoptr (i64 130978824301904 to {}*) to {} addrspace(10)**, !dbg !648
  %906 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %905, i64 0, !dbg !648
  ret void, !dbg !648

pass:                                             ; preds = %L256
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:88 within `__warp_groupreduce`
; ││┌ @ int.jl:298 within `rem`
     %907 = urem i32 %421, 32, !dbg !445
; ││└
; ││┌ @ int.jl:1013 within `+` @ int.jl:87
     %908 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !649
     %909 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %908, i64 0, !dbg !649
     %910 = add i32 %907, 1, !dbg !649
; ││└
; ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:89 within `__warp_groupreduce`
; ││┌ @ int.jl:1013 within `-` @ int.jl:86
     %911 = bitcast {}* inttoptr (i64 130978868085152 to {}*) to {} addrspace(10)**, !dbg !651
     %912 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %911, i64 0, !dbg !651
     %913 = sub i32 %400, 1, !dbg !651
; ││└
    %914 = bitcast {}* inttoptr (i64 130978247410944 to {}*) to {} addrspace(10)**, !dbg !653
    %915 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %914, i64 0, !dbg !653
; ││┌ @ int.jl:297 within `div`
     %916 = bitcast {}* inttoptr (i64 130978849209392 to {}*) to {} addrspace(10)**, !dbg !654
     %917 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %916, i64 0, !dbg !654
     br label %pass2, !dbg !654

pass2:                                            ; preds = %pass
     %918 = udiv i32 %913, 32, !dbg !654
; ││└
; ││┌ @ int.jl:1013 within `+` @ int.jl:87
     %919 = bitcast {}* inttoptr (i64 130978868085264 to {}*) to {} addrspace(10)**, !dbg !656
     %920 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %919, i64 0, !dbg !656
     %921 = add i32 %918, 1, !dbg !656
     %922 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.lifetime.start.p5i8(i64 -1, i8 addrspace(5)* %922), !dbg !77
  %923 = icmp ne [2 x float] addrspace(5)* %20, null
  br i1 %923, label %guard_pass, label %guard_exit

guard_pass:                                       ; preds = %pass2
  br label %guard_exit

guard_exit:                                       ; preds = %guard_pass, %pass2
  %924 = phi i1 [ false, %pass2 ], [ true, %guard_pass ]
  br i1 %924, label %guard_pass29, label %guard_exit30

guard_pass29:                                     ; preds = %guard_exit
  %925 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*
  %926 = bitcast [2 x float] addrspace(5)* %20 to i8 addrspace(5)*
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %925, i8 addrspace(5)* align 4 %926, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit30

guard_exit30:                                     ; preds = %guard_pass29, %guard_exit
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:89 within `__warp_groupreduce`
; ││┌ @ int.jl:1013 within `+` @ int.jl:87
     br label %L277, !dbg !656

guard_pass31:                                     ; preds = %L366
     br label %guard_exit32

guard_exit32:                                     ; preds = %guard_pass31, %L366
     %927 = phi i1 [ false, %L366 ], [ true, %guard_pass31 ]
     br i1 %927, label %guard_pass33, label %guard_exit34

guard_pass33:                                     ; preds = %guard_exit32
     %928 = bitcast [2 x float] addrspace(5)* %23 to i8 addrspace(5)*
     %929 = bitcast [2 x float] addrspace(5)* %25 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %928, i8 addrspace(5)* align 4 %929, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit34

guard_exit34:                                     ; preds = %guard_pass33, %guard_exit32
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:80 within `__warp_reduce`
     br label %L277, !dbg !658

guard_pass35:                                     ; preds = %L420
     br label %guard_exit36

guard_exit36:                                     ; preds = %guard_pass35, %L420
     %930 = phi i1 [ false, %L420 ], [ true, %guard_pass35 ]
     br i1 %930, label %guard_pass37, label %guard_exit38

guard_pass37:                                     ; preds = %guard_exit36
     %931 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*
     %932 = bitcast [2 x float] addrspace(5)* %28 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %931, i8 addrspace(5)* align 4 %932, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit38

guard_exit38:                                     ; preds = %guard_pass37, %guard_exit36
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
; │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
; ││││┌ @ none within `pointerref`
; │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
        br label %L422, !dbg !561

guard_pass39:                                     ; preds = %L421
        br label %guard_exit40

guard_exit40:                                     ; preds = %guard_pass39, %L421
        %933 = phi i1 [ false, %L421 ], [ true, %guard_pass39 ]
        br i1 %933, label %guard_pass41, label %guard_exit42

guard_pass41:                                     ; preds = %guard_exit40
        %934 = bitcast [2 x float] addrspace(5)* %29 to i8 addrspace(5)*
        %935 = bitcast [2 x float] addrspace(5)* %21 to i8 addrspace(5)*
; └└└└└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %934, i8 addrspace(5)* align 4 %935, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit42

guard_exit42:                                     ; preds = %guard_pass41, %guard_exit40
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
; │││┌ @ abstractarray.jl:699 within `checkbounds`
      br label %L422, !dbg !659

guard_pass43:                                     ; preds = %L425
      br label %guard_exit44

guard_exit44:                                     ; preds = %guard_pass43, %L425
      %936 = phi i1 [ false, %L425 ], [ true, %guard_pass43 ]
      br i1 %936, label %guard_pass45, label %guard_exit46

guard_pass45:                                     ; preds = %guard_exit44
      %937 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*
      %938 = bitcast [2 x float] addrspace(5)* %30 to i8 addrspace(5)*
; └└└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %937, i8 addrspace(5)* align 4 %938, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit46

guard_exit46:                                     ; preds = %guard_pass45, %guard_exit44
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
    br label %L426, !dbg !569

guard_pass47:                                     ; preds = %L513
    br label %guard_exit48

guard_exit48:                                     ; preds = %guard_pass47, %L513
    %939 = phi i1 [ false, %L513 ], [ true, %guard_pass47 ]
    br i1 %939, label %guard_pass49, label %guard_exit50

guard_pass49:                                     ; preds = %guard_exit48
    %940 = bitcast [2 x float] addrspace(5)* %31 to i8 addrspace(5)*
    %941 = bitcast [2 x float] addrspace(5)* %33 to i8 addrspace(5)*
; └└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %940, i8 addrspace(5)* align 4 %941, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit50

guard_exit50:                                     ; preds = %guard_pass49, %guard_exit48
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:80 within `__warp_reduce`
     br label %L426, !dbg !660

guard_pass51:                                     ; preds = %L521
     br label %guard_exit52

guard_exit52:                                     ; preds = %guard_pass51, %L521
     %942 = phi i1 [ false, %L521 ], [ true, %guard_pass51 ]
     br i1 %942, label %guard_pass53, label %guard_exit54

guard_pass53:                                     ; preds = %guard_exit52
     %943 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*
     %944 = bitcast [2 x float] addrspace(5)* %32 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %943, i8 addrspace(5)* align 4 %944, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit54

guard_exit54:                                     ; preds = %guard_pass53, %guard_exit52
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
; ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:81 within `__warp_reduce`
     br label %L522, !dbg !617

guard_pass55:                                     ; preds = %L422.L522_crit_edge
     br label %guard_exit56

guard_exit56:                                     ; preds = %guard_pass55, %L422.L522_crit_edge
     %945 = phi i1 [ false, %L422.L522_crit_edge ], [ true, %guard_pass55 ]
     br i1 %945, label %guard_pass57, label %guard_exit58

guard_pass57:                                     ; preds = %guard_exit56
     %946 = bitcast [2 x float] addrspace(5)* %34 to i8 addrspace(5)*
     %947 = bitcast [2 x float] addrspace(5)* %30 to i8 addrspace(5)*
; └└└
;  @ none within `gpu_groupreduce_1!`
  call void @llvm.memcpy.p5i8.p5i8.i64(i8 addrspace(5)* align 4 %946, i8 addrspace(5)* align 4 %947, i64 8, i1 false), !dbg !77, !tbaa !332, !alias.scope !334, !noalias !335
  br label %guard_exit58

guard_exit58:                                     ; preds = %guard_pass57, %guard_exit56
;  @ none within `gpu_groupreduce_1!` @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
; │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
    br label %L522, !dbg !569
; └└
}

; Function Attrs: alwaysinline convergent mustprogress nofree norecurse nounwind willreturn memory(read)
define internal fastcc i32 @__ockl_activelane_u32() unnamed_addr #9 {
  %1 = load i8, i8 addrspace(4)* @__oclc_wavefrontsize64, align 1, !tbaa !661, !range !665
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %8, label %3

3:                                                ; preds = %0
  %4 = tail call i32 @llvm.read_register.i32(metadata !666) #16
  %5 = tail call i32 @llvm.read_register.i32(metadata !667) #16
  %6 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %5, i32 0)
  %7 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %4, i32 %6)
  br label %11

8:                                                ; preds = %0
  %9 = tail call i32 @llvm.read_register.i32(metadata !667) #16
  %10 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %9, i32 0)
  br label %11

11:                                               ; preds = %8, %3
  %12 = phi i32 [ %7, %3 ], [ %10, %8 ]
  ret i32 %12
}

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(read)
declare i32 @llvm.read_register.i32(metadata) #10

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #11

; Function Attrs: alwaysinline nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32) #11

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:138 within `report_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_report_exception(i64 zeroext %0) unnamed_addr #12 !dbg !668 {
top:
  %pgcstack = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -14
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 15
  ret void, !dbg !670
}

;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:112 within `signal_exception`
; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #12 !dbg !671 {
top:
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %pgcstack = call {}*** @julia.get_pgcstack()
  %1 = bitcast {}*** %pgcstack to {}**
  %current_task = getelementptr inbounds {}*, {}** %1, i64 -14
  %2 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %2, i64 15
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:113 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:11 within `exception_flag`
; │┌ @ none within `kernel_state`
; ││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
     %3 = bitcast {}* inttoptr (i64 139223665615936 to {}*) to {} addrspace(10)**, !dbg !672
     %4 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %3, i64 0, !dbg !672
     %5 = addrspacecast {}* inttoptr (i64 139215314230032 to {}*) to {} addrspace(10)*, !dbg !672
     %6 = insertvalue [2 x {} addrspace(10)*] zeroinitializer, {} addrspace(10)* %5, 0, !dbg !672
     %7 = addrspacecast {}* inttoptr (i64 139220359716432 to {}*) to {} addrspace(10)*, !dbg !672
     %8 = insertvalue [2 x {} addrspace(10)*] %6, {} addrspace(10)* %7, 1, !dbg !672
     %9 = bitcast {}* inttoptr (i64 139223664405024 to {}*) to {} addrspace(10)**, !dbg !672
     %10 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %9, i64 0, !dbg !672
     %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter(), !dbg !672
     store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8, !dbg !672
; │└└
; │┌ @ Base.jl:49 within `getproperty`
    %11 = bitcast {}* inttoptr (i64 139223630822352 to {}*) to {} addrspace(10)**, !dbg !681
    %12 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %11, i64 0, !dbg !681
    %13 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 0, !dbg !681
; └└
; ┌ @ pointer.jl:180 within `unsafe_store!` @ pointer.jl:180
   %14 = bitcast {}* inttoptr (i64 139223674366464 to {}*) to {} addrspace(10)**, !dbg !683
   %15 = getelementptr inbounds {} addrspace(10)*, {} addrspace(10)** %14, i64 0, !dbg !683
   %16 = bitcast i64 addrspace(5)* %13 to i8* addrspace(5)*, !dbg !683
   %17 = load i8*, i8* addrspace(5)* %16, align 8, !dbg !683, !tbaa !332, !alias.scope !334, !noalias !335
   %18 = getelementptr inbounds i8, i8* %17, i64 0, !dbg !683
   %19 = bitcast i8* %18 to i32*, !dbg !683
   %20 = load i32, i32 addrspace(1)* @_j_const_1.19, align 4, !dbg !683, !tbaa !415, !alias.scope !419, !noalias !420
   store i32 %20, i32* %19, align 1, !dbg !683
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:115 within `signal_exception`
; ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl:52 within `endpgm`
   call void @llvm.amdgcn.endpgm(), !dbg !687
; └
;  @ /home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl:116 within `signal_exception`
  unreachable, !dbg !691
}

; Function Attrs: memory(none)
declare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() local_unnamed_addr #13

; Function Attrs: cold nocallback nofree noreturn nounwind
declare void @llvm.amdgcn.endpgm() #14

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { cold noreturn nounwind }
attributes #4 = { convergent nocallback nofree nounwind willreturn memory(none) }
attributes #5 = { convergent nocallback nofree nounwind willreturn }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #7 = { alwaysinline noreturn }
attributes #8 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #9 = { alwaysinline convergent mustprogress nofree norecurse nounwind willreturn memory(read) "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { alwaysinline nocallback nofree nosync nounwind willreturn memory(read) }
attributes #11 = { alwaysinline nocallback nofree nosync nounwind willreturn memory(none) }
attributes #12 = { alwaysinline }
attributes #13 = { memory(none) }
attributes #14 = { cold nocallback nofree noreturn nounwind }
attributes #15 = { noreturn }
attributes #16 = { convergent }

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
!43 = !{void ({ [1 x [1 x [1 x i64]]], { [1 x [1 x [1 x i64]]] } }, { [1 x i64], i8 addrspace(1)*, i64 }, { [1 x i64], i8 addrspace(1)*, i64 }, float)* @_Z18gpu_groupreduce_1_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILi1E5TupleI5OneToI5Int64EEE7NDRangeILi1ES0_10StaticSizeI6_256__ES8_vEE14ROCDeviceArrayI7Float32Li1ELi1EESG_1_SF_}
!44 = distinct !DISubprogram(name: "#throw_inexacterror", linkageName: "julia_#throw_inexacterror_12221", scope: null, file: !45, line: 40, type: !46, scopeLine: 40, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !6, retainedNodes: !47)
!45 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl", directory: ".")
!46 = !DISubroutineType(types: !47)
!47 = !{}
!48 = !DILocation(line: 8, scope: !44)
!49 = !{!50, !50, i64 0, i64 1}
!50 = !{!"jtbaa_const", !51, i64 0}
!51 = !{!"jtbaa", !52, i64 0}
!52 = !{!"jtbaa"}
!53 = !{!54}
!54 = !{!"jnoalias_const", !55}
!55 = !{!"jnoalias"}
!56 = !{!57, !58, !59, !60}
!57 = !{!"jnoalias_gcframe", !55}
!58 = !{!"jnoalias_stack", !55}
!59 = !{!"jnoalias_data", !55}
!60 = !{!"jnoalias_typemd", !55}
!61 = distinct !DISubprogram(name: "#throw_boundserror", linkageName: "julia_#throw_boundserror_12219", scope: null, file: !45, line: 44, type: !46, scopeLine: 44, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !11, retainedNodes: !47)
!62 = !DILocation(line: 8, scope: !61)
!63 = distinct !DISubprogram(name: "gpu_groupreduce_1!", linkageName: "julia_gpu_groupreduce_1!_12132", scope: null, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!64 = !DIFile(filename: "none", directory: ".")
!65 = !DILocation(line: 49, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !67, file: !67, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!67 = !DIFile(filename: "Base.jl", directory: ".")
!68 = !DILocation(line: 23, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__iterspace;", linkageName: "__iterspace", scope: !70, file: !70, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!70 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl", directory: ".")
!71 = !DILocation(line: 141, scope: !72, inlinedAt: !74)
!72 = distinct !DISubprogram(name: "#__validindex;", linkageName: "#__validindex", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!73 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl", directory: ".")
!74 = !DILocation(line: 96, scope: !75, inlinedAt: !77)
!75 = distinct !DISubprogram(name: "gpu_groupreduce_1!;", linkageName: "gpu_groupreduce_1!", scope: !76, file: !76, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!76 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl", directory: ".")
!77 = !DILocation(line: 0, scope: !63)
!78 = !DILocation(line: 39, scope: !79, inlinedAt: !81)
!79 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!80 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl", directory: ".")
!81 = !DILocation(line: 3, scope: !82, inlinedAt: !84)
!82 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!83 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl", directory: ".")
!84 = !DILocation(line: 3, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "_index;", linkageName: "_index", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!86 = !DILocation(line: 93, scope: !87, inlinedAt: !88)
!87 = distinct !DISubprogram(name: "workgroupIdx_x;", linkageName: "workgroupIdx_x", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!88 = !DILocation(line: 95, scope: !89, inlinedAt: !90)
!89 = distinct !DISubprogram(name: "blockIdx_x;", linkageName: "blockIdx_x", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!90 = !DILocation(line: 172, scope: !91, inlinedAt: !71)
!91 = distinct !DISubprogram(name: "blockIdx;", linkageName: "blockIdx", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!92 = !{i32 0, i32 -2}
!93 = !DILocation(line: 87, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!95 = !DIFile(filename: "int.jl", directory: ".")
!96 = !DILocation(line: 1013, scope: !94, inlinedAt: !86)
!97 = !DILocation(line: 39, scope: !79, inlinedAt: !98)
!98 = !DILocation(line: 3, scope: !82, inlinedAt: !99)
!99 = !DILocation(line: 3, scope: !85, inlinedAt: !100)
!100 = !DILocation(line: 93, scope: !101, inlinedAt: !102)
!101 = distinct !DISubprogram(name: "workgroupIdx_y;", linkageName: "workgroupIdx_y", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!102 = !DILocation(line: 95, scope: !103, inlinedAt: !90)
!103 = distinct !DISubprogram(name: "blockIdx_y;", linkageName: "blockIdx_y", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!104 = !DILocation(line: 39, scope: !79, inlinedAt: !105)
!105 = !DILocation(line: 3, scope: !82, inlinedAt: !106)
!106 = !DILocation(line: 3, scope: !85, inlinedAt: !107)
!107 = !DILocation(line: 93, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "workgroupIdx_z;", linkageName: "workgroupIdx_z", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!109 = !DILocation(line: 95, scope: !110, inlinedAt: !90)
!110 = distinct !DISubprogram(name: "blockIdx_z;", linkageName: "blockIdx_z", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!111 = !DILocation(line: 39, scope: !79, inlinedAt: !112)
!112 = !DILocation(line: 3, scope: !82, inlinedAt: !113)
!113 = !DILocation(line: 3, scope: !85, inlinedAt: !114)
!114 = !DILocation(line: 87, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "workitemIdx_x;", linkageName: "workitemIdx_x", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!116 = !DILocation(line: 89, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "threadIdx_x;", linkageName: "threadIdx_x", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!118 = !DILocation(line: 164, scope: !119, inlinedAt: !71)
!119 = distinct !DISubprogram(name: "threadIdx;", linkageName: "threadIdx", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!120 = !{i32 0, i32 1023}
!121 = !DILocation(line: 87, scope: !94, inlinedAt: !122)
!122 = !DILocation(line: 1013, scope: !94, inlinedAt: !114)
!123 = !DILocation(line: 39, scope: !79, inlinedAt: !124)
!124 = !DILocation(line: 3, scope: !82, inlinedAt: !125)
!125 = !DILocation(line: 3, scope: !85, inlinedAt: !126)
!126 = !DILocation(line: 87, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "workitemIdx_y;", linkageName: "workitemIdx_y", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!128 = !DILocation(line: 89, scope: !129, inlinedAt: !118)
!129 = distinct !DISubprogram(name: "threadIdx_y;", linkageName: "threadIdx_y", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!130 = !DILocation(line: 39, scope: !79, inlinedAt: !131)
!131 = !DILocation(line: 3, scope: !82, inlinedAt: !132)
!132 = !DILocation(line: 3, scope: !85, inlinedAt: !133)
!133 = !DILocation(line: 87, scope: !134, inlinedAt: !135)
!134 = distinct !DISubprogram(name: "workitemIdx_z;", linkageName: "workitemIdx_z", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!135 = !DILocation(line: 89, scope: !136, inlinedAt: !118)
!136 = distinct !DISubprogram(name: "threadIdx_z;", linkageName: "threadIdx_z", scope: !83, file: !83, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!137 = !DILocation(line: 49, scope: !66, inlinedAt: !138)
!138 = !DILocation(line: 64, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "blocks;", linkageName: "blocks", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!140 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl", directory: ".")
!141 = !DILocation(line: 117, scope: !142, inlinedAt: !71)
!142 = distinct !DISubprogram(name: "expand;", linkageName: "expand", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!143 = !DILocation(line: 49, scope: !66, inlinedAt: !144)
!144 = !DILocation(line: 110, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "#3;", linkageName: "#3", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!146 = !DILocation(line: 48, scope: !147, inlinedAt: !149)
!147 = distinct !DISubprogram(name: "ntuple;", linkageName: "ntuple", scope: !148, file: !148, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!148 = !DIFile(filename: "ntuple.jl", directory: ".")
!149 = !DILocation(line: 108, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "assume_nonzero;", linkageName: "assume_nonzero", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!151 = !DILocation(line: 119, scope: !142, inlinedAt: !71)
!152 = !DILocation(line: 31, scope: !153, inlinedAt: !144)
!153 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !154, file: !154, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!154 = !DIFile(filename: "tuple.jl", directory: ".")
!155 = !DILocation(line: 49, scope: !66, inlinedAt: !156)
!156 = !DILocation(line: 111, scope: !145, inlinedAt: !146)
!157 = !DILocation(line: 83, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!159 = !DILocation(line: 379, scope: !160, inlinedAt: !156)
!160 = distinct !DISubprogram(name: ">;", linkageName: ">", scope: !161, file: !161, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!161 = !DIFile(filename: "operators.jl", directory: ".")
!162 = !DILocation(line: 91, scope: !163, inlinedAt: !156)
!163 = distinct !DISubprogram(name: "assume;", linkageName: "assume", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!164 = !DILocation(line: 91, scope: !163, inlinedAt: !165)
!165 = !DILocation(line: 111, scope: !145, inlinedAt: !166)
!166 = !DILocation(line: 48, scope: !147, inlinedAt: !167)
!167 = !DILocation(line: 108, scope: !150, inlinedAt: !168)
!168 = !DILocation(line: 120, scope: !142, inlinedAt: !71)
!169 = !DILocation(line: 816, scope: !170, inlinedAt: !172)
!170 = distinct !DISubprogram(name: "toInt64;", linkageName: "toInt64", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!171 = !DIFile(filename: "boot.jl", directory: ".")
!172 = !DILocation(line: 892, scope: !173, inlinedAt: !174)
!173 = distinct !DISubprogram(name: "Int64;", linkageName: "Int64", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!174 = !DILocation(line: 7, scope: !175, inlinedAt: !177)
!175 = distinct !DISubprogram(name: "convert;", linkageName: "convert", scope: !176, file: !176, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!176 = !DIFile(filename: "number.jl", directory: ".")
!177 = !DILocation(line: 307, scope: !178, inlinedAt: !180)
!178 = distinct !DISubprogram(name: "to_index;", linkageName: "to_index", scope: !179, file: !179, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!179 = !DIFile(filename: "indices.jl", directory: ".")
!180 = !DILocation(line: 292, scope: !178, inlinedAt: !181)
!181 = !DILocation(line: 368, scope: !182, inlinedAt: !183)
!182 = distinct !DISubprogram(name: "to_indices;", linkageName: "to_indices", scope: !179, file: !179, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!183 = !DILocation(line: 365, scope: !182, inlinedAt: !184)
!184 = !DILocation(line: 1312, scope: !185, inlinedAt: !187)
!185 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!186 = !DIFile(filename: "abstractarray.jl", directory: ".")
!187 = !DILocation(line: 121, scope: !142, inlinedAt: !71)
!188 = !DILocation(line: 55, scope: !189, inlinedAt: !190)
!189 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!190 = !DILocation(line: 1358, scope: !191, inlinedAt: !184)
!191 = distinct !DISubprogram(name: "_getindex;", linkageName: "_getindex", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!192 = !DILocation(line: 49, scope: !66, inlinedAt: !193)
!193 = !DILocation(line: 56, scope: !189, inlinedAt: !190)
!194 = !DILocation(line: 31, scope: !153, inlinedAt: !195)
!195 = !DILocation(line: 382, scope: !196, inlinedAt: !193)
!196 = distinct !DISubprogram(name: "map;", linkageName: "map", scope: !154, file: !154, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!197 = !DILocation(line: 922, scope: !198, inlinedAt: !200)
!198 = distinct !DISubprogram(name: "_getindex;", linkageName: "_getindex", scope: !199, file: !199, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!199 = !DIFile(filename: "range.jl", directory: ".")
!200 = !DILocation(line: 3076, scope: !201, inlinedAt: !203)
!201 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !202, file: !202, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!202 = !DIFile(filename: "array.jl", directory: ".")
!203 = !DILocation(line: 57, scope: !204, inlinedAt: !195)
!204 = distinct !DISubprogram(name: "#54;", linkageName: "#54", scope: !45, file: !45, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!205 = !DILocation(line: 699, scope: !206, inlinedAt: !197)
!206 = distinct !DISubprogram(name: "checkbounds;", linkageName: "checkbounds", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!207 = !DILocation(line: 86, scope: !208, inlinedAt: !209)
!208 = distinct !DISubprogram(name: "-;", linkageName: "-", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!209 = !DILocation(line: 79, scope: !210, inlinedAt: !211)
!210 = distinct !DISubprogram(name: "#1;", linkageName: "#1", scope: !140, file: !140, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!211 = !DILocation(line: 48, scope: !147, inlinedAt: !212)
!212 = !DILocation(line: 75, scope: !142, inlinedAt: !187)
!213 = !DILocation(line: 88, scope: !214, inlinedAt: !209)
!214 = distinct !DISubprogram(name: "*;", linkageName: "*", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!215 = !DILocation(line: 87, scope: !94, inlinedAt: !209)
!216 = !DILocation(line: 49, scope: !66, inlinedAt: !217)
!217 = !DILocation(line: 28, scope: !218, inlinedAt: !219)
!218 = distinct !DISubprogram(name: "__ndrange;", linkageName: "__ndrange", scope: !70, file: !70, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!219 = !DILocation(line: 142, scope: !72, inlinedAt: !74)
!220 = !DILocation(line: 49, scope: !66, inlinedAt: !221)
!221 = !DILocation(line: 477, scope: !222, inlinedAt: !219)
!222 = distinct !DISubprogram(name: "in;", linkageName: "in", scope: !223, file: !223, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!223 = !DIFile(filename: "multidimensional.jl", directory: ".")
!224 = !DILocation(line: 31, scope: !153, inlinedAt: !225)
!225 = !DILocation(line: 382, scope: !196, inlinedAt: !221)
!226 = !DILocation(line: 514, scope: !227, inlinedAt: !228)
!227 = distinct !DISubprogram(name: "<=;", linkageName: "<=", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!228 = !DILocation(line: 1426, scope: !229, inlinedAt: !225)
!229 = distinct !DISubprogram(name: "in;", linkageName: "in", scope: !199, file: !199, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!230 = !DILocation(line: 49, scope: !66, inlinedAt: !231)
!231 = !DILocation(line: 846, scope: !232, inlinedAt: !228)
!232 = distinct !DISubprogram(name: "last;", linkageName: "last", scope: !199, file: !199, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!233 = !DILocation(line: 38, scope: !234, inlinedAt: !228)
!234 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !235, file: !235, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!235 = !DIFile(filename: "bool.jl", directory: ".")
!236 = !DILocation(line: 49, scope: !66, inlinedAt: !237)
!237 = !DILocation(line: 23, scope: !69, inlinedAt: !238)
!238 = !DILocation(line: 122, scope: !239, inlinedAt: !240)
!239 = distinct !DISubprogram(name: "#__index_Global_Linear;", linkageName: "#__index_Global_Linear", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!240 = !DILocation(line: 15, scope: !241, inlinedAt: !243)
!241 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !242, file: !242, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!242 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/t.jl", directory: ".")
!243 = !DILocation(line: 97, scope: !75, inlinedAt: !77)
!244 = !DILocation(line: 39, scope: !79, inlinedAt: !245)
!245 = !DILocation(line: 3, scope: !82, inlinedAt: !246)
!246 = !DILocation(line: 3, scope: !85, inlinedAt: !247)
!247 = !DILocation(line: 93, scope: !87, inlinedAt: !248)
!248 = !DILocation(line: 95, scope: !89, inlinedAt: !249)
!249 = !DILocation(line: 172, scope: !91, inlinedAt: !238)
!250 = !DILocation(line: 87, scope: !94, inlinedAt: !251)
!251 = !DILocation(line: 1013, scope: !94, inlinedAt: !247)
!252 = !DILocation(line: 39, scope: !79, inlinedAt: !253)
!253 = !DILocation(line: 3, scope: !82, inlinedAt: !254)
!254 = !DILocation(line: 3, scope: !85, inlinedAt: !255)
!255 = !DILocation(line: 93, scope: !101, inlinedAt: !256)
!256 = !DILocation(line: 95, scope: !103, inlinedAt: !249)
!257 = !DILocation(line: 39, scope: !79, inlinedAt: !258)
!258 = !DILocation(line: 3, scope: !82, inlinedAt: !259)
!259 = !DILocation(line: 3, scope: !85, inlinedAt: !260)
!260 = !DILocation(line: 93, scope: !108, inlinedAt: !261)
!261 = !DILocation(line: 95, scope: !110, inlinedAt: !249)
!262 = !DILocation(line: 39, scope: !79, inlinedAt: !263)
!263 = !DILocation(line: 3, scope: !82, inlinedAt: !264)
!264 = !DILocation(line: 3, scope: !85, inlinedAt: !265)
!265 = !DILocation(line: 87, scope: !115, inlinedAt: !266)
!266 = !DILocation(line: 89, scope: !117, inlinedAt: !267)
!267 = !DILocation(line: 164, scope: !119, inlinedAt: !238)
!268 = !DILocation(line: 87, scope: !94, inlinedAt: !269)
!269 = !DILocation(line: 1013, scope: !94, inlinedAt: !265)
!270 = !DILocation(line: 39, scope: !79, inlinedAt: !271)
!271 = !DILocation(line: 3, scope: !82, inlinedAt: !272)
!272 = !DILocation(line: 3, scope: !85, inlinedAt: !273)
!273 = !DILocation(line: 87, scope: !127, inlinedAt: !274)
!274 = !DILocation(line: 89, scope: !129, inlinedAt: !267)
!275 = !DILocation(line: 39, scope: !79, inlinedAt: !276)
!276 = !DILocation(line: 3, scope: !82, inlinedAt: !277)
!277 = !DILocation(line: 3, scope: !85, inlinedAt: !278)
!278 = !DILocation(line: 87, scope: !134, inlinedAt: !279)
!279 = !DILocation(line: 89, scope: !136, inlinedAt: !267)
!280 = !DILocation(line: 49, scope: !66, inlinedAt: !281)
!281 = !DILocation(line: 64, scope: !139, inlinedAt: !282)
!282 = !DILocation(line: 117, scope: !142, inlinedAt: !238)
!283 = !DILocation(line: 49, scope: !66, inlinedAt: !284)
!284 = !DILocation(line: 110, scope: !145, inlinedAt: !285)
!285 = !DILocation(line: 48, scope: !147, inlinedAt: !286)
!286 = !DILocation(line: 108, scope: !150, inlinedAt: !287)
!287 = !DILocation(line: 119, scope: !142, inlinedAt: !238)
!288 = !DILocation(line: 31, scope: !153, inlinedAt: !284)
!289 = !DILocation(line: 49, scope: !66, inlinedAt: !290)
!290 = !DILocation(line: 111, scope: !145, inlinedAt: !285)
!291 = !DILocation(line: 83, scope: !158, inlinedAt: !292)
!292 = !DILocation(line: 379, scope: !160, inlinedAt: !290)
!293 = !DILocation(line: 91, scope: !163, inlinedAt: !290)
!294 = !DILocation(line: 91, scope: !163, inlinedAt: !295)
!295 = !DILocation(line: 111, scope: !145, inlinedAt: !296)
!296 = !DILocation(line: 48, scope: !147, inlinedAt: !297)
!297 = !DILocation(line: 108, scope: !150, inlinedAt: !298)
!298 = !DILocation(line: 120, scope: !142, inlinedAt: !238)
!299 = !DILocation(line: 816, scope: !170, inlinedAt: !300)
!300 = !DILocation(line: 892, scope: !173, inlinedAt: !301)
!301 = !DILocation(line: 7, scope: !175, inlinedAt: !302)
!302 = !DILocation(line: 307, scope: !178, inlinedAt: !303)
!303 = !DILocation(line: 292, scope: !178, inlinedAt: !304)
!304 = !DILocation(line: 368, scope: !182, inlinedAt: !305)
!305 = !DILocation(line: 365, scope: !182, inlinedAt: !306)
!306 = !DILocation(line: 1312, scope: !185, inlinedAt: !307)
!307 = !DILocation(line: 121, scope: !142, inlinedAt: !238)
!308 = !DILocation(line: 55, scope: !189, inlinedAt: !309)
!309 = !DILocation(line: 1358, scope: !191, inlinedAt: !306)
!310 = !DILocation(line: 49, scope: !66, inlinedAt: !311)
!311 = !DILocation(line: 56, scope: !189, inlinedAt: !309)
!312 = !DILocation(line: 31, scope: !153, inlinedAt: !313)
!313 = !DILocation(line: 382, scope: !196, inlinedAt: !311)
!314 = !DILocation(line: 922, scope: !198, inlinedAt: !315)
!315 = !DILocation(line: 3076, scope: !201, inlinedAt: !316)
!316 = !DILocation(line: 57, scope: !204, inlinedAt: !313)
!317 = !DILocation(line: 699, scope: !206, inlinedAt: !314)
!318 = !DILocation(line: 86, scope: !208, inlinedAt: !319)
!319 = !DILocation(line: 79, scope: !210, inlinedAt: !320)
!320 = !DILocation(line: 48, scope: !147, inlinedAt: !321)
!321 = !DILocation(line: 75, scope: !142, inlinedAt: !307)
!322 = !DILocation(line: 88, scope: !214, inlinedAt: !319)
!323 = !DILocation(line: 87, scope: !94, inlinedAt: !319)
!324 = !DILocation(line: 49, scope: !66, inlinedAt: !325)
!325 = !DILocation(line: 28, scope: !218, inlinedAt: !326)
!326 = !DILocation(line: 124, scope: !239, inlinedAt: !240)
!327 = !DILocation(line: 49, scope: !66, inlinedAt: !328)
!328 = !DILocation(line: 582, scope: !329, inlinedAt: !326)
!329 = distinct !DISubprogram(name: "LinearIndices;", linkageName: "LinearIndices", scope: !223, file: !223, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!330 = !DILocation(line: 484, scope: !331, inlinedAt: !328)
!331 = distinct !DISubprogram(name: "LinearIndices;", linkageName: "LinearIndices", scope: !179, file: !179, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!332 = !{!333, !333, i64 0}
!333 = !{!"jtbaa_stack", !51, i64 0}
!334 = !{!58}
!335 = !{!57, !59, !60, !54}
!336 = !DILocation(line: 518, scope: !337, inlinedAt: !338)
!337 = distinct !DISubprogram(name: "getindex;", linkageName: "getindex", scope: !179, file: !179, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!338 = !DILocation(line: 1336, scope: !191, inlinedAt: !339)
!339 = !DILocation(line: 1312, scope: !185, inlinedAt: !326)
!340 = !DILocation(line: 699, scope: !206, inlinedAt: !336)
!341 = !DILocation(line: 49, scope: !66, inlinedAt: !342)
!342 = !DILocation(line: 71, scope: !343, inlinedAt: !345)
!343 = distinct !DISubprogram(name: "length;", linkageName: "length", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!344 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl", directory: ".")
!345 = !DILocation(line: 16, scope: !241, inlinedAt: !243)
!346 = !DILocation(line: 83, scope: !158, inlinedAt: !347)
!347 = !DILocation(line: 379, scope: !160, inlinedAt: !345)
!348 = !DILocation(line: 84, scope: !349, inlinedAt: !345)
!349 = distinct !DISubprogram(name: "#getindex;", linkageName: "#getindex", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!350 = !DILocation(line: 697, scope: !206, inlinedAt: !348)
!351 = !DILocation(line: 49, scope: !66, inlinedAt: !352)
!352 = !DILocation(line: 69, scope: !353, inlinedAt: !354)
!353 = distinct !DISubprogram(name: "size;", linkageName: "size", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!354 = !DILocation(line: 98, scope: !355, inlinedAt: !356)
!355 = distinct !DISubprogram(name: "axes;", linkageName: "axes", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!356 = !DILocation(line: 137, scope: !357, inlinedAt: !358)
!357 = distinct !DISubprogram(name: "axes1;", linkageName: "axes1", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!358 = !DILocation(line: 389, scope: !359, inlinedAt: !360)
!359 = distinct !DISubprogram(name: "eachindex;", linkageName: "eachindex", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!360 = !DILocation(line: 689, scope: !206, inlinedAt: !361)
!361 = !DILocation(line: 699, scope: !206, inlinedAt: !348)
!362 = !DILocation(line: 31, scope: !153, inlinedAt: !363)
!363 = !DILocation(line: 355, scope: !196, inlinedAt: !354)
!364 = !DILocation(line: 86, scope: !208, inlinedAt: !365)
!365 = !DILocation(line: 754, scope: !366, inlinedAt: !360)
!366 = distinct !DISubprogram(name: "checkindex;", linkageName: "checkindex", scope: !186, file: !186, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!367 = !DILocation(line: 730, scope: !368, inlinedAt: !370)
!368 = distinct !DISubprogram(name: "reinterpret;", linkageName: "reinterpret", scope: !369, file: !369, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!369 = !DIFile(filename: "essentials.jl", directory: ".")
!370 = !DILocation(line: 668, scope: !371, inlinedAt: !365)
!371 = distinct !DISubprogram(name: "unsigned;", linkageName: "unsigned", scope: !369, file: !369, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!372 = !DILocation(line: 513, scope: !158, inlinedAt: !365)
!373 = !DILocation(line: 49, scope: !66, inlinedAt: !374)
!374 = !DILocation(line: 64, scope: !375, inlinedAt: !376)
!375 = distinct !DISubprogram(name: "pointer;", linkageName: "pointer", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!376 = !DILocation(line: 86, scope: !349, inlinedAt: !345)
!377 = !DILocation(line: 39, scope: !79, inlinedAt: !378)
!378 = !DILocation(line: 0, scope: !379, inlinedAt: !380)
!379 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!380 = !DILocation(line: 0, scope: !381, inlinedAt: !382)
!381 = distinct !DISubprogram(name: "pointerref;", linkageName: "pointerref", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!382 = !DILocation(line: 85, scope: !383, inlinedAt: !376)
!383 = distinct !DISubprogram(name: "unsafe_load;", linkageName: "unsafe_load", scope: !384, file: !384, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!384 = !DIFile(filename: "/home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl", directory: ".")
!385 = !DILocation(line: 86, scope: !208, inlinedAt: !377)
!386 = !{!387, !387, i64 0, i64 0}
!387 = !{!"custom_tbaa_addrspace(1)", !388, i64 0}
!388 = !{!"custom_tbaa"}
!389 = !DILocation(line: 7, scope: !390, inlinedAt: !391)
!390 = distinct !DISubprogram(name: "A;", linkageName: "A", scope: !242, file: !242, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!391 = !DILocation(line: 17, scope: !241, inlinedAt: !243)
!392 = !DILocation(line: 7, scope: !390, inlinedAt: !393)
!393 = !DILocation(line: 18, scope: !241, inlinedAt: !243)
!394 = !DILocation(line: 39, scope: !79, inlinedAt: !395)
!395 = !DILocation(line: 2, scope: !396, inlinedAt: !398)
!396 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !397, file: !397, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!397 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl", directory: ".")
!398 = !DILocation(line: 2, scope: !399, inlinedAt: !400)
!399 = distinct !DISubprogram(name: "alloc_special;", linkageName: "alloc_special", scope: !397, file: !397, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!400 = !DILocation(line: 2, scope: !399, inlinedAt: !401)
!401 = !DILocation(line: 151, scope: !402, inlinedAt: !403)
!402 = distinct !DISubprogram(name: "#SharedMemory;", linkageName: "#SharedMemory", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!403 = !DILocation(line: 236, scope: !404, inlinedAt: !406)
!404 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !405, file: !405, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!405 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl", directory: ".")
!406 = !DILocation(line: 85, scope: !407, inlinedAt: !409)
!407 = distinct !DISubprogram(name: "__warp_groupreduce;", linkageName: "__warp_groupreduce", scope: !408, file: !408, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!408 = !DIFile(filename: "/home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl", directory: ".")
!409 = !DILocation(line: 19, scope: !241, inlinedAt: !243)
!410 = !DILocation(line: 36, scope: !411, inlinedAt: !412)
!411 = distinct !DISubprogram(name: "ROCDeviceArray;", linkageName: "ROCDeviceArray", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!412 = !DILocation(line: 59, scope: !411, inlinedAt: !413)
!413 = !DILocation(line: 50, scope: !411, inlinedAt: !414)
!414 = !DILocation(line: 152, scope: !402, inlinedAt: !403)
!415 = !{!416, !416, i64 0}
!416 = !{!"jtbaa_immut", !417, i64 0}
!417 = !{!"jtbaa_value", !418, i64 0}
!418 = !{!"jtbaa_data", !51, i64 0}
!419 = !{!59}
!420 = !{!57, !58, !60, !54}
!421 = !DILocation(line: 39, scope: !79, inlinedAt: !422)
!422 = !DILocation(line: 3, scope: !82, inlinedAt: !423)
!423 = !DILocation(line: 3, scope: !85, inlinedAt: !424)
!424 = !DILocation(line: 87, scope: !115, inlinedAt: !425)
!425 = !DILocation(line: 89, scope: !117, inlinedAt: !426)
!426 = !DILocation(line: 164, scope: !119, inlinedAt: !427)
!427 = !DILocation(line: 114, scope: !428, inlinedAt: !429)
!428 = distinct !DISubprogram(name: "#__index_Local_Linear;", linkageName: "#__index_Local_Linear", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!429 = !DILocation(line: 87, scope: !407, inlinedAt: !409)
!430 = !DILocation(line: 87, scope: !94, inlinedAt: !431)
!431 = !DILocation(line: 1013, scope: !94, inlinedAt: !424)
!432 = !DILocation(line: 39, scope: !79, inlinedAt: !433)
!433 = !DILocation(line: 3, scope: !82, inlinedAt: !434)
!434 = !DILocation(line: 3, scope: !85, inlinedAt: !435)
!435 = !DILocation(line: 87, scope: !127, inlinedAt: !436)
!436 = !DILocation(line: 89, scope: !129, inlinedAt: !426)
!437 = !DILocation(line: 39, scope: !79, inlinedAt: !438)
!438 = !DILocation(line: 3, scope: !82, inlinedAt: !439)
!439 = !DILocation(line: 3, scope: !85, inlinedAt: !440)
!440 = !DILocation(line: 87, scope: !134, inlinedAt: !441)
!441 = !DILocation(line: 89, scope: !136, inlinedAt: !426)
!442 = !DILocation(line: 86, scope: !208, inlinedAt: !443)
!443 = !DILocation(line: 1013, scope: !208, inlinedAt: !444)
!444 = !DILocation(line: 88, scope: !407, inlinedAt: !409)
!445 = !DILocation(line: 298, scope: !446, inlinedAt: !444)
!446 = distinct !DISubprogram(name: "rem;", linkageName: "rem", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!447 = !DILocation(line: 77, scope: !448, inlinedAt: !449)
!448 = distinct !DISubprogram(name: "__warp_reduce;", linkageName: "__warp_reduce", scope: !408, file: !408, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!449 = !DILocation(line: 92, scope: !407, inlinedAt: !409)
!450 = !DILocation(line: 513, scope: !158, inlinedAt: !451)
!451 = !DILocation(line: 484, scope: !452, inlinedAt: !454)
!452 = distinct !DISubprogram(name: "<;", linkageName: "<", scope: !453, file: !453, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!453 = !DIFile(filename: "promotion.jl", directory: ".")
!454 = !DILocation(line: 379, scope: !160, inlinedAt: !447)
!455 = !DILocation(line: 82, scope: !456, inlinedAt: !458)
!456 = distinct !DISubprogram(name: "wavefrontsize;", linkageName: "wavefrontsize", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!457 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl", directory: ".")
!458 = !DILocation(line: 360, scope: !459, inlinedAt: !460)
!459 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!460 = !DILocation(line: 174, scope: !461, inlinedAt: !462)
!461 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!462 = !DILocation(line: 12, scope: !463, inlinedAt: !464)
!463 = distinct !DISubprogram(name: "shfl_down;", linkageName: "shfl_down", scope: !242, file: !242, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!464 = !DILocation(line: 78, scope: !448, inlinedAt: !449)
!465 = !DILocation(line: 730, scope: !368, inlinedAt: !466)
!466 = !DILocation(line: 228, scope: !467, inlinedAt: !468)
!467 = distinct !DISubprogram(name: "_shfl;", linkageName: "_shfl", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!468 = !DILocation(line: 360, scope: !459, inlinedAt: !458)
!469 = !DILocation(line: 106, scope: !470, inlinedAt: !471)
!470 = distinct !DISubprogram(name: "activelane;", linkageName: "activelane", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!471 = !DILocation(line: 249, scope: !459, inlinedAt: !472)
!472 = !DILocation(line: 361, scope: !473, inlinedAt: !466)
!473 = distinct !DISubprogram(name: "#19;", linkageName: "#19", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!474 = !DILocation(line: 741, scope: !475, inlinedAt: !476)
!475 = distinct !DISubprogram(name: "is_top_bit_set;", linkageName: "is_top_bit_set", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!476 = !DILocation(line: 756, scope: !477, inlinedAt: !478)
!477 = distinct !DISubprogram(name: "check_sign_bit;", linkageName: "check_sign_bit", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!478 = !DILocation(line: 805, scope: !479, inlinedAt: !480)
!479 = distinct !DISubprogram(name: "toInt32;", linkageName: "toInt32", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!480 = !DILocation(line: 891, scope: !481, inlinedAt: !482)
!481 = distinct !DISubprogram(name: "Int32;", linkageName: "Int32", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!482 = !DILocation(line: 7, scope: !175, inlinedAt: !471)
!483 = !DILocation(line: 741, scope: !475, inlinedAt: !484)
!484 = !DILocation(line: 756, scope: !477, inlinedAt: !485)
!485 = !DILocation(line: 805, scope: !479, inlinedAt: !486)
!486 = !DILocation(line: 891, scope: !481, inlinedAt: !487)
!487 = !DILocation(line: 250, scope: !459, inlinedAt: !472)
!488 = !DILocation(line: 87, scope: !94, inlinedAt: !487)
!489 = !DILocation(line: 86, scope: !208, inlinedAt: !490)
!490 = !DILocation(line: 1013, scope: !208, inlinedAt: !491)
!491 = !DILocation(line: 251, scope: !459, inlinedAt: !472)
!492 = !DILocation(line: 554, scope: !446, inlinedAt: !493)
!493 = !DILocation(line: 1011, scope: !494, inlinedAt: !491)
!494 = distinct !DISubprogram(name: "&;", linkageName: "&", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!495 = !DILocation(line: 347, scope: !494, inlinedAt: !496)
!496 = !DILocation(line: 1013, scope: !494, inlinedAt: !491)
!497 = !DILocation(line: 87, scope: !94, inlinedAt: !491)
!498 = !DILocation(line: 515, scope: !227, inlinedAt: !499)
!499 = !DILocation(line: 426, scope: !500, inlinedAt: !491)
!500 = distinct !DISubprogram(name: ">=;", linkageName: ">=", scope: !161, file: !161, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!501 = !DILocation(line: 796, scope: !502, inlinedAt: !491)
!502 = distinct !DISubprogram(name: "ifelse;", linkageName: "ifelse", scope: !369, file: !369, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!503 = !DILocation(line: 529, scope: !504, inlinedAt: !505)
!504 = distinct !DISubprogram(name: "<<;", linkageName: "<<", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!505 = !DILocation(line: 252, scope: !459, inlinedAt: !472)
!506 = !DILocation(line: 178, scope: !507, inlinedAt: !505)
!507 = distinct !DISubprogram(name: "bpermute;", linkageName: "bpermute", scope: !457, file: !457, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!508 = !DILocation(line: 491, scope: !509, inlinedAt: !511)
!509 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !510, file: !510, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!510 = !DIFile(filename: "float.jl", directory: ".")
!511 = !DILocation(line: 10, scope: !512, inlinedAt: !464)
!512 = distinct !DISubprogram(name: "+;", linkageName: "+", scope: !242, file: !242, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!513 = !DILocation(line: 7, scope: !390, inlinedAt: !511)
!514 = !DILocation(line: 528, scope: !515, inlinedAt: !516)
!515 = distinct !DISubprogram(name: ">>;", linkageName: ">>", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!516 = !DILocation(line: 79, scope: !448, inlinedAt: !449)
!517 = !DILocation(line: 81, scope: !448, inlinedAt: !449)
!518 = !DILocation(line: 639, scope: !519, inlinedAt: !520)
!519 = distinct !DISubprogram(name: "==;", linkageName: "==", scope: !453, file: !453, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!520 = !DILocation(line: 483, scope: !519, inlinedAt: !521)
!521 = !DILocation(line: 93, scope: !407, inlinedAt: !409)
!522 = !DILocation(line: 90, scope: !523, inlinedAt: !521)
!523 = distinct !DISubprogram(name: "#setindex!;", linkageName: "#setindex!", scope: !344, file: !344, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!524 = !DILocation(line: 39, scope: !79, inlinedAt: !525)
!525 = !DILocation(line: 0, scope: !379, inlinedAt: !526)
!526 = !DILocation(line: 0, scope: !527, inlinedAt: !528)
!527 = distinct !DISubprogram(name: "pointerset;", linkageName: "pointerset", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!528 = !DILocation(line: 88, scope: !529, inlinedAt: !530)
!529 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !384, file: !384, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!530 = !DILocation(line: 92, scope: !523, inlinedAt: !521)
!531 = !DILocation(line: 86, scope: !208, inlinedAt: !524)
!532 = !{!533, !533, i64 0, i64 0}
!533 = !{!"custom_tbaa_addrspace(3)", !388, i64 0}
!534 = !DILocation(line: 93, scope: !523, inlinedAt: !521)
!535 = !DILocation(line: 699, scope: !206, inlinedAt: !522)
!536 = !DILocation(line: 6, scope: !537, inlinedAt: !539)
!537 = distinct !DISubprogram(name: "sync_workgroup;", linkageName: "sync_workgroup", scope: !538, file: !538, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!538 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl", directory: ".")
!539 = !DILocation(line: 162, scope: !540, inlinedAt: !541)
!540 = distinct !DISubprogram(name: "#__synchronize;", linkageName: "#__synchronize", scope: !73, file: !73, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!541 = !DILocation(line: 290, scope: !404, inlinedAt: !542)
!542 = !DILocation(line: 94, scope: !407, inlinedAt: !409)
!543 = !DILocation(line: 86, scope: !208, inlinedAt: !544)
!544 = !DILocation(line: 1013, scope: !208, inlinedAt: !545)
!545 = !DILocation(line: 97, scope: !407, inlinedAt: !409)
!546 = !DILocation(line: 871, scope: !547, inlinedAt: !548)
!547 = distinct !DISubprogram(name: "toUInt64;", linkageName: "toUInt64", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!548 = !DILocation(line: 897, scope: !549, inlinedAt: !550)
!549 = distinct !DISubprogram(name: "UInt64;", linkageName: "UInt64", scope: !171, file: !171, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!550 = !DILocation(line: 7, scope: !175, inlinedAt: !551)
!551 = !DILocation(line: 375, scope: !552, inlinedAt: !553)
!552 = distinct !DISubprogram(name: "_promote;", linkageName: "_promote", scope: !453, file: !453, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!553 = !DILocation(line: 400, scope: !554, inlinedAt: !555)
!554 = distinct !DISubprogram(name: "promote;", linkageName: "promote", scope: !453, file: !453, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!555 = !DILocation(line: 484, scope: !452, inlinedAt: !556)
!556 = !DILocation(line: 520, scope: !158, inlinedAt: !545)
!557 = !DILocation(line: 513, scope: !158, inlinedAt: !555)
!558 = !DILocation(line: 38, scope: !234, inlinedAt: !556)
!559 = !DILocation(line: 98, scope: !407, inlinedAt: !409)
!560 = !DILocation(line: 84, scope: !349, inlinedAt: !559)
!561 = !DILocation(line: 39, scope: !79, inlinedAt: !562)
!562 = !DILocation(line: 0, scope: !379, inlinedAt: !563)
!563 = !DILocation(line: 0, scope: !381, inlinedAt: !564)
!564 = !DILocation(line: 85, scope: !383, inlinedAt: !565)
!565 = !DILocation(line: 86, scope: !349, inlinedAt: !559)
!566 = !DILocation(line: 86, scope: !208, inlinedAt: !561)
!567 = !DILocation(line: 639, scope: !519, inlinedAt: !568)
!568 = !DILocation(line: 483, scope: !519, inlinedAt: !569)
!569 = !DILocation(line: 99, scope: !407, inlinedAt: !409)
!570 = !DILocation(line: 77, scope: !448, inlinedAt: !569)
!571 = !DILocation(line: 513, scope: !158, inlinedAt: !572)
!572 = !DILocation(line: 484, scope: !452, inlinedAt: !573)
!573 = !DILocation(line: 379, scope: !160, inlinedAt: !570)
!574 = !DILocation(line: 49, scope: !66, inlinedAt: !575)
!575 = !DILocation(line: 12, scope: !463, inlinedAt: !576)
!576 = !DILocation(line: 78, scope: !448, inlinedAt: !569)
!577 = !DILocation(line: 82, scope: !456, inlinedAt: !578)
!578 = !DILocation(line: 360, scope: !459, inlinedAt: !579)
!579 = !DILocation(line: 174, scope: !461, inlinedAt: !575)
!580 = !DILocation(line: 730, scope: !368, inlinedAt: !581)
!581 = !DILocation(line: 228, scope: !467, inlinedAt: !582)
!582 = !DILocation(line: 360, scope: !459, inlinedAt: !578)
!583 = !DILocation(line: 106, scope: !470, inlinedAt: !584)
!584 = !DILocation(line: 249, scope: !459, inlinedAt: !585)
!585 = !DILocation(line: 361, scope: !473, inlinedAt: !581)
!586 = !DILocation(line: 741, scope: !475, inlinedAt: !587)
!587 = !DILocation(line: 756, scope: !477, inlinedAt: !588)
!588 = !DILocation(line: 805, scope: !479, inlinedAt: !589)
!589 = !DILocation(line: 891, scope: !481, inlinedAt: !590)
!590 = !DILocation(line: 7, scope: !175, inlinedAt: !584)
!591 = !DILocation(line: 741, scope: !475, inlinedAt: !592)
!592 = !DILocation(line: 756, scope: !477, inlinedAt: !593)
!593 = !DILocation(line: 805, scope: !479, inlinedAt: !594)
!594 = !DILocation(line: 891, scope: !481, inlinedAt: !595)
!595 = !DILocation(line: 250, scope: !459, inlinedAt: !585)
!596 = !DILocation(line: 87, scope: !94, inlinedAt: !595)
!597 = !DILocation(line: 86, scope: !208, inlinedAt: !598)
!598 = !DILocation(line: 1013, scope: !208, inlinedAt: !599)
!599 = !DILocation(line: 251, scope: !459, inlinedAt: !585)
!600 = !DILocation(line: 554, scope: !446, inlinedAt: !601)
!601 = !DILocation(line: 1011, scope: !494, inlinedAt: !599)
!602 = !DILocation(line: 347, scope: !494, inlinedAt: !603)
!603 = !DILocation(line: 1013, scope: !494, inlinedAt: !599)
!604 = !DILocation(line: 87, scope: !94, inlinedAt: !599)
!605 = !DILocation(line: 515, scope: !227, inlinedAt: !606)
!606 = !DILocation(line: 426, scope: !500, inlinedAt: !599)
!607 = !DILocation(line: 796, scope: !502, inlinedAt: !599)
!608 = !DILocation(line: 529, scope: !504, inlinedAt: !609)
!609 = !DILocation(line: 252, scope: !459, inlinedAt: !585)
!610 = !DILocation(line: 178, scope: !507, inlinedAt: !609)
!611 = !DILocation(line: 49, scope: !66, inlinedAt: !612)
!612 = !DILocation(line: 10, scope: !512, inlinedAt: !576)
!613 = !DILocation(line: 491, scope: !509, inlinedAt: !612)
!614 = !DILocation(line: 7, scope: !390, inlinedAt: !612)
!615 = !DILocation(line: 528, scope: !515, inlinedAt: !616)
!616 = !DILocation(line: 79, scope: !448, inlinedAt: !569)
!617 = !DILocation(line: 81, scope: !448, inlinedAt: !569)
!618 = !DILocation(line: 100, scope: !407, inlinedAt: !409)
!619 = !DILocation(line: 639, scope: !519, inlinedAt: !620)
!620 = !DILocation(line: 21, scope: !241, inlinedAt: !243)
!621 = !DILocation(line: 49, scope: !66, inlinedAt: !620)
!622 = !DILocation(line: 491, scope: !509, inlinedAt: !620)
!623 = !DILocation(line: 90, scope: !523, inlinedAt: !620)
!624 = !DILocation(line: 697, scope: !206, inlinedAt: !623)
!625 = !DILocation(line: 49, scope: !66, inlinedAt: !626)
!626 = !DILocation(line: 69, scope: !353, inlinedAt: !627)
!627 = !DILocation(line: 98, scope: !355, inlinedAt: !628)
!628 = !DILocation(line: 137, scope: !357, inlinedAt: !629)
!629 = !DILocation(line: 389, scope: !359, inlinedAt: !630)
!630 = !DILocation(line: 689, scope: !206, inlinedAt: !631)
!631 = !DILocation(line: 699, scope: !206, inlinedAt: !623)
!632 = !DILocation(line: 31, scope: !153, inlinedAt: !633)
!633 = !DILocation(line: 355, scope: !196, inlinedAt: !627)
!634 = !DILocation(line: 86, scope: !208, inlinedAt: !635)
!635 = !DILocation(line: 754, scope: !366, inlinedAt: !630)
!636 = !DILocation(line: 730, scope: !368, inlinedAt: !637)
!637 = !DILocation(line: 668, scope: !371, inlinedAt: !635)
!638 = !DILocation(line: 513, scope: !158, inlinedAt: !635)
!639 = !DILocation(line: 49, scope: !66, inlinedAt: !640)
!640 = !DILocation(line: 64, scope: !375, inlinedAt: !641)
!641 = !DILocation(line: 92, scope: !523, inlinedAt: !620)
!642 = !DILocation(line: 39, scope: !79, inlinedAt: !643)
!643 = !DILocation(line: 0, scope: !379, inlinedAt: !644)
!644 = !DILocation(line: 0, scope: !527, inlinedAt: !645)
!645 = !DILocation(line: 88, scope: !529, inlinedAt: !641)
!646 = !DILocation(line: 86, scope: !208, inlinedAt: !642)
!647 = !DILocation(line: 93, scope: !523, inlinedAt: !620)
!648 = !DILocation(line: 99, scope: !75, inlinedAt: !77)
!649 = !DILocation(line: 87, scope: !94, inlinedAt: !650)
!650 = !DILocation(line: 1013, scope: !94, inlinedAt: !444)
!651 = !DILocation(line: 86, scope: !208, inlinedAt: !652)
!652 = !DILocation(line: 1013, scope: !208, inlinedAt: !653)
!653 = !DILocation(line: 89, scope: !407, inlinedAt: !409)
!654 = !DILocation(line: 297, scope: !655, inlinedAt: !653)
!655 = distinct !DISubprogram(name: "div;", linkageName: "div", scope: !95, file: !95, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !47)
!656 = !DILocation(line: 87, scope: !94, inlinedAt: !657)
!657 = !DILocation(line: 1013, scope: !94, inlinedAt: !653)
!658 = !DILocation(line: 80, scope: !448, inlinedAt: !449)
!659 = !DILocation(line: 699, scope: !206, inlinedAt: !560)
!660 = !DILocation(line: 80, scope: !448, inlinedAt: !569)
!661 = !{!662, !662, i64 0}
!662 = !{!"bool", !663, i64 0}
!663 = !{!"omnipotent char", !664, i64 0}
!664 = !{!"Simple C/C++ TBAA"}
!665 = !{i8 0, i8 2}
!666 = !{!"exec_hi"}
!667 = !{!"exec_lo"}
!668 = distinct !DISubprogram(name: "report_exception", linkageName: "julia_report_exception_15612", scope: null, file: !669, line: 138, type: !46, scopeLine: 138, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !15, retainedNodes: !47)
!669 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/runtime.jl", directory: ".")
!670 = !DILocation(line: 138, scope: !668)
!671 = distinct !DISubprogram(name: "signal_exception", linkageName: "julia_signal_exception_15842", scope: null, file: !669, line: 112, type: !46, scopeLine: 112, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!672 = !DILocation(line: 39, scope: !673, inlinedAt: !674)
!673 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !80, file: !80, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!674 = !DILocation(line: 0, scope: !675, inlinedAt: !676)
!675 = distinct !DISubprogram(name: "macro expansion;", linkageName: "macro expansion", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!676 = !DILocation(line: 0, scope: !677, inlinedAt: !678)
!677 = distinct !DISubprogram(name: "kernel_state;", linkageName: "kernel_state", scope: !64, file: !64, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!678 = !DILocation(line: 11, scope: !679, inlinedAt: !680)
!679 = distinct !DISubprogram(name: "exception_flag;", linkageName: "exception_flag", scope: !669, file: !669, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!680 = !DILocation(line: 113, scope: !671)
!681 = !DILocation(line: 49, scope: !682, inlinedAt: !678)
!682 = distinct !DISubprogram(name: "getproperty;", linkageName: "getproperty", scope: !67, file: !67, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!683 = !DILocation(line: 180, scope: !684, inlinedAt: !686)
!684 = distinct !DISubprogram(name: "unsafe_store!;", linkageName: "unsafe_store!", scope: !685, file: !685, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!685 = !DIFile(filename: "pointer.jl", directory: ".")
!686 = !DILocation(line: 180, scope: !684, inlinedAt: !680)
!687 = !DILocation(line: 52, scope: !688, inlinedAt: !690)
!688 = distinct !DISubprogram(name: "endpgm;", linkageName: "endpgm", scope: !689, file: !689, type: !46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !23, retainedNodes: !47)
!689 = !DIFile(filename: "/home/pxlth/.julia/dev/AMDGPU/src/device/gcn/execution_control.jl", directory: ".")
!690 = !DILocation(line: 115, scope: !671)
!691 = !DILocation(line: 116, scope: !671)
