# Benchmark suite execution
using AMDGPU

using BenchmarkTools

using Random, StableRNGs
rng = StableRNG(123)

# print system information
AMDGPU.versioninfo()

# convenience macro to create a benchmark that requires synchronizing the GPU.
# The setup=(GC+sync) runs before each sample (outside the timing window) to
# drain pending hipFreeAsync calls before the next allocation, preventing
# HIP memory pool exhaustion on discrete GPUs.
macro async_benchmarkable(ex...)
    quote
        @benchmarkable(AMDGPU.@sync($(ex...)),
                       setup=(GC.gc(false); AMDGPU.synchronize()))
    end
end

# before anything else, run latency benchmarks. these spawn subprocesses, so we don't want
# to do so after regular benchmarks have caused the memory allocator to reserve memory.
@info "Running latency benchmarks"
latency_results = include("latency.jl")

SUITE = BenchmarkGroup()

include("amdgpu.jl")
include("kernel.jl")
include("array.jl")

@info "Preparing main benchmarks"
# tune!() uses a strategy that exhausts the HIP memory pool on discrete GPUs.
# Instead, warmup for compilation and fix evals=1: one GPU round-trip per sample.
warmup(SUITE; verbose=false)

function set_evals!(group::BenchmarkGroup, evals::Int=1)
    for (_, b) in group
        if b isa BenchmarkGroup
            set_evals!(b, evals)
        else
            b.params.evals = evals
        end
    end
end
set_evals!(SUITE)

# reclaim memory that might have been used by the tuning process
GC.gc(true)
AMDGPU.reclaim()

# benchmark groups that aren't part of the suite
addgroup!(SUITE, "integration")

@info "Running main benchmarks"
results = run(SUITE, verbose=true)

# integration tests (that need to be run last)
@info "Running integration benchmarks"
integration_results = BenchmarkGroup()
integration_results["volumerhs"] = include("volumerhs.jl")
integration_results["byval"] = include("byval.jl")

results["latency"] = latency_results
results["integration"] = integration_results

# write out the results
# we report the minimum rather than the median: at the sub-microsecond scale of many
# of these benchmarks, OS scheduler jitter dominates the median and produces 5-15%
# trial-to-trial variance, while the minimum reflects the un-preempted code path
# and is stable to <1% across trials. real regressions still show up in the minimum.
result_file = length(ARGS) >= 1 ? ARGS[1] : "benchmarkresults.json"
BenchmarkTools.save(result_file, minimum(results))
