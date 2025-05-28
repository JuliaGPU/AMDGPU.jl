
# Streams {#Streams}

Similar to CUDA streams, ROCm has HIP streams, which are buffers used to instruct the GPU hardware which kernels to launch. HIP streams are synchronous, like CUDA streams.

Each device has a default stream associated, which is accessible with `AMDGPU.stream()`.

There are several ways to specify which stream to launch a kernel on:
- Using [`AMDGPU.stream!`](/api/streams#AMDGPU.stream!) to change default stream to be used   **within the same Julia task**.
  

```julia
stream = AMDGPU.HIPStream()
AMDGPU.stream!(stream) # Change default stream to be used for subsequent operations.
AMDGPU.ones(Float32, 16) # Will be executed on `stream`.
```

- Using [`AMDGPU.stream!`](/api/streams#AMDGPU.stream!) to execute given function and reset   to the original stream after completion:
  

```julia
stream = AMDGPU.HIPStream()
x = AMDGPU.stream!(() -> AMDGPU.ones(Float32, 16), stream)
```

- Using `stream` argument to `@roc` macro:
  

```julia
stream = AMDGPU.HIPStream()
@roc stream=stream kernel(...)
```


Streams also have an inherent priority, which allows control of kernel submission latency and on-device scheduling preference with respect to kernels submitted on other streams. There are three priorities: normal (the default), low, and high priority.

Priority of the default `stream` can be set with [`AMDGPU.priority!`](/api/streams#AMDGPU.priority!). Alternatively, it can be set at stream creation time:

```julia
low_prio = HIPStream(:low)
high_prio = HIPStream(:high)
normal_prio = HIPStream(:normal) # or just omit "priority"
```

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.stream' href='#AMDGPU.stream'><span class="jlbinding">AMDGPU.stream</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
stream()::HIPStream
```


Get the HIP stream that should be used as the default one for the currently executing task.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L80-L85" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.stream!' href='#AMDGPU.stream!'><span class="jlbinding">AMDGPU.stream!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
stream!(s::HIPStream)
```


Change the default stream to be used **within the same Julia task**.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L88-L92" target="_blank" rel="noreferrer">source</a></Badge>



```julia
stream!(f::Base.Callable, stream::HIPStream)
```


Change the default stream to be used **within the same Julia task**, execute `f` and revert to the original stream.

**Returns:**

Return value of the function `f`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L99-L108" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.priority!' href='#AMDGPU.priority!'><span class="jlbinding">AMDGPU.priority!</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
priority!(p::Symbol)
```


Change the priority of the default stream. Accepted values are `:normal` (the default), `:low` and `:high`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L152-L157" target="_blank" rel="noreferrer">source</a></Badge>



```julia
priority!(f::Base.Callable, priority::Symbol)
```


Chnage the priority of default stream, execute `f` and revert to the original priority. Accepted values are `:normal` (the default), `:low` and `:high`.

**Returns:**

Return value of the function `f`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/tls.jl#L166-L176" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.HIPStream' href='#AMDGPU.HIP.HIPStream'><span class="jlbinding">AMDGPU.HIP.HIPStream</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
HIPStream(priority::Symbol = :normal)
```


**Arguments:**
- `priority::Symbol`: Priority of the stream: `:normal`, `:high` or `:low`.
  

Create HIPStream with given priority. Device is the default device that&#39;s currently in use.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/stream.jl#L13-L22" target="_blank" rel="noreferrer">source</a></Badge>



```julia
HIPStream(stream::hipStream_t)
```


Create HIPStream from `hipStream_t` handle. Device is the default device that&#39;s currently in use.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/stream.jl#L42-L47" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Synchronization {#Synchronization}

AMDGPU.jl by default uses non-blocking stream synchronization with [`AMDGPU.synchronize`](/api/streams#AMDGPU.synchronize) to work correctly with TLS and [Hostcall](/api/hostcall#Hostcall).

Users, however, can switch to a blocking synchronization globally with `nonblocking_synchronization` [preference](https://github.com/JuliaPackaging/Preferences.jl) or with fine-grained `AMDGPU.synchronize(; blocking=true)`. Blocking synchronization might offer slightly lower latency.

You can also perform synchronization of the expression with [`AMDGPU.@sync`](/api/streams#AMDGPU.@sync) macro, which will execute given expression and synchronize afterwards (using [`AMDGPU.synchronize`](/api/streams#AMDGPU.synchronize) under the hood).

```julia
AMDGPU.@sync begin
    @roc ...
end
```


Finally, you can perform full device synchronization with [`AMDGPU.device_synchronize`](/api/streams#AMDGPU.HIP.device_synchronize).
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.synchronize' href='#AMDGPU.synchronize'><span class="jlbinding">AMDGPU.synchronize</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
synchronize(stream::HIPStream = stream(); blocking::Bool = false)
```


Wait until all kernels executing on `stream` have completed.

If there are running HostCalls, then `blocking` **must** be `false`. Additionally, if you want to stop host calls afterwards, then provide `stop_hostcalls=true` keyword argument.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/highlevel.jl#L27-L35" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.@sync' href='#AMDGPU.@sync'><span class="jlbinding">AMDGPU.@sync</span></a> <Badge type="info" class="jlObjectType jlMacro" text="Macro" /></summary>



```julia
@sync ex
```


Run expression `ex` on currently active stream and synchronize the GPU on that stream afterwards.

See also: [`synchronize`](/api/streams#AMDGPU.synchronize).


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/highlevel.jl#L67-L74" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.HIP.device_synchronize' href='#AMDGPU.HIP.device_synchronize'><span class="jlbinding">AMDGPU.HIP.device_synchronize</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



Blocks until all kernels on all streams have completed. Uses currently active device.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/hip/HIP.jl#L83-L86" target="_blank" rel="noreferrer">source</a></Badge>

</details>

