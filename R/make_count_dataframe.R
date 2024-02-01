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
                                 name_of_the_markers_column = "Name"
                                ) {
  counts_total <- as.data.frame.matrix(
    table(.data[[unique_name_row_identifier]], .data[[name_of_the_markers_column]])
  )

  # get a vector of all the markers in the dataset
  markers_names <- .data[[name_of_the_markers_column]] |> unique()

  # add sum of the markers
  counts_total$sum_cells <- apply(MARGIN = 1, X = counts_total[, markers_names], FUN = sum)

  # # calculate the ratios
  # lapply(markers_names, \(marker) {
  #   counts_total[[paste0(marker, "_ratio_of_total_cells2")]] <<- round(counts_total[[marker]]/counts_total[["sum_cells"]], 2)
  # })

  # Calculate the ratios
  counts_total[paste0(markers_names, "_ratio_of_total_cells")] <-
    round(counts_total[, markers_names] / counts_total[["sum_cells"]], 2)

  # names of the columns
  # col_names_of_markers <- colnames(counts_total)[which(grepl(x = colnames(counts_total), pattern = "_ratio_of_total_cells"))]

  counts_total[[unique_name_row_identifier]] <- row.names(counts_total)

  # get variables back
  counts_total$PID <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 1)
  counts_total$DOC <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 2)
  counts_total$Date <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 3)
  counts_total$Tissue <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 4)
  counts_total$Image_number <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 5)
  counts_total$Treatment <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 6)
  counts_total$Concentration <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 7)
  counts_total$ConcentrationUnits <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 8)
  counts_total$ReplicaOrNot <- sapply(strsplit(counts_total[[unique_name_row_identifier]], "_"), '[', 9)

  # add drug plus concentration plus units
  for (i in unique(tolower(counts_total$Treatment))) {
    rows <- tolower(counts_total$Treatment) == i
    # Check if the current treatment is not in the specified list
    if (!i %in% c("dmso", "control", "ctrl")) {
      counts_total$Treatment_complete[rows] <- paste(counts_total$Treatment[rows], counts_total$Concentration[rows], counts_total$ConcentrationUnits[rows], sep = ".")
    } else {
      counts_total$Treatment_complete[rows] <- counts_total$Treatment[rows]
    }
  }

  # Return the data
  return(
    counts_total
  )
}
