# Store in KernelState gbl ptr.
# default_global_hooks[:__global_exception_ring] = (gbl, mod, device) -> begin
#     # initialize exception ring buffer
#     gbl_ptr = Base.unsafe_convert(Ptr{Ptr{ExceptionEntry}}, gbl)
#     ex_ptr = Base.unsafe_convert(Ptr{ExceptionEntry}, mod.exceptions)
#     unsafe_store!(gbl_ptr, ex_ptr)

#     # setup initial slots
#     for i in 1:Runtime.MAX_EXCEPTIONS-1
#         unsafe_store!(ex_ptr, ExceptionEntry(0, LLVMPtr{UInt8,1}(0)))
#         ex_ptr += sizeof(ExceptionEntry)
#     end
#     # setup tail slot
#     unsafe_store!(ex_ptr, ExceptionEntry(1, LLVMPtr{UInt8,1}(0)))
# end
# default_global_hooks[:__global_malloc_hostcall] = (gbl, mod, device) -> begin
#     # initialize malloc hostcall
#     args_type = Tuple{UInt64, Csize_t}
#     ret_type = Ptr{Cvoid}
#     gbl_ptr = Base.unsafe_convert(Ptr{HostCall{ret_type, args_type}}, gbl)

#     hc = Device.named_perdevice_hostcall(device, :__global_malloc) do
#         HostCall(ret_type, args_type; device, continuous=true, timeout=nothing) do kern, sz
#             buf = Mem.alloc(device, sz; coherent=true)
#             # FIXME: Lock
#             push!(mod.metadata, Runtime.KernelMetadata(kern, buf))
#             @debug "Allocated $(buf.ptr) ($sz bytes) for kernel $kern on device $device"
#             return buf.ptr
#         end
#     end
#     Base.unsafe_store!(gbl_ptr, hc)
# end
# default_global_hooks[:__global_free_hostcall] = (gbl, mod, device) -> begin
#     # initialize free hostcall
#     args_type = Tuple{UInt64, Ptr{Cvoid}}
#     ret_type = Nothing
#     gbl_ptr = Base.unsafe_convert(Ptr{HostCall{ret_type, args_type}}, gbl)

#     hc = Device.named_perdevice_hostcall(device, :__global_free) do
#         HostCall(ret_type, args_type; device, continuous=true, timeout=nothing) do kern, ptr
#             # FIXME: Lock
#             for idx in length(mod.metadata):-1:1
#                 meta = mod.metadata[idx]
#                 same_kern = meta.kern == kern
#                 same_ptr = meta.buf.ptr == ptr
#                 if same_kern && same_ptr
#                     Mem.free(meta.buf)
#                     deleteat!(mod.metadata, idx)
#                     @debug "Freed $ptr ($(meta.buf.bytesize) bytes) for kernel $kern on device $device."
#                     break
#                 end
#             end
#             return nothing
#         end
#     end
#     Base.unsafe_store!(gbl_ptr, hc)
# end
