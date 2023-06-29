; ModuleID = 'start'
source_filename = "start"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:10:11:12:13"
target triple = "amdgcn-amd-amdhsa"

%0 = type { i32, i32, i32, i32, i32, i32, i32, i32 }
%1 = type { i32, i32, i32, i32, i32, i32, i32, i32 }
%2 = type { %3 addrspace(1)*, %4 addrspace(1)*, %5, i64, i64, i64 }
%3 = type { i64, i64, i32, i32 }
%4 = type { [64 x [8 x i64]] }
%5 = type { i64 }
%6 = type { i64, %5, i64, i32, i32, i64, i64, %7, [2 x i32] }
%7 = type { %8 addrspace(1)* }
%8 = type { %9, [4 x i32], i64, i32, i32, i32, i32, i64, i32, [9 x i32], i64, i32, i32, [4 x i32], i64, i64, i32, i32, [2 x i32], %5, [14 x i32] }
%9 = type { i32, i32, i8 addrspace(1)*, %5, i32, i32, i64 }
%10 = type { [16 x %11], [16 x %11], [16 x %11], [16 x %12], [16 x %12], [16 x [256 x %13]], i64, i64, [14 x i64], i64 }
%11 = type { i32, [15 x i64] }
%12 = type { i64, [15 x i64] }
%13 = type { i64, i64, i32 }
%14 = type { i32, i32, i32, i32, [524284 x i32] }

@0 = internal unnamed_addr addrspace(4) constant [16 x %0] [%1 { i32 130054, i32 129546, i32 110114, i32 16288, i32 6, i32 256, i32 0, i32 4195 }, %1 { i32 86927, i32 86758, i32 73744, i32 10904, i32 399, i32 512, i32 0, i32 2804 }, %1 { i32 65280, i32 64770, i32 55054, i32 8192, i32 0, i32 128, i32 0, i32 2107 }, %1 { i32 43576, i32 43406, i32 36895, i32 5504, i32 56, i32 256, i32 0, i32 1405 }, %1 { i32 32703, i32 32193, i32 27364, i32 4160, i32 63, i32 64, i32 0, i32 1054 }, %1 { i32 21816, i32 21646, i32 18399, i32 2816, i32 56, i32 128, i32 0, i32 703 }, %1 { i32 16367, i32 15856, i32 13477, i32 2176, i32 15, i32 32, i32 32768, i32 527 }, %1 { i32 10915, i32 10745, i32 9133, i32 1472, i32 35, i32 64, i32 0, i32 352 }, %1 { i32 8187, i32 7676, i32 6524, i32 1280, i32 11, i32 16, i32 134219776, i32 265 }, %1 { i32 5459, i32 5289, i32 4495, i32 896, i32 19, i32 32, i32 524288, i32 176 }, %1 { i32 4094, i32 3583, i32 3045, i32 1024, i32 6, i32 8, i32 1077952576, i32 133 }, %1 { i32 2730, i32 2560, i32 2176, i32 512, i32 10, i32 16, i32 67109888, i32 89 }, %1 { i32 2047, i32 1536, i32 1305, i32 1024, i32 3, i32 4, i32 -2004318072, i32 66 }, %1 { i32 1365, i32 1195, i32 1015, i32 512, i32 5, i32 8, i32 538976288, i32 44 }, %1 { i32 1023, i32 512, i32 435, i32 2048, i32 1, i32 2, i32 -1431655766, i32 34 }, %1 { i32 682, i32 512, i32 435, i32 2048, i32 2, i32 4, i32 1145324612, i32 35 }], align 4

; Function Attrs: alwaysinline nounwind readnone speculatable willreturn
declare align 4 i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr() #0

; Function Attrs: convergent noinline norecurse nounwind optnone
define internal fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %0, i32 noundef %1, i64 noundef %2, i64 noundef %3, i64 noundef %4, i64 noundef %5, i64 noundef %6, i64 noundef %7, i64 noundef %8, i64 noundef %9) unnamed_addr #1 {
  %11 = alloca i8*, align 8, addrspace(5)
  %12 = alloca i32, align 4, addrspace(5)
  %13 = alloca i64, align 8, addrspace(5)
  %14 = alloca i64, align 8, addrspace(5)
  %15 = alloca i64, align 8, addrspace(5)
  %16 = alloca i64, align 8, addrspace(5)
  %17 = alloca i64, align 8, addrspace(5)
  %18 = alloca i64, align 8, addrspace(5)
  %19 = alloca i64, align 8, addrspace(5)
  %20 = alloca i64, align 8, addrspace(5)
  %21 = alloca i32, align 4, addrspace(5)
  %22 = alloca i32, align 4, addrspace(5)
  %23 = alloca %2 addrspace(1)*, align 8, addrspace(5)
  %24 = alloca i64, align 8, addrspace(5)
  %25 = alloca %3 addrspace(1)*, align 8, addrspace(5)
  %26 = alloca %4 addrspace(1)*, align 8, addrspace(5)
  %27 = alloca <2 x i64>, align 16, addrspace(5)
  store i8* %0, i8* addrspace(5)* %11, align 8, !tbaa !9
  store i32 %1, i32 addrspace(5)* %12, align 4, !tbaa !13
  store i64 %2, i64 addrspace(5)* %13, align 8, !tbaa !15
  store i64 %3, i64 addrspace(5)* %14, align 8, !tbaa !15
  store i64 %4, i64 addrspace(5)* %15, align 8, !tbaa !15
  store i64 %5, i64 addrspace(5)* %16, align 8, !tbaa !15
  store i64 %6, i64 addrspace(5)* %17, align 8, !tbaa !15
  store i64 %7, i64 addrspace(5)* %18, align 8, !tbaa !15
  store i64 %8, i64 addrspace(5)* %19, align 8, !tbaa !15
  store i64 %9, i64 addrspace(5)* %20, align 8, !tbaa !15
  %28 = bitcast i32 addrspace(5)* %21 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 4, i8 addrspace(5)* %28) #12
  %29 = call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #12
  %30 = call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %29) #12
  store i32 %30, i32 addrspace(5)* %21, align 4, !tbaa !13
  %31 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %32 = call i32 asm sideeffect "; ockl readfirstlane hoisting hack $0", "=v,0"(i32 %31) #13, !srcloc !17
  store i32 %32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %33 = bitcast i32 addrspace(5)* %22 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 4, i8 addrspace(5)* %33) #12
  %34 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %35 = call i32 @llvm.amdgcn.readfirstlane(i32 %34)
  store i32 %35, i32 addrspace(5)* %22, align 4, !tbaa !13
  %36 = bitcast %2 addrspace(1)* addrspace(5)* %23 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %36) #12
  %37 = load i8*, i8* addrspace(5)* %11, align 8, !tbaa !9
  %38 = addrspacecast i8* %37 to %2 addrspace(1)*
  store %2 addrspace(1)* %38, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %39 = bitcast i64 addrspace(5)* %24 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %39) #12
  %40 = load %2 addrspace(1)*, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %41 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %42 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !13
  %43 = icmp eq i32 %41, %42
  br i1 %43, label %44, label %.exit3

44:                                               ; preds = %10
  %45 = getelementptr inbounds %2, %2 addrspace(1)* %40, i64 0, i32 3
  %46 = load atomic i64, i64 addrspace(1)* %45 syncscope("one-as") acquire, align 8
  %47 = getelementptr %2, %2 addrspace(1)* %40, i64 0, i32 0
  %48 = getelementptr %2, %2 addrspace(1)* %40, i64 0, i32 5
  %49 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %47, align 8, !tbaa !18
  %50 = load i64, i64 addrspace(1)* %48, align 8, !tbaa !21
  %51 = and i64 %50, %46
  %52 = getelementptr inbounds %3, %3 addrspace(1)* %49, i64 %51, i32 0
  %53 = load atomic i64, i64 addrspace(1)* %52 syncscope("one-as") monotonic, align 8
  %54 = cmpxchg i64 addrspace(1)* %45, i64 %46, i64 %53 syncscope("one-as") acquire monotonic, align 8
  %55 = extractvalue { i64, i1 } %54, 1
  br i1 %55, label %66, label %.preheader6

.preheader6:                                      ; preds = %44
  br label %56

56:                                               ; preds = %56, %.preheader6
  %57 = phi { i64, i1 } [ %64, %56 ], [ %54, %.preheader6 ]
  %58 = extractvalue { i64, i1 } %57, 0
  call void @llvm.amdgcn.s.sleep(i32 1) #12
  %59 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %47, align 8, !tbaa !18
  %60 = load i64, i64 addrspace(1)* %48, align 8, !tbaa !21
  %61 = and i64 %60, %58
  %62 = getelementptr inbounds %3, %3 addrspace(1)* %59, i64 %61, i32 0
  %63 = load atomic i64, i64 addrspace(1)* %62 syncscope("one-as") monotonic, align 8
  %64 = cmpxchg i64 addrspace(1)* %45, i64 %58, i64 %63 syncscope("one-as") acquire monotonic, align 8
  %65 = extractvalue { i64, i1 } %64, 1
  br i1 %65, label %.loopexit7, label %56

.loopexit7:                                       ; preds = %56
  %.lcssa = phi { i64, i1 } [ %64, %56 ]
  br label %66

66:                                               ; preds = %.loopexit7, %44
  %67 = phi { i64, i1 } [ %54, %44 ], [ %.lcssa, %.loopexit7 ]
  %68 = extractvalue { i64, i1 } %67, 0
  br label %.exit3

.exit3:                                           ; preds = %66, %10
  %69 = phi i64 [ %68, %66 ], [ 0, %10 ]
  %70 = trunc i64 %69 to i32
  %71 = lshr i64 %69, 32
  %72 = trunc i64 %71 to i32
  %73 = call i32 @llvm.amdgcn.readfirstlane(i32 %70) #12
  %74 = call i32 @llvm.amdgcn.readfirstlane(i32 %72) #12
  %75 = zext i32 %74 to i64
  %76 = shl nuw i64 %75, 32
  %77 = zext i32 %73 to i64
  %78 = or i64 %76, %77
  store i64 %78, i64 addrspace(5)* %24, align 8, !tbaa !15
  %79 = bitcast %3 addrspace(1)* addrspace(5)* %25 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %79) #12
  %80 = load %2 addrspace(1)*, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %81 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !15
  %82 = getelementptr %2, %2 addrspace(1)* %80, i64 0, i32 0
  %83 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %82, align 8, !tbaa !18
  %84 = getelementptr %2, %2 addrspace(1)* %80, i64 0, i32 5
  %85 = load i64, i64 addrspace(1)* %84, align 8, !tbaa !21
  %86 = and i64 %81, %85
  %87 = getelementptr inbounds %3, %3 addrspace(1)* %83, i64 %86
  store %3 addrspace(1)* %87, %3 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !9
  %88 = bitcast %4 addrspace(1)* addrspace(5)* %26 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 8, i8 addrspace(5)* %88) #12
  %89 = load %2 addrspace(1)*, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %90 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !15
  %91 = getelementptr %2, %2 addrspace(1)* %89, i64 0, i32 1
  %92 = load %4 addrspace(1)*, %4 addrspace(1)* addrspace(1)* %91, align 8, !tbaa !22
  %93 = getelementptr %2, %2 addrspace(1)* %89, i64 0, i32 5
  %94 = load i64, i64 addrspace(1)* %93, align 8, !tbaa !21
  %95 = and i64 %90, %94
  %96 = getelementptr inbounds %4, %4 addrspace(1)* %92, i64 %95
  store %4 addrspace(1)* %96, %4 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !9
  %97 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !9
  %98 = load %4 addrspace(1)*, %4 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !9
  %99 = load i32, i32 addrspace(5)* %12, align 4, !tbaa !13
  %100 = load i64, i64 addrspace(5)* %13, align 8, !tbaa !15
  %101 = load i64, i64 addrspace(5)* %14, align 8, !tbaa !15
  %102 = load i64, i64 addrspace(5)* %15, align 8, !tbaa !15
  %103 = load i64, i64 addrspace(5)* %16, align 8, !tbaa !15
  %104 = load i64, i64 addrspace(5)* %17, align 8, !tbaa !15
  %105 = load i64, i64 addrspace(5)* %18, align 8, !tbaa !15
  %106 = load i64, i64 addrspace(5)* %19, align 8, !tbaa !15
  %107 = load i64, i64 addrspace(5)* %20, align 8, !tbaa !15
  %108 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %109 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !13
  %110 = call i64 @llvm.read_register.i64(metadata !23) #13
  %111 = icmp eq i32 %108, %109
  br i1 %111, label %112, label %.exit4

112:                                              ; preds = %.exit3
  %113 = getelementptr inbounds %3, %3 addrspace(1)* %97, i64 0, i32 3
  %114 = getelementptr inbounds %3, %3 addrspace(1)* %97, i64 0, i32 1
  %115 = getelementptr inbounds %3, %3 addrspace(1)* %97, i64 0, i32 2
  store i32 %99, i32 addrspace(1)* %115, align 8, !tbaa !24
  store i64 %110, i64 addrspace(1)* %114, align 8, !tbaa !26
  store i32 1, i32 addrspace(1)* %113, align 4, !tbaa !27
  br label %.exit4

.exit4:                                           ; preds = %112, %.exit3
  %116 = zext i32 %108 to i64
  %117 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 0
  store i64 %100, i64 addrspace(1)* %117, align 8, !tbaa !15
  %118 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 1
  store i64 %101, i64 addrspace(1)* %118, align 8, !tbaa !15
  %119 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 2
  store i64 %102, i64 addrspace(1)* %119, align 8, !tbaa !15
  %120 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 3
  store i64 %103, i64 addrspace(1)* %120, align 8, !tbaa !15
  %121 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 4
  store i64 %104, i64 addrspace(1)* %121, align 8, !tbaa !15
  %122 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 5
  store i64 %105, i64 addrspace(1)* %122, align 8, !tbaa !15
  %123 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 6
  store i64 %106, i64 addrspace(1)* %123, align 8, !tbaa !15
  %124 = getelementptr inbounds %4, %4 addrspace(1)* %98, i64 0, i32 0, i64 %116, i64 7
  store i64 %107, i64 addrspace(1)* %124, align 8, !tbaa !15
  %125 = load %2 addrspace(1)*, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %126 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !15
  %127 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %128 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !13
  %129 = icmp eq i32 %127, %128
  br i1 %129, label %130, label %.exit2

130:                                              ; preds = %.exit4
  %131 = getelementptr inbounds %2, %2 addrspace(1)* %125, i64 0, i32 4
  %132 = load atomic i64, i64 addrspace(1)* %131 syncscope("one-as") monotonic, align 8
  %133 = getelementptr %2, %2 addrspace(1)* %125, i64 0, i32 0
  %134 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %133, align 8, !tbaa !18
  %135 = getelementptr %2, %2 addrspace(1)* %125, i64 0, i32 5
  %136 = load i64, i64 addrspace(1)* %135, align 8, !tbaa !21
  %137 = and i64 %136, %126
  %138 = getelementptr inbounds %3, %3 addrspace(1)* %134, i64 %137, i32 0
  store i64 %132, i64 addrspace(1)* %138, align 8, !tbaa !28
  %139 = cmpxchg i64 addrspace(1)* %131, i64 %132, i64 %126 syncscope("one-as") release monotonic, align 8
  %140 = extractvalue { i64, i1 } %139, 1
  br i1 %140, label %146, label %.preheader5

.preheader5:                                      ; preds = %130
  br label %141

141:                                              ; preds = %141, %.preheader5
  %142 = phi { i64, i1 } [ %144, %141 ], [ %139, %.preheader5 ]
  %143 = extractvalue { i64, i1 } %142, 0
  call void @llvm.amdgcn.s.sleep(i32 1) #12
  store i64 %143, i64 addrspace(1)* %138, align 8, !tbaa !28
  %144 = cmpxchg i64 addrspace(1)* %131, i64 %143, i64 %126 syncscope("one-as") release monotonic, align 8
  %145 = extractvalue { i64, i1 } %144, 1
  br i1 %145, label %.loopexit, label %141

.loopexit:                                        ; preds = %141
  br label %146

146:                                              ; preds = %.loopexit, %130
  %147 = getelementptr inbounds %2, %2 addrspace(1)* %125, i64 0, i32 2, i32 0
  %148 = load i64, i64 addrspace(1)* %147, align 8
  call fastcc void @__ockl_hsa_signal_add(i64 %148, i64 noundef 1, i32 noundef 3) #13
  br label %.exit2

.exit2:                                           ; preds = %146, %.exit4
  %149 = bitcast <2 x i64> addrspace(5)* %27 to i8 addrspace(5)*
  call void @llvm.lifetime.start.p5i8(i64 16, i8 addrspace(5)* %149) #12
  %150 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(5)* %25, align 8, !tbaa !9
  %151 = load %4 addrspace(1)*, %4 addrspace(1)* addrspace(5)* %26, align 8, !tbaa !9
  %152 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %153 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !13
  %154 = icmp eq i32 %152, %153
  %155 = getelementptr inbounds %3, %3 addrspace(1)* %150, i64 0, i32 3
  br label %156

156:                                              ; preds = %164, %.exit2
  br i1 %154, label %157, label %160

157:                                              ; preds = %156
  %158 = load atomic i32, i32 addrspace(1)* %155 syncscope("one-as") acquire, align 4
  %159 = and i32 %158, 1
  br label %160

160:                                              ; preds = %157, %156
  %161 = phi i32 [ %159, %157 ], [ 1, %156 ]
  %162 = call i32 @llvm.amdgcn.readfirstlane(i32 %161) #12
  %163 = icmp eq i32 %162, 0
  br i1 %163, label %.exit1, label %164

164:                                              ; preds = %160
  call void @llvm.amdgcn.s.sleep(i32 1) #12
  br label %156

.exit1:                                           ; preds = %160
  %165 = zext i32 %152 to i64
  %166 = getelementptr inbounds %4, %4 addrspace(1)* %151, i64 0, i32 0, i64 %165, i64 0
  %167 = getelementptr inbounds %4, %4 addrspace(1)* %151, i64 0, i32 0, i64 %165, i64 1
  %168 = load i64, i64 addrspace(1)* %166, align 8, !tbaa !15
  %169 = load i64, i64 addrspace(1)* %167, align 8, !tbaa !15
  %170 = insertelement <2 x i64> undef, i64 %168, i64 0
  %171 = insertelement <2 x i64> %170, i64 %169, i64 1
  store <2 x i64> %171, <2 x i64> addrspace(5)* %27, align 16, !tbaa !29
  %172 = load %2 addrspace(1)*, %2 addrspace(1)* addrspace(5)* %23, align 8, !tbaa !9
  %173 = load i64, i64 addrspace(5)* %24, align 8, !tbaa !15
  %174 = load i32, i32 addrspace(5)* %21, align 4, !tbaa !13
  %175 = load i32, i32 addrspace(5)* %22, align 4, !tbaa !13
  %176 = icmp eq i32 %174, %175
  br i1 %176, label %177, label %.exit

177:                                              ; preds = %.exit1
  %178 = getelementptr inbounds %2, %2 addrspace(1)* %172, i64 0, i32 5
  %179 = load i64, i64 addrspace(1)* %178, align 8, !tbaa !21
  %180 = add i64 %179, 1
  %181 = add i64 %180, %173
  %182 = icmp eq i64 %181, 0
  %183 = select i1 %182, i64 %180, i64 %181
  %184 = getelementptr inbounds %2, %2 addrspace(1)* %172, i64 0, i32 3
  %185 = load atomic i64, i64 addrspace(1)* %184 syncscope("one-as") monotonic, align 8
  %186 = getelementptr %2, %2 addrspace(1)* %172, i64 0, i32 0
  %187 = load %3 addrspace(1)*, %3 addrspace(1)* addrspace(1)* %186, align 8, !tbaa !18
  %188 = and i64 %183, %179
  %189 = getelementptr inbounds %3, %3 addrspace(1)* %187, i64 %188, i32 0
  store i64 %185, i64 addrspace(1)* %189, align 8, !tbaa !28
  %190 = cmpxchg i64 addrspace(1)* %184, i64 %185, i64 %183 syncscope("one-as") release monotonic, align 8
  %191 = extractvalue { i64, i1 } %190, 1
  br i1 %191, label %.exit, label %.preheader

.preheader:                                       ; preds = %177
  br label %192

192:                                              ; preds = %192, %.preheader
  %193 = phi { i64, i1 } [ %195, %192 ], [ %190, %.preheader ]
  %194 = extractvalue { i64, i1 } %193, 0
  call void @llvm.amdgcn.s.sleep(i32 1) #12
  store i64 %194, i64 addrspace(1)* %189, align 8, !tbaa !28
  %195 = cmpxchg i64 addrspace(1)* %184, i64 %194, i64 %183 syncscope("one-as") release monotonic, align 8
  %196 = extractvalue { i64, i1 } %195, 1
  br i1 %196, label %.exit.loopexit, label %192

.exit.loopexit:                                   ; preds = %192
  br label %.exit

.exit:                                            ; preds = %.exit.loopexit, %177, %.exit1
  %197 = load <2 x i64>, <2 x i64> addrspace(5)* %27, align 16, !tbaa !29
  %198 = bitcast <2 x i64> addrspace(5)* %27 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 16, i8 addrspace(5)* %198) #12
  %199 = bitcast %4 addrspace(1)* addrspace(5)* %26 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %199) #12
  %200 = bitcast %3 addrspace(1)* addrspace(5)* %25 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %200) #12
  %201 = bitcast i64 addrspace(5)* %24 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %201) #12
  %202 = bitcast %2 addrspace(1)* addrspace(5)* %23 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 8, i8 addrspace(5)* %202) #12
  %203 = bitcast i32 addrspace(5)* %22 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 4, i8 addrspace(5)* %203) #12
  %204 = bitcast i32 addrspace(5)* %21 to i8 addrspace(5)*
  call void @llvm.lifetime.end.p5i8(i64 4, i8 addrspace(5)* %204) #12
  ret <2 x i64> %197
}

; Function Attrs: alwaysinline argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #2

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readfirstlane(i32) #3

; Function Attrs: alwaysinline argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p5i8(i64 immarg, i8 addrspace(5)* nocapture) #2

; Function Attrs: alwaysinline nounwind willreturn
declare void @llvm.amdgcn.s.sleep(i32 immarg) #4

; Function Attrs: convergent norecurse nounwind
define internal fastcc void @__ockl_hsa_signal_add(i64 %0, i64 noundef %1, i32 noundef %2) unnamed_addr #5 {
  %4 = inttoptr i64 %0 to %6 addrspace(1)*
  %5 = getelementptr inbounds %6, %6 addrspace(1)* %4, i64 0, i32 1, i32 0
  switch i32 %2, label %6 [
    i32 1, label %8
    i32 2, label %8
    i32 3, label %10
    i32 4, label %12
    i32 5, label %14
  ]

6:                                                ; preds = %3
  %7 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") monotonic, align 8
  br label %16

8:                                                ; preds = %3, %3
  %9 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") acquire, align 8
  br label %16

10:                                               ; preds = %3
  %11 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") release, align 8
  br label %16

12:                                               ; preds = %3
  %13 = atomicrmw add i64 addrspace(1)* %5, i64 %1 syncscope("one-as") acq_rel, align 8
  br label %16

14:                                               ; preds = %3
  %15 = atomicrmw add i64 addrspace(1)* %5, i64 %1 seq_cst, align 8
  br label %16

16:                                               ; preds = %14, %12, %10, %8, %6
  %17 = getelementptr inbounds %6, %6 addrspace(1)* %4, i64 0, i32 2
  %18 = load i64, i64 addrspace(1)* %17, align 16, !tbaa !30
  %19 = icmp eq i64 %18, 0
  br i1 %19, label %27, label %20

20:                                               ; preds = %16
  %21 = inttoptr i64 %18 to i64 addrspace(1)*
  %22 = getelementptr inbounds %6, %6 addrspace(1)* %4, i64 0, i32 3
  %23 = load i32, i32 addrspace(1)* %22, align 8, !tbaa !32
  %24 = zext i32 %23 to i64
  store atomic i64 %24, i64 addrspace(1)* %21 syncscope("one-as") release, align 8
  %25 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %23)
  %26 = and i32 %25, 255
  tail call void @llvm.amdgcn.s.sendmsg(i32 1, i32 %26)
  br label %27

27:                                               ; preds = %20, %16
  ret void
}

; Function Attrs: alwaysinline nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg, i32) #6

; Function Attrs: alwaysinline nounwind readonly
declare i64 @llvm.read_register.i64(metadata) #7

; Function Attrs: alwaysinline nounwind readnone willreturn
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #8

; Function Attrs: alwaysinline nounwind readnone willreturn
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32) #8

; Function Attrs: convergent noinline norecurse nounwind
define internal fastcc void @__ockl_dm_alloc(i64 noundef %0) unnamed_addr #9 {
  %2 = icmp eq i64 %0, 0
  br i1 %2, label %.loopexit88, label %3

3:                                                ; preds = %1
  %4 = icmp ugt i64 %0, 3072
  br i1 %4, label %5, label %32

5:                                                ; preds = %3
  %6 = tail call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr() #12
  %7 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 80
  %8 = bitcast i8 addrspace(4)* %7 to i64 addrspace(4)*
  %9 = load i64, i64 addrspace(4)* %8, align 8, !tbaa !15
  %10 = inttoptr i64 %9 to i8 addrspace(1)*
  %11 = addrspacecast i8 addrspace(1)* %10 to i8*
  %12 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %11, i32 noundef 3, i64 noundef 0, i64 noundef %0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  %13 = extractelement <2 x i64> %12, i64 0
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %30, label %15

15:                                               ; preds = %5
  %16 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %17 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %18 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %17, i32 0) #12
  %19 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %16, i32 %18) #12
  %20 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %21 = icmp eq i32 %19, 0
  br i1 %21, label %22, label %30

22:                                               ; preds = %15
  %23 = tail call i64 @llvm.ctpop.i64(i64 %20), !range !35
  %24 = getelementptr inbounds i8, i8 addrspace(4)* %6, i64 96
  %25 = bitcast i8 addrspace(4)* %24 to i64 addrspace(4)*
  %26 = load i64, i64 addrspace(4)* %25, align 8, !tbaa !15
  %27 = inttoptr i64 %26 to %10 addrspace(1)*
  %28 = getelementptr inbounds %10, %10 addrspace(1)* %27, i64 0, i32 9
  %29 = atomicrmw add i64 addrspace(1)* %28, i64 %23 syncscope("agent-one-as") monotonic, align 8
  br label %30

30:                                               ; preds = %22, %15, %5
  %31 = inttoptr i64 %13 to i8 addrspace(1)*
  br label %.loopexit88

32:                                               ; preds = %3
  %33 = trunc i64 %0 to i32
  %34 = tail call i32 @llvm.umax.i32(i32 %33, i32 16)
  %35 = tail call i32 @llvm.ctlz.i32(i32 %34, i1 false) #12, !range !36
  %36 = sub nsw i32 31, %35
  %37 = and i32 %36, 31
  %38 = shl nuw i32 1, %37
  %39 = mul nsw i32 %35, -2
  %40 = add nsw i32 %39, 54
  %41 = icmp ugt i32 %34, %38
  %42 = zext i1 %41 to i32
  %43 = or i32 %40, %42
  %44 = lshr i32 %38, 1
  %45 = or i32 %44, %38
  %46 = icmp ugt i32 %34, %45
  %47 = zext i1 %46 to i32
  %48 = add nsw i32 %43, %47
  %49 = tail call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %50 = getelementptr inbounds i8, i8 addrspace(4)* %49, i64 96
  %51 = bitcast i8 addrspace(4)* %50 to i64 addrspace(4)*
  %52 = load i64, i64 addrspace(4)* %51, align 8, !tbaa !15
  %53 = inttoptr i64 %52 to %10 addrspace(1)*
  %54 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 6
  %55 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 7
  %56 = zext i32 %48 to i64
  %57 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 1, i64 %56, i32 0
  %58 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 0, i64 %56, i32 0
  %59 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %56, i32 2
  %60 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 2, i64 %56, i32 0
  %61 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 4, i64 %56, i32 0
  %62 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 3, i64 %56, i32 0
  %63 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %56, i32 5
  %64 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %56, i32 0
  %65 = lshr i64 191, %56
  %66 = and i64 %65, 1
  %67 = icmp eq i64 %66, 0
  %68 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %56, i32 4
  %69 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %56, i32 6
  %70 = icmp eq i32 %48, 2
  %71 = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 %48, i64 0
  %72 = getelementptr inbounds i8, i8 addrspace(4)* %49, i64 80
  %73 = bitcast i8 addrspace(4)* %72 to i64 addrspace(4)*
  br label %74

74:                                               ; preds = %.loopexit87, %32
  %75 = phi i32 [ 1, %32 ], [ %1336, %.loopexit87 ]
  %76 = phi i8 addrspace(1)* [ null, %32 ], [ %1337, %.loopexit87 ]
  %77 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %75) #13, !srcloc !37
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %.loopexit87, label %79

79:                                               ; preds = %74
  %80 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %48)
  %81 = icmp eq i32 %80, %48
  br i1 %81, label %.preheader86, label %.loopexit87

.preheader86:                                     ; preds = %1330, %79
  %82 = phi i32 [ %1331, %1330 ], [ %77, %79 ]
  %83 = phi i32 [ %1332, %1330 ], [ 1, %79 ]
  %84 = phi i8 addrspace(1)* [ %1333, %1330 ], [ %76, %79 ]
  %85 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %83) #13, !srcloc !37
  %86 = icmp eq i32 %85, 0
  br i1 %86, label %1330, label %87

87:                                               ; preds = %.preheader86
  %88 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %89 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %90 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %89, i32 0) #12
  %91 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %88, i32 %90) #12
  %92 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %91) #13, !srcloc !38
  %93 = icmp eq i32 %92, 0
  br i1 %93, label %94, label %96

94:                                               ; preds = %87
  %95 = load atomic i32, i32 addrspace(1)* %57 syncscope("agent-one-as") monotonic, align 8
  br label %96

96:                                               ; preds = %94, %87
  %97 = phi i32 [ %95, %94 ], [ 0, %87 ]
  %98 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %97)
  %99 = icmp ult i32 %98, 65792
  %100 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %101 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %102 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %101, i32 0) #12
  %103 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %100, i32 %102) #12
  %104 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %105 = tail call i64 @llvm.ctpop.i64(i64 %104), !range !35
  %106 = trunc i64 %105 to i32
  br i1 %99, label %.preheader82, label %.preheader84

.preheader82:                                     ; preds = %601, %96
  %107 = phi i32 [ %110, %601 ], [ %103, %96 ]
  %108 = phi i32 [ %602, %601 ], [ %98, %96 ]
  %109 = phi %13 addrspace(1)* [ %603, %601 ], [ undef, %96 ]
  %110 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %107) #13, !srcloc !38
  %111 = icmp eq i32 %108, 0
  br i1 %111, label %.loopexit78, label %112

112:                                              ; preds = %.preheader82
  %113 = icmp eq i32 %110, 0
  br i1 %113, label %114, label %116

114:                                              ; preds = %112
  %115 = load atomic i32, i32 addrspace(1)* %58 syncscope("agent-one-as") monotonic, align 8
  br label %116

116:                                              ; preds = %114, %112
  %117 = phi i32 [ %115, %114 ], [ 0, %112 ]
  %118 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %117)
  %119 = add i32 %118, %110
  %120 = urem i32 %119, %108
  %121 = load i32, i32 addrspace(4)* %59, align 4, !tbaa !39
  br label %122

122:                                              ; preds = %180, %116
  %123 = phi i32 [ %120, %116 ], [ %177, %180 ]
  %124 = phi i32 [ %108, %116 ], [ %178, %180 ]
  %125 = phi %13 addrspace(1)* [ %109, %116 ], [ %179, %180 ]
  %126 = icmp ugt i32 %123, 255
  br i1 %126, label %127, label %137

127:                                              ; preds = %122
  %128 = add i32 %123, -256
  %129 = lshr i32 %128, 8
  %130 = zext i32 %129 to i64
  %131 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %130, i32 0
  %132 = load atomic i64, i64 addrspace(1)* %131 syncscope("agent-one-as") monotonic, align 8
  %133 = inttoptr i64 %132 to %13 addrspace(1)*
  %134 = and i32 %123, 255
  %135 = zext i32 %134 to i64
  %136 = getelementptr inbounds %13, %13 addrspace(1)* %133, i64 %135
  br label %140

137:                                              ; preds = %122
  %138 = zext i32 %123 to i64
  %139 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %138
  br label %140

140:                                              ; preds = %137, %127
  %141 = phi %13 addrspace(1)* [ %136, %127 ], [ %139, %137 ]
  %142 = getelementptr inbounds %13, %13 addrspace(1)* %141, i64 0, i32 2
  %143 = load atomic i32, i32 addrspace(1)* %142 syncscope("agent-one-as") monotonic, align 8
  %144 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %143, i32 %121, i32 36)
  %145 = icmp eq i64 %144, 0
  br i1 %145, label %151, label %146

146:                                              ; preds = %140
  %147 = tail call i64 @llvm.cttz.i64(i64 %144, i1 true) #12, !range !35
  %148 = trunc i64 %147 to i32
  %149 = shl nuw nsw i32 %148, 2
  %150 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %149, i32 %123)
  br label %151

151:                                              ; preds = %146, %140
  %152 = phi i32 [ -1, %140 ], [ %150, %146 ]
  %153 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %152)
  %154 = icmp eq i32 %153, -1
  br i1 %154, label %170, label %155

155:                                              ; preds = %151
  %156 = icmp ugt i32 %153, 255
  br i1 %156, label %157, label %167

157:                                              ; preds = %155
  %158 = add i32 %153, -256
  %159 = lshr i32 %158, 8
  %160 = zext i32 %159 to i64
  %161 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %160, i32 0
  %162 = load atomic i64, i64 addrspace(1)* %161 syncscope("agent-one-as") monotonic, align 8
  %163 = inttoptr i64 %162 to %13 addrspace(1)*
  %164 = and i32 %153, 255
  %165 = zext i32 %164 to i64
  %166 = getelementptr inbounds %13, %13 addrspace(1)* %163, i64 %165
  br label %176

167:                                              ; preds = %155
  %168 = zext i32 %153 to i64
  %169 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %168
  br label %176

170:                                              ; preds = %151
  %171 = add i32 %123, %106
  %172 = urem i32 %171, %108
  br i1 %113, label %173, label %174

173:                                              ; preds = %170
  store atomic i32 %172, i32 addrspace(1)* %58 syncscope("agent-one-as") monotonic, align 8
  br label %174

174:                                              ; preds = %173, %170
  %175 = sub i32 %124, %106
  br label %176

176:                                              ; preds = %174, %167, %157
  %177 = phi i32 [ %172, %174 ], [ %123, %157 ], [ %123, %167 ]
  %178 = phi i32 [ %175, %174 ], [ %124, %157 ], [ %124, %167 ]
  %179 = phi %13 addrspace(1)* [ %125, %174 ], [ %166, %157 ], [ %169, %167 ]
  br i1 %154, label %180, label %.loopexit77

180:                                              ; preds = %176
  %181 = icmp sgt i32 %178, 0
  br i1 %181, label %122, label %.loopexit78

.loopexit78:                                      ; preds = %180, %.preheader82
  %182 = phi %13 addrspace(1)* [ %109, %.preheader82 ], [ %179, %180 ]
  %183 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %184 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %185 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %184, i32 0) #12
  %186 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %183, i32 %185) #12
  br label %187

187:                                              ; preds = %.loopexit26, %.loopexit78
  %188 = phi i32 [ %186, %.loopexit78 ], [ %534, %.loopexit26 ]
  %189 = phi %13 addrspace(1)* [ undef, %.loopexit78 ], [ %535, %.loopexit26 ]
  %190 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %188) #13, !srcloc !38
  %191 = icmp eq i32 %190, 0
  br i1 %191, label %192, label %194

192:                                              ; preds = %187
  %193 = load atomic i32, i32 addrspace(1)* %57 syncscope("agent-one-as") monotonic, align 8
  br label %194

194:                                              ; preds = %192, %187
  %195 = phi i32 [ %193, %192 ], [ 0, %187 ]
  %196 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %195)
  %197 = icmp eq i32 %196, 65792
  br i1 %197, label %.loopexit26, label %198

198:                                              ; preds = %194
  br i1 %191, label %199, label %204

199:                                              ; preds = %198
  %200 = cmpxchg i32 addrspace(1)* %60, i32 0, i32 256 syncscope("agent-one-as") monotonic monotonic, align 4
  %201 = extractvalue { i32, i1 } %200, 1
  %202 = extractvalue { i32, i1 } %200, 0
  %203 = select i1 %201, i32 256, i32 %202
  br label %204

204:                                              ; preds = %199, %198
  %205 = phi i32 [ %203, %199 ], [ 0, %198 ]
  %206 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %205)
  %207 = icmp eq i32 %196, %206
  br i1 %207, label %208, label %364

208:                                              ; preds = %204
  %209 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %210 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %211 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %210, i32 0) #12
  %212 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %209, i32 %211) #12
  %213 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %212) #13, !srcloc !38
  %214 = icmp eq i32 %213, 0
  br i1 %214, label %215, label %217

215:                                              ; preds = %208
  %216 = load atomic i32, i32 addrspace(1)* %60 syncscope("agent-one-as") monotonic, align 8
  br label %217

217:                                              ; preds = %215, %208
  %218 = phi i32 [ %216, %215 ], [ 0, %208 ]
  %219 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %218)
  %220 = icmp eq i32 %219, 65792
  br i1 %220, label %.loopexit46, label %221

221:                                              ; preds = %217
  br i1 %214, label %222, label %231

222:                                              ; preds = %221
  %223 = load atomic i64, i64 addrspace(1)* %61 syncscope("agent-one-as") monotonic, align 8
  %224 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %225 = sub i64 %224, %223
  %226 = icmp ugt i64 %225, 29999
  br i1 %226, label %227, label %231

227:                                              ; preds = %222
  %228 = cmpxchg i64 addrspace(1)* %61, i64 %223, i64 %224 syncscope("agent-one-as") monotonic monotonic, align 8
  %229 = extractvalue { i64, i1 } %228, 1
  %230 = select i1 %229, i32 2, i32 1
  br label %231

231:                                              ; preds = %227, %222, %221
  %232 = phi i32 [ 1, %221 ], [ 1, %222 ], [ %230, %227 ]
  %233 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %232)
  %234 = icmp eq i32 %233, 1
  br i1 %234, label %.loopexit46, label %235

235:                                              ; preds = %231
  br i1 %214, label %236, label %242

236:                                              ; preds = %235
  %237 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %238 = inttoptr i64 %237 to i8 addrspace(1)*
  %239 = addrspacecast i8 addrspace(1)* %238 to i8*
  %240 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %239, i32 noundef 3, i64 noundef 0, i64 noundef 6144, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  %241 = extractelement <2 x i64> %240, i64 0
  br label %242

242:                                              ; preds = %236, %235
  %243 = phi i64 [ %241, %236 ], [ 0, %235 ]
  %244 = trunc i64 %243 to i32
  %245 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %244)
  %246 = insertelement <2 x i32> undef, i32 %245, i64 0
  %247 = lshr i64 %243, 32
  %248 = trunc i64 %247 to i32
  %249 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %248)
  %250 = insertelement <2 x i32> %246, i32 %249, i64 1
  %251 = bitcast <2 x i32> %250 to i64
  %252 = icmp eq i64 %251, 0
  br i1 %252, label %.loopexit46, label %253

253:                                              ; preds = %242
  %254 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %255 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %256 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %255, i32 0) #12
  %257 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %254, i32 %256) #12
  %258 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %259 = tail call i64 @llvm.ctpop.i64(i64 %258), !range !35
  %260 = trunc i64 %259 to i32
  %261 = inttoptr i64 %251 to i64 addrspace(1)*
  %262 = icmp ult i32 %257, 768
  br i1 %262, label %.preheader47, label %.loopexit48

.preheader47:                                     ; preds = %.preheader47, %253
  %263 = phi i32 [ %266, %.preheader47 ], [ %257, %253 ]
  %264 = zext i32 %263 to i64
  %265 = getelementptr inbounds i64, i64 addrspace(1)* %261, i64 %264
  store i64 0, i64 addrspace(1)* %265, align 8, !tbaa !15
  %266 = add i32 %263, %260
  %267 = icmp ult i32 %266, 768
  br i1 %267, label %.preheader47, label %.loopexit48

.loopexit48:                                      ; preds = %.preheader47, %253
  br label %268

268:                                              ; preds = %300, %.loopexit48
  %269 = phi i32 [ %298, %300 ], [ %233, %.loopexit48 ]
  %270 = phi i32 [ %278, %300 ], [ %219, %.loopexit48 ]
  %271 = phi i32 [ %272, %300 ], [ %213, %.loopexit48 ]
  %272 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %271) #13, !srcloc !38
  %273 = icmp eq i32 %272, 0
  br i1 %273, label %274, label %276

274:                                              ; preds = %268
  %275 = load atomic i32, i32 addrspace(1)* %60 syncscope("agent-one-as") monotonic, align 8
  br label %276

276:                                              ; preds = %274, %268
  %277 = phi i32 [ %275, %274 ], [ %270, %268 ]
  %278 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %277)
  %279 = icmp eq i32 %278, 65792
  br i1 %279, label %280, label %286

280:                                              ; preds = %276
  br i1 %273, label %281, label %.loopexit46

281:                                              ; preds = %280
  %282 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %283 = inttoptr i64 %282 to i8 addrspace(1)*
  %284 = addrspacecast i8 addrspace(1)* %283 to i8*
  %285 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %284, i32 noundef 3, i64 noundef %251, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  br label %.loopexit46

286:                                              ; preds = %276
  br i1 %273, label %287, label %296

287:                                              ; preds = %286
  %288 = add i32 %278, -256
  %289 = lshr i32 %288, 8
  %290 = zext i32 %289 to i64
  %291 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %290, i32 0
  %292 = cmpxchg i64 addrspace(1)* %291, i64 0, i64 %251 syncscope("agent-one-as") monotonic monotonic, align 8
  %293 = extractvalue { i64, i1 } %292, 1
  br i1 %293, label %294, label %296

294:                                              ; preds = %287
  %295 = atomicrmw add i32 addrspace(1)* %60, i32 256 syncscope("agent-one-as") release, align 4
  br label %296

296:                                              ; preds = %294, %287, %286
  %297 = phi i32 [ %269, %286 ], [ 0, %294 ], [ %269, %287 ]
  %298 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %297)
  %299 = icmp eq i32 %298, 0
  br i1 %299, label %.loopexit46, label %300

300:                                              ; preds = %296
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %268

.loopexit46:                                      ; preds = %296, %281, %280, %242, %231, %217
  %301 = phi i32 [ 2, %217 ], [ 1, %231 ], [ %233, %242 ], [ %269, %281 ], [ %269, %280 ], [ 0, %296 ]
  %302 = icmp eq i32 %301, 0
  br i1 %302, label %362, label %303

303:                                              ; preds = %.loopexit46
  %304 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %305 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %306 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %305, i32 0) #12
  %307 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %304, i32 %306) #12
  %308 = icmp eq i32 %307, 0
  br i1 %308, label %309, label %__ockl_rtcwait_u32.exit2

309:                                              ; preds = %303
  %310 = load atomic i64, i64 addrspace(1)* %61 syncscope("agent-one-as") monotonic, align 8
  %311 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %312 = sub i64 %311, %310
  %313 = icmp ult i64 %312, 30000
  br i1 %313, label %314, label %__ockl_rtcwait_u32.exit2

314:                                              ; preds = %309
  %315 = trunc i64 %312 to i32
  %316 = sub nuw nsw i32 30000, %315
  %317 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %318 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %316) #12
  %319 = sext i32 %318 to i64
  %320 = add i64 %317, %319
  %321 = add i64 %317, 1625
  %322 = icmp ugt i64 %320, %321
  br i1 %322, label %.preheader44, label %.loopexit45

.loopexit45:                                      ; preds = %.preheader44, %314
  %323 = phi i64 [ %317, %314 ], [ %326, %.preheader44 ]
  %324 = add i64 %323, 806
  %325 = icmp ugt i64 %320, %324
  br i1 %325, label %.preheader42, label %.loopexit43

.preheader44:                                     ; preds = %.preheader44, %314
  tail call void @llvm.amdgcn.s.sleep(i32 127) #12
  %326 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %327 = add i64 %326, 1625
  %328 = icmp ugt i64 %320, %327
  br i1 %328, label %.preheader44, label %.loopexit45

.loopexit43:                                      ; preds = %.preheader42, %.loopexit45
  %329 = phi i64 [ %323, %.loopexit45 ], [ %332, %.preheader42 ]
  %330 = add i64 %329, 396
  %331 = icmp ugt i64 %320, %330
  br i1 %331, label %.preheader40, label %.loopexit41

.preheader42:                                     ; preds = %.preheader42, %.loopexit45
  tail call void @llvm.amdgcn.s.sleep(i32 63) #12
  %332 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %333 = add i64 %332, 806
  %334 = icmp ugt i64 %320, %333
  br i1 %334, label %.preheader42, label %.loopexit43

.preheader40:                                     ; preds = %.preheader40, %.loopexit43
  tail call void @llvm.amdgcn.s.sleep(i32 31) #12
  %335 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %336 = add i64 %335, 396
  %337 = icmp ugt i64 %320, %336
  br i1 %337, label %.preheader40, label %.loopexit41

.loopexit41:                                      ; preds = %.preheader40, %.loopexit43
  %338 = phi i64 [ %329, %.loopexit43 ], [ %335, %.preheader40 ]
  %339 = add i64 %338, 192
  %340 = icmp ugt i64 %320, %339
  br i1 %340, label %.preheader38, label %.loopexit39

.loopexit39:                                      ; preds = %.preheader38, %.loopexit41
  %341 = phi i64 [ %338, %.loopexit41 ], [ %344, %.preheader38 ]
  %342 = add i64 %341, 89
  %343 = icmp ugt i64 %320, %342
  br i1 %343, label %.preheader36, label %.loopexit37

.preheader38:                                     ; preds = %.preheader38, %.loopexit41
  tail call void @llvm.amdgcn.s.sleep(i32 15) #12
  %344 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %345 = add i64 %344, 192
  %346 = icmp ugt i64 %320, %345
  br i1 %346, label %.preheader38, label %.loopexit39

.loopexit37:                                      ; preds = %.preheader36, %.loopexit39
  %347 = phi i64 [ %341, %.loopexit39 ], [ %350, %.preheader36 ]
  %348 = add i64 %347, 38
  %349 = icmp ugt i64 %320, %348
  br i1 %349, label %.preheader34, label %.loopexit35

.preheader36:                                     ; preds = %.preheader36, %.loopexit39
  tail call void @llvm.amdgcn.s.sleep(i32 7) #12
  %350 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %351 = add i64 %350, 89
  %352 = icmp ugt i64 %320, %351
  br i1 %352, label %.preheader36, label %.loopexit37

.loopexit35:                                      ; preds = %.preheader34, %.loopexit37
  %353 = phi i64 [ %347, %.loopexit37 ], [ %355, %.preheader34 ]
  %354 = icmp ugt i64 %320, %353
  br i1 %354, label %.preheader33, label %__ockl_rtcwait_u32.exit2

.preheader34:                                     ; preds = %.preheader34, %.loopexit37
  tail call void @llvm.amdgcn.s.sleep(i32 3) #12
  %355 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %356 = add i64 %355, 38
  %357 = icmp ugt i64 %320, %356
  br i1 %357, label %.preheader34, label %.loopexit35

.preheader33:                                     ; preds = %.preheader33, %.loopexit35
  tail call void @llvm.amdgcn.s.sleep(i32 1) #12
  %358 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %359 = icmp ugt i64 %320, %358
  br i1 %359, label %.preheader33, label %__ockl_rtcwait_u32.exit2

__ockl_rtcwait_u32.exit2:                         ; preds = %.preheader33, %.loopexit35, %309, %303
  %360 = icmp eq i32 %301, 2
  %361 = select i1 %360, %13 addrspace(1)* null, %13 addrspace(1)* inttoptr (i64 1 to %13 addrspace(1)*)
  br label %362

362:                                              ; preds = %__ockl_rtcwait_u32.exit2, %.loopexit46
  %363 = phi %13 addrspace(1)* [ %361, %__ockl_rtcwait_u32.exit2 ], [ %189, %.loopexit46 ]
  br i1 %302, label %364, label %.loopexit26

364:                                              ; preds = %362, %204
  %365 = phi %13 addrspace(1)* [ %363, %362 ], [ %189, %204 ]
  br i1 %191, label %366, label %375

366:                                              ; preds = %364
  %367 = load atomic i64, i64 addrspace(1)* %62 syncscope("agent-one-as") monotonic, align 8
  %368 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %369 = sub i64 %368, %367
  %370 = icmp ugt i64 %369, 19999
  br i1 %370, label %371, label %375

371:                                              ; preds = %366
  %372 = cmpxchg i64 addrspace(1)* %62, i64 %367, i64 %368 syncscope("agent-one-as") monotonic monotonic, align 8
  %373 = extractvalue { i64, i1 } %372, 1
  %374 = select i1 %373, i8 addrspace(1)* null, i8 addrspace(1)* inttoptr (i64 1 to i8 addrspace(1)*)
  br label %375

375:                                              ; preds = %371, %366, %364
  %376 = phi i8 addrspace(1)* [ inttoptr (i64 1 to i8 addrspace(1)*), %364 ], [ inttoptr (i64 1 to i8 addrspace(1)*), %366 ], [ %374, %371 ]
  %377 = ptrtoint i8 addrspace(1)* %376 to i64
  %378 = trunc i64 %377 to i32
  %379 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %378)
  %380 = insertelement <2 x i32> undef, i32 %379, i64 0
  %381 = lshr i64 %377, 32
  %382 = trunc i64 %381 to i32
  %383 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %382)
  %384 = insertelement <2 x i32> %380, i32 %383, i64 1
  %385 = bitcast <2 x i32> %384 to i64
  %386 = icmp eq i64 %385, 0
  br i1 %386, label %389, label %387

387:                                              ; preds = %375
  %388 = inttoptr i64 %385 to %13 addrspace(1)*
  br label %.loopexit26

389:                                              ; preds = %375
  br i1 %191, label %390, label %403

390:                                              ; preds = %389
  %391 = load atomic i64, i64 addrspace(1)* %54 syncscope("agent-one-as") monotonic, align 8
  %392 = load i64, i64 addrspace(1)* %55, align 8, !tbaa !41
  %393 = icmp ult i64 %391, %392
  br i1 %393, label %394, label %397

394:                                              ; preds = %390
  %395 = atomicrmw add i64 addrspace(1)* %54, i64 2097152 syncscope("agent-one-as") monotonic, align 8
  %396 = icmp ult i64 %395, %392
  br i1 %396, label %403, label %397

397:                                              ; preds = %394, %390
  %398 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %399 = inttoptr i64 %398 to i8 addrspace(1)*
  %400 = addrspacecast i8 addrspace(1)* %399 to i8*
  %401 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %400, i32 noundef 3, i64 noundef 0, i64 noundef 2097152, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  %402 = extractelement <2 x i64> %401, i64 0
  br label %403

403:                                              ; preds = %397, %394, %389
  %404 = phi i64 [ 0, %389 ], [ %402, %397 ], [ %395, %394 ]
  %405 = trunc i64 %404 to i32
  %406 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %405)
  %407 = insertelement <2 x i32> undef, i32 %406, i64 0
  %408 = lshr i64 %404, 32
  %409 = trunc i64 %408 to i32
  %410 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %409)
  %411 = insertelement <2 x i32> %407, i32 %410, i64 1
  %412 = bitcast <2 x i32> %411 to i64
  %413 = icmp eq i64 %412, 0
  br i1 %413, label %.loopexit26, label %414

414:                                              ; preds = %403
  %415 = inttoptr i64 %412 to %14 addrspace(1)*
  %416 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %417 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %418 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %417, i32 0) #12
  %419 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %416, i32 %418) #12
  %420 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %419) #13, !srcloc !38
  %421 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %422 = tail call i64 @llvm.ctpop.i64(i64 %421), !range !35
  %423 = trunc i64 %422 to i32
  %424 = load i32, i32 addrspace(4)* %63, align 4, !tbaa !43
  %425 = load i32, i32 addrspace(4)* %64, align 4, !tbaa !44
  %426 = add i32 %425, 31
  %427 = lshr i32 %426, 5
  br i1 %67, label %448, label %428

428:                                              ; preds = %414
  %429 = icmp ult i32 %420, %427
  br i1 %429, label %.preheader31, label %.loopexit32

.loopexit32:                                      ; preds = %.preheader31, %428
  %430 = mul i32 %424, %423
  %431 = load i32, i32 addrspace(4)* %68, align 4, !tbaa !45
  %432 = mul i32 %424, %420
  %433 = add i32 %431, %432
  %434 = icmp ult i32 %433, %425
  br i1 %434, label %.preheader29, label %.loopexit28

.preheader31:                                     ; preds = %.preheader31, %428
  %435 = phi i32 [ %438, %.preheader31 ], [ %420, %428 ]
  %436 = zext i32 %435 to i64
  %437 = getelementptr inbounds %14, %14 addrspace(1)* %415, i64 0, i32 4, i64 %436
  store i32 0, i32 addrspace(1)* %437, align 4, !tbaa !13
  %438 = add i32 %435, %423
  %439 = icmp ult i32 %438, %427
  br i1 %439, label %.preheader31, label %.loopexit32

.preheader29:                                     ; preds = %.preheader29, %.loopexit32
  %440 = phi i32 [ %446, %.preheader29 ], [ %433, %.loopexit32 ]
  %441 = and i32 %440, 31
  %442 = shl nuw i32 1, %441
  %443 = lshr i32 %440, 5
  %444 = zext i32 %443 to i64
  %445 = getelementptr inbounds %14, %14 addrspace(1)* %415, i64 0, i32 4, i64 %444
  store i32 %442, i32 addrspace(1)* %445, align 4, !tbaa !13
  %446 = add i32 %440, %430
  %447 = icmp ult i32 %446, %425
  br i1 %447, label %.preheader29, label %.loopexit28

448:                                              ; preds = %414
  %449 = load i32, i32 addrspace(4)* %69, align 4, !tbaa !46
  %450 = icmp ult i32 %420, %427
  br i1 %450, label %.preheader27, label %.loopexit28

.preheader27:                                     ; preds = %.preheader27, %448
  %451 = phi i32 [ %454, %.preheader27 ], [ %420, %448 ]
  %452 = zext i32 %451 to i64
  %453 = getelementptr inbounds %14, %14 addrspace(1)* %415, i64 0, i32 4, i64 %452
  store i32 %449, i32 addrspace(1)* %453, align 4, !tbaa !13
  %454 = add i32 %451, %423
  %455 = icmp ult i32 %454, %427
  br i1 %455, label %.preheader27, label %.loopexit28

.loopexit28:                                      ; preds = %.preheader27, %448, %.preheader29, %.loopexit32
  %456 = icmp eq i32 %420, 0
  br i1 %456, label %457, label %468

457:                                              ; preds = %.loopexit28
  br i1 %70, label %466, label %458

458:                                              ; preds = %457
  %459 = and i32 %425, 31
  %460 = shl nsw i32 -1, %459
  %461 = add nsw i32 %427, -1
  %462 = zext i32 %461 to i64
  %463 = getelementptr inbounds %14, %14 addrspace(1)* %415, i64 0, i32 4, i64 %462
  %464 = load i32, i32 addrspace(1)* %463, align 4, !tbaa !13
  %465 = or i32 %464, %460
  store i32 %465, i32 addrspace(1)* %463, align 4, !tbaa !13
  br label %466

466:                                              ; preds = %458, %457
  %467 = inttoptr i64 %412 to <4 x i32> addrspace(1)*
  store <4 x i32> %71, <4 x i32> addrspace(1)* %467, align 16, !tbaa !29
  br label %468

468:                                              ; preds = %466, %.loopexit28
  %469 = getelementptr inbounds %14, %14 addrspace(1)* %415, i64 0, i32 1
  br label %470

470:                                              ; preds = %532, %468
  %471 = phi i32 [ %206, %468 ], [ %487, %532 ]
  %472 = phi i32 [ %196, %468 ], [ %480, %532 ]
  %473 = phi i32 [ %190, %468 ], [ %474, %532 ]
  %474 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %473) #13, !srcloc !38
  %475 = icmp eq i32 %474, 0
  br i1 %475, label %476, label %478

476:                                              ; preds = %470
  %477 = load atomic i32, i32 addrspace(1)* %57 syncscope("agent-one-as") monotonic, align 8
  br label %478

478:                                              ; preds = %476, %470
  %479 = phi i32 [ %477, %476 ], [ %472, %470 ]
  %480 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %479)
  %481 = icmp eq i32 %480, 65792
  br i1 %481, label %.loopexit26, label %482

482:                                              ; preds = %478
  br i1 %475, label %483, label %485

483:                                              ; preds = %482
  %484 = load atomic i32, i32 addrspace(1)* %60 syncscope("agent-one-as") monotonic, align 8
  br label %485

485:                                              ; preds = %483, %482
  %486 = phi i32 [ %484, %483 ], [ %471, %482 ]
  %487 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %486)
  %488 = icmp eq i32 %480, %487
  br i1 %488, label %489, label %495

489:                                              ; preds = %485
  br i1 %475, label %490, label %.loopexit26

490:                                              ; preds = %489
  %491 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %492 = inttoptr i64 %491 to i8 addrspace(1)*
  %493 = addrspacecast i8 addrspace(1)* %492 to i8*
  %494 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %493, i32 noundef 3, i64 noundef %412, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  br label %.loopexit26

495:                                              ; preds = %485
  br i1 %475, label %496, label %518

496:                                              ; preds = %495
  %497 = icmp ugt i32 %480, 255
  br i1 %497, label %498, label %508

498:                                              ; preds = %496
  %499 = add i32 %480, -256
  %500 = lshr i32 %499, 8
  %501 = zext i32 %500 to i64
  %502 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %501, i32 0
  %503 = load atomic i64, i64 addrspace(1)* %502 syncscope("agent-one-as") monotonic, align 8
  %504 = inttoptr i64 %503 to %13 addrspace(1)*
  %505 = and i32 %480, 255
  %506 = zext i32 %505 to i64
  %507 = getelementptr inbounds %13, %13 addrspace(1)* %504, i64 %506
  br label %511

508:                                              ; preds = %496
  %509 = zext i32 %480 to i64
  %510 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %56, i64 %509
  br label %511

511:                                              ; preds = %508, %498
  %512 = phi %13 addrspace(1)* [ %507, %498 ], [ %510, %508 ]
  store i32 %480, i32 addrspace(1)* %469, align 4, !tbaa !47
  %513 = getelementptr inbounds %13, %13 addrspace(1)* %512, i64 0, i32 1
  %514 = cmpxchg i64 addrspace(1)* %513, i64 0, i64 %412 syncscope("agent-one-as") monotonic monotonic, align 8
  %515 = extractvalue { i64, i1 } %514, 1
  br i1 %515, label %516, label %518

516:                                              ; preds = %511
  %517 = atomicrmw add i32 addrspace(1)* %57, i32 1 syncscope("agent-one-as") release, align 4
  br label %518

518:                                              ; preds = %516, %511, %495
  %519 = phi %13 addrspace(1)* [ null, %495 ], [ %512, %516 ], [ null, %511 ]
  %520 = ptrtoint %13 addrspace(1)* %519 to i64
  %521 = trunc i64 %520 to i32
  %522 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %521)
  %523 = insertelement <2 x i32> undef, i32 %522, i64 0
  %524 = lshr i64 %520, 32
  %525 = trunc i64 %524 to i32
  %526 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %525)
  %527 = insertelement <2 x i32> %523, i32 %526, i64 1
  %528 = bitcast <2 x i32> %527 to i64
  %529 = icmp eq i64 %528, 0
  br i1 %529, label %532, label %530

530:                                              ; preds = %518
  %531 = inttoptr i64 %528 to %13 addrspace(1)*
  br label %.loopexit26

532:                                              ; preds = %518
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %470

.loopexit26:                                      ; preds = %530, %490, %489, %478, %403, %387, %362, %194
  %533 = phi i1 [ false, %387 ], [ true, %490 ], [ true, %489 ], [ false, %403 ], [ false, %530 ], [ false, %194 ], [ false, %362 ], [ false, %478 ]
  %534 = phi i32 [ %190, %387 ], [ 0, %490 ], [ %474, %489 ], [ %190, %403 ], [ %474, %530 ], [ %190, %194 ], [ %190, %362 ], [ %474, %478 ]
  %535 = phi %13 addrspace(1)* [ %388, %387 ], [ %365, %490 ], [ %365, %489 ], [ null, %403 ], [ %531, %530 ], [ null, %194 ], [ %363, %362 ], [ null, %478 ]
  br i1 %533, label %187, label %536

536:                                              ; preds = %.loopexit26
  %537 = icmp eq %13 addrspace(1)* %535, inttoptr (i64 1 to %13 addrspace(1)*)
  br i1 %537, label %538, label %601

538:                                              ; preds = %536
  %539 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %540 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %541 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %540, i32 0) #12
  %542 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %539, i32 %541) #12
  %543 = icmp eq i32 %542, 0
  br i1 %543, label %544, label %__ockl_rtcwait_u32.exit3

544:                                              ; preds = %538
  %545 = load atomic i64, i64 addrspace(1)* %62 syncscope("agent-one-as") monotonic, align 8
  %546 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %547 = sub i64 %546, %545
  %548 = icmp ult i64 %547, 20000
  br i1 %548, label %549, label %__ockl_rtcwait_u32.exit3

549:                                              ; preds = %544
  %550 = trunc i64 %547 to i32
  %551 = sub nuw nsw i32 20000, %550
  %552 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %553 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %551) #12
  %554 = sext i32 %553 to i64
  %555 = add i64 %552, %554
  %556 = add i64 %552, 1625
  %557 = icmp ugt i64 %555, %556
  br i1 %557, label %.preheader75, label %.loopexit76

.loopexit76:                                      ; preds = %.preheader75, %549
  %558 = phi i64 [ %552, %549 ], [ %561, %.preheader75 ]
  %559 = add i64 %558, 806
  %560 = icmp ugt i64 %555, %559
  br i1 %560, label %.preheader73, label %.loopexit74

.preheader75:                                     ; preds = %.preheader75, %549
  tail call void @llvm.amdgcn.s.sleep(i32 127) #12
  %561 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %562 = add i64 %561, 1625
  %563 = icmp ugt i64 %555, %562
  br i1 %563, label %.preheader75, label %.loopexit76

.loopexit74:                                      ; preds = %.preheader73, %.loopexit76
  %564 = phi i64 [ %558, %.loopexit76 ], [ %567, %.preheader73 ]
  %565 = add i64 %564, 396
  %566 = icmp ugt i64 %555, %565
  br i1 %566, label %.preheader71, label %.loopexit72

.preheader73:                                     ; preds = %.preheader73, %.loopexit76
  tail call void @llvm.amdgcn.s.sleep(i32 63) #12
  %567 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %568 = add i64 %567, 806
  %569 = icmp ugt i64 %555, %568
  br i1 %569, label %.preheader73, label %.loopexit74

.preheader71:                                     ; preds = %.preheader71, %.loopexit74
  tail call void @llvm.amdgcn.s.sleep(i32 31) #12
  %570 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %571 = add i64 %570, 396
  %572 = icmp ugt i64 %555, %571
  br i1 %572, label %.preheader71, label %.loopexit72

.loopexit72:                                      ; preds = %.preheader71, %.loopexit74
  %573 = phi i64 [ %564, %.loopexit74 ], [ %570, %.preheader71 ]
  %574 = add i64 %573, 192
  %575 = icmp ugt i64 %555, %574
  br i1 %575, label %.preheader69, label %.loopexit70

.loopexit70:                                      ; preds = %.preheader69, %.loopexit72
  %576 = phi i64 [ %573, %.loopexit72 ], [ %579, %.preheader69 ]
  %577 = add i64 %576, 89
  %578 = icmp ugt i64 %555, %577
  br i1 %578, label %.preheader67, label %.loopexit68

.preheader69:                                     ; preds = %.preheader69, %.loopexit72
  tail call void @llvm.amdgcn.s.sleep(i32 15) #12
  %579 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %580 = add i64 %579, 192
  %581 = icmp ugt i64 %555, %580
  br i1 %581, label %.preheader69, label %.loopexit70

.loopexit68:                                      ; preds = %.preheader67, %.loopexit70
  %582 = phi i64 [ %576, %.loopexit70 ], [ %585, %.preheader67 ]
  %583 = add i64 %582, 38
  %584 = icmp ugt i64 %555, %583
  br i1 %584, label %.preheader65, label %.loopexit66

.preheader67:                                     ; preds = %.preheader67, %.loopexit70
  tail call void @llvm.amdgcn.s.sleep(i32 7) #12
  %585 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %586 = add i64 %585, 89
  %587 = icmp ugt i64 %555, %586
  br i1 %587, label %.preheader67, label %.loopexit68

.loopexit66:                                      ; preds = %.preheader65, %.loopexit68
  %588 = phi i64 [ %582, %.loopexit68 ], [ %590, %.preheader65 ]
  %589 = icmp ugt i64 %555, %588
  br i1 %589, label %.preheader64, label %__ockl_rtcwait_u32.exit3

.preheader65:                                     ; preds = %.preheader65, %.loopexit68
  tail call void @llvm.amdgcn.s.sleep(i32 3) #12
  %590 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %591 = add i64 %590, 38
  %592 = icmp ugt i64 %555, %591
  br i1 %592, label %.preheader65, label %.loopexit66

.preheader64:                                     ; preds = %.preheader64, %.loopexit66
  tail call void @llvm.amdgcn.s.sleep(i32 1) #12
  %593 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %594 = icmp ugt i64 %555, %593
  br i1 %594, label %.preheader64, label %__ockl_rtcwait_u32.exit3

__ockl_rtcwait_u32.exit3:                         ; preds = %.preheader64, %.loopexit66, %544, %538
  %595 = icmp eq i32 %110, 0
  br i1 %595, label %596, label %598

596:                                              ; preds = %__ockl_rtcwait_u32.exit3
  %597 = load atomic i32, i32 addrspace(1)* %57 syncscope("agent-one-as") monotonic, align 8
  br label %598

598:                                              ; preds = %596, %__ockl_rtcwait_u32.exit3
  %599 = phi i32 [ %597, %596 ], [ %108, %__ockl_rtcwait_u32.exit3 ]
  %600 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %599)
  br label %601

601:                                              ; preds = %598, %536
  %602 = phi i32 [ %600, %598 ], [ %108, %536 ]
  %603 = phi %13 addrspace(1)* [ %182, %598 ], [ %535, %536 ]
  br i1 %537, label %.preheader82, label %.loopexit77

.preheader84:                                     ; preds = %.loopexit62, %96
  %604 = phi i32 [ %1219, %.loopexit62 ], [ %48, %96 ]
  %605 = phi i32 [ %607, %.loopexit62 ], [ %103, %96 ]
  %606 = phi %13 addrspace(1)* [ %1220, %.loopexit62 ], [ undef, %96 ]
  %607 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %605) #13, !srcloc !38
  %608 = zext i32 %604 to i64
  %609 = icmp eq i32 %607, 0
  br i1 %609, label %610, label %613

610:                                              ; preds = %.preheader84
  %611 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 0, i64 %608, i32 0
  %612 = load atomic i32, i32 addrspace(1)* %611 syncscope("agent-one-as") monotonic, align 8
  br label %613

613:                                              ; preds = %610, %.preheader84
  %614 = phi i32 [ %612, %610 ], [ 0, %.preheader84 ]
  %615 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %614)
  %616 = add i32 %615, %607
  %617 = urem i32 %616, 65792
  %618 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %608, i32 1
  %619 = load i32, i32 addrspace(4)* %618, align 4, !tbaa !49
  %620 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 0, i64 %608, i32 0
  br label %621

621:                                              ; preds = %679, %613
  %622 = phi i32 [ %617, %613 ], [ %676, %679 ]
  %623 = phi i32 [ 65792, %613 ], [ %677, %679 ]
  %624 = phi %13 addrspace(1)* [ %606, %613 ], [ %678, %679 ]
  %625 = icmp ugt i32 %622, 255
  br i1 %625, label %626, label %636

626:                                              ; preds = %621
  %627 = add i32 %622, -256
  %628 = lshr i32 %627, 8
  %629 = zext i32 %628 to i64
  %630 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %608, i64 %629, i32 0
  %631 = load atomic i64, i64 addrspace(1)* %630 syncscope("agent-one-as") monotonic, align 8
  %632 = inttoptr i64 %631 to %13 addrspace(1)*
  %633 = and i32 %622, 255
  %634 = zext i32 %633 to i64
  %635 = getelementptr inbounds %13, %13 addrspace(1)* %632, i64 %634
  br label %639

636:                                              ; preds = %621
  %637 = zext i32 %622 to i64
  %638 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %608, i64 %637
  br label %639

639:                                              ; preds = %636, %626
  %640 = phi %13 addrspace(1)* [ %635, %626 ], [ %638, %636 ]
  %641 = getelementptr inbounds %13, %13 addrspace(1)* %640, i64 0, i32 2
  %642 = load atomic i32, i32 addrspace(1)* %641 syncscope("agent-one-as") monotonic, align 8
  %643 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %642, i32 %619, i32 36)
  %644 = icmp eq i64 %643, 0
  br i1 %644, label %650, label %645

645:                                              ; preds = %639
  %646 = tail call i64 @llvm.cttz.i64(i64 %643, i1 true) #12, !range !35
  %647 = trunc i64 %646 to i32
  %648 = shl nuw nsw i32 %647, 2
  %649 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %648, i32 %622)
  br label %650

650:                                              ; preds = %645, %639
  %651 = phi i32 [ -1, %639 ], [ %649, %645 ]
  %652 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %651)
  %653 = icmp eq i32 %652, -1
  br i1 %653, label %669, label %654

654:                                              ; preds = %650
  %655 = icmp ugt i32 %652, 255
  br i1 %655, label %656, label %666

656:                                              ; preds = %654
  %657 = add i32 %652, -256
  %658 = lshr i32 %657, 8
  %659 = zext i32 %658 to i64
  %660 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %608, i64 %659, i32 0
  %661 = load atomic i64, i64 addrspace(1)* %660 syncscope("agent-one-as") monotonic, align 8
  %662 = inttoptr i64 %661 to %13 addrspace(1)*
  %663 = and i32 %652, 255
  %664 = zext i32 %663 to i64
  %665 = getelementptr inbounds %13, %13 addrspace(1)* %662, i64 %664
  br label %675

666:                                              ; preds = %654
  %667 = zext i32 %652 to i64
  %668 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %608, i64 %667
  br label %675

669:                                              ; preds = %650
  %670 = add i32 %622, %106
  %671 = urem i32 %670, 65792
  br i1 %609, label %672, label %673

672:                                              ; preds = %669
  store atomic i32 %671, i32 addrspace(1)* %620 syncscope("agent-one-as") monotonic, align 8
  br label %673

673:                                              ; preds = %672, %669
  %674 = sub i32 %623, %106
  br label %675

675:                                              ; preds = %673, %666, %656
  %676 = phi i32 [ %671, %673 ], [ %622, %656 ], [ %622, %666 ]
  %677 = phi i32 [ %674, %673 ], [ %623, %656 ], [ %623, %666 ]
  %678 = phi %13 addrspace(1)* [ %624, %673 ], [ %665, %656 ], [ %668, %666 ]
  br i1 %653, label %679, label %.loopexit62

679:                                              ; preds = %675
  %680 = icmp sgt i32 %677, 0
  br i1 %680, label %621, label %681

681:                                              ; preds = %679
  %682 = add i32 %604, 2
  %683 = and i32 %682, -2
  %684 = icmp ne i32 %604, %48
  %685 = icmp ugt i32 %683, 15
  %686 = select i1 %684, i1 true, i1 %685
  br i1 %686, label %.loopexit62, label %687

687:                                              ; preds = %681
  br i1 %609, label %688, label %692

688:                                              ; preds = %687
  %689 = zext i32 %683 to i64
  %690 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 1, i64 %689, i32 0
  %691 = load atomic i32, i32 addrspace(1)* %690 syncscope("agent-one-as") monotonic, align 8
  br label %692

692:                                              ; preds = %688, %687
  %693 = phi i32 [ %691, %688 ], [ 0, %687 ]
  %694 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %693)
  %695 = icmp ult i32 %694, 65792
  br i1 %695, label %696, label %.loopexit62

696:                                              ; preds = %692
  %697 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %698 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %699 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %698, i32 0) #12
  %700 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %697, i32 %699) #12
  %701 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %702 = tail call i64 @llvm.ctpop.i64(i64 %701), !range !35
  %703 = trunc i64 %702 to i32
  %704 = zext i32 %683 to i64
  %705 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 0, i64 %704, i32 0
  %706 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %704, i32 2
  %707 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 1, i64 %704, i32 0
  %708 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 2, i64 %704, i32 0
  %709 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 4, i64 %704, i32 0
  %710 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 3, i64 %704, i32 0
  %711 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %704, i32 5
  %712 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %704, i32 0
  %713 = lshr i64 191, %704
  %714 = and i64 %713, 1
  %715 = icmp eq i64 %714, 0
  %716 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %704, i32 4
  %717 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %704, i32 6
  %718 = icmp eq i32 %683, 2
  %719 = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 %683, i64 0
  br label %720

720:                                              ; preds = %1215, %696
  %721 = phi i32 [ %700, %696 ], [ %724, %1215 ]
  %722 = phi i32 [ %694, %696 ], [ %1216, %1215 ]
  %723 = phi %13 addrspace(1)* [ undef, %696 ], [ %1217, %1215 ]
  %724 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %721) #13, !srcloc !38
  %725 = icmp eq i32 %722, 0
  br i1 %725, label %.loopexit63, label %726

726:                                              ; preds = %720
  %727 = icmp eq i32 %724, 0
  br i1 %727, label %728, label %730

728:                                              ; preds = %726
  %729 = load atomic i32, i32 addrspace(1)* %705 syncscope("agent-one-as") monotonic, align 8
  br label %730

730:                                              ; preds = %728, %726
  %731 = phi i32 [ %729, %728 ], [ 0, %726 ]
  %732 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %731)
  %733 = add i32 %732, %724
  %734 = urem i32 %733, %722
  %735 = load i32, i32 addrspace(4)* %706, align 4, !tbaa !39
  br label %736

736:                                              ; preds = %794, %730
  %737 = phi i32 [ %734, %730 ], [ %791, %794 ]
  %738 = phi i32 [ %722, %730 ], [ %792, %794 ]
  %739 = phi %13 addrspace(1)* [ %723, %730 ], [ %793, %794 ]
  %740 = icmp ugt i32 %737, 255
  br i1 %740, label %741, label %751

741:                                              ; preds = %736
  %742 = add i32 %737, -256
  %743 = lshr i32 %742, 8
  %744 = zext i32 %743 to i64
  %745 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %744, i32 0
  %746 = load atomic i64, i64 addrspace(1)* %745 syncscope("agent-one-as") monotonic, align 8
  %747 = inttoptr i64 %746 to %13 addrspace(1)*
  %748 = and i32 %737, 255
  %749 = zext i32 %748 to i64
  %750 = getelementptr inbounds %13, %13 addrspace(1)* %747, i64 %749
  br label %754

751:                                              ; preds = %736
  %752 = zext i32 %737 to i64
  %753 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %752
  br label %754

754:                                              ; preds = %751, %741
  %755 = phi %13 addrspace(1)* [ %750, %741 ], [ %753, %751 ]
  %756 = getelementptr inbounds %13, %13 addrspace(1)* %755, i64 0, i32 2
  %757 = load atomic i32, i32 addrspace(1)* %756 syncscope("agent-one-as") monotonic, align 8
  %758 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 %757, i32 %735, i32 36)
  %759 = icmp eq i64 %758, 0
  br i1 %759, label %765, label %760

760:                                              ; preds = %754
  %761 = tail call i64 @llvm.cttz.i64(i64 %758, i1 true) #12, !range !35
  %762 = trunc i64 %761 to i32
  %763 = shl nuw nsw i32 %762, 2
  %764 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %763, i32 %737)
  br label %765

765:                                              ; preds = %760, %754
  %766 = phi i32 [ -1, %754 ], [ %764, %760 ]
  %767 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %766)
  %768 = icmp eq i32 %767, -1
  br i1 %768, label %784, label %769

769:                                              ; preds = %765
  %770 = icmp ugt i32 %767, 255
  br i1 %770, label %771, label %781

771:                                              ; preds = %769
  %772 = add i32 %767, -256
  %773 = lshr i32 %772, 8
  %774 = zext i32 %773 to i64
  %775 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %774, i32 0
  %776 = load atomic i64, i64 addrspace(1)* %775 syncscope("agent-one-as") monotonic, align 8
  %777 = inttoptr i64 %776 to %13 addrspace(1)*
  %778 = and i32 %767, 255
  %779 = zext i32 %778 to i64
  %780 = getelementptr inbounds %13, %13 addrspace(1)* %777, i64 %779
  br label %790

781:                                              ; preds = %769
  %782 = zext i32 %767 to i64
  %783 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %782
  br label %790

784:                                              ; preds = %765
  %785 = add i32 %737, %703
  %786 = urem i32 %785, %722
  br i1 %727, label %787, label %788

787:                                              ; preds = %784
  store atomic i32 %786, i32 addrspace(1)* %705 syncscope("agent-one-as") monotonic, align 8
  br label %788

788:                                              ; preds = %787, %784
  %789 = sub i32 %738, %703
  br label %790

790:                                              ; preds = %788, %781, %771
  %791 = phi i32 [ %786, %788 ], [ %737, %771 ], [ %737, %781 ]
  %792 = phi i32 [ %789, %788 ], [ %738, %771 ], [ %738, %781 ]
  %793 = phi %13 addrspace(1)* [ %739, %788 ], [ %780, %771 ], [ %783, %781 ]
  br i1 %768, label %794, label %.loopexit62

794:                                              ; preds = %790
  %795 = icmp sgt i32 %792, 0
  br i1 %795, label %736, label %.loopexit63

.loopexit63:                                      ; preds = %794, %720
  %796 = phi %13 addrspace(1)* [ %723, %720 ], [ %793, %794 ]
  %797 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %798 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %799 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %798, i32 0) #12
  %800 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %797, i32 %799) #12
  br label %801

801:                                              ; preds = %.loopexit, %.loopexit63
  %802 = phi i32 [ %800, %.loopexit63 ], [ %1148, %.loopexit ]
  %803 = phi %13 addrspace(1)* [ undef, %.loopexit63 ], [ %1149, %.loopexit ]
  %804 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %802) #13, !srcloc !38
  %805 = icmp eq i32 %804, 0
  br i1 %805, label %806, label %808

806:                                              ; preds = %801
  %807 = load atomic i32, i32 addrspace(1)* %707 syncscope("agent-one-as") monotonic, align 8
  br label %808

808:                                              ; preds = %806, %801
  %809 = phi i32 [ %807, %806 ], [ 0, %801 ]
  %810 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %809)
  %811 = icmp eq i32 %810, 65792
  br i1 %811, label %.loopexit, label %812

812:                                              ; preds = %808
  br i1 %805, label %813, label %818

813:                                              ; preds = %812
  %814 = cmpxchg i32 addrspace(1)* %708, i32 0, i32 256 syncscope("agent-one-as") monotonic monotonic, align 4
  %815 = extractvalue { i32, i1 } %814, 1
  %816 = extractvalue { i32, i1 } %814, 0
  %817 = select i1 %815, i32 256, i32 %816
  br label %818

818:                                              ; preds = %813, %812
  %819 = phi i32 [ %817, %813 ], [ 0, %812 ]
  %820 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %819)
  %821 = icmp eq i32 %810, %820
  br i1 %821, label %822, label %978

822:                                              ; preds = %818
  %823 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %824 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %825 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %824, i32 0) #12
  %826 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %823, i32 %825) #12
  %827 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %826) #13, !srcloc !38
  %828 = icmp eq i32 %827, 0
  br i1 %828, label %829, label %831

829:                                              ; preds = %822
  %830 = load atomic i32, i32 addrspace(1)* %708 syncscope("agent-one-as") monotonic, align 8
  br label %831

831:                                              ; preds = %829, %822
  %832 = phi i32 [ %830, %829 ], [ 0, %822 ]
  %833 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %832)
  %834 = icmp eq i32 %833, 65792
  br i1 %834, label %.loopexit23, label %835

835:                                              ; preds = %831
  br i1 %828, label %836, label %845

836:                                              ; preds = %835
  %837 = load atomic i64, i64 addrspace(1)* %709 syncscope("agent-one-as") monotonic, align 8
  %838 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %839 = sub i64 %838, %837
  %840 = icmp ugt i64 %839, 29999
  br i1 %840, label %841, label %845

841:                                              ; preds = %836
  %842 = cmpxchg i64 addrspace(1)* %709, i64 %837, i64 %838 syncscope("agent-one-as") monotonic monotonic, align 8
  %843 = extractvalue { i64, i1 } %842, 1
  %844 = select i1 %843, i32 2, i32 1
  br label %845

845:                                              ; preds = %841, %836, %835
  %846 = phi i32 [ 1, %835 ], [ 1, %836 ], [ %844, %841 ]
  %847 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %846)
  %848 = icmp eq i32 %847, 1
  br i1 %848, label %.loopexit23, label %849

849:                                              ; preds = %845
  br i1 %828, label %850, label %856

850:                                              ; preds = %849
  %851 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %852 = inttoptr i64 %851 to i8 addrspace(1)*
  %853 = addrspacecast i8 addrspace(1)* %852 to i8*
  %854 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %853, i32 noundef 3, i64 noundef 0, i64 noundef 6144, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  %855 = extractelement <2 x i64> %854, i64 0
  br label %856

856:                                              ; preds = %850, %849
  %857 = phi i64 [ %855, %850 ], [ 0, %849 ]
  %858 = trunc i64 %857 to i32
  %859 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %858)
  %860 = insertelement <2 x i32> undef, i32 %859, i64 0
  %861 = lshr i64 %857, 32
  %862 = trunc i64 %861 to i32
  %863 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %862)
  %864 = insertelement <2 x i32> %860, i32 %863, i64 1
  %865 = bitcast <2 x i32> %864 to i64
  %866 = icmp eq i64 %865, 0
  br i1 %866, label %.loopexit23, label %867

867:                                              ; preds = %856
  %868 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %869 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %870 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %869, i32 0) #12
  %871 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %868, i32 %870) #12
  %872 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %873 = tail call i64 @llvm.ctpop.i64(i64 %872), !range !35
  %874 = trunc i64 %873 to i32
  %875 = inttoptr i64 %865 to i64 addrspace(1)*
  %876 = icmp ult i32 %871, 768
  br i1 %876, label %.preheader24, label %.loopexit25

.preheader24:                                     ; preds = %.preheader24, %867
  %877 = phi i32 [ %880, %.preheader24 ], [ %871, %867 ]
  %878 = zext i32 %877 to i64
  %879 = getelementptr inbounds i64, i64 addrspace(1)* %875, i64 %878
  store i64 0, i64 addrspace(1)* %879, align 8, !tbaa !15
  %880 = add i32 %877, %874
  %881 = icmp ult i32 %880, 768
  br i1 %881, label %.preheader24, label %.loopexit25

.loopexit25:                                      ; preds = %.preheader24, %867
  br label %882

882:                                              ; preds = %914, %.loopexit25
  %883 = phi i32 [ %912, %914 ], [ %847, %.loopexit25 ]
  %884 = phi i32 [ %892, %914 ], [ %833, %.loopexit25 ]
  %885 = phi i32 [ %886, %914 ], [ %827, %.loopexit25 ]
  %886 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %885) #13, !srcloc !38
  %887 = icmp eq i32 %886, 0
  br i1 %887, label %888, label %890

888:                                              ; preds = %882
  %889 = load atomic i32, i32 addrspace(1)* %708 syncscope("agent-one-as") monotonic, align 8
  br label %890

890:                                              ; preds = %888, %882
  %891 = phi i32 [ %889, %888 ], [ %884, %882 ]
  %892 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %891)
  %893 = icmp eq i32 %892, 65792
  br i1 %893, label %894, label %900

894:                                              ; preds = %890
  br i1 %887, label %895, label %.loopexit23

895:                                              ; preds = %894
  %896 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %897 = inttoptr i64 %896 to i8 addrspace(1)*
  %898 = addrspacecast i8 addrspace(1)* %897 to i8*
  %899 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %898, i32 noundef 3, i64 noundef %865, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  br label %.loopexit23

900:                                              ; preds = %890
  br i1 %887, label %901, label %910

901:                                              ; preds = %900
  %902 = add i32 %892, -256
  %903 = lshr i32 %902, 8
  %904 = zext i32 %903 to i64
  %905 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %904, i32 0
  %906 = cmpxchg i64 addrspace(1)* %905, i64 0, i64 %865 syncscope("agent-one-as") monotonic monotonic, align 8
  %907 = extractvalue { i64, i1 } %906, 1
  br i1 %907, label %908, label %910

908:                                              ; preds = %901
  %909 = atomicrmw add i32 addrspace(1)* %708, i32 256 syncscope("agent-one-as") release, align 4
  br label %910

910:                                              ; preds = %908, %901, %900
  %911 = phi i32 [ %883, %900 ], [ 0, %908 ], [ %883, %901 ]
  %912 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %911)
  %913 = icmp eq i32 %912, 0
  br i1 %913, label %.loopexit23, label %914

914:                                              ; preds = %910
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %882

.loopexit23:                                      ; preds = %910, %895, %894, %856, %845, %831
  %915 = phi i32 [ 2, %831 ], [ 1, %845 ], [ %847, %856 ], [ %883, %895 ], [ %883, %894 ], [ 0, %910 ]
  %916 = icmp eq i32 %915, 0
  br i1 %916, label %976, label %917

917:                                              ; preds = %.loopexit23
  %918 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %919 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %920 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %919, i32 0) #12
  %921 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %918, i32 %920) #12
  %922 = icmp eq i32 %921, 0
  br i1 %922, label %923, label %__ockl_rtcwait_u32.exit1

923:                                              ; preds = %917
  %924 = load atomic i64, i64 addrspace(1)* %709 syncscope("agent-one-as") monotonic, align 8
  %925 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %926 = sub i64 %925, %924
  %927 = icmp ult i64 %926, 30000
  br i1 %927, label %928, label %__ockl_rtcwait_u32.exit1

928:                                              ; preds = %923
  %929 = trunc i64 %926 to i32
  %930 = sub nuw nsw i32 30000, %929
  %931 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %932 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %930) #12
  %933 = sext i32 %932 to i64
  %934 = add i64 %931, %933
  %935 = add i64 %931, 1625
  %936 = icmp ugt i64 %934, %935
  br i1 %936, label %.preheader21, label %.loopexit22

.loopexit22:                                      ; preds = %.preheader21, %928
  %937 = phi i64 [ %931, %928 ], [ %940, %.preheader21 ]
  %938 = add i64 %937, 806
  %939 = icmp ugt i64 %934, %938
  br i1 %939, label %.preheader19, label %.loopexit20

.preheader21:                                     ; preds = %.preheader21, %928
  tail call void @llvm.amdgcn.s.sleep(i32 127) #12
  %940 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %941 = add i64 %940, 1625
  %942 = icmp ugt i64 %934, %941
  br i1 %942, label %.preheader21, label %.loopexit22

.loopexit20:                                      ; preds = %.preheader19, %.loopexit22
  %943 = phi i64 [ %937, %.loopexit22 ], [ %946, %.preheader19 ]
  %944 = add i64 %943, 396
  %945 = icmp ugt i64 %934, %944
  br i1 %945, label %.preheader17, label %.loopexit18

.preheader19:                                     ; preds = %.preheader19, %.loopexit22
  tail call void @llvm.amdgcn.s.sleep(i32 63) #12
  %946 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %947 = add i64 %946, 806
  %948 = icmp ugt i64 %934, %947
  br i1 %948, label %.preheader19, label %.loopexit20

.preheader17:                                     ; preds = %.preheader17, %.loopexit20
  tail call void @llvm.amdgcn.s.sleep(i32 31) #12
  %949 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %950 = add i64 %949, 396
  %951 = icmp ugt i64 %934, %950
  br i1 %951, label %.preheader17, label %.loopexit18

.loopexit18:                                      ; preds = %.preheader17, %.loopexit20
  %952 = phi i64 [ %943, %.loopexit20 ], [ %949, %.preheader17 ]
  %953 = add i64 %952, 192
  %954 = icmp ugt i64 %934, %953
  br i1 %954, label %.preheader15, label %.loopexit16

.loopexit16:                                      ; preds = %.preheader15, %.loopexit18
  %955 = phi i64 [ %952, %.loopexit18 ], [ %958, %.preheader15 ]
  %956 = add i64 %955, 89
  %957 = icmp ugt i64 %934, %956
  br i1 %957, label %.preheader13, label %.loopexit14

.preheader15:                                     ; preds = %.preheader15, %.loopexit18
  tail call void @llvm.amdgcn.s.sleep(i32 15) #12
  %958 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %959 = add i64 %958, 192
  %960 = icmp ugt i64 %934, %959
  br i1 %960, label %.preheader15, label %.loopexit16

.loopexit14:                                      ; preds = %.preheader13, %.loopexit16
  %961 = phi i64 [ %955, %.loopexit16 ], [ %964, %.preheader13 ]
  %962 = add i64 %961, 38
  %963 = icmp ugt i64 %934, %962
  br i1 %963, label %.preheader11, label %.loopexit12

.preheader13:                                     ; preds = %.preheader13, %.loopexit16
  tail call void @llvm.amdgcn.s.sleep(i32 7) #12
  %964 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %965 = add i64 %964, 89
  %966 = icmp ugt i64 %934, %965
  br i1 %966, label %.preheader13, label %.loopexit14

.loopexit12:                                      ; preds = %.preheader11, %.loopexit14
  %967 = phi i64 [ %961, %.loopexit14 ], [ %969, %.preheader11 ]
  %968 = icmp ugt i64 %934, %967
  br i1 %968, label %.preheader10, label %__ockl_rtcwait_u32.exit1

.preheader11:                                     ; preds = %.preheader11, %.loopexit14
  tail call void @llvm.amdgcn.s.sleep(i32 3) #12
  %969 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %970 = add i64 %969, 38
  %971 = icmp ugt i64 %934, %970
  br i1 %971, label %.preheader11, label %.loopexit12

.preheader10:                                     ; preds = %.preheader10, %.loopexit12
  tail call void @llvm.amdgcn.s.sleep(i32 1) #12
  %972 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %973 = icmp ugt i64 %934, %972
  br i1 %973, label %.preheader10, label %__ockl_rtcwait_u32.exit1

__ockl_rtcwait_u32.exit1:                         ; preds = %.preheader10, %.loopexit12, %923, %917
  %974 = icmp eq i32 %915, 2
  %975 = select i1 %974, %13 addrspace(1)* null, %13 addrspace(1)* inttoptr (i64 1 to %13 addrspace(1)*)
  br label %976

976:                                              ; preds = %__ockl_rtcwait_u32.exit1, %.loopexit23
  %977 = phi %13 addrspace(1)* [ %975, %__ockl_rtcwait_u32.exit1 ], [ %803, %.loopexit23 ]
  br i1 %916, label %978, label %.loopexit

978:                                              ; preds = %976, %818
  %979 = phi %13 addrspace(1)* [ %977, %976 ], [ %803, %818 ]
  br i1 %805, label %980, label %989

980:                                              ; preds = %978
  %981 = load atomic i64, i64 addrspace(1)* %710 syncscope("agent-one-as") monotonic, align 8
  %982 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %983 = sub i64 %982, %981
  %984 = icmp ugt i64 %983, 19999
  br i1 %984, label %985, label %989

985:                                              ; preds = %980
  %986 = cmpxchg i64 addrspace(1)* %710, i64 %981, i64 %982 syncscope("agent-one-as") monotonic monotonic, align 8
  %987 = extractvalue { i64, i1 } %986, 1
  %988 = select i1 %987, i8 addrspace(1)* null, i8 addrspace(1)* inttoptr (i64 1 to i8 addrspace(1)*)
  br label %989

989:                                              ; preds = %985, %980, %978
  %990 = phi i8 addrspace(1)* [ inttoptr (i64 1 to i8 addrspace(1)*), %978 ], [ inttoptr (i64 1 to i8 addrspace(1)*), %980 ], [ %988, %985 ]
  %991 = ptrtoint i8 addrspace(1)* %990 to i64
  %992 = trunc i64 %991 to i32
  %993 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %992)
  %994 = insertelement <2 x i32> undef, i32 %993, i64 0
  %995 = lshr i64 %991, 32
  %996 = trunc i64 %995 to i32
  %997 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %996)
  %998 = insertelement <2 x i32> %994, i32 %997, i64 1
  %999 = bitcast <2 x i32> %998 to i64
  %1000 = icmp eq i64 %999, 0
  br i1 %1000, label %1003, label %1001

1001:                                             ; preds = %989
  %1002 = inttoptr i64 %999 to %13 addrspace(1)*
  br label %.loopexit

1003:                                             ; preds = %989
  br i1 %805, label %1004, label %1017

1004:                                             ; preds = %1003
  %1005 = load atomic i64, i64 addrspace(1)* %54 syncscope("agent-one-as") monotonic, align 8
  %1006 = load i64, i64 addrspace(1)* %55, align 8, !tbaa !41
  %1007 = icmp ult i64 %1005, %1006
  br i1 %1007, label %1008, label %1011

1008:                                             ; preds = %1004
  %1009 = atomicrmw add i64 addrspace(1)* %54, i64 2097152 syncscope("agent-one-as") monotonic, align 8
  %1010 = icmp ult i64 %1009, %1006
  br i1 %1010, label %1017, label %1011

1011:                                             ; preds = %1008, %1004
  %1012 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %1013 = inttoptr i64 %1012 to i8 addrspace(1)*
  %1014 = addrspacecast i8 addrspace(1)* %1013 to i8*
  %1015 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %1014, i32 noundef 3, i64 noundef 0, i64 noundef 2097152, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  %1016 = extractelement <2 x i64> %1015, i64 0
  br label %1017

1017:                                             ; preds = %1011, %1008, %1003
  %1018 = phi i64 [ 0, %1003 ], [ %1016, %1011 ], [ %1009, %1008 ]
  %1019 = trunc i64 %1018 to i32
  %1020 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1019)
  %1021 = insertelement <2 x i32> undef, i32 %1020, i64 0
  %1022 = lshr i64 %1018, 32
  %1023 = trunc i64 %1022 to i32
  %1024 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1023)
  %1025 = insertelement <2 x i32> %1021, i32 %1024, i64 1
  %1026 = bitcast <2 x i32> %1025 to i64
  %1027 = icmp eq i64 %1026, 0
  br i1 %1027, label %.loopexit, label %1028

1028:                                             ; preds = %1017
  %1029 = inttoptr i64 %1026 to %14 addrspace(1)*
  %1030 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %1031 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %1032 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %1031, i32 0) #12
  %1033 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %1030, i32 %1032) #12
  %1034 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %1033) #13, !srcloc !38
  %1035 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %1036 = tail call i64 @llvm.ctpop.i64(i64 %1035), !range !35
  %1037 = trunc i64 %1036 to i32
  %1038 = load i32, i32 addrspace(4)* %711, align 4, !tbaa !43
  %1039 = load i32, i32 addrspace(4)* %712, align 4, !tbaa !44
  %1040 = add i32 %1039, 31
  %1041 = lshr i32 %1040, 5
  br i1 %715, label %1062, label %1042

1042:                                             ; preds = %1028
  %1043 = icmp ult i32 %1034, %1041
  br i1 %1043, label %.preheader8, label %.loopexit9

.loopexit9:                                       ; preds = %.preheader8, %1042
  %1044 = mul i32 %1038, %1037
  %1045 = load i32, i32 addrspace(4)* %716, align 4, !tbaa !45
  %1046 = mul i32 %1038, %1034
  %1047 = add i32 %1045, %1046
  %1048 = icmp ult i32 %1047, %1039
  br i1 %1048, label %.preheader6, label %.loopexit5

.preheader8:                                      ; preds = %.preheader8, %1042
  %1049 = phi i32 [ %1052, %.preheader8 ], [ %1034, %1042 ]
  %1050 = zext i32 %1049 to i64
  %1051 = getelementptr inbounds %14, %14 addrspace(1)* %1029, i64 0, i32 4, i64 %1050
  store i32 0, i32 addrspace(1)* %1051, align 4, !tbaa !13
  %1052 = add i32 %1049, %1037
  %1053 = icmp ult i32 %1052, %1041
  br i1 %1053, label %.preheader8, label %.loopexit9

.preheader6:                                      ; preds = %.preheader6, %.loopexit9
  %1054 = phi i32 [ %1060, %.preheader6 ], [ %1047, %.loopexit9 ]
  %1055 = and i32 %1054, 31
  %1056 = shl nuw i32 1, %1055
  %1057 = lshr i32 %1054, 5
  %1058 = zext i32 %1057 to i64
  %1059 = getelementptr inbounds %14, %14 addrspace(1)* %1029, i64 0, i32 4, i64 %1058
  store i32 %1056, i32 addrspace(1)* %1059, align 4, !tbaa !13
  %1060 = add i32 %1054, %1044
  %1061 = icmp ult i32 %1060, %1039
  br i1 %1061, label %.preheader6, label %.loopexit5

1062:                                             ; preds = %1028
  %1063 = load i32, i32 addrspace(4)* %717, align 4, !tbaa !46
  %1064 = icmp ult i32 %1034, %1041
  br i1 %1064, label %.preheader, label %.loopexit5

.preheader:                                       ; preds = %.preheader, %1062
  %1065 = phi i32 [ %1068, %.preheader ], [ %1034, %1062 ]
  %1066 = zext i32 %1065 to i64
  %1067 = getelementptr inbounds %14, %14 addrspace(1)* %1029, i64 0, i32 4, i64 %1066
  store i32 %1063, i32 addrspace(1)* %1067, align 4, !tbaa !13
  %1068 = add i32 %1065, %1037
  %1069 = icmp ult i32 %1068, %1041
  br i1 %1069, label %.preheader, label %.loopexit5

.loopexit5:                                       ; preds = %.preheader, %1062, %.preheader6, %.loopexit9
  %1070 = icmp eq i32 %1034, 0
  br i1 %1070, label %1071, label %1082

1071:                                             ; preds = %.loopexit5
  br i1 %718, label %1080, label %1072

1072:                                             ; preds = %1071
  %1073 = add nsw i32 %1041, -1
  %1074 = zext i32 %1073 to i64
  %1075 = getelementptr inbounds %14, %14 addrspace(1)* %1029, i64 0, i32 4, i64 %1074
  %1076 = and i32 %1039, 31
  %1077 = shl nsw i32 -1, %1076
  %1078 = load i32, i32 addrspace(1)* %1075, align 4, !tbaa !13
  %1079 = or i32 %1078, %1077
  store i32 %1079, i32 addrspace(1)* %1075, align 4, !tbaa !13
  br label %1080

1080:                                             ; preds = %1072, %1071
  %1081 = inttoptr i64 %1026 to <4 x i32> addrspace(1)*
  store <4 x i32> %719, <4 x i32> addrspace(1)* %1081, align 16, !tbaa !29
  br label %1082

1082:                                             ; preds = %1080, %.loopexit5
  %1083 = getelementptr inbounds %14, %14 addrspace(1)* %1029, i64 0, i32 1
  br label %1084

1084:                                             ; preds = %1146, %1082
  %1085 = phi i32 [ %820, %1082 ], [ %1101, %1146 ]
  %1086 = phi i32 [ %810, %1082 ], [ %1094, %1146 ]
  %1087 = phi i32 [ %804, %1082 ], [ %1088, %1146 ]
  %1088 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %1087) #13, !srcloc !38
  %1089 = icmp eq i32 %1088, 0
  br i1 %1089, label %1090, label %1092

1090:                                             ; preds = %1084
  %1091 = load atomic i32, i32 addrspace(1)* %707 syncscope("agent-one-as") monotonic, align 8
  br label %1092

1092:                                             ; preds = %1090, %1084
  %1093 = phi i32 [ %1091, %1090 ], [ %1086, %1084 ]
  %1094 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1093)
  %1095 = icmp eq i32 %1094, 65792
  br i1 %1095, label %.loopexit, label %1096

1096:                                             ; preds = %1092
  br i1 %1089, label %1097, label %1099

1097:                                             ; preds = %1096
  %1098 = load atomic i32, i32 addrspace(1)* %708 syncscope("agent-one-as") monotonic, align 8
  br label %1099

1099:                                             ; preds = %1097, %1096
  %1100 = phi i32 [ %1098, %1097 ], [ %1085, %1096 ]
  %1101 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1100)
  %1102 = icmp eq i32 %1094, %1101
  br i1 %1102, label %1103, label %1109

1103:                                             ; preds = %1099
  br i1 %1089, label %1104, label %.loopexit

1104:                                             ; preds = %1103
  %1105 = load i64, i64 addrspace(4)* %73, align 8, !tbaa !15
  %1106 = inttoptr i64 %1105 to i8 addrspace(1)*
  %1107 = addrspacecast i8 addrspace(1)* %1106 to i8*
  %1108 = tail call fastcc <2 x i64> @__ockl_hostcall_internal(i8* noundef %1107, i32 noundef 3, i64 noundef %1026, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0, i64 noundef 0) #13
  br label %.loopexit

1109:                                             ; preds = %1099
  br i1 %1089, label %1110, label %1132

1110:                                             ; preds = %1109
  %1111 = icmp ugt i32 %1094, 255
  br i1 %1111, label %1112, label %1122

1112:                                             ; preds = %1110
  %1113 = add i32 %1094, -256
  %1114 = lshr i32 %1113, 8
  %1115 = zext i32 %1114 to i64
  %1116 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %1115, i32 0
  %1117 = load atomic i64, i64 addrspace(1)* %1116 syncscope("agent-one-as") monotonic, align 8
  %1118 = inttoptr i64 %1117 to %13 addrspace(1)*
  %1119 = and i32 %1094, 255
  %1120 = zext i32 %1119 to i64
  %1121 = getelementptr inbounds %13, %13 addrspace(1)* %1118, i64 %1120
  br label %1125

1122:                                             ; preds = %1110
  %1123 = zext i32 %1094 to i64
  %1124 = getelementptr inbounds %10, %10 addrspace(1)* %53, i64 0, i32 5, i64 %704, i64 %1123
  br label %1125

1125:                                             ; preds = %1122, %1112
  %1126 = phi %13 addrspace(1)* [ %1121, %1112 ], [ %1124, %1122 ]
  store i32 %1094, i32 addrspace(1)* %1083, align 4, !tbaa !47
  %1127 = getelementptr inbounds %13, %13 addrspace(1)* %1126, i64 0, i32 1
  %1128 = cmpxchg i64 addrspace(1)* %1127, i64 0, i64 %1026 syncscope("agent-one-as") monotonic monotonic, align 8
  %1129 = extractvalue { i64, i1 } %1128, 1
  br i1 %1129, label %1130, label %1132

1130:                                             ; preds = %1125
  %1131 = atomicrmw add i32 addrspace(1)* %707, i32 1 syncscope("agent-one-as") release, align 4
  br label %1132

1132:                                             ; preds = %1130, %1125, %1109
  %1133 = phi %13 addrspace(1)* [ null, %1109 ], [ %1126, %1130 ], [ null, %1125 ]
  %1134 = ptrtoint %13 addrspace(1)* %1133 to i64
  %1135 = trunc i64 %1134 to i32
  %1136 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1135)
  %1137 = insertelement <2 x i32> undef, i32 %1136, i64 0
  %1138 = lshr i64 %1134, 32
  %1139 = trunc i64 %1138 to i32
  %1140 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1139)
  %1141 = insertelement <2 x i32> %1137, i32 %1140, i64 1
  %1142 = bitcast <2 x i32> %1141 to i64
  %1143 = icmp eq i64 %1142, 0
  br i1 %1143, label %1146, label %1144

1144:                                             ; preds = %1132
  %1145 = inttoptr i64 %1142 to %13 addrspace(1)*
  br label %.loopexit

1146:                                             ; preds = %1132
  tail call void @llvm.amdgcn.s.sleep(i32 2)
  br label %1084

.loopexit:                                        ; preds = %1144, %1104, %1103, %1092, %1017, %1001, %976, %808
  %1147 = phi i1 [ false, %1001 ], [ true, %1104 ], [ true, %1103 ], [ false, %1017 ], [ false, %1144 ], [ false, %808 ], [ false, %976 ], [ false, %1092 ]
  %1148 = phi i32 [ %804, %1001 ], [ 0, %1104 ], [ %1088, %1103 ], [ %804, %1017 ], [ %1088, %1144 ], [ %804, %808 ], [ %804, %976 ], [ %1088, %1092 ]
  %1149 = phi %13 addrspace(1)* [ %1002, %1001 ], [ %979, %1104 ], [ %979, %1103 ], [ null, %1017 ], [ %1145, %1144 ], [ null, %808 ], [ %977, %976 ], [ null, %1092 ]
  br i1 %1147, label %801, label %1150

1150:                                             ; preds = %.loopexit
  %1151 = icmp eq %13 addrspace(1)* %1149, inttoptr (i64 1 to %13 addrspace(1)*)
  br i1 %1151, label %1152, label %1215

1152:                                             ; preds = %1150
  %1153 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %1154 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %1155 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %1154, i32 0) #12
  %1156 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %1153, i32 %1155) #12
  %1157 = icmp eq i32 %1156, 0
  br i1 %1157, label %1158, label %__ockl_rtcwait_u32.exit

1158:                                             ; preds = %1152
  %1159 = load atomic i64, i64 addrspace(1)* %710 syncscope("agent-one-as") monotonic, align 8
  %1160 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1161 = sub i64 %1160, %1159
  %1162 = icmp ult i64 %1161, 20000
  br i1 %1162, label %1163, label %__ockl_rtcwait_u32.exit

1163:                                             ; preds = %1158
  %1164 = trunc i64 %1161 to i32
  %1165 = sub nuw nsw i32 20000, %1164
  %1166 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1167 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1165) #12
  %1168 = sext i32 %1167 to i64
  %1169 = add i64 %1166, %1168
  %1170 = add i64 %1166, 1625
  %1171 = icmp ugt i64 %1169, %1170
  br i1 %1171, label %.preheader60, label %.loopexit61

.loopexit61:                                      ; preds = %.preheader60, %1163
  %1172 = phi i64 [ %1166, %1163 ], [ %1175, %.preheader60 ]
  %1173 = add i64 %1172, 806
  %1174 = icmp ugt i64 %1169, %1173
  br i1 %1174, label %.preheader58, label %.loopexit59

.preheader60:                                     ; preds = %.preheader60, %1163
  tail call void @llvm.amdgcn.s.sleep(i32 127) #12
  %1175 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1176 = add i64 %1175, 1625
  %1177 = icmp ugt i64 %1169, %1176
  br i1 %1177, label %.preheader60, label %.loopexit61

.loopexit59:                                      ; preds = %.preheader58, %.loopexit61
  %1178 = phi i64 [ %1172, %.loopexit61 ], [ %1181, %.preheader58 ]
  %1179 = add i64 %1178, 396
  %1180 = icmp ugt i64 %1169, %1179
  br i1 %1180, label %.preheader56, label %.loopexit57

.preheader58:                                     ; preds = %.preheader58, %.loopexit61
  tail call void @llvm.amdgcn.s.sleep(i32 63) #12
  %1181 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1182 = add i64 %1181, 806
  %1183 = icmp ugt i64 %1169, %1182
  br i1 %1183, label %.preheader58, label %.loopexit59

.preheader56:                                     ; preds = %.preheader56, %.loopexit59
  tail call void @llvm.amdgcn.s.sleep(i32 31) #12
  %1184 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1185 = add i64 %1184, 396
  %1186 = icmp ugt i64 %1169, %1185
  br i1 %1186, label %.preheader56, label %.loopexit57

.loopexit57:                                      ; preds = %.preheader56, %.loopexit59
  %1187 = phi i64 [ %1178, %.loopexit59 ], [ %1184, %.preheader56 ]
  %1188 = add i64 %1187, 192
  %1189 = icmp ugt i64 %1169, %1188
  br i1 %1189, label %.preheader54, label %.loopexit55

.loopexit55:                                      ; preds = %.preheader54, %.loopexit57
  %1190 = phi i64 [ %1187, %.loopexit57 ], [ %1193, %.preheader54 ]
  %1191 = add i64 %1190, 89
  %1192 = icmp ugt i64 %1169, %1191
  br i1 %1192, label %.preheader52, label %.loopexit53

.preheader54:                                     ; preds = %.preheader54, %.loopexit57
  tail call void @llvm.amdgcn.s.sleep(i32 15) #12
  %1193 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1194 = add i64 %1193, 192
  %1195 = icmp ugt i64 %1169, %1194
  br i1 %1195, label %.preheader54, label %.loopexit55

.loopexit53:                                      ; preds = %.preheader52, %.loopexit55
  %1196 = phi i64 [ %1190, %.loopexit55 ], [ %1199, %.preheader52 ]
  %1197 = add i64 %1196, 38
  %1198 = icmp ugt i64 %1169, %1197
  br i1 %1198, label %.preheader50, label %.loopexit51

.preheader52:                                     ; preds = %.preheader52, %.loopexit55
  tail call void @llvm.amdgcn.s.sleep(i32 7) #12
  %1199 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1200 = add i64 %1199, 89
  %1201 = icmp ugt i64 %1169, %1200
  br i1 %1201, label %.preheader52, label %.loopexit53

.loopexit51:                                      ; preds = %.preheader50, %.loopexit53
  %1202 = phi i64 [ %1196, %.loopexit53 ], [ %1204, %.preheader50 ]
  %1203 = icmp ugt i64 %1169, %1202
  br i1 %1203, label %.preheader49, label %__ockl_rtcwait_u32.exit

.preheader50:                                     ; preds = %.preheader50, %.loopexit53
  tail call void @llvm.amdgcn.s.sleep(i32 3) #12
  %1204 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1205 = add i64 %1204, 38
  %1206 = icmp ugt i64 %1169, %1205
  br i1 %1206, label %.preheader50, label %.loopexit51

.preheader49:                                     ; preds = %.preheader49, %.loopexit51
  tail call void @llvm.amdgcn.s.sleep(i32 1) #12
  %1207 = tail call i64 @llvm.amdgcn.s.memrealtime() #12
  %1208 = icmp ugt i64 %1169, %1207
  br i1 %1208, label %.preheader49, label %__ockl_rtcwait_u32.exit

__ockl_rtcwait_u32.exit:                          ; preds = %.preheader49, %.loopexit51, %1158, %1152
  %1209 = icmp eq i32 %724, 0
  br i1 %1209, label %1210, label %1212

1210:                                             ; preds = %__ockl_rtcwait_u32.exit
  %1211 = load atomic i32, i32 addrspace(1)* %707 syncscope("agent-one-as") monotonic, align 8
  br label %1212

1212:                                             ; preds = %1210, %__ockl_rtcwait_u32.exit
  %1213 = phi i32 [ %1211, %1210 ], [ %722, %__ockl_rtcwait_u32.exit ]
  %1214 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1213)
  br label %1215

1215:                                             ; preds = %1212, %1150
  %1216 = phi i32 [ %1214, %1212 ], [ %722, %1150 ]
  %1217 = phi %13 addrspace(1)* [ %796, %1212 ], [ %1149, %1150 ]
  br i1 %1151, label %720, label %.loopexit62

.loopexit62:                                      ; preds = %1215, %790, %692, %681, %675
  %1218 = phi i1 [ false, %681 ], [ true, %692 ], [ false, %790 ], [ false, %1215 ], [ false, %675 ]
  %1219 = phi i32 [ %604, %681 ], [ %683, %692 ], [ %48, %790 ], [ %48, %1215 ], [ %604, %675 ]
  %1220 = phi %13 addrspace(1)* [ null, %681 ], [ %678, %692 ], [ %793, %790 ], [ %1217, %1215 ], [ %678, %675 ]
  br i1 %1218, label %.preheader84, label %.loopexit77

.loopexit77:                                      ; preds = %.loopexit62, %601, %176
  %1221 = phi %13 addrspace(1)* [ %179, %176 ], [ %603, %601 ], [ %1220, %.loopexit62 ]
  %1222 = ptrtoint %13 addrspace(1)* %1221 to i64
  %1223 = trunc i64 %1222 to i32
  %1224 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1223)
  %1225 = insertelement <2 x i32> undef, i32 %1224, i64 0
  %1226 = lshr i64 %1222, 32
  %1227 = trunc i64 %1226 to i32
  %1228 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1227)
  %1229 = insertelement <2 x i32> %1225, i32 %1228, i64 1
  %1230 = bitcast <2 x i32> %1229 to i64
  %1231 = icmp eq i64 %1230, 0
  br i1 %1231, label %1330, label %1232

1232:                                             ; preds = %.loopexit77
  %1233 = inttoptr i64 %1230 to %13 addrspace(1)*
  %1234 = tail call i32 @llvm.read_register.i32(metadata !33) #13
  %1235 = tail call i32 @llvm.read_register.i32(metadata !34) #13
  %1236 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 %1235, i32 0) #12
  %1237 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 %1234, i32 %1236) #12
  %1238 = tail call i32 asm sideeffect "; O0 $0", "=v,0"(i32 %1237) #13, !srcloc !38
  %1239 = tail call i64 @llvm.read_register.i64(metadata !23) #14
  %1240 = getelementptr inbounds %13, %13 addrspace(1)* %1233, i64 0, i32 1
  %1241 = load atomic i64, i64 addrspace(1)* %1240 seq_cst, align 8, !tbaa !50
  %1242 = inttoptr i64 %1241 to %14 addrspace(1)*
  %1243 = getelementptr inbounds %14, %14 addrspace(1)* %1242, i64 0, i32 0
  %1244 = load i32, i32 addrspace(1)* %1243, align 4, !tbaa !52
  %1245 = icmp eq i32 %1238, 0
  br i1 %1245, label %1246, label %1251

1246:                                             ; preds = %1232
  %1247 = tail call i64 @llvm.ctpop.i64(i64 %1239), !range !35
  %1248 = trunc i64 %1247 to i32
  %1249 = getelementptr inbounds %14, %14 addrspace(1)* %1242, i64 0, i32 2
  %1250 = atomicrmw add i32 addrspace(1)* %1249, i32 %1248 syncscope("agent-one-as") monotonic, align 4
  br label %1251

1251:                                             ; preds = %1246, %1232
  %1252 = phi i32 [ %1250, %1246 ], [ 0, %1232 ]
  %1253 = tail call i32 @llvm.amdgcn.readfirstlane(i32 %1252)
  %1254 = zext i32 %1244 to i64
  %1255 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %1254, i32 0
  %1256 = load i32, i32 addrspace(4)* %1255, align 4, !tbaa !44
  %1257 = add i32 %1256, 31
  %1258 = lshr i32 %1257, 5
  %1259 = icmp ult i32 %1257, 32
  br i1 %1259, label %.loopexit81, label %1260

1260:                                             ; preds = %1251
  %1261 = add i32 %1253, %1238
  %1262 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %1254, i32 7
  %1263 = load i32, i32 addrspace(4)* %1262, align 4, !tbaa !53
  %1264 = mul i32 %1263, %1261
  %1265 = urem i32 %1264, %1256
  %1266 = lshr i32 %1265, 5
  %1267 = inttoptr i64 %1241 to i8 addrspace(1)*
  %1268 = getelementptr inbounds [16 x %0], [16 x %0] addrspace(4)* @0, i64 0, i64 %1254, i32 3
  %1269 = lshr i32 %1244, 1
  %1270 = add nuw i32 %1269, 4
  %1271 = and i32 %1270, 31
  %1272 = shl nuw i32 1, %1271
  %1273 = and i32 %1244, 1
  %1274 = icmp eq i32 %1273, 0
  %1275 = lshr i32 %1272, 1
  %1276 = select i1 %1274, i32 0, i32 %1275
  %1277 = add nuw i32 %1276, %1272
  %1278 = tail call i32 @llvm.umax.i32(i32 %1258, i32 1)
  br label %1279

1279:                                             ; preds = %1311, %1260
  %1280 = phi i32 [ %1266, %1260 ], [ %1314, %1311 ]
  %1281 = phi i8 addrspace(1)* [ null, %1260 ], [ %1313, %1311 ]
  %1282 = phi i32 [ 0, %1260 ], [ %1316, %1311 ]
  %1283 = zext i32 %1280 to i64
  %1284 = getelementptr inbounds %14, %14 addrspace(1)* %1242, i64 0, i32 4, i64 %1283
  %1285 = load atomic i32, i32 addrspace(1)* %1284 syncscope("agent-one-as") monotonic, align 4
  %1286 = icmp eq i32 %1285, -1
  br i1 %1286, label %1307, label %1287

1287:                                             ; preds = %1279
  %1288 = xor i32 %1285, -1
  %1289 = tail call i32 @llvm.cttz.i32(i32 %1288, i1 false) #12, !range !36
  %1290 = and i32 %1289, 31
  %1291 = shl nuw i32 1, %1290
  %1292 = atomicrmw or i32 addrspace(1)* %1284, i32 %1291 syncscope("agent-one-as") monotonic, align 4
  %1293 = and i32 %1292, %1291
  %1294 = icmp eq i32 %1293, 0
  br i1 %1294, label %1295, label %1304

1295:                                             ; preds = %1287
  %1296 = shl i32 %1280, 5
  %1297 = add i32 %1289, %1296
  %1298 = mul i32 %1297, %1277
  %1299 = zext i32 %1298 to i64
  %1300 = load i32, i32 addrspace(4)* %1268, align 4, !tbaa !54
  %1301 = zext i32 %1300 to i64
  %1302 = getelementptr inbounds i8, i8 addrspace(1)* %1267, i64 %1301
  %1303 = getelementptr inbounds i8, i8 addrspace(1)* %1302, i64 %1299
  br label %1304

1304:                                             ; preds = %1295, %1287
  %1305 = phi i32 [ 2, %1295 ], [ 0, %1287 ]
  %1306 = phi i8 addrspace(1)* [ %1303, %1295 ], [ %1281, %1287 ]
  br i1 %1294, label %1311, label %1307

1307:                                             ; preds = %1304, %1279
  %1308 = phi i8 addrspace(1)* [ %1306, %1304 ], [ %1281, %1279 ]
  %1309 = add i32 %1280, 1
  %1310 = urem i32 %1309, %1258
  br label %1311

1311:                                             ; preds = %1307, %1304
  %1312 = phi i32 [ 0, %1307 ], [ %1305, %1304 ]
  %1313 = phi i8 addrspace(1)* [ %1308, %1307 ], [ %1306, %1304 ]
  %1314 = phi i32 [ %1310, %1307 ], [ %1280, %1304 ]
  %1315 = icmp ne i32 %1312, 0
  %1316 = add nuw nsw i32 %1282, 1
  %1317 = icmp eq i32 %1316, %1278
  %1318 = select i1 %1315, i1 true, i1 %1317
  br i1 %1318, label %.loopexit81, label %1279

.loopexit81:                                      ; preds = %1311, %1251
  %1319 = phi i8 addrspace(1)* [ null, %1251 ], [ %1313, %1311 ]
  %1320 = ptrtoint i8 addrspace(1)* %1319 to i64
  %1321 = tail call i64 @llvm.amdgcn.icmp.i64.i64(i64 noundef %1320, i64 noundef 0, i32 noundef 33) #15
  br i1 %1245, label %1322, label %1327

1322:                                             ; preds = %.loopexit81
  %1323 = tail call i64 @llvm.ctpop.i64(i64 %1321), !range !35
  %1324 = trunc i64 %1323 to i32
  %1325 = getelementptr inbounds %13, %13 addrspace(1)* %1233, i64 0, i32 2
  %1326 = atomicrmw add i32 addrspace(1)* %1325, i32 %1324 syncscope("agent-one-as") monotonic, align 4
  br label %1327

1327:                                             ; preds = %1322, %.loopexit81
  %1328 = icmp eq i8 addrspace(1)* %1319, null
  br i1 %1328, label %1330, label %1329

1329:                                             ; preds = %1327
  br label %1330

1330:                                             ; preds = %1329, %1327, %.loopexit77, %.preheader86
  %1331 = phi i32 [ %82, %.preheader86 ], [ 0, %1329 ], [ %82, %1327 ], [ 0, %.loopexit77 ]
  %1332 = phi i32 [ 0, %.preheader86 ], [ 0, %1329 ], [ %85, %1327 ], [ 0, %.loopexit77 ]
  %1333 = phi i8 addrspace(1)* [ %84, %.preheader86 ], [ %1319, %1329 ], [ null, %1327 ], [ %84, %.loopexit77 ]
  %1334 = tail call i32 asm sideeffect "; ockl ballot hoisting hack $0", "=v,0"(i32 %1332) #13, !srcloc !55
  %1335 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 noundef %1334, i32 noundef 0, i32 noundef 33) #15
  %.not4 = icmp eq i64 %1335, 0
  br i1 %.not4, label %.loopexit87, label %.preheader86

.loopexit87:                                      ; preds = %1330, %79, %74
  %1336 = phi i32 [ 0, %74 ], [ %77, %79 ], [ %1331, %1330 ]
  %1337 = phi i8 addrspace(1)* [ %76, %74 ], [ %76, %79 ], [ %1333, %1330 ]
  %1338 = tail call i32 asm sideeffect "; ockl ballot hoisting hack $0", "=v,0"(i32 %1336) #13, !srcloc !55
  %1339 = tail call i64 @llvm.amdgcn.icmp.i64.i32(i32 noundef %1338, i32 noundef 0, i32 noundef 33) #15
  %.not = icmp eq i64 %1339, 0
  br i1 %.not, label %.loopexit88, label %74

.loopexit88:                                      ; preds = %.loopexit87, %30, %1
  %1340 = phi i8 addrspace(1)* [ %31, %30 ], [ null, %1 ], [ %1337, %.loopexit87 ]
  ret void
}

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #10

; Function Attrs: alwaysinline nounwind readonly
declare i32 @llvm.read_register.i32(metadata) #7

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umax.i32(i32, i32) #10

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i64 @llvm.amdgcn.icmp.i64.i32(i32, i32, i32 immarg) #3

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.ds.bpermute(i32, i32) #3

; Function Attrs: alwaysinline convergent nounwind readnone willreturn
declare i64 @llvm.amdgcn.icmp.i64.i64(i64, i64, i32 immarg) #3

; Function Attrs: alwaysinline nounwind willreturn
declare i64 @llvm.amdgcn.s.memrealtime() #4

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.cttz.i32(i32, i1 immarg) #10

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.cttz.i64(i64, i1 immarg) #10

; Function Attrs: alwaysinline nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #10

;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `mm`
define amdgpu_kernel void @_Z2mm({ i64, i64, i64, i64, i64, i64, i32, i32 } %state) local_unnamed_addr #11 !dbg !56 {
conversion:
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:370 within `mm`
; ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl:4 within `#dm_alloc`
   call fastcc void @__ockl_dm_alloc(i64 128), !dbg !59
; └
;  @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:372 within `mm`
  ret void, !dbg !63
}

attributes #0 = { alwaysinline nounwind readnone speculatable willreturn }
attributes #1 = { convergent noinline norecurse nounwind optnone "frame-pointer"="none" "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { alwaysinline argmemonly nofree nosync nounwind willreturn }
attributes #3 = { alwaysinline convergent nounwind readnone willreturn }
attributes #4 = { alwaysinline nounwind willreturn }
attributes #5 = { convergent norecurse nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #6 = { alwaysinline nounwind }
attributes #7 = { alwaysinline nounwind readonly }
attributes #8 = { alwaysinline nounwind readnone willreturn }
attributes #9 = { convergent noinline norecurse nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #10 = { alwaysinline nofree nosync nounwind readnone speculatable willreturn }
attributes #11 = { "frame-pointer"="all" "probe-stack"="inline-asm" }
attributes #12 = { nounwind }
attributes #13 = { convergent nounwind }
attributes #14 = { convergent }
attributes #15 = { convergent nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.dbg.cu = !{!4}
!opencl.ocl.version = !{!6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6, !6}
!llvm.ident = !{!7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7}
!julia.kernel = !{!8}

!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"PIC Level", i32 1}
!4 = distinct !DICompileUnit(language: DW_LANG_Julia, file: !5, producer: "julia", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, nameTableKind: None)
!5 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl", directory: ".")
!6 = !{i32 2, i32 0}
!7 = !{!"AMD clang version 15.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.4.3 23045 a29fe425c7b0e5aba97ed2f95f61fd5ecba68aed)"}
!8 = !{void ({ i64, i64, i64, i64, i64, i64, i32, i32 })* @_Z2mm}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !11, i64 0}
!15 = !{!16, !16, i64 0}
!16 = !{!"long", !11, i64 0}
!17 = !{i64 2662}
!18 = !{!19, !10, i64 0}
!19 = !{!"", !10, i64 0, !10, i64 8, !20, i64 16, !16, i64 24, !16, i64 32, !16, i64 40}
!20 = !{!"hsa_signal_s", !16, i64 0}
!21 = !{!19, !16, i64 40}
!22 = !{!19, !10, i64 8}
!23 = !{!"exec"}
!24 = !{!25, !14, i64 16}
!25 = !{!"", !16, i64 0, !16, i64 8, !14, i64 16, !14, i64 20}
!26 = !{!25, !16, i64 8}
!27 = !{!25, !14, i64 20}
!28 = !{!25, !16, i64 0}
!29 = !{!11, !11, i64 0}
!30 = !{!31, !16, i64 16}
!31 = !{!"amd_signal_s", !16, i64 0, !11, i64 8, !16, i64 16, !14, i64 24, !14, i64 28, !16, i64 32, !16, i64 40, !11, i64 48, !11, i64 56}
!32 = !{!31, !14, i64 24}
!33 = !{!"exec_hi"}
!34 = !{!"exec_lo"}
!35 = !{i64 0, i64 65}
!36 = !{i32 0, i32 33}
!37 = !{i64 7014}
!38 = !{i64 7137}
!39 = !{!40, !14, i64 8}
!40 = !{!"kind_info_s", !14, i64 0, !14, i64 4, !14, i64 8, !14, i64 12, !14, i64 16, !14, i64 20, !14, i64 24, !14, i64 28}
!41 = !{!42, !16, i64 108552}
!42 = !{!"heap_s", !11, i64 0, !11, i64 2048, !11, i64 4096, !11, i64 6144, !11, i64 8192, !11, i64 10240, !11, i64 108544, !16, i64 108552, !11, i64 108560, !11, i64 108672}
!43 = !{!40, !14, i64 20}
!44 = !{!40, !14, i64 0}
!45 = !{!40, !14, i64 16}
!46 = !{!40, !14, i64 24}
!47 = !{!48, !14, i64 4}
!48 = !{!"slab_s", !14, i64 0, !14, i64 4, !11, i64 8, !14, i64 12, !11, i64 16}
!49 = !{!40, !14, i64 4}
!50 = !{!51, !11, i64 8}
!51 = !{!"sdata_s", !11, i64 0, !11, i64 8, !11, i64 16}
!52 = !{!48, !14, i64 0}
!53 = !{!40, !14, i64 28}
!54 = !{!40, !14, i64 12}
!55 = !{i64 751}
!56 = distinct !DISubprogram(name: "mm", linkageName: "julia_mm_1664", scope: null, file: !5, line: 369, type: !57, scopeLine: 369, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !58)
!57 = !DISubroutineType(types: !58)
!58 = !{}
!59 = !DILocation(line: 4, scope: !60, inlinedAt: !62)
!60 = distinct !DISubprogram(name: "#dm_alloc;", linkageName: "#dm_alloc", scope: !61, file: !61, type: !57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !4, retainedNodes: !58)
!61 = !DIFile(filename: "/home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/memory_dynamic.jl", directory: ".")
!62 = !DILocation(line: 370, scope: !56)
!63 = !DILocation(line: 372, scope: !56)
