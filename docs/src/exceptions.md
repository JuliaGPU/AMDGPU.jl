# Kernel-thrown Exceptions

Just like regular CPU-executed Julia functions, GPU kernels can throw
exceptions! For example, the following kernel will throw a `KernelException`:

```julia
function throwkernel(A)
    A[0] = 1
end
HA = HSAArray(zeros(Int,1))
wait(@roc throwkernel(HA))
```

Kernels that hit an exception will write some exception information into a
pre-allocated list for the CPU to inspect. Once complete, the wavefront
throwing the exception will stop itself, but other wavefronts will continue
executing (possibly throwing their own exceptions, or not).

Kernel-thrown exceptions are thrown on the CPU in the call to `wait(event)`,
where `event` is the returned value of `@roc` calls. When the kernel signals
that it's completed, the `wait` function will check if an exception flag has
been set, and if it has, will collect all of the relevant exception information
that the kernels set up. Unlike CPU execution, GPU kernel exceptions aren't
very user-customizable and pretty (for now!). They don't call `Base.show`, but
instead pass the LLVM function name of their exception handler (details in
`GPUCompiler`, `src/irgen.jl`). Therefore, the exact error that occured might
be a bit hard to figure out.

If exception checking turns out to be too expensive for your needs, you can
disable those checks by passing the kwarg `check_exceptions=false` to the
`wait` call, which will skip any error checking (although it will still wait
for the kernel to signal completion).
