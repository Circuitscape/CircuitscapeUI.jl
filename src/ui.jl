using Blink
using WebIO
using Tachyons
using CSSUtil
using JSExpr
using Circuitscape
using InteractBulma

include("utils.jl")
include("pairwise_ui.jl")
include("advanced_ui.jl")
include("output_ui.jl")


function log_window()
    lw = Node(:pre, "", id = "log", 
              attributes = Dict(:style => "height: 800px; border: 2px solid Black;
                                width: 500px; border-style: solid;
                                overflow: auto"))

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


function ui_logger(logging) 
    function (msg, typ)
        logging["log"][] = msg
    end
end

function generate_ui(w)

    heading = Node(:div, tachyons_css, "Circuitscape 5.0") |> 
                    class"f-subheadline lh-title tc red"

    section1 = Node(:div, tachyons_css, "Data Type and Modelling Mode") |> 
                    class"f4 lh-title"

    focal = Observable("")
    source = Observable("")
    ground = Observable("")
    points_input = Observable{Any}(Node(:div))

    on(points_input) do x
        on(x["focal"]) do y
            focal[] = y
        end
        on(x["source"]) do z
            source[] = z
        end
        on(x["ground"]) do v
            ground[] = v
        end
    end
    points_input[] = pairwise_input_ui()

    # First drop down
    dt = get_data_type()

    # Next drop down
    mod_mode = map(dt["value"]) do v
        points_input[] = pairwise_input_ui()
        if v == "Network"
            get_mod_mode_network()
        else
            get_mod_mode_raster()
        end
    end

    # Get the input raster/graph 
    input_section = Node(:div, tachyons_css, "Input Resistance Data") |> 
                    class"f4 lh-title"
    input = input_ui()
    
    input_graph = Observable("")
    is_res = Observable(false)
    on(input["filepath"]) do x
        println("filepath changed to $x")
        input_graph[] = x
    end
    on(input["check"]) do x
       println("check changed to $x")
       is_res[] = x
    end
    
    # Focal points or advanced mode
    pair = pairwise_input_ui()
    adv = advanced_input_ui()
    
    on(mod_mode) do x
        v = x["value"]
        on(v) do s
            if s == "Advanced"
                points_input[] = adv
                focal[] = ""
            else
                points_input[] = pair
            end
        end
    end
    dt["value"][] = "Raster"
    
    # Output options
    write_cur_maps = Observable(false)
    write_volt_maps = Observable(false)
    out = Observable("")
    output = output_ui()

    on(output["cur"]) do x
        write_cur_maps[] = x
    end
    on(output["volt"]) do x
        write_volt_maps[] = x
    end
    on(output["out"]) do x
        out[] = x
    end
    logging = log_window()
    Circuitscape.ui_interface[] = ui_logger(logging)

    # Run button
    run, ob = run_button()
    on(ob) do x
       @show input_graph[]
       @show is_res[]
       @show focal[]
       @show source[]
       @show ground[]
       @show out[]
       @show write_cur_maps[]
       @show write_volt_maps[]
       cfg = Dict{String,String}()
       cfg["habitat_file"] = input_graph[]
       cfg["habitat_map_is_resistances"] = string(is_res[])
       cfg["point_file"] = focal[]
       cfg["source_file"] = source[]
       cfg["ground_file"] = ground[]
       cfg["output_file"] = out[]
       cfg["write_cur_maps"] = string(write_cur_maps[])
       cfg["write_volt_maps"] = string(write_volt_maps[])

       logging["clear"][] = rand()
       compute(cfg)
    end
    
    runtests = runtests_button(w)

    left = vbox(section1,
                dt, 
                mod_mode, 
                input_section,
                input, 
                points_input,
                output,
                run,
                runtests)

    right = vbox(Node(:div, "Logging") |> class"f4 lh-title", 
                 vskip(1em),
                 logging)

    page = vbox(heading,
                hline(style = :solid, w=5px)(style = Dict(:margin => 20px)), 
            hbox(left,
                hskip(0.5em),
                vline(style = :solid, w=3px)(style = Dict(:margin => 10px)),
                hskip(0.5em),
                right))
    
    page = page |> class"pa3 system-sans-serif"

    body!(w, page)

end

function run_ui()
    w = Window(Dict(:title => "Circuitscape",
                    :width => 1000, 
                    :height => 800))
    generate_ui(w)
    w
end
