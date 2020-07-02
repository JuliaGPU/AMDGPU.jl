@testset "Math Intrinsics" begin
    for intr in AMDGPU.MATH_INTRINSICS
        jlintr = intr.jlname
        if intr.isbroken || !(isdefined(Base, jlintr) || isdefined(SpecialFunctions, jlintr))
            @test_skip "$jlintr()"
            continue
        end
        modname = (isdefined(Base, jlintr) ? Base : SpecialFunctions)
        # FIXME: Handle all input and output args
        T = intr.inp_args[1]
        intr_kern = Symbol("intr_$(jlintr)_$T")
        @eval begin
            function $intr_kern(a)
                i = threadIdx().x
                a[i] = AMDGPU.$jlintr(a[i])
                return nothing
            end
            dims = (8,)
            a = rand($T, dims)
            if $(QuoteNode(jlintr)) == :acosh
                a .+= one($T)
            end
            d_a = HSAArray(a)
            len = prod(dims)

            @debug begin
                aspace = AMDGPU.AS.Global
                arrdims = ndims(a)
                arrT = ROCDeviceArray{Float32,arrdims,aspace}
                @debug "LLVM IR"
                AMDGPU.code_llvm($intr_kern, Tuple{arrT}; kernel=true)
                @debug "GCN Device Code"
                AMDGPU.code_gcn($intr_kern, Tuple{arrT}; kernel=true)
                ""
            end

            wait(@roc groupsize=len $intr_kern(d_a))
            _a = Array(d_a)
            @test $modname.$jlintr.(a) ≈ _a
        end
    end
end
