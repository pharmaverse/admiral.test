# admiral.test 0.5.0
 - Updated AE to add variable AELAT for ophthalmology package (#99)
 - Updated TR, TU, RS for admiralonco package (#103):
     - tumor location `"LYMPH NODE"` added
     - TR test codes `"LDIAM"` and `"LPERP"` added
     - unscheduled visits added
     - incomplete assessments of target lesions added
 - Created SDTM SC dataset for ophthalmology package (#102)
 - Created SDTM OE dataset for ophthalmology package (#101)
 - Using {metatools} to add labels to datasets (#87)
 - `admiral.test` has SDTM data for [oncology](https://pharmaverse.github.io/admiralonco/main/index.html)
 and [ophthalmology](https://pharmaverse.github.io/admiralophtha/main/reference/index.html)
 
# admiral.test 0.4.0
 - Updated labels for pp and pc datasets (#77)
 - Updates to use `get_terms` and `basket_select` (#94)
 - Various updates to improve CI/CD workflows

# admiral.test 0.3.0
 - Updated README for instructions on installation, how to add and update to data (#53)
 - Adding new data to MH (#51)
 - Updates to percent differentials in LB (#52)
 - Implemented admiral CI/CD workflows (#50)

# admiral.test 0.2.0

- Renaming all datasets to `admiral_` (#30) 
- Extending the test data offering by adding PK datasets - PC and PP (#1) 
- Adding Oncology test data - RS, TU, TR, SUPPTR (#2)
- Adding SV from CDISC pilot project (#20)

# admiral.test 0.1.2

- CRAN release version with all comments resolved (#18)

# admiral.test 0.1.1

- Addressing CRAN comments (#16)

# admiral.test 0.1.0

- Test data for the {admiral} package taken from the CDISC pilot project - mainly safety data.
