using Base.BinaryPlatforms

function rocm_arch()
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

function rocm_arch_string(target::Integer)
    patch = lowercase(string(target % 100, base = 16))
    return "gfx$(div(target, 10000))$(div(target, 100) % 100)$(patch)"
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
            isxdigit(arch_char) || return false
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
