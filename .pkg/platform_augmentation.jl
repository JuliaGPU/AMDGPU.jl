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

            push!(arch, "gfx$(div(target, 10000))$(div(target, 100) % 100)$(target % 100)")
        end
    end

    unique!(arch)
    sort!(arch; rev = true)
    return arch
end

function rocm_arch_comparison_strategy(a::String, b::String, a_requested::Bool, b_requested::Bool)
    a == "none" && return false
    b == "none" && return false

    a_arches = split(a, ',')
    b_arches = split(b, ',')
    for arch in a_arches
        arch in b_arches && return true
    end
    return false
end

function augment_platform!(platform::Platform)
    if !haskey(platform, "rocm_arch")
        arch = rocm_arch()
        platform["rocm_arch"] = isempty(arch) ? "none" : join(arch, ',')
    end

    BinaryPlatforms.set_compare_strategy!(platform, "rocm_arch", rocm_arch_comparison_strategy)

    return platform
end
