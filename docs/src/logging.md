# Runtime and Compiler Logging

AMDGPU.jl has a built-in logging system integrated into various runtime and
compiler operations, which is provided by TimespanLogging.jl. Operations such
as compilation and linking, signal and buffer allocation/freeing, kernel
launch, etc. are instrumented with logging statements, allowing the user to
record the start and end of operations.

While disabled by default, logging can be enabled by first running
`AMDGPU.Runtime.enable_logging!()` to globally enable logging, after which
Julia must be restarted for the changes to take effect.

Once logging is globally enabled, `AMDGPU.Runtime.start_logging()` causes new
log events to be saved, while `AMDGPU.Runtime.stop_logging()` causes new log
events to be discarded. Log events can be collected with
`AMDGPU.Runtime.fetch_logs!()`. A more convenient option is
`AMDGPU.Runtime.log_and_fetch!(f)`, which can be used to easily log operations
within a region of code:

```julia
logs = AMDGPU.Runtime.log_and_fetch!() do
    A = AMDGPU.ones(3, 4)
    B = copy(A)
    fill!(B, 1f0)
    C = Array(B)
end
@show logs[1]
```
