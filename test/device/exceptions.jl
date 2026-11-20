using Test
using AMDGPU
using AMDGPU: Device, ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim
using GPUCompiler
using StaticArrays

# the exception that a kernel reported, if any
function kernel_exception()
    try
        AMDGPU.synchronize()
        return nothing
    catch err
        return err
    end
end

# the exception that `f(args...)` reports when compiled at `debug_level`
function kernel_exception(f, args...; debug_level, kwargs...)
    dev = AMDGPU.device()
    config = GPUCompiler.CompilerConfig(AMDGPU.Compiler.compiler_config(dev); debug_level)
    args = map(AMDGPU.rocconvert, args)
    tt = Tuple{map(Core.Typeof, args)...}
    source = GPUCompiler.methodinstance(typeof(f), tt)
    fun = AMDGPU.Compiler.hipfunction_lookup(source, config, dev)
    AMDGPU.Runtime.HIPKernel{typeof(f), tt}(f, fun)(args...; kwargs...)
    return kernel_exception()
end

@testset "Exceptions" begin
    function oob_kernel(X)
        X[0] = 1
        return
    end

    RA = ROCArray(zeros(Int, 1))
    @roc oob_kernel(RA)
    err = kernel_exception()
    @test err isa AMDGPU.KernelException
    @test err.workgroup == (1, 1, 1)
    @test err.workitem == (1, 1, 1)

    # the exception record is reset
    @roc oob_kernel(ROCArray(zeros(Int, 0)))
    @test kernel_exception() isa AMDGPU.KernelException
    @test kernel_exception() === nothing

    # the work-item with global index `i` throws a BoundsError
    function throw_at_kernel(X, i)
        j = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
        j == i && (X[0] = 1)
        return
    end
    line = first(methods(throw_at_kernel)).line
    X = ROCArray(zeros(Int, 1))
    throw_at(i; debug_level) =
        kernel_exception(throw_at_kernel, X, i; debug_level, groupsize=4, gridsize=2)

    err = throw_at(7; debug_level=0)
    @test err isa AMDGPU.KernelException
    @test err.site === nothing
    @test (err.workgroup, err.workitem) == ((2, 1, 1), (3, 1, 1))
    @test startswith(sprint(showerror, err),
                     "KernelException: exception thrown during kernel execution on work-item (3, 1, 1)")

    err = throw_at(7; debug_level=1)
    @test err isa AMDGPU.KernelException
    @test err.site.name == "BoundsError"
    @test err.site.reason == "Out-of-bounds array access"
    @test isempty(err.site.frames)
    @test (err.workgroup, err.workitem) == ((2, 1, 1), (3, 1, 1))
    @test sprint(showerror, err) == """
        KernelException: BoundsError during kernel execution on work-item (3, 1, 1) of \
        work-group (2, 1, 1): Out-of-bounds array access
        Run Julia on debug level 2 for a device stack trace."""

    # with a backtrace that reaches the kernel
    err = throw_at(2; debug_level=2)
    @test err.site.name == "BoundsError"
    @test (err.workgroup, err.workitem) == ((1, 1, 1), (2, 1, 1))
    frame = last(err.site.frames)
    @test occursin("throw_at_kernel", frame.func)
    @test frame.line == line + 2
    @test occursin("Stacktrace:", sprint(showerror, err))
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
    }; kernel=true)
    asm = String(take!(iob))

    # The new lightweight exception path should NOT generate flat_store_byte
    # instructions for writing ExceptionInfo fields. Previously each div check
    # inlined ~20 flat_store_byte for the 56-byte ExceptionInfo struct.
    n_flat_store_byte = count("flat_store_byte", asm)
    @test n_flat_store_byte == 0

    # Should use global_atomic_cmpswap for the exception flag instead
    @test occursin("global_atomic_cmpswap", asm) || occursin("flat_atomic_cmpswap", asm)

    # Kernel with bounds-checked array access
    function boundscheck_kernel(X, Y)
        i = workitemIdx().x
        X[i] = Y[i] + Y[i+1]
        return
    end

    iob2 = IOBuffer()
    AMDGPU.code_native(iob2, boundscheck_kernel, Tuple{
        Device.ROCDeviceArray{Float64, 1, 1},
        Device.ROCDeviceArray{Float64, 1, 1},
    }; kernel=true)
    asm2 = String(take!(iob2))

    @test count("flat_store_byte", asm2) == 0
    @test occursin("global_atomic_cmpswap", asm2) || occursin("flat_atomic_cmpswap", asm2)
end

@testset "InexactError" begin
    function inexact_kernel(X, Y)
        X[1] = Int32(Y[1])
        return
    end

    X = ROCArray(zeros(Int32, 1))
    Y = ROCArray([typemax(Int64)])
    @roc inexact_kernel(X, Y)
    err = try
        AMDGPU.synchronize()
        nothing
    catch err
        err
    end
    @test err isa AMDGPU.KernelException
    @test err.site.name == "InexactError"
end

# Julia 1.10 formats the message of the errors that `Rational` throws, which doesn't compile;
# GPUToolbox's shared overrides throw these with a constant message instead
@testset "Rational" begin
    function rational_kernel(Y, A, B, C)
        i = workitemIdx().x
        Y[i] = -(A[i] * B[i] + C[i])
        return
    end

    a = [1//2, -3//4, 5//6]
    b = [2//3, 5//7, -1//9]
    c = [1//6, -1//3, 7//2]
    Y = ROCArray(zeros(Rational{Int}, 3))
    @roc groupsize=3 rational_kernel(Y, ROCArray(a), ROCArray(b), ROCArray(c))
    @test Array(Y) == -(a .* b .+ c)

    function rational_ctor_kernel(Y, n, d)
        Y[1] = Rational(n, d)
        return
    end

    Y = ROCArray(zeros(Rational{Int}, 1))
    @roc rational_ctor_kernel(Y, 1, -2)
    @test Array(Y) == [-1//2]

    # the device reports the type of the exception that the host throws (an ArgumentError
    # on Julia 1.10, an OverflowError on later versions)
    expected(f) = try
        f()
        nothing
    catch host_err
        string(nameof(typeof(host_err)))
    end

    @roc rational_ctor_kernel(Y, 1, typemin(Int))
    err = kernel_exception()
    @test err isa AMDGPU.KernelException
    @test err.site.name == expected(() -> Rational(1, typemin(Int)))

    function rational_neg_kernel(Y, X)
        Y[1] = -X[1]
        return
    end

    # Julia 1.12+ throws this one with a lazily formatted message, which compiles, but is
    # only reported as the exception GPUCompiler derives from the throw
    @roc rational_neg_kernel(Y, ROCArray([typemin(Int)//1]))
    err = kernel_exception()
    @test err isa AMDGPU.KernelException
    if VERSION < v"1.12-"
        @test err.site.name == expected(() -> -(typemin(Int)//1))
    end
end

# GPUToolbox's shared overrides report their exceptions like AMDGPU's own
@testset "Shared override exceptions" begin
    function shared_throw_kernel()
        Device.GPUToolbox.Overlays.device_throw(ArgumentError, Val(Symbol("shared reason")))
        return
    end

    @roc shared_throw_kernel()
    err = kernel_exception()
    @test err isa AMDGPU.KernelException
    @test err.site.name == "ArgumentError"
    @test err.site.reason == "shared reason"
end

if VERSION ≥ v"1.11-"
    # reporting InexactError must not block constant folding in `reinterpret`
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
