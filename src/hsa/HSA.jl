module HSA

include("LibHSARuntime.jl")

#=
const Agent = hsa_agent_t
const AgentInfo = hsa_agent_info_t
const BarrierAndPacket = hsa_barrier_and_packet_t
const BarrierOrPacket = hsa_barrier_or_packet_t
const CodeObjectReader = hsa_code_object_reader_t
const DefaultFloatRoundingMode = hsa_default_float_rounding_mode_t
const DeviceType = hsa_device_type_t
const Executable = hsa_executable_t
const ExecutableSymbol = hsa_executable_symbol_t
const ExecutableSymbolInfo = hsa_executable_symbol_info_t
const ISA = hsa_isa_t
const ISAInfo = hsa_isa_info_t
const KernelDispatchPacket = hsa_kernel_dispatch_packet_t
const KernelDispatchPacketSetup = hsa_kernel_dispatch_packet_setup_t
const PacketType = hsa_packet_type_t
const PointerInfo = hsa_amd_pointer_info_t
const Profile = hsa_profile_t
const Queue = hsa_queue_t
const QueueType = hsa_queue_type_t
const Region = hsa_region_t
const RegionGlobalFlag = hsa_region_global_flag_t
const RegionInfo = hsa_region_info_t
const RegionSegment = hsa_region_segment_t
const Signal = hsa_signal_t
const Status = hsa_status_t
const SymbolKind = hsa_symbol_kind_t

for enum in (AgentInfo,
             hsa_amd_agent_info_t,
             DefaultFloatRoundingMode,
             DeviceType,
             ExecutableSymbolInfo,
             hsa_fence_scope_t,
             KernelDispatchPacketSetup,
             ISAInfo,
             PacketType,
             Profile,
             QueueType,
             RegionGlobalFlag,
             RegionInfo,
             RegionSegment,
             Status,
             SymbolKind)
    for (name, _) in CEnum.name_value_pairs(enum)
        newname = Symbol(replace(string(name), "HSA_"=>""))
        @eval const $newname = $name
    end
end
=#

# Forward prefixed names
hsa_names = map(string, names(LibHSARuntime))
for name in filter(n->!(getproperty(LibHSARuntime, Symbol(n)) isa Function), hsa_names)
    newname = if endswith(name, "_s")
        continue
    elseif endswith(name, "_t")
        Symbol(replace(titlecase(replace(name[begin:end-2], "hsa_"=>"")), "_"=>"",
                                                                          "Amd"=>"AMD",
                                                                          "Isa"=>"ISA"))
    else
        Symbol(replace(name, "HSA_"=>""))
    end
    @eval const $newname = LibHSARuntime.$(Symbol(name))
end
for func in filter(n->startswith(n, "hsa_") && getproperty(LibHSARuntime, Symbol(n)) isa Function, hsa_names)
    newfunc = Symbol(replace(func, "hsa_"=>""))
    @eval const $newfunc = LibHSARuntime.$(Symbol(func))
end

end
