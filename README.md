# HSARuntime.jl - Julia interface to the HSA runtime

## Requirements
### Installed
* ROCR
* ROCT
* hsa-ext-rocr-dev - Requires version 1.8.3 from ROCm APT archives
* Recent Linux kernel with AMDGPU and HSA enabled
### Setup Instructions
Currently, the requirements to get the simple ext/example.jl script to run are
a bit poorly documented in the upstream docs for any distro other than Ubuntu.
So here is a list of requirements I've found through the process of making
this work:

Make sure /dev/kfd has a group other than root (maybe create the "kfd" group and
add yourself to it, and then set /dev/kfd group to kfd with g+rw permissions).
Or, run as root! (Don't actually do this)

The correct libraries in your LD_LIBRARY_PATH or standard library locations:
* libhsa-runtime64.so
* libhsakmt.so

From the hsa-ext-rocr-dev closed-source package:
* libhsa-ext-finalize64.so
* libhsa-ext-image64.so
* libhsa-runtime-tools64.so

Note that libhsa-ext-finalize64.so has been removed in recent releases of
hsa-ext-rocr-dev, because apparently HSAIL support is deprecated or something?
You can still get the library from the apt archive at:
http://repo.radeon.com/rocm/archive/apt_1.8.3.tar.bz2

I leave this as an exercise to the reader until someone gives detailed
instructions :)

In terms of Linux kernel versions, just pick the newest one you can (I'm
running 4.20 as I type this). If building your own kernel, make sure all the
regular AMDGPU and HSA options are enabled.

## TODO
* Document some key Linux kernel config options to have enabled
* Create some structs and functions for various HSA stuff
* Make ext/wrap.jl use system-installed HSA headers
