# Parse image filenames to extract metadata

This function will parse the data from the Image name and will return
the metadata there contained The metadata will be then associated to the
count file as well

## Usage

``` r
string_parsing(.data)
```

## Arguments

- .data:

  dataframe with parsed metadata

## Value

A `dataframe`/`tibble`.

## Examples

``` r
# Basic example with sample data
input_data <- data.frame(
  Image = "B516_Ascites_2023-11-25_DOC2020-12-14_dmso_rep_Ecad_cCasp3_(series 01).tif"
)
test <- drugsens::string_parsing(input_data)

# \donttest{
# Example with actual data processing
data.parsed <- string_parsing(input_data)
# }
```
