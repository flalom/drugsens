# Process a Single File

This function returns a processed single file

## Usage

``` r
process_file(
  file_path,
  extension,
  relabeling_map = .drugsens_env$list_of_relabeling
)
```

## Arguments

- file_path:

  Path to the file

- extension:

  String File extension to filter

- relabeling_map:

  Named list mapping raw marker names to standardized names

## Value

dataframe
