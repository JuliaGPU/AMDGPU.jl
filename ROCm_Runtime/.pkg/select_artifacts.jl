push!(Base.LOAD_PATH, dirname(@__DIR__))

using TOML, Artifacts, Base.BinaryPlatforms
include("./platform_augmentation.jl")
artifacts_toml = joinpath(dirname(@__DIR__), "Artifacts.toml")

# Update Base.parse to support riscv64, needed for Julia <1.12
@static if !haskey(BinaryPlatforms.arch_mapping, "riscv64")

    BinaryPlatforms.arch_mapping["riscv64"] = "(rv64|riscv64)"

    function bbparse(::Type{Platform}, triplet::AbstractString; validate_strict::Bool = false)
        arch_mapping = BinaryPlatforms.arch_mapping
        os_mapping = BinaryPlatforms.os_mapping
        libc_mapping = BinaryPlatforms.libc_mapping
        call_abi_mapping = BinaryPlatforms.call_abi_mapping
        libgfortran_version_mapping = BinaryPlatforms.libgfortran_version_mapping
        cxxstring_abi_mapping = BinaryPlatforms.cxxstring_abi_mapping
        libstdcxx_version_mapping = BinaryPlatforms.libstdcxx_version_mapping
    
        # Helper function to collapse dictionary of mappings down into a regex of
        # named capture groups joined by "|" operators
        c(mapping) = string("(",join(["(?<$k>$v)" for (k, v) in mapping], "|"), ")")
    
        # We're going to build a mondo regex here to parse everything:
        triplet_regex = Regex(string(
            "^",
            # First, the core triplet; arch/os/libc/call_abi
            c(arch_mapping),
            c(os_mapping),
            c(libc_mapping),
            c(call_abi_mapping),
            # Next, optional things, like libgfortran/libstdcxx/cxxstring abi
            c(libgfortran_version_mapping),
            c(cxxstring_abi_mapping),
            c(libstdcxx_version_mapping),
            # Finally, the catch-all for extended tags
            "(?<tags>(?:-[^-]+\\+[^-]+)*)?",
            "\$",
        ))
    
        m = match(triplet_regex, triplet)
        if m !== nothing
            # Helper function to find the single named field within the giant regex
            # that is not `nothing` for each mapping we give it.
            get_field(m, mapping) = begin
                for k in keys(mapping)
                    if m[k] !== nothing
                        # Convert our sentinel `nothing` values to actual `nothing`
                        if endswith(k, "_nothing")
                            return nothing
                        end
                        # Convert libgfortran/libstdcxx version numbers
                        if startswith(k, "libgfortran")
                            return VersionNumber(parse(Int,k[12:end]))
                        elseif startswith(k, "libstdcxx")
                            return VersionNumber(3, 4, parse(Int,m[k][11:end]))
                        else
                            return k
                        end
                    end
                end
            end
    
            # Extract the information we're interested in:
            arch = get_field(m, arch_mapping)
            os = get_field(m, os_mapping)
            libc = get_field(m, libc_mapping)
            call_abi = get_field(m, call_abi_mapping)
            libgfortran_version = get_field(m, libgfortran_version_mapping)
            libstdcxx_version = get_field(m, libstdcxx_version_mapping)
            cxxstring_abi = get_field(m, cxxstring_abi_mapping)
            function split_tags(tagstr)
                tag_fields = filter(!isempty, split(tagstr, "-"))
                if isempty(tag_fields)
                    return Pair{String,String}[]
                end
                return map(v -> Symbol(v[1]) => v[2], split.(tag_fields, "+"))
            end
            tags = split_tags(m["tags"])
    
            # Special parsing of os version number, if any exists
            function extract_os_version(os_name, pattern)
                m_osvn = match(pattern, m[os_name])
                if m_osvn !== nothing
                    return VersionNumber(m_osvn.captures[1])
                end
                return nothing
            end
            os_version = nothing
            if os == "macos"
                os_version = extract_os_version("macos", r".*darwin([\d.]+)"sa)
            end
            if os == "freebsd"
                os_version = extract_os_version("freebsd", r".*freebsd([\d.]+)"sa)
            end
            if os == "openbsd"
                os_version = extract_os_version("openbsd", r".*openbsd([\d.]+)"sa)
            end
    
            return Platform(
                arch, os;
                validate_strict,
                libc,
                call_abi,
                libgfortran_version,
                cxxstring_abi,
                libstdcxx_version,
                os_version,
                tags...,
            )
        end
        throw(ArgumentError("Platform `$(triplet)` is not an officially supported platform"))
    end

else
    # riscv64 is supported, all is fine

    const bbparse = parse

end


# Get "target triplet" from ARGS, if given (defaulting to the host triplet otherwise)
target_triplet = get(ARGS, 1, Base.BinaryPlatforms.host_triplet())

# Augment this platform object with any special tags we require
platform = augment_platform!(HostPlatform(bbparse(Platform, target_triplet)))

# Select all downloadable artifacts that match that platform
artifacts = select_downloadable_artifacts(artifacts_toml; platform, include_lazy=true)

# Output the result to `stdout` as a TOML dictionary
TOML.print(stdout, artifacts)
