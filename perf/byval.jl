module ByVal

using AMDGPU, BenchmarkTools, Random

const threads = 256

# simple add matrices kernel
function kernel_add_mat(n, x1, x2, y)
    i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
    if i <= n
        @inbounds y[i] = x1[i] + x2[i]
    end
    return
end

@inline get_inputs3(indx_y, a, b, c)                          = (a, b, c)
@inline get_inputs3(indx_y, a1, a2, b1, b2, c1, c2)           = indx_y == 1 ? (a1, b1, c1) : (a2, b2, c2)
@inline get_inputs3(indx_y, a1, a2, a3, b1, b2, b3, c1, c2, c3) = indx_y == 1 ? (a1, b1, c1) : indx_y == 2 ? (a2, b2, c2) : (a3, b3, c3)

# add arrays of matrices kernel
function kernel_add_mat_z_slices(n, vararg...)
    x1, x2, y = get_inputs3(workgroupIdx().y, vararg...)
    i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
    if i <= n
        @inbounds y[i] = x1[i] + x2[i]
    end
    return
end

function add_z_slices!(y, x1, x2)
    m1, n1 = size(x1[1])
    blocks = (m1 * n1 + threads - 1) ÷ threads
    @roc groupsize=threads gridsize=(blocks, length(x1)) kernel_add_mat_z_slices(m1 * n1, x1..., x2..., y...)
end

function add!(y, x1, x2)
    m1, n1 = size(x1)
    blocks = (m1 * n1 + threads - 1) ÷ threads
    @roc groupsize=threads gridsize=(blocks, 1) kernel_add_mat(m1 * n1, x1, x2, y)
end

function main()
    results = BenchmarkGroup()

    num_z_slices = 3
    Random.seed!(1)

    m, n = 3072, 1536    # 256 multiplier

    x1 = [ROCArray(randn(Float32, (m, n)) .+ Float32(0.5)) for i = 1:num_z_slices]
    x2 = [ROCArray(randn(Float32, (m, n)) .+ Float32(0.5)) for i = 1:num_z_slices]
    y1 = [similar(x1[1]) for i = 1:num_z_slices]

    # reference down-to-bones add on GPU
    results["reference"] = @benchmark AMDGPU.@sync add!($y1[1], $x1[1], $x2[1])

    # adding arrays in an array
    for slices = 1:num_z_slices
        results["slices=$slices"] = @benchmark AMDGPU.@sync add_z_slices!($y1[1:$slices], $x1[1:$slices], $x2[1:$slices])
    end

    # BenchmarkTools captures inputs, JuliaCI/BenchmarkTools.jl#127, so forcibly free them
    AMDGPU.unsafe_free!.(x1)
    AMDGPU.unsafe_free!.(x2)
    AMDGPU.unsafe_free!.(y1)

    return results
end

end

ByVal.main()
