utils::globalVariables(c(
  "marker_positivity_ratio",
  "marker_positivity",
  "x",
  "y",
  "Name",
  ".data"
))

.drugsens_default_relabeling <- function() {
  list(
    "PathCellObject" = "onlyDAPIPositve",
    "cCasp3" = "cCASP3",
    "E-Cadherin: cCASP3" = "E-Cadherin and cCASP3",
    "EpCAM_E-Cadherin" = "E-Cadherin",
    "EpCAM_E-Cadherin and cCASP3" = "E-Cadherin and cCASP3"
  )
}

.drugsens_env <- new.env(parent = emptyenv())
.drugsens_env$list_of_relabeling <- .drugsens_default_relabeling()

.onLoad <- function(libname, pkgname) {
  .drugsens_env$list_of_relabeling <- .drugsens_default_relabeling()
}

#' Colorblind-safe categorical palette for drugsens plots
#'
#' An 8-color categorical palette ordered for high contrast and color-vision
#' deficiency (CVD) safety across adjacent levels.
#'
#' @format A named character vector of 8 hex color codes:
#'   `blue`, `orange`, `aqua`, `yellow`, `magenta`, `green`, `violet`, `red`.
#' @export
#' @examples
#' drugsens_palette
drugsens_palette <- c(
  blue    = "#2a78d6",
  orange  = "#eb6834",
  aqua    = "#1baf7a",
  yellow  = "#eda100",
  magenta = "#e87ba4",
  green   = "#008300",
  violet  = "#4a3aa7",
  red     = "#e34948"
)

drugsens_sequential_blue <- c(
  "#0d366b", "#184f95", "#256abf", "#3987e5", "#6da7ec", "#a6ccf6", "#deecfb"
)

#' Publication-ready ggplot2 theme for drugsens
#'
#' Applies a clean, warm-neutral background, subtle gridlines, bold facet strips,
#' and legible typography across all `drugsens` visualizations. Can also be added
#' to custom `ggplot2` plots.
#'
#' @param base_size Base font size in pts. Defaults to `14`.
#' @return A `ggplot2` theme object.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   drugsens_theme()
drugsens_theme <- function(base_size = 14) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = "#fcfcfb", color = NA),
      panel.background = ggplot2::element_rect(fill = "#fcfcfb", color = NA),
      panel.grid.major = ggplot2::element_line(color = "#e1e0d9", linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      axis.line = ggplot2::element_line(color = "#c3c2b7", linewidth = 0.4),
      axis.text = ggplot2::element_text(color = "#52514e", size = ggplot2::rel(0.92)),
      axis.title = ggplot2::element_text(color = "#0b0b0b", size = ggplot2::rel(1.05), face = "bold"),
      plot.title = ggplot2::element_text(color = "#0b0b0b", face = "bold", hjust = 0.5, size = ggplot2::rel(1.25)),
      plot.subtitle = ggplot2::element_text(color = "#52514e", hjust = 0.5, size = ggplot2::rel(1.0)),
      strip.background = ggplot2::element_rect(fill = "#f0efec", color = NA),
      strip.text = ggplot2::element_text(color = "#0b0b0b", face = "bold", size = ggplot2::rel(0.98)),
      legend.title = ggplot2::element_text(color = "#0b0b0b", face = "bold", size = ggplot2::rel(1.0)),
      legend.text = ggplot2::element_text(color = "#52514e", size = ggplot2::rel(0.92)),
      plot.margin = ggplot2::margin(t = 12, r = 16, b = 10, l = 10)
    )
}

# Wraps a long label (facet strip, legend key, or axis tick) onto multiple
# lines while preserving biological acronyms (e.g. cCASP3, EpCAM) and
# concentration units (e.g. 100uM, 1000nM).
drugsens_wrap_text <- function(x, width = 18, strip_ratio_suffix = FALSE) {
  vapply(as.character(x), function(s) {
    if (is.na(s) || !nzchar(s)) return(s)
    if (strip_ratio_suffix) {
      s <- gsub("_?ratio_of_total_cells", "", s)
      s <- gsub("\\s+ratio of total cells", "", s)
    }
    s <- gsub("_", " ", s)
    s <- gsub("onlyDAPIPositve|onlyDAPIPositive", "only DAPI+", s)
    s <- gsub("([a-z])([A-Z])", "\\1 \\2", s)
    s <- gsub("\\bc CASP", "cCASP", s)
    s <- gsub("\\bEp CAM\\b", "EpCAM", s)
    s <- gsub("(\\d+\\s*[munp])\\s+([Mm])\\b", "\\1\\2", s)
    s <- gsub("([A-Za-z])(\\d+[munp][Mm])", "\\1 \\2", s)
    paste(strwrap(s, width = width), collapse = "\n")
  }, character(1))
}

# Facet labeller built on drugsens_wrap_text(), for facet_wrap(labeller = ...).
drugsens_wrap_labeller <- function(width = 18, strip_ratio_suffix = TRUE) {
  ggplot2::as_labeller(function(x) drugsens_wrap_text(x, width, strip_ratio_suffix = strip_ratio_suffix))
}

# Manual discrete scale that uses drugsens_palette for up to 8 levels and
# falls back to a colorblind-safe Viridis palette for larger level counts.
drugsens_scale <- function(aesthetic, values_needed, label_width = 20) {
  if (!is.finite(values_needed) || values_needed < 1) return(NULL)
  scale_fn <- if (aesthetic == "fill") ggplot2::scale_fill_manual else ggplot2::scale_color_manual
  pal <- if (values_needed <= length(drugsens_palette)) {
    unname(drugsens_palette)[seq_len(values_needed)]
  } else {
    grDevices::hcl.colors(values_needed, palette = "Viridis")
  }
  scale_fn(values = pal, labels = function(x) drugsens_wrap_text(x, label_width))
}

# Format p-value into concise significance stars or p-value string
drugsens_format_pval <- function(p,
                                 label_type = c("p.adj.signif", "p.signif", "p.adj.format", "p.format"),
                                 is_adjusted = FALSE) {
  label_type <- match.arg(label_type)
  prefix <- if (is_adjusted || label_type %in% c("p.adj.signif", "p.adj.format")) "padj" else "p"
  vapply(p, function(val) {
    if (is.na(val) || !is.finite(val)) return("")
    if (label_type %in% c("p.signif", "p.adj.signif")) {
      if (val <= 0.001) "***"
      else if (val <= 0.01) "**"
      else if (val <= 0.05) "*"
      else "ns"
    } else {
      if (val < 0.001) paste0(prefix, " < 0.001")
      else sprintf("%s = %.3f", prefix, val)
    }
  }, character(1))
}

# Compute per-facet p-values comparing each treatment against a control group
drugsens_compare_to_control <- function(data,
                                        group_col,
                                        value_col,
                                        facet_col = "marker_positivity",
                                        control_name = "Control",
                                        method = c("wilcox", "t.test"),
                                        p_adjust_method = "BH",
                                        label_type = c("p.adj.signif", "p.signif", "p.adj.format", "p.format")) {
  method <- match.arg(method)
  p_adjust_method <- match.arg(p_adjust_method, stats::p.adjust.methods)
  label_type <- match.arg(label_type)
  facets <- unique(data[[facet_col]])
  out_list <- list()

  for (fc in facets) {
    sub <- data[data[[facet_col]] == fc & is.finite(data[[value_col]]), , drop = FALSE]
    ctrl_vals <- sub[[value_col]][sub[[group_col]] == control_name]
    if (length(ctrl_vals) < 2) next
    y_span <- diff(range(sub[[value_col]], na.rm = TRUE))
    if (!is.finite(y_span) || y_span == 0) y_span <- max(abs(sub[[value_col]]), 1, na.rm = TRUE) * 0.1
    y_pos <- max(sub[[value_col]], na.rm = TRUE) + 0.08 * y_span

    treatments <- setdiff(unique(sub[[group_col]]), control_name)
    fc_rows <- list()
    for (tr in treatments) {
      tr_vals <- sub[[value_col]][sub[[group_col]] == tr]
      if (length(tr_vals) < 2) next
      pval <- tryCatch({
        if (method == "wilcox") {
          suppressWarnings(stats::wilcox.test(tr_vals, ctrl_vals, exact = FALSE)$p.value)
        } else {
          suppressWarnings(stats::t.test(tr_vals, ctrl_vals)$p.value)
        }
      }, error = function(e) NA_real_)

      if (is.finite(pval)) {
        row_df <- data.frame(
          group = tr,
          y_pos = y_pos,
          p_value = pval,
          stringsAsFactors = FALSE
        )
        row_df[[facet_col]] <- fc
        row_df[[group_col]] <- tr
        fc_rows[[length(fc_rows) + 1]] <- row_df
      }
    }
    if (length(fc_rows) > 0) {
      fc_df <- do.call(rbind, fc_rows)
      fc_df[["p_adj"]] <- stats::p.adjust(fc_df[["p_value"]], method = p_adjust_method)
      fc_df[["p_adjust_method"]] <- p_adjust_method
      use_adj <- label_type %in% c("p.adj.signif", "p.adj.format")
      p_for_label <- if (use_adj) fc_df[["p_adj"]] else fc_df[["p_value"]]
      fc_df[["label"]] <- drugsens_format_pval(
        p_for_label,
        label_type = label_type,
        is_adjusted = use_adj && p_adjust_method != "none"
      )
      out_list[[length(out_list) + 1]] <- fc_df
    }
  }
  if (length(out_list) == 0) return(NULL)
  do.call(rbind, out_list)
}
