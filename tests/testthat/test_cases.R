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
