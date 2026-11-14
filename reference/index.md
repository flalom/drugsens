# Package index

## QuPath Setup & Data Import

Generate QuPath export scripts, configure marker relabeling, and bind
CSV exports with automatic filename metadata parsing.

- [`generate_qupath_script()`](https://flalom.github.io/drugsens/reference/generate_qupath_script.md)
  : Generate the groovy script used for the analysis
- [`make_run_config()`](https://flalom.github.io/drugsens/reference/make_run_config.md)
  : Generates and loads a marker-relabeling configuration file
- [`data_binding()`](https://flalom.github.io/drugsens/reference/data_binding.md)
  : Merge all the dataframes coming out from the QuPath
- [`string_parsing()`](https://flalom.github.io/drugsens/reference/string_parsing.md)
  : Parse image filenames to extract metadata

## Cell Counting & Reshaping

Aggregate per-image marker counts, compute marker positivity ratios, and
reshape wide count tables to tidy long format.

- [`make_count_dataframe()`](https://flalom.github.io/drugsens/reference/make_count_dataframe.md)
  : Count the main marker expression
- [`change_data_format_to_longer()`](https://flalom.github.io/drugsens/reference/change_data_format_to_longer.md)
  : Data format changer

## Quality Control (QC) Visualization

Inspect raw marker ratios and feature distributions per patient,
treatment, or tissue.

- [`get_QC_plots()`](https://flalom.github.io/drugsens/reference/get_QC_plots.md)
  : Plot some QC plots to define that everything ran correctly
- [`get_QC_plots_parsed_merged_data()`](https://flalom.github.io/drugsens/reference/get_QC_plots_parsed_merged_data.md)
  : Plot QC plots and calculate statistics for bound data

## Control Normalization & Dose-Response Analysis

Normalize treated wells to matched vehicle controls, fit LOESS or 4PL
Hill dose-response curves, and visualize drug panels across cohorts.

- [`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md)
  : Normalize marker values to percent of control
- [`plot_normalization_before_after()`](https://flalom.github.io/drugsens/reference/plot_normalization_before_after.md)
  : Plot the raw values next to the normalized values, before and after
- [`plot_dose_response()`](https://flalom.github.io/drugsens/reference/plot_dose_response.md)
  : Plot dose response curves from normalized data
- [`plot_dose_response_heatmap()`](https://flalom.github.io/drugsens/reference/plot_dose_response_heatmap.md)
  : Plot a treatment by concentration heatmap of percent-of-control
  values
- [`plot_treatment_summary()`](https://flalom.github.io/drugsens/reference/plot_treatment_summary.md)
  : Plot a ranked summary of mean percent-of-control by treatment
- [`plot_patient_heatmap()`](https://flalom.github.io/drugsens/reference/plot_patient_heatmap.md)
  : Plot a patient by treatment heatmap of percent-of-control values

## Theme & Color Palette

Shared ggplot2 theme and colorblind-safe categorical palette for custom
figures.

- [`drugsens_theme()`](https://flalom.github.io/drugsens/reference/drugsens_theme.md)
  : Publication-ready ggplot2 theme for drugsens
- [`drugsens_palette`](https://flalom.github.io/drugsens/reference/drugsens_palette.md)
  : Colorblind-safe categorical palette for drugsens plots
