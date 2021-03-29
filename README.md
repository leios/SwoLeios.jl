# SwoLeios

This is a simple repository to select a short exercise to do for roughly 5 minutes every hour

Example run:
```
using SwoLeios
superset = SwoLeios.create_superset("exercises/core.dat", "exercises/mobility.dat", "exercises/arms.dat", "exercises/legs.dat")
(set, reps) = cycle_set!(superset)
```

`cycle_set(superset)` will give the next set, but will also decrease its priority and resort the superset.
If you want to get the next set without changing the superset, use `next_set(superset)`.

Also, the following commands are available:

```
set = increase_difficulty(set)
set = decrease_difficulty(set)
shuffle!(superset)
```

List of things to do:
* Implement "heaps of heaps" to select exercise

Finicky things to think about:
* Determining whether set is in reps or duration is weird for `select_reps()`
* Can we just use `time` directly?
* if the dataframe is read in with a duration as the first row, it will assume everything is a "Date," which breaks things
* if no duration is present in exercises, dataframes assume that the column is for integers and things break
* by=x->x[2] for heaps?
* some sets do not fit on the image

