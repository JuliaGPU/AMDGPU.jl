using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import AMDGPU.Device: HostCallHolder, hostcall!

using ParallelTestRunner
using Test

import Pkg
import InteractiveUtils

AMDGPU.allowscalar(false)

# Force 4 workers if running on buildkite
if parse(Bool, get(ENV, "BUILDKITE", "false"))
    jobs_pos = findfirst(arg -> startswith(arg, "--jobs"), ARGS)
    if isnothing(jobs_pos)
        push!(ARGS, "--jobs=4")
    end
end

# Force 4 workers if running on machine with <= 32GB RAM and not on CI
jobs_pos = findfirst(arg -> startswith(arg, "--jobs"), ARGS)
if isnothing(jobs_pos) && (Sys.total_memory() <= 32*2^30)
    push!(ARGS, "--jobs=4")
end

@info "System information:\n"
InteractiveUtils.versioninfo()

AMDGPU.versioninfo()

# Autodiscovered tests
testsuite = find_tests(@__DIR__)

## GPUArrays test suite
import GPUArrays
gpuarrays = pathof(GPUArrays)
gpuarrays_root = dirname(dirname(gpuarrays))
gpuarrays_testsuite = joinpath(gpuarrays_root, "test", "testsuite.jl")
include(gpuarrays_testsuite)
for name in keys(TestSuite.tests)
    testsuite["gpuarrays/$name"] = :(TestSuite.tests[$name](ROCArray))
end

args = parse_args(ARGS)

# Don't run Enzyme tests by default
if filter_tests!(testsuite, args)
    delete!(testsuite, "enzyme_tests")
end

if any(name -> startswith(name, "enzyme"), keys(testsuite))
    @info "Running Enzyme tests\n"
    Pkg.add(["EnzymeCore", "Enzyme"])
end

# Hostcall tests must run on main thread (not in parallel workers)
delete!(testsuite, "device/hostcall")
delete!(testsuite, "device/output")

# Code to run in each test's sandbox module before running the test
init_code = quote
    import GPUArrays
    include($gpuarrays_testsuite)
    testf(f, xs...; kwargs...) = TestSuite.compare(f, ROCArray, xs...; kwargs...)

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
end

runtests(AMDGPU, args; testsuite, init_code)

# Hostcall tests must run on main thread (not in parallel workers)
if any(name -> startswith(name, "core"), keys(testsuite)) && Sys.islinux()
    @info "Testing `Hostcalls` on the main thread."
    @testset "Hostcalls" begin
        include("device/hostcall.jl")
        include("device/output.jl")
    end
end
