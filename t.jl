using AMDGPU
using GPUArrays

# Notes:
# - if function contains malloc & respective free calls -> can just relaunch graph.
# - if only malloc, but no free -> capture allocs with AllocCache first -> then capture graph itself.
# - if rand calls -> call rand before capture to init RNG.
#
# - updating graph, does not update malloc addresses, so is not supported, only instantiation.
# - TODO write cases when updating makes sense: e.g. changing `.+ 1f0` to `.+ 2f0`.

# function f(o)
#     x = AMDGPU.rand(Float32, size(o))
#     y = AMDGPU.rand(Float32, size(o))
#     z = x * y
#     o .+= z .+ 1f0
#     AMDGPU.unsafe_free!(x)
#     AMDGPU.unsafe_free!(y)
#     AMDGPU.unsafe_free!(z)
#     return
# end

function f(o)
    x = AMDGPU.rand(Float32, size(o))
    y = AMDGPU.rand(Float32, size(o))
    o .+= x * y .+ 1f0
    return
end

function main()
    cache = GPUArrays.AllocCache()
    z = AMDGPU.zeros(Float32, 4, 4)

    GPUArrays.@cached cache begin
        f(z)
    end

    # g = AMDGPU.@captured begin
    g = GPUArrays.@cached cache AMDGPU.@captured begin
        f(z)
    end
    display(z); println()

    for i in 1:10
        AMDGPU.launch(g)
        display(z); println()
    end

    return
end
main()
