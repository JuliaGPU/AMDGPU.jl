@testitem "core" setup=[TSCore] begin

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

AMDGPU.allowscalar(false)

macro grab_output(ex, io=stdout)
    quote
        mktemp() do fname, fout
            ret = nothing
            open(fname, "w") do fout
                if $io == stdout
                    redirect_stdout(fout) do
                        ret = $(esc(ex))
                    end
                elseif $io == stderr
                    redirect_stderr(fout) do
                        ret = $(esc(ex))
                    end
                end
            end
            ret, read(fname, String)
        end
    end
end

include("hsa/utils.jl")
include("hsa/getinfo.jl")
include("hsa/device.jl")

include("codegen/synchronization.jl")
include("codegen/trap.jl")

include("tls.jl")
include("rocarray/base.jl")
include("rocarray/broadcast.jl")

end
