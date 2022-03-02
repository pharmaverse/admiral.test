#TU

library(haven)
library(dplyr)
library(admiral)
library(admiral.test)

# Reading input data  --  DUMMY DATA CREATED FROM TR data created from TR
data("tr")
data("supptr")

tr <- convert_blanks_to_na(tr)
supptr <- convert_blanks_to_na(supptr)

supptr1 <- supptr %>%
  mutate("DOMAIN" = RDOMAIN, TRSEQ = as.numeric(IDVARVAL), "TRLOC" = QVAL) %>%
  select(., c(STUDYID, USUBJID, TRSEQ, TRLOC))

tr <- full_join(tr, supptr1, by = c("STUDYID", "USUBJID", "TRSEQ"))

# Renaming And Adding TU Variables
tu1 <- tr %>%
  filter((VISITNUM == 3 | (TRGRPID == "NEW" &
    !is.na(TRORRES) & TRORRES != "NO"))) %>%
  filter(TRTESTCD != "SUMDIAM") %>%
  rename(
    "TULNKID" = "TRLNKID",
    "TUMETHOD" = "TRMETHOD",
    "TUSEQ" = "TRSEQ",
    "TUEVAL" = "TREVAL",
    "TUEVALID" = "TREVALID",
    "TUDTC" = "TRDTC",
    "TUDY" = "TRDY",
    "TULOC" = "TRLOC",
    "TUACPTFL" = "TRACPTFL"
  ) %>%
  mutate(
    "TUTESTCD" = "TUMIDENT",
    "TUTEST" = "Tumor Identification",
    "TUORRES" = TRGRPID,
    "TUSTRESC" = TUORRES
  )

# TUSEQ
tu2 <- tu1 %>%
  arrange(STUDYID, USUBJID, VISITNUM, TUDTC, TULNKID) %>%
  group_by(STUDYID, USUBJID) %>%
  mutate(TUSEQ = row_number())

# Creating TU
tu <- select(tu2, c(
  STUDYID, DOMAIN, USUBJID, TUSEQ, TULNKID,
  TUTESTCD, TUTEST, TUORRES, TUSTRESC, TULOC,
  TUMETHOD, TUEVAL, TUEVALID, TUACPTFL,
  VISITNUM, VISIT, TUDTC, TUDY
))

save(tu, file = "data/tu.rda", compress = "bzip2")
