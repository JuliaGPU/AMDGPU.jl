using Test
using AMDGPU
using AMDGPU: Mem, rocconvert
using AMDGPU.Compiler: hipfunction
using LinearAlgebra
import Adapt
import KernelAbstractions as KA
import KernelInterface as KI

# Kernels that use fine-grained memory (e.g. wrapped host arrays), on which hardware atomics
# can silently have no effect, are compiled without the assumption that there is none.

struct ArrayHolder{A, B}
    a::A
    n::Int
    b::B
end
Adapt.@adapt_structure ArrayHolder
struct UntypedHolder
    a::ROCArray{Float32, 1}   # memory type unknown from the type
end

function atomic_add!(hist)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    j = (i - 1) % length(hist) + 1
    AMDGPU.@atomic hist[j] += one(eltype(hist))
    return
end
atomic_add_holder!(h) = atomic_add!(h.a)

KA.@kernel function ka_atomic_add!(hist)
    i = KA.@index(Global, Linear)
    j = (i - 1) % length(hist) + 1
    KA.@atomic hist[j] += one(eltype(hist))
end

@testset "fine-grained memory" begin
    fine = AMDGPU.uses_fine_grained_memory
    device = ROCArray{Float32, 1, Mem.HIPBuffer}(undef, 4)
    host_data = zeros(Float32, 4)
    host = unsafe_wrap(ROCArray, host_data)
    @test host isa ROCArray{Float32, 1, Mem.HostBuffer}

    @testset "detection" begin
        @test Mem.is_fine_grained(Mem.HostBuffer)
        @test Mem.is_fine_grained(Mem.UnifiedBuffer)
        @test !Mem.is_fine_grained(Mem.HIPBuffer)

        @test !fine(device)
        @test fine(host)
        for x in (1, 1f0, nothing, "a", :a, Int, (1, 2.0), identity, [1, 2], Ref(1))
            @test !fine(x)
        end

        # tuples, structs and wrappers
        @test !fine((device, 1, device))
        @test fine((device, 1, host))
        @test fine((a=device, b=(1, host)))
        @test !fine(ArrayHolder(device, 1, nothing))
        @test fine(ArrayHolder(device, 1, ArrayHolder(1, 2, host)))
        @test !fine(UntypedHolder(device))
        @test fine(UntypedHolder(host))
        @test fine(view(host, 1:2)) && !fine(view(device, 1:2))
        @test fine(view(host, [1, 3])) && !fine(view(device, [1, 3]))
        @test fine(host') && !fine(device')
        @test fine(Diagonal(host)) && !fine(Diagonal(device))
        @test fine(Ref(host)) && !fine(Ref(device))
        @test !fine(Ref{Any}())

        # arrays that closures capture
        @test fine(() -> host)
        @test !fine(() -> device)
        @test fine(Base.Fix1(+, host))

        # decided at compile time for arguments without arrays, and for typed ones
        @test (@allocated fine((1, 2f0, nothing))) == 0
        @test (@allocated fine((device, device))) == 0
        @test (@allocated fine((device, host))) == 0
    end

    @testset "@roc" begin
        tt = Tuple{typeof(rocconvert(device))}
        default = hipfunction(atomic_add!, tt)
        assuming = hipfunction(atomic_add!, tt; atomic_memory_assumptions=true)
        safe = hipfunction(atomic_add!, tt; atomic_memory_assumptions=false)
        @test default.fun !== safe.fun

        @test (@roc launch=false atomic_add!(device)).fun === default.fun
        @test (@roc launch=false atomic_add!(host)).fun === safe.fun
        # the option decides for either kind of memory
        @test (@roc launch=false atomic_memory_assumptions=false atomic_add!(device)).fun === safe.fun
        @test (@roc launch=false atomic_memory_assumptions=true atomic_add!(host)).fun === assuming.fun
        @test (@roc launch=false atomic_memory_assumptions=true atomic_add!(device)).fun === assuming.fun

        # the kernel to launch with a given kind of memory
        kernel_for_memory = AMDGPU.Compiler.kernel_for_memory
        @test kernel_for_memory(default, (device,)).fun === default.fun
        @test kernel_for_memory(default, (host,)).fun === safe.fun
        @test kernel_for_memory(default, (atomic_add!, (device, host))).fun === safe.fun
        @test kernel_for_memory(assuming, (host,)).fun === assuming.fun
        @test kernel_for_memory(safe, (host,)).fun === safe.fun
        @test kernel_for_memory(safe, (device,)).fun === safe.fun

        # arrays in structs, splatted arguments and captured arrays
        holder_tt = Tuple{typeof(rocconvert(ArrayHolder(device, 1, nothing)))}
        k = @roc launch=false atomic_add_holder!(ArrayHolder(host, 1, nothing))
        @test k.fun === hipfunction(atomic_add_holder!, holder_tt; atomic_memory_assumptions=false).fun
        k = @roc launch=false atomic_add_holder!(ArrayHolder(device, 1, nothing))
        @test k.fun === hipfunction(atomic_add_holder!, holder_tt).fun
        args = (host,)
        @test (@roc launch=false atomic_add!(args...)).fun === safe.fun

        # atomics give the right result on either kind of memory
        for T in (Int32, Float32, Float64)
            data = zeros(T, 32)
            for hist in (ROCArray{T, 1, Mem.HIPBuffer}(data), ROCArray{T, 1, Mem.UnifiedBuffer}(data),
                         unsafe_wrap(ROCArray, data))
                fill!(hist, 0)
                @roc groupsize=256 gridsize=4 atomic_add!(hist)
                @test all(==(T(32)), Array(hist))
                fill!(hist, 0)
                @roc groupsize=256 gridsize=4 atomic_add_holder!(ArrayHolder(hist, 1, nothing))
                @test all(==(T(32)), Array(hist))
            end
        end
    end

    @testset "KernelAbstractions" begin
        backend = ROCBackend()
        for T in (Int32, Float32, Float64)
            data = zeros(T, 32)
            for hist in (ROCArray{T, 1, Mem.HIPBuffer}(data), ROCArray{T, 1, Mem.UnifiedBuffer}(data),
                         unsafe_wrap(ROCArray, data))
                fill!(hist, 0)
                ka_atomic_add!(backend)(hist; ndrange=1024)
                KA.synchronize(backend)
                @test all(==(T(32)), Array(hist))
            end
        end

        # the option decides for either kind of memory
        tt = Tuple{typeof(rocconvert(device))}
        kernel = KI.kernel_function(backend, atomic_add!, tt; atomic_memory_assumptions=true)
        assuming = kernel.kern.kernel
        @test AMDGPU.Compiler.kernel_for_memory(assuming, (host,)).fun === assuming.fun
    end
end
