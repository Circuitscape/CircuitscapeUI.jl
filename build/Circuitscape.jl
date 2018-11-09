using Blink
using Tachyons
using WebIO
using InteractBase
using InteractBulma
using Circuitscape
using CircuitscapeUI
using MbedTLS
using Knockout
using MacroTools
using AssetRegistry
using Distributed

function change_dir_if_bundle()
    cd(joinpath(split(string(Base.julia_cmd()))[1][2:end], ".."))
end

# Blink 
Core.eval(Blink.AtomShell, :(_electron = "../Libraries/Julia.app/Contents/MacOS/Julia"))
Core.eval(Blink.AtomShell, :(mainjs = "main.js"))
Core.eval(Blink, :(buzz = "main.html"))
Core.eval(Blink, :(resources = Dict("spinner.css" => "res/spinner.css", 
                               "blink.js" => "res/blink.js", 
                               "blink.css" => "res/blink.css", 
                               "reset.css" => "res/reset.css")))
Core.eval(WebIO, :(webiosetup = "webio_setup.js"))

# Mbedtls
Core.eval(MbedTLS, :(libmbedcrypto = "../Libraries/libmbedcrypto"))
Core.eval(MbedTLS, :(libmbedtls = "../Libraries/libmbedtls"))
Core.eval(MbedTLS, :(libmbedx509 = "../Libraries/libmbedx509"))

# Tachyons
Core.eval(Tachyons, :(path = "tachyons.min.css"))

# WebIO
Core.eval(WebIO, :(bundlepath = "bundle.js"))
# Core.eval(WebIO, :(blinksetup = "blink_setup.js"))

# InteractBase
Core.eval(InteractBase, :(font_awesome = "all.js"))
Core.eval(InteractBase, :(style_css = "style.css"))

# InteractBulma
Core.eval(InteractBulma, :(all_js = "all.js"))
Core.eval(InteractBulma, :(bulma_min_css = "bulma.min.css"))
Core.eval(InteractBulma, :(bulma_slider_min_css = "bulma-slider.min.css"))
Core.eval(InteractBulma, :(bulma_switch_min_css = "bulma-switch.min.css"))
Core.eval(InteractBulma, :(bulma_checkradio_min_css = "bulma-checkradio.min.css"))
Core.eval(InteractBulma, :(bulma_tooltip_min_css = "bulma-tooltip.min.css"))
Core.eval(InteractBulma, :(bulma_accordion_min_css = "bulma-accordion.min.css"))

# Knockout 
Core.eval(Knockout, :(knockout_js = "knockout.js"))
Core.eval(Knockout, :(knockout_punches_js = "knockout_punches.js"))

# CircuitscapeUI
Core.eval(CircuitscapeUI, :(TESTPATH = "test/"))
Core.eval(CircuitscapeUI, :(logo = "cs_logo.ico"))

# MacroTools
Core.eval(MacroTools, :(animals_file = "animals.txt"))

Base.@ccallable function julia_main(args::Vector{String})::Cint
    # ApplicationBuilder.App.change_dir_if_bundle()
    # change_dir_if_bundle()
    @show pwd()
    @show Blink.AtomShell._electron
    @show WebIO.bundlepath
    @show InteractBulma.bulma_tooltip_min_css
    @show InteractBulma.bulma_accordion_min_css
    w = CircuitscapeUI.run_ui()
    @show AssetRegistry.registry
    while Blink.active(w)
        sleep(0.01)
    end
    return 0
end
