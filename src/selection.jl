function convert_to_float(value::String)

    # determining whether set is in reps or duration
    colon_loc = findfirst(":", value)
    if typeof(colon_loc) != Nothing
        return parse(Float64,value[1:colon_loc[1]-1])+
               parse(Float64,value[colon_loc[1]+1:end])/60
    else
        return parse(Float64,value)
    end
end

function convert_to_time(value::Float64)
    return string(floor(Int, value))*":"*string(convert(Int,(value%1)*60))
end

function select_reps(exercise::DataFrameRow)
    difficulty = exercise["difficulty"]
    reps_0 = convert_to_float(exercise["reps_0"])
    reps_10 = convert_to_float(exercise["reps_10"])

    value = reps_0 + (reps_10 - reps_0)*difficulty/10

    # determining whether set is in reps or duration
    colon_loc = findfirst(":", exercise["reps_0"])

    if typeof(colon_loc) != Nothing
        return convert_to_time(value)
    else
        return string(floor(Int, value))
    end 
    
end

function select_set()
end
