# Logging utilities

mutable struct TimespanContext
    log_sink::Union{TimespanLogging.MultiEventLog, Nothing}
end
TimespanLogging.log_sink(ctx::TimespanContext) =
    something(ctx.log_sink, TimespanLogging.NoOpLog())
TimespanLogging.profile(ctx::TimespanContext, xs...) = false

const GLOBAL_TIMESPAN_CONTEXT = TimespanContext(nothing)

function enable_logging!(flag::Bool=true; quiet::Bool=false)
    @set_preferences!("logging_enabled" => flag)
    if !quiet
        @info "Logging is now $(flag ? "enabled" : "disabled")\nPlease restart Julia for changes to take effect"
    end
end
const LOGGING_STATIC_ENABLED = begin
    if haskey(ENV, "JULIA_AMDGPU_LOGGING_ENABLED")
        enabled = parse(Bool, ENV["JULIA_AMDGPU_LOGGING_ENABLED"])
        enable_logging!(enabled; quiet=true)
        enabled
    else
        @load_preference("logging_enabled", false)
    end
end

macro log_start(args...)
    quote
        if $LOGGING_STATIC_ENABLED
            $timespan_start($GLOBAL_TIMESPAN_CONTEXT, $(map(esc, args)...))
        end
    end
end
macro log_finish(args...)
    quote
        if $LOGGING_STATIC_ENABLED
            $timespan_finish($GLOBAL_TIMESPAN_CONTEXT, $(map(esc, args)...))
        end
    end
end

function start_logging(log_sink=nothing)
    if !LOGGING_STATIC_ENABLED
        @warn "Logging is statically disabled\nEnable it with AMDGPU.Runtime.enable_logging!()"
        return
    end
    if log_sink === nothing
        log_sink = TimespanLogging.MultiEventLog()
        log_sink[:core] = TimespanLogging.Events.CoreMetrics()
        log_sink[:id] = TimespanLogging.Events.IDMetrics()
        log_sink[:timeline] = TimespanLogging.Events.TimelineMetrics()
        log_sink[:esat] = TimespanLogging.Events.EventSaturation()
        log_sink[:psat] = KernelLaunches()
    end
    GLOBAL_TIMESPAN_CONTEXT.log_sink = log_sink
    return
end
function stop_logging()
    GLOBAL_TIMESPAN_CONTEXT.log_sink = nothing
    return
end
fetch_logs!() = TimespanLogging.get_logs!(GLOBAL_TIMESPAN_CONTEXT)
function log_and_fetch!(f::Base.Callable)
    start_logging()
    try
        f()
        return fetch_logs!()
    finally
        stop_logging()
    end
end

struct KernelLaunches
    kernels::Set{NamedTuple}
end
KernelLaunches() = KernelLaunches(Set{NamedTuple}())
function (kl::KernelLaunches)(event::TimespanLogging.Event{:start})
    if event.category == :wait
        push!(kl.kernels, event.id)
    end
    # FIXME: return Dict(k=>1 for k in collect(kl.kernels))
    return [(k, 1) for k in collect(kl.kernels)]
end
function (kl::KernelLaunches)(event::TimespanLogging.Event{:finish})
    if event.category == :wait
        delete!(kl.kernels, event.id)
    end
    # FIXME: return Dict(k=>1 for k in collect(kl.kernels))
    return [(k, 1) for k in collect(kl.kernels)]
end
