# JIT compilation of Julia code to GCN

const to = Ref{TimerOutput}()

function timings!(new=TimerOutput())
  global to
  to[] = new
  return
end

include(joinpath("compiler", "common.jl"))
include(joinpath("compiler", "irgen.jl"))
include(joinpath("compiler", "optim.jl"))
include(joinpath("compiler", "validation.jl"))
include(joinpath("compiler", "rtlib.jl"))
include(joinpath("compiler", "mcgen.jl"))
include(joinpath("compiler", "debug.jl"))
include(joinpath("compiler", "driver.jl"))

function __init_compiler__()
    timings!()
end
