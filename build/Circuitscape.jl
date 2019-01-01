using CircuitscapeUI

function change_dir_if_bundle()
    cd(joinpath(split(string(Base.julia_cmd()))[1][2:end], ".."))
end

append_res(x) = joinpath("res", x)
append_lib(x) = joinpath("lib", x)

# Blink
if Sys.isapple()
    electron_str = "../Libraries/Julia.app/Contents/MacOS/Julia"

    Core.eval(CircuitscapeUI.Blink.AtomShell, :(_electron = electron_str))
    Core.eval(CircuitscapeUI.Blink.AtomShell, :(mainjs = "main.js"))
    Core.eval(CircuitscapeUI.Blink, :(buzz = "main.html"))
    Core.eval(CircuitscapeUI.Blink, :(resources = Dict("spinner.css" => joinpath("res", "spinner.css"), 
                                   "blink.js" => joinpath("res","blink.js"), 
                                   "blink.css" => joinpath("res","blink.css"), 
                                   "reset.css" => joinpath("res","reset.css"))))
    Core.eval(CircuitscapeUI.Blink, :(webiosetup = "webio_setup.js"))

    # Mbedtls
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedcrypto = "../Libraries/libmbedcrypto"))
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedtls = "../Libraries/libmbedtls"))
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedx509 = "../Libraries/libmbedx509"))

    # Tachyons
    Core.eval(CircuitscapeUI.Tachyons, :(path = "tachyons.min.css"))

    # WebIO
    Core.eval(CircuitscapeUI.WebIO, :(bundlepath = "bundle.js"))

    # InteractBase
    Core.eval(CircuitscapeUI.InteractBase, :(font_awesome = "all.js"))
    Core.eval(CircuitscapeUI.InteractBase, :(style_css = "style.css"))

    # InteractBulma
    Core.eval(CircuitscapeUI.InteractBulma, :(font_awesome = "all.js"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_min_css = "bulma.min.css"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_slider_min_css = "bulma-slider.min.css"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_switch_min_css = "bulma-switch.min.css"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_checkradio_min_css = "bulma-checkradio.min.css"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_tooltip_min_css = "bulma-tooltip.min.css"))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_accordion_min_css = "bulma-accordion.min.css"))

    # Knockout
    Core.eval(CircuitscapeUI.Knockout, :(knockout_js = "knockout.js"))
    Core.eval(CircuitscapeUI.Knockout, :(knockout_punches_js = "knockout_punches.js"))

    # CircuitscapeUI
    Core.eval(CircuitscapeUI, :(TESTPATH = "test/"))
    Core.eval(CircuitscapeUI, :(logo = "cs_logo.ico"))

elseif Sys.iswindows()

    Core.eval(CircuitscapeUI.Blink.AtomShell, :(_electron = joinpath("..", "lib", "atom", "electron.exe")))
    Core.eval(CircuitscapeUI.Blink.AtomShell, :(mainjs = joinpath("..", "res", "main.js")))
    Core.eval(CircuitscapeUI.Blink, :(mainhtml = joinpath("..", "res", "main.html")))
    Core.eval(CircuitscapeUI.Blink, :(resources = Dict("spinner.css" => joinpath("..", "res", "res", "spinner.css"), 
                                   "blink.js" => joinpath("..", "res", "res", "blink.js"), 
                                   "blink.css" => joinpath("..", "res", "res","blink.css"), 
                                   "reset.css" => joinpath("..", "res", "res","reset.css"))))
    Core.eval(CircuitscapeUI.Blink, :(webiosetup = joinpath("..", "res", "webio_setup.js")))

    # Mbedtls
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedcrypto = joinpath("..", "lib", "libmbedcrypto")))
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedtls = joinpath("..", "lib", "libmbedtls")))
    Core.eval(CircuitscapeUI.MbedTLS, :(libmbedx509 = joinpath("..", "lib", "libmbedx509")))

    # Tachyons
    Core.eval(CircuitscapeUI.Tachyons, :(path = joinpath("..", "res", "tachyons.min.css")))

    # WebIO
    Core.eval(CircuitscapeUI.WebIO, :(bundlepath = joinpath("..", "res", "bundle.js")))

    # InteractBase
    Core.eval(CircuitscapeUI.InteractBase, :(font_awesome = joinpath("..", "res", "all.js")))
    Core.eval(CircuitscapeUI.InteractBase, :(style_css = joinpath("..", "res", "style.css")))

    # InteractBulma
    Core.eval(CircuitscapeUI.InteractBulma, :(font_awesome = joinpath("..", "res", "all.js")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_min_css = joinpath("..", "res", "bulma.min.css")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_slider_min_css = joinpath("..", "res", "bulma-slider.min.css")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_switch_min_css = joinpath("..", "res", "bulma-switch.min.css")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_checkradio_min_css = joinpath("..", "res", "bulma-checkradio.min.css")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_tooltip_min_css = joinpath("..", "res", "bulma-tooltip.min.css")))
    Core.eval(CircuitscapeUI.InteractBulma, :(bulma_accordion_min_css = joinpath("..", "res", "bulma-accordion.min.css")))

    # Knockout
    Core.eval(CircuitscapeUI.Knockout, :(knockout_js = joinpath("..", "res", "knockout.js")))
    Core.eval(CircuitscapeUI.Knockout, :(knockout_punches_js = joinpath("..", "res", "knockout_punches.js")))

    # CircuitscapeUI
    Core.eval(CircuitscapeUI, :(TESTPATH = joinpath("..", "res", "test")))
    Core.eval(CircuitscapeUI, :(logo = joinpath("..", "res", "cs_logo.ico")))
end


Base.@ccallable function julia_main(args::Vector{String})::Cint
    # ApplicationBuilder.App.change_dir_if_bundle()
    # change_dir_if_bundle()
    #@show pwd()
    @show CircuitscapeUI.Blink.AtomShell._electron
    @show CircuitscapeUI.Blink.AtomShell.mainjs
    @show CircuitscapeUI.Blink.mainhtml
    @show CircuitscapeUI.WebIO.bundlepath 
    @show CircuitscapeUI.InteractBulma.bulma_tooltip_min_css 
    @show CircuitscapeUI.InteractBulma.bulma_accordion_min_css 
    @show CircuitscapeUI.Blink.resources
    @show CircuitscapeUI.Blink.webiosetup
    # CircuitscapeUI.WebIO.setup(:blink)
    #@show CircuitscapeUI.WebIO.providers_initialised
    w = CircuitscapeUI.run_ui()
    #println("boss")
    # w = CircuitscapeUI.Blink.Window()
    #@show CircuitscapeUI.AssetRegistry.registry    
    # wait(w.content)
    # CircuitscapeUI.Blink.tools(w)
    # return w
    #@show CircuitscapeUI.WebIO.providers_initialised
    #println("boss")

    # CircuitscapeUI.Blink.body!(w, CircuitscapeUI.WebIO.node(:div, "hello world!"))
    #println("boss")

    # CircuitscapeUI.Blink.body!(w,  "hello world!")
    #@show CircuitscapeUI.WebIO.providers_initialised

    #CircuitscapeUI.Blink.tools(w)
    @show CircuitscapeUI.AssetRegistry.registry
    while CircuitscapeUI.Blink.active(w)
        sleep(0.01)
    end
    return 0
end
