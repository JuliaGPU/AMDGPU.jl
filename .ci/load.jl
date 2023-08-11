import Pkg

Pkg.update()

root_directory = dirname(@__DIR__)
amdgpu = Pkg.PackageSpec(;path=root_directory)

Pkg.develop(amdgpu)
Pkg.build()
Pkg.precompile()

import AMDGPU
AMDGPU.versioninfo()
