CodeInfo(
1 ─       oc_ptr#230 = (AMDGPU.Device.output_context)()
│   %2  = Base.unsafe_load
│   %3  = oc_ptr#230
│         oc#231 = (%2)(%3)
│   %5  = oc#231
│         (AMDGPU.Device.hostcall_device_lock!)(%5)
│         str_ptr#232 = (AMDGPU.Device.alloc_string)(Val{Symbol("Hello World!")}())
│   %8  = Main.:+
│   %9  = oc#231
│   %10 = Base.getproperty(%9, :buf_ptr)
│   %11 = (%8)(%10, 0)
│   %12 = str_ptr#232
│         (AMDGPU.Device.memcpy!)(%11, %12, 12)
│   %14 = Base.unsafe_store!
│   %15 = Main.reinterpret
│   %16 = oc#231
│   %17 = Base.getproperty(%16, :buf_ptr)
│   %18 = (%15)(Core.LLVMPtr{UInt8, 1}, %17)
│         (%14)(%18, 0x00, 13)
│   %20 = oc#231
│         (AMDGPU.Device.hostcall_device_trigger_and_return!)(%20)
│   %22 = Main.nothing
└──       return %22
)
