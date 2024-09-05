; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #0

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #1

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.smax.i64(i64, i64) #2

define amdgpu_kernel void @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl3E5TupleI5OneToI5Int64ES4_IS5_ES4_IS5_EEE7NDRangeILl3ES0_S0_S2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEES2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, { [3 x i64], i8 addrspace(1)*, i64 } %1, i64 signext %2, i64 signext %3, i64 signext %4) local_unnamed_addr #3 {
conversion:
  %.fca.0.0.0.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 0, 0, 0, 0
  %.fca.0.0.1.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 0, 0, 1, 0
  %.fca.0.0.2.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 0, 0, 2, 0
  %.fca.1.0.0.0.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 1, 0, 0, 0, 0
  %.fca.1.0.0.1.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 1, 0, 0, 1, 0
  %.fca.1.1.0.0.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 1, 1, 0, 0, 0
  %.fca.1.1.0.1.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 1, 1, 0, 1, 0
  %.fca.1.1.0.2.0.extract = extractvalue { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, 1, 1, 0, 2, 0
  %.fca.1.extract = extractvalue { [3 x i64], i8 addrspace(1)*, i64 } %1, 1
  %5 = call i32 @llvm.amdgcn.workitem.id.x(), !range !7
  %6 = call i64 @llvm.smax.i64(i64 %.fca.1.0.0.1.0.extract, i64 0)
  %7 = icmp sgt i64 %.fca.1.0.0.0.0.extract, 0
  br i1 %7, label %pass, label %fail

L674:                                             ; preds = %L674.preheader, %L706
  %value_phi17 = phi i64 [ %10, %L706 ], [ %65, %L674.preheader ]
  %value_phi18 = phi double [ %value_phi26, %L706 ], [ 0.000000e+00, %L674.preheader ]
  br i1 %.not127.not, label %L706, label %L693

L693:                                             ; preds = %L693, %L674
  %value_phi22 = phi double [ %8, %L693 ], [ %value_phi18, %L674 ]
  %value_phi23 = phi i64 [ %9, %L693 ], [ %67, %L674 ]
  %8 = fadd double %value_phi22, 2.000000e+00
  %.not128 = icmp eq i64 %value_phi23, %value_phi19
  %9 = add i64 %value_phi23, 1
  br i1 %.not128, label %L706, label %L693

L706:                                             ; preds = %L693, %L674
  %value_phi26 = phi double [ %value_phi18, %L674 ], [ %8, %L693 ]
  %.not129 = icmp eq i64 %value_phi17, %value_phi
  %10 = add i64 %value_phi17, 1
  br i1 %.not129, label %L732, label %L674

L732:                                             ; preds = %pass10, %L706
  %value_phi29 = phi double [ 0.000000e+00, %pass10 ], [ %value_phi26, %L706 ]
  %11 = add i64 %64, %32
  %reass.add137 = add i64 %11, %reass.mul135
  %reass.mul138 = mul i64 %reass.add137, %60
  %12 = add i64 %reass.mul138, %31
  %13 = add i64 %12, %reass.mul
  %14 = bitcast i8 addrspace(1)* %.fca.1.extract to double addrspace(1)*
  %15 = getelementptr inbounds double, double addrspace(1)* %14, i64 %13
  store double %value_phi29, double addrspace(1)* %15, align 8, !tbaa !8
  br label %L738

L738:                                             ; preds = %pass6, %L732
  ret void

fail:                                             ; preds = %conversion
  %state.i.fca.0.extract.i = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0
  %16 = inttoptr i64 %state.i.fca.0.extract.i to i32*
  store i32 1, i32* %16, align 1
  call void @llvm.amdgcn.endpgm()
  unreachable

pass:                                             ; preds = %conversion
  %17 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !11
  %18 = zext i32 %17 to i64
  %19 = udiv i64 %18, %.fca.1.0.0.0.0.extract
  %20 = mul i64 %19, %.fca.1.0.0.0.0.extract
  %21 = icmp sgt i64 %.fca.1.0.0.1.0.extract, 0
  br i1 %21, label %pass2, label %fail1

fail1:                                            ; preds = %pass
  %state.i.fca.0.extract.i28 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0
  %22 = inttoptr i64 %state.i.fca.0.extract.i28 to i32*
  store i32 1, i32* %22, align 1
  call void @llvm.amdgcn.endpgm()
  unreachable

pass2:                                            ; preds = %pass
  %23 = udiv i64 %19, %6
  %24 = mul i64 %23, %6
  %25 = sub i64 %19, %24
  %26 = call i64 @llvm.smax.i64(i64 %.fca.1.1.0.1.0.extract, i64 0)
  %27 = icmp sgt i64 %.fca.1.1.0.0.0.extract, 0
  br i1 %27, label %pass4, label %fail3

fail3:                                            ; preds = %pass2
  %state.i.fca.0.extract.i42 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0
  %28 = inttoptr i64 %state.i.fca.0.extract.i42 to i32*
  store i32 1, i32* %28, align 1
  call void @llvm.amdgcn.endpgm()
  unreachable

pass4:                                            ; preds = %pass2
  %29 = icmp sgt i64 %.fca.1.1.0.1.0.extract, 0
  br i1 %29, label %pass6, label %fail5

fail5:                                            ; preds = %pass4
  %state.i.fca.0.extract.i56 = extractvalue { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state, 0
  %30 = inttoptr i64 %state.i.fca.0.extract.i56 to i32*
  store i32 1, i32* %30, align 1
  call void @llvm.amdgcn.endpgm()
  unreachable

pass6:                                            ; preds = %pass4
  %31 = zext i32 %5 to i64
  %32 = udiv i64 %31, %.fca.1.1.0.0.0.extract
  %33 = udiv i64 %32, %26
  %34 = mul i64 %33, %26
  %35 = add i64 %20, %32
  %reass.add = sub i64 %18, %35
  %reass.mul = mul i64 %reass.add, %.fca.1.1.0.0.0.extract
  %36 = add nuw nsw i64 %31, 1
  %37 = add i64 %36, %reass.mul
  %38 = mul i64 %25, %.fca.1.1.0.1.0.extract
  %39 = add i64 %38, 1
  %40 = add i64 %39, %32
  %41 = sub i64 %40, %34
  %42 = mul i64 %23, %.fca.1.1.0.2.0.extract
  %43 = add i64 %42, 1
  %44 = add i64 %43, %33
  %45 = icmp sgt i64 %37, 0
  %46 = icmp sle i64 %37, %.fca.0.0.0.0.extract
  %47 = and i1 %45, %46
  %48 = icmp sgt i64 %41, 0
  %49 = icmp sle i64 %41, %.fca.0.0.1.0.extract
  %50 = and i1 %48, %49
  %51 = icmp sgt i64 %44, 0
  %52 = icmp sle i64 %44, %.fca.0.0.2.0.extract
  %53 = and i1 %51, %52
  %54 = and i1 %47, %50
  %55 = and i1 %53, %54
  br i1 %55, label %pass10, label %L738

pass10:                                           ; preds = %pass6
  %56 = udiv i64 %19, %.fca.1.0.0.1.0.extract
  %57 = mul i64 %56, %.fca.1.0.0.1.0.extract
  %58 = udiv i64 %32, %.fca.1.1.0.1.0.extract
  %59 = mul i64 %56, %.fca.1.1.0.2.0.extract
  %60 = call i64 @llvm.smax.i64(i64 %.fca.0.0.0.0.extract, i64 0)
  %61 = call i64 @llvm.smax.i64(i64 %.fca.0.0.1.0.extract, i64 0)
  %62 = add i64 %57, %58
  %reass.add134 = sub i64 %19, %62
  %reass.mul135 = mul i64 %reass.add134, %.fca.1.1.0.1.0.extract
  %63 = add i64 %58, %59
  %64 = mul i64 %63, %61
  %65 = sub i64 0, %2
  %.not = icmp sgt i64 %65, %2
  %66 = sext i1 %.not to i64
  %value_phi = xor i64 %66, %2
  %.not125.not = icmp slt i64 %value_phi, %65
  br i1 %.not125.not, label %L732, label %L674.preheader

L674.preheader:                                   ; preds = %pass10
  %67 = sub i64 0, %3
  %.not126 = icmp sgt i64 %67, %3
  %68 = sext i1 %.not126 to i64
  %value_phi19 = xor i64 %68, %3
  %.not127.not = icmp slt i64 %value_phi19, %67
  br label %L674
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { cold noreturn nounwind }
attributes #2 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }

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
!6 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [3 x i64], i8 addrspace(1)*, i64 }, i64, i64, i64)* @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl3E5TupleI5OneToI5Int64ES4_IS5_ES4_IS5_EEE7NDRangeILl3ES0_S0_S2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEES2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_}
!7 = !{i32 0, i32 1023}
!8 = !{!9, !9, i64 0, i64 0}
!9 = !{!"custom_tbaa_addrspace(1)", !10, i64 0}
!10 = !{!"custom_tbaa"}
!11 = !{i32 0, i32 -2}
