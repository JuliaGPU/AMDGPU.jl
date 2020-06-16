@testset "Global" begin

function kernel(X)
    ptr = AMDGPUnative.get_global_pointer(Val(:myglobal), Float32)
    Base.unsafe_store!(ptr, 3f0)
    nothing
end

hk = AMDGPUnative.rocfunction(kernel, Tuple{Int32})
exe = hk.mod.exe
gbl = HSARuntime.get_global(exe.exe, :myglobal)
gbl_ptr = Base.unsafe_convert(Ptr{Float32}, gbl.ptr)
@test Base.unsafe_load(gbl_ptr) == 0f0
Base.unsafe_store!(gbl_ptr, 2f0)
@test Base.unsafe_load(gbl_ptr) == 2f0

dev = AMDGPUnative.default_device()
queue = AMDGPUnative.default_queue(dev)
kern = AMDGPUnative.create_kernel(dev, exe, hk.fun.entry, (Int32(3),))
signal = AMDGPUnative.create_event()
AMDGPUnative.launch_kernel(queue, kern, signal; groupsize=(1,1,1), gridsize=(1,1,1))
wait(signal)
@test Base.unsafe_load(gbl_ptr) == 3f0

end
