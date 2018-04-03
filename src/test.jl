using Blink
using Tachyons
using JSExpr
using CSSUtil

w = Window()

function driver(w)
    dt = get_data_type()
    @show dt

    ui1 = get_mod_mode_network()
    ui2 = get_mod_mode_raster()

    nextui = ui1 
    nextui = map(dt["value"]) do v 
        if v == "Network"
            ui1
        else
            ui2
        end
    end
    @show nextui

    nextnextui = ""
    map(nextui) do v
        s = v["value"]
        map(s) do x
            if x == "Pairwise"
                nextnextui = "Pairwise UI"
            elseif x == "Advanced"
                nextnextui = "Advanced UI"
            elseif x == "One To All"
                nextnextui = "One To All UI"
            elseif x == "All To One"
                nextnextui = "All To One UI"
            end
        end
    end
    @show nextnextui

    page = vbox(dt, 
                 nextui)

    body!(w, page)
end

function get_data_type()

    data_type_prompt = "Step 1: Choose your input data type: "

    # Select between raster and network
    data_type = vbox(Node(:div, data_type_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                 Node(:select, "Select Data Type", 
                 Node(:option, "Raster"), 
                 Node(:option, "Network"), id = "dt", 
                 attributes = Dict(:style => "margin-top: 12px; margin-bottom: 12px")))

    s = Scope()
    s.dom = data_type
    onimport(s, JSExpr.@js function ()
                 @var el = this.dom.querySelector("#dt")
                 el.onchange = (function ()
                        $(s["value"])[] = el.value
                    end)
             end)

    s
end

function get_mod_mode_network()
    
    mod_mode_prompt = "Step 2: Choose a Modelling Mode: "
    mod_mode = vbox(Node(:div, mod_mode_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                 Node(:select, "Select Modelling Mode", 
                 Node(:option, "Pairwise"), 
                 Node(:option, "Advanced"), id = "modelling", 
                 attributes = Dict(:style => "margin-top: 12px; margin-bottom: 12px")))

    s = Scope()
    s.dom = mod_mode
    onimport(s, JSExpr.@js function ()
                 @var el = this.dom.querySelector("#modelling")
                 el.onchange = (function ()
                        $(s["value"])[] = el.value
                    end)
             end)

    s
end

function get_mod_mode_raster()
    
    mod_mode_prompt = "Step 2: Choose a Modelling Mode: "
    mod_mode = vbox(Node(:div, mod_mode_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                 Node(:select, "Select Modelling Mode", 
                 Node(:option, "Pairwise"), 
                 Node(:option, "Advanced"), 
                 Node(:option, "One To All "), 
                 Node(:option, "All To One"), id = "modelling", 
                 attributes = Dict(:style => "margin-top: 12px; margin-bottom: 12px")))

    s = Scope()
    s.dom = mod_mode
    onimport(s, JSExpr.@js function ()
                 @var el = this.dom.querySelector("#modelling")
                 el.onchange = (function ()
                        $(s["value"])[] = el.value
                    end)
             end)
    s
end

driver(w)
