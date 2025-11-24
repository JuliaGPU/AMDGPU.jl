@testsetup module TSGPUArrays
    export gpuarrays_test

    using AMDGPU
    import GPUArrays
    include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

    gpuarrays_test(test_name::String) = TestSuite.tests[test_name](ROCArray)
end
# TODO define `@testitem` dynamically

@testitem "gpuarrays - base" setup=[TSGPUArrays] begin
    gpuarrays_test("base")
end
@testitem "gpuarrays - broadcasting" setup=[TSGPUArrays] begin
    gpuarrays_test("broadcasting")
end
@testitem "gpuarrays - constructors" setup=[TSGPUArrays] begin
    gpuarrays_test("constructors")
end
@testitem "gpuarrays - indexing find" setup=[TSGPUArrays] begin
    gpuarrays_test("indexing find")
end
@testitem "gpuarrays - indexing multidimensional" setup=[TSGPUArrays] begin
    if Sys.islinux() # TODO Windows does not support hostcalls.
        gpuarrays_test("indexing multidimensional")
        AMDGPU.synchronize(; stop_hostcalls=true)
    end
end
@testitem "gpuarrays - indexing scalar" setup=[TSGPUArrays] begin
    gpuarrays_test("indexing scalar")
end
@testitem "gpuarrays - linalg/core" setup=[TSGPUArrays] begin
    gpuarrays_test("linalg/core")
end
@testitem "gpuarrays - linalg/mul!/matrix-matrix" setup=[TSGPUArrays] begin
    gpuarrays_test("linalg/mul!/matrix-matrix")
end
@testitem "gpuarrays - linalg/mul!/vector-matrix" setup=[TSGPUArrays] begin
    gpuarrays_test("linalg/mul!/vector-matrix")
end
@testitem "gpuarrays - linalg/norm" setup=[TSGPUArrays] begin
    gpuarrays_test("linalg/norm")
end
@testitem "gpuarrays - math/intrinsics" setup=[TSGPUArrays] begin
    gpuarrays_test("math/intrinsics")
end
@testitem "gpuarrays - math/power" setup=[TSGPUArrays] begin
    gpuarrays_test("math/power")
end
@testitem "gpuarrays - random" setup=[TSGPUArrays] begin
    gpuarrays_test("random")
end
@testitem "gpuarrays - reductions/== isequal" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/== isequal")
end
@testitem "gpuarrays - reductions/any all count" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/any all count")
end
@testitem "gpuarrays - reductions/mapreduce" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/mapreduce")
end
@testitem "gpuarrays - reductions/mapreducedim!" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/mapreducedim!")
end
@testitem "gpuarrays - reductions/mapreducedim!_large" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/mapreducedim!_large")
end
@testitem "gpuarrays - reductions/minimum maximum extrema" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/minimum maximum extrema")
end
@testitem "gpuarrays - reductions/reduce" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/reduce")
end
@testitem "gpuarrays - reductions/reducedim!" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/reducedim!")
end
@testitem "gpuarrays - reductions/sum prod" setup=[TSGPUArrays] begin
    gpuarrays_test("reductions/sum prod")
end
@testitem "gpuarrays - statistics" setup=[TSGPUArrays] begin
    gpuarrays_test("statistics")
end
@testitem "gpuarrays - uniformscaling" setup=[TSGPUArrays] begin
    gpuarrays_test("uniformscaling")
end
@testitem "gpuarrays - alloc cache" setup=[TSGPUArrays] begin
    gpuarrays_test("alloc cache")
end
