# admiraltest

Test data for the {admiral} package taken from the [CDISC pilot project](https://github.com/cdisc-org/sdtm-adam-pilot-project). 
As this mostly contains safety data only, over time we will extend this with adding further test data required such as for PK and TA-specific efficacy analyses.

# Installation

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("pharmaverse/admiraltest", ref = "main")
```
