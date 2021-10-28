@testset "Math Intrinsics" begin
    for intr in AMDGPU.MATH_INTRINSICS
        jlintr = intr.jlname
        if intr.isbroken || !(isdefined(Base, jlintr) || isdefined(SpecialFunctions, jlintr)) || length(intr.inp_args) != 1
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
            d_a = ROCArray(a)
            len = prod(dims)

            wait(@roc groupsize=len $intr_kern(d_a))
            _a = Array(d_a)
            @test $modname.$jlintr.(a) ≈ _a
        end
    end
end
