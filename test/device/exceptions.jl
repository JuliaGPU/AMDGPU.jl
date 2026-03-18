using Test
using AMDGPU
using AMDGPU: Device, ROCArray, @roc
using AMDGPU.Device: workitemIdx
using StaticArrays

@testset "Exceptions" begin
    function oob_kernel(X)
        X[0] = 1
        return
    end

    RA = ROCArray(zeros(Int, 1))
    @roc oob_kernel(RA)
    try
        AMDGPU.synchronize()
    catch err
        @test err isa ErrorException
        @test occursin("GPU Kernel Exception", err.msg)
    end
end

@testset "Exception codegen" begin
    # Kernel with multiple div() calls — each generates an error path
    function div_kernel(X, a, b, c, d)
        i = workitemIdx().x
        x = div(a, b)
        y = div(c, d)
        X[i] = x + y
        return
    end

    iob = IOBuffer()
    AMDGPU.code_native(iob, div_kernel, Tuple{
        Device.ROCDeviceArray{Int64, 1, 1},
        Int64, Int64, Int64, Int64,
    })
    asm = String(take!(iob))

    # The new lightweight exception path should NOT generate flat_store_byte
    # instructions for writing ExceptionInfo fields. Previously each div check
    # inlined ~20 flat_store_byte for the 56-byte ExceptionInfo struct.
    n_flat_store_byte = count("flat_store_byte", asm)
    @test n_flat_store_byte == 0

    # Should use global_atomic_cmpswap for the exception flag instead
    @test occursin("global_atomic_cmpswap", asm) || occursin("flat_atomic_cmpswap", asm)
end

if VERSION ≥ v"1.11-"
    # FIXME: https://github.com/JuliaGPU/AMDGPU.jl/issues/808
    # For now InexactError with just throw(nothing) and not log anything.
    @testset "Issue #808: InexactError failure" begin
        @inline function add!(a::MMatrix{NC,NC,Complex{T},NC2}) where {NC,NC2,T}
            ar = reinterpret(reshape, T, a)
            ar[1] += 1.0
            return a
        end

        function kernel!(a)
            i = workitemIdx().x
            a[i] = SMatrix(add!(MMatrix(a[i])))
            return
        end

        a = AMDGPU.zeros(SMatrix{3,3,ComplexF64,9}, 1)
        @roc groupsize=1 kernel!(a)
    end
end
