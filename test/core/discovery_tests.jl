using Test
using AMDGPU

# Pure-filesystem tests for ROCm library discovery against synthetic trees
# (no real ROCm install or GPU needed). Two kinds of test live here:
#
#   * "behaviour"  — layout-independent properties of the discovery functions.
#                    Version numbers in the fixtures are representative, not
#                    special-cased; these should hold for any ROCm generation
#                    that nests libraries under a versioned subdir.
#   * "layout pins" — concrete on-disk locations AMD chose for a given ROCm
#                    generation. When a future ROCm moves these, ADD the new
#                    path (keep the old for back-compat) rather than editing
#                    in place.
const Disc = AMDGPU.ROCmDiscovery

# The `core-*` fallback and the `libamdhip64` naming are Linux-specific.
if Sys.islinux()

hip_lib(dir) = (mkpath(dir); touch(joinpath(dir, "libamdhip64.so")); dir)
hip_lib_versioned(dir) = (mkpath(dir); touch(joinpath(dir, "libamdhip64.so.7")); dir)

@testset "ROCm discovery" begin

@testset "behaviour: rocm_core_dirs orders newest-first" begin
    mktempdir() do root
        @test isempty(Disc.rocm_core_dirs(root))
        mkpath(joinpath(root, "core-7.2"))
        mkpath(joinpath(root, "core-7.14"))
        mkpath(joinpath(root, "core"))       # unversioned -> ignored
        touch(joinpath(root, "core-junk"))   # not a dir / not a version
        dirs = Disc.rocm_core_dirs(root)
        @test length(dirs) == 2
        @test basename(dirs[1]) == "core-7.14"   # newest first
        @test basename(dirs[2]) == "core-7.2"
    end
    @test isempty(Disc.rocm_core_dirs(joinpath(tempdir(), "no-such-dir-xyz")))
end

@testset "behaviour: flat lib/ is found" begin
    mktempdir() do root
        hip_lib(joinpath(root, "lib"))
        @test Disc.check_rocm_path(root) == joinpath(root, "lib")
    end
end

@testset "behaviour: flat lib/ via compat symlink resolves" begin
    mktempdir() do root
        real = hip_lib(joinpath(root, "core-7.14", "lib"))
        symlink(real, joinpath(root, "lib"))
        # The `<root>/lib` probe resolves through the symlink and wins before
        # the versioned-core fallback is reached.
        @test Disc.check_rocm_path(root) == joinpath(root, "lib")
    end
end

@testset "behaviour: fall back to versioned core-*/lib" begin
    mktempdir() do root
        hip_lib(joinpath(root, "core-7.14", "lib"))
        @test Disc.check_rocm_path(root) == joinpath(root, "core-7.14", "lib")
    end
end

@testset "behaviour: match versioned-only soname" begin
    mktempdir() do root
        # Minimal install may ship only `libamdhip64.so.N`, no `-dev` symlink.
        hip_lib_versioned(joinpath(root, "core-7.14", "lib"))
        @test Disc.check_rocm_path(root) == joinpath(root, "core-7.14", "lib")
    end
end

@testset "behaviour: newest core-* wins" begin
    mktempdir() do root
        hip_lib(joinpath(root, "core-7.2", "lib"))
        hip_lib(joinpath(root, "core-7.14", "lib"))
        @test Disc.check_rocm_path(root) == joinpath(root, "core-7.14", "lib")
    end
end

@testset "behaviour: nothing found returns empty" begin
    mktempdir() do root
        @test Disc.check_rocm_path(root) == ""
    end
end

@testset "layout pins: device-libs directories" begin
    withenv(
        "ROCM_PATH" => nothing,
        "HIP_DEVICE_LIB_PATH" => nothing,
        "DEVICE_LIB_PATH" => nothing,
    ) do
        # Known bitcode locations, one row per ROCm generation. Append new
        # rows here when the layout shifts; do not edit existing ones.
        for (label, subdir, fname) in (
            ("classic <libdir>/amdgcn/bitcode",     ("amdgcn", "bitcode"),         "hip.bc"),
            ("7.14 <libdir>/llvm/amdgcn/bitcode",   ("llvm", "amdgcn", "bitcode"), "hip.bc"),
            ("7.14 hip.amdgcn.bc filename variant", ("llvm", "amdgcn", "bitcode"), "hip.amdgcn.bc"),
        )
            @testset "$label" begin
                mktempdir() do libdir
                    bc = joinpath(libdir, subdir...)
                    mkpath(bc); touch(joinpath(bc, fname))
                    @test Disc.find_device_libs(libdir) == bc
                end
            end
        end
    end
end

@testset "behaviour: KFD GPU nodes" begin
    mktempdir() do dir
        root = joinpath(dir, "nodes")
        dri = mkpath(joinpath(dir, "dri"))
        function node(id, props; render=nothing)
            mkpath(joinpath(root, id))
            write(joinpath(root, id, "properties"), props)
            render === nothing || touch(joinpath(dri, "renderD$render"))
        end
        node("0", "cpu_cores_count 16\nsimd_count 0\n")
        node("10", "simd_count 4\ngfx_target_version 100306\ndrm_render_minor 129\n" *
                   "unique_id 18446744073709551615\n"; render=129)
        node("2", "simd_count 8\ngfx_target_version 110000\ndrm_render_minor 128\n" *
                  "location_id 3584\n"; render=128)
        # GPUs hidden from us, e.g., by the cgroup device controller
        mkpath(joinpath(root, "3"))
        node("4", "simd_count 8\ngfx_target_version 110000\ndrm_render_minor 130\n")

        nodes = Disc.kfd_gpu_nodes(root; dri)
        @test [node["gfx_target_version"] for node in nodes] == [110000, 100306]
        @test nodes[1]["location_id"] == 3584
        @test nodes[2]["unique_id"] == typemax(UInt64)
    end
    @test isempty(Disc.kfd_gpu_nodes(joinpath(tempdir(), "no-such-dir-xyz")))
end

@testset "behaviour: visible GPUs" begin
    gpus = [Dict("location_id" => 1, "unique_id" => 0x1111222233334444),
            Dict("location_id" => 2, "unique_id" => 0x111199990000abcd),
            Dict("location_id" => 3)]
    visible(env...) = [gpu["location_id"] for gpu in Disc.visible_gpus(gpus, Dict(env...))]

    @test visible() == [1, 2, 3]

    # ROCr: indices or unique UUID prefixes, up to the first invalid or repeated entry
    @test visible("ROCR_VISIBLE_DEVICES" => "2,0") == [3, 1]
    @test visible("ROCR_VISIBLE_DEVICES" => "") == []
    @test visible("ROCR_VISIBLE_DEVICES" => " 1 ,0,") == [2, 1]
    @test visible("ROCR_VISIBLE_DEVICES" => "0x2,01") == [3, 2]
    @test visible("ROCR_VISIBLE_DEVICES" => "08") == []
    @test visible("ROCR_VISIBLE_DEVICES" => "0,5,1") == [1]
    @test visible("ROCR_VISIBLE_DEVICES" => "1,1,2") == [2]
    @test visible("ROCR_VISIBLE_DEVICES" => "gpu-111199990000ABCD") == [2]
    @test visible("ROCR_VISIBLE_DEVICES" => "GPU-11112,1") == [1, 2]
    @test visible("ROCR_VISIBLE_DEVICES" => "GPU-1111") == []

    # HIP: exact indices or parts of UUIDs, skipping repeated entries
    @test visible("HIP_VISIBLE_DEVICES" => "1") == [2]
    @test visible("HIP_VISIBLE_DEVICES" => "1,1,0") == [2, 1]
    @test visible("HIP_VISIBLE_DEVICES" => " 1") == []
    @test visible("HIP_VISIBLE_DEVICES" => "0,x,1") == [1]
    @test visible("HIP_VISIBLE_DEVICES" => "GPU-11119999") == [2]
    @test visible("CUDA_VISIBLE_DEVICES" => "2") == [3]
    @test visible("HIP_VISIBLE_DEVICES" => "0", "CUDA_VISIBLE_DEVICES" => "2") == [1]
    @test visible("HIP_VISIBLE_DEVICES" => "", "CUDA_VISIBLE_DEVICES" => "2") == [3]

    # HIP picks from the GPUs that ROCr exposes
    @test visible("ROCR_VISIBLE_DEVICES" => "2,1", "HIP_VISIBLE_DEVICES" => "0") == [3]
end

@testset "behaviour: system-scope fences" begin
    igpu = Dict("simd_count" => 4, "gfx_target_version" => 100306,
                "domain" => 0, "location_id" => 0x0e00)
    dgpu = Dict("simd_count" => 48, "gfx_target_version" => 110000,
                "domain" => 1, "location_id" => 0x0c11)
    config(gpus; env=Dict(), preference="auto") =
        Disc.system_scope_fences_config(gpus; env, preference)

    # "auto" only uses them when every GPU needs them
    @test config([igpu]) == ([(0, 0x0e, 0)], true, :auto)
    @test config([igpu, dgpu]) == ([(0, 0x0e, 0)], false, :auto)
    @test config([dgpu]) == ([], false, :auto)
    @test config([]) == ([], false, :auto)

    @test config([igpu, dgpu]; preference=true) == ([(0, 0x0e, 0)], true, :preference)
    @test config([igpu]; preference=false) == ([(0, 0x0e, 0)], false, :preference)

    # `AMD_OPT_FLUSH` is parsed with `atoi`
    for (value, enabled) in ("0" => true, "1" => false, "" => true, "false" => true,
                             " 00" => true, "10" => false)
        env = Dict("AMD_OPT_FLUSH" => value)
        @test config([dgpu]; env, preference=false) == ([], enabled, :environment)
    end
end

end # @testset "ROCm discovery"

end # Sys.islinux()
