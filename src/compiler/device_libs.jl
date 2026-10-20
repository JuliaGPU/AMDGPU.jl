import AMDGPU: libdevice_libs

const rocm_library_lock = ReentrantLock()
const rocm_libraries = Dict{String,GPUCompiler.DeviceLibrary}()

function locate_lib(file)
    isempty(libdevice_libs) && return nothing
    for extension in (".bc", ".amdgcn.bc")
        path = joinpath(libdevice_libs, file * extension)
        isfile(path) && return path
    end
    return nothing
end

"""
    rocm_device_libraries(target, wavefrontsize64)

Select ROCm bitcode in dependency order: language libraries, OCML, OCKL, then
the target-specific control constants. Missing optional libraries are omitted;
GPUCompiler diagnoses any unresolved calls that actually require them.
"""
function rocm_device_libraries(target::GCNCompilerTarget, wavefrontsize64::Bool)
    isa_short = replace(target.dev_isa, "gfx" => "")
    names = ["hc", "hip", "opencl", "ocml", "ockl", "irif",
             "oclc_isa_version_$isa_short", "oclc_abi_version_500"]
    for (option, value) in (
        (:finite_only, false),
        (:unsafe_math, false),
        (:correctly_rounded_sqrt, true),
        (:daz_opt, false),
        (:wavefrontsize64, wavefrontsize64),
    )
        push!(names, "oclc_$(option)_$(value ? "on" : "off")")
    end
    libraries = GPUCompiler.DeviceLibrary[]
    for name in names
        path = locate_lib(name)
        path === nothing && continue
        library = Base.@lock rocm_library_lock begin
            get!(rocm_libraries, path) do
                GPUCompiler.DeviceLibrary(Symbol(name); bitcode=read(path))
            end
        end
        push!(libraries, library)
    end
    return Tuple(libraries)
end

const library_attributes_lock = ReentrantLock()
const library_attributes = Dict{NTuple{32,UInt8},
    Dict{String,Vector{Pair{Symbol,UInt64}}}}()

"""
Read context-independent optimization attributes from the bitcode itself.
This preserves memory effects and convergence constraints while implementations
remain opaque, without guessing pointer-output behavior or linking bodies early.
"""
function rocm_library_attributes(library::GPUCompiler.DeviceLibrary)
    snapshot = GPUCompiler.device_library_bitcode(library)
    Base.@lock library_attributes_lock begin
        get!(library_attributes, snapshot.digest) do
            @dispose mod=parse(LLVM.Module, MemoryBuffer(snapshot.bytes); lazy=true) begin
                properties = Dict{String,Vector{Pair{Symbol,UInt64}}}()
                for fun in mod.functions
                    isdeclaration(fun) && continue
                    properties[fun.name] = [
                        LLVM.kind(attr) => LLVM.value(attr)
                        for attr in fun.function_attributes
                        if attr isa EnumAttribute && LLVM.kind(attr) in
                           (:convergent, :memory, :readnone, :readonly, :writeonly, :nounwind,
                            :willreturn, :nofree, :nosync, :speculatable)]
                end
                properties
            end
        end
    end
end

function annotate_rocm_declarations!(job, mod::LLVM.Module)
    declarations = [fun for fun in mod.functions
                    if isdeclaration(fun) && fun.intrinsic === nothing]
    isempty(declarations) && return
    for library in rocm_device_libraries(job.config.target, job.config.params.wavefrontsize64)
        properties = rocm_library_attributes(library)
        for fun in declarations
            for (kind, value) in get(properties, fun.name, Pair{Symbol,UInt64}[])
                push!(fun.function_attributes, EnumAttribute(kind, value))
            end
        end
    end
    return
end
