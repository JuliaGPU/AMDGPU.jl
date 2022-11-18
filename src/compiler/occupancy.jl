import ObjectFile
import ObjectFile: readmeta, Sections, section_name, section_size, section_offset
import MsgPack

const OCCUPANCY_CACHE = Dict{Tuple{String, Int, Int}, NamedTuple}()
const OCCUPANCY_CACHE_LOCK = Threads.ReentrantLock()

function read_metadata(fun::ROCFunction)
    path, io = mktemp(; cleanup=false)
    write(io, fun.mod.exe.data)
    close(io)
    mv(path, path*".exe") # so that readmeta knows that this is an ELF file
    path = path * ".exe"
    try
        return open(path, "r") do io
            elf = readmeta(io)
            note_sec_idx = findfirst(sec->section_name(sec) == ".note", Sections(elf))
            note_sec = Sections(elf)[note_sec_idx]
            note_sec_size = section_size(note_sec)

            seek(io, section_offset(note_sec))
            off = position(io)
            while position(io) - off < note_sec_size
                name_size = read(io, UInt32)
                desc_size = read(io, UInt32)
                note_type = read(io, UInt32)
                if note_type != 0x20 # NT_AMDGPU_METADATA
                    # Skip this note
                    seek(io, position(io) + name_size + 1 + desc_size)
                    continue
                end
                name = readuntil(io, '\0'); read(io, UInt8)
                desc = Vector{UInt8}(undef, desc_size)
                readbytes!(io, desc)
                return MsgPack.unpack(desc)
            end
        end
    finally
        rm(path)
    end
    return nothing
end

function calculate_occupancy(fun::ROCFunction, device::ROCDevice; input_block_size=1, dynamic_localmem=0)
    lock(OCCUPANCY_CACHE_LOCK) do
        get!(OCCUPANCY_CACHE, (fun.entry, input_block_size, dynamic_localmem)) do
            _calculate_occupancy(fun, device; input_block_size, dynamic_localmem)
        end
    end
end
calculate_occupancy(kernel::Runtime.HostKernel; input_block_size=1, dynamic_localmem=0) =
    calculate_occupancy(kernel.fun, kernel.mod.exe.device; input_block_size, dynamic_localmem)
function _calculate_occupancy(fun::ROCFunction, device::ROCDevice; input_block_size, dynamic_localmem)
    # Calculate occupancy
    # Copied from https://github.com/ROCm-Developer-Tools/hipamd/blob/3ec1ccdbbbee7090ba854eddd1dee281973a4498/src/hip_platform.cpp#L301
    isa = first(Runtime.isas(device))
    if input_block_size == 1
        # We assume the user is requesting groupsize optimization
        input_block_size = Runtime.isa_workgroup_max_size(isa)
    end
    workgroup_size = Runtime.isa_workgroup_max_size(isa)
    arch = Runtime.architecture(isa)
    arch_major, arch_minor, arch_stepping = if startswith(arch, "gfx8")
        8, parse(Int, "0x"*arch[5]), parse(Int, "0x"*arch[6:end])
    elseif startswith(arch, "gfx9")
        9, parse(Int, "0x"*arch[5]), parse(Int, "0x"*arch[6:end])
    elseif startswith(arch, "gfx10")
        10, parse(Int, "0x"*arch[6]), parse(Int, "0x"*arch[7:end])
    elseif startswith(arch, "gfx11")
        11, parse(Int, "0x"*arch[6]), parse(Int, "0x"*arch[7:end])
    else
        error("Unsupported architecture: $arch")
    end
    meta = read_metadata(fun)
    kernel_idx = findfirst(k->startswith(k[".symbol"], fun.entry), meta["amdhsa.kernels"])
    kernel = meta["amdhsa.kernels"][kernel_idx]
    SGPR_count = Int(kernel[".sgpr_count"])
    VGPR_count = Int(kernel[".vgpr_count"])
    LDS_size = Int(kernel[".group_segment_fixed_size"])
    wavefront_size = Int(kernel[".wavefront_size"])
    # TODO: Print signature
    @debug "Calculating occupancy of $(fun.entry) for $arch ($arch_major, $arch_minor, $arch_stepping)" SGPR_count VGPR_count LDS_size
    max_waves_per_SIMD = arch_major <= 9 ? 8 : 16
    VGPR_waves = max_waves_per_SIMD
    local max_VGPRs, VGPR_granularity
    if arch_major <= 9
        if arch == "gfx90a"
            max_VGPRs = 512
            VGPR_granularity = 8
        else
            max_VGPRs = 256
            VGPR_granularity = 4
        end
    else
        max_VGPRs = 1024
        VGPR_granularity = 8
    end

    align_up(x, y) = x + y-rem(x, y)
    if VGPR_count > 0
        VGPR_waves = max_VGPRs ÷ align_up(VGPR_count, VGPR_granularity)
    end

    GPR_waves = VGPR_waves
    if SGPR_count > 0
        max_SGPRs = if arch_major < 8
            512
        elseif arch_major < 10
            800
        else
            typemax(Int64)
        end
        SGPR_waves = max_SGPRs ÷ align_up(SGPR_count, 16)
        GPR_waves = min(VGPR_waves, SGPR_waves)
    end

    alu_occupancy = Runtime.device_num_simds_per_compute_unit(device) * min(max_waves_per_SIMD, GPR_waves)
    alu_limited_threads = alu_occupancy * wavefront_size

    LDS_occupancy_wgs = typemax(Int)
    total_used_LDS = LDS_size + dynamic_localmem
    if total_used_LDS != 0
        LDS_occupancy_wgs = Runtime.device_local_memory_size(device) ÷ total_used_LDS
    end

    # Calculate how many blocks of inputBlockSize we can fit per CU
    max_blocks_per_CU = alu_limited_threads ÷ align_up(input_block_size, wavefront_size)
    max_blocks_per_CU = min(max_blocks_per_CU, LDS_occupancy_wgs)
    best_block_size = Int(min(alu_limited_threads, align_up(input_block_size, wavefront_size)))
    best_block_size = min(best_block_size, AMDGPU.Device._max_group_size)
    best_blocks_per_CU = alu_limited_threads ÷ best_block_size
    num_blocks_per_grid = Runtime.device_num_compute_units(device) * min(best_blocks_per_CU, LDS_occupancy_wgs)

    # TODO: Print signature
    @debug "Occupancy of $(fun.entry) for $arch ($arch_major, $arch_minor, $arch_stepping)" max_blocks_per_CU best_block_size best_blocks_per_CU num_blocks_per_grid
    return (;max_blocks_per_CU,
             best_block_size,
             best_blocks_per_CU,
             num_blocks_per_grid,
             SGPR_count,
             VGPR_count,
             LDS_size,
             wavefront_size)
end
