@testset "Globals" begin

function kernel(X)
    ptr = AMDGPU.get_global_pointer(Val(:myglobal), Float32)
    Base.unsafe_store!(ptr, 3f0)
    nothing
end

mygbl_ptr = Ref{Any}()
function gbl_init(gbl, mod, dev)
    gbl_ptr = Base.unsafe_convert(Ptr{Float32}, gbl.ptr)
    mygbl_ptr[] = gbl_ptr

    @test Base.unsafe_load(gbl_ptr) == 0f0
    Base.unsafe_store!(gbl_ptr, 2f0)
    @test Base.unsafe_load(gbl_ptr) == 2f0
end

wait(@roc groupsize=1 global_hooks=(myglobal=gbl_init,) kernel(Int32(1)))
@test Base.unsafe_load(mygbl_ptr[]) == 3f0

end
