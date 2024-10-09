using AMDGPU
using KernelAbstractions

function compute_tensors(tensor, kernel_fun, Nx, Ny, Nz)
    kernel! = kernel_fun(get_backend(tensor))
    kernel!(tensor, Nx, Ny, Nz; ndrange=size(tensor))
    KernelAbstractions.synchronize(get_backend(tensor))
    return
end

@kernel function kernel_xx!(tensor, Nx::Int64, Ny::Int64, Nz::Int64)
    idx = @index(Global)
    res = zero(eltype(tensor))
    for p in (-Nx):Nx
        for q in Ny:(Ny + 2)
            res += 2.0
        end
    end
    @inbounds tensor[idx] = res
end

function main()
    nx, ny, nz = 10, 1, 1
    Nx, Ny, Nz = 1, 1, 1
    # tensor = zeros(Float64, nx, ny, nz)
    # compute_tensors(tensor, kernel_xx!, Nx, Ny, Nz)
    # println("cpu:", tensor)

    tensor = AMDGPU.zeros(Float64, nx, ny, nz)
    compute_tensors(tensor, kernel_xx!, Nx, Ny, Nz)
    println("amd:", tensor)
end
main()
