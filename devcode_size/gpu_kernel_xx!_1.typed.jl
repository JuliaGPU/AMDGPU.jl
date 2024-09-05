CodeInfo(
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:94 within `gpu_kernel_xx!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:144 within `#__validindex`
     │┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:23 within `__iterspace`
     ││┌ @ Base.jl:37 within `getproperty`
1 ───│││ %1   = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{3, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}}
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
│    ││││ %16  = Base.getfield(%1, :blocks)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
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
│    │││┌ @ abstractarray.jl:1335 within `_getindex`
└────││││        goto #6 if not false
     ││││┌ @ abstractarray.jl:700 within `checkbounds`
2 ───│││││ %19  = Core.tuple(%17)::Tuple{Int64}
│    │││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││││┌ @ abstractarray.jl:388 within `eachindex`
│    ││││││┌ @ multidimensional.jl:455 within `length`
│    │││││││┌ @ multidimensional.jl:453 within `size`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %20  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %21  = Base.getfield(%20, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %22  = Base.getfield(%21, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %23  = Base.getfield(%20, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %24  = Base.getfield(%23, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %25  = Base.getfield(%20, 3, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %26  = Base.getfield(%25, :stop)::Int64
│    │││││││└└└└
│    │││││││┌ @ tuple.jl:595 within `prod`
│    ││││││││┌ @ operators.jl:587 within `*` @ int.jl:88
│    │││││││││ %27  = Base.mul_int(%22, %24)::Int64
│    │││││││││ %28  = Base.mul_int(%27, %26)::Int64
│    ││││││└└└
│    ││││││┌ @ range.jl:469 within `oneto`
│    │││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %29  = Base.slt_int(%28, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││ %30  = Core.ifelse(%29, 0, %28)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││┌ @ int.jl:86 within `-`
│    │││││││ %31  = Base.sub_int(%17, 1)::Int64
│    ││││││└
│    ││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││ %32  = Base.bitcast(UInt64, %31)::UInt64
│    ││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││ %33  = Base.bitcast(UInt64, %30)::UInt64
│    ││││││└└
│    ││││││┌ @ int.jl:513 within `<`
│    │││││││ %34  = Base.ult_int(%32, %33)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││        goto #4 if not %34
3 ───│││││        goto #5
4 ───│││││        invoke Base.throw_boundserror(%16::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %19::Tuple{Int64})::Union{}
└────│││││        unreachable
5 ───│││││        nothing::Nothing
     ││││└
     ││││ @ abstractarray.jl:1336 within `_getindex`
     ││││┌ @ abstractarray.jl:1343 within `_to_subscript_indices`
     │││││┌ @ abstractarray.jl:1365 within `_unsafe_ind2sub`
     ││││││┌ @ abstractarray.jl:2962 within `_ind2sub`
     │││││││┌ @ multidimensional.jl:344 within `axes`
     ││││││││┌ @ Base.jl:37 within `getproperty`
6 ┄──│││││││││ %40  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %41  = Base.getfield(%40, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %42  = Base.getfield(%41, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %43  = Base.slt_int(%42, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %44  = Core.ifelse(%43, 0, %42)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %45  = Base.getfield(%40, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %46  = Base.getfield(%45, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %47  = Base.slt_int(%46, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %48  = Core.ifelse(%47, 0, %46)::Int64
│    │││││││└└└└└└└└
│    │││││││ @ abstractarray.jl:2962 within `_ind2sub` @ abstractarray.jl:3000
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %49  = Base.sub_int(%17, 1)::Int64
│    │││││││└
│    │││││││┌ @ abstractarray.jl:3013 within `_ind2sub_recurse`
│    ││││││││┌ @ abstractarray.jl:3020 within `_div`
│    │││││││││┌ @ int.jl:295 within `div`
│    ││││││││││ %50  = Base.checked_sdiv_int(%49, %44)::Int64
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse`
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %51  = Base.mul_int(%44, %50)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %52  = Base.sub_int(%49, %51)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:87 within `+`
│    │││││││││ %53  = Base.add_int(%52, 1)::Int64
│    ││││││││└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3013
│    ││││││││┌ @ abstractarray.jl:3020 within `_div`
│    │││││││││┌ @ int.jl:295 within `div`
│    ││││││││││ %54  = Base.checked_sdiv_int(%50, %48)::Int64
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %55  = Base.mul_int(%48, %54)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %56  = Base.sub_int(%50, %55)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:87 within `+`
│    │││││││││ %57  = Base.add_int(%56, 1)::Int64
│    ││││││││└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014 @ abstractarray.jl:3008
│    ││││││││┌ @ abstractarray.jl:3018 within `_lookup`
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %58  = Base.add_int(%54, 1)::Int64
│    ││││└└└└└└
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────│││││        goto #11 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
7 ───││││││ %60  = Core.tuple(%53, %57, %58)::Tuple{Int64, Int64, Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:681
│    ││││││┌ @ multidimensional.jl:344 within `axes`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %61  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││└
│    │││││││┌ @ tuple.jl:293 within `map`
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %62  = Base.getfield(%61, 1, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %63  = Base.getfield(%62, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %64  = Base.slt_int(%63, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %65  = Core.ifelse(%64, 0, %63)::Int64
│    ││││││││└└└└└└
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %66  = Base.getfield(%61, 2, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %67  = Base.getfield(%66, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %68  = Base.slt_int(%67, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %69  = Core.ifelse(%68, 0, %67)::Int64
│    ││││││││└└└└└└
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %70  = Base.getfield(%61, 3, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %71  = Base.getfield(%70, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %72  = Base.slt_int(%71, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %73  = Core.ifelse(%72, 0, %71)::Int64
│    ││││││└└└└└└└└
│    ││││││┌ @ abstractarray.jl:728 within `checkbounds_indices`
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %74  = Base.sub_int(%53, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %75  = Base.bitcast(UInt64, %74)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %76  = Base.bitcast(UInt64, %65)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %77  = Base.ult_int(%75, %76)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %78  = Base.sub_int(%57, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %79  = Base.bitcast(UInt64, %78)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %80  = Base.bitcast(UInt64, %69)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %81  = Base.ult_int(%79, %80)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728 @ abstractarray.jl:728
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %82  = Base.sub_int(%58, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %83  = Base.bitcast(UInt64, %82)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %84  = Base.bitcast(UInt64, %73)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %85  = Base.ult_int(%83, %84)::Bool
│    │││││││└└
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %86  = Base.and_int(%85, true)::Bool
│    │││││││└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %87  = Base.and_int(%81, %86)::Bool
│    │││││││└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices`
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %88  = Base.and_int(%77, %87)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #9 if not %88
8 ───││││││        goto #10
9 ───││││││        invoke Base.throw_boundserror(%16::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %60::Tuple{Int64, Int64, Int64})::Union{}
└────││││││        unreachable
10 ──││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
11 ┄─││││││ %94  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:322 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %95  = Base.getfield(%94, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #15 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
12 ──││││││││││ %97  = Base.slt_int(0, %53)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %98  = Base.getfield(%95, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %99  = Base.sle_int(%53, %98)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %100 = Base.and_int(%97, %99)::Bool
│    ││││││││└
└────││││││││        goto #14 if not %100
13 ──││││││││        goto #15
14 ──││││││││        invoke Base.throw_boundserror(%95::Base.OneTo{Int64}, %53::Int64)::Union{}
└────││││││││        unreachable
15 ┄─││││││││        goto #16
16 ──││││││││        goto #17
     ││││││└└
     ││││││┌ @ essentials.jl:374 within `tail`
17 ──│││││││ %107 = Core.getfield(%94, 2)::Base.OneTo{Int64}
│    │││││││ %108 = Core.getfield(%94, 3)::Base.OneTo{Int64}
│    ││││││└
│    ││││││ @ tuple.jl:322 within `map` @ tuple.jl:319
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #21 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
18 ──││││││││││ %110 = Base.slt_int(0, %57)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %111 = Base.getfield(%107, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %112 = Base.sle_int(%57, %111)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %113 = Base.and_int(%110, %112)::Bool
│    ││││││││└
└────││││││││        goto #20 if not %113
19 ──││││││││        goto #21
20 ──││││││││        invoke Base.throw_boundserror(%107::Base.OneTo{Int64}, %57::Int64)::Union{}
└────││││││││        unreachable
21 ┄─││││││││        goto #22
22 ──││││││││        goto #23
     ││││││││ @ range.jl:937 within `getindex`
23 ──││││││││        goto #27 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
24 ──││││││││││ %121 = Base.slt_int(0, %58)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %122 = Base.getfield(%108, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %123 = Base.sle_int(%58, %122)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %124 = Base.and_int(%121, %123)::Bool
│    ││││││││└
└────││││││││        goto #26 if not %124
25 ──││││││││        goto #27
26 ──││││││││        invoke Base.throw_boundserror(%108::Base.OneTo{Int64}, %58::Int64)::Union{}
└────││││││││        unreachable
27 ┄─││││││││        goto #28
28 ──││││││││        goto #29
29 ──││││││││        goto #30
30 ──││││││││        goto #31
31 ──││││││││        goto #32
32 ──││││││││        goto #33
33 ──││││││││        goto #34
     ││└└└└└└
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     │││┌ @ Base.jl:37 within `getproperty`
34 ──││││ %136 = Base.getfield(%1, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ abstractarray.jl:1291 within `getindex`
│    │││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    ││││┌ @ indices.jl:359 within `_to_indices1`
│    │││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:784 within `Int64`
│    ││││││││┌ @ boot.jl:708 within `toInt64`
│    │││││││││ %137 = Core.zext_int(Core.Int64, %11)::Int64
│    │││└└└└└└
│    │││┌ @ abstractarray.jl:1335 within `_getindex`
└────││││        goto #39 if not false
     ││││┌ @ abstractarray.jl:700 within `checkbounds`
35 ──│││││ %139 = Core.tuple(%137)::Tuple{Int64}
│    │││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││││┌ @ abstractarray.jl:388 within `eachindex`
│    ││││││┌ @ multidimensional.jl:455 within `length`
│    │││││││┌ @ multidimensional.jl:453 within `size`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %140 = Base.getfield(%136, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %141 = Base.getfield(%140, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %142 = Base.getfield(%141, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %143 = Base.getfield(%140, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %144 = Base.getfield(%143, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %145 = Base.getfield(%140, 3, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %146 = Base.getfield(%145, :stop)::Int64
│    │││││││└└└└
│    │││││││┌ @ tuple.jl:595 within `prod`
│    ││││││││┌ @ operators.jl:587 within `*` @ int.jl:88
│    │││││││││ %147 = Base.mul_int(%142, %144)::Int64
│    │││││││││ %148 = Base.mul_int(%147, %146)::Int64
│    ││││││└└└
│    ││││││┌ @ range.jl:469 within `oneto`
│    │││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %149 = Base.slt_int(%148, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││ %150 = Core.ifelse(%149, 0, %148)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││┌ @ int.jl:86 within `-`
│    │││││││ %151 = Base.sub_int(%137, 1)::Int64
│    ││││││└
│    ││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││ %152 = Base.bitcast(UInt64, %151)::UInt64
│    ││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││ %153 = Base.bitcast(UInt64, %150)::UInt64
│    ││││││└└
│    ││││││┌ @ int.jl:513 within `<`
│    │││││││ %154 = Base.ult_int(%152, %153)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││        goto #37 if not %154
36 ──│││││        goto #38
37 ──│││││        invoke Base.throw_boundserror(%136::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %139::Tuple{Int64})::Union{}
└────│││││        unreachable
38 ──│││││        nothing::Nothing
     ││││└
     ││││ @ abstractarray.jl:1336 within `_getindex`
     ││││┌ @ abstractarray.jl:1343 within `_to_subscript_indices`
     │││││┌ @ abstractarray.jl:1365 within `_unsafe_ind2sub`
     ││││││┌ @ abstractarray.jl:2962 within `_ind2sub`
     │││││││┌ @ multidimensional.jl:344 within `axes`
     ││││││││┌ @ Base.jl:37 within `getproperty`
39 ┄─│││││││││ %160 = Base.getfield(%136, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %161 = Base.getfield(%160, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %162 = Base.getfield(%161, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %163 = Base.slt_int(%162, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %164 = Core.ifelse(%163, 0, %162)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %165 = Base.getfield(%160, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %166 = Base.getfield(%165, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %167 = Base.slt_int(%166, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %168 = Core.ifelse(%167, 0, %166)::Int64
│    │││││││└└└└└└└└
│    │││││││ @ abstractarray.jl:2962 within `_ind2sub` @ abstractarray.jl:3000
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %169 = Base.sub_int(%137, 1)::Int64
│    │││││││└
│    │││││││┌ @ abstractarray.jl:3013 within `_ind2sub_recurse`
│    ││││││││┌ @ abstractarray.jl:3020 within `_div`
│    │││││││││┌ @ int.jl:295 within `div`
│    ││││││││││ %170 = Base.checked_sdiv_int(%169, %164)::Int64
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse`
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %171 = Base.mul_int(%164, %170)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %172 = Base.sub_int(%169, %171)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:87 within `+`
│    │││││││││ %173 = Base.add_int(%172, 1)::Int64
│    ││││││││└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3013
│    ││││││││┌ @ abstractarray.jl:3020 within `_div`
│    │││││││││┌ @ int.jl:295 within `div`
│    ││││││││││ %174 = Base.checked_sdiv_int(%170, %168)::Int64
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %175 = Base.mul_int(%168, %174)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %176 = Base.sub_int(%170, %175)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:87 within `+`
│    │││││││││ %177 = Base.add_int(%176, 1)::Int64
│    ││││││││└
│    ││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014 @ abstractarray.jl:3008
│    ││││││││┌ @ abstractarray.jl:3018 within `_lookup`
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %178 = Base.add_int(%174, 1)::Int64
│    ││││└└└└└└
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────│││││        goto #44 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
40 ──││││││ %180 = Core.tuple(%173, %177, %178)::Tuple{Int64, Int64, Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:681
│    ││││││┌ @ multidimensional.jl:344 within `axes`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %181 = Base.getfield(%136, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││└
│    │││││││┌ @ tuple.jl:293 within `map`
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %182 = Base.getfield(%181, 1, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %183 = Base.getfield(%182, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %184 = Base.slt_int(%183, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %185 = Core.ifelse(%184, 0, %183)::Int64
│    ││││││││└└└└└└
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %186 = Base.getfield(%181, 2, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %187 = Base.getfield(%186, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %188 = Base.slt_int(%187, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %189 = Core.ifelse(%188, 0, %187)::Int64
│    ││││││││└└└└└└
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %190 = Base.getfield(%181, 3, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %191 = Base.getfield(%190, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %192 = Base.slt_int(%191, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %193 = Core.ifelse(%192, 0, %191)::Int64
│    ││││││└└└└└└└└
│    ││││││┌ @ abstractarray.jl:728 within `checkbounds_indices`
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %194 = Base.sub_int(%173, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %195 = Base.bitcast(UInt64, %194)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %196 = Base.bitcast(UInt64, %185)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %197 = Base.ult_int(%195, %196)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %198 = Base.sub_int(%177, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %199 = Base.bitcast(UInt64, %198)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %200 = Base.bitcast(UInt64, %189)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %201 = Base.ult_int(%199, %200)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728 @ abstractarray.jl:728
│    │││││││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %202 = Base.sub_int(%178, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:524 within `unsigned`
│    │││││││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %203 = Base.bitcast(UInt64, %202)::UInt64
│    ││││││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││││││ %204 = Base.bitcast(UInt64, %193)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %205 = Base.ult_int(%203, %204)::Bool
│    │││││││└└
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %206 = Base.and_int(%205, true)::Bool
│    │││││││└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %207 = Base.and_int(%201, %206)::Bool
│    │││││││└
│    │││││││ @ abstractarray.jl:728 within `checkbounds_indices`
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %208 = Base.and_int(%197, %207)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #42 if not %208
41 ──││││││        goto #43
42 ──││││││        invoke Base.throw_boundserror(%136::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %180::Tuple{Int64, Int64, Int64})::Union{}
└────││││││        unreachable
43 ──││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
44 ┄─││││││ %214 = Base.getfield(%136, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:322 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %215 = Base.getfield(%214, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #48 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
45 ──││││││││││ %217 = Base.slt_int(0, %173)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %218 = Base.getfield(%215, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %219 = Base.sle_int(%173, %218)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %220 = Base.and_int(%217, %219)::Bool
│    ││││││││└
└────││││││││        goto #47 if not %220
46 ──││││││││        goto #48
47 ──││││││││        invoke Base.throw_boundserror(%215::Base.OneTo{Int64}, %173::Int64)::Union{}
└────││││││││        unreachable
48 ┄─││││││││        goto #49
49 ──││││││││        goto #50
     ││││││└└
     ││││││┌ @ essentials.jl:374 within `tail`
50 ──│││││││ %227 = Core.getfield(%214, 2)::Base.OneTo{Int64}
│    │││││││ %228 = Core.getfield(%214, 3)::Base.OneTo{Int64}
│    ││││││└
│    ││││││ @ tuple.jl:322 within `map` @ tuple.jl:319
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ range.jl:937 within `getindex`
└────││││││││        goto #54 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
51 ──││││││││││ %230 = Base.slt_int(0, %177)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %231 = Base.getfield(%227, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %232 = Base.sle_int(%177, %231)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %233 = Base.and_int(%230, %232)::Bool
│    ││││││││└
└────││││││││        goto #53 if not %233
52 ──││││││││        goto #54
53 ──││││││││        invoke Base.throw_boundserror(%227::Base.OneTo{Int64}, %177::Int64)::Union{}
└────││││││││        unreachable
54 ┄─││││││││        goto #55
55 ──││││││││        goto #56
     ││││││││ @ range.jl:937 within `getindex`
56 ──││││││││        goto #60 if not false
     ││││││││┌ @ operators.jl:378 within `>`
     │││││││││┌ @ int.jl:83 within `<`
57 ──││││││││││ %241 = Base.slt_int(0, %178)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %242 = Base.getfield(%228, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:514 within `<=`
│    │││││││││ %243 = Base.sle_int(%178, %242)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %244 = Base.and_int(%241, %243)::Bool
│    ││││││││└
└────││││││││        goto #59 if not %244
58 ──││││││││        goto #60
59 ──││││││││        invoke Base.throw_boundserror(%228::Base.OneTo{Int64}, %178::Int64)::Union{}
└────││││││││        unreachable
60 ┄─││││││││        goto #61
61 ──││││││││        goto #62
62 ──││││││││        goto #63
63 ──││││││││        goto #64
64 ──││││││││        goto #65
65 ──││││││││        goto #66
66 ──││││││││        goto #67
     ││└└└└└└
     ││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand` @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:74
     ││┌ @ ntuple.jl:50 within `ntuple`
     │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
     ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     │││││┌ @ Base.jl:37 within `getproperty`
67 ──││││││ %256 = Base.getfield(%1, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││││└└
│    ││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %257 = Base.getfield(%256, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:293 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %258 = Base.getfield(%257, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ range.jl:779 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %259 = Base.getfield(%258, :stop)::Int64
│    ││││└└└└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %260 = Base.sub_int(%53, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %261 = Base.mul_int(%260, %259)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %262 = Base.add_int(%261, %173)::Int64
│    ││││└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
│    ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %263 = Base.getfield(%1, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││││└└
│    ││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %264 = Base.getfield(%263, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:293 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %265 = Base.getfield(%264, 2, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ range.jl:779 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %266 = Base.getfield(%265, :stop)::Int64
│    ││││└└└└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %267 = Base.sub_int(%57, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %268 = Base.mul_int(%267, %266)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %269 = Base.add_int(%268, %177)::Int64
│    ││││└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
│    ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %270 = Base.getfield(%1, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││││└└
│    ││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %271 = Base.getfield(%270, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:293 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %272 = Base.getfield(%271, 3, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ range.jl:779 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %273 = Base.getfield(%272, :stop)::Int64
│    ││││└└└└
│    ││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %274 = Base.sub_int(%58, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %275 = Base.mul_int(%274, %273)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %276 = Base.add_int(%275, %178)::Int64
└────│││││        goto #68
     │└└└└
     │ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:145 within `#__validindex`
     │┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:28 within `__ndrange`
     ││┌ @ Base.jl:37 within `getproperty`
68 ──│││ %278 = Base.getfield(__ctx__, :ndrange)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │└└
│    │┌ @ multidimensional.jl:471 within `in`
│    ││┌ @ Base.jl:37 within `getproperty`
│    │││ %279 = Base.getfield(%278, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││└
│    ││┌ @ tuple.jl:322 within `map`
│    │││┌ @ tuple.jl:31 within `getindex`
│    ││││ %280 = Base.getfield(%279, 1, true)::Base.OneTo{Int64}
│    │││└
│    │││┌ @ range.jl:1439 within `in`
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %281 = Base.sle_int(1, %262)::Bool
│    ││││└
│    ││││┌ @ range.jl:839 within `last`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %282 = Base.getfield(%280, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %283 = Base.sle_int(%262, %282)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %284 = Base.and_int(%281, %283)::Bool
│    │││└└
│    │││┌ @ essentials.jl:374 within `tail`
│    ││││ %285 = Core.getfield(%279, 2)::Base.OneTo{Int64}
│    ││││ %286 = Core.getfield(%279, 3)::Base.OneTo{Int64}
│    │││└
│    │││ @ tuple.jl:322 within `map` @ tuple.jl:319
│    │││┌ @ range.jl:1439 within `in`
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %287 = Base.sle_int(1, %269)::Bool
│    ││││└
│    ││││┌ @ range.jl:839 within `last`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %288 = Base.getfield(%285, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %289 = Base.sle_int(%269, %288)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %290 = Base.and_int(%287, %289)::Bool
│    ││││└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %291 = Base.sle_int(1, %276)::Bool
│    ││││└
│    ││││┌ @ range.jl:839 within `last`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %292 = Base.getfield(%286, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %293 = Base.sle_int(%276, %292)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %294 = Base.and_int(%291, %293)::Bool
│    ││└└└
│    ││┌ @ tuple.jl:600 within `all`
│    │││┌ @ bool.jl:38 within `&`
│    ││││ %295 = Base.and_int(%284, %290)::Bool
│    ││││ %296 = Base.and_int(%295, %294)::Bool
│    │└└└
└────│        goto #69
     └
69 ──        goto #186 if not %296
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:95 within `gpu_kernel_xx!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:12 within `macro expansion`
     │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:125 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:23 within `__iterspace`
     │││┌ @ Base.jl:37 within `getproperty`
70 ──││││ %299 = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{3, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %300 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││ %301 = Base.llvmcall(%300, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    ││││││ %302 = Base.add_int(%301, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %303 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%303, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %305 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%305, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %307 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││ %308 = Base.llvmcall(%307, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1068 within `+` @ int.jl:87
│    ││││││ %309 = Base.add_int(%308, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %310 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%310, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││││ %312 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%312, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand`
│    │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:64 within `blocks`
│    ││││┌ @ Base.jl:37 within `getproperty`
│    │││││ %314 = Base.getfield(%299, :blocks)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1291 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %315 = Core.zext_int(Core.Int64, %302)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1335 within `_getindex`
└────│││││        goto #75 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
71 ──││││││ %317 = Core.tuple(%315)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:388 within `eachindex`
│    │││││││┌ @ multidimensional.jl:455 within `length`
│    ││││││││┌ @ multidimensional.jl:453 within `size`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %318 = Base.getfield(%314, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:293 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %319 = Base.getfield(%318, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %320 = Base.getfield(%319, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %321 = Base.getfield(%318, 2, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %322 = Base.getfield(%321, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %323 = Base.getfield(%318, 3, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %324 = Base.getfield(%323, :stop)::Int64
│    ││││││││└└└└
│    ││││││││┌ @ tuple.jl:595 within `prod`
│    │││││││││┌ @ operators.jl:587 within `*` @ int.jl:88
│    ││││││││││ %325 = Base.mul_int(%320, %322)::Int64
│    ││││││││││ %326 = Base.mul_int(%325, %324)::Int64
│    │││││││└└└
│    │││││││┌ @ range.jl:469 within `oneto`
│    ││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %327 = Base.slt_int(%326, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││ %328 = Core.ifelse(%327, 0, %326)::Int64
│    ││││││└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %329 = Base.sub_int(%315, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %330 = Base.bitcast(UInt64, %329)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %331 = Base.bitcast(UInt64, %328)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %332 = Base.ult_int(%330, %331)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #73 if not %332
72 ──││││││        goto #74
73 ──││││││        invoke Base.throw_boundserror(%314::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %317::Tuple{Int64})::Union{}
└────││││││        unreachable
74 ──││││││        nothing::Nothing
     │││││└
     │││││ @ abstractarray.jl:1336 within `_getindex`
     │││││┌ @ abstractarray.jl:1343 within `_to_subscript_indices`
     ││││││┌ @ abstractarray.jl:1365 within `_unsafe_ind2sub`
     │││││││┌ @ abstractarray.jl:2962 within `_ind2sub`
     ││││││││┌ @ multidimensional.jl:344 within `axes`
     │││││││││┌ @ Base.jl:37 within `getproperty`
75 ┄─││││││││││ %338 = Base.getfield(%314, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:293 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %339 = Base.getfield(%338, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %340 = Base.getfield(%339, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %341 = Base.slt_int(%340, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %342 = Core.ifelse(%341, 0, %340)::Int64
│    ││││││││││└└└└└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %343 = Base.getfield(%338, 2, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %344 = Base.getfield(%343, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %345 = Base.slt_int(%344, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %346 = Core.ifelse(%345, 0, %344)::Int64
│    ││││││││└└└└└└└└
│    ││││││││ @ abstractarray.jl:2962 within `_ind2sub` @ abstractarray.jl:3000
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %347 = Base.sub_int(%315, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:3013 within `_ind2sub_recurse`
│    │││││││││┌ @ abstractarray.jl:3020 within `_div`
│    ││││││││││┌ @ int.jl:295 within `div`
│    │││││││││││ %348 = Base.checked_sdiv_int(%347, %342)::Int64
│    │││││││││└└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse`
│    │││││││││┌ @ int.jl:88 within `*`
│    ││││││││││ %349 = Base.mul_int(%342, %348)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %350 = Base.sub_int(%347, %349)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %351 = Base.add_int(%350, 1)::Int64
│    │││││││││└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3013
│    │││││││││┌ @ abstractarray.jl:3020 within `_div`
│    ││││││││││┌ @ int.jl:295 within `div`
│    │││││││││││ %352 = Base.checked_sdiv_int(%348, %346)::Int64
│    │││││││││└└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014
│    │││││││││┌ @ int.jl:88 within `*`
│    ││││││││││ %353 = Base.mul_int(%346, %352)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %354 = Base.sub_int(%348, %353)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %355 = Base.add_int(%354, 1)::Int64
│    │││││││││└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014 @ abstractarray.jl:3008
│    │││││││││┌ @ abstractarray.jl:3018 within `_lookup`
│    ││││││││││┌ @ int.jl:87 within `+`
│    │││││││││││ %356 = Base.add_int(%352, 1)::Int64
│    │││││└└└└└└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────││││││        goto #80 if not false
     ││││││┌ @ abstractarray.jl:700 within `checkbounds`
76 ──│││││││ %358 = Core.tuple(%351, %355, %356)::Tuple{Int64, Int64, Int64}
│    │││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:681
│    │││││││┌ @ multidimensional.jl:344 within `axes`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %359 = Base.getfield(%314, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %360 = Base.getfield(%359, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %361 = Base.getfield(%360, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %362 = Base.slt_int(%361, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %363 = Core.ifelse(%362, 0, %361)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %364 = Base.getfield(%359, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %365 = Base.getfield(%364, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %366 = Base.slt_int(%365, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %367 = Core.ifelse(%366, 0, %365)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %368 = Base.getfield(%359, 3, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %369 = Base.getfield(%368, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %370 = Base.slt_int(%369, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %371 = Core.ifelse(%370, 0, %369)::Int64
│    │││││││└└└└└└└└
│    │││││││┌ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %372 = Base.sub_int(%351, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %373 = Base.bitcast(UInt64, %372)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %374 = Base.bitcast(UInt64, %363)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %375 = Base.ult_int(%373, %374)::Bool
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %376 = Base.sub_int(%355, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %377 = Base.bitcast(UInt64, %376)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %378 = Base.bitcast(UInt64, %367)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %379 = Base.ult_int(%377, %378)::Bool
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728 @ abstractarray.jl:728
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %380 = Base.sub_int(%356, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %381 = Base.bitcast(UInt64, %380)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %382 = Base.bitcast(UInt64, %371)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %383 = Base.ult_int(%381, %382)::Bool
│    ││││││││└└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %384 = Base.and_int(%383, true)::Bool
│    ││││││││└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %385 = Base.and_int(%379, %384)::Bool
│    ││││││││└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %386 = Base.and_int(%375, %385)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││││        goto #78 if not %386
77 ──│││││││        goto #79
78 ──│││││││        invoke Base.throw_boundserror(%314::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %358::Tuple{Int64, Int64, Int64})::Union{}
└────│││││││        unreachable
79 ──│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
80 ┄─│││││││ %392 = Base.getfield(%314, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:322 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %393 = Base.getfield(%392, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #84 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
81 ──│││││││││││ %395 = Base.slt_int(0, %351)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %396 = Base.getfield(%393, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %397 = Base.sle_int(%351, %396)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %398 = Base.and_int(%395, %397)::Bool
│    │││││││││└
└────│││││││││        goto #83 if not %398
82 ──│││││││││        goto #84
83 ──│││││││││        invoke Base.throw_boundserror(%393::Base.OneTo{Int64}, %351::Int64)::Union{}
└────│││││││││        unreachable
84 ┄─│││││││││        goto #85
85 ──│││││││││        goto #86
     │││││││└└
     │││││││┌ @ essentials.jl:374 within `tail`
86 ──││││││││ %405 = Core.getfield(%392, 2)::Base.OneTo{Int64}
│    ││││││││ %406 = Core.getfield(%392, 3)::Base.OneTo{Int64}
│    │││││││└
│    │││││││ @ tuple.jl:322 within `map` @ tuple.jl:319
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #90 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
87 ──│││││││││││ %408 = Base.slt_int(0, %355)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %409 = Base.getfield(%405, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %410 = Base.sle_int(%355, %409)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %411 = Base.and_int(%408, %410)::Bool
│    │││││││││└
└────│││││││││        goto #89 if not %411
88 ──│││││││││        goto #90
89 ──│││││││││        invoke Base.throw_boundserror(%405::Base.OneTo{Int64}, %355::Int64)::Union{}
└────│││││││││        unreachable
90 ┄─│││││││││        goto #91
91 ──│││││││││        goto #92
     │││││││││ @ range.jl:937 within `getindex`
92 ──│││││││││        goto #96 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
93 ──│││││││││││ %419 = Base.slt_int(0, %356)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %420 = Base.getfield(%406, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %421 = Base.sle_int(%356, %420)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %422 = Base.and_int(%419, %421)::Bool
│    │││││││││└
└────│││││││││        goto #95 if not %422
94 ──│││││││││        goto #96
95 ──│││││││││        invoke Base.throw_boundserror(%406::Base.OneTo{Int64}, %356::Int64)::Union{}
└────│││││││││        unreachable
96 ┄─│││││││││        goto #97
97 ──│││││││││        goto #98
98 ──│││││││││        goto #99
99 ──│││││││││        goto #100
100 ─│││││││││        goto #101
101 ─│││││││││        goto #102
102 ─│││││││││        goto #103
     │││└└└└└└
     │││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     ││││┌ @ Base.jl:37 within `getproperty`
103 ─│││││ %434 = Base.getfield(%299, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1291 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %435 = Core.zext_int(Core.Int64, %309)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1335 within `_getindex`
└────│││││        goto #108 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
104 ─││││││ %437 = Core.tuple(%435)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:388 within `eachindex`
│    │││││││┌ @ multidimensional.jl:455 within `length`
│    ││││││││┌ @ multidimensional.jl:453 within `size`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %438 = Base.getfield(%434, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:293 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %439 = Base.getfield(%438, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %440 = Base.getfield(%439, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %441 = Base.getfield(%438, 2, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %442 = Base.getfield(%441, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %443 = Base.getfield(%438, 3, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %444 = Base.getfield(%443, :stop)::Int64
│    ││││││││└└└└
│    ││││││││┌ @ tuple.jl:595 within `prod`
│    │││││││││┌ @ operators.jl:587 within `*` @ int.jl:88
│    ││││││││││ %445 = Base.mul_int(%440, %442)::Int64
│    ││││││││││ %446 = Base.mul_int(%445, %444)::Int64
│    │││││││└└└
│    │││││││┌ @ range.jl:469 within `oneto`
│    ││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %447 = Base.slt_int(%446, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││ %448 = Core.ifelse(%447, 0, %446)::Int64
│    ││││││└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %449 = Base.sub_int(%435, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %450 = Base.bitcast(UInt64, %449)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %451 = Base.bitcast(UInt64, %448)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %452 = Base.ult_int(%450, %451)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #106 if not %452
105 ─││││││        goto #107
106 ─││││││        invoke Base.throw_boundserror(%434::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %437::Tuple{Int64})::Union{}
└────││││││        unreachable
107 ─││││││        nothing::Nothing
     │││││└
     │││││ @ abstractarray.jl:1336 within `_getindex`
     │││││┌ @ abstractarray.jl:1343 within `_to_subscript_indices`
     ││││││┌ @ abstractarray.jl:1365 within `_unsafe_ind2sub`
     │││││││┌ @ abstractarray.jl:2962 within `_ind2sub`
     ││││││││┌ @ multidimensional.jl:344 within `axes`
     │││││││││┌ @ Base.jl:37 within `getproperty`
108 ┄││││││││││ %458 = Base.getfield(%434, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:293 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %459 = Base.getfield(%458, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %460 = Base.getfield(%459, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %461 = Base.slt_int(%460, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %462 = Core.ifelse(%461, 0, %460)::Int64
│    ││││││││││└└└└└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %463 = Base.getfield(%458, 2, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %464 = Base.getfield(%463, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %465 = Base.slt_int(%464, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││││ %466 = Core.ifelse(%465, 0, %464)::Int64
│    ││││││││└└└└└└└└
│    ││││││││ @ abstractarray.jl:2962 within `_ind2sub` @ abstractarray.jl:3000
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %467 = Base.sub_int(%435, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:3013 within `_ind2sub_recurse`
│    │││││││││┌ @ abstractarray.jl:3020 within `_div`
│    ││││││││││┌ @ int.jl:295 within `div`
│    │││││││││││ %468 = Base.checked_sdiv_int(%467, %462)::Int64
│    │││││││││└└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse`
│    │││││││││┌ @ int.jl:88 within `*`
│    ││││││││││ %469 = Base.mul_int(%462, %468)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %470 = Base.sub_int(%467, %469)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %471 = Base.add_int(%470, 1)::Int64
│    │││││││││└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3013
│    │││││││││┌ @ abstractarray.jl:3020 within `_div`
│    ││││││││││┌ @ int.jl:295 within `div`
│    │││││││││││ %472 = Base.checked_sdiv_int(%468, %466)::Int64
│    │││││││││└└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014
│    │││││││││┌ @ int.jl:88 within `*`
│    ││││││││││ %473 = Base.mul_int(%466, %472)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %474 = Base.sub_int(%468, %473)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:87 within `+`
│    ││││││││││ %475 = Base.add_int(%474, 1)::Int64
│    │││││││││└
│    │││││││││ @ abstractarray.jl:3014 within `_ind2sub_recurse` @ abstractarray.jl:3014 @ abstractarray.jl:3008
│    │││││││││┌ @ abstractarray.jl:3018 within `_lookup`
│    ││││││││││┌ @ int.jl:87 within `+`
│    │││││││││││ %476 = Base.add_int(%472, 1)::Int64
│    │││││└└└└└└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
└────││││││        goto #113 if not false
     ││││││┌ @ abstractarray.jl:700 within `checkbounds`
109 ─│││││││ %478 = Core.tuple(%471, %475, %476)::Tuple{Int64, Int64, Int64}
│    │││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:681
│    │││││││┌ @ multidimensional.jl:344 within `axes`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %479 = Base.getfield(%434, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││││└
│    ││││││││┌ @ tuple.jl:293 within `map`
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %480 = Base.getfield(%479, 1, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %481 = Base.getfield(%480, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %482 = Base.slt_int(%481, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %483 = Core.ifelse(%482, 0, %481)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %484 = Base.getfield(%479, 2, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %485 = Base.getfield(%484, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %486 = Base.slt_int(%485, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %487 = Core.ifelse(%486, 0, %485)::Int64
│    │││││││││└└└└└└
│    │││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││ %488 = Base.getfield(%479, 3, true)::Base.OneTo{Int64}
│    │││││││││└
│    │││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││┌ @ range.jl:706 within `axes`
│    │││││││││││┌ @ range.jl:779 within `length`
│    ││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││ %489 = Base.getfield(%488, :stop)::Int64
│    │││││││││││└└
│    │││││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││ %490 = Base.slt_int(%489, 0)::Bool
│    ││││││││││││││└
│    ││││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││││ %491 = Core.ifelse(%490, 0, %489)::Int64
│    │││││││└└└└└└└└
│    │││││││┌ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %492 = Base.sub_int(%471, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %493 = Base.bitcast(UInt64, %492)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %494 = Base.bitcast(UInt64, %483)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %495 = Base.ult_int(%493, %494)::Bool
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %496 = Base.sub_int(%475, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %497 = Base.bitcast(UInt64, %496)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %498 = Base.bitcast(UInt64, %487)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %499 = Base.ult_int(%497, %498)::Bool
│    ││││││││└└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728 @ abstractarray.jl:728
│    ││││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││││┌ @ int.jl:86 within `-`
│    ││││││││││ %500 = Base.sub_int(%476, 1)::Int64
│    │││││││││└
│    │││││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %501 = Base.bitcast(UInt64, %500)::UInt64
│    │││││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││││ %502 = Base.bitcast(UInt64, %491)::UInt64
│    │││││││││└└
│    │││││││││┌ @ int.jl:513 within `<`
│    ││││││││││ %503 = Base.ult_int(%501, %502)::Bool
│    ││││││││└└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %504 = Base.and_int(%503, true)::Bool
│    ││││││││└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %505 = Base.and_int(%499, %504)::Bool
│    ││││││││└
│    ││││││││ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %506 = Base.and_int(%495, %505)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││││        goto #111 if not %506
110 ─│││││││        goto #112
111 ─│││││││        invoke Base.throw_boundserror(%434::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %478::Tuple{Int64, Int64, Int64})::Union{}
└────│││││││        unreachable
112 ─│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
113 ┄│││││││ %512 = Base.getfield(%434, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:322 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %513 = Base.getfield(%512, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #117 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
114 ─│││││││││││ %515 = Base.slt_int(0, %471)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %516 = Base.getfield(%513, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %517 = Base.sle_int(%471, %516)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %518 = Base.and_int(%515, %517)::Bool
│    │││││││││└
└────│││││││││        goto #116 if not %518
115 ─│││││││││        goto #117
116 ─│││││││││        invoke Base.throw_boundserror(%513::Base.OneTo{Int64}, %471::Int64)::Union{}
└────│││││││││        unreachable
117 ┄│││││││││        goto #118
118 ─│││││││││        goto #119
     │││││││└└
     │││││││┌ @ essentials.jl:374 within `tail`
119 ─││││││││ %525 = Core.getfield(%512, 2)::Base.OneTo{Int64}
│    ││││││││ %526 = Core.getfield(%512, 3)::Base.OneTo{Int64}
│    │││││││└
│    │││││││ @ tuple.jl:322 within `map` @ tuple.jl:319
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ range.jl:937 within `getindex`
└────│││││││││        goto #123 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
120 ─│││││││││││ %528 = Base.slt_int(0, %475)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %529 = Base.getfield(%525, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %530 = Base.sle_int(%475, %529)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %531 = Base.and_int(%528, %530)::Bool
│    │││││││││└
└────│││││││││        goto #122 if not %531
121 ─│││││││││        goto #123
122 ─│││││││││        invoke Base.throw_boundserror(%525::Base.OneTo{Int64}, %475::Int64)::Union{}
└────│││││││││        unreachable
123 ┄│││││││││        goto #124
124 ─│││││││││        goto #125
     │││││││││ @ range.jl:937 within `getindex`
125 ─│││││││││        goto #129 if not false
     │││││││││┌ @ operators.jl:378 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
126 ─│││││││││││ %539 = Base.slt_int(0, %476)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %540 = Base.getfield(%526, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:514 within `<=`
│    ││││││││││ %541 = Base.sle_int(%476, %540)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %542 = Base.and_int(%539, %541)::Bool
│    │││││││││└
└────│││││││││        goto #128 if not %542
127 ─│││││││││        goto #129
128 ─│││││││││        invoke Base.throw_boundserror(%526::Base.OneTo{Int64}, %476::Int64)::Union{}
└────│││││││││        unreachable
129 ┄│││││││││        goto #130
130 ─│││││││││        goto #131
131 ─│││││││││        goto #132
132 ─│││││││││        goto #133
133 ─│││││││││        goto #134
134 ─│││││││││        goto #135
135 ─│││││││││        goto #136
     │││└└└└└└
     │││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:84 within `expand` @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:74
     │││┌ @ ntuple.jl:50 within `ntuple`
     ││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
     │││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
     ││││││┌ @ Base.jl:37 within `getproperty`
136 ─│││││││ %554 = Base.getfield(%299, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │││││└└
│    │││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %555 = Base.getfield(%554, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:293 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %556 = Base.getfield(%555, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ range.jl:779 within `length`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %557 = Base.getfield(%556, :stop)::Int64
│    │││││└└└└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %558 = Base.sub_int(%351, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %559 = Base.mul_int(%558, %557)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %560 = Base.add_int(%559, %471)::Int64
│    │││││└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
│    │││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %561 = Base.getfield(%299, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │││││└└
│    │││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %562 = Base.getfield(%561, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:293 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %563 = Base.getfield(%562, 2, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ range.jl:779 within `length`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %564 = Base.getfield(%563, :stop)::Int64
│    │││││└└└└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %565 = Base.sub_int(%355, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %566 = Base.mul_int(%565, %564)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %567 = Base.add_int(%566, %475)::Int64
│    │││││└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:76 within `#1`
│    │││││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:62 within `workitems`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %568 = Base.getfield(%299, :workitems)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    │││││└└
│    │││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:453
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %569 = Base.getfield(%568, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:293 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %570 = Base.getfield(%569, 3, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ range.jl:779 within `length`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %571 = Base.getfield(%570, :stop)::Int64
│    │││││└└└└
│    │││││ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/nditeration.jl:78 within `#1`
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %572 = Base.sub_int(%356, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %573 = Base.mul_int(%572, %571)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %574 = Base.add_int(%573, %476)::Int64
└────││││││        goto #137
     ││└└└└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:127 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/compiler.jl:28 within `__ndrange`
     │││┌ @ Base.jl:37 within `getproperty`
137 ─││││ %576 = Base.getfield(__ctx__, :ndrange)::CartesianIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ multidimensional.jl:576 within `LinearIndices`
│    │││┌ @ Base.jl:37 within `getproperty`
│    ││││ %577 = Base.getfield(%576, :indices)::Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}
│    │││└
│    │││ @ multidimensional.jl:576 within `LinearIndices` @ indices.jl:476
│    │││ %578 = %new(LinearIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %577)::LinearIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}
│    ││└
│    ││┌ @ abstractarray.jl:1291 within `getindex`
│    │││┌ @ abstractarray.jl:1323 within `_getindex`
└────││││        goto #142 if not false
     ││││┌ @ abstractarray.jl:700 within `checkbounds`
138 ─│││││ %580 = Core.tuple(%560, %567, %574)::Tuple{Int64, Int64, Int64}
│    │││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:681
│    │││││┌ @ indices.jl:505 within `axes`
│    ││││││┌ @ tuple.jl:293 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %581 = Base.getfield(%577, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ range.jl:706 within `axes`
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %582 = Base.getfield(%581, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││ %583 = Base.slt_int(%582, 0)::Bool
│    ││││││││││││└
│    ││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││ %584 = Core.ifelse(%583, 0, %582)::Int64
│    │││││││└└└└└└
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %585 = Base.getfield(%577, 2, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ range.jl:706 within `axes`
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %586 = Base.getfield(%585, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││ %587 = Base.slt_int(%586, 0)::Bool
│    ││││││││││││└
│    ││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││ %588 = Core.ifelse(%587, 0, %586)::Int64
│    │││││││└└└└└└
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %589 = Base.getfield(%577, 3, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ range.jl:706 within `axes`
│    │││││││││┌ @ range.jl:779 within `length`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %590 = Base.getfield(%589, :stop)::Int64
│    │││││││││└└
│    │││││││││┌ @ range.jl:469 within `oneto`
│    ││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││ %591 = Base.slt_int(%590, 0)::Bool
│    ││││││││││││└
│    ││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││││ %592 = Core.ifelse(%591, 0, %590)::Int64
│    │││││└└└└└└└└
│    │││││┌ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %593 = Base.sub_int(%560, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %594 = Base.bitcast(UInt64, %593)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %595 = Base.bitcast(UInt64, %584)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %596 = Base.ult_int(%594, %595)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %597 = Base.sub_int(%567, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %598 = Base.bitcast(UInt64, %597)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %599 = Base.bitcast(UInt64, %588)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %600 = Base.ult_int(%598, %599)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728 @ abstractarray.jl:728
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %601 = Base.sub_int(%574, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %602 = Base.bitcast(UInt64, %601)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %603 = Base.bitcast(UInt64, %592)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %604 = Base.ult_int(%602, %603)::Bool
│    ││││││└└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %605 = Base.and_int(%604, true)::Bool
│    ││││││└
│    ││││││ @ abstractarray.jl:728 within `checkbounds_indices` @ abstractarray.jl:728
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %606 = Base.and_int(%600, %605)::Bool
│    ││││││└
│    ││││││ @ abstractarray.jl:728 within `checkbounds_indices`
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %607 = Base.and_int(%596, %606)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:702 within `checkbounds`
└────│││││        goto #140 if not %607
139 ─│││││        goto #141
140 ─│││││        invoke Base.throw_boundserror(%578::LinearIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %580::Tuple{Int64, Int64, Int64})::Union{}
└────│││││        unreachable
141 ─│││││        nothing::Nothing
     ││││└
     ││││ @ abstractarray.jl:1324 within `_getindex`
     ││││┌ @ abstractarray.jl:1330 within `_to_linear_index`
     │││││┌ @ abstractarray.jl:2957 within `_sub2ind`
     ││││││┌ @ indices.jl:505 within `axes`
     │││││││┌ @ tuple.jl:293 within `map`
     ││││││││┌ @ tuple.jl:31 within `getindex`
142 ┄│││││││││ %613 = Base.getfield(%577, 1, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %614 = Base.getfield(%613, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %615 = Base.slt_int(%614, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %616 = Core.ifelse(%615, 0, %614)::Int64
│    ││││││││└└└└└└
│    ││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││ %617 = Base.getfield(%577, 2, true)::Base.OneTo{Int64}
│    ││││││││└
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ range.jl:706 within `axes`
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %618 = Base.getfield(%617, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ range.jl:469 within `oneto`
│    │││││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││││││││┌ @ promotion.jl:532 within `max`
│    │││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││ %619 = Base.slt_int(%618, 0)::Bool
│    │││││││││││││└
│    │││││││││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││││││││ %620 = Core.ifelse(%619, 0, %618)::Int64
│    ││││││└└└└└└└└
│    ││││││ @ abstractarray.jl:2957 within `_sub2ind` @ abstractarray.jl:2973
│    ││││││┌ @ abstractarray.jl:2989 within `_sub2ind_recurse`
│    │││││││┌ @ abstractarray.jl:2993 within `nextL`
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %621 = Base.mul_int(1, %616)::Int64
│    │││││││└└
│    │││││││┌ @ abstractarray.jl:2996 within `offsetin`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %622 = Base.sub_int(%560, 1)::Int64
│    │││││││└└
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %623 = Base.mul_int(%622, 1)::Int64
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %624 = Base.add_int(1, %623)::Int64
│    │││││││└
│    │││││││ @ abstractarray.jl:2989 within `_sub2ind_recurse` @ abstractarray.jl:2989
│    │││││││┌ @ abstractarray.jl:2993 within `nextL`
│    ││││││││┌ @ int.jl:88 within `*`
│    │││││││││ %625 = Base.mul_int(%621, %620)::Int64
│    │││││││└└
│    │││││││┌ @ abstractarray.jl:2996 within `offsetin`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %626 = Base.sub_int(%567, 1)::Int64
│    │││││││└└
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %627 = Base.mul_int(%626, %621)::Int64
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %628 = Base.add_int(%624, %627)::Int64
│    │││││││└
│    │││││││ @ abstractarray.jl:2989 within `_sub2ind_recurse` @ abstractarray.jl:2989 @ abstractarray.jl:2989
│    │││││││┌ @ abstractarray.jl:2996 within `offsetin`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %629 = Base.sub_int(%574, 1)::Int64
│    │││││││└└
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %630 = Base.mul_int(%629, %625)::Int64
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %631 = Base.add_int(%628, %630)::Int64
│    ││││└└└└
│    ││││┌ @ indices.jl:510 within `getindex`
└────│││││        goto #147 if not false
     │││││┌ @ abstractarray.jl:700 within `checkbounds`
143 ─││││││ %633 = Core.tuple(%631)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    ││││││┌ @ abstractarray.jl:388 within `eachindex`
│    │││││││┌ @ abstractarray.jl:315 within `length`
│    ││││││││┌ @ indices.jl:506 within `size`
│    │││││││││┌ @ tuple.jl:293 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %634 = Base.getfield(%577, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %635 = Base.getfield(%634, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %636 = Base.getfield(%577, 2, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %637 = Base.getfield(%636, :stop)::Int64
│    ││││││││││└└
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %638 = Base.getfield(%577, 3, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ range.jl:779 within `length`
│    │││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││ %639 = Base.getfield(%638, :stop)::Int64
│    ││││││││└└└└
│    ││││││││┌ @ tuple.jl:595 within `prod`
│    │││││││││┌ @ operators.jl:587 within `*` @ int.jl:88
│    ││││││││││ %640 = Base.mul_int(%635, %637)::Int64
│    ││││││││││ %641 = Base.mul_int(%640, %639)::Int64
│    │││││││└└└
│    │││││││┌ @ range.jl:469 within `oneto`
│    ││││││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    │││││││││┌ @ promotion.jl:532 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %642 = Base.slt_int(%641, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:647 within `ifelse`
│    │││││││││││ %643 = Core.ifelse(%642, 0, %641)::Int64
│    ││││││└└└└└
│    ││││││┌ @ abstractarray.jl:763 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %644 = Base.sub_int(%631, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:524 within `unsigned`
│    ││││││││┌ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %645 = Base.bitcast(UInt64, %644)::UInt64
│    │││││││││ @ essentials.jl:581 within `reinterpret`
│    │││││││││ %646 = Base.bitcast(UInt64, %643)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %647 = Base.ult_int(%645, %646)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:702 within `checkbounds`
└────││││││        goto #145 if not %647
144 ─││││││        goto #146
145 ─││││││        invoke Base.throw_boundserror(%578::LinearIndices{3, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}, Base.OneTo{Int64}}}, %633::Tuple{Int64})::Union{}
└────││││││        unreachable
146 ─││││││        nothing::Nothing
147 ┄││││││        goto #148
148 ─││││││        goto #149
149 ─││││││        goto #150
150 ─││││││        goto #151
     │└└└└└
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:14 within `macro expansion`
     │┌ @ int.jl:85 within `-`
151 ─││ %657 = Base.neg_int(Nx)::Int64
│    │└
│    │┌ @ range.jl:5 within `Colon`
│    ││┌ @ range.jl:403 within `UnitRange`
│    │││┌ @ range.jl:414 within `unitrange_last`
│    ││││┌ @ operators.jl:425 within `>=`
│    │││││┌ @ int.jl:514 within `<=`
│    ││││││ %658 = Base.sle_int(%657, Nx)::Bool
│    ││││└└
└────││││        goto #153 if not %658
152 ─││││        goto #154
     ││││┌ @ int.jl:86 within `-`
153 ─│││││ %661 = Base.sub_int(%657, 1)::Int64
└────│││││        goto #154
     │││└└
154 ┄│││ %663 = φ (#152 => Nx, #153 => %661)::Int64
└────│││        goto #155
155 ─│││        goto #156
     │└└
     │┌ @ range.jl:897 within `iterate`
     ││┌ @ range.jl:672 within `isempty`
     │││┌ @ operators.jl:378 within `>`
     ││││┌ @ int.jl:83 within `<`
156 ─│││││ %666 = Base.slt_int(%663, %657)::Bool
│    ││└└└
└────││        goto #158 if not %666
157 ─││        goto #159
158 ─││        goto #159
     │└
159 ┄│ %670 = φ (#157 => true, #158 => false)::Bool
│    │ %671 = φ (#158 => %657)::Int64
│    │ %672 = Base.not_int(%670)::Bool
└────│        goto #179 if not %672
160 ┄│ %674 = φ (#159 => %671, #178 => %712)::Int64
│    │ %675 = φ (#159 => 0.0, #178 => %706)::Float64
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:15 within `macro expansion`
│    │┌ @ int.jl:85 within `-`
│    ││ %676 = Base.neg_int(Ny)::Int64
│    │└
│    │┌ @ range.jl:5 within `Colon`
│    ││┌ @ range.jl:403 within `UnitRange`
│    │││┌ @ range.jl:414 within `unitrange_last`
│    ││││┌ @ operators.jl:425 within `>=`
│    │││││┌ @ int.jl:514 within `<=`
│    ││││││ %677 = Base.sle_int(%676, Ny)::Bool
│    ││││└└
└────││││        goto #162 if not %677
161 ─││││        goto #163
     ││││┌ @ int.jl:86 within `-`
162 ─│││││ %680 = Base.sub_int(%676, 1)::Int64
└────│││││        goto #163
     │││└└
163 ┄│││ %682 = φ (#161 => Ny, #162 => %680)::Int64
└────│││        goto #164
164 ─│││        goto #165
     │└└
     │┌ @ range.jl:897 within `iterate`
     ││┌ @ range.jl:672 within `isempty`
     │││┌ @ operators.jl:378 within `>`
     ││││┌ @ int.jl:83 within `<`
165 ─│││││ %685 = Base.slt_int(%682, %676)::Bool
│    ││└└└
└────││        goto #167 if not %685
166 ─││        goto #168
167 ─││        goto #168
     │└
168 ┄│ %689 = φ (#166 => true, #167 => false)::Bool
│    │ %690 = φ (#167 => %676)::Int64
│    │ %691 = Base.not_int(%689)::Bool
└────│        goto #174 if not %691
169 ┄│ %693 = φ (#168 => %675, #173 => %695)::Float64
│    │ %694 = φ (#168 => %690, #173 => %701)::Int64
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:16 within `macro expansion`
│    │┌ @ float.jl:409 within `+`
│    ││ %695 = Base.add_float(%693, 2.0)::Float64
│    │└
│    │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:17 within `macro expansion`
│    │┌ @ range.jl:901 within `iterate`
│    ││┌ @ promotion.jl:521 within `==`
│    │││ %696 = (%694 === %682)::Bool
│    ││└
└────││        goto #171 if not %696
170 ─││        goto #172
     ││ @ range.jl:902 within `iterate`
     ││┌ @ int.jl:87 within `+`
171 ─│││ %699 = Base.add_int(%694, 1)::Int64
└────│││        goto #172
     │└└
172 ┄│ %701 = φ (#171 => %699)::Int64
│    │ %702 = φ (#170 => true, #171 => false)::Bool
│    │ %703 = Base.not_int(%702)::Bool
└────│        goto #174 if not %703
173 ─│        goto #169
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:18 within `macro expansion`
174 ┄│ %706 = φ (#172 => %695, #168 => %675)::Float64
│    │┌ @ range.jl:901 within `iterate`
│    ││┌ @ promotion.jl:521 within `==`
│    │││ %707 = (%674 === %663)::Bool
│    ││└
└────││        goto #176 if not %707
175 ─││        goto #177
     ││ @ range.jl:902 within `iterate`
     ││┌ @ int.jl:87 within `+`
176 ─│││ %710 = Base.add_int(%674, 1)::Int64
└────│││        goto #177
     │└└
177 ┄│ %712 = φ (#176 => %710)::Int64
│    │ %713 = φ (#175 => true, #176 => false)::Bool
│    │ %714 = Base.not_int(%713)::Bool
└────│        goto #179 if not %714
178 ─│        goto #160
     │ @ /home/pxlth/.julia/dev/AMDGPU/a.jl:19 within `macro expansion`
179 ┄│ %717 = φ (#177 => %706, #159 => 0.0)::Float64
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:88 within `#setindex!`
└────││        goto #184 if not false
     ││┌ @ abstractarray.jl:700 within `checkbounds`
180 ─│││ %719 = Core.tuple(%631)::Tuple{Int64}
│    │││ @ abstractarray.jl:702 within `checkbounds` @ abstractarray.jl:687
│    │││┌ @ abstractarray.jl:388 within `eachindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `length`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %720 = Base.getfield(tensor, :len)::Int64
│    ││││└└
│    ││││┌ @ range.jl:469 within `oneto`
│    │││││┌ @ range.jl:467 within `OneTo` @ range.jl:454
│    ││││││┌ @ promotion.jl:532 within `max`
│    │││││││┌ @ int.jl:83 within `<`
│    ││││││││ %721 = Base.slt_int(%720, 0)::Bool
│    │││││││└
│    │││││││┌ @ essentials.jl:647 within `ifelse`
│    ││││││││ %722 = Core.ifelse(%721, 0, %720)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:763 within `checkindex`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %723 = Base.sub_int(%631, 1)::Int64
│    ││││└
│    ││││┌ @ essentials.jl:524 within `unsigned`
│    │││││┌ @ essentials.jl:581 within `reinterpret`
│    ││││││ %724 = Base.bitcast(UInt64, %723)::UInt64
│    ││││││ @ essentials.jl:581 within `reinterpret`
│    ││││││ %725 = Base.bitcast(UInt64, %722)::UInt64
│    ││││└└
│    ││││┌ @ int.jl:513 within `<`
│    │││││ %726 = Base.ult_int(%724, %725)::Bool
│    │││└└
│    │││ @ abstractarray.jl:702 within `checkbounds`
└────│││        goto #182 if not %726
181 ─│││        goto #183
182 ─│││        invoke Base.throw_boundserror(tensor::ROCDeviceArray{Float64, 3, 1}, %719::Tuple{Int64})::Union{}
└────│││        unreachable
183 ─│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:63 within `pointer`
     │││┌ @ Base.jl:37 within `getproperty`
184 ┄││││ %732 = Base.getfield(tensor, :ptr)::Core.LLVMPtr{Float64, 1}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││┌ @ none within `pointerset`
│    ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/UqMfW/src/interop/base.jl:39
│    │││││ %733 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, double %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to double addrspace(1)*\n  %4 = getelementptr inbounds double, double addrspace(1)* %3, i64 %2\n  store double %1, double addrspace(1)* %4, align 8, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %734 = Base.sub_int(%631, 1)::Int64
│    │││││└
│    │││││        Base.llvmcall(%733, Nothing, Tuple{Core.LLVMPtr{Float64, 1}, Float64, Int64}, %732, %717, %734)::Nothing
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:91 within `#setindex!`
└────││        goto #185
185 ─││        nothing::Nothing
     └└
      @ /home/pxlth/.julia/packages/KernelAbstractions/60cqT/src/macros.jl:97 within `gpu_kernel_xx!`
186 ┄        return Main.nothing
) => Nothing
