# Benchmark suite execution
using AMDGPU

using BenchmarkTools, Statistics, JSON

using Random, StableRNGs
rng = StableRNG(123)

# print system information
AMDGPU.versioninfo()

# convenience macro to create a benchmark that requires synchronizing the GPU.
# The setup runs before each sample (outside the timing window) to drain pending
# hipFreeAsync calls before the next allocation, preventing HIP memory pool
# exhaustion on discrete GPUs. This is load-bearing, not belt-and-braces: dropping
# it takes the pool to 25.7 GB on a 24 GiB card and the suite never finishes.
# See set_evals! below for why evals is not 1.
macro async_benchmarkable(ex...)
    quote
        @benchmarkable(AMDGPU.@sync($(ex...)), setup=collect_gpu_garbage())
    end
end

# only collect when the previous sample left garbage on the GPU. a collection idles
# the GPU long enough for it to power down, and evicts the working set from its
# caches, making the next evaluation up to twice as slow. benchmarks that do not
# allocate would otherwise measure a mix of such cold and warm evaluations, which
# made their results flip between levels from one run to the next.
const last_live = Ref(0)
function collect_gpu_garbage()
    AMDGPU.memory_stats().live > last_live[] && GC.gc(false)
    last_live[] = AMDGPU.memory_stats().live
    AMDGPU.synchronize()
end

# before anything else, run latency benchmarks. these spawn subprocesses, so we don't want
# to do so after regular benchmarks have caused the memory allocator to reserve memory.
@info "Running latency benchmarks"
latency_results = include("latency.jl")

SUITE = BenchmarkGroup()

include("amdgpu.jl")
include("kernel.jl")
include("array.jl")
include("gemm.jl")
include("stencil.jl")
include("applications.jl")

@info "Preparing main benchmarks"
# tune!() still grows the HIP memory pool ~10x (64 MiB -> 640 MiB) on discrete
# GPUs, and picks evals=1 for 65 of 69 benchmarks anyway since its criterion is
# timer resolution and every GPU benchmark is already far above it. Instead,
# warmup for compilation and fix evals explicitly.
warmup(SUITE; verbose=false)

# evals=4: the first evaluation after a GC in the `setup` above is slow (a post-GC
# hipMallocAsync, on a GPU that has gone idle), which at evals=1 inflates
# allocation-heavy benchmarks ~1.9x (accumulate/F32/dims=1L: 133us at evals=1 vs
# 70.5us at evals=4). At evals=4 three of four evals run in steady state, so the
# number reflects that rather than the GC's aftermath. The pool still stays flat at 96 MiB.
# Note evals=2 is the worst of both: a 50/50 slow/fast split puts the sample
# mean between the two levels, where it is maximally sensitive to the split.
function set_evals!(group::BenchmarkGroup, evals::Int=4)
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

@info "Running main benchmarks"
results = run(SUITE, verbose=true)

# integration tests (that need to be run last)
@info "Running integration benchmarks"
integration_results = BenchmarkGroup()
integration_results["volumerhs"] = include("volumerhs.jl")
integration_results["byval"] = include("byval.jl")

# the first part of every name is its category in the benchmark history: everything
# compiled (performance), fresh processes (latency), or larger codes (applications).
# see perf/benchmark-config.json
applications = BenchmarkGroup()
for (name, result) in results["applications"]
    applications[name] = result
end
applications["gemm"] = results["gemm"]
applications["stencil"] = results["stencil"]
for (name, result) in integration_results
    applications[name] = result
end
delete!(results, "applications"); delete!(results, "gemm"); delete!(results, "stencil")
results = BenchmarkGroup("performance" => results, "latency" => latency_results,
                         "applications" => applications)

# every statistic of every benchmark, and the environment they were measured in, for the
# benchmark history at https://juliagpu.org/perf/. times are in nanoseconds.
# the history compares the minimum rather than the median (perf/benchmark-config.json): at
# the sub-microsecond scale of many of these benchmarks, OS scheduler jitter dominates the
# median and produces 5-15% trial-to-trial variance, while the minimum reflects the
# un-preempted code path and is stable to <1% across trials.
function export_results(file, results)
    benchmarks = Dict{String,Any}()
    for (keys, trial) in BenchmarkTools.leaves(results)
        times = trial.times
        benchmarks[join(keys, "/")] = Dict(
            "min" => minimum(times), "p25" => quantile(times, 0.25),
            "median" => median(times), "p75" => quantile(times, 0.75),
            "mean" => mean(times), "max" => maximum(times),
            "std" => length(times) > 1 ? std(times) : nothing,
            "gctime" => median(trial.gctimes),
            "memory" => trial.memory, "allocs" => trial.allocs,
            "samples" => length(times), "evals" => trial.params.evals)
    end
    # the versions of every package loaded, to explain changes the commit itself does not
    packages = Dict(id.name => string(pkgversion(mod)) for (id, mod) in Base.loaded_modules
                    if pkgversion(mod) !== nothing)
    dev = AMDGPU.device()
    env = Dict(
        "julia" => string(VERSION),
        "gpu" => "$(AMDGPU.HIP.name(dev)) ($(AMDGPU.HIP.gcn_arch(dev)))",
        "runtime" => string(AMDGPU.HIP.runtime_version()),
        "cpu" => Sys.cpu_info()[1].model,
        "os" => readchomp(`uname -sr`),
        "threads" => Threads.nthreads(),
        "agent" => get(ENV, "BUILDKITE_AGENT_NAME", nothing),
        "package" => string(pkgversion(AMDGPU)),
        "packages" => packages)
    open(file, "w") do io
        JSON.print(io, Dict("version" => 2, "env" => env, "benchmarks" => benchmarks))
    end
end
export_results(length(ARGS) >= 1 ? ARGS[1] : "benchmarks.json", results)
