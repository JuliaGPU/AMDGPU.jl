@testitem "gpuarrays" begin

    using AMDGPU
    import GPUArrays
    include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

    const gpuarrays_tests = collect(keys(TestSuite.tests))

    run_gpuarrays_test(test_name::String) =
        TestSuite.tests[test_name](ROCArray)

    for test_name in gpuarrays_tests
        if test_name == "indexing multidimensional" && !Sys.islinux()
            # Skipping indexing multidimensional test on non-Linux
        else
            run_gpuarrays_test(test_name)
            if test_name == "indexing multidimensional"
                AMDGPU.synchronize(; stop_hostcalls=true)
            end
        end
    end
end
