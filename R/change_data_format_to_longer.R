#' Reformat the counts data in longer format
#' @description
#' This function gets the count data data.frame, that has a wider format and it returns a longer-formatted data.frame
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr select
#' @return A `dataframe`/`tibble`.
#' @param .data The markers count dataframe that is coming from the processing of the microscopy data
#' @param pattern_column_markers The markers' pattern name to obtain the column with ratios of the markers (it defaults to "_ratio_of_total_cells")
#' @param additional_columns columns that can be additionally added to the longer formatted data.frame, "Defaults as c("Treatment", "PID", "Image_number", "Tissue", "Concentration", "DOC")"
#' @param unique_name_row_identifier String that indicates the unique identifier for each image, defaults as "filter_image"
#' @export
#' @example
#' change_data_format_to_longer(.data, pattern_column_markers = "_ratio_of_total_cells", additional_columns = TRUE)
# adding the image number so to identify the distribution

# pivot_longer
change_data_format_to_longer <- function(.data,
                                         pattern_column_markers = "_ratio_of_total_cells",
                                         unique_name_row_identifier = "filter_image",
                                         additional_columns = TRUE) {
  # names of the columns
  col_names_of_markers <- colnames(.data)[which(grepl(x = colnames(.data), pattern = pattern_column_markers))]

  if (additional_columns){
  additional_columns_to_use <- c("Treatment", "PID", "Image_number", "Tissue", "Concentration", "DOC", "Treatment_complete", "ReplicaOrNot")
  } else {
    additional_columns_to_use <- NULL
  }

  if (length(col_names_of_markers) < 1) stop(paste0("Failed to find pattern: ", pattern_column_markers, " in the columnames"))

  if (!all(additional_columns_to_use %in% colnames(.data))) stop(paste0('One or more of the following columnames:
                                                     c(Treatment", "PID", "Image_number", "Tissue", "Concentration", "DOC") could not be found.
                                                     Please check the names of your data.frame and/or provide your selection'),
                                                     "Those are the colnames found in the input data: ",
                                                     colnames(.data))
  if (!"Image_number" %in% additional_columns_to_use) stop("Image_number has to be in the dataframe.")
  if (!"Treatment_complete" %in% additional_columns_to_use) stop("Treatment_complete has to be in the dataframe.")

  longer_format <- .data |>
    select(unique_name_row_identifier, col_names_of_markers, additional_columns_to_use) |>
    pivot_longer(cols = c(col_names_of_markers),
      names_to = "marker_positivity",
      values_to = "marker_positivity_ratio"
    )

return(
  longer_format
)
}
