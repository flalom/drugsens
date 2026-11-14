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

test_that("Config creation and reading works without polluting .GlobalEnv", {
  if (exists("list_of_relabeling", envir = .GlobalEnv, inherits = FALSE)) {
    rm("list_of_relabeling", envir = .GlobalEnv)
  }
  temp_dir <- file.path(tempdir(), "drugsens_config_test")
  dir.create(temp_dir, recursive = TRUE, showWarnings = FALSE)
  on.exit({
    unlink(temp_dir, recursive = TRUE)
    make_run_config(overwrite_config = TRUE)
  }, add = TRUE)

  cfg_path <- make_run_config(forcePath = temp_dir)
  expect_true(file.exists(file.path(temp_dir, "config_drugsens.txt")))
  expect_equal(cfg_path, file.path(temp_dir, "config_drugsens.txt"))

  # Test re-running doesn't error and does not pollute .GlobalEnv
  expect_silent(make_run_config(forcePath = temp_dir))
  expect_false(exists("list_of_relabeling", envir = .GlobalEnv, inherits = FALSE))
  expect_type(drugsens:::.drugsens_env$list_of_relabeling, "list")
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

test_that("drugsens_theme and drugsens_palette are exported and valid", {
  expect_type(drugsens_palette, "character")
  expect_length(drugsens_palette, 8)
  th <- drugsens_theme()
  expect_s3_class(th, "theme")
})

test_that("plot_dose_response fits 4PL Hill curves and populates ic50 attribute accurately", {
  # Synthetic decreasing viability curve with bottom = 0, top = 100, IC50 = 5, hill = 1.5
  concs <- c(0.1, 1, 5, 10, 100)
  viab <- 100 / (1 + 10^((log10(concs) - log10(5)) * 1.5))
  df <- data.frame(
    PID = rep("P1", 12),
    Treatment = c("Control", "Control", rep("DrugA", 10)),
    Concentration1 = c(NA, NA, as.character(rep(concs, each = 2))),
    marker_positivity = "Viability",
    marker_positivity_ratio = c(1.0, 1.0, rep(viab / 100, each = 2))
  )
  normalized <- normalize_to_control(df)

  p <- plot_dose_response(normalized, method = "4pl", show_ic50 = TRUE)
  expect_s3_class(p, "ggplot")
  ic50_tbl <- attr(p, "ic50")
  expect_s3_class(ic50_tbl, "data.frame")
  expect_equal(nrow(ic50_tbl), 1)
  expect_true(ic50_tbl$ic50_reached)
  expect_true(ic50_tbl$converged)
  expect_equal(ic50_tbl$ic50, 5.0, tolerance = 0.05)

  # When 50% response is never reached (e.g. partial response 95% -> 70%), ic50 is NA
  df_unreached <- df
  df_unreached$marker_positivity_ratio <- c(1.0, 1.0, rep(c(0.95, 0.90, 0.82, 0.75, 0.72), each = 2))
  norm_unreached <- normalize_to_control(df_unreached)
  p_unreached <- plot_dose_response(norm_unreached, method = "4pl", show_ic50 = TRUE)
  ic50_unreached <- attr(p_unreached, "ic50")
  expect_false(ic50_unreached$ic50_reached)
  expect_true(is.na(ic50_unreached$ic50))
  expect_true(is.finite(ic50_unreached$ec50) && ic50_unreached$ec50 > 0)
})

test_that("plot_treatment_summary and get_QC_plots support compare_to_control", {
  df <- data.frame(
    PID = rep("P1", 9),
    Treatment = rep(c("Control", "DrugA", "DrugB"), each = 3),
    Treatment_complete = rep(c("Control", "DrugA10uM", "DrugB10uM"), each = 3),
    marker_positivity = "cCASP3",
    marker_positivity_ratio = c(0.10, 0.11, 0.09, 0.45, 0.48, 0.42, 0.12, 0.11, 0.10)
  )
  normalized <- normalize_to_control(df)

  p_sum <- plot_treatment_summary(
    normalized,
    compare_to_control = TRUE,
    stat_method = "t.test",
    p_adjust_method = "BH",
    pvalue_label = "p.adj.format"
  )
  expect_s3_class(p_sum, "ggplot")
  expect_true("p_adj" %in% colnames(attr(p_sum, "stats")))
  expect_equal(attr(p_sum, "stats")$p_adjust_method[1], "BH")

  p_qc <- get_QC_plots(
    df,
    isolate_a_specific_patient = "P1",
    compare_to_control = TRUE,
    stat_method = "t.test",
    p_adjust_method = "bonferroni"
  )
  expect_s3_class(p_qc, "ggplot")
  expect_true("p_adj" %in% colnames(attr(p_qc, "stats")))

  p_hm <- plot_patient_heatmap(
    normalized,
    show_values = TRUE,
    compare_to_control = TRUE,
    stat_method = "t.test",
    p_adjust_method = "BH"
  )
  expect_s3_class(p_hm, "ggplot")
  expect_true("p_adj" %in% colnames(attr(p_hm, "stats")))
})

test_that("normalize_to_control and plot_dose_response compute viability from dead_markers and viable_markers", {
  base_df <- data.frame(
    PID = rep("P1", 5),
    Treatment = c("Control", rep("Paclitaxel", 4)),
    Concentration1 = c(NA, "0.1", "1", "10", "100"),
    Rep = 1:5
  )
  casp <- base_df
  casp$marker_positivity <- "cCASP3_ratio_of_total_cells"
  casp$marker_positivity_ratio <- c(0.07, 0.10, 0.25, 0.45, 0.60)

  epcam <- base_df
  epcam$marker_positivity <- "EpCAM_E-Cadherin_ratio_of_total_cells"
  epcam$marker_positivity_ratio <- c(0.63, 0.60, 0.45, 0.25, 0.10)

  dapi <- base_df
  dapi$marker_positivity <- "onlyDAPIPositve_ratio_of_total_cells"
  dapi$marker_positivity_ratio <- rep(0.30, 5)

  screen_df <- rbind(casp, epcam, dapi)
  norm_v <- normalize_to_control(
    screen_df,
    dead_markers = "cCASP3",
    viable_markers = "EpCAM_E-Cadherin",
    control_treatment_name = "Control"
  )

  expect_equal(nrow(norm_v), 5)
  expect_equal(norm_v$total_target_cells_ratio, rep(0.70, 5))
  expect_equal(norm_v$viable_fraction[1], 0.90)
  expect_equal(norm_v$pct_of_control[1], 100)
  expect_true(all(diff(norm_v$pct_of_control) < 0))

  p_dr <- plot_dose_response(
    screen_df,
    dead_markers = "cCASP3",
    viable_markers = "EpCAM_E-Cadherin",
    selected_treatments = "Paclitaxel",
    method = "4pl",
    show_ic50 = TRUE
  )
  expect_s3_class(p_dr, "ggplot")
  expect_equal(nrow(attr(p_dr, "ic50")), 1)
  expect_equal(nrow(attr(p_dr, "consensus_ic50")), 1)

  # Multi-marker: 2 viable markers + 2 dead markers -> 2 individual panels + 1 consensus panel
  epcam2 <- epcam
  epcam2$marker_positivity <- "EpCAM_ratio_of_total_cells"
  ecad2 <- epcam
  ecad2$marker_positivity <- "E-Cadherin_ratio_of_total_cells"
  casp2 <- casp
  casp2$marker_positivity <- "cCASP3_ratio_of_total_cells"
  parp2 <- casp
  parp2$marker_positivity <- "cPARP_ratio_of_total_cells"

  multi_df <- rbind(epcam2, ecad2, casp2, parp2, dapi)
  p_multi <- plot_dose_response(
    multi_df,
    viable_markers = c("EpCAM", "E-Cadherin"),
    dead_markers = c("cCASP3", "cPARP"),
    selected_treatments = "Paclitaxel",
    method = "4pl",
    show_ic50 = TRUE,
    consensus_dispersion = "rcvq"
  )
  expect_s3_class(p_multi, "ggplot")
  expect_equal(nrow(attr(p_multi, "ic50")), 3)
  expect_equal(nrow(attr(p_multi, "consensus_ic50")), 1)
  expect_equal(as.character(attr(p_multi, "consensus_ic50")$marker_positivity), "Consensus Viability (Combined)")
  expect_true(all(c("cv", "rcvq", "rcv_mad", "sd", "se") %in% colnames(attr(p_multi, "consensus_cv"))))
})

test_that("string_parsing handles Omentum tissue, multi-capital single drugs, and Repotrectinib", {
  df <- data.frame(
    Image = c(
      "P1_Omentum_2024-02-13_DOC2024-02-01_Control_Rep_Ecad_(series 01).tif",
      "P1_Ascites_2024-02-13_DOC2024-02-01_AZD6738_10_uM_Rep_Ecad_(series 01).tif",
      "P1_Ascites_2024-02-13_DOC2024-02-01_Repotrectinib_5_uM_Ecad_(series 01).tif"
    ),
    stringsAsFactors = FALSE
  )
  parsed <- string_parsing(df)

  # Omentum should not trigger "um" in ConcentrationUnits1 when no dose exists
  expect_equal(parsed$Tissue[1], "Omentum")
  expect_true(is.na(parsed$Concentration1[1]))
  expect_true(is.na(parsed$ConcentrationUnits1[1]))
  expect_equal(parsed$ReplicaOrNot[1], "Replica")

  # Single drug with multiple capitals (AZD6738) and one dose should stay single-drug
  expect_equal(parsed$Treatment[2], "AZD6738")
  expect_equal(parsed$Concentration1[2], "10")
  expect_equal(parsed$ConcentrationUnits1[2], "uM")
  expect_true(is.na(parsed$Concentration2[2]))
  expect_equal(parsed$Treatment_complete[2], "AZD673810uM")
  expect_equal(parsed$ReplicaOrNot[2], "Replica")

  # "Rep" inside drug name Repotrectinib must not trigger ReplicaOrNot
  expect_equal(parsed$Treatment[3], "Repotrectinib")
  expect_true(is.na(parsed$ReplicaOrNot[3]))
  expect_equal(parsed$Treatment_complete[3], "Repotrectinib5uM")
})

test_that("make_count_dataframe preserves 4-decimal marker ratios", {
  synthetic <- data.frame(
    Name = c(rep("cCASP3", 4), rep("onlyDAPIPositve", 996)),
    filter_image = rep("P1_2024-01-01_2024-01-01_Ascites_series 01_Control_NA_NA_NA_NA_NA_Control", 1000),
    stringsAsFactors = FALSE
  )
  counts <- make_count_dataframe(synthetic)
  expect_equal(counts$sum_cells, 1000)
  expect_equal(counts$cCASP3_ratio_of_total_cells, 0.004)
})

test_that("normalize_to_control warns on zero or missing control per group and handles cell_death", {
  df_zero <- data.frame(
    PID = c("P1", "P1", "P2", "P2"),
    Treatment = c("Control", "DrugA", "Control", "DrugA"),
    value_ratio_of_total_cells = c(0, 10, 10, 20)
  )
  expect_warning(
    res_zero <- normalize_to_control(df_zero, value_columns = "value_ratio_of_total_cells"),
    "Missing, non-finite, or non-positive control mean"
  )
  expect_true(all(is.na(res_zero$value_ratio_of_total_cells_pct_of_control[res_zero$PID == "P1"])))
  expect_equal(res_zero$value_ratio_of_total_cells_pct_of_control[res_zero$PID == "P2"], c(100, 200))

  # Missing control for P2 when P1 has control
  df_miss <- data.frame(
    PID = c("P1", "P1", "P2"),
    Treatment = c("Control", "DrugA", "DrugA"),
    value_ratio_of_total_cells = c(10, 20, 15)
  )
  expect_warning(
    res_miss <- normalize_to_control(df_miss, value_columns = "value_ratio_of_total_cells"),
    "Missing, non-finite, or non-positive control mean"
  )
  expect_true(is.na(res_miss$value_ratio_of_total_cells_pct_of_control[res_miss$PID == "P2"]))

  # cell_death response metric with plot_dose_response omits IC50 vline/points
  base_df <- data.frame(
    PID = rep("P1", 5),
    Treatment = c("Control", rep("DrugA", 4)),
    Concentration1 = c(NA, "0.1", "1", "10", "100"),
    Rep = 1:5
  )
  cd_df <- rbind(
    transform(base_df, marker_positivity = "cCASP3_ratio_of_total_cells", marker_positivity_ratio = c(0.10, 0.15, 0.30, 0.50, 0.70)),
    transform(base_df, marker_positivity = "E-Cadherin_ratio_of_total_cells", marker_positivity_ratio = c(0.90, 0.85, 0.70, 0.50, 0.30))
  )
  p_cd <- plot_dose_response(
    cd_df,
    dead_markers = "cCASP3",
    viable_markers = "E-Cadherin",
    response_metric = "cell_death",
    method = "4pl",
    show_ic50 = TRUE
  )
  expect_s3_class(p_cd, "ggplot")
  expect_true(all(is.na(attr(p_cd, "ic50")$ic50)))
})

test_that("drugsens_compare_to_control and consensus_cv match exact numerical formulas", {
  ctrl <- c(100, 102, 98, 101)
  tr_a <- c(40, 42, 38, 44)
  tr_b <- c(95, 99, 97, 100)
  df <- data.frame(
    Treatment = c(rep("Control", 4), rep("DrugA", 4), rep("DrugB", 4)),
    marker_positivity = "Viability",
    pct_of_control = c(ctrl, tr_a, tr_b),
    stringsAsFactors = FALSE
  )

  stats_adj <- drugsens:::drugsens_compare_to_control(
    df, group_col = "Treatment", value_col = "pct_of_control",
    method = "t.test", p_adjust_method = "BH", label_type = "p.adj.format"
  )
  stats_raw <- drugsens:::drugsens_compare_to_control(
    df, group_col = "Treatment", value_col = "pct_of_control",
    method = "wilcox", p_adjust_method = "bonferroni", label_type = "p.format"
  )

  p_a_t <- stats::t.test(tr_a, ctrl)$p.value
  p_b_t <- stats::t.test(tr_b, ctrl)$p.value
  expect_equal(stats_adj$p_value, c(p_a_t, p_b_t), tolerance = 1e-12)
  expect_equal(stats_adj$p_adj, stats::p.adjust(c(p_a_t, p_b_t), method = "BH"), tolerance = 1e-12)
  expect_true(all(grepl("^padj", stats_adj$label)))

  p_a_w <- suppressWarnings(stats::wilcox.test(tr_a, ctrl, exact = FALSE)$p.value)
  p_b_w <- suppressWarnings(stats::wilcox.test(tr_b, ctrl, exact = FALSE)$p.value)
  expect_equal(stats_raw$p_value, c(p_a_w, p_b_w), tolerance = 1e-12)
  expect_equal(stats_raw$p_adj, stats::p.adjust(c(p_a_w, p_b_w), method = "bonferroni"), tolerance = 1e-12)
  expect_true(all(grepl("^p ", stats_raw$label)))

  # Exact dispersion check on consensus_cv
  base_df <- data.frame(
    PID = rep("P1", 5),
    Treatment = c("Control", rep("Paclitaxel", 4)),
    Concentration1 = c(NA, "0.1", "1", "10", "100"),
    Rep = 1:5
  )
  m_df <- rbind(
    transform(base_df, marker_positivity = "EpCAM_ratio_of_total_cells", marker_positivity_ratio = c(0.63, 0.60, 0.45, 0.25, 0.10)),
    transform(base_df, marker_positivity = "E-Cadherin_ratio_of_total_cells", marker_positivity_ratio = c(0.63, 0.55, 0.40, 0.20, 0.08)),
    transform(base_df, marker_positivity = "cCASP3_ratio_of_total_cells", marker_positivity_ratio = c(0.07, 0.10, 0.25, 0.45, 0.60)),
    transform(base_df, marker_positivity = "cPARP_ratio_of_total_cells", marker_positivity_ratio = c(0.07, 0.12, 0.28, 0.50, 0.62))
  )
  p_disp <- plot_dose_response(
    m_df,
    viable_markers = c("EpCAM", "E-Cadherin"),
    dead_markers = c("cCASP3", "cPARP"),
    selected_treatments = "Paclitaxel"
  )
  cv_tbl <- attr(p_disp, "consensus_cv")
  expect_true(nrow(cv_tbl) == 4)
  # Manually verify row 1 (dose 0.1): pair1 & pair2 pct_of_control
  norm_ind <- normalize_to_control(
    m_df, viable_markers = c("EpCAM", "E-Cadherin"),
    dead_markers = c("cCASP3", "cPARP"), selected_treatments = "Paclitaxel"
  )
  vals_01 <- norm_ind$pct_of_control[
    !norm_ind$is_consensus & !is.na(norm_ind$Concentration1) & norm_ind$Concentration1 == "0.1"
  ]
  expect_equal(cv_tbl$sd[1], stats::sd(vals_01), tolerance = 1e-12)
  expect_equal(cv_tbl$cv[1], 100 * stats::sd(vals_01) / abs(mean(vals_01)), tolerance = 1e-12)
  expect_equal(cv_tbl$rcvq[1], 100 * 0.75 * stats::IQR(vals_01) / abs(stats::median(vals_01)), tolerance = 1e-12)
  expect_equal(cv_tbl$rcv_mad[1], 100 * stats::mad(vals_01) / abs(stats::median(vals_01)), tolerance = 1e-12)
})



