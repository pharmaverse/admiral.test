# admiral.test

Test data for the `{admiral}` package taken from the [CDISC pilot project](https://github.com/cdisc-org/sdtm-adam-pilot-project) and renamed with `admiral_` prefix for clarity. 
As this mostly contains safety data only, we extend this as needed by adding further test data required such as for PK and TA-specific efficacy analyses.
See the "How To Update" section below for more details.

# Installation

The package is available from CRAN and can be installed by running `install.packages("admiral.test")`.

To install the latest development version of the package directly from GitHub use the following code:

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("pharmaverse/admiral.test", ref = "devel")
```

# How To Update

There are two main ways to extend the test data, either by adding new datasets or extending existing datasets with new records/variables.

## Adding New

- Add the output dataset name in `R/data.R` in the form `admiral_<name>`.
- Create a program at `inst/data_scripts` named `<name>.R` (e.g. `rs.R`) to generate the test data and output as `admiral_<name>`. Use CDISC pilot data such as `admiral_dm` as input in this program in order to create realistic synthetic data that remains consistent with other domains. Note that **no personal data should be used** as part of this package, even if anonymised.
- Add the output dataset to `data` folder
- Run `devtools::document()` and include the updated `NAMESPACE` and `.Rd` files in `man/`

## Updating Existing

- Rename the source dataset as `raw_<name>` (e.g. `raw_ds`) and reflect this change in `R/data.R`.
- Create a program at `inst/data_scripts` named `update_<name>.R` to read in `raw_<name>`, make the updates, and output as `admiral_<name>`.
- Add the output dataset to `data` folder
- Run `devtools::document()` and include the updated `NAMESPACE` and `.Rd` files in `man/`
