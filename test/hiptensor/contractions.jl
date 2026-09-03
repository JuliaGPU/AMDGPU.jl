using Test, AMDGPU
using LinearAlgebra
using AMDGPU: hipTENSOR
using AMDGPU.hipTENSOR: contract!, plan_contraction, hipTensor

if AMDGPU.hipTENSOR.has_hiptensor()

@testset "contractions" verbose = true begin
    
eltypes = [(Float32, Float32, Float32, Float32),
           (Float32, Float32, Float32, Float16),
           (Float16, Float16, Float16, Float32),
           (ComplexF32, ComplexF32, ComplexF32, ComplexF32),
           (Float64, Float64, Float64, Float64),
           (Float64, Float64, Float64, Float32),
           (ComplexF64, ComplexF64, ComplexF64, ComplexF64),
           ]

@testset for NoA=1:2, NoB=1:2, Nc=1:2
    @testset for (eltyA, eltyB, eltyC, eltyCompute) in eltypes
        # setup
        #dmax = 2^div(12, max(NoA+Nc, NoB+Nc, NoA+NoB))
        dmax = 4
        dimsoA = rand(2:dmax, NoA)
        loA = prod(dimsoA)
        dimsoB = rand(2:dmax, NoB)
        loB = prod(dimsoB)
        dimsc = rand(2:dmax, Nc)
        lc = prod(dimsc)
        allinds = collect('a':'z')
        indsoA = allinds[1:NoA]
        indsoB = allinds[NoA .+ (1:NoB)]
        indsc = allinds[NoA .+ NoB .+ (1:Nc)]
        # hipTENSOR 2.4 only computes the layout `check_contraction_layout` enforces;
        # random mode orders are meaningful only on the versions that accept them.
        canonical_layout = hipTENSOR.version() >= v"2.4"
        pA = canonical_layout ? collect(1:(NoA + Nc))        : randperm(NoA + Nc)
        pB = canonical_layout ? [(Nc + 1):(Nc + NoB); 1:Nc]  : randperm(Nc + NoB)
        pC = canonical_layout ? collect(1:(NoA + NoB))       : randperm(NoA + NoB)
        ipA = invperm(pA)
        ipB = invperm(pB)
        ipC = invperm(pC)
        compute_rtol = (eltyCompute == Float16 || eltyC == Float16) ? 1e-2 : (eltyCompute == Float32 ? 1e-4 : 1e-6)
        dimsA = [dimsoA; dimsc][pA]
        indsA = [indsoA; indsc][pA]
        dimsB = [dimsc; dimsoB][pB]
        indsB = [indsc; indsoB][pB]
        dimsC = [dimsoA; dimsoB][pC]
        indsC = [indsoA; indsoB][pC]

        A = rand(eltyA, (dimsA...,))
        mA = reshape(permutedims(A, ipA), (loA, lc))
        B = rand(eltyB, (dimsB...,))
        mB = reshape(permutedims(B, ipB), (lc, loB))
        C = zeros(eltyC, (dimsC...,))
        dA = ROCArray(A)
        dB = ROCArray(B)
        dC = ROCArray(C)
        opA = AMDGPU.hipTENSOR.OP_IDENTITY
        opB = AMDGPU.hipTENSOR.OP_IDENTITY
        opC = AMDGPU.hipTENSOR.OP_IDENTITY
        opOut = AMDGPU.hipTENSOR.OP_IDENTITY
        
        @testset "simple case" begin 
            dC = contract!(1, dA, indsA, opA, dB, indsB, opB, 0, dC, indsC, opC, opOut, compute_type=eltyCompute)
            C = collect(dC)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            @test mC ≈ mA * mB rtol=compute_rtol
            AMDGPU.synchronize()
        end

        @testset "simple case with plan storage" begin
            plan  = hipTENSOR.plan_contraction(dA, indsA, opA, dB, indsB, opB, dC, indsC, opC, opOut)
            dC = contract!(plan, 1, dA, dB, 0, dC)
            C = collect(dC)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            @test mC ≈ mA * mB
            AMDGPU.synchronize()
        end

        @testset "simple case with plan storage and compute type" begin
            eltypComputeEnum = hipTENSOR.compute_descriptor(eltyCompute)
            plan  = hipTENSOR.plan_contraction(dA, indsA, opA, dB, indsB, opB, dC, indsC, opC, opOut; compute_type=eltypComputeEnum)
            dC = hipTENSOR.contract!(plan, 1, dA, dB, 0, dC)
            C = collect(dC)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            @test mC ≈ mA * mB rtol=compute_rtol
            AMDGPU.synchronize()
        end

        @testset "simple case with plan storage and JIT compilation" begin
            plan  = AMDGPU.hipTENSOR.plan_contraction(dA, indsA, opA, dB, indsB, opB, dC, indsC, opC, opOut; jit=hipTENSOR.JIT_MODE_DEFAULT)
            dC = contract!(plan, 1, dA, dB, 0, dC)
            C = collect(dC)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            @test mC ≈ mA * mB
            AMDGPU.synchronize()
        end

        @testset "with non-trivial α" begin
            α = rand(eltyCompute)
            dC = contract!(α, dA, indsA, opA, dB, indsB, opB, zero(eltyCompute), dC, indsC, opC, opOut; compute_type=eltyCompute)
            C = collect(dC)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            @test mC ≈ α * mA * mB rtol=compute_rtol
            AMDGPU.synchronize()
        end

        @testset "with non-trivial β" begin
            C = rand(eltyC, (dimsC...,))
            dC = ROCArray(C)
            α = rand(eltyCompute)
            β = rand(eltyCompute)
            copyto!(dC, C)
            dD = contract!(α, dA, indsA, opA, dB, indsB, opB, β, dC, indsC, opC, opOut; compute_type=eltyCompute)
            D = collect(dD)
            mC = reshape(permutedims(C, ipC), (loA, loB))
            mD = reshape(permutedims(D, ipC), (loA, loB))
            @test mD ≈ α * mA * mB + β * mC rtol=compute_rtol
            AMDGPU.synchronize()
        end

        if eltyCompute != Float32 && eltyC != Float16
            @testset "with hipTensor objects" begin
                ctA = hipTensor(dA, indsA)
                ctB = hipTensor(dB, indsB)
                ctC = hipTensor(dC, indsC)
                ctC = LinearAlgebra.mul!(ctC, ctA, ctB)
                C2, C2inds = collect(ctC)
                mC = reshape(permutedims(C2, ipC), (loA, loB))
                @test mC ≈ mA * mB
                ctC = ctA * ctB
                C2, C2inds = collect(ctC)
                pC2 = Int.(indexin(Char.(C2inds), [indsoA; indsoB]))
                mC = reshape(permutedims(C2, invperm(pC2)), (loA, loB))
                @test mC ≈ mA * mB
            end
            AMDGPU.synchronize()
        end

        # not supported for these specific cases for unknown reason
        if !((NoA, NoB, Nc) in ((1,1,3), (1,2,3), (3,1,2)))
            # hipTENSOR 2.2 accepts HIPTENSOR_OP_CONJ on a contraction's inputs and then
            # silently ignores it: the results below are the unconjugated products. These
            # are `@test_broken` so that they start failing again once that is fixed.
            @testset "with conjugation flag for complex arguments" begin
                if canonical_layout
                    # 2.4 rejects OP_CONJ outright, failing `hiptensorCreatePlan`
                    if eltyA <: Complex
                        @test_throws hipTENSOR.hipTENSORError contract!(
                            complex(1.0, 0.0), dA, indsA, AMDGPU.hipTENSOR.OP_CONJ,
                            dB, indsB, AMDGPU.hipTENSOR.OP_IDENTITY,
                            0, dC, indsC, opC, AMDGPU.hipTENSOR.OP_IDENTITY;
                            compute_type=eltyCompute)
                    end
                    if eltyB <: Complex
                        @test_throws hipTENSOR.hipTENSORError contract!(
                            complex(1.0, 0.0), dA, indsA, AMDGPU.hipTENSOR.OP_IDENTITY,
                            dB, indsB, AMDGPU.hipTENSOR.OP_CONJ,
                            complex(0.0, 0.0), dC, indsC, opC, AMDGPU.hipTENSOR.OP_IDENTITY;
                            compute_type=eltyCompute)
                    end
                else
                    if eltyA <: Complex
                        opA   = AMDGPU.hipTENSOR.OP_CONJ
                        opB   = AMDGPU.hipTENSOR.OP_IDENTITY
                        opOut = AMDGPU.hipTENSOR.OP_IDENTITY
                        dC    = contract!(complex(1.0, 0.0), dA, indsA, opA, dB, indsB, opB,
                                                        0, dC, indsC, opC, opOut; compute_type=eltyCompute)
                        C     = collect(dC)
                        mC    = reshape(permutedims(C, ipC), (loA, loB))
                        @test_broken isapprox(mC, conj(mA) * mB; rtol=compute_rtol)
                        @test mC ≈ mA * mB rtol=compute_rtol   # opA was ignored
                    end
                    if eltyB <: Complex
                        opA = AMDGPU.hipTENSOR.OP_IDENTITY
                        opB = AMDGPU.hipTENSOR.OP_CONJ
                        opOut = AMDGPU.hipTENSOR.OP_IDENTITY
                        dC = contract!(complex(1.0, 0.0), dA, indsA, opA, dB, indsB, opB,
                                       complex(0.0, 0.0), dC, indsC, opC, opOut; compute_type=eltyCompute)
                        C = collect(dC)
                        mC = reshape(permutedims(C, ipC), (loA, loB))
                        @test_broken isapprox(mC, mA * conj(mB); rtol=compute_rtol)
                        @test mC ≈ mA * mB rtol=compute_rtol   # opB was ignored
                    end
                    if eltyA <: Complex && eltyB <: Complex
                        opA = AMDGPU.hipTENSOR.OP_CONJ
                        opB = AMDGPU.hipTENSOR.OP_CONJ
                        opOut = AMDGPU.hipTENSOR.OP_IDENTITY
                        dC = contract!(one(eltyCompute), dA, indsA, opA, dB, indsB, opB,
                                zero(eltyCompute), dC, indsC, opC, opOut; compute_type=eltyCompute)
                        C = collect(dC)
                        mC = reshape(permutedims(C, ipC), (loA, loB))
                        @test_broken isapprox(mC, conj(mA) * conj(mB); rtol=compute_rtol)
                        @test mC ≈ mA * mB rtol=compute_rtol   # opA and opB were ignored
                    end
                end
            end
            AMDGPU.synchronize()
        end
    end
end

@testset "layouts hipTENSOR miscomputes are rejected" begin
    if hipTENSOR.version() >= v"2.4"
        dA = ROCArray(rand(Float32, 2, 4))
        dB = ROCArray(rand(Float32, 4, 3))   # indexed [K, N]; hipTENSOR 2.4 needs [N, K]
        dC = ROCArray(zeros(Float32, 2, 3))
        op = AMDGPU.hipTENSOR.OP_IDENTITY
        @test_throws ArgumentError contract!(1f0, dA, ['a', 'k'], op, dB, ['k', 'b'], op,
                                             0f0, dC, ['a', 'b'], op, op)
    end
end

@testset "contractions of views" begin
    @testset for (eltyA, eltyB, eltyC, eltyCompute) in eltypes
        dimsA = (16,)
        dimsB = (4,)
        dimsC = (8,)
        A = rand(eltyA, dimsA)
        B = rand(eltyB, dimsB)
        C = rand(eltyC, dimsC)
        dA = ROCArray(A)
        dB = ROCArray(B)
        dC = ROCArray(C)
        dD = ROCArray(C)
        vA = @view dA[1:4]
        vB = @view dB[4:4]
        vC = @view dC[3:6]
        vD = @view dD[3:6]
        tA = hipTensor(reshape(vA, (4, 1)), [1, 2])
        tB = hipTensor(reshape(vB, (1, 1)), [3, 2])
        # C must be indexed by A's free modes then B's; see `check_contraction_layout`
        tC = hipTensor(reshape(vC, (4, 1)), [1, 3])
        mul!(tC, tA, tB)
    end
end

end

end
