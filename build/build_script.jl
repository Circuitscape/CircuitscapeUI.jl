using ApplicationBuilder
using CircuitscapeUI

dir(mod) = normpath(joinpath(dirname(pathof(mod)),".."))
const BUILD_FILE = joinpath(dir(CircuitscapeUI), "build", "Circuitscape.jl")
const SNOOP_FILE = joinpath(dir(CircuitscapeUI), "build", "snoop.jl")
const BINDIR = Sys.BINDIR

function build_cs_binary(; build_path=pwd(), snoop = false, verbose = false)

    resources = [ 
                 joinpath(dir(CircuitscapeUI.Blink), "src", "AtomShell", "main.js"), 
                 joinpath(dir(CircuitscapeUI.Blink), "src", "content", "main.html"), 
                 joinpath(dir(CircuitscapeUI.Blink), "res"), 
                 joinpath(dir(CircuitscapeUI.Blink), "res", "webio_setup.js"),
                 joinpath(dir(CircuitscapeUI.Tachyons), "assets", "tachyons.min.css"), 
                 joinpath(dir(CircuitscapeUI.WebIO), "assets", "webio", "dist", "bundle.js"), 
                 joinpath(dir(CircuitscapeUI.InteractBase), "assets", "all.js"), 
                 joinpath(dir(CircuitscapeUI.InteractBase), "assets", "style.css"), 
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "main.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma.min.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma-slider.min.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma-switch.min.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma-checkradio.min.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma-tooltip.min.css"),
                 joinpath(dir(CircuitscapeUI.InteractBulma), "assets", "bulma-accordion.min.css"),
                 joinpath(dir(CircuitscapeUI.Knockout), "assets", "knockout.js"),
                 joinpath(dir(CircuitscapeUI.Knockout), "assets", "knockout_punches.js"),
                 joinpath(dir(CircuitscapeUI.Circuitscape), "test"), 
                 joinpath(dir(CircuitscapeUI), "assets", "cs_logo.ico")
                ]

    libs = readdir(joinpath(dir(CircuitscapeUI.MbedTLS), "deps", "usr", "lib"))
    lib_paths = joinpath.(dir(CircuitscapeUI.MbedTLS), "deps", "usr", "lib", libs)

    if Sys.isapple()
    	electron_app = joinpath(dir(CircuitscapeUI.Blink), "deps/Julia.app")
    elseif Sys.iswindows()
    	electron_app = joinpath(dir(CircuitscapeUI.Blink), "deps", "atom")
    end
    if !ispath(electron_app)
        CircuitscapeUI.Blink.AtomShell.install()
    end
    libraries = vcat(
                     electron_app,
                     lib_paths
                    )

    julia_path = joinpath(split(string(Base.julia_cmd()))[1][2:end])

    if Sys.isapple()
        system_path = joinpath("Circuitscape.app", "Contents", "MacOS")
        bin_path = joinpath(build_path, system_path)
        mkpath(bin_path, mode=0o755)
        run(`cp $julia_path $bin_path`)
        run(Cmd(`install_name_tool -rpath '@executable_path/../lib' '@executable_path' julia`, dir=bin_path))
    end

    if snoop
        build_app_bundle(BUILD_FILE,
            resources = resources,
            builddir = build_path,
            snoopfile = SNOOP_FILE,
            libraries = libraries,
            icns_file = joinpath(dir(CircuitscapeUI), "assets", "circuitscape.icns"),
            verbose = verbose)
    else
        build_app_bundle(BUILD_FILE,
            resources = resources,
            builddir = build_path,
            libraries = libraries)
            #icns_file = joinpath(dir(CircuitscapeUI), "assets", "circuitscape.icns"),
            #verbose = verbose)
    end

end
