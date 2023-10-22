@testset "Workgroup synchronization" begin

function test_sync_workgroup_count!(
    sync_test,
    all_workitems_zero,
    all_workitems_one,
    odd_workitems_one,
    all_workitems_minus_one,
    all_workitems_id,
)
    block_size = workgroupDim().x

    # First block index starts with 0.
    # Second block index starts with `block_size`.
    i = ifelse(workgroupIdx().x == 1,
        workitemIdx().x, (block_size + workitemIdx().x))

    sm = @ROCStaticLocalArray(Int32, 2, false)
    if workitemIdx().x == 1
        sm[1] = 10
    elseif workitemIdx().x == 2
        sm[2] = 20
    end
    Device.sync_workgroup_count(Cint(1))
    sync_test[i] = sm[1] + sm[2]

    # All workitems pass 0, result should be 0.
    all_workitems_zero[i] = Device.sync_workgroup_count(Cint(0))
    # All workitems pass 1, result should be `block_size`.
    all_workitems_one[i] = Device.sync_workgroup_count(Cint(1))
    # Odd workitems pass 1, result should be `block_size ÷ 2`.
    odd_workitems_one[i] = Device.sync_workgroup_count(Cint((workitemIdx().x - 1) % 2))
    # All workitems pass -1, result should be `block_size`.
    all_workitems_minus_one[i] = Device.sync_workgroup_count(Cint(-1))
    # All workitems pass its id (starting from 0), result should be `block_size - 1`.
    all_workitems_id[i] = Device.sync_workgroup_count(Cint(workitemIdx().x - 1))
    return
end

@testset "sync_workgroup_count: block_size=$block_size" for block_size in (
    10, 40, 70, 240, 723, 32, 64, 128, 256, 512, 1024,
)
    sync_test = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_zero = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_one = ROCArray{Int32}(undef, 2 * block_size)
    odd_workitems_one = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_minus_one = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_id = ROCArray{Int32}(undef, 2 * block_size)

    @roc groupsize=block_size gridsize=2 test_sync_workgroup_count!(
        sync_test, all_workitems_zero, all_workitems_one, odd_workitems_one,
        all_workitems_minus_one, all_workitems_id)

    @test all(Array(sync_test) .== 30)
    @test all(Array(all_workitems_zero) .== 0)
    @test all(Array(all_workitems_one) .== block_size)
    @test all(Array(odd_workitems_one) .== block_size ÷ 2)
    @test all(Array(all_workitems_minus_one) .== block_size)
    @test all(Array(all_workitems_id) .== block_size - 1)

    AMDGPU.unsafe_free!(sync_test)
    AMDGPU.unsafe_free!(all_workitems_zero)
    AMDGPU.unsafe_free!(all_workitems_one)
    AMDGPU.unsafe_free!(odd_workitems_one)
    AMDGPU.unsafe_free!(all_workitems_minus_one)
    AMDGPU.unsafe_free!(all_workitems_id)
end

function test_sync_workgroup_and!(
    sync_test,
    all_workitems_zero,
    all_workitems_one,
    one_workitem_zero,
    all_workitems_minus_one,
)
    block_size = workgroupDim().x

    # First block index starts with 0.
    # Second block index starts with `block_size`.
    i = workgroupIdx().x == 1 ? workitemIdx().x : (block_size + workitemIdx().x)

    sm = @ROCStaticLocalArray(Int32, 2, false)
    if workitemIdx().x == 1
        sm[1] = 10
    elseif workitemIdx().x == 2
        sm[2] = 20
    end
    Device.sync_workgroup_and(Cint(1))
    sync_test[i] = sm[1] + sm[2]

    # All workitems pass 0, result should be 0.
    all_workitems_zero[i] = Device.sync_workgroup_and(Cint(0))
    # All workitems pass 1, result should be `block_size`.
    all_workitems_one[i] = Device.sync_workgroup_and(Cint(1))
    # Workitem 0 passes 0, others - 1.
    one_workitem_zero[i] = Device.sync_workgroup_and(Cint(workitemIdx().x == 1 ? 0 : 1))
    # All workitems pass -1, result should be 1.
    all_workitems_minus_one[i] = Device.sync_workgroup_and(Cint(-1))
    return
end

@testset "sync_workgroup_and: block_size=$block_size" for block_size in (
    10, 40, 70, 240, 723, 32, 64, 128, 256, 512, 1024,
)
    sync_test = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_zero = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_one = ROCArray{Int32}(undef, 2 * block_size)
    one_workitem_zero = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_minus_one = ROCArray{Int32}(undef, 2 * block_size)

    @roc groupsize=block_size gridsize=2 test_sync_workgroup_and!(
        sync_test, all_workitems_zero, all_workitems_one,
        one_workitem_zero, all_workitems_minus_one)

    @test all(Array(sync_test) .== 30)
    @test all(Array(all_workitems_zero) .== 0)
    @test all(Array(all_workitems_one) .== 1)
    @test all(Array(one_workitem_zero) .== 0)
    @test all(Array(all_workitems_minus_one) .== 1)

    AMDGPU.unsafe_free!(sync_test)
    AMDGPU.unsafe_free!(all_workitems_zero)
    AMDGPU.unsafe_free!(all_workitems_one)
    AMDGPU.unsafe_free!(one_workitem_zero)
    AMDGPU.unsafe_free!(all_workitems_minus_one)
end

function test_sync_workgroup_or!(
    sync_test,
    all_workitems_zero,
    all_workitems_one,
    one_workitem_zero,
    all_workitems_minus_one,
)
    block_size = workgroupDim().x

    # First block index starts with 0.
    # Second block index starts with `block_size`.
    i = workgroupIdx().x == 1 ? workitemIdx().x : (block_size + workitemIdx().x)

    sm = @ROCStaticLocalArray(Int32, 2, false)
    if workitemIdx().x == 1
        sm[1] = 10
    elseif workitemIdx().x == 2
        sm[2] = 20
    end
    Device.sync_workgroup_or(Cint(1))
    sync_test[i] = sm[1] + sm[2]

    # All workitems pass 0, result should be 0.
    all_workitems_zero[i] = Device.sync_workgroup_or(Cint(0))
    # All workitems pass 1, result should be `block_size`.
    all_workitems_one[i] = Device.sync_workgroup_or(Cint(1))
    # Workitem 0 passes 1, others - 0.
    one_workitem_zero[i] = Device.sync_workgroup_or(Cint(workitemIdx().x == 1 ? 1 : 0))
    # All workitems pass -1, result should be 1.
    all_workitems_minus_one[i] = Device.sync_workgroup_or(Cint(-1))
    return
end

@testset "sync_workgroup_and: block_size=$block_size" for block_size in (
    10, 40, 70, 240, 723, 32, 64, 128, 256, 512, 1024,
)
    sync_test = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_zero = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_one = ROCArray{Int32}(undef, 2 * block_size)
    one_workitem_zero = ROCArray{Int32}(undef, 2 * block_size)
    all_workitems_minus_one = ROCArray{Int32}(undef, 2 * block_size)

    @roc groupsize=block_size gridsize=2 test_sync_workgroup_or!(
        sync_test, all_workitems_zero, all_workitems_one,
        one_workitem_zero, all_workitems_minus_one)

    @test all(Array(sync_test) .== 30)
    @test all(Array(all_workitems_zero) .== 0)
    @test all(Array(all_workitems_one) .== 1)
    @test all(Array(one_workitem_zero) .== 1)
    @test all(Array(all_workitems_minus_one) .== 1)

    AMDGPU.unsafe_free!(sync_test)
    AMDGPU.unsafe_free!(all_workitems_zero)
    AMDGPU.unsafe_free!(all_workitems_one)
    AMDGPU.unsafe_free!(one_workitem_zero)
    AMDGPU.unsafe_free!(all_workitems_minus_one)
end

end
