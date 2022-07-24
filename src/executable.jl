mutable struct ROCExecutable{B} # FIXME: Don't parameterize on Mem.Buffer
    device::ROCDevice
    executable::Ref{HSA.Executable}
    data::Vector{UInt8}
    globals::Dict{Symbol,B}
end

### @cfunction Callbacks ###

function iterate_exec_agent_syms_cb(exe::HSA.Executable, agent::HSA.Agent,
                                    sym::HSA.ExecutableSymbol,
                                    sym_ref::Ptr{Cvoid})

    sym_ref = Base.unsafe_convert(Ptr{HSA.ExecutableSymbol}, sym_ref)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE,
                                   sym_type) |> check

    if sym_type[] == HSA.SYMBOL_KIND_KERNEL
        len = Ref(0)
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
        name = Vector{UInt8}(undef, len[])
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
        Base.unsafe_store!(sym_ref, sym)
    end

    return HSA.STATUS_SUCCESS
end

# TODO Docstring
function ROCExecutable(device::ROCDevice, data::Vector{UInt8}, symbol::String; globals=())
    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data),
                                              code_object_reader) |> check

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(profile(device),
                              HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
                              C_NULL, executable) |> check

    _globals = Dict{Symbol,Mem.Buffer}()
    for (gbl,sz) in globals
        gbl_buf = Mem.alloc(device, sz; coherent=true)
        HSA.executable_agent_global_variable_define(executable[], device.agent,
                                                    string(gbl), gbl_buf.ptr) |> check
        _globals[gbl] = gbl_buf
    end

    HSA.executable_load_agent_code_object(executable[], device.agent,
                                          code_object_reader[],
                                          C_NULL, C_NULL) |> check

    HSA.executable_freeze(executable[], "") |> check

    exe = ROCExecutable(device, executable, data, _globals)

    # TODO: Ensure no derived kernels are in flight during finalization
    AMDGPU.hsaref!()
    finalizer(exe) do exe
        HSA.executable_destroy(exe.executable[]) |> check
        for buf in values(exe.globals)
            Mem.free(buf)
        end
        HSA.code_object_reader_destroy(code_object_reader[]) |> check
        AMDGPU.hsaunref!()
    end

    return exe
end

function get_global(exe::ROCExecutable, symbol::Symbol)
    @assert symbol in keys(exe.globals) "No such global in executable: $symbol"
    return exe.globals[symbol]::Mem.Buffer
end

function getinfo(exsym::HSA.ExecutableSymbol, attribute::HSA.ExecutableSymbolInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.executable_symbol_get_info(exsym, attribute, value)
end
