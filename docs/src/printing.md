# Printing

Writing GPU kernels can be a difficult endeavor, owing to the fact that the
LLVM GPU backends turn serial code into parallel code automatically.
Recognizing this, every good GPU programming interface allows the user's GPU
kernels to print output to a buffer, which will be passed to the host for
display. With the ability to interpolate variables, this functionality serves
as the "printf of GPUs". Quite literally, the primary tool for this is
`@rocprintf`. Here's a simple example of printing the current workgroup index:

```julia
function kernel(x)
    @rocprintf "Workgroup index: %d\n" workgroupIdx().x
    nothing
end
```

The above kernel would print out the string "Workgroup index: 1\n" when run
with a single workgroup (where "\n" means a newline).

Any number of variables may be passed to `@rocprintf`, as long as those
variables have a printf-compatible implementation in `Printf`. Calls to
`@rocprintf` are blocking, and will not return control to the kernel until the
string has been formatted and sent to the OS runtime for printing (the same as
for regular calls to `@printf`).

While `@rocprintf` is printed once per wavefront, it's possible to print once
per lane by doing a simple loop:

```julia
function kernel(x)
    for i in 1:workgroupDim().x
        idx = workitemIdx().x
        if i == idx
            @rocprintf "My index is %d\n" idx
        ed
    end
    nothing
end
```

The above kernel, when run with just 4 workitems in a single workgroup, will
print out:

My index is 1
My index is 2
My index is 3
My index is 4

## Differences to `@cuprintf`

Similar to CUDA's `@cuprintf`, `@rocprintf` is a printf-compatible macro
which takes a format string and arguments, and commands the host CPU to display
it as formatted text. In contrast to `@cuprintf`, however, is that we use
AMDGPU's hostcall and Julia's `Printf` stdlib to implement this. This means
that anything that `Printf` can print, so can `@rocprintf`. The macro is also
handled as a regular hostcall, which means that argument types are checked at
compile time (although currently, any errors while printing will be detected on
the host, and will terminate the kernel).
