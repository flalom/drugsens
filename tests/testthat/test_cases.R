test_that("Verify that the internal file in to_merge examples in exdata are available", {
  list_files_exdata <- system.file("extdata/to_merge/", package = "drugsens") |> list.files()
  expect_true(length(list_files_exdata) > 3 )
})

test_that("Verify that the internal file examples in exdata merged are available", {
  list_files_exdata <- system.file("extdata/merged/", package = "drugsens") |> list.files()
  expect_true(length(list_files_exdata) >= 1 )
})

test_that("list_all_files returns correct file paths", {
  # Setup: Create temporary files and directory
  temp_dir <- tempdir()
  file.create(file.path(temp_dir, "file1.csv"))
  file.create(file.path(temp_dir, "file2.csv"))
  file.create(file.path(temp_dir, "file3.txt"))
  file.create(file.path(temp_dir, "file4.tsv"))

  # Test 1
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.csv$",
                               recursive_search = T)
  expect_length(files_list, 2)
  expect_true(all(grepl("file1.csv|file2.csv", files_list)))

  # Test 2
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.txt$",
                               recursive_search = T)
  expect_length(files_list, 1)
  expect_true(all(grepl("file3.txt", files_list)))

  # Test 3
  files_list <- list_all_files(define_path = temp_dir, extension = "\\.tsv$",
                               recursive_search = T)
  expect_length(files_list, 1)
  expect_true(all(grepl("file4.tsv", files_list)))

  # remove the dir
  unlink(temp_dir, recursive = TRUE)

})

test_that("Config creation and reading works", {
  temp_dir <- tempdir()
  on.exit(unlink(file.path(temp_dir, "config_drugsens.txt")))

  make_run_config(forcePath = temp_dir)
  make_run_config(forcePath = temp_dir)
  expect_true(file.exists(file.path(temp_dir, "config_drugsens.txt")))
  expect_true(exists("list_of_relabeling"))
})

test_that("Check that the example file can be read correctly", {
  datas <- drugsens::data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens"))
  expect_true(exists("datas"))
  expect_equal(ncol(datas), expected = 28)
})

test_that("Check that the drugs combination have two unit and two concentration and control none", {
  datas <- drugsens::data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/", package = "drugsens"))
  expect_true(datas[datas$Treatment == "GentamicinePaclitaxel", "Treatment_complete"][1] == "GentamicinePaclitaxel100uM-10uM" || datas[datas$Treatment == "GentamicinePaclitaxel", "Treatment_complete"][1] == "gentamicinePaclitaxel100uM-10uM")
  expect_true(datas[datas$Treatment == "Control", "Treatment_complete"][1] == "Control" || datas[datas$Treatment == "Control", "Treatment_complete"][1] == "control")
})

test_that("Config file was there and removed correctly", {
  expect_silent( file.remove(path.expand(paste0(getwd(), "/config_drugsens.txt"))) )
})


test_that("The parsing is working", {
  input_data <- data.frame(Image = "PID1_Tissue1_2024-02-13_DOC2024.02.13_TreatmentRana_10_uM_15_nm_Replica_(series.10)")
  expected_output <- data.frame(
                                Image = "PID1_Tissue1_2024-02-13_DOC2024.02.13_TreatmentRana_10_uM_15_nm_Replica_(series.10)",
                                Image_number = "series.10",
                                PID = "PID1",
                                Tissue = "Tissue1",
                                Date1 = "2024-02-13",
                                DOC = "2024.02.13",
                                ReplicaOrNot = "Replica",
                                Treatment = "TreatmentRana",
                                Concentration1 = "10",
                                Concentration2 = "15",
                                ConcentrationUnits1 = "uM",
                                ConcentrationUnits2 = "nm",
                                Treatment_complete = "TreatmentRana10uM-15nm")
  expect_equal(drugsens::string_parsing(input_data), expected = expected_output)
})

test_that("Another parsing test", {
  input_data <- data.frame(Image = "B516_Ascites_2023-11-25_DOC2020-12-14_dmso_rep_Ecad_cCasp3_(series 01).tif")
  expected_output <- data.frame(
    Image = "B516_Ascites_2023-11-25_DOC2020-12-14_dmso_rep_Ecad_cCasp3_(series 01).tif",
    Image_number = "series 01",
    PID = "B516",
    Tissue = "Ascites",
    Date1 = "2023-11-25",
    DOC = "2020-12-14",
    ReplicaOrNot = "Replica",
    Treatment = "dmso",
    Concentration1 = NA_character_, #WIP
    Concentration2 = NA_integer_,
    ConcentrationUnits1 = NA_character_,
    ConcentrationUnits2 = NA_character_,
    Treatment_complete = "dmso")
  expect_equal(drugsens::string_parsing(input_data), expected = expected_output)
  #   Image1 <- "B516_Ascites_2023-11-25_DOC2020-12-14_CarboplatinPaclitaxel_100_uM_10_nM_Ecad_cCasp3_(series 01).tif"
  #   Image2 <- "A8759_Spleen_2020.11.10_DOC2001.10.05_compoundX34542_1000_uM_EpCAM_Ecad_cCasp3_(series 01).tif"
  #   Image3 <- "A8759_Spleen_2020.11.10_DOC2001.10.05_compoundX34542_1000_uM_EpCAM_Ecad_cCasp3_(series 01).tif"
  #   Image4 <- "B38_Eye_2023.11.10_DOC2023.10.05_GentamicinePaclitaxel_100_uM_10_nM_EpCAM_Ecad_cCasp3_(series 01).tif"
})

