module AMDGPUSpecialFunctionsExt

# Device-side overrides mapping SpecialFunctions.jl functions to OCML intrinsics.
# Kept in an extension (like CUDA.jl) so that `using AMDGPU` does not pay the
# load-time cost of SpecialFunctions and its dependencies unless they are needed.

import AMDGPU
import AMDGPU.Device: @device_override, fntypes, DEFINED_SF_INTRINSICS
import SpecialFunctions

for jltype in (Float64, Float32, Float16)
    type_suffix = fntypes[jltype]
    for (fname, intrinsic) in DEFINED_SF_INTRINSICS
        @eval @device_override SpecialFunctions.$(fname)(x::$jltype) = ccall(
            $("extern __ocml_$(intrinsic)_$(type_suffix)"), llvmcall, $jltype, ($jltype,), x)
    end
end

end
