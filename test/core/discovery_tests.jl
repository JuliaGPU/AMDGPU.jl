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

end # @testset "ROCm discovery"

end # Sys.islinux()
