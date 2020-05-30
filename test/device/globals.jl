@testset "Globals" begin

function kernel(X)
    ptr = AMDGPUnative.get_global_pointer(Val(:myglobal), Float32)
    Base.unsafe_store!(ptr, 3f0)
    nothing
end

hk = AMDGPUnative.rocfunction(kernel, Tuple{Int32})
gbl = HSARuntime.get_global(hk.mod.exe, :myglobal)
gbl_ptr = Base.unsafe_convert(Ptr{Float32}, gbl.ptr)

@test Base.unsafe_load(gbl_ptr) == 0f0
Base.unsafe_store!(gbl_ptr, 2f0)
@test Base.unsafe_load(gbl_ptr) == 2f0

wait(@roc groupsize=1 kernel(Int32(1)))
@test Base.unsafe_load(gbl_ptr) == 3f0

end
