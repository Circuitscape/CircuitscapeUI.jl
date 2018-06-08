function get_data_type()

    data_type_prompt = "Step 1: Choose your input data type: "

    # Select between raster and network
    o = Observable("Raster")
    data_type = vbox(Node(:div, data_type_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                     vskip(0.5em),
                     dropdown(["Raster", "Network"]))

    s = Scope()
    s.dom = data_type
    s["value"] = o

    s
end

function get_mod_mode_network()
    
    mod_mode_prompt = "Step 2: Choose a Modelling Mode: "
    o = Observable("Pairwise")
    mod_mode = vbox(Node(:div, mod_mode_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                    vskip(0.5em),
                    dropdown(["Pairwise", "Advanced"]))

    s = Scope()
    s.dom = mod_mode
    s["value"] = o

    s
end

function get_mod_mode_raster()
    
    mod_mode_prompt = "Step 2: Choose a Modelling Mode: "
    o = Observable("Pairwise")
    mod_mode = vbox(Node(:div, mod_mode_prompt, 
                          attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                    vskip(0.5em),
                    dropdown(["Pairwise",
                              "Advanced",
                              "One To All",
                              "All To One"]))

    s = Scope()
    s.dom = mod_mode
    s["value"] = o

    s
end
function run_button()

    ob = Observable(rand())
	#=s = Scope()
	s["click"] = ob
	cb = JSExpr.@js () -> $ob[] = $ob[] + 1
	run = Node(:button, "Run", attributes = Dict(:style => "margin-top: 12px"),
			events = Dict(:click => cb))=#
    run = button("Run", value = ob)

	run, ob
end
