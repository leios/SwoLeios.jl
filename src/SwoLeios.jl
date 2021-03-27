module SwoLeios

export cycle_set!, next_set, output_set

using DataFrames
using CSV

include("selection.jl")
include("update.jl")

function output_set(superset)
    (set, reps) = next_set(superset)
    output_set(set, reps)
end

function output_set(set, reps)
    set_str = string(reps)*' '*string(set[:exercise])
    output_file = open("set.txt", "w")
    write(output_file, "Next: "*set_str)
    close(output_file)
    run(`sh bin/draw_set`)
    return set_str
end

function next_set(superset)
    set = copy(superset[1][1][1,:])
    reps = select_reps(set)
    return (set, reps)
end

function cycle_set!(superset)
    set = select_set!(superset)
    reps = select_reps(set)
    return output_set(set, reps)
end

end # module
