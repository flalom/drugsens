# Internal helper to match user-provided marker names (with or without "_ratio_of_total_cells")
drugsens_match_markers <- function(user_markers, available_markers, arg_name = "markers") {
  avail_clean <- sub("_ratio_of_total_cells$", "", available_markers)
  user_clean <- sub("_ratio_of_total_cells$", "", as.character(user_markers))
  matched <- character(0)
  for (um in user_clean) {
    idx <- which(available_markers == um | avail_clean == um)
    if (length(idx) == 0) {
      stop(sprintf(
        "Marker '%s' in `%s` was not found. Available markers: %s",
        um, arg_name, paste(unique(avail_clean), collapse = ", ")
      ))
    }
    matched <- c(matched, available_markers[idx])
  }
  unique(matched)
}

#' Normalize marker values to percent of control
#' @description
#' Expresses each marker measurement (or a biological target-cell viability /
#' cell-death metric computed from user-selected `dead_markers` and
#' `viable_markers` / `total_markers`) as a percentage of the mean control
#' (untreated/vehicle) value within the same patient. This is the standard
#' first step for building dose response curves and estimating \eqn{\mathrm{IC}_{50}}
#' in drug sensitivity assays, following Labrosse et al. (2024)
#' <doi:10.1016/j.xpro.2024.103274>.
#'
#' When `dead_markers` (e.g. `"cCASP3"`) and `viable_markers` (e.g.
#' `"EpCAM_E-Cadherin"`) or `total_markers` (e.g. `c("EpCAM_E-Cadherin", "cCASP3")`)
#' are supplied, `normalize_to_control()` first computes for each well/image:
#' \itemize{
#'   \item \code{dead_cells_ratio}: sum of \code{dead_markers}
#'   \item \code{total_target_cells_ratio}: sum of \code{total_markers} (living target cells + dying cells, excluding unrelated DAPI-only stromal cells)
#'   \item \code{viable_cells_ratio}: \code{total_target_cells_ratio - dead_cells_ratio}
#'   \item \code{dead_fraction}: \code{dead_cells_ratio / total_target_cells_ratio}
#'   \item \code{viable_fraction}: \code{1 - dead_fraction} (\code{viable_cells_ratio / total_target_cells_ratio})
#' }
#' and then normalizes the chosen \code{response_metric} (\code{"viability"} or
#' \code{"cell_death"}) against the matched \code{control_treatment_name} group.
#' @param .data A data frame in either the wide format returned by
#'   `make_count_dataframe()` or the long format returned by
#'   `change_data_format_to_longer()`.
#' @param control_treatment_name Value identifying control/vehicle wells in
#'   `treatment_column_name`. Defaults to "Control".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param group_by_columns Columns that define a comparable batch: the control mean
#'   is computed within each combination of these columns. Defaults to "PID".
#' @param value_columns Columns to normalize. If NULL, uses "marker_positivity_ratio"
#'   when present (long format), otherwise all columns matching `pattern_column_markers`
#'   (wide format).
#' @param pattern_column_markers Pattern used to auto-detect marker columns in wide
#'   format. Defaults to "_ratio_of_total_cells".
#' @param dead_markers Optional character vector of marker name(s) representing
#'   dead/dying cells (e.g. `"cCASP3"` or `c("cCASP3", "E-Cadherin and cCASP3")`).
#'   Matches names with or without the `"_ratio_of_total_cells"` suffix.
#' @param viable_markers Optional character vector of marker name(s) representing
#'   viable target/cancer cells (e.g. `"EpCAM_E-Cadherin"` or `"E-Cadherin"`).
#'   When multiple `viable_markers` and `dead_markers` are supplied, markers are
#'   paired positionally if `length(viable_markers) == length(dead_markers)`;
#'   otherwise all combinations are evaluated alongside a combined consensus panel.
#' @param total_markers Optional character vector of marker name(s) representing
#'   the total target cell population (e.g. `c("EpCAM_E-Cadherin", "cCASP3")`).
#'   If `NULL` when `dead_markers` and `viable_markers` are provided, defaults to
#'   `unique(c(viable_markers, dead_markers))`.
#' @param response_metric Metric to compute and normalize when `dead_markers` is
#'   provided: `"viability"` (default, `1 - dead / total`, which starts at `100%`
#'   in control and decreases toward `0%` as cells die) or `"cell_death"`
#'   (`dead / total`).
#' @param selected_treatments Optional character vector of treatment names to keep
#'   (in addition to `control_treatment_name`). Defaults to `NULL` (all treatments).
#' @param consensus_only Logical; when multiple `viable_markers` or `dead_markers`
#'   are supplied and `consensus_only = FALSE` (the default), `normalize_to_control()`
#'   computes each individual marker pair's readout as well as a combined
#'   `"Consensus (Combined)"` readout across all selected markers. Set
#'   `consensus_only = TRUE` to return only the combined consensus readout.
#' @return `.data` with an added column per normalized value: `"<column>_pct_of_control"`
#'   in wide format, or a single `"pct_of_control"` column in long format. When
#'   `dead_markers` is supplied, also includes `dead_cells_ratio`,
#'   `viable_cells_ratio`, `total_target_cells_ratio`, `dead_fraction`,
#'   `viable_fraction`, and `is_consensus`.
#' @export
#' @examples
#' # A patient with a control group and one drug at three doses
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugA"),
#'   cCASP3_ratio_of_total_cells = c(10, 10, 5, 20, 40)
#' )
#' normalize_to_control(df)
normalize_to_control <- function(.data,
                                 control_treatment_name = "Control",
                                 treatment_column_name = "Treatment",
                                 group_by_columns = "PID",
                                 value_columns = NULL,
                                 pattern_column_markers = "_ratio_of_total_cells",
                                 dead_markers = NULL,
                                 viable_markers = NULL,
                                 total_markers = NULL,
                                 response_metric = c("viability", "cell_death"),
                                 selected_treatments = NULL,
                                 consensus_only = FALSE) {
  response_metric <- match.arg(response_metric)
  if (!is.data.frame(.data) || nrow(.data) < 1) {
    stop("Input must be a non-empty data frame")
  }
  if (!treatment_column_name %in% colnames(.data)) {
    stop(paste0("Column not found: ", treatment_column_name))
  }
  if (!all(group_by_columns %in% colnames(.data))) {
    stop("All group_by_columns must be present in .data")
  }

  if (!is.null(selected_treatments)) {
    ctrl_vals_in_data <- if (any(.data[[treatment_column_name]] == control_treatment_name)) {
      control_treatment_name
    } else {
      unique(.data[[treatment_column_name]][
        tolower(as.character(.data[[treatment_column_name]])) == tolower(control_treatment_name)
      ])
    }
    keep_tr <- unique(c(ctrl_vals_in_data, as.character(selected_treatments)))
    .data <- .data[.data[[treatment_column_name]] %in% keep_tr, , drop = FALSE]
    if (nrow(.data) < 1) {
      stop("No rows remaining after filtering for `selected_treatments` and `control_treatment_name`.")
    }
  }

  is_control <- .data[[treatment_column_name]] == control_treatment_name
  if (!any(is_control)) {
    ci_match <- tolower(as.character(.data[[treatment_column_name]])) == tolower(control_treatment_name)
    if (any(ci_match)) {
      matched_name <- as.character(.data[[treatment_column_name]][which(ci_match)[1]])
      warning(sprintf(
        "No exact match for control_treatment_name = '%s'; matched '%s' case-insensitively.",
        control_treatment_name, matched_name
      ))
      control_treatment_name <- matched_name
      is_control <- ci_match
    } else {
      stop(paste0("No rows found where ", treatment_column_name, " == '", control_treatment_name, "'"))
    }
  }

  long_format <- "marker_positivity_ratio" %in% colnames(.data)

  # Biological viability / cell-death calculation when dead_markers is provided
  if (!is.null(dead_markers)) {
    if (is.null(viable_markers) && is.null(total_markers)) {
      stop("When `dead_markers` is specified, please also provide `viable_markers` (e.g. cancer cells) or `total_markers` (all target cells).")
    }

    if (long_format && "marker_positivity" %in% colnames(.data)) {
      avail_mk <- unique(as.character(.data[["marker_positivity"]]))
      dead_cols <- drugsens_match_markers(dead_markers, avail_mk, "dead_markers")
      viable_cols <- if (!is.null(viable_markers)) {
        drugsens_match_markers(viable_markers, avail_mk, "viable_markers")
      } else {
        character(0)
      }
      total_cols <- if (!is.null(total_markers)) {
        unique(c(drugsens_match_markers(total_markers, avail_mk, "total_markers"), dead_cols))
      } else {
        unique(c(viable_cols, dead_cols))
      }
      v_cols <- if (length(viable_cols) > 0) viable_cols else setdiff(total_cols, dead_cols)

      id_cols <- setdiff(colnames(.data), c("marker_positivity", "marker_positivity_ratio", "pct_of_control",
                                            "dead_cells_ratio", "viable_cells_ratio", "total_target_cells_ratio",
                                            "dead_fraction", "viable_fraction", "is_consensus"))
      well_key <- do.call(paste, c(.data[id_cols], list(sep = "\r")))
      unique_keys <- unique(well_key)
      first_idx <- match(unique_keys, well_key)
      base_wells <- .data[first_idx, id_cols, drop = FALSE]

      build_panel_df <- function(d_set, t_set, label_override = NULL, is_cons = FALSE) {
        panel_df <- base_wells
        dead_sub <- .data[.data[["marker_positivity"]] %in% d_set, , drop = FALSE]
        dead_key <- do.call(paste, c(dead_sub[id_cols], list(sep = "\r")))
        dead_sums <- tapply(dead_sub[["marker_positivity_ratio"]], dead_key, sum, na.rm = TRUE)

        tot_sub <- .data[.data[["marker_positivity"]] %in% t_set, , drop = FALSE]
        tot_key <- do.call(paste, c(tot_sub[id_cols], list(sep = "\r")))
        tot_sums <- tapply(tot_sub[["marker_positivity_ratio"]], tot_key, sum, na.rm = TRUE)

        panel_df[["dead_cells_ratio"]] <- as.vector(dead_sums[unique_keys])
        panel_df[["total_target_cells_ratio"]] <- as.vector(tot_sums[unique_keys])
        panel_df[["viable_cells_ratio"]] <- pmax(0, panel_df[["total_target_cells_ratio"]] - panel_df[["dead_cells_ratio"]])
        panel_df[["dead_fraction"]] <- ifelse(
          panel_df[["total_target_cells_ratio"]] > 0,
          panel_df[["dead_cells_ratio"]] / panel_df[["total_target_cells_ratio"]],
          NA_real_
        )
        panel_df[["viable_fraction"]] <- ifelse(
          panel_df[["total_target_cells_ratio"]] > 0,
          panel_df[["viable_cells_ratio"]] / panel_df[["total_target_cells_ratio"]],
          NA_real_
        )

        if (is.null(label_override)) {
          v_lbl <- paste(gsub("_", " ", sub("_ratio_of_total_cells$", "", setdiff(t_set, d_set))), collapse = " + ")
          d_lbl <- paste(gsub("_", " ", sub("_ratio_of_total_cells$", "", d_set)), collapse = " + ")
          if (!nzchar(v_lbl)) v_lbl <- "Target"
          label_override <- if (response_metric == "viability") {
            sprintf("Viability: %s / (%s + %s)", v_lbl, v_lbl, d_lbl)
          } else {
            sprintf("Cell death: %s / (%s + %s)", d_lbl, v_lbl, d_lbl)
          }
        }
        panel_df[["marker_positivity"]] <- label_override
        panel_df[["marker_positivity_ratio"]] <- if (response_metric == "viability") {
          panel_df[["viable_fraction"]]
        } else {
          panel_df[["dead_fraction"]]
        }
        panel_df[["is_consensus"]] <- is_cons
        panel_df
      }

      has_multi_pairs <- !consensus_only && length(v_cols) >= 1 && (length(v_cols) > 1 || length(dead_cols) > 1)
      if (has_multi_pairs) {
        if (length(v_cols) == length(dead_cols)) {
          pair_grid <- data.frame(v = v_cols, d = dead_cols, stringsAsFactors = FALSE)
        } else if (length(v_cols) == 1) {
          pair_grid <- data.frame(v = rep(v_cols, length(dead_cols)), d = dead_cols, stringsAsFactors = FALSE)
        } else if (length(dead_cols) == 1) {
          pair_grid <- data.frame(v = v_cols, d = rep(dead_cols, length(v_cols)), stringsAsFactors = FALSE)
        } else {
          pair_grid <- expand.grid(v = v_cols, d = dead_cols, stringsAsFactors = FALSE)
        }

        panel_list <- vector("list", nrow(pair_grid) + 1)
        level_names <- character(nrow(pair_grid) + 1)
        for (idx in seq_len(nrow(pair_grid))) {
          vc <- pair_grid$v[idx]
          dc <- pair_grid$d[idx]
          p_df <- build_panel_df(dc, unique(c(vc, dc)), is_cons = FALSE)
          panel_list[[idx]] <- p_df
          level_names[idx] <- p_df[["marker_positivity"]][1]
        }
        cons_lbl <- if (response_metric == "viability") {
          "Consensus Viability (Combined)"
        } else {
          "Consensus Cell Death (Combined)"
        }
        cons_df <- build_panel_df(dead_cols, total_cols, label_override = cons_lbl, is_cons = TRUE)
        panel_list[[nrow(pair_grid) + 1]] <- cons_df
        level_names[nrow(pair_grid) + 1] <- cons_lbl

        out_df <- do.call(rbind, panel_list)
        out_df[["marker_positivity"]] <- factor(out_df[["marker_positivity"]], levels = unique(level_names))
      } else {
        out_df <- build_panel_df(dead_cols, total_cols, is_cons = TRUE)
      }

      .data <- out_df
      is_control <- .data[[treatment_column_name]] == control_treatment_name
    } else {
      avail_mk <- colnames(.data)
      dead_cols <- drugsens_match_markers(dead_markers, avail_mk, "dead_markers")
      viable_cols <- if (!is.null(viable_markers)) {
        drugsens_match_markers(viable_markers, avail_mk, "viable_markers")
      } else {
        character(0)
      }
      total_cols <- if (!is.null(total_markers)) {
        unique(c(drugsens_match_markers(total_markers, avail_mk, "total_markers"), dead_cols))
      } else {
        unique(c(viable_cols, dead_cols))
      }

      .data[["dead_cells_ratio"]] <- rowSums(.data[, dead_cols, drop = FALSE], na.rm = TRUE)
      .data[["total_target_cells_ratio"]] <- rowSums(.data[, total_cols, drop = FALSE], na.rm = TRUE)
      .data[["viable_cells_ratio"]] <- pmax(0, .data[["total_target_cells_ratio"]] - .data[["dead_cells_ratio"]])
      .data[["dead_fraction"]] <- ifelse(
        .data[["total_target_cells_ratio"]] > 0,
        .data[["dead_cells_ratio"]] / .data[["total_target_cells_ratio"]],
        NA_real_
      )
      .data[["viable_fraction"]] <- ifelse(
        .data[["total_target_cells_ratio"]] > 0,
        .data[["viable_cells_ratio"]] / .data[["total_target_cells_ratio"]],
        NA_real_
      )
      value_columns <- if (response_metric == "viability") "viable_fraction" else "dead_fraction"
    }
  }

  if (is.null(value_columns)) {
    value_columns <- if (long_format) {
      "marker_positivity_ratio"
    } else {
      colnames(.data)[grepl(pattern_column_markers, colnames(.data))]
    }
  }
  if (length(value_columns) < 1) stop("Could not find any value columns to normalize")

  group_key <- interaction(.data[group_by_columns], drop = TRUE)
  marker_key <- if (long_format && "marker_positivity" %in% colnames(.data)) {
    interaction(group_key, .data[["marker_positivity"]], drop = TRUE)
  } else {
    group_key
  }

  for (col in value_columns) {
    ctrl_sub <- .data[[col]][is_control]
    ctrl_grp <- droplevels(marker_key[is_control])
    control_means <- tapply(ctrl_sub, ctrl_grp, mean, na.rm = TRUE)
    key_chr <- as.character(marker_key)
    matched_ctrl <- as.numeric(control_means[key_chr])

    missing_or_bad <- is.na(matched_ctrl) | !is.finite(matched_ctrl) | matched_ctrl <= 0
    if (any(missing_or_bad)) {
      bad_groups <- paste(unique(key_chr[missing_or_bad]), collapse = ", ")
      warning(sprintf(
        "Missing, non-finite, or non-positive control mean in column '%s' for group(s): %s. Setting pct_of_control to NA.",
        col, bad_groups
      ))
    }
    out_col <- if (long_format) "pct_of_control" else paste0(col, "_pct_of_control")
    pct_vals <- ifelse(missing_or_bad, NA_real_, 100 * .data[[col]] / matched_ctrl)
    .data[[out_col]] <- as.vector(pct_vals)
  }

  return(.data)
}

# Standardize concentration column when a paired unit column (e.g. ConcentrationUnits1) is present
drugsens_standardize_conc <- function(df, conc_col) {
  unit_col <- if (conc_col == "Concentration1" && "ConcentrationUnits1" %in% colnames(df)) {
    "ConcentrationUnits1"
  } else if (conc_col == "Concentration2" && "ConcentrationUnits2" %in% colnames(df)) {
    "ConcentrationUnits2"
  } else {
    NULL
  }
  if (is.null(unit_col)) return(list(data = df, unit = NULL))

  raw_u <- as.character(df[[unit_col]])
  valid_u <- unique(raw_u[!is.na(raw_u) & nzchar(raw_u)])
  if (length(valid_u) == 0) return(list(data = df, unit = NULL))
  if (length(valid_u) == 1) return(list(data = df, unit = valid_u[1]))

  scale_map <- c(mm = 1000, um = 1, nm = 1e-3, pm = 1e-6)
  low_u <- tolower(raw_u)
  known <- is.na(raw_u) | !nzchar(raw_u) | (low_u %in% names(scale_map))
  if (!all(known)) {
    warning("Unrecognized concentration units encountered; plotting concentrations without unit conversion.")
    return(list(data = df, unit = NULL))
  }

  factors <- unname(scale_map[low_u])
  factors[is.na(factors)] <- 1
  uniq_factors <- unique(factors[!is.na(raw_u) & nzchar(raw_u)])
  if (length(uniq_factors) == 1 && uniq_factors[1] == 1) {
    return(list(data = df, unit = "uM"))
  }

  num_c <- suppressWarnings(as.numeric(df[[conc_col]]))
  df[[conc_col]] <- num_c * factors
  df[[unit_col]] <- ifelse(is.na(raw_u) | !nzchar(raw_u), raw_u, "uM")
  message("Multiple concentration units detected; converted concentrations to uM for consistent plotting.")
  list(data = df, unit = "uM")
}

# Internal 4-parameter log-logistic (Hill) curve fitter via stats::optim.
# Parameterizes top = bottom + span (span >= 0) to guarantee 0 <= bottom <= top
# across both decreasing (hill > 0) and increasing (hill < 0) dose-response curves.
drugsens_fit_4pl_group <- function(conc, resp) {
  valid <- is.finite(conc) & conc > 0 & is.finite(resp)
  conc <- conc[valid]
  resp <- resp[valid]
  if (length(unique(conc)) < 3) return(NULL)

  log_c <- log10(conc)
  y_min <- max(0, min(resp, na.rm = TRUE))
  y_max <- max(resp, na.rm = TRUE)
  if (y_max <= min(resp, na.rm = TRUE)) return(NULL)

  obj_fn <- function(par) {
    bottom <- par[1]
    span <- par[2]
    log_ic50 <- par[3]
    hill <- par[4]
    pred <- bottom + span / (1 + 10^((log_c - log_ic50) * hill))
    sum((resp - pred)^2)
  }

  lower_b <- c(0, 0, min(log_c) - 2, -10)
  upper_b <- c(y_max, max(200, y_max + 50), max(log_c) + 2, 10)
  span_init <- max(1e-3, y_max - y_min)
  cor_dir <- suppressWarnings(stats::cor(log_c, resp))
  slopes <- if (!is.na(cor_dir) && cor_dir < 0) c(1.5, -1.5) else c(-1.5, 1.5)

  fits <- lapply(slopes, function(sl) {
    init_par <- c(bottom = min(y_min, upper_b[1]), span = span_init, log_ic50 = stats::median(log_c), hill = sl)
    tryCatch(
      stats::optim(
        par = init_par,
        fn = obj_fn,
        method = "L-BFGS-B",
        lower = lower_b,
        upper = upper_b
      ),
      error = function(e) NULL
    )
  })
  fits <- Filter(function(f) !is.null(f) && all(is.finite(f$par)) && is.finite(f$value), fits)
  if (length(fits) == 0) return(NULL)
  fit <- fits[[which.min(vapply(fits, function(f) f$value, numeric(1)))]]

  bot_v <- unname(fit$par[1])
  top_v <- bot_v + unname(fit$par[2])
  log_ec50 <- unname(fit$par[3])
  hill_v <- unname(fit$par[4])

  grid_log_c <- seq(min(log_c), max(log_c), length.out = 100)
  pred_y <- bot_v + (top_v - bot_v) / (1 + 10^((grid_log_c - log_ec50) * hill_v))
  pred_rng <- range(pred_y, na.rm = TRUE)

  ic50_reached <- (bot_v < 50) && (top_v > 50) &&
    (pred_rng[1] <= 50) && (pred_rng[2] >= 50) &&
    (abs(hill_v) > 1e-3)

  if (ic50_reached) {
    ratio_50 <- (top_v - 50) / (50 - bot_v)
    ic50_val <- if (is.finite(ratio_50) && ratio_50 > 0) 10^(log_ec50 + log10(ratio_50) / hill_v) else NA_real_
    y_50_val <- if (is.finite(ic50_val)) 50 else NA_real_
    if (!is.finite(ic50_val)) ic50_reached <- FALSE
  } else {
    ic50_val <- NA_real_
    y_50_val <- NA_real_
  }

  list(
    curve = data.frame(
      concentration = 10^grid_log_c,
      pct_of_control = pred_y,
      stringsAsFactors = FALSE
    ),
    params = data.frame(
      bottom = bot_v,
      top = top_v,
      ic50 = ic50_val,
      ec50 = 10^log_ec50,
      y_ic50 = y_50_val,
      hill_slope = hill_v,
      converged = (fit$convergence == 0),
      ic50_reached = ic50_reached,
      stringsAsFactors = FALSE
    )
  )
}

#' Plot dose response curves from normalized data
#' @description
#' Plots percent-of-control marker values against drug concentration, the
#' standard dose response view for drug sensitivity assays. Expects data
#' that has already been processed with `normalize_to_control()`. Supports
#' non-parametric LOESS smoothing (`method = "loess"`), 4-parameter log-logistic
#' Hill curve fitting (`method = "4pl"`), or linear trend lines (`method = "linear"`).
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", and a
#'   concentration column).
#' @param concentration_column_name Column holding the drug concentration. Defaults
#'   to "Concentration1".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param patient_column_name Column holding the patient ID. Defaults to "PID".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the dose response curve. Defaults to "Control".
#' @param log_scale_x Logical, whether to plot concentration on a log10 axis (the
#'   usual view when doses span orders of magnitude). Defaults to TRUE; rows with
#'   a non-positive concentration are dropped when TRUE.
#' @param method Curve fitting method: `"loess"` (default), `"4pl"` (4-parameter
#'   log-logistic Hill model estimated via `stats::optim()`), or `"linear"`.
#'   When `"4pl"` is used, a data frame of estimated `ic50`, `hill_slope`, `bottom`,
#'   and `top` parameters is attached as `attr(plot, "ic50")`.
#' @param show_ic50 Logical; when `TRUE` and `method = "4pl"`, draws a vertical
#'   dashed reference line at the estimated IC50 concentration for each fitted curve.
#'   Defaults to `FALSE`.
#' @param dead_markers Optional character vector of marker name(s) representing
#'   dead/dying cells (e.g. `"cCASP3"`). If provided, `normalize_to_control()` is
#'   called automatically to compute the target cell response before plotting.
#' @param viable_markers Optional character vector of marker name(s) representing
#'   viable target/cancer cells (e.g. `"EpCAM_E-Cadherin"`).
#' @param total_markers Optional character vector of marker name(s) representing
#'   all target cells (e.g. `c("EpCAM_E-Cadherin", "cCASP3")`).
#' @param response_metric Metric to compute when `dead_markers` is supplied:
#'   `"viability"` (default) or `"cell_death"`.
#' @param selected_treatments Optional character vector of drug treatment names to
#'   plot (e.g. `"Paclitaxel"`).
#' @param consensus_only Logical; when multiple `viable_markers` or `dead_markers`
#'   are supplied, `FALSE` (default) plots individual panels for each marker pair
#'   plus a `"Consensus Viability (Combined)"` panel and attaches the consensus
#'   IC50 table as `attr(plot, "consensus_ic50")`. Set to `TRUE` to plot only the
#'   combined consensus panel.
#' @param consensus_dispersion Coefficient of variation or dispersion metric to
#'   compute per point on the Consensus panel (attached as `attr(plot, "consensus_cv")`
#'   and plotted as error bars / point labels): `"cv"` (standard coefficient of
#'   variation `100 * SD / Mean`, default), `"rcvq"` (robust quartile CV
#'   `100 * 0.75 * IQR / Median`), `"rcv_mad"` (robust MAD CV `100 * MAD / Median`),
#'   `"sd"` (standard deviation), `"se"` (standard error), `"iqr"` (interquartile
#'   range), `"mad"` (median absolute deviation), or `"none"`. Note that `rcvq` and
#'   `rcv_mad` require multiple marker pairs/replicates per dose (most informative
#'   when >= 3 values per dose are available).
#' @param show_cv Logical; whether to print the per-point CV (or selected
#'   `consensus_dispersion` value) on the Consensus panel. Defaults to `TRUE`.
#' @importFrom ggplot2 ggplot aes geom_point geom_smooth geom_hline geom_line
#'             geom_vline geom_errorbar geom_label geom_text facet_wrap labs scale_x_log10
#' @importFrom stats optim cor median IQR mad approx
#' @return A `ggplot` object (with `attr(plot, "ic50")`, `attr(plot, "consensus_ic50")`,
#'   and `attr(plot, "consensus_cv")` populated).
#' @export
#' @examples
#' df <- data.frame(
#'   PID = rep("PID1", 10),
#'   Treatment = c("Control", "Control", rep("DrugA", 8)),
#'   Concentration1 = c(NA, NA, "0.1", "0.1", "1", "1", "10", "10", "100", "100"),
#'   marker_positivity = "Viability",
#'   marker_positivity_ratio = c(10, 10, 9.5, 9.2, 7.0, 6.8, 3.0, 2.8, 1.0, 0.9)
#' )
#' normalized <- normalize_to_control(df)
#' plot_dose_response(normalized)
#' plot_dose_response(normalized, method = "4pl", show_ic50 = TRUE)
plot_dose_response <- function(.data,
                               concentration_column_name = "Concentration1",
                               treatment_column_name = "Treatment",
                               patient_column_name = "PID",
                               control_treatment_name = "Control",
                               log_scale_x = TRUE,
                               method = c("loess", "4pl", "linear"),
                               show_ic50 = FALSE,
                               dead_markers = NULL,
                               viable_markers = NULL,
                               total_markers = NULL,
                               response_metric = c("viability", "cell_death"),
                               selected_treatments = NULL,
                               consensus_only = FALSE,
                               consensus_dispersion = c("cv", "rcvq", "rcv_mad", "sd", "se", "iqr", "mad", "none"),
                               show_cv = TRUE) {
  method <- match.arg(method)
  response_metric <- match.arg(response_metric)
  consensus_dispersion <- match.arg(consensus_dispersion)

  if (!is.null(dead_markers)) {
    .data <- normalize_to_control(
      .data,
      control_treatment_name = control_treatment_name,
      treatment_column_name = treatment_column_name,
      group_by_columns = patient_column_name,
      dead_markers = dead_markers,
      viable_markers = viable_markers,
      total_markers = total_markers,
      response_metric = response_metric,
      selected_treatments = selected_treatments,
      consensus_only = consensus_only
    )
  } else if (!is.null(selected_treatments)) {
    .data <- .data[.data[[treatment_column_name]] %in% as.character(selected_treatments), , drop = FALSE]
  }

  required_cols <- c("pct_of_control", "marker_positivity", concentration_column_name,
                     treatment_column_name, patient_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  std <- drugsens_standardize_conc(plot_data, concentration_column_name)
  plot_data <- std$data
  conc_unit <- std$unit
  plot_data[[concentration_column_name]] <- suppressWarnings(as.numeric(plot_data[[concentration_column_name]]))
  plot_data <- plot_data[!is.na(plot_data[[concentration_column_name]]) &
                           is.finite(plot_data[["pct_of_control"]]), ]
  if (log_scale_x || method == "4pl") {
    plot_data <- plot_data[plot_data[[concentration_column_name]] > 0, ]
  }

  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a numeric concentration and finite pct_of_control were found to plot")
  }

  n_patients <- length(unique(plot_data[[patient_column_name]]))
  mk_vals <- if (is.factor(plot_data[["marker_positivity"]])) {
    levels(droplevels(plot_data[["marker_positivity"]]))
  } else {
    unique(plot_data[["marker_positivity"]])
  }
  is_cell_death <- (response_metric == "cell_death") ||
    all(grepl("^Cell death|^Consensus Cell Death", as.character(plot_data[["marker_positivity"]])))

  p <- ggplot2::ggplot(plot_data, ggplot2::aes(
    x = .data[[concentration_column_name]],
    y = .data[["pct_of_control"]],
    color = .data[[patient_column_name]],
    fill = .data[[patient_column_name]]
  )) +
    ggplot2::geom_hline(yintercept = 100, color = "#8c8b82", linetype = "dashed", linewidth = 0.6)

  if (!is_cell_death) {
    p <- p + ggplot2::geom_hline(yintercept = 50, color = "#52514e", linetype = "longdash", linewidth = 0.65)
  }

  p <- p +
    ggplot2::geom_point(
      alpha = 0.55,
      size = 2.1,
      shape = 21,
      color = "#fcfcfb",
      stroke = 0.35
    ) +
    ggplot2::stat_summary(
      fun = mean,
      geom = "point",
      size = 2.8,
      alpha = 0.95
    )

  # Compute per-point CV / dispersion on the Consensus panel
  consensus_cv_df <- data.frame()
  is_cons_vec <- if ("is_consensus" %in% colnames(plot_data)) {
    as.logical(plot_data[["is_consensus"]])
  } else {
    grepl("^Consensus", as.character(plot_data[["marker_positivity"]]))
  }
  if (any(is_cons_vec) && consensus_dispersion != "none") {
    cons_mk <- unique(as.character(plot_data[["marker_positivity"]][is_cons_vec]))[1]
    has_indiv <- any(!is_cons_vec)
    cv_rows <- list()
    for (pid in unique(plot_data[[patient_column_name]])) {
      for (cc in sort(unique(plot_data[[concentration_column_name]]))) {
        cons_sub <- plot_data[is_cons_vec &
                                plot_data[[patient_column_name]] == pid &
                                plot_data[[concentration_column_name]] == cc, , drop = FALSE]
        if (nrow(cons_sub) < 1) next
        pool_sub <- if (has_indiv) {
          plot_data[!is_cons_vec &
                      plot_data[[patient_column_name]] == pid &
                      plot_data[[concentration_column_name]] == cc, , drop = FALSE]
        } else {
          cons_sub
        }
        v <- pool_sub[["pct_of_control"]]
        v <- v[is.finite(v)]
        if (length(v) < 2) next
        m_cons <- mean(cons_sub[["pct_of_control"]], na.rm = TRUE)
        m_pool <- mean(v, na.rm = TRUE)
        med_pool <- stats::median(v, na.rm = TRUE)
        sd_v <- stats::sd(v, na.rm = TRUE)
        se_v <- sd_v / sqrt(length(v))
        iqr_v <- stats::IQR(v, na.rm = TRUE)
        mad_v <- stats::mad(v, na.rm = TRUE)
        cv_v <- if (abs(m_pool) > 1e-6) 100 * sd_v / abs(m_pool) else NA_real_
        rcvq_v <- if (abs(med_pool) > 1e-6) 100 * 0.75 * iqr_v / abs(med_pool) else NA_real_
        rcvm_v <- if (abs(med_pool) > 1e-6) 100 * mad_v / abs(med_pool) else NA_real_

        metric_val <- switch(
          consensus_dispersion,
          cv = cv_v,
          rcvq = rcvq_v,
          rcv_mad = rcvm_v,
          sd = sd_v,
          se = se_v,
          iqr = iqr_v,
          mad = mad_v,
          cv_v
        )
        spread_val <- switch(
          consensus_dispersion,
          cv = sd_v,
          sd = sd_v,
          se = se_v,
          rcvq = 0.5 * iqr_v,
          iqr = 0.5 * iqr_v,
          rcv_mad = mad_v,
          mad = mad_v,
          sd_v
        )
        lbl <- if (consensus_dispersion %in% c("cv", "rcvq", "rcv_mad")) {
          sprintf("%.0f%%", metric_val)
        } else {
          sprintf("%.1f", metric_val)
        }
        row_cv <- data.frame(
          mean_pct_of_control = m_cons,
          sd = sd_v,
          se = se_v,
          cv = cv_v,
          rcvq = rcvq_v,
          rcv_mad = rcvm_v,
          iqr = iqr_v,
          mad = mad_v,
          metric = consensus_dispersion,
          metric_value = metric_val,
          ymin = pmax(0, m_cons - spread_val),
          ymax = m_cons + spread_val,
          label = lbl,
          stringsAsFactors = FALSE
        )
        row_cv[[patient_column_name]] <- pid
        row_cv[[concentration_column_name]] <- cc
        row_cv[["marker_positivity"]] <- cons_mk
        cv_rows[[length(cv_rows) + 1]] <- row_cv
      }
    }
    if (length(cv_rows) > 0) {
      consensus_cv_df <- do.call(rbind, cv_rows)
      if (is.factor(plot_data[["marker_positivity"]])) {
        consensus_cv_df[["marker_positivity"]] <- factor(consensus_cv_df[["marker_positivity"]], levels = mk_vals)
      }
      p <- p + ggplot2::geom_errorbar(
        data = consensus_cv_df,
        ggplot2::aes(
          x = .data[[concentration_column_name]],
          ymin = .data[["ymin"]],
          ymax = .data[["ymax"]],
          color = .data[[patient_column_name]]
        ),
        inherit.aes = FALSE,
        width = 0.08,
        linewidth = 0.65,
        alpha = 0.85
      )
      if (show_cv && has_indiv) {
        cv_pill_rows <- list()
        disp_prefix <- switch(
          consensus_dispersion,
          cv = "CV",
          rcvq = "RCVQ",
          rcv_mad = "RCV",
          sd = "SD",
          se = "SE",
          iqr = "IQR",
          mad = "MAD",
          ""
        )
        for (cc_val in sort(unique(consensus_cv_df[[concentration_column_name]]))) {
          sub_cc <- consensus_cv_df[consensus_cv_df[[concentration_column_name]] == cc_val, , drop = FALSE]
          m_val <- mean(sub_cc[["metric_value"]], na.rm = TRUE)
          if (!is.finite(m_val)) next
          lbl_cc <- if (consensus_dispersion %in% c("cv", "rcvq", "rcv_mad")) {
            sprintf("%s %.0f%%", disp_prefix, m_val)
          } else {
            sprintf("%s %.1f", disp_prefix, m_val)
          }
          pill_row <- data.frame(
            label_y = max(sub_cc[["ymax"]], na.rm = TRUE) + 5.5,
            label = lbl_cc,
            stringsAsFactors = FALSE
          )
          pill_row[[concentration_column_name]] <- cc_val
          pill_row[["marker_positivity"]] <- sub_cc[["marker_positivity"]][1]
          cv_pill_rows[[length(cv_pill_rows) + 1]] <- pill_row
        }
        if (length(cv_pill_rows) > 0) {
          cv_pill_df <- do.call(rbind, cv_pill_rows)
          if (is.factor(plot_data[["marker_positivity"]])) {
            cv_pill_df[["marker_positivity"]] <- factor(cv_pill_df[["marker_positivity"]], levels = mk_vals)
          }
          p <- p + ggplot2::geom_label(
            data = cv_pill_df,
            ggplot2::aes(
              x = .data[[concentration_column_name]],
              y = .data[["label_y"]],
              label = .data[["label"]]
            ),
            inherit.aes = FALSE,
            size = 2.65,
            fontface = "bold",
            color = "#2e2d2a",
            fill = "#fcfcfb",
            alpha = 0.92,
            label.padding = ggplot2::unit(0.16, "lines"),
            label.r = ggplot2::unit(0.18, "lines"),
            show.legend = FALSE
          )
        }
      }
    }
  }

  ic50_table <- data.frame()
  points_50_list <- list()

  if (method == "loess" || method == "linear") {
    smooth_m <- if (method == "loess") "loess" else "lm"
    p <- p + ggplot2::geom_smooth(method = smooth_m, formula = y ~ x, se = FALSE, linewidth = 1.0)
    for (pid in unique(plot_data[[patient_column_name]])) {
      for (mk in mk_vals) {
        sub <- plot_data[plot_data[[patient_column_name]] == pid &
                           as.character(plot_data[["marker_positivity"]]) == as.character(mk), , drop = FALSE]
        agg <- stats::aggregate(sub[["pct_of_control"]], by = list(c = sub[[concentration_column_name]]), FUN = mean)
        if (nrow(agg) >= 2 && min(agg$x) <= 50 && max(agg$x) >= 50) {
          c50 <- tryCatch({
            if (log_scale_x) {
              10^stats::approx(x = agg$x, y = log10(agg$c), xout = 50)$y
            } else {
              stats::approx(x = agg$x, y = agg$c, xout = 50)$y
            }
          }, error = function(e) NA_real_)
          if (is.finite(c50)) {
            pt50 <- data.frame(ic50 = c50, y_ic50 = 50, stringsAsFactors = FALSE)
            pt50[[patient_column_name]] <- pid
            pt50[["marker_positivity"]] <- mk
            points_50_list[[length(points_50_list) + 1]] <- pt50
          }
        }
      }
    }
  } else if (method == "4pl") {
    curve_rows <- list()
    param_rows <- list()
    for (pid in unique(plot_data[[patient_column_name]])) {
      for (mk in mk_vals) {
        sub <- plot_data[plot_data[[patient_column_name]] == pid &
                           as.character(plot_data[["marker_positivity"]]) == as.character(mk), , drop = FALSE]
        res <- drugsens_fit_4pl_group(sub[[concentration_column_name]], sub[["pct_of_control"]])
        if (!is.null(res)) {
          c_df <- res$curve
          c_df[[concentration_column_name]] <- c_df$concentration
          c_df[[patient_column_name]] <- pid
          c_df[["marker_positivity"]] <- mk
          curve_rows[[length(curve_rows) + 1]] <- c_df

          p_df <- res$params
          p_df[[patient_column_name]] <- pid
          p_df[["marker_positivity"]] <- mk
          p_df[["is_consensus"]] <- if ("is_consensus" %in% colnames(sub)) {
            isTRUE(sub[["is_consensus"]][1])
          } else {
            grepl("^Consensus", as.character(mk)) || length(mk_vals) == 1
          }
          param_rows[[length(param_rows) + 1]] <- p_df
          points_50_list[[length(points_50_list) + 1]] <- p_df
        }
      }
    }
    if (length(curve_rows) > 0) {
      all_curves <- do.call(rbind, curve_rows)
      ic50_table <- do.call(rbind, param_rows)
      if (is.factor(plot_data[["marker_positivity"]])) {
        all_curves[["marker_positivity"]] <- factor(all_curves[["marker_positivity"]], levels = mk_vals)
        ic50_table[["marker_positivity"]] <- factor(ic50_table[["marker_positivity"]], levels = mk_vals)
      }
      p <- p + ggplot2::geom_line(
        data = all_curves,
        ggplot2::aes(
          x = .data[[concentration_column_name]],
          y = .data[["pct_of_control"]],
          color = .data[[patient_column_name]]
        ),
        inherit.aes = FALSE,
        linewidth = 1.05
      )
      if (show_ic50 && nrow(ic50_table) > 0 && !is_cell_death) {
        ic50_valid <- ic50_table[is.finite(ic50_table[["ic50"]]) & is.finite(ic50_table[["y_ic50"]]), , drop = FALSE]
        if (nrow(ic50_valid) > 0) {
          p <- p + ggplot2::geom_vline(
            data = ic50_valid,
            ggplot2::aes(xintercept = .data[["ic50"]], color = .data[[patient_column_name]]),
            linetype = "dotted",
            linewidth = 0.75,
            alpha = 0.85
          )
        }
      }
    }
  }

  # Bold 50% response point on curves that cross 50%
  if (!is_cell_death && length(points_50_list) > 0) {
    pts_50_df <- do.call(rbind, points_50_list)
    pts_50_df <- pts_50_df[is.finite(pts_50_df[["ic50"]]) & is.finite(pts_50_df[["y_ic50"]]), , drop = FALSE]
    if (nrow(pts_50_df) > 0) {
      if (is.factor(plot_data[["marker_positivity"]])) {
        pts_50_df[["marker_positivity"]] <- factor(pts_50_df[["marker_positivity"]], levels = mk_vals)
      }
      p <- p + ggplot2::geom_point(
        data = pts_50_df,
        ggplot2::aes(
          x = .data[["ic50"]],
          y = .data[["y_ic50"]],
          fill = .data[[patient_column_name]]
        ),
        inherit.aes = FALSE,
        shape = 21,
        size = 3.9,
        stroke = 1.25,
        color = "#0b0b0b"
      )
    }
  }

  n_facets <- length(unique(plot_data[["marker_positivity"]]))
  wrap_w <- if (n_facets == 1) 60 else 32
  facet_scales <- if ("is_consensus" %in% colnames(plot_data) ||
                        any(grepl("^Consensus", as.character(plot_data[["marker_positivity"]])))) {
    "fixed"
  } else {
    "free_y"
  }
  sub_txt <- if (is_cell_death) {
    "Dashed = 100% control baseline"
  } else {
    "Dashed = 100% baseline | Long-dash & bold ring = 50% response (IC50)"
  }
  if (nrow(consensus_cv_df) > 0 && any(!is_cons_vec)) {
    cv_tag <- if (n_patients > 1) paste0("mean ", toupper(consensus_dispersion)) else toupper(consensus_dispersion)
    sub_txt <- paste0(sub_txt, " | Consensus labels = ", cv_tag)
  }
  x_lab <- if (!is.null(conc_unit)) paste0("Concentration (", conc_unit, ")") else "Concentration"
  y_scale <- if (is_cell_death) {
    ggplot2::scale_y_continuous(
      breaks = function(lims) {
        b <- pretty(lims, 4)
        b <- b[b >= lims[1] & b <= lims[2] & abs(b - 100) > 8]
        sort(unique(c(b, if (lims[1] <= 100 && lims[2] >= 100) 100 else NULL)))
      },
      labels = function(y) paste0(round(y, 0), "%"),
      expand = ggplot2::expansion(mult = c(0.06, 0.15))
    )
  } else {
    ggplot2::scale_y_continuous(
      breaks = function(lims) {
        b <- pretty(lims, 4)
        b <- b[b >= lims[1] & b <= lims[2] & abs(b - 50) > 8]
        sort(unique(c(b, if (lims[1] <= 50 && lims[2] >= 50) 50 else NULL,
                      if (lims[1] <= 100 && lims[2] >= 100) 100 else NULL)))
      },
      labels = function(y) ifelse(round(y, 0) == 50, "50% (IC50)", paste0(round(y, 0), "%")),
      expand = ggplot2::expansion(mult = c(0.06, 0.15))
    )
  }
  p <- p +
    drugsens_scale("color", n_patients) +
    drugsens_scale("fill", n_patients) +
    ggplot2::facet_wrap(
      ~marker_positivity,
      scales = facet_scales,
      labeller = drugsens_wrap_labeller(wrap_w, strip_ratio_suffix = TRUE)
    ) +
    y_scale +
    ggplot2::labs(
      title = if (method == "4pl") "Dose response (4PL Hill fit)" else "Dose response",
      subtitle = sub_txt,
      x = x_lab,
      y = "Response (% of control)",
      color = "Patient",
      fill = "Patient"
    ) +
    drugsens_theme() +
    ggplot2::theme(
      panel.spacing.x = ggplot2::unit(1.4, "lines")
    )

  if (log_scale_x) {
    p <- p + ggplot2::scale_x_log10(
      labels = function(x) format(x, trim = TRUE, scientific = FALSE, drop0trailing = TRUE)
    )
  }
  if (method == "4pl") {
    attr(p, "ic50") <- ic50_table
    if ("is_consensus" %in% colnames(ic50_table)) {
      attr(p, "consensus_ic50") <- ic50_table[ic50_table[["is_consensus"]], , drop = FALSE]
    } else {
      attr(p, "consensus_ic50") <- ic50_table
    }
  }
  if (nrow(consensus_cv_df) > 0) {
    attr(p, "consensus_cv") <- consensus_cv_df
  }

  p
}

#' Plot a treatment by concentration heatmap of percent-of-control values
#' @description
#' Summarizes `normalize_to_control()` output into a treatment x concentration
#' heatmap of the mean percent-of-control value, a compact overview of an entire
#' dose response experiment across many drugs at once.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", a
#'   concentration column, and a treatment column).
#' @param concentration_column_name Column holding the drug concentration. Defaults
#'   to "Concentration1".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the heatmap. Defaults to "Control".
#' @param show_values Logical; whether to print the numeric mean `% of control`
#'   inside each heatmap tile. Defaults to `FALSE`.
#' @importFrom ggplot2 ggplot aes geom_tile geom_text facet_wrap labs scale_fill_gradientn
#' @importFrom stats aggregate
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", rep(c("DrugA", "DrugB"), each = 3)),
#'   Concentration1 = c(NA, NA, "1", "10", "100", "1", "10", "100"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 10, 8, 6, 4, 12, 14, 16)
#' )
#' normalized <- normalize_to_control(df)
#' plot_dose_response_heatmap(normalized)
plot_dose_response_heatmap <- function(.data,
                                       concentration_column_name = "Concentration1",
                                       treatment_column_name = "Treatment",
                                       control_treatment_name = "Control",
                                       show_values = FALSE) {
  required_cols <- c("pct_of_control", "marker_positivity", concentration_column_name,
                     treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  std <- drugsens_standardize_conc(plot_data, concentration_column_name)
  plot_data <- std$data
  conc_unit <- std$unit
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]

  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  summary_data <- stats::aggregate(
    plot_data[["pct_of_control"]],
    by = plot_data[c(treatment_column_name, concentration_column_name, "marker_positivity")],
    FUN = mean
  )
  colnames(summary_data)[colnames(summary_data) == "x"] <- "mean_pct_of_control"

  # Order concentrations numerically when possible
  conc_vals <- unique(as.character(summary_data[[concentration_column_name]]))
  conc_num <- suppressWarnings(as.numeric(conc_vals))
  if (!any(is.na(conc_num))) {
    ordered_levels <- conc_vals[order(conc_num)]
    summary_data[[concentration_column_name]] <- factor(
      summary_data[[concentration_column_name]],
      levels = ordered_levels
    )
  }

  x_lab <- if (!is.null(conc_unit)) paste0("Concentration (", conc_unit, ")") else "Concentration"
  wrap_w <- if (length(unique(summary_data[["marker_positivity"]])) == 1) 60 else 32
  p <- ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[concentration_column_name]],
    y = .data[[treatment_column_name]],
    fill = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_tile(color = "#fcfcfb", linewidth = 1) +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(wrap_w, strip_ratio_suffix = TRUE)) +
    ggplot2::scale_fill_gradientn(colors = drugsens_sequential_blue, name = "% of control") +
    ggplot2::scale_y_discrete(labels = function(x) drugsens_wrap_text(x, 16)) +
    ggplot2::labs(title = "Dose response overview", x = x_lab, y = "Treatment") +
    drugsens_theme()

  if (show_values) {
    val_rng <- range(summary_data[["mean_pct_of_control"]], na.rm = TRUE)
    norm_pos <- if (diff(val_rng) > 0) {
      (summary_data[["mean_pct_of_control"]] - val_rng[1]) / diff(val_rng)
    } else {
      rep(0.5, nrow(summary_data))
    }
    summary_data[["text_col"]] <- ifelse(norm_pos < 0.58, "#fcfcfb", "#0b0b0b")
    p <- p + ggplot2::geom_text(
      data = summary_data,
      ggplot2::aes(label = sprintf("%.0f%%", .data[["mean_pct_of_control"]])),
      color = summary_data[["text_col"]],
      size = 3.5,
      fontface = "bold"
    )
  }

  p
}

#' Plot a ranked summary of mean percent-of-control by treatment
#' @description
#' Summarizes `normalize_to_control()` output into one bar per treatment: the
#' mean percent-of-control value across all concentrations and replicates, with
#' a standard error bar, ranked from strongest to weakest effect. A quick way
#' to rank an entire drug panel by response.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity" and a
#'   treatment column).
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the summary. Defaults to "Control".
#' @param compare_to_control Logical; whether to compute and annotate p-values
#'   comparing each treatment against `control_treatment_name` per marker facet.
#'   Defaults to `FALSE`.
#' @param stat_method Statistical test used when `compare_to_control = TRUE`:
#'   `"wilcox"` (default) or `"t.test"`.
#' @param p_adjust_method Multiple-testing correction method passed to
#'   `stats::p.adjust()` across treatments within each marker facet. Supports
#'   `"BH"` (Benjamini-Hochberg FDR, default), `"bonferroni"`, `"holm"`, `"fdr"`,
#'   `"hochberg"`, `"hommel"`, `"BY"`, or `"none"`.
#' @param pvalue_label Format for p-value annotations: `"p.adj.signif"` (adjusted `*`,
#'   `**`, `***`, `ns`, default), `"p.signif"` (unadjusted), `"p.adj.format"`, or
#'   `"p.format"`.
#' @details
#' When multiple drug concentrations or imaged fields of view are present in `.data`,
#' `compare_to_control = TRUE` pools all normalized observations for each treatment
#' against `control_treatment_name` to test for an overall treatment effect across
#' the tested condition. To test specific concentrations individually without pooling
#' across doses, subset `.data` to a single concentration first or use
#' `get_QC_plots(..., x_plot_var = "Treatment_complete", compare_to_control = TRUE)`.
#' @importFrom ggplot2 ggplot aes geom_col geom_errorbar geom_hline geom_text
#'             facet_wrap labs coord_flip scale_y_continuous expansion
#' @importFrom stats aggregate sd reorder p.adjust p.adjust.methods
#' @return A `ggplot` object (with `attr(plot, "stats")` populated when `compare_to_control = TRUE`).
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 10, 4, 6, 14, 16)
#' )
#' normalized <- normalize_to_control(df)
#' plot_treatment_summary(normalized)
plot_treatment_summary <- function(.data,
                                   treatment_column_name = "Treatment",
                                   control_treatment_name = "Control",
                                   compare_to_control = FALSE,
                                   stat_method = c("wilcox", "t.test"),
                                   p_adjust_method = "BH",
                                   pvalue_label = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")) {
  stat_method <- match.arg(stat_method)
  p_adjust_method <- match.arg(p_adjust_method, stats::p.adjust.methods)
  pvalue_label <- match.arg(pvalue_label)

  required_cols <- c("pct_of_control", "marker_positivity", treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  standard_error <- function(x) stats::sd(x) / sqrt(length(x))
  group_cols <- plot_data[c(treatment_column_name, "marker_positivity")]

  summary_mean <- stats::aggregate(plot_data[["pct_of_control"]], by = group_cols, FUN = mean)
  colnames(summary_mean)[colnames(summary_mean) == "x"] <- "mean_pct_of_control"

  summary_se <- stats::aggregate(plot_data[["pct_of_control"]], by = group_cols, FUN = standard_error)
  colnames(summary_se)[colnames(summary_se) == "x"] <- "se_pct_of_control"

  summary_data <- merge(summary_mean, summary_se, by = c(treatment_column_name, "marker_positivity"))
  summary_data[["se_pct_of_control"]][is.na(summary_data[["se_pct_of_control"]])] <- 0
  summary_data[[treatment_column_name]] <- stats::reorder(
    summary_data[[treatment_column_name]], summary_data[["mean_pct_of_control"]]
  )

  wrap_w <- if (length(unique(summary_data[["marker_positivity"]])) == 1) 60 else 32
  p <- ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[treatment_column_name]],
    y = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_hline(yintercept = 100, color = "#c3c2b7", linetype = "dashed") +
    ggplot2::geom_col(fill = unname(drugsens_palette["blue"]), alpha = 0.9) +
    ggplot2::geom_errorbar(
      ggplot2::aes(
        ymin = .data[["mean_pct_of_control"]] - .data[["se_pct_of_control"]],
        ymax = .data[["mean_pct_of_control"]] + .data[["se_pct_of_control"]]
      ),
      width = 0.22, color = "#52514e", linewidth = 0.6
    ) +
    ggplot2::coord_flip() +
    ggplot2::facet_wrap(~marker_positivity, scales = "free_x", labeller = drugsens_wrap_labeller(wrap_w, strip_ratio_suffix = TRUE)) +
    ggplot2::scale_x_discrete(labels = function(x) drugsens_wrap_text(x, 16)) +
    ggplot2::labs(title = "Treatment summary", x = NULL, y = "Mean % of control") +
    drugsens_theme()

  if (compare_to_control) {
    pval_df <- drugsens_compare_to_control(
      data = .data,
      group_col = treatment_column_name,
      value_col = "pct_of_control",
      facet_col = "marker_positivity",
      control_name = control_treatment_name,
      method = stat_method,
      p_adjust_method = p_adjust_method,
      label_type = pvalue_label
    )
    attr(p, "stats") <- pval_df
    if (!is.null(pval_df) && nrow(pval_df) > 0) {
      merged_p <- merge(
        summary_data,
        pval_df[, c(treatment_column_name, "marker_positivity", "label"), drop = FALSE],
        by = c(treatment_column_name, "marker_positivity")
      )
      if (nrow(merged_p) > 0) {
        facet_max <- tapply(
          merged_p[["mean_pct_of_control"]] + merged_p[["se_pct_of_control"]],
          merged_p[["marker_positivity"]],
          max,
          na.rm = TRUE
        )
        merged_p[["label_y"]] <- merged_p[["mean_pct_of_control"]] + merged_p[["se_pct_of_control"]] +
          0.07 * as.vector(facet_max[as.character(merged_p[["marker_positivity"]])])
        p <- p +
          ggplot2::geom_text(
            data = merged_p,
            ggplot2::aes(x = .data[[treatment_column_name]], y = .data[["label_y"]], label = .data[["label"]]),
            inherit.aes = FALSE,
            color = "#0b0b0b",
            fontface = "bold",
            size = 3.5
          ) +
          ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = c(0.05, 0.20)))
      }
    }
  }

  p
}

#' Plot a patient by treatment heatmap of percent-of-control values
#' @description
#' Summarizes `normalize_to_control()` output into a patient x treatment heatmap
#' of the mean percent-of-control value (averaged across concentrations), a
#' cohort-level view of how every patient responded to every drug in the panel.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "pct_of_control", "marker_positivity", a patient
#'   column and a treatment column).
#' @param patient_column_name Column holding the patient ID. Defaults to "PID".
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @param control_treatment_name Value identifying control/vehicle wells, excluded
#'   from the heatmap. Defaults to "Control".
#' @param show_values Logical; whether to print the numeric mean `% of control`
#'   inside each heatmap tile. Defaults to `FALSE`.
#' @param compare_to_control Logical; whether to compute and annotate p-values
#'   comparing each treatment against `control_treatment_name` per patient and
#'   marker facet. Defaults to `FALSE`.
#' @param stat_method Statistical test used when `compare_to_control = TRUE`:
#'   `"wilcox"` (default) or `"t.test"`.
#' @param p_adjust_method Multiple-testing correction method passed to
#'   `stats::p.adjust()` across treatments within each patient and marker facet.
#'   Supports `"BH"` (default), `"bonferroni"`, `"holm"`, `"fdr"`, `"hochberg"`,
#'   `"hommel"`, `"BY"`, or `"none"`.
#' @param pvalue_label Format for p-value annotations: `"p.adj.signif"` (adjusted `*`,
#'   `**`, `***`, `ns`, default), `"p.signif"` (unadjusted), `"p.adj.format"`, or
#'   `"p.format"`.
#' @details
#' When multiple drug concentrations or imaged fields of view are present per patient,
#' `compare_to_control = TRUE` pools observations across doses and fields of view within
#' each patient and treatment against `control_treatment_name`. For dose-specific tests,
#' filter `.data` to a single concentration beforehand or use
#' `get_QC_plots(..., x_plot_var = "Treatment_complete", compare_to_control = TRUE)`.
#' @importFrom ggplot2 ggplot aes geom_tile geom_text facet_wrap labs scale_fill_gradientn theme
#'             element_text
#' @importFrom stats aggregate
#' @return A `ggplot` object (with `attr(plot, "stats")` populated when `compare_to_control = TRUE`).
#' @export
#' @examples
#' df <- data.frame(
#'   PID = rep(c("PID1", "PID2"), each = 4),
#'   Treatment = rep(c("Control", "DrugA"), 4),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 5, 10, 8, 12, 4, 12, 6)
#' )
#' normalized <- normalize_to_control(df)
#' plot_patient_heatmap(normalized)
plot_patient_heatmap <- function(.data,
                                 patient_column_name = "PID",
                                 treatment_column_name = "Treatment",
                                 control_treatment_name = "Control",
                                 show_values = FALSE,
                                 compare_to_control = FALSE,
                                 stat_method = c("wilcox", "t.test"),
                                 p_adjust_method = "BH",
                                 pvalue_label = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")) {
  stat_method <- match.arg(stat_method)
  p_adjust_method <- match.arg(p_adjust_method, stats::p.adjust.methods)
  pvalue_label <- match.arg(pvalue_label)

  required_cols <- c("pct_of_control", "marker_positivity", patient_column_name, treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  plot_data <- .data[.data[[treatment_column_name]] != control_treatment_name, ]
  plot_data <- plot_data[is.finite(plot_data[["pct_of_control"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No non-control rows with a finite pct_of_control were found to plot")
  }

  summary_data <- stats::aggregate(
    plot_data[["pct_of_control"]],
    by = plot_data[c(patient_column_name, treatment_column_name, "marker_positivity")],
    FUN = mean
  )
  colnames(summary_data)[colnames(summary_data) == "x"] <- "mean_pct_of_control"

  pval_all <- data.frame()
  if (compare_to_control) {
    p_rows <- list()
    for (pid in unique(.data[[patient_column_name]])) {
      sub_pid <- .data[.data[[patient_column_name]] == pid, , drop = FALSE]
      res_pid <- drugsens_compare_to_control(
        data = sub_pid,
        group_col = treatment_column_name,
        value_col = "pct_of_control",
        facet_col = "marker_positivity",
        control_name = control_treatment_name,
        method = stat_method,
        p_adjust_method = p_adjust_method,
        label_type = pvalue_label
      )
      if (!is.null(res_pid) && nrow(res_pid) > 0) {
        res_pid[[patient_column_name]] <- pid
        p_rows[[length(p_rows) + 1]] <- res_pid
      }
    }
    if (length(p_rows) > 0) {
      pval_all <- do.call(rbind, p_rows)
      summary_data <- merge(
        summary_data,
        pval_all[, c(patient_column_name, treatment_column_name, "marker_positivity", "label"), drop = FALSE],
        by = c(patient_column_name, treatment_column_name, "marker_positivity"),
        all.x = TRUE
      )
    }
  }

  wrap_w <- if (length(unique(summary_data[["marker_positivity"]])) == 1) 60 else 32
  p <- ggplot2::ggplot(summary_data, ggplot2::aes(
    x = .data[[treatment_column_name]],
    y = .data[[patient_column_name]],
    fill = .data[["mean_pct_of_control"]]
  )) +
    ggplot2::geom_tile(color = "#fcfcfb", linewidth = 1) +
    ggplot2::facet_wrap(~marker_positivity, labeller = drugsens_wrap_labeller(wrap_w, strip_ratio_suffix = TRUE)) +
    ggplot2::scale_fill_gradientn(colors = drugsens_sequential_blue, name = "% of control") +
    ggplot2::scale_x_discrete(labels = function(x) drugsens_wrap_text(x, 11)) +
    ggplot2::labs(title = "Patient response overview", x = "Treatment", y = "Patient") +
    drugsens_theme() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.5, size = ggplot2::rel(0.76)))

  if (show_values || (compare_to_control && "label" %in% colnames(summary_data))) {
    val_rng <- range(summary_data[["mean_pct_of_control"]], na.rm = TRUE)
    norm_pos <- if (diff(val_rng) > 0) {
      (summary_data[["mean_pct_of_control"]] - val_rng[1]) / diff(val_rng)
    } else {
      rep(0.5, nrow(summary_data))
    }
    summary_data[["text_col"]] <- ifelse(norm_pos < 0.58, "#fcfcfb", "#0b0b0b")
    has_p_lbl <- "label" %in% colnames(summary_data) && !all(is.na(summary_data[["label"]]))
    if (show_values && has_p_lbl) {
      summary_data[["tile_text"]] <- ifelse(
        !is.na(summary_data[["label"]]) & nzchar(summary_data[["label"]]),
        sprintf("%.0f%%\n(%s)", summary_data[["mean_pct_of_control"]], summary_data[["label"]]),
        sprintf("%.0f%%", summary_data[["mean_pct_of_control"]])
      )
    } else if (show_values) {
      summary_data[["tile_text"]] <- sprintf("%.0f%%", summary_data[["mean_pct_of_control"]])
    } else {
      summary_data[["tile_text"]] <- ifelse(is.na(summary_data[["label"]]), "", summary_data[["label"]])
    }
    p <- p + ggplot2::geom_text(
      data = summary_data,
      ggplot2::aes(label = .data[["tile_text"]]),
      color = summary_data[["text_col"]],
      size = 3.4,
      fontface = "bold",
      lineheight = 0.9
    )
  }
  if (nrow(pval_all) > 0) {
    attr(p, "stats") <- pval_all
  }

  p
}

#' Plot the raw values next to the normalized values, before and after
#' @description
#' Shows the raw marker ratio (before) side by side with the percent-of-control
#' value (after `normalize_to_control()`), one pair of panels per marker, so you
#' can see at a glance what control normalization did to the data.
#' @param .data Data frame that has been through `normalize_to_control()` on the
#'   long format (must contain "marker_positivity_ratio", "pct_of_control",
#'   "marker_positivity" and a treatment column).
#' @param treatment_column_name Column holding the treatment label. Defaults to "Treatment".
#' @importFrom ggplot2 ggplot aes geom_boxplot geom_jitter facet_wrap labs
#'             element_text element_blank
#' @return A `ggplot` object.
#' @export
#' @examples
#' df <- data.frame(
#'   PID = "PID1",
#'   Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
#'   marker_positivity = "cCASP3",
#'   marker_positivity_ratio = c(10, 12, 4, 6, 18, 20)
#' )
#' normalized <- normalize_to_control(df)
#' plot_normalization_before_after(normalized)
plot_normalization_before_after <- function(.data, treatment_column_name = "Treatment") {
  required_cols <- c("marker_positivity_ratio", "pct_of_control", "marker_positivity",
                     treatment_column_name)
  missing_cols <- setdiff(required_cols, colnames(.data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "),
         ". Please run change_data_format_to_longer() then normalize_to_control() first.")
  }

  before <- data.frame(
    treatment = .data[[treatment_column_name]],
    marker_positivity = .data[["marker_positivity"]],
    value = .data[["marker_positivity_ratio"]],
    stage = "Before (raw ratio)",
    stringsAsFactors = FALSE
  )
  after <- data.frame(
    treatment = .data[[treatment_column_name]],
    marker_positivity = .data[["marker_positivity"]],
    value = .data[["pct_of_control"]],
    stage = "After (% of control)",
    stringsAsFactors = FALSE
  )
  plot_data <- rbind(before, after)
  plot_data <- plot_data[is.finite(plot_data[["value"]]), ]
  if (nrow(plot_data) < 1) {
    stop("No rows with a finite value were found to plot")
  }

  plot_data[["facet_label"]] <- factor(
    paste(plot_data[["marker_positivity"]], plot_data[["stage"]], sep = " \u2014 "),
    levels = as.vector(t(outer(
      sort(unique(plot_data[["marker_positivity"]])),
      c("Before (raw ratio)", "After (% of control)"),
      paste, sep = " \u2014 "
    )))
  )

  n_treatments <- length(unique(plot_data[["treatment"]]))

  ggplot2::ggplot(plot_data, ggplot2::aes(
    x = .data[["treatment"]],
    y = .data[["value"]],
    fill = .data[["treatment"]],
    color = .data[["treatment"]]
  )) +
    ggplot2::geom_violin(trim = TRUE, alpha = 0.22, color = NA, width = 0.45) +
    ggplot2::geom_boxplot(width = 0.18, outlier.shape = NA, alpha = 0.45, linewidth = 0.6) +
    ggplot2::geom_jitter(width = 0.06, height = 0, alpha = 0.85, size = 2.0, shape = 21, color = "#fcfcfb", stroke = 0.35) +
    ggplot2::facet_wrap(~facet_label, ncol = 2, scales = "free_y", labeller = drugsens_wrap_labeller(28, strip_ratio_suffix = TRUE)) +
    drugsens_scale("fill", n_treatments) +
    drugsens_scale("color", n_treatments) +
    ggplot2::scale_x_discrete(labels = function(x) drugsens_wrap_text(x, 11)) +
    ggplot2::labs(title = "Effect of control normalization", x = NULL, y = NULL) +
    drugsens_theme() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = if (n_treatments >= 4) 28 else 0,
        hjust = if (n_treatments >= 4) 1 else 0.5,
        vjust = if (n_treatments >= 4) 1 else 0.5,
        size = ggplot2::rel(0.84),
        face = "bold"
      ),
      panel.grid.major.x = ggplot2::element_blank(),
      legend.position = "none"
    )
}
