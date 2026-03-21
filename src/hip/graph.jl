function unchecked_hipStreamEndCapture(stream, pGraph)
    AMDGPU.prepare_state()
    @gcsafe_ccall(libhip.hipStreamEndCapture(stream::hipStream_t, pGraph::Ptr{hipGraph_t})::hipError_t)
end

mutable struct HIPGraph
    handle::hipGraph_t

    function HIPGraph(flags = hipStreamCaptureModeGlobal)
        handle_ref = Ref{hipGraph_t}()
        hipGraphCreate(handle_ref, flags)

        obj = new(handle_ref[])
        finalizer(obj) do obj
            hipGraphDestroy(obj)
        end
        return obj
    end

    global function capture(f::Function; flags = hipStreamCaptureModeGlobal, throw_error::Bool = true)
        gc_state = GC.enable(false)
        stream = AMDGPU.stream()
        try
            hipStreamBeginCapture(stream, flags)
            f()
        finally
            handle_ref = Ref{hipGraph_t}()
            st = unchecked_hipStreamEndCapture(stream, handle_ref)
            GC.enable(gc_state)

            if st == hipErrorStreamCaptureInvalidated && !throw_error
                return nothing
            elseif st != hipSuccess
                throw(HIPError(st))
            end

            obj = new(handle_ref[])
            finalizer(hipGraphDestroy, obj)
            return obj
        end
        return nothing
    end
end

Base.unsafe_convert(::Type{hipGraph_t}, graph::HIPGraph) = graph.handle

mutable struct HIPGraphExec
    handle::hipGraphExec_t

    global function instantiate(graph::HIPGraph)
        handle_ref = Ref{hipGraphExec_t}()
        hipGraphInstantiateWithFlags(handle_ref, graph, 0)
        obj = new(handle_ref[])

        finalizer(obj) do obj
            hipGraphExecDestroy(obj)
        end
        return obj
    end
end

Base.unsafe_convert(::Type{hipGraphExec_t}, exec::HIPGraphExec) = exec.handle

launch(exec::HIPGraphExec, stream::HIPStream = AMDGPU.stream()) = hipGraphLaunch(exec, stream)

function update(exec::HIPGraphExec, graph::HIPGraph; throw_error::Bool = true)
    error_node = Ref{hipGraphNode_t}()
    update_res_ref = Ref{hipGraphExecUpdateResult}()
    hipGraphExecUpdate(exec, graph, error_node, update_res_ref)

    update_res = update_res_ref[]
    if update_res != hipGraphExecUpdateSuccess
        throw_error && error("Failed to update HIPGraphExec: `$(update_res)`.")
        return false
    end
    return true
end

function capture_status(stream::HIPStream)
    status_ref = Ref{hipStreamCaptureStatus}()
    id_ref = Ref{Culonglong}()
    hipStreamGetCaptureInfo(stream, status_ref, id_ref)
    status = status_ref[]
    return (; status, id=(status == hipStreamCaptureStatusActive) ? id_ref[] : nothing)
end

is_capturing(stream::HIPStream = AMDGPU.stream()) =
    capture_status(stream).status == hipStreamCaptureStatusActive

macro captured(ex)
    @gensym exec
    @eval __module__ begin
        const $exec = Ref{$HIPGraphExec}()
    end
    quote
        executed = false
        GC.enable(false)
        graph = try
            capture(; throw_error=false) do
                $(esc(ex))
            end
        finally
            GC.enable(true)
        end

        if graph === nothing
            # if the capture failed, this may have been due to JIT compilation.
            # execute the body out of capture, and try capturing again.
            $(esc(ex))

            # don't tolerate capture failures now so that the user will be informed
            GC.enable(false)
            graph = try
                capture() do
                    $(esc(ex))
                end
            catch
                rethrow()
            finally
                GC.enable(true)
            end
            executed = true
        end

        # TODO updating should be done manually by users.
        # Update or instantiate.
        # if !isassigned($(esc(exec))) || !update($(esc(exec))[], graph; throw_error=false)
        #     $(esc(exec))[] = instantiate(graph)
        # end

        # when allocation nodes are present on AMD ROCm — always reinstantiate for now.
        $(esc(exec))[] = instantiate(graph)
        executed || launch($(esc(exec))[])
        $(esc(exec))[]
    end
end
