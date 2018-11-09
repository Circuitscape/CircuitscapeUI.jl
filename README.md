# CircuitscapeUI.jl

This package contains the UI code and build scripts for Circuitscape. To install this utility, do: 
```julia
] dev https://github.com/ranjanan/CircuitscapeUI.jl.git
```

To run the UI, do:
```julia
using CircuitscapeUI
run_ui()
```

To run the build script, you will need the branch `webio` from [this fork](https://github.com/ranjanan/Blink.jl) of Blink.jl 
and the branch `blink` from [`WebIO.jl`](https://github.com/JuliaGizmos/WebIO.jl). Then: 
```julia
using CircuitscapeUI
CircuitscapeUI.build_cs_binary(; build_path = pwd(), 
                                 snoop = false) # snoop = true takes longer but removes most JIT overhead
```

This currently only works on Mac.
