# Merge all the dataframes coming out from the QuPath

This function identifies string patterns in the dataset, fills the
dataframe with that information, and combines all data into a single
file. Marker relabeling is loaded from `config_drugsens.txt` via
[`make_run_config()`](https://flalom.github.io/drugsens/reference/make_run_config.md)
without modifying `.GlobalEnv`.

## Usage

``` r
data_binding(
  path_to_the_projects_folder,
  files_extension_to_look_for = "csv",
  recursive_search = FALSE,
  forcePath = NULL
)
```

## Arguments

- path_to_the_projects_folder:

  String/Path The path where the files coming out of QuPath are located

- files_extension_to_look_for:

  String The extension of the file outputted from QuPath, (default is
  "csv")

- recursive_search:

  Boolean, it defined the behavior of the file search, if recursive or
  not, (default is FALSE)

- forcePath:

  Optional directory path containing `config_drugsens.txt`. Defaults to
  `NULL` ([`tempdir()`](https://rdrr.io/r/base/tempfile.html)).

## Value

A concatenated dataframe from all the files within the indicated path

## Examples

``` r
# \donttest{
bind_data <- data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/",
                         package = "drugsens"))
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1..conc2.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1__conc1.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B36_Ascites_rep_cont.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B37_Ascites_Pacli.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B38_Ascites_GP.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B39_Ascites_REP_nir.csv
# }
```
