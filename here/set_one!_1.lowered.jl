CodeInfo(
1 ─ %1  = AMDGPU.workitemIdx()
│   %2  = Base.getproperty(%1, :x)
│   %3  = AMDGPU.workgroupIdx()
│   %4  = Base.getproperty(%3, :x)
│   %5  = %4 - 1
│   %6  = AMDGPU.workgroupDim()
│   %7  = Base.getproperty(%6, :x)
│   %8  = %5 * %7
│         i = %2 + %8
│   %10 = Base.getindex(x, i)
│   %11 = %10 + 3
│         Base.setindex!(x, %11, i)
└──       return AMDGPU.nothing
)
