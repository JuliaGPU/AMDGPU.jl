group = addgroup!(SUITE, "stencil")

# 7-point 3D diffusion step on the interior. Short and bandwidth-bound, so it
# is dominated by per-wave entry costs (workgroupDim/gridDim reads) and, in
# the checked variant, by the bounds-check control flow.
function diffusion3d!(T2, T, Ci, lam, dx, dy, dz)
    ix = (workgroupIdx().x - Int32(1)) * workgroupDim().x + workitemIdx().x
    iy = (workgroupIdx().y - Int32(1)) * workgroupDim().y + workitemIdx().y
    iz = (workgroupIdx().z - Int32(1)) * workgroupDim().z + workitemIdx().z
    nx, ny, nz = size(T)
    if Int32(1) < ix < nx && Int32(1) < iy < ny && Int32(1) < iz < nz
        @inbounds T2[ix, iy, iz] = T[ix, iy, iz] + lam * Ci[ix, iy, iz] * (
            (T[ix - 1, iy, iz] - 2 * T[ix, iy, iz] + T[ix + 1, iy, iz]) / (dx * dx) +
            (T[ix, iy - 1, iz] - 2 * T[ix, iy, iz] + T[ix, iy + 1, iz]) / (dy * dy) +
            (T[ix, iy, iz - 1] - 2 * T[ix, iy, iz] + T[ix, iy, iz + 1]) / (dz * dz))
    end
    return
end

function diffusion3d_checked!(T2, T, Ci, lam, dx, dy, dz)
    ix = (workgroupIdx().x - Int32(1)) * workgroupDim().x + workitemIdx().x
    iy = (workgroupIdx().y - Int32(1)) * workgroupDim().y + workitemIdx().y
    iz = (workgroupIdx().z - Int32(1)) * workgroupDim().z + workitemIdx().z
    nx, ny, nz = size(T)
    if Int32(1) < ix < nx && Int32(1) < iy < ny && Int32(1) < iz < nz
        T2[ix, iy, iz] = T[ix, iy, iz] + lam * Ci[ix, iy, iz] * (
            (T[ix - 1, iy, iz] - 2 * T[ix, iy, iz] + T[ix + 1, iy, iz]) / (dx * dx) +
            (T[ix, iy - 1, iz] - 2 * T[ix, iy, iz] + T[ix, iy + 1, iz]) / (dy * dy) +
            (T[ix, iy, iz - 1] - 2 * T[ix, iy, iz] + T[ix, iy, iz + 1]) / (dz * dz))
    end
    return
end

st_n = 256
st_T = AMDGPU.rand(Float64, st_n, st_n, st_n)
st_T2 = similar(st_T)
st_Ci = AMDGPU.ones(Float64, st_n, st_n, st_n)
st_groupsize = (64, 2, 2)
st_grid = cld.((st_n, st_n, st_n), st_groupsize)
group["diffusion3d"] = @async_benchmarkable(
    @roc groupsize=$st_groupsize gridsize=$st_grid maxthreads=256 $diffusion3d!(
        $st_T2, $st_T, $st_Ci, 1.0, 0.1, 0.1, 0.1))
group["diffusion3d_checked"] = @async_benchmarkable(
    @roc groupsize=$st_groupsize gridsize=$st_grid maxthreads=256 $diffusion3d_checked!(
        $st_T2, $st_T, $st_Ci, 1.0, 0.1, 0.1, 0.1))
