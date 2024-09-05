; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #0

define amdgpu_kernel void @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl1E5TupleI5OneToI5Int64EEE7NDRangeILl1ES0_S0_S2_ILl1ES3_IS4_IS5_EEES2_ILl1ES3_IS4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } %0, { [3 x i64], i8 addrspace(1)*, i64 } %1, i64 signext %2, i64 signext %3, i64 signext %4) local_unnamed_addr #1 {
conversion:
  %.fca.0.0.0.0.extract = extractvalue { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } %0, 0, 0, 0, 0
  %.fca.1.1.0.0.0.extract = extractvalue { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } %0, 1, 1, 0, 0, 0
  %.fca.1.extract = extractvalue { [3 x i64], i8 addrspace(1)*, i64 } %1, 1
  %5 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !7
  %6 = call i32 @llvm.amdgcn.workitem.id.x(), !range !8
  %7 = add nuw nsw i32 %6, 1
  %8 = zext i32 %7 to i64
  %9 = zext i32 %5 to i64
  %10 = mul i64 %.fca.1.1.0.0.0.extract, %9
  %11 = add i64 %10, %8
  %12 = icmp slt i64 %11, 1
  %13 = icmp sgt i64 %11, %.fca.0.0.0.0.extract
  %14 = or i1 %12, %13
  br i1 %14, label %L299, label %L103

L103:                                             ; preds = %conversion
  %15 = sub i64 0, %2
  %.not = icmp sgt i64 %15, %2
  %16 = sext i1 %.not to i64
  %value_phi = xor i64 %16, %2
  %.not6.not = icmp slt i64 %value_phi, %15
  br i1 %.not6.not, label %L293, label %L235.preheader

L235.preheader:                                   ; preds = %L103
  %17 = sub i64 0, %3
  %.not7 = icmp sgt i64 %17, %3
  %18 = sext i1 %.not7 to i64
  %value_phi5 = xor i64 %18, %3
  %.not8.not = icmp slt i64 %value_phi5, %17
  br label %L235

L235:                                             ; preds = %L267, %L235.preheader
  %value_phi3 = phi i64 [ %21, %L267 ], [ %15, %L235.preheader ]
  %value_phi4 = phi double [ %value_phi12, %L267 ], [ 0.000000e+00, %L235.preheader ]
  br i1 %.not8.not, label %L267, label %L254

L254:                                             ; preds = %L254, %L235
  %value_phi8 = phi double [ %19, %L254 ], [ %value_phi4, %L235 ]
  %value_phi9 = phi i64 [ %20, %L254 ], [ %17, %L235 ]
  %19 = fadd double %value_phi8, 2.000000e+00
  %.not9 = icmp eq i64 %value_phi9, %value_phi5
  %20 = add i64 %value_phi9, 1
  br i1 %.not9, label %L267, label %L254

L267:                                             ; preds = %L254, %L235
  %value_phi12 = phi double [ %value_phi4, %L235 ], [ %19, %L254 ]
  %.not10 = icmp eq i64 %value_phi3, %value_phi
  %21 = add i64 %value_phi3, 1
  br i1 %.not10, label %L293, label %L235

L293:                                             ; preds = %L267, %L103
  %value_phi15 = phi double [ 0.000000e+00, %L103 ], [ %value_phi12, %L267 ]
  %22 = add nsw i64 %8, -1
  %23 = add i64 %22, %10
  %24 = bitcast i8 addrspace(1)* %.fca.1.extract to double addrspace(1)*
  %25 = getelementptr inbounds double, double addrspace(1)* %24, i64 %23
  store double %value_phi15, double addrspace(1)* %25, align 8, !tbaa !9
  br label %L299

L299:                                             ; preds = %L293, %conversion
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

!llvm.module.flags = !{!0, !1, !2, !3}
!opencl.ocl.version = !{!4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4, !4}
!llvm.ident = !{!5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5, !5}
!julia.kernel = !{!6}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = !{i32 2, i32 0}
!5 = !{!"clang version 15.0.0 (/cache/yggdrasil/downloads/clones/llvm-project.git-974efd367bc513231526d317489c66cb27727ef3caa41108e3819c131a8acf57 f3d695fc2985a8dfdd5f4219d351fdeac3038867)"}
!6 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [3 x i64], i8 addrspace(1)*, i64 }, i64, i64, i64)* @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl1E5TupleI5OneToI5Int64EEE7NDRangeILl1ES0_S0_S2_ILl1ES3_IS4_IS5_EEES2_ILl1ES3_IS4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_}
!7 = !{i32 0, i32 -2}
!8 = !{i32 0, i32 1023}
!9 = !{!10, !10, i64 0, i64 0}
!10 = !{!"custom_tbaa_addrspace(1)", !11, i64 0}
!11 = !{!"custom_tbaa"}
