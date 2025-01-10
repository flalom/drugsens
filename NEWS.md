# drugsens Changelog

All notable changes to the drugsens project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial creation of the drugsens tool for analyzing drug sensitivity in cancer cell lines and cancer patients.
- Addition of `make_count_dataframe` function for counting cell marker expressions.
- Implementation of `change_data_format_to_longer` function to reformat data into a longer format for easier analysis.

### Changed
- Improved algorithm for more accurate cell marker detection.

### Deprecated
- None

### Removed
- None

### Fixed
- Bug fixes in data preprocessing to handle edge cases in input data.

### Security
- Enhanced data encryption for patient data storage and processing.

## [0.1.0] - 2024-01-01

### Added
- Launch of the first version of drugsens, providing functionalities for drug sensitivity analysis in translational research.
- Support for `.csv` files.
- Comprehensive metadata extraction from microscopy images, including patient ID, tissue type, and treatment details.
- Testing

### Changed
- Updated documentation to include detailed descriptions of metadata fields.

### Fixed
- Resolved issues with metadata extraction accuracy.

