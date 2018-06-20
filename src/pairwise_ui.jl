
function input_ui()
    
    o1 = Observable("")
    graph = vbox(Node(:div, "Raster resistance map or network/graph: ", 
                      attributes = Dict(:style => "margin-top: 12px")),
                filepicker(value = o1))

    o2 = Observable(false)
    graph_is_res = checkbox("Data represents resistances instead of conductances", 
                            value = o2)

    input = vbox(graph,
                 vskip(1em),
                 graph_is_res)

	# Get file path 
	s = Scope()
	s.dom = input
    @private s["filepath"] = o1
    @private s["check"] = o2
    s
end

function pairwise_input_ui()

    o1 = Observable("")
    additional_input = Node(:div, tachyons_css, "Pairwise Mode Options") |> class"f4 lh-title"
    focal = vbox(Node(:div, "Select focal node locations from file: ", 
                      attributes = Dict(:style => "margin-top: 12px")),
                 filepicker(value = o1))

    pair = vbox(additional_input, 
                 focal)

    s = Scope()
    s.dom = pair
    @private s["focal"] = o1

    s
end

