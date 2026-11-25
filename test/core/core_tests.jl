using Test
using Random
using AMDGPU
using AMDGPU: HIP, Runtime, Device, Mem

@testset "core" begin

@testset "Functional" begin
    @test AMDGPU.has_rocm_gpu() isa Bool
    @test AMDGPU.functional() isa Bool
end

@testset "versioninfo" begin
    # rocSPARSE is the only library whose version query needs a handle (#920).
    if AMDGPU.functional(:rocsparse)
        @test AMDGPU.rocSPARSE.version() isa VersionNumber
    end
    # Having touched rocSPARSE, nothing from a ROCm outside the artifact may be
    # loaded: that mixture is silent until something downstream misbehaves.
    @test isempty(AMDGPU.ROCm_Runtime.foreign_libraries())
end

@testset "versioninfo path shortening" begin
    depot = first(Base.DEPOT_PATH)
    hash = "0123456789abcdef0123456789abcdef01234567"
    @test AMDGPU._shortpath(joinpath(depot, "artifacts", hash, "lib", "libfoo.so")) ==
        "@artifacts/01234567…/lib/libfoo.so"
    @test AMDGPU._shortpath(joinpath(depot, "artifacts", hash)) == "@artifacts/01234567…"
    uuid = "21141c5a-9bdb-4563-92ae-f87d6854732e"
    @test AMDGPU._shortpath(joinpath(depot, "scratchspaces", uuid, "device_libs")) ==
        "@scratchspaces/21141c5a…/device_libs"
    outside = joinpath(depot, "packages", "Foo", "lib", "libfoo.so")
    @test AMDGPU._shortpath(outside) == outside
    @test AMDGPU._shortpath("/opt/rocm/lib/libamdhip64.so") == "/opt/rocm/lib/libamdhip64.so"

    out = sprint(AMDGPU.versioninfo)
    @test occursin("- ROCm_Runtime: ", out)
    @test occursin("- ROCm_Runtime_Discovery: ", out)
    @test AMDGPU.local_rocm || occursin(r"Artifact platform tags: rocm = \S+, rocm_arch = \S+", out)
end

@testset "versioninfo `_ver` crash guard" begin
    # A library whose version query throws on a broken/mismatched install
    # (e.g. a missing symbol in an ABI-mismatched .so) must not take down
    # `versioninfo()` -- it should degrade to `"err"`, same as rocSPARSE's
    # isolated probe does for a crash.
    @test AMDGPU._ver(true, () -> error("boom")) == "err"
    @test AMDGPU._ver(true, () -> "1.2.3") == "1.2.3"
    @test AMDGPU._ver(false, () -> error("never called")) == "-"

    # The exception is handed to `on_error` so `versioninfo()` can report it.
    errs = Pair{Symbol, String}[]
    @test AMDGPU._ver(true, () -> error("boom");
        on_error = e -> push!(errs, :lib => sprint(showerror, e))) == "err"
    @test errs == [:lib => "boom"]
end

@testset "HIP initialization failure" begin
    # a failed HIP start flags HIP as not functional, the package still loads (#1249)
    failing() = throw(HIP.HIPError(HIP.hipErrorNoDevice))
    try
        @test (@test_logs (:warn, r"HIP could not be initialized") match_mode=:any AMDGPU.init_hip!(failing)) == false
        @test !AMDGPU.functional(:hip)
        @test !AMDGPU.functional()
        @test !AMDGPU.has_rocm_gpu()
        out = sprint(AMDGPU.versioninfo)
        @test occursin("HIP initialization failed: HIPError(code hipErrorNoDevice", out)
        @test !occursin("AMDGPU devices", out)
    finally
        AMDGPU.HIP_INIT_ERROR[] = nothing
    end
    @test AMDGPU.functional(:hip)

    # for real: a fresh process without a visible GPU
    if Sys.islinux()
        function load(must_load)
            code = """
            using AMDGPU
            print(AMDGPU.functional(:hip), " ", AMDGPU.functional(), " ", AMDGPU.has_rocm_gpu())
            AMDGPU.versioninfo(devnull)
            """
            cmd = `$(Base.julia_cmd()) --project=$(Base.active_project()) -e $code`
            cmd = addenv(cmd, "ROCR_VISIBLE_DEVICES" => "",
                "JULIA_AMDGPU_HIP_MUST_LOAD" => must_load)
            out, err = tempname(), tempname()
            proc = run(pipeline(cmd; stdout=out, stderr=err); wait=false)
            timer = Timer(_ -> kill(proc), 600)
            wait(proc)
            close(timer)
            return success(proc), read(out, String), read(err, String)
        end

        ok, out, err = load("0")
        @test ok
        @test out == "false false false"
        @test occursin("HIP could not be initialized", err)

        # CI asks for the hard error
        ok, out, err = load("1")
        @test !ok
        @test occursin("HIP must load", err)
    end
end

@testset "HIPDevice" begin
    @testset "Device props" begin
        devices = AMDGPU.devices()
        for (idx, device) in enumerate(devices)
            @test AMDGPU.device_id(device) == idx

            if HIP.runtime_version() > v"6"
                device_name = HIP.name(device)
                @test length(device_name) > 0
            end

            @test occursin("gfx", HIP.gcn_arch(device))
            @test HIP.wavefrontsize(device) in (32, 64)
            @test HIP.max_workgroup_size(device) ==
                  HIP.attribute(device, HIP.hipDeviceAttributeMaxThreadsPerBlock)
        end
    end
end

@testset "ISA parsing" begin
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx1030")
    @test dev_isa == "gfx1030"
    @test isempty(features)
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:sramecc+:xnack-")
    @test dev_isa == "gfx90a"
    @test features == "+sramecc"
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:sramecc+:xnack+")
    @test dev_isa == "gfx90a"
    @test features == "+sramecc,+xnack"
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:xnack-")
    @test dev_isa == "gfx90a"
    @test isempty(features)
    dev_isa, features = AMDGPU.Compiler.parse_llvm_features("gfx90a:xnack+")
    @test dev_isa == "gfx90a"
    @test features == "+xnack"
end

@testset "Comparison" begin
    s = AMDGPU.stream()
    @test s == deepcopy(s)

    c = AMDGPU.context()
    @test c == deepcopy(c)

    d = AMDGPU.device()
    @test d == deepcopy(d)
end

@testset "HandleCache global idle budget (#1053)" begin
    max_entries, max_idle = 4, 8
    cache = HandleCache{Int, Int}(max_entries, max_idle)

    destroyed = Int[]
    n_created = 0
    for key in 1:100
        h = pop!(cache, key) do
            n_created += 1
            key + 1000
        end
        @test h == key + 1000
        push!(() -> push!(destroyed, h), cache, key, h)
    end

    idle = AMDGPU.total_idle(cache)
    @test idle <= max_idle
    @test isempty(cache.active_handles)
    @test idle + length(destroyed) == n_created == 100
    @test allunique(destroyed)
end

@testset "HandleCache randomized invariants" begin
    rng = Xoshiro(0x1070)
    for _ in 1:200
        max_entries = rand(rng, 0:5)
        max_idle = rand(rng, 0:12)
        cache = HandleCache{Int, Int}(max_entries, max_idle)

        next_id = Ref(0)
        created = Set{Int}()
        destroyed = Int[]
        active = Dict{Int, Vector{Int}}()   # key => handles currently checked out

        ok = true
        for _ in 1:400
            key = rand(rng, 1:8)
            held = get(active, key, Int[])
            if isempty(held) || rand(rng, Bool)
                h = pop!(cache, key) do
                    id = (next_id[] += 1)
                    push!(created, id)
                    id
                end
                push!(get!(() -> Int[], active, key), h)
            else
                h = popat!(held, rand(rng, eachindex(held)))
                isempty(held) && delete!(active, key)
                push!(() -> push!(destroyed, h), cache, key, h)
            end

            idle_handles = [e.handle for entries in values(cache.idle_handles) for e in entries]
            live_pairs = Set(key => h for (key, hs) in active for h in hs)

            ok &= allunique(idle_handles)                        # never idled twice
            ok &= allunique(destroyed)                           # never destroyed twice
            ok &= isempty(Set(idle_handles) ∩ Set(destroyed))    # never idle *and* destroyed
            ok &= live_pairs == cache.active_handles             # cache agrees with the harness
            ok &= all(!isempty(v) for v in values(cache.idle_handles))       # no empty vectors left behind
            ok &= all(length(v) <= max_entries + 1 for v in values(cache.idle_handles))
            ok &= AMDGPU.total_idle(cache) <= max_idle

            accounted = length(idle_handles) + length(destroyed) +
                        sum(length, values(active); init = 0)
            ok &= accounted == length(created)                   # nothing lost
            ok || break
        end
        @test ok
    end
end

@testset "HandleCache: hot key survives cold churn" begin
    cache = HandleCache{Int, Int}(32, 8)
    created = Ref(0)
    get_put(key) = (h = pop!(() -> (created[] += 1), cache, key);
                    push!(() -> nothing, cache, key, h); h)
    get_put(0)                    # hot key
    before = created[]
    cold = 1
    for _ in 1:50
        get_put(0)
        for _ in 1:4
            get_put(cold); cold += 1
        end
    end
    @test created[] - before == cold - 1
end

end
