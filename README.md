# AMDGPUnative

*Support for compiling and executing native Julia kernels on AMD hardware.*

NOTE:
-----

This is an experimental package, not ready for usage and subject to change at any time. Contributions are welcomed, but here be dragons.

Installation
------------

AMDGPUnative is a experimental package, to install it use `Pkg.clone`.

It is recommended to use LLVM 7.0 or higher, otherwise certain features (like
math intrinsics) are disabled.

Acknowledgment
--------------

AMDGPUnative would not have been possible without the work by Tim Besard on [CUDAnative.jl](https://github.com/JuliaGPU/CUDAnative.jl)
and [LLVM.jl](https://github.com/maleadt/LLVM.jl). 


License
-------

AMDGPUnative.jl is licensed under the [MIT License](LICENSE.md).

