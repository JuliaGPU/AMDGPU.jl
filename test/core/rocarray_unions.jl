using Test
using AMDGPU
using AMDGPU: ROCArray, @roc, @ROCStaticLocalArray

# Arrays of isbits unions keep one selector byte per element past the data (see
# `typetagdata` in src/array.jl), like `Array` does. These follow CUDA.jl's tests.

const HIPBuffer = AMDGPU.Mem.HIPBuffer
const HostBuffer = AMDGPU.Mem.HostBuffer

# a struct with a union field is not isbits, but is allocated inline with its own selector
struct UnionField
    foo::Union{Int, Float32}
end

@testset "isbits unions" begin

@testset "size" begin
    b = ROCArray(Union{Int, Nothing}[1, nothing, 3])
    @test sizeof(b) == 3 * sizeof(Int)  # excludes the selector bytes
end

@testset "host round trips ($B)" for B in (HIPBuffer, HostBuffer)
    a = Union{Int, Nothing}[1, nothing, 3]
    b = ROCArray{Union{Int, Nothing}, 1, B}(a)
    @test Array(b) == a
    @test Array(copy(b)) == a

    # copies between device arrays, also across buffer types
    c = similar(b)
    copyto!(c, b)
    @test Array(c) == a
    d = ROCArray{Union{Int, Nothing}, 1, HIPBuffer}(undef, 3)
    copyto!(d, b)
    @test Array(d) == a
    copyto!(d, 2, b, 1, 2)
    @test Array(d) == [1, 1, nothing]

    # unions of singletons have no data, only selector bytes
    e = [nothing, missing, missing, nothing]
    @test isequal(Array(ROCArray{Union{Nothing, Missing}, 1, B}(e)), e)
end

@testset "kernels" begin
    # reading and writing unions from device code
    function bump!(x)
        i = workitemIdx().x
        val = x[i]
        if val !== nothing
            x[i] = val + 1
        end
        return
    end
    a = Union{Int, Nothing}[1, nothing, 3]
    b = ROCArray(a)
    @roc groupsize=length(b) bump!(b)
    @test Array(b) == [2, nothing, 4]

    # a derived view starts at an offset: the kernel must pick up the view's own selector
    # bytes, not those at the start of the parent (which differ here)
    a = Union{Int, Nothing}[nothing, nothing, 1, nothing, 3, 5]
    b = ROCArray(a)
    v = view(b, 3:5)
    @test Array(v) == view(a, 3:5)
    @roc groupsize=length(v) bump!(v)
    @test Array(v) == [2, nothing, 4]
    @test Array(b) == [nothing, nothing, 2, nothing, 4, 5]

    # a non-contiguous view indexes into its parent
    w = view(b, 1:2:5)
    @roc groupsize=length(w) bump!(w)
    @test Array(b) == [nothing, nothing, 3, nothing, 5, 5]

    # unions of singletons
    function check_singletons!(ok, x)
        i = workitemIdx().x
        expected = (i == 1 || i == 4) ? nothing : missing
        ok[i] = x[i] === expected
        return
    end
    c = ROCArray([nothing, missing, missing, nothing])
    ok = ROCArray(falses(4))
    @roc groupsize=4 check_singletons!(ok, c)
    @test all(Array(ok))

    # their views have no byte offset, but must still read their own selector bytes
    v = view(c, 2:3)
    @test isequal(Array(v), [missing, missing])
    @test isequal(Array(copy(v)), [missing, missing])
    function check_missing!(ok, x)
        i = workitemIdx().x
        ok[i] = x[i] === missing
        return
    end
    ok = ROCArray(falses(2))
    @roc groupsize=2 check_missing!(ok, v)
    @test all(Array(ok))

    # nested unions are flattened
    function bump_nested!(x)
        i = workitemIdx().x
        val = x[i]
        if val !== nothing && val !== missing
            x[i] = val + 1
        end
        return
    end
    d = ROCArray{Union{Union{Missing, Nothing}, Int}}([0, missing, nothing])
    @roc groupsize=length(d) bump_nested!(d)
    @test isequal(Array(d), [1, missing, nothing])

    # a struct with a union field keeps its selector inside the element
    function fill_struct!(x::AbstractArray{T}) where {T}
        i = workitemIdx().x
        x[i] = i == 1 ? T(Int(i)) : T(Float32(i))
        return
    end
    e = ROCArray{UnionField}(undef, 2)
    @roc groupsize=2 fill_struct!(e)
    @test Array(e) == [UnionField(1), UnionField(2f0)]

    # local memory keeps the selector bytes too. reversing the elements through it makes
    # every work-item read a value another one wrote; the tiles' data fill whole
    # alignment units, so selectors written past an allocation would land in the other tile
    function reverse_local!(x::AbstractArray{T}, y::AbstractArray{T}) where {T}
        i = workitemIdx().x
        n = length(x)
        tile_x = @ROCStaticLocalArray(T, 32, false)
        tile_y = @ROCStaticLocalArray(T, 32, false)
        tile_x[i] = x[i]
        tile_y[i] = y[i]
        sync_workgroup()
        x[i] = tile_x[n + 1 - i]
        y[i] = tile_y[n + 1 - i]
        return
    end
    a = Union{Missing, Int32}[isodd(i) ? missing : Int32(i) for i in 1:32]
    b = Union{Missing, Int32}[isodd(i) ? Int32(-i) : missing for i in 1:32]
    f, g = ROCArray(a), ROCArray(b)
    @roc groupsize=length(f) reverse_local!(f, g)
    @test isequal(Array(f), reverse(a))
    @test isequal(Array(g), reverse(b))
end

@testset "array operations" begin
    x = ROCArray(Union{Missing, Bool}[missing, true, false])
    @test isequal(Array(x .| false), [missing, true, false])
    @test isequal(Array(map(!, x)), [missing, false, true])
    @test any(x) === true
    @test all(x) === false
    @test isequal(Array(x[2:3]), [true, false])

    y = similar(x)
    fill!(y, missing)
    @test all(ismissing, Array(y))
    fill!(y, true)
    @test Array(y) == [true, true, true]

    # unions of types that memset could fill must still get their selector bytes
    w = ROCArray(Union{Int8, UInt8}[Int8(0), Int8(0)])
    fill!(w, 0xff)
    @test Array(w) == [0xff, 0xff] && all(v -> v isa UInt8, Array(w))

    z = reshape(ROCArray(Union{Int, Nothing}[1, nothing, 3, nothing]), 2, 2)
    @test Array(z) == [1 3; nothing nothing]
    @test isequal(Array(map(v -> v === nothing ? 0 : v, z)), [1 3; 0 0])
end

@testset "resize!" begin
    a = ROCArray(Union{Int, Nothing}[1, nothing, 3])
    resize!(a, 5)
    @test length(a) == 5
    @test Array(a)[1:3] == [1, nothing, 3]
    resize!(a, 2)
    @test Array(a) == [1, nothing]
end

@testset "unsupported operations" begin
    a = Union{Int, Nothing}[1, nothing]
    @test_throws ArgumentError unsafe_wrap(ROCArray, a)
    b = ROCArray{Union{Int, Nothing}, 1, HostBuffer}(a)
    @test_throws ArgumentError unsafe_wrap(Array, b)
    @test_throws "not all types are bitstypes" reinterpret(Float64, ROCArray(a))
end

end
