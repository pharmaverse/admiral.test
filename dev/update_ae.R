# Update AE by adding AELAT variable for admiraloptha package

library(dplyr)
library(admiral.test)

# I had to load in date from console with data("admiral_ae") - Ben Straub
# raw_ae <- admiral_ae
# Save dataset ----
# save(raw_ae, file = "data/raw_ae.rda", compress = "bzip2")

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

attr(admiral_ae, "label") <- "Adverse Events"

# Save dataset ----
save(admiral_ae, file = "data/admiral_ae.rda", compress = "bzip2")
