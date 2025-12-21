# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: biochar scenario runs
# --------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "BC_rev01"

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))





### biochar settings
cfg$gms$biochar <- "dec24"
cfg$gms$c63_biochar_simulation_mode <- "mag"


### bioenergy settings
cfg$gms$bioenergy <- "1st2ndgen_biomass_dec24"



### scenario definition
mitiScen      <- c("NPi2025", "PkBudg650")
bcScen    <- c(bcZero = "none", 
               bcDef = "R34BC-SSP2-PkBudg650-BCdef", 
               bcDef_CTS01 = "R34BC-SSP2-PkBudg650-BCdef-CTS01", 
               bcDef_CTS01_BM70 = "R34BC-SSP2-PkBudg650-BCdef-CTS01-BM70", 
               bcPess_CTS01_BM70 = "R34BC-SSP2-PkBudg650-BCpess-CTS01-BM70")


for(miti in mitiScen){
  for (bc in names(bcScen)){

   if(miti == "NPi2025") {

     # NPI - BAU
     cfg <- setScenario(cfg, c("SSP2", "NPI"))
     cfg$gms$c56_mute_ghgprices_until <- "y2150"
     cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-NPi2025"
     cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-NPi2025"

   } else if (miti == "PkBudg650") {

     # Climate mitigation
     cfg <- setScenario(cfg, c("SSP2", "NDC"))
     cfg$gms$c56_mute_ghgprices_until <- "y2030"
     cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
     cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg650"

   } else {stop("wrong mitiScen setup")}

   cfg$title <- .title(cfg, paste(bc, miti, sep = "_"))
   cfg$gms$c63_biochar_prod    <- bcScen[bc]
   start_run(cfg, codeCheck = FALSE)

  }
}

