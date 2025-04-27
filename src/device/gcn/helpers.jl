# HSA dispatch packet offsets
_packet_names = fieldnames(HSA.KernelDispatchPacket)
_packet_offsets = fieldoffset.(HSA.KernelDispatchPacket, 1:length(_packet_names))

# which Julia types map to a given ROC lib type
const fntypes = Dict{Type,Symbol}(
    Nothing => :void,
    Bool    => :bool,
    Int8    => :i8,
    Int16   => :i16,
    Int32   => :i32,
    Int64   => :i64,
    UInt8   => :u8,
    UInt16  => :u16,
    UInt32  => :u32,
    UInt64  => :u64,
    Float16 => :f16,
    Float32 => :f32,
    Float64 => :f64
)

import ExprTools

macro device_override(ex)
    ex = macroexpand(__module__, ex)
    if VERSION >= v"1.12.0-DEV.745" || v"1.11-rc1" <= VERSION < v"1.12-"
        esc(quote
            Base.Experimental.@consistent_overlay(AMDGPU.method_table, $ex)
        end)
    else
        esc(quote
            Base.Experimental.@overlay(AMDGPU.method_table, $ex)
        end)
    end
end

macro device_function(ex)
    ex = macroexpand(__module__, ex)
    def = ExprTools.splitdef(ex)

    # generate a function that errors
    def[:body] = quote
        error("This function is not intended for use on the CPU")
    end

    esc(quote
        $(ExprTools.combinedef(def))
        Base.Experimental.@overlay(AMDGPU.method_table, $ex)
    end)
end
