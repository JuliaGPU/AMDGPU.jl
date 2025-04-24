CodeInfo(
1 ─ %1 = Main.AMDGPU
│   %2 =   dynamic Base.getproperty(%1, :Device)
│   %3 =   dynamic Base.getproperty(%2, :sync_workgroup_or)
│   %4 = Main.Cint
│   %5 =   dynamic (%4)(0)
│   %6 =   dynamic (%3)(%5)
│          dynamic Base.setindex!(x, %6, 1)
└──      return nothing
)
