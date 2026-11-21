using Test
using AMDGPU
using AMDGPU: HIP, Mem, rocconvert
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

# measured in a function, after compiling it: `@allocated` at top level counts both on
# Julia 1.10
function detection_allocations(x)
    AMDGPU.uses_fine_grained_memory(x)
    return @allocated AMDGPU.uses_fine_grained_memory(x)
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
        @test detection_allocations((1, 2f0, nothing)) == 0
        @test detection_allocations((device, device)) == 0
        @test detection_allocations((device, host)) == 0
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

    @testset "coarse-grained unified memory" begin
        U = Mem.UnifiedBuffer
        tt = Tuple{typeof(rocconvert(device))}
        default = hipfunction(atomic_add!, tt)
        safe = hipfunction(atomic_add!, tt; atomic_memory_assumptions=false)

        x = ROCArray{Float32, 1, U}(undef, 32)
        @test fine(x) && !AMDGPU.is_coarse_grained(x)
        @test (@roc launch=false atomic_add!(x)).fun === safe.fun

        @test AMDGPU.coarse_grained!(x) === x
        @test !fine(x) && AMDGPU.is_coarse_grained(x)
        @test !fine((1, view(x, 2:3))) && !fine(reshape(x, 4, 8))
        @test (@roc launch=false atomic_add!(x)).fun === default.fun
        # still accessible from the host, and atomics work
        for T in (Int32, Float32, Float64)
            hist = AMDGPU.coarse_grained!(ROCArray{T, 1, U}(zeros(T, 32)))
            @roc groupsize=256 gridsize=4 atomic_add!(hist)
            @test hist[1] == 32
            @test all(==(T(32)), Array(hist))
            hist[2] = 0
            ka_atomic_add!(ROCBackend())(hist; ndrange=1024)
            @test hist[2] == 32
        end

        # and back, which the views of the memory follow
        v = view(x, 2:3)
        AMDGPU.coarse_grained!(x, false)
        @test fine(x) && fine(v)
        AMDGPU.coarse_grained!(v)
        @test !fine(x)

        # `Mem.advise` keeps track of it, for all of the buffer
        buf = x.buf[].mem
        Mem.advise(buf, HIP.hipMemAdviseUnsetCoarseGrain)
        @test fine(x)
        Mem.advise(buf, HIP.hipMemAdviseSetCoarseGrain, sizeof(buf) ÷ 2)
        @test fine(x)
        Mem.advise(buf, HIP.hipMemAdviseSetCoarseGrain)
        @test !fine(x)
        Mem.advise(buf, HIP.hipMemAdviseSetReadMostly)
        @test !fine(x)

        # at allocation
        buf = Mem.UnifiedBuffer(1024; coarse_grained=true)
        @test !Mem.is_fine_grained(buf)
        @test !Mem.is_fine_grained(Mem.view(buf, 512))
        Mem.free(buf)
        @test Mem.is_fine_grained(Mem.UnifiedBuffer(0))
        @test !fine(AMDGPU.coarse_grained!(ROCArray{Float32, 1, U}(undef, 0)))

        # other memory is what it is
        @test AMDGPU.is_coarse_grained(device) && !AMDGPU.is_coarse_grained(host)
        @test_throws ArgumentError AMDGPU.coarse_grained!(device)
        @test_throws ArgumentError AMDGPU.coarse_grained!(host, false)
        # wrappers of the same memory find out how it is when wrapping it
        w = unsafe_wrap(ROCArray, pointer(x), size(x))
        @test !fine(w)
        @test (@roc launch=false atomic_add!(w)).fun === default.fun
        AMDGPU.coarse_grained!(x, false)
        @test fine(unsafe_wrap(ROCArray, pointer(x), size(x)))
        # and for the part that is wrapped
        page = 4096
        big = ROCArray{UInt8, 1, U}(undef, 4page)
        Mem.advise(big.buf[].mem, HIP.hipMemAdviseSetCoarseGrain, 2page)
        @test fine(big)
        @test !fine(unsafe_wrap(ROCArray, pointer(big), 2page))
        @test fine(unsafe_wrap(ROCArray, pointer(big), 3page))
        @test fine(unsafe_wrap(ROCArray, pointer(big, 2page + 1), 2page))
        @test !Mem.is_fine_grained(Ptr{Cvoid}(pointer(big)), page)
        @test Mem.is_fine_grained(C_NULL, 0)
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
