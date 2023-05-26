# High-level functions.

function maxpool(
    x::ROCArray{T, N}; dims::NTuple{K, Int},
    padding::NTuple{K, Int}, stride::NTuple{K, Int}, do_backward::Bool = true,
) where {T <: MIOPENFloat, N, K}
    xdesc = TensorDescriptor(x)
    pdesc = PoolingDescriptor(miopenPoolingMax, ndims(x) - 2; dims, padding, stride)
    y = similar(x, T, output_size(pdesc, xdesc))
    pool!(y, TensorDescriptor(y), x, xdesc, pdesc; do_backward)
end

function maxpool!(
    y::ROCArray{T, N}, x::ROCArray{T, N}; dims::NTuple{K, Int},
    padding::NTuple{K, Int}, stride::NTuple{K, Int}, do_backward::Bool = true,
) where {T <: MIOPENFloat, N, K}
    xdesc, ydesc = TensorDescriptor.((x, y))
    pdesc = PoolingDescriptor(miopenPoolingMax, ndims(x) - 2; dims, padding, stride)
    pool!(y, ydesc, x, xdesc, pdesc; do_backward)
end

function ∇maxpool(
    dy::ROCArray{T, N}, y::ROCArray{T, N}, x::ROCArray{T, N};
    dims::NTuple{K, Int}, padding::NTuple{K, Int}, stride::NTuple{K, Int},
    workspace,
) where {T <: MIOPENFloat, N, K}
    dx = similar(x, T, size(x))
    dxdesc, dydesc, ydesc, xdesc = TensorDescriptor.((dx, dy, y, x))
    pdesc = PoolingDescriptor(miopenPoolingMax, ndims(x) - 2; dims, padding, stride)
    ∇pool!(dx, dxdesc, dy, dydesc, y, ydesc, x, xdesc, pdesc; workspace)
end

function ∇maxpool!(
    dx::ROCArray{T, N}, dy::ROCArray{T, N}, y::ROCArray{T, N}, x::ROCArray{T, N};
    dims::NTuple{K, Int}, padding::NTuple{K, Int}, stride::NTuple{K, Int},
    workspace,
) where {T <: MIOPENFloat, N, K}
    dxdesc, dydesc, ydesc, xdesc = TensorDescriptor.((dx, dy, y, x))
    pdesc = PoolingDescriptor(miopenPoolingMax, ndims(x) - 2; dims, padding, stride)
    ∇pool!(dx, dxdesc, dy, dydesc, y, ydesc, x, xdesc, pdesc; workspace)
end

function meanpool(
    x::ROCArray{T, N}; dims::NTuple{K, Int},
    padding::NTuple{K, Int}, stride::NTuple{K, Int}, do_backward::Bool = true,
) where {T <: MIOPENFloat, N, K}
    xdesc = TensorDescriptor(x)
    pdesc = PoolingDescriptor(miopenPoolingAverageInclusive, ndims(x) - 2; dims, padding, stride)
    y = similar(x, T, output_size(pdesc, xdesc))
    pool!(y, TensorDescriptor(y), x, xdesc, pdesc; do_backward)
end

function meanpool!(
    y::ROCArray{T, N}, x::ROCArray{T, N}; dims::NTuple{K, Int},
    padding::NTuple{K, Int}, stride::NTuple{K, Int}, do_backward::Bool = true,
) where {T <: MIOPENFloat, N, K}
    xdesc, ydesc = TensorDescriptor.((x, y))
    pdesc = PoolingDescriptor(miopenPoolingAverageInclusive, ndims(x) - 2; dims, padding, stride)
    pool!(y, ydesc, x, xdesc, pdesc; do_backward)
end

function ∇meanpool(
    dy::ROCArray{T, N}, y::ROCArray{T, N}, x::ROCArray{T, N};
    dims::NTuple{K, Int}, padding::NTuple{K, Int}, stride::NTuple{K, Int},
    workspace,
) where {T <: MIOPENFloat, N, K}
    dx = similar(x, T, size(x))
    dxdesc, dydesc, ydesc, xdesc = TensorDescriptor.((dx, dy, y, x))
    pdesc = PoolingDescriptor(miopenPoolingAverageInclusive, ndims(x) - 2; dims, padding, stride)
    ∇pool!(dx, dxdesc, dy, dydesc, y, ydesc, x, xdesc, pdesc; workspace)
end

function ∇meanpool!(
    dx::ROCArray{T, N}, dy::ROCArray{T, N}, y::ROCArray{T, N}, x::ROCArray{T, N};
    dims::NTuple{K, Int}, padding::NTuple{K, Int}, stride::NTuple{K, Int},
    workspace,
) where {T <: MIOPENFloat, N, K}
    dxdesc, dydesc, ydesc, xdesc = TensorDescriptor.((dx, dy, y, x))
    pdesc = PoolingDescriptor(miopenPoolingAverageInclusive, ndims(x) - 2; dims, padding, stride)
    ∇pool!(dx, dxdesc, dy, dydesc, y, ydesc, x, xdesc, pdesc; workspace)
end

# Generic MIOpen pooling.

function get_workspace_size(pdesc::PoolingDescriptor, ydesc::TensorDescriptor)
    wsize_ref = Ref{Csize_t}(0)
    miopenPoolingGetWorkSpaceSizeV2(
        pdesc.handle, ydesc.handle, wsize_ref) |> check
    wsize_ref[]
end

function pool!(
    y::ROCArray{T, N}, ydesc::TensorDescriptor,
    x::ROCArray{T, N}, xdesc::TensorDescriptor,
    pdesc::PoolingDescriptor; alpha = 1f0, beta = 0f0, do_backward::Bool = true,
) where {T <: MIOPENFloat, N}
    if do_backward
        wsize = get_workspace_size(pdesc, ydesc)
        workspace = Workspace(GPUArrays.device(y), wsize)
        wptr = workspace.data.ptr
    else
        wsize = 0
        workspace = nothing
        wptr = C_NULL
    end
    (; handle, stream) = lib_state()
    miopenPoolingForward(
        handle, pdesc.handle, Ref{Float32}(alpha), xdesc.handle, x,
        Ref{Float32}(beta), ydesc.handle, y, do_backward,
        wptr, wsize) |> check
    y, workspace
end

function ∇pool!(
    dx::ROCArray{T, N}, dxdesc::TensorDescriptor,
    dy::ROCArray{T, N}, dydesc::TensorDescriptor,
    y::ROCArray{T, N}, ydesc::TensorDescriptor,
    x::ROCArray{T, N}, xdesc::TensorDescriptor,
    pdesc::PoolingDescriptor; alpha = 1f0, beta = 0f0, workspace,
) where {T <: MIOPENFloat, N}
    (; handle, stream) = lib_state()
    miopenPoolingBackward(
        handle, pdesc.handle, Ref{Float32}(alpha),
        ydesc.handle, y, dydesc.handle, dy, xdesc.handle, x,
        Ref{Float32}(beta), dxdesc.handle, dx,
        (isnothing(workspace) ? C_NULL : workspace.data.ptr)) |> check
    dx
end
