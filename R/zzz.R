.onLoad <- function(libname, pkgname) {
  utils::globalVariables(c(
    "list_of_relabeling",
    "marker_positivity_ratio",
    "marker_positivity",
    "x",
    "y",
    "Name"
  ))
}

# ponytail: validated 8-hue categorical order (fixed, CVD-safe adjacency) and a
# single-hue sequential ramp, both internal so every plot in the package shares
# one look. Do not reorder or recolor per-call; add a new plot with its own
# scale_*_manual() call instead of overriding a slot here.
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
  "#cde2fb", "#9ec5f4", "#6da7ec", "#3987e5", "#256abf", "#184f95", "#0d366b"
)

drugsens_theme <- function(base_size = 15) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = "#fcfcfb", color = NA),
      panel.background = ggplot2::element_rect(fill = "#fcfcfb", color = NA),
      panel.grid.major = ggplot2::element_line(color = "#e1e0d9", linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      axis.line = ggplot2::element_line(color = "#c3c2b7"),
      axis.text = ggplot2::element_text(color = "#52514e", size = ggplot2::rel(0.95)),
      axis.title = ggplot2::element_text(color = "#0b0b0b", size = ggplot2::rel(1.1), face = "bold"),
      plot.title = ggplot2::element_text(color = "#0b0b0b", face = "bold", hjust = 0.5, size = ggplot2::rel(1.3)),
      plot.subtitle = ggplot2::element_text(color = "#52514e", hjust = 0.5, size = ggplot2::rel(1.05)),
      strip.background = ggplot2::element_rect(fill = "#f0efec", color = NA),
      strip.text = ggplot2::element_text(color = "#0b0b0b", face = "bold", size = ggplot2::rel(1.05)),
      legend.title = ggplot2::element_text(color = "#0b0b0b", face = "bold", size = ggplot2::rel(1.05)),
      legend.text = ggplot2::element_text(color = "#52514e", size = ggplot2::rel(0.95)),
      plot.margin = ggplot2::margin(t = 12, r = 16, b = 10, l = 10)
    )
}

# Wraps a long label (facet strip, legend key, or axis tick) onto multiple
# lines. Marker names use underscores instead of spaces, and treatment names
# are often camelCase ("GentamicinePaclitaxel100uM-10uM") with no separator at
# all, so plain whitespace-wrapping has nothing to break on; this inserts
# break points at underscores and at lower-to-upper camelCase transitions.
drugsens_wrap_text <- function(x, width = 18) {
  vapply(x, function(s) {
    s <- gsub("_", " ", s)
    s <- gsub("([a-z])([A-Z])", "\\1 \\2", s)
    paste(strwrap(s, width = width), collapse = "\n")
  }, character(1))
}

# Facet labeller built on drugsens_wrap_text(), for facet_wrap(labeller = ...).
drugsens_wrap_labeller <- function(width = 18) {
  ggplot2::as_labeller(function(x) drugsens_wrap_text(x, width))
}

# Manual discrete scale that falls back to ggplot2's default hues once the
# data has more levels than the validated palette provides for. Legend key
# text is wrapped the same way facet strips are, so long names never overrun
# the plot panel.
drugsens_scale <- function(aesthetic, values_needed, label_width = 20) {
  scale_fn <- if (aesthetic == "fill") ggplot2::scale_fill_manual else ggplot2::scale_color_manual
  if (values_needed <= length(drugsens_palette)) {
    scale_fn(values = unname(drugsens_palette), labels = function(x) drugsens_wrap_text(x, label_width))
  } else {
    NULL
  }
}
