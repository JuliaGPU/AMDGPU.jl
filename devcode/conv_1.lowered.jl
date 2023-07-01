CodeInfo(
1 ─ %1 = Base.getindex(y, 1)
│   %2 = AMDGPU.UInt32(%1)
│        Base.setindex!(x, %2, 1)
└──      return nothing
)
