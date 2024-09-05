; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

@_j_const1 = private unnamed_addr addrspace(1) constant i32 1, align 4

declare {}*** @julia.get_pgcstack() local_unnamed_addr

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p5i8.p11i8.i64(i8 addrspace(5)* noalias nocapture writeonly, i8 addrspace(11)* noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.x() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.y() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workgroup.id.z() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.x() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.y() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.workitem.id.z() #2

define amdgpu_kernel void @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl3E5TupleI5OneToI5Int64ES4_IS5_ES4_IS5_EEE7NDRangeILl3ES0_S0_S2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEES2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_({ [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, { [3 x i64], i8 addrspace(1)*, i64 } %1, i64 signext %2, i64 signext %3, i64 signext %4) local_unnamed_addr #3 {
conversion:
  %5 = alloca { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, align 8, addrspace(5)
  %6 = addrspacecast { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(5)* %5 to { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)*
  store { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } %0, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)* %6, align 8
  %7 = alloca { [3 x i64], i8 addrspace(1)*, i64 }, align 8, addrspace(5)
  %8 = addrspacecast { [3 x i64], i8 addrspace(1)*, i64 } addrspace(5)* %7 to { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)*
  store { [3 x i64], i8 addrspace(1)*, i64 } %1, { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %8, align 8
  br label %top

top:                                              ; preds = %conversion
  %9 = alloca [1 x i64], align 8, addrspace(5)
  %10 = alloca [3 x i64], align 8, addrspace(5)
  %11 = alloca [1 x i64], align 8, addrspace(5)
  %12 = alloca [3 x i64], align 8, addrspace(5)
  %13 = alloca [1 x i64], align 8, addrspace(5)
  %14 = alloca [3 x i64], align 8, addrspace(5)
  %15 = alloca [1 x i64], align 8, addrspace(5)
  %16 = alloca [3 x i64], align 8, addrspace(5)
  %17 = alloca [1 x [3 x [1 x i64]]], align 8, addrspace(5)
  %18 = alloca [3 x i64], align 8, addrspace(5)
  %19 = alloca [1 x i64], align 8, addrspace(5)
  %20 = alloca [1 x i64], align 8, addrspace(5)
  %21 = call {}*** @julia.get_pgcstack()
  %22 = bitcast {}*** %21 to {}**
  %current_task = getelementptr inbounds {}*, {}** %22, i64 -14
  %23 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %23, i64 15
  %24 = getelementptr inbounds { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 1
  %25 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !7
  %26 = add i32 %25, 1
  %27 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !7
  %28 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !7
  %29 = call i32 @llvm.amdgcn.workitem.id.x(), !range !8
  %30 = add i32 %29, 1
  %31 = call i32 @llvm.amdgcn.workitem.id.y(), !range !8
  %32 = call i32 @llvm.amdgcn.workitem.id.z(), !range !8
  %33 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %24, i32 0, i32 0
  %34 = zext i32 %26 to i64
  br label %L40

L40:                                              ; preds = %top
  %35 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %33, i32 0, i32 0
  %36 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %35, i32 0, i32 0
  %37 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %36, i32 0, i32 0
  %38 = load i64, i64 addrspace(11)* %37, align 8, !alias.scope !9, !noalias !12
  %39 = icmp slt i64 %38, 0
  %40 = xor i1 %39, true
  %41 = load i64, i64 addrspace(11)* %37, align 8, !alias.scope !9, !noalias !12
  %42 = select i1 %40, i64 %41, i64 0
  %43 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %35, i32 0, i32 1
  %44 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %43, i32 0, i32 0
  %45 = load i64, i64 addrspace(11)* %44, align 8, !alias.scope !9, !noalias !12
  %46 = icmp slt i64 %45, 0
  %47 = xor i1 %46, true
  %48 = load i64, i64 addrspace(11)* %44, align 8, !alias.scope !9, !noalias !12
  %49 = select i1 %47, i64 %48, i64 0
  %50 = sub i64 %34, 1
  %51 = icmp ne i64 %50, -9223372036854775808
  %52 = icmp ne i64 %42, -1
  %53 = or i1 %52, %51
  %54 = icmp ne i64 %42, 0
  %55 = and i1 %54, %53
  br i1 %55, label %pass, label %fail

L94:                                              ; preds = %pass2
  %56 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %33, i32 0, i32 0
  %57 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %56, i32 0, i32 0
  br label %L105

L105:                                             ; preds = %L94
  br label %L106

L106:                                             ; preds = %L105
  br label %L107

L107:                                             ; preds = %L106
  %58 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %56, i32 0, i32 1
  %59 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %56, i32 0, i32 2
  br label %L118

L118:                                             ; preds = %L107
  br label %L119

L119:                                             ; preds = %L118
  br label %L120

L120:                                             ; preds = %L119
  br label %L129

L129:                                             ; preds = %L120
  br label %L130

L130:                                             ; preds = %L129
  br label %L131

L131:                                             ; preds = %L130
  br label %L132

L132:                                             ; preds = %L131
  br label %L133

L133:                                             ; preds = %L132
  br label %L134

L134:                                             ; preds = %L133
  br label %L135

L135:                                             ; preds = %L134
  br label %L136

L136:                                             ; preds = %L135
  %60 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %24, i32 0, i32 1
  %61 = zext i32 %30 to i64
  br label %L160

L160:                                             ; preds = %L136
  %62 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %60, i32 0, i32 0
  %63 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %62, i32 0, i32 0
  %64 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %63, i32 0, i32 0
  %65 = load i64, i64 addrspace(11)* %64, align 8, !alias.scope !9, !noalias !12
  %66 = icmp slt i64 %65, 0
  %67 = xor i1 %66, true
  %68 = load i64, i64 addrspace(11)* %64, align 8, !alias.scope !9, !noalias !12
  %69 = select i1 %67, i64 %68, i64 0
  %70 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %62, i32 0, i32 1
  %71 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %70, i32 0, i32 0
  %72 = load i64, i64 addrspace(11)* %71, align 8, !alias.scope !9, !noalias !12
  %73 = icmp slt i64 %72, 0
  %74 = xor i1 %73, true
  %75 = load i64, i64 addrspace(11)* %71, align 8, !alias.scope !9, !noalias !12
  %76 = select i1 %74, i64 %75, i64 0
  %77 = sub i64 %61, 1
  %78 = icmp ne i64 %77, -9223372036854775808
  %79 = icmp ne i64 %69, -1
  %80 = or i1 %79, %78
  %81 = icmp ne i64 %69, 0
  %82 = and i1 %81, %80
  br i1 %82, label %pass4, label %fail3

L214:                                             ; preds = %pass6
  %83 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %60, i32 0, i32 0
  %84 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %83, i32 0, i32 0
  br label %L225

L225:                                             ; preds = %L214
  br label %L226

L226:                                             ; preds = %L225
  br label %L227

L227:                                             ; preds = %L226
  %85 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %83, i32 0, i32 1
  %86 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %83, i32 0, i32 2
  br label %L238

L238:                                             ; preds = %L227
  br label %L239

L239:                                             ; preds = %L238
  br label %L240

L240:                                             ; preds = %L239
  br label %L249

L249:                                             ; preds = %L240
  br label %L250

L250:                                             ; preds = %L249
  br label %L251

L251:                                             ; preds = %L250
  br label %L252

L252:                                             ; preds = %L251
  br label %L253

L253:                                             ; preds = %L252
  br label %L254

L254:                                             ; preds = %L253
  br label %L255

L255:                                             ; preds = %L254
  br label %L256

L256:                                             ; preds = %L255
  %87 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %24, i32 0, i32 1
  %88 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %87, i32 0, i32 0
  %89 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %88, i32 0, i32 0
  %90 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %89, i32 0, i32 0
  %91 = sub i64 %290, 1
  %92 = load i64, i64 addrspace(11)* %90, align 8, !alias.scope !9, !noalias !12
  %93 = mul i64 %91, %92
  %94 = add i64 %93, %304
  %95 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %24, i32 0, i32 1
  %96 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %95, i32 0, i32 0
  %97 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %96, i32 0, i32 1
  %98 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %97, i32 0, i32 0
  %99 = sub i64 %299, 1
  %100 = load i64, i64 addrspace(11)* %98, align 8, !alias.scope !9, !noalias !12
  %101 = mul i64 %99, %100
  %102 = add i64 %101, %313
  %103 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %24, i32 0, i32 1
  %104 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %103, i32 0, i32 0
  %105 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %104, i32 0, i32 2
  %106 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %105, i32 0, i32 0
  %107 = sub i64 %300, 1
  %108 = load i64, i64 addrspace(11)* %106, align 8, !alias.scope !9, !noalias !12
  %109 = mul i64 %107, %108
  %110 = add i64 %109, %314
  br label %L278

L278:                                             ; preds = %L256
  %111 = getelementptr inbounds { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 0
  %112 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %111, i32 0, i32 0
  %113 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %112, i32 0, i32 0
  %114 = icmp sle i64 1, %94
  %115 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %113, i32 0, i32 0
  %116 = load i64, i64 addrspace(11)* %115, align 8, !alias.scope !9, !noalias !12
  %117 = icmp sle i64 %94, %116
  %118 = and i1 %114, %117
  %119 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %112, i32 0, i32 1
  %120 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %112, i32 0, i32 2
  %121 = icmp sle i64 1, %102
  %122 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %119, i32 0, i32 0
  %123 = load i64, i64 addrspace(11)* %122, align 8, !alias.scope !9, !noalias !12
  %124 = icmp sle i64 %102, %123
  %125 = and i1 %121, %124
  %126 = icmp sle i64 1, %110
  %127 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %120, i32 0, i32 0
  %128 = load i64, i64 addrspace(11)* %127, align 8, !alias.scope !9, !noalias !12
  %129 = icmp sle i64 %110, %128
  %130 = and i1 %126, %129
  %131 = and i1 %118, %125
  %132 = and i1 %131, %130
  br label %L298

L298:                                             ; preds = %L278
  %133 = xor i1 %132, true
  br i1 %133, label %L738, label %L299

L299:                                             ; preds = %L298
  %134 = getelementptr inbounds { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 1
  %135 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !7
  %136 = add i32 %135, 1
  %137 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !7
  %138 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !7
  %139 = call i32 @llvm.amdgcn.workitem.id.x(), !range !8
  %140 = add i32 %139, 1
  %141 = call i32 @llvm.amdgcn.workitem.id.y(), !range !8
  %142 = call i32 @llvm.amdgcn.workitem.id.z(), !range !8
  %143 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %134, i32 0, i32 0
  %144 = zext i32 %136 to i64
  br label %L338

L338:                                             ; preds = %L299
  %145 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %143, i32 0, i32 0
  %146 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %145, i32 0, i32 0
  %147 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %146, i32 0, i32 0
  %148 = load i64, i64 addrspace(11)* %147, align 8, !alias.scope !9, !noalias !12
  %149 = icmp slt i64 %148, 0
  %150 = xor i1 %149, true
  %151 = load i64, i64 addrspace(11)* %147, align 8, !alias.scope !9, !noalias !12
  %152 = select i1 %150, i64 %151, i64 0
  %153 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %145, i32 0, i32 1
  %154 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %153, i32 0, i32 0
  %155 = load i64, i64 addrspace(11)* %154, align 8, !alias.scope !9, !noalias !12
  %156 = icmp slt i64 %155, 0
  %157 = xor i1 %156, true
  %158 = load i64, i64 addrspace(11)* %154, align 8, !alias.scope !9, !noalias !12
  %159 = select i1 %157, i64 %158, i64 0
  %160 = sub i64 %144, 1
  %161 = icmp ne i64 %160, -9223372036854775808
  %162 = icmp ne i64 %152, -1
  %163 = or i1 %162, %161
  %164 = icmp ne i64 %152, 0
  %165 = and i1 %164, %163
  br i1 %165, label %pass8, label %fail7

L392:                                             ; preds = %pass10
  %166 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %143, i32 0, i32 0
  %167 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %166, i32 0, i32 0
  br label %L403

L403:                                             ; preds = %L392
  br label %L404

L404:                                             ; preds = %L403
  br label %L405

L405:                                             ; preds = %L404
  %168 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %166, i32 0, i32 1
  %169 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %166, i32 0, i32 2
  br label %L416

L416:                                             ; preds = %L405
  br label %L417

L417:                                             ; preds = %L416
  br label %L418

L418:                                             ; preds = %L417
  br label %L427

L427:                                             ; preds = %L418
  br label %L428

L428:                                             ; preds = %L427
  br label %L429

L429:                                             ; preds = %L428
  br label %L430

L430:                                             ; preds = %L429
  br label %L431

L431:                                             ; preds = %L430
  br label %L432

L432:                                             ; preds = %L431
  br label %L433

L433:                                             ; preds = %L432
  br label %L434

L434:                                             ; preds = %L433
  %170 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %134, i32 0, i32 1
  %171 = zext i32 %140 to i64
  br label %L458

L458:                                             ; preds = %L434
  %172 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %170, i32 0, i32 0
  %173 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %172, i32 0, i32 0
  %174 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %173, i32 0, i32 0
  %175 = load i64, i64 addrspace(11)* %174, align 8, !alias.scope !9, !noalias !12
  %176 = icmp slt i64 %175, 0
  %177 = xor i1 %176, true
  %178 = load i64, i64 addrspace(11)* %174, align 8, !alias.scope !9, !noalias !12
  %179 = select i1 %177, i64 %178, i64 0
  %180 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %172, i32 0, i32 1
  %181 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %180, i32 0, i32 0
  %182 = load i64, i64 addrspace(11)* %181, align 8, !alias.scope !9, !noalias !12
  %183 = icmp slt i64 %182, 0
  %184 = xor i1 %183, true
  %185 = load i64, i64 addrspace(11)* %181, align 8, !alias.scope !9, !noalias !12
  %186 = select i1 %184, i64 %185, i64 0
  %187 = sub i64 %171, 1
  %188 = icmp ne i64 %187, -9223372036854775808
  %189 = icmp ne i64 %179, -1
  %190 = or i1 %189, %188
  %191 = icmp ne i64 %179, 0
  %192 = and i1 %191, %190
  br i1 %192, label %pass12, label %fail11

L512:                                             ; preds = %pass14
  %193 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %170, i32 0, i32 0
  %194 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %193, i32 0, i32 0
  br label %L523

L523:                                             ; preds = %L512
  br label %L524

L524:                                             ; preds = %L523
  br label %L525

L525:                                             ; preds = %L524
  %195 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %193, i32 0, i32 1
  %196 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %193, i32 0, i32 2
  br label %L536

L536:                                             ; preds = %L525
  br label %L537

L537:                                             ; preds = %L536
  br label %L538

L538:                                             ; preds = %L537
  br label %L547

L547:                                             ; preds = %L538
  br label %L548

L548:                                             ; preds = %L547
  br label %L549

L549:                                             ; preds = %L548
  br label %L550

L550:                                             ; preds = %L549
  br label %L551

L551:                                             ; preds = %L550
  br label %L552

L552:                                             ; preds = %L551
  br label %L553

L553:                                             ; preds = %L552
  br label %L554

L554:                                             ; preds = %L553
  %197 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %134, i32 0, i32 1
  %198 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %197, i32 0, i32 0
  %199 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %198, i32 0, i32 0
  %200 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %199, i32 0, i32 0
  %201 = sub i64 %318, 1
  %202 = load i64, i64 addrspace(11)* %200, align 8, !alias.scope !9, !noalias !12
  %203 = mul i64 %201, %202
  %204 = add i64 %203, %332
  %205 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %134, i32 0, i32 1
  %206 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %205, i32 0, i32 0
  %207 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %206, i32 0, i32 1
  %208 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %207, i32 0, i32 0
  %209 = sub i64 %327, 1
  %210 = load i64, i64 addrspace(11)* %208, align 8, !alias.scope !9, !noalias !12
  %211 = mul i64 %209, %210
  %212 = add i64 %211, %341
  %213 = getelementptr inbounds [2 x [1 x [3 x [1 x i64]]]], [2 x [1 x [3 x [1 x i64]]]] addrspace(11)* %134, i32 0, i32 1
  %214 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %213, i32 0, i32 0
  %215 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %214, i32 0, i32 2
  %216 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %215, i32 0, i32 0
  %217 = sub i64 %328, 1
  %218 = load i64, i64 addrspace(11)* %216, align 8, !alias.scope !9, !noalias !12
  %219 = mul i64 %217, %218
  %220 = add i64 %219, %342
  br label %L576

L576:                                             ; preds = %L554
  %221 = getelementptr inbounds { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] } addrspace(11)* %6, i32 0, i32 0
  %222 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(11)* %221, i32 0, i32 0
  %223 = getelementptr inbounds [1 x [3 x [1 x i64]]], [1 x [3 x [1 x i64]]] addrspace(5)* %17, i32 0, i32 0
  %224 = bitcast [3 x [1 x i64]] addrspace(5)* %223 to i8 addrspace(5)*
  %225 = bitcast [3 x [1 x i64]] addrspace(11)* %222 to i8 addrspace(11)*
  call void @llvm.memcpy.p5i8.p11i8.i64(i8 addrspace(5)* align 8 %224, i8 addrspace(11)* %225, i64 24, i1 false), !alias.scope !17, !noalias !18
  br label %L613

L613:                                             ; preds = %L576
  %226 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %222, i32 0, i32 0
  %227 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %226, i32 0, i32 0
  %228 = load i64, i64 addrspace(11)* %227, align 8, !alias.scope !9, !noalias !12
  %229 = icmp slt i64 %228, 0
  %230 = xor i1 %229, true
  %231 = load i64, i64 addrspace(11)* %227, align 8, !alias.scope !9, !noalias !12
  %232 = select i1 %230, i64 %231, i64 0
  %233 = getelementptr inbounds [3 x [1 x i64]], [3 x [1 x i64]] addrspace(11)* %222, i32 0, i32 1
  %234 = getelementptr inbounds [1 x i64], [1 x i64] addrspace(11)* %233, i32 0, i32 0
  %235 = load i64, i64 addrspace(11)* %234, align 8, !alias.scope !9, !noalias !12
  %236 = icmp slt i64 %235, 0
  %237 = xor i1 %236, true
  %238 = load i64, i64 addrspace(11)* %234, align 8, !alias.scope !9, !noalias !12
  %239 = select i1 %237, i64 %238, i64 0
  %240 = mul i64 1, %232
  %241 = sub i64 %204, 1
  %242 = mul i64 %241, 1
  %243 = add i64 1, %242
  %244 = mul i64 %240, %239
  %245 = sub i64 %212, 1
  %246 = mul i64 %245, %240
  %247 = add i64 %243, %246
  %248 = sub i64 %220, 1
  %249 = mul i64 %248, %244
  %250 = add i64 %247, %249
  br label %L653

L653:                                             ; preds = %L613
  br label %L654

L654:                                             ; preds = %L653
  br label %L655

L655:                                             ; preds = %L654
  br label %L656

L656:                                             ; preds = %L655
  br label %L657

L657:                                             ; preds = %L656
  %251 = sub i64 0, %2
  %252 = icmp sle i64 %251, %2
  %253 = xor i1 %252, true
  br i1 %253, label %L661, label %L660

L660:                                             ; preds = %L657
  br label %L663

L661:                                             ; preds = %L657
  %254 = sub i64 %251, 1
  br label %L663

L663:                                             ; preds = %L661, %L660
  %value_phi = phi i64 [ %2, %L660 ], [ %254, %L661 ]
  br label %L665

L665:                                             ; preds = %L663
  br label %L666

L666:                                             ; preds = %L665
  %255 = icmp slt i64 %value_phi, %251
  %256 = xor i1 %255, true
  br i1 %256, label %L669, label %L668

L668:                                             ; preds = %L666
  br label %L670

L669:                                             ; preds = %L666
  br label %L670

L670:                                             ; preds = %L669, %L668
  %value_phi15 = phi i8 [ 1, %L668 ], [ 0, %L669 ]
  %value_phi16 = phi i64 [ %251, %L669 ], [ undef, %L668 ]
  %257 = trunc i8 %value_phi15 to i1
  %258 = xor i1 %257, true
  %259 = xor i1 %258, true
  br i1 %259, label %L670.L717_crit_edge, label %L670.L674_crit_edge

L670.L717_crit_edge:                              ; preds = %L670
  br label %L717

L670.L674_crit_edge:                              ; preds = %L670
  br label %L674

L674:                                             ; preds = %L716, %L670.L674_crit_edge
  %value_phi17 = phi i64 [ %value_phi16, %L670.L674_crit_edge ], [ %value_phi27, %L716 ]
  %value_phi18 = phi double [ 0.000000e+00, %L670.L674_crit_edge ], [ %value_phi26, %L716 ]
  %260 = sub i64 0, %3
  %261 = icmp sle i64 %260, %3
  %262 = xor i1 %261, true
  br i1 %262, label %L680, label %L679

L679:                                             ; preds = %L674
  br label %L682

L680:                                             ; preds = %L674
  %263 = sub i64 %260, 1
  br label %L682

L682:                                             ; preds = %L680, %L679
  %value_phi19 = phi i64 [ %3, %L679 ], [ %263, %L680 ]
  br label %L684

L684:                                             ; preds = %L682
  br label %L685

L685:                                             ; preds = %L684
  %264 = icmp slt i64 %value_phi19, %260
  %265 = xor i1 %264, true
  br i1 %265, label %L688, label %L687

L687:                                             ; preds = %L685
  br label %L689

L688:                                             ; preds = %L685
  br label %L689

L689:                                             ; preds = %L688, %L687
  %value_phi20 = phi i8 [ 1, %L687 ], [ 0, %L688 ]
  %value_phi21 = phi i64 [ %260, %L688 ], [ undef, %L687 ]
  %266 = trunc i8 %value_phi20 to i1
  %267 = xor i1 %266, true
  %268 = xor i1 %267, true
  br i1 %268, label %L689.L706_crit_edge, label %L689.L693_crit_edge

L689.L706_crit_edge:                              ; preds = %L689
  br label %L706

L689.L693_crit_edge:                              ; preds = %L689
  br label %L693

L693:                                             ; preds = %L705, %L689.L693_crit_edge
  %value_phi22 = phi double [ %value_phi18, %L689.L693_crit_edge ], [ %269, %L705 ]
  %value_phi23 = phi i64 [ %value_phi21, %L689.L693_crit_edge ], [ %value_phi24, %L705 ]
  %269 = fadd double %value_phi22, 2.000000e+00
  %270 = icmp eq i64 %value_phi23, %value_phi19
  %271 = xor i1 %270, true
  br i1 %271, label %L699, label %L698

L698:                                             ; preds = %L693
  br label %L701

L699:                                             ; preds = %L693
  %272 = add i64 %value_phi23, 1
  br label %L701

L701:                                             ; preds = %L699, %L698
  %value_phi24 = phi i64 [ %272, %L699 ], [ undef, %L698 ]
  %value_phi25 = phi i8 [ 1, %L698 ], [ 0, %L699 ]
  %273 = trunc i8 %value_phi25 to i1
  %274 = xor i1 %273, true
  %275 = xor i1 %274, true
  br i1 %275, label %L701.L706_crit_edge, label %L705

L701.L706_crit_edge:                              ; preds = %L701
  br label %L706

L705:                                             ; preds = %L701
  br label %L693

L706:                                             ; preds = %L701.L706_crit_edge, %L689.L706_crit_edge
  %value_phi26 = phi double [ %269, %L701.L706_crit_edge ], [ %value_phi18, %L689.L706_crit_edge ]
  %276 = icmp eq i64 %value_phi17, %value_phi
  %277 = xor i1 %276, true
  br i1 %277, label %L710, label %L709

L709:                                             ; preds = %L706
  br label %L712

L710:                                             ; preds = %L706
  %278 = add i64 %value_phi17, 1
  br label %L712

L712:                                             ; preds = %L710, %L709
  %value_phi27 = phi i64 [ %278, %L710 ], [ undef, %L709 ]
  %value_phi28 = phi i8 [ 1, %L709 ], [ 0, %L710 ]
  %279 = trunc i8 %value_phi28 to i1
  %280 = xor i1 %279, true
  %281 = xor i1 %280, true
  br i1 %281, label %L712.L717_crit_edge, label %L716

L712.L717_crit_edge:                              ; preds = %L712
  br label %L717

L716:                                             ; preds = %L712
  br label %L674

L717:                                             ; preds = %L712.L717_crit_edge, %L670.L717_crit_edge
  %value_phi29 = phi double [ %value_phi26, %L712.L717_crit_edge ], [ 0.000000e+00, %L670.L717_crit_edge ]
  br label %L732

L732:                                             ; preds = %L717
  %282 = getelementptr inbounds { [3 x i64], i8 addrspace(1)*, i64 }, { [3 x i64], i8 addrspace(1)*, i64 } addrspace(11)* %8, i32 0, i32 1
  %283 = sub i64 %250, 1
  %284 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(11)* %282, align 8, !alias.scope !9, !noalias !12
  %285 = bitcast i8 addrspace(1)* %284 to double addrspace(1)*
  %286 = getelementptr inbounds double, double addrspace(1)* %285, i64 %283
  store double %value_phi29, double addrspace(1)* %286, align 8, !tbaa !19
  br label %L737

L737:                                             ; preds = %L732
  br label %L738

L738:                                             ; preds = %L737, %L298
  ret void

fail:                                             ; preds = %L40
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass:                                             ; preds = %L40
  %287 = sdiv i64 %50, %42
  %288 = mul i64 %42, %287
  %289 = sub i64 %50, %288
  %290 = add i64 %289, 1
  %291 = icmp ne i64 %287, -9223372036854775808
  %292 = icmp ne i64 %49, -1
  %293 = or i1 %292, %291
  %294 = icmp ne i64 %49, 0
  %295 = and i1 %294, %293
  br i1 %295, label %pass2, label %fail1

fail1:                                            ; preds = %pass
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass2:                                            ; preds = %pass
  %296 = sdiv i64 %287, %49
  %297 = mul i64 %49, %296
  %298 = sub i64 %287, %297
  %299 = add i64 %298, 1
  %300 = add i64 %296, 1
  br label %L94

fail3:                                            ; preds = %L160
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass4:                                            ; preds = %L160
  %301 = sdiv i64 %77, %69
  %302 = mul i64 %69, %301
  %303 = sub i64 %77, %302
  %304 = add i64 %303, 1
  %305 = icmp ne i64 %301, -9223372036854775808
  %306 = icmp ne i64 %76, -1
  %307 = or i1 %306, %305
  %308 = icmp ne i64 %76, 0
  %309 = and i1 %308, %307
  br i1 %309, label %pass6, label %fail5

fail5:                                            ; preds = %pass4
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass6:                                            ; preds = %pass4
  %310 = sdiv i64 %301, %76
  %311 = mul i64 %76, %310
  %312 = sub i64 %301, %311
  %313 = add i64 %312, 1
  %314 = add i64 %310, 1
  br label %L214

fail7:                                            ; preds = %L338
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass8:                                            ; preds = %L338
  %315 = sdiv i64 %160, %152
  %316 = mul i64 %152, %315
  %317 = sub i64 %160, %316
  %318 = add i64 %317, 1
  %319 = icmp ne i64 %315, -9223372036854775808
  %320 = icmp ne i64 %159, -1
  %321 = or i1 %320, %319
  %322 = icmp ne i64 %159, 0
  %323 = and i1 %322, %321
  br i1 %323, label %pass10, label %fail9

fail9:                                            ; preds = %pass8
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass10:                                           ; preds = %pass8
  %324 = sdiv i64 %315, %159
  %325 = mul i64 %159, %324
  %326 = sub i64 %315, %325
  %327 = add i64 %326, 1
  %328 = add i64 %324, 1
  br label %L392

fail11:                                           ; preds = %L458
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass12:                                           ; preds = %L458
  %329 = sdiv i64 %187, %179
  %330 = mul i64 %179, %329
  %331 = sub i64 %187, %330
  %332 = add i64 %331, 1
  %333 = icmp ne i64 %329, -9223372036854775808
  %334 = icmp ne i64 %186, -1
  %335 = or i1 %334, %333
  %336 = icmp ne i64 %186, 0
  %337 = and i1 %336, %335
  br i1 %337, label %pass14, label %fail13

fail13:                                           ; preds = %pass12
  call fastcc void @gpu_signal_exception()
  call void @llvm.trap()
  unreachable

pass14:                                           ; preds = %pass12
  %338 = sdiv i64 %329, %186
  %339 = mul i64 %186, %338
  %340 = sub i64 %329, %339
  %341 = add i64 %340, 1
  %342 = add i64 %338, 1
  br label %L512
}

; Function Attrs: alwaysinline
define internal fastcc void @gpu_signal_exception() unnamed_addr #4 {
top:
  %0 = alloca { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, align 8, addrspace(5)
  %1 = call {}*** @julia.get_pgcstack()
  %2 = bitcast {}*** %1 to {}**
  %current_task = getelementptr inbounds {}*, {}** %2, i64 -14
  %3 = bitcast {}** %current_task to i64*
  %world_age = getelementptr inbounds i64, i64* %3, i64 15
  %state.i = call { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter()
  store { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } %state.i, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, align 8
  %4 = getelementptr inbounds { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 }, { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } addrspace(5)* %0, i32 0, i32 0
  %5 = bitcast i64 addrspace(5)* %4 to i8* addrspace(5)*
  %6 = load i8*, i8* addrspace(5)* %5, align 8, !tbaa !22, !alias.scope !26, !noalias !27
  %7 = getelementptr inbounds i8, i8* %6, i64 0
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32 addrspace(1)* @_j_const1, align 1, !tbaa !28, !alias.scope !32, !noalias !33
  store i32 %9, i32* %8, align 1
  call void @llvm.amdgcn.endpgm()
  unreachable
}

; Function Attrs: readnone
declare { i64, i64, i64, i64, i64, i64, i32, i32, i64, i64, i64, i64 } @julia.gpu.state_getter() local_unnamed_addr #5

; Function Attrs: cold noreturn nounwind
declare void @llvm.amdgcn.endpgm() #1

attributes #0 = { argmemonly nocallback nofree nounwind willreturn }
attributes #1 = { cold noreturn nounwind }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { "amdgpu-unsafe-fp-atomics"="true" "target-cpu"="gfx1100" "target-features"="+wavefrontsize32,-wavefrontsize64" }
attributes #4 = { alwaysinline }
attributes #5 = { readnone }

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
!6 = !{void ({ [1 x [3 x [1 x i64]]], [2 x [1 x [3 x [1 x i64]]]] }, { [3 x i64], i8 addrspace(1)*, i64 }, i64, i64, i64)* @_Z14gpu_kernel_xx_16CompilerMetadataI11DynamicSize12DynamicCheckv16CartesianIndicesILl3E5TupleI5OneToI5Int64ES4_IS5_ES4_IS5_EEE7NDRangeILl3ES0_S0_S2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEES2_ILl3ES3_IS4_IS5_ES4_IS5_ES4_IS5_EEEEE14ROCDeviceArrayI7Float64Ll3ELl1EES5_S5_S5_}
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
!17 = !{!10, !14}
!18 = !{!13, !15, !16}
!19 = !{!20, !20, i64 0, i64 0}
!20 = !{!"custom_tbaa_addrspace(1)", !21, i64 0}
!21 = !{!"custom_tbaa"}
!22 = !{!23, !23, i64 0}
!23 = !{!"jtbaa_stack", !24, i64 0}
!24 = !{!"jtbaa", !25, i64 0}
!25 = !{!"jtbaa"}
!26 = !{!14}
!27 = !{!13, !15, !16, !10}
!28 = !{!29, !29, i64 0}
!29 = !{!"jtbaa_immut", !30, i64 0}
!30 = !{!"jtbaa_value", !31, i64 0}
!31 = !{!"jtbaa_data", !24, i64 0}
!32 = !{!15}
!33 = !{!13, !14, !16, !10}
