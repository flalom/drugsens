test_that("Verify that the internal file in to_merge examples in exdata are available", {
  list_files_exdata <- system.file("extdata/to_merge/", package = "DRUGSENS") |> list.files()
  expect_true(length(list_files_exdata) > 3 )
})

test_that("Verify that the internal file examples in exdata merged are available", {
  list_files_exdata <- system.file("extdata/merged/", package = "DRUGSENS") |> list.files()
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

test_that("Check that the config.txt is made and can be read", {
  expect_silent(make_run_config())
  expect_silent(make_run_config())
  expect_true(exists("list_of_relabeling"))
})

# WIP add for the regex in processing the data
# test_that("Check that parsig does work", {
#
#   Image1 <- "B516_Ascites_2023-11-25_DOC2020-12-14_CarboplatinPaclitaxel_100_uM_10_nM_Ecad_cCasp3_(series 01).tif"
#   Image2 <- "A8759_Spleen_2020.11.10_DOC2001.10.05_compoundX34542_1000_uM_EpCAM_Ecad_cCasp3_(series 01).tif"
#   Image3 <- "A8759_Spleen_2020.11.10_DOC2001.10.05_compoundX34542_1000_uM_EpCAM_Ecad_cCasp3_(series 01).tif"
#   Image4 <- "B38_Eye_2023.11.10_DOC2023.10.05_GentamicinePaclitaxel_100_uM_10_nM_EpCAM_Ecad_cCasp3_(series 01).tif"
#
#   # make a dataframe of those images examples
#   dt <- data.frame(
#     Image = c(Image1, Image2, Image3, Image4),
#     Example = c("Protocol", "Fake", "Fake", "Fake")
#   )
#
#   # run parser
#   dt1 <- DRUGSENS:::string_parsing(dt)
#
#   expect_true(exists("list_of_relabeling"))
# })
