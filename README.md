# HSARuntime.jl - Julia interface to the HSA runtime

## Requirements

### Installed
* [ROCR](https://github.com/RadeonOpenCompute/ROCR-Runtime)
* [ROCT](https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface)
* Recent Linux kernel with AMDGPU and HSA enabled

### Setup Instructions
Currently, the requirements to get everything working properly is a bit poorly
documented in the upstream docs for any distro other than Ubuntu.  So here is
a list of requirements I've found through the process of making this work:

Make sure /dev/kfd has a group other than root that you can add your user to.
I recommend adding your user to the "video" group, and setting the
ownership of /dev/kfd to root:video with 660 permissions.  Or, run as root!
(Don't actually do this)

The correct libraries in your LD_LIBRARY_PATH or standard library locations:
* libhsa-runtime64.so
* libhsakmt.so

In terms of Linux kernel versions, just pick the newest one you can (I'm
running 4.20 as I type this). If building your own kernel, make sure all the
regular AMDGPU and HSA options are enabled.

You will also need `ld.lld` installed on your system (provided by LLVM/Clang);
if you built Julia from source, you should have a copy somewhere in
`deps/scratch/llvm-*/*/bin/` that you can add to your PATH.

Once all of this is setup properly, you should be able to `] build HSARuntime`
successfully; after that, if you have a supported GPU attached and enabled, `]
test HSARuntime` should work exactly as you might expect.

## TODO
* Document some key Linux kernel config options to have enabled
* Make deps/wrap.jl use system-installed HSA headers
