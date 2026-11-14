# Publication-ready ggplot2 theme for drugsens

Applies a clean, warm-neutral background, subtle gridlines, bold facet
strips, and legible typography across all `drugsens` visualizations. Can
also be added to custom `ggplot2` plots.

## Usage

``` r
drugsens_theme(base_size = 14)
```

## Arguments

- base_size:

  Base font size in pts. Defaults to `14`.

## Value

A `ggplot2` theme object.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  drugsens_theme()
```
