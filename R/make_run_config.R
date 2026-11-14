#' Generates and loads a marker-relabeling configuration file
#' @description
#' Generates a `config_drugsens.txt` file in `tempdir()` (or in `forcePath` when
#' specified) defining `list_of_relabeling`, evaluates it into an isolated local
#' environment, and stores the relabeling map inside the package's internal
#' configuration environment without modifying `.GlobalEnv`.
#' @param overwrite_config Boolean; if TRUE an existing `config_drugsens.txt`
#'   will be overwritten with the default template (default is FALSE).
#' @param forcePath Optional directory path for `config_drugsens.txt`. Defaults
#'   to `NULL`, which uses `tempdir()`.
#' @export
#' @return Invisibly returns the path to the configuration file.
#' @examples
#' \donttest{
#' # Generate and load config in a temporary directory
#' make_run_config(forcePath = tempdir())
#' }
make_run_config <- function(overwrite_config = FALSE, forcePath = NULL) {

  currentPath <- if (is.null(forcePath)) tempdir() else forcePath
  if (!dir.exists(currentPath)) {
    dir.create(currentPath, recursive = TRUE, showWarnings = FALSE)
  }
  config_file <- file.path(currentPath, "config_drugsens.txt")

  if (!file.exists(config_file) || overwrite_config) {
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

  tryCatch(
    expr = {
      cfg_env <- new.env(parent = baseenv())
      source(config_file, local = cfg_env)
      if (exists("list_of_relabeling", envir = cfg_env, inherits = FALSE)) {
        if (!is.list(cfg_env$list_of_relabeling)) {
          stop("'list_of_relabeling' in config_drugsens.txt must be a list.")
        }
        .drugsens_env$list_of_relabeling <- cfg_env$list_of_relabeling
      } else {
        .drugsens_env$list_of_relabeling <- .drugsens_default_relabeling()
      }
    },
    error = function(error) {
      message("drugsens could not load the 'config_drugsens.txt' file: ",
              conditionMessage(error),
              "\nPlease generate a valid config file with `list_of_relabeling` ",
              "and re-run make_run_config() to verify that it is correctly read.")
    }
  )

  invisible(config_file)
}
