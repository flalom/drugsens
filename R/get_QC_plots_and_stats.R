#' Plot some QC plots for the bound data
#' @description
#' This plot can show trends within the dataset and run some basic statistics.
#'
#' @param .data The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer()) merged data.frame that should be visualized
#' @param list_of_columns_to_plot The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer()) merged data.frame that should be visualized
#' @param save_plots Boolean, TRUE if plots should be saved (default is FALSE)
#' @param saving_plots_folder String indicating the folder where the plots should be stored (default is "figures")
#' @param PID_column_name String, indicating the name of the sample to subset (default is "PID")
#' @param isolate_specific_drug String, indicating if there should be a Treatment specific data subset (default is NULL)
#' @param isolate_specific_patient String, indicating a spacific sample to plot only (default is NULL)
#' @param PID_column_name String, indicating the name of the sample to subset (default is "Treatment")
#' @param save_list_of_plots Boolean, if TRUE returns a named list of all the plots ran (default is TRUE), this can be usefult to isolate specific plots
#' @param save_plots_in_patient_specific_subfolders Boolean, if TRUE the plots will be saved (if `save_plots` TRUE) in sample specific folders (default is TRUE)
#' @param fill_color_variable Boolean, String, indicating the name of the variable (discrete) to use for the plot's filling
#' @param p_height Integer, indicate the plot's height (default is 10 inches)
#' @param p_width Integer, indicate the plot's width (default is 10 inches)
#' @param drug_column_name String, indicate the column indicating the Drug/Treament (default is "Treatment")
#'
#' @import ggplot2
#' @import ggpubr
#' @importFrom readr write_excel_csv
#' @importFrom dplyr filter
#' @return A `list`/`NULL`.
#' @example
#' \dontrun {qc <- get_QC_plots_parsed_merged_data(bind_data, save_plots = TRUE, save_list_of_plots = TRUE)}
#' @export

get_QC_plots_parsed_merged_data <- function(.data,
                                            list_of_columns_to_plot = NULL,
                                            save_plots = FALSE,
                                            saving_plots_folder = "figures",
                                            save_plots_in_patient_specific_subfolders = TRUE,
                                            fill_color_variable = NULL,
                                            PID_column_name = "PID",
                                            isolate_specific_drug = NULL,
                                            isolate_specific_patient = NULL,
                                            drug_column_name = "Treatment",
                                            save_list_of_plots = TRUE,
                                            p_height = 10,
                                            p_width = 10) {
  # List where plots could be stored
  list_plottos <- list()

  if (!is.data.frame(.data) | nrow(.data) < 1) stop("ERROR: the data provided must be not empty of dataframe type.")

  # get the number of possible plotting variables
  if (is.null(list_of_columns_to_plot)) {
    list_of_columns_to_plot <- colnames(.data)[which(sapply(.data, is.numeric))]
  }

  # check that the fill_color_variable is in the dataset and not null
  if (!is.null(fill_color_variable) & !fill_color_variable %in% colnames(.data)) stop("ERROR: the fill_color_variable must be in the colum names variables.")

  # if the user decides to isolate a specific sample only
  if (!is.null(isolate_specific_patient)) .data <- .data[.data[[PID_column_name]] == isolate_specific_patient, ]

  for (pid in unique(.data[[PID_column_name]])) {
    subset_data <- .data[.data[[PID_column_name]] == pid, ]

    for (i in list_of_columns_to_plot) {
      if (!is.null(isolate_specific_drug)) subset_data <- subset_data[subset_data[[drug_column_name]] %in% isolate_specific_drug, ]

      if (nrow(subset_data) < 1) {
        print(unique(subset_data[[PID_column_name]]))
        print(unique(subset_data[[drug_column_name]]))
        stop("ERROR: Your filtering query has returned no observations")
      }

      # browser()

      # Function to dynamically add layers to a ggplot object based on conditions
      add_violin_layers <- function(p, fill_color_variable) {
        if (!is.null(fill_color_variable)) {
          p <- p + geom_violin(trim = FALSE, aes_string(fill = fill_color_variable), color = NA) +
            geom_boxplot(width = 0.1, fill = "white")
        } else {
          p <- p + geom_violin(trim = FALSE, fill = "#A4A4A4", color = "darkred") +
            geom_boxplot(width = 0.1, fill = "white")
        }
        return(p)
      }

      # Initialize ggplot
      p <- ggplot(subset_data, aes(x = Name, y = log2(unlist(subset_data[[i]]))))

      # Add violin and boxplot layers
      p <- add_violin_layers(p, fill_color_variable)

      # More layers on top
      p <- p + facet_wrap(~Treatment) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(
          title = colnames(subset_data[i]),
          x = "Cell Markers",
          y = paste0("Intensity of ", colnames(subset_data[i]), " (log2)"),
          subtitle = paste0(pid, ".", isolate_specific_drug)
        ) +
        geom_jitter(shape = 16, position = position_jitter(0.01)) +
        stat_summary(geom = "crossbar", fun = mean, colour = "red", width = 0.21)

      # Conditionally add to list of plots
      if (save_list_of_plots) {
        list_plottos[[paste0(isolate_specific_drug, ".", pid, ".", i)]] <- p
      }


      if (save_plots) {
        if (save_plots_in_patient_specific_subfolders) {

          if (!dir.exists(paste0(saving_plots_folder, "/", pid))) dir.create(paste0(saving_plots_folder, "/", pid), showWarnings = F, recursive = T)
          ggsave(
            plot = p,
            filename = paste0(
              paste0(saving_plots_folder, "/", pid),
              "/",
              Sys.Date(),
              "_",
              pid,
              ".",
              isolate_specific_drug,
              ".",
              colnames(.data[i]),
              ".pdf"
            ),
            device = "pdf",
            dpi = 600
          )
        } else {
          # Saving plots in .pdf at 600 dpi
          if (!dir.exists(saving_plots_folder)) dir.create(saving_plots_folder, showWarnings = F, recursive = T)
          ggsave(
            plot = p,
            width = p_width,
            height = p_height,
            filename = paste0(
              saving_plots_folder,
              "/",
              Sys.Date(),
              "_",
              pid,
              ".",
              isolate_specific_drug,
              ".",
              colnames(.data[i]),
              ".pdf"
            ),
            device = "pdf",
            dpi = 600,
          )
        }

        message(paste0(
          "plots for: ",
          pid,
          ".",
          isolate_specific_drug,
          ".",
          colnames(.data[i]), " saved"
        ))
      }
    }
  }
}
