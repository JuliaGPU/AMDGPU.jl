mutable struct HSAExecutable{B} # FIXME: Don't parameterize on Mem.Buffer
    agent::HSAAgent
    executable::Ref{HSA.Executable}
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
        @debug "    Symbol Name: $(String(name))"
        Base.unsafe_store!(sym_ref, sym)
    end

    return HSA.STATUS_SUCCESS
end

# TODO Docstring
function HSAExecutable(agent::HSAAgent, path::String, symbol::String; globals=())
    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    @assert isfile(path)
    open(path, "r") do io
        HSA.code_object_reader_create_from_file(Int32(fd(io)),
                                                code_object_reader) |> check
    end

    HSAExecutable(agent, code_object_reader, symbol; globals=globals)
end
function HSAExecutable(agent::HSAAgent, data::Vector{UInt8}, symbol::String; globals=())
    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data),
                                              code_object_reader) |> check

    HSAExecutable(agent, code_object_reader, symbol; globals=globals)
end
function HSAExecutable(agent::HSAAgent, code_object_reader::Ref{HSA.CodeObjectReader}, symbol::String; globals=())
    #= NOTE: Everything I can see indicates that profile is always FULL
    profile = Ref{HSA.Profile}()
    HSA.agent_get_info(agent.agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    =#

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(HSA.PROFILE_BASE,
                              HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
                              C_NULL, executable) |> check

    _globals = Dict{Symbol,Mem.Buffer}()
    for (gbl,sz) in globals
        gbl_buf = Mem.alloc(agent, sz; coherent=true)
        HSA.executable_agent_global_variable_define(executable[], agent.agent,
                                                    string(gbl), gbl_buf.ptr) |> check
        _globals[gbl] = gbl_buf
    end

    HSA.executable_load_agent_code_object(executable[], agent.agent,
                                          code_object_reader[],
                                          C_NULL, C_NULL) |> check

    HSA.executable_freeze(executable[], "") |> check

    exe = HSAExecutable(agent, executable, _globals)

    # TODO: Ensure no derived kernels are in flight during finalization
    hsaref!()
    finalizer(exe) do exe
        HSA.executable_destroy(exe.executable[]) |> check
        for buf in values(exe.globals)
            Mem.free(buf)
        end
        HSA.code_object_reader_destroy(code_object_reader[]) |> check
        hsaunref!()
    end

    return exe
end

function get_global(exe::HSAExecutable, symbol::Symbol)
    @assert symbol in keys(exe.globals) "No such global in executable: $symbol"
    return exe.globals[symbol]::Mem.Buffer
end
