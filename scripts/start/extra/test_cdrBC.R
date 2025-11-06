# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: agri-CDR runs for EU and global
# --------------------------------------------------------

library(magpie4)
library(magclass)

version <- "BCtest-02"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")
backupInputH12 <- cfg$input

EU_countries <- c("ALA", "AUT", "BEL", "BGR", "CYP", "CZE", "DEU", "DNK", "ESP", 
                  "EST", "FIN", "FRA", "FRO", "GBR", "GGY", "GIB", "GRC", "HRV", 
                  "HUN", "IMN", "IRL", "ITA", "JEY", "LTU", "LUX", "LVA", "MLT", 
                  "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "SWE")

cdrRegions <- list(glo = all_iso_countries, eu = EU_countries)     

### biochar settings
cfg$gms$c63_biochar_simulation_mode <- "mag"
cfg$gms$c63_biochar_prod <- "stylized"
cfg$gms$s63_bcScen_stylized_startyear <- 2025
cfg$gms$s63_bcScen_stylized_targetyear <- 2050

miti      <- c("rcp2p6", "npi")
regionSet <- c("h12")
cdrSet    <- c("eu")

.title <- function(version = NULL, miti = NULL, bc = NULL, regions = NULL, cdr = NULL){
  return(paste(version, miti, gsub("\\.", "p", bc), regions, cdr, sep = "_"))
}

for(scen in miti){
  for (regions in regionSet){
    for (cdrReg in cdrSet){     
      
      if(scen == "npi") {

        # NDC - BAU
        cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))

      } else if (scen == "rcp2p6") {

        # 2° - MAU
        cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
        cfg$gms$c56_mute_ghgprices_until <- "y2030"
        cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-PkBudg1000")
        cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-PkBudg1000")

      } else {stop("wrong miti setup")}
 
      cfg$input <- backupInputH12
        
      .startRun <- function(bc) {
        cfg$gms$scen_countries63    <- cdrRegions[[cdrReg]]
        cfg$gms$s63_bcScen_stylized_target <- bc
        cfg$title <- .title(version, scen, bc, regions, cdrReg)
        start_run(cfg, codeCheck = FALSE)
      } 
  
      test <- c(0, 400, 500, 550, 600, 650, 700, 750, 800, 900)
      for(i in test) {.startRun(i)}
      
    }
  }
}
