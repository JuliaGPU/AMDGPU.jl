# Kernel argument hashing

## Arguments which are written to the kernarg buffer identically should have
## the same khash value. Array contents are not hashed; instead, we hash the
## array pointer.

function khash(x::T, h::UInt=UInt(0)) where T
    # Generic hashing
    h = khash(T, h)
    if isstructtype(T)
        for idx in 1:fieldcount(T)
            name = fieldname(T, idx)
            h = khash(getfield(x, name), h)
        end
    elseif isprimitivetype(T)
        h = hash(x, h)
    else
        error("Can't hash: $T")
    end
    return h
end
khash(::Type{T}, h::UInt=UInt(0)) where T = hash(T, h)
khash(x::Symbol, h::UInt=UInt(0)) = hash(x, h)
