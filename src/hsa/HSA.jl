module HSA

include("LibHSARuntime.jl")

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

function version()
    major_ref = Ref{Cushort}(typemax(Cushort))
    minor_ref = Ref{Cushort}(typemax(Cushort))
    major_status = system_get_info(SYSTEM_INFO_VERSION_MAJOR, major_ref)
    minor_status = system_get_info(SYSTEM_INFO_VERSION_MINOR, minor_ref)
    if major_status != STATUS_SUCCESS || minor_status != STATUS_SUCCESS
        @warn "Failed to detect HSA version: $major_status"
        return v"0"
    end
    return VersionNumber(major_ref[], minor_ref[])
end

end
