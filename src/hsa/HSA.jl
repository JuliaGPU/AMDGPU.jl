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

end
