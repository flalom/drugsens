#' Plot some QC plots to define that everything ran correctly
#' @description
#' Plot data to visualize immediate trends
#' @param .data The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer()) merged data.frame that should be visualized
#' @param patient_column_name The PID's column name in the merged data.frame (defaults to "PID")
#' @param colors  A list of colors to supply to personalize the plot, as default 4 colors c("dark green", "red", "orange", "pink")
#' @param save_plots  A Boolean value indicating if the plots should be saved or not, TRUE for saving in the current working directory, FALSE to not. Default is FALSE
#' @param folder_name A string indicating the name of the folder where to save the plots in case that save_plots = TRUE
#' @param isolate_a_specific_patient A string indicating the patient name to isolate for single plot case (default is NULL)
#' @param x_plot_var A string indicating the treatment's full name for the QC plots (default is "Treatment_complete")
#' @import ggplot2
#' @import ggpubr
#' @importFrom dplyr filter
#' @return A `dataframe`/`tibble`.
#' @examples
#' \dontrun{
#'   get_QC_plots(longer_format_dataframe, patient_column_name = "PID",
#'                save_plots = TRUE, folder_name = "figures")
#' }
#' @export
get_QC_plots <- function(.data,
                         patient_column_name = "PID",
                         colors = c("darkgreen", "red", "orange", "pink"),
                         save_plots = FALSE,
                         folder_name = "figures",
                         x_plot_var = "Treatment_complete",
                         isolate_a_specific_patient = NULL) {

  if (!is.null(isolate_a_specific_patient)) .data <- .data[.data[[patient_column_name]] == isolate_a_specific_patient, ]
  if (nrow(.data) < 1) stop("The data cannot be empty")

  # run for every unique PID the QC plot
  for (i in unique(.data[patient_column_name])) {
    message(paste0("Running the QC plot function for PID: ", i))

    QC_plot <- .data |>
      dplyr::filter(.data[[patient_column_name]] == i) |>
      ggplot(aes(x = .data[[x_plot_var]],
                 y = .data$marker_positivity_ratio,
                 col = .data$marker_positivity)) +
      geom_boxplot(
        position = position_dodge(width = 1.0),
      ) +
      facet_wrap(~marker_positivity) +
      geom_jitter(width = 0.15) +
      theme_light() +
      labs(title = paste0("Cell marker ratios for PID: ", i), color = "Cell marker") +
      ylab("Percentage of expression marker (marker-positive-cells/total_cell_count)") +
      xlab("Drugs") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1.0)) +
      scale_color_manual(values = colors) +
      stat_summary(
        fun = "median", geom = "pointrange",
        mapping = aes(xend = after_stat(x) - 0.25, yend = after_stat(y)),
        size = 1.5, alpha = 1.0,
        position = position_dodge(width = 1)
      ) +
      stat_summary(
        geom = "line", fun = "median", position = position_dodge(width = 1),
        size = 1, alpha = 0.3, aes(group = marker_positivity)
      ) +
      theme(
        axis.title.x = element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        strip.background = element_rect(
          colour = "black",
          fill = "grey1"
        )
      )

    if (save_plots) {
      if (!dir.exists(paths = paste0(getwd(), "/", folder_name, "/"))) dir.create(path = paste0(getwd(), "/", folder_name, "/"), showWarnings = F, recursive = T)

      ggsave(QC_plot,
        filename = paste0(folder_name, "/", "patients_QC_box_plots_", i, "_", "median", Sys.Date(), ".pdf"),
        device = "pdf",
        height = 12,
        width = 12
      )
    }
  }
  message(paste0("If save_plots = TRUE, the plots will be saved here:", paste0(folder_name, "/", "patients_QC_box_plots_", "median", Sys.Date(), ".pdf")))
}
