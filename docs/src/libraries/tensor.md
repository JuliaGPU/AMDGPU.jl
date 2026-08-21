# Tensor Operations

`AMDGPU.jl` now provides wrappers for the [`hipTensor`](https://rocm.docs.amd.com/projects/hipTensor/en/latest/index.html) library,
which can be used to perform operations on high-dimensional arrays. However, there are some caveats:

- `hipTensor` isn't supported on every AMD GPU. You can find the list of supported GPUs [at the `hipTensor` documentation](https://rocm.docs.amd.com/projects/hipTensor/en/latest/api-reference/api-reference.html#supported-gpu-architectures).
- for [`hiptensorCreateElementwiseTrinary`](https://rocm.docs.amd.com/projects/hipTensor/en/latest/api-reference/api-reference.html#hiptensorcreateelementwisetrinary), `hipTENSOR` 2.2 has the two binary operators the wrong way round: it applies the
  operator passed as `opABC` to `A` and `B`, and the one passed as `opAB` to that intermediate result and `C`. This is currently handled by our wrapper.
- Unlike NVIDIA's `cuTENSOR`, `hipTENSOR` wants a *complex* compute descriptor for complex operands: pairing e.g. `ComplexF32` tensors with `HIPTENSOR_COMPUTE_DESC_32F` makes
  `hiptensorCreatePlan` fail with `HIPTENSOR_STATUS_EXECUTION_FAILED`
