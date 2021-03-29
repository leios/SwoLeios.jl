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
