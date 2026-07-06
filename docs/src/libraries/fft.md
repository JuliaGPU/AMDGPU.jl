# Fourier Transforms

AMDGPU.jl implements the [AbstractFFTs.jl](https://github.com/JuliaMath/AbstractFFTs.jl) interface on top of AMD's [rocFFT](https://github.com/ROCm/rocFFT), so `fft`, `ifft`, `rfft`, and the planning API work on `ROCArray` just as they do on the CPU. Load `AbstractFFTs` (or a package that re-exports it, such as `FFTW`) alongside AMDGPU:

```julia
using AMDGPU
using AbstractFFTs

x = ROCArray(ComplexF32[1, 2, 3, 4])
y = fft(x)          # forward transform on the GPU
z = ifft(y)         # z ≈ x
```

Real-to-complex transforms are available through `rfft`:

```julia
xr = AMDGPU.rand(Float32, 1024)
yr = rfft(xr)       # length 513 complex output
```

## Plans

For repeated transforms of the same size, create a plan once and reuse it to amortize setup cost. Both out-of-place and in-place plans are supported:

```julia
x = ROCArray(rand(ComplexF32, 1024))

p = plan_fft(x)          # out-of-place
y = p * x

p! = plan_fft!(x)        # in-place, overwrites its argument
p! * x
```

Multidimensional transforms and transforms over selected dimensions work as usual, e.g. `fft(x, (1, 2))` for a 2D transform of a higher-dimensional array.
```
