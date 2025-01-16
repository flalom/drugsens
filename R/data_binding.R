# Get a list of all the files that are in a user-specified folder and get a list of full paths
#' Internal utility functions for file handling
#' @name utils_internal
#' @description
#' This file contains internal utility functions for file handling and processing
#' @keywords internal
#' @importFrom utils read.csv
#' @importFrom stats setNames
#' @import roxygen2
#' @examples
#' \donttest{
#' # Load example data from package
#' bind_data <- data_binding(
#'   path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
#' )
#' }

# list all the files
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

# Process a Single File
#' @title Process a Single File
#' @name process_file
#' @description This function returns a processed single file
#' @param file_path Path to the file
#' @param extension String File extension to filter
#' @keywords internal
#' @return dataframe
process_file <- function(file_path,
                         # relabeling_map,
                         extension) {
  message(paste0("Reading file: ", file_path))

  # Read the CSV file into a data frame
  .data <- read.csv(file_path, stringsAsFactors = FALSE)
  extension <- sub(x = extension, pattern = "\\.", "")

  # get the name, relabeling of the markers WIP
  for (nam in names(list_of_relabeling)) {
    .data$Name <- gsub(
      x = as.character(.data$Name),
      pattern = nam,
      replacement = list_of_relabeling[[nam]],
      ignore.case = FALSE
    )
  }

  # parse the data with the function
  .data <- string_parsing(.data)

  .data$filter_image <- apply(.data, 1, function(row) {
    paste(
      row["PID"],
      row["Date1"],
      row["DOC"],
      row["Tissue"],
      row["Image_number"],
      row["Treatment"],
      row["Concentration1"],
      row["Concentration2"],
      row["ConcentrationUnits1"],
      row["ConcentrationUnits2"],
      row["ReplicaOrNot"],
      row["Treatment_complete"],
      collapse = "_",
      sep = "_"
    )
  })

  return(.data)
}

#' Merge all the dataframes coming out from the QuPath
#' @name data_binding
#' @description
#' This function identifies string patterns in the dataset, fills the dataframe
#' with that information, and combines all data into a single file
#' @import knitr
#' @importFrom stringr str_extract
#' @param path_to_the_projects_folder String/Path The path where the files coming out of QuPath are located
#' @param files_extension_to_look_for String The extension of the file outputted from QuPath, (default is "csv")
#' @param recursive_search Boolean, it defined the behavior of the file search, if recursive or not, (default is FALSE)
#' @param forcePath String defining an alternative path to the confic file
#' @return A concatenated dataframe from all the files within the indicated path
#' @export
#' @examples
#' \dontrun{
#' bind_data <- data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/",
#'                          package = "drugsens"))
#'}

# Main function to bind data from multiple files
data_binding <- function(path_to_the_projects_folder,
                         files_extension_to_look_for = "csv",
                         recursive_search = FALSE,
                         forcePath = NULL) {
  # run configuration file
  make_run_config(forcePath = forcePath)

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
  list_csv_files <- list_all_files(
    path_to_the_projects_folder,
    files_extension_to_look_for,
    recursive_search
  )

  # Process each file and combine the results
  df_list <- lapply(
    list_csv_files,
    process_file,
    files_extension_to_look_for
  )

  combined_df <- do.call(rbind, df_list)

  # Return the combined dataframe
  return(combined_df)
}
