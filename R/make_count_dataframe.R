#' Count the main marker expression
#' @description
#' This function counts every single marker present in the "Name" column of the data.frame and return a dataframe of the counts per marker
#' @importFrom tidyr pivot_longer
#' @return A `dataframe`/`tibble`.
#' @param .data The dataframe that is coming from the processing of the microscopy data
#' @param unique_name_row_identifier The name of the column of the .data where the unique name can be used to counts (it defaults to "filter_image")
#' @param name_of_the_markers_column The name of the column of the .data where the marker names are expressed (ie E-Caderin, DAPI), "Defaults as Name"
#' @export
#' @example
#' make_count_dataframe(data, name_of_the_markers_column = "Name", unique_name_row_identifier = "filter_image")
# adding the image number so to identify the distribution
make_count_dataframe <- function(.data, unique_name_row_identifier = "filter_image",
                                 name_of_the_markers_column = "Name") {
  counts_total <- as.data.frame.matrix(
    table(.data[[unique_name_row_identifier]], .data[[name_of_the_markers_column]])
  )

  # get a vector of all the markers in the dataset
  markers_names <- .data[[name_of_the_markers_column]] |> unique()

  # add sum of the markers
  counts_total$sum_cells <- apply(MARGIN = 1, X = counts_total[, markers_names], FUN = sum)

  # Calculate the ratios
  counts_total[paste0(markers_names, "_ratio_of_total_cells")] <-
    round(counts_total[, markers_names] / counts_total[["sum_cells"]], 2)

  counts_total[[unique_name_row_identifier]] <- row.names(counts_total)

  # get variables back from the filter column
  counts_total$PID <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 1)
  counts_total$Date <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 2)
  counts_total$DOC <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 3)
  counts_total$Tissue <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 4)
  counts_total$Image_number <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 5)
  counts_total$Treatment <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 6)
  counts_total$Concentration1 <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 7)
  counts_total$Concentration2 <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 8)
  counts_total$ConcentrationUnits1 <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 9)
  counts_total$ConcentrationUnits2 <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 10)
  counts_total$ReplicaOrNot <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 11)
  counts_total$Treatment_complete <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), "[", 12)


  # Return the data
  return(
    counts_total
  )
}
