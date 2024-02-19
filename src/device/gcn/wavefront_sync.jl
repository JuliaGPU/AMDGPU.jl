@inline function __check_mask(mask::UInt64)
    done::Cint = Cint(0)
    while wfany(__not(done))
        if __not(done) == Cint(1)
            chosen_mask = readfirstlane(mask)
            if mask == chosen_mask
                # TODO
                # @rocassert(mask == ballot(true),
                #   "All threads specified in the mask must execute the same operation.")
                done = Cint(1)
            end
        end
    end
end

"""
    ballot_sync(mask::UInt64, predicate::Bool)::UInt64

Evaluate `predicate` for all non-exited threads in `mask`
and return an integer whose Nth bit is set if and only if
`predicate` is `true` for the Nth thread of the wavefront and the Nth thread is active.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.ballot_sync(mask, true)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt64}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> bitstring(Array(x)[1])
"0000000000000000000000000000000001010101010101010101010101010101"
```
"""
function ballot_sync(mask::UInt64, predicate::Bool)::UInt64
    __check_mask(mask)
    ballot(predicate) & mask
end

"""
    any_sync(mask::UInt64, predicate::Bool)::Bool

Evaluate `predicate` for all non-exited threads in `mask` and
return non-zero if and only if `predicate` evaluates to non-zero for any of them.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.any_sync(mask, i == 0)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Bool}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{Bool, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 1
```
"""
any_sync(mask::UInt64, predicate::Bool)::Bool = ballot_sync(mask, predicate) != 0

"""
    all_sync(mask::UInt64, predicate::Bool)::Bool

Evaluate `predicate` for all non-exited threads in `mask` and
return non-zero if and only if `predicate` evaluates to non-zero for all of them.

```jldoctest
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.all_sync(mask, true)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Bool}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{Bool, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 1
```
"""
all_sync(mask::UInt64, predicate::Bool)::Bool = ballot_sync(mask, predicate) == mask

"""
    shfl_sync(mask::UInt64, val, lane, width = wavefrontsize())

Synchronize threads according to a `mask` and
read data stored in `val` from a `lane` ID.
"""
function shfl_sync(mask::UInt64, val, lane, width = wavefrontsize())
    __check_mask(mask)
    shfl(val, lane, width)
end

"""
    shfl_up_sync(mask::UInt64, val, δ, width = wavefrontsize())

Synchronize threads according to a `mask` and
read data stored in `val` from a `lane` with lower ID relative to the caller.
"""
function shfl_up_sync(mask::UInt64, val, δ, width = wavefrontsize())
    __check_mask(mask)
    shfl_up(val, δ, width)
end

"""
    shfl_down_sync(mask::UInt64, val, δ, width = wavefrontsize())

Synchronize threads according to a `mask` and
read data stored in `val` from a `lane` with higher ID relative to the caller.
"""
function shfl_down_sync(mask::UInt64, val, δ, width = wavefrontsize())
    __check_mask(mask)
    shfl_down(val, δ, width)
end

"""
    shfl_xor_sync(mask::UInt64, val, lane_mask, width = wavefrontsize())

Synchronize threads according to a `mask` and
read data stored in `val` from a lane according to a bitwise XOR
of the caller's lane ID with the `lane_mask`.
"""
function shfl_xor_sync(mask::UInt64, val, lane_mask, width = wavefrontsize())
    __check_mask(mask)
    shfl_xor(val, lane_mask, width)
end
