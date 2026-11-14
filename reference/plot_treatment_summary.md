# Plot a ranked summary of mean percent-of-control by treatment

Summarizes
[`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md)
output into one bar per treatment: the mean percent-of-control value
across all concentrations and replicates, with a standard error bar,
ranked from strongest to weakest effect. A quick way to rank an entire
drug panel by response.

## Usage

``` r
plot_treatment_summary(
  .data,
  treatment_column_name = "Treatment",
  control_treatment_name = "Control",
  compare_to_control = FALSE,
  stat_method = c("wilcox", "t.test"),
  p_adjust_method = "BH",
  pvalue_label = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")
)
```

## Arguments

- .data:

  Data frame that has been through
  [`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md)
  on the long format (must contain "pct_of_control", "marker_positivity"
  and a treatment column).

- treatment_column_name:

  Column holding the treatment label. Defaults to "Treatment".

- control_treatment_name:

  Value identifying control/vehicle wells, excluded from the summary.
  Defaults to "Control".

- compare_to_control:

  Logical; whether to compute and annotate p-values comparing each
  treatment against `control_treatment_name` per marker facet. Defaults
  to `FALSE`.

- stat_method:

  Statistical test used when `compare_to_control = TRUE`: `"wilcox"`
  (default) or `"t.test"`.

- p_adjust_method:

  Multiple-testing correction method passed to
  [`stats::p.adjust()`](https://rdrr.io/r/stats/p.adjust.html) across
  treatments within each marker facet. Supports `"BH"`
  (Benjamini-Hochberg FDR, default), `"bonferroni"`, `"holm"`, `"fdr"`,
  `"hochberg"`, `"hommel"`, `"BY"`, or `"none"`.

- pvalue_label:

  Format for p-value annotations: `"p.adj.signif"` (adjusted `*`, `**`,
  `***`, `ns`, default), `"p.signif"` (unadjusted), `"p.adj.format"`, or
  `"p.format"`.

## Value

A `ggplot` object (with `attr(plot, "stats")` populated when
`compare_to_control = TRUE`).

## Details

When multiple drug concentrations or imaged fields of view are present
in `.data`, `compare_to_control = TRUE` pools all normalized
observations for each treatment against `control_treatment_name` to test
for an overall treatment effect across the tested condition. To test
specific concentrations individually without pooling across doses,
subset `.data` to a single concentration first or use
`get_QC_plots(..., x_plot_var = "Treatment_complete", compare_to_control = TRUE)`.

## Examples

``` r
df <- data.frame(
  PID = "PID1",
  Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
  marker_positivity = "cCASP3",
  marker_positivity_ratio = c(10, 10, 4, 6, 14, 16)
)
normalized <- normalize_to_control(df)
plot_treatment_summary(normalized)
```
