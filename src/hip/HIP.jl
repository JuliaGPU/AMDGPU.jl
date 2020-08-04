module HIP

import ..AMDGPU.libhip
using CEnum

include("libhip_common.jl")
include("error.jl")
include("libhip.jl")

end
