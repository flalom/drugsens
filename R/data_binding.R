# Get a list of all the files that are in a user-specified folder and get a list of full paths
list_all_files <- function(define_path, extension, recursive_search) {
  list_listed_files <- list.files(
    path = define_path,
    pattern = extension,
    ignore.case = TRUE,
    recursive = recursive_search,
    full.names = TRUE
  ) |>
    Filter(
      x = _,
      f = function(z) grepl(x = z, pattern = extension)
    )
  return(
    list_listed_files
  )
}

# Helper function to read and process a single file
process_file <- function(file_path,
                         # relabeling_map,
                         extension) {
  message(paste0("Reading file: ", file_path))

  # Read the CSV file into a data frame
  data <- read.csv(file_path, stringsAsFactors = FALSE)
  extension <- sub(x = extension, pattern = "\\.", "")

  # add the image name
  data$Image_number <- stringr::str_extract(
    string = data$Image,
    pattern = "series.\\d*"
  )

  # extract information from the data
  data$PID <- str_extract(data$Image, "[A-Z0-9]+(?=_)")
  data$Tissue <-  sapply(strsplit(data$Image, "_"), `[`, 2, simplify=FALSE) |> unlist()
  data$Date1 <- str_extract(data$Image, "\\d{4}.\\d{2}.\\d{2}")
  data$DOC <- str_extract(data$Image, "(?<=DOC)\\d{4}\\.\\d{2}\\.\\d{2}")
  data$ReplicaOrNot <- ifelse(stringr::str_detect(data$Image, pattern = "Replica|Rep|rep|replica|REPLICA|REP"), "Replica", NA_character_)

  data$Treatment <- str_extract(string = data$Image, pattern = "(?<=\\d{4}\\.\\d{2}\\.\\d{2}_)[A-Za-z0-9]+(?=_.+)")

  data$Concentration <-  str_extract(data$Image, "\\d+(?=_[un][Mm])")
  data$ConcentrationUnits <- str_extract(data$Image, "[un][Mm](?=_)")

  # get the name, relabelling of the markers WIP
  for(nam in names(list_of_relabeling)) {
    data$Name <- gsub(
      x = as.character(data$Name),
      pattern = nam,
      replacement = list_of_relabeling[[nam]],
      ignore.case = FALSE
    )
  }

  ## create unique_identifier
  data$filter_image <- paste(
    data$PID,
    data$Date1,
    data$DOC,
    data$Tissue,
    data$Image_number,
    data$Treatment,
    data$Concentration,
    data$ConcentrationUnits,
    data$ReplicaOrNot,
    sep = "_"
  )

  return(data)
}

#' Merge all the dataframes coming out from the QuPath
#' @description
#' This function try to guess the string patterns that are in the dataset and then fill the dataframe
#' with that information. Finally the data is combined and combined them into one file
#' @import knitr
#' @import testthat
#' @importFrom stringr str_extract
#' @return A `dataframe`/`tibble`.
#' @param path_to_the_projects_folder The path where the files coming out of QuPath are located
#' @param files_extension_to_look_for The extension of the file outputted from QuPath
#' @param recursive_search Boolean, it defined the behavior of the file search, if recursive or not, (default is FALSE)
#'
#' @export
#' @example
#' dataframe_output <- data_binding(path_to_the_projects_folder = "<USER_DEFINED_PATH>"
#'                                  files_extension_to_look_for = "csv")
#'#This will return the dataframe of all the data in the folder
# Main function to bind data from multiple files
data_binding <- function(path_to_the_projects_folder,
                         files_extension_to_look_for,
                         recursive_search = FALSE
                         ) {

  # run configuration file
  make_run_config()

  # Validate input parameters
  if (!dir.exists(path_to_the_projects_folder)) {
    stop("The specified path does not exist.")
  }

  if (is.null(files_extension_to_look_for)) {
    stop("File extension to look for has to be provided.")
  }

  if (!is.list(list_of_relabeling) && !is.null(list_of_relabeling)) {
    stop("The relabeling information should be provided as a list.")
  }

  # List all files with the specified extension in the given folder
  list_csv_files <- list_all_files(path_to_the_projects_folder,
                                   files_extension_to_look_for,
                                   recursive_search)

  # Process each file and combine the results
  df_list <- lapply(list_csv_files,
                    process_file,
                    # relabeling_map = use_custom_column_names,
                    files_extension_to_look_for)

  combined_df <- do.call(rbind, df_list)

  # # remove namings
  # rm(list_csv_files, col_names_qupath_output_files)

  # Return the combined dataframe
  return(combined_df)
}
