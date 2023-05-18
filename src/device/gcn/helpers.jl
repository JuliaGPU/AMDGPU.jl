# HSA dispatch packet offsets
_packet_names = fieldnames(HSA.KernelDispatchPacket)
_packet_offsets = fieldoffset.(HSA.KernelDispatchPacket, 1:length(_packet_names))

@generated function _intr(::Val{fname}, out_arg, inp_args...) where {fname,}
    @dispose ctx=Context() begin
        inp_exprs = [:( inp_args[$i] ) for i in 1:length(inp_args)]
        inp_types = [inp_args...]
        out_type = convert(LLVMType, out_arg.parameters[1]; ctx)

        # create function
        bool_types = map(x->x===Bool, inp_types)
        T_bool = LLVM.Int1Type(ctx)
        param_types = LLVMType[convert.(LLVMType, inp_types; ctx=ctx)...]
        llvm_f, _ = create_function(out_type, param_types)
        mod = LLVM.parent(llvm_f)

        # generate IR
        @dispose builder=IRBuilder(ctx) begin
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            # call the intrinsic
            intr_types = map(x->bool_types[x[1]] ? T_bool : x[2], enumerate(param_types))
            intr_out_type = out_arg === Type{Bool} ? T_bool : out_type
            intr_ftype = LLVM.FunctionType(intr_out_type, intr_types)
            intr = LLVM.Function(mod, string(fname), intr_ftype)
            for idx in 1:length(param_types)
                if bool_types[idx]
                    attrs = parameter_attributes(intr, idx)
                    push!(attrs, EnumAttribute("zeroext", 0; ctx))
                end
            end
            params = map(x->bool_types[x[1]] ? trunc!(builder, x[2], T_bool) : x[2], enumerate(parameters(llvm_f)))
            value = call!(builder, intr_ftype, intr, [params...])
            if out_arg === Type{Bool}
                ret!(builder, zext!(builder, value, convert(LLVMType, Bool; ctx)))
            else
                ret!(builder, value)
            end
        end

        call_function(llvm_f, out_arg.parameters[1], Tuple{inp_args...}, inp_exprs...)
    end
end

struct GCNIntrinsic
    jlname::Symbol
    rocname::Symbol
    isbroken::Bool # please don't laugh...
    isinverted::Bool
    # FIXME: Input/output types
    inp_args::Tuple
    out_arg::Type
    roclib::Symbol
    suffix::Symbol
    tobool::Bool
end

GCNIntrinsic(jlname, rocname=jlname; isbroken=false, isinverted=false,
             inp_args=(), out_arg=(), roclib=:ocml, suffix=fntypes[first(inp_args)], tobool=false) =
    GCNIntrinsic(jlname, rocname, isbroken, isinverted, inp_args, out_arg, roclib, suffix, tobool)

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

# TODO have separate method_table for HIP
macro device_override(ex)
    esc(quote
        $GPUCompiler.@override(AMDGPU.method_table, $ex)
    end)
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
        @device_override $ex
    end)
end
