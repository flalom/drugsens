# Normalize marker values to percent of control

Expresses each marker measurement (or a biological target-cell viability
/ cell-death metric computed from user-selected `dead_markers` and
`viable_markers` / `total_markers`) as a percentage of the mean control
(untreated/vehicle) value within the same patient. This is the standard
first step for building dose response curves and estimating
\\(\mathrm{IC}\_{50}\\) in drug sensitivity assays, following Labrosse
et al. (2024) <doi:10.1016/j.xpro.2024.103274>.

When `dead_markers` (e.g. `"cCASP3"`) and `viable_markers` (e.g.
`"EpCAM_E-Cadherin"`) or `total_markers` (e.g.
`c("EpCAM_E-Cadherin", "cCASP3")`) are supplied,
`normalize_to_control()` first computes for each well/image:

- `dead_cells_ratio`: sum of `dead_markers`

- `total_target_cells_ratio`: sum of `total_markers` (living target
  cells + dying cells, excluding unrelated DAPI-only stromal cells)

- `viable_cells_ratio`: `total_target_cells_ratio - dead_cells_ratio`

- `dead_fraction`: `dead_cells_ratio / total_target_cells_ratio`

- `viable_fraction`: `1 - dead_fraction`
  (`viable_cells_ratio / total_target_cells_ratio`)

and then normalizes the chosen `response_metric` (`"viability"` or
`"cell_death"`) against the matched `control_treatment_name` group.

## Usage

``` r
normalize_to_control(
  .data,
  control_treatment_name = "Control",
  treatment_column_name = "Treatment",
  group_by_columns = "PID",
  value_columns = NULL,
  pattern_column_markers = "_ratio_of_total_cells",
  dead_markers = NULL,
  viable_markers = NULL,
  total_markers = NULL,
  response_metric = c("viability", "cell_death"),
  selected_treatments = NULL,
  consensus_only = FALSE
)
```

## Arguments

- .data:

  A data frame in either the wide format returned by
  [`make_count_dataframe()`](https://flalom.github.io/drugsens/reference/make_count_dataframe.md)
  or the long format returned by
  [`change_data_format_to_longer()`](https://flalom.github.io/drugsens/reference/change_data_format_to_longer.md).

- control_treatment_name:

  Value identifying control/vehicle wells in `treatment_column_name`.
  Defaults to "Control".

- treatment_column_name:

  Column holding the treatment label. Defaults to "Treatment".

- group_by_columns:

  Columns that define a comparable batch: the control mean is computed
  within each combination of these columns. Defaults to "PID".

- value_columns:

  Columns to normalize. If NULL, uses "marker_positivity_ratio" when
  present (long format), otherwise all columns matching
  `pattern_column_markers` (wide format).

- pattern_column_markers:

  Pattern used to auto-detect marker columns in wide format. Defaults to
  "\_ratio_of_total_cells".

- dead_markers:

  Optional character vector of marker name(s) representing dead/dying
  cells (e.g. `"cCASP3"` or `c("cCASP3", "E-Cadherin and cCASP3")`).
  Matches names with or without the `"_ratio_of_total_cells"` suffix.

- viable_markers:

  Optional character vector of marker name(s) representing viable
  target/cancer cells (e.g. `"EpCAM_E-Cadherin"` or `"E-Cadherin"`).
  When multiple `viable_markers` and `dead_markers` are supplied,
  markers are paired positionally if
  `length(viable_markers) == length(dead_markers)`; otherwise all
  combinations are evaluated alongside a combined consensus panel.

- total_markers:

  Optional character vector of marker name(s) representing the total
  target cell population (e.g. `c("EpCAM_E-Cadherin", "cCASP3")`). If
  `NULL` when `dead_markers` and `viable_markers` are provided, defaults
  to `unique(c(viable_markers, dead_markers))`.

- response_metric:

  Metric to compute and normalize when `dead_markers` is provided:
  `"viability"` (default, `1 - dead / total`, which starts at `100%` in
  control and decreases toward `0%` as cells die) or `"cell_death"`
  (`dead / total`).

- selected_treatments:

  Optional character vector of treatment names to keep (in addition to
  `control_treatment_name`). Defaults to `NULL` (all treatments).

- consensus_only:

  Logical; when multiple `viable_markers` or `dead_markers` are supplied
  and `consensus_only = FALSE` (the default), `normalize_to_control()`
  computes each individual marker pair's readout as well as a combined
  `"Consensus (Combined)"` readout across all selected markers. Set
  `consensus_only = TRUE` to return only the combined consensus readout.

## Value

`.data` with an added column per normalized value: "\_pct_of_control" in
wide format, or a single "pct_of_control" column in long format. When
`dead_markers` is supplied, also includes `dead_cells_ratio`,
`viable_cells_ratio`, `total_target_cells_ratio`, `dead_fraction`,
`viable_fraction`, and `is_consensus`.

## Examples

``` r
# A patient with a control group and one drug at three doses
df <- data.frame(
  PID = "PID1",
  Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugA"),
  cCASP3_ratio_of_total_cells = c(10, 10, 5, 20, 40)
)
normalize_to_control(df)
#>    PID Treatment cCASP3_ratio_of_total_cells
#> 1 PID1   Control                          10
#> 2 PID1   Control                          10
#> 3 PID1     DrugA                           5
#> 4 PID1     DrugA                          20
#> 5 PID1     DrugA                          40
#>   cCASP3_ratio_of_total_cells_pct_of_control
#> 1                                        100
#> 2                                        100
#> 3                                         50
#> 4                                        200
#> 5                                        400
```
