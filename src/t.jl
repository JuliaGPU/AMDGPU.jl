using AMDGPU

function main()
    dim = 2

    P = zeros(Int32, 2, 3, 4)
    P .= [iz*1e2 + iy*1e1 + ix for ix=1:size(P,1), iy=1:size(P,2), iz=1:size(P,3)];
    P = ROCArray(P)

    if dim==1
        ranges = [2:2, 1:size(P,2), 1:size(P,3)]
        buf = zeros(Int32, size(P,2), size(P,3))
        buf_view_shape = (1, size(P,2), size(P,3))
    elseif dim==2
        ranges = [1:size(P,1), 3:3, 1:size(P,3)]
        buf = zeros(Int32, size(P,1), size(P,3))
        buf_view_shape = (size(P,1), 1, size(P,3))
    elseif dim==3
        ranges = [1:size(P,1), 1:size(P,2), 3:3]
        buf = zeros(Int32, size(P,1), size(P,2))
        buf_view_shape = (size(P,1), size(P,2), 1)
    end

    buf_view = reshape(buf, buf_view_shape)

    AMDGPU.Mem.unsafe_copy3d!(
        pointer(buf), AMDGPU.Mem.HostBuffer,
        pointer(P), typeof(P.buf),
        length(ranges[1]), length(ranges[2]), length(ranges[3]);
        srcPos=(ranges[1][1], ranges[2][1], ranges[3][1]),
        dstPitch=sizeof(Int32) * size(buf_view, 1), dstHeight=size(buf_view, 2),
        srcPitch=sizeof(Int32) * size(P, 1), srcHeight=size(P, 2),
    )

    if dim==1
        @assert buf ≈ Array(P)[2,:,:]
    elseif dim==2
        @assert buf ≈ Array(P)[:,3,:]
    elseif dim==3
        @assert buf ≈ Array(P)[:,:,3]
    end

    # host to device
    P2 = similar(P)

    AMDGPU.Mem.unsafe_copy3d!(
        pointer(P2), typeof(P2.buf),
        pointer(buf), AMDGPU.Mem.HostBuffer,
        length(ranges[1]), length(ranges[2]), length(ranges[3]);
        dstPos=(ranges[1][1], ranges[2][1], ranges[3][1]),
        dstPitch=sizeof(Int32) * size(P2,1), dstHeight=size(P2, 2),
        srcPitch=sizeof(Int32) * size(buf_view, 1), srcHeight=size(buf_view, 2),
    )

    if dim == 1
        @assert Array(P2)[2,:,:] ≈ Array(P)[2,:,:]
    elseif dim == 2
        @assert Array(P2)[:,3,:] ≈ Array(P)[:,3,:]
    elseif dim == 3
        @assert Array(P2)[:,:,3] ≈ Array(P)[:,:,3]
    end
end
main()

function ttt()
    nx, ny, nz = 4, 6, 8
    # x-z
    src = ROCArray(collect(reshape(1:(nx * ny * nz), nx, ny, nz)))
    dst = ROCArray(zeros(Int, nx, nz))

    AMDGPU.Mem.unsafe_copy3d!(
        pointer(dst), typeof(dst.buf),
        pointer(src), typeof(src.buf),
        4, 1, 8;
        dstPos=(1, 1, 1), srcPos=(1, 2, 1),
        dstPitch=nx * sizeof(Int), dstWidth=nz,
        srcPitch=nx * sizeof(Int), srcWidth=1, srcHeight=ny)

    display(Array(src)[:, 2, :]); println()
    display(Array(dst)); println()


    # y-z
    src = ROCArray(collect(reshape(1:(nx * ny * nz), nx, ny, nz)))
    dst = ROCArray(zeros(Int, ny, nz))

    AMDGPU.Mem.unsafe_copy3d!(
        pointer(dst), typeof(dst.buf),
        pointer(src), typeof(src.buf),
        1, 3, 4;
        dstPos=(1, 1, 1), srcPos=(2, 1, 1),
        dstPitch=1 * sizeof(Int), dstWidth=1, dstHeight=ny,
        srcPitch=nx * sizeof(Int), srcWidth=1, srcHeight=ny)

    display(Array(src)[2, :, :]); println()
    # display(Array(dst)[1, :, :]); println()
    display(Array(dst)); println()
    return
end
