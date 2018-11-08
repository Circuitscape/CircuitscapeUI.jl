using ApplicationBuilder
# using BuildApp
import Blink
import Tachyons
import WebIO
import InteractBase
import InteractBulma
import Circuitscape
import CircuitscapeUI
import MbedTLS
# import HttpParser

dir(mod) = normpath(joinpath(dirname(pathof(mod)),".."))

resources = 
            [joinpath(dir(Blink), "src/AtomShell/main.js"), 
             joinpath(dir(Blink), "src/content/main.html"), 
             joinpath(dir(Blink), "res"), 
             joinpath(dir(Tachyons), "assets/tachyons.min.css"), 
             joinpath(dir(WebIO), "assets/webio/dist/bundle.js"), 
             joinpath(dir(WebIO), "assets/providers/blink_setup.js"),
             joinpath(dir(InteractBase), "assets/all.js"), 
             joinpath(dir(InteractBulma), "assets/main.css"),
             joinpath(dir(InteractBulma), "assets/bulma.min.css"),
             joinpath(dir(InteractBulma), "assets/bulma-slider.min.css"),
             joinpath(dir(InteractBulma), "assets/bulma-switch.min.css"),
             joinpath(dir(InteractBulma), "assets/bulma-checkradio.min.css"),
       #      joinpath(dir(Vue), "assets/vue.js"),
             joinpath(dir(Circuitscape), "test"), 
      #       joinpath(dir(MacroTools), "animals.txt"), 
             joinpath(dir(CircuitscapeUI), "assets", "cs_logo.ico")
            ]
libs = readdir(joinpath(dir(MbedTLS), "deps/usr/lib/"))
lib_paths = joinpath.(dir(MbedTLS), "deps/usr/lib", libs)

libraries = vcat(
                 joinpath(dir(Blink), "deps/Julia.app"), 
                 lib_paths
                )
             # joinpath(dir(MbedTLS), "deps/usr/lib/libmbedcrypto.dylib"),
             #joinpath(dir(MbedTLS), "deps/usr/lib/libmbedtls.dylib"),
             #joinpath(dir(MbedTLS), "deps/usr/lib/libmbedx509.dylib")]
             #joinpath(dir(HttpParser), "deps/usr/lib/libhttp_parser.dylib")]

build_app_bundle("Circuitscape.jl", resources = resources, 
                          libraries = libraries, icns_file = "/Users/ranjan/Repos/Circuitscape/circuitscape.icns")
