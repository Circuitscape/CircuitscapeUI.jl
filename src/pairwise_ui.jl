
function input_ui()
    

    graph = vbox(Node(:div, "Raster resistance map or network/graph: ", 
                      attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                 Node(:input, id = "input", attributes = Dict(:type => :file, 
                                                :style => "margin-top: 12px")))

    graph_is_res = hbox(Node(:input, "graph_is_res", id = "check",
                            attributes = Dict(:type => :checkbox, 
                           :style => "margin-top: 12px; margin-right: 5px")), 
                        Node(:div, "Data represents resistances instead of conductances", 
                             attributes = Dict(:style => "margin-top: 12px")))
    input = vbox(graph,
                 graph_is_res)

	# Get file path 
	s = Scope()
	s.dom = input
	onimport(s, JSExpr.@js function ()
				JSExpr.@var el1 = this.dom.querySelector("#input")
				JSExpr.@var el2 = this.dom.querySelector("#check")
				el1.onchange = (function ()
				   $(s["filepath"])[] = el1.files[0].path
				end)
                el2.onchange = (function ()
                    $(s["check"])[] = el2.checked
                end)
			end)

    s
end

function pairwise_input_ui()
    additional_input = Node(:div, tachyons_css, "Pairwise Mode Options") |> class"f4 lh-title"
    focal = vbox(Node(:div, "Select focal node locations from file: ", 
                      attributes = Dict(:style => "margin-top: 12px")),
                 Node(:input, id = "focal", attributes = Dict(:type => :file, 
                                                 :style => "margin-top: 12px")))
    pair = vbox(additional_input, 
                 focal)

    s = Scope()
    s.dom = pair
    onimport(s, JSExpr.@js function ()
                 JSExpr.@var el = this.dom.querySelector("#focal")
                 el.onchange = (function ()
                     $(s["focal"])[] = el.files[0].path
                    end)
             end)

    s
end

