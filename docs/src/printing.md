# Printing

Writing GPU kernels can be a difficult endeavor, owing to the fact that the
LLVM GPU backends turn serial code into parallel code automatically.
Recognizing this, every good GPU programming interface allows the user's GPU
kernels to print output to a buffer, which will be passed to the host for
display. With the ability to interpolate variables, this functionality serves
as the "printf of GPUs". Quite literally, the primary tool for this is
`@rocprintf`. Here's a simple example of printing the current workgroup index:

```julia
kernel(x) = @rocprintf "Workgroup index: %d\n" workgroupIdx().x
```

The above kernel would print out the string "Workgroup index: 1\n" when run
with a single workgroup (where "\n" means a newline).

Any number of variables may be passed to `@rocprintf`, as long as those
variables have a printf-compatible implementation in `Printf.@printf`. Calls to
`@rocprintf` are blocking, and will not return control to the kernel until the
string has been formatted and sent to the OS runtime for printing (the same as
for calls to `Printf.@printf`).

While `@rocprintf` is printed once per workgroup by default, it's possible to
print once per lane, once per wavefront, or once per grid by specifying an
execution mode as the first argument:

```julia
# Once per lane
kernel(x) = @rocprintf :lane "My index is: %d\n" workitemIdx().x

# Once per wavefront
kernel(x) = @rocprintf :wave "My index is: %d\n" workitemIdx().x

# Once per workgroup
kernel(x) = @rocprintf :group "My index is: %d\n" workitemIdx().x
# OR (:group is the default)
kernel(x) = @rocprintf "My index is: %d\n" workitemIdx().x

# Once total
kernel(x) = @rocprintf :grid "My index is: %d\n" workitemIdx().x
```

Executing those kernels with 256 workitems split evenly between 2 workgroups
would print out:

```
# :lane
My index is 1
My index is 2
...
My index is 127
My index is 128
My index is 1
My index is 2
...
My index is 127
My index is 128

# :wave
My index is 1
My index is 65
My index is 1
My index is 65

# :group
My index is 1
My index is 1

# :grid
My index is 1
```

## Differences to `@cuprintf`

Similar to CUDA's `@cuprintf`, `@rocprintf` is a printf-compatible macro which
takes a format string and arguments, and commands the host CPU to display it as
formatted text. However, in contrast to `@cuprintf`, we use AMDGPU's hostcall
and Julia's `Printf` stdlib to implement this. This means that anything that
`Printf` can print, so can `@rocprintf` (assuming such an object can be
represented on the GPU). The macro is also handled as a regular hostcall, which
means that argument types are checked at compile time (although currently, any
errors while printing will be detected on the host, and will terminate the
kernel).
