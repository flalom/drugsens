#' Main parsing function
#' @description
#' This function will parse the data from the Image name and will return the metadata there contained
#' The metadata will be then associated to the count file as well
#' @import knitr
#' @import testthat
#' @importFrom stringr str_extract
#' @importFrom stringr str_count
#' @return A `dataframe`/`tibble`.
#' @param .data dataframe with parsed metadata
#' @example
#' data.parsed <- string_parsing(.data)
#' #This will return the dataframe of all the data in the folder
# Main function to bind data from multiple files
string_parsing <- function(.data) {
  # add the image name
  .data$Image_number <- stringr::str_extract(
    string = .data$Image,
    pattern = "series.\\d*"
  )

  multiple_drugs <- list()

  # Idea I could add the configuration of the relative position of the various elements of the text by providing this configuration in the config file
  # in the case of more complex scenario, in the config file, we offer the possibility to manually define the parsing values for more than 3 drugs
  # https://bioconductor.org/packages/release/bioc/vignettes/GSVA/inst/doc/GSVA.html
  # extract information from the data
  .data$PID <- sapply(strsplit(.data$Image, "_"), `[`, 1, simplify = FALSE) |> unlist()
  # .data$PID <- str_extract(.data$Image, "[A-Z0-9]+(?=_)")
  .data$Tissue <- sapply(strsplit(.data$Image, "_"), `[`, 2, simplify = FALSE) |> unlist()
  .data$Date1 <- str_extract(.data$Image, "\\d{4}.\\d{2}.\\d{2}")
  .data$DOC <- str_extract(.data$Image, "(?<=DOC)\\d{2,4}.\\d{2}.\\d{2,4}")
  .data$ReplicaOrNot <- ifelse(stringr::str_detect(.data$Image, pattern = "Replica|Rep|rep|replica|REPLICA|REP"), "Replica", NA_character_)

  .data$Treatment <- sapply(strsplit(.data$Image, "_"), `[`, 5, simplify = FALSE) |> unlist()

  for (double_patterns in unique(.data$Treatment)) {
    number_maiusc <- stringr::str_count(pattern = "[A-Z]", string = double_patterns)
    if ((number_maiusc >= 2) &
      (number_maiusc < nchar(double_patterns))) {
       # save the double drugs
       multiple_drugs[[double_patterns]] <- double_patterns
      .data <- .data[.data$Treatment == double_patterns, ]
      .data$Concentration1 <- sapply(strsplit(.data$Image, "_"), `[`, 6, simplify = FALSE) |> unlist()
      .data$Concentration2 <- sapply(strsplit(.data$Image, "_"), `[`, 8, simplify = FALSE) |> unlist()
      .data$ConcentrationUnits1 <- sapply(strsplit(.data$Image, "_"), `[`, 7, simplify = FALSE) |> unlist()
      .data$ConcentrationUnits2 <- sapply(strsplit(.data$Image, "_"), `[`, 9, simplify = FALSE) |> unlist()
    } else {
      .data$Concentration1 <- str_extract(.data$Image, "\\d+(?=_[munp][Mm])")
      .data$Concentration2 <- NA_integer_
      .data$ConcentrationUnits1 <- str_extract(.data$Image, "[munp][Mm](?=_)")
      .data$ConcentrationUnits2 <- NA_character_
    }
  }

  # add drug plus concentration plus units
  for (i in unique(tolower(.data$Treatment))) {
    rows <- tolower(.data$Treatment) == i
    # Check if the current treatment is not in the specified list
    if (i %in% c("dmso", "control", "ctrl", "original")) {
      .data$Treatment_complete[rows] <- .data$Treatment[rows]

    } else if (i %in% tolower(names(multiple_drugs))){
      .data$Treatment_complete[rows] <- paste0(.data$Treatment[rows],
                                               .data$Concentration1[rows],
                                               .data$ConcentrationUnits1[rows],
                                               "-",
                                               .data$Concentration2[rows],
                                               .data$ConcentrationUnits2[rows]
                                               )
    } else {
      .data$Treatment_complete[rows] <- paste0(.data$Treatment[rows],
                                               .data$Concentration1[rows],
                                               .data$ConcentrationUnits1[rows]
      )
    }
  }

  return(
    .data
  )
}
