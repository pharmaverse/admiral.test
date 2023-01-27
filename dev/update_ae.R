# Update AE by adding AELAT variable for admiraloptha package

library(dplyr)
library(admiral.test)
library(admiral)

data("admiral_ae")

raw_ae <- admiral_ae


data("raw_ae")
ae <- convert_blanks_to_na(raw_ae)

# create possible AELAT values - as collected on CRF ----
lat <- c("LEFT", "RIGHT", "BOTH")

# create AELAT variable ----
# with random assignment of lat values where AESOC is "EYE DISORDERS"
# Set seed so that result stays the same for each run
set.seed(1)
ae$AELAT <- if_else(ae$AESOC == "EYE DISORDERS",
                apply(ae, 1, function(x) sample(lat, 1)),
                NA_character_
                )
admiral_ae <- ae
attr(admiral_mh, "label") <- "Adverse Events"

# Save dataset ----
saveRDS(admiral_ae, "data/admiral_ae.rda", compress = "bzip2")
