
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

# Mbedtls
Core.eval(MbedTLS, :(libmbedcrypto = "../Libraries/libmbedcrypto"))
Core.eval(MbedTLS, :(libmbedtls = "../Libraries/libmbedtls"))
Core.eval(MbedTLS, :(libmbedx509 = "../Libraries/libmbedx509"))

# HttpParser
# eval(HttpParser, :(lib = "Libraries/libhttp_parser.dylib"))

# Tachyons
Core.eval(Tachyons, :(path = "tachyons.min.css"))

# WebIO
Core.eval(WebIO, :(bundlepath = "bundle.js"))
Core.eval(WebIO, :(blinksetup = "blink_setup.js"))

# InteractBase
Core.eval(InteractBulma, :(all_js = "all.js"))
Core.eval(InteractBulma, :(bulma_min_css = "bulma.min.css"))
Core.eval(InteractBulma, :(bulma_slider_min_css = "bulma-slider.min.css"))
Core.eval(InteractBulma, :(bulma_switch_min_css = "bulma-switch.min.css"))
Core.eval(InteractBulma, :(bulma_checkradio_min_css = "bulma-checkradio.min.css"))


# CircuitscapeUI
Core.eval(CircuitscapeUI, :(TESTPATH = "test/"))
Core.eval(CircuitscapeUI, :(logo = "cs_logo.ico"))

## MacroTools
Core.eval(MacroTools, :(animals_file = "animals.txt"))

Base.@ccallable function julia_main(args::Vector{String})::Cint
    # ApplicationBuilder.App.change_dir_if_bundle()
    # change_dir_if_bundle()
    @show pwd()
    @show Blink.AtomShell._electron
    @show Tachyons.path
    @show WebIO.bundlepath
    @show WebIO.blinksetup
    # @show HttpParser.lib
    @show InteractBulma.bulma_min_css
    # @show Vue.vue_js
    @show InteractBulma.all_js
    @show InteractBulma.bulma_slider_min_css
    @show InteractBulma.bulma_switch_min_css
    @show InteractBulma.bulma_checkradio_min_css
    @show MacroTools.animals_file
    w = CircuitscapeUI.run_ui()
    @show AssetRegistry.registry
    while Blink.active(w)
        sleep(0.01)
    end
    return 0
end
