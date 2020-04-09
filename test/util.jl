# NOTE: based on test/pkg.jl::capture_stdout, but doesn't discard exceptions
macro grab_output(ex)
    quote
        mktemp() do fname, fout
            ret = nothing
            open(fname, "w") do fout
                redirect_stdout(fout) do
                    ret = $(esc(ex))
                end
            end
            ret, read(fname, String)
        end
    end
end

# Run some code on-device, returning captured standard output
macro on_device(ex)
    quote
        let
            function kernel()
                $(esc(ex))
                return
            end

            @roc kernel()
            synchronize()
        end
    end
end

function julia_script(code, args=``)
    script = "using AMDGPUnative; $code"
    out = Pipe()
    err = Pipe()
    cmd = `$(Base.julia_cmd()) -e $script`
    if Base.JLOptions().project != C_NULL
        # --project isn't preserved by julia_cmd()
        cmd = `$cmd --project=$(unsafe_string(Base.JLOptions().project))`
    end
    cmd = `$cmd $args`
    proc = run(pipeline(cmd, stdout=out, stderr=err), wait=false)
    close(out.in)
    close(err.in)
    wait(proc)
    proc.exitcode, read(out, String), read(err, String)
end

# a lightweight ROC array type for testing purposes
## ctor & finalizer
mutable struct ROCTestArray{T,N}
    buf::Mem.Buffer
    shape::NTuple{N,Int}
    function ROCTestArray{T,N}(shape::NTuple{N,Int}) where {T,N}
        len = prod(shape)
        buf = Mem.alloc(len*sizeof(T))

        obj = new{T,N}(buf, shape)
        finalizer(unsafe_free!, obj)
        return obj
    end
end
function unsafe_free!(a::ROCTestArray)
    # FIXME
    error("Not implemented")
    #CUDAdrv.isvalid(a.buf.ctx) && Mem.free(a.buf)
end
## memory copy operations
function ROCTestArray(src::Array{T,N}) where {T,N}
    dst = ROCTestArray{T,N}(size(src))
    Mem.upload!(dst.buf, pointer(src), length(src) * sizeof(T))
    return dst
end
function Base.Array(src::ROCTestArray{T,N}) where {T,N}
    dst = Array{T,N}(undef, src.shape)
    Mem.download!(pointer(dst), src.buf, prod(src.shape) * sizeof(T))
    return dst
end
## conversions
using Adapt
function Adapt.adapt_storage(::AMDGPUnative.Adaptor, a::ROCTestArray{T,N}) where {T,N}
    ptr = Base.unsafe_convert(Ptr{T}, a.buf)
    devptr = AMDGPUnative.DevicePtr{T,AS.Global}(ptr)
    ROCDeviceArray{T,N,AS.Global}(a.shape, devptr)
end
