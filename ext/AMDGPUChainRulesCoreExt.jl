module AMDGPUChainRulesCoreExt

using AMDGPU: ROCArray

import ChainRulesCore

ChainRulesCore.is_inplaceable_destination(::ROCArray) = true

end
