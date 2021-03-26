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
end

function increase_difficulty!(set::DataFrameRow)
    set[:difficulty] += 1
end

function decrease_difficulty!(set::DataFrameRow)
    set[:difficulty] -= 1
end
