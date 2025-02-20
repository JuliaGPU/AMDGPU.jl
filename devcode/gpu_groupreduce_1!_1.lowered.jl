CodeInfo(
1 ─       x@_11 = x@_4
│         Core.NewvarNode(:(res))
│         Core.NewvarNode(:(nx))
│         Core.NewvarNode(:(val))
│         Core.NewvarNode(:(i))
│   %6  = (KernelAbstractions.__validindex)(__ctx__)
└──       goto #7 if not %6
2 ─       i = KernelAbstractions.__index_Global_Linear(__ctx__)
│   %9  = Main.:>
│   %10 = i
│   %11 = Main.length
│   %12 = x@_11
│   %13 = (%11)(%12)
│   %14 = (%9)(%10, %13)
└──       goto #4 if not %14
3 ─ %16 = neutral
│         @_12 = %16
└──       goto #5
4 ─ %19 = x@_11
│   %20 = i
└──       @_12 = Base.getindex(%19, %20)
5 ┄ %22 = @_12
│         val = %22
│   %24 = val
│   %25 = val
│         x@_11 = Main.A(%24, %25)
│         nx = Main.A(neutral, neutral)
│   %28 = KernelAbstractions.__warp_groupreduce
│   %29 = x@_11
│   %30 = nx
│   %31 = KernelAbstractions.Val
│   %32 = KernelAbstractions.prod
│   %33 = (KernelAbstractions.groupsize)(__ctx__)
│   %34 = (%32)(%33)
│   %35 = (%31)(%34)
│         res = (%28)(__ctx__, op, %29, %30, %35)
│   %37 = Main.:(==)
│   %38 = i
│   %39 = (%37)(%38, 1)
└──       goto #7 if not %39
6 ─ %41 = Main.:+
│   %42 = res
│   %43 = Base.getproperty(%42, :x)
│   %44 = res
│   %45 = Base.getproperty(%44, :y)
│   %46 = (%41)(%43, %45)
│         Base.setindex!(y, %46, 1)
└──       goto #7
7 ┄ %49 = Main.nothing
└──       return %49
)
