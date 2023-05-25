CodeInfo(
     @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:367 within `set_one!`
    ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:124 within `workitemIdx`
    │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_x`
    ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
    │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
1 ──││││ %1  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   ││││ %2  = Base.llvmcall(%1, UInt32, Tuple{})::UInt32
│   ││└└
│   ││┌ @ int.jl:1042 within `+` @ int.jl:87
│   │││ %3  = Base.add_int(%2, 0x00000001)::UInt32
│   │└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_y`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %4  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%4, UInt32, Tuple{})::UInt32
│   │└└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `workitemIdx_z`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %6  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%6, UInt32, Tuple{})::UInt32
│   └└└└
│   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:132 within `workgroupIdx`
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_x`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %8  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│   ││││ %9  = Base.llvmcall(%8, UInt32, Tuple{})::UInt32
│   ││└└
│   ││┌ @ int.jl:1042 within `+` @ int.jl:87
│   │││ %10 = Base.add_int(%9, 0x00000001)::UInt32
│   │└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_y`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %11 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%11, UInt32, Tuple{})::UInt32
│   │└└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `workgroupIdx_z`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %13 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%13, UInt32, Tuple{})::UInt32
│   └└└└
│   ┌ @ int.jl:1040 within `-`
│   │┌ @ int.jl:525 within `rem`
│   ││┌ @ number.jl:7 within `convert`
│   │││┌ @ boot.jl:784 within `Int64`
│   ││││┌ @ boot.jl:708 within `toInt64`
│   │││││ %15 = Core.zext_int(Core.Int64, %10)::Int64
│   │└└└└
│   │ @ int.jl:1042 within `-` @ int.jl:86
│   │ %16 = Base.sub_int(%15, 1)::Int64
│   └
│   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:140 within `workgroupDim`
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_x`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %17 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()\n  %1 = getelementptr inbounds i8, i8 addrspace(4)* %0, i64 4\n  %2 = bitcast i8 addrspace(4)* %1 to i16 addrspace(4)*\n  %3 = load i16, i16 addrspace(4)* %2, align 2, !range !0\n  %4 = zext i16 %3 to i32\n  ret i32 %4\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i16 0, i16 1023}\n", "entry")::Tuple{String, String}
│   ││││ %18 = Base.llvmcall(%17, UInt32, Tuple{})::UInt32
│   │└└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_y`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %19 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()\n  %1 = getelementptr inbounds i8, i8 addrspace(4)* %0, i64 6\n  %2 = bitcast i8 addrspace(4)* %1 to i16 addrspace(4)*\n  %3 = load i16, i16 addrspace(4)* %2, align 2, !range !0\n  %4 = zext i16 %3 to i32\n  ret i32 %4\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i16 0, i16 1023}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%19, UInt32, Tuple{})::UInt32
│   │└└└
│   │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:103 within `workgroupDim_z`
│   ││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `_dim`
│   │││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:33 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %21 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()\n  %1 = getelementptr inbounds i8, i8 addrspace(4)* %0, i64 8\n  %2 = bitcast i8 addrspace(4)* %1 to i16 addrspace(4)*\n  %3 = load i16, i16 addrspace(4)* %2, align 2, !range !0\n  %4 = zext i16 %3 to i32\n  ret i32 %4\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare align 4 i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i16 0, i16 1023}\n", "entry")::Tuple{String, String}
│   ││││       Base.llvmcall(%21, UInt32, Tuple{})::UInt32
│   └└└└
│   ┌ @ int.jl:1040 within `*`
│   │┌ @ int.jl:525 within `rem`
│   ││┌ @ number.jl:7 within `convert`
│   │││┌ @ boot.jl:784 within `Int64`
│   ││││┌ @ boot.jl:708 within `toInt64`
│   │││││ %23 = Core.zext_int(Core.Int64, %18)::Int64
│   │└└└└
│   │ @ int.jl:1042 within `*` @ int.jl:88
│   │ %24 = Base.mul_int(%16, %23)::Int64
│   └
│   ┌ @ int.jl:1040 within `+`
│   │┌ @ int.jl:525 within `rem`
│   ││┌ @ number.jl:7 within `convert`
│   │││┌ @ boot.jl:784 within `Int64`
│   ││││┌ @ boot.jl:708 within `toInt64`
│   │││││ %25 = Core.zext_int(Core.Int64, %3)::Int64
│   │└└└└
│   │ @ int.jl:1042 within `+` @ int.jl:87
│   │ %26 = Base.add_int(%25, %24)::Int64
│   └
│    @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:368 within `set_one!`
│   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:87 within `#getindex`
└───│       goto #6 if not true
    │┌ @ abstractarray.jl:707 within `checkbounds`
2 ──││ %28 = Core.tuple(%26)::Tuple{Int64}
│   ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│   ││┌ @ abstractarray.jl:382 within `eachindex`
│   │││┌ @ abstractarray.jl:133 within `axes1`
│   ││││┌ @ abstractarray.jl:98 within `axes`
│   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
│   ││││││┌ @ Base.jl:37 within `getproperty`
│   │││││││ %29 = Base.getfield(x, :shape)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:273 within `map`
│   ││││││┌ @ tuple.jl:29 within `getindex`
│   │││││││ %30 = Base.getfield(%29, 1, true)::Int64
│   ││││││└
│   ││││││┌ @ range.jl:459 within `oneto`
│   │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│   ││││││││┌ @ promotion.jl:510 within `max`
│   │││││││││┌ @ int.jl:83 within `<`
│   ││││││││││ %31 = Base.slt_int(%30, 0)::Bool
│   │││││││││└
│   │││││││││┌ @ essentials.jl:575 within `ifelse`
│   ││││││││││ %32 = Core.ifelse(%31, 0, %30)::Int64
│   ││└└└└└└└└
│   ││┌ @ abstractarray.jl:768 within `checkindex`
│   │││┌ @ int.jl:488 within `<=`
│   ││││ %33 = Base.sle_int(1, %26)::Bool
│   ││││ %34 = Base.sle_int(%26, %32)::Bool
│   │││└
│   │││┌ @ bool.jl:38 within `&`
│   ││││ %35 = Base.and_int(%33, %34)::Bool
│   ││└└
│   ││ @ abstractarray.jl:709 within `checkbounds`
└───││       goto #4 if not %35
    ││ @ abstractarray.jl:710 within `checkbounds`
3 ──││       goto #5
    ││ @ abstractarray.jl:709 within `checkbounds`
4 ──││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int32, 1}, %28::Tuple{Int64})::Union{}
└───││       unreachable
5 ──││       nothing::Nothing
    │└
    │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:89 within `#getindex`
    │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
    ││┌ @ Base.jl:37 within `getproperty`
6 ┄─│││ %41 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int32, 1}
│   │└└
│   │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:85 within `unsafe_load`
│   ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `pointerref`
│   │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %42 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry(i8 addrspace(1)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(1)* %0 to i32 addrspace(1)*\n  %3 = getelementptr inbounds i32, i32 addrspace(1)* %2, i64 %1\n  %4 = load i32, i32 addrspace(1)* %3, align 4, !tbaa !0\n  ret i32 %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││┌ @ int.jl:86 within `-`
│   │││││ %43 = Base.sub_int(%26, 1)::Int64
│   ││││└
│   ││││ %44 = Base.llvmcall(%42, Int32, Tuple{Core.LLVMPtr{Int32, 1}, Int64}, %41, %43)::Int32
│   │└└└
└───│       goto #7
    └
    ┌ @ int.jl:1040 within `+`
    │┌ @ int.jl:523 within `rem`
7 ──││ %46 = Base.sext_int(Int64, %44)::Int64
│   │└
│   │ @ int.jl:1042 within `+` @ int.jl:87
│   │ %47 = Base.add_int(%46, 3)::Int64
│   └
│   ┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
└───│       goto #12 if not true
    │┌ @ abstractarray.jl:707 within `checkbounds`
8 ──││ %49 = Core.tuple(%26)::Tuple{Int64}
│   ││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│   ││┌ @ abstractarray.jl:382 within `eachindex`
│   │││┌ @ abstractarray.jl:133 within `axes1`
│   ││││┌ @ abstractarray.jl:98 within `axes`
│   │││││┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:73 within `size`
│   ││││││┌ @ Base.jl:37 within `getproperty`
│   │││││││ %50 = Base.getfield(x, :shape)::Tuple{Int64}
│   │││││└└
│   │││││┌ @ tuple.jl:273 within `map`
│   ││││││┌ @ tuple.jl:29 within `getindex`
│   │││││││ %51 = Base.getfield(%50, 1, true)::Int64
│   ││││││└
│   ││││││┌ @ range.jl:459 within `oneto`
│   │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│   ││││││││┌ @ promotion.jl:510 within `max`
│   │││││││││┌ @ int.jl:83 within `<`
│   ││││││││││ %52 = Base.slt_int(%51, 0)::Bool
│   │││││││││└
│   │││││││││┌ @ essentials.jl:575 within `ifelse`
│   ││││││││││ %53 = Core.ifelse(%52, 0, %51)::Int64
│   ││└└└└└└└└
│   ││┌ @ abstractarray.jl:768 within `checkindex`
│   │││┌ @ int.jl:488 within `<=`
│   ││││ %54 = Base.sle_int(1, %26)::Bool
│   ││││ %55 = Base.sle_int(%26, %53)::Bool
│   │││└
│   │││┌ @ bool.jl:38 within `&`
│   ││││ %56 = Base.and_int(%54, %55)::Bool
│   ││└└
│   ││ @ abstractarray.jl:709 within `checkbounds`
└───││       goto #10 if not %56
    ││ @ abstractarray.jl:710 within `checkbounds`
9 ──││       goto #11
    ││ @ abstractarray.jl:709 within `checkbounds`
10 ─││       invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Int32, 1}, %49::Tuple{Int64})::Union{}
└───││       unreachable
11 ─││       nothing::Nothing
    │└
    │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:95 within `#setindex!`
    │┌ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:68 within `pointer`
    ││┌ @ Base.jl:37 within `getproperty`
12 ┄│││ %62 = Base.getfield(x, :ptr)::Core.LLVMPtr{Int32, 1}
│   │└└
│   │┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:88 within `unsafe_store!`
│   ││┌ @ number.jl:7 within `convert`
│   │││┌ @ boot.jl:783 within `Int32`
│   ││││ %63 = invoke Core.toInt32(%47::Int64)::Int32
│   ││└└
│   ││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `pointerset`
│   │││┌ @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/TLGyi/src/interop/base.jl:40
│   ││││ %64 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, i32 %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to i32 addrspace(1)*\n  %4 = getelementptr inbounds i32, i32 addrspace(1)* %3, i64 %2\n  store i32 %1, i32 addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│   ││││┌ @ int.jl:86 within `-`
│   │││││ %65 = Base.sub_int(%26, 1)::Int64
│   ││││└
│   ││││       Base.llvmcall(%64, Nothing, Tuple{Core.LLVMPtr{Int32, 1}, Int32, Int64}, %62, %63, %65)::Nothing
│   │└└└
│   │ @ /home/pxl-th/.julia/dev/AMDGPU/src/device/gcn/array.jl:96 within `#setindex!`
└───│       goto #13
    └
     @ /home/pxl-th/.julia/dev/AMDGPU/src/AMDGPU.jl:369 within `set_one!`
13 ─       return AMDGPU.nothing
) => Nothing
