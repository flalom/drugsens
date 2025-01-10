# Get a list of all the files that are in a user-specified folder and get a list of full paths
#' @description
#' This function lists the content of a selected folder either recursively or not
#' @keywords internal
#' @returns list
#' @name   "Name", "list_of_relabeling", "marker_positivity","marker_positivity_ratio", "x", "y"
#' @importFrom utils read.csv
#' @importFrom stats setNames
#' @import roxygen2
#'

# important for the scripts
globalVariables(c(
  "Name", "list_of_relabeling", "marker_positivity",
  "marker_positivity_ratio", "x", "y"
))

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

# Helper function to read and process a single file
#' @description
#' This function returns a processed single file
#' @param file_path Path to the file
#' @param extension String File extension to filter
#' @keywords internal
#' @returns dataframe
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
#' @description
#' This function try to guess the string patterns that are in the dataset and then fill the dataframe
#' with that information. Finally the data is combined and combined them into one file
#' @import knitr
#' @importFrom stringr str_extract
#' @return A `dataframe`/`tibble`.
#' @param path_to_the_projects_folder String/Path The path where the files coming out of QuPath are located
#' @param files_extension_to_look_for String The extension of the file outputted from QuPath, (default is "csv")
#' @param recursive_search Boolean, it defined the behavior of the file search, if recursive or not, (default is FALSE)
#' @returns Returns a concatenated dataframe from all the files within the indicated one
#' @export
#' @examples
#' bind_data <- data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/",
#' package = "drugsens"))
#' #This will return the dataframe of all the data in the folder
# Main function to bind data from multiple files
data_binding <- function(path_to_the_projects_folder,
                         files_extension_to_look_for = "csv",
                         recursive_search = FALSE) {
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
