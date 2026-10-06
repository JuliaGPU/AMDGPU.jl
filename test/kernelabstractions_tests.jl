using Test
using AMDGPU

import KernelAbstractions
import KernelAbstractions as KA
import KernelInterface as KI
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

KA.@kernel function store_global_linear!(A)
    I = KA.@index(Global, Linear)
    @inbounds A[I] = I
end

KA.@kernel function store_last_index!(A)
    I = KA.@index(Global, Linear)
    if I == prod(KA.@ndrange())
        @inbounds A[1] = I
        @inbounds A[2] = KA.@index(Global, Cartesian)[2]
    end
end

@testset "kernelabstractions" begin

# TODO fix Printing
# sparse is tested by rocSPARSE; the others run kernels on KA's POCL-based CPU back-end
skip_tests = ["Printing", "sparse", "CPU synchronization", "fallback test: callable types"]
if Sys.iswindows()
    # TODO
    # We do not support hostcalls on Windows yet.
    push!(skip_tests, "Convert")
    # Also launches malloc hostcall for some reason...
    push!(skip_tests, "Private")
end

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
    skip_tests=Set(skip_tests))

@testset "Many arguments" begin
    # more arguments than Julia splats or maps over without falling back to dynamic calls
    params = [Symbol(:x, i) for i in 1:40]
    @eval KernelAbstractions.@kernel function many_args_kernel(out, $(params...))
        out[1] = $(foldl((a, b) -> :($a + $b), params))
    end
    @eval many_args_launch(kernel, out) = kernel(out, $(1:40...); ndrange=1)

    @eval KernelAbstractions.@kernel function few_args_kernel(out, x)
        out[1] = x
    end
    few_args_launch(kernel, out) = kernel(out, 1; ndrange=1)

    out = ROCArray([0])
    kernel = Base.invokelatest(many_args_kernel, ROCBackend())
    few_kernel = Base.invokelatest(few_args_kernel, ROCBackend())
    Base.invokelatest(many_args_launch, kernel, out)
    @test Array(out)[1] == sum(1:40)

    # launching should not be much more expensive than with few arguments
    # (Julia 1.11 and older allocate a little per argument)
    Base.invokelatest() do
        few_args_launch(few_kernel, out)
        @test @allocated(many_args_launch(kernel, out)) <=
              @allocated(few_args_launch(few_kernel, out)) + 40*32
    end
end

if Sys.islinux()
    # Disable global malloc hostcall started by conversion tests.
    AMDGPU.synchronize(; stop_hostcalls=true)
end

@testset "launch configuration" begin
    backend = ROCBackend()
    function select(kernel, ndrange, workgroupsize=nothing)
        ndrange, workgroupsize, iterspace, _ = KA.launch_config(kernel, ndrange, workgroupsize)
        KA.select_launch(kernel, workgroupsize, iterspace)
    end

    # kernels are launched on an N-d grid, computing indices in 32 bits
    kernel = store_global_linear!(backend)
    @test select(kernel, (64, 32, 16)) === KA.NDLaunch{Int32}()
    @test select(kernel, (4, 4, 4, 4)) === KA.LinearLaunch{Int32}()

    # which doesn't need divisions to compute the index of a dynamic N-d range
    A = AMDGPU.zeros(Int, 64, 32, 16)
    ir = sprint(io -> AMDGPU.@device_code_llvm io=io kernel(A; ndrange=size(A)))
    @test !occursin(r"\b[su](div|rem) ", ir)
    @test Array(A) == LinearIndices(A)

    # iteration spaces that don't fit 32 bits use 64-bit indices
    kernel = store_last_index!(backend)
    A = AMDGPU.zeros(Int, 2)
    for (dims, launch) in (((2^16 + 1, 2^15), KA.NDLaunch{Int}()),
                           ((2^11 + 1, 2^10, 2^10, 1), KA.LinearLaunch{Int}()))
        @test select(kernel, dims) === launch
        kernel(A; ndrange=dims)
        @test Array(A) == [prod(dims), dims[2]]
    end
end

@testset "compiler options" begin
    # a static workgroup size bounds the number of work-items per workgroup
    A = AMDGPU.zeros(Int, 1024)
    kernel = store_global_linear!(ROCBackend(), 256)
    ir = sprint(io -> AMDGPU.@device_code_llvm io=io dump_module=true kernel(A; ndrange=length(A)))
    @test occursin("\"amdgpu-flat-work-group-size\"=\"1,256\"", ir)
    @test Array(A) == 1:1024
end

end
