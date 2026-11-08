#' Normalize marker values to percent of control
#' @description
#' Expresses each marker measurement as a percentage of the mean control
#' (untreated/vehicle) value within the same patient. This is the standard
#' first step for building dose response curves in drug sensitivity assays,
#' following the methodology in Labrosse et al. (2024) <doi:10.1016/j.xpro.2024.103274>.
#' @param .data A data frame in either the wide format returned by
#'   `make_count_dataframe()` or the long format returned by
#'   `change_data_format_to_longer()`.
#' @param control_treatment_name Value identifying control/vehicle wells in
#'   `treatment_column_name`. Defaults to "Control".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param group_by_columns Columns that define a comparable batch: the control mean
#'   is computed within each combination of these columns. Defaults to "PID".
#' @param value_columns Columns to normalize. If NULL, uses "marker_positivity_ratio"
#'   when present (long format), otherwise all columns matching `pattern_column_markers`
#'   (wide format).
#' @param pattern_column_markers Pattern used to auto-detect marker columns in wide
#'   format. Defaults to "_ratio_of_total_cells".
#' @return `.data` with an added column per normalized value: "<column>_pct_of_control"
#'   in wide format, or a single "pct_of_control" column in long format.
#' @export
#' @examples
#' # A patient with a control group and one drug at three doses
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugA"),
#'   cCASP3_ratio_of_total_cells = c(10, 10, 5, 20, 40)
#' )
#' normalize_to_control(df)
normalize_to_control <- function(.data,
                                 control_treatment_name = "Control",
                                 treatment_column_name = "Treatment",
                                 group_by_columns = "PID",
                                 value_columns = NULL,
                                 pattern_column_markers = "_ratio_of_total_cells") {
  if (!is.data.frame(.data) || nrow(.data) < 1) {
    stop("Input must be a non-empty data frame")
  }
  if (!treatment_column_name %in% colnames(.data)) {
    stop(paste0("Column not found: ", treatment_column_name))
  }
  if (!all(group_by_columns %in% colnames(.data))) {
    stop("All group_by_columns must be present in .data")
  }

  is_control <- .data[[treatment_column_name]] == control_treatment_name
  if (!any(is_control)) {
    stop(paste0("No rows found where ", treatment_column_name, " == '", control_treatment_name, "'"))
  }

  long_format <- "marker_positivity_ratio" %in% colnames(.data)

  if (is.null(value_columns)) {
    value_columns <- if (long_format) {
      "marker_positivity_ratio"
    } else {
      colnames(.data)[grepl(pattern_column_markers, colnames(.data))]
    }
  }
  if (length(value_columns) < 1) stop("Could not find any value columns to normalize")

  group_key <- interaction(.data[group_by_columns], drop = TRUE)
  marker_key <- if (long_format && "marker_positivity" %in% colnames(.data)) {
    interaction(group_key, .data[["marker_positivity"]], drop = TRUE)
  } else {
    group_key
  }

  for (col in value_columns) {
    control_means <- tapply(.data[[col]][is_control], marker_key[is_control], mean, na.rm = TRUE)
    out_col <- if (long_format) "pct_of_control" else paste0(col, "_pct_of_control")
    .data[[out_col]] <- as.vector(100 * .data[[col]] / control_means[as.character(marker_key)])
  }

  return(.data)
}

#' Plot dose response curves from normalized data
#' @description
#' Plots percent-of-control marker values against drug concentration, the
#' standard dose response view for drug sensitivity assays. Expects data
#' that has already been processed with `normalize_to_control()`.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", and a
#'   concentration column).
#' @param concentration_column_name Column holding the drug concentration. Defaults
#'   to "Concentration1".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param patient_column_name Column holding the patient ID. Defaults to "PID".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the dose response curve. Defaults to "Control".
#' @param log_scale_x Logical, whether to plot concentration on a log10 axis (the
#'   usual view when doses span orders of magnitude). Defaults to TRUE; rows with
#'   a non-positive concentration are dropped when TRUE.
#' @importFrom ggplot2 ggplot aes geom_point geom_smooth geom_hline facet_wrap
#'             labs scale_x_log10
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "DrugA", "DrugA", "DrugA"),
#'   Concentration1 = c(NA, "1", "10", "100"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 10, 20, 30)
#' )
#' normalized <- normalize_to_control(df)
#' plot_dose_response(normalized)
plot_dose_response <- function(.data,
                               concentration_column_name = "Concentration1",
                               treatment_column_name = "Treatment",
                               patient_column_name = "PID",
                               control_treatment_name = "Control",
                               log_scale_x = TRUE) {
  required_cols <- c("pct_of_control", "marker_positivity", concentration_column_name,
                     treatment_column_name, patient_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data[[concentration_column_name]] <- as.numeric(plot_data[[concentration_column_name]])
  plot_data <- plot_data[!is.na(plot_data[[concentration_column_name]]) &
                           is.finite(plot_data[["pct_of_control"]]), ]
  if (log_scale_x) {
    plot_data <- plot_data[plot_data[[concentration_column_name]] > 0, ]
  }

  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a numeric concentration and finite pct_of_control were found to plot")
  }

  n_patients <- length(unique(plot_data[[patient_column_name]]))

  p <- ggplot2::ggplot(plot_data, ggplot2::aes(
    x = .data[[concentration_column_name]],
    y = .data[["pct_of_control"]],
    color = .data[[patient_column_name]]
  )) +
    ggplot2::geom_hline(yintercept = 100, color = "#c3c2b7", linetype = "dashed") +
    ggplot2::geom_point(alpha = 0.6, size = 1.8) +
    ggplot2::geom_smooth(method = "loess", formula = y ~ x, se = FALSE, linewidth = 0.8) +
    drugsens_scale("color", n_patients) +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(18)) +
    ggplot2::labs(
      title = "Dose response",
      x = "Concentration",
      y = "% of control",
      color = "Patient"
    ) +
    drugsens_theme()

  if (log_scale_x) p <- p + ggplot2::scale_x_log10()

  p
}

#' Plot a treatment by concentration heatmap of percent-of-control values
#' @description
#' Summarizes `normalize_to_control()` output into a treatment x concentration
#' heatmap of the mean percent-of-control value, a compact overview of an entire
#' dose response experiment across many drugs at once.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", a
#'   concentration column, and a treatment column).
#' @param concentration_column_name Column holding the drug concentration. Defaults
#'   to "Concentration1".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the heatmap. Defaults to "Control".
#' @importFrom ggplot2 ggplot aes geom_tile facet_wrap labs scale_fill_gradientn
#' @importFrom stats aggregate
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", rep(c("DrugA", "DrugB"), each = 3)),
#'   Concentration1 = c(NA, NA, "1", "10", "100", "1", "10", "100"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 10, 8, 6, 4, 12, 14, 16)
#' )
#' normalized <- normalize_to_control(df)
#' plot_dose_response_heatmap(normalized)
plot_dose_response_heatmap <- function(.data,
                                       concentration_column_name = "Concentration1",
                                       treatment_column_name = "Treatment",
                                       control_treatment_name = "Control") {
  required_cols <- c("pct_of_control", "marker_positivity", concentration_column_name,
                     treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]

  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  summary_data <- stats::aggregate(
    plot_data[["pct_of_control"]],
    by = plot_data[c(treatment_column_name, concentration_column_name, "marker_positivity")],
    FUN = mean
  )
  colnames(summary_data)[colnames(summary_data) == "x"] <- "mean_pct_of_control"

  ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[concentration_column_name]],
    y = .data[[treatment_column_name]],
    fill = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_tile(color = "#fcfcfb", linewidth = 1) +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(18)) +
    ggplot2::scale_fill_gradientn(colors = drugsens_sequential_blue, name = "% of control") +
    ggplot2::labs(title = "Dose response overview", x = "Concentration", y = "Treatment") +
    drugsens_theme()
}

#' Plot a ranked summary of mean percent-of-control by treatment
#' @description
#' Summarizes `normalize_to_control()` output into one bar per treatment: the
#' mean percent-of-control value across all concentrations and replicates, with
#' a standard error bar, ranked from strongest to weakest effect. A quick way
#' to rank an entire drug panel by response.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity" and a
#'   treatment column).
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the summary. Defaults to "Control".
#' @importFrom ggplot2 ggplot aes geom_col geom_errorbar geom_hline facet_wrap
#'             labs coord_flip
#' @importFrom stats aggregate sd reorder
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 10, 4, 6, 14, 16)
#' )
#' normalized <- normalize_to_control(df)
#' plot_treatment_summary(normalized)
plot_treatment_summary <- function(.data,
                                   treatment_column_name = "Treatment",
                                   control_treatment_name = "Control") {
  required_cols <- c("pct_of_control", "marker_positivity", treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  standard_error <- function(x) stats::sd(x) / sqrt(length(x))
  group_cols <- plot_data[c(treatment_column_name, "marker_positivity")]

  summary_mean <- stats::aggregate(plot_data[["pct_of_control"]], by = group_cols, FUN = mean)
  colnames(summary_mean)[colnames(summary_mean) == "x"] <- "mean_pct_of_control"

  summary_se <- stats::aggregate(plot_data[["pct_of_control"]], by = group_cols, FUN = standard_error)
  colnames(summary_se)[colnames(summary_se) == "x"] <- "se_pct_of_control"

  summary_data <- merge(summary_mean, summary_se, by = c(treatment_column_name, "marker_positivity"))
  summary_data[["se_pct_of_control"]][is.na(summary_data[["se_pct_of_control"]])] <- 0
  summary_data[[treatment_column_name]] <- stats::reorder(
    summary_data[[treatment_column_name]], summary_data[["mean_pct_of_control"]]
  )

  ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[treatment_column_name]],
    y = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_hline(yintercept = 100, color = "#c3c2b7", linetype = "dashed") +
    ggplot2::geom_col(fill = unname(drugsens_palette["blue"])) +
    ggplot2::geom_errorbar(
      ggplot2::aes(
        ymin = .data[["mean_pct_of_control"]] - .data[["se_pct_of_control"]],
        ymax = .data[["mean_pct_of_control"]] + .data[["se_pct_of_control"]]
      ),
      width = 0.2, color = "#52514e"
    ) +
    ggplot2::coord_flip() +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(18)) +
    ggplot2::labs(title = "Treatment summary", x = NULL, y = "Mean % of control") +
    drugsens_theme()
}

#' Plot a patient by treatment heatmap of percent-of-control values
#' @description
#' Summarizes `normalize_to_control()` output into a patient x treatment heatmap
#' of the mean percent-of-control value (averaged across concentrations), a
#' cohort-level view of how every patient responded to every drug in the panel.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", a patient
#'   column and a treatment column).
#' @param patient_column_name Column holding the patient ID. Defaults to "PID".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the heatmap. Defaults to "Control".
#' @importFrom ggplot2 ggplot aes geom_tile facet_wrap labs scale_fill_gradientn theme
#'             element_text
#' @importFrom stats aggregate
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = rep(c("PID1", "PID2"), each = 4),
#'   Treatment = rep(c("Control", "DrugA"), 4),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 5, 10, 8, 12, 4, 12, 6)
#' )
#' normalized <- normalize_to_control(df)
#' plot_patient_heatmap(normalized)
plot_patient_heatmap <- function(.data,
                                 patient_column_name = "PID",
                                 treatment_column_name = "Treatment",
                                 control_treatment_name = "Control") {
  required_cols <- c("pct_of_control", "marker_positivity", patient_column_name, treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  summary_data <- stats::aggregate(
    plot_data[["pct_of_control"]],
    by = plot_data[c(patient_column_name, treatment_column_name, "marker_positivity")],
    FUN = mean
  )
  colnames(summary_data)[colnames(summary_data) == "x"] <- "mean_pct_of_control"

  ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[treatment_column_name]],
    y = .data[[patient_column_name]],
    fill = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_tile(color = "#fcfcfb", linewidth = 1) +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(18)) +
    ggplot2::scale_fill_gradientn(colors = drugsens_sequential_blue, name = "% of control") +
    ggplot2::scale_x_discrete(labels = function(x) drugsens_wrap_text(x, 9)) +
    ggplot2::labs(title = "Patient response overview", x = "Treatment", y = "Patient") +
    drugsens_theme() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.5, size = ggplot2::rel(0.72)))
}

#' Plot the raw values next to the normalized values, before and after
#' @description
#' Shows the raw marker ratio (before) side by side with the percent-of-control
#' value (after `normalize_to_control()`), one pair of panels per marker, so you
#' can see at a glance what control normalization did to the data.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "marker_positivity_ratio", "pct_of_control",
#'   "marker_positivity" and a treatment column).
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @importFrom ggplot2 ggplot aes geom_boxplot geom_jitter facet_wrap labs
#'             element_text element_blank
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 12, 4, 6, 18, 20)
#' )
#' normalized <- normalize_to_control(df)
#' plot_normalization_before_after(normalized)
plot_normalization_before_after <- function(.data, treatment_column_name = "Treatment") {
  required_cols <- c("marker_positivity_ratio", "pct_of_control", "marker_positivity",
                     treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  before <- data.frame(
    treatment = .data[[treatment_column_name]],
    marker_positivity = .data[["marker_positivity"]],
    value = .data[["marker_positivity_ratio"]],
    stage = "Before (raw ratio)",
    stringsAsFactors = FALSE
  )
  after <- data.frame(
    treatment = .data[[treatment_column_name]],
    marker_positivity = .data[["marker_positivity"]],
    value = .data[["pct_of_control"]],
    stage = "After (% of control)",
    stringsAsFactors = FALSE
  )
  plot_data <- rbind(before, after)
  plot_data <- plot_data[is.finite(plot_data[["value"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No rows with a finite value were found to plot")
  }

  plot_data[["facet_label"]] <- factor(
    paste(plot_data[["marker_positivity"]], plot_data[["stage"]], sep = " \u2014 "),
    levels = as.vector(t(outer(
      sort(unique(plot_data[["marker_positivity"]])),
      c("Before (raw ratio)", "After (% of control)"),
      paste, sep = " \u2014 "
    )))
  )

  n_treatments <- length(unique(plot_data[["treatment"]]))

  ggplot2::ggplot(plot_data, ggplot2::aes(
    x = .data[["treatment"]],
    y = .data[["value"]],
    fill = .data[["treatment"]]
  )) +
    ggplot2::geom_boxplot(outlier.shape = NA, alpha = 0.85) +
    ggplot2::geom_jitter(width = 0.15, alpha = 0.4, size = 1) +
    ggplot2::facet_wrap(~facet_label, ncol = 2, scales = "free_y", labeller = drugsens_wrap_labeller(26)) +
    drugsens_scale("fill", n_treatments) +
    ggplot2::scale_x_discrete(labels = function(x) drugsens_wrap_text(x, 9)) +
    ggplot2::labs(title = "Effect of control normalization", x = NULL, y = NULL) +
    drugsens_theme() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(hjust = 0.5, size = ggplot2::rel(0.72)),
      legend.position = "none"
    )
}
