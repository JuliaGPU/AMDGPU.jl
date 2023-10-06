@testitem "ext" setup=[TSCore] begin
    AMDGPU.allowscalar(false)
    include("external/forwarddiff.jl")
end
