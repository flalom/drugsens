test_that("Verify that the internal file in to_merge examples in exdata are available", {
  list_files_exdata <- system.file("extdata/to_merge/", package = "drugsens") |> list.files()
  expect_true(length(list_files_exdata) > 3)
})

test_that("Verify that the internal file examples in exdata merged are available", {
  list_files_exdata <- system.file("extdata/merged/", package = "drugsens") |> list.files()
  expect_true(length(list_files_exdata) >= 1)
})

test_that("list_all_files returns correct file paths", {
  # Setup: Create temporary files and directory
  temp_dir <- file.path(tempdir(), "drugsens_test")
  dir.create(temp_dir, recursive = TRUE, showWarnings = FALSE)
  on.exit(unlink(temp_dir, recursive = TRUE))

  file.create(file.path(temp_dir, "file1.csv"))
  file.create(file.path(temp_dir, "file2.csv"))
  file.create(file.path(temp_dir, "file3.txt"))
  file.create(file.path(temp_dir, "file4.tsv"))

  # Test CSV files
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.csv$",
                               recursive_search = TRUE)
  expect_length(files_list, 2)
  expect_true(all(grepl("file1.csv|file2.csv", files_list)))

  # Test TXT files
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.txt$",
                               recursive_search = TRUE)
  expect_length(files_list, 1)
  expect_true(all(grepl("file3.txt", files_list)))

  # Test TSV files
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.tsv$",
                               recursive_search = TRUE)
  expect_length(files_list, 1)
  expect_true(all(grepl("file4.tsv", files_list)))
})

test_that("Config creation and reading works", {
  temp_dir <- file.path(tempdir(), "drugsens_config_test")
  dir.create(temp_dir, recursive = TRUE, showWarnings = FALSE)
  on.exit(unlink(temp_dir, recursive = TRUE))

  make_run_config(forcePath = temp_dir)
  expect_true(file.exists(file.path(temp_dir, "config_drugsens.txt")))

  # Test re-running doesn't error
  expect_silent(make_run_config(forcePath = temp_dir))
  expect_true(exists("list_of_relabeling"))
})

test_that("Example file can be read correctly", {
  datas <- drugsens::data_binding(
    path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
  )
  expect_true(exists("datas"))
  expect_equal(ncol(datas), expected = 28)
})

test_that("Drug combinations have correct units and concentrations", {
  datas <- drugsens::data_binding(
    path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
  )

  # Test drug combination formatting
  combo_row <- datas[datas$Treatment == "GentamicinePaclitaxel", "Treatment_complete"][1]
  expect_true(combo_row == "GentamicinePaclitaxel100uM-10uM" ||
                combo_row == "gentamicinePaclitaxel100uM-10uM")

  # Test control formatting
  control_row <- datas[datas$Treatment == "Control", "Treatment_complete"][1]
  expect_true(control_row == "Control" || control_row == "control")
})

test_that("String parsing works correctly for single drug", {
  input_data <- data.frame(
    Image = "PID1_Tissue1_2024-02-13_DOC2024.02.13_TreatmentRana_10_uM_15_nm_Replica_(series.10)"
  )
  result <- drugsens::string_parsing(input_data)

  expect_equal(result$PID, "PID1")
  expect_equal(result$Tissue, "Tissue1")
  expect_equal(result$Date1, "2024-02-13")
  expect_equal(result$DOC, "2024.02.13")
  expect_equal(result$Treatment, "TreatmentRana")
  expect_equal(result$Concentration1, "10")
  expect_equal(result$ConcentrationUnits1, "uM")
  expect_equal(result$Treatment_complete, "TreatmentRana10uM-15nm")
})

test_that("make_count_dataframe returns ratio and grouping columns", {
  list_of_relabeling <- list("PathCellObject" = "onlyDAPIPositve")
  bind_data <- drugsens::data_binding(
    path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
  )
  counts <- drugsens::make_count_dataframe(bind_data)

  expect_true("sum_cells" %in% colnames(counts))
  expect_true(any(grepl("_ratio_of_total_cells$", colnames(counts))))
  expect_true(all(c("PID", "Treatment", "Concentration1") %in% colnames(counts)))
  expect_true("Control" %in% counts$Treatment)
})

test_that("change_data_format_to_longer pivots ratio columns", {
  list_of_relabeling <- list("PathCellObject" = "onlyDAPIPositve")
  bind_data <- drugsens::data_binding(
    path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens")
  )
  counts <- drugsens::make_count_dataframe(bind_data)
  longer <- drugsens::change_data_format_to_longer(counts)

  expect_true(all(c("marker_positivity", "marker_positivity_ratio") %in% colnames(longer)))
  n_ratio_cols <- sum(grepl("_ratio_of_total_cells$", colnames(counts)))
  expect_equal(nrow(longer), nrow(counts) * n_ratio_cols)
})

test_that("normalize_to_control expresses control rows as ~100%", {
  df <- data.frame(
    PID = rep("P1", 6),
    Treatment = c("Control", "Control", "Control", "DrugA", "DrugA", "DrugA"),
    value_ratio_of_total_cells = c(10, 10, 10, 5, 20, 40)
  )

  normalized <- normalize_to_control(df, value_columns = "value_ratio_of_total_cells")

  expect_true("value_ratio_of_total_cells_pct_of_control" %in% colnames(normalized))
  expect_equal(
    normalized$value_ratio_of_total_cells_pct_of_control[df$Treatment == "Control"],
    rep(100, 3)
  )
  expect_equal(
    normalized$value_ratio_of_total_cells_pct_of_control[df$Treatment == "DrugA"],
    c(50, 200, 400)
  )
})

test_that("normalize_to_control normalizes within each group_by_columns group", {
  df <- data.frame(
    PID = c("P1", "P1", "P2", "P2"),
    Treatment = c("Control", "DrugA", "Control", "DrugA"),
    value_ratio_of_total_cells = c(10, 20, 5, 5)
  )

  normalized <- normalize_to_control(df, value_columns = "value_ratio_of_total_cells")

  expect_equal(
    normalized$value_ratio_of_total_cells_pct_of_control,
    c(100, 200, 100, 100)
  )
})

test_that("normalize_to_control errors when no control rows are present", {
  df <- data.frame(
    PID = "P1",
    Treatment = "DrugA",
    value_ratio_of_total_cells = 5
  )

  expect_error(
    normalize_to_control(df, value_columns = "value_ratio_of_total_cells"),
    "No rows found"
  )
})

test_that("normalize_to_control auto-detects marker_positivity_ratio in long format", {
  df <- data.frame(
    PID = rep("P1", 4),
    Treatment = c("Control", "Control", "DrugA", "DrugA"),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 10, 20, 30)
  )

  normalized <- normalize_to_control(df)

  expect_true("pct_of_control" %in% colnames(normalized))
  expect_equal(normalized$pct_of_control, c(100, 100, 200, 300))
})

test_that("plot_dose_response returns a ggplot object", {
  df <- data.frame(
    PID = rep("P1", 4),
    Treatment = c("Control", "DrugA", "DrugA", "DrugA"),
    Concentration1 = c(NA, "1", "10", "100"),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 10, 20, 30)
  )
  normalized <- normalize_to_control(df)

  p <- plot_dose_response(normalized)
  expect_s3_class(p, "ggplot")
})

test_that("plot_dose_response errors on missing pct_of_control column", {
  df <- data.frame(
    PID = "P1", Treatment = "DrugA", Concentration1 = "1",
    marker_positivity = "cCASP3"
  )
  expect_error(plot_dose_response(df), "Missing required columns")
})

test_that("plot_dose_response_heatmap returns a ggplot object", {
  df <- data.frame(
    PID = "PID1",
    Treatment = c("Control", "Control", rep(c("DrugA", "DrugB"), each = 3)),
    Concentration1 = c(NA, NA, "1", "10", "100", "1", "10", "100"),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 10, 8, 6, 4, 12, 14, 16)
  )
  normalized <- normalize_to_control(df)

  p <- plot_dose_response_heatmap(normalized)
  expect_s3_class(p, "ggplot")
})

test_that("plot_dose_response_heatmap errors on missing pct_of_control column", {
  df <- data.frame(
    PID = "P1", Treatment = "DrugA", Concentration1 = "1",
    marker_positivity = "cCASP3"
  )
  expect_error(plot_dose_response_heatmap(df), "Missing required columns")
})

test_that("plot_treatment_summary ranks treatments by mean pct_of_control", {
  df <- data.frame(
    PID = "PID1",
    Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 10, 4, 6, 14, 16)
  )
  normalized <- normalize_to_control(df)

  p <- plot_treatment_summary(normalized)
  expect_s3_class(p, "ggplot")

  built <- ggplot2::ggplot_build(p)
  plot_data_levels <- levels(built$plot$data$Treatment)
  expect_equal(plot_data_levels, c("DrugA", "DrugB"))
})

test_that("plot_treatment_summary errors on missing pct_of_control column", {
  df <- data.frame(PID = "P1", Treatment = "DrugA", marker_positivity = "cCASP3")
  expect_error(plot_treatment_summary(df), "Missing required columns")
})

test_that("plot_patient_heatmap returns a ggplot object", {
  df <- data.frame(
    PID = rep(c("PID1", "PID2"), each = 4),
    Treatment = rep(c("Control", "DrugA"), 4),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 5, 10, 8, 12, 4, 12, 6)
  )
  normalized <- normalize_to_control(df)

  p <- plot_patient_heatmap(normalized)
  expect_s3_class(p, "ggplot")
})

test_that("plot_patient_heatmap errors on missing pct_of_control column", {
  df <- data.frame(PID = "P1", Treatment = "DrugA", marker_positivity = "cCASP3")
  expect_error(plot_patient_heatmap(df), "Missing required columns")
})

test_that("plot_normalization_before_after returns a ggplot object with before/after facets", {
  df <- data.frame(
    PID = "PID1",
    Treatment = c("Control", "Control", "DrugA", "DrugA", "DrugB", "DrugB"),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(10, 12, 4, 6, 18, 20)
  )
  normalized <- normalize_to_control(df)

  p <- plot_normalization_before_after(normalized)
  expect_s3_class(p, "ggplot")

  built <- ggplot2::ggplot_build(p)
  expect_equal(
    levels(built$plot$data$facet_label),
    c("cCASP3 \u2014 Before (raw ratio)",
      "cCASP3 \u2014 After (% of control)")
  )
})

test_that("plot_normalization_before_after errors on missing pct_of_control column", {
  df <- data.frame(
    PID = "P1", Treatment = "DrugA",
    marker_positivity = "cCASP3", marker_positivity_ratio = 5
  )
  expect_error(plot_normalization_before_after(df), "Missing required columns")
})

test_that("String parsing works correctly for DMSO control", {
  input_data <- data.frame(
    Image = "B516_Ascites_2023-11-25_DOC2020-12-14_dmso_rep_Ecad_cCasp3_(series 01).tif"
  )
  result <- drugsens::string_parsing(input_data)

  expect_equal(result$PID, "B516")
  expect_equal(result$Tissue, "Ascites")
  expect_equal(result$Date1, "2023-11-25")
  expect_equal(result$DOC, "2020-12-14")
  expect_equal(result$Treatment, "dmso")
  expect_true(is.na(result$Concentration1))
  expect_true(is.na(result$ConcentrationUnits1))
  expect_equal(result$Treatment_complete, "dmso")
})
