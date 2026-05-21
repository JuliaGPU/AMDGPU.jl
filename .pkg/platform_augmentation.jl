using Base.BinaryPlatforms, Libdl

function rocm_arch_string(target::Integer)
    patch = lowercase(string(target % 100, base = 16))
    return "gfx$(div(target, 10000))$(div(target, 100) % 100)$(patch)"
end

function rocm_arch_from_device_name(device_name::AbstractString)
    device_lower = lowercase(device_name)

    if !occursin("radeon", device_lower) && !occursin("amd", device_lower)
        return ""
    end

    # STX Halo iGPUs (gfx1151 architecture)
    # Radeon 8050S Graphics / Radeon 8060S Graphics
    if occursin("8050s", device_lower) ||
       occursin("8060s", device_lower) ||
       occursin("device 1586", device_lower)
        return "gfx1151"
    end

    # STX Point iGPUs (gfx1150 architecture)
    # Radeon 880M / 890M Graphics
    if occursin("880m", device_lower) ||
       occursin("890m", device_lower)
        return "gfx1150"
    end

    # RDNA4 GPUs (gfx120X architecture)
    # AMD Radeon AI PRO R9700, AMD Radeon RX 9070 XT, AMD Radeon RX 9070 GRE,
    # AMD Radeon RX 9070, AMD Radeon RX 9060 XT
    if occursin("r9700", device_lower) ||
       occursin("9060", device_lower) ||
       occursin("9070", device_lower)
        return "gfx120X"
    end

    # RDNA3 GPUs (gfx110X architecture)
    # AMD Radeon PRO V710, AMD Radeon PRO W7900 Dual Slot, AMD Radeon PRO W7900,
    # AMD Radeon PRO W7800 48GB, AMD Radeon PRO W7800, AMD Radeon PRO W7700,
    # AMD Radeon RX 7900 XTX, AMD Radeon RX 7900 XT, AMD Radeon RX 7900 GRE,
    # AMD Radeon RX 7800 XT, AMD Radeon RX 7700 XT
    if occursin("7700", device_lower) ||
       occursin("7800", device_lower) ||
       occursin("7900", device_lower) ||
       occursin("v710", device_lower)
        return "gfx110X"
    end

    # RDNA2 GPUs (gfx103X architecture)
    # AMD Radeon RX 6800 XT, AMD Radeon RX 6800, AMD Radeon RX 6700 XT,
    # AMD Radeon RX 6700, AMD Radeon RX 6600 XT, AMD Radeon RX 6600,
    # AMD Radeon RX 6500 XT, AMD Radeon RX 6500
    if occursin("6800", device_lower) ||
       occursin("6700", device_lower) ||
       occursin("6600", device_lower) ||
       occursin("6500", device_lower)
        return "gfx103X"
    end

    return ""
end

function rocm_arch_linux()
    topology_root = "/sys/class/kfd/kfd/topology/nodes/"
    isdir(topology_root) || return String[]

    arch = String[]
    for dir in readdir(topology_root; join = true)
        props = joinpath(dir, "properties")
        isfile(props) || continue

        for s in eachline(props)
            m = match(r"^gfx_target_version (\d+)$", s)
            m === nothing && continue

            target = parse(Int, m[1])
            target == 0 && continue

            push!(arch, rocm_arch_string(target))
        end
    end

    unique!(arch)
    sort!(arch; rev = true)
    return arch
end

function wmi_query_video_controllers()
    ole32    = Libdl.dlopen("ole32.dll")
    oleaut32 = Libdl.dlopen("oleaut32.dll")

    CoInitializeEx      = Libdl.dlsym(ole32,    :CoInitializeEx)
    CoInitializeSecurity = Libdl.dlsym(ole32,   :CoInitializeSecurity)
    CoCreateInstance    = Libdl.dlsym(ole32,    :CoCreateInstance)
    CoUninitialize      = Libdl.dlsym(ole32,    :CoUninitialize)
    SysAllocString      = Libdl.dlsym(oleaut32, :SysAllocString)
    SysFreeString       = Libdl.dlsym(oleaut32, :SysFreeString)

    # Helper: allocate a BSTR from a Julia string
    function bstr(s::String)
        ws = transcode(UInt16, s * "\0")
        ccall(SysAllocString, Ptr{UInt16}, (Ptr{UInt16},), ws)
    end
    free_bstr(p) = ccall(SysFreeString, Cvoid, (Ptr{UInt16},), p)

    # Helper: read a BSTR pointer back to Julia String
    function read_bstr(p::Ptr{UInt16})
        p == C_NULL && return ""
        # BSTR length (in bytes) is stored 4 bytes before the pointer
        nbytes = unsafe_load(Ptr{UInt32}(p - 4))
        nchars = nbytes ÷ 2
        buf = unsafe_wrap(Array, p, nchars; own=false)
        transcode(String, buf)
    end

    # CLSID_WbemLocator  = {4590F811-1D3A-11D0-891F-00AA004B2E24}
    # IID_IWbemLocator   = {DC12A687-737F-11CF-884D-00AA004B2E24}
    CLSID_WbemLocator = UInt8[
        0x11, 0xF8, 0x90, 0x45,  # Data1 (little-endian)
        0x3A, 0x1D,              # Data2 (little-endian)
        0xD0, 0x11,              # Data3 (little-endian)
        0x89, 0x1F, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]

    IID_IWbemLocator = UInt8[
        0x87, 0xA6, 0x12, 0xDC,
        0x7F, 0x73,
        0xCF, 0x11,
        0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]

    # Step 1: CoInitializeEx(0, COINIT_MULTITHREADED=0)
    ccall(CoInitializeEx, Clong, (Ptr{Cvoid}, Culong), C_NULL, 0)

    # Step 2: CoInitializeSecurity(NULL, -1, NULL, NULL,
    #           RPC_C_AUTHN_LEVEL_DEFAULT=0, RPC_C_IMP_LEVEL_IMPERSONATE=3,
    #           NULL, EOAC_NONE=0, NULL)
    ccall(CoInitializeSecurity, Clong,
        (Ptr{Cvoid}, Clong, Ptr{Cvoid}, Ptr{Cvoid},
         Culong, Culong, Ptr{Cvoid}, Culong, Ptr{Cvoid}),
        C_NULL, -1, C_NULL, C_NULL, 0, 3, C_NULL, 0, C_NULL)

    # Step 3: CoCreateInstance(&CLSID_WbemLocator, 0, CLSCTX_INPROC_SERVER=1,
    #                          &IID_IWbemLocator, &locator)
    locator = Ref{Ptr{Cvoid}}(C_NULL)
    hr = ccall(CoCreateInstance, Clong,
        (Ptr{UInt8}, Ptr{Cvoid}, Culong, Ptr{UInt8}, Ref{Ptr{Cvoid}}),
        CLSID_WbemLocator, C_NULL, 1, IID_IWbemLocator, locator)
    hr < 0 && error("CoCreateInstance failed: 0x$(string(hr % UInt32, base=16))")

    # vtable layout for IWbemLocator (inherits IUnknown):
    #   [0] QueryInterface  [1] AddRef  [2] Release  [3] ConnectServer
    vtbl_loc = unsafe_load(Ptr{Ptr{Ptr{Cvoid}}}(locator[]))

    resource = bstr("ROOT\\CIMV2")
    services = Ref{Ptr{Cvoid}}(C_NULL)
    # Step 4: locator->ConnectServer(locator, resource, NULL,NULL,NULL,0,NULL,NULL, &services)
    hr = ccall(unsafe_load(vtbl_loc, 4), Clong,
        (Ptr{Cvoid}, Ptr{UInt16}, Ptr{Cvoid}, Ptr{Cvoid},
         Ptr{Cvoid}, Clong, Ptr{Cvoid}, Ptr{Cvoid}, Ref{Ptr{Cvoid}}),
        locator[], resource, C_NULL, C_NULL, C_NULL, 0, C_NULL, C_NULL, services)
    hr < 0 && error("ConnectServer failed: 0x$(string(hr % UInt32, base=16))")

    # vtable layout for IWbemServices — ExecQuery is at index 20 (0-based)
    vtbl_svc = unsafe_load(Ptr{Ptr{Ptr{Cvoid}}}(services[]))

    language = bstr("WQL")
    query    = bstr("SELECT Name FROM Win32_VideoController")
    results  = Ref{Ptr{Cvoid}}(C_NULL)
    # Step 5: services->ExecQuery(services, language, query,
    #           WBEM_FLAG_BIDIRECTIONAL=0, NULL, &results)
    hr = ccall(unsafe_load(vtbl_svc, 21), Clong,  # 0-based index 20 -> 1-based 21
        (Ptr{Cvoid}, Ptr{UInt16}, Ptr{UInt16}, Clong, Ptr{Cvoid}, Ref{Ptr{Cvoid}}),
        services[], language, query, 0, C_NULL, results)
    hr < 0 && error("ExecQuery failed: 0x$(string(hr % UInt32, base=16))")

    # vtable layout for IEnumWbemClassObject:
    #   [0] QI  [1] AddRef  [2] Release  [3] Reset  [4] Next  [5] NextAsync  [6] Clone  [7] Skip
    vtbl_enum = unsafe_load(Ptr{Ptr{Ptr{Cvoid}}}(results[]))

    # vtable layout for IWbemClassObject::Get is at index 4 (0-based)
    #   [0] QI  [1] AddRef  [2] Release  [3] GetQualifierSet  [4] Get  ...

    names = String[]
    while true
        result   = Ref{Ptr{Cvoid}}(C_NULL)
        returned = Ref{Culong}(0)

        # results->Next(results, WBEM_INFINITE=-1, 1, &result, &returned)
        hr = ccall(unsafe_load(vtbl_enum, 5), Clong,  # Next at 0-based 4 -> 1-based 5
            (Ptr{Cvoid}, Clong, Culong, Ref{Ptr{Cvoid}}, Ref{Culong}),
            results[], -1, 1, result, returned)
        (hr != 0 || returned[] == 0) && break  # S_FALSE or no more objects

        vtbl_obj = unsafe_load(Ptr{Ptr{Ptr{Cvoid}}}(result[]))

        # VARIANT is 16 bytes: vt(2) + reserved(6) + value(8)
        variant = zeros(UInt8, 16)
        prop    = bstr("Name")

        # result->Get(result, L"Name", 0, &variant, NULL, NULL)
        hr = ccall(unsafe_load(vtbl_obj, 5), Clong,  # Get at 0-based 4 -> 1-based 5
            (Ptr{Cvoid}, Ptr{UInt16}, Clong, Ptr{UInt8}, Ptr{Cvoid}, Ptr{Cvoid}),
            result[], prop, 0, variant, C_NULL, C_NULL)

        if hr == 0
            vt = reinterpret(UInt16, variant[1:2])[1]
            if vt == 8  # VT_BSTR
                p = reinterpret(UInt64, variant[9:16])[1]
                push!(names, read_bstr(Ptr{UInt16}(p)))
            end
        end

        free_bstr(prop)
        ccall(unsafe_load(vtbl_obj, 3), Culong, (Ptr{Cvoid},), result[])  # Release
    end

    # Cleanup — mirrors the C example exactly
    ccall(unsafe_load(vtbl_enum, 3), Culong, (Ptr{Cvoid},), results[])   # results->Release
    ccall(unsafe_load(vtbl_svc,  3), Culong, (Ptr{Cvoid},), services[])  # services->Release
    ccall(unsafe_load(vtbl_loc,  3), Culong, (Ptr{Cvoid},), locator[])   # locator->Release
    ccall(CoUninitialize, Cvoid, ())
    free_bstr(query); free_bstr(language); free_bstr(resource)

    return names
end

function rocm_arch()
    if Sys.islinux()
        return rocm_arch_linux()
    elseif Sys.iswindows()
        arch = map(rocm_arch_from_device_name, wmi_query_video_controllers())
        filter!(!isempty, arch)
        unique!(arch)
        sort!(arch; rev = true)
        return arch
    end

    return String[]
end

function rocm_arch_comparison_strategy(a::String, b::String, a_requested::Bool, b_requested::Bool)
    a == "none" && return false
    b == "none" && return false

    a_arches = split(a, ',')
    b_arches = split(b, ',')
    for a_arch in a_arches
        for b_arch in b_arches
            rocm_arch_matches(a_arch, b_arch) && return true
            rocm_arch_matches(b_arch, a_arch) && return true
        end
    end
    return false
end

function rocm_arch_core(arch::AbstractString)
    return match(r"gfx(.*)", first(split(arch, r"[_-]", limit = 2)))[1]
end

function rocm_arch_matches(pattern::AbstractString, arch::AbstractString)
    pattern = rocm_arch_core(pattern)
    arch = rocm_arch_core(arch)

    length(pattern) == length(arch) || return false
    for (pattern_char, arch_char) in zip(pattern, arch)
        if lowercase(pattern_char) == 'x'
            isxdigit(arch_char) || lowercase(arch_char) == 'x' || return false
        elseif pattern_char != arch_char
            return false
        end
    end
    return true
end

function augment_platform!(platform::Platform)
    if !haskey(platform, "rocm_arch")
        arch = rocm_arch()
        platform["rocm_arch"] = isempty(arch) ? "none" : join(arch, ',')
    end

    BinaryPlatforms.set_compare_strategy!(platform, "rocm_arch", rocm_arch_comparison_strategy)

    return platform
end
