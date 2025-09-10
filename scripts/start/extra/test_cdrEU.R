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

version <- "EUCDR-05"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")
backupInputH12 <- cfg$input

EU_countries <- c("ALA", "AUT", "BEL", "BGR", "CYP", "CZE", "DEU", "DNK", "ESP", 
                  "EST", "FIN", "FRA", "FRO", "GBR", "GGY", "GIB", "GRC", "HRV", 
                  "HUN", "IMN", "IRL", "ITA", "JEY", "LTU", "LUX", "LVA", "MLT", 
                  "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "SWE")

cdrRegions <- list(glo = all_iso_countries, eu = EU_countries)     

### agroforestry settings
cfg$gms$s29_treecover_scenario_start <- 2025   # def = 2025
cfg$gms$s29_treecover_scenario_target <- 2050   # def = 2050
cfg$gms$s29_fader_functional_form <- 1   # linear
cfg$gms$s29_treecover_keep <- 1          # keep them
cfg$gms$s29_treecover_plantation <- 1    # plantations

### soil carbon management
cfg$gms$s59_scm_scenario_start  <- 2025   # def = 2025
cfg$gms$s59_scm_scenario_target <- 2050   # def = 2050            

### biochar settings
cfg$gms$c63_biochar_simulation_mode <- "mag"

targetLow  <- 0.05
targetHigh <- 0.3

miti      <- c("npi", "rcp2p6")
agfScen   <- c(agfLow = targetLow, agfHigh = targetHigh)
scmScen   <- c(scmLow = targetLow, scmHigh = targetHigh)
bcScen    <- c(bcLow = "none",     bcHigh = "R34BC-SSP2-PkBudg650-BCdef-CTS01-BM70")
regionSet <- c("h12", "h16EU")
cdrSet    <- c("eu", "glo")

.title <- function(version = NULL, miti = NULL, agf = NULL, scm = NULL, bc = NULL, regions = NULL, cdr = NULL){
  return(paste(version, miti, agf, scm, bc, regions, cdr, sep = "_"))
}

for(scen in miti){
  for (regions in regionSet){
    for (cdrReg in c("eu", "glo")){     
      
      if(scen == "npi") {

        # NDC - BAU
        cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp4p5"))

      } else if (scen == "rcp2p6") {

        # 2° - MAU
        cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
        cfg$gms$c56_mute_ghgprices_until <- "y2030"
        cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-PkBudg1000")
        cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-PkBudg1000")

      } else {stop("wrong miti setup")}
 
      if(regions == "h12") {
        
        cfg$input <- backupInputH12
        
      } else if (regions == "h16EU") {
        
        cfg$input['regional']    <- "rev4.121_36f73207_magpie.tgz"
        cfg$input['validation']  <- "rev4.121_36f73207_validation.tgz" 
        cfg$input['calibration'] <- "calibration_H16_FAO_20Jun25.tgz"
 
        if(scen == "rcp2p6") {
          cfg$input['cellular']    <- "rev4.121_36f73207_b62ca1de_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz" 
        } else if (scen == "npi") {
          cfg$input['cellular']    <- "rev4.121_36f73207_582d657c_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
        } else {stop("wrong scen setup")}

      } else {stop("wrong regions setup")}
      
      for(agf in names(agfScen)) {
        for(scm in names(scmScen)) {
          for(bc in names(bcScen)) {      
    
            cfg$gms$policy_countries29   <- cdrRegions[[cdrReg]]
            cfg$gms$s29_treecover_target <- agfScen[agf] / 10      # devided by 10 to go from agf to treecover target
          
            cfg$gms$policy_countries59  <- cdrRegions[[cdrReg]]
            cfg$gms$s59_scm_target      <- scmScen[scm]      # def = 0
          
            cfg$gms$scen_countries63    <- cdrRegions[[cdrReg]]
            cfg$gms$c63_biochar_prod    <- bcScen[bc] 
            
            cfg$title <- .title(version, scen, agf, scm, bc, regions, cdrReg)
            start_run(cfg, codeCheck = FALSE)
          }
        }
      }
    }
  }
}
