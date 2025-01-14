#' Plot QC plots and calculate statistics for bound data
#' @description
#' This function creates quality control plots and calculates basic statistics for microscopy data.
#' The plots provide visual insights into marker expression patterns and data quality.
#' @param .data The preprocessed data frame to analyze
#' @param list_of_columns_to_plot Columns to include in plots. If NULL, all numeric columns are used.
#' @param save_plots Logical, whether to save plots to files. Defaults to FALSE.
#' @param saving_plots_folder Directory for saving plots. If NULL and save_plots=TRUE, uses a subdirectory of tempdir().
#' @param save_plots_in_patient_specific_subfolders Logical, whether to create patient subdirectories. Defaults to TRUE.
#' @param fill_color_variable Variable name for plot color filling
#' @param PID_column_name Column name for patient IDs. Defaults to "PID".
#' @param isolate_specific_drug Drug name to subset data
#' @param isolate_specific_patient Patient ID to subset data
#' @param drug_column_name Column name for drug information. Defaults to "Treatment".
#' @param save_list_of_plots Logical, whether to return list of plot objects. Defaults to TRUE.
#' @param p_height Plot height in inches. Defaults to 10.
#' @param p_width Plot width in inches. Defaults to 10.
#' @param verbose Logical, whether to show progress messages. Defaults to TRUE.
#' @return If save_list_of_plots=TRUE, returns a named list of ggplot objects. Otherwise returns invisible(NULL).
#' @importFrom ggplot2 ggplot aes geom_violin geom_boxplot facet_wrap theme element_text labs
#'             geom_jitter position_jitter stat_summary aes_string
#' @examples
#' \dontrun{
#' # First load and process example data
#' example_path <- system.file("extdata/to_merge/", package = "drugsens")
#' raw_data <- data_binding(path_to_the_projects_folder = example_path)
#' count_data <- make_count_dataframe(raw_data)
#' processed_data <- change_data_format_to_longer(count_data)
#'
#' # Basic usage - create plots for all patients
#' plots <- get_QC_plots_parsed_merged_data(processed_data)
#'
#' # Save plots to a temporary directory
#' temp_dir <- file.path(tempdir(), "qc_plots")
#' plots <- get_QC_plots_parsed_merged_data(
#'   processed_data,
#'   save_plots = TRUE,
#'   saving_plots_folder = temp_dir
#' )
#'
#' # Focus on a specific patient
#' plots <- get_QC_plots_parsed_merged_data(
#'   processed_data,
#'   isolate_specific_patient = "B39"
#' )
#'
#' # Color plots by tissue type
#' plots <- get_QC_plots_parsed_merged_data(
#'   processed_data,
#'   fill_color_variable = "Tissue"
#' )
#' }
#' @export
get_QC_plots_parsed_merged_data <- function(.data,
                                            list_of_columns_to_plot = NULL,
                                            save_plots = FALSE,
                                            saving_plots_folder = NULL,
                                            save_plots_in_patient_specific_subfolders = TRUE,
                                            fill_color_variable = NULL,
                                            PID_column_name = "PID",
                                            isolate_specific_drug = NULL,
                                            isolate_specific_patient = NULL,
                                            drug_column_name = "Treatment",
                                            save_list_of_plots = TRUE,
                                            p_height = 10,
                                            p_width = 10,
                                            verbose = TRUE) {

  # Define the helper function for creating individual QC plots
  create_qc_plot <- function(data, metric, fill_var, pid, drug) {
    p <- ggplot2::ggplot(data, ggplot2::aes(x = marker_positivity, y = unlist(data[[metric]])))

    if (!is.null(fill_var)) {
      p <- p + ggplot2::geom_violin(trim = FALSE,
                                    ggplot2::aes_string(fill = fill_var),
                                    color = NA)
    } else {
      p <- p + ggplot2::geom_violin(trim = FALSE,
                                    fill = "#A4A4A4",
                                    color = "darkred")
    }

    p <- p +
      theme_minimal() +
      ggplot2::geom_boxplot(width = 0.1, fill = "white") +
      ggplot2::facet_wrap(~Treatment) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
      ggplot2::labs(
        title = metric,
        x = "Cell Markers",
        y = paste0("Intensity of ", metric, " (log2)"),
        subtitle = paste0(pid, ".", drug)
      ) +
      ggplot2::geom_jitter(shape = 16,
                           position = ggplot2::position_jitter(0.01)) +
      ggplot2::stat_summary(geom = "crossbar",
                            fun = mean,
                            colour = "red",
                            width = 0.21)

    return(p)
  }

  # Input validation
  if (!is.data.frame(.data) || nrow(.data) < 1) {
    stop("Input must be a non-empty data frame")
  }

  # Initialize plot storage
  list_plottos <- list()

  # If user requested to isolate specific patient, filter the data
  if (!is.null(isolate_specific_patient)) {
    .data <- .data[.data[[PID_column_name]] == isolate_specific_patient, ]
    if (nrow(.data) < 1) {
      stop("No data found for specified patient: ", isolate_specific_patient)
    }
  }

  # Set up output directory if saving plots
  if (save_plots) {
    # Initialize the base directory for plots
    saving_plots_folder <- if (is.null(saving_plots_folder)) {
      file.path(tempdir(), "drugsens_plots")
    } else {
      saving_plots_folder
    }
    dir.create(saving_plots_folder, showWarnings = FALSE, recursive = TRUE)
  }

  # Determine columns to plot
  if (is.null(list_of_columns_to_plot)) {
    list_of_columns_to_plot <- colnames(.data)[sapply(.data, is.numeric)]
  }

  # Process each patient
  for (pid in unique(.data[[PID_column_name]])) {
    if (verbose) {
      message("Processing patient: ", pid)
    }

    # Subset data for current patient
    subset_data <- .data[.data[[PID_column_name]] == pid, ]

    # Apply drug filter if specified
    if (!is.null(isolate_specific_drug)) {
      subset_data <- subset_data[subset_data[[drug_column_name]] %in% isolate_specific_drug, ]
    }

    # Skip if no data after filtering
    if (nrow(subset_data) < 1) {
      if (verbose) {
        message("No data found for PID: ", pid)
      }
      next
    }

    # Create patient directory if needed
    if (save_plots && save_plots_in_patient_specific_subfolders) {
      patient_dir <- file.path(saving_plots_folder, pid)
      dir.create(patient_dir, showWarnings = FALSE, recursive = TRUE)
    }

    # Process each metric
    for (i in list_of_columns_to_plot) {
      # Create plot
      p <- create_qc_plot(subset_data, i, fill_color_variable,
                          pid, isolate_specific_drug)

      # Save plot if requested
      if (save_plots) {
        plot_file <- sprintf("%s_%s_%s_%s.pdf",
                             format(Sys.Date(), "%Y%m%d"),
                             pid,
                             ifelse(is.null(isolate_specific_drug), "all", isolate_specific_drug),
                             make.names(i))

        # Determine save directory
        save_dir <- if (save_plots_in_patient_specific_subfolders) {
          file.path(saving_plots_folder, pid)
        } else {
          saving_plots_folder
        }

        plot_path <- file.path(save_dir, plot_file)

        ggplot2::ggsave(plot_path,
                        plot = p,
                        width = p_width,
                        height = p_height,
                        dpi = 600)

        if (verbose) {
          message("Saved plot to: ", plot_path)
        }
      }

      # Store plot if requested
      if (save_list_of_plots) {
        plot_name <- paste(pid, i, sep = ".")
        if (!is.null(isolate_specific_drug)) {
          plot_name <- paste(isolate_specific_drug, plot_name, sep = ".")
        }
        list_plottos[[plot_name]] <- p
      }
    }
  }

  # Return results
  if (save_list_of_plots) {
    return(list_plottos)
  } else {
    invisible(NULL)
  }
}
