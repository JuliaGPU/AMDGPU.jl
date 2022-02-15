using Base.FastMath

@testset "Math Intrinsics" begin
    for intr in AMDGPU.MATH_INTRINSICS
        jlintr = intr.jlname
        if intr.isbroken ||
           !isdefined(Base, jlintr) ||
           !isdefined(Base.FastMath, jlintr) ||
           !isdefined(SpecialFunctions, jlintr) ||
           length(intr.inp_args) != 1
            @test_skip "$jlintr()"
            continue
        end
        modname = (isdefined(Base, jlintr) ? Base :
                   isdefined(Base.FastMath, jlintr) ? Base.FastMath :
                   isdefined(SpecialFunctions, jlintr) ? SpecialFunctions :
                   nothing)
        modname !== nothing || continue
        # FIXME: Handle all input and output args
        T = intr.inp_args[1]
        intr_kern = Symbol("intr_$(jlintr)_$T")
        @eval begin
            function $intr_kern(out, a)
                i = threadIdx().x
                out[i] = $jlintr(a[i])
                return nothing
            end
            dims = (8,)
            a = rand($T, dims)
            if $(QuoteNode(jlintr)) == :acosh
                a .+= one($T)
            end
            d_a = ROCArray(a)
            if $intr.tobool
                d_out = similar(d_a, Bool)
            else
                d_out = similar(d_a)
            end
            len = prod(dims)

            wait(@roc groupsize=len $intr_kern(d_out, d_a))
            out = Array(d_out)
            @test $modname.$jlintr.(a) ≈ out
        end
    end
end
