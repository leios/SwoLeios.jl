module SwoLeios

export next_set

using DataFrames
using CSV

include("selection.jl")
include("update.jl")

function next_set(superset)
    set = select_set!(superset)
    reps = select_reps(set)
    return string(reps)*'\t'*string(set[:exercise])
end

end # module
