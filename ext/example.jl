#= Original License of vector_copy.c
////////////////////////////////////////////////////////////////////////////////
//
// The University of Illinois/NCSA
// Open Source License (NCSA)
//
// Copyright (c) 2014-2016, Advanced Micro Devices, Inc. All rights reserved.
//
// Developed by:
//
//                 AMD Research and AMD HSA Software Development
//
//                 Advanced Micro Devices, Inc.
//
//                 www.amd.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal with the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimers.
//  - Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimers in
//    the documentation and/or other materials provided with the distribution.
//  - Neither the names of Advanced Micro Devices, Inc,
//    nor the names of its contributors may be used to endorse or promote
//    products derived from this Software without specific prior written
//    permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS WITH THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////
=#

using CEnum
using Setfield

include("hsa_types.jl")
include("hsa_interface.jl")
include("hsa_extras.jl")

#= TODO: Validate alignment
struct __attribute__ ((aligned(16))) args_t {
    void* in;
    void* out;
} args;
=#
struct KernelArgs
    inp
    out
end

global const SELECTED_AGENT = Ref{hsa_agent_t}()

macro check(ex::Expr)
    quote
        result = $(esc(ex))
        if result != HSA_STATUS_SUCCESS
            @warn "HSA call failed with code: $result"
            return HSA_STATUS_ERROR
        end
    end
end

function agent_iterate_isas_cb(isa::hsa_isa_t, data)
    name = repeat(" ", 64)
    @check hsa_isa_get_info_alt(isa, HSA_ISA_INFO_NAME, name)
    @info "    ISA Name: $name"

    return HSA_STATUS_SUCCESS
end

function iterate_agents_cb(agent::hsa_agent_t, data)
    @info "Available Agents:"

    # TODO: Get name length first!
    name = repeat(" ", 64)
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_NAME, name)
    @info "    Agent Name: $name"

    devtype = Ref{UInt32}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_DEVICE, devtype)
    @info "    Device Type: $(hsa_device_type_t(devtype[]))"
    if hsa_device_type_t(devtype[]) == HSA_DEVICE_TYPE_GPU
        ref = Ptr{Nothing}(0)
        func = @cfunction(agent_iterate_isas_cb, hsa_status_t,
            (hsa_isa_t, Ref{Nothing}))
        @check hsa_agent_iterate_isas(agent, func, ref)

        SELECTED_AGENT[] = agent
    end

    return HSA_STATUS_SUCCESS
end

function finalizer_iterate_isas_cb(isa::hsa_isa_t, data)
    @info "Finalizer ISAs:"

    name = repeat(" ", 64)
    @check hsa_isa_get_info_alt(isa, HSA_ISA_INFO_NAME, name)
    @info "    ISA Name: $name"

    return HSA_STATUS_SUCCESS
end

"Determines if a memory region can be used for kernarg allocations."
function get_kernarg_memory_region_cb(region::hsa_region_t, data::Ptr{hsa_region_t})
    segment = Ref{hsa_region_segment_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA_REGION_SEGMENT_GLOBAL)
        return HSA_STATUS_SUCCESS
    end

    flags = Ref{hsa_region_global_flag_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA_REGION_GLOBAL_FLAG_KERNARG > 0)
        unsafe_store!(data, region)
        return HSA_STATUS_INFO_BREAK
    end

    return HSA_STATUS_SUCCESS
end

"Determines if a memory region can be used for fine grained allocations."
function get_fine_grained_memory_region_cb(region::hsa_region_t, data::Ptr{hsa_region_t})
    segment = Ref{hsa_region_segment_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA_REGION_SEGMENT_GLOBAL)
        return HSA_STATUS_SUCCESS
    end

    flags = Ref{hsa_region_global_flag_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA_REGION_GLOBAL_FLAG_FINE_GRAINED > 0)
        unsafe_store!(data, region)
        return HSA_STATUS_INFO_BREAK
    end

    return HSA_STATUS_SUCCESS
end

function main()
    @check hsa_init()
    atexit() do
        hsa_shut_down()
    end

    support = Ref{Bool}(false)
    @check hsa_system_extension_supported(HSA_EXTENSION_FINALIZER, 1, 0,
            support)
    @info "HSA Finalizer 1.0 Supported: $(support[])"

    # Note: Requires the following libraries to be accessible as such:
    # libhsa-ext-finalize64.so
    # libhsa-ext-image64.so
    # libhsa-runtime-tools64.so
    table_1_00 = Ref{hsa_ext_finalizer_1_00_pfn_t}()
    @check hsa_system_get_extension_table(HSA_EXTENSION_FINALIZER, 1, 0,
            table_1_00)

    ref = Ptr{Nothing}(0)
    func = @cfunction(iterate_agents_cb, hsa_status_t,
            (hsa_agent_t, Ref{Nothing}))
    @check hsa_iterate_agents(func, ref)
    agent = SELECTED_AGENT[]
    println()

    #= TODO: Does ROCR not implement this for some good reason?
    ref = Ptr{Nothing}(0)
    func = @cfunction(finalizer_iterate_isas_cb, hsa_status_t,
            (hsa_isa_t, Ref{Nothing}))
    @check ccall((:hsa_ext_finalizer_iterate_isa, "libhsa-ext-finalize64"), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), func, ref)
    println()
    =#

    name = repeat(" ", 64)
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_NAME, name)
    @info "Agent Name: $name"

    queue_size = Ref{UInt32}(0)
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_QUEUE_MAX_SIZE, queue_size)
    @info "Queue Size: $(queue_size[])"

    queue = Ref{Ptr{hsa_queue_t}}()
    @check hsa_queue_create(agent, queue_size[], HSA_QUEUE_TYPE_SINGLE,
            C_NULL, C_NULL, typemax(UInt32), typemax(UInt32), queue)
    @info "Queue: $queue"

    machine_model = Ref{hsa_machine_model_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_MACHINE_MODEL,
            machine_model)
    @info "Machine Model: $(machine_model[])"

    profile = Ref{hsa_profile_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_PROFILE, profile)
    @info "Profile: $(profile[])"

    ext_module = Ref{hsa_ext_module_t}()
    if profile[] == HSA_PROFILE_BASE
      _ext_module = read("vector_copy_base.brig")
    else
      _ext_module = read("vector_copy_full.brig")
    end
    ext_module[] = reinterpret(Ptr{hsa_ext_module_t}, pointer(_ext_module))

    program = Ref{hsa_ext_program_t}()
    @check ccall(table_1_00[].hsa_ext_program_create, hsa_status_t,
        (hsa_machine_model_t, hsa_profile_t, hsa_default_float_rounding_mode_t,
            Cstring, Ptr{hsa_ext_program_t}),
        machine_model[], profile[], HSA_DEFAULT_FLOAT_ROUNDING_MODE_DEFAULT,
            C_NULL, program)
    @info "Created program"

    @check ccall(table_1_00[].hsa_ext_program_add_module, hsa_status_t,
        (hsa_ext_program_t, hsa_ext_module_t),
        program[], ext_module[])
    @info "Added BRIG module to program"

    hsa_isa = Ref{hsa_isa_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_ISA, hsa_isa)
    name = repeat(" ", 64)
    @check hsa_isa_get_info_alt(hsa_isa[], HSA_ISA_INFO_NAME, name)
    @info "Agent ISA Name: $name"

    control_directives = Ref{hsa_ext_control_directives_t}()
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        control_directives, 0, sizeof(hsa_ext_control_directives_t))
    code_object = Ref{hsa_code_object_t}()
    @check ccall(table_1_00[].hsa_ext_program_finalize, hsa_status_t,
        (hsa_ext_program_t, hsa_isa_t, Int32, hsa_ext_control_directives_t, Cstring, hsa_code_object_type_t, Ptr{hsa_code_object_t}),
        program[], hsa_isa[], 0, control_directives[], "", HSA_CODE_OBJECT_TYPE_PROGRAM, code_object);
    @info "Finalized program"

    @check ccall(table_1_00[].hsa_ext_program_destroy, hsa_status_t,
        (hsa_ext_program_t,),
        program[])
    @info "Destroyed program"

    executable = Ref{hsa_executable_t}();
    @check hsa_executable_create(profile[], HSA_EXECUTABLE_STATE_UNFROZEN, "",
            executable)
    @info "Created executable"

    @check hsa_executable_load_code_object(executable[], agent, code_object[], "")
    @info "Loaded code object"

    @check hsa_executable_freeze(executable[], "")
    @info "Froze executable"

    exec_symbol = Ref{hsa_executable_symbol_t}()
    @check hsa_executable_get_symbol(executable[], C_NULL, "&__vector_copy_kernel", agent, 0, exec_symbol)
    @info "Extracted symbol from executable"

    kernel_object = Ref{UInt64}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT, kernel_object)
    @info "Extracted symbol from executable"

    kernarg_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE, kernarg_segment_size)
    @info "Extracted kernarg segment size from executable"

    group_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE, group_segment_size)
    @info "Extracted group segment size from executable"

    private_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE, private_segment_size)
    @info "Extracted private segment from executable"

    signal = Ref{hsa_signal_t}()
    hsa_signal_create(1, 0, C_NULL, signal)
    @info "Created signal"

    finegrained_region = newref!(Ref{hsa_region_t}, typemax(UInt64))
    func = @cfunction(get_fine_grained_memory_region_cb, hsa_status_t,
            (hsa_region_t, Ptr{hsa_region_t}))
    hsa_agent_iterate_regions(agent, func, finegrained_region)
    @check (finegrained_region[].handle == typemax(UInt64)) ? HSA_STATUS_ERROR : HSA_STATUS_SUCCESS
    @info "Found a fine grained memory region"

    inp = Ref{Ptr{Nothing}}()
    @check hsa_memory_allocate(finegrained_region[], 1024*1024*4, inp)
    @info "Allocated argument memory for input parameter"
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        inp[], 1, 1024*1024*4)

    out = Ref{Ptr{Nothing}}()
    @check hsa_memory_allocate(finegrained_region[], 1024*1024*4, out)
    @info "Allocated argument memory for output parameter"
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        out[], 0, 1024*1024*4)

    args = KernelArgs(inp, out)

    # Find a memory region that supports kernel arguments
    kernarg_region = newref!(Ref{hsa_region_t}, typemax(UInt64))
    func = @cfunction(get_kernarg_memory_region_cb, hsa_status_t,
            (hsa_region_t, Ptr{hsa_region_t}))
    hsa_agent_iterate_regions(agent, func, kernarg_region)
    @check (kernarg_region[].handle == typemax(UInt64)) ? HSA_STATUS_ERROR : HSA_STATUS_SUCCESS
    @info "Found a kernarg memory region"

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    @check hsa_memory_allocate(kernarg_region[], kernarg_segment_size[], kernarg_address)
    @info "Allocated kernel argument memory buffer"
    ccall(:memcpy, Cvoid,
        (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
        kernarg_address[], Ref(args), sizeof(args))

    # Obtain the current queue write index
    index = hsa_queue_load_write_index_relaxed(queue[])
    @info "Got current queue write index"

    # Write the aql packet at the calculated queue index address
    header = Ref{UInt16}(0)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_ACQUIRE_FENCE_SCOPE)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_RELEASE_FENCE_SCOPE)
    header[] |= Int(HSA_PACKET_TYPE_KERNEL_DISPATCH) << Int(HSA_PACKET_HEADER_TYPE)
    # FIXME: __atomic_store_n((uint16_t*)(&dispatch_packet->header), header, __ATOMIC_RELEASE);

    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}()
    _packet = dispatch_packet[]
    @set! _packet.header = header[]
    @set! _packet.setup |= 1 << Int(HSA_KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
    @set! _packet.workgroup_size_x = 256
    @set! _packet.workgroup_size_y = 1
    @set! _packet.workgroup_size_z = 1
    @set! _packet.grid_size_x = 1024*1024
    @set! _packet.grid_size_y = 1
    @set! _packet.grid_size_z = 1
    @set! _packet.completion_signal = signal[]
    @set! _packet.kernel_object = kernel_object[]
    @set! _packet.kernarg_address = kernarg_address[]
    @set! _packet.private_segment_size = private_segment_size[]
    @set! _packet.group_segment_size = group_segment_size[]
    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}(_packet)

    _queue = unsafe_load(queue[])
    queueMask = UInt32(_queue.size - 1)
    baseaddr_ptr = Ptr{hsa_kernel_dispatch_packet_t}(_queue.base_address)
    baseaddr_ptr += sizeof(hsa_kernel_dispatch_packet_t) * (index & queueMask)
    dispatch_packet_ptr = Base.unsafe_convert(Ptr{hsa_kernel_dispatch_packet_t}, dispatch_packet)
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

    # Increment the write index and ring the doorbell to dispatch the kernel
    hsa_queue_store_write_index_relaxed(queue[], index+1)
    hsa_signal_store_relaxed(_queue.doorbell_signal, index)
    @info "Dispatched kernel"
    sleep(1)
    @info "Slept"

    # Wait on the dispatch completion signal until the kernel is finished
    value = Ref{hsa_signal_value_t}()
    value[] = hsa_signal_wait_acquire(signal[], HSA_SIGNAL_CONDITION_LT, 1, UINT64_MAX, HSA_WAIT_STATE_BLOCKED)
    @info "Kernel finished"

    # Validate the data in the output buffer
    valid = true
    fail_index = 0
    for i = 1:(1024*1024)
        if out[i] != in[i]
            fail_index = i
            valid = false
            break
        end
    end

    if valid
        @info "Passed validation"
    else
        @warn "VALIDATION FAILED!"
        @warn "Bad index: $fail_index"
    end

    # Clean-up time!
    @check hsa_memory_free(kernarg_address)
    @info "Freed kernel argument memory buffer"

    @check hsa_signal_destroy(signal)
    @info "Destroyed signal"

    @check hsa_executable_destroy(executable)
    @info "Destroyed executable"

    @check hsa_code_object_destroy(code_object)
    @info "Destroyed code object"

    @check hsa_queue_destroy(queue)
    @info "Destroyed queue"

    @check hsa_memory_free(in)
    @info "Freed in argument memory buffer"

    @check hsa_memory_free(out)
    @info "Freed out argument memory buffer"

    @check hsa_shut_down()
    @info "Shut down runtime"
end
main()
