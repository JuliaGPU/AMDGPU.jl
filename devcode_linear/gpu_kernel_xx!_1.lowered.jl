CodeInfo(
1 ─       Core.NewvarNode(:(val))
│         Core.NewvarNode(:(@_8))
│         Core.NewvarNode(:(res))
│         Core.NewvarNode(:(idx))
│   %5  = (KernelAbstractions.__validindex)(__ctx__)
└──       goto #9 if not %5
2 ─       idx = KernelAbstractions.__index_Global_Linear(__ctx__)
│   %8  = Main.eltype(tensor)
│         res = Main.zero(%8)
│   %10 = -Nx
│   %11 = %10:Nx
│         @_8 = Base.iterate(%11)
│   %13 = @_8 === nothing
│   %14 = Base.not_int(%13)
└──       goto #8 if not %14
3 ┄ %16 = @_8
│         p = Core.getfield(%16, 1)
│   %18 = Core.getfield(%16, 2)
│   %19 = -Ny
│   %20 = %19:Ny
│         @_11 = Base.iterate(%20)
│   %22 = @_11 === nothing
│   %23 = Base.not_int(%22)
└──       goto #6 if not %23
4 ┄ %25 = @_11
│         q = Core.getfield(%25, 1)
│   %27 = Core.getfield(%25, 2)
│         res = res + 2.0
│         @_11 = Base.iterate(%20, %27)
│   %30 = @_11 === nothing
│   %31 = Base.not_int(%30)
└──       goto #6 if not %31
5 ─       goto #4
6 ┄       @_8 = Base.iterate(%11, %18)
│   %35 = @_8 === nothing
│   %36 = Base.not_int(%35)
└──       goto #8 if not %36
7 ─       goto #3
8 ┄       nothing
│         Base.setindex!(tensor, res, idx)
│         val = res
│         nothing
└──       val
9 ┄       return Main.nothing
)
