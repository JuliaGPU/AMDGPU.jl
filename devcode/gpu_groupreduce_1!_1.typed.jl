CodeInfo(
      @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:96 within `gpu_groupreduce_1!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:141 within `#__validindex`
     │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:23 within `__iterspace`
     ││┌ @ Base.jl:49 within `getproperty`
1 ───│││ %1   = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.StaticSize{(256,)}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, Nothing}
│    │└└
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %2   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││ %3   = Base.llvmcall(%2, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1013 within `+` @ int.jl:87
│    │││││ %4   = Base.add_int(%3, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %5   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%5, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %7   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%7, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %9   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││ %10  = Base.llvmcall(%9, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1013 within `+` @ int.jl:87
│    │││││ %11  = Base.add_int(%10, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %12  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%12, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %14  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%14, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:117 within `expand`
│    ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:64 within `blocks`
│    │││┌ @ Base.jl:49 within `getproperty`
│    ││││ %16  = Base.getfield(%1, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:119 within `expand`
│    ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
│    │││┌ @ ntuple.jl:48 within `ntuple`
│    ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:110 within `#3`
│    │││││┌ @ Base.jl:49 within `getproperty`
│    ││││││ %17  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:31 within `getindex`
│    ││││││ %18  = $(Expr(:boundscheck, true))::Bool
│    ││││││ %19  = Base.getfield(%17, 1, %18)::Base.OneTo{Int64}
│    │││││└
│    │││││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
│    │││││┌ @ Base.jl:49 within `getproperty`
│    ││││││ %20  = Base.getfield(%19, :stop)::Int64
│    │││││└
│    │││││┌ @ operators.jl:379 within `>`
│    ││││││┌ @ int.jl:83 within `<`
│    │││││││ %21  = Base.slt_int(0, %20)::Bool
│    │││││└└
│    │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
│    ││││││ %22  = Core.tuple("declare void @llvm.assume(i1)\n\ndefine void @entry(i8) #0 {\n    %cond = icmp eq i8 %0, 1\n    call void @llvm.assume(i1 %cond)\n    ret void\n}\n\nattributes #0 = { alwaysinline }", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%22, KernelAbstractions.NDIteration.Nothing, Tuple{Bool}, %21)::Nothing
│    ││└└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:120 within `expand`
│    ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
│    │││┌ @ ntuple.jl:48 within `ntuple`
│    ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
│    │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
│    ││││││ %24  = Core.tuple("declare void @llvm.assume(i1)\n\ndefine void @entry(i8) #0 {\n    %cond = icmp eq i8 %0, 1\n    call void @llvm.assume(i1 %cond)\n    ret void\n}\n\nattributes #0 = { alwaysinline }", "entry")::Tuple{String, String}
│    ││││││        Base.llvmcall(%24, KernelAbstractions.NDIteration.Nothing, Tuple{Bool}, true)::Nothing
│    ││└└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
│    ││┌ @ abstractarray.jl:1312 within `getindex`
│    │││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
│    ││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:892 within `Int64`
│    │││││││┌ @ boot.jl:816 within `toInt64`
│    ││││││││ %26  = Core.zext_int(Core.Int64, %4)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:1358 within `_getindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
│    │││││ %27  = $(Expr(:boundscheck, false))::Bool
└────│││││        goto #6 if not %27
     │││││┌ @ abstractarray.jl:697 within `checkbounds`
2 ───││││││ %29  = Core.tuple(%26)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ multidimensional.jl:358 within `axes`
│    │││││││││┌ @ Base.jl:49 within `getproperty`
│    ││││││││││ %30  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:355 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %31  = $(Expr(:boundscheck, true))::Bool
│    │││││││││││ %32  = Base.getfield(%30, 1, %31)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ abstractarray.jl:98 within `axes`
│    ││││││││││││┌ @ range.jl:676 within `size`
│    │││││││││││││┌ @ range.jl:786 within `length`
│    ││││││││││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││││││││││ %33  = Base.getfield(%32, :stop)::Int64
│    ││││││└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:754 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %34  = Base.sub_int(%26, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:668 within `unsigned`
│    ││││││││┌ @ essentials.jl:730 within `reinterpret`
│    │││││││││ %35  = Base.bitcast(UInt64, %34)::UInt64
│    │││││││││ @ essentials.jl:730 within `reinterpret`
│    │││││││││ %36  = Base.bitcast(UInt64, %33)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %37  = Base.ult_int(%35, %36)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:699 within `checkbounds`
└────││││││        goto #4 if not %37
3 ───││││││        goto #5
4 ───││││││        invoke Base.throw_boundserror(%16::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %29::Tuple{Int64})::Union{}
└────││││││        unreachable
5 ───││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:49 within `getproperty`
6 ┄──││││││ %43  = Base.getfield(%16, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:382 within `map`
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %44  = $(Expr(:boundscheck, true))::Bool
│    │││││││ %45  = Base.getfield(%43, 1, %44)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    │││││││┌ @ array.jl:3076 within `getindex`
│    ││││││││┌ @ range.jl:922 within `_getindex`
│    │││││││││ %46  = $(Expr(:boundscheck, false))::Bool
└────│││││││││        goto #11 if not %46
     │││││││││┌ @ abstractarray.jl:697 within `checkbounds`
7 ───││││││││││ %48  = Core.tuple(%26)::Tuple{Int64}
│    ││││││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││││┌ @ abstractarray.jl:98 within `axes`
│    │││││││││││││┌ @ range.jl:676 within `size`
│    ││││││││││││││┌ @ range.jl:786 within `length`
│    │││││││││││││││┌ @ Base.jl:49 within `getproperty`
│    ││││││││││││││││ %49  = Base.getfield(%45, :stop)::Int64
│    ││││││││││└└└└└└
│    ││││││││││┌ @ abstractarray.jl:754 within `checkindex`
│    │││││││││││┌ @ int.jl:86 within `-`
│    ││││││││││││ %50  = Base.sub_int(%26, 1)::Int64
│    │││││││││││└
│    │││││││││││┌ @ essentials.jl:668 within `unsigned`
│    ││││││││││││┌ @ essentials.jl:730 within `reinterpret`
│    │││││││││││││ %51  = Base.bitcast(UInt64, %50)::UInt64
│    │││││││││││││ @ essentials.jl:730 within `reinterpret`
│    │││││││││││││ %52  = Base.bitcast(UInt64, %49)::UInt64
│    │││││││││││└└
│    │││││││││││┌ @ int.jl:513 within `<`
│    ││││││││││││ %53  = Base.ult_int(%51, %52)::Bool
│    ││││││││││└└
│    ││││││││││ @ abstractarray.jl:699 within `checkbounds`
└────││││││││││        goto #9 if not %53
8 ───││││││││││        goto #10
9 ───││││││││││        invoke Base.throw_boundserror(%45::Base.OneTo{Int64}, %48::Tuple{Int64})::Union{}
└────││││││││││        unreachable
10 ──││││││││││        nothing::Nothing
11 ┄─││││││││││        goto #12
12 ──││││││││││        goto #13
13 ──││││││││││        goto #14
14 ──││││││││││        goto #15
15 ──││││││││││        goto #16
16 ──││││││││││        goto #17
17 ──││││││││││        goto #18
     │││└└└└└└└
     │││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
     ││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:892 within `Int64`
     │││││││┌ @ boot.jl:816 within `toInt64`
18 ──││││││││ %66  = Core.zext_int(Core.Int64, %11)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:1358 within `_getindex`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
│    │││││ %67  = $(Expr(:boundscheck, false))::Bool
└────│││││        goto #23 if not %67
     │││││┌ @ abstractarray.jl:697 within `checkbounds`
19 ──││││││ %69  = Core.tuple(%66)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││││┌ @ abstractarray.jl:754 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %70  = Base.sub_int(%66, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:668 within `unsigned`
│    ││││││││┌ @ essentials.jl:730 within `reinterpret`
│    │││││││││ %71  = Base.bitcast(UInt64, %70)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %72  = Base.ult_int(%71, 0x0000000000000100)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:699 within `checkbounds`
└────││││││        goto #21 if not %72
20 ──││││││        goto #22
21 ──││││││        invoke Base.throw_boundserror($(QuoteNode(CartesianIndices((256,))))::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %69::Tuple{Int64})::Union{}
└────││││││        unreachable
22 ──││││││        nothing::Nothing
     │││││└
     │││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ tuple.jl:382 within `map`
     ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
     │││││││┌ @ array.jl:3076 within `getindex`
     ││││││││┌ @ range.jl:922 within `_getindex`
23 ┄─│││││││││ %78  = $(Expr(:boundscheck, false))::Bool
└────│││││││││        goto #28 if not %78
     │││││││││┌ @ abstractarray.jl:697 within `checkbounds`
24 ──││││││││││ %80  = Core.tuple(%66)::Tuple{Int64}
│    ││││││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││││││││┌ @ abstractarray.jl:754 within `checkindex`
│    │││││││││││┌ @ int.jl:86 within `-`
│    ││││││││││││ %81  = Base.sub_int(%66, 1)::Int64
│    │││││││││││└
│    │││││││││││┌ @ essentials.jl:668 within `unsigned`
│    ││││││││││││┌ @ essentials.jl:730 within `reinterpret`
│    │││││││││││││ %82  = Base.bitcast(UInt64, %81)::UInt64
│    │││││││││││└└
│    │││││││││││┌ @ int.jl:513 within `<`
│    ││││││││││││ %83  = Base.ult_int(%82, 0x0000000000000100)::Bool
│    ││││││││││└└
│    ││││││││││ @ abstractarray.jl:699 within `checkbounds`
└────││││││││││        goto #26 if not %83
25 ──││││││││││        goto #27
26 ──││││││││││        invoke Base.throw_boundserror($(QuoteNode(Base.OneTo(256)))::Base.OneTo{Int64}, %80::Tuple{Int64})::Union{}
└────││││││││││        unreachable
27 ──││││││││││        nothing::Nothing
28 ┄─││││││││││        goto #29
29 ──││││││││││        goto #30
30 ──││││││││││        goto #31
31 ──││││││││││        goto #32
32 ──││││││││││        goto #33
33 ──││││││││││        goto #34
34 ──││││││││││        goto #35
     ││└└└└└└└└
     ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand` @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:75
     ││┌ @ ntuple.jl:48 within `ntuple`
     │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:79 within `#1`
     ││││┌ @ int.jl:86 within `-`
35 ──│││││ %96  = Base.sub_int(%26, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %97  = Base.mul_int(%96, 256)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %98  = Base.add_int(%97, %66)::Int64
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
└────││        goto #36
     │└
     │ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:142 within `#__validindex`
     │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:28 within `__ndrange`
     ││┌ @ Base.jl:49 within `getproperty`
36 ──│││ %100 = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │└└
│    │┌ @ multidimensional.jl:477 within `in`
│    ││┌ @ Base.jl:49 within `getproperty`
│    │││ %101 = Base.getfield(%100, :indices)::Tuple{Base.OneTo{Int64}}
│    ││└
│    ││┌ @ tuple.jl:382 within `map`
│    │││┌ @ tuple.jl:31 within `getindex`
│    ││││ %102 = $(Expr(:boundscheck, true))::Bool
│    ││││ %103 = Base.getfield(%101, 1, %102)::Base.OneTo{Int64}
│    │││└
│    │││┌ @ range.jl:1426 within `in`
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %104 = Base.sle_int(1, %98)::Bool
│    ││││└
│    ││││┌ @ range.jl:846 within `last`
│    │││││┌ @ Base.jl:49 within `getproperty`
│    ││││││ %105 = Base.getfield(%103, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:514 within `<=`
│    │││││ %106 = Base.sle_int(%98, %105)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %107 = Base.and_int(%104, %106)::Bool
│    │└└└└
└────│        goto #37
     └
37 ──        goto #198 if not %107
      @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:97 within `gpu_groupreduce_1!`
     ┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:15 within `macro expansion`
     │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:122 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:23 within `__iterspace`
     │││┌ @ Base.jl:49 within `getproperty`
38 ──││││ %110 = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.StaticSize{(256,)}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, Nothing}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:172 within `blockIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %111 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││ %112 = Base.llvmcall(%111, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1013 within `+` @ int.jl:87
│    ││││││ %113 = Base.add_int(%112, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %114 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%114, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %116 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%116, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %118 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││ %119 = Base.llvmcall(%118, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1013 within `+` @ int.jl:87
│    ││││││ %120 = Base.add_int(%119, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %121 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%121, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││││ %123 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%123, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:117 within `expand`
│    │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:64 within `blocks`
│    ││││┌ @ Base.jl:49 within `getproperty`
│    │││││ %125 = Base.getfield(%110, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:119 within `expand`
│    │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
│    ││││┌ @ ntuple.jl:48 within `ntuple`
│    │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:110 within `#3`
│    ││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││ %126 = Base.getfield(%125, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││ %127 = $(Expr(:boundscheck, true))::Bool
│    │││││││ %128 = Base.getfield(%126, 1, %127)::Base.OneTo{Int64}
│    ││││││└
│    ││││││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
│    ││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││ %129 = Base.getfield(%128, :stop)::Int64
│    ││││││└
│    ││││││┌ @ operators.jl:379 within `>`
│    │││││││┌ @ int.jl:83 within `<`
│    ││││││││ %130 = Base.slt_int(0, %129)::Bool
│    ││││││└└
│    ││││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
│    │││││││ %131 = Core.tuple("declare void @llvm.assume(i1)\n\ndefine void @entry(i8) #0 {\n    %cond = icmp eq i8 %0, 1\n    call void @llvm.assume(i1 %cond)\n    ret void\n}\n\nattributes #0 = { alwaysinline }", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%131, KernelAbstractions.NDIteration.Nothing, Tuple{Bool}, %130)::Nothing
│    │││└└└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:120 within `expand`
│    │││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:108 within `assume_nonzero`
│    ││││┌ @ ntuple.jl:48 within `ntuple`
│    │││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:111 within `#3`
│    ││││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:91 within `assume`
│    │││││││ %133 = Core.tuple("declare void @llvm.assume(i1)\n\ndefine void @entry(i8) #0 {\n    %cond = icmp eq i8 %0, 1\n    call void @llvm.assume(i1 %cond)\n    ret void\n}\n\nattributes #0 = { alwaysinline }", "entry")::Tuple{String, String}
│    │││││││        Base.llvmcall(%133, KernelAbstractions.NDIteration.Nothing, Tuple{Bool}, true)::Nothing
│    │││└└└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
│    │││┌ @ abstractarray.jl:1312 within `getindex`
│    ││││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
│    │││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:892 within `Int64`
│    ││││││││┌ @ boot.jl:816 within `toInt64`
│    │││││││││ %135 = Core.zext_int(Core.Int64, %113)::Int64
│    ││││└└└└└
│    ││││┌ @ abstractarray.jl:1358 within `_getindex`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
│    ││││││ %136 = $(Expr(:boundscheck, false))::Bool
└────││││││        goto #43 if not %136
     ││││││┌ @ abstractarray.jl:697 within `checkbounds`
39 ──│││││││ %138 = Core.tuple(%135)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││││││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││┌ @ multidimensional.jl:358 within `axes`
│    ││││││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││││││ %139 = Base.getfield(%125, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││││││└
│    ││││││││││┌ @ tuple.jl:355 within `map`
│    │││││││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││││││ %140 = $(Expr(:boundscheck, true))::Bool
│    ││││││││││││ %141 = Base.getfield(%139, 1, %140)::Base.OneTo{Int64}
│    │││││││││││└
│    │││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││││││┌ @ abstractarray.jl:98 within `axes`
│    │││││││││││││┌ @ range.jl:676 within `size`
│    ││││││││││││││┌ @ range.jl:786 within `length`
│    │││││││││││││││┌ @ Base.jl:49 within `getproperty`
│    ││││││││││││││││ %142 = Base.getfield(%141, :stop)::Int64
│    │││││││└└└└└└└└└
│    │││││││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %143 = Base.sub_int(%135, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:668 within `unsigned`
│    │││││││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││││││ %144 = Base.bitcast(UInt64, %143)::UInt64
│    ││││││││││ @ essentials.jl:730 within `reinterpret`
│    ││││││││││ %145 = Base.bitcast(UInt64, %142)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %146 = Base.ult_int(%144, %145)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:699 within `checkbounds`
└────│││││││        goto #41 if not %146
40 ──│││││││        goto #42
41 ──│││││││        invoke Base.throw_boundserror(%125::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %138::Tuple{Int64})::Union{}
└────│││││││        unreachable
42 ──│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:49 within `getproperty`
43 ┄─│││││││ %152 = Base.getfield(%125, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:382 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %153 = $(Expr(:boundscheck, true))::Bool
│    ││││││││ %154 = Base.getfield(%152, 1, %153)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
│    ││││││││┌ @ array.jl:3076 within `getindex`
│    │││││││││┌ @ range.jl:922 within `_getindex`
│    ││││││││││ %155 = $(Expr(:boundscheck, false))::Bool
└────││││││││││        goto #48 if not %155
     ││││││││││┌ @ abstractarray.jl:697 within `checkbounds`
44 ──│││││││││││ %157 = Core.tuple(%135)::Tuple{Int64}
│    │││││││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││││││││││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││││┌ @ abstractarray.jl:98 within `axes`
│    ││││││││││││││┌ @ range.jl:676 within `size`
│    │││││││││││││││┌ @ range.jl:786 within `length`
│    ││││││││││││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││││││││││││ %158 = Base.getfield(%154, :stop)::Int64
│    │││││││││││└└└└└└
│    │││││││││││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││││││││││┌ @ int.jl:86 within `-`
│    │││││││││││││ %159 = Base.sub_int(%135, 1)::Int64
│    ││││││││││││└
│    ││││││││││││┌ @ essentials.jl:668 within `unsigned`
│    │││││││││││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││││││││││ %160 = Base.bitcast(UInt64, %159)::UInt64
│    ││││││││││││││ @ essentials.jl:730 within `reinterpret`
│    ││││││││││││││ %161 = Base.bitcast(UInt64, %158)::UInt64
│    ││││││││││││└└
│    ││││││││││││┌ @ int.jl:513 within `<`
│    │││││││││││││ %162 = Base.ult_int(%160, %161)::Bool
│    │││││││││││└└
│    │││││││││││ @ abstractarray.jl:699 within `checkbounds`
└────│││││││││││        goto #46 if not %162
45 ──│││││││││││        goto #47
46 ──│││││││││││        invoke Base.throw_boundserror(%154::Base.OneTo{Int64}, %157::Tuple{Int64})::Union{}
└────│││││││││││        unreachable
47 ──│││││││││││        nothing::Nothing
48 ┄─│││││││││││        goto #49
49 ──│││││││││││        goto #50
50 ──│││││││││││        goto #51
51 ──│││││││││││        goto #52
52 ──│││││││││││        goto #53
53 ──│││││││││││        goto #54
54 ──│││││││││││        goto #55
     ││││└└└└└└└
     ││││┌ @ indices.jl:365 within `to_indices` @ indices.jl:368
     │││││┌ @ indices.jl:292 within `to_index` @ indices.jl:307
     ││││││┌ @ number.jl:7 within `convert`
     │││││││┌ @ boot.jl:892 within `Int64`
     ││││││││┌ @ boot.jl:816 within `toInt64`
55 ──│││││││││ %175 = Core.zext_int(Core.Int64, %120)::Int64
│    ││││└└└└└
│    ││││┌ @ abstractarray.jl:1358 within `_getindex`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:55 within `#getindex`
│    ││││││ %176 = $(Expr(:boundscheck, false))::Bool
└────││││││        goto #60 if not %176
     ││││││┌ @ abstractarray.jl:697 within `checkbounds`
56 ──│││││││ %178 = Core.tuple(%175)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││││││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││││││┌ @ int.jl:86 within `-`
│    │││││││││ %179 = Base.sub_int(%175, 1)::Int64
│    ││││││││└
│    ││││││││┌ @ essentials.jl:668 within `unsigned`
│    │││││││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││││││ %180 = Base.bitcast(UInt64, %179)::UInt64
│    ││││││││└└
│    ││││││││┌ @ int.jl:513 within `<`
│    │││││││││ %181 = Base.ult_int(%180, 0x0000000000000100)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:699 within `checkbounds`
└────│││││││        goto #58 if not %181
57 ──│││││││        goto #59
58 ──│││││││        invoke Base.throw_boundserror($(QuoteNode(CartesianIndices((256,))))::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %178::Tuple{Int64})::Union{}
└────│││││││        unreachable
59 ──│││││││        nothing::Nothing
     ││││││└
     ││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ tuple.jl:382 within `map`
     │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/quirks.jl:57 within `#54`
     ││││││││┌ @ array.jl:3076 within `getindex`
     │││││││││┌ @ range.jl:922 within `_getindex`
60 ┄─││││││││││ %187 = $(Expr(:boundscheck, false))::Bool
└────││││││││││        goto #65 if not %187
     ││││││││││┌ @ abstractarray.jl:697 within `checkbounds`
61 ──│││││││││││ %189 = Core.tuple(%175)::Tuple{Int64}
│    │││││││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││││││││││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││││││││││┌ @ int.jl:86 within `-`
│    │││││││││││││ %190 = Base.sub_int(%175, 1)::Int64
│    ││││││││││││└
│    ││││││││││││┌ @ essentials.jl:668 within `unsigned`
│    │││││││││││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││││││││││ %191 = Base.bitcast(UInt64, %190)::UInt64
│    ││││││││││││└└
│    ││││││││││││┌ @ int.jl:513 within `<`
│    │││││││││││││ %192 = Base.ult_int(%191, 0x0000000000000100)::Bool
│    │││││││││││└└
│    │││││││││││ @ abstractarray.jl:699 within `checkbounds`
└────│││││││││││        goto #63 if not %192
62 ──│││││││││││        goto #64
63 ──│││││││││││        invoke Base.throw_boundserror($(QuoteNode(Base.OneTo(256)))::Base.OneTo{Int64}, %189::Tuple{Int64})::Union{}
└────│││││││││││        unreachable
64 ──│││││││││││        nothing::Nothing
65 ┄─│││││││││││        goto #66
66 ──│││││││││││        goto #67
67 ──│││││││││││        goto #68
68 ──│││││││││││        goto #69
69 ──│││││││││││        goto #70
70 ──│││││││││││        goto #71
71 ──│││││││││││        goto #72
     │││└└└└└└└└
     │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand` @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:75
     │││┌ @ ntuple.jl:48 within `ntuple`
     ││││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:79 within `#1`
     │││││┌ @ int.jl:86 within `-`
72 ──││││││ %205 = Base.sub_int(%135, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %206 = Base.mul_int(%205, 256)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %207 = Base.add_int(%206, %175)::Int64
│    │││└└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/nditeration.jl:121 within `expand`
└────│││        goto #73
     ││└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:124 within `#__index_Global_Linear`
     ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/compiler.jl:28 within `__ndrange`
     │││┌ @ Base.jl:49 within `getproperty`
73 ──││││ %209 = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ multidimensional.jl:582 within `LinearIndices`
│    │││┌ @ Base.jl:49 within `getproperty`
│    ││││ %210 = Base.getfield(%209, :indices)::Tuple{Base.OneTo{Int64}}
│    │││└
│    │││ @ multidimensional.jl:582 within `LinearIndices` @ indices.jl:484
│    │││ %211 = %new(LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %210)::LinearIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└
│    ││┌ @ abstractarray.jl:1312 within `getindex`
│    │││┌ @ abstractarray.jl:1336 within `_getindex`
│    ││││┌ @ indices.jl:518 within `getindex`
│    │││││ %212 = $(Expr(:boundscheck, false))::Bool
└────│││││        goto #78 if not %212
     │││││┌ @ abstractarray.jl:697 within `checkbounds`
74 ──││││││ %214 = Core.tuple(%207)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││││┌ @ abstractarray.jl:389 within `eachindex`
│    │││││││┌ @ abstractarray.jl:137 within `axes1`
│    ││││││││┌ @ indices.jl:513 within `axes`
│    │││││││││┌ @ tuple.jl:355 within `map`
│    ││││││││││┌ @ tuple.jl:31 within `getindex`
│    │││││││││││ %215 = $(Expr(:boundscheck, true))::Bool
│    │││││││││││ %216 = Base.getfield(%210, 1, %215)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││││││││┌ @ abstractarray.jl:98 within `axes`
│    ││││││││││││┌ @ range.jl:676 within `size`
│    │││││││││││││┌ @ range.jl:786 within `length`
│    ││││││││││││││┌ @ Base.jl:49 within `getproperty`
│    │││││││││││││││ %217 = Base.getfield(%216, :stop)::Int64
│    ││││││└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:754 within `checkindex`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %218 = Base.sub_int(%207, 1)::Int64
│    │││││││└
│    │││││││┌ @ essentials.jl:668 within `unsigned`
│    ││││││││┌ @ essentials.jl:730 within `reinterpret`
│    │││││││││ %219 = Base.bitcast(UInt64, %218)::UInt64
│    │││││││││ @ essentials.jl:730 within `reinterpret`
│    │││││││││ %220 = Base.bitcast(UInt64, %217)::UInt64
│    │││││││└└
│    │││││││┌ @ int.jl:513 within `<`
│    ││││││││ %221 = Base.ult_int(%219, %220)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:699 within `checkbounds`
└────││││││        goto #76 if not %221
75 ──││││││        goto #77
76 ──││││││        invoke Base.throw_boundserror(%211::LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %214::Tuple{Int64})::Union{}
└────││││││        unreachable
77 ──││││││        nothing::Nothing
78 ┄─││││││        goto #79
79 ──││││││        goto #80
80 ──││││││        goto #81
81 ──││││││        goto #82
     │└└└└└
     │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:16 within `macro expansion`
     │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:71 within `length`
     ││┌ @ Base.jl:49 within `getproperty`
82 ──│││ %231 = Base.getfield(x, :len)::Int64
│    │└└
│    │┌ @ operators.jl:379 within `>`
│    ││┌ @ int.jl:83 within `<`
│    │││ %232 = Base.slt_int(%231, %207)::Bool
│    │└└
└────│        goto #84 if not %232
83 ──│        goto #91
     │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
84 ──││ %235 = $(Expr(:boundscheck, true))::Bool
└────││        goto #89 if not %235
     ││┌ @ abstractarray.jl:697 within `checkbounds`
85 ──│││ %237 = Core.tuple(%207)::Tuple{Int64}
│    │││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││┌ @ abstractarray.jl:98 within `axes`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `size`
│    │││││││┌ @ Base.jl:49 within `getproperty`
│    ││││││││ %238 = Base.getfield(x, :dims)::Tuple{Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:355 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %239 = $(Expr(:boundscheck, true))::Bool
│    ││││││││ %240 = Base.getfield(%238, 1, %239)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %241 = Base.sub_int(%207, 1)::Int64
│    ││││└
│    ││││┌ @ essentials.jl:668 within `unsigned`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %242 = Base.bitcast(UInt64, %241)::UInt64
│    ││││││ @ essentials.jl:730 within `reinterpret`
│    ││││││ %243 = Base.bitcast(UInt64, %240)::UInt64
│    ││││└└
│    ││││┌ @ int.jl:513 within `<`
│    │││││ %244 = Base.ult_int(%242, %243)::Bool
│    │││└└
│    │││ @ abstractarray.jl:699 within `checkbounds`
└────│││        goto #87 if not %244
86 ──│││        goto #88
87 ──│││        invoke Base.throw_boundserror(x::AMDGPU.Device.ROCDeviceVector{Float32, 1}, %237::Tuple{Int64})::Union{}
└────│││        unreachable
88 ──│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `pointer`
     │││┌ @ Base.jl:49 within `getproperty`
89 ┄─││││ %250 = Base.getfield(x, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
│    │││┌ @ none within `pointerref`
│    ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││ %251 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(1)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %3 = getelementptr inbounds float, float addrspace(1)* %2, i64 %1\n  %4 = load float, float addrspace(1)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %252 = Base.sub_int(%207, 1)::Int64
│    │││││└
│    │││││ %253 = Base.llvmcall(%251, Float32, Tuple{Core.LLVMPtr{Float32, 1}, Int64}, %250, %252)::Float32
└────│││││        goto #90
90 ──│││││        nothing::Nothing
     │└└└└
91 ┄─│ %256 = φ (#83 => neutral, #90 => %253)::Float32
│    │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:17 within `macro expansion`
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
│    ││ %257 = %new(Main.A, %256, %256)::A
│    │└
│    │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:18 within `macro expansion`
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
│    ││ %258 = %new(Main.A, neutral, neutral)::A
│    │└
│    │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:19 within `macro expansion`
│    │┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:85 within `__warp_groupreduce`
│    ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl:236 within `macro expansion`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:151 within `#SharedMemory`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `alloc_special` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/memory_static.jl:2 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││ %259 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n@\"alloc_special_##static_shmem#231\" = external addrspace(3) global [32 x [2 x float]], align 32\n\n; Function Attrs: alwaysinline\ndefine i8 addrspace(3)* @entry() #0 {\nentry:\n  ret i8 addrspace(3)* bitcast ([32 x [2 x float]] addrspace(3)* @\"alloc_special_##static_shmem#231\" to i8 addrspace(3)*)\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│    ││││││ %260 = Base.llvmcall(%259, Core.LLVMPtr{A, 3}, Tuple{})::Core.LLVMPtr{A, 3}
│    ││││└└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:152 within `#SharedMemory`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:50 within `ROCDeviceArray` @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:59 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:36
│    │││││ %261 = %new(AMDGPU.Device.ROCDeviceVector{A, 3}, (32,), %260, 32)::AMDGPU.Device.ROCDeviceVector{A, 3}
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:87 within `__warp_groupreduce`
│    ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:114 within `#__index_Local_Linear`
│    │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:164 within `threadIdx`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││││ %262 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││││ %263 = Base.llvmcall(%262, UInt32, Tuple{})::UInt32
│    ││││││└└
│    ││││││┌ @ int.jl:1013 within `+` @ int.jl:87
│    │││││││ %264 = Base.add_int(%263, 0x00000001)::UInt32
│    ││││└└└
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││││ %265 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││││        Base.llvmcall(%265, UInt32, Tuple{})::UInt32
│    ││││└└└└
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `_index`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    ││││││││ %267 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││││        Base.llvmcall(%267, UInt32, Tuple{})::UInt32
│    ││└└└└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:88 within `__warp_groupreduce`
│    ││┌ @ int.jl:1013 within `-` @ int.jl:86
│    │││ %269 = Base.sub_int(%264, 0x00000001)::UInt32
│    ││└
│    ││ %270 = KernelAbstractions.__warpsize::UInt32
│    ││┌ @ int.jl:298 within `rem`
│    │││ %271 = Base.checked_urem_int(%269, %270)::UInt32
│    ││└
│    ││┌ @ int.jl:1013 within `+` @ int.jl:87
│    │││ %272 = Base.add_int(%271, 0x00000001)::UInt32
│    ││└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:89 within `__warp_groupreduce`
│    ││┌ @ int.jl:1013 within `-` @ int.jl:86
│    │││ %273 = Base.sub_int(%264, 0x00000001)::UInt32
│    ││└
│    ││ %274 = KernelAbstractions.__warpsize::UInt32
│    ││┌ @ int.jl:297 within `div`
│    │││ %275 = Base.checked_udiv_int(%273, %274)::UInt32
│    ││└
│    ││┌ @ int.jl:1013 within `+` @ int.jl:87
└────│││ %276 = Base.add_int(%275, 0x00000001)::UInt32
     ││└
     ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:92 within `__warp_groupreduce`
     ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:77 within `__warp_reduce`
92 ┄─│││ %277 = φ (#91 => 0x00000010, #128 => %369)::UInt32
│    │││ %278 = φ (#91 => %256, #128 => %366)::Float32
│    │││ %279 = φ (#91 => %256, #128 => %367)::Float32
│    │││ %280 = φ (#91 => %256, #128 => %366)::Float32
│    │││ %281 = φ (#91 => %256, #128 => %367)::Float32
│    │││ %282 = φ (#91 => %257, #128 => %368)::A
│    │││┌ @ operators.jl:379 within `>`
│    ││││┌ @ promotion.jl:484 within `<` @ int.jl:513
│    │││││ %283 = Base.ult_int(0x00000000, %277)::Bool
│    │││└└
└────│││        goto #129 if not %283
     │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
     │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
     ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
93 ──│││││ %285 = $(Expr(:foreigncall, "llvm.amdgcn.wavefrontsize", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %286 = Base.bitcast(Int32, %278)::Int32
│    │││││└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
│    ││││││││ %287 = $(Expr(:foreigncall, "extern __ockl_activelane_u32", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    │││││││└
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:891 within `Int32`
│    │││││││││┌ @ boot.jl:805 within `toInt32`
│    ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
│    │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
│    ││││││││││││ %288 = Core.lshr_int(%287, 31)::UInt32
│    ││││││││││││ %289 = Core.trunc_int(Core.UInt8, %288)::UInt8
│    ││││││││││││ %290 = Core.eq_int(%289, 0x01)::Bool
│    │││││││││││└
└────│││││││││││        goto #95 if not %290
94 ──│││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %287::UInt32)::Union{}
└────│││││││││││        unreachable
95 ──│││││││││││        goto #96
     ││││││││││└
96 ──││││││││││ %295 = Core.bitcast(Core.Int32, %287)::Int32
└────││││││││││        goto #97
97 ──││││││││││        goto #98
98 ──││││││││││        goto #99
     │││││││└└└
     │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
     │││││││┌ @ boot.jl:891 within `Int32`
     ││││││││┌ @ boot.jl:805 within `toInt32`
     │││││││││┌ @ boot.jl:756 within `check_sign_bit`
     ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
99 ──│││││││││││ %299 = Core.lshr_int(%277, 31)::UInt32
│    │││││││││││ %300 = Core.trunc_int(Core.UInt8, %299)::UInt8
│    │││││││││││ %301 = Core.eq_int(%300, 0x01)::Bool
│    ││││││││││└
└────││││││││││        goto #101 if not %301
100 ─││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %277::UInt32)::Union{}
└────││││││││││        unreachable
101 ─││││││││││        goto #102
     │││││││││└
102 ─│││││││││ %306 = Core.bitcast(Core.Int32, %277)::Int32
└────│││││││││        goto #103
103 ─│││││││││        goto #104
     │││││││└└
     │││││││┌ @ int.jl:87 within `+`
104 ─││││││││ %309 = Base.add_int(%295, %306)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
│    │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
│    ││││││││ %310 = Base.sub_int(%285, 0x00000001)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:1011 within `&`
│    ││││││││┌ @ int.jl:554 within `rem`
│    │││││││││ %311 = Base.bitcast(UInt32, %295)::UInt32
│    ││││││││└
│    ││││││││ @ int.jl:1013 within `&` @ int.jl:347
│    ││││││││ %312 = Base.and_int(%311, %310)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %313 = Base.add_int(%312, %277)::UInt32
│    │││││││└
│    │││││││┌ @ operators.jl:426 within `>=`
│    ││││││││┌ @ int.jl:515 within `<=`
│    │││││││││ %314 = Base.ule_int(%285, %313)::Bool
│    │││││││└└
│    │││││││┌ @ essentials.jl:796 within `ifelse`
│    ││││││││ %315 = Core.ifelse(%314, %295, %309)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
│    │││││││┌ @ int.jl:529 within `<<`
│    ││││││││ %316 = Base.shl_int(%315, 0x02)::Int32
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
│    ││││││││ %317 = $(Expr(:foreigncall, "llvm.amdgcn.ds.bpermute", Int32, svec(Int32, Int32), 0, :(:llvmcall), :(%316), :(%286), :(%286), :(%316)))::Int32
└────││││││││        goto #105
105 ─││││││││        goto #106
     │││││└└└
     │││││┌ @ essentials.jl:730 within `reinterpret`
106 ─││││││ %320 = Base.bitcast(Float32, %317)::Float32
└────││││││        goto #107
107 ─││││││        goto #108
108 ─││││││        goto #109
109 ─││││││        goto #110
     ││││└└
     ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
     ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
110 ─│││││ %325 = $(Expr(:foreigncall, "llvm.amdgcn.wavefrontsize", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %326 = Base.bitcast(Int32, %279)::Int32
│    │││││└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
│    ││││││││ %327 = $(Expr(:foreigncall, "extern __ockl_activelane_u32", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    │││││││└
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:891 within `Int32`
│    │││││││││┌ @ boot.jl:805 within `toInt32`
│    ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
│    │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
│    ││││││││││││ %328 = Core.lshr_int(%327, 31)::UInt32
│    ││││││││││││ %329 = Core.trunc_int(Core.UInt8, %328)::UInt8
│    ││││││││││││ %330 = Core.eq_int(%329, 0x01)::Bool
│    │││││││││││└
└────│││││││││││        goto #112 if not %330
111 ─│││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %327::UInt32)::Union{}
└────│││││││││││        unreachable
112 ─│││││││││││        goto #113
     ││││││││││└
113 ─││││││││││ %335 = Core.bitcast(Core.Int32, %327)::Int32
└────││││││││││        goto #114
114 ─││││││││││        goto #115
115 ─││││││││││        goto #116
     │││││││└└└
     │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
     │││││││┌ @ boot.jl:891 within `Int32`
     ││││││││┌ @ boot.jl:805 within `toInt32`
     │││││││││┌ @ boot.jl:756 within `check_sign_bit`
     ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
116 ─│││││││││││ %339 = Core.lshr_int(%277, 31)::UInt32
│    │││││││││││ %340 = Core.trunc_int(Core.UInt8, %339)::UInt8
│    │││││││││││ %341 = Core.eq_int(%340, 0x01)::Bool
│    ││││││││││└
└────││││││││││        goto #118 if not %341
117 ─││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %277::UInt32)::Union{}
└────││││││││││        unreachable
118 ─││││││││││        goto #119
     │││││││││└
119 ─│││││││││ %346 = Core.bitcast(Core.Int32, %277)::Int32
└────│││││││││        goto #120
120 ─│││││││││        goto #121
     │││││││└└
     │││││││┌ @ int.jl:87 within `+`
121 ─││││││││ %349 = Base.add_int(%335, %346)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
│    │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
│    ││││││││ %350 = Base.sub_int(%325, 0x00000001)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:1011 within `&`
│    ││││││││┌ @ int.jl:554 within `rem`
│    │││││││││ %351 = Base.bitcast(UInt32, %335)::UInt32
│    ││││││││└
│    ││││││││ @ int.jl:1013 within `&` @ int.jl:347
│    ││││││││ %352 = Base.and_int(%351, %350)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %353 = Base.add_int(%352, %277)::UInt32
│    │││││││└
│    │││││││┌ @ operators.jl:426 within `>=`
│    ││││││││┌ @ int.jl:515 within `<=`
│    │││││││││ %354 = Base.ule_int(%325, %353)::Bool
│    │││││││└└
│    │││││││┌ @ essentials.jl:796 within `ifelse`
│    ││││││││ %355 = Core.ifelse(%354, %335, %349)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
│    │││││││┌ @ int.jl:529 within `<<`
│    ││││││││ %356 = Base.shl_int(%355, 0x02)::Int32
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
│    ││││││││ %357 = $(Expr(:foreigncall, "llvm.amdgcn.ds.bpermute", Int32, svec(Int32, Int32), 0, :(:llvmcall), :(%356), :(%326), :(%326), :(%356)))::Int32
└────││││││││        goto #122
122 ─││││││││        goto #123
     │││││└└└
     │││││┌ @ essentials.jl:730 within `reinterpret`
123 ─││││││ %360 = Base.bitcast(Float32, %357)::Float32
└────││││││        goto #124
124 ─││││││        goto #125
125 ─││││││        goto #126
126 ─││││││        goto #127
127 ─││││││        goto #128
     │││└└└
     │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
128 ─││││ %366 = Base.add_float(%280, %320)::Float32
│    ││││ %367 = Base.add_float(%281, %360)::Float32
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
│    │││││ %368 = %new(Main.A, %366, %367)::A
│    │││└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:79 within `__warp_reduce`
│    │││┌ @ int.jl:528 within `>>`
│    ││││ %369 = Base.lshr_int(%277, 0x01)::UInt32
│    │││└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:80 within `__warp_reduce`
└────│││        goto #92
     │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:81 within `__warp_reduce`
129 ─│││        goto #130
     ││└
     ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:93 within `__warp_groupreduce`
     ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
130 ─│││ %372 = (%272 === 0x00000001)::Bool
│    ││└
└────││        goto #138 if not %372
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
131 ─│││ %374 = $(Expr(:boundscheck, false))::Bool
└────│││        goto #136 if not %374
     │││┌ @ abstractarray.jl:697 within `checkbounds`
132 ─││││ %376 = Core.tuple(%276)::Tuple{UInt32}
│    ││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││┌ @ abstractarray.jl:752 within `checkindex`
│    │││││┌ @ int.jl:521 within `<=` @ promotion.jl:485
│    ││││││┌ @ promotion.jl:400 within `promote`
│    │││││││┌ @ promotion.jl:375 within `_promote`
│    ││││││││┌ @ number.jl:7 within `convert`
│    │││││││││┌ @ boot.jl:897 within `UInt64`
│    ││││││││││┌ @ boot.jl:871 within `toUInt64`
│    │││││││││││ %377 = Core.zext_int(Core.UInt64, %276)::UInt64
│    ││││││└└└└└
│    ││││││ @ int.jl:521 within `<=` @ promotion.jl:485 @ int.jl:515
│    ││││││ %378 = Base.ule_int(0x0000000000000001, %377)::Bool
│    ││││││ @ int.jl:521 within `<=`
│    ││││││┌ @ bool.jl:39 within `|`
│    │││││││ %379 = Base.or_int(false, %378)::Bool
│    ││││││└
│    ││││││ @ int.jl:522 within `<=` @ promotion.jl:485
│    ││││││┌ @ promotion.jl:400 within `promote`
│    │││││││┌ @ promotion.jl:375 within `_promote`
│    ││││││││┌ @ number.jl:7 within `convert`
│    │││││││││┌ @ boot.jl:897 within `UInt64`
│    ││││││││││┌ @ boot.jl:871 within `toUInt64`
│    │││││││││││ %380 = Core.zext_int(Core.UInt64, %276)::UInt64
│    ││││││└└└└└
│    ││││││ @ int.jl:522 within `<=` @ promotion.jl:485 @ int.jl:515
│    ││││││ %381 = Base.ule_int(%380, 0x0000000000000020)::Bool
│    ││││││ @ int.jl:522 within `<=`
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %382 = Base.and_int(true, %381)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %383 = Base.and_int(%379, %382)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:699 within `checkbounds`
└────││││        goto #134 if not %383
133 ─││││        goto #135
134 ─││││        invoke Base.throw_boundserror(%261::AMDGPU.Device.ROCDeviceVector{A, 3}, %376::Tuple{UInt32})::Union{}
└────││││        unreachable
135 ─││││        nothing::Nothing
     │││└
     │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
     │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
     ││││┌ @ none within `pointerset`
     │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
136 ┄││││││ %389 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(3)* %0, [2 x float] %1, i32 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(3)* %0 to [2 x float] addrspace(3)*\n  %4 = getelementptr inbounds [2 x float], [2 x float] addrspace(3)* %3, i32 %2\n  store [2 x float] %1, [2 x float] addrspace(3)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(3)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    ││││││┌ @ int.jl:86 within `-`
│    │││││││ %390 = Base.sub_int(%276, 0x00000001)::UInt32
│    ││││││└
│    ││││││        Base.llvmcall(%389, Nothing, Tuple{Core.LLVMPtr{A, 3}, A, UInt32}, %260, %282, %390)::Nothing
│    │││└└└
│    │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
└────│││        goto #137
137 ─│││        goto #139
138 ─│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:94 within `__warp_groupreduce`
     ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/KernelAbstractions.jl:290 within `macro expansion`
     │││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:162 within `#__synchronize`
     ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/synchronization.jl:6 within `sync_workgroup`
139 ┄│││││        $(Expr(:foreigncall, "llvm.amdgcn.s.barrier", Nothing, svec(), 0, :(:llvmcall)))::Nothing
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:97 within `__warp_groupreduce`
│    ││┌ @ int.jl:1013 within `-` @ int.jl:86
│    │││ %396 = Base.sub_int(%264, 0x00000001)::UInt32
│    ││└
│    ││┌ @ int.jl:520 within `<` @ promotion.jl:484
│    │││┌ @ promotion.jl:400 within `promote`
│    ││││┌ @ promotion.jl:375 within `_promote`
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:897 within `UInt64`
│    │││││││┌ @ boot.jl:871 within `toUInt64`
│    ││││││││ %397 = Core.zext_int(Core.UInt64, %396)::UInt64
│    │││└└└└└
│    │││ @ int.jl:520 within `<` @ promotion.jl:484 @ int.jl:513
│    │││ %398 = Base.ult_int(%397, 0x0000000000000008)::Bool
│    │││ @ int.jl:520 within `<`
│    │││┌ @ bool.jl:38 within `&`
│    ││││ %399 = Base.and_int(true, %398)::Bool
│    ││└└
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:98 within `__warp_groupreduce`
└────││        goto #147 if not %399
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:84 within `#getindex`
140 ─│││ %401 = $(Expr(:boundscheck, false))::Bool
└────│││        goto #145 if not %401
     │││┌ @ abstractarray.jl:697 within `checkbounds`
141 ─││││ %403 = Core.tuple(%272)::Tuple{UInt32}
│    ││││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    ││││┌ @ abstractarray.jl:752 within `checkindex`
│    │││││┌ @ int.jl:521 within `<=` @ promotion.jl:485
│    ││││││┌ @ promotion.jl:400 within `promote`
│    │││││││┌ @ promotion.jl:375 within `_promote`
│    ││││││││┌ @ number.jl:7 within `convert`
│    │││││││││┌ @ boot.jl:897 within `UInt64`
│    ││││││││││┌ @ boot.jl:871 within `toUInt64`
│    │││││││││││ %404 = Core.zext_int(Core.UInt64, %272)::UInt64
│    ││││││└└└└└
│    ││││││ @ int.jl:521 within `<=` @ promotion.jl:485 @ int.jl:515
│    ││││││ %405 = Base.ule_int(0x0000000000000001, %404)::Bool
│    ││││││ @ int.jl:521 within `<=`
│    ││││││┌ @ bool.jl:39 within `|`
│    │││││││ %406 = Base.or_int(false, %405)::Bool
│    ││││││└
│    ││││││ @ int.jl:522 within `<=` @ promotion.jl:485
│    ││││││┌ @ promotion.jl:400 within `promote`
│    │││││││┌ @ promotion.jl:375 within `_promote`
│    ││││││││┌ @ number.jl:7 within `convert`
│    │││││││││┌ @ boot.jl:897 within `UInt64`
│    ││││││││││┌ @ boot.jl:871 within `toUInt64`
│    │││││││││││ %407 = Core.zext_int(Core.UInt64, %272)::UInt64
│    ││││││└└└└└
│    ││││││ @ int.jl:522 within `<=` @ promotion.jl:485 @ int.jl:515
│    ││││││ %408 = Base.ule_int(%407, 0x0000000000000020)::Bool
│    ││││││ @ int.jl:522 within `<=`
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %409 = Base.and_int(true, %408)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %410 = Base.and_int(%406, %409)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:699 within `checkbounds`
└────││││        goto #143 if not %410
142 ─││││        goto #144
143 ─││││        invoke Base.throw_boundserror(%261::AMDGPU.Device.ROCDeviceVector{A, 3}, %403::Tuple{UInt32})::Union{}
└────││││        unreachable
144 ─││││        nothing::Nothing
     │││└
     │││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:86 within `#getindex`
     │││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:85 within `unsafe_load`
     ││││┌ @ none within `pointerref`
     │││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
145 ┄││││││ %416 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine [2 x float] @entry(i8 addrspace(3)* %0, i32 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(3)* %0 to [2 x float] addrspace(3)*\n  %3 = getelementptr inbounds [2 x float], [2 x float] addrspace(3)* %2, i32 %1\n  %4 = load [2 x float], [2 x float] addrspace(3)* %3, align 4, !tbaa !0\n  ret [2 x float] %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(3)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    ││││││┌ @ int.jl:86 within `-`
│    │││││││ %417 = Base.sub_int(%272, 0x00000001)::UInt32
│    ││││││└
│    ││││││ %418 = Base.llvmcall(%416, A, Tuple{Core.LLVMPtr{A, 3}, UInt32}, %260, %417)::A
└────││││││        goto #146
146 ─││││││        goto #148
147 ─││││││        nothing::Nothing
     ││└└└└
148 ┄││ %422 = φ (#146 => %418, #147 => %258)::A
│    ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:99 within `__warp_groupreduce`
│    ││┌ @ promotion.jl:483 within `==` @ promotion.jl:639
│    │││ %423 = (%276 === 0x00000001)::Bool
│    ││└
└────││        goto #189 if not %423
149 ─││        nothing::Nothing
     ││┌ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:77 within `__warp_reduce`
150 ┄│││ %426 = φ (#149 => 0x00000010, #186 => %518)::UInt32
│    │││ %427 = φ (#149 => %422, #186 => %517)::A
│    │││┌ @ operators.jl:379 within `>`
│    ││││┌ @ promotion.jl:484 within `<` @ int.jl:513
│    │││││ %428 = Base.ult_int(0x00000000, %426)::Bool
│    │││└└
└────│││        goto #187 if not %428
     │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:78 within `__warp_reduce`
     │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down`
     ││││┌ @ Base.jl:49 within `getproperty`
151 ─│││││ %430 = Base.getfield(%427, :x)::Float32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
│    │││││ %431 = $(Expr(:foreigncall, "llvm.amdgcn.wavefrontsize", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %432 = Base.bitcast(Int32, %430)::Int32
│    │││││└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
│    ││││││││ %433 = $(Expr(:foreigncall, "extern __ockl_activelane_u32", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    │││││││└
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:891 within `Int32`
│    │││││││││┌ @ boot.jl:805 within `toInt32`
│    ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
│    │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
│    ││││││││││││ %434 = Core.lshr_int(%433, 31)::UInt32
│    ││││││││││││ %435 = Core.trunc_int(Core.UInt8, %434)::UInt8
│    ││││││││││││ %436 = Core.eq_int(%435, 0x01)::Bool
│    │││││││││││└
└────│││││││││││        goto #153 if not %436
152 ─│││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %433::UInt32)::Union{}
└────│││││││││││        unreachable
153 ─│││││││││││        goto #154
     ││││││││││└
154 ─││││││││││ %441 = Core.bitcast(Core.Int32, %433)::Int32
└────││││││││││        goto #155
155 ─││││││││││        goto #156
156 ─││││││││││        goto #157
     │││││││└└└
     │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
     │││││││┌ @ boot.jl:891 within `Int32`
     ││││││││┌ @ boot.jl:805 within `toInt32`
     │││││││││┌ @ boot.jl:756 within `check_sign_bit`
     ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
157 ─│││││││││││ %445 = Core.lshr_int(%426, 31)::UInt32
│    │││││││││││ %446 = Core.trunc_int(Core.UInt8, %445)::UInt8
│    │││││││││││ %447 = Core.eq_int(%446, 0x01)::Bool
│    ││││││││││└
└────││││││││││        goto #159 if not %447
158 ─││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %426::UInt32)::Union{}
└────││││││││││        unreachable
159 ─││││││││││        goto #160
     │││││││││└
160 ─│││││││││ %452 = Core.bitcast(Core.Int32, %426)::Int32
└────│││││││││        goto #161
161 ─│││││││││        goto #162
     │││││││└└
     │││││││┌ @ int.jl:87 within `+`
162 ─││││││││ %455 = Base.add_int(%441, %452)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
│    │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
│    ││││││││ %456 = Base.sub_int(%431, 0x00000001)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:1011 within `&`
│    ││││││││┌ @ int.jl:554 within `rem`
│    │││││││││ %457 = Base.bitcast(UInt32, %441)::UInt32
│    ││││││││└
│    ││││││││ @ int.jl:1013 within `&` @ int.jl:347
│    ││││││││ %458 = Base.and_int(%457, %456)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %459 = Base.add_int(%458, %426)::UInt32
│    │││││││└
│    │││││││┌ @ operators.jl:426 within `>=`
│    ││││││││┌ @ int.jl:515 within `<=`
│    │││││││││ %460 = Base.ule_int(%431, %459)::Bool
│    │││││││└└
│    │││││││┌ @ essentials.jl:796 within `ifelse`
│    ││││││││ %461 = Core.ifelse(%460, %441, %455)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
│    │││││││┌ @ int.jl:529 within `<<`
│    ││││││││ %462 = Base.shl_int(%461, 0x02)::Int32
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
│    ││││││││ %463 = $(Expr(:foreigncall, "llvm.amdgcn.ds.bpermute", Int32, svec(Int32, Int32), 0, :(:llvmcall), :(%462), :(%432), :(%432), :(%462)))::Int32
└────││││││││        goto #163
163 ─││││││││        goto #164
     │││││└└└
     │││││┌ @ essentials.jl:730 within `reinterpret`
164 ─││││││ %466 = Base.bitcast(Float32, %463)::Float32
└────││││││        goto #165
165 ─││││││        goto #166
166 ─││││││        goto #167
167 ─││││││        goto #168
     ││││└└
     ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down`
     ││││┌ @ Base.jl:49 within `getproperty`
168 ─│││││ %471 = Base.getfield(%427, :y)::Float32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:82 within `wavefrontsize`
│    │││││ %472 = $(Expr(:foreigncall, "llvm.amdgcn.wavefrontsize", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:12 within `shfl_down` @ /home/pxlth/.julia/dev/AMDGPU/src/ROCKernels.jl:174 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360 @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:360
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:228 within `_shfl`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %473 = Base.bitcast(Int32, %471)::Int32
│    │││││└
│    │││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:361 within `#19`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:249 within `shfl_down`
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:106 within `activelane`
│    ││││││││ %474 = $(Expr(:foreigncall, "extern __ockl_activelane_u32", UInt32, svec(), 0, :(:llvmcall)))::UInt32
│    │││││││└
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:891 within `Int32`
│    │││││││││┌ @ boot.jl:805 within `toInt32`
│    ││││││││││┌ @ boot.jl:756 within `check_sign_bit`
│    │││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
│    ││││││││││││ %475 = Core.lshr_int(%474, 31)::UInt32
│    ││││││││││││ %476 = Core.trunc_int(Core.UInt8, %475)::UInt8
│    ││││││││││││ %477 = Core.eq_int(%476, 0x01)::Bool
│    │││││││││││└
└────│││││││││││        goto #170 if not %477
169 ─│││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %474::UInt32)::Union{}
└────│││││││││││        unreachable
170 ─│││││││││││        goto #171
     ││││││││││└
171 ─││││││││││ %482 = Core.bitcast(Core.Int32, %474)::Int32
└────││││││││││        goto #172
172 ─││││││││││        goto #173
173 ─││││││││││        goto #174
     │││││││└└└
     │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:250 within `shfl_down`
     │││││││┌ @ boot.jl:891 within `Int32`
     ││││││││┌ @ boot.jl:805 within `toInt32`
     │││││││││┌ @ boot.jl:756 within `check_sign_bit`
     ││││││││││┌ @ boot.jl:741 within `is_top_bit_set`
174 ─│││││││││││ %486 = Core.lshr_int(%426, 31)::UInt32
│    │││││││││││ %487 = Core.trunc_int(Core.UInt8, %486)::UInt8
│    │││││││││││ %488 = Core.eq_int(%487, 0x01)::Bool
│    ││││││││││└
└────││││││││││        goto #176 if not %488
175 ─││││││││││        invoke Core.throw_inexacterror(:convert::Symbol, Int32::Type{Int32}, %426::UInt32)::Union{}
└────││││││││││        unreachable
176 ─││││││││││        goto #177
     │││││││││└
177 ─│││││││││ %493 = Core.bitcast(Core.Int32, %426)::Int32
└────│││││││││        goto #178
178 ─│││││││││        goto #179
     │││││││└└
     │││││││┌ @ int.jl:87 within `+`
179 ─││││││││ %496 = Base.add_int(%482, %493)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:251 within `shfl_down`
│    │││││││┌ @ int.jl:1013 within `-` @ int.jl:86
│    ││││││││ %497 = Base.sub_int(%472, 0x00000001)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:1011 within `&`
│    ││││││││┌ @ int.jl:554 within `rem`
│    │││││││││ %498 = Base.bitcast(UInt32, %482)::UInt32
│    ││││││││└
│    ││││││││ @ int.jl:1013 within `&` @ int.jl:347
│    ││││││││ %499 = Base.and_int(%498, %497)::UInt32
│    │││││││└
│    │││││││┌ @ int.jl:87 within `+`
│    ││││││││ %500 = Base.add_int(%499, %426)::UInt32
│    │││││││└
│    │││││││┌ @ operators.jl:426 within `>=`
│    ││││││││┌ @ int.jl:515 within `<=`
│    │││││││││ %501 = Base.ule_int(%472, %500)::Bool
│    │││││││└└
│    │││││││┌ @ essentials.jl:796 within `ifelse`
│    ││││││││ %502 = Core.ifelse(%501, %482, %496)::Int32
│    │││││││└
│    │││││││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:252 within `shfl_down`
│    │││││││┌ @ int.jl:529 within `<<`
│    ││││││││ %503 = Base.shl_int(%502, 0x02)::Int32
│    │││││││└
│    │││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/wavefront.jl:178 within `bpermute`
│    ││││││││ %504 = $(Expr(:foreigncall, "llvm.amdgcn.ds.bpermute", Int32, svec(Int32, Int32), 0, :(:llvmcall), :(%503), :(%473), :(%473), :(%503)))::Int32
└────││││││││        goto #180
180 ─││││││││        goto #181
     │││││└└└
     │││││┌ @ essentials.jl:730 within `reinterpret`
181 ─││││││ %507 = Base.bitcast(Float32, %504)::Float32
└────││││││        goto #182
182 ─││││││        goto #183
183 ─││││││        goto #184
184 ─││││││        goto #185
185 ─││││││        goto #186
     │││└└└
     │││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
     ││││┌ @ Base.jl:49 within `getproperty`
186 ─│││││ %513 = Base.getfield(%427, :x)::Float32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
│    ││││ %514 = Base.add_float(%513, %466)::Float32
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
│    ││││┌ @ Base.jl:49 within `getproperty`
│    │││││ %515 = Base.getfield(%427, :y)::Float32
│    ││││└
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+` @ float.jl:491
│    ││││ %516 = Base.add_float(%515, %507)::Float32
│    ││││ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:10 within `+`
│    ││││┌ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:7 within `A`
│    │││││ %517 = %new(Main.A, %514, %516)::A
│    │││└└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:79 within `__warp_reduce`
│    │││┌ @ int.jl:528 within `>>`
│    ││││ %518 = Base.lshr_int(%426, 0x01)::UInt32
│    │││└
│    │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:80 within `__warp_reduce`
└────│││        goto #150
     │││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:81 within `__warp_reduce`
187 ─│││        goto #188
188 ─│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/KernelAbstractions/src/reduce.jl:100 within `__warp_groupreduce`
189 ┄││ %522 = φ (#188 => %427, #148 => %422)::A
└────││        goto #190
     │└
     │ @ /home/pxlth/.julia/dev/AMDGPU/t.jl:21 within `macro expansion`
     │┌ @ promotion.jl:639 within `==`
190 ─││ %524 = (%207 === 1)::Bool
│    │└
└────│        goto #198 if not %524
     │┌ @ Base.jl:49 within `getproperty`
191 ─││ %526 = Base.getfield(%522, :x)::Float32
│    ││ %527 = Base.getfield(%522, :y)::Float32
│    │└
│    │┌ @ float.jl:491 within `+`
│    ││ %528 = Base.add_float(%526, %527)::Float32
│    │└
│    │┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:90 within `#setindex!`
│    ││ %529 = $(Expr(:boundscheck, true))::Bool
└────││        goto #196 if not %529
     ││┌ @ abstractarray.jl:697 within `checkbounds`
192 ─│││ %531 = Core.tuple(1)::Tuple{Int64}
│    │││ @ abstractarray.jl:699 within `checkbounds` @ abstractarray.jl:689
│    │││┌ @ abstractarray.jl:389 within `eachindex`
│    ││││┌ @ abstractarray.jl:137 within `axes1`
│    │││││┌ @ abstractarray.jl:98 within `axes`
│    ││││││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:69 within `size`
│    │││││││┌ @ Base.jl:49 within `getproperty`
│    ││││││││ %532 = Base.getfield(y, :dims)::Tuple{Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:355 within `map`
│    │││││││┌ @ tuple.jl:31 within `getindex`
│    ││││││││ %533 = $(Expr(:boundscheck, true))::Bool
│    ││││││││ %534 = Base.getfield(%532, 1, %533)::Int64
│    │││└└└└└
│    │││┌ @ abstractarray.jl:754 within `checkindex`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %535 = Base.sub_int(1, 1)::Int64
│    ││││└
│    ││││┌ @ essentials.jl:668 within `unsigned`
│    │││││┌ @ essentials.jl:730 within `reinterpret`
│    ││││││ %536 = Base.bitcast(UInt64, %535)::UInt64
│    ││││││ @ essentials.jl:730 within `reinterpret`
│    ││││││ %537 = Base.bitcast(UInt64, %534)::UInt64
│    ││││└└
│    ││││┌ @ int.jl:513 within `<`
│    │││││ %538 = Base.ult_int(%536, %537)::Bool
│    │││└└
│    │││ @ abstractarray.jl:699 within `checkbounds`
└────│││        goto #194 if not %538
193 ─│││        goto #195
194 ─│││        invoke Base.throw_boundserror(y::AMDGPU.Device.ROCDeviceVector{Float32, 1}, %531::Tuple{Int64})::Union{}
└────│││        unreachable
195 ─│││        nothing::Nothing
     ││└
     ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:92 within `#setindex!`
     ││┌ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:64 within `pointer`
     │││┌ @ Base.jl:49 within `getproperty`
196 ┄││││ %544 = Base.getfield(y, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││└└
│    ││┌ @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││┌ @ none within `pointerset`
│    ││││┌ @ none within `macro expansion` @ /home/pxlth/.julia/packages/LLVM/b3kFs/src/interop/base.jl:39
│    │││││ %545 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %546 = Base.sub_int(1, 1)::Int64
│    │││││└
│    │││││        Base.llvmcall(%545, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %544, %528, %546)::Nothing
│    ││└└└
│    ││ @ /home/pxlth/.julia/dev/AMDGPU/src/device/gcn/array.jl:93 within `#setindex!`
└────││        goto #197
197 ─││        nothing::Nothing
     └└
      @ /home/pxlth/.julia/dev/KernelAbstractions/src/macros.jl:99 within `gpu_groupreduce_1!`
198 ┄        return Main.nothing
) => Nothing
