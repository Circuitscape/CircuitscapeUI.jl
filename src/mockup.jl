
# First slider
step1 = data_type_slider(options = [:raster, :network]) 

val1 = dynamically_get_val(slider1)


sel2 = Observable{String}("")
step2 = Observable{Any}()
on(val1) do val1
    sel2[] = "Pairwise"
    if val1 == "Raster"
        slider2 = modelling_mode_slider(options = [:pairwise, 
                                                :advanced, :onetoall, :alltoone:]) 
        val2 = dyanamically_get_val(slider2)
        on(val2) do x
            sel2[] = x
        end
    else
        slider2 = modelling_mode_slider(options = [:pairwise, :advanced]) 
        val2 = dynamically_get_val(slider2)
    end

    if val2 == "Pairwise"
        ui = dynamically_generate_pairwise_ui()
    elseif val2 == "Advanced"
        ui = dynamically_generate_advanced_ui()
    else
        ui = dynamically_generate_pairwise_ui()
    end
        step2[] = ui
    end
end

# output_ui = generate_output_ui() # With the logging box and the pretty printed resistance matrix
val1["value"][] = "Raster"

push_to_page(vbox(step1,
                  step1, 
                  ui))
                  #output_ui))
                  
