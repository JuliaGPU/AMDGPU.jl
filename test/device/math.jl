@testset "Math Intrinsics" begin
    for intr in AMDGPUnative.MATH_INTRINSICS
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
                a[i] = AMDGPUnative.$jlintr(a[i])
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
                aspace = AMDGPUnative.AS.Global
                arrdims = ndims(a)
                arrT = ROCDeviceArray{Float32,arrdims,aspace}
                @debug "LLVM IR"
                AMDGPUnative.code_llvm($intr_kern, Tuple{arrT}; kernel=true)
                @debug "GCN Device Code"
                AMDGPUnative.code_gcn($intr_kern, Tuple{arrT}; kernel=true)
                ""
            end

            @roc groupsize=len gridsize=len $intr_kern(d_a)
            _a = Array(d_a)
            @test $modname.$jlintr.(a) ≈ _a
        end
    end
end
