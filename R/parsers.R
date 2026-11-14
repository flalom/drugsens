#' @title Parse image filenames to extract metadata
#' @description
#' This function will parse the data from the Image name and will return the metadata there contained
#' The metadata will be then associated to the count file as well
#' @importFrom stringr str_extract str_count str_detect
#' @return A `dataframe`/`tibble`.
#' @param .data dataframe with parsed metadata
#' @export
#' @examples
#' # Basic example with sample data
#' input_data <- data.frame(
#'   Image = "B516_Ascites_2023-11-25_DOC2020-12-14_dmso_rep_Ecad_cCasp3_(series 01).tif"
#' )
#' test <- drugsens::string_parsing(input_data)
#'
#' \donttest{
#' # Example with actual data processing
#' data.parsed <- string_parsing(input_data)
#' }

# Main function to bind data from multiple files
string_parsing <- function(.data) {
  # add the image name
  .data$Image_number <- stringr::str_extract(
    string = .data$Image,
    pattern = "series.\\d*"
  )

  # Split image names on "_" once for positional token inspection
  split_tokens <- strsplit(as.character(.data$Image), "_")
  get_tok <- function(idx) {
    vapply(split_tokens, function(x) if (length(x) >= idx) x[idx] else NA_character_, character(1))
  }

  # extract information from the data
  .data$PID <- get_tok(1)
  .data$Tissue <- get_tok(2)
  .data$Date1 <- stringr::str_extract(.data$Image, "\\d{4}.\\d{2}.\\d{2}")
  .data$DOC <- stringr::str_extract(.data$Image, "(?<=DOC)\\d{2,4}.\\d{2}.\\d{2,4}")
  .data$ReplicaOrNot <- ifelse(
    stringr::str_detect(.data$Image, pattern = "(?i)(?:^|_)(?:rep|replica)(?:_|$)"),
    "Replica",
    NA_character_
  )

  .data$Treatment <- get_tok(5)
  tok6 <- get_tok(6)
  tok7 <- get_tok(7)
  tok8 <- get_tok(8)
  tok9 <- get_tok(9)

  .data$Concentration1 <- NA_character_
  .data$Concentration2 <- NA_character_
  .data$ConcentrationUnits1 <- NA_character_
  .data$ConcentrationUnits2 <- NA_character_
  .data$Treatment_complete <- NA_character_

  number_maiusc <- stringr::str_count(pattern = "[A-Z]", string = .data$Treatment)
  has_two_doses <- grepl("^\\d+(?:\\.\\d+)?$", tok6) &
    grepl("^[munp][Mm]$", tok7) &
    grepl("^\\d+(?:\\.\\d+)?$", tok8) &
    grepl("^[munp][Mm]$", tok9)
  is_double <- !is.na(.data$Treatment) &
    (number_maiusc >= 2) &
    (number_maiusc < nchar(.data$Treatment)) &
    has_two_doses

  if (any(is_double)) {
    .data$Concentration1[is_double] <- tok6[is_double]
    .data$ConcentrationUnits1[is_double] <- tok7[is_double]
    .data$Concentration2[is_double] <- tok8[is_double]
    .data$ConcentrationUnits2[is_double] <- tok9[is_double]
  }

  single_rows <- !is_double
  if (any(single_rows)) {
    conc_unit_match <- stringr::str_extract(
      .data$Image[single_rows],
      "(?<=_)\\d+(?:\\.\\d+)?_[munp][Mm](?=_|$)"
    )
    .data$Concentration1[single_rows] <- stringr::str_extract(conc_unit_match, "^\\d+(?:\\.\\d+)?")
    .data$Concentration2[single_rows] <- NA_character_
    .data$ConcentrationUnits1[single_rows] <- stringr::str_extract(conc_unit_match, "[munp][Mm]$")
    .data$ConcentrationUnits2[single_rows] <- NA_character_
  }

  # add drug plus concentration plus units
  is_ctrl <- tolower(.data$Treatment) %in% c("dmso", "control", "ctrl", "original")
  .data$Treatment_complete[is_ctrl] <- .data$Treatment[is_ctrl]
  .data$Treatment_complete[is_double & !is_ctrl] <- paste0(
    .data$Treatment[is_double & !is_ctrl],
    .data$Concentration1[is_double & !is_ctrl],
    .data$ConcentrationUnits1[is_double & !is_ctrl],
    "-",
    .data$Concentration2[is_double & !is_ctrl],
    .data$ConcentrationUnits2[is_double & !is_ctrl]
  )
  single_non_ctrl <- !is_double & !is_ctrl
  .data$Treatment_complete[single_non_ctrl] <- ifelse(
    !is.na(.data$Concentration1[single_non_ctrl]) & !is.na(.data$ConcentrationUnits1[single_non_ctrl]),
    paste0(
      .data$Treatment[single_non_ctrl],
      .data$Concentration1[single_non_ctrl],
      .data$ConcentrationUnits1[single_non_ctrl]
    ),
    .data$Treatment[single_non_ctrl]
  )

  return(
    .data
  )
}
