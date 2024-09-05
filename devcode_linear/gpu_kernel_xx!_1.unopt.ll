; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #0

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #0

define amdgpu_kernel void @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl1E5TupleI5OneToI5Int64EEE7NDRangeILl1ES0_S0_S2_ILl1ES3_IS4_IS5_EEES2_ILl1ES3_IS4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_({ [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } %0, { [3 x i64], i8 addrspace(1)*, i64 } %1, i64 signext %2, i64 signext %3, i64 signext %4) local_unnamed_addr #1 {
conversion:
  %5 = alloca { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, align 8, addrspace(5)
  %6 = addrspacecast { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(5)* %5 to { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)*
  store { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } %0, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)* %6, align 8
  %7 = alloca { [3 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %8 = addrspacecast { [3 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %7 to { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [3 x i64], i8 addrspace(1)*, i64 } %1, { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %8, align 8
  br label %top

top:                                              ; preds = %conversion
  %9 = alloca [1 x i64], align 8, addrspace(5)
  %10 = alloca [1 x i64], align 8, addrspace(5)
  %11 = alloca [1 x i64], align 8, addrspace(5)
  %12 = alloca [1 x i64], align 8, addrspace(5)
  %13 = alloca [1 x [1 x [1 x i64]]], align 8, addrspace(5)
  %14 = alloca [1 x i64], align 8, addrspace(5)
  %15 = alloca [1 x i64], align 8, addrspace(5)
  %16 = call {}*** @julia.get_pgcstack()
  %17 = bitcast {}*** %16 to {}**
  %current_task = getelementptr inbounds {}*, {}** %17, i64 -14
  %18 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %18, i64 15
  %19 = getelementptr inbounds { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 1
  %20 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !7
  %21 = add i32 %20, 1
  %22 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !7
  %23 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !7
  %24 = call i32 @llvm.amdgcn.workitem.id.x(), !range !8
  %25 = add i32 %24, 1
  %26 = call i32 @llvm.amdgcn.workitem.id.y(), !range !8
  %27 = call i32 @llvm.amdgcn.workitem.id.z(), !range !8
  %28 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %19, i32 0, i32 0
  %29 = zext i32 %21 to i64
  br label %L34

L34:                                              ; preds = %top
  %30 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %28, i32 0, i32 0
  %31 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %30, i32 0, i32 0
  br label %L45

L45:                                              ; preds = %L34
  br label %L46

L46:                                              ; preds = %L45
  br label %L47

L47:                                              ; preds = %L46
  br label %L48

L48:                                              ; preds = %L47
  br label %L49

L49:                                              ; preds = %L48
  br label %L50

L50:                                              ; preds = %L49
  br label %L51

L51:                                              ; preds = %L50
  %32 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %19, i32 0, i32 1
  %33 = zext i32 %25 to i64
  br label %L69

L69:                                              ; preds = %L51
  %34 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %32, i32 0, i32 0
  %35 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %34, i32 0, i32 0
  br label %L80

L80:                                              ; preds = %L69
  br label %L81

L81:                                              ; preds = %L80
  br label %L82

L82:                                              ; preds = %L81
  br label %L83

L83:                                              ; preds = %L82
  br label %L84

L84:                                              ; preds = %L83
  br label %L85

L85:                                              ; preds = %L84
  br label %L86

L86:                                              ; preds = %L85
  %36 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %19, i32 0, i32 1
  %37 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %36, i32 0, i32 0
  %38 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %37, i32 0, i32 0
  %39 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %38, i32 0, i32 0
  %40 = sub i64 %29, 1
  %41 = load i64, i64 addrspace(11)* %39, align 8, !alias.scope !9, !noalias !12
  %42 = mul i64 %40, %41
  %43 = add i64 %42, %33
  br label %L94

L94:                                              ; preds = %L86
  %44 = getelementptr inbounds { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 0
  %45 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %44, i32 0, i32 0
  %46 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %45, i32 0, i32 0
  %47 = icmp sle i64 1, %43
  %48 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %46, i32 0, i32 0
  %49 = load i64, i64 addrspace(11)* %48, align 8, !alias.scope !9, !noalias !12
  %50 = icmp sle i64 %43, %49
  %51 = and i1 %47, %50
  br label %L102

L102:                                             ; preds = %L94
  %52 = xor i1 %51, true
  br i1 %52, label %L299, label %L103

L103:                                             ; preds = %L102
  %53 = getelementptr inbounds { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 1
  %54 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !7
  %55 = add i32 %54, 1
  %56 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !7
  %57 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !7
  %58 = call i32 @llvm.amdgcn.workitem.id.x(), !range !8
  %59 = add i32 %58, 1
  %60 = call i32 @llvm.amdgcn.workitem.id.y(), !range !8
  %61 = call i32 @llvm.amdgcn.workitem.id.z(), !range !8
  %62 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %53, i32 0, i32 0
  %63 = zext i32 %55 to i64
  br label %L136

L136:                                             ; preds = %L103
  %64 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %62, i32 0, i32 0
  %65 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %64, i32 0, i32 0
  br label %L147

L147:                                             ; preds = %L136
  br label %L148

L148:                                             ; preds = %L147
  br label %L149

L149:                                             ; preds = %L148
  br label %L150

L150:                                             ; preds = %L149
  br label %L151

L151:                                             ; preds = %L150
  br label %L152

L152:                                             ; preds = %L151
  br label %L153

L153:                                             ; preds = %L152
  %66 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %53, i32 0, i32 1
  %67 = zext i32 %59 to i64
  br label %L171

L171:                                             ; preds = %L153
  %68 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %66, i32 0, i32 0
  %69 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %68, i32 0, i32 0
  br label %L182

L182:                                             ; preds = %L171
  br label %L183

L183:                                             ; preds = %L182
  br label %L184

L184:                                             ; preds = %L183
  br label %L185

L185:                                             ; preds = %L184
  br label %L186

L186:                                             ; preds = %L185
  br label %L187

L187:                                             ; preds = %L186
  br label %L188

L188:                                             ; preds = %L187
  %70 = getelementptr inbounds [2 x [1 x [1 x [1 x i64]]]], [2 x [1 x [1 x [1 x i64]]]] addrspace(11)* %53, i32 0, i32 1
  %71 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %70, i32 0, i32 0
  %72 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %71, i32 0, i32 0
  %73 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %72, i32 0, i32 0
  %74 = sub i64 %63, 1
  %75 = load i64, i64 addrspace(11)* %73, align 8, !alias.scope !9, !noalias !12
  %76 = mul i64 %74, %75
  %77 = add i64 %76, %67
  br label %L196

L196:                                             ; preds = %L188
  %78 = getelementptr inbounds { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 0
  %79 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(11)* %78, i32 0, i32 0
  %80 = getelementptr inbounds [1 x [1 x [1 x i64]]], [1 x [1 x [1 x i64]]] addrspace(5)* %13, i32 0, i32 0
  %81 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(11)* %79, i32 0, i32 0
  %82 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %81, i32 0, i32 0
  %83 = getelementptr inbounds [1 x [1 x i64]], [1 x [1 x i64]] addrspace(5)* %80, i32 0, i32 0
  %84 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(5)* %83, i32 0, i32 0
  %85 = load i64, i64 addrspace(11)* %82, align 8, !alias.scope !9, !noalias !12
  store i64 %85, i64 addrspace(5)* %84, align 8, !tbaa !17, !alias.scope !21, !noalias !22
  br label %L214

L214:                                             ; preds = %L196
  br label %L215

L215:                                             ; preds = %L214
  br label %L216

L216:                                             ; preds = %L215
  br label %L217

L217:                                             ; preds = %L216
  br label %L218

L218:                                             ; preds = %L217
  %86 = sub i64 0, %2
  %87 = icmp sle i64 %86, %2
  %88 = xor i1 %87, true
  br i1 %88, label %L222, label %L221

L221:                                             ; preds = %L218
  br label %L224

L222:                                             ; preds = %L218
  %89 = sub i64 %86, 1
  br label %L224

L224:                                             ; preds = %L222, %L221
  %value_phi = phi i64 [ %2, %L221 ], [ %89, %L222 ]
  br label %L226

L226:                                             ; preds = %L224
  br label %L227

L227:                                             ; preds = %L226
  %90 = icmp slt i64 %value_phi, %86
  %91 = xor i1 %90, true
  br i1 %91, label %L230, label %L229

L229:                                             ; preds = %L227
  br label %L231

L230:                                             ; preds = %L227
  br label %L231

L231:                                             ; preds = %L230, %L229
  %value_phi1 = phi i8 [ 1, %L229 ], [ 0, %L230 ]
  %value_phi2 = phi i64 [ %86, %L230 ], [ undef, %L229 ]
  %92 = trunc i8 %value_phi1 to i1
  %93 = xor i1 %92, true
  %94 = xor i1 %93, true
  br i1 %94, label %L231.L278_crit_edge, label %L231.L235_crit_edge

L231.L278_crit_edge:                              ; preds = %L231
  br label %L278

L231.L235_crit_edge:                              ; preds = %L231
  br label %L235

L235:                                             ; preds = %L277, %L231.L235_crit_edge
  %value_phi3 = phi i64 [ %value_phi2, %L231.L235_crit_edge ], [ %value_phi13, %L277 ]
  %value_phi4 = phi double [ 0.000000e+00, %L231.L235_crit_edge ], [ %value_phi12, %L277 ]
  %95 = sub i64 0, %3
  %96 = icmp sle i64 %95, %3
  %97 = xor i1 %96, true
  br i1 %97, label %L241, label %L240

L240:                                             ; preds = %L235
  br label %L243

L241:                                             ; preds = %L235
  %98 = sub i64 %95, 1
  br label %L243

L243:                                             ; preds = %L241, %L240
  %value_phi5 = phi i64 [ %3, %L240 ], [ %98, %L241 ]
  br label %L245

L245:                                             ; preds = %L243
  br label %L246

L246:                                             ; preds = %L245
  %99 = icmp slt i64 %value_phi5, %95
  %100 = xor i1 %99, true
  br i1 %100, label %L249, label %L248

L248:                                             ; preds = %L246
  br label %L250

L249:                                             ; preds = %L246
  br label %L250

L250:                                             ; preds = %L249, %L248
  %value_phi6 = phi i8 [ 1, %L248 ], [ 0, %L249 ]
  %value_phi7 = phi i64 [ %95, %L249 ], [ undef, %L248 ]
  %101 = trunc i8 %value_phi6 to i1
  %102 = xor i1 %101, true
  %103 = xor i1 %102, true
  br i1 %103, label %L250.L267_crit_edge, label %L250.L254_crit_edge

L250.L267_crit_edge:                              ; preds = %L250
  br label %L267

L250.L254_crit_edge:                              ; preds = %L250
  br label %L254

L254:                                             ; preds = %L266, %L250.L254_crit_edge
  %value_phi8 = phi double [ %value_phi4, %L250.L254_crit_edge ], [ %104, %L266 ]
  %value_phi9 = phi i64 [ %value_phi7, %L250.L254_crit_edge ], [ %value_phi10, %L266 ]
  %104 = fadd double %value_phi8, 2.000000e+00
  %105 = icmp eq i64 %value_phi9, %value_phi5
  %106 = xor i1 %105, true
  br i1 %106, label %L260, label %L259

L259:                                             ; preds = %L254
  br label %L262

L260:                                             ; preds = %L254
  %107 = add i64 %value_phi9, 1
  br label %L262

L262:                                             ; preds = %L260, %L259
  %value_phi10 = phi i64 [ %107, %L260 ], [ undef, %L259 ]
  %value_phi11 = phi i8 [ 1, %L259 ], [ 0, %L260 ]
  %108 = trunc i8 %value_phi11 to i1
  %109 = xor i1 %108, true
  %110 = xor i1 %109, true
  br i1 %110, label %L262.L267_crit_edge, label %L266

L262.L267_crit_edge:                              ; preds = %L262
  br label %L267

L266:                                             ; preds = %L262
  br label %L254

L267:                                             ; preds = %L262.L267_crit_edge, %L250.L267_crit_edge
  %value_phi12 = phi double [ %104, %L262.L267_crit_edge ], [ %value_phi4, %L250.L267_crit_edge ]
  %111 = icmp eq i64 %value_phi3, %value_phi
  %112 = xor i1 %111, true
  br i1 %112, label %L271, label %L270

L270:                                             ; preds = %L267
  br label %L273

L271:                                             ; preds = %L267
  %113 = add i64 %value_phi3, 1
  br label %L273

L273:                                             ; preds = %L271, %L270
  %value_phi13 = phi i64 [ %113, %L271 ], [ undef, %L270 ]
  %value_phi14 = phi i8 [ 1, %L270 ], [ 0, %L271 ]
  %114 = trunc i8 %value_phi14 to i1
  %115 = xor i1 %114, true
  %116 = xor i1 %115, true
  br i1 %116, label %L273.L278_crit_edge, label %L277

L273.L278_crit_edge:                              ; preds = %L273
  br label %L278

L277:                                             ; preds = %L273
  br label %L235

L278:                                             ; preds = %L273.L278_crit_edge, %L231.L278_crit_edge
  %value_phi15 = phi double [ %value_phi12, %L273.L278_crit_edge ], [ 0.000000e+00, %L231.L278_crit_edge ]
  br label %L293

L293:                                             ; preds = %L278
  %117 = getelementptr inbounds { [3 x i64], i8 addrspace(1)*, i64 }, { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %8, i32 0, i32 1
  %118 = sub i64 %77, 1
  %119 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %117, align 8, !alias.scope !9, !noalias !12
  %120 = bitcast i8 addrspace(1)* %119 to double addrspace(1)*
  %121 = getelementptr inbounds double, double addrspace(1)* %120, i64 %118
  store double %value_phi15, double addrspace(1)* %121, align 8, !tbaa !23
  br label %L298

L298:                                             ; preds = %L293
  br label %L299

L299:                                             ; preds = %L298, %L102
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
!6 = !{void ({ [1 x [1 x [1 x i64]]], [2 x [1 x [1 x [1 x i64]]]] }, { [3 x i64], i8 addrspace(1)*, i64 }, i64, i64, i64)* @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl1E5TupleI5OneToI5Int64EEE7NDRangeILl1ES0_S0_S2_ILl1ES3_IS4_IS5_EEES2_ILl1ES3_IS4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_}
!7 = !{i32 0, i32 -2}
!8 = !{i32 0, i32 1023}
!9 = !{!10}
!10 = !{!"jnoalias_const", !11}
!11 = !{!"jnoalias"}
!12 = !{!13, !14, !15, !16}
!13 = !{!"jnoalias_gcframe", !11}
!14 = !{!"jnoalias_stack", !11}
!15 = !{!"jnoalias_data", !11}
!16 = !{!"jnoalias_typemd", !11}
!17 = !{!18, !18, i64 0}
!18 = !{!"jtbaa_stack", !19, i64 0}
!19 = !{!"jtbaa", !20, i64 0}
!20 = !{!"jtbaa"}
!21 = !{!14}
!22 = !{!13, !15, !16, !10}
!23 = !{!24, !24, i64 0, i64 0}
!24 = !{!"custom_tbaa_addrspace(1)", !25, i64 0}
!25 = !{!"custom_tbaa"}
