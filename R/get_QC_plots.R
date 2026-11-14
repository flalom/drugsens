# Internal helper to order discrete treatment/dose labels logically:
# control first, then grouped by drug prefix and ascending numerical concentration.
drugsens_order_dose_levels <- function(values, control_name = "Control") {
  x_vals <- unique(as.character(values[!is.na(values)]))
  has_dose <- grepl("[0-9]+(?:\\.[0-9]+)?\\s*[munp]?[Mm]", x_vals)
  drug_pref <- ifelse(
    has_dose,
    sub("([0-9]+(?:\\.[0-9]+)?\\s*[munp]?[Mm].*)$", "", x_vals),
    x_vals
  )
  dose_num <- ifelse(
    has_dose,
    suppressWarnings(as.numeric(sub("^.*?([0-9]+(?:\\.[0-9]+)?)\\s*[munp]?[Mm].*$", "\\1", x_vals))),
    Inf
  )
  ord <- order(x_vals != control_name, drug_pref, dose_num, x_vals)
  x_vals[ord]
}

#' Plot some QC plots to define that everything ran correctly
#' @description
#' Plot data to visualize immediate trends. This function expects data that has been processed
#' through make_count_dataframe() and change_data_format_to_longer() to ensure the correct
#' data structure for plotting.
#' @param .data The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer())
#'              merged data.frame that should be visualized
#' @param patient_column_name The PID's column name in the merged data.frame (defaults to "PID")
#' @param colors A character vector of colors to supply to personalize the plot, defaults to
#'   `unname(drugsens_palette)` (8-color CVD-safe palette).
#' @param save_plots A Boolean value indicating if the plots should be saved or not (default is FALSE)
#' @param folder_name Directory where plots are saved when `save_plots = TRUE`.
#'   Defaults to `file.path(tempdir(), "figures")` when `NULL`.
#' @param isolate_a_specific_patient A string indicating the patient name to isolate for single plot case (default is NULL)
#' @param x_plot_var A string indicating the treatment's full name for the QC plots (default is "Treatment_complete")
#' @param compare_to_control Logical, whether to compute and display statistical comparisons
#'   against `control_treatment_name` within each marker facet. Defaults to FALSE.
#' @param control_treatment_name Value in `x_plot_var` identifying the control/vehicle group
#'   when `compare_to_control = TRUE`. Defaults to `"Control"`.
#' @param stat_method Statistical test used when `compare_to_control = TRUE`: `"wilcox"` (default)
#'   or `"t.test"`.
#' @param p_adjust_method Multiple-testing correction method passed to `stats::p.adjust()`
#'   across treatments within each marker facet. Supports `"BH"` (Benjamini-Hochberg FDR, default),
#'   `"bonferroni"`, `"holm"`, `"fdr"`, `"hochberg"`, `"hommel"`, `"BY"`, or `"none"`.
#' @param pvalue_label Format for p-value annotations: `"p.adj.signif"` (adjusted `*`, `**`,
#'   `***`, `ns`, default), `"p.signif"` (unadjusted), `"p.adj.format"`, or `"p.format"`.
#' @import ggplot2
#' @importFrom dplyr filter
#' @return When `save_plots = FALSE`, returns a `ggplot` object (if a single patient is plotted)
#'   or a named list of `ggplot` objects (keyed by patient ID). When `save_plots = TRUE`,
#'   invisibly returns the named list of `ggplot` objects after saving PDFs to disk.
#' @examples
#' \donttest{
#' # First process example data
#' example_path <- system.file("extdata/to_merge/", package = "drugsens")
#' raw_data <- data_binding(path_to_the_projects_folder = example_path)
#' count_data <- make_count_dataframe(raw_data)
#' processed_data <- change_data_format_to_longer(count_data)
#'
#' # Create and save plots to temporary directory
#' temp_dir <- file.path(tempdir(), "qc_plots")
#' get_QC_plots(
#'   processed_data,
#'   save_plots = TRUE,
#'   folder_name = temp_dir
#' )
#'
#' # Create plots for a specific patient
#' get_QC_plots(
#'   processed_data,
#'   isolate_a_specific_patient = "B39",
#'   save_plots = TRUE,
#'   folder_name = temp_dir
#' )
#' }
#' @export
get_QC_plots <- function(.data,
                         patient_column_name = "PID",
                         colors = unname(drugsens_palette),
                         save_plots = FALSE,
                         folder_name = NULL,
                         x_plot_var = "Treatment_complete",
                         isolate_a_specific_patient = NULL,
                         compare_to_control = FALSE,
                         control_treatment_name = "Control",
                         stat_method = c("wilcox", "t.test"),
                         p_adjust_method = "BH",
                         pvalue_label = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")) {

  stat_method <- match.arg(stat_method)
  p_adjust_method <- match.arg(p_adjust_method, stats::p.adjust.methods)
  pvalue_label <- match.arg(pvalue_label)

  # Input validation
  if (!is.data.frame(.data)) {
    stop("Input must be a data frame")
  }

  # Check required columns exist
  required_cols <- c(patient_column_name, x_plot_var, "marker_positivity", "marker_positivity_ratio")
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please ensure data has been processed with make_count_dataframe() and change_data_format_to_longer()")
  }

  # Filter for specific patient if requested
  if (!is.null(isolate_a_specific_patient)) {
    .data <- .data[.data[[patient_column_name]] == isolate_a_specific_patient, ]
    if (nrow(.data) < 1) {
      stop("No data found for patient: ", isolate_a_specific_patient)
    }
  }

  # Set up output directory if saving plots
  if (save_plots) {
    if (is.null(folder_name)) {
      folder_name <- file.path(tempdir(), "figures")
    }
    dir.create(folder_name, showWarnings = FALSE, recursive = TRUE)
  }

  plot_list <- list()

  # Process each patient
  for (current_pid in unique(.data[[patient_column_name]])) {
    message("Processing patient: ", current_pid)

    # Filter data for current patient
    patient_data <- dplyr::filter(.data, .data[[patient_column_name]] == current_pid)

    if (!is.factor(patient_data[[x_plot_var]])) {
      patient_data[[x_plot_var]] <- factor(
        patient_data[[x_plot_var]],
        levels = drugsens_order_dose_levels(patient_data[[x_plot_var]], control_name = control_treatment_name)
      )
    }
    n_x <- length(unique(patient_data[[x_plot_var]]))
    wrap_w_x <- if (n_x >= 5) 22 else 14

    # Create a layered violin + narrow boxplot + filled jitter plot
    QC_plot <- ggplot2::ggplot(
      patient_data,
      ggplot2::aes(
        x = .data[[x_plot_var]],
        y = marker_positivity_ratio,
        color = marker_positivity,
        fill = marker_positivity
      )
    ) +
      ggplot2::geom_violin(
        trim = TRUE,
        alpha = 0.22,
        color = NA,
        width = 0.36
      ) +
      ggplot2::geom_boxplot(
        width = 0.14,
        alpha = 0.45,
        outlier.shape = NA,
        linewidth = 0.65
      ) +
      ggplot2::geom_jitter(
        width = 0.05,
        height = 0,
        alpha = 0.85,
        size = 2.4,
        shape = 21,
        color = "#fcfcfb",
        stroke = 0.4
      ) +
      ggplot2::facet_wrap(
        ~marker_positivity,
        scales = "free_y",
        labeller = drugsens_wrap_labeller(22, strip_ratio_suffix = TRUE)
      ) +
      drugsens_theme() +
      ggplot2::labs(
        title = paste0("Cell marker positivity \u2014 Patient ", current_pid),
        subtitle = "Distribution across imaged fields of view (violin density, IQR boxplot, and individual series)",
        y = "Marker-positive cells (% of total cells)",
        x = NULL
      ) +
      ggplot2::scale_y_continuous(
        labels = function(x) paste0(round(x * 100, 1), "%"),
        expand = ggplot2::expansion(mult = c(0.08, 0.16))
      ) +
      ggplot2::scale_color_manual(values = colors) +
      ggplot2::scale_fill_manual(values = colors) +
      ggplot2::scale_x_discrete(
        labels = function(x) drugsens_wrap_text(x, wrap_w_x),
        expand = ggplot2::expansion(add = 0.55)
      ) +
      ggplot2::theme(
        legend.position = "none",
        axis.text.x = ggplot2::element_text(
          angle = if (n_x >= 5) 40 else 0,
          hjust = if (n_x >= 5) 1 else 0.5,
          vjust = if (n_x >= 5) 1 else 0.5,
          size = ggplot2::rel(if (n_x >= 5) 0.78 else 0.88),
          face = "bold",
          lineheight = 0.85
        ),
        axis.ticks.x = ggplot2::element_blank(),
        panel.grid.major.x = ggplot2::element_blank(),
        panel.spacing = ggplot2::unit(1.1, "lines")
      )

    if (compare_to_control) {
      pval_df <- drugsens_compare_to_control(
        data = patient_data,
        group_col = x_plot_var,
        value_col = "marker_positivity_ratio",
        facet_col = "marker_positivity",
        control_name = control_treatment_name,
        method = stat_method,
        p_adjust_method = p_adjust_method,
        label_type = pvalue_label
      )
      attr(QC_plot, "stats") <- pval_df
      if (!is.null(pval_df) && nrow(pval_df) > 0) {
        QC_plot <- QC_plot +
          ggplot2::geom_text(
            data = pval_df,
            ggplot2::aes(x = .data[[x_plot_var]], y = .data[["y_pos"]], label = .data[["label"]]),
            inherit.aes = FALSE,
            color = "#0b0b0b",
            fontface = "bold",
            size = 3.8
          )
      }
    }

    plot_list[[as.character(current_pid)]] <- QC_plot

    # Save the plot if requested
    if (save_plots) {
      plot_filename <- file.path(
        folder_name,
        paste0("patients_QC_box_plots_",
               current_pid,
               "_median",
               format(Sys.Date(), "%Y-%m-%d"),
               ".pdf"
        )
      )

      ggplot2::ggsave(
        filename = plot_filename,
        plot = QC_plot,
        device = "pdf",
        height = 9,
        width = 11
      )
    }
  }

  # Final message about plot locations
  if (save_plots) {
    message("Plots have been saved in: ", folder_name)
    return(invisible(plot_list))
  }

  if (length(plot_list) == 1) {
    return(plot_list[[1]])
  }
  plot_list
}
