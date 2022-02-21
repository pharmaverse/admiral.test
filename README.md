# admiral.test

Test data for the {admiral} package taken from the [CDISC pilot project](https://bitbucket.cdisc.org/projects/CED/repos/sdtm-adam-pilot-project/browse). 
As this mostly contains safety data only, over time we will extend this with adding further test data required such as for PK and TA-specific efficacy analyses.

# Installation

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("pharmaverse/admiral.test", ref = "main")
```
