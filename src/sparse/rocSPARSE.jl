module ROCSPARSE

using ..AMDGPU
import AMDGPU: wait!, mark!

using LinearAlgebra

const librocsparse = "librocsparse"

include("librocsparse.jl")

const _handle = Ref{rocsparse_handle}(C_NULL)

function handle()
    if _handle[] == C_NULL
        rocsparse_create_handle(Base.unsafe_convert(Ptr{Cvoid}, _handle))
        atexit(()->rocsparse_destroy_handle(_handle[]))
    end
    return _handle[]
end

function version()
    ref_version = Ref{Cint}()
    rocsparse_get_version(handle(), ref_version)
    version = unsafe_load(Base.unsafe_convert(Ptr{Cint}, ref_version))
    patch = version % 100
    minor = div(version, 100) % 1000
    major = div(version, 100000)
    VersionNumber(string(major, ".", minor, ".", patch))
end

end
