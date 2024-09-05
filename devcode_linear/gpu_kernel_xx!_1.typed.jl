CodeInfo(
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:94 within `gpu_kernel_xx!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:144 within `#__validindex`
     │┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:23 within `__iterspace`
     ││┌ @ Base.jl:37 within `getproperty`
1 ───│││ %1   = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}}
│    │└└
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %2   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││ %3   = Base.llvmcall(%2, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    │││││ %4   = Base.add_int(%3, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %5   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%5, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %7   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%7, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %9   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││ %10  = Base.llvmcall(%9, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    │││││ %11  = Base.add_int(%10, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %12  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%12, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    ││││││ %14  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%14, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand`
│    ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:64 within `blocks`
│    │││┌ @ Base.jl:37 within `getproperty`
│    ││││ %16  = Base.getfield(%1, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ abstractarray.jl:1291 within `getindex`
│    │││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    ││││┌ @ indices.jl:359 within `_to_indices1`
│    │││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:784 within `Int64`
│    ││││││││┌ @ boot.jl:708 within `toInt64`
│    │││││││││ %17  = Core.zext_int(Core.Int64, %4)::Int64
│    │││└└└└└└
│    │││┌ @ abstractarray.jl:1341 within `_getindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────│││││        goto #6 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
2 ───││││││ %19  = Core.tuple(%17)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ multidimensional.jl:344 within `axes`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %20  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:291 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %21  = Base.getfield(%20, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %22  = Base.getfield(%21, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %23  = Base.slt_int(%22, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %24  = Core.ifelse(%23, 0, %22)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %25  = Base.sub_int(%17, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %26  = Base.bitcast(UInt64, %25)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %27  = Base.bitcast(UInt64, %24)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %28  = Base.ult_int(%26, %27)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #4 if not %28
3 ───││││││        goto #5
4 ───││││││        invoke Base.throw_boundserror(%16::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %19::Tuple{Int64})::Union{}
└────││││││        unreachable
5 ───││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
6 ┄──││││││ %34  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:318 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %35  = Base.getfield(%34, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #10 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
7 ───││││││││││ %37  = Base.slt_int(0, %17)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %38  = Base.getfield(%35, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %39  = Base.sle_int(%17, %38)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %40  = Base.and_int(%37, %39)::Bool
│    ││││││││└
└────││││││││        goto #9 if not %40
8 ───││││││││        goto #10
9 ───││││││││        invoke Base.throw_boundserror(%35::Base.OneTo{Int64}, %17::Int64)::Union{}
└────││││││││        unreachable
10 ┄─││││││││        goto #11
11 ──││││││││        goto #12
12 ──││││││││        goto #13
13 ──││││││││        goto #14
14 ──││││││││        goto #15
15 ──││││││││        goto #16
     ││└└└└└└
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     │││┌ @ Base.jl:37 within `getproperty`
16 ──││││ %51  = Base.getfield(%1, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ abstractarray.jl:1291 within `getindex`
│    │││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    ││││┌ @ indices.jl:359 within `_to_indices1`
│    │││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:784 within `Int64`
│    ││││││││┌ @ boot.jl:708 within `toInt64`
│    │││││││││ %52  = Core.zext_int(Core.Int64, %11)::Int64
│    │││└└└└└└
│    │││┌ @ abstractarray.jl:1341 within `_getindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────│││││        goto #21 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
17 ──││││││ %54  = Core.tuple(%52)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ multidimensional.jl:344 within `axes`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %55  = Base.getfield(%51, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:291 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %56  = Base.getfield(%55, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %57  = Base.getfield(%56, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %58  = Base.slt_int(%57, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %59  = Core.ifelse(%58, 0, %57)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %60  = Base.sub_int(%52, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %61  = Base.bitcast(UInt64, %60)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %62  = Base.bitcast(UInt64, %59)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %63  = Base.ult_int(%61, %62)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #19 if not %63
18 ──││││││        goto #20
19 ──││││││        invoke Base.throw_boundserror(%51::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %54::Tuple{Int64})::Union{}
└────││││││        unreachable
20 ──││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
21 ┄─││││││ %69  = Base.getfield(%51, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:318 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %70  = Base.getfield(%69, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #25 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
22 ──││││││││││ %72  = Base.slt_int(0, %52)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %73  = Base.getfield(%70, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %74  = Base.sle_int(%52, %73)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %75  = Base.and_int(%72, %74)::Bool
│    ││││││││└
└────││││││││        goto #24 if not %75
23 ──││││││││        goto #25
24 ──││││││││        invoke Base.throw_boundserror(%70::Base.OneTo{Int64}, %52::Int64)::Union{}
└────││││││││        unreachable
25 ┄─││││││││        goto #26
26 ──││││││││        goto #27
27 ──││││││││        goto #28
28 ──││││││││        goto #29
29 ──││││││││        goto #30
30 ──││││││││        goto #31
     ││└└└└└└
     ││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand` @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:74
     ││┌ @ ntuple.jl:48 within `ntuple`
     │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
     ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     │││││┌ @ Base.jl:37 within `getproperty`
31 ──││││││ %86  = Base.getfield(%1, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││││└└
│    ││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %87  = Base.getfield(%86, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:291 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %88  = Base.getfield(%87, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ range.jl:779 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %89  = Base.getfield(%88, :stop)::Int64
│    ││││└└└└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %90  = Base.sub_int(%17, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %91  = Base.mul_int(%90, %89)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %92  = Base.add_int(%91, %52)::Int64
└────│││││        goto #32
     │└└└└
     │ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:145 within `#__validindex`
     │┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:28 within `__ndrange`
     ││┌ @ Base.jl:37 within `getproperty`
32 ──│││ %94  = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │└└
│    │┌ @ multidimensional.jl:471 within `in`
│    ││┌ @ Base.jl:37 within `getproperty`
│    │││ %95  = Base.getfield(%94, :indices)::Tuple{Base.OneTo{Int64}}
│    ││└
│    ││┌ @ tuple.jl:318 within `map`
│    │││┌ @ tuple.jl:31 within `getindex`
│    ││││ %96  = Base.getfield(%95, 1, true)::Base.OneTo{Int64}
│    │││└
│    │││┌ @ range.jl:1439 within `in`
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %97  = Base.sle_int(1, %92)::Bool
│    ││││└
│    ││││┌ @ range.jl:839 within `last`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %98  = Base.getfield(%96, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %99  = Base.sle_int(%92, %98)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %100 = Base.and_int(%97, %99)::Bool
│    │└└└└
└────│        goto #33
     └
33 ──        goto #109 if not %100
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:95 within `gpu_kernel_xx!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:12 within `macro expansion`
     │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:125 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:23 within `__iterspace`
     │││┌ @ Base.jl:37 within `getproperty`
34 ──││││ %103 = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %104 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││ %105 = Base.llvmcall(%104, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    ││││││ %106 = Base.add_int(%105, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %107 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%107, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %109 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%109, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %111 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││ %112 = Base.llvmcall(%111, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    ││││││ %113 = Base.add_int(%112, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %114 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%114, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %116 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%116, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand`
│    │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:64 within `blocks`
│    ││││┌ @ Base.jl:37 within `getproperty`
│    │││││ %118 = Base.getfield(%103, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1291 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %119 = Core.zext_int(Core.Int64, %106)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1341 within `_getindex`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────││││││        goto #39 if not false
     ││││││┌ @ abstractarray.jl:700 within `checkbounds`
35 ──│││││││ %121 = Core.tuple(%119)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││││││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ multidimensional.jl:344 within `axes`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %122 = Base.getfield(%118, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││││││└
│    ││││││││││┌ @ tuple.jl:291 within `map`
│    │││││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││││ %123 = Base.getfield(%122, 1, true)::Base.OneTo{Int64}
│    │││││││││││└
│    │││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││││ %124 = Base.getfield(%123, :stop)::Int64
│    │││││││││││││└└
│    │││││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││││ %125 = Base.slt_int(%124, 0)::Bool
│    ││││││││││││││││└
│    ││││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││││ %126 = Core.ifelse(%125, 0, %124)::Int64
│    │││││││└└└└└└└└└└
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %127 = Base.sub_int(%119, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %128 = Base.bitcast(UInt64, %127)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %129 = Base.bitcast(UInt64, %126)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %130 = Base.ult_int(%128, %129)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││││        goto #37 if not %130
36 ──│││││││        goto #38
37 ──│││││││        invoke Base.throw_boundserror(%118::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %121::Tuple{Int64})::Union{}
└────│││││││        unreachable
38 ──│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
39 ┄─│││││││ %136 = Base.getfield(%118, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:318 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %137 = Base.getfield(%136, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #43 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
40 ──│││││││││││ %139 = Base.slt_int(0, %119)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %140 = Base.getfield(%137, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %141 = Base.sle_int(%119, %140)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %142 = Base.and_int(%139, %141)::Bool
│    │││││││││└
└────│││││││││        goto #42 if not %142
41 ──│││││││││        goto #43
42 ──│││││││││        invoke Base.throw_boundserror(%137::Base.OneTo{Int64}, %119::Int64)::Union{}
└────│││││││││        unreachable
43 ┄─│││││││││        goto #44
44 ──│││││││││        goto #45
45 ──│││││││││        goto #46
46 ──│││││││││        goto #47
47 ──│││││││││        goto #48
48 ──│││││││││        goto #49
     │││└└└└└└
     │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     ││││┌ @ Base.jl:37 within `getproperty`
49 ──│││││ %153 = Base.getfield(%103, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1291 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %154 = Core.zext_int(Core.Int64, %113)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1341 within `_getindex`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────││││││        goto #54 if not false
     ││││││┌ @ abstractarray.jl:700 within `checkbounds`
50 ──│││││││ %156 = Core.tuple(%154)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││││││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ multidimensional.jl:344 within `axes`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %157 = Base.getfield(%153, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││││││└
│    ││││││││││┌ @ tuple.jl:291 within `map`
│    │││││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││││ %158 = Base.getfield(%157, 1, true)::Base.OneTo{Int64}
│    │││││││││││└
│    │││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││││ %159 = Base.getfield(%158, :stop)::Int64
│    │││││││││││││└└
│    │││││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││││ %160 = Base.slt_int(%159, 0)::Bool
│    ││││││││││││││││└
│    ││││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││││ %161 = Core.ifelse(%160, 0, %159)::Int64
│    │││││││└└└└└└└└└└
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %162 = Base.sub_int(%154, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %163 = Base.bitcast(UInt64, %162)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %164 = Base.bitcast(UInt64, %161)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %165 = Base.ult_int(%163, %164)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││││        goto #52 if not %165
51 ──│││││││        goto #53
52 ──│││││││        invoke Base.throw_boundserror(%153::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %156::Tuple{Int64})::Union{}
└────│││││││        unreachable
53 ──│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
54 ┄─│││││││ %171 = Base.getfield(%153, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:318 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %172 = Base.getfield(%171, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #58 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
55 ──│││││││││││ %174 = Base.slt_int(0, %154)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %175 = Base.getfield(%172, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %176 = Base.sle_int(%154, %175)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %177 = Base.and_int(%174, %176)::Bool
│    │││││││││└
└────│││││││││        goto #57 if not %177
56 ──│││││││││        goto #58
57 ──│││││││││        invoke Base.throw_boundserror(%172::Base.OneTo{Int64}, %154::Int64)::Union{}
└────│││││││││        unreachable
58 ┄─│││││││││        goto #59
59 ──│││││││││        goto #60
60 ──│││││││││        goto #61
61 ──│││││││││        goto #62
62 ──│││││││││        goto #63
63 ──│││││││││        goto #64
     │││└└└└└└
     │││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand` @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:74
     │││┌ @ ntuple.jl:48 within `ntuple`
     ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
     │││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     ││││││┌ @ Base.jl:37 within `getproperty`
64 ──│││││││ %188 = Base.getfield(%103, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││││└└
│    │││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %189 = Base.getfield(%188, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:291 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %190 = Base.getfield(%189, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ range.jl:779 within `length`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %191 = Base.getfield(%190, :stop)::Int64
│    │││││└└└└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %192 = Base.sub_int(%119, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %193 = Base.mul_int(%192, %191)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %194 = Base.add_int(%193, %154)::Int64
└────││││││        goto #65
     ││└└└└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:127 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:28 within `__ndrange`
     │││┌ @ Base.jl:37 within `getproperty`
65 ──││││ %196 = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ multidimensional.jl:576 within `LinearIndices`
│    │││┌ @ Base.jl:37 within `getproperty`
│    ││││ %197 = Base.getfield(%196, :indices)::Tuple{Base.OneTo{Int64}}
│    │││└
│    │││ @ multidimensional.jl:576 within `LinearIndices` @ indices.jl:476
│    │││ %198 = %new(LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %197)::LinearIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└
│    ││┌ @ abstractarray.jl:1291 within `getindex`
│    │││┌ @ abstractarray.jl:1319 within `_getindex`
│    ││││┌ @ indices.jl:510 within `getindex`
└────│││││        goto #70 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
66 ──││││││ %200 = Core.tuple(%194)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ indices.jl:505 within `axes`
│    │││││││││┌ @ tuple.jl:291 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %201 = Base.getfield(%197, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %202 = Base.getfield(%201, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %203 = Base.slt_int(%202, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %204 = Core.ifelse(%203, 0, %202)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %205 = Base.sub_int(%194, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %206 = Base.bitcast(UInt64, %205)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %207 = Base.bitcast(UInt64, %204)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %208 = Base.ult_int(%206, %207)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #68 if not %208
67 ──││││││        goto #69
68 ──││││││        invoke Base.throw_boundserror(%198::LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %200::Tuple{Int64})::Union{}
└────││││││        unreachable
69 ──││││││        nothing::Nothing
70 ┄─││││││        goto #71
71 ──││││││        goto #72
72 ──││││││        goto #73
73 ──││││││        goto #74
     │└└└└└
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:14 within `macro expansion`
     │┌ @ int.jl:85 within `-`
74 ──││ %218 = Base.neg_int(Nx)::Int64
│    │└
│    │┌ @ range.jl:5 within `Colon`
│    ││┌ @ range.jl:403 within `UnitRange`
│    │││┌ @ range.jl:414 within `unitrange_last`
│    ││││┌ @ operators.jl:425 within `>=`
│    │││││┌ @ int.jl:514 within `<=`
│    ││││││ %219 = Base.sle_int(%218, Nx)::Bool
│    ││││└└
└────││││        goto #76 if not %219
75 ──││││        goto #77
     ││││┌ @ int.jl:86 within `-`
76 ──│││││ %222 = Base.sub_int(%218, 1)::Int64
└────│││││        goto #77
     │││└└
77 ┄─│││ %224 = φ (#75 => Nx, #76 => %222)::Int64
└────│││        goto #78
78 ──│││        goto #79
     │└└
     │┌ @ range.jl:897 within `iterate`
     ││┌ @ range.jl:672 within `isempty`
     │││┌ @ operators.jl:378 within `>`
     ││││┌ @ int.jl:83 within `<`
79 ──│││││ %227 = Base.slt_int(%224, %218)::Bool
│    ││└└└
└────││        goto #81 if not %227
80 ──││        goto #82
81 ──││        goto #82
     │└
82 ┄─│ %231 = φ (#80 => true, #81 => false)::Bool
│    │ %232 = φ (#81 => %218)::Int64
│    │ %233 = Base.not_int(%231)::Bool
└────│        goto #102 if not %233
83 ┄─│ %235 = φ (#82 => %232, #101 => %273)::Int64
│    │ %236 = φ (#82 => 0.0, #101 => %267)::Float64
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:15 within `macro expansion`
│    │┌ @ int.jl:85 within `-`
│    ││ %237 = Base.neg_int(Ny)::Int64
│    │└
│    │┌ @ range.jl:5 within `Colon`
│    ││┌ @ range.jl:403 within `UnitRange`
│    │││┌ @ range.jl:414 within `unitrange_last`
│    ││││┌ @ operators.jl:425 within `>=`
│    │││││┌ @ int.jl:514 within `<=`
│    ││││││ %238 = Base.sle_int(%237, Ny)::Bool
│    ││││└└
└────││││        goto #85 if not %238
84 ──││││        goto #86
     ││││┌ @ int.jl:86 within `-`
85 ──│││││ %241 = Base.sub_int(%237, 1)::Int64
└────│││││        goto #86
     │││└└
86 ┄─│││ %243 = φ (#84 => Ny, #85 => %241)::Int64
└────│││        goto #87
87 ──│││        goto #88
     │└└
     │┌ @ range.jl:897 within `iterate`
     ││┌ @ range.jl:672 within `isempty`
     │││┌ @ operators.jl:378 within `>`
     ││││┌ @ int.jl:83 within `<`
88 ──│││││ %246 = Base.slt_int(%243, %237)::Bool
│    ││└└└
└────││        goto #90 if not %246
89 ──││        goto #91
90 ──││        goto #91
     │└
91 ┄─│ %250 = φ (#89 => true, #90 => false)::Bool
│    │ %251 = φ (#90 => %237)::Int64
│    │ %252 = Base.not_int(%250)::Bool
└────│        goto #97 if not %252
92 ┄─│ %254 = φ (#91 => %236, #96 => %256)::Float64
│    │ %255 = φ (#91 => %251, #96 => %262)::Int64
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:16 within `macro expansion`
│    │┌ @ float.jl:409 within `+`
│    ││ %256 = Base.add_float(%254, 2.0)::Float64
│    │└
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:17 within `macro expansion`
│    │┌ @ range.jl:901 within `iterate`
│    ││┌ @ promotion.jl:521 within `==`
│    │││ %257 = (%255 === %243)::Bool
│    ││└
└────││        goto #94 if not %257
93 ──││        goto #95
     ││ @ range.jl:902 within `iterate`
     ││┌ @ int.jl:87 within `+`
94 ──│││ %260 = Base.add_int(%255, 1)::Int64
└────│││        goto #95
     │└└
95 ┄─│ %262 = φ (#94 => %260)::Int64
│    │ %263 = φ (#93 => true, #94 => false)::Bool
│    │ %264 = Base.not_int(%263)::Bool
└────│        goto #97 if not %264
96 ──│        goto #92
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:18 within `macro expansion`
97 ┄─│ %267 = φ (#95 => %256, #91 => %236)::Float64
│    │┌ @ range.jl:901 within `iterate`
│    ││┌ @ promotion.jl:521 within `==`
│    │││ %268 = (%235 === %224)::Bool
│    ││└
└────││        goto #99 if not %268
98 ──││        goto #100
     ││ @ range.jl:902 within `iterate`
     ││┌ @ int.jl:87 within `+`
99 ──│││ %271 = Base.add_int(%235, 1)::Int64
└────│││        goto #100
     │└└
100 ┄│ %273 = φ (#99 => %271)::Int64
│    │ %274 = φ (#98 => true, #99 => false)::Bool
│    │ %275 = Base.not_int(%274)::Bool
└────│        goto #102 if not %275
101 ─│        goto #83
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:19 within `macro expansion`
102 ┄│ %278 = φ (#100 => %267, #82 => 0.0)::Float64
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
└────││        goto #107 if not false
     ││┌ @ abstractarray.jl:700 within `checkbounds`
103 ─│││ %280 = Core.tuple(%194)::Tuple{Int64}
│    │││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││┌ @ abstractarray.jl:388 within `eachindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `length`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %281 = Base.getfield(tensor, :len)::Int64
│    ││││└└
│    ││││┌ @ range.jl:469 within `oneto`
│    │││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││┌ @ promotion.jl:532 within `max`
│    │││││││┌ @ int.jl:83 within `<`
│    ││││││││ %282 = Base.slt_int(%281, 0)::Bool
│    │││││││└
│    │││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││ %283 = Core.ifelse(%282, 0, %281)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %284 = Base.sub_int(%194, 1)::Int64
│    ││││└
│    ││││┌ @ essentials.jl:524 within `unsigned`
│    │││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││ %285 = Base.bitcast(UInt64, %284)::UInt64
│    ││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││ %286 = Base.bitcast(UInt64, %283)::UInt64
│    ││││└└
│    ││││┌ @ int.jl:513 within `<`
│    │││││ %287 = Base.ult_int(%285, %286)::Bool
│    │││└└
│    │││ @ abstractarray.jl:702 within `checkbounds`
└────│││        goto #105 if not %287
104 ─│││        goto #106
105 ─│││        invoke Base.throw_boundserror(tensor::ROCDeviceArray{Float64, 3, 1}, %280::Tuple{Int64})::Union{}
└────│││        unreachable
106 ─│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
     │││┌ @ Base.jl:37 within `getproperty`
107 ┄││││ %293 = Base.getfield(tensor, :ptr)::Core.LLVMPtr{Float64, 1}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││┌ @ none within `pointerset`
│    ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││ %294 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, double %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to double addrspace(1)*\n  %4 = getelementptr inbounds double, double addrspace(1)* %3, i64 %2\n  store double %1, double addrspace(1)* %4, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %295 = Base.sub_int(%194, 1)::Int64
│    │││││└
│    │││││        Base.llvmcall(%294, Nothing, Tuple{Core.LLVMPtr{Float64, 1}, Float64, Int64}, %293, %278, %295)::Nothing
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└────││        goto #108
108 ─││        nothing::Nothing
     └└
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:97 within `gpu_kernel_xx!`
109 ┄        return Main.nothing
) => Nothing
