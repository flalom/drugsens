# Plot some QC plots to define that everything ran correctly

Plot data to visualize immediate trends. This function expects data that
has been processed through make_count_dataframe() and
change_data_format_to_longer() to ensure the correct data structure for
plotting.

## Usage

``` r
get_QC_plots(
  .data,
  patient_column_name = "PID",
  colors = unname(drugsens_palette),
  save_plots = FALSE,
  folder_name = NULL,
  x_plot_var = "Treatment_complete",
  isolate_a_specific_patient = NULL,
  compare_to_control = FALSE,
  control_treatment_name = "Control",
  stat_method = c("wilcox", "t.test"),
  p_adjust_method = "BH",
  pvalue_label = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")
)
```

## Arguments

- .data:

  The preprocessed data (after running make_count_dataframe() and
  change_data_format_to_longer()) merged data.frame that should be
  visualized

- patient_column_name:

  The PID's column name in the merged data.frame (defaults to "PID")

- colors:

  A character vector of colors to supply to personalize the plot,
  defaults to `unname(drugsens_palette)` (8-color CVD-safe palette).

- save_plots:

  A Boolean value indicating if the plots should be saved or not
  (default is FALSE)

- folder_name:

  Directory where plots are saved when `save_plots = TRUE`. Defaults to
  `file.path(tempdir(), "figures")` when `NULL`.

- x_plot_var:

  A string indicating the treatment's full name for the QC plots
  (default is "Treatment_complete")

- isolate_a_specific_patient:

  A string indicating the patient name to isolate for single plot case
  (default is NULL)

- compare_to_control:

  Logical, whether to compute and display statistical comparisons
  against `control_treatment_name` within each marker facet. Defaults to
  FALSE.

- control_treatment_name:

  Value in `x_plot_var` identifying the control/vehicle group when
  `compare_to_control = TRUE`. Defaults to `"Control"`.

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

When `save_plots = FALSE`, returns a `ggplot` object (if a single
patient is plotted) or a named list of `ggplot` objects (keyed by
patient ID). When `save_plots = TRUE`, invisibly returns the named list
of `ggplot` objects after saving PDFs to disk.

## Examples

``` r
# \donttest{
# First process example data
example_path <- system.file("extdata/to_merge/", package = "drugsens")
raw_data <- data_binding(path_to_the_projects_folder = example_path)
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1..conc2.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1__conc1.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B36_Ascites_rep_cont.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B37_Ascites_Pacli.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B38_Ascites_GP.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B39_Ascites_REP_nir.csv
count_data <- make_count_dataframe(raw_data)
processed_data <- change_data_format_to_longer(count_data)

# Create and save plots to temporary directory
temp_dir <- file.path(tempdir(), "qc_plots")
get_QC_plots(
  processed_data,
  save_plots = TRUE,
  folder_name = temp_dir
)
#> Processing patient: A8759
#> Warning: for 'Cell marker positivity — Patient A8759' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Processing patient: B36
#> Warning: for 'Cell marker positivity — Patient B36' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Processing patient: B37
#> Warning: for 'Cell marker positivity — Patient B37' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Processing patient: B38
#> Warning: for 'Cell marker positivity — Patient B38' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Processing patient: B39
#> Warning: for 'Cell marker positivity — Patient B39' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Plots have been saved in: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots

# Create plots for a specific patient
get_QC_plots(
  processed_data,
  isolate_a_specific_patient = "B39",
  save_plots = TRUE,
  folder_name = temp_dir
)
#> Processing patient: B39
#> Warning: for 'Cell marker positivity — Patient B39' in 'mbcsToSbcs': - substituted for — (U+2014)
#> Plots have been saved in: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots
# }
```
