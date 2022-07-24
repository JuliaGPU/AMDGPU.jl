## exception ring buffer

struct ExceptionEntry
    kern::UInt64
    ptr::LLVMPtr{UInt8,AS.Global}
end
# FIXME: https://github.com/JuliaLang/julia/issues/38864
#ExceptionEntry(kern) = ExceptionEntry(kern, LLVMPtr{UInt8,AS.Global}(0))
#ExceptionEntry() = ExceptionEntry(0)
