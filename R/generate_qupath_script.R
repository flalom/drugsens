#' Generate the groovy script used for the analysis
#' @description
#' Generate a useful script to consistently save the output data from QuPath in .csv format following the naming conventions
#' followed during the package development.
#' @param output_dir Directory where the script should be saved. If NULL, uses tempdir()
#' @return Invisibly returns the path to the generated script file.
#' @export
#' @examples
#' \dontrun{
#'   # Generate script in a temporary directory
#'   generate_qupath_script()
#'
#'   # Generate script in a specific directory
#'   output_dir <- tempdir()
#'   generate_qupath_script(output_dir = output_dir)
#' }
generate_qupath_script <- function(output_dir = NULL) {
  if(is.null(output_dir)) {
    output_dir <- tempdir()
  }
  output_file <- file.path(output_dir, "script_for_qupath.txt")

  write(
    x = paste0('
//This code script was tested with QuPath 4

import qupath.lib.gui.tools.MeasurementExporter
import qupath.lib.objects.PathCellObject
import qupath.lib.objects.PathDetectionObject

// Get the list of all images in the current project
def project = getProject()
def imagesToExport = project.getImageList()

// Separate each measurement value in the output file with a tab ("\t")
def separator = ","

// Choose the columns that will be included in the export
// Note: if columnsToInclude is empty, all columns will be included
def columnsToInclude = new String[]{"Image", "Name", "Class","Centroid X um","Centroid Y um","Nucleus: Area", "Nucleus: DAPI mean","Nucleus: E-Cadherin mean", "Nucleus: Cleaved caspase 3 mean", "Cell: Area","Cell: E-Cadherin mean", "Cell: Cleaved caspase 3 mean","Cytoplasm: E-Cadherin mean","Cytoplasm: Cleaved caspase 3 mean","Nucleus/Cell area ratio"}

// Choose the type of objects that the export will process
// Other possibilities include:
//    1. PathAnnotationObject
//    2. PathDetectionObject
//    3. PathRootObject
// Note: import statements should then be modified accordingly
def exportType = PathCellObject.class

// Choose your *full* output path
def outputPath = "<USER_DEFINED_PATH>/<PID>_<TISSUE>_',Sys.Date(),'_<SAMPLE_DOC>_<TREATMENT_INITIALS>_<CONCENTRATION>_<CONCENTRATION_UNITS>_<REPLICA_OR_NOT>_<TUMOR_MARKER>_<APOPTOTIC_MARKER>.csv"
def outputFile = new File(outputPath)
// example <USER_DEFINED_PATH>/B39_Ascites_2023.11.10_DOC2023.10.05_Niraparib_1000_nM_Rep_EpCAM_Ecad_cCasp3_ QuPath will add (series 1) at the end of this line
// example <USER_DEFINED_PATH>/B39_Ascites_2023.11.10_DOC2023.10.05_Niraparib_1000_nM_Rep_EpCAM_Ecad_cCasp3_(series 01).tif
// the part EpCAM_Ecad_cCasp3_ is optional but recommended

// Create the measurementExporter and start the export
def exporter  = new MeasurementExporter()
        .imageList(imagesToExport)            // Images from which measurements will be exported
        .separator(separator)                 // Character that separates values
        .includeOnlyColumns(columnsToInclude) // Columns are case-sensitive
        .exportType(exportType)               // Type of objects to export
        .exportMeasurements(outputFile)       // Start the export process

print "Done!"
      '),
    file = output_file
  )
  message("You can now take the script and personalize it to your needs")
  message(paste0(Sys.time(), " The script file was generated here: ", output_file, "/"))
  message(paste0(Sys.time(), " Please make sure to follow the name convention here proposed, or it might fail to get all the information"))
}
