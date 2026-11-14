# Generate the groovy script used for the analysis

Generate a useful script to consistently save the output data from
QuPath in .csv format following the naming conventions followed during
the package development.

## Usage

``` r
generate_qupath_script(output_dir = NULL)
```

## Arguments

- output_dir:

  Directory where the script should be saved. If NULL, uses tempdir()

## Value

Invisibly returns the path to the generated script file.

## Examples

``` r
# \donttest{
  # Generate script in a temporary directory
  generate_qupath_script()
#> You can now take the script and personalize it to your needs
#> 2026-11-14 14:45:52.603693 The script file was generated here: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/script_for_qupath.txt
#> 2026-11-14 14:45:52.603879 Please make sure to follow the name convention here proposed, or it might fail to get all the information

  # Generate script in a specific directory
  output_dir <- tempdir()
  generate_qupath_script(output_dir = output_dir)
#> You can now take the script and personalize it to your needs
#> 2026-11-14 14:45:52.604591 The script file was generated here: /var/folders/t6/78b91bxn6txf3zfdbjyxvpqm0000gn/T//RtmplAOhLx/script_for_qupath.txt
#> 2026-11-14 14:45:52.604755 Please make sure to follow the name convention here proposed, or it might fail to get all the information
# }
```
