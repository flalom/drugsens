#' Generates and use a config txt file
#' @description
#' When this function run the first time, it will generated a config.txt file in the user working directory.
#' It will import the data config file into the use environment. This data will be used to change the column names
#' of the imported dataset and change the name of the markers that is often incorrectly exported.
#' @export
#' @return A `dataframe`/`tibble`.
#' @example
make_run_config <- function() {
  if (file.exists("config_DRUGSENS.txt")) {
    tryCatch(
      expr = {
        source("config_DRUGSENS.txt", local = FALSE)
      },
      error = function(error) {
        message("DRUGSENS could not load the 'config.txt' file.
                Please, generate a valid config file with the substitution names form the dataframe
                and the name of the columns to use for your project.
                Once the 'config.txt' is available re-run run_config to veryfy that the data was correctly read")
      }
    )
  } else {
    write(
      x =
        (
        '
        # List of markers to relabel
        list_of_relabeling =
        list(
            "PathCellObject" = "DAPI",
            "cCasp3" = "cCASP3",
            "E-Cadherin: cCASP3" = "E-Cadherin and cCASP3",
            "EpCAM_E-Cadherin" = "E-Cadherin",
            "EpCAM_E-Cadherin and cCASP3" = "E-Cadherin and cCASP3"
          )'
        ),
      file = paste0(path.expand(getwd()), "/config_DRUGSENS.txt")
    )
  }
}
