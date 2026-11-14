# Internal utility functions for file handling

This file contains internal utility functions for file handling and
processing

## Usage

``` r
list_all_files(define_path, extension, recursive_search)
```

## Examples

``` r
# \donttest{
# Load example data from package
bind_data <- data_binding(
  path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
)
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1..conc2.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1__conc1.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B36_Ascites_rep_cont.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B37_Ascites_Pacli.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B38_Ascites_GP.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B39_Ascites_REP_nir.csv
# }
```
