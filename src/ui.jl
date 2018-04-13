using Blink
using WebIO
using Tachyons
using CSSUtil
using JSExpr
using Circuitscape

const w = Window()
const logging = log_window()

function ui_logger(msg, typ)

    logging["log"][] = msg
end
Circuitscape.ui_interface[] = ui_logger

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
        input_graph[] = x
    end
    on(input["check"]) do x
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

    # Run button
    run, ob = run_button()
    on(ob) do x
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
    

    page = vbox(heading, 
                hline(style = :solid, w=5px)(style = Dict(:margin => 20px)), 
                section1,
                dt, 
                mod_mode, 
                hline(style = :solid, w=3px)(style = Dict(:margin => 10px)),
                input_section,
                input, 
                hline(style = :solid, w=3px)(style = Dict(:margin => 10px)),
                points_input,
                hline(style = :solid, w=3px)(style = Dict(:margin => 10px)),
                output,
                run,
                hline(style = :solid, w=3px)(style = Dict(:margin => 10px)),
                logging)|> class"pa3 system-sans-serif"

    body!(w, page)

end

generate_ui(w)
