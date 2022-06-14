# Add new variables to MH
library(dplyr)
library(tidyselect)
library(labelled)
library(admiral)
library(metatools)
library(admiral.test)

data("raw_mh")

# Convert blank to NA
mh <- convert_blanks_to_na(raw_mh)
set.seed(1)
ran_int <- sample.int(400, nrow(raw_mh), replace = TRUE)


admiral_mh <- mh %>%
  # Add MHENDTC
  mutate(MHENDTC = as.character(as.Date(MHSTDTC) + days(ran_int))) %>%
  # Add MHPRESP
  mutate(MHPRESP = ifelse(MHTERM == "ALZHEIMER'S DISEASE", "Y", NA_character_)) %>%
  # Add MHOCCUR
  mutate(MHOCCUR = case_when(MHPRESP == "Y" & !is.na(MHSTDTC) ~ "Y",
                             MHPRESP == "Y" & is.na(MHSTDTC) ~ "N",
                             MHPRESP == "N" ~ NA_character_)) %>%
  # Add MHSTTPT
  mutate(MHSTTPT = if_else(MHTERM == "ALZHEIMER'S DISEASE", NA_character_,
                           "SCREENING")) %>%
  # Add MHENTPT
  mutate(MHENTPT = if_else(MHTERM == "ALZHEIMER'S DISEASE", "SCREENING",
                           "FIRST DOSE OF STUDY DRUG")) %>%
  # variable labels
  add_labels(
    MHENDTC = "End Date/Time of Medical History Event",
    MHPRESP = "Medical History Event Pre-Specified",
    MHOCCUR = "Medical History Occurrence",
    MHSTTPT = "Start Reference Time Point",
    MHENTPT= "End Reference Time Point"
  )

attr(admiral_mh, "label") <- "Medical History"
save(admiral_mh, file = "data/admiral_mh.rda", compress = "bzip2")
