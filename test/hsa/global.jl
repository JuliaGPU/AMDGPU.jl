@testset "Global" begin

function kernel(X)
    ptr = AMDGPU.get_global_pointer(Val(:myglobal), Float32)
    Base.unsafe_store!(ptr, 3f0)
    nothing
end

hk = AMDGPU.rocfunction(kernel, Tuple{Int32})
exe = hk.mod.exe
gbl = AMDGPU.get_global(exe.exe, :myglobal)
gbl_ptr = Base.unsafe_convert(Ptr{Float32}, gbl.ptr)
@test Base.unsafe_load(gbl_ptr) == 0f0
Base.unsafe_store!(gbl_ptr, 2f0)
@test Base.unsafe_load(gbl_ptr) == 2f0

dev = AMDGPU.default_device()
queue = AMDGPU.default_queue(dev)
kern = AMDGPU.create_kernel(dev, exe, hk.fun.entry, (Int32(3),))
signal = AMDGPU.create_event(hk.mod.exe)
AMDGPU.launch_kernel(queue, kern, signal; groupsize=(1,1,1), gridsize=(1,1,1))
wait(signal)
@test Base.unsafe_load(gbl_ptr) == 3f0

end
