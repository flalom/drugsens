# Changelog

## drugsens 0.2.0

### New features

- [`normalize_to_control()`](https://flalom.github.io/drugsens/reference/normalize_to_control.md):
  expresses marker values as a percentage of the control/vehicle group
  per patient, with multi-marker apoptosis/viability scoring
  (`dead_markers`, `viable_markers`, `total_markers`, `response_metric`,
  `consensus_only`).
- [`plot_dose_response()`](https://flalom.github.io/drugsens/reference/plot_dose_response.md):
  plots percent-of-control values against drug concentration using LOESS
  (`method = "loess"`), 4-parameter log-logistic Hill curves
  (`method = "4pl"` with `show_ic50` option, `attr(plot, "ic50")`
  parameter table, and multi-marker consensus IC50
  `attr(plot, "consensus_ic50")`), or linear trends
  (`method = "linear"`), with optional per-point marker dispersion/CV
  (`consensus_dispersion`, `show_cv`, `attr(plot, "consensus_cv")`).
- [`plot_dose_response_heatmap()`](https://flalom.github.io/drugsens/reference/plot_dose_response_heatmap.md):
  treatment x concentration overview heatmap of percent-of-control with
  numerical concentration ordering and optional tile value labels
  (`show_values`).
- [`plot_treatment_summary()`](https://flalom.github.io/drugsens/reference/plot_treatment_summary.md):
  ranked bar chart of mean percent-of-control per treatment with
  standard error bars and optional statistical comparisons against
  Control (`compare_to_control`).
- [`plot_patient_heatmap()`](https://flalom.github.io/drugsens/reference/plot_patient_heatmap.md):
  patient x treatment overview heatmap of percent-of-control with
  optional tile value labels (`show_values`) and statistical comparisons
  against Control (`compare_to_control`).
- [`plot_normalization_before_after()`](https://flalom.github.io/drugsens/reference/plot_normalization_before_after.md):
  side-by-side raw-ratio vs. percent-of-control panels per marker.
- [`drugsens_theme()`](https://flalom.github.io/drugsens/reference/drugsens_theme.md)
  and `drugsens_palette`: exported publication-ready `ggplot2` theme and
  8-color CVD-safe categorical palette used across all package figures.
- Optional statistical comparisons against control
  (`compare_to_control`, `stat_method`, `p_adjust_method` defaulting to
  `"BH"`, `pvalue_label`) in
  [`get_QC_plots()`](https://flalom.github.io/drugsens/reference/get_QC_plots.md),
  [`plot_treatment_summary()`](https://flalom.github.io/drugsens/reference/plot_treatment_summary.md),
  and
  [`plot_patient_heatmap()`](https://flalom.github.io/drugsens/reference/plot_patient_heatmap.md).
- Four comprehensive vignettes (`drugsens`, `qupath-and-metadata`,
  `quality-control-workflow`, `cohort-and-dose-response`) and a
  `pkgdown` documentation website.
- Expanded `testthat` unit test suite covering counting, reshaping,
  control normalization, 4PL dose-response fitting, statistical
  comparisons, and plotting functions.

### Improvements and fixes

- [`get_QC_plots()`](https://flalom.github.io/drugsens/reference/get_QC_plots.md)
  now returns a `ggplot` object (single patient) or named list of
  `ggplot` objects (multiple patients) for interactive and vignette use.
- Improved label wrapping across all plots so biological acronyms
  (`cCASP3`, `EpCAM`) and concentration units (`uM`, `nM`) remain
  intact.
- [`make_run_config()`](https://flalom.github.io/drugsens/reference/make_run_config.md)
  now immediately loads `list_of_relabeling` after creating
  `config_drugsens.txt` on first run.

## drugsens 0.1.0

CRAN release: 2025-01-16

- Initial CRAN release of `drugsens`, providing functionalities for
  QuPath drug sensitivity analysis in translational research.
- Support for `.csv` file binding and metadata extraction
  ([`data_binding()`](https://flalom.github.io/drugsens/reference/data_binding.md),
  [`string_parsing()`](https://flalom.github.io/drugsens/reference/string_parsing.md),
  [`make_count_dataframe()`](https://flalom.github.io/drugsens/reference/make_count_dataframe.md),
  [`change_data_format_to_longer()`](https://flalom.github.io/drugsens/reference/change_data_format_to_longer.md),
  [`get_QC_plots()`](https://flalom.github.io/drugsens/reference/get_QC_plots.md),
  [`get_QC_plots_parsed_merged_data()`](https://flalom.github.io/drugsens/reference/get_QC_plots_parsed_merged_data.md)).
