export create_superset
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
    return string(floor(Int, value))*":"*lpad(string(floor(Int,(value%1)*60)), 2, "0")
end

function select_reps(exercise)
    difficulty = exercise[:difficulty]
    reps_0 = convert_to_float(exercise[:reps_0])
    reps_10 = convert_to_float(exercise[:reps_10])

    value = reps_0 + (reps_10 - reps_0)*difficulty/10

    # determining whether set is in reps or duration
    colon_loc = findfirst(":", exercise[:reps_0])

    if typeof(colon_loc) != Nothing
        return convert_to_time(value)
    else
        return string(floor(Int, value))
    end 
    
end

function select_set!(superset)
    # select set
    set = copy(superset[1][1][1,:])

    # clear weights of chosen set
    superset[1][1][1, :priority] = 0
    superset[1][2] = 0

    # updating weights
    update_weights!(superset)

    # sorting
    sort_sets!(superset)

    return set
end

function update_weights!(superset)
    for i = 1:size(superset)[1]
        superset[i][2] += rand()
        for j = 1:size(superset[i][1])[1]
            superset[i][1][j,:priority] += rand()
        end
    end
end

function sort_sets!(superset)
    for i = 1:size(superset)[1]
        sort!(superset[i][1], :priority, rev=true)
    end 

    sort!(superset, by=x->x[2], rev=true)
end

# Ideally, this is a heap of heaps, using BinaryHeap(Base.By(x->x[2]), data)
function create_superset(core_file, mobility_file, arms_file, legs_file)

    core_set = DataFrame(CSV.File("exercises/core.dat"))
    mobility_set = DataFrame(CSV.File("exercises/mobility.dat"))
    arms_set = DataFrame(CSV.File("exercises/arms.dat"))
    legs_set = DataFrame(CSV.File("exercises/legs.dat"))

    # Add a priority column to the data frames
    for set in [core_set, mobility_set, arms_set, legs_set]
        set.priority = rand(size(set)[1])
    end

    superset = [[core_set, rand()],
                [mobility_set, rand()],
                [arms_set, rand()],
                [legs_set, rand()]]

    return sort_sets!(superset)

end
