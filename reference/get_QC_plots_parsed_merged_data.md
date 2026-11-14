# Plot QC plots and calculate statistics for bound data

This function creates quality control plots and calculates basic
statistics for microscopy data. The plots provide visual insights into
marker expression patterns and data quality.

## Usage

``` r
get_QC_plots_parsed_merged_data(
  .data,
  list_of_columns_to_plot = NULL,
  save_plots = FALSE,
  saving_plots_folder = NULL,
  save_plots_in_patient_specific_subfolders = TRUE,
  fill_color_variable = NULL,
  PID_column_name = "PID",
  isolate_specific_drug = NULL,
  isolate_specific_patient = NULL,
  drug_column_name = "Treatment",
  save_list_of_plots = TRUE,
  p_height = 10,
  p_width = 10,
  verbose = TRUE
)
```

## Arguments

- .data:

  The preprocessed data frame to analyze (either raw bound data from
  [`data_binding()`](https://flalom.github.io/drugsens/reference/data_binding.md)
  or long-format count data from
  [`change_data_format_to_longer()`](https://flalom.github.io/drugsens/reference/change_data_format_to_longer.md)).

- list_of_columns_to_plot:

  Columns to include in plots. If NULL, all numeric columns are used.

- save_plots:

  Logical, whether to save plots to files. Defaults to FALSE.

- saving_plots_folder:

  Directory for saving plots. If NULL and save_plots=TRUE, uses a
  subdirectory of tempdir().

- save_plots_in_patient_specific_subfolders:

  Logical, whether to create patient subdirectories. Defaults to TRUE.

- fill_color_variable:

  Variable name for plot color filling

- PID_column_name:

  Column name for patient IDs. Defaults to "PID".

- isolate_specific_drug:

  Drug name to subset data

- isolate_specific_patient:

  Patient ID to subset data

- drug_column_name:

  Column name for drug information. Defaults to "Treatment".

- save_list_of_plots:

  Logical, whether to return list of plot objects. Defaults to TRUE.

- p_height:

  Plot height in inches. Defaults to 10.

- p_width:

  Plot width in inches. Defaults to 10.

- verbose:

  Logical, whether to show progress messages. Defaults to TRUE.

## Value

If save_list_of_plots=TRUE, returns a named list of ggplot objects.
Otherwise returns invisible(NULL).

## Examples

``` r
# \donttest{
# First load and process example data
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

# Basic usage - create plots for all patients
plots <- get_QC_plots_parsed_merged_data(processed_data)
#> Processing patient: A8759
#> Processing patient: B36
#> Processing patient: B37
#> Processing patient: B38
#> Processing patient: B39

# Save plots to a temporary directory
temp_dir <- file.path(tempdir(), "qc_plots")
plots <- get_QC_plots_parsed_merged_data(
  processed_data,
  save_plots = TRUE,
  saving_plots_folder = temp_dir
)
#> Processing patient: A8759
#> Saved plot to: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots/A8759/20261114_A8759_all_marker_positivity_ratio.pdf
#> Processing patient: B36
#> Saved plot to: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots/B36/20261114_B36_all_marker_positivity_ratio.pdf
#> Processing patient: B37
#> Saved plot to: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots/B37/20261114_B37_all_marker_positivity_ratio.pdf
#> Processing patient: B38
#> Saved plot to: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots/B38/20261114_B38_all_marker_positivity_ratio.pdf
#> Processing patient: B39
#> Saved plot to: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/qc_plots/B39/20261114_B39_all_marker_positivity_ratio.pdf

# Focus on a specific patient
plots <- get_QC_plots_parsed_merged_data(
  processed_data,
  isolate_specific_patient = "B39"
)
#> Processing patient: B39

# Color plots by tissue type
plots <- get_QC_plots_parsed_merged_data(
  processed_data,
  fill_color_variable = "Tissue"
)
#> Processing patient: A8759
#> Processing patient: B36
#> Processing patient: B37
#> Processing patient: B38
#> Processing patient: B39
# }
```
