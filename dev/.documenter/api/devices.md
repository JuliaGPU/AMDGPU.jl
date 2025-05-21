
# Devices {#Devices}

In AMDGPU, all GPU devices are auto-detected by the runtime, if they&#39;re supported.

AMDGPU maintains a global default device. The default device is relevant for all kernel and GPUArray operations. If one is not specified via `@roc` or an equivalent interface, then the default device is used for those operations, which affects compilation and kernel launch.

The device bound to a current Julia task is accessible via [`AMDGPU.device`](/api/devices#AMDGPU.device) method. The list of available devices can be queried with [`AMDGPU.devices`](/api/devices#AMDGPU.HIP.devices) method.

If you have a `HIPDevice` object, you can also switch the device with [`AMDGPU.device!`](/api/devices#AMDGPU.device!). This will switch it **only within the task it is called from**.

```julia
xd1 = AMDGPU.ones(Float32, 16) # On `AMDGPU.device()` device.

AMDGPU.device!(AMDGPU.devices()[2]) # Switch to second device.
xd2 = AMDPGU.ones(Float32, 16) # On second device.
```


Additionally, devices have an associated numeric ID. This value is bounded between `1` and `length(AMDGPU.devices())`, and device `1` is the default device when AMDGPU is first loaded. The ID of the device associated with the current task can be queried with [`AMDGPU.device_id`](/api/devices#AMDGPU.device_id) and changed with [`AMDGPU.device_id!`](/api/devices#AMDGPU.device_id!).
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.devices' href='#AMDGPU.HIP.devices'><span class="jlbinding">AMDGPU.HIP.devices</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
devices()
```


Get list of all devices.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L107-L111" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.device' href='#AMDGPU.device'><span class="jlbinding">AMDGPU.device</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
device()::HIPDevice
```


Get currently active device. This device is used when launching kernels via `@roc`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L39-L44" target="_blank" rel="noreferrer">source</a></Badge>



```julia
device(A::ROCArray) -> HIPDevice
```


Return the device associated with the array `A`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/array.jl#L31-L35" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.device!' href='#AMDGPU.device!'><span class="jlbinding">AMDGPU.device!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
device!(device::HIPDevice)
```


Switch current device being used. This switches only for a task inside which it is called.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L47-L52" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.device_id' href='#AMDGPU.device_id'><span class="jlbinding">AMDGPU.device_id</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
device_id() -> Int
device_id(device::HIPDevice) -> Int
```


Returns the numerical device ID for `device` or for the current `AMDGPU.device()`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/highlevel.jl#L1-L6" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.device_id!' href='#AMDGPU.device_id!'><span class="jlbinding">AMDGPU.device_id!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
device_id!(idx::Integer)
```


Sets the current device to `AMDGPU.devices()[idx]`. See [`device_id`](/api/devices#AMDGPU.device_id) for details on the numbering semantics.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/highlevel.jl#L10-L15" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Device Properties {#Device-Properties}
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.name' href='#AMDGPU.HIP.name'><span class="jlbinding">AMDGPU.HIP.name</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
name(dev::HIPDevice)::String
```


Get name of the device.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L70-L74" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.wavefrontsize' href='#AMDGPU.HIP.wavefrontsize'><span class="jlbinding">AMDGPU.HIP.wavefrontsize</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
wavefrontsize(d::HIPDevice)::Cint
```


Get size of the wavefront. AMD GPUs support either 32 or 64.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L32-L36" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.gcn_arch' href='#AMDGPU.HIP.gcn_arch'><span class="jlbinding">AMDGPU.HIP.gcn_arch</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
gcn_arch(d::HIPDevice)::String
```


Get GCN architecture for the device.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L39-L43" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.device_id' href='#AMDGPU.HIP.device_id'><span class="jlbinding">AMDGPU.HIP.device_id</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
device_id(d::HIPDevice)
```


Zero-based device ID as expected by HIP functions. Differs from [`AMDGPU.device_id`](/api/devices#AMDGPU.device_id) method by `1`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L24-L29" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.properties' href='#AMDGPU.HIP.properties'><span class="jlbinding">AMDGPU.HIP.properties</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
properties(dev::HIPDevice)::hipDeviceProp_t
```


Get all properties for the device. See HIP documentation for `hipDeviceProp_t` for the meaning of each field.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/device.jl#L81-L86" target="_blank" rel="noreferrer">source</a></Badge>

</details>

