export increase_difficulty, decrease_difficulty, shuffle!
function shuffle!(specset::DataFrame)

    # Set all priorities to be random

    for i = 1:size(specset)[1]
        specset[i,:priority] = rand()
    end

    # Sort
    sort!(specset, :priority, rev=true)
end

function shuffle!(superset)
    for i = 1:size(superset)[1]
        superset[i][2] = rand()
        shuffle!(superset[i][1])
    end

    SwoLeios.sort_sets!(superset)

    output_set(superset)
end

function increase_difficulty(set::NamedTuple)
    new_set = (exercise = set[:exercise], reps_0 = set[:reps_0],
               reps_10 = set[:reps_10], difficulty = set[:difficulty] + 1,
               priority = set[:priority])
    output_set(new_set, select_reps(new_set))
    return new_set
end

function decrease_difficulty(set::NamedTuple)
    new_set = (exercise = set[:exercise], reps_0 = set[:reps_0],
               reps_10 = set[:reps_10], difficulty = set[:difficulty] - 1,
               priority = set[:priority])
    output_set(new_set, select_reps(new_set))
    return new_set
end

function increase_difficulty!(set::DataFrameRow)
    set[:difficulty] += 1
end

function decrease_difficulty!(set::DataFrameRow)
    set[:difficulty] -= 1
end
