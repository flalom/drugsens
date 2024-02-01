![](https://img.shields.io/badge/R-%3E%3D%204.0.0-blue)

# Overview
Running DRUGSENS for QuPAth script with your project Here we provide the code to run a QuPath for a reproducible example. For more detailed examples please read [QuPath Documentation](https://qupath.readthedocs.io/en/stable/). This script should be placed into scripts within QuPath. We tested this code to a previous version of QuPath.

# Installation

``` r
devtools::install_gitlab("https://git.scicore.unibas.ch/ovca-research/drugsens")
# OR
devtools::install_github("https://github.com/flalom/drugsens") # this is the mirroring repo of the gitlab
```

`devtools` is required to install DRUGSENS. If `devtools` is not installed yet you can install it with:

``` r
# Install devtools from CRAN
install.packages("devtools")

# Or the development version from GitHub:
# install.packages("pak")
pak::pak("r-lib/devtools")
```

You can have a look at it [devtools]("https://github.com/r-lib/devtools")

# Usage

## Example

We recommend making a new project when working with `DRUGSENS`, to have clear and defined path. This will make the data analysis much easier and reproducible. 
You can also set you working directory with `setwd()`.

### QuPath script used

To make this code locally available:

``` r
library("DRUGSENS")
generate_qupath_script()
```

This function will generate a `script_for_qupath.txt` file with the code that one can copy/paste into the QuPath's script manager. All the sections that contain \<\> should be replaced with the user experimental information. The `columnsToInclude` in the script should also be user defined, depending on the markers used.

It is very important that the file naming structure QuPath's output is maintained for `DRUGSENS` to work correctly.

``` groovy
//This groovy snipped script was tested with QuPath 4

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
def columnsToInclude = new String[]{"Image", "Name", "Class","Centroid X µm","Centroid Y µm","Nucleus: Area", "Nucleus: DAPI mean","Nucleus: E-Cadherin mean", "Nucleus: Cleaved caspase 3 mean", "Cell: Area","Cell: E-Cadherin mean", "Cell: Cleaved caspase 3 mean","Cytoplasm: E-Cadherin mean","Cytoplasm: Cleaved caspase 3 mean","Nucleus/Cell area ratio"}

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
// example <USER_DEFINED_PATH>/B39_Ascites_2023.11.10_DOC2023.10.05_NIRAPARIB_1000_nM_Rep_EpCAM_Ecad_cCasp3_ QuPath will add (series 1) at the end of this line
// example <USER_DEFINED_PATH>/B39_Ascites_2023.11.10_DOC2023.10.05_NIRAPARIB_1000_nM_Rep_EpCAM_Ecad_cCasp3_(series 01).tif


// Create the measurementExporter and start the export
def exporter  = new MeasurementExporter()
        .imageList(imagesToExport)            // Images from which measurements will be exported
        .separator(separator)                 // Character that separates values
        .includeOnlyColumns(columnsToInclude) // Columns are case-sensitive
        .exportType(exportType)               // Type of objects to export
        .exportMeasurements(outputFile)       // Start the export process

print "Done!"
```

### Generate configuration file
This command will generate a `config_DRUGSENS.txt` that should be edited to include the names of the cell markers that have been used by the experimenter.
``` r
make_run_config()
```
Once the file `config_DRUGSENS.txt` has been modified; you can feed it back to `R`; by running the command again.
``` r
make_run_config()
```
Now the `list_of_relabeling` should be available in the R environment and it can be used by `DRUGSENS` to work. `list_of_relabeling` is a named list that is required for relabeling the markers name, that is often not user friendly. 
In case the markers naming doesn't need corrections/relabeling you can leave the `list_of_relabeling` unchanged.

> 📝**NOTE** It is recommended having no spaces and using camelCase style for the list of cell markers.
>
> - Start the name with a lowercase letter.
> - Do not include spaces or underscores between words.
> - Capitalize the first letter of each subsequent word.


### Explore example datasets

We present here a few mock datasets, as an example. Those can be explored from the folder

``` r
system.file("extdata/to_merge/", package = "DRUGSENS")
```

### Bind QuPath files

The example data can be bound together with this command:
``` r
bind_data <- data_binding(path_to_the_projects_folder = system.file("extdata/to_merge/", package = "DRUGSENS"), files_extension_to_look_for = "csv")
```
You will be now able to `View(bind_data)`. You should see all the images from the QuPath in one dataframe. This dataframe will have all the metadata parsed from the `Image` column (this is the first column defined in the in `columnsToInclude` within the `script_for_qupath.txt`).

### Counting the markers for every image
This function will take the previous step's generated dataframe and it will counts image by image for every sample the number of marker occurrences. This function will keep the metadata
``` r
counts_dataframe <- make_count_dataframe(bind_data)
```

### Making plotting-ready data
This function will change the wider format into longer format keeping all the metadata
``` r
plotting_ready_dataframe <- change_data_format_to_longer(counts_dataframe)
```
### Make a plot
Visualizing the results of the previous steps is essential to asses your experiment.
``` r
get_QC_plots(plotting_ready_dataframe, save_plots = TRUE, isolate_a_specific_patient = "B39")
```
<img src="assets/QC_plot.png" alt="QC Plot example" title="QC Plot example" width="500" height="500"/>
<br>

## Run with user's data

Let's run `DRUGSENS` with your data. `DRUGSENS` is not very strict about the capitalization of the file name but is very strict on the position of the parameters. This to avoid potential parsing problems. Here how the labeled data should look like in your QuPath generated file. Here below is shown a the first row from the file `A8759_drug1..conc2.csv` contained as example in `system.file("extdata/to_merge/", package = "DRUGSENS")`

```         
A8759_p.wash_2020.11.10_DOC2001.10.05_compoundX34542_10000_uM_EpCAM_Ecad_cCasp3_(series 01).tif
```

That follows the structure suggested in the QuPath script

```         
"<USER_DEFINED_PATH>/<PID>_<TISSUE>_',Sys.Date(),'_<SAMPLE_DOC>_<TREATMENT_INITIALS>_<CONCENTRATION>_<CONCENTRATION_UNITS>_<REPLICA_OR_NOT>_<TUMOR_MARKER>_<APOPTOTIC_MARKER>.csv"
```
> ⚠️ **WARNING**: It is highly recommended to follow the recommended naming structure to obtain the correct output

### Data Binding and Processing

These lines sets stage for `DRUGSENS` to find the directory path where the microscopy image data are located. `defined_path` is a predefined variable that should contain the base path. This makes it easier to access and manage the files during processing. It is convenient also to define the `desired_file_extensions_of_the_files`, usually `csv` is a good start.

``` r
defined_path <- "<USER_DEFINED_PATH>"
desired_file_extensions <- "csv"
```

You can then

``` r
bind_data <- data_binding(path_to_the_projects_folder = defined_path, 
files_extension_to_look_for = desired_file_extensions, recursive_search = FALSE)
```


> 📝**NOTE**It is recommended to run `data_binding()` with `recursive_search = FALSE` in the case that the target folder has subfolders that belong to other projects that use other cell markers. 

Each file is read, and additional metadata is extracted. This will return a dataframe of all the csv files within the folder merged with some additional parsing, the metadata is parsed from the file name will be retrieved and appended to the data. Metadata such as:

- **PID** = A unique identifier assigned to each sample. This ID helps in distinguishing and tracking individual samples' data throughout the experiment.
- **Date1** = The date on which the experiment or analysis was conducted. This field records when the data was generated or processed.
- **DOC** = The date when the biological sample was collected.
- **Tissue** = Indicates the type of tissue from which the sample was derived. This could be a specific organ or cell type
- **Image_number** = Represents the order or sequence number of the image in a stack of images
- **Treatment** = The name or type of drug treatment applied to the sample
- **Concentration** = The amount of the drug treatment applied (concentration), quantitatively described.
- **ConcentrationUnits** = The units in which the drug concentration is measured, such as micromolar (uM) or nanomolar (nM)
- **ReplicaOrNot** = Indicates whether the sample is a replica or repeat of a previous experiment
- **Name** = The standardized name of the cell markers as defined in the `config_DRUGSENS.txt` file. This ensures consistency and accuracy in identifying and referring to specific cell markers. 

### Cell markers counting

`make_count_dataframe()`, is designed for processing microscopy data stored in a dataframe. It counts occurrences of different markers present in the dataset and computes additional metadata based on unique identifiers within each row.

``` r
cell_markers_counts_data <- make_count_dataframe(bind_data)
```
- `.data`: The input dataframe containing microscopy data.
- `unique_name_row_identifier`: The name of the column in .data that contains unique identifiers for each row (default is "filter_image").
- `name_of_the_markers_column`: The name of the column in .data that contains the names of the markers (default is "Name").

> 📝**NOTE** `make_count_dataframe()` accepts directly the `bind_data` generated in the previous step, unless the fiels were modified, in that case the paramenters `unique_name_row_identifier` and `name_of_the_markers_column` should be passed to the function.

The data output will be a dataframe, with all the metadata coming from the previous preprocessing. At this point, you can you the data already, but you can additionally change the format from wider to longer. This is useful especially for plotting and more fine analysis.

### Prepare the data for plotting

`change_data_format_to_longer`, transforms count data from a wide format to a longer format, making it more suitable for certain types of analysis or visualization.
- `.data`: The input dataframe containing count data in a wide format, typically generated from microscopy data processing.
- `pattern_column_markers`: A pattern used to identify columns related to marker ratios (defaults to "_ratio_of_total_cells").
- `unique_name_row_identifier`: The name of the column in .data that contains unique identifiers for each image (defaults to "filter_image").
- `additional_columns`: A logical value indicating whether to include additional metadata columns in the longer format dataframe. It defaults to TRUE.
    
``` r
plotting_format <- change_data_format_to_longer(cell_markers_counts_data)
```


> 📝**NOTE** `change_data_format_to_longer()` accepts directly the `cell_markers_counts_data` generated in the previous step, unless the fiels were modified, in that case the paramenters `pattern_column_markers` and `unique_name_row_identifier` and `additional_columns` should be passed to the function.

This will return a dataframe that can be easily used for plotting and additional analyses.

### QC plotting

get_QC_plots, is designed for generating Quality Control (QC) plots from preprocessed microscopy data. It visualizes cell marker ratios across different treatments for each patient or a specific patient, aiding in the immediate assessment of data quality and trends.
Input Parameters:

``` r
get_QC_plots(plotting_format, isolate_a_specific_patient = "A8759", save_plots = T)
```
More parameters can be specified to personalize the plot(s).

- `.data`: The preprocessed and merged dataframe, expected to be in a long format, typically obtained after processing through make_count_dataframe() and change_data_format_to_longer().
- `patient_column_name`: Specifies the column in .data that contains patient identifiers (defaults to "PID").
- `colors`: A vector of colors for the plots. Defaults to c("darkgreen", "red", "orange", "pink").
- `save_plots`: A Boolean flag indicating whether to save the generated plots. If TRUE, plots are saved in the specified directory.
- `folder_name`: The name of the folder where plots will be saved if save_plots is TRUE. Defaults to "figures".
- `isolate_a_specific_patient`: If specified, QC plots will be generated for this patient only. Defaults to NULL, meaning plots will be generated for all patients.
- `x_plot_var`: The variable to be used on the x-axis, typically indicating different treatments. Defaults to "Treatment_complete".

## Contributing

We welcome contributions from the community! Here are some ways you can contribute:

- Reporting bugs
- Suggesting enhancements
- Submitting pull requests for bug fixes or new features

### Setting Up the Development Environment

To get started with development, follow these setup instructions:

<details>
<summary>Development Environment Setup</summary>

This project uses `renv` for R package management to ensure reproducibility. To set up your development environment:

1. Clone the repository to your local machine.
2. Open the project in RStudio or start an R session in the project directory.
3. Run `renv::restore()` to install the required R packages.

Renv will automatically activate and install the necessary packages as specified in the `renv.lock` file.

</details>

### Reporting Issues
If you encounter any bugs or have suggestions for improvements, please file an issue using our [GitLab]("https://git.scicore.unibas.ch/ovca-research/DRUGSENS/issues"). Be sure to include as much information as possible to help us understand and address the issue.

Please make sure to file the issue in gitlab as the GitHub is a mirror repo.
