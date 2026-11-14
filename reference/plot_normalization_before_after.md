# Plot the raw values next to the normalized values, before and after

Shows the raw marker ratio (before) side by side with the
percent-of-control value (after
[`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md)),
one pair of panels per marker, so you can see at a glance what control
normalization did to the data.

## Usage

``` r
plot_normalization_before_after(.data, treatment_column_name = "Treatment")
```

## Arguments

- .data:

  Data frame that has been through
  [`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md)
  on the long format (must contain "marker_positivity_ratio",
  "pct_of_control", "marker_positivity" and a treatment column).

- treatment_column_name:

  Column holding the treatment label. Defaults to "Treatment".

## Value

A `ggplot` object.

## Examples

``` r
df <- data.frame(
  PID = "PID1",
  Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
  marker_positivity = "cCASP3",
  marker_positivity_ratio = c(10, 12, 4, 6, 18, 20)
)
normalized <- normalize_to_control(df)
plot_normalization_before_after(normalized)
```
