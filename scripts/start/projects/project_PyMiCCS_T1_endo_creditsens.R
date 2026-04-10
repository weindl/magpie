# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: PyMiCCS Project runs (Tier 1)
# position: 6
# ----------------------------------------------------------


# Biochar assessment Tier 1 (core matrix) ####################################
# Core design: SSP1-SSP3 X {NPi2025, PkBudg1000, PkBudg650} X {BCoff, BCon}
# Coupled pathway inputs taken from R34M410 scenario set


# General set-up =============================================================

library(lucode2)
library(gms)

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
# cfg$results_folder <- "output/:title::date:"
cfg$force_replace <- TRUE

cfg$info$flag <- "PT1endo_rewC_APP_credit"
cfg$qos <- "standby"

.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))


# MAgPIE model switches for all scenario runs ================================

### bioenergy settings
cfg$gms$bioenergy <- "1st2ndgen_biomass_dec24"
# decide very carefully about the value for s60_res_substitution_factor depending on
# the model configuration, scenario and research question
cfg$gms$s60_res_substitution_factor <- 0


### biochar settings
cfg$gms$biochar <- "dec24"
cfg$gms$c63_biochar_simulation_mode <- "mag"

cfg$gms$s63_BC100 <- 0.8
cfg$gms$s63_bc_max_app_rate_crop <- 5
cfg$gms$s63_bc_max_stock_crop <- 50

cfg$gms$s63_bc_yield_response_max <- 0.10
cfg$gms$s63_bc_yield_response_k <- 10

cfg$gms$c63_BCcost_scen <- "central"
cfg$gms$s63_bc_cost_transport <- 80
cfg$gms$s63_bc_cost_application <- 10

cfg$gms$c63_biochar_prod <- "none"
cfg$gms$c63_biochar_prod_noselect <- "none"

### ghg policy / biochar reward credit factor
cfg$gms$s56_bc_luc_credit_steepness <- 0.1


### other settings
cfg <- setScenario(cfg, "nocc_hist")

cfg0 <- cfg


# Scenario runs ==============================================================

ssps <- c("SSP2")
# ssps <- c("SSP1", "SSP2", "SSP3", "SSP5")  # SSP5 is also available but not maintained anymore

mitiScen <- c("NPi2025", "PkBudg650")
# mitiScen <- c("NPi2025", "PkBudg1000", "PkBudg650")

bcScen <- c("BCon")
#bcScen <- c("BCon", "BCoff")

# Sensitivity parameters ------------------------------------------------------
bc_app_rate <- c(1, 2.5, 5)
bc_credit_steepness <- c(0.1, 0.5, 1, 2,5,10)

format_num <- function(x) {
  gsub("\\.", "p", as.character(x))
}

for (ssp in ssps) {
  for (miti in mitiScen) {
    for (bc in bcScen) {
      for (app in bc_app_rate) {
        for (credit in bc_credit_steepness) {

          # start each scenario from the base configuration
          cfg <- cfg0

          # Not feasible: SSP3-PkBudg650
          if (ssp == "SSP3" && miti == "PkBudg650") next

          # ----------------------------
          # Mitigation scenario settings
          # ----------------------------
          if (miti == "NPi2025") {

            # NPI - BAU
            cfg <- setScenario(cfg, c(ssp, "NPI"))
            cfg$gms$c56_mute_ghgprices_until <- "y2150"
            cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
            cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-", ssp, "-NPi2025")

          } else if (miti == "PkBudg1000") {

            # Climate mitigation
            cfg <- setScenario(cfg, c(ssp, "NDC"))
            cfg$gms$c56_mute_ghgprices_until <- "y2030"
            cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg1000")
            cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-", ssp, "-PkBudg1000")

          } else if (miti == "PkBudg650") {

            # Climate mitigation
            cfg <- setScenario(cfg, c(ssp, "NDC"))
            cfg$gms$c56_mute_ghgprices_until <- "y2030"
            cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg650")
            cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-", ssp, "-PkBudg650")

          } else {
            stop("wrong mitiScen setup")
          }

          # ---------------------------
          # Biochar scenario definition
          # ---------------------------
          if (bc == "BCoff") {

            cfg$gms$c63_biochar_prod_mode <- "exo"

          } else if (bc == "BCon") {

            cfg$gms$c63_biochar_prod_mode <- "endo"

          } else {
            stop("wrong bcScen setup")
          }

          # --------------------------------
          # Sensitivity parameter assignment
          # --------------------------------
          cfg$gms$s63_bc_max_app_rate_crop <- app
          cfg$gms$s56_bc_luc_credit_steepness <- credit

          # optional: keep naming short and file-system friendly
          app_lab <- paste0("app", format_num(app))
          credit_lab <- paste0("cred", format_num(credit))

          cfg$title <- .title(cfg, paste(ssp, miti, bc, app_lab, credit_lab, sep = "_"))

          start_run(cfg, codeCheck = FALSE)
        }
      }
    }
  }
}