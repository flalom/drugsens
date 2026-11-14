# Data format changer

This function gets the count data data.frame, that has a wider format
and it returns a longer-formatted data.frame

## Usage

``` r
change_data_format_to_longer(
  .data,
  pattern_column_markers = "_ratio_of_total_cells",
  unique_name_row_identifier = "filter_image",
  additional_columns = TRUE
)
```

## Arguments

- .data:

  The markers count dataframe that is coming from the processing of the
  microscopy data

- pattern_column_markers:

  The markers' pattern name to obtain the column with ratios of the
  markers (it defaults to "\_ratio_of_total_cells")

- unique_name_row_identifier:

  String that indicates the unique identifier for each image, defaults
  as "filter_image"

- additional_columns:

  Logical; whether to keep all standard metadata columns (`PID`, `Date`,
  `DOC`, `Tissue`, `Image_number`, `Treatment`, `Concentration1`,
  `Concentration2`, `ConcentrationUnits1`, `ConcentrationUnits2`,
  `ReplicaOrNot`, `Treatment_complete`) in the long-format output.
  Defaults to `TRUE`.

## Value

A `dataframe`/`tibble`.

## Details

Reformat the counts data in longer format

## Examples

``` r
# \donttest{
# Load and process example data
bind_data <- data_binding(
  path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
)
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1..conc2.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1__conc1.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B36_Ascites_rep_cont.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B37_Ascites_Pacli.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B38_Ascites_GP.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B39_Ascites_REP_nir.csv
counts_dataframe <- make_count_dataframe(bind_data)

# Convert to long format
plotting_ready_dataframe <- change_data_format_to_longer(counts_dataframe)
# }
```
