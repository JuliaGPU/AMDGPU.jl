@testset "Memory: Static" begin
    @testset "Fixed-size Allocation" begin
        function memory_static_kernel(A, B, C)
            idx = workitemIdx().x

            # Local
            dims = 8
            arr_local = @ROCStaticLocalArray(eltype(C), dims)
            C[idx] = arr_local[idx]
            arr_local[idx] = A[idx]
            B[idx] = arr_local[idx]

            # Private
            #= TODO
            ptr_private = alloc_special(Val(:private), Float32, Val(AS.Private), Val(1))
            unsafe_store!(ptr_private, a[3])
            b[3] = unsafe_load(ptr_private)
            =#

            nothing
        end

        RA = ROCArray(ones(Float32, 8))
        RB = ROCArray(zeros(Float32, 8))
        RC = ROCArray(ones(Float32, 8))

        @roc groupsize=8 memory_static_kernel(RA, RB, RC)
        @test Array(RA) ≈ Array(RB)
        # Test zero-initialization
        @test all(iszero, Array(RC))
    end

    # https://reviews.llvm.org/D82496
    if Base.libllvm_version.major >= 14
        @testset "Dynamic-size Local Allocation" begin
            function dynamic_localmem_kernel(A, C)
                B = @ROCDynamicLocalArray(eltype(C), length(A))
                for i in 1:length(A)
                    @inbounds C[i] = B[i]
                    @inbounds B[i] = A[i] + 1f0
                end
                for i in 1:length(A)
                    @inbounds A[i] = B[i]
                end
            end

            N = 2^10
            A = rand(Float32, N)
            RA = ROCArray(A)
            RC = ROCArray(ones(Float32, N))

            shmem = N * sizeof(Float32)
            @roc shmem=shmem dynamic_localmem_kernel(RA, RC)

            @test Array(RA) ≈ A .+ 1f0
            # Test zero-initialization
            @test all(iszero, Array(RC))
        end
    end
end

# TODO
# @testset "Memory: Dynamic" begin
#     function malloc_kernel(X)
#         ptr = AMDGPU.Device.malloc(Csize_t(4))
#         X[1] = reinterpret(UInt64, ptr)
#         AMDGPU.Device.free(ptr)
#         nothing
#     end

#     RA = ROCArray(zeros(UInt64, 1))
#     @roc malloc_kernel(RA)
#     @test Array(RA)[1] != 0
# end

@testset "Memcpy/Memset" begin
    function memcpy_kernel(X, Y)
        AMDGPU.Device.memcpy!(Y.ptr, X.ptr, sizeof(Float32) * length(X))
        nothing
    end

    A = rand(Float32, 4)
    B = zeros(Float32, 4)
    RA, RB = ROCArray.((A, B))
    @roc memcpy_kernel(RA, RB)
    @test A == collect(RA) == collect(RB)

    function memset_kernel(X, y)
        AMDGPU.Device.memset!(X.ptr, y, length(X) ÷ 2)
        nothing
    end

    A = zeros(UInt8, 4)
    RA = ROCArray(A)
    @roc memset_kernel(RA, 0x3)
    @test all(collect(RA)[1:2] .== 0x3)
    @test all(collect(RA)[3:4] .== 0x0)
end
