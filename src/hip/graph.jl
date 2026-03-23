"""
    instantiate(graph::HIPGraph)::HIPGraphExec

Instantiate captured graph making it executable with [`launch`](@ref).
"""
instantiate

"""
    capture(f::Function; flags = hipStreamCaptureModeGlobal, throw_error::Bool = true)::Union{Nothing, HIPGraph}

Capture fiven function `f` to a graph.
If successful, returns a captured graph that needs to be [`instantiate`](@ref)'d to obtain executable graph.
"""
capture

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

    global function capture(f::Function; flags = hipStreamCaptureModeGlobal, throw_error::Bool = true)::Union{Nothing, HIPGraph}
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

"""
    launch(exec::HIPGraphExec, stream::HIPStream = AMDGPU.stream())

Launch executable graph on a given stream.
"""
function launch(exec::HIPGraphExec, stream::HIPStream = AMDGPU.stream())
    hipGraphLaunch(exec, stream)
end

"""
    update(exec::HIPGraphExec, graph::HIPGraph; throw_error::Bool = true)::Bool

Given executable graph, perform update with graph.
Return `true` if successful, `false` otherwise.

If `throw_error=false` allows avoiding throwing an exception if update was not successful.
"""
function update(exec::HIPGraphExec, graph::HIPGraph; throw_error::Bool = true)::Bool
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

"""
    is_capturing(stream::HIPStream = AMDGPU.stream())::Bool

For a given `stream` check if capturing for a graph is performed.
"""
function is_capturing(stream::HIPStream = AMDGPU.stream())::Bool
    capture_status(stream).status == hipStreamCaptureStatusActive
end

"""
    graph = AMDGPU.@captured begin
        # code to capture in a graph.
    end

Macro to capture a given expression in a graph & execute it.
Returns captured graph, that can be relaunched with [`launch`](@ref) or updated with [`update`](@ref).

If capture fails (e.g. due to JIT), attempts recovery, compilation and re-capture.
"""
macro captured(ex)
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
            # If the capture failed, this may have been due to JIT compilation.
            # execute the body out of capture, and try capturing again.
            $(esc(ex))

            # Don't tolerate capture failures now so that the user will be informed.
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

        exec = instantiate(graph)
        executed || launch(exec)
        exec
    end
end
