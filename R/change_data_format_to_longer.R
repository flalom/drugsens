#' Reformat the counts data in longer format
#' @description
#' This function gets the count data data.frame, that has a wider format and it returns a longer-formatted data.frame
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr select
#' @importFrom tidyselect any_of
#' @return A `dataframe`/`tibble`.
#' @param .data The markers count dataframe that is coming from the processing of the microscopy data
#' @param pattern_column_markers The markers' pattern name to obtain the column with ratios of the markers (it defaults to "_ratio_of_total_cells")
#' @param additional_columns columns that can be additionally added to the longer formatted data.frame, "Defaults as c("Treatment", "PID", "Image_number", "Tissue", "Concentration", "DOC")"
#' @param unique_name_row_identifier String that indicates the unique identifier for each image, defaults as "filter_image"
#' @export
#' @examples
#' list_of_relabeling =list(  "PathCellObject" = "onlyDAPIPositve",
#' "cCasp3" = "cCASP3",  "E-Cadherin: cCASP3" = "E-Cadherin and cCASP3",
#' "EpCAM_E-Cadherin" = "E-Cadherin",
#' "EpCAM_E-Cadherin and cCASP3" = "E-Cadherin and cCASP3")
#' bind_data <- data_binding(path_to_the_projects_folder =
#' system.file("extdata/to_merge/", package = "DRUGSENS"))
#' counts_dataframe <- make_count_dataframe(bind_data)
#' plotting_ready_dataframe <-
#' change_data_format_to_longer(counts_dataframe)

# adding the image number so to identify the distribution

# pivot_longer
change_data_format_to_longer <- function(.data,
                                         pattern_column_markers = "_ratio_of_total_cells",
                                         unique_name_row_identifier = "filter_image",
                                         additional_columns = TRUE) {
  # names of the columns
  col_names_of_markers <- colnames(.data)[which(grepl(x = colnames(.data), pattern = pattern_column_markers))]

  if (additional_columns) {
    additional_columns_to_use <- c(
      "PID",
      "Date",
      "DOC",
      "Tissue",
      "Image_number",
      "Treatment",
      "Concentration1",
      "Concentration2",
      "ConcentrationUnits1",
      "ConcentrationUnits2",
      "ReplicaOrNot",
      "Treatment_complete"
    )
  } else {
    additional_columns_to_use <- NULL
  }

  if (length(col_names_of_markers) < 1) stop(paste0("Failed to find pattern: ", pattern_column_markers, " in the columnames"))

  if (!"Image_number" %in% additional_columns_to_use) stop("Image_number has to be in the dataframe.")

  if (!"Treatment_complete" %in% additional_columns_to_use) stop("Treatment_complete has to be in the dataframe.")


  longer_format <- .data |>
    select(any_of(c(
      unique_name_row_identifier,
      col_names_of_markers,
      additional_columns_to_use
    ))) |>
    pivot_longer(
      cols = c(col_names_of_markers),
      names_to = "marker_positivity",
      values_to = "marker_positivity_ratio"
    )

  return(
    longer_format
  )
}
