# In make_run_config.R:

#' Generates and use a config txt file
#' @description
#' When this function run the first time, it will generated a config.txt file in the user working directory.
#' It will import the data config file into the use environment. This data will be used to change the column names
#' of the imported dataset and change the name of the markers that is often incorrectly exported.
#' @param overwrite_config Boolean, if TRUE the `config_drugsens.txt` will be overwritten (default is FALSE)
#' @param forcePath String, Define a custom path for the config file
#' @export
#' @return A `dataframe`/`tibble`.
#' @examples
#' \dontrun{
#'   make_run_config()
#' }
make_run_config <- function(overwrite_config = FALSE, forcePath = NULL) {
  currentPath <- if (is.null(forcePath)) getwd() else forcePath
  config_file <- file.path(currentPath, "config_drugsens.txt")

  if (file.exists(config_file)) {
    tryCatch(
      expr = {
        source(config_file, local = FALSE)
      },
      error = function(error) {
        message("drugsens could not load the 'config.txt' file.
                Please, generate a valid config file with the substitution
                names form the dataframe and the name of the columns to use
                for your project. Once the 'config.txt' is available re-run
                run_config to veryfy that the data was correctly read")
      }
    )
  } else if (overwrite_config) {
    write(
      x = '# List of markers to relabel
        list_of_relabeling =
        list(
            "PathCellObject" = "onlyDAPIPositve",
            "cCasp3" = "cCASP3",
            "E-Cadherin: cCASP3" = "E-Cadherin and cCASP3",
            "EpCAM_E-Cadherin" = "E-Cadherin",
            "EpCAM_E-Cadherin and cCASP3" = "E-Cadherin and cCASP3"
          )',
      file = config_file
    )
  } else {
    write(
      x = '# List of markers to relabel
        list_of_relabeling =
        list(
            "PathCellObject" = "onlyDAPIPositve",
            "cCasp3" = "cCASP3",
            "E-Cadherin: cCASP3" = "E-Cadherin and cCASP3",
            "EpCAM_E-Cadherin" = "E-Cadherin",
            "EpCAM_E-Cadherin and cCASP3" = "E-Cadherin and cCASP3"
          )',
      file = config_file
    )
  }
}
