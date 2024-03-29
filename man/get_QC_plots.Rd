% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_QC_plots.R
\name{get_QC_plots}
\alias{get_QC_plots}
\title{Plot some QC plots to define that everything ran correctly}
\usage{
get_QC_plots(
  .data,
  patient_column_name = "PID",
  colors = c("darkgreen", "red", "orange", "pink"),
  save_plots = FALSE,
  folder_name = "figures",
  x_plot_var = "Treatment_complete",
  isolate_a_specific_patient = NULL
)
}
\arguments{
\item{.data}{The preprocessed data (after running make_count_dataframe() and change_data_format_to_longer()) merged data.frame that should be visualized}

\item{patient_column_name}{The PID's column name in the merged data.frame (defaults to "PID")}

\item{colors}{A list of colors to supply to personalize the plot, as default 4 colors c("dark green", "red", "orange", "pink")}

\item{save_plots}{A Boolean value indicating if the plots should be saved or not, TRUE for saving in the current working directory, FALSE to not. Default is FALSE}

\item{folder_name}{A string indicating the name of the folder where to save the plots in case that save_plots = TRUE}

\item{x_plot_var}{A string indicating the treatment's full name for the QC plots (default is "Treatment_complete")}

\item{isolate_a_specific_patient}{A string indicating the patient name to isolate for single plot case (default is NULL)}
}
\value{
A \code{dataframe}/\code{tibble}.
}
\description{
Plot data to visualize immediate trends
}
