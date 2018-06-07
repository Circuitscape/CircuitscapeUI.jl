function output_ui()
    
    # Title of section
    title = Node(:div, tachyons_css, "Output Options") |> class"f4 lh-title"

    o1 = Observable("")
    base_name = vbox(Node(:div, "Base output file name: ",
                      attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                     textbox(value = o1))

    o2 = Observable("")
    o3 = Observable("")
    options = vbox(checkbox("Current maps", value = o2), 
                    checkbox("Voltage maps", value = o3))

    output_ui = vbox(title,
                     base_name, 
                     options)

    s = Scope()

	s.dom = output_ui
    @private s["out"] = o1
    @private s["cur"] = o2
    @private s["volt"] = o3

    s
end
