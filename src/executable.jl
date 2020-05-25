mutable struct HSAExecutable
    agent::HSAAgent
    executable::Ref{HSA.Executable}
    data::Vector{UInt8}
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

function iterate_exec_prog_syms_cb(exe::HSA.Executable, sym::HSA.ExecutableSymbol, data)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE, sym_type) |> check

    #if sym_type[] == HSA.SYMBOL_KIND_KERNEL
        len = Ref(0)
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
        name = Vector{UInt8}(undef, len[])
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
        @debug "   Symbol Name: $(String(name))"
    #end
    return HSA.STATUS_SUCCESS
end

# TODO Docstring
function HSAExecutable(agent::HSAAgent, data::Vector{UInt8}, symbol::String)
    #= NOTE: Everything I can see indicates that profile is always FULL
    profile = Ref{HSA.Profile}()
    HSA.agent_get_info(agent.agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    =#

    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data),
                                              code_object_reader) |> check

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(HSA.PROFILE_BASE,
                              HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
                              C_NULL, executable) |> check

    HSA.executable_load_agent_code_object(executable[], agent.agent,
                                          code_object_reader[],
                                          C_NULL, C_NULL) |> check

    HSA.executable_freeze(executable[], "") |> check
    HSA.code_object_reader_destroy(code_object_reader[]) |> check

    exe = HSAExecutable(agent, executable, data)
    
    finalizer(exe) do exe
        HSA.executable_destroy(exe.executable[]) |> check
    end

    return exe
end

