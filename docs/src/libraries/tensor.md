# Tensor Operations

`AMDGPU.jl` now provides wrappers for the [`hipTensor`](https://rocm.docs.amd.com/projects/hipTensor/en/latest/index.html) library,
which can be used to perform operations on high-dimensional arrays. However, there are some caveats:

- `hipTensor` isn't supported on every AMD GPU. You can find the list of supported GPUs [at the `hipTensor` documentation](https://rocm.docs.amd.com/projects/hipTensor/en/latest/api-reference/api-reference.html#supported-gpu-architectures).
- for [`hiptensorCreateElementwiseTrinary`](https://rocm.docs.amd.com/projects/hipTensor/en/latest/api-reference/api-reference.html#hiptensorcreateelementwisetrinary), `hipTENSOR` 2.2 has the two binary operators the wrong way round: it applies the
  operator passed as `opABC` to `A` and `B`, and the one passed as `opAB` to that intermediate result and `C`. This is currently handled by our wrapper.
- Unlike NVIDIA's `cuTENSOR`, `hipTENSOR` wants a *complex* compute descriptor for complex operands: pairing e.g. `ComplexF32` tensors with `HIPTENSOR_COMPUTE_DESC_32F` makes
  `hiptensorCreatePlan` fail with `HIPTENSOR_STATUS_EXECUTION_FAILED`
- from `hipTENSOR` 2.4 on (the version in the ROCm 10.0 bundles, for instance), the contraction kernels no longer use the mode labels to work out how their operands line up:
  they read every descriptor positionally, and only compute the right result when `A` is indexed by its free modes followed by the contracted ones, `B` likewise, and `C` and `D`
  by `A`'s free modes followed by `B`'s, with every operand packed column-major. Any other layout is *silently* miscomputed — `hiptensorContract` reports success and writes a
  plausible but wrong result — so `plan_contraction` rejects it with an `ArgumentError`. Permute the operands with `permutedims` first. `hipTENSOR` 2.2 handled arbitrary mode
  orders, and is left alone
- `hipTENSOR` 2.2 accepts `HIPTENSOR_OP_CONJ` on a contraction's inputs and then silently ignores it, computing the unconjugated product; 2.4 rejects it instead, failing
  `hiptensorCreatePlan` with `HIPTENSOR_STATUS_EXECUTION_FAILED`
