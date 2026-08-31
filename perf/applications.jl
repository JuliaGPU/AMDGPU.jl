group = addgroup!(SUITE, "applications")

# Ports of rocm-examples/Applications kernels. Integer widths follow HIP
# (int/unsigned -> Int32/UInt32). The multi-launch entries (prefix_sum,
# bitonic_sort, floyd_warshall) track host launch overhead and per-wave kernel
# entry costs; histogram tracks LDS byte counters; convolution kernarg reads.
const I32 = Int32
@inline app_tid() = I32(workitemIdx().x) - I32(1)
@inline app_bid() = I32(workgroupIdx().x) - I32(1)
@inline app_bdim() = I32(workgroupDim().x)
@inline app_tidy() = I32(workitemIdx().y) - I32(1)
@inline app_bidy() = I32(workgroupIdx().y) - I32(1)
@inline app_bdimy() = I32(workgroupDim().y)

function histogram256_block(data, block_bins, items_per_thread::I32)
    thread_id = app_tid(); block_id = app_bid(); block_size = app_bdim(); bin_size = I32(256)
    thread_bins = AMDGPU.Device.@ROCDynamicLocalArray(UInt8, (256 * 128,), false)
    b_bits_length = (trailing_zeros(block_size) + I32(1)) - I32(3)
    sh_thread_id = ((thread_id & ((I32(1) << b_bits_length) - I32(1))) << 2) | (thread_id >> b_bits_length)
    i = I32(0)
    while i < bin_size; @inbounds thread_bins[i + bin_size * sh_thread_id + 1] = 0x00; i += I32(1); end
    sync_workgroup()
    i = I32(0)
    while i < items_per_thread
        @inbounds value = I32(data[(block_id * block_size + thread_id) * items_per_thread + i + 1])
        @inbounds thread_bins[value * block_size + sh_thread_id + 1] += 0x01
        i += I32(1)
    end
    sync_workgroup()
    bins_per_thread = bin_size ÷ block_size
    i = I32(0)
    while i < bins_per_thread
        bin_sh_id = i * block_size + sh_thread_id
        bin_acc = UInt32(0); j = I32(0)
        while j < block_size; @inbounds bin_acc += thread_bins[bin_sh_id * block_size + j + 1]; j += I32(1); end
        @inbounds block_bins[block_id * bin_size + bin_sh_id + 1] = bin_acc
        i += I32(1)
    end
    return
end

function block_prefix_sum(d_data, size::I32, offset::I32)
    thread_id = app_tid(); block_id = app_bid(); block_size = app_bdim()
    x = (offset * (I32(2) * (block_id * block_size + thread_id) + I32(1))) - I32(1)
    block = AMDGPU.Device.@ROCDynamicLocalArray(Float32, (256,), false)
    x < size && (@inbounds block[2 * thread_id + 1] = d_data[x + 1])
    x + offset < size && (@inbounds block[2 * thread_id + 2] = d_data[x + offset + 1])
    tree_offset = I32(1); tree_size = size >> 1
    while tree_size > 0
        sync_workgroup()
        if thread_id < tree_size
            from = tree_offset * (I32(2) * thread_id + I32(1)) - I32(1)
            to = tree_offset * (I32(2) * thread_id + I32(2)) - I32(1)
            @inbounds block[to + 1] += block[from + 1]
        end
        tree_offset <<= 1; tree_size >>= 1
    end
    if size > 2
        tree_offset < size && (tree_offset <<= 1)
        max_thread = tree_offset >> 1; tree_size = I32(0)
        while tree_size < max_thread
            tree_size += I32(1); tree_offset >>= 1
            sync_workgroup()
            if thread_id < tree_size
                from = tree_offset * (thread_id + I32(1)) - I32(1); to = from + (tree_offset >> 1)
                @inbounds block[to + 1] += block[from + 1]
            end
            tree_size <<= 1
        end
    end
    sync_workgroup()
    x < size && (@inbounds d_data[x + 1] = block[2 * thread_id + 1])
    x + offset < size && (@inbounds d_data[x + offset + 1] = block[2 * thread_id + 2])
    return
end

function device_prefix_sum(buffer, size::I32, offset::I32)
    thread_id = app_tid(); block_size = app_bdim(); block_id = app_bid()
    sorted_blocks = offset ÷ block_size
    unsorted_block_id = block_id + (block_id ÷ ((offset << 1) - sorted_blocks) + I32(1)) * sorted_blocks
    x = unsorted_block_id * block_size + thread_id
    if ((x + I32(1)) % offset != 0) && (x < size)
        @inbounds buffer[x + 1] += buffer[x - (x % offset + I32(1)) + 1]
    end
    return
end

# 5x5 mask passed as a kernel argument (kernarg constant memory)
function convolution_kernel(input, output, width::Int, height::Int, mask::NTuple{25, Float32})
    x = Int(app_bdim()) * Int(app_bid()) + Int(app_tid())
    y = Int(app_bdimy()) * Int(app_bidy()) + Int(app_tidy())
    padded_width = width + 4
    (x >= width || y >= height) && return
    sum = 0f0; convolution_base = y * padded_width + x
    for mask_index_y in 0:4, mask_index_x in 0:4
        mask_index = mask_index_y * 5 + mask_index_x
        convolution_offset = mask_index_y * padded_width + mask_index_x
        @inbounds sum += input[convolution_base + convolution_offset + 1] * mask[mask_index + 1]
    end
    @inbounds output[y * width + x + 1] = sum
    return
end

function bitonic_sort_kernel(array, step::UInt32, stage::UInt32, sort_increasing::Bool)
    thread_id = UInt32(app_bid()) * UInt32(app_bdim()) + UInt32(app_tid())
    same_order_block_width = UInt32(1) << step
    pair_distance = UInt32(1) << (step - stage)
    sorted_block_width = UInt32(2) * pair_distance
    left_id = (thread_id % pair_distance) + (thread_id ÷ pair_distance) * sorted_block_width
    right_id = left_id + pair_distance
    @inbounds left_element = array[left_id + 1]
    @inbounds right_element = array[right_id + 1]
    (thread_id ÷ same_order_block_width) % UInt32(2) == 1 && (sort_increasing = !sort_increasing)
    greater = left_element > right_element ? left_element : right_element
    lesser = left_element > right_element ? right_element : left_element
    @inbounds array[left_id + 1] = sort_increasing ? lesser : greater
    @inbounds array[right_id + 1] = sort_increasing ? greater : lesser
    return
end

function floyd_warshall_kernel(adj, nxt, nodes::UInt32, k::UInt32)
    x = app_bid() * app_bdim() + app_tid(); y = app_bidy() * app_bdimy() + app_tidy()
    n = I32(nodes); kk = I32(k)
    @inbounds d_x_y = I32(adj[y * n + x + 1])
    @inbounds d_x_k_y = I32(adj[y * n + kk + 1]) + I32(adj[kk * n + x + 1])
    if d_x_k_y < d_x_y
        @inbounds adj[y * n + x + 1] = UInt32(d_x_k_y)
        @inbounds nxt[y * n + x + 1] = k
    end
    return
end

hist_size = 1 << 26
hist_items_per_thread = 1024
hist_tpb = 128
hist_blocks = hist_size ÷ (hist_items_per_thread * hist_tpb)
hist_data = ROCArray(UInt8[((i * 2654435761) >> 24) & 0xff for i in 0:hist_size-1])
hist_bins = AMDGPU.zeros(UInt32, 256 * hist_blocks)
group["histogram"] = @async_benchmarkable(
    @roc gridsize=$hist_blocks groupsize=$hist_tpb shmem=256 * 128 $histogram256_block(
        $hist_data, $hist_bins, I32($hist_items_per_thread)))

ps_size = 1 << 22
ps_data = AMDGPU.ones(Float32, ps_size)
function prefix_sum_sweep!(d, size)
    tpb = 128; items_per_block = tpb * 2
    offset = 1
    while offset < size
        data_size = size ÷ offset
        if size ÷ offset > 1
            total_threads = (data_size + 1) ÷ 2
            total_threads = cld(total_threads, tpb) * tpb
            @roc gridsize=total_threads ÷ tpb groupsize=tpb shmem=sizeof(Float32) * 2 * tpb block_prefix_sum(d, I32(size), I32(offset))
        end
        if offset > 1
            total_threads = size - offset
            total_threads -= (total_threads ÷ (offset * items_per_block)) * offset
            total_threads = cld(total_threads, tpb) * tpb
            @roc gridsize=total_threads ÷ tpb groupsize=tpb device_prefix_sum(d, I32(size), I32(offset))
        end
        offset *= items_per_block
    end
end
group["prefix_sum"] = @async_benchmarkable($prefix_sum_sweep!($ps_data, $ps_size))

conv_width = 2048; conv_height = 2048
conv_mask = (1f0,3f0,0f0,-2f0,0f0, 1f0,4f0,0f0,-8f0,-4f0, 2f0,7f0,0f0,-12f0,0f0,
             2f0,3f0,1.5f0,-8f0,-4f0, 0f0,1f0,0f0,-2f0,0f0)
conv_in = AMDGPU.rand(Float32, (conv_width + 4) * (conv_height + 4)) .* 256
conv_out = AMDGPU.zeros(Float32, conv_width * conv_height)
group["convolution"] = @async_benchmarkable(
    @roc gridsize=(cld($conv_width, 32), cld($conv_height, 32)) groupsize=(32, 32) $convolution_kernel(
        $conv_in, $conv_out, $conv_width, $conv_height, $conv_mask))

bitonic_steps = 20
bitonic_data = ROCArray(UInt32.(rand(rng, 0:9, 1 << bitonic_steps)))
function bitonic_sort!(d, steps)
    gt = length(d) ÷ 2; lt = 256
    for i in 0:steps-1, j in 0:i
        @roc gridsize=gt ÷ lt groupsize=lt bitonic_sort_kernel(d, UInt32(i), UInt32(j), true)
    end
end
group["bitonic_sort"] = @async_benchmarkable($bitonic_sort!($bitonic_data, $bitonic_steps))

fw_nodes = 1024
fw_adj = UInt32.(rand(rng, 1:100, fw_nodes * fw_nodes))
for i in 0:fw_nodes-1; fw_adj[i * fw_nodes + i + 1] = 0; end
fw_dadj = ROCArray(fw_adj)
fw_dnxt = AMDGPU.zeros(UInt32, fw_nodes * fw_nodes)
function floyd_warshall!(adj, nxt, nodes)
    bs = 16
    for k in 0:nodes-1
        @roc gridsize=(nodes ÷ bs, nodes ÷ bs) groupsize=(bs, bs) floyd_warshall_kernel(adj, nxt, UInt32(nodes), UInt32(k))
    end
end
group["floyd_warshall"] = @async_benchmarkable($floyd_warshall!($fw_dadj, $fw_dnxt, $fw_nodes))
