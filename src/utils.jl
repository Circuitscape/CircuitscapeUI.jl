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
    s["value"] = Observable("Raster")
    onimport(s, JSExpr.@js function ()
                 JSExpr.@var el = this.dom.querySelector("#dt")
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
    s["value"] = Observable("Pairwise")
    onimport(s, JSExpr.@js function ()
                 JSExpr.@var el = this.dom.querySelector("#modelling")
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
    s["value"] = Observable("Pairwise")
    onimport(s, JSExpr.@js function ()
                 JSExpr.@var el = this.dom.querySelector("#modelling")
                 el.onchange = (function ()
                        $(s["value"])[] = el.value
                    end)
             end)
    s
end
function run_button()

	ob = Observable(0)
	s = Scope()
	s["click"] = ob
	cb = JSExpr.@js () -> $ob[] = $ob[] + 1
	run = Node(:button, "Run", attributes = Dict(:style => "margin-top: 12px"),
			events = Dict(:click => cb))
	s.dom = run

	s, ob
end

function log_window()
    lw = Node(:pre, "", id = "log", 
              attributes = Dict(:style => "height: 200px; overflow: auto"))

    s = Scope()
    s.dom = lw
    s["log"] = Observable("")
    s["clear"] = Observable(rand())
    onjs(s["log"], JSExpr.@js function (msg)
             JSExpr.@var el = this.dom.querySelector("#log")
             el.textContent += ("\n" + msg)
         end)
    onjs(s["clear"], JSExpr.@js function (msg)
             JSExpr.@var el = this.dom.querySelector("#log")
             el.textContent = ""
         end)
    s
end

function showsome(uis, which)
    s = Scope()
    s["visible"] = which
    s.dom = Node(:div, id="cont", uis...)
    onjs(s["visible"], JSExpr.@js function (visbl)
                 JSExpr.@var cont = this.dom.querySelector("cont")
                 JSExpr.@var cs = cont.children
                 for i = 1:cs.length
                     if visbl.indexOf(i) >= 0
                         cs[i].style.display = "block"
                     else          
                         cs[i].style.display = "none"
                     end
                 end
             end)
    s
end


