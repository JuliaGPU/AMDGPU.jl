# HSA error handling utilities

export HSAError

struct HSAError <: Exception
    code::HSA.Status
end

"""
    description(err::HSAError)

Gets the string description of an error code.
"""
description(err::HSAError) = description(err.code)
function description(status::HSA.Status)
    str_ref = Ref{Ptr{Int8}}()
    HSA.status_string(status, str_ref)
    unsafe_string(reinterpret(Cstring, str_ref[]))
end

function Base.showerror(io::IO, err::HSAError)
    print(io, "HSA error (code #$(Int(err.code)), $(description(err)))")
end

Base.show(io::IO, err::HSAError) = print(io, "HSAError($(Int(err.code)), $(description(err)))")

"""
    check(result::AMDGPU.HSA.Status)

Check the return code of an HSA call, and throw an `HSAError` exception
if it is not the success code.
"""
function check(result::HSA.Status)
    if result != HSA.STATUS_SUCCESS
        throw(HSAError(result))
    end
end
