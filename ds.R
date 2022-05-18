# DS

#' Disposition Dataset
#'
#' A SDTM DS dataset from the CDISC pilot project
#'
#' @source \url{https://bitbucket.cdisc.org/projects/CED/repos/sdtm-adam-pilot-project/browse/updated-pilot-submission-package/900172/m5/datasets/cdiscpilot01/tabulations/sdtm/ds.xpt}
#' "ds"

library(dplyr)
library(labelled)
library(tidyselect)
library(admiral)
library(admiral.test)

set.seed(1)

# Reading input data
data("dm")
data("suppdm")

data("ds")
data("suppds")

# Converting blank to NA
dm <- convert_blanks_to_na(dm)
suppdm <- convert_blanks_to_na(suppdm)
ds <- convert_blanks_to_na(ds)
suppds <- convert_blanks_to_na(suppds)

# Creating full DS data
ds1 <- ds %>%
  derive_vars_suppqual(suppds)

# Creating RANDOMIZED records
dm1 <- select(dm, c(STUDYID, USUBJID, RFSTDTC)) %>%
  filter(!is.na(RFSTDTC)) %>%
  mutate(
    DSTERM = "RANDOMIZED",
    DSDECOD = "RANDOMIZED",
    DSCAT = "PROTOCOL MILESTONE",
    DSDTC = RFSTDTC,
    DSSTDTC = RFSTDTC,
    DOMAIN = "DS",
    DSSEQ = 1,
    VISIT = "BASELINE",
    VISITNUM = 3.0,
    DSSTDY = 1
  )

ds2 <- bind_rows(ds1, select(dm1, -c(RFSTDTC)))

# Adding labels
dslab <- var_label(ds1)
var_label(ds2) <- dslab

ds3 <- ds2 %>%
  arrange(STUDYID, USUBJID, DSSTDTC, DSCAT, DSDECOD) %>%
  group_by(STUDYID, USUBJID) %>%
  mutate(
    DSSEQ = row_number()
  )

# Creating SUPPDS
suppds1 <- select(ds3, c("STUDYID", "USUBJID", "DSSEQ", "DOMAIN", "ENTCRIT")) %>%
  filter(!is.na(ENTCRIT))

suppds2 <- rename(suppds1, "RDOMAIN" = "DOMAIN") %>%
  mutate(
    "IDVARVAL" = as.character(DSSEQ),
    "IDVAR" = "DSSEQ",
    "QVAL" = ENTCRIT,
    "QNAM" = "ENTCRIT",
    "QLABEL" = "PROTOCOL ENTRY CRITERIA NOT MET",
    "QORIG" = "CRF"
  )

suppds <- select(
  suppds2,
  c(
    STUDYID, RDOMAIN, USUBJID,
    IDVAR, IDVARVAL, QNAM, QLABEL,
    QVAL, QORIG
  )
)

suppds <- suppds %>% set_variable_labels(
  STUDYID = "Study Identifier",
  RDOMAIN = "Related Domain Abbreviation",
  USUBJID = "Unique Subject Identifier",
  IDVAR = "Identifying Variable",
  IDVARVAL = "Identifying Variable Value",
  QNAM = "Qualifier Variable Name",
  QLABEL = "Qualifier Variable Label",
  QVAL = "Data Value",
  QORIG = "Origin"
)

attr(suppds, "label") <- "Supplemental Disposition"

# Creating DS
dsnames <- names(ds)
ds <- select(ds3, all_of(dsnames))

attr(ds, "label") <- "Disposition"

save(ds, file = "data/admiral_ds.rda", compress = "bzip2")
save(suppds, file = "data/admiral_suppds.rda", compress = "bzip2")
