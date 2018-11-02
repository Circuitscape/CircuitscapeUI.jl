function advanced_input_ui()

    # Title of section
    title = node(:div, tachyons_css, "Advanced Mode Options") |> class"f4 lh-title"

    # Sources
    o1 = Observable("")
    sources = vbox(node(:div, "Current source file: ",
                      attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                   filepicker(value = o1))

    # Grounds
    o2 = Observable("")
    grounds = vbox(node(:div, "Ground point file: ",
                      attributes = Dict(:style => "margin-top: 12px")) |> class"b",
                   filepicker(value = o2))

    adv = vbox(title,
             sources,
             grounds)

    # Define scope
    s = Scope()
    s.dom = adv
    @private s["source"] = o1
    @private s["ground"] = o2

    s
end
