@testset "Kernel Argument Hashing" begin
    khash = AMDGPU.Runtime.khash

    @testset "Primitives" begin
        x = UInt8(1)
        y = UInt8(2)

        @test khash(x) == khash(x)
        @test khash(y) == khash(y)
        @test khash(x) != khash(y)

        @test khash(x, UInt(1)) == khash(x, UInt(1))
        @test khash(y, UInt(1)) == khash(y, UInt(1))
        @test khash(x, UInt(1)) != khash(y, UInt(1))

        @test khash(x, UInt(1)) != khash(x, UInt(2))
        @test khash(y, UInt(1)) != khash(y, UInt(2))
        @test khash(x, UInt(1)) != khash(y, UInt(2))

        for T in [UInt16, UInt32, UInt64, Int8, Int16, Int32, Int64, Float32, Float64]
            xc = convert(T, x)
            yc = convert(T, y)
            @test khash(xc) == khash(xc)
            @test khash(yc) == khash(yc)
            @test khash(xc) != khash(yc)

            @test khash(xc, UInt(1)) == khash(xc, UInt(1))
            @test khash(yc, UInt(1)) == khash(yc, UInt(1))
            @test khash(xc, UInt(1)) != khash(yc, UInt(1))

            @test khash(xc, UInt(1)) != khash(xc, UInt(2))
            @test khash(yc, UInt(1)) != khash(yc, UInt(2))
            @test khash(xc, UInt(1)) != khash(yc, UInt(2))
        end
    end

    @testset "Tuples" begin
        z1 = (UInt8(1), UInt8(2), UInt8(3))
        z2 = (UInt8(1), UInt8(2), UInt8(4))
        z3 = (UInt8(1), UInt8(2), UInt16(3))

        @test khash(z1) == khash(z1)
        @test khash(z1, UInt(1)) == khash(z1, UInt(1))
        @test khash(z1, UInt(1)) != khash(z1, UInt(2))

        @test khash(z1) != khash(z2)
        @test khash(z1, UInt(1)) != khash(z2, UInt(1))

        @test khash(z1) != khash(z3)
        @test khash(z1, UInt(1)) != khash(z3, UInt(1))
    end

    @testset "Functions" begin
        @test khash(+) == khash(+)
        @test khash(+, UInt(1)) == khash(+, UInt(1))
        @test khash(+, UInt(1)) != khash(+, UInt(2))
        @test khash(+) != khash(-) != khash(/) != khash(identity)

        x = 1
        f() = x
        @test khash(f) == khash(f)
        @test khash(f, UInt(1)) == khash(f, UInt(1))

        g() = x
        @test khash(f) != khash(g)
        @test khash(f, UInt(1)) != khash(g, UInt(1))
    end

    @testset "ROCDeviceArray" begin
        RA = ROCArray(rand(4))
        DA = rocconvert(RA)

        @test khash(DA) == khash(DA)
        @test khash(DA, UInt(1)) == khash(DA, UInt(1))
        @test khash(DA, UInt(1)) != khash(DA, UInt(2))

        A_hash = khash(DA)
        RA .= RA .+ 1
        @test khash(DA) == A_hash

        RB = copy(RA)
        DB = rocconvert(RB)

        @test khash(RA) != khash(RB)
    end

    @testset "ROCDeviceArray wrappers" begin
        RC = ROCArray(rand(4, 4))
        DC = rocconvert(RC)
        RCv = @view RC[2:3, 2:3]
        DCv = rocconvert(RCv)

        @test khash(DC) != khash(DCv)
        @test khash(DC, UInt(1)) != khash(DCv, UInt(1))

        @test khash(DCv) == khash(DCv)
        @test khash(DCv, UInt(1)) == khash(DCv, UInt(1))
        @test khash(DCv, UInt(1)) != khash(DCv, UInt(2))
    end
end
