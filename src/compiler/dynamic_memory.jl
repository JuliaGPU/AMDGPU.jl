function create_malloc_hostcall!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :malloc_hostcall) do
        holder = Device.HostCallHolder(
            Ptr{Cvoid}, Tuple{Csize_t}; continuous=true,
        ) do bytesize
            buf = Mem.HostBuffer(bytesize, HIP.hipHostAllocDefault)
            dev_ptr = Mem.device_ptr(buf)
            @assert buf.ptr == dev_ptr # TODO
            return dev_ptr
        end

        # Create host pinned memory and store HostCall in it.
        # It will be then accessed by kernels from kernel state.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.HostCall{Ptr{Cvoid}, Tuple{Csize_t}}}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end

function create_free_hostcall!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :free_hostcall) do
        holder = Device.HostCallHolder(
            Nothing, Tuple{Ptr{Cvoid}}; continuous=true,
        ) do ptr
            ptr == C_NULL && return
            # FIXME for some reason it hangs on free function in hostcall...
            # HIP.hipHostFree(ptr) |> HIP.check
            return
        end

        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.HostCall{Nothing, Tuple{Ptr{Cvoid}}}}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end

"""
    lower_device_malloc!(mod::LLVM.Module)

Give the C-ABI `malloc`/`free` a device-side definition, forwarding to ROCm's device
allocator.

That allocator is `__ockl_dm_alloc`/`__ockl_dm_dealloc` in `ockl`, drawing from the heap
sized by `hipLimitMallocHeapSize` (see [`AMDGPU.HIP.heap_size!`](@ref)). No device library
defines a plain `malloc`: for HIP C++ the C names come from a weak inline shim in clang's
`__clang_hip_runtime_wrapper.h`, and nothing plays that role for Julia. Code generated
outside AMDGPU.jl therefore reaches us as undefined `malloc`/`free` declarations, which
`GPUCompiler.check_ir` rejects as calls into the Julia runtime. Enzyme's reverse mode is
the motivating case: it puts the per-work-item tape behind `malloc`/`free`, so
differentiating any kernel that needs a runtime-sized tape fails to compile.

This emits the missing bodies, mirroring the clang shim. Note this is *not*
[`Device.malloc`](@ref), which serves the same C names' worth of functionality over a
hostcall; the ockl heap stays on the device.

Only undefined declarations are touched, so a module that already defines `malloc` (or
does not mention it) is left alone. Returns `true` if anything was defined.
"""
function lower_device_malloc!(mod::LLVM.Module)
    changed = false
    fns = LLVM.functions(mod)
    for (name, ockl_name, nargs) in (
        ("malloc", "__ockl_dm_alloc", 1),
        ("free", "__ockl_dm_dealloc", 1),
    )
        haskey(fns, name) || continue
        f = fns[name]
        LLVM.isdeclaration(f) || continue

        ftype = LLVM.function_type(f)
        # Anything that is not the C signature we expect is left for check_ir to report,
        # rather than silently given a body that does not match its callers.
        length(LLVM.parameters(ftype)) == nargs || continue

        # `__ockl_dm_alloc(i64) -> ptr addrspace(1)`, `__ockl_dm_dealloc(i64) -> void`.
        # Declared to match the definitions in ockl so that linking does not have to
        # bitcast the callee.
        i64 = LLVM.Int64Type()
        ockl_type = if name == "malloc"
            LLVM.FunctionType(LLVM.PointerType(AS.Global), [i64])
        else
            LLVM.FunctionType(LLVM.VoidType(), [i64])
        end
        ockl = haskey(fns, ockl_name) ? fns[ockl_name] :
            LLVM.Function(mod, ockl_name, ockl_type)

        @dispose builder = LLVM.IRBuilder() begin
            entry = LLVM.BasicBlock(f, "entry")
            LLVM.position!(builder, entry)
            arg = LLVM.parameters(f)[1]
            if name == "malloc"
                size = LLVM.value_type(arg) == i64 ? arg :
                    LLVM.zext!(builder, arg, i64)
                ptr = LLVM.call!(builder, ockl_type, ockl, [size])
                # ockl hands back a global-address-space pointer; malloc's callers expect
                # one in whatever address space the declaration promised (flat, in
                # practice).
                LLVM.ret!(builder, LLVM.addrspacecast!(
                    builder, ptr, LLVM.return_type(ftype)))
            else
                LLVM.call!(builder, ockl_type, ockl,
                    [LLVM.ptrtoint!(builder, arg, i64)])
                LLVM.ret!(builder)
            end
        end

        # Matches what clang's shim gets from `inline`, and keeps the call out of the way
        # of the register allocator.
        push!(LLVM.function_attributes(f), LLVM.EnumAttribute("alwaysinline"))
        changed = true
    end
    return changed
end
