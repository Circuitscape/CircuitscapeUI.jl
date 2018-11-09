dir(mod) = normpath(joinpath(dirname(pathof(mod)),".."))
const BUILD_FILE = joinpath(dir(CircuitscapeUI), "build", "Circuitscape.jl")
const SNOOP_FILE = joinpath(dir(CircuitscapeUI), "build", "snoop.jl")

function build_cs_binary(; build_path=pwd(), snoop = false)

    resources = [ 
                 joinpath(dir(Blink), "src", "AtomShell", "main.js"), 
                 joinpath(dir(Blink), "src", "content", "main.html"), 
                 joinpath(dir(Blink), "res"), 
                 joinpath(dir(Blink), "res", "webio_setup.js"),
                 joinpath(dir(Tachyons), "assets", "tachyons.min.css"), 
                 joinpath(dir(WebIO), "assets", "webio", "dist", "bundle.js"), 
                 joinpath(dir(InteractBase), "assets", "all.js"), 
                 joinpath(dir(InteractBase), "assets", "style.css"), 
                 joinpath(dir(InteractBulma), "assets", "main.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma.min.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma-slider.min.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma-switch.min.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma-checkradio.min.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma-tooltip.min.css"),
                 joinpath(dir(InteractBulma), "assets", "bulma-accordion.min.css"),
                 joinpath(dir(Knockout), "assets", "knockout.js"),
                 joinpath(dir(Knockout), "assets", "knockout_punches.js"),
                 joinpath(dir(Circuitscape), "test"), 
                 joinpath(dir(CircuitscapeUI), "assets", "cs_logo.ico")
                ]

    libs = readdir(joinpath(dir(MbedTLS), "deps", "usr", "lib"))
    lib_paths = joinpath.(dir(MbedTLS), "deps", "usr", "lib", libs)

    libraries = vcat(
                     joinpath(dir(Blink), "deps/Julia.app"), 
                     lib_paths
                    )

    julia_path = joinpath(split(string(Base.julia_cmd()))[1][2:end])

    if Sys.isapple()
        system_path = joinpath("Circuitscape.app", "Contents", "MacOS")
        bin_path = joinpath(build_path, system_path)
        run(`cp $julia_path $bin_path`)
        oldpwd = pwd()
        cd(bin_path)
        run(`install_name_tool -rpath '@executable_path/../lib' '@executable_path' julia`)
        cd(oldpwd)
    end

    if snoop
        build_app_bundle(BUILD_FILE, resources = resources, builddir = build_path, snoopfile = SNOOP_FILE,
                     libraries = libraries, icns_file = joinpath(dir(CircuitscapeUI), "assets", "circuitscape.icns"))
    else
        build_app_bundle(BUILD_FILE, resources = resources, builddir = build_path, 
                     libraries = libraries, icns_file = joinpath(dir(CircuitscapeUI), "assets", "circuitscape.icns"))
    end

end
