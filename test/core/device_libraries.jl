using Test
using AMDGPU
import GPUCompiler
import LLVM

@testset "Device library selection" begin
    for (dev_isa, wave64) in (("gfx1030", false), ("gfx90a", true), ("gfx1030", true))
        target = GPUCompiler.GCNCompilerTarget(; dev_isa)
        params = AMDGPU.Compiler.HIPCompilerParams(wave64, true, true)
        config = GPUCompiler.CompilerConfig(target, params; kernel=false)
        source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
        job = GPUCompiler.CompilerJob(source, config)
        libraries = GPUCompiler.device_libraries(job)
        @test !GPUCompiler.uses_legacy_linker(job)
        @test first(libraries).name == :AMDGPU
        names = [library.name for library in libraries]
        @test allunique(names)
        @test findfirst(==(:opencl), names) < findfirst(==(:ocml), names) <
              findfirst(==(:ockl), names)
        isa_name = Symbol("oclc_isa_version_", replace(dev_isa, "gfx" => ""))
        isa_library = only(filter(library -> library.name == isa_name, libraries))
        @test isa_library.bitcode isa Vector{UInt8}
        @test isa_library.bitcode == read(AMDGPU.Compiler.locate_lib(String(isa_name)))
        @test GPUCompiler.device_libraries(job)[2:end] === libraries[2:end]
        wave_name = Symbol("oclc_wavefrontsize64_", wave64 ? "on" : "off")
        @test wave_name in names
        @test !(Symbol("oclc_wavefrontsize64_", wave64 ? "off" : "on") in names)
        GPUCompiler.JuliaContext() do _
            exports = [GPUCompiler.library_exports(library) for library in libraries]
            @test length(union(exports...)) == sum(length, exports)
        end
    end
end

opencl_sin(value::Float32) =
    ccall("extern _Z3sinf", llvmcall, Float32, (Float32,), value)
opencl_global_id() =
    ccall("extern _Z13get_global_idj", llvmcall, UInt64, (UInt32,), UInt32(0))

@testset "Transitive ROCm imports" begin
    input = Float32[0, 0.5, 1, 2]
    @test Array(opencl_sin.(ROCArray(input))) ≈ sin.(input)
    function index_kernel(output)
        index = AMDGPU.Device.workitemIdx().x
        @inbounds output[index] = opencl_global_id()
        return
    end
    output = AMDGPU.zeros(UInt64, 4)
    @roc groupsize=4 gridsize=1 index_kernel(output)
    @test Array(output) == UInt64[0, 1, 2, 3]
    types = Tuple{AMDGPU.Device.ROCDeviceVector{UInt64, AMDGPU.Device.AS.Global}}
    ir = sprint(io -> AMDGPU.code_llvm(io, index_kernel, types;
                                      kernel=true, dump_module=true))
    @test !occursin("@__oclc_", ir)
    @test !occursin("call i32 @llvm.amdgcn.wavefrontsize", ir)
end

@testset "Convergent calls in divergent control flow" begin
    function divergent_lane(output)
        index = AMDGPU.Device.workitemIdx().x
        if iseven(index)
            result = AMDGPU.Device.activelane() + UInt32(100)
        else
            result = AMDGPU.Device.activelane() + UInt32(200)
        end
        @inbounds output[index] = result
        return
    end
    width = Int(AMDGPU.HIP.wavefrontsize(AMDGPU.device()))
    output = AMDGPU.zeros(UInt32, width)
    @roc groupsize=width gridsize=1 divergent_lane(output)
    expected = [(index - 1) ÷ 2 + (iseven(index) ? 100 : 200) for index in 1:width]
    if LLVM.version() < v"16"
        @test_broken Array(output) == expected
    else
        @test Array(output) == expected
    end
end

@testset "Runtime building does not leak hostcalls" begin
    target = GPUCompiler.GCNCompilerTarget(; dev_isa="gfx1030")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true, 1)
    config = GPUCompiler.CompilerConfig(target, params; kernel=false)
    source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
    job = GPUCompiler.CompilerJob(source, config)
    storage = task_local_storage()
    previous = pop!(storage, :amdgpu_early_hostcalls, nothing)
    try
        GPUCompiler.JuliaContext() do _
            mod, _ = GPUCompiler.load_device_library(GPUCompiler.runtime_library(AMDGPU), job)
            LLVM.dispose(mod)
        end
        @test isempty(get(storage, :amdgpu_early_hostcalls, Symbol[]))
    finally
        pop!(storage, :amdgpu_early_hostcalls, nothing)
        previous === nothing || (storage[:amdgpu_early_hostcalls] = previous)
    end
end

@testset "Late import policy" begin
    target = GPUCompiler.GCNCompilerTarget(; dev_isa="gfx1030")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true)
    config = GPUCompiler.CompilerConfig(target, params; kernel=false)
    source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
    job = GPUCompiler.CompilerJob(source, config)
    GPUCompiler.JuliaContext() do _
        mod = parse(LLVM.Module, """
            declare i32 @llvm.amdgcn.wavefrontsize()
            define i32 @__ocml_fabs_f32() {
                %size = call i32 @llvm.amdgcn.wavefrontsize()
                ret i32 %size
            }
            define void @__ockl_hsa_signal_test() { ret void }
            define void @explicit_noinline() noinline { ret void }
            define void @julia_helper() { ret void }
            define void @report_exception_test() noinline { ret void }
            """)
        try
            GPUCompiler.finish_imports!(job, mod,
                ["__ocml_fabs_f32", "__ockl_hsa_signal_test",
                 "explicit_noinline", "julia_helper", "report_exception_test"])
            @test occursin("ret i32 32", string(mod.functions["__ocml_fabs_f32"]))
            @test haskey(mod.functions["__ocml_fabs_f32"].function_attributes, :alwaysinline)
            @test !haskey(mod.functions["julia_helper"].function_attributes, :alwaysinline)
            @test !haskey(mod.functions["__ockl_hsa_signal_test"].function_attributes,
                          :alwaysinline)
            @test haskey(mod.functions["explicit_noinline"].function_attributes, :noinline)
            @test haskey(mod.functions["report_exception_test"].function_attributes,
                         :alwaysinline)
            @test !haskey(mod.functions["report_exception_test"].function_attributes,
                          :noinline)
            @test LLVM.verify(mod) === nothing
        finally
            LLVM.dispose(mod)
        end
    end
end

@testset "ROCm declaration attributes" begin
    target = GPUCompiler.GCNCompilerTarget(; dev_isa="gfx1030")
    params = AMDGPU.Compiler.HIPCompilerParams(false, true, true)
    config = GPUCompiler.CompilerConfig(target, params; kernel=false)
    source = GPUCompiler.methodinstance(typeof(identity), Tuple{Float32})
    job = GPUCompiler.CompilerJob(source, config)
    GPUCompiler.JuliaContext() do _
        mod = parse(LLVM.Module, """
            declare float @__ocml_sin_f32(float)
            declare float @__ocml_sincos_f32(float, float*)
            declare i32 @__ockl_wfred_add_i32(i32)
            """)
        try
            AMDGPU.Compiler.annotate_rocm_declarations!(job, mod)
            @test haskey(mod.functions["__ockl_wfred_add_i32"].function_attributes,
                         :convergent)
            library = only(filter(library -> library.name == :ocml,
                                  GPUCompiler.device_libraries(job)))
            properties = AMDGPU.Compiler.rocm_library_attributes(library)
            for name in ("__ocml_sin_f32", "__ocml_sincos_f32")
                @test !isempty(properties[name])
                for (kind, value) in properties[name]
                    @test LLVM.value(mod.functions[name].function_attributes[kind]) == value
                end
            end
        finally
            LLVM.dispose(mod)
        end
    end
end
