# CircuitscapeUI.jl

This package contains the UI code and build scripts for Circuitscape. To install this utility, do:
```julia
] add https://github.com/Circuitscape/CircuitscapeUI.jl
```

To run the UI, do:
```julia
using CircuitscapeUI
run_ui()
```

To run the build script, First run
```bash
$ CIRCUITSCAPEUI=$(julia -e 'using CircuitscapeUI; print(joinpath(dirname(pathof(CircuitscapeUI)), ".."))')
$ JULIA_PROJECT=$CIRCUITSCAPEUI julia
```
and then in Julia
```julia
julia> include(joinpath(ENV["JULIA_PROJECT"], "build", "build_script.jl"))
CircuitscapeUI.build_cs_binary(; build_path = pwd(),
                                 snoop = false) # snoop = true takes longer but removes most JIT overhead
```

This currently only works on Mac.
