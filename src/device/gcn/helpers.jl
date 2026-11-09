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

macro device_override(ex)
    esc(GPUToolbox.Overlays.device_override(__module__, GlobalRef(AMDGPU, :method_table), ex))
end

macro device_function(ex)
    esc(GPUToolbox.Overlays.device_function(__module__, GlobalRef(AMDGPU, :method_table), ex))
end
