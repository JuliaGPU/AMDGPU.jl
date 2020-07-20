# Execution Control and Intrinsics

GPU execution is similar to CPU execution in some ways, although there are many
differences. AMD GPUs have Compute Units (CUs), which can be thought of like
CPU cores. Those CUs have (on pre-Navi architectures) 64 "shader processors",
which are essentially the same as CPU SIMD lanes. The lanes in a CU operate in
lockstep just like CPU SIMD lanes, and have execution masks and various kinds
of SIMD instructions available. CUs execute wavefronts, which are pieces of
work split off from a single kernel launch. A single CU can run one out of many
wavefronts (one is chosen by the CU scheduler each cycle), which allows for
very efficient parallel and concurrent execution on the device. Each wavefront
runs independently of the other wavefronts, only stopping to synchronize with
other wavefronts or terminate when specified by the program.

We can control wavefront execution through a variety of intrinsics provided by
ROCm. For example, the `endpgm()` intrinsic stops the current wavefront's
execution, and is also automatically inserted by the compiler at the end of
each kernel (except in certain unique cases).

`signal_completion(x)` signals the "kernel doorbell" with the value `x`, which
is the signal checked by the CPU `wait` call to determine when the kernel has
completed. This doorbell is set to `0` automatically by GPU hardware once the
kernel is complete.

`sendmsg(x,y=0)` and `sendmsghalt(x,y=0)` can be used to signal special
conditions to the scheduler/hardware, such as making requests to stop wavefront
generation, or halt all running wavefronts. Check the ISA manual for details!
