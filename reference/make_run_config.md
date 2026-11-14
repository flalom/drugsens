# Generates and loads a marker-relabeling configuration file

Generates a `config_drugsens.txt` file in
[`tempdir()`](https://rdrr.io/r/base/tempfile.html) (or in `forcePath`
when specified) defining `list_of_relabeling`, evaluates it into an
isolated local environment, and stores the relabeling map inside the
package's internal configuration environment without modifying
`.GlobalEnv`.

## Usage

``` r
make_run_config(overwrite_config = FALSE, forcePath = NULL)
```

## Arguments

- overwrite_config:

  Boolean; if TRUE an existing `config_drugsens.txt` will be overwritten
  with the default template (default is FALSE).

- forcePath:

  Optional directory path for `config_drugsens.txt`. Defaults to `NULL`,
  which uses [`tempdir()`](https://rdrr.io/r/base/tempfile.html).

## Value

Invisibly returns the path to the configuration file.

## Examples

``` r
# \donttest{
# Generate and load config in a temporary directory
make_run_config(forcePath = tempdir())
# }
```
