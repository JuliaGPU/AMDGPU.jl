CodeInfo(
1 ─       oc_ptr#274 = (AMDGPU.Device.output_context)()
│   %2  = Main.Base
│   %3  =   dynamic Base.getproperty(%2, :unsafe_load)
│   %4  = oc_ptr#274
│         oc#275 = (%3)(%4)
│   %6  = oc#275
│           dynamic (AMDGPU.Device.hostcall_device_lock!)(%6)
│         str_ptr#276 = (AMDGPU.Device.alloc_string)(Val{Symbol("Hello World!")}())
│   %9  = Main.:+
│   %10 = oc#275
│   %11 =   dynamic Base.getproperty(%10, :buf_ptr)
│   %12 =   dynamic (%9)(%11, 0)
│   %13 = str_ptr#276
│           dynamic (AMDGPU.Device.memcpy!)(%12, %13, 12)
│   %15 = Main.Base
│   %16 =   dynamic Base.getproperty(%15, :unsafe_store!)
│   %17 = Main.reinterpret
│   %18 = oc#275
│   %19 =   dynamic Base.getproperty(%18, :buf_ptr)
│   %20 =   dynamic (%17)(Core.LLVMPtr{UInt8, 1}, %19)
│           dynamic (%16)(%20, 0x00, 13)
│   %22 = oc#275
│           dynamic (AMDGPU.Device.hostcall_device_trigger_and_return!)(%22)
│   %24 = Main.nothing
└──       return %24
)
