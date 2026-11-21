# hash(HIPDevice) => HostBuffer
const GLOBAL_EXCEPTION_INFO = Dict{UInt, Mem.HostBuffer}()

# the throw sites of the kernels that have been loaded, by handle. a kernel's exception info
# names the kernel that threw, but is checked where that kernel isn't known, e.g. by
# `synchronize`.
const EXCEPTION_SITES = Dict{HIP.hipFunction_t, Vector{GPUCompiler.ExceptionSite}}()
const EXCEPTION_SITES_LOCK = ReentrantLock()

function register_exception_sites!(fun::HIP.HIPFunction, sites::Vector{GPUCompiler.ExceptionSite})
    @lock EXCEPTION_SITES_LOCK EXCEPTION_SITES[fun.handle] = sites
    return
end

function exception_site(kernel::UInt64, id::Int32)
    sites = @lock EXCEPTION_SITES_LOCK get(EXCEPTION_SITES, reinterpret(HIP.hipFunction_t, kernel), nothing)
    sites === nothing && return nothing
    return 1 <= id <= length(sites) ? sites[id] : nothing
end

"""
    KernelException

An exception thrown during kernel execution on device `dev`, by work-item `workitem` of
work-group `workgroup`. If the debug level is 1 or higher (see Julia's `-g` option), `site`
describes what was thrown: the exception's name, the reason, and at debug level 2 a
backtrace.
"""
struct KernelException <: Exception
    dev::HIPDevice
    site::Union{Nothing, GPUCompiler.ExceptionSite}
    workgroup::NTuple{3, Int}
    workitem::NTuple{3, Int}
end

function Base.showerror(io::IO, err::KernelException)
    site = err.site
    if site === nothing
        print(io, "KernelException: exception thrown during kernel execution on work-item ",
              err.workitem, " of work-group ", err.workgroup, " on ", err.dev)
        return
    end
    print(io, "KernelException: ", site.name, " during kernel execution on work-item ",
          err.workitem, " of work-group ", err.workgroup)
    isempty(site.reason) || print(io, ": ", site.reason)
    if isempty(site.frames)
        print(io, "\nRun Julia on debug level 2 for a device stack trace.")
    else
        print(io, "\nStacktrace:")
        for (i, frame) in enumerate(site.frames)
            print(io, "\n [", i, "] ", frame.func, " at ", frame.file, ":", frame.line)
        end
    end
end

# TODO RT_LOCK?
function exception_info(dev::HIPDevice)::Ptr{UInt64}
    ei = get!(
        () -> Device.alloc_exception_info(),
        GLOBAL_EXCEPTION_INFO, hash(dev))
    return convert(Ptr{UInt64}, Mem.device_ptr(ei))
end

function has_exception(dev::HIPDevice)::Bool
    return unsafe_load(exception_info(dev)) != UInt64(0)
end

function reset_exception_info!(dev::HIPDevice)
    unsafe_store!(convert(Ptr{Device.ExceptionInfo}, exception_info(dev)), Device.ExceptionInfo())
    return
end

function throw_if_exception(dev::HIPDevice)
    has_exception(dev) || return
    info = unsafe_load(convert(Ptr{Device.ExceptionInfo}, exception_info(dev)))
    reset_exception_info!(dev)
    throw(KernelException(dev, exception_site(info.kernel, info.site),
                          Int.(info.workgroup), Int.(info.workitem)))
end

function KernelState(dev::HIPDevice, fun::HIP.HIPFunction, shmem::Integer = 0)
    global_hostcalls = fun.global_hostcalls
    malloc_ptr = :malloc_hostcall in global_hostcalls ?
        Compiler.create_malloc_hostcall!() : C_NULL
    free_ptr = :free_hostcall in global_hostcalls ?
        Compiler.create_free_hostcall!() : C_NULL
    print_ptr = :print_hostcall in global_hostcalls ?
        Compiler.create_output_context!() : C_NULL
    printf_ptr = :printf_hostcall in global_hostcalls ?
        Compiler.create_printf_output_context!() : C_NULL

    return KernelState(exception_info(dev), fun.handle, malloc_ptr, free_ptr, print_ptr, printf_ptr,
                       Int(shmem))
end
