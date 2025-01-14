#' Plot some QC plots to define that everything ran correctly
#' @description
#' Plot data to visualize immediate trends. This function expects data that has been processed
#' through make_count_dataframe() and change_data_format_to_longer() to ensure the correct
#' data structure for plotting.
#' @param .data The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer())
#'              merged data.frame that should be visualized
#' @param patient_column_name The PID's column name in the merged data.frame (defaults to "PID")
#' @param colors A list of colors to supply to personalize the plot, defaults to c("darkgreen", "red", "orange", "pink")
#' @param save_plots A Boolean value indicating if the plots should be saved or not (default is FALSE)
#' @param folder_name A string indicating the name of the folder where to save the plots if save_plots is TRUE
#' @param isolate_a_specific_patient A string indicating the patient name to isolate for single plot case (default is NULL)
#' @param x_plot_var A string indicating the treatment's full name for the QC plots (default is "Treatment_complete")
#' @import ggplot2
#' @import ggpubr
#' @importFrom dplyr filter
#' @return Invisibly returns NULL, but saves plots to disk if save_plots is TRUE
#' @examples
#' \dontrun{
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
                         colors = c("darkgreen", "red", "orange", "pink"),
                         save_plots = FALSE,
                         folder_name = NULL,
                         x_plot_var = "Treatment_complete",
                         isolate_a_specific_patient = NULL) {

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

  # Process each patient
  for (current_pid in unique(.data[[patient_column_name]])) {
    message("Processing patient: ", current_pid)

    # Filter data for current patient
    patient_data <- dplyr::filter(.data, .data[[patient_column_name]] == current_pid)

    # Create the plot
    QC_plot <- ggplot2::ggplot(patient_data,
                               ggplot2::aes(x = .data[[x_plot_var]],
                                            y = marker_positivity_ratio,
                                            color = marker_positivity)) +
      ggplot2::geom_boxplot(position = ggplot2::position_dodge(width = 1.0)) +
      ggplot2::facet_wrap(~marker_positivity) +
      ggplot2::geom_jitter(width = 0.15) +
      ggplot2::theme_light() +
      ggplot2::labs(
        title = paste0("Cell marker ratios for PID: ", current_pid),
        color = "Cell marker",
        y = "Percentage of expression marker (marker-positive-cells/total_cell_count)",
        x = "Drugs"
      ) +
      ggplot2::theme(
        axis.text.x = ggplot2::element_text(angle = 45, hjust = 1.0),
        axis.title.x = ggplot2::element_blank(),
        plot.title = ggplot2::element_text(hjust = 0.5),
        axis.ticks.x = ggplot2::element_blank(),
        panel.grid = ggplot2::element_blank(),
        strip.background = ggplot2::element_rect(
          colour = "black",
          fill = "grey1"
        )
      ) +
      ggplot2::scale_color_manual(values = colors) +
      ggplot2::stat_summary(
        fun = "median",
        geom = "point",
        size = 3,
        position = ggplot2::position_dodge(width = 1)
      ) +
      ggplot2::stat_summary(
        geom = "line",
        fun = "median",
        position = ggplot2::position_dodge(width = 1),
        linewidth = 1,
        alpha = 0.3,
        aes(group = marker_positivity)
      )

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
        height = 12,
        width = 12
      )
    }
  }

  # Final message about plot locations
  if (save_plots) {
    message("Plots have been saved in: ", folder_name)
  }

  invisible(NULL)
}
