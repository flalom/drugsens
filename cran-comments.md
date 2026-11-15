## Resubmission
This is a resubmission of drugsens 0.2.0 addressing the incoming CRAN pretest checks:

* Fixed the HTML manual validation problem in `man/normalize_to_control.Rd` where `<column>` inside `<column>_pct_of_control` was unescaped in the roxygen `@return` tag and emitted as a raw HTML tag.
* Confirmed maintainer email update: I have changed my maintainer email from my former institutional address (`flavio.lombardo@unibas.ch`) to my permanent personal address (`fl@flaviolombardo.site`). I am the same author and maintainer (Flavio Lombardo, ORCID 0000-0002-4853-6838) and no longer have access to the former institutional mailbox.

## Test environments
* local macOS arm64 (aarch64-apple-darwin23), R 4.6.1
* R-hub / GitHub Actions (ubuntu-latest, R-release)

## R CMD check results

0 errors | 0 warnings | 0 notes

* Maintainer email update: I have updated my maintainer email address from my former institutional address to my permanent personal address (<fl@flaviolombardo.site>). I am the same author and maintainer (Flavio Lombardo, ORCID 0000-0002-4853-6838) and no longer use my former institutional email.
* This is a minor feature and documentation update (0.2.0) adding control normalization (`normalize_to_control()`), dose-response and cohort visualization functions (`plot_dose_response()`, `plot_dose_response_heatmap()`, `plot_treatment_summary()`, `plot_patient_heatmap()`, `plot_normalization_before_after()`, `drugsens_theme()`, `drugsens_palette`), and four tutorial vignettes.
