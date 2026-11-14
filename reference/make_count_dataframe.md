# Count the main marker expression

This function counts every single marker present in the "Name" column of
the data.frame and return a dataframe of the counts per marker

## Usage

``` r
make_count_dataframe(
  .data,
  unique_name_row_identifier = "filter_image",
  name_of_the_markers_column = "Name"
)
```

## Arguments

- .data:

  The dataframe that is coming from the processing of the microscopy
  data

- unique_name_row_identifier:

  The name of the column of the .data where the unique name can be used
  to counts (it defaults to "filter_image")

- name_of_the_markers_column:

  The name of the column of the .data where the marker names are
  expressed (ie E-Caderin, DAPI), "Defaults as Name"

## Value

A `dataframe`/`tibble`.

## Examples

``` r
# \donttest{
# First load example data
pkg_path <- system.file("extdata/to_merge/", package = "drugsens")
bind_data <- data_binding(
  path_to_the_projects_folder = pkg_path,
  files_extension_to_look_for = "csv"
)
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1..conc2.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//A8759_drug1__conc1.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B36_Ascites_rep_cont.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B37_Ascites_Pacli.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B38_Ascites_GP.csv
#> Reading file: /Users/flalom/Library/R/arm64/4.6/library/drugsens/extdata/to_merge//B39_Ascites_REP_nir.csv

# Process the data
counts_dataframe <- make_count_dataframe(bind_data)

# Convert to plotting format
plotting_ready_dataframe <- change_data_format_to_longer(counts_dataframe)
# }

# \donttest{
# Example with custom parameters
make_count_dataframe(
  bind_data,
  name_of_the_markers_column = "Name",
  unique_name_row_identifier = "filter_image"
)
#>                                                                                                                   E-Cadherin
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                          36
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                          49
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                          37
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                          44
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                          39
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                           33
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                           35
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                           40
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                           39
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                           35
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                         16
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                         20
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                         20
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                         18
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                         15
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                             39
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                             37
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                             34
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                             46
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                             43
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        6
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        7
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        9
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        9
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        8
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                           46
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                           52
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                           42
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                           43
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                           43
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                           42
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               48
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               48
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               36
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               48
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   32
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   31
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   33
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   34
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 11
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  8
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                7
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                3
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                3
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                6
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 53
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 46
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 46
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 36
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     41
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     44
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     34
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     41
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   20
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   23
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   22
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   19
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  7
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 13
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  9
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 10
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          9
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          9
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         10
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          5
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          9
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                           42
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                           45
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                           36
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                           47
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                           46
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                           40
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               49
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               38
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               34
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               51
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   37
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   37
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   39
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   31
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 16
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 24
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 15
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 15
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                5
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                7
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                4
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                2
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 52
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 37
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 43
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 43
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     34
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     32
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     37
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     40
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   29
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   23
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   24
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   21
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 12
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 12
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  9
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 11
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          6
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         10
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         10
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          7
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          5
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             13
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             11
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             12
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              9
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              8
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                               34
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                               41
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                               49
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                               40
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                               33
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                               34
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   37
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   40
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   40
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   41
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       37
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       33
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       40
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       30
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     23
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     21
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     18
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     24
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    6
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    5
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    9
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    7
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     34
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     43
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     34
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     38
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         37
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         37
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         37
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         40
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       24
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       27
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       25
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       32
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     12
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      9
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     10
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      9
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                           50
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                           49
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                           48
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                           40
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                           43
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                           56
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               46
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               35
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               49
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               40
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   31
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   27
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   29
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   25
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 11
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  8
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 11
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                5
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                4
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                5
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                4
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 44
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 34
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 51
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 44
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     35
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     37
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     37
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     40
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   19
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   17
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   19
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   17
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  7
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  8
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  8
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  6
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         13
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         10
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          7
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          7
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM          8
#>                                                                                                                   E-Cadherin and cCASP3
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                      4
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                      6
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                      2
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                      3
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                      3
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                       8
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                       6
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                       5
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                       8
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                       8
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                    12
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                     9
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                    12
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                     9
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                    11
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         3
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         4
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         4
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         5
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         3
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                  12
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                   8
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                  10
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                  10
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                   9
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                       3
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                       5
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                       2
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                       5
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           6
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           8
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           6
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           5
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              12
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              11
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              11
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              12
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            14
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            20
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            17
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            18
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          14
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          12
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           9
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          13
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             5
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             6
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             4
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             5
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 7
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                11
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 7
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 7
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              14
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              10
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              10
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              11
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            10
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            14
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            11
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            12
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    15
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                     9
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    14
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    15
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    14
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                       3
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                       5
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                       2
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                       2
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           8
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           3
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           4
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           6
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                               5
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                               8
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                               9
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                               8
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            15
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            15
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            14
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            19
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          11
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          12
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           9
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           9
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             5
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             3
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             5
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             7
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 6
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 5
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 7
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                 5
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                               8
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                               9
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                               8
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              10
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                             7
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                             9
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                             9
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            12
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    12
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                     9
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    17
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    12
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    11
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                        11
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                        10
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                        10
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                        13
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                        15
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                           5
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                           3
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                           3
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                           3
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                           4
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                           5
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                               3
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                               3
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                               3
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                               7
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                   4
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                   6
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                   4
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                   4
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 9
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 7
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 7
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 7
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                               6
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                               8
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                              13
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                               9
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 4
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 6
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 4
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 3
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                     5
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                     6
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                     3
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                     5
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                   6
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                   9
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                   8
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                   7
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 8
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 6
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 7
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 5
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                       4
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                       6
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                       6
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                       5
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           7
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           7
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           6
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           5
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              19
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              22
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              15
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                              15
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            19
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            16
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            23
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                            18
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          13
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          16
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          13
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                          11
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             6
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             4
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             7
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                             8
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                13
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                10
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                10
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                10
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              17
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              16
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              14
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                              13
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                             7
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            14
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            11
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                            14
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    21
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    16
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    13
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    11
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                    10
#>                                                                                                                   cCASP3
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                       1
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                       2
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                       1
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                       2
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                       2
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                        4
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                        5
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                        3
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                        5
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                        4
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                     20
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                     21
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                     21
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                     19
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                     17
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                          1
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                          1
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                          1
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                          1
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                          1
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                   29
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                   30
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                   30
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                   23
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                   26
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        3
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        3
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                5
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                4
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                7
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                5
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             23
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             26
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             20
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             26
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           38
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           35
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           40
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           38
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              2
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  4
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               17
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               20
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               14
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               17
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             33
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             32
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             35
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             32
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     31
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     25
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     21
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     32
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     26
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        3
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        1
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                2
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                3
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                4
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                2
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             15
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             24
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             17
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             19
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           25
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           31
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           34
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           39
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              2
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              2
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  2
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               16
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               15
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               13
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               13
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             32
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             37
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             25
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             33
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     27
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     29
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     25
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     25
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     25
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         26
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         28
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         27
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         28
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         24
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                            1
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                            2
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                            2
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                            2
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                            2
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                            2
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                1
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                1
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                1
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                2
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    2
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    2
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    2
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    1
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  9
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 12
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               29
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               29
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               28
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               30
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  1
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  1
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  2
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  1
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      3
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      3
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      2
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      2
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                    9
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   13
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   10
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   11
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 26
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 25
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 25
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 24
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        1
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        3
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        2
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            2
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            1
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                8
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                9
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                6
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                7
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             32
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             26
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             26
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             23
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           45
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           40
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           35
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           41
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              2
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              2
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              1
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  5
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  5
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  5
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  4
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               22
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               23
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               20
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               19
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             36
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             31
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             38
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             37
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     32
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     32
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     25
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     38
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     29
#>                                                                                                                   onlyDAPIPositve
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                               24
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                8
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                               25
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                               16
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                               21
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                20
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                19
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                17
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                13
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                18
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                              17
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                              15
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                              12
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                              19
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                              22
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  22
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  23
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  26
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  13
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  18
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                            18
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                            20
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                            16
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                            23
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                            22
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                19
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                15
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                12
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                22
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                17
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                19
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    20
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    12
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    22
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    12
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        15
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        20
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        14
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        16
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      21
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                       8
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      20
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      14
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    16
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    22
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    11
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    16
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      10
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                       9
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      21
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      19
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          13
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          16
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          22
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          13
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        18
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        16
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        14
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        14
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      13
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      12
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      20
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      21
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              14
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              19
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              19
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              17
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              23
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                22
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                19
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                20
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                18
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                19
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                16
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    12
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    24
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    24
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    15
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        24
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        22
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        18
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        19
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      15
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      12
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      29
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      21
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    29
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    19
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    23
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    25
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      15
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      20
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      18
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      20
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          18
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          21
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          14
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          25
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        21
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        20
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        21
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        26
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      21
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      16
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      24
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      11
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              24
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              18
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              23
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              26
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              23
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  25
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  23
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  24
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  19
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  24
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    22
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                    21
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                    21
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                    28
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                    30
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                    30
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        23
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        19
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        25
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        21
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            24
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            27
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            18
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            25
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          24
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          24
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          28
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          32
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        27
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        24
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        23
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        22
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          24
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          25
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          32
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          32
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              19
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              28
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              21
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              24
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            32
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            24
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            23
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            23
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          21
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          20
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          21
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          22
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                19
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                 5
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                11
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                16
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                21
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                10
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                     9
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    19
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                     8
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                    16
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        15
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        13
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        18
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        17
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                       7
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      13
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      12
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                      15
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                     7
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    10
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    14
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                    18
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      17
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      21
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      13
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                      14
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          11
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                           8
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          16
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          12
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        13
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        18
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        16
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                        15
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      11
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      11
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      12
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                      17
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               6
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              12
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              16
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               9
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM              16
#>                                                                                                                   sum_cells
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                         65
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                         65
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                         65
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                         65
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                         65
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          65
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          65
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          65
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          65
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          65
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        65
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        65
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        65
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        65
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        65
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            65
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            65
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            65
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            65
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            65
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      65
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      65
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      65
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      65
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      65
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                          69
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                          75
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                          60
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                          68
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                          68
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                          67
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              75
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              70
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              66
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              67
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  64
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  66
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  65
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  67
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                67
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                65
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                65
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                67
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              75
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              72
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              63
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              73
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                70
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                62
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                72
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                61
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    63
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    75
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    65
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    63
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  69
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  69
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  60
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  61
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                63
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                71
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                75
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                75
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        69
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        62
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        64
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        69
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        72
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                          69
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                          72
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                          62
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                          71
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                          68
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                          60
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              71
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              66
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              63
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              74
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  68
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  70
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  70
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  60
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                61
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                75
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                75
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                74
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              70
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              69
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              70
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              75
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                73
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                61
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                68
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                72
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    60
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    60
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    60
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    72
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  74
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  67
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  66
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  70
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                72
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                74
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                67
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                67
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        69
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        66
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        75
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        70
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        64
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            75
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            72
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            73
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            69
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            71
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                              62
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                              67
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                              75
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                              73
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                              69
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                              71
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  64
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  63
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  69
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  71
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      67
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      68
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      64
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      60
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    65
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    61
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    62
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    75
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  68
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  66
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  73
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  68
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    63
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    75
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    72
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    74
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                        64
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                        74
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                        63
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                        71
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                      71
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                      73
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                      66
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                      73
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    67
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    60
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    63
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    60
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                          75
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                          60
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                          64
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                          65
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                          72
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                          73
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              64
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              62
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              64
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              62
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  73
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  71
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  68
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  64
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                69
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                63
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                72
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                65
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              70
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              70
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              67
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              74
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                69
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                60
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                73
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                67
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    64
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    60
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    68
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    66
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  71
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  74
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  69
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  64
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                61
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                64
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                69
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                74
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        72
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        70
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        61
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        65
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        63
#>                                                                                                                   onlyDAPIPositve_ratio_of_total_cells
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                0.3692
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                0.1231
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                0.3846
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                0.2462
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                0.3231
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                 0.3077
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                 0.2923
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                 0.2615
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                 0.2000
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                 0.2769
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                               0.2615
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                               0.2308
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                               0.1846
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                               0.2923
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                               0.3385
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                   0.3385
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                   0.3538
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                   0.4000
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                   0.2000
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                   0.2769
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                             0.2769
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                             0.3077
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                             0.2462
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                             0.3538
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                             0.3385
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2754
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2000
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2000
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                 0.3235
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2500
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2836
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.2667
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.1714
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.3333
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.1791
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2344
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.3030
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2154
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2388
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.3134
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.1231
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.3077
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.2090
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.2133
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.3056
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.1746
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.2192
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.1429
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.1452
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2917
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.3115
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.2063
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.2133
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.3385
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.2063
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2609
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2319
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2333
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2295
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2063
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.1690
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2667
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2800
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2029
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3065
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2969
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2464
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3194
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                 0.3188
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2639
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                 0.3226
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2535
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2794
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2667
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.1690
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.3636
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.3810
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.2027
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.3529
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.3143
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2571
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.3167
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.2459
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.1600
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.3867
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.2838
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.4143
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.2754
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.3286
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.3333
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2055
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.3279
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2647
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2778
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.3000
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.3500
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.2333
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.3472
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2838
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2985
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.3182
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.3714
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2917
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2162
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.3582
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.1642
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3478
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2727
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3067
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3714
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.3594
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                   0.3333
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                   0.3194
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                   0.3288
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                   0.2754
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                   0.3380
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                     0.3548
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                                     0.3134
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                                     0.2800
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                                     0.3836
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                                     0.4348
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                                     0.4225
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                         0.3594
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                         0.3016
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                         0.3623
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                         0.2958
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             0.3582
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             0.3971
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             0.2812
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             0.4167
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                           0.3692
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                           0.3934
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                           0.4516
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                           0.4267
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                         0.3971
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                         0.3636
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                         0.3151
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                         0.3235
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                           0.3810
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                           0.3333
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                           0.4444
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                           0.4324
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                               0.2969
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                               0.3784
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                               0.3333
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                               0.3380
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             0.4507
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             0.3288
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             0.3485
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             0.3151
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                           0.3134
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                           0.3333
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                           0.3333
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                           0.3667
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2533
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                 0.0833
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                 0.1719
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2462
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                 0.2917
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                 0.1370
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.1406
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.3065
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.1250
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     0.2581
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2055
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.1831
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2647
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                         0.2656
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.1014
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.2063
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.1667
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                       0.2308
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.1000
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.1429
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.2090
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     0.2432
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2464
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.3500
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.1781
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                       0.2090
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.1719
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.1333
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.2353
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                           0.1818
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.1831
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2432
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2319
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                         0.2344
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.1803
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.1719
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.1739
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                       0.2297
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.0833
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.1714
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2623
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.1385
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                               0.2540
#>                                                                                                                   E-Cadherin_ratio_of_total_cells
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                           0.5538
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                           0.7538
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                           0.5692
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                           0.6769
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                           0.6000
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                            0.5077
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                            0.5385
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                            0.6154
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                            0.6000
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                            0.5385
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                          0.2462
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                          0.3077
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                          0.3077
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                          0.2769
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                          0.2308
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                              0.6000
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                              0.5692
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                              0.5231
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                              0.7077
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                              0.6615
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                        0.0923
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                        0.1077
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                        0.1385
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                        0.1385
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                        0.1231
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                            0.6667
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                            0.6933
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                            0.7000
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                            0.6324
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                            0.6324
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                            0.6269
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.6400
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.6857
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.5455
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.7164
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5000
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.4697
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5077
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5075
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1343
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1692
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1231
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1343
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0933
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0417
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0476
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0822
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.7571
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.7419
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6389
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.5902
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.6508
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5867
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5231
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.6508
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.2899
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3333
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3667
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3115
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1111
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1831
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1200
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1333
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1304
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1452
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1562
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.0725
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1250
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                            0.6087
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                            0.6250
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                            0.5806
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                            0.6620
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                            0.6765
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                            0.6667
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.6901
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.5758
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.5397
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.6892
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5441
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5286
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5571
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.5167
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.2623
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.3200
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.2000
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.2027
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0714
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.1014
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0571
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0267
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.7123
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6066
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6324
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.5972
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5667
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5333
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.6167
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5556
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3919
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3433
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3636
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.3000
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1667
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1622
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1343
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1642
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.0870
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1515
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1333
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1000
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.0781
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                              0.1733
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                              0.1528
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                              0.1644
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                              0.1304
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                              0.1127
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                0.5484
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                                0.6119
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                                0.6533
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                                0.5479
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                                0.4783
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                                0.4789
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                    0.5781
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                    0.6349
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                    0.5797
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                    0.5775
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                        0.5522
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                        0.4853
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                        0.6250
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                        0.5000
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                      0.3538
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                      0.3443
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                      0.2903
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                      0.3200
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                    0.0882
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                    0.0758
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                    0.1233
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                    0.1029
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                      0.5397
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                      0.5733
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                      0.4722
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                      0.5135
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                          0.5781
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                          0.5000
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                          0.5873
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                          0.5634
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                        0.3380
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                        0.3699
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                        0.3788
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                        0.4384
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                      0.1791
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                      0.1500
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                      0.1587
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                      0.1500
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                            0.6667
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                            0.8167
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                            0.7500
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                            0.6154
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                            0.5972
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                            0.7671
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.7188
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.5645
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.7656
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.6452
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.4247
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.3803
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.4265
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.3906
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1594
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1270
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1528
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1385
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0714
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0571
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0746
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.0541
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6377
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.5667
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6986
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.6567
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5469
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.6167
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.5441
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.6061
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.2676
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.2297
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.2754
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.2656
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1148
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1250
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.1159
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.0811
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1806
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1429
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1148
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1077
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.1270
#>                                                                                                                   cCASP3_ratio_of_total_cells
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                       0.0154
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                       0.0308
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                       0.0154
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                       0.0308
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                       0.0308
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                        0.0615
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                        0.0769
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                        0.0462
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                        0.0769
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                        0.0615
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                      0.3077
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                      0.3231
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                      0.3231
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                      0.2923
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                      0.2615
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                          0.0154
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                          0.0154
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                          0.0154
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                          0.0154
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                          0.0154
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                    0.4462
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                    0.4615
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                    0.4615
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                    0.3538
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                    0.4000
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                        0.0145
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                        0.0400
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                        0.0333
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                        0.0147
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                        0.0441
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                        0.0299
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0133
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0286
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0303
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0299
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0781
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0606
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.1077
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0746
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3433
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.4000
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3077
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3881
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5067
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.4861
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.6349
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5205
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0286
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0161
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0139
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0164
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0317
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0533
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0308
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0317
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2464
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2899
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2333
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2787
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.5238
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4507
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4667
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4267
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4493
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4032
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3281
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4638
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3611
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                        0.0290
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                        0.0417
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                        0.0323
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                        0.0282
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                        0.0147
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                        0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0282
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0152
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0159
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0270
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0294
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0429
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0571
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.2459
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3200
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.2267
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.2568
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.3571
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.4493
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.4857
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5200
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0137
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0164
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0294
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0278
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0278
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2162
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2239
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.1970
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.1857
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4444
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.5000
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.3731
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4925
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3913
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4394
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3333
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3571
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.3906
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.3467
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.3889
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.3699
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.4058
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                          0.3380
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                            0.0161
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                            0.0299
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                            0.0267
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                            0.0274
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                            0.0290
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                            0.0282
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.0156
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.0159
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.0145
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                0.0282
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.0299
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.0294
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.0312
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                    0.0167
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1385
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1475
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1452
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                  0.1600
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.4265
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.4394
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.3836
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                0.4412
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.0159
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.0133
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.0278
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                  0.0135
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.0469
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.0405
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.0317
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                      0.0282
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.1268
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.1781
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.1515
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                    0.1507
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.3881
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.4167
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.3968
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                  0.4000
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                        0.0267
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                        0.0333
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                        0.0156
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                        0.0462
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                        0.0278
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                        0.0274
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0312
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0161
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0156
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            0.0161
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.1096
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.1268
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.0882
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                0.1094
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.4638
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.4127
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3611
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              0.3538
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.6429
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5714
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5224
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            0.5541
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0290
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0167
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0274
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              0.0149
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0781
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0833
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0735
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  0.0606
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.3099
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.3108
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2899
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                0.2969
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.5902
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.4844
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.5507
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              0.5000
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4444
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4571
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4098
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.5846
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      0.4603
#>                                                                                                                   E-Cadherin and cCASP3_ratio_of_total_cells
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                      0.0615
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                      0.0923
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                      0.0308
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                      0.0462
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                      0.0462
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                       0.1231
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                       0.0923
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                       0.0769
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                       0.1231
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                                       0.1231
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                                     0.1846
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                                     0.1385
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                                     0.1846
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                                     0.1385
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                                     0.1692
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                         0.0462
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                         0.0615
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                         0.0615
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                         0.0769
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                                         0.0462
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                                   0.1846
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                                   0.1231
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                                   0.1538
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                                   0.1538
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                                   0.1385
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0435
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0667
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0667
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0294
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0735
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0597
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0800
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.1143
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0909
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0746
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1875
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1667
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1692
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1791
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2090
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.3077
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2615
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2687
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1867
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1667
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1429
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1781
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0714
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0968
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0556
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0820
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1111
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1467
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1077
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1111
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.2029
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1449
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1667
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1803
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1587
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1972
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1467
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1600
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2174
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1452
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2188
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2174
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1944
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0435
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0694
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0645
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0563
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0294
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0333
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.1127
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0455
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0635
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0811
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.0735
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1143
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1286
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.1333
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2459
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2000
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.1867
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2568
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1571
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1739
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1286
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1200
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0685
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0492
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0735
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0972
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1000
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.0833
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1167
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.0694
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1081
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1343
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1212
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.1429
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.0972
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1216
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1343
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1791
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1739
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1364
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2267
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1714
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1719
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                         0.1467
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                         0.1389
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                         0.1370
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                         0.1884
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                         0.2113
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0806
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0448
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0400
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0411
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0580
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                                           0.0704
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                               0.0469
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                               0.0476
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                               0.0435
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                               0.0986
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                                   0.0597
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                                   0.0882
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                                   0.0625
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                                   0.0667
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                                 0.1385
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                                 0.1148
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                                 0.1129
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                                 0.0933
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                               0.0882
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                               0.1212
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                               0.1781
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                               0.1324
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                                 0.0635
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                                 0.0800
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                                 0.0556
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                                 0.0405
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                     0.0781
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                     0.0811
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                     0.0476
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                     0.0704
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                                   0.0845
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                                   0.1233
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                                   0.1212
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                                   0.0959
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                                 0.1194
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                                 0.1000
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                                 0.1111
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                                 0.0833
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0533
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0667
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0625
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0923
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0833
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                       0.0685
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.1094
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.1129
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0938
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                           0.0806
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.2603
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.3099
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.2206
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                               0.2344
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2754
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2540
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.3194
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                             0.2769
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1857
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.2286
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1940
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                           0.1486
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0870
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0667
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.0959
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                             0.1194
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.2031
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1667
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1471
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 0.1515
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.2394
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.2162
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.2029
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                               0.2031
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1148
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.2188
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1594
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                             0.1892
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2917
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2286
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.2131
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1692
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                                     0.1587
#>                                                                                                                                                                                                                        filter_image
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                   A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                   A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                   A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                   A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                   A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                     A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                     A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                     A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                     A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                     A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                 A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                 A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                 A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                 A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                 A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                         A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                             A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                             A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                             A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                             A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                             A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                     B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                     B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                                             B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                                     B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                             B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                         B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                         B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                         B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                         B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                                     B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                         B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                         B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                         B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                         B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                                 B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                             B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                         B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                         B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                         B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                         B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                                     B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                             B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                             B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                         B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                     B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                                 B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM
#>                                                                                                                     PID
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                  A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                  A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                  A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                  A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                  A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 A8759
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               A8759
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               A8759
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                     B36
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B36
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B36
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B36
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B36
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B36
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B36
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B36
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B36
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B36
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B36
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B36
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B36
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                     B37
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B37
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B37
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B37
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B37
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B37
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B37
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B37
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B37
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B37
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B37
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B37
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B37
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM       B38
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM       B38
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM       B38
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM       B38
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM       B38
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                         B38
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                             B38
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                   B38
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                   B38
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                   B38
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                   B38
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                 B38
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                               B38
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                               B38
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                     B39
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                         B39
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B39
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B39
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B39
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                               B39
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                             B39
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                           B39
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B39
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B39
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B39
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B39
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM   B39
#>                                                                                                                         Date
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                  2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                  2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                  2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                  2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                  2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2020.11.10
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2020.11.10
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2020.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                       2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.11.10
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.11.10
#>                                                                                                                          DOC
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                  2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                  2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                  2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                  2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                  2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                   2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2001.10.05
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                 2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                     2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2001.10.05
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM               2001.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                       2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                           2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                 2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                               2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.10.05
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                             2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM 2023.10.05
#>                                                                                                                    Tissue
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                   Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                   Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                   Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                   Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                   Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                    Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                    Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                    Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                    Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                    Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                  Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                  Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                  Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                  Spleen
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                  Spleen
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                      p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                      p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                      p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                      p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                      p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                p.wash
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                p.wash
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         Eye
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         Eye
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         Eye
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         Eye
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM         Eye
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                           Eye
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                               Eye
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     Eye
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     Eye
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     Eye
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                     Eye
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                   Eye
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 Eye
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                 Eye
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                   Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                       Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                             Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                           Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                         Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM Ascites
#>                                                                                                                   Image_number
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                     series 01
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                     series 02
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                     series 03
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                     series 04
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                     series 05
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                      series 06
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                      series 07
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                      series 08
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                      series 09
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                      series 10
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                    series 11
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                    series 12
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                    series 13
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                    series 14
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                    series 15
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                        series 16
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                        series 17
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                        series 18
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                        series 19
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                        series 20
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                  series 21
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                  series 22
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                  series 23
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                  series 24
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                  series 25
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                      series 01
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                      series 02
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                      series 03
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                      series 04
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                      series 05
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                      series 06
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 07
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 08
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 09
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 10
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 11
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 12
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 13
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 14
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 15
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 16
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 17
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 18
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 19
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 20
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 21
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 22
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 23
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 24
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 25
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 26
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 27
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 28
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 29
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 30
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 31
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 32
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 33
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 34
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 35
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 36
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 37
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 38
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 39
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 40
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 41
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 42
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 43
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                      series 01
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                      series 02
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                      series 03
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                      series 04
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                      series 05
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                      series 06
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 07
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 08
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 09
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 10
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 11
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 12
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 13
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 14
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 15
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 16
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 17
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 18
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 19
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 20
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 21
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 22
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 23
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 24
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 25
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 26
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 27
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 28
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 29
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 30
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 31
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 32
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 33
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 34
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 35
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 36
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 37
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 38
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 39
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 40
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 41
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 42
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 43
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        series 01
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        series 02
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        series 03
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        series 04
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM        series 05
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                          series 06
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                          series 07
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                          series 08
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                          series 09
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                          series 10
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                          series 11
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              series 12
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              series 13
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              series 14
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                              series 15
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  series 16
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  series 17
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  series 18
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                  series 19
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                series 20
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                series 21
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                series 22
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                series 23
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              series 24
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              series 25
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              series 26
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                              series 27
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                series 28
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                series 29
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                series 30
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                series 31
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    series 32
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    series 33
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    series 34
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                    series 35
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  series 36
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  series 37
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  series 38
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                  series 39
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                series 40
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                series 41
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                series 42
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                series 43
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                      series 01
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                      series 02
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                      series 03
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                      series 04
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                      series 05
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                      series 06
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 07
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 08
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 09
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                          series 10
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 11
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 12
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 13
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                              series 14
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 15
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 16
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 17
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                            series 18
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 19
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 20
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 21
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                          series 22
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 23
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 24
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 25
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                            series 26
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 27
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 28
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 29
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                series 30
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 31
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 32
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 33
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                              series 34
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 35
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 36
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 37
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                            series 38
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 39
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 40
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 41
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 42
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM    series 43
#>                                                                                                                               Treatment
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                          compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        compoundX34542
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                        compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                            compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      compoundX34542
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                      compoundX34542
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                     Control
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                          Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                          Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                          Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                          Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                        Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                        Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                        Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                        Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      Paclitaxel
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NIRAPARIB
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                 Control
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                      Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                    Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  Paclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NIRAPARIB
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel
#>                                                                                                                   Concentration1
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                              100
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                              100
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                              100
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                              100
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                              100
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           1000
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           1000
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           1000
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           1000
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           1000
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 10
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 10
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 10
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 10
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 10
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        10000
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        10000
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        10000
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        10000
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                        10000
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                100
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                100
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                100
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                100
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                100
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      0.1
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      0.1
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      0.1
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                      0.1
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            1
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            1
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            1
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            1
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         10
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         10
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         10
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         10
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      100
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      100
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      100
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                      100
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                        0.1
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                        0.1
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                        0.1
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                        0.1
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              1
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              1
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              1
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              1
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           10
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           10
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           10
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           10
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                        100
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                        100
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                        100
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                        100
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                  0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                        1
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     10
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                  100
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                    0.1
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                          1
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       10
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                    100
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM            100
#>                                                                                                                   Concentration2
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                              NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                             NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                 NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                           NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                           NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                           NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                           NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                           NA
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                 10
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                 10
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                 10
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                 10
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                 10
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       NA
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NA
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NA
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NA
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                             NA
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                           NA
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NA
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                         NA
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                               NA
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                   NA
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                         NA
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                       NA
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                     NA
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM             10
#>                                                                                                                   ConcentrationUnits1
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                uM
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            uM
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                uM
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              uM
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              uM
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        uM
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              uM
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            uM
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          uM
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#>                                                                                                                   ConcentrationUnits2
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                   NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                                    NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                                  NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                      NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                                NA
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                      uM
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                        NA
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                            NA
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  NA
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  NA
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  NA
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                  NA
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                NA
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NA
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NA
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                    NA
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                        NA
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                              NA
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                            NA
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NA
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM                  uM
#>                                                                                                                   ReplicaOrNot
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                       Replica
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                       Replica
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                       Replica
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                       Replica
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                       Replica
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                             NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           NA
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                           NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                               NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                               NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                               NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                               NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                               NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         NA
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         NA
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               NA
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               NA
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               NA
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               NA
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM               NA
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                            Replica
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                Replica
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      Replica
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      Replica
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      Replica
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                      Replica
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                    Replica
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  Replica
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                  Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                        Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                            Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                  Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                              Replica
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM           NA
#>                                                                                                                                Treatment_complete
#> A8759_2020.11.10_2001.10.05_Spleen_series 01_Control_NA_NA_NA_NA_Replica_Control                                                          Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 02_Control_NA_NA_NA_NA_Replica_Control                                                          Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 03_Control_NA_NA_NA_NA_Replica_Control                                                          Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 04_Control_NA_NA_NA_NA_Replica_Control                                                          Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 05_Control_NA_NA_NA_NA_Replica_Control                                                          Control
#> A8759_2020.11.10_2001.10.05_Spleen_series 06_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 07_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 08_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 09_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 10_compoundX34542_100_NA_uM_NA_NA_compoundX34542100uM                               compoundX34542100uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 11_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                            compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 12_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                            compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 13_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                            compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 14_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                            compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_Spleen_series 15_compoundX34542_1000_NA_uM_NA_NA_compoundX345421000uM                            compoundX345421000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 16_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 17_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 18_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 19_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 20_compoundX34542_10_NA_uM_NA_NA_compoundX3454210uM                                  compoundX3454210uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 21_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 22_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 23_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 24_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         compoundX3454210000uM
#> A8759_2020.11.10_2001.10.05_p.wash_series 25_compoundX34542_10000_NA_uM_NA_NA_compoundX3454210000uM                         compoundX3454210000uM
#> B36_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B36_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B36_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B36_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B36_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B37_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B37_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B37_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B37_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 01_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 02_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 03_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 04_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 05_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM     GentamicinePaclitaxel100uM-10uM
#> B38_2023.11.10_2023.10.05_Eye_series 06_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 07_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 08_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 09_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 10_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 11_Control_NA_NA_NA_NA_Replica_Control                                                               Control
#> B38_2023.11.10_2023.10.05_Eye_series 12_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 13_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 14_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 15_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                           Paclitaxel0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 16_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                 Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 17_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                 Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 18_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                 Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 19_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                                 Paclitaxel1uM
#> B38_2023.11.10_2023.10.05_Eye_series 20_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 21_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 22_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 23_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                              Paclitaxel10uM
#> B38_2023.11.10_2023.10.05_Eye_series 24_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 25_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 26_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 27_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                           Paclitaxel100uM
#> B38_2023.11.10_2023.10.05_Eye_series 28_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 29_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 30_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 31_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                              NIRAPARIB0.1uM
#> B38_2023.11.10_2023.10.05_Eye_series 32_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                    NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 33_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                    NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 34_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                    NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 35_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                    NIRAPARIB1uM
#> B38_2023.11.10_2023.10.05_Eye_series 36_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                 NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 37_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                 NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 38_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                 NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 39_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                                 NIRAPARIB10uM
#> B38_2023.11.10_2023.10.05_Eye_series 40_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 41_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 42_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NIRAPARIB100uM
#> B38_2023.11.10_2023.10.05_Eye_series 43_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                              NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 01_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 02_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 03_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 04_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 05_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 06_Control_NA_NA_NA_NA_Replica_Control                                                           Control
#> B39_2023.11.10_2023.10.05_Ascites_series 07_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 08_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 09_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 10_Paclitaxel_0.1_NA_uM_NA_Replica_Paclitaxel0.1uM                                       Paclitaxel0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 11_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 12_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 13_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 14_Paclitaxel_1_NA_uM_NA_Replica_Paclitaxel1uM                                             Paclitaxel1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 15_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 16_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 17_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 18_Paclitaxel_10_NA_uM_NA_Replica_Paclitaxel10uM                                          Paclitaxel10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 19_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 20_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 21_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 22_Paclitaxel_100_NA_uM_NA_Replica_Paclitaxel100uM                                       Paclitaxel100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 23_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 24_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 25_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 26_NIRAPARIB_0.1_NA_uM_NA_Replica_NIRAPARIB0.1uM                                          NIRAPARIB0.1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 27_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 28_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 29_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 30_NIRAPARIB_1_NA_uM_NA_Replica_NIRAPARIB1uM                                                NIRAPARIB1uM
#> B39_2023.11.10_2023.10.05_Ascites_series 31_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 32_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 33_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 34_NIRAPARIB_10_NA_uM_NA_Replica_NIRAPARIB10uM                                             NIRAPARIB10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 35_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 36_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 37_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 38_NIRAPARIB_100_NA_uM_NA_Replica_NIRAPARIB100uM                                          NIRAPARIB100uM
#> B39_2023.11.10_2023.10.05_Ascites_series 39_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 40_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 41_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 42_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
#> B39_2023.11.10_2023.10.05_Ascites_series 43_GentamicinePaclitaxel_100_10_uM_uM_NA_GentamicinePaclitaxel100uM-10uM GentamicinePaclitaxel100uM-10uM
# }
```
