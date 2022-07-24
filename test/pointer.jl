@testset "semi_safe_load" begin

@test Runtime.PAGESIZE == 0x1000

struct MediumObject end
Base.sizeof(::MediumObject) = 0x1000
Base.sizeof(::Type{MediumObject}) = 0x1000
struct BigObject end
Base.sizeof(::BigObject) = 0x2000
Base.sizeof(::Type{BigObject}) = 0x2000

for (ptr, bases) in (
    # Less-than-page object
    (Ptr{Int}(UInt64(0x0)), UInt64[0x0]),
    (Ptr{Int}(UInt64(0x1)), UInt64[0x0]),
    (Ptr{Int}(UInt64(0xffc)), UInt64[0x0, 0x1000]),
    (Ptr{Int}(UInt64(0x1000)), UInt64[0x1000]),
    (Ptr{Int}(UInt64(0x1001)), UInt64[0x1000]),

    # Full-page object
    (Ptr{MediumObject}(UInt64(0x0)), UInt64[0x0]),
    (Ptr{MediumObject}(UInt64(0x1)), UInt64[0x0, 0x1000]),
    (Ptr{MediumObject}(UInt64(0xffc)), UInt64[0x0, 0x1000]),
    (Ptr{MediumObject}(UInt64(0x1000)), UInt64[0x1000]),
    (Ptr{MediumObject}(UInt64(0x1001)), UInt64[0x1000, 0x2000]),

    # Multi-page object
    (Ptr{BigObject}(UInt64(0x0)), UInt64[0x0, 0x1000]),
    (Ptr{BigObject}(UInt64(0x1)), UInt64[0x0, 0x1000, 0x2000]),
    (Ptr{BigObject}(UInt64(0xffc)), UInt64[0x0, 0x1000, 0x2000]),
    (Ptr{BigObject}(UInt64(0x1000)), UInt64[0x1000, 0x2000]),
    (Ptr{BigObject}(UInt64(0x1001)), UInt64[0x1000, 0x2000, 0x3000]),
)
    @test Runtime._pages_spanned(ptr) == length(bases)
    Runtime._per_page((x,y)->nothing, ptr) do base
        @test base in bases
    end
end

end
