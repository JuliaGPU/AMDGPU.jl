# Kernel Dependencies

Unlike CUDA, ROCm does not have blocking queues; instead, all kernels placed on a queue will usually be processed and scheduled immediately. There is one exception: barrier packets may be placed on the queue to block the GPU's queue packet processor from proceeding until a given set of kernels has completed. These barriers come in two flavors: `barrier_and!` and `barrier_or!`. These functions can be called on a queue with a given set of kernel signals (those returned from `@roc`) to wait for all kernels or any one kernel to complete, respectively.

Generally, the `barrier_and!` call should be the most useful tool for most users, since many codes require synchronization of all "threads of execution" at the end of one step before moving onto the next step. For example, the following code may look innocuous, but in fact the kernels might "race" and return unexpected results:

```julia
function kernel(A)
    A[1] += 1.0
    nothing
end

RA = ROCArray(zeros(Float64, 1))
@roc kernel(RA)
@roc kernel(RA)
@show Array(RA)[1] # could be 1.0 or 2.0
```

To fix this example, we use a `barrier_and!` call to ensure proper ordering of execution:

```julia
RA = ROCArray(zeros(Float64, 1))
s1 = @roc kernel(RA)
barrier_and!([s1])
s2 = @roc kernel(RA)
wait(s2)
@show Array(RA)[1] # will always be 2.0
```

While likely less useful for most, `barrier_or!` can be useful in situations where any one of many "input" kernels can satisfy a condition necessary to allow later kernels to execute properly:

```julia
function kernel1(A, i)
    A[1] = i
    nothing
end
function kernel2(A, i)
    A[2] = i/A[1]
end

RA = ROCArray(zeros(Float64, 2))
s1 = @roc kernel1(RA, 1.0)
s2 = @roc kernel1(RA, 2.0)
barrier_or!([s1,s2])
s3 = @roc kernel2(RA, 3.0)
wait(s3)
@show Array(RA)[1] # will either be 3.0 or 1.5, but will never throw due to divide-by-zero
```

!!! warning
    Because of how barrier OR packets work, you can't use queue hardware to do a wait-any on more than 5 signals at a time. If more than 5 signals are specified, then the signals are split into sets of 5, and the total barrier won't be fulfilled until, for each set, one of the signals is satisfied.

    Contributions are welcome to workaround this issue, which will probably need to implemented in software either on the CPU or GPU side.
